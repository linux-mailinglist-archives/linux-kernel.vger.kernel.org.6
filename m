Return-Path: <linux-kernel+bounces-430850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B212C9E3679
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8128F1691C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D01A38E3;
	Wed,  4 Dec 2024 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuoFP7Bm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8AF17B50E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304262; cv=none; b=k0vNpWeu+DD6ji7X5VKSBrZnL5jTKVfmYw5fmpCiOoY78Dk9ncXNhnl0GHmBP2gt3zgN0xiWKsZPadn1r0yefrnKNEil4V5skd+MbxuUXAkrUpC5DYZ1uU557BaUKv3zgG5NjP6qq5el1hq0j7cEXCScvNvWcIf6gYbGyS++fM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304262; c=relaxed/simple;
	bh=NirhQcHh90i9gsZ0E//F2UnnEuWxbKKhuU2roeDJUoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOB9HxuSA1PU53sYaa9SZScMS0aDOzdgV/A95qJ/2e3dxG+a8E2PyMza1wF1i1xQsflJXKjNoybm432vBE2QhPyzeh/wijRKS2evpBQk1umLM1HkA2qr4Qm+ROZDzTCutNoTZlTv85t+zusqJ/gWRfQF3iV/E7u+SG4+5+irOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuoFP7Bm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733304258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rA3Q8pSqM1dSDp1IjUijqveaLItTi22vCFk780D7MI=;
	b=EuoFP7BmFw7dg1jT8/mUAbJ2CC6Mjmmxv/NNqS+m7qxjnmZgWhM6JIwkQchKfGyeRNsj6i
	3oz3x/Lfa6psOw0z+gh+xpfbyQ44G1kQ9VSEE85/e8BOXfEV4wmS+/k8PeJcRxh5zAxRyH
	Vo9K72dOgaDx9LG9931hBwGPsfPW074=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-DpxyC6SDPqSBGVTZ8yAeqQ-1; Wed, 04 Dec 2024 04:24:17 -0500
X-MC-Unique: DpxyC6SDPqSBGVTZ8yAeqQ-1
X-Mimecast-MFC-AGG-ID: DpxyC6SDPqSBGVTZ8yAeqQ
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53e1c921604so363560e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733304255; x=1733909055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rA3Q8pSqM1dSDp1IjUijqveaLItTi22vCFk780D7MI=;
        b=mGO3X/pKSmYdqSOzg8LoJdI6+/5h3Mp0js3/jHkqWb1rcweo3YnQOzdKASXXEAilE/
         5vyCrmnJKPKqGMoiYWmaIYToigVlfEZSMcvBr6iJtOcHjz+f0ySeNUmOLVeiIX0VnMsr
         Y1/q3EFH/iJ2XkVO+gfWoZmNN/x/FzV0JaPDsDpPeR7djpzWeM/RD6tocaZrpkYiAFg5
         5BQbSyTs9U0R0QQauIq/2tFRuyDEzIhhgFuESZJwmzdLPudbSxUkQPA1NQkAZyg3K0qn
         0JzdJtZQCF/oEVpW1DPJQ4rQn/uydt6rdzD1pyvE8ANnp7I6hgNAUiWsOUmyy0ENwQ9O
         TlsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV48t/DQHQ8lGz5onY56At6FqMqtjae1wq7Ddl9sbees9p5UBE38Jlrx1zFT6rO3a8/si1ycjAGUm0mpg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJ2qcWJ3le3rqIUQYWwFIXkrmcf8YhyAIDidwu4bdUOD1Iqq+
	AmwT7HLBzVtgBQF4MsVkxLEYP2+HKr2MvO3vDqLVHDG7+1DDgYbeeJLHSpvBPBOjYmgyPb7O8OO
	cCKKUoeQciVNY1suyQjHGEkF4ucqR/T9PZEFu3HWiuiH52dLjXYuYikfKPKVWHg==
X-Gm-Gg: ASbGnct0eFMI/w3tu/QsnU5KJfMguXEjHeE562SX2sYBzZvzd/TjPiD8XWwMkSw9i3U
	WAvpn7h4o3uQKrfvXuf4PdFTGg8qm+vNByjFLSQFAxcDWkH7ZXyfVeEvKqWcO2Eu3zwCBwHSATg
	OzCfTkUibKrCMEW7QRuEltuGIcsD3dlwYeZArXhYw4OEyaig5qLkWQK77twqBG87nQRysXDWZ+l
	KxQsVLBZNABxH1iOc2S0CKHbaXhNuYHwqOao2NbU9Lua07OQlgk6vijlrrsXQmRgNwoiu/mzpmz
	sWryXbCqfOCuTKbjxxtGgg==
X-Received: by 2002:a05:6512:10c5:b0:53e:1c3d:d1ae with SMTP id 2adb3069b0e04-53e1c3dd2c2mr1188999e87.29.1733304255436;
        Wed, 04 Dec 2024 01:24:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsbNZvNHIYi3juR1bGlOd7p4wtzrVDLahVmik9+1Qp9w7qDv8Yeu/UFp2p0lFOTQ8AFCDHtw==
X-Received: by 2002:a05:6512:10c5:b0:53e:1c3d:d1ae with SMTP id 2adb3069b0e04-53e1c3dd2c2mr1188975e87.29.1733304255025;
        Wed, 04 Dec 2024 01:24:15 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b312sm18181805e9.6.2024.12.04.01.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:24:14 -0800 (PST)
Date: Wed, 4 Dec 2024 10:24:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241204102413.31c8d76d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241204095635.512a44d5@foz.lan>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org>
	<20241203125143.7171892a@imammedo.users.ipa.redhat.com>
	<20241203144730.47b8ca86@foz.lan>
	<20241204085440.4640a476@imammedo.users.ipa.redhat.com>
	<20241204095635.512a44d5@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Dec 2024 09:56:35 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 4 Dec 2024 08:54:40 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Tue, 3 Dec 2024 14:47:30 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Em Tue, 3 Dec 2024 12:51:43 +0100
> > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > >     
> > > > On Fri, 22 Nov 2024 10:11:30 +0100
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > >       
> > > > > Currently, CPER address location is calculated as an offset of
> > > > > the hardware_errors table. It is also badly named, as the
> > > > > offset actually used is the address where the CPER data starts,
> > > > > and not the beginning of the error source.
> > > > > 
> > > > > Move the logic which calculates such offset to a separate
> > > > > function, in preparation for a patch that will be changing the
> > > > > logic to calculate it from the HEST table.
> > > > > 
> > > > > While here, properly name the variable which stores the cper
> > > > > address.
> > > > > 
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > ---
> > > > >  hw/acpi/ghes.c | 41 ++++++++++++++++++++++++++++++++---------
> > > > >  1 file changed, 32 insertions(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > > > index 87fd3feedd2a..d99697b20164 100644
> > > > > --- a/hw/acpi/ghes.c
> > > > > +++ b/hw/acpi/ghes.c
> > > > > @@ -364,10 +364,37 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > > > >      ags->present = true;
> > > > >  }
> > > > >  
> > > > > +static void get_hw_error_offsets(uint64_t ghes_addr,
> > > > > +                                 uint64_t *cper_addr,
> > > > > +                                 uint64_t *read_ack_register_addr)
> > > > > +{        
> > > > 
> > > >       
> > > > > +    if (!ghes_addr) {
> > > > > +        return;
> > > > > +    }        
> > > > 
> > > > why do we need this check?      
> > > 
> > > It is a safeguard measure to avoid crashes and OOM access. If fw_cfg 
> > > callback doesn't fill it properly, this will be zero.    
> > 
> > shouldn't happen, but yeah it firmware job to write back addr
> > which might happen for whatever reason (a bug for example).
> >  
> 
> The main reason I added it is that, after the second series, it could 
> also happen if there's something wrong with the backward compat logic.
> 
> So, both here and after switching to HEST-based offsets, I opted
> to explicitly test.
> 
> > Perhaps push this up to the stack, so we don't have to deal
> > with scattered checks in ghes code.
> > 
> > kvm_arch_on_sigbus_vcpu() looks like a goo candidate for check
> > and warn_once if that ever happens.
> > It already calls acpi_ghes_present() which resolves GED device
> > and then later we duplicate this job in ghes_record_cper_errors()
> > 
> > so maybe rename acpi_ghes_present to something like AcpiGhesState* acpi_ghes_get_state()
> > and call it instead. And then move ghes_addr check/warn_once there.
> > This way the rest of ghes code won't have to deal handling practically
> > impossible error conditions that cause reader to wonder why it might happen.  
> 
> I'll look on it. Yet, if ok for you, I would prefer dealing with this
> once we have a bigger picture, e.g. once we merge those tree series:
> 
> 	- cleanup series (this one);
> 	- HEST offset (I'll be sending a new version today);
ok, lets revisit this point after this series.
Since at this point we should have a clean picture of how new code
works.

> 	- error_inject.
> 
> Thanks,
> Mauro
> 



Return-Path: <linux-kernel+bounces-538559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E018CA49A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6BA18900BD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EAD26B2C7;
	Fri, 28 Feb 2025 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsE0TZGY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8302D1D88DB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748106; cv=none; b=knaaRsNFtSgDWF6mQLs1+PYZVb23QZ6hG0MYypQXew4fMhgArDQAVud0BijSGphaylHrskand5bq6c7hrrVBdUjOqlq+9Dqnr7UmQwU7iqyrwHNYmxe93SaPkK/wnbcf9FxlwCGPVOrtkvZBjkreUQCW61wjNyQfLOUrh44V+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748106; c=relaxed/simple;
	bh=/Gy2ZdSWyHE27aBHIMdrnJMk4Y3nBgqwXBNnhLPrgmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coAtkd4i+LMqZ9juPwnEcUuvUL0b8n+G0vYkW29Z0F4YsONeUnr2T0zDFUHALW5I/lPWA7PqshP5XVy2D5FtqkPRdWvo0cF3LzLLqDiSR3K3PGrJLlThEmJp3tGv1jbMvYnPv301ovJKhc0IHxE/59rvl9sIvL0D4zzCCZOGlRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsE0TZGY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740748103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jivrn7Vdp6x4GL1b5ZxyJQKIN05Kj60F1xupGwdydvs=;
	b=fsE0TZGYc1q7pu2qoyQBtbuKF2Hp8d7TEStZgIoTJ2qRJhtTqj7k+7Q5Auqbo33VooLekh
	cz4Csp5FtOa+8JZbKrdwCXqhiIOaHml5lzw9Y35kWdXNnAJvBVeXO9yvljRe/pwR+pEfqJ
	7252mgzZxULCyASOXEZ3Zjfd+7HxVLk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-Y8loqDcNPwu4BwPjkZmyWQ-1; Fri, 28 Feb 2025 08:08:22 -0500
X-MC-Unique: Y8loqDcNPwu4BwPjkZmyWQ-1
X-Mimecast-MFC-AGG-ID: Y8loqDcNPwu4BwPjkZmyWQ_1740748101
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c489babso12347935e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748101; x=1741352901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jivrn7Vdp6x4GL1b5ZxyJQKIN05Kj60F1xupGwdydvs=;
        b=lIGWB5Wm473trILQwclvSs9L68aAqk8UwZjWipdqL7d1Xz1W02FpdUGKlBNZ2mIWhN
         QMbL9nRwN48c3VgA3O3lCsHIo+CYYNbL2/6sq+ZqdhYnIFGSQvTgN4cFF3fLEHjPyVbj
         p/8uPl6lgA1Uei8/Lthv1nUhJzUnrcqmNEmcUBU/8TJ1Tu1h6i0/zx3erceEHbeeH0RR
         IBKGxy/Luu8LmSxryAkVRbtuCEsIHELhWNGoJwvMmLMzMeUzwtR6L8YgSvVRlNtc+9eQ
         c2Eexbd3P47Apj0wsVJNhMDcNkyji7STeNL2PoTqprpSU23MdEPOL36h6dd/VP248mdM
         CRWw==
X-Forwarded-Encrypted: i=1; AJvYcCXgONju0B/RhXThZdkILGoXK524m9P4piWi1MUqW1DleXGRf658dxsrdzRJH8L9vkrqHLBlMrjiMjJQcOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKGCM08P0SnOdoEOzYhGYQgituV+BD3j06W59Ti+Q28JpjVXTz
	sUl6t6an6osoKgDC4h2ViaC1ToRDA32vAuf41Yk7Nqnq+JwrPN6tQfc0qLZC5bMlHMnFpkRftOh
	oxc3ot4wZaJYX7K/cRlElv6BR7Juh8X3i0u83mVx8fLvBz820FCWc32fA3cq1zA==
X-Gm-Gg: ASbGncsvI6cJP5oofYIREXhi/so8HccOxFUKZjVxMTSsFc21zpw/jt0XsV0UMK7MiPU
	NfsprahS5TlaLog1e8jxIThx2bouAyFhABuauATKdz0p1xmrH47oXlVUXPXG1R2tvW3/qAjxWPu
	zQ5iEfqrDBZO8sP1di61KuFARRHnjdVE5raLHnE5kx2a+N0+iZAJtQs8cU3hpAetxQWh22S5HN3
	iWroEMCoTXFo0htuBxENbMjKxy6rjVkSZCZB4xQYEgFxzRmfJNSV9ekPQjTEPy6HI1DeV4AMJtg
	7YPuxJlkSh8uF+Ide2CFevVKC7YRIUmLG5oG1VhHvYa8TrYSYwrqvf2CatrVs44=
X-Received: by 2002:a05:600c:1c93:b0:439:a1ef:c238 with SMTP id 5b1f17b1804b1-43ba6704511mr27965415e9.13.1740748100812;
        Fri, 28 Feb 2025 05:08:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdeugB0DYaeSGn2VbFG9q+ru+bR1PmY2MFJJnKraycPUMTshNrf3BW7rb+d9fMMTMfeMuzcA==
X-Received: by 2002:a05:600c:1c93:b0:439:a1ef:c238 with SMTP id 5b1f17b1804b1-43ba6704511mr27964775e9.13.1740748100341;
        Fri, 28 Feb 2025 05:08:20 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7ddesm5239888f8f.57.2025.02.28.05.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:08:19 -0800 (PST)
Date: Fri, 28 Feb 2025 14:08:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 18/19] docs: hest: add new "etc/acpi_table_hest_addr"
 and update workflow
Message-ID: <20250228140819.322e6390@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250228173608.0000779c@huawei.com>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
	<445f7d41b01ffc5bd79d6fd83bc7c4c621bcbc85.1740671863.git.mchehab+huawei@kernel.org>
	<20250228173608.0000779c@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 17:36:08 +0800
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 27 Feb 2025 17:00:56 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > While the HEST layout didn't change, there are some internal
> > changes related to how offsets are calculated and how memory error
> > events are triggered.
> > 
> > Update specs to reflect such changes.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> One minor editorial suggestion. With that or similar tidy up,
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

with nit below fixed,

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> > ---
> >  docs/specs/acpi_hest_ghes.rst | 28 +++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> > 
> > diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> > index c3e9f8d9a702..4311a9536b21 100644
> > --- a/docs/specs/acpi_hest_ghes.rst
> > +++ b/docs/specs/acpi_hest_ghes.rst
> > @@ -89,12 +89,21 @@ Design Details
> >      addresses in the "error_block_address" fields with a pointer to the
> >      respective "Error Status Data Block" in the "etc/hardware_errors" blob.
> >  
> > -(8) QEMU defines a third and write-only fw_cfg blob which is called
> > -    "etc/hardware_errors_addr". Through that blob, the firmware can send back
> > -    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
> > -    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
> > -    for the firmware. The firmware will write back the start address of
> > -    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
> > +(8) QEMU defines a third and write-only fw_cfg blob to store the location
> > +    where the error block offsets, read ack registers and CPER records are
> > +    stored.
> > +
> > +    Up to QEMU 9.2, the location was at "etc/hardware_errors_addr", and
> > +    contains a GPA for the beginning of "etc/hardware_errors".
> > +
> > +    Newer versions place the location at "etc/acpi_table_hest_addr",
> > +    pointing to the GPA of the HEST table.
> > +
> > +    Through that such GPA values, the firmware can send back the guest-side  
> This confuses me.
>  Via those GPA values...? (maybe?)

it's not GPA here, it should be fwcfg.
Maybe something like this
 "Using above mentioned 'fwcfg' files,"

> 
> > +    allocation addresses to QEMU. They contain a 8-byte entry. QEMU generates
> > +    a single WRITE_POINTER command for the firmware. The firmware will write
> > +    back the start address of either "etc/hardware_errors" or HEST table at
> > +    the corresponding fw_cfg file.
> >  
> >  (9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
> >      "Error Status Data Block", guest memory, and then injects platform specific
> > @@ -105,8 +114,5 @@ Design Details
> >       kernel, on receiving notification, guest APEI driver could read the CPER error
> >       and take appropriate action.
> >  
> > -(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
> > -     find out "Error Status Data Block" entry corresponding to error source. So supported
> > -     source_id values should be assigned here and not be changed afterwards to make sure
> > -     that guest will write error into expected "Error Status Data Block" even if guest was
> > -     migrated to a newer QEMU.
> > +(11) kvm_arch_on_sigbus_vcpu() report RAS errors via a SEA notifications,
> > +     when a SIGBUS event is triggered.  
> 



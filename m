Return-Path: <linux-kernel+bounces-277969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98DA94A8CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E919284415
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F791EA0D2;
	Wed,  7 Aug 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chegYxU5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D71B8EAD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038238; cv=none; b=fZS4l2OuNWwBlrfjQWONfCb89F4G5mTdN+bQ+D4ed/QljxSD4F0tW73YSTJ9lzn8lYgUOfYiRqKwrT/lUj1G5yFwRGYI3YHp/2Ljwymv9ETAA7FRhrVCYjXgPR3t/PKfa/quwTCc2q6QpMWvJFl0DpcH1hDR5D4C3e1w3xaevqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038238; c=relaxed/simple;
	bh=hZWOghC9twLYStZL6Ext5Irw7Otnqc8jOQRKuMsRbNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7WcNgYwscnCNziG9uacvXvsK/vHNezjUIQymRe6LjSSGYsYxc4nZDXq6WAeALBFRg0/PdPltwNYo1CYQLCNwQNMrc2St62KxFZfdZQvRHDG7gI2fhTV1+1kVDOx4GohdyyxLgxD7xcKygxvqCuMEnHPxSkAS0j1BnZ31Vf6ldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chegYxU5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723038235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYwB9PhaxROTttP1ClR+qhim39o3hwwUvgAALYgcWMw=;
	b=chegYxU5K6WekukNk7koyw5X0zhJpDepjCDTMtJXgy6qNXHNf54DbmDNEvjB5llmAQXIxW
	dLKAu0YQE7uUieJ20+SVnVfGb8JUp/tRZ9o3wW6EJsTLWejNldldY+8HGOjqMd6xGKAesE
	QwFYTzAyN3SbO2jpQYnaeWmwiPgT6Ic=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-SvGbNN07P36Jo8fyXGNMGg-1; Wed, 07 Aug 2024 09:43:53 -0400
X-MC-Unique: SvGbNN07P36Jo8fyXGNMGg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-368448dfe12so460520f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038232; x=1723643032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYwB9PhaxROTttP1ClR+qhim39o3hwwUvgAALYgcWMw=;
        b=j5ffFU0M7+0TI8nj7sEFRRHtNcntxClCZfMru6UrRh5q83maqop43oE3msxxL9Wfbi
         MsmanlwHSX1LhJY3im9RbRR8Rl0fv6n8AdjA/Y6K5pkZ81r1SpNZFaO0qasSy2YzxpJ1
         QEIUXTQ97xID6gZsrZ3X7sRSE6oxanL6l43irf5dL294IuoQH2KuxixmGo8Ee7w0Ttb6
         3dWZFEXoYZAmEQXpCAv8Qrp35jpuOANKTiRk3cCtstaiq1gKPyalds49+4/6awPkeiSI
         DVGWYPk0omwTwHeWiBM3GYi46iqdsF9ZNNyb2Z8gobh0ijTZRpSPhNgy5zP5TE+2O7ih
         MDjg==
X-Forwarded-Encrypted: i=1; AJvYcCXACizgR6glO9MY9+Rm65+W9R/7ptVe1VTwT5jWYqoSGKR/YuKd0pxpnV7u79mhk3Lh6k9BOCnW2u2K/AYe538dubMK0YK5ykqvt0zJ
X-Gm-Message-State: AOJu0YyDHrqEbQ1DgObVtNdluPtJd+SJqIa5NEWJ3DnGsDhah06Yo66g
	XjufqxwY5bG0RuS7LTufyEHccJqDWNULTRIh4OZCjQ1MgUg/FRNno423hnqJxyxsl0DkAgwUOtv
	d8Gxlw2SIc9eK3DaXyDqDkUU4vMnkNjkVm4D4mqsur8K/ocKeazM/Nt/ZGTtqbA==
X-Received: by 2002:adf:feca:0:b0:363:ac4d:c44f with SMTP id ffacd0b85a97d-36bf0dd08famr1912028f8f.17.1723038231891;
        Wed, 07 Aug 2024 06:43:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr6Bm0/qVydUdq0qsX27MEtf7O7IbQ3mMZHGid02hUTzyOiqKIcbVCgMZl/ksBWWcM0AtYNQ==
X-Received: by 2002:adf:feca:0:b0:363:ac4d:c44f with SMTP id ffacd0b85a97d-36bf0dd08famr1911997f8f.17.1723038231299;
        Wed, 07 Aug 2024 06:43:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06e0f5sm16009224f8f.104.2024.08.07.06.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:43:50 -0700 (PDT)
Date: Wed, 7 Aug 2024 15:43:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240807154350.5907e4ed@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240807152357.0d2dc466@foz.lan>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
	<20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
	<20240807094750.6414fb2f@foz.lan>
	<20240807103436.000013fc@Huawei.com>
	<20240807152357.0d2dc466@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 15:23:57 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 7 Aug 2024 10:34:36 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:
> 
> > On Wed, 7 Aug 2024 09:47:50 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Em Tue, 6 Aug 2024 16:31:13 +0200
> > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > >     
> > > > PS:
> > > > looking at the code, ACPI_GHES_MAX_RAW_DATA_LENGTH is 1K
> > > > and it is the total size of a error block for a error source.
> > > > 
> > > > However acpi_hest_ghes.rst (3) says it should be 4K,
> > > > am I mistaken?      
> > > 
> > > Maybe Jonathan knows better, but I guess the 1K was just some
> > > arbitrary limit to prevent a too big CPER. The 4K limit described
> > > at acpi_hest_ghes.rst could be just some limit to cope with
> > > the current bios implementation, but I didn't check myself how
> > > this is implemented there. 
> > > 
> > > I was unable to find any limit at the specs. Yet, if you look at:
> > > 
> > > https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section    
> > 
> > I think both limits are just made up.  You can in theory log huge
> > error records.  Just not one does.  
> 
> If both are made up, I would sync them, either patching the
> documentation or the ghes driver.
> 
> >   
> > > 
> > > The processor Error Information Structure, starting at offset
> > > 40, can go up to 255*32, meaning an offset of 8200, which is
> > > bigger than 4K.
> > > 
> > > Going further, processor context can have up to 65535 (spec
> > > actually says 65536, but that sounds a typo, as the size is
> > > stored on an uint16_t), containing multiple register values
> > > there (the spec calls its length as "P").
> > > 
> > > So, the CPER record could, in theory, have:
> > > 	8200 + (65535 * P) + sizeof(vendor-specicific-info)
> > > 
> > > The CPER length is stored in Section Length record, which is
> > > uint32_t.
> > > 
> > > So, I'd say that the GHES record can theoretically be a lot
> > > bigger than 4K.	    
> > Agreed - but I don't think we care for testing as long as it's
> > big enough for plausible records.   Unless you really want
> > to fuzz the limits?  
> 
> Fuzz the limits could be interesting, but it is not on my
> current plans.
> 
> Yet, 1K could be a little bit short for ARM CPER.
> 
> See: N.26 ARMv8 AArch64 GPRs (Type 4) has 256 bytes for
> registers, plus 8 bytes for the header. So, a total size of
> 264 bytes, for a single context register dump. I would expect
> that, in real life, type 4 to always be reported on aarch64,
> on BIOS with context register support. Maybe other types could
> also be dumped altogether (like context registers for EL1, 
> EL2 and/or EL3).
> 
> If just one type 4 context is encoded, it means that, 1K has 
> space for 23 errors (of a max limit of 255).
> 
> Just looking at the maximum number, my feeling is that 1K
> might be too short to simulate some real life reports,
> but that depends on how firmware is actually grouping
> such events.

per my knowledge firmware is out of picture here, since all
it does in HEST case is allocate continuous space for
'etc/hardware_errors' blob as QEMU told it.

> 
> So, maybe this could be expanded to, let's say, 4K, thus
> aligning with the ReST documentation.
maybe to get moving, 1st get your series in with docs fixed
to today limit.
And then increase error_block size to desired value on top of that
as it's really not relevant to what you are doing here.

> Regards,
> Mauro
> 



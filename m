Return-Path: <linux-kernel+bounces-430733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6EB9E34EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED890B3522C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D3A1922DD;
	Wed,  4 Dec 2024 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5jQ3eBq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1018C907
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298888; cv=none; b=iBMf//avjD5d+t0qBQvxZ6MEGyV6E8WRSxeLYBWe/xRYhdxl+KpbWsXdyufEx/mtwHW5WnrrBjBeSpXb0rphl58oExXcFOEBPb1ApO8yowueJR6Fgi4VfN+ep3NuEWqI5JmfAZk8ClM34Do8LmENqGnVswBBNqMmtVjaXxX9xqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298888; c=relaxed/simple;
	bh=1V+l6SdVwLkoHa9GMiUi6/ecxejmRHXTgwCh78uO6SY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5N58+67xu5d+fVMCg33VBsWDYPb7QSmZT6VQDFanFUcyZLS/Ppe9n3HanPrRrTZ9aN2ssqLwCgloW9UP35LTJg57Zl7caxrR0KmOHdMELcIfMLPfblMQQaR1ljAZF48m/rOryWwg9svZ7F2/jxmNp2PGu22pCGxFyFopFc2S3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5jQ3eBq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bapXZ7d3j5PvmLQR20ulpt7ZnCE088LkGy4W5u5RvDM=;
	b=P5jQ3eBq7W12tqLlelz4XIcipQwiJqxiUmCcLX43OIMSqMssae+sUalLuW5T3Xo+3iSSbp
	jQZL5yRTPpt8r7XDZnNJJArSD0YWYNn3fjtGWff4aVBHs8sxtbcMFGkH7KnrkPVb3uzJ+t
	zq0HT9WQtDvELJgtSrs/DK8PgUIQTjY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-A4L9ndu9N1OCv_EicDIfVg-1; Wed, 04 Dec 2024 02:54:44 -0500
X-MC-Unique: A4L9ndu9N1OCv_EicDIfVg-1
X-Mimecast-MFC-AGG-ID: A4L9ndu9N1OCv_EicDIfVg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434c214c05aso26957465e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 23:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733298883; x=1733903683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bapXZ7d3j5PvmLQR20ulpt7ZnCE088LkGy4W5u5RvDM=;
        b=nukTK3OWDB3iAEuWnAYkAZmh+3ZEpB1siUVX47ymV9wONHrbmpdZEgjCxmnBEpC9h1
         +PWAI1Lq+oehESwugkErGuuxHyYqP0vyYpiTZ2zrphobz0jviIQ6i9btMuuZqTFF2/n4
         N52JMajSewirEG56ptLo1DWWkTtEDHi1pINMDW8cYnxQhMUmdB7/Gn/qSog+8DWRfDJY
         MyYLphYWHtgmQFzrHX0CPbZO/w3vsca34gpC8CZwOb6z0ObQ5DlKPu/21+71ogrbvq+k
         6CWeQnUUtnB7yKjHJ3fS6fR7TqJjoCq8peehLX9AlByzmpkxtLglFi1d1Appv2Y9Nax3
         42vw==
X-Forwarded-Encrypted: i=1; AJvYcCV8KsZFGR27TVQp+FsfclzKUdLRn3aNCcnonWJwOniPkzZqao6/OEPTlTatCHtvBZP2uNXrNaLiSyWov50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGn60SpGfb2iNadx+++YblJuR3X64Psuoy0quBMY3Hgns8dKO
	K/3us3Xgxi2EZ3FhSU93j0GiE12xakdMf4YvfjhXqa3msLlLLHYvaBFnAZQX8ozOuGCvrTwVTTn
	gD7Ai4QMXtVm+exSi9I/dn6K5Od7GmCPW5uFXK18Ctldy7WhbmJvHJt/0Ib1Ljg==
X-Gm-Gg: ASbGncuYkHk0w2yRX4tFWa3WH6Y+kKKw7dGPMUvKt7JCF063k61sg5eqZtRbzMYuJHM
	2kwIIaKufC69TgTH2kefCxDV8hwc6rSYVux8IdAufPJXu7hHUYf3t22LHGB7EUgRmUCgX2X8fGP
	p17DpzfjdkXHqVGgjAnzfllv3M0F+jaj/xjJdkT6AroklhXZOSm2RyNL8AG/fW2BlrPtcAj0uCF
	xwm3M0YXECBRkqPuaSOm4Pwcw/0USSq+UfXoaqvUK5R24eZEpLNUv16IK4ZOQDdXaAiY3p3tX+E
	VyVM19DBvDMAxidBNxncKQ==
X-Received: by 2002:a05:6000:1aca:b0:382:319f:3abd with SMTP id ffacd0b85a97d-385fd53ef48mr3821753f8f.36.1733298882623;
        Tue, 03 Dec 2024 23:54:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExlC9aez6wOgXUHe7v4Tl9z03wmj1DfrNWHgzsP8H2nhXL372UgwE29wd7/FfES9t5ebV8Zg==
X-Received: by 2002:a05:6000:1aca:b0:382:319f:3abd with SMTP id ffacd0b85a97d-385fd53ef48mr3821741f8f.36.1733298882222;
        Tue, 03 Dec 2024 23:54:42 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385f0056637sm8769421f8f.15.2024.12.03.23.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:54:41 -0800 (PST)
Date: Wed, 4 Dec 2024 08:54:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241204085440.4640a476@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241203144730.47b8ca86@foz.lan>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org>
	<20241203125143.7171892a@imammedo.users.ipa.redhat.com>
	<20241203144730.47b8ca86@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 14:47:30 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 3 Dec 2024 12:51:43 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Fri, 22 Nov 2024 10:11:30 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Currently, CPER address location is calculated as an offset of
> > > the hardware_errors table. It is also badly named, as the
> > > offset actually used is the address where the CPER data starts,
> > > and not the beginning of the error source.
> > > 
> > > Move the logic which calculates such offset to a separate
> > > function, in preparation for a patch that will be changing the
> > > logic to calculate it from the HEST table.
> > > 
> > > While here, properly name the variable which stores the cper
> > > address.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  hw/acpi/ghes.c | 41 ++++++++++++++++++++++++++++++++---------
> > >  1 file changed, 32 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index 87fd3feedd2a..d99697b20164 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -364,10 +364,37 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > >      ags->present = true;
> > >  }
> > >  
> > > +static void get_hw_error_offsets(uint64_t ghes_addr,
> > > +                                 uint64_t *cper_addr,
> > > +                                 uint64_t *read_ack_register_addr)
> > > +{    
> > 
> >   
> > > +    if (!ghes_addr) {
> > > +        return;
> > > +    }    
> > 
> > why do we need this check?  
> 
> It is a safeguard measure to avoid crashes and OOM access. If fw_cfg 
> callback doesn't fill it properly, this will be zero.

shouldn't happen, but yeah it firmware job to write back addr
which might happen for whatever reason (a bug for example).

Perhaps push this up to the stack, so we don't have to deal
with scattered checks in ghes code.

kvm_arch_on_sigbus_vcpu() looks like a goo candidate for check
and warn_once if that ever happens.
It already calls acpi_ghes_present() which resolves GED device
and then later we duplicate this job in ghes_record_cper_errors()

so maybe rename acpi_ghes_present to something like AcpiGhesState* acpi_ghes_get_state()
and call it instead. And then move ghes_addr check/warn_once there.
This way the rest of ghes code won't have to deal handling practically
impossible error conditions that cause reader to wonder why it might happen.

> > > +
> > > +    /*
> > > +     * non-HEST version supports only one source, so no need to change
> > > +     * the start offset based on the source ID. Also, we can't validate
> > > +     * the source ID, as it is stored inside the HEST table.
> > > +     */
> > > +
> > > +    cpu_physical_memory_read(ghes_addr, cper_addr,
> > > +                             sizeof(*cper_addr));
> > > +
> > > +    *cper_addr = le64_to_cpu(*cper_addr);    
> >         1st bits flip, and then see later
> >   
> > > +
> > > +    /*
> > > +     * As the current version supports only one source, the ack offset is
> > > +     * just sizeof(uint64_t).
> > > +     */
> > > +    *read_ack_register_addr = ghes_addr +
> > > +			      ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> > > +}
> > > +
> > >  void ghes_record_cper_errors(const void *cper, size_t len,
> > >                               uint16_t source_id, Error **errp)
> > >  {
> > > -    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> > > +    uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;    
> > 
> > if get_hw_error_offsets() isn't supposed to fail, then we do not need to initialize
> > above. So this hunk doesn't belong to this patch.  
> 
> It may fail due to:
> 
>     if (!ghes_addr) {
>         return;
>     }
> 
> >   
> > >      uint64_t start_addr;
> > >      AcpiGedState *acpi_ged_state;
> > >      AcpiGhesState *ags;
> > > @@ -389,18 +416,14 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> > >  
> > >      start_addr += source_id * sizeof(uint64_t);
> > >  
> > > -    cpu_physical_memory_read(start_addr, &error_block_addr,
> > > -                             sizeof(error_block_addr));
> > > +    get_hw_error_offsets(start_addr, &cper_addr, &read_ack_register_addr);
> > >  
> > > -    error_block_addr = le64_to_cpu(error_block_addr);
> > > -    if (!error_block_addr) {
> > > +    cper_addr = le64_to_cpu(cper_addr);    
> >                    ^^^^ 2nd bits flip turning it back to guest byte order again
> > 
> > suggest to keep only one of them in get_hw_error_offsets()  
> 
> Ok, I'll drop this one.
> 
> > > +    if (!cper_addr) {
> > >          error_setg(errp, "can not find Generic Error Status Block");
> > >          return;
> > >      }
> > >  
> > > -    read_ack_register_addr = start_addr +
> > > -                             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> > > -
> > >      cpu_physical_memory_read(read_ack_register_addr,
> > >                               &read_ack_register, sizeof(read_ack_register));
> > >  
> > > @@ -421,7 +444,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> > >          &read_ack_register, sizeof(uint64_t));
> > >  
> > >      /* Write the generic error data entry into guest memory */
> > > -    cpu_physical_memory_write(error_block_addr, cper, len);
> > > +    cpu_physical_memory_write(cper_addr, cper, len);
> > >  
> > >      return;
> > >  }    
> >   
> 
> Thanks,
> Mauro
> 



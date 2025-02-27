Return-Path: <linux-kernel+bounces-536276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E21A47D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C732B1764EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ECD22ACDB;
	Thu, 27 Feb 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hk++juhs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34801991CD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658976; cv=none; b=IR/CV/11qshdMoUCndBEzyPSfGdHHboBDU12WLENmgYAqIW0sYNofCQDU0x8LunKMuAKAXm3LR1lXDIUOMfvWjPqqVwDyjHCWGzZaxH+Y+PIZQz6Zhq/TyFLj1x2I4LURh8BkqyZXoia3PCbnQKQiVFlQqKIoMBskREALSSQIxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658976; c=relaxed/simple;
	bh=7852AgmMHCotqhZLkFof7CbN3o3KUw4KeAsNJmJycY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDxqzxth01R36eazuCoDk94oHe9k6F+MnLMQtGFMwugShlECP/l8CEro/iXhXFtoWZpal/i6eJlsgEhqtxguiVcsOHa0f8L5Tf/SWDsteMdHR0bGCiFfRECLwyoat+4AunbVaifH1SteyCaoTEuhLkopPp8kvqybMRV+WOBtgWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hk++juhs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740658973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0drJSCTbWN/ba75bqW+aniDK5NCt33vV1jPzY6YlkA=;
	b=hk++juhsh/jlFscuZb2g7ibx0wuDNw0x8WS39Fi+gXAiASkLgBieuyl0muBKEg5H+NLg5u
	O7Fo0qQHkWaCWEWJ0y63yrqpQjuEVlVNwQWVDF2d5I4iIVyQFqp2FzLxUz8HWJ2honHGFL
	GdspqDNeC5LcuOUPdXTqf71/LLM959Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-b4WynaxvOUuJT-_rGWpYeA-1; Thu, 27 Feb 2025 07:22:52 -0500
X-MC-Unique: b4WynaxvOUuJT-_rGWpYeA-1
X-Mimecast-MFC-AGG-ID: b4WynaxvOUuJT-_rGWpYeA_1740658971
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399c32efb4so8506495e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658971; x=1741263771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0drJSCTbWN/ba75bqW+aniDK5NCt33vV1jPzY6YlkA=;
        b=WzxXLTsvmMjo7GQDuUEu2RKbAOsHVxrmTlAwuzLnGj98cMIlcE0YoUs9o0QEkk5PSk
         /oX38y2a2I0w1+0qEPvtmNhv4OBk99F2gzX9MUMkD6EbIDR87OsMq0aZw3GCRGndAKId
         QicNxKAMtOkuSf8HvOrzpMjndPZ6mYm77uzbGWaf8qMeST6PJzY7v+HuoGgtvkU2ZI46
         HGyvbgCMI+AgwZscK3gT855jtKpkqkqKDNE9y+/63OV+oWlWh4xsLaace+bsVZoXQZ9p
         lBa+fCam3D8sUVrK7xXvwWhqdaDfp+ii1FM4XccnuIELxPCtGB+8olK3vEHWvvEngtUP
         FaXw==
X-Forwarded-Encrypted: i=1; AJvYcCVKh5crzdFKTmALkbs8Ztgc347wGmxb3IWx8dpRFJoPMb4sn9CWSY96O/yoihNwyiUa4YgyWbSYOhy/3j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlMn/J8pnECBDq9aju+SW+YmyGiShSIuxkwF2VWdt9S84RPaaI
	tSes4KUoURs+/YBjL/sJPL++KvQGh1K1adn3/at21/7T/MtqTUw4g2nGtRQrZw4wNnFrIm76CbH
	4oLIXpBl9TNn6+dvGGVutO0yn7ztG0vwNbf8+Sv5j8V+zxxfCmGCq/3ldq7NNAg==
X-Gm-Gg: ASbGncsJy89bJ07lA5Av7hVHdGJUJ5XAqEQD0uom/fKksnRc/qY2dEO/ezfSYkuxBAD
	odjJotOKt69Fm9UHGylIhN1So5MM4YNM+9zyfCO64vBQ5FRodX8KMPMj6sbQY0gXu8nGywx+v5T
	CiPyqnIWHzPcbbqBpBJwRvzttirmxzEB00zsQ4CNIiN79uGmbgGAuEPY4lNqG+OAqCox0A0Fxu4
	vEVOpLmsooqBKXqi3ziyug1Xt7mI9s1TM6iOkLWdINaJkkY7pqivByG1rfJv9hTE9lkBv6M8XyN
	8jrA0feXrVdaY0eeNKHK/rYPhmNvw0YszbmVwoxUBC5I1Fuuj6LIMYb1xtx6Ol4=
X-Received: by 2002:a05:600c:1c23:b0:439:892c:dfd0 with SMTP id 5b1f17b1804b1-43b04dc361amr26051755e9.14.1740658970836;
        Thu, 27 Feb 2025 04:22:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQ83M4/KsXSQHu6pDlNDVcuk6Z5Ml2/r9st1BbY0/wCxIRxtiVX5idFzmIaNDSfkyk0vvAlA==
X-Received: by 2002:a05:600c:1c23:b0:439:892c:dfd0 with SMTP id 5b1f17b1804b1-43b04dc361amr26051585e9.14.1740658970475;
        Thu, 27 Feb 2025 04:22:50 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f839asm21290255e9.2.2025.02.27.04.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:22:49 -0800 (PST)
Date: Thu, 27 Feb 2025 13:22:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/14] acpi/ghes: prepare to change the way HEST
 offsets are calculated
Message-ID: <20250227132248.17c6754b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250227124538.7a2191e0@foz.lan>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<9eeaabf88e7ddc4884633702b7bc419075975bc8.1740148260.git.mchehab+huawei@kernel.org>
	<20250226153714.20c57efe@imammedo.users.ipa.redhat.com>
	<20250227124538.7a2191e0@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 12:45:38 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 26 Feb 2025 15:37:14 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Fri, 21 Feb 2025 15:35:10 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> 
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index 3ac8f8e17861..8ab8d11b6536 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -946,9 +946,18 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> > >      build_dbg2(tables_blob, tables->linker, vms);
> > >  
> > >      if (vms->ras) {
> > > -        acpi_add_table(table_offsets, tables_blob);
> > > -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> > > -                        vms->oem_id, vms->oem_table_id);
> > > +        AcpiGedState *acpi_ged_state;
> > > +        AcpiGhesState *ags;
> > > +
> > > +        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,    
> >                             ^^^ will explode if object_resolve_path_type() returns NULL  
> > > +                                                       NULL));    
> > 
> > it's also expensive load-wise.
> > You have access to vms with ged pointer here, use that
> > (search for 'acpi_ged_state = ACPI_GED' example)  
> 
> Ok, but the state binding on ghes were designed to use ACPI_GED. I moved
> the code that it is using ACPI_GED() to the beginning of v5 series,
> just after the HEST table test addition.
> 
> With that, ACPI_GED() is now used only on two places inside ghes:
> 
> - at virt_acpi_build(), during VM initialization;

ACPI_GED() is not expensive, what I'm referring to is
  object_resolve_path_type()

given it's a new code and virt_acpi_build() has direct access
to ged pointer, there is no excuse to use object_resolve_path_type().

all you have to do here is:

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e6328af5d2..040d875d4e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -949,8 +949,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         AcpiGedState *acpi_ged_state;
         AcpiGhesState *ags;
 
-        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
-                                                       NULL));
+        acpi_ged_state = ACPI_GED(vms->acpi_dev);
         ags = &acpi_ged_state->ghes_state;
         if (ags) {
             acpi_add_table(table_offsets, tables_blob);


> - at acpi_ghes_get_state().

this one is different, it doesn't have access to ged so it
has to look up for it.

> 
> If you want to replace it by some other solution, IMO we should do
> it on some separate series, as this is not related to neither error
> injection nor with offset calculation to get read ack address. 
> 
> > > +        if (acpi_ged_state) {    
> > 
> >                 hence, this check is not really needed,
> >                 we have to have GED at this point or abort
> > 
> >                 earlier code that instantiates GED should take care of
> >                 cleanly exiting if it failed to create GED so we would never get
> >                 to missing GED here  
> 
> I dropped this check on v5.
> 
> Thanks,
> Mauro
> 



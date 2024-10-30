Return-Path: <linux-kernel+bounces-389492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921389B6DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47914282CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B081D958F;
	Wed, 30 Oct 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOHEZoiT"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9CC1BD9EF;
	Wed, 30 Oct 2024 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320432; cv=none; b=I7HckNyqLXFsjhkxrT9W+Peh+o9iO2el+oB8yVxU1yExfifiRc1sfMNGgfuWGUSDu9jKqS8tnwGDZQ3ChqPYzM3C5+H/bpzCPiFSW1+2qH3PGKDff8/cX/cUG1KidGBZJb1x1ulejzN6nsmYxt7kR7gw16p6rwktvfeM3JMd7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320432; c=relaxed/simple;
	bh=Z+iil6GQLbvqX00aPArukj2KBQPSS8z1Rwalkm6Rwmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxqJSIDr2j5eTkfjHBQzWrFkvvTEZ21DZyEd3NxyYjU583755Lxv8tycKWByLKagyGpEmzjsN27JTOAyClL4kXRDAV4UTg4GMNW4NSXXfLccxLGqIiOwzSTxwsrxvuuns12xe+gEerraMGC5AHDDecLZ5XPtYPxCh5YTrWnM4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOHEZoiT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cbcd71012so3056435ad.3;
        Wed, 30 Oct 2024 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320430; x=1730925230; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qb3qMdYA0/SEfdeZoaEXoDe8oViNJ3e5nLqVZx/qRGc=;
        b=fOHEZoiT78qVX4ZWAm36dRXnRdIjF5L04sBsAMKuWWKiGwupHH6Y1ZeyCiJtDcDBsX
         Gk2bPlT+p1pqnsrNinHTUcy5si/MZJ/SZHdOFeXcKp7aAtMBpteZKLw0zyfMDHPWRwke
         mZNy1SbEg6+Jr3vNBaLMGcZ4oG7Namph6NNS7aErqND8PaE2PPO0/El8FjSSlXmVVLS2
         vC3I+8+Ua496RtAk6bkcIo2c9Kdfa89wU53oWcg3ctzh4pyprek++0a3zt2kzJwEqC/d
         LGgIRCxBKsNSOroKI3U6JF3TYIRP7A1hzypxdd7mS8zeW/D4Iwe7JPxGNdNO+5ViAP//
         YQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320430; x=1730925230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb3qMdYA0/SEfdeZoaEXoDe8oViNJ3e5nLqVZx/qRGc=;
        b=u00/nl4wfwQNkNBeO06TOi0cR6YMp53UCrtKdrRCaSRBwgJoKwliueHE31ZhpDvIu2
         QphiMf61srS/FWtDjNBmKM+F5OcQiHjVYZxzvoQ9GYsiROBnxvZf6fYsV1POy3pGbQqp
         FV8aeBqfjqeGgLuZ4E1Er6a5P3/tj3Zh5p72QlZ5Sb8WNP/LdesHbgoeXmRaKiBRNIGA
         YYF1KAscQ/gn0iWQOocdx2VDxe8jpoQBtJduFONZOf6+5xeD4+ag4JSFOL1c3ZZbT9Ow
         SYG9PSo/2GypNwv0tF/39wlx4TZHAu8OeANkx1+9CF+gXvW/+S/BJh3H7FDCbbotd+mW
         5aeA==
X-Forwarded-Encrypted: i=1; AJvYcCUSTfT+IIc0aRSHiJAwsVhmnJYaQkep40kOuuNcEFGQVkvXo/h6ob25vqv/48Ck/WIhDWRorsq0xf+fXpyuZky7EQGj/A==@vger.kernel.org, AJvYcCUuk9D1Apn9sJ0Tj0ZWgxQRgAZf7ZFHnOz051ETjk16HbhsFFvOBk0Hj545L9jkzUBRb0oxI1ZNw1idyIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbtHEgmwvia8uIUrargTeCuNIbEUZDvR9tjSxCkYuYFf2CO2Dh
	DQzI2alENY6Z5ZOoMKPSp42ib6AoUlkyfCC6kIP84UhPvj7O0UkY4eAaaEQ8
X-Google-Smtp-Source: AGHT+IGk1LbMrIX3TQr9Wbd5bDqlW1+lLpA+tjGnzCQaeNNEgzkp/zcMPFk19jA6bihXxe9gGvSgfA==
X-Received: by 2002:a17:902:d58c:b0:20c:ab2d:a664 with SMTP id d9443c01a7336-210c6cd11f6mr256385935ad.59.1730320429688;
        Wed, 30 Oct 2024 13:33:49 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93da98480sm65778a91.7.2024.10.30.13.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:33:49 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:33:45 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com, w_armin@gmx.de, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH 1/2] dell-smbios-base: Extends support to Alienware
 products
Message-ID: <7dp62mqmqqgcjb4pyoszdmpml4vi364uui233iyspibah7qbbl@hgwc7vc2xyxd>
References: <20241030181244.3272-2-kuurtb@gmail.com>
 <20241030182613.xn3tl2khzuhft4sr@pali>
 <7kx45jrxlzo6vhaknkxlrpxfs6w4ijwee3qdb7mavz2rtxqetk@vpknhvcpfgwl>
 <20241030200729.7klmmwvpnwxq326z@pali>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030200729.7klmmwvpnwxq326z@pali>

On Wed, Oct 30, 2024 at 09:07:29PM +0100, Pali Rohár wrote:
> On Wednesday 30 October 2024 17:01:11 Kurt Borja wrote:
> > On Wed, Oct 30, 2024 at 07:26:13PM +0100, Pali Rohár wrote:
> > > On Wednesday 30 October 2024 15:12:45 Kurt Borja wrote:
> > > > Fixes the following error:
> > > > 
> > > > dell_smbios: Unable to run on non-Dell system
> > > > 
> > > > Which is triggered after dell-wmi driver fails to initialize on
> > > > Alienware systems, as it depends on dell-smbios.
> > > > 
> > > > This effectively adds dell-wmi and dell-smbios support to Alienware
> > > > products.
> > > > 
> > > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > > > ---
> > > >  drivers/platform/x86/dell/dell-smbios-base.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> > > > index 73e41eb69..01c72b91a 100644
> > > > --- a/drivers/platform/x86/dell/dell-smbios-base.c
> > > > +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> > > > @@ -576,6 +576,7 @@ static int __init dell_smbios_init(void)
> > > >  	int ret, wmi, smm;
> > > >  
> > > >  	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> > > > +	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
> > > 
> > > Are we sure that all devices with "Alienware" OEM string supports this SMBIOS API?
> > 
> > No, I am not sure.
> > 
> > However, I believe this driver is intended for general Dell SMBIOS 
> > implementations and automatically checks for support. I know this doesn't
> > necessarily extend to Alienware, so I hope some of the Dell maintainers
> > could shine some light on us.
> > 
> > I tested this on an Alienware x15 R1 and only some SMBIOS features
> > work, but no errors and dell-wmi-base works perfectly.
> 
> This is good to know. You should write into commit message on which
> platform you have tested this change. In case there would be some issues
> in future, it will help to for example whitelist working machines.

Perfect. I will.

> 
> I asked for this because for example dell hwmon driver has explicit list
> of working and non-working devices. And on some dell some machines just
> calling hwmon API cause issues...
> 
> So it is not just theoretical problem that allowing all devices from
> Dell with some generic OEM string can cause issues.

Yes, makes sense.

Also it is worth to mention that I checked a bunch of acpidumps of
different Dell models. I found three main ACPI implementations shared
between Dell's G-Series (which uses OEM STRING "Dell System") and 
Alienware X and M-Series. Obviously there might be some key differences I'm
ignoring, but it tells me the SMBIOS interface is probably implemented
similarily.

These three laptop series are all relatively new, this probably doesn't
apply to older Alienware devices.

Kurt

> 
> > > 
> > > >  	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
> > > >  		pr_err("Unable to run on non-Dell system\n");
> > > >  		return -ENODEV;
> > > > -- 
> > > > 2.47.0
> > > > 


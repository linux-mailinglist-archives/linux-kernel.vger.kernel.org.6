Return-Path: <linux-kernel+bounces-389449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E429B6D38
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A861C20B41
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ED61D1300;
	Wed, 30 Oct 2024 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl1SvJGx"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49C1BD9D8;
	Wed, 30 Oct 2024 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318478; cv=none; b=eveSr02Ps1K0dwXDwNL4z/XGfETrrSMH8dVGP67Qc+Qyof0hLD2kvybVEAxEooTOW3up2YtHenQHGkyu0b/y+DefmrWlmLBXu6ZXhES/TFx7lEzbazpRq8ZjYlG6o3PTKQE20eawJW+26EA877V9U+k2HBcIr3SVFsOfXZ1RlNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318478; c=relaxed/simple;
	bh=TqtdwIKm4iEdZ2vLJydwEM3S5vCKcyrTOlIcs4Aw/lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oilZxDdq2hzeeluXbAZawEKTtRovBZsOzYEbC71LKJpHU6AB4Q+FOPjuZsLvPzlApc+Myzb+KOmDuk0cznjyJcl317WpUZon1fZjO02qBPu+j+137vmLuNIKYcZGuBl0K2GddfKnVsNY/Oeuc1CxO8AVhDzoT8uXKzg73STd7KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bl1SvJGx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cbcd71012so2752315ad.3;
        Wed, 30 Oct 2024 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730318476; x=1730923276; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tfd60NOPKvpiQLPV902o6dLnyxYIbQkGyxS/wxQm4nQ=;
        b=Bl1SvJGxENomgmR0Vy97G1IKEe+Npioq4c73aXOMFuUhJQtvfN9+IeUbnaxpxHOq5Q
         o7Hu0FIGjuugETHEW4cYPwGkNjr96ivhC6QreoSw3XBS2NqnMrwlZonpoiqz3w8JeyQq
         GqW86hBKBDmMc5N2MmIiK7lPTB6WmyJNN/rVbFwp4F1Lm0TzVGtetfwdwiu0szc+HbSe
         zjF2OJauFbz/j4PJLetzq10QCQHFLdB5Ccd1/IF6XH23pV6kBPMzOyk46HBiZgbYsocD
         9qOpNwyRxY3VGs0ftb91mYp/kyCqug+39Ct8AdnjesIKDRVk8VhXpytD+KhkF2Sr0zs3
         SkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730318476; x=1730923276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfd60NOPKvpiQLPV902o6dLnyxYIbQkGyxS/wxQm4nQ=;
        b=rLlkzKQ0RIeJxP8zlvt78B112AEYd11p+Tm3I8VWl3OpPLX10amjInqMQrUDLI58ir
         /FquxCFJYmml9XmRJqAWijGz4eKKNWSstGmJZNftv/b9v78cPetx2ErGh2U/CMDxezXH
         u0ISfZJ7VBbPp756GjNpkCEaq3x91ckhnBFL12ynbh34027K8GbymVsCWi6i3QdAYPb9
         yxxlRSi2nbOawtqjMuvm0SSbRdfbn5T65AQp/nRS0XDJmt2t1c1Xv0Q/1UxPINSsIEE2
         LqVLAMP0jwetmFG1phIqCAj0vgE838ZgnQwDGNsghL/8v/ma0meQY7XZC0ZfZoCfq5t6
         PkcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGyHH1wum+o6AoerBfDBDJVoj0pLU5f+mbz+0DCmIGF8OvwPAyMTNJeNTZ+Bxy/GZn00bj67Ry/fp3nmF/QCXa6XgjkA==@vger.kernel.org, AJvYcCW0Mxxac/PoOvBxoP8yaDbNCZK1vSJSRsWpTrpiC6hayWztRUTSidlLJgilK4xrIyAEXLEZA91VZ1NQBEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgf+Zyy/9iAuzEQKEPJV/78nJSwIR0gSCjHqwOzNgAimLozQY
	2n1zuLZ0vMqB7EqK5QvilcMNFzSC828VbclKgnuJQc5oEnLH3mKk
X-Google-Smtp-Source: AGHT+IF+H57lU6Un5w721gl4wx2QPNSbGD2nXqT40d8Hrx4yL/GdbYlIIS/ck16PVXeKTehJvvBx+w==
X-Received: by 2002:a17:902:f64e:b0:20c:ef81:db with SMTP id d9443c01a7336-210c6c01188mr221074075ad.28.1730318475671;
        Wed, 30 Oct 2024 13:01:15 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc013410sm85626095ad.173.2024.10.30.13.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:01:15 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:01:11 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com, w_armin@gmx.de, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH 1/2] dell-smbios-base: Extends support to Alienware
 products
Message-ID: <7kx45jrxlzo6vhaknkxlrpxfs6w4ijwee3qdb7mavz2rtxqetk@vpknhvcpfgwl>
References: <20241030181244.3272-2-kuurtb@gmail.com>
 <20241030182613.xn3tl2khzuhft4sr@pali>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030182613.xn3tl2khzuhft4sr@pali>

On Wed, Oct 30, 2024 at 07:26:13PM +0100, Pali Rohár wrote:
> On Wednesday 30 October 2024 15:12:45 Kurt Borja wrote:
> > Fixes the following error:
> > 
> > dell_smbios: Unable to run on non-Dell system
> > 
> > Which is triggered after dell-wmi driver fails to initialize on
> > Alienware systems, as it depends on dell-smbios.
> > 
> > This effectively adds dell-wmi and dell-smbios support to Alienware
> > products.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  drivers/platform/x86/dell/dell-smbios-base.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> > index 73e41eb69..01c72b91a 100644
> > --- a/drivers/platform/x86/dell/dell-smbios-base.c
> > +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> > @@ -576,6 +576,7 @@ static int __init dell_smbios_init(void)
> >  	int ret, wmi, smm;
> >  
> >  	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> > +	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
> 
> Are we sure that all devices with "Alienware" OEM string supports this SMBIOS API?

No, I am not sure.

However, I believe this driver is intended for general Dell SMBIOS 
implementations and automatically checks for support. I know this doesn't
necessarily extend to Alienware, so I hope some of the Dell maintainers
could shine some light on us.

I tested this on an Alienware x15 R1 and only some SMBIOS features
work, but no errors and dell-wmi-base works perfectly.

> 
> >  	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
> >  		pr_err("Unable to run on non-Dell system\n");
> >  		return -ENODEV;
> > -- 
> > 2.47.0
> > 


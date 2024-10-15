Return-Path: <linux-kernel+bounces-365003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A000399DC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BAD28309A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B5816130C;
	Tue, 15 Oct 2024 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS6HCrPH"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F0915ADAF;
	Tue, 15 Oct 2024 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728958373; cv=none; b=hiMgjG8Y02d7So3Fdj9/Mlc8dRCpYVmRPkUNE7WrHe9iWw7mit9Z1Z/ourgvqitX2+iIkDwFmBSUxr/Hbzr+w98yV/xk2VYSY0xsW387+4HBo+GUC1YGo7yDPGuTEMMvNia5XrbPI5MaVhPLOQkijV9rym98X/G2+6Tj4Piedjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728958373; c=relaxed/simple;
	bh=H0fn2+8MQBU1/jfryBfbl43F50MJwop7WqfZxHiCtNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+tiz0aRC6okJxveMraC1iTh0RKUFblN1/u1N/HruO82iP37JSXpgMvc/iiUdKwnT7A2CDosesApAoey5aKR9EbGU384J02oC/2K7rWBQIFq3A8vfuO4WyYJIHT2bZg1YY1MTNZ4480jHOZmWbWpsxqlkwrHxPbd04i8aU+xL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nS6HCrPH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so3750672a91.0;
        Mon, 14 Oct 2024 19:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728958371; x=1729563171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SBKiJS3M5jGvXqu9WLoTR9S513AG6P0MUpbOvXCHls=;
        b=nS6HCrPHiblkYIgoPAYI+GMTKKqaPHIF8k0JGUT8Uj3ROu/yg7m3s3vHrveh2fYQbo
         fTkT+sWGM1z0WASdKkNcoGaTEAI+IXuSSxZaK9fRHYbNQZXjU3Tv3fnPtWYcfIIFGh9N
         8IXgcb8Low/tDIXi0jqe2FKrMwR1LqTWHKhecjc4iIrbJpsQgHJdgI1Bs3BA1OuKzMSY
         XInOKHizozwZJ/fSJNWVJBQ0mSSjwXfRlsMRpiK38kxT3d3GN4IE/bl1CGEybSRLafho
         vzKz2ukm2hg5M6SBdwEsEta+3k92pDMB9o3h4nBv9Qe6iVhOCgmKNdZB/89mEjLRHTki
         jzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728958371; x=1729563171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SBKiJS3M5jGvXqu9WLoTR9S513AG6P0MUpbOvXCHls=;
        b=VpDIAlgcOcTyplGcYl8NpPs59HvLU0LHr1qqa1phy2qCuKFpyZ9/3JBAAxntJLOLig
         G0291XlC2CB4JV4jeOr9arLkaiLKY/oUIrLbj+gMX0lI9IoI84dAMVL3GgHcUGIDN3Xn
         zYIUKjbgGUwjeEKuJx7kmX6+Qjw3AHb36bta/7DkzEUzqHIG9JL56ZLXVMYoY2pKnnDW
         yuLT/i5MGOLlDtVI8/bIcFNbX+PgGIHqIXrP0rOxNmGJ2Eya19o6rLfD23ScPIeNDYhW
         FSC+bCIyTd+SFrCO/x3gqQ6S13kwcG2VEa548l9tfiEBV+B1qvPQ8WUAmve+hZyNR/MM
         FnhA==
X-Forwarded-Encrypted: i=1; AJvYcCXFBQzTNbpjjdRIfOQxjBTkFjB5hl5dpO+G2wUCGfTIXLRFpZEpqqTDru6okjsyNF7RnWwmY0VYLAIywfM=@vger.kernel.org, AJvYcCXhRmfigbJWiCImJVvVI/nU05QUWkCLrlxhuEsMK9Y0jJArhxHrBs9EAmvzKgmKxFhf/eLeRAF2qXCRJok7J72B/cUzMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+db5OL/lMHJ6HkAm2wmAL15738UsoFAwmIxtrSunN6dv4MVx
	rm5WIivUowXTizmf8U3JDUWzg336jGoIf3BPYR4nu2c78+zlkiTvj8litGmy
X-Google-Smtp-Source: AGHT+IH9zWafi5jPO+YkOg0xmdV3p58sEd2smP/08kquVG5S+Hj2QhwLaqhlfEGymBgKfT6wFdimmA==
X-Received: by 2002:a17:90a:e608:b0:2e2:9038:4a48 with SMTP id 98e67ed59e1d1-2e2f0d8105cmr14862318a91.32.1728958371459;
        Mon, 14 Oct 2024 19:12:51 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f630c0sm266676a91.46.2024.10.14.19.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 19:12:51 -0700 (PDT)
Date: Mon, 14 Oct 2024 23:12:47 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 1/4] alienware-wmi: fixed indentation and clean up
Message-ID: <476nhdxwmbzxr4amkeccoyklpw73e63tgsrrqwzwre6hyec3ef@gx67i6x6orzv>
References: <20241012015849.19036-3-kuurtb@gmail.com>
 <20241012020124.19444-2-kuurtb@gmail.com>
 <2d685783-aef8-4774-b67c-8a8736b5a477@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d685783-aef8-4774-b67c-8a8736b5a477@gmx.de>

On Mon, Oct 14, 2024 at 06:26:45PM +0200, Armin Wolf wrote:
> Am 12.10.24 um 04:01 schrieb Kurt Borja:
> 
> > Fixed inconsistent indentation and removed unnecessary (acpi_size) and
> > (u32 *) casts.
> 
> Reviewed-by: Armin Wolf <W_Armin@gmx.de
> 

Thank you for your review.

Kurt

> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >   drivers/platform/x86/dell/alienware-wmi.c | 134 +++++++++++-----------
> >   1 file changed, 67 insertions(+), 67 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index f5ee62ce1..16a3fe9ac 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -116,68 +116,68 @@ static int __init dmi_matched(const struct dmi_system_id *dmi)
> > 
> >   static const struct dmi_system_id alienware_quirks[] __initconst = {
> >   	{
> > -	 .callback = dmi_matched,
> > -	 .ident = "Alienware X51 R3",
> > -	 .matches = {
> > -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > -		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R3"),
> > -		     },
> > -	 .driver_data = &quirk_x51_r3,
> > -	 },
> > +		.callback = dmi_matched,
> > +		.ident = "Alienware X51 R3",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R3"),
> > +		},
> > +		.driver_data = &quirk_x51_r3,
> > +	},
> >   	{
> > -	 .callback = dmi_matched,
> > -	 .ident = "Alienware X51 R2",
> > -	 .matches = {
> > -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > -		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R2"),
> > -		     },
> > -	 .driver_data = &quirk_x51_r1_r2,
> > -	 },
> > +		.callback = dmi_matched,
> > +		.ident = "Alienware X51 R2",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R2"),
> > +		},
> > +		.driver_data = &quirk_x51_r1_r2,
> > +	},
> >   	{
> > -	 .callback = dmi_matched,
> > -	 .ident = "Alienware X51 R1",
> > -	 .matches = {
> > -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > -		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51"),
> > -		     },
> > -	 .driver_data = &quirk_x51_r1_r2,
> > -	 },
> > +		.callback = dmi_matched,
> > +		.ident = "Alienware X51 R1",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51"),
> > +		},
> > +		.driver_data = &quirk_x51_r1_r2,
> > +	},
> >   	{
> > -	 .callback = dmi_matched,
> > -	 .ident = "Alienware ASM100",
> > -	 .matches = {
> > -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > -		     DMI_MATCH(DMI_PRODUCT_NAME, "ASM100"),
> > -		     },
> > -	 .driver_data = &quirk_asm100,
> > -	 },
> > +		.callback = dmi_matched,
> > +		.ident = "Alienware ASM100",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "ASM100"),
> > +		},
> > +		.driver_data = &quirk_asm100,
> > +	},
> >   	{
> > -	 .callback = dmi_matched,
> > -	 .ident = "Alienware ASM200",
> > -	 .matches = {
> > -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > -		     DMI_MATCH(DMI_PRODUCT_NAME, "ASM200"),
> > -		     },
> > -	 .driver_data = &quirk_asm200,
> > -	 },
> > +		.callback = dmi_matched,
> > +		.ident = "Alienware ASM200",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "ASM200"),
> > +		},
> > +		.driver_data = &quirk_asm200,
> > +	},
> >   	{
> > -	 .callback = dmi_matched,
> > -	 .ident = "Alienware ASM201",
> > -	 .matches = {
> > -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > -		     DMI_MATCH(DMI_PRODUCT_NAME, "ASM201"),
> > -		     },
> > -	 .driver_data = &quirk_asm201,
> > -	 },
> > -	 {
> > -	 .callback = dmi_matched,
> > -	 .ident = "Dell Inc. Inspiron 5675",
> > -	 .matches = {
> > -		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > -		     DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5675"),
> > -		     },
> > -	 .driver_data = &quirk_inspiron5675,
> > -	 },
> > +		.callback = dmi_matched,
> > +		.ident = "Alienware ASM201",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "ASM201"),
> > +		},
> > +		.driver_data = &quirk_asm201,
> > +	},
> > +	{
> > +		.callback = dmi_matched,
> > +		.ident = "Dell Inc. Inspiron 5675",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5675"),
> > +		},
> > +		.driver_data = &quirk_inspiron5675,
> > +	},
> >   	{}
> >   };
> > 
> > @@ -221,8 +221,8 @@ static struct platform_zone *zone_data;
> > 
> >   static struct platform_driver platform_driver = {
> >   	.driver = {
> > -		   .name = "alienware-wmi",
> > -		   }
> > +		.name = "alienware-wmi",
> > +	}
> >   };
> > 
> >   static struct attribute_group zone_attribute_group = {
> > @@ -292,7 +292,7 @@ static int alienware_update_led(struct platform_zone *zone)
> >   		guid = WMAX_CONTROL_GUID;
> >   		method_id = WMAX_METHOD_ZONE_CONTROL;
> > 
> > -		input.length = (acpi_size) sizeof(wmax_basic_args);
> > +		input.length = sizeof(wmax_basic_args);
> >   		input.pointer = &wmax_basic_args;
> >   	} else {
> >   		legacy_args.colors = zone->colors;
> > @@ -306,7 +306,7 @@ static int alienware_update_led(struct platform_zone *zone)
> >   			guid = LEGACY_CONTROL_GUID;
> >   		method_id = zone->location + 1;
> > 
> > -		input.length = (acpi_size) sizeof(legacy_args);
> > +		input.length = sizeof(legacy_args);
> >   		input.pointer = &legacy_args;
> >   	}
> >   	pr_debug("alienware-wmi: guid %s method %d\n", guid, method_id);
> > @@ -358,7 +358,7 @@ static int wmax_brightness(int brightness)
> >   		.led_mask = 0xFF,
> >   		.percentage = brightness,
> >   	};
> > -	input.length = (acpi_size) sizeof(args);
> > +	input.length = sizeof(args);
> >   	input.pointer = &args;
> >   	status = wmi_evaluate_method(WMAX_CONTROL_GUID, 0,
> >   				     WMAX_METHOD_BRIGHTNESS, &input, NULL);
> > @@ -508,7 +508,7 @@ static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
> >   	struct acpi_buffer input;
> >   	struct acpi_buffer output;
> > 
> > -	input.length = (acpi_size) sizeof(*in_args);
> > +	input.length = sizeof(*in_args);
> >   	input.pointer = in_args;
> >   	if (out_data) {
> >   		output.length = ACPI_ALLOCATE_BUFFER;
> > @@ -542,7 +542,7 @@ static ssize_t show_hdmi_cable(struct device *dev,
> >   	};
> >   	status =
> >   	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> > -				   (u32 *) &out_data);
> > +				   &out_data);
> >   	if (ACPI_SUCCESS(status)) {
> >   		if (out_data == 0)
> >   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> > @@ -563,7 +563,7 @@ static ssize_t show_hdmi_source(struct device *dev,
> >   	};
> >   	status =
> >   	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> > -				   (u32 *) &out_data);
> > +				   &out_data);
> > 
> >   	if (ACPI_SUCCESS(status)) {
> >   		if (out_data == 1)
> > @@ -643,7 +643,7 @@ static ssize_t show_amplifier_status(struct device *dev,
> >   	};
> >   	status =
> >   	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> > -				   (u32 *) &out_data);
> > +				   &out_data);
> >   	if (ACPI_SUCCESS(status)) {
> >   		if (out_data == 0)
> >   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> > @@ -695,7 +695,7 @@ static ssize_t show_deepsleep_status(struct device *dev,
> >   		.arg = 0,
> >   	};
> >   	status = alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STATUS,
> > -					(u32 *) &out_data);
> > +					&out_data);
> >   	if (ACPI_SUCCESS(status)) {
> >   		if (out_data == 0)
> >   			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");


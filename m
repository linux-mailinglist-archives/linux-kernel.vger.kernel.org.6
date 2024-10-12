Return-Path: <linux-kernel+bounces-362011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7033599AFED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB8E1C21953
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE6DDC1;
	Sat, 12 Oct 2024 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaH1e8RU"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2FDDA8;
	Sat, 12 Oct 2024 01:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728698260; cv=none; b=rHXTrcIaDpUx0hVDiQKNRacJ3jahO+SgqeBLdqe2y5tFcPb3zZEsJ7dKVAYXfz+YtYiWmqHjV5OXK2yv5wclwiiUs0K9nrw0EqzU9TSZiQnAgpKw6buygRvepObOHcvqK41YsfJsHPsEenQujzVYC5ANuM4tpdl+k/b0aXmdSsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728698260; c=relaxed/simple;
	bh=hzPkXX0jGElKpsJTgEDcvUxkPhR9frbu2HTIb2QwkAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLnYwuQ8Zl4KmexL5A/6uu1hng6aT3HsafaSrsUhGFlOdW2MSWgtLjSRDnKc9CFtC+aE+UIJmELGFZSCNZk4oeNmaCT63PCbZ7IUEvGLnm5XZkK3s8v0ktVSf01WmOpVwyoD+T59UIlomCKMxHtfR/f8BTHAi4FfMYSBhWOIkgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaH1e8RU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e06ba441cso2169903b3a.1;
        Fri, 11 Oct 2024 18:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728698258; x=1729303058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/1nVIx/6krwU4xjPcep9X3bs8K+7xjxSSaTs64fLFk=;
        b=TaH1e8RUhEj3xJjqLC+472Ibr2S65QGJLOz8bmspaeE2sHkle8l3AtUV+xtfSlyViK
         9r4V26wvmIk2FWa1NhmZNaO+UEah0EncwK7UapIWPG3GcqvEjqJnQQeaifuJ6i+JoroK
         nNwUTJWE8/O+y4mdZNK3UKDIlAYMzNsjmOLidqf9U8dFlKGlBy5GTyXETIPGqNv2n7/O
         OeIy6kW9Kbfjd+FP2KViNlcm+GDAykAq/CU4e548aPdHNy0NElNpPyIdNIFmZjogtpcu
         GhrV9GH0s9yRW8+FlMGUTutCavRL5Sz3eomVcBHyZWFaYAZUwKwY+7/TpBu8gye3OwHw
         flgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728698258; x=1729303058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/1nVIx/6krwU4xjPcep9X3bs8K+7xjxSSaTs64fLFk=;
        b=b79UETGL1DGskFxXTmLgg0o5fXf9K4Wso9xU2tkVGvuuiAtwLcqCbaGoBz5fCX6t0y
         VgQdfeyU+VxPwMs1PDR0tIbakS1YdFGoVb8LE7SVsepjjDR7jdImjCchexNBrm7/KkVo
         LMBOCzribofBrzcU1yC0Hbziiok6HujGOqaHXxL+OSWnMsB/TgpFgQdokCJGb9DZ62QE
         itg2RoGaGtI5DTrHlLGUtZn/gQ6ndfKj9TdNsyTroGG9pm6nj7eJ4RLpJXSXqhSn4J9/
         zFyoi2/9u2N84mVYc6+OM7VyeBvHYjPojZ0s1F8sKTKLVXul1XG+eweH3Y8sKVQsW1Lo
         UnrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFMb18ri1OfMQLXu+vfQd0qPpoMuN49WBtiAW9agNtS5rLs8TbSfKtIXfN6JQsLX6FhKkeXcFHgaJLufQ=@vger.kernel.org, AJvYcCW5Leak9Kb896nJCwkKvcP9y8+sVurfESuTT4iHB2KiOCTFK9z/qqP1bhB7Sq653OHIrFKIaN7fdyopzm485APOgt2Iew==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQnWZXURfl/mEzZs6uT960W8O+kX7sKoBJ+j9r4FzeNFzlNQX
	avel4EL6iTXY7OiBayVO7E5GzN6zeSYL6HjBQ8TJphkr9NOlkgigXgPBtG8z
X-Google-Smtp-Source: AGHT+IFNgbnpEP7RSmtu8REh1m0IW0BUIupj0x8mAiEvpoNeWuyXd73VjYd301yzfRHRu5BMNcx8PQ==
X-Received: by 2002:a05:6a21:4a4c:b0:1d5:a29:3173 with SMTP id adf61e73a8af0-1d8bcf41208mr5937048637.24.1728698257874;
        Fri, 11 Oct 2024 18:57:37 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e3dd922aesm1752933b3a.173.2024.10.11.18.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 18:57:37 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	kuurtb@gmail.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 1/4] alienware-wmi: fixed indentation and clean up
Date: Fri, 11 Oct 2024 22:57:33 -0300
Message-ID: <20241012015733.18431-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <1cf8cd09-aeba-be32-164b-514d65b635b4@linux.intel.com>
References: <1cf8cd09-aeba-be32-164b-514d65b635b4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All changes done in v5.

Thank you for all your help.

> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  drivers/platform/x86/dell/alienware-wmi.c | 134 +++++++++++-----------
> >  1 file changed, 67 insertions(+), 67 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index f5ee62ce1..16a3fe9ac 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -116,68 +116,68 @@ static int __init dmi_matched(const struct dmi_system_id *dmi)
> >  
> >  static const struct dmi_system_id alienware_quirks[] __initconst = {
> >  	{
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
> >  	{
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
> >  	{
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
> >  	{
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
> >  	{
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
> >  	{
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
> >  	{}
> >  };
> >  
> > @@ -221,8 +221,8 @@ static struct platform_zone *zone_data;
> >  
> >  static struct platform_driver platform_driver = {
> >  	.driver = {
> > -		   .name = "alienware-wmi",
> > -		   }
> > +		.name = "alienware-wmi",
> > +	}
> >  };
> >  
> >  static struct attribute_group zone_attribute_group = {
> > @@ -292,7 +292,7 @@ static int alienware_update_led(struct platform_zone *zone)
> >  		guid = WMAX_CONTROL_GUID;
> >  		method_id = WMAX_METHOD_ZONE_CONTROL;
> >  
> > -		input.length = (acpi_size) sizeof(wmax_basic_args);
> > +		input.length = sizeof(wmax_basic_args);
> >  		input.pointer = &wmax_basic_args;
> >  	} else {
> >  		legacy_args.colors = zone->colors;
> > @@ -306,7 +306,7 @@ static int alienware_update_led(struct platform_zone *zone)
> >  			guid = LEGACY_CONTROL_GUID;
> >  		method_id = zone->location + 1;
> >  
> > -		input.length = (acpi_size) sizeof(legacy_args);
> > +		input.length = sizeof(legacy_args);
> >  		input.pointer = &legacy_args;
> >  	}
> >  	pr_debug("alienware-wmi: guid %s method %d\n", guid, method_id);
> > @@ -358,7 +358,7 @@ static int wmax_brightness(int brightness)
> >  		.led_mask = 0xFF,
> >  		.percentage = brightness,
> >  	};
> > -	input.length = (acpi_size) sizeof(args);
> > +	input.length = sizeof(args);
> >  	input.pointer = &args;
> >  	status = wmi_evaluate_method(WMAX_CONTROL_GUID, 0,
> >  				     WMAX_METHOD_BRIGHTNESS, &input, NULL);
> > @@ -508,7 +508,7 @@ static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
> >  	struct acpi_buffer input;
> >  	struct acpi_buffer output;
> >  
> > -	input.length = (acpi_size) sizeof(*in_args);
> > +	input.length = sizeof(*in_args);
> >  	input.pointer = in_args;
> >  	if (out_data) {
> >  		output.length = ACPI_ALLOCATE_BUFFER;
> > @@ -542,7 +542,7 @@ static ssize_t show_hdmi_cable(struct device *dev,
> >  	};
> >  	status =
> >  	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> > -				   (u32 *) &out_data);
> > +				   &out_data);
> >  	if (ACPI_SUCCESS(status)) {
> >  		if (out_data == 0)
> >  			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> > @@ -563,7 +563,7 @@ static ssize_t show_hdmi_source(struct device *dev,
> >  	};
> >  	status =
> >  	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> > -				   (u32 *) &out_data);
> > +				   &out_data);
> >  
> >  	if (ACPI_SUCCESS(status)) {
> >  		if (out_data == 1)
> > @@ -643,7 +643,7 @@ static ssize_t show_amplifier_status(struct device *dev,
> >  	};
> >  	status =
> >  	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> > -				   (u32 *) &out_data);
> > +				   &out_data);
> >  	if (ACPI_SUCCESS(status)) {
> >  		if (out_data == 0)
> >  			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> > @@ -695,7 +695,7 @@ static ssize_t show_deepsleep_status(struct device *dev,
> >  		.arg = 0,
> >  	};
> >  	status = alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STATUS,
> > -					(u32 *) &out_data);
> > +					&out_data);
> >  	if (ACPI_SUCCESS(status)) {
> >  		if (out_data == 0)
> >  			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
> > 


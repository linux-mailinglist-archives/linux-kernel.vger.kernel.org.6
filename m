Return-Path: <linux-kernel+bounces-568935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A6A69C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DAF189E657
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A421D00A;
	Wed, 19 Mar 2025 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzcDPKE4"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA021B8F6;
	Wed, 19 Mar 2025 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424294; cv=none; b=gKicSwFChLHkbpmWnxndx5WwHQJJvByEZFin4P7bKs3NgsIxUTkCBrBRKylogg5KISHpUGKPMqoG73NDB7GK50lzU2FjiG0r4S0EdVfJPugskiZ0kbTWFMKQTZYGTH3p1Dq8oD2G825ROu6fT/83MIlFzgq+ZAuIlPzxhV7lVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424294; c=relaxed/simple;
	bh=+9sWX8YbgrFeC/YbgbhYnbjYUydHzS0Apmcm0FOvK+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoKZ9JUfNnViohoT16HTJaBYM0zEuzhf8bLPufutNAjE9idYMzukaT0F1aaNGNQQD+BOfxBnWZEqvKefKwh11RrdPzYOV2Ds0k/+Z9OgXt9tmt9c/Ql6pRVEAblN77jJpSrN3Ef1ZavE1IYVSliZmvmh56+q3VRzAjPOqrCvtys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzcDPKE4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2264aefc45dso2457345ad.0;
        Wed, 19 Mar 2025 15:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742424292; x=1743029092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdpvxvMjlHe0hrJMEYqU3FFcQkdx8uTkA7czjNOPV3g=;
        b=lzcDPKE4ubuMMCGZdUPV+n7LYwHqChJ3+GnM+xtsbntdrrlyTbP4fH+2Dz3FElMNd4
         yRxgES4z96fPkeKkarUDJ4Nf3vquw32sF+Elk4rQNxZAy3gQhZUBq8TH1UG+RznpSRY3
         R7nv8447QiNChofJ+RkKuX2cs3pzdQMxkYO4ZDDxHP7tssXNX/sm4/BXZnqWh5Spf2cD
         eGJ34y33IFBuPsktX2iFLXr/LcRuqngJfwAoTEtplBPR1b59eRLgXhaKr7lorhlhhqQ7
         brHWywkhs8N4eyAKJaVXivaCxPPVB7ALOJPybJEYV8nzjqVcO0SvgM3t5rD1ciSjkKJO
         irwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424292; x=1743029092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdpvxvMjlHe0hrJMEYqU3FFcQkdx8uTkA7czjNOPV3g=;
        b=w8U7E7/5gyWH0/plu9BJaK9LFuutPY+1ivjesY0nPG9aY+9R/5Icx8ko9uqW9zoTbW
         Aevw2lEcZkPKPuT31bViDd8Y2X5OGKE7OTvckliFqZxNKvHo0THASSbpb9swr99f0W7b
         rCcVrGooc/Un/wPa0RaoGmF2/GjOc2XrxFSSg4nItqK2w96pQK4x1E/497I/ehrnG0Dh
         0xmVOh41tgADFXWh2TyYcll9HdCVYFvN4W7pqBMVlRAJlIGidRZhE5o6VXaqdsrOpfT2
         Qb0F1FDaI78LdNJ5ol3S7FA988DoP9D8hOsQn2msY6WZOi7tw0uaDZhJe34+R761KOiO
         68jA==
X-Forwarded-Encrypted: i=1; AJvYcCUIobqDwNGxi69mwGkSGciEJ7nFP9MlX35pQZKIjhOGfJlWd6eZPNCHuGrSlWE5mCSRb7ePZqXqxv/IXF5d@vger.kernel.org, AJvYcCWlZLdL0oyc2vwBR6lqw3h7OdRr3rALDVTVnKvl8TDi3hvkpmAYEtohMl9edFsKhoVgWBTcUFwd0xFeNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCfsydVbzcYJWpduucTMeblwFDSVF+cWZoG7EeqT2KfMFhozaX
	/wMD0mLoYheITEOON+McLo3oQ9aoQMej0qq/eZFbNc2SxDUCAI6DJjoM+Q==
X-Gm-Gg: ASbGnctPnrjO1Rybr2AviD39dCysGumL0ojutWgFL1zULromNk9m/g9F7E4GkpQgd8t
	xKVZ47s8vGFtAmr36QCG4TZGHEye6XwixkSfVwsc+svAsHko4wQ4xw3mpWQTY02AyCjbiswoA5R
	AUry36e9JMDlW9BDYkXqVoaMn/KCoLNKZnhqKGboxrl9fFLDm+FaMD3xULrx76DhmQ5x48J7u4h
	53Urt4Wn0PSHI5bkesyKZI2AwRQxiWfX+QBMlXDGvXc+s+NtqKqNSHmfer3/Grfzr6tM66cWBnZ
	9xBZyojeBeYdhJ0p4gulI88wmUH491oIcsDKGnSSLTE+B+NoaAp7CnIPVQ==
X-Google-Smtp-Source: AGHT+IGeTgAmLL1+fm7nSo5v4wD4AqLA6avdP7d5J92dUSyvLM/xk723vB/JZsgeXgECNcJypAsrmw==
X-Received: by 2002:a05:6a20:2d2a:b0:1ee:63d7:1d32 with SMTP id adf61e73a8af0-1fd0e4e4531mr1516304637.0.1742424291751;
        Wed, 19 Mar 2025 15:44:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea7cac1sm11635702a12.48.2025.03.19.15.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:44:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 19 Mar 2025 15:44:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Huisong Li <lihuisong@huawei.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
	liuyonglong@huawei.com
Subject: Re: [PATCH v3] hwmon: (acpi_power_meter) Replace the deprecated
 hwmon_device_register
Message-ID: <ffef93ae-177e-4c7c-8e13-630180ad11d3@roeck-us.net>
References: <20250319020638.59925-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319020638.59925-1-lihuisong@huawei.com>

On Wed, Mar 19, 2025 at 10:06:38AM +0800, Huisong Li wrote:
> When load this mode, we can see the following log:
> "power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please
>  convert the driver to use hwmon_device_register_with_info()."
> 
> So replace hwmon_device_register with hwmon_device_register_with_info.
> 
> These attributes, 'power_accuracy', 'power_cap_hyst', 'power_average_min'
> and 'power_average_max', should have been placed in hwmon_chip_info as
> power data type. But these attributes are displayed as string format on
> the following case:
> a) power1_accuracy  --> display like '90.0%'
> b) power1_cap_hyst  --> display 'unknown' when its value is 0xFFFFFFFF
> c) power1_average_min/max --> display 'unknown' when its value is
> 			      negative.
> To avoid any changes in the display of these sysfs interfaces, we can't
> modifiy the type of these attributes in hwmon core and have to put them
> to extra_groups.
> 
> Please note that the path of these sysfs interfaces are modified
> accordingly if use hwmon_device_register_with_info():
> old: all sysfs interfaces are under acpi device, namely,
>      /sys/class/hwmon/hwmonX/device/
> now: all sysfs interfaces are under hwmon device, namely,
>      /sys/class/hwmon/hwmonX/
> The new ABI does not guarantee that the underlying path remains the same.
> But we have to accept this change so as to replace the deprecated API.
> Fortunately, some userspace application, like libsensors, would scan
> the two path and handles this automatically. So we can accept this change
> so as to drop the deprecated message.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>

Applied.

Thanks,
Guenter


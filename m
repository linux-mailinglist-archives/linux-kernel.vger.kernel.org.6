Return-Path: <linux-kernel+bounces-283778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD294F897
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346E3B20D25
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9D19A295;
	Mon, 12 Aug 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jDSlKxc6"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D51199EAB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495880; cv=none; b=COya6RTtfUKysOSOAxVhpkRfXoPAz9+wBy5X084nNcWWSezJep2zBGafjpurSQiqWI+oM32FHlssrBZqLg9fVAC9iqZq3igHhIFCzpwYm7bUwB4NW1DI0aQYlSKiHKCSFaEEgkyy6zpazsFyzv0ODlpZv/Q4ilwkHwgdAmg5P0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495880; c=relaxed/simple;
	bh=CP8T+AntS/iHAU01tb8nRV8SXoRPrOlZSp1e8z9fO/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZT3pCg8s+Z6R4wnqiXTdah85Ulrq96W14FPWWQbC5TAsKP1PWzNI/8vSiD7Dw0jI+ZBLJbN1A53O9yt5W/jxp19nl2QO1oy460/VPfkAO8L1RIzrzCmyiJVN3PEgExB1IWPAeBo49YNEacLHZk/GXZClRfsB8rupyMiV0YJtBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jDSlKxc6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc611a0f8cso34133125ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723495875; x=1724100675; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx1FcJTrAQENI8ZoNUPdOTApIsFBsETkLUh/9i4pK3o=;
        b=jDSlKxc6WpMVJOYVcLNahRBdnGA6a4d0oMh0HiG4HBw6gd/nqxMYECf1ycYt71Sfo5
         FAwViTR8lMnI4h9gv4xEWUlAZTimLRIDVZu8g4kAnhp4MzUAOrL+bRJFmguTNsW7BU+8
         aUlsMLiuc33k4tv+yKOVINzqP+0JMrdb+eWCWBC+Hp79AZAR0UT9je3a6/G+1cduPoF2
         OUakezNlarpu69sbb5Od49uNex4mx2lcTrdls24dy4ij5cdKUZsIKxj0qDnJgGvcDVvJ
         190GI7GStv0YM9NpnCiuWCz/Gxn26O2BtN70Cu9hHF16pN0woOhIKy5Lokyfic5FlA2S
         vxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495875; x=1724100675;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx1FcJTrAQENI8ZoNUPdOTApIsFBsETkLUh/9i4pK3o=;
        b=OrV3WKQ2O6sswRV+rwPub1xxahXGXYGTB+6OfqrDNZIScDDtTyN64ofYM9r4Abscxy
         Akf/zCMwxmH3uOtWuXWlNDkHsMpPyfE3JjMeYFDhWWKapGCmBm7YszUp7VQmpn5MREbk
         ZYgwqPmkhErZ/zhlNPQyHbbZenJOr6pedVWVc7ofRwOQZBjlr23RrADV5xpcNpHjrZzN
         Ir5GoOjSV4EiJMEXud03IP1exaZk18oz0miuiZpfsg7JldQdcroQsysuEELPqoNowneL
         s+M9u7EV8e+gCy+d8LHr2fR/578LNBatw+cdkOJKFk7koCslUO/cW8FaiN6qCePR5Wbz
         9ZVw==
X-Forwarded-Encrypted: i=1; AJvYcCXaJRilmptqzSp/ddacJS9wH2Fno1dQ8A+iQSGVyNbuYp8thkNGnR3bzyEW9FzOehpuvFW2+bcGmQOoVvtvBEUKw4ZKpiNFV4LAorTl
X-Gm-Message-State: AOJu0YwktVsj3dm8MDX/lMKZUUCPSHttxge1CMsvQC1CssWYTfHuQdw3
	9e9QhpTjqXK3sDXJHeVrOnWpFobPY+3g3c6JMDLGKFfZmm0GKVbZ2t22lKNOiAE=
X-Google-Smtp-Source: AGHT+IFbHD9miMnGw5xLZgp5D0DQhmARx7myjai4F/lcfBqSv6V+tyrN9MnEHsaMcUosKU0p/4D2Xg==
X-Received: by 2002:a17:903:2342:b0:1fd:6b87:2147 with SMTP id d9443c01a7336-201ca12aea4mr18355905ad.6.1723495875207;
        Mon, 12 Aug 2024 13:51:15 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14a6ffsm1059285ad.96.2024.08.12.13.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 13:51:14 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Dhruva Gole <d-gole@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, Vibhore Vardhan <vibhore@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/4] firmware: ti_sci: add CPU latency constraint
 management
In-Reply-To: <20240812101148.wpybfhqkd2kponp7@lcpd911>
References: <20240809135347.2112634-1-msp@baylibre.com>
 <20240809135347.2112634-5-msp@baylibre.com>
 <20240812101148.wpybfhqkd2kponp7@lcpd911>
Date: Mon, 12 Aug 2024 13:51:14 -0700
Message-ID: <7hfrr9pirh.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dhruva Gole <d-gole@ti.com> writes:

> Hello,
>
> On Aug 09, 2024 at 15:53:47 +0200, Markus Schneider-Pargmann wrote:
>> From: Kevin Hilman <khilman@baylibre.com>
>> 
>> During system-wide suspend, check if any of the CPUs have PM QoS
>> resume latency constraints set.  If so, set TI SCI constraint.
>> 
>> TI SCI has a single system-wide latency constraint, so use the max of
>> any of the CPU latencies as the system-wide value.
>> 
>> Note: DM firmware clears all constraints at resume time, so
>> constraints need to be checked/updated/sent at each system suspend.
>> 
>> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
>> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
>>  drivers/firmware/ti_sci.c | 22 +++++++++++++++++++++-
>>  1 file changed, 21 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index 5cbeca5df313..481b7649fde1 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
>> @@ -9,6 +9,7 @@
>>  #define pr_fmt(fmt) "%s: " fmt, __func__
>>  
>>  #include <linux/bitmap.h>
>> +#include <linux/cpu.h>
>>  #include <linux/debugfs.h>
>>  #include <linux/export.h>
>>  #include <linux/io.h>
>> @@ -19,6 +20,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_platform.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_qos.h>
>>  #include <linux/property.h>
>>  #include <linux/semaphore.h>
>>  #include <linux/slab.h>
>> @@ -3639,7 +3641,25 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
>>  static int ti_sci_suspend(struct device *dev)
>>  {
>>  	struct ti_sci_info *info = dev_get_drvdata(dev);
>> -	int ret;
>> +	struct device *cpu_dev;
>> +	s32 val, cpu_lat = 0;
>> +	int i, ret;
>> +
>> +	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
>> +		for_each_possible_cpu(i) {
>> +			cpu_dev = get_cpu_device(i);
>> +			val = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_RESUME_LATENCY);
>> +			if (val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
>> +				cpu_lat = max(cpu_lat, val);
>> +		}
>> +		if (cpu_lat && cpu_lat != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
>> +			dev_dbg(cpu_dev, "%s: sending max CPU latency=%u\n", __func__, cpu_lat);
>
> An interesting observation was made which caused us to suspect this
> code, the CPU on which the latency was actually being set was not being
> printed here. It was always the cpu3
>
> cpu cpu3: ti_sci_suspend: sending max CPU latency=100
>
> If you look at how this print comes, it's always after all the cpu
> indices have run, so by then the cpu_dev value will have always become
> = nproc in the system. This makes debugging it confusing.

Good catch.  That's definitely a debug bug.  :)

Will fix in the next version.

Thanks for the review & testing,

Kevin



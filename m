Return-Path: <linux-kernel+bounces-318621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3334196F0DD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40EF1F24572
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999D61C9DF1;
	Fri,  6 Sep 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9JLdVyy"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445CE1BFE0C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617058; cv=none; b=ZwEE3n9Lc1FXluTrOJx1Pq6NPC8YK9COE/mJ0TvB0CzkVgV+XANr0QZk50nDegSx8WyXEFp04UH0kzCliXtTOcz7dbkIhqdrsq8XsyIzJ0L+ilvkWO/AF/eaneQ2AkQJMVp/ZSaX2l5XHRwiXSnLZp+R7LQ7guqjpFww24y7ZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617058; c=relaxed/simple;
	bh=2RPun1GvohKXhE5aoSasUbi/UHlKYzrsMqoeCmnres0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkzHHYWRm9iHQC8taNoxqvUAhyI8DMWixZqv81tgIq1phyiwXm85BR8w0CMpBdjzzkanZ4zB5krkqanFvxqjIeVWAxG2/XUCT4xQdqBsUmkc7xihWpLaDAL+ef1DZT+dDPMcT05BFEx2TmnUUfOEmcyaMbto6ZzbrHtiZ+oFLOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T9JLdVyy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42c7a384b18so14678445e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725617056; x=1726221856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICGVfQquZxLUdv4qyof+VD005fvK34/ue8aLmEnx0Hs=;
        b=T9JLdVyyDdR/p9VbJxJsA9DEAwURNHXiz8vyIg+hZcRFAo7+0uDcXl44T0XENCWnKN
         uG50KXtGKQCZ8LzCnys4RaxJ0A0Wg0nhFQCatjyPBYMI7q1ibquHCcdonxJ2qxLKqGhM
         dSPG3j0HoAgTmu4xkx5s7X97OrRzycWxYcapsEzzouGJIqroKplMprM6WZ1VBzdaseMk
         2enMtQKMQUwKPdOztI12b5dXXQ1qWWO7fqAUKDoascaboP+2tWniEMEJ0DvWVrMuTfpR
         9y9LM8WVD6MlE13A3s2OxgPUxR+xPn2qYF3c64z1CNzIAb9lJcWs0VhWonzFKe0WvkKU
         oDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725617056; x=1726221856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICGVfQquZxLUdv4qyof+VD005fvK34/ue8aLmEnx0Hs=;
        b=mK441/BJM8zv93/ROFs5LGgeJwFOOvlc54Li/Or/eZcRYkLVzMxzdtluGCWFlInWcc
         CA3Auzm22F8RG3Zbc7SZuP5Pz59B1m4zJyo6l1a+dyCshAnlJ3PrTotj2f7yW6CQ6Qz6
         QiQl38punKksHUXOFNGA0Yocmgn91NhJJ82RWuUpi8pGD0WXTfd158nQIj+Mu1Le4iNk
         YEOICQrFa/R2cOkTj8dDBTmV0+iaxvprmf/DdR/Bs5eOCpVHnZt0e4wKtGO1sJLNm7U2
         dSqHAbFpw5HBig1c9dkcoJiubB9tKcIO95z7oIUK1HR6i65kRSQ49QBaiLRlsRN8zbqf
         1uEA==
X-Forwarded-Encrypted: i=1; AJvYcCXIWH8ZyAr+LYjbFs4PrIc+uf5noPzevb2q12iA3SX7vsJr6qm8NExMXUz8+2H1QswEMz6MB0zP3k0/hy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2Pg3l+Vf4CEBQ7+CltMD6vNs4y0EQIu7T+6sFzVWFngdRn0O
	Fw9hCGqfZEOUgm3nAiHF2P6HwWMq7Jx3Um7T/gVugXg/CMICW//5fo/Ns9UcjWY=
X-Google-Smtp-Source: AGHT+IEa0EFSzTSab9skgszp2VXJgV7bSagVjGqTmtvznhN6ryAHPGAPBLObB1eCrJcsSNSidlyLFQ==
X-Received: by 2002:a05:6000:b92:b0:371:8dcc:7f9e with SMTP id ffacd0b85a97d-378895c6306mr1366536f8f.2.1725617055371;
        Fri, 06 Sep 2024 03:04:15 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-374bd0ce240sm17104161f8f.70.2024.09.06.03.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 03:04:15 -0700 (PDT)
Message-ID: <2c7f43b1-48e7-48f2-bbe2-c0006ac6e0e7@linaro.org>
Date: Fri, 6 Sep 2024 12:04:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] drivers/thermal/exynos: improve
 sanitize_temp_error
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz
 <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Anand Moon <linux.amoon@gmail.com>
References: <CGME20240903072005eucas1p20eec517c32d39e7aef17e6a2c2ad4b6e@eucas1p2.samsung.com>
 <20240903071957.2577486-1-m.majewski2@samsung.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240903071957.2577486-1-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/09/2024 09:19, Mateusz Majewski wrote:
> Hello :)
> 
>> May I suggest to convert this function to a specific soc ops to be put
>> in the struct exynos_tmu_data ?
> 
> Like this?
> 
> static void exynos4210_sanitize_temp_error(struct exynos_tmu_data *data,
> 					   u32 trim_info)
> {
> 	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
> 	if (!data->temp_error1 ||
> 	    (data->min_efuse_value > data->temp_error1) ||
> 	    (data->temp_error1 > data->max_efuse_value))
> 		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
> 	WARN_ON_ONCE(data->cal_type == TYPE_TWO_POINT_TRIMMING);
> }
> 
> static void exynos5433_sanitize_temp_error(struct exynos_tmu_data *data,
> 					   u32 trim_info)
> {
> 	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
> 	if (!data->temp_error1 ||
> 	    (data->min_efuse_value > data->temp_error1) ||
> 	    (data->temp_error1 > data->max_efuse_value))
> 		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
> 
> 	if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
> 		data->temp_error2 = (trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
> 				    EXYNOS_TMU_TEMP_MASK;
> 		if (!data->temp_error2)
> 			data->temp_error2 = (data->efuse_value >>
> 					     EXYNOS_TRIMINFO_85_SHIFT) &
> 					    EXYNOS_TMU_TEMP_MASK;
> 	}
> }
> 
> static void exynos7_sanitize_temp_error(struct exynos_tmu_data *data,
> 					u32 trim_info)
> {
> 	data->temp_error1 = trim_info & EXYNOS7_TMU_TEMP_MASK;
> 	if (!data->temp_error1 ||
> 	    (data->min_efuse_value > data->temp_error1) ||
> 	    (data->temp_error1 > data->max_efuse_value))
> 		data->temp_error1 = data->efuse_value & EXYNOS7_TMU_TEMP_MASK;
> 	WARN_ON_ONCE(data->cal_type == TYPE_TWO_POINT_TRIMMING);
> }
> 
> static void exynos850_sanitize_temp_error(struct exynos_tmu_data *data,
> 					   u32 trim_info)
> {
> 	data->temp_error1 = trim_info & EXYNOS7_TMU_TEMP_MASK;
> 	if (!data->temp_error1 ||
> 	    (data->min_efuse_value > data->temp_error1) ||
> 	    (data->temp_error1 > data->max_efuse_value))
> 		data->temp_error1 = data->efuse_value & EXYNOS7_TMU_TEMP_MASK;
> 
> 	if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
> 		data->temp_error2 = (trim_info >> EXYNOS7_TMU_TEMP_SHIFT) &
> 				    EXYNOS7_TMU_TEMP_MASK;
> 		if (!data->temp_error2)
> 			data->temp_error2 = (data->efuse_value >>
> 					     EXYNOS7_TMU_TEMP_SHIFT) &
> 					    EXYNOS_TMU_TEMP_MASK;
> 	}
> }

Yes, something like that but may be with more code factoring, like a 
common routine to pass the temp_mask and the specific chunk of code.

> Or maybe we could put tmu_temp_mask and tmu_85_shift in data instead,
> and have one function like this:

Either way

It would be nice if the code can be commented to explain how the sensor 
works in order to understand what means "sanitize the temp error"

> static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
> {
> 	data->temp_error1 = trim_info & data->tmu_temp_mask;
> 	if (!data->temp_error1 || (data->min_efuse_value > data->temp_error1) ||
> 	    (data->temp_error1 > data->max_efuse_value))
> 		data->temp_error1 = data->efuse_value & data->tmu_temp_mask;
> 
> 	if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
> 		data->temp_error2 = (trim_info >> data->tmu_85_shift) &
> 				    data->tmu_temp_mask;
> 		if (!data->temp_error2)
> 			data->temp_error2 =
> 				(data->efuse_value >> data->tmu_85_shift) &
> 				data->tmu_temp_mask;
> 	}
> }
> 
> Thank you,
> Mateusz


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


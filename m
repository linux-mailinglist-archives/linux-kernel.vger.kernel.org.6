Return-Path: <linux-kernel+bounces-240095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FC7926912
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A0F1F25490
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BC218C334;
	Wed,  3 Jul 2024 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+fltZH6"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7BB1891B6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720035587; cv=none; b=uIiX+DC9Y4QXvNM22hdwxAjv06xY4xAdD8A4UKqCgT+ZQkBQH854QQ/xTVwRHcRxYgnFkGNDt9b2U3tX1abGcFhtK9waXtgp6gMREmzfaGHgv6n/kVw60eOMW57jlth5p5zHMZ5KvHYTWO0Mtut8KBhE9rfry09remDgqEDQbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720035587; c=relaxed/simple;
	bh=PgjlqjpDtSMNToK+0DWfNPbGm3RXM7KEd8vklcHb2CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRXSyFPCjagpCH4sGhunfvpdJ9dXVlVZMdQfqWY/RWjmKI73XrLBHI2Vp/e3XyFc3cih+GWG1wewFMrZF5U/ZFZq1QNvD7/bNQ2pI8Z+WAjkyfiGUOQZyUL2FXUGrslxLXr674nZyyBC7qMmJ+4wuEisu7rzOCkx0FNicHho1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r+fltZH6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so59793591fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720035584; x=1720640384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQz1UR6bDZLMmSUGCaRreiwA1h+kKJVVIEZe47xJ3rI=;
        b=r+fltZH6WIJAwES4UAwvWJ4oLyhhEbqooSzUocT6VeHJCq9vH2U6E5pwC3mbGd7+ys
         HHkHKQzphba4MrVJVJzRg6lXpbh7lhbizlNI0cIla5Fh0OUSEqdPHMYmIozDEItQ/hIG
         wWy+zwu4bKPnWtPOknh8O//M1Sij35Yw6PDWjOMRqAQit8UeL76dO395Jnsa0eig05dO
         YznBxwymNq0pUR+B5G83WDdhYJNDViZ2Dh9oLMNistyFSoauaOgjADMUZhdAcl8CRXQy
         1+vJZOj/0C7dca/oXSIQVH7mrYw2tyDCYtCZ5vTZE40xsnFNQMWGCu+blpDL1vxsbhke
         2q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720035584; x=1720640384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQz1UR6bDZLMmSUGCaRreiwA1h+kKJVVIEZe47xJ3rI=;
        b=qEkj6zLcC4c91FU0MMc/oQeHjr1l9SiP7EyUA29DRzjpLadOmc4Xz2FWRsbZd+30cv
         XGqRi7cBS/jW5PYjJNUZcLEvfjMVORywBt6z45Zy41b9PT3z7pdIKtY95jRIVGOlkTEQ
         O5YWL/VCA8n+TXTFs7fNMKL4kkbgkdAqcE2Dqh+oZ4x1vziAGTp1YuNwVh5neKClOVYx
         lHcmO1OiSjn393PXwkO9aqB9GP+5IgiDAP3PnlS/Z0+p0wRslaUtIzWk93fe1XLx366A
         eOzNMRrbrUOwQ4MhPZXnU0lGS/ipyL5OswMKLWtQR+BxOTXhS3cdqmM2mwt7569OQ5f6
         /gIw==
X-Forwarded-Encrypted: i=1; AJvYcCXC3V/mBpT0fYhEWfzhIpeLlnIOhwmb5I+940fmMtVfqB3eD4UdjntMIB0pdeH9vuZvfjKO1Xjv87cufH/cxTSYTFlL31e4iejEY2gX
X-Gm-Message-State: AOJu0Yw/RES4mgISF1ZZN9StaT77G/jnDMKAUw695/UiCrWzmh0GGEHf
	zb9jkGYHbcDbgDuNDuyC0aEOFLAcMDRLNcv2QGA7tRyQK+d0k+ZBmrLYQ114xaU=
X-Google-Smtp-Source: AGHT+IEpw4uTyTeCbt6/9ih3YCJdaiM7QLsRYETOoXHgx6zL4W2wfa3/M5DwW4ZdtGzxE5d7N91g4w==
X-Received: by 2002:a2e:a889:0:b0:2eb:dd0b:b9ec with SMTP id 38308e7fff4ca-2ee5e3a30e0mr98452451fa.20.1720035584013;
        Wed, 03 Jul 2024 12:39:44 -0700 (PDT)
Received: from [192.168.86.191] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm248729915e9.15.2024.07.03.12.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:39:43 -0700 (PDT)
Message-ID: <80baa293-d0b1-404c-afc6-4e0e25ae7f60@linaro.org>
Date: Wed, 3 Jul 2024 20:39:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100: add Lenovo Thinkpad Yoga
 slim 7x devicetree
To: Rob Clark <robdclark@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240703-yoga-slim7x-v1-0-7aa4fd5fdece@linaro.org>
 <20240703-yoga-slim7x-v1-2-7aa4fd5fdece@linaro.org>
 <CAF6AEGt+3LFP+GCcSwiSEymixVVkYD98iJX5RJ75NQDzZbPpcw@mail.gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <CAF6AEGt+3LFP+GCcSwiSEymixVVkYD98iJX5RJ75NQDzZbPpcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/07/2024 19:33, Rob Clark wrote:
> On Wed, Jul 3, 2024 at 10:17 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> Add an initial devicetree for the Lenovo Yoga slim 7x with support for
>> Display, usb, keyboard, touchscreen, PMICs, speaker audio, gpu, NVMe,
>> and remoteprocs.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>>   .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  | 910 +++++++++++++++++++++
>>   2 files changed, 911 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index e0babd642fa8..d7de2aea4748 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -261,4 +261,5 @@ dtb-$(CONFIG_ARCH_QCOM)     += sm8650-mtp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += sm8650-qrd.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += x1e80100-asus-vivobook-s15.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += x1e80100-crd.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)        += x1e80100-lenovo-yoga-slim7x.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += x1e80100-qcp.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
>> new file mode 100644
>> index 000000000000..1d00119691bc
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
>> @@ -0,0 +1,910 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
...
>> +
>> +&gpu {
>> +       status = "okay";
>> +
>> +       zap-shader {
>> +               firmware-name = "qcom/x1e80100/LENOVO/14Q8X9/qcdxkmsuc8380.mbn";
> 
> I ended up with:
> 
>    firmware-name = "qcom/x1e80100/LENOVO/83ED/qcdxkmsuc8380.mbn";
> 
> my DMI string is:
> 
>    DMI: LENOVO 83ED/LNVNB161216, BIOS NHCN36WW 05/23/2024
> 
> idk if that is different for you?


You are correct, dmi/id/product_name is 83ED in my case too. I think i 
overlooked it :-)


will send out a v2 to fix this one..


> 
>> +       };
>> +};
>> +
>> +&i2c0 {
>> +       clock-frequency = <400000>;
>> +
>> +       status = "okay";
>> +
> 
> I also have this, which is working for me (sry about gmail butchering
> the formating):
> 
> 
> touchpad@2c {
> compatible = "hid-over-i2c";
> reg = <0x2c>;
> 
> hid-descr-addr = <0x20>;
> interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
> 
> pinctrl-0 = <&tpad_default>;
> pinctrl-names = "default";
> 
> wakeup-source;
> };
> 
> basically just uncommented the node from Xilin's tree, but seems to work fine.
> 

Thanks.. I could not figure out the descr-addr from acpi tables.
It works now..
V2 will have this as well.

--srini

> BR,
> -R
> 


Return-Path: <linux-kernel+bounces-216957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEB490A91C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575CD28932A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAB0190698;
	Mon, 17 Jun 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/W5sT9X"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F6C1836FC;
	Mon, 17 Jun 2024 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615348; cv=none; b=vE+3koCsr6iOtI6dip6hJ4SsIY48CuQepI+M2DBgfWrSY99V2kkSmDB+R2dNgTiN+QLALKlZdN2KYmJUPFQScpp7bdPdU+ln2TkxEc31ZOkt8ZYrXu5qpz1zXZ+5AUr/QnHyj/YJ1KgezgcaqE0xlmepWfJSgpmxo9JYtFGnjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615348; c=relaxed/simple;
	bh=cXXNE+/7w55i14XhydNETn2Xywxi8u/c5hsjE7hRYsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kn2qg7OAWtf/xCHoo/uOC6M83454unp1Y9cpZM6/WKFasRaXgzEtt43z0v/dbb0wDL40AK+A1CfEYc5UXvtiJLz85QQkTIfSDTFpORRAJ3jKCvDQpe7mLvvfenvmeqBnLMMZ50ZHiLBZfZnrAVVDlVytiHKXOGDoPZpPl+RQrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/W5sT9X; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so4729504e87.3;
        Mon, 17 Jun 2024 02:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718615345; x=1719220145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHualuQcrcR9FOndaPpRpoW37XnDcV8gKD4pHsnrc4s=;
        b=Z/W5sT9X7APzG+yGuNPY5Ek5W3hniignONtip2sjqOyVKntD7Uh7U7IZRFiv231gLe
         fOESf4zbdxsjTz6+jxlBhslmjR87MMXMJSsT0eb2dMSznHkvQtMT7t0RgRyxFUDDLuak
         bp5vAa+nNHcj7fHjJ+N+gG1C3NdAnI0/RcKU4DIKBTxe3bHnYeNNi3cR0620HWdOwfnP
         27lH+5hBqeGh1fEXKzJOBt+C8rwK8ftzHLJZKIkDhdKYiUNquGv0KcvHT4l2oiE4G5+p
         gJRP1KPYIY4Y+5SNuA8bTuh+3c+mmefVHpptyRt7O8ENk+ccIqpGpKX1DWiQGdkWC+a1
         t+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615345; x=1719220145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHualuQcrcR9FOndaPpRpoW37XnDcV8gKD4pHsnrc4s=;
        b=VFMDbttYP/2qHdvFQp3PlmXAbC+z2ArOCbudu1Az6v8q/BxQRzb6TlSSXDkSlp2Vjv
         WirP8VT8j7FmaMYeOWLjyHyHtE1CmIsreiM/66bZG2CTpyaHTsS7SGxyskJGEYHffD3w
         akxItWUO0nmBHtWnx5nvpVtyS7ExGehPXLWaw0FTVgJb8ifAfChYniEvFY7opzm1B6eG
         P8hsUNkG6zcdjEYDdpWw+sJyhc+FJstBOu4f9mGl+DNZW2uZjIDsvLCPJJ9piET93CMA
         eqTLv706fzD50QyPyfm6PSsnf4kbMtdMTU6jA7jGsIlgaPdEK2VZ/PTnrBCz/VTy4AFw
         SQbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlNG9A9DWf0QgDn5WicOU+M2n4q8zuav8zdNg7V7GTMsZxNZzMcZ9pX4Tl7M3rMzaywHeXqc2zx/b77H9q9cGbVsaOacYE44aSaiGw49BkMgpMHzGxyMZdMW4LsDMXSwpyaAVun+qdLw==
X-Gm-Message-State: AOJu0YyEy84Ru00ozWT3hA1bUD1ld7V2wRkHQXmWsZy+OByIfLOkA/dt
	kfGWdLPZPIciHQZyw2mL3aPwB6ZS2b5WRVgO7cJSl/olag6OCd99
X-Google-Smtp-Source: AGHT+IFHVBJp/VFqtV++c4t0//VCdL0P9LDVu7JUn+qUbTIRnLIdZCE653CJVQBQ1vaa46S79Eeekw==
X-Received: by 2002:ac2:555e:0:b0:52c:9a1f:52e7 with SMTP id 2adb3069b0e04-52ca6e988a6mr5758312e87.58.1718615344901;
        Mon, 17 Jun 2024 02:09:04 -0700 (PDT)
Received: from ?IPV6:2001:8f8:183b:6864:7071:8881:6a51:3e82? ([2001:8f8:183b:6864:7071:8881:6a51:3e82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6127d6dsm154008765e9.26.2024.06.17.02.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 02:09:04 -0700 (PDT)
Message-ID: <8ae179e6-3aee-415b-9dc4-298e162fbcad@gmail.com>
Date: Mon, 17 Jun 2024 13:09:00 +0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: rockchip: Add cpufreq support to
 Khadas Edge2
Content-Language: en-GB
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, Jacobe Zang <jacobe.zang@wesion.com>
Cc: nick@khadas.com, efectn@protonmail.com, jagan@edgeble.ai,
 dsimic@manjaro.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-6-jacobe.zang@wesion.com> <5475817.tWeucmBOSa@diego>
From: Alexey Charkov <alchark@gmail.com>
In-Reply-To: <5475817.tWeucmBOSa@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 17/06/2024 11:33, Heiko Stübner wrote:
> Hi Jacobe Zang,
>
> Am Montag, 17. Juni 2024, 09:11:12 CEST schrieb Jacobe Zang:
>> This adjust CPU nodes on Khadas Edge2.
>>
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>> ---
>>   .../arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
>> index 7d7cc3e76838c..5fb15d3dc23e9 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
>> @@ -160,34 +160,42 @@ vdd_3v3_sd: vdd-3v3-sd-regulator {
>>   
>>   &cpu_b0 {
>>   	cpu-supply = <&vdd_cpu_big0_s0>;
>> +	mem-supply = <&vdd_cpu_big0_mem_s0>;
> as far as I remember there has not been any binding merged that declares
> this supply. Thankfully following the double phandle below, the Edge2 is
> designed to use the same regulator for the mem-supply, so special handling
> isn't even needed.

Indeed, currently there isn't any user in the mainline tree (neither 
bindings nor drivers) for this separate regulator. Mainline cpufreq-dt 
only expects a single regulator, and as Heiko pointed out Edge2 uses the 
same physical regulator to power both the CPU core and its SRAM, so 
adding a separate mem-supply here isn't helpful.

Best regards, Alexey



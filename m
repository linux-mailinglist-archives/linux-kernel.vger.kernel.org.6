Return-Path: <linux-kernel+bounces-240986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B6D92755A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21F02826A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65171AC44A;
	Thu,  4 Jul 2024 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hatAKI+P"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBB217B410;
	Thu,  4 Jul 2024 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093432; cv=none; b=P2w7hC38fafTjTyM5Yc/fxrZFGMl8rouyFF5yB7TM2Y9WZQHB9fUEHqJPHQoZYYeKX05qMVne5PmimEDccQy484JMAseymYwD1YzQsC/uCgj3+CFK40VXn16e8i2KB63THDA00yRsSJvuHFQSkrt99Av+QkhXMx54GAno5drfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093432; c=relaxed/simple;
	bh=MBMdo7s33ygnlwSJlQ8Wtv/OVCeNUkSqzmNIgtCkdcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMYhgMEj3M3YmvkC5SC5lDR5XzMdbtxswstsfMYzxRNVytqXK/JzpVBGjriu+PmqkvU+0hCM/YbmgLi9cH1rCudj918IkiGHwrd11timipSQOZn6dLUxQCO987MYBJ/NrfPETlVfzetGSxu3CbEySG/Kd2VIL3w0z2n6e0hmv68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hatAKI+P; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a724b3a32d2so57489866b.2;
        Thu, 04 Jul 2024 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720093429; x=1720698229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zveAwN34PYsp6aPMx1IsdJe3pfWxmcuJq8MSSftt/mQ=;
        b=hatAKI+P3oelM4717kb86oYcJcjyxasqXwgqHSh55poKEyaIFr5eVovl8b5aOROneI
         6njNnGJO7b+1Eyhd9PQDeRdsanGduMyJ95P6TzAOf98gj3OfJYXjx4X/bWTarC3eaUJ6
         OoTpMO1bzBYZR+SHhgmDJtuDugWTwHokt7MsuMFQ6iQx9HNK9rNhSrHN+Qt4UwPIDFFA
         9AW+5Ocecr75CBkYQ1N1Z109OexS1FmSsQQ4k+aynDBRESpX3mfr+lYsfjdEpSl5ZX6Y
         jK8O0bbwpbDpxFScdfMcNY2YJ3n6AFX0HWJeejKSqVnUw6oXvB/qoad5MSoK4vI3pKht
         PBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720093429; x=1720698229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zveAwN34PYsp6aPMx1IsdJe3pfWxmcuJq8MSSftt/mQ=;
        b=QwCFvSqUtkFKy6Jl+lqoez4/iVpywPHwNat56LR013CCAhzwtZ+C0vQDR1C1EHK+u3
         39a918fYs1U+bj+CDFUCPW0oYdkLWK7OvZIjVoBSCCn3QixQ5GrPKqVfWhdCsMU2tI4m
         0RRwQfD23ORGpYwhiWNz5F3LklXb2b4H1OM9q/oG8sm/xWb0Ta4cE/U2lhonUVom/1h0
         vB5twbjWHIUIqGOxbfDVE1/AojTj3a4MCaENYcgk61Bv0jrvSLSx2hhEXY0n8OrvPsKo
         G74F+ef0wzHIiP0NxeHNBM7azaH29bhBB6BXu8ZZdm99Ir+POlOnrPb61FotKpXCYdbZ
         ofVg==
X-Forwarded-Encrypted: i=1; AJvYcCUaIi04pH7TpgayCOTd7mo6/i6ECEJnzAodDunqkTH4xwxHcxVU79SOrmgbzpRSLi2/4SmurcvqGLhwNKOZsX9Fh/NzXbhh2REBs/FGWo2boYFQWTQjid4c4j37PBkljmk3VQt8oPAFPQ==
X-Gm-Message-State: AOJu0YwSonKzyJNPGpzASiTBGcIAUK7reNilpxCz4wQrXTiYogsTVFhb
	IprvxBMwpnVRLVNbQgf6DWnbvqBNWjy7R0DFYGS8NBh3++RuBrM=
X-Google-Smtp-Source: AGHT+IFCdpf6OuObS+dVAXvcZeJOQuT115EAXlgiAT6ExmVmJY8OSQLXrRwDiCoprKTsl/0fXCoYaQ==
X-Received: by 2002:a17:906:f287:b0:a72:415f:cb0e with SMTP id a640c23a62f3a-a77ba72725cmr89878366b.69.1720093428276;
        Thu, 04 Jul 2024 04:43:48 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:5f4b:4104:ca7b:6efb? ([2a02:810b:f40:4600:5f4b:4104:ca7b:6efb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0652eesm593037466b.131.2024.07.04.04.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 04:43:47 -0700 (PDT)
Message-ID: <2c46dfb7-5ef3-494f-8cf1-413033e73412@gmail.com>
Date: Thu, 4 Jul 2024 13:43:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: add rock5 itx board
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, Diederik de Haas <didi.debian@cknow.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240703210524.776455-1-heiko@sntech.de>
 <20240703210524.776455-3-heiko@sntech.de> <2278169.QnsP76Vvrg@bagend>
 <4552794.8F6SAcFxjW@diego>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <4552794.8F6SAcFxjW@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 04.07.24 um 12:05 schrieb Heiko Stübner:
> Hi Diederik,
> 
> Am Donnerstag, 4. Juli 2024, 11:38:51 CEST schrieb Diederik de Haas:
>> Thanks for submitting this. A quick scan indicates it should work with a
>> (recent) Debian kernel OOTB :-)
>>
>> On Wednesday, 3 July 2024 23:05:24 CEST Heiko Stuebner wrote:
>>> +&sdhci {
>>> +       bus-width = <8>;
>>> +       no-sdio;
>>> +       no-sd;
>>> +       non-removable;
>>> +       max-frequency = <200000000>;
>>> +       mmc-hs400-1_8v;
>>> +       mmc-hs400-enhanced-strobe;
>>> +       mmc-hs200-1_8v;
>>> +       status = "okay";
>>> +};
>>> +
>>> +&sdmmc {
>>> +       max-frequency = <200000000>;
>>> +       no-sdio;
>>> +       no-mmc;
>>> +       bus-width = <4>;
>>> +       cap-mmc-highspeed;
>>> +       cap-sd-highspeed;
>>> +       disable-wp;
>>> +       sd-uhs-sdr104;
>>> +       vmmc-supply = <&vcc_3v3_s3>;
>>> +       vqmmc-supply = <&vccio_sd_s0>;
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_det>;
>>> +       status = "okay";
>>> +};
>>> +
>>> +/* M.2 E-KEY */
>>> +&sdio {
>>> +       broken-cd;
>>> +       bus-width = <4>;
>>> +       cap-sdio-irq;
>>> +       disable-wp;
>>> +       keep-power-in-suspend;
>>> +       max-frequency = <150000000>;
>>> +       mmc-pwrseq = <&sdio_pwrseq>;
>>> +       no-sd;
>>> +       no-mmc;
>>> +       non-removable;
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&sdiom0_pins>;
>>> +       sd-uhs-sdr104;
>>> +       vmmc-supply = <&vcc3v3_ekey>;
>>> +       status = "okay";
>>> +};
>>> +
>>> +&sfc {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&fspim2_pins>;
>>> +       status = "okay";
>>
>> Shouldn't those properties be sorted alphabetically? Or at least consistently?
>> Note that the same issue is present on other places too, but I believe the
>> above quoted part shows the issue enough.
> 
> The main sorting is
> - compatible
> - reg
> [... alphabetically ...]
> - status
> 
Yeah ... that's always the question when adding new board files. Do it like
"it's always been done" or re-sort the properties alphanumeric _everywhere_
which looks quite strange at times. If I'm getting the newly added dt
coding style correctly common (subsystem?) properties should also be placed
before vendor (driver?) specific ones. Yet I didn't see a board file which
places 'regulator-max-microvolt' before 'regulator-min-microvolt'. So I
guess it's fine if it's done consistently within the same file?

Alex
> But now that I look at it, you're right there are some non-alphabetical
> shenanigans going on there in the sdmmc and sdhci nodes ;-)
> 
> Heiko
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip



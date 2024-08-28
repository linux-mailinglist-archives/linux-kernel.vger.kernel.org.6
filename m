Return-Path: <linux-kernel+bounces-304579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5038196220E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BC1B22766
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B4C15B57A;
	Wed, 28 Aug 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7K1UKCW"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CC0B67A;
	Wed, 28 Aug 2024 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724832712; cv=none; b=ema8YXFYMxDt1pHxbqLADw/+1AGJBwfsOR1QQo8pJtw4Wc+0OJhA5/Aez6UBSdCT5qCNugXyoluM5oQt8/8AYxreeD+hj5nPp6GI/zSV+f0HKLgDlgGcnX/yd1XZk5VRktUZBI1bv2D+Pih0h1fA+e/35M+h6cePO52umSdsSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724832712; c=relaxed/simple;
	bh=rXAlDyfQa6JsiZxIdegNxFqr8f1pLLaMFvHLepT2Hus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUapMGY3deerMtxIj7dRXHAMANwXKO+2ffgNtoSfW4vMJpMuEzkUam5CildI2g+sVorMIhrFETNRyKCLPQkO2brIGTyULmc/SdqPqltGhVO8UxuccKDIOV7hCvYq0MBL/FMp1Fi1qxPAtZaRLNckHSAFrvzMMcx8HFx8Hcfl0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7K1UKCW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso55111495e9.0;
        Wed, 28 Aug 2024 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724832709; x=1725437509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSk/OEHoPMhRCK/ZaRMyI/zmjD4EdJp4kRX9RWfkNhI=;
        b=E7K1UKCWsB2Jk9vrvl1gkpJuvm7Qg7FWBnxnhJSUzq/n41+UQOWysJ2wjIYLpZU3zG
         v6Cs/AHqWmCDGww5Me+A+Z+/h92asiwhsvxuxvy+TpQghsI4uH9s72eYlcHVPBYYb/81
         s0Au66bTStSr6xcFFbluJ0APbSkOWBs1+uVH04AhwgtM8msBNG1XPk3YoaJmWwinXAZl
         K77WGc8Ggs7JGFywi0tDAot117yY0ymJQ+qVAnc8W88Bsha3g4ZQbbXLSoN52AU/5xBo
         Z91R0/WZ9YIVOMNXsIV8PFRTZpVC+XC1VuNXBkVjKMeWo/jvC/Vk7RsnJG/d10Ai+tpU
         jopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724832709; x=1725437509;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSk/OEHoPMhRCK/ZaRMyI/zmjD4EdJp4kRX9RWfkNhI=;
        b=XSaFA93IKmTOs02docrzuJZUiT0+sW8rGyeVO5QWurBMUVq0Hz5Foxu8OriOmCvjfh
         j5H6+I0pGF3q1V4nsk5e3CTpbljx1bGfKchAbagIaxuWAJfeydpFqI74P3gJktd8o/Y6
         Gh+++twBXrXekL2KFzbeLYSc48WDrrPDa/xQyipDXif2VwDnIpWNRjG9GS9VISLQXFAL
         x2LNwFTzMRHCPhJ+wB0tbw1QkQPr2FwRYbXkqgRSjJ5yYbY1RrEp/l56Rj1ttCa8m4/O
         YwZxE0XR8YuO+uekIwGApeEvTK65DcXPcAk19ZeNUCJMd5Z9FJ3lJIieZylOozb8qjM/
         0Fww==
X-Forwarded-Encrypted: i=1; AJvYcCWUSu+4Om5xosMOnRZvsP3/cOc8Rew3UF4r0BH/ty9uBaNX3VPnmRxDxvFdi3cR92rdaCxUOBBrmLQP8xZX@vger.kernel.org, AJvYcCWtOsPjZTj5HOVWDcEU/SJ5dT43niliHJZ/Oza9F6JHxnQFO/XfIoM2qEhY0SlIo6v/laCinsSwdBDJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwVWVAaN7+e/ka+FKsxBiiSmWF/RJPtnWVmRkSBv7NOSY0FB0jg
	GpYN1wnEhNW7oIVmkonebHekjfOA23DNgFv1pfMfq0jA87xBIY3h
X-Google-Smtp-Source: AGHT+IF8lcvZiFVTHUZ/tpOE7NQ2mVYYVRKLrUmvMJQgvic+d058iumAAiF97qbfy80oik/EDFhJNQ==
X-Received: by 2002:adf:f08f:0:b0:371:7e19:b9de with SMTP id ffacd0b85a97d-37496821fb1mr774969f8f.32.1724832708968;
        Wed, 28 Aug 2024 01:11:48 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba7b4271fsm7517625e9.29.2024.08.28.01.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 01:11:48 -0700 (PDT)
Message-ID: <66432301-d5ad-4703-a08d-833573e733e0@gmail.com>
Date: Wed, 28 Aug 2024 11:11:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: Fix supported-hw mask for
 GPU OPPs
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
References: <20240725072243.173104-1-angelogioacchino.delregno@collabora.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Language: en-US, tr, en-GB
In-Reply-To: <20240725072243.173104-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2024-07-25 10:22 +03:00, AngeloGioacchino Del Regno wrote:
> The speedbin eFuse reads a value 'x' from 0 to 7 and, in order to
> make that compatible with opp-supported-hw, it gets post processed
> as BIT(x).
> 
> Change all of the 0x30 supported-hw to 0x20 to avoid getting
> duplicate OPPs for speedbin 4, and also change all of the 0x8 to
> 0xcf because speedbins different from 4 and 5 do support 900MHz,
> 950MHz, 1000MHz with the higher voltage of 850mV, 900mV, 950mV
> respectively.
> 
> Fixes: f38ea593ad0d ("arm64: dts: mediatek: mt8186: Wire up GPU voltage/frequency scaling")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Appears to work on my magneton, I can see "Mali-G52 r1 (Panfrost)" as
the OpenGL renderer in various programs after this patch.

>  arch/arm64/boot/dts/mediatek/mt8186.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 4763ed5dc86c..d63a9defe73e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -731,7 +731,7 @@ opp-850000000 {
>  		opp-900000000-3 {
>  			opp-hz = /bits/ 64 <900000000>;
>  			opp-microvolt = <850000>;
> -			opp-supported-hw = <0x8>;
> +			opp-supported-hw = <0xcf>;
>  		};
>  
>  		opp-900000000-4 {
> @@ -743,13 +743,13 @@ opp-900000000-4 {
>  		opp-900000000-5 {
>  			opp-hz = /bits/ 64 <900000000>;
>  			opp-microvolt = <825000>;
> -			opp-supported-hw = <0x30>;
> +			opp-supported-hw = <0x20>;
>  		};
>  
>  		opp-950000000-3 {
>  			opp-hz = /bits/ 64 <950000000>;
>  			opp-microvolt = <900000>;
> -			opp-supported-hw = <0x8>;
> +			opp-supported-hw = <0xcf>;
>  		};
>  
>  		opp-950000000-4 {
> @@ -761,13 +761,13 @@ opp-950000000-4 {
>  		opp-950000000-5 {
>  			opp-hz = /bits/ 64 <950000000>;
>  			opp-microvolt = <850000>;
> -			opp-supported-hw = <0x30>;
> +			opp-supported-hw = <0x20>;
>  		};
>  
>  		opp-1000000000-3 {
>  			opp-hz = /bits/ 64 <1000000000>;
>  			opp-microvolt = <950000>;
> -			opp-supported-hw = <0x8>;
> +			opp-supported-hw = <0xcf>;
>  		};
>  
>  		opp-1000000000-4 {
> @@ -779,7 +779,7 @@ opp-1000000000-4 {
>  		opp-1000000000-5 {
>  			opp-hz = /bits/ 64 <1000000000>;
>  			opp-microvolt = <875000>;
> -			opp-supported-hw = <0x30>;
> +			opp-supported-hw = <0x20>;
>  		};
>  	};
>  



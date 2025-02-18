Return-Path: <linux-kernel+bounces-519771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D5A3A1AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342181894F02
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F74D26D5D8;
	Tue, 18 Feb 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="v5LlfeBM"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E874926A098
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893771; cv=none; b=KHHfL1oDCuWACvhblMYtSvBq6ayCTz1pkAwOjwhedRo0OLJ+DuOBClqLD/NACdcmeHciXxCcHSKddBmYf/H7s4NQ4QCDNLqttzbFKM4iV3+xtpB3BZAMH32H7Xy3IJ1e+rGgmObtp5t5lWxsS1XYHLfabr8VXohfi4EwuhLzg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893771; c=relaxed/simple;
	bh=KnYpb6bE0eyQCr84HbKFpqpurHoiaGGJGPLTOYYxz18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MO4cPMx0IYKctdaYAmXqsemUkN6r/9NKoaqivqMZ+kkA43sY+wZdnIu4O/5hTLw7FQLvg/13gz/7cug9fmEdo59be6UfBDNGNkE+X6UEG7kpEBKBjEjRmcL/+ay29grnoZ3WQhniCkLJXW2/webLsVvQyKWDtbUYmSApfiTe81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=v5LlfeBM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f29a1a93bso3665467f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1739893768; x=1740498568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5lpfrcaL2Is2w5mfT4nI0tpu6NUg+OVNgUbEulgO5s=;
        b=v5LlfeBM+1XbvFnvDOUwev5A72L5lowwCEGWlDMQrlsi17LyMPlFW5IITO+ETfxUrM
         Ns+81FZ0ndU6Q/r6wYTLxsGblbhITj75UV6122y0OuYNO+P3N0wuLVvUaDNW5N/yrgUt
         AA5dtoXdi9BMOjrW9gc9a2A6Tnmf3+O/vqFx66CepAHcruNlpe83sauTdT/yFT/kjbiu
         jcTRuxauGTKPb5O4CitP9pHBh9qlMOSMNe9x8WQbX+P7uTXrxwZOCa9oK+XnVHqFe9Mq
         OHduk5vBuINEU4groW8C7TUAZ95L1YVAHtyvzR5Cj7E/MouachcvZle/PsmUOLqCixKd
         MN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739893768; x=1740498568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5lpfrcaL2Is2w5mfT4nI0tpu6NUg+OVNgUbEulgO5s=;
        b=INjfLlhveuuiqCzzbrG608b5/kI51fPCNftsMOFrkCPcNDX8mAx50B3Ni5oVyO4+sU
         0xjTqXsZAhvtRkIAl4FeYPDfCziGt5Abbm3xMzDQfL4hxNMRWeV2+IpfE8l/GAHVjR5o
         7DDNEZah5AkwAzS0EXuZ2DhRd+/ByQ5jtMXOELHdp7dIwAN3pDwW7hAW3zO+egHezgMN
         8tAVirJ/tnnkP5Glj2CJfbjfEjmxwbVJhYPjlTAgSzlUnoPhUr8MTmqCTUu8weoPV4Kd
         urGR3AbifpHoHXh8Ivds3lRKBbtlQ08GZEBIDcbief+A14j5mYaydMrbIJO0JCWUC4Pm
         Xi2g==
X-Forwarded-Encrypted: i=1; AJvYcCWYrhRtbiLIXxiiIR11iLsnxvT1DulLxQrJZTZWDaFEPV9QZ7nl8ZWrKOOBp7zGgOh23iEtLi1kNguk56k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWGtsxM7D+vhA1tgD6B1kdmdibzuZCIlU8H1sEd8biE5JjO9S
	FgpQwraAPI+H7bsqAn5zQzbnOWWtYdmmTLhsfJu5e5x/a/SF57xOKptvasWGXkw=
X-Gm-Gg: ASbGncuqAA2F3iiOmOtYndYBYRFPH/+vR3d29ViJ6p/vAdS884iT9HCqk8WtSp9+yjg
	/HevlstKuHWPOmgx9NHEhTeV46IeGBN5CHIrEeg9DMiHymvrwXYNkEsRINS9Aelm38Npt/jF5+9
	js30ApcuQaknULeIPUezlVf8W+FEnJMBu3/5ySogrrpVxXXhb5c7PdwGnhzQei2pyVofq4LGUBd
	ooqJ+TScoRDcuUZEo/8V1AgFVTr29b3wweL9Wn0xVla9CupIBOo28AZfg0yX3pX/nsV66735+VK
	TGwERMovfMeqoW8OheR9W6GcmNSy45AaryUlYr8R1sm9RzCtZIzffM5+xk0=
X-Google-Smtp-Source: AGHT+IHzHPbfVt1Tel29A+epxPfb2KB2d12lkNDmgHGe0o8ZVjMIavmijEOcnrw/jRAI4QZkUMylUg==
X-Received: by 2002:a05:6000:1568:b0:38f:5481:1160 with SMTP id ffacd0b85a97d-38f54811294mr1777787f8f.15.1739893768059;
        Tue, 18 Feb 2025 07:49:28 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25913f5asm15548613f8f.52.2025.02.18.07.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 07:49:27 -0800 (PST)
Message-ID: <a38ad793-8660-4942-ba29-aa5f297336ea@nexus-software.ie>
Date: Tue, 18 Feb 2025 15:49:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: clock: qcom,sm8450-videocc: Add MXC
 power domain
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-1-cfe6289ea29b@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20250218-videocc-pll-multi-pd-voting-v1-1-cfe6289ea29b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/02/2025 14:26, Jagadeesh Kona wrote:
> To configure the video PLLs and enable the video GDSCs on SM8450,
> SM8475, SM8550 and SM8650 platforms, the MXC rail must be ON along
> with MMCX. Therefore, update the videocc bindings to include
> the MXC power domain on these platforms.
> 
> Fixes: 1e910b2ba0ed ("dt-bindings: clock: qcom: Add SM8450 video clock controller")
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
>   Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> index 62714fa54db82491a7a108f7f18a253d737f8d61..737efc4b46564c1e475b02873d2dc124329fb775 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> @@ -32,9 +32,11 @@ properties:
>         - description: Video AHB clock from GCC
>   
>     power-domains:
> -    maxItems: 1
>       description:
> -      MMCX power domain.
> +      Power domains required for the clock controller to operate
> +    items:
> +      - description: MMCX power domain
> +      - description: MXC power domain
>   
>     required-opps:
>       maxItems: 1
> @@ -72,7 +74,8 @@ examples:
>         reg = <0x0aaf0000 0x10000>;
>         clocks = <&rpmhcc RPMH_CXO_CLK>,
>                  <&gcc GCC_VIDEO_AHB_CLK>;
> -      power-domains = <&rpmhpd RPMHPD_MMCX>;
> +      power-domains = <&rpmhpd RPMHPD_MMCX>,
> +                      <&rpmhpd RPMHPD_MXC>;
>         required-opps = <&rpmhpd_opp_low_svs>;
>         #clock-cells = <1>;
>         #reset-cells = <1>;
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


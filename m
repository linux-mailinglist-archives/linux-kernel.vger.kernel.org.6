Return-Path: <linux-kernel+bounces-308493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A569A965DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6385B28769C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0C170A30;
	Fri, 30 Aug 2024 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHwsvixE"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107715FA92
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011972; cv=none; b=irT+EWg67wvSCPceiXe7QIGZX5JQqUyySWA8FL0C/UpS9w7Dy0H3/h+px7G2EjBhi6Q6pusO2yvw2JLWu7FWQiol8LgJiwy5rLumaZxwv64XoUjy3Sd1slsw1/WwoxhZPI6V0APGYMxl5a23N85nx/9HCYrcf1XXpz4Sx6xKym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011972; c=relaxed/simple;
	bh=eZJ60bYB9XfBbv97tdApJ/91VcLhKNNaro4hUfGAKtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3gWpvWlcjK6fietA8sV1YnhnJ9czAeH6DPbrLjRYyee7TpWDQLuUAgMEa7jXZZ9jwKnOUvAKFWhFX3CyH/jU+0xEB4R2qAX06+bBi+kMa/FN+o55F34VCO6eYqMkRfxwHE1nbI+HsjFNF14GCZ4npbX7VjLotvQ3ZnVW2cWM28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pHwsvixE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bbe908380so1734235e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725011969; x=1725616769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFRjgJLup1MnUFrYzfu39ZRhA8FvaRP/4WA8tKvuOks=;
        b=pHwsvixE0ciqzsGxeCWdeMTLiVsPOt3Rxxg3vHBHKCZnV53q38pmcHBkbC2+F+MV/R
         n7o9Rki0C50RH4mnG0RFhipHYC8Hvm+SwUz2atusAi3tcQD+u+OAUjVlb6M7IZYaASGS
         RJmbkP9rn2S9o6DVjPMg2nt2PODjT+KwSogrNXJMNwVUlUn1KGUavOvQYYwyt5szs5rw
         lFXjOplD7kY4PvuuoaYLTlyGgx3kIoHUgIMYjFOOe3B3E4Z0le8ZXwg28SCyXdSaw0df
         nZjLDzX1QtZXobVZJpHjjljBAv4Te7L34OJS7tpoAfBM+xXrOqbqBhC9XjIU1hVKUACf
         fMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725011969; x=1725616769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFRjgJLup1MnUFrYzfu39ZRhA8FvaRP/4WA8tKvuOks=;
        b=gGWBYG4zp+Osq4P8JGhOpVDHfqfwO72ByACb3u68gmKg3J1/7njJdTR9T5npZ3Rocu
         9thxTwn9W0nF5COGhxq3M0Ut9eKsUI9lgRCk6MpXSiWcMPJW75knshj79sW6wLrnrthJ
         rGkR50/aAreNau7X9PmwLf6h0SdaXI9phiN5FEEGO3N652WcnylxTJ4hkvI+FQYD497F
         g0Iw6ldfSykEAefFkmSCSaMASpIaE1vjoNzPe3Ve936r4cz8JEPEyra9OT9puxvhozSq
         FE9yWlJHIOalKLCsLfgPfRJFJefswFQRu43BEflw++kScJrCX3fvWIYlWgr0D02UVQZr
         C0xw==
X-Forwarded-Encrypted: i=1; AJvYcCWEmRYoACseTAWZhu1JkxA27HmW2DQOfaHw3eDXvvuyMMnJBROgcjuGcMRdgsbSQoMsc/sM1L016RiQmwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPq122y4b2aNYhNYkjOnWkx8tLMBFCQ/Vvwo9Sz8Ku7RUZmLpj
	NU8gkRH/XB30NnCTrnWutx4pp2/Mz3BkyR31Ufu8oR7mZQVcaORCmdo2vJvk3Ayi75PefCA6XS9
	8
X-Google-Smtp-Source: AGHT+IEnFTaPLGbW9YtYqHCcQQDVJbUsxG1P0RaZiuimZTPDfuGtZT6aUIXSTDQ9CZrfRQ0Ie1PejQ==
X-Received: by 2002:a5d:4e83:0:b0:371:7c71:9ab2 with SMTP id ffacd0b85a97d-3749b5874c3mr3779369f8f.52.1725011969020;
        Fri, 30 Aug 2024 02:59:29 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef7e94bsm3531661f8f.85.2024.08.30.02.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 02:59:28 -0700 (PDT)
Message-ID: <c399748e-05ca-45df-9e40-2d38b132f97a@linaro.org>
Date: Fri, 30 Aug 2024 10:59:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] arm64: dts: qcom: sc7280.dtsi: Fix PMU nodes for Cortex
 A55 and A78
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@mainlining.org
References: <20240818192905.120477-1-danila@jiaxyga.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240818192905.120477-1-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/08/2024 20:29, Danila Tikhonov wrote:
> The SC7280, SM7325, and QCM6490 platforms feature an 8-core setup
> consisting of:
> - 1x Kryo 670 Prime (Cortex-A78) / Kryo 670 Gold Plus (Cortex-A78)
> - 3x Kryo 670 Gold (Cortex-A78)
> - 4x Kryo 670 Silver (Cortex-A55)
> (The CPU cores in the SC7280 are simply called Kryo, but are
> nevertheless based on the same Cortex A78 and A55).
> 
> Use the correct compatibility.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 91cc5e74d8f5..ab024a3c3653 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -845,8 +845,13 @@ wlan_smp2p_in: wlan-wpss-to-ap {
>   		};
>   	};
>   
> -	pmu {
> -		compatible = "arm,armv8-pmuv3";
> +	pmu-a55 {
> +		compatible = "arm,cortex-a55-pmu";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	pmu-a78 {
> +		compatible = "arm,cortex-a78-pmu";
>   		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   

-- 
// Caleb (they/them)


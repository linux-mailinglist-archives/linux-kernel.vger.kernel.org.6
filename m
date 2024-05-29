Return-Path: <linux-kernel+bounces-194266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323CC8D3925
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52621F241DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999081581FC;
	Wed, 29 May 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgcWFLIf"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3249A1581F4
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992809; cv=none; b=RUzDOwOBMtdIHHhhQbeSDnGjRStICbu+n2RQFU2joOUsXl4j0Jxc6ZNaajRMb8t5HgBw3D1O9BFDO3J3OTne3SYBf3wsk31iEfea5NNcy+ZlgLu7wOEib826WxDJ5/XeF4SXec9RWWLPWuBxUfRJQrIB9yQ6fYcq9Ql8jLg6JMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992809; c=relaxed/simple;
	bh=HwJzftLA1+dQNuWJ93GUEzlbuhARUmppvfMGRyd+Pgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsPtUoljmhkS6W+eZX0aED0LeEOvCGkSH5SOYdkHxWIDEYKLUnn1rysNKKjbyZ4zwJ2/97z7FKwX8ldFRhhK7yvJ9pnNUhYl+gKuBs8TQK0fXzOBebDA9/de1Qbbt5EGH8SOpL5Is+t6VVVRrc8kNBRTI3mdnKSg7npC4oJTook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IgcWFLIf; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6266ffdba8so216713466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716992806; x=1717597606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t9und5k3EPAWeDAxO2liROy1Lyi+UxLY0JPYPD1aV7w=;
        b=IgcWFLIfsVZVC0+1kW4MrwMJW3vkgE/Bfuvyb4PF5vvzfILWc+seYxxssROaCW1bvU
         0kp7+JsuhYWItd5+AVY39P+u55DO+j+xF8uIL9PRBdiDFEfuwvSeyQZlhpWuGZlLWJId
         UyjPLD+O8GuLGdfqJ8E5qg5hIN0GqTY5kSG1e1orf6EoOIbkWM2mRC+Zs7Dmd/IXk1fF
         Gp9betvTo+lYYrOn+RYNcoUlKTi+ZwUi044QmUaB8I8HyvZq9mS/goLBiTEVkXfGGJ7g
         m7P3i8culHT5wRtWzQRDmZQZ+Sl20+v8OirUQO53ODOlAIAM8ZTLYW/db45OR9XmpeGh
         KSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716992806; x=1717597606;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9und5k3EPAWeDAxO2liROy1Lyi+UxLY0JPYPD1aV7w=;
        b=UEoyLzwcQ9KlX7UaZR/+wLjzykP7quQ0whWjflc+UXyQXxGXV5x7h0k3pjk0TG20Ar
         1az7kXnijMJtyMLKFHGpFh6BvkF5zWKhbnQDNpmuf8tu8fUydPqj6J8tqVdAKQmbW9MU
         hAWhRdHOHz54llfH/zAlJbR1YvJe95GZ5XTBApEHuyH1GI6rQsmoMXfk4p/BUTttZFEo
         lastk3GaeYmU+yllmDHw+SbBH2MemD40GMyBNBtT42QqqZLwsX1Vy5RP030yLkgX2t/9
         Bjoet7MQZpU/Scg1dUSfWqH3r95vqRCGcEt+b2YLQcZ6tDhDZh5WjyjTcIuzh6pq1uPE
         fKrg==
X-Forwarded-Encrypted: i=1; AJvYcCVx8NYbyNOH02Th3NNjeZt+twfJUkk827FHOTdi2PkaqTqcuFGpu/tM7Qax+/K831yWYQp5I2nxKY+6pnTa4FqHT5HZuarxqZZLPKqo
X-Gm-Message-State: AOJu0YyThvV34ZDdvXwdqNBAUF3NLklwBz58IEAQTKADEk89AD5vlmdl
	0G7y3awgf8b7eAczpMX42RCtOjCm5gTbPjhTjZUpc5TgAJSg+jaWtYVz1pAFkyQ=
X-Google-Smtp-Source: AGHT+IEJXSMs8i/ULaVvIYuF1LRfLKLZCFaSajGTqXU0ezQ+aYm+2catGB5oyDuks5MOauz4ino/XQ==
X-Received: by 2002:a17:906:874c:b0:a59:c3e2:712f with SMTP id a640c23a62f3a-a6264192ff3mr1071760566b.9.1716992806572;
        Wed, 29 May 2024 07:26:46 -0700 (PDT)
Received: from [192.168.128.35] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4f56asm719071966b.115.2024.05.29.07.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 07:26:46 -0700 (PDT)
Message-ID: <8f3f1e88-426d-4254-a31c-afcb88fc08f3@linaro.org>
Date: Wed, 29 May 2024 16:26:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/15] arm64: dts: qcom: sa8775p: add a dedicated
 memory carveout for TZ
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Elliot Berman <quic_eberman@quicinc.com>,
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@quicinc.com
References: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
 <20240527-shm-bridge-v10-15-ce7afaa58d3a@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240527-shm-bridge-v10-15-ce7afaa58d3a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.05.2024 2:55 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a 20MB reserved memory region for use by SCM calls.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 31de73594839..c183527452d7 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -208,6 +208,7 @@ core3 {
>  	firmware {
>  		scm {
>  			compatible = "qcom,scm-sa8775p", "qcom,scm";
> +			memory-region = <&tz_ffi_mem>;
>  		};
>  	};
>  
> @@ -418,6 +419,12 @@ cdt_data_backup_mem: cdt-data-backup@91ba0000 {
>  			no-map;
>  		};
>  
> +		tz_ffi_mem: tz-ffi@91c00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x91c00000 0x0 0x1400000>;

How does that size relate to 

+	pool_config.max_size = SZ_256K;

in patch 3?

Konrad


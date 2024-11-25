Return-Path: <linux-kernel+bounces-420602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E819D7D17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F192028273B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EE418C039;
	Mon, 25 Nov 2024 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga6xIN0p"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798AC18B47C;
	Mon, 25 Nov 2024 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524215; cv=none; b=amSve0Gc2jZNG1v1hqPPdciLAcQ6GGxVMEhHKcM38Ia8KSvZrzJ7LsJI67d5UZn5Pylh2/1JPa/kWmGb7rfAmPSmm2fNLjFNlY90QAIHD/ewUIlr+xBsuRoIwv2w31o4IioKJXdO1hqkFv7wjiD1Akrl8vYQuhGLp9r57yn2UM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524215; c=relaxed/simple;
	bh=AsbyBTK9GRr6ucLVmXwxS+szhGmlI1Yq48V5IFbo/Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuXs+ByYpyEfmz8I3qEy+E+ZyC3VQFWMDbsk9MYH81TS8ZbQ5R8HSHqBmhGD+dQvVxx9bPrZa0s/yDvYLISsLi6yTfsquR0NdEN0+gsHnD0kSjdpj8m9j/aRPcIbrIpuMDUhQf52y3B9ou6IsYZEgRGwT5/5VmixjakEgzRKri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga6xIN0p; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7eae96e6624so3256726a12.2;
        Mon, 25 Nov 2024 00:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732524214; x=1733129014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pI8BQQ/T5SVzIWF61zZavJ6P7DIvRK0aGvjhr4khLmI=;
        b=Ga6xIN0pZuskKgCpajQ8gL+WZRsmWkB1w7GGPTrsTGndIgRoEQ1p1UTMhLjAaQexnv
         C5ceka8oEuR7REU+GipXwduZc2vSa6Hmf74Jgh0GK8x/PQRKJM+QaMLi1K2dQBeZRr8N
         A+77Rf9JNEVCkel8fmVfnGj3u6z5iVXslVVxFUObNjm2Y09yqgD9ySDFHfBqeqAuDmrZ
         +BXY5Wz2PDxbYJB/dEiFfJUy6cnJMneKhWywZA/laFFLvMBhmbjumqYL2X9EId0i1Dfr
         ba1+ZaoILwxtQ6cv1YVXb0kxVQ6RcqN/Dx/b4lNvXBPzAuxEzuU7u0No5L/ZFM4OrAx4
         YesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732524214; x=1733129014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pI8BQQ/T5SVzIWF61zZavJ6P7DIvRK0aGvjhr4khLmI=;
        b=FJ7J4Ab1y0LLgNMBAwHzn6hAt4fevdmEOVvu/Bb6jSq1Wi1F1ofSJMCHnpJ5M3+uOS
         vSgUnAKnpA8hbrROb1LgRAVgCKyZrJ9EnprhFUqoaJ5T5UrGUpBptM3EsIpQyo4vrNL9
         lL2qJcQn6KrGVPJw4LK/9ckQKP/tgiFZL4JqW2EnF4ZERvRVYbup+k25u/Bd939/4PEu
         UI+6NxbyhRqMUyKEM0pjMwbV/blzYW5VGWCVKsMM3DUCIyTDdU0MZVYD6lQArBMZJ/BK
         j7x5IYuqeJXMSdCIjqz36OQ6lHhs72kCaGbvWfuMgNLJBRh2lgyTmqlamXDugGPETggN
         mZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVbSJDfV8j3EskkCF8axbmmmD/uqwXEtBnqHNwWVynCncGak38wHcmRQCvxAUdE4nhvhLyhCqTrcuZ6b8b@vger.kernel.org, AJvYcCX/ZW+Gza6z0CoPleABuDzfxoH0sWQBAhaeEnlcIkxOLbbaiw4PPg1TTUyjUArdD++UEFuTDRroFVg9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0a1KlftjtXHqEejW+Wq+Of5DhmpXnyvBbmTvgJQDtQzurghv/
	WI5PA2UBvK3RQnyBKgPLqe5yEIyy5ay2PMR76DgI1Ku7asbp8WOM
X-Gm-Gg: ASbGncvuF6ciffuTZAAbdLzVTqJNpwEmfjnb8c/J5zLCVCxErkiBkvanoi02ThBma/A
	RuyJg/8AYJOmbsQcGYkjdQ4Bxv/pSwV8usyuA04hBW04t2HzYE62B1g7/AXv0JJeuUOvjkN5E52
	bhiCZMovn5ZqNFfljorvxAB3oHFnjO/76+TCRdK/wVUkJZsAP0kLb1aGh26J2pO0TjTPhlcSbMO
	BpgmmPIr2EVLTjGBOHjMFtd1dSkHOgK8I0kiLcDA8qMZjSWAOYEKAEq4yOwhu9o4s4G
X-Google-Smtp-Source: AGHT+IGhgxcXQ0ft9/Za4vorVCq/dkomo2GMsbGwiP5RlHt6aZtAoqt6aKppLpP3grbtnbLAwPJzMA==
X-Received: by 2002:a05:6a21:7881:b0:1e0:c92a:c838 with SMTP id adf61e73a8af0-1e0c92ac9e8mr5471906637.35.1732524213648;
        Mon, 25 Nov 2024 00:43:33 -0800 (PST)
Received: from [192.168.0.115] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db9fdd5sm59524145ad.58.2024.11.25.00.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 00:43:33 -0800 (PST)
Message-ID: <4a3c832b-0c8d-4487-b1bc-122450a57516@gmail.com>
Date: Mon, 25 Nov 2024 16:43:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: apple: Add touchbar screen nodes
To: fnkl.kernel@gmail.com, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Janne Grunau <j@jannau.net>
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-4-3191d8e6e49a@gmail.com>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20241124-adpdrm-v1-4-3191d8e6e49a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Sasha Finkelstein via B4 Relay 於 2024/11/25 早上6:29 寫道:

[...]
> diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
> index 1666e6ab250bc0be9b8318e3c8fc903ccd3f3760..726b11376692580abb129b9be35107bee1550a93 100644
> --- a/arch/arm64/boot/dts/apple/t8112.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8112.dtsi
> @@ -379,6 +379,31 @@ cpufreq_p: cpufreq@211e20000 {
>  			#performance-domain-cells = <0>;
>  		};
>  
> +		display_dfr: display-pipe@228200000 {
> +			compatible = "apple,t8112-display-pipe", "apple,h7-display-pipe";
> +			reg-names = "be", "fe", "mipi";
> +			reg = <0x2 0x28200000 0x0 0xc000>,
> +				<0x2 0x28400000 0x0 0x4000>,
> +				<0x2 0x28600000 0x0 0x100000>;
> +			power-domains = <&ps_dispdfr_fe>, <&ps_dispdfr_be>, <&ps_mipi_dsi>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 614 IRQ_TYPE_LEVEL_HIGH>,
> +				<AIC_IRQ 618 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "be", "fe";
> +			status = "disabled";

Forgot to add, status should go after other properties here as well.
> +			iommus = <&displaydfr_dart 0>;
> +		};
[...]

Nick Chan


Return-Path: <linux-kernel+bounces-219473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CFE90D310
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7451C2457D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0FA15DBA7;
	Tue, 18 Jun 2024 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrATvGNT"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA22154C02
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717568; cv=none; b=VH9Undjhdos315qK2D4Sgw5rOiFDmpb0W/VOd0+EmbOEBNtFjWk48hp/RwwXMm8ApRS/KaLfNsw4hGqRaA5Gjmb9/VLSSOdKqXfXOvOq8Hyoy0fVeLXiDUsy3OCTBO+RRqTZTC5v+zBIZIL36j8QCwxI/vljzGoW+sfz4mFts6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717568; c=relaxed/simple;
	bh=GgzUktl0D9SwGZEeIDX+GZpiHGkGUQjZHSqKbu5zMQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ey8paGmxD6cGKDfGptHQltChfeVeDfXoNlRERveRzZOMK/g1tShGmqWFWDbyPlBjgpMaFm1mrwAdiUnQVDdusVqDp1FeL5Bg16q3n9kqgIW+/PM8dSYAHL/fU1miMEMpOsThP9W6BiuCTY4iaIlIYRB3DztEvjf5jM5myjc/5fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lrATvGNT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cc10b5978so1660428e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718717565; x=1719322365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ez+ZYdZ4IhLN/85Rh7VlX4Z1ctdZ87K4zP66/HgVbow=;
        b=lrATvGNTfb3AKMeZ6GDh4FIr9HLQ+sQLwBneZ+0q046YuhN0qi7YfCqOvWI/aVKv9u
         H5QkbixvqREmqRZJD7veJv5f6pix9eKiuDoo3syJM9yphx0gNWOs/S418FJwqbksS3G6
         E+zm+mJpuhxv6V8h/rASD6UGoTReaCpPQaIixdatJ1kCplWVPk4jb+9WCYT4eNpl2296
         7fGigkeQE1uXyFocdelDfRIpJxMt3Yxs91qKPGkEb1KXzBevXhQWpalKw0sl7LZqT9Ds
         KCrKFBP4kro+kADUtejSRlX1Bg0eWdznATrAnDsD3GIO8kQ/X0lwOyYHyaTeBrSLnt7b
         2PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717565; x=1719322365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ez+ZYdZ4IhLN/85Rh7VlX4Z1ctdZ87K4zP66/HgVbow=;
        b=cUHETyPydFgYjA/XoW5xWypjQq9dNBsTGk0p54JM3y+bYs4h71rbSATDuwghn2/+zd
         6OgWjahAQaVv0MbT9hUTSxYmDXvaj9XoD6r4tjFENW2tI3Uoj0Vj255JV62gIhZL2lVd
         5GaX66crIB7qxKghkgprc8vhs+o2gU+pYXG9NZyIwwGAATvMUy4tRwbADEiJpgyDQZsC
         sbHj9V1XTmCFtnE2wnTvFJ2pXbABLV+B5VUO28BlZDu81JfQy5iJx/LXUazA4aQ/ujca
         SfZmCSLO3vYgZW1uzhlY8dG00g+7zqk3BMYQ7Ac6+wjTToHk15Am/PeIr4YotumUtWSi
         /96g==
X-Forwarded-Encrypted: i=1; AJvYcCXNFtju1LEwhyJMKg88xWXyXg/LOgkregx5LmZxCQxndmOvndVgbcBH3Hvnr2CJCo0K+5+gzgMUNsVMvcaR23rnBI2CQv/TnCRhK/k5
X-Gm-Message-State: AOJu0Yz5Nql2/04YzHrZTm6+oMZdjaeXQrtAoAJaxmCfJm82byZiAgbH
	8n854Coqw4tiVqQI8k+RicrQPyyIveGNaa+bt20gxPGr8q8i2JjzYoq9SHENRq2PnxVxrabvwyc
	lg+E=
X-Google-Smtp-Source: AGHT+IFd8vm/A2hU7dX3aYosPwqK6rV2k2IpMC6TsKDAceEBhHhRIb3K8WkyukwOO/rCj6gYmrYeTA==
X-Received: by 2002:ac2:443c:0:b0:52c:9906:fa33 with SMTP id 2adb3069b0e04-52ca6e92f06mr8544246e87.43.1718717563886;
        Tue, 18 Jun 2024 06:32:43 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282f3b6sm1503387e87.117.2024.06.18.06.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:32:43 -0700 (PDT)
Message-ID: <b53d7f5d-c619-4620-8a69-24e71d5d19ba@linaro.org>
Date: Tue, 18 Jun 2024 15:32:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8992-lg-h815: Initial support
 for LG G4 (H815)
To: Alexander Reimelt <alexander.reimelt@posteo.de>, andersson@kernel.org,
 petr.vorel@gmail.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240403104415.30636-1-alexander.reimelt@posteo.de>
 <20240530135922.23326-1-alexander.reimelt@posteo.de>
 <20240530135922.23326-3-alexander.reimelt@posteo.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240530135922.23326-3-alexander.reimelt@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/30/24 15:57, Alexander Reimelt wrote:
> To make it easier for downstream projects and avoid duplication of work.
> Makes the device bootable and enables all buttons, hall sensor, eMMC and SD-Card.
> 
> Signed-off-by: Alexander Reimelt <alexander.reimelt@posteo.de>
> ---

[...]

> +	chosen {};

There's already one in msm8994.dtsi

> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		spin-table@6000000 {
> +			reg = <0 0x6000000 0 0x1000>;

Please pad the non-zero size part to 8 hex digits and use 0x0 instead
of 0 consistently

> +			no-map;
> +		};
> +
> +		ramoops@ff00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xff00000 0x0 0x100000>;
> +			console-size = <0x20000>;
> +			pmsg-size = <0x20000>;
> +			record-size = <0x10000>;
> +			ecc-size = <0x10>;
> +		};
> +
> +		cont_splash_mem: fb@3400000 {
> +			compatible = "framebuffer";

Doesn't seem like a documented compatible, you're probably looking for
"simple-framebuffer", see:

Documentation/devicetree/bindings/display/simple-framebuffer.yaml


The rest looks OK!

Konrad


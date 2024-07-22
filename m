Return-Path: <linux-kernel+bounces-258879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1349938DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EED928198E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DBE16C87A;
	Mon, 22 Jul 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WjYqf9zQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B35338D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645215; cv=none; b=ejZYFn58Yth4Z+X5Sw1dlT+IRG55woyo8fFeEiz88Ru4ZWJ9jvPek4yqXaj0FC55fpZwgjh2QNz3vm3siwCQDFHmSRbHSWKgbnseSZT5z2ugzM2wW16umxvY8BtbehANX+uta4GIyti/zTdKSaSRWllTS2aVg0vmt/FXGD2mk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645215; c=relaxed/simple;
	bh=r+jqmXvvmaex8/uEkN1osu3gYZAAVsAJT99/JnDhrUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBjvTkuMtftNQa0KwcNuGx/5HWvFb+0cuhqS57hWWR3ZGgkHcRqiW6AEQXunQ+G7xt2dgyAHVhyYuydkGgarr5qnlBEQROHkoUvHS12kuuEOEqmKJnaq/L6t8wasmtSFL3mBj19m3+INC3hhvdjj+yW/Y0CYxnl3aKxdcYd5cXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WjYqf9zQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so3323654a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721645212; x=1722250012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vwn7v6qPzsQ+W/oRt1+H5zX/vSu+roSyUBFZnaxVsk4=;
        b=WjYqf9zQDHNUQ0SZ+vcYLOYEB/ThDWqeFhmvgCcVZ6UCiPQcgFO43KYFXDAV6Vq8aQ
         /HJ0h2KDs2YL549aLdT3oqVH/jBzckui/OfUlNVifPZYk9BhR7CKFEPJr/OTElpPz4el
         NHs5QleCyK5QDH2ykIlgbxPWXaDeUup3Oj7wIWBF5krvUTrFYLfM8bRwys83XXE0XF3D
         mfp8UjACNpz71dOrLWsUpIJqIJBjpy7ZkoevNtI2YUz5kbazAEyk86Dmhh5a/QnRygno
         UltOqIuvL62V4hoIazkPm3Zfbr2dBn8wKo2NJ15qC1do/Ycr8wffwb39VF+ZmQFL2pzm
         78+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721645212; x=1722250012;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vwn7v6qPzsQ+W/oRt1+H5zX/vSu+roSyUBFZnaxVsk4=;
        b=pNE24S7mvEUEVrShtc1ERqTcIHIQIUy9T7KZAoIK8AzGLSRbbEQr8GKAljoh/CJHpA
         7OstiEUr9L6PGzZgReqc3aRnxx/JQTDMtQ6+00sfJ1fpMvQ74JD5AiqSCYBnG3uba8ei
         /SUCeXVM0Ynn66ULxlnAEdgpM4DiWvi18yEqLUHUDU34ceozrfN7fN+MlIc06/0lhXxg
         RJut6xdn4HRHQbQlMItze0os4r2YVmdFUOC5DMd5W9Xd8S3zD8NHG/gjF64OKZ9HYGIV
         ckgsg4PZPT6LQYYbsue5We2yTencgsYMMjcK6rCPUja1qsxfpd+FaNkzRZskN7ShgrA3
         suzA==
X-Forwarded-Encrypted: i=1; AJvYcCXRjWujD+ydwW9u5spAHbg6UvtTcCvDGb8+siGS2r2NrR+gxCuYWM+AbaswREmgkpeNCG97k6jtrXVjYzt+r8+yvxv7Kpd8OgZyeCLk
X-Gm-Message-State: AOJu0Ywx5KdhsNpI2p08R1dDyYugbZS8ndTD2lI3W0Ri2CzzPJFRD/vR
	gtEqyUzp+4YlP1BA7SE1uUNer7P3OpL6E0t9c93OSOu6bGvDPmH7scWq4pwmAAo=
X-Google-Smtp-Source: AGHT+IGYOyBTZzFHbDoRENbqf+GlRPBuTlQulZNSAcPldU/CItxchsXzjf+phgEu61UFbL2BEyH4yA==
X-Received: by 2002:a05:6402:34c9:b0:5a1:b42f:c93 with SMTP id 4fb4d7f45d1cf-5a478b78e72mr5365701a12.13.1721645211406;
        Mon, 22 Jul 2024 03:46:51 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa31e0sm5915655a12.27.2024.07.22.03.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 03:46:50 -0700 (PDT)
Message-ID: <d92aa01c-eb13-4cfa-864e-3d39ba207ea1@linaro.org>
Date: Mon, 22 Jul 2024 12:46:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] arm64: dts: qcom: sm6115-pro1x: Hook up USB3 SS
To: Dang Huynh <danct12@riseup.net>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240722-qx1050-feature-expansion-v1-0-c4d486435b96@riseup.net>
 <20240722-qx1050-feature-expansion-v1-7-c4d486435b96@riseup.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722-qx1050-feature-expansion-v1-7-c4d486435b96@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 9:10 AM, Dang Huynh wrote:
> The F(x)tec Pro1X supports USB 3.0 through it's USB-C port.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---


Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


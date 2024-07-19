Return-Path: <linux-kernel+bounces-256812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE929370BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0CB1C21DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B698A146590;
	Thu, 18 Jul 2024 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wG+smpkL"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525AB145A18
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342177; cv=none; b=IvJn4tG0yX7d9GvP8V+RBmUDlrFf/ajM4Q+1PkrvlW0aw0OmC0xz6PpUf/sd3p4+lYZcc8WOG2KKLPQEWe30ArS+xvtqZ32hOx3+SzVelX+KAbsKJ875lQhep2Q6MebQYzCXfRQxY+IJX5MMm9niO/MpLEEIv/3wBjQZU47NKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342177; c=relaxed/simple;
	bh=kZpRT5dYzNCoiJuGGlU53Km8rTgRF3YX07uU72ozLiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkApCytW8kLUlUA2lnQ0jgk6czE2FrVOyPhi7845HuAl+Z9Ps6rieO1wHh4JnSFSNtIdRGqJnuy5U4w0jeFL+Ts4xDbPb2Uyo2c7eyUiDbbLKRjSKOOWj/BsV1ag76H90VUj4m8E4I1D298XlN8F2sD5f/V4J5IMFCRoHwKfooM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wG+smpkL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ed741fe46so1282711e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721342173; x=1721946973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FgUOD+mkX9M13phdvi/0/4J0LT+n4qFD9yiMYmn0Hm8=;
        b=wG+smpkLE899xWomqtpd1vMxswEiV3h/DWmiyTkcl+YPuoBTUVVUY7NHQX0yOHnMNr
         1ugClcceJ5slkz0SL57guhsqAAeVzGOrFB6x2LDjFkZvdD/YUe4Xl2wfrRI3q7hAYcCF
         9GSRSlYAfzhPVNk2RE4TpvBGcKoCdIBnyBjlnIAGguCLLy1750bvcx27yyHJq5fEQ1qr
         FJBAEN48v925CZgwJJP9O7BhVEpKyb8xaz9y9/ZW3ZDWvZTJQRpNcROAdtb7YFWb9Z+S
         7pT2VBWSFR+CDyQTOwVqeWJ9ho3PRbjqsyCIzHJv6XeXPr2s38JMEfi/CgSu3MO5EA5c
         Vmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721342173; x=1721946973;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgUOD+mkX9M13phdvi/0/4J0LT+n4qFD9yiMYmn0Hm8=;
        b=AAjOMQVbFE7HNeeq9bdutxLvAKG6iw73R/8RkR9DMyOp2rfUTdZDvnmQqsBZFryfgJ
         oxAoLrYCxwa6LUm7KOXMT83PRDD6JndcJqTatUHL4mY8h3PpY3FcbcHpL9zm3np4EGFW
         eFQd2QXKYQHM7QbBsVJZDgj6FpCkfFQzCTnjqmmWHB/E+kI53OEKIXVi2zD/r5AVed/I
         lQu6q68p21GeRO1NPwJRBUbCjorCiF+hA2TAswbgoo1mqyKuNaDOQ0oviqXUMs48d733
         Lj3Bt0T5ckC8q+/sSdbIqBoKsCnFZrAb75cCY7lIrbVe1vqfMooEJUEjznEf/hicppIP
         I6NA==
X-Forwarded-Encrypted: i=1; AJvYcCVpGWlcKtS6v4FHpNBsyAJl5gdLvoXler18MZHIqxjYbPl3kLjQgi0/f1ekJQ7oBwqK/9HmbFYPlQyvlRbgEPlr1PPcatf0WuwDzONz
X-Gm-Message-State: AOJu0YzAgYw3AO+WhnBMh68GKusZC6d3GKn+7iPZqbl/mFJX5JeqaS6S
	jKQ4wbNujA8EvR2neAO25uS/uc/a5lqaElW05rcKYd+ReCWU38Y35ocMoWuOcug=
X-Google-Smtp-Source: AGHT+IFCe8gu5OpEkQ3T0sn6pr7BaMQvODrWJt+x4GEemFhaUUCxmskdWU6iYE6Qhr4L2sG/7NZtzA==
X-Received: by 2002:a05:6512:3f16:b0:52c:d750:bd19 with SMTP id 2adb3069b0e04-52ee53ad97dmr4758748e87.8.1721342173128;
        Thu, 18 Jul 2024 15:36:13 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a33a82ce6sm10569366b.36.2024.07.18.15.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 15:36:12 -0700 (PDT)
Message-ID: <3fc1bccb-39df-46c8-80ea-75c7019c7da9@linaro.org>
Date: Fri, 19 Jul 2024 00:36:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: x1e80100-yoga: Update panel
 bindings
To: Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: Doug Anderson <dianders@chromium.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>, Rob Clark <robdclark@chromium.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240718184434.6307-1-robdclark@gmail.com>
 <20240718184434.6307-3-robdclark@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240718184434.6307-3-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.07.2024 8:44 PM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Use the correct panel compatible, and wire up enable-gpio.  It is wired
> up in the same way as the x1e80100-crd.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


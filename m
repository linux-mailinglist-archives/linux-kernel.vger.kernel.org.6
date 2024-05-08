Return-Path: <linux-kernel+bounces-173646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7D68C035B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF349288737
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E4112C497;
	Wed,  8 May 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="jUZZrhyX"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0FA12C814
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190025; cv=none; b=tN9adtK6ywl2n6E5CPJZyapH8KhH2LJeqkZiPrtbgvaZgiHy23QL8oZojbQWeAYyTbtvpwRHKvEIYenUgM7FMA7s5Gg+1uWUCaI3oWlBHWTOMS02wouTJquhOPNnz9wPWb9F7mN/Z5FRlZRqBn7Jac3s9HKOdtBTrYnocxtJFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190025; c=relaxed/simple;
	bh=PAtHcuLWJy86JWpb/htscGlek6QGvbVBsvumhD+83Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMxOUnTYzEZ2fC4VSZxeopQsLk9lGEcBW7W468hcryKQCnmCbLCj2YrupRinR0I2k9czMM4F7Zh1Ebc8jcWg9ehCfHkwhPvyQB4TjOmdb5ytfNyk4p/qWN8yfSsZaWuHTZS4M+BWnP5Mf8ENtAYWD2tLtJGIVZzDpvx0Z2Y1S8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=jUZZrhyX; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e0a34b2899so191281fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1715190017; x=1715794817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDHB0XN+Y2IFS9zyHNN2RE1AMhbCwDzKPIZtzDgQlN8=;
        b=jUZZrhyXaIIck2Y55KGbl/qeeKGH6KpT4z20mwWPg8w99XX72EQJVkIvatMiGE+Ip2
         guriMNisi76n28x4ZzQ+DD3AmmLqR/EvZSLZv4GlawPTWWKhIPZKMLv274AkKtMQDfKH
         0KcGKQgRQhxzWIbOAD1mmheDV+u4j30lIVolA+gWvFvUpvh2s5SNVYJkJ25BJ8sXMwZ9
         wfQkGneanEamXeYg4R1Ocv8rsh/Dw86ZL14IAiHp3+orBI/bYq4r0StaAHTuGQB5JpyV
         GGfyNo1uo+epz3sTqpS1dGUZ3aM5BuYns4/Bm+2S1jyUbh8iy34YIUPjNmtjq7nJafhG
         xpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190017; x=1715794817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDHB0XN+Y2IFS9zyHNN2RE1AMhbCwDzKPIZtzDgQlN8=;
        b=Y3QISt5iCfDygOmceEIjV1fbjGEMIfoW+THqI88oSzelUeksopjpPiGbdX/obS/rJ3
         e/GUUdf6DvDiO80j8CWZLgCahTcFThSC9ALbvKbjRcmL6xP0N3Yl5g5HqYeYgqlvbi9y
         0yUMozVnL9AIwqTAytEghoHmt4pCVnOfeeu3bVMDkGGa8EkYmzupDxUDdbDnUojNYENf
         T0wBKzBskNDi8MGgCDeoITh5gKZjoJF3cIhvi8oaXHRn+uUhUdxlpfQj2YM5/0hSQ7u3
         6np5DzlKFLcpJMIsC8p2O2k9xyCWIeAeESy4BHIuJ6OBgJUgFmdQHTsMI6JTRRKj6LDM
         njvg==
X-Forwarded-Encrypted: i=1; AJvYcCWF/VBIzbMGKmXZtKb4oEO5i7CDagLcT301wZFTydUybxkrkNrV97cZKoHec6N+CchokdNaZDZqSlbPfl6UXsg3z5NYeQzfe2KuCpiX
X-Gm-Message-State: AOJu0Yxy2hEa+Oc3SuJa8CQ70/HuTU45+0aCdeBI7iPk3YuW+0R/AhfP
	iV047VezFpJPsp1ktb+gWEfbPJ/KmXGfLzmauFpk7Kbh8YWvlJJxTh7NVOT4iiY=
X-Google-Smtp-Source: AGHT+IE1huGCa+hWAL6JQGpNAWWgrA48A0xE0DblIHPDov5vdErQyvN6CCDw4Mf1ybyiLOLq9pY/7Q==
X-Received: by 2002:a2e:7316:0:b0:2d9:fb60:9afa with SMTP id 38308e7fff4ca-2e44769763dmr25683481fa.40.1715190017008;
        Wed, 08 May 2024 10:40:17 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c450c00b0041bd920d41csm3067993wmo.1.2024.05.08.10.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:40:16 -0700 (PDT)
Message-ID: <dbdba5da-12c9-4644-9411-ce3e30347b00@nexus-software.ie>
Date: Wed, 8 May 2024 18:40:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] mfd: pm8008: drop unused driver data
To: Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>,
 Satya Priya <quic_c_skakit@quicinc.com>, Stephen Boyd <swboyd@chromium.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240506150830.23709-1-johan+linaro@kernel.org>
 <20240506150830.23709-8-johan+linaro@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20240506150830.23709-8-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/05/2024 16:08, Johan Hovold wrote:
> The i2c client driver data pointer has never been used so drop the
> unnecessary assignment.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/mfd/qcom-pm8008.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> index a04bae52a49a..c7a4f8a60cd4 100644
> --- a/drivers/mfd/qcom-pm8008.c
> +++ b/drivers/mfd/qcom-pm8008.c
> @@ -169,8 +169,6 @@ static int pm8008_probe(struct i2c_client *client)
>   	if (IS_ERR(regmap))
>   		return PTR_ERR(regmap);
>   
> -	i2c_set_clientdata(client, regmap);
> -
>   	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>   	if (IS_ERR(reset))
>   		return PTR_ERR(reset);

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


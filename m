Return-Path: <linux-kernel+bounces-445308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3282C9F147A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14D716A864
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722711E6311;
	Fri, 13 Dec 2024 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDO3EZ1i"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363418873F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112707; cv=none; b=iXiG96mTVGlsxt6POuHBensfZfprYJpSoP6sCcHhSApBQS43YkIyyoZSLZeLudLISL7QK3X3BbaifXiDHQDdP8fsj77pXh0qkv40efv5LgxXfaTpIFfV2xBzav9vk9buC5vfVgaCAJL/bRnLKD84Cf1ABNN6dHVIHqgnyDQpt4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112707; c=relaxed/simple;
	bh=fJMJGGIs8XwoUh5eaP+N5nnUuULzD6iUDWJ2PhMddOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzGS1lbbCDSG+7DIWPRLoDea0oVsqNSWKCxCgHFs1/xAY7X7oIOFXkVU1oJ43hF8DhlsyC28CX2WxyJJ0eHEw/jPb8gqzjomz0gZ/nCX+F1Pg43xilD8C8t4cbEA88dcP54mwyNbNiWk2V9EehSLqb5cyuZEA49DAcTG2Tfg/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hDO3EZ1i; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3001f1232e5so1096941fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734112703; x=1734717503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JP0v5TL7oePTh21UGaiJDFEPSqS7AXPH+Qkz4Rr1cGc=;
        b=hDO3EZ1itKK9oaB3oPBrr9zLVwgndKkZM0/2bJ88i4MrEF7X7resYq/hcL7BmZgNR6
         6I69X6Jbz9qS4q02+/Lg6cvwDQ3YjNxF0/7/lvRFOluYZGdDk2gztKLLV6BKsb9C9nV3
         ZQ1arKYQb59uTdSsvKuKHbbTvYnzjqSgQsmPLj4qwaHx/czcgXT83C0VM2aAfph/agvi
         oLIeP3YsscSWTv+5R/kO8GxM3bvXoXCMeC2FVQukHlUUk5F58J6E6z31rSmLpz0AiCBh
         jC6LgSon7AbuiooBkK2rgWocIdTe/s6V+d8OuY7DUn8jBJqbS8EmGBapcQs22/vMjWvm
         9xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112703; x=1734717503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JP0v5TL7oePTh21UGaiJDFEPSqS7AXPH+Qkz4Rr1cGc=;
        b=oJVxGHDn+SfA+ZjaCX4m/0LnX3v1FYDs4F1I2MzgVByJ32kjkNDF7YFx1DxljFei7I
         u4aRvZK3MXfGPSiWXKM+kcLkDYQU23a2G8Qd5szs7mXLo4bc9zAetIiqQ92B2xorNuoL
         r3ZIss/xobLGcebhZIyL6w0SnvOS+ERVyWh9eFC/pVRllpiEKO8U+KvfJrYXMQCuME7K
         QFbP4ZhBRCYVOqGDaay0uIj2cDZrcn8C+WefQRqhdWfkW/NKqJ2M9v3J7ZYPJ66IPjcd
         1aem85wpJMpaxSHOMF58z6IiDIvejbnHd7uzspNTPo+88c+le+Y9gdoIXLWB07GrF/F2
         sc0A==
X-Forwarded-Encrypted: i=1; AJvYcCVJIyGRw3/JG7vaL9+rOfTM5XVo7dUiVOklK9qi+aPM2WZk34t2IzXTFbvwb7ECOaP8dNRnWTaaUioSScw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqHchZfpbknWcdgXot8Gxh75CVZIJqEpSMTGEzlAuFBxjCL5zJ
	8vcVwSrVjmG/TvYegS7DFbBmq1qmxk9nBptC8aJpkz/QnI5CIfZvvJIFd21NAIQ=
X-Gm-Gg: ASbGnctykcuHun6EDI0jeRrlo7mzewFiiscsvwaIv+S8E2m3BD2V95kbknw4TOXPtFo
	vSqU5OuOdYjSbpaC9M4Qx14RNJJ/fGkewmTmzi0/FgtRzqzgvJnZ22/lcOrusBaJlW+0ONHKA0n
	9AWAZpUOVj/t/IHNST9ot2nVAuKgr2YgXLPHgAKIYuaYRBjUgmSObBqu98DlB05g0rK/g1rL2uL
	3rxczhOVSBLimV9ihUn8oM3v/ELiUI3FRk6QkOfCJlnUJqsnCFuBHakNJK2STlbD1zbk3vPik48
	jVnSIf+A0pFOE4rz999iLadzJbBVPW2TNRI=
X-Google-Smtp-Source: AGHT+IHrAfr6s54EMZzdZibt61xiXAEyvwCU0wxpSg2sJKxDaCspoqErH2abtAvmUlYyFr7yIzet5w==
X-Received: by 2002:a05:651c:b20:b0:302:4113:2023 with SMTP id 38308e7fff4ca-3025451db77mr4619631fa.3.1734112703518;
        Fri, 13 Dec 2024 09:58:23 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-302245cf66csm15409481fa.25.2024.12.13.09.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 09:58:22 -0800 (PST)
Message-ID: <8308a825-2f33-4ec6-bfd2-9d3ed31c4a56@linaro.org>
Date: Fri, 13 Dec 2024 19:58:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: qcom: camss: Restrict endpoint bus-type to
 D-PHY
Content-Language: ru-RU
To: Luca Weiss <luca.weiss@fairphone.com>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Barnabas Czeman <barnabas.czeman@mainlining.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, David Heidelberg <david@ixit.cz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241209-camss-dphy-v1-0-5f1b6f25ed92@fairphone.com>
 <20241209-camss-dphy-v1-2-5f1b6f25ed92@fairphone.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241209-camss-dphy-v1-2-5f1b6f25ed92@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luca.

On 12/9/24 14:01, Luca Weiss wrote:
> Currently the Qualcomm CAMSS driver only supports D-PHY while the
> hardware on most SoCs also supports C-PHY. Until this support is added,
> check for D-PHY to make it somewhat explicit that C-PHY won't work.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 9fb31f4c18adee886cd0bcf84438a8f27635e07f..b99af35074cdf6fa794a0d2f0d54ecf12ac354d9 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -1855,6 +1855,15 @@ static int camss_of_parse_endpoint_node(struct device *dev,
>   	if (ret)
>   		return ret;
>   
> +	/*
> +	 * Most SoCs support both D-PHY and C-PHY standards, but currently only
> +	 * D-PHY is supported in the driver.
> +	 */
> +	if (vep.bus_type != V4L2_MBUS_CSI2_DPHY) {
> +		dev_err(dev, "Unsupported bus type %d\n", vep.bus_type);
> +		return -EINVAL;
> +	}
> +
>   	csd->interface.csiphy_id = vep.base.port;
>   
>   	mipi_csi2 = &vep.bus.mipi_csi2;

My cautious worries were futile, the change works as expected and
the regression testing on RB5 is passed:

===== begin parsing endpoint /soc@0/camss@ac6a000/ports/port@2/endpoint
fwnode video bus type not specified (0), mbus type not specified (0)
lane 0 position 0
lane 1 position 1
lane 2 position 2
lane 3 position 3
clock lane position 7
no lane polarities defined, assuming not inverted
assuming media bus type MIPI CSI-2 D-PHY (5)
===== end parsing endpoint /soc@0/camss@ac6a000/ports/port@2/endpoint

Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir


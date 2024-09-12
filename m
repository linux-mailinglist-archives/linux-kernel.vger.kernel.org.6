Return-Path: <linux-kernel+bounces-326128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A5E97635E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71665B2231A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A883318EFDB;
	Thu, 12 Sep 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OwEPxOA6"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B718C915
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127480; cv=none; b=Y05IqCEUJMbSKAbbby6TiIB6QUxxu2TBSzj3djWwNdCt7drwfBhENTF/XvNSU2Ul/JvI2NAJNUgxdnHStAOLAbca6+Ynubnc6B020jmq7CKz1SLTqCG/ot/wflLfQlSYl7DqPll52XkOg/00Np3hQ/+iFzQeki6Wveh5O7HjaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127480; c=relaxed/simple;
	bh=Jn/WmmWqV6Oz1qW8UzAzsc2CIj0g9WeIqPQj9OAxD2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UT4MB874qbwhEhjGCraSw8UyqwKIO0caC5tn55QnSwRGN6IiA2DQ+NXCqCBnon7rA8OeijGREB3Jp3rPXbEYVp03DxEOJZwMnqjNkmxkI7ZAQL5EJCPy7iI4Gd1FYq23pj+L5N4/6qZxZQ1ooanJYpgeGNXH7NjOISsdpzLzXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OwEPxOA6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5356d34ef19so90346e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726127476; x=1726732276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSC5IYlX2GVw7tHTObPeS1hh+2TPL2GlXnJ0/a7Cp54=;
        b=OwEPxOA62FQlkq7Dv3Pw/+gyhwagwK7yrulzJXAZ8+BpM0BrK6XaTRJI6sNduO7dlQ
         cpFMHkRinbEONroK6eyuWisSrjbnjlR+S8eoINfPxVrySRDOGHhFhtXuNdBMuI4c09fn
         FzmMeyBC6D722RLg2SopeRYB+3ZhGRZUHL5B6t4apobXAmM53ebyFLt+PnwirqEmU55Y
         d9Sk/JDDQ5p0cS4nVTYAIr886K5y8MC1CKPJBl1ZJ03RKh6zOJ1sNRxkp+bJF0WbQFUf
         2R4BK3oh1HBDqYMoJ8u30iIRk2PoifiP1h2rzlSkRun72OwREF4HZmBW7oofjpJXjYw8
         namg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726127476; x=1726732276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSC5IYlX2GVw7tHTObPeS1hh+2TPL2GlXnJ0/a7Cp54=;
        b=ZplDr5JMCSXEYACkuRiOn/QbH3vouWpchweeM9/x135O/e9rNSDAC74s6x4VNEKtiV
         2ifcmsvpnfPJeR6FgWSxNaN4ipCb1GiZYbCxLjPduhTutqd9JYPQBngHF8VfYklvd0yV
         9HB5VKg+s8bsfl2V1j1jXdThpVnQsOfBPo27u8m8pGt/dHtAyxIVyqQhVA6c8MoazfVa
         iHuFMfj05vq7wVXWJ4JdTwyc/Zqhe5BfShKIABarduPVZrjka0qZiAn9QNeg1gK/wEwl
         vtlgDJljvmT3JatbBKW2c4CZ5LRABBo5t6U1MisOwv3oPrGIhmo9KjFk6bz7zkmZzZUJ
         QBDw==
X-Forwarded-Encrypted: i=1; AJvYcCVO+Cy+6YgqRuD1pHgfradSzCJ+UvZ56Zx/ISbe3K8bbTkAYdud7ypiGJukOI2Ze5Hg1lF7viEfnE8LcBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOManSpD8J9Rq0SzL+WXG22g2hHV132J7YmteD0NCIKx4uFbuB
	4t7SCgMflfAnIzrrcV3mNk7AXMZ5NY/yVl7OQgNzbFce4sEoWc5htBztTpHWmZ3iNI/3cpS/73q
	q
X-Google-Smtp-Source: AGHT+IFzTejAnj+md6Dum/Fvnlg7LUCWhb1+849LYpXkIst84RpIK/lVMWVk/YwkXD38Y3yT3kHjhQ==
X-Received: by 2002:a05:6512:401d:b0:535:6a7b:9c03 with SMTP id 2adb3069b0e04-53678fef731mr300477e87.6.1726127475898;
        Thu, 12 Sep 2024 00:51:15 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f8cb76fsm1826761e87.177.2024.09.12.00.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 00:51:15 -0700 (PDT)
Message-ID: <14bfc031-63f7-4c70-b860-f2dcf592d19f@linaro.org>
Date: Thu, 12 Sep 2024 10:51:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: Fix potential crash in cleanup in
 camss_configure_pd()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <7883f30a-0646-440c-95d5-937062ce10b6@moroto.mountain>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <7883f30a-0646-440c-95d5-937062ce10b6@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Dan,

On 9/10/24 22:55, Dan Carpenter wrote:
> This function calls dev_pm_domain_detach(camss->genpd, true) in the
> cleanup path.  But calling detach is only necessary if the attach
> succeeded.  If it didn't succeed then "camss->genpd" is either an error
> pointer or NULL and it leads to a crash.
> 
> Fixes: 23aa4f0cd327 ("media: qcom: camss: Move VFE power-domain specifics into vfe.c")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 1923615f0eea..f4531e7341d4 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -2130,10 +2130,8 @@ static int camss_configure_pd(struct camss *camss)
>   	if (camss->res->pd_name) {
>   		camss->genpd = dev_pm_domain_attach_by_name(camss->dev,
>   							    camss->res->pd_name);
> -		if (IS_ERR(camss->genpd)) {
> -			ret = PTR_ERR(camss->genpd);
> -			goto fail_pm;
> -		}
> +		if (IS_ERR(camss->genpd))
> +			return PTR_ERR(camss->genpd);
>   	}
>   
>   	if (!camss->genpd) {
> @@ -2141,13 +2141,10 @@ static int camss_configure_pd(struct camss *camss)
>   		 */
>   		camss->genpd = dev_pm_domain_attach_by_id(camss->dev,
>   							  camss->genpd_num - 1);
> -	}
> -	if (IS_ERR_OR_NULL(camss->genpd)) {
> +		if (IS_ERR(camss->genpd))
> +			return PTR_ERR(camss->genpd);
>   		if (!camss->genpd)
> -			ret = -ENODEV;
> -		else
> -			ret = PTR_ERR(camss->genpd);
> -		goto fail_pm;
> +			return -ENODEV;
>   	}
>   	camss->genpd_link = device_link_add(camss->dev, camss->genpd,
>   					    DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME |

the problem has been already addressed, it is a real crash, not just
a potential one.

Please see https://lore.kernel.org/all/20240813210342.1765944-1-vladimir.zapolskiy@linaro.org/

--
Best wishes,
Vladimir


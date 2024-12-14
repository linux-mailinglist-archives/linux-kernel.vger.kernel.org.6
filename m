Return-Path: <linux-kernel+bounces-445772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 677249F1B6C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDAC16B030
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF17D2FF;
	Sat, 14 Dec 2024 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8KAYX/U"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D7B674
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137083; cv=none; b=uGqQOKw2fevy2Td8m7v/btoGVA59W2jJfKfxe5RDjiMWVuYgFZyCXkb19Ng0wI1Ai+m2Icg5TASo5eazLIWgAA73P/jtFVx7AhfIzRtMV291e9F2AnpzwGeUtk5glvGoV9fla6pWQb4AZb8Po0XEQvIj5tydDjtQGy3fMMKnMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137083; c=relaxed/simple;
	bh=aFbdLbRlaVcy+PhAJ++OAS1Q15RgBSAPtcCTnN3A5x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIwtIB/y1S6k2pfUNXJ8ysg78qDu2BH6WwOTe9haXCOx7PTNSd9u6dnxGqVL5NmCXp1I8H3SlHqxZXO8sRWYnd9F3gzKV5Y1nfb0JmI2JC6LQwOAmqSbMwBEA4nEKzv8VPJDVhJOP3x7b3kIP7DHCWtmkHiQo9PrAsNIEFOLKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c8KAYX/U; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361c705434so16718675e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734137080; x=1734741880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeDrMymOkQm4q0L/Z4XKBmKDN4NxNTLNurLDHBywolY=;
        b=c8KAYX/UP3qNr29rQR6KfNIOUtJQ2qU7uKHfoPBD2CZm7ey9oWw7Psb0zr7OPSF0h8
         mL9kOOcP52WVFiBh5Mndxr8nEGeVzT2eZAgRyJ4t8r/zFYyaRrakW1sJx3GjSXaQdl1p
         qQWEqDg6LG19Wn3crY1FP5+dcqd/Fn/Y58gltDkMIaFwSM4gl7ba0jaouGjAT2CERowB
         lB34jpOuxlz+G6pPr/2UIlB4v4cIGIV0V2Vxu/wFan99+FkmP64Jq95ScPU6wE9/SFcm
         F6VCdBhGSXcTIXEb1cqPjF6iOnmdpdAuCcH8vlB0XPUUwOOrq5wjlPp7cRNEUOzQwaCD
         n4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137080; x=1734741880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeDrMymOkQm4q0L/Z4XKBmKDN4NxNTLNurLDHBywolY=;
        b=iBNidM/bysS0i3cLkdjcVDiO/bqiHXfjhyqzzY8Tmjpj+gmb+8VOl2KA++5JySx1m3
         r6i0oC5Se6F/Z4ZYFIlJhWRYDWCM7UEbY1f4puvYuf2l8P3UOHpw3djXk9ESb0BoiSVQ
         dZDbxgvPZnWzcebyd5PCmHI8i532PWDDLM6xP4zFFuCU/AwiCZA6goo0qg9cG/BXnFlT
         arqqk5fZvHU/HDYW30AMrTtmu8pie7UF5puiUUnP+XLIOPwNZv7zK4FWnbD9WG0ef4Gt
         xK8S5x4yshu1MvcTjUzJmN9kBqAeWND3zxqEDjtNM/pVJyORZ7I5hO7wLXGvSvO75oC2
         J70Q==
X-Forwarded-Encrypted: i=1; AJvYcCVci2n/UHXziTccrCa0PUkRtUWsuc9Aqny8x0t8hF54Gr06hAC1y9OgHkKvQsZYjIvHSJYWSEiNVZ9lzJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJoCxVD48ecrtkifycgDMOwNYrweWFL9FuZTNbaxDObz6ay3lI
	87YmLbarWjiuTPTh2PPFsgUIAQ01SRr+2en3Or2gJpoRGl04ToUUkZGn2ETwJOY=
X-Gm-Gg: ASbGncsqMc3n4xJaJkTEFi+1W4tI3nC1hg54aXG9iaodVK/YDKPqukw/J3tTF1TPFzT
	fRSOwAnoEcNc52rRdHDcMOs69il1zrEmIbIvhHIjkE7BBA0Nw/qEFLgyz/DmWM1bdg6Wc5jQGvO
	X95HJsJWmD9CK44BTvoo5MHp86YjOFvsG1GvUN2v6FbBtfXGUBnIPVksFWuaVmTovXg8O3C/YaJ
	+pctctVBXYbVhPmOivbEj7iFkTokVdzX6MUzHWAIph/gykSmFfuIHbaCJxMoYfNkUyptg==
X-Google-Smtp-Source: AGHT+IE0KYR/8jsLefDmzAbaJ5qV8oYgeFZCRtcVw4sbIXG9a+jTQI69goTr98uf2yrQPqe8MTbCUA==
X-Received: by 2002:a05:600c:511c:b0:434:fbda:1f36 with SMTP id 5b1f17b1804b1-4362aaa9cb5mr33801055e9.20.1734137080297;
        Fri, 13 Dec 2024 16:44:40 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43636066f51sm8558775e9.22.2024.12.13.16.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 16:44:39 -0800 (PST)
Message-ID: <1a570c17-c501-4a29-a4f7-020f41563f3d@linaro.org>
Date: Sat, 14 Dec 2024 00:44:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] media: qcom: camss: Restructure
 camss_link_entities
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com
References: <20241126100126.2743795-1-quic_vikramsa@quicinc.com>
 <20241126100126.2743795-3-quic_vikramsa@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241126100126.2743795-3-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2024 10:01, Vikram Sharma wrote:
> Refactor the camss_link_entities function by breaking it down into
> three distinct functions. Each function will handle the linking of
> a specific entity separately.
> SC7280 and later targets mandates for 1:1 linking for csid -> vfe.
> i.e. csid0 can be mapped to vfe0 only.
> 
> Signed-off-by: Suresh Vankadara <quic_svankada@quicinc.com>
> Signed-off-by: Trishansh Bhardwaj <quic_tbhardwa@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 155 ++++++++++++++--------
>   1 file changed, 103 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 6824ffbdf4a8..67fb11cbe865 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -1994,7 +1994,6 @@ static int camss_init_subdevices(struct camss *camss)
>   }
>   
>   /*
> - * camss_link_entities - Register subdev nodes and create links
>    * camss_link_err - print error in case link creation fails
>    * @src_name: name for source of the link
>    * @sink_name: name for sink of the link
> @@ -2012,14 +2011,64 @@ inline void camss_link_err(struct camss *camss,
>   }
>   
>   /*
> - * camss_link_entities - Register subdev nodes and create links
> + * camss_link_entities_csid - Register subdev nodes and create links
>    * @camss: CAMSS device
>    *
>    * Return 0 on success or a negative error code on failure
>    */
> -static int camss_link_entities(struct camss *camss)
> +static int camss_link_entities_csid(struct camss *camss)
>   {
> -	int i, j, k;
> +	struct media_entity *src_entity;
> +	struct media_entity *sink_entity;
> +	int ret, line_num;
> +	u16 sink_pad;
> +	u16 src_pad;
> +	int i, j;
> +
> +	for (i = 0; i < camss->res->csid_num; i++) {
> +		if (camss->ispif)
> +			line_num = camss->ispif->line_num;
> +		else
> +			line_num = camss->vfe[i].res->line_num;

This statement is incorrect, you are indexing vfe[] with a control 
derived from csid_num.

Below is the statement you are removing.

> -		for (i = 0; i < camss->res->csid_num; i++)
> -			for (k = 0; k < camss->res->vfe_num; k++)
> -				for (j = 0; j < camss->vfe[k].res->line_num; j++) {

As soon as csid_num > ARRAY_SIZE(vfe) your code breaks.

I noticed this as I added csid_lite to the x1e series where the 
aggregate count of CSID is grater than the aggregate count of VFE.

Please fix.

---
bod


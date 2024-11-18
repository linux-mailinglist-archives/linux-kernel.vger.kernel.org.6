Return-Path: <linux-kernel+bounces-413561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23B9D1B02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42ECB1F2218A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DD21E7C1A;
	Mon, 18 Nov 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcp8S/pc"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375531E5712
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731968242; cv=none; b=E9ES7+2En9VB5t5f31tmGO5ELmEE0HWu5g3HsYE5belwyUN1ylx6BRJiRYppt/xRc2xt7xYxekdyzyVC9hZfL+rbfdwQ5ShDWRAQuaNm4zGssVDqSAnAgT2CGcz2uHimIkxSNNQfA4b6R8YxEbnmVRvASLcB5blXoe700OD0iVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731968242; c=relaxed/simple;
	bh=hZIvMyXtZWni8q5+iCDoHqgTW0z1eP+nNGIo28NDmRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/didxhS/tTZksAY27NacbzZwEf6lQDPElib66BEd+YUW5xNi2EwFm9kI7LcoZe7Z5YDrfpJOuH49usFmfjstsn3AEwXfrowuM9oUhUmDnZ+qZht3KSVJMrrJ3V5Ee4IyfqH1rp55LAZFPCnfeIzuEaqyMMIQa4Cy8JGG5w1wQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hcp8S/pc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539ec09d690so626021e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731968239; x=1732573039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4J2lS2YmBPhVneBwHBuX6J9t5XJoyMza4FciI9dZ0VI=;
        b=hcp8S/pctrgE4OmEV+M6xkDxoMo4Y0PMgJ+U0IoD8UY5Bw9IVM19ORZn1vMLNuGCKN
         PsXR1yGDoYwlF8HcZb9m4HvEkjZT1lQfol24cUYzaqKhugkteskA2/CDusf6k4OF8ptR
         4KoAByn1iL6oIwfEnl5UJehtF+MDVdVRG/vOWCh4XwobZu27feA13rQtmuYA7W94+rD3
         ywwt8qtGyT2QmbmAuKdc3X4L821xUBmLPdbrCyP7FUsMDC+3WIk38u8QQv8siEVgfgNG
         fQAvlo1X2TPzdv8XxtjjP+ienhQjrmuDQ3+ydRi0d7/NB0rVYM05LJXIi9/PQcWXNZvJ
         IuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731968239; x=1732573039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4J2lS2YmBPhVneBwHBuX6J9t5XJoyMza4FciI9dZ0VI=;
        b=mZMyRC9K4N1gdux++UXvicVL4x9kOqmHc75NZOu/nuF3JgrzkPh+eEtbHxnHgBd15y
         wYaYY7lBuuDEYhDw4qBIaLZYk1Vp89F0ijifiGMZM/FvqiCGBqO3y6oxytRlrumv1q6e
         YrGo/7AUzf7wEU/1GwRENW2oKedPIjMncVwv3CSRiUjQrtwyN/+xcepOKJSub3BJAh7t
         wFPDrK4YoIIlTUjFNQ9yRfSlOevGWZz8wWUbDWQ6jjuS8Jmv8RjTnRJ08W0Bkt6+1259
         ts7zwShmsGgvYApVE+x69lNxJE8JngSTKgytvt/cMNEBxQQT0IlZWMbFvCcdxh47gYX2
         1xUw==
X-Forwarded-Encrypted: i=1; AJvYcCVguIlWKCUl83Fd5+cVOoHZCDO5Z3yYdzhbsbkDf1C41ekpzhNgSyJ3RC1ieP7sqOkPRSMRPTwOdEorxA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV47MyyxbvAqAthQ0EDvI8J3AhpFoBmK7xpe9H/FrXMfMDn9lA
	PufToO7trnw51pC/feI/nyQwQYkcLJ2+ZC70gsoanfkU7nkgavTGi365DH9CwGI=
X-Gm-Gg: ASbGnctC+bvIkzwar9iLEWvVt6m2sufKfuhqkl/Qo6zPZI70PzIPRzB36H2J2mW7pTY
	EmViI+LXe+zhk8s6Qwa+95YlsZ0yYS/T35Do+5XTZLZ6C9p74Y/uP/eA5wMmdDbBYx6QTr8Aipl
	iA1FXGoTAOnYB0+PRru86k6UWZmFTnQYZZUladeAMVtJEtZtcWaEtmm9b7/xoz01CeUpPJ+6JEq
	Rs94f2eY81xKWYnTBNwlffnyOdEQy/31sng+rZFtRNJfmM3I8PCEQSAO2Nutliujj6oNzQeocMW
	Cyk0JNdFiImxEZ2QHlH6TcaBIu3R
X-Google-Smtp-Source: AGHT+IH7yutk9OuFHF7vFU1p9lx+sgBcPdw4/+MxXchsSnYtkuyHmZwIoY0dub0Kym16dEsIApX+Dw==
X-Received: by 2002:a2e:b8c1:0:b0:2fb:55b0:8293 with SMTP id 38308e7fff4ca-2ff60668453mr11518611fa.5.1731968239323;
        Mon, 18 Nov 2024 14:17:19 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff6985118fsm10566341fa.2.2024.11.18.14.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 14:17:17 -0800 (PST)
Message-ID: <8a33c0ff-0c6d-4995-b239-023d2a2c2af5@linaro.org>
Date: Tue, 19 Nov 2024 00:17:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: qcom: common: Add support for power-domain
 attachment
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org>
 <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-1-b7a2bd82ba37@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-1-b7a2bd82ba37@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/24 04:24, Bryan O'Donoghue wrote:
> Right now we have a plethora of singleton power-domains which power clock
> controllers. These singletons are switched on by core logic when we probe
> the clocks.
> 
> However when multiple power-domains are attached to a clock controller that
> list of power-domains needs to be managed outside of core logic.
> 
> Use dev_pm_domain_attach_list() to automatically hook the list of given
> power-domains in the dtsi for the clock being registered in
> qcom_cc_really_probe().
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/clk/qcom/common.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 33cc1f73c69d1f875a193aea0552902268dc8716..b4377fa09f7c0ec8d3c63dfc97d04fbb8cd6e10b 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -22,6 +22,7 @@ struct qcom_cc {
>   	struct qcom_reset_controller reset;
>   	struct clk_regmap **rclks;
>   	size_t num_rclks;
> +	struct dev_pm_domain_list *pd_list;
>   };
>   
>   const
> @@ -283,6 +284,25 @@ static int qcom_cc_icc_register(struct device *dev,
>   						     desc->num_icc_hws, icd);
>   }
>   
> +static int qcom_cc_pds_attach(struct device *dev, struct qcom_cc *cc)
> +{
> +	struct dev_pm_domain_attach_data pd_data = {
> +		.pd_names = 0,
> +		.num_pd_names = 0,
> +	};
> +	int ret;
> +
> +	/* Only one power-domain platform framework will hook it up */
> +	if (dev->pm_domain)
> +		return 0;
> +
> +	ret = dev_pm_domain_attach_list(dev, &pd_data, &cc->pd_list);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>   int qcom_cc_really_probe(struct device *dev,
>   			 const struct qcom_cc_desc *desc, struct regmap *regmap)
>   {
> @@ -299,6 +319,10 @@ int qcom_cc_really_probe(struct device *dev,
>   	if (!cc)
>   		return -ENOMEM;
>   
> +	ret = qcom_cc_pds_attach(dev, cc);
> +	if (ret)
> +		return ret;
> +

	ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
	if (ret < 0 && ret != -EEXIST)
		return ret;

That's it. No need to introduce a new function, not saying about 20 LoC off.

Next, you have to call dev_pm_domain_detach_list() in your version of the
change on the error paths etc., fortunately this can be easily avoided,
if the resource management flavour of the same function is in use.

>   	reset = &cc->reset;
>   	reset->rcdev.of_node = dev->of_node;
>   	reset->rcdev.ops = &qcom_reset_ops;
> 

--
Best wishes,
Vladimir


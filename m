Return-Path: <linux-kernel+bounces-441376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2591D9ECD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0550A188BC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D862368EA;
	Wed, 11 Dec 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nmvbd8Jq"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44537233680
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924216; cv=none; b=fU8F6kgxB8eqA97qKN3vt8zwXgSDh4ZoYBHiYec/2D4r1MmmoUHXV/vuxPvhdNvXja6y2kPEe8Kq5uwiyYnEHEXj3jmljuLpQg6LpZOg0GRyOs8NTWL01ulOHmdfIBNcuCX6rzhCFsjgyV7Ewm5th+3r9KejsHxJnY0l5BVmUYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924216; c=relaxed/simple;
	bh=fuXYp1uvXlvOHM0BGIwSdW+Neg42eTmNvggMnkhRUIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+rAmLt0gHcNfJgl0Rv7mTSrDZAby6lTnbhGKQW+YJMrkZaxKKWnTf/dNpzHcvwygFQ+kmMPQFYWG53Un7tlgHnwtfrkzP2qal/kfk+/FmR3ylRx6q1PQ0Ow3PXRCodJvJqa2MRof9zuSWf/MAFl/WwCNn+8qjA9R6EFipQJWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nmvbd8Jq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53de3ba3d39so1232274e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733924212; x=1734529012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEbwGtbe9naMX/pU7T/wl0s3YzTrymq39FJreAC4edI=;
        b=Nmvbd8JqPxpXRl9zL1BiSZxEyln59DzinMMkZxLyZwzkZc4GKyzLyMOpTSh+TsZU1u
         1J6kdV4zOpbvPaUlhO34PjLkcEI2FkuLwS8kr6pudf7Y6iOnmqHq3Xvp2hJGO0MzLbbk
         Kq7Rho+Tck/lwg2utCGAWd565sb0Mq8VajDAqS0SFBZ57aWrUjTBTpMa/oXAPGN+LP+3
         iShYI60SBdYnQKjW6wisIIwiJSZdWBY7XB5t+HGCyXqb9G+sXX172XgAmTqRhwT+C3y3
         XXTpZH+HiYS0TSc1U6Kq/hEPP4Ke6PFcpapdGQqOLPfZD4C1ykd7XpcJf3Z1WfCdg5tY
         /pVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733924212; x=1734529012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEbwGtbe9naMX/pU7T/wl0s3YzTrymq39FJreAC4edI=;
        b=AuqSMDf0VHVWNknwgEnYW113zunGF0h0VU2Qt40sC+6IFFHK3YgiII1r3K9DWsYrbC
         Rk+/M5iwefxxHf0R6s1lXN+qMgxAenjZ9/sdlqSRxwcpflusNPCFVTWHXLAMOyisFSQZ
         5Pw85PIRAsTTOpmSA+ArHkIDM7IZyEo3qn9lsQUTRL8MRPsssWtTaJXUahB8xQoJeSKh
         y8J1LCFpnEMdgXYtUZnaLgiN3syVahzDMFopYElwJXI8/fOv4+E+Y9YrZrLLVRt9Hlu+
         nJBVEDMG68BwCbZJbrYYOqvL/mg/UF1mq+APZpFfyBq5gjuLzRmG521yLVyuD6aKmi3h
         b/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUft9NMheh5Qn1Kkq3hkXu6JRt9TovFDYTtzfUcceQDQhM2MGrIAILYmJ8kF77lqMUyUabHZC22orQoPyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvYvaUzyh+Wddwhub62HaLoYw2xSyLWehUze1fJ6HtItqvn4d
	1q5eB6giuktOaa2Cyz/xWqtcyC5lhYM/8RlI4fLY5mQV9Np2F8HMBe2t+JPTYQA=
X-Gm-Gg: ASbGncse+YUarors9z+ofSFCYkLlkdMQbddAVDu1dqroEQEqxYBnehTQj71FqE49r1P
	XS/hGstLbxSKiIJB1TxCLefKODmFKqd+o6BX9Psf3gUpWZ3xizxokA/gcGrTY1VhaF6abQW2iN/
	p4bCQ0nuvQHbG1Lq5lRZt32J4ZQWLwWBzVu2di2Svh/TJS128fidBLhIZH1WDHmDvDBK85TD2Wt
	S9Ct6HxMltx8AeG3EBwkJec7IY9oVFpTN8tgDFktcL0RAuiMJy1wGJrg7T1IhhvcG8A1/7TVJyc
	5MURanAkdCFuXAhGKTUVYhwSb7hpzP1X
X-Google-Smtp-Source: AGHT+IHHGHISPWwoOfSLQHxkKBfu9jAmiwtrWrntxuCBZKz+ikghNTm/6FcJSOAcYPNYw/C/JlHI5w==
X-Received: by 2002:a05:6512:3c9c:b0:53e:df2b:df1a with SMTP id 2adb3069b0e04-5402a5e83c3mr291795e87.7.1733924212381;
        Wed, 11 Dec 2024 05:36:52 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401a3a4c24sm1264587e87.199.2024.12.11.05.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 05:36:50 -0800 (PST)
Message-ID: <fca39cde-b9c8-4f1d-a4d0-92a1d739b57f@linaro.org>
Date: Wed, 11 Dec 2024 15:36:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] clk: qcom: common: Add support for power-domain
 attachment
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-0-7e302fd09488@linaro.org>
 <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-2-7e302fd09488@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-2-7e302fd09488@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryan,

On 12/11/24 02:27, Bryan O'Donoghue wrote:
> Right now we support one power-domain per clock controller.
> These single power-domains are switched on by the driver platform logic.
> 
> However when we have multiple power-domains attached to a clock-controller
> that list of power-domains must be handled outside of driver platform
> logic.
> 
> Use devm_pm_domain_attach_list() to automatically hook the list of given
> power-domains in the dtsi for the clock-controller driver.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/clk/qcom/common.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 33cc1f73c69d1f875a193aea0552902268dc8716..e6a024e95ab5f4b0776ffc6c7b3bebfbebb007fd 100644
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
> @@ -294,11 +295,19 @@ int qcom_cc_really_probe(struct device *dev,
>   	struct clk_regmap **rclks = desc->clks;
>   	size_t num_clk_hws = desc->num_clk_hws;
>   	struct clk_hw **clk_hws = desc->clk_hws;
> +	struct dev_pm_domain_attach_data pd_data = {
> +		.pd_names = 0,
> +		.num_pd_names = 0,
> +	};

Please remove the added local variable.

>   	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
>   	if (!cc)
>   		return -ENOMEM;
>   
> +	ret = devm_pm_domain_attach_list(dev, &pd_data, &cc->pd_list);

Please simplify it to

	ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);

> +	if (ret < 0 && ret != -EEXIST)
> +		return ret;
> +
>   	reset = &cc->reset;
>   	reset->rcdev.of_node = dev->of_node;
>   	reset->rcdev.ops = &qcom_reset_ops;
> 

--
Best wishes,
Vladimir


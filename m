Return-Path: <linux-kernel+bounces-192404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F598D1CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA729284D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC1F16F85D;
	Tue, 28 May 2024 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUoaSrND"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646116E89E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902613; cv=none; b=huEwQic0EKFUgadpotoE7+K6IrUC+ZuIK99utzVvQe+zZ1OztveD16EbQrYu35j4A1QHDxcM2oUdo3b0QqeW+pidhTYbU/F4002sB1+WitYvKNKGzGijTGzOyTa8KFy/O/qNaNHolIpCj8WYvyXib5fi9UceRMUdzAy8tME1S2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902613; c=relaxed/simple;
	bh=eWv5JwR7K1Qxq1I3dmUUg+Jdv1UMh0zhiDtqyF8rVtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWdQnmQ3UeHR7gNYPoUWG6duu3fHJJ8EjQzLlEw8fWWIksAlS/kjXq1Sj7TDhnZsPzfGfDMcsCb75p1vCNEW8d/sIgTngHGcSvELAY2DpfEyUvbKQOc3ekN2sP3BVGg2gfp96wzx+xsaTO8Kxbd0P6edrjRyUpNY6XoWFqSis/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AUoaSrND; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5295d509178so1060088e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716902609; x=1717507409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXo//qXhY1ly8R9H5vDfmlnijDRJLj8I/IeGXD7QUwQ=;
        b=AUoaSrNDnkc6TNBi6D04MozIiT8FSWz0Y1wgW5d3RLH+avESFAguNUC8xadJmZX8dQ
         9uURd4ThW2K70HXRs+feblbAHMMWFrhDlasXCHmQ5cHZFNPY11OgfGFqsjluaRGMkGXJ
         9tTZ/8wlClnuNCQG6yCBkR3hGuFSTbzjYiynfYUrZVjLDMhYjzza+H/DfQi+/xN93SiJ
         Fqz2WCXhgK9OIlH4d+Q0e0+SJQnoIQBEaVuPC0T6zmKKGeS9hZFUn2coHN6nfFF9IqPS
         LCflxei7lrb9Jg9FOhgy4St0wLyzQI7rQoNemcFicqSzJBYsmGfMdw4Lz/A030NIiAQk
         e61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716902609; x=1717507409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXo//qXhY1ly8R9H5vDfmlnijDRJLj8I/IeGXD7QUwQ=;
        b=fTI1fM6aRQxIlkAjmPz3buuSdbKcs9KqvlPaZl5tG6U3y3qICy9DCOPBClxbiIJvWb
         5AQ3swLNTJ5y6fQEQKp5M98/MLgE/DQvTSGs/K3AzyWSAf5SnIXbFM1fniSjQFDE++1n
         xZLsj9wKt9FYgSleNVnZ6cUKz5joaY8owY+GVeaWT0jGiD6oajmk03TerboLoy729B9a
         0cZLxRDH94ss9eMIuJ9nbGhYmXVOO561VWHXODTzEYgE+uiD1LwG02qoWTEKNb5MP5za
         6LSO+7JmiC0SGK0npkrkb11sksptYvo5HUYgyUxYsrUFm7E72fDUzit8tbXiGEWTQ0Ru
         QFQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLQj4y0KueBENahDOlQzdNygDe7wRynh7UtCUArIaUkudu/QuODS2Xp2hw5L3BovFYvF9Xm1CRdlxFpbO8IIKw83F33QdHPC0fEDoj
X-Gm-Message-State: AOJu0Yz1xdVOfvEJ1hQ9BrGvCS+S2Mj4KZca1esv4KfZDFnpxk5P/Jcu
	e7bRpQoPcy9nMhblyKGHwPopgV7ezrbLbxOUGSft0RRKaBT5fydItNuaLn70KtY=
X-Google-Smtp-Source: AGHT+IH5995i1hOQ5zC022yhutQM4mzC2zckdQviZ3acRk+TMh+HR4elAA7mD6XJRRShwIOot+PE0A==
X-Received: by 2002:ac2:4343:0:b0:518:9823:601a with SMTP id 2adb3069b0e04-52965f1093amr10770667e87.39.1716902609284;
        Tue, 28 May 2024 06:23:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296e885ccasm950109e87.53.2024.05.28.06.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:23:28 -0700 (PDT)
Date: Tue, 28 May 2024 16:23:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ajit Pandey <quic_ajipan@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: Re: [PATCH V3 7/8] clk: qcom: Add GPUCC driver support for SM4450
Message-ID: <ssnyujhgz64mbxawb43okjkdidd3tbxwjob36ikgbogy64xuqv@ckvir5vfqo63>
References: <20240528114254.3147988-1-quic_ajipan@quicinc.com>
 <20240528114254.3147988-8-quic_ajipan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528114254.3147988-8-quic_ajipan@quicinc.com>

On Tue, May 28, 2024 at 05:12:53PM +0530, Ajit Pandey wrote:
> Add Graphics Clock Controller (GPUCC) support for SM4450 platform.
> 
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig        |   9 +
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/gpucc-sm4450.c | 805 ++++++++++++++++++++++++++++++++
>  3 files changed, 815 insertions(+)
>  create mode 100644 drivers/clk/qcom/gpucc-sm4450.c

[trimmed]

> +
> +	/* Keep some clocks always enabled */
> +	qcom_branch_set_clk_en(regmap, 0x93a4); /* GPU_CC_CB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x9004); /* GPU_CC_CXO_AON_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x900c); /* GPU_CC_DEMET_CLK */

I pinged Stephen regarding these clocks. LGTM otherwise.

> +
> +	return qcom_cc_really_probe(pdev, &gpu_cc_sm4450_desc, regmap);
> +}
> +
> +static struct platform_driver gpu_cc_sm4450_driver = {
> +	.probe = gpu_cc_sm4450_probe,
> +	.driver = {
> +		.name = "gpucc-sm4450",
> +		.of_match_table = gpu_cc_sm4450_match_table,
> +	},
> +};
> +
> +module_platform_driver(gpu_cc_sm4450_driver);
> +
> +MODULE_DESCRIPTION("QTI GPUCC SM4450 Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry


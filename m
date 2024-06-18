Return-Path: <linux-kernel+bounces-220133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F8A90DD09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFF728534F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEED16EBEA;
	Tue, 18 Jun 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E6x4F7Pe"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7864B16EB51;
	Tue, 18 Jun 2024 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741170; cv=none; b=ky28xz2DdiobZ3HqJBbydAbqh9IL+rnFs/7twHg09EBmlkUQlk0VFkfHBHWELAJVs/P88EPUn+vYF0MklZYmsMNUwMncfM6Z8Mp54u91qzyApeqnAumOp5qy59ucKQITxVYcTdan/izcuQs2/XtQs8lVGfxHvv2WpgSQ5dk9hNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741170; c=relaxed/simple;
	bh=+H52mh3XnrV/CQJyqHkVADaWVlcbgd1ZnWwtIDcA+S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezDSFVus/IFde326okGdybj9wKpz0rrBG+47WoAE+1N5HIcOYt77I856HLPtF9CmAe5YQsARSdl8S68V3U3ra7gqgKkNMwAz6exYk5Ae5kioE4an6VTWM6D8zEcVQAVnaq46u5PsiAg/ANJYMkU4zVlfVcCHm6WhM7axp37mp0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E6x4F7Pe; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C41BA40005;
	Tue, 18 Jun 2024 20:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718741160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTvCEPU1cab+Z2/A6+9YjBaQ0HypCOH+hj9/cz45SEA=;
	b=E6x4F7Pe83c+8Eo8TPPTNp6BEbcccZFhCynsoozHSXi/8WXh6gQZ8o/YHs5caaP54rexz6
	af1NlCpf3HhEZKBmjGungMcaINXnClhcf4niusVKnUFrfmLPomhEyv93Pjs7AhaQ77hej8
	5yWiKMVdkHgmZOQkbZzaX9IagPQ2Ir9IJUujIUBEV5DlgPqI/b/YmzRFo//nPkYH22ZFl4
	qKyGd649PDf96Xa5IucHfXCeXtmhwcbknTan8ccHoN+11WLbQUcDs83zDNKzZr1ctEsHUD
	b+QM5BXeAW5KQLTmbxgfp0Cy9utM+49T1RNRAZpxt/NyadPVPXPL5VaD5qSJrA==
Date: Tue, 18 Jun 2024 22:05:58 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Aniket <aniketmaurya@google.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] i3c: dw: Add optional apb clock
Message-ID: <202406182005584f0deea8@mail.local>
References: <20240611171600.1105124-1-aniketmaurya@google.com>
 <20240611171600.1105124-3-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611171600.1105124-3-aniketmaurya@google.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

On 11/06/2024 17:16:00+0000, Aniket wrote:
> Besides the core clock, IP also has an apb
> interface clock. Add an optional hook for
> the same and appropriately enable and disable.
> 
> Signed-off-by: Aniket <aniketmaurya@google.com>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 12 ++++++++++++
>  drivers/i3c/master/dw-i3c-master.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 77a2a1c3fd1d..41cdfd6741e3 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1470,12 +1470,20 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  	if (IS_ERR(master->core_clk))
>  		return PTR_ERR(master->core_clk);
>  
> +	master->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
> +	if (IS_ERR(master->pclk))
> +		return PTR_ERR(master->pclk);
> +

I guess you need to update the device tree binding documentation too.

>  	master->core_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
>  								    "core_rst");
>  	if (IS_ERR(master->core_rst))
>  		return PTR_ERR(master->core_rst);
>  
>  	ret = clk_prepare_enable(master->core_clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(master->pclk);
>  	if (ret)
>  		goto err_disable_core_clk;
>  
> @@ -1520,6 +1528,8 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  err_assert_rst:
>  	reset_control_assert(master->core_rst);
>  
> +	clk_disable_unprepare(master->pclk);
> +
>  err_disable_core_clk:
>  	clk_disable_unprepare(master->core_clk);
>  
> @@ -1533,6 +1543,8 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
>  
>  	reset_control_assert(master->core_rst);
>  
> +	clk_disable_unprepare(master->pclk);
> +
>  	clk_disable_unprepare(master->core_clk);
>  }
>  EXPORT_SYMBOL_GPL(dw_i3c_common_remove);
> diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
> index 8cb617b8147e..50c38e790c0e 100644
> --- a/drivers/i3c/master/dw-i3c-master.h
> +++ b/drivers/i3c/master/dw-i3c-master.h
> @@ -36,6 +36,7 @@ struct dw_i3c_master {
>  	void __iomem *regs;
>  	struct reset_control *core_rst;
>  	struct clk *core_clk;
> +	struct clk *pclk;
>  	char version[5];
>  	char type[5];
>  	bool ibi_capable;
> -- 
> 2.45.2.505.gda0bf45e8d-goog
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


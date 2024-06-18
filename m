Return-Path: <linux-kernel+bounces-220046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DD390DBF3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49F51C22FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B903115EFAC;
	Tue, 18 Jun 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXqAQtuz"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3C15ECCD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718736913; cv=none; b=WqCfj8Go69MlmSuZEz2qK2ti6ImSg2XTNZh7SPDPtsqwZL1qTBMPlPTGhGiNsVeNEFPUSgfQlzYdBFdn8IPTaItd5pcJmdCwNSLgoIaxS0PqhhBEvySG/QJZdD2gkHDF2UapdaDTODOXUGddLzUDMpxpudyJEDCJ6Pac6teQq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718736913; c=relaxed/simple;
	bh=UNFVAPuelWNv7Oeq53TScOsxnOnzZlhh3VXd9HNUGyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1dYouwrnkMr4RlI7Kt1D8Ef4PiAB0sLy2fBmNGv9wyUtlNMB2RfppYFZtwa3Wuom/iWrL2PN344Cxm64gcbVOUG6ihv2zwjvT+tt3TUHeTKWTk8oucbccGwplxVJfwxv8dLq+r84RmhF8XM4tvenfhpoN1nJh4Al/Prz3qNVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HXqAQtuz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b7ffd9f6eso5734655e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718736909; x=1719341709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27ULhBa6NF2Bs7Hi7tIhonbGGD8DbNJDz+k7oeA0y6Q=;
        b=HXqAQtuzqclHE1Tfkp579HcGaaZZgFwRzxX+H9pRdanvcbtAIVifU2Z88Rq+hwsvjV
         +GibgBYgwYPW1fvdh9GjD4GWidl4cRK7Xf4wf8TVPUcvTAUZNMNBkEshb0uwMPnZc1Tt
         g9m9xEfSYyqKv4GseAvLWWCiSPcsi75nl8zXWzolwuxVJc+q0GO7z6VNC31hz8GAmO4t
         GomLe0Pf8GKPRLmPLKfmEWX7a2uWcKL9UgoQuFyoH2DWDD2e9XgawG163+urz7T4s2Jk
         qcfuQNmSjyqyyUXvuW1aPYe5hDdGCwsy03JN4keGE7liR/FfmE6DwidjlRuUgs8pM6jr
         ABpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718736909; x=1719341709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27ULhBa6NF2Bs7Hi7tIhonbGGD8DbNJDz+k7oeA0y6Q=;
        b=qPsWPqho3F36gbSwCZtMyh2AnPrLhA2TtHpTn/+geKlcDGydB120Z9koC/utjcKV6Q
         X/A6wnHANV0AA6IrQ4K5BVt8TWa2cOURO8lUO8r7/DVhoBMFeNDht6f4MPKVQUL5NbEC
         fIVFUrYMcETvP/VOJIuBt01+THpuweyfpeYQz1LsjQc386N8lW8duZ//A1xoGjJxuCRf
         aX6ZnXusB5Q/O9wKfQZx7GhmPyeXxr7SRPH4vXPL+1DhGk3cslfIVVFek+UGODHkQJ5M
         dYVg5ad5SGhSwF3cpIYs0rk/sJHpjEj1OYh0y4ijsuVqDxUr1We2OOFuZoXn8mt/9TtF
         MPjA==
X-Forwarded-Encrypted: i=1; AJvYcCUnCMQuehqbZ9aCeFLUlN9dEfFojj+duNpAQkDdZOGeqWuP1sFeRdzT9eRrOYOWFnkWpCFVyAUrxk1w9zupPnZ57dFONQwNriPDepRP
X-Gm-Message-State: AOJu0YxZEeDQkUcbr5e6M+YMz9Q3DbOml9ByoZGwwMxrNPqvSq1eQKAA
	G6NpSmOYxg30bKDNIi8tjVCFRZPROor/f11ONTid3Nh83BmHbKQa3PJkJLXeLvI=
X-Google-Smtp-Source: AGHT+IF2Xuc+j5GQniwyckTVq0FVa/bh12Lgiw0qNMq3HIEExse2nNOx3fGWmOmKvYSecoALF0y/9Q==
X-Received: by 2002:ac2:5974:0:b0:52c:8009:e0cb with SMTP id 2adb3069b0e04-52ccaa62705mr256788e87.41.1718736908660;
        Tue, 18 Jun 2024 11:55:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282f1dbsm1578550e87.110.2024.06.18.11.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 11:55:08 -0700 (PDT)
Date: Tue, 18 Jun 2024 21:55:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, quic_rgottimu@quicinc.com, 
	quic_kshivnan@quicinc.com, conor+dt@kernel.org, abel.vesa@linaro.org
Subject: Re: [PATCH V2 2/3] soc: qcom: icc-bwmon: Allow for interrupts to be
 shared across instances
Message-ID: <d4f3rlk3jgqegxvto2b6vyemspommtsbs3ixqgan2rmknet3je@ohonicqa2iqy>
References: <20240618154306.279637-1-quic_sibis@quicinc.com>
 <20240618154306.279637-3-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618154306.279637-3-quic_sibis@quicinc.com>

On Tue, Jun 18, 2024 at 09:13:05PM GMT, Sibi Sankar wrote:
> The multiple BWMONv4 instances available on the X1E80100 SoC use the
> same interrupt number. Mark them are shared to allow for re-use across
> instances. Handle the ensuing race introduced by relying on bwmon_disable
> to disable the interrupt and coupled with explicit request/free irqs.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v2:
> * Use explicit request/free irq and add comments regarding the race
>   introduced when adding the IRQF_SHARED flag. [Krzysztof/Dmitry]
> 
>  drivers/soc/qcom/icc-bwmon.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index fb323b3364db..4a4e28b41509 100644
> --- a/drivers/soc/qcom/icc-bwmon.c
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -781,9 +781,10 @@ static int bwmon_probe(struct platform_device *pdev)
>  	bwmon->dev = dev;
>  
>  	bwmon_disable(bwmon);
> -	ret = devm_request_threaded_irq(dev, bwmon->irq, bwmon_intr,
> -					bwmon_intr_thread,
> -					IRQF_ONESHOT, dev_name(dev), bwmon);
> +
> +	/* SoCs with multiple cpu-bwmon instances can end up using a shared interrupt line */

... using devm_ here might result in the IRQ handler being executed
after bwmon_disable in bwmon_remove()

> +	ret = request_threaded_irq(bwmon->irq, bwmon_intr, bwmon_intr_thread,
> +				   IRQF_ONESHOT | IRQF_SHARED, dev_name(dev), bwmon);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to request IRQ\n");
>  
> @@ -798,6 +799,13 @@ static void bwmon_remove(struct platform_device *pdev)
>  	struct icc_bwmon *bwmon = platform_get_drvdata(pdev);
>  
>  	bwmon_disable(bwmon);
> +
> +	/*
> +	 * Handle the race introduced, when dealing with multiple bwmon instances
> +	 * using a shared interrupt line, by relying on bwmon_disable to disable
> +	 * the interrupt and followed by an explicit free.
> +	 */

This sounds more like a part of the commit message. The comment before
request_threaded_irq() should be enough.

> +	free_irq(bwmon->irq, bwmon);
>  }
>  
>  static const struct icc_bwmon_data msm8998_bwmon_data = {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


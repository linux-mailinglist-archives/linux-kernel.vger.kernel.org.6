Return-Path: <linux-kernel+bounces-513987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56301A3510E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A2E3A67A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E8F26E14E;
	Thu, 13 Feb 2025 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kjh5NL7/"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64326B0A1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484886; cv=none; b=IVErIDh+hjclb5pjJ8KtT2aF1vyAR3afK+YACLIgIk1XduJPi8GbvdYs+nadBuTTPTqSZGuHw1d/zbDTwlGYvDVb63QSuB+wnSa0++E/0gaORIzqnH85ckDX6YqgAuQ4e7ikLFGd42JvMcXme+/TSWXArdZOJ6NXbhWKwKn3YUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484886; c=relaxed/simple;
	bh=SMGkvZkCZvqG2ktEbJEc7YSfHNgKF1p1/msOSxsKHwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEoLOWESYTGpjwbLh06KNvlXmcKgXzZee2Ix7uTncRfDGoXD2HwSAbNK7oYvLhAK6ZHLeXjNtnRETpRjxZsBl/6sw3jk5UscMVBBuaEZoMxn4csEjaILRfx5J+h2kY7g1NkyBKtJ03Fo4ylNtyaUFQ+KPdxLJqbxPg38m3pcPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kjh5NL7/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54504f29000so1384503e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739484882; x=1740089682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbNV/3b+ye98We8N2apWnRnzXmdzQBqHfwo/QAVSKao=;
        b=Kjh5NL7/AjJU7+LbN1hLI1XntGAe3IlH6SrlDv7jRtYvVfdIUcmBOFwqurvGa3uDJC
         E48rBLD/iycQaSabxG0xg3AHu3/GKVsVKan5bRPD8RotYg0Cf6hfcqgUOWsP74kinlF2
         v5NlGXs1eqLPH+lvbLXFNO6hPBnmT1RNSWRSBqFFw7dccjmpol3CSXuU5JWXKM7+UN4c
         PIuCk1ph/Ijp9fI87VlY7D2JrhoDpEl1Uk4/aMVebEQ8AbmQZgUrr7CYZSSZC5m7VGaQ
         AM87Cmt0j/B7969/QcxH9Ky+9/az7E598M/eFGg+z+S4+R+65aFDJHe1LjmiaW4FCMk3
         CIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484882; x=1740089682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbNV/3b+ye98We8N2apWnRnzXmdzQBqHfwo/QAVSKao=;
        b=NR6OvPBXKvxdPl+S788yQlCUICvGmsvWAE1OvWtR3z3lsyFv98Xtn2rngSIlNb7o2x
         yDgDRWdPI0IGBC2U/VahoKexa7fSo2IDnk9otpoZtKwlfcaO+mz9Lk2EFmZc4/w1wJC6
         vzgAgT7muNI9L2Ad9gbTLmw04wXMxiTNvOiFLENzIx46LOdUj6jGxLBpSpx5lmo2Iudk
         39dtXx5Zxrto/r7FFJvY08Q1wrtWn0/1WsW3b2CJtK3QzNCRfzSdKO8mzJA+NRExuQlp
         ERjk/LcGg9bwng9e/OyL+4EtRp2qJnBCvozCgqOQvH4N6IYeHv/PLBsLCq5IRQ/cJzpS
         lNmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU35xEs54LKj1xkOZMj9U9FEqfsmkX40+oL3MUADuJ52TTuxB0yHmWJpSgGFkN1sM8vAR4CUIAAg3zUbJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVx/kH2l/8gBUvBgVE1a/QVdgyyNPThyby0kPMJGTw0iyWY2O
	NLUlW/HaRW5cGEeuVwtRo3sXnCzewGNqRzle2zSlgZ73c7w1pk+fRwmvEwe7C0DUOPRJsnSHEjD
	I2gc=
X-Gm-Gg: ASbGncv/5zM32r2Q1pH4rDXA622d86pkCwgBSB4rqrKSAWefmqd1NYWYwmz3oCaqsmD
	9eunYQstCgmShkcRe10diM2tVKbJ48mibYmGi0t2t6wYIVMd2hrguJeYOxIJs6vfLSlNOsTHiL/
	LviUnuYPFe+s2eT2hUv9eTtSQRfOOQNrRsEYwfx7IjpU+ZAF3/nh1lTQehAgHwIzgYu1BzO5S+f
	SKKYGnv/58hxknIfu+yBtAWZo3AuAkfKTDqIQZH9Dg+XvutXVS4e2moIb8VIstFUxLge+ykCqcD
	MNHWFf9e5VH/i5rb+CrB79TeVboovqv7cTGwJkpwegFDT38JyuuGzK9FMuBK3TIA1Aj2EbA=
X-Google-Smtp-Source: AGHT+IHncmb7iXd7qOxLGrJgwFbp8mWCOblbfNMb7p+RCa4lr5PqtVfqFBy6rnhu20ZbF5clhirijg==
X-Received: by 2002:a05:6512:3b24:b0:544:c36:3333 with SMTP id 2adb3069b0e04-545182933c1mr2974520e87.30.1739484882297;
        Thu, 13 Feb 2025 14:14:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309181d9c6esm1418661fa.40.2025.02.13.14.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:14:41 -0800 (PST)
Date: Fri, 14 Feb 2025 00:14:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Johan Hovold <johan.hovold@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/qcom-pdc: Workaround hardware register bug on
 X1E80100
Message-ID: <dvo4loo63prbrjm57vu5dcre3eo3onuni7fzucobcbjdhr5wmt@mbgm2kxi6osa>
References: <20250213-x1e80100-pdc-hw-wa-v1-1-f8c248a48cba@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-x1e80100-pdc-hw-wa-v1-1-f8c248a48cba@linaro.org>

On Thu, Feb 13, 2025 at 06:04:00PM +0100, Stephan Gerhold wrote:
> On X1E80100, there is a hardware bug in the register logic of the
> IRQ_ENABLE_BANK register. While read accesses work on the normal address,
> all write accesses must be made to a shifted address. Without a workaround
> for this, the wrong interrupt gets enabled in the PDC and it is impossible
> to wakeup from deep suspend (CX collapse).
> 
> This has not caused problems so far, because the deep suspend state was not
> enabled. We need a workaround now since work is ongoing to fix this.
> 
> Introduce a workaround for the problem by matching the qcom,x1e80100-pdc
> compatible and shift the write address by the necessary offset.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  drivers/irqchip/qcom-pdc.c | 51 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)
> 
> @@ -324,10 +357,21 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>  	if (res_size > resource_size(&res))
>  		pr_warn("%pOF: invalid reg size, please fix DT\n", node);
>  
> +	if (of_device_is_compatible(node, "qcom,x1e80100-pdc")) {
> +		pdc_drv1 = ioremap(res.start - PDC_DRV_OFFSET, IRQ_ENABLE_BANK_MAX);

Please mention it in the commit message that you are mapping the memory
outside of the defined device's region.

> +		if (!pdc_drv1) {
> +			pr_err("%pOF: unable to map PDC DRV1 region\n", node);
> +			return -ENXIO;
> +		}
> +
> +		pdc_x1e_quirk = true;
> +	}
> +
>  	pdc_base = ioremap(res.start, res_size);
>  	if (!pdc_base) {
>  		pr_err("%pOF: unable to map PDC registers\n", node);
> -		return -ENXIO;
> +		ret = -ENXIO;
> +		goto fail;
>  	}
>  
>  	pdc_version = pdc_reg_read(PDC_VERSION_REG, 0);
> @@ -363,6 +407,7 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>  fail:
>  	kfree(pdc_region);
>  	iounmap(pdc_base);
> +	iounmap(pdc_drv1);
>  	return ret;
>  }
>  
> 
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250211-x1e80100-pdc-hw-wa-b738d99ef459
> 
> Best regards,
> -- 
> Stephan Gerhold <stephan.gerhold@linaro.org>
> 

-- 
With best wishes
Dmitry


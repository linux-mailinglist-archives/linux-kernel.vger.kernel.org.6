Return-Path: <linux-kernel+bounces-412928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4749D115B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6315283DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9141AC43E;
	Mon, 18 Nov 2024 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixSaVm8A"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD421AA1D0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935000; cv=none; b=ir0AjJcmgvXnNu4Kq16Ibza/GO/AgUDm78scHf8nIHnwG/KuTqex4b2GbZAFH7dAae/vmGkWRDo1y3QpCjmBOzDN2/xHkBYahJl7B5UGBiiyS4Ms8Ai/3xE2uIw4Aw448KMEy0yAjA7g80V5eHp0No64x0uVQu/rGCytgJqZU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935000; c=relaxed/simple;
	bh=4S1yj6D8n9xTzysddADwluvLVjQoCCuayJpjFaeuwUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZg+zW2089wQqVb3tbnJdni+sRnQ/Mbq/spoTansTypuN6yA8z7FCVS7PsAHoKXuB3iB9r7VhW5cpnWCjTEw4shl84gS4Xvk4ha4mpEho8bstT26z/UW5b4ANPUS7kDHeaK/IzxBg/JwmrDKNPHOSwsrji9F45epRyF4wIAUerc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ixSaVm8A; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53c779ef19cso3636340e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731934996; x=1732539796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qPQYHCecUB6gZDvxkmvxtfaY7PsTEfXFdnw9uFXrBvQ=;
        b=ixSaVm8AeFJteBNBLM4yKL6LsNrayKaccabwRNwkK7wtWOwTQYEvwC5ViWBhIQQLXR
         aJcT3wB9YgnJmx/C4gIWryk4iu7/e4e5kh8LQz95/OFL0vLdTJRu81OWO8BfQiifjlQN
         jgzjEDkgPOLdLu6iROc4bQEDAmoCrGypcdnemnt3ErSCWL3Hl+epOT1/dHTsrV4vNXrk
         4o0UoA4fRUer/k/IpEzxpGlqrnOEkI13KMeGS4MCpSFYwjHaVsD4diqftDpuqfeyc1cf
         N0VDKx+aHXGd0sbkGDvi5RRieCClNTFhu8+yrwhqs7gD4FTBux53t5Of0LpIrnJCguLT
         dlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731934996; x=1732539796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPQYHCecUB6gZDvxkmvxtfaY7PsTEfXFdnw9uFXrBvQ=;
        b=oR92mSITp2wtzNIkh2vy6jHj6WTgx9G2mGIozAIhyT8y24Ns/fRAUDf9UcYbIvDokh
         /5nePckyiUGA25h2sGEVl1jf6Gp0QlzwDL/GKy8tSpOkXHRzVJhUvN7tgwkXCyws+i5V
         JqPOIy+YPcKRrFEoZz31+zORIIKG73E6F6NjfP0qxhmrNtXDJG2V2JyU3f7XMx2rtl9L
         Cc78VEBan4sOt4bwM4FGQwxMPW4zr6CJWrcNUTJMPfNsbb+26bWrVdeJKXgb+6yXoQ7G
         uAc8G4gqs5fKjROag2DJLX2iwBtok9cfC77tCgDiE2UiWePU89yUkwpVW+EalF8FMR/f
         1uxA==
X-Forwarded-Encrypted: i=1; AJvYcCVZc9bJACD+aaakurjIaboSwSz9jLpMWtTCMIH4WMhEWq3qNYr6Tbr01hVwpBQrzPfoLvUya79ej2QNpbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxa4QjlT4npQxY79lVt61bZf2SJkVgchAkV1gql6NWwnwiVchk
	smR0fMYDl07RQcaYSgX6kWpDrfJgmjS9au7MRDZaxYi2kGKo9n719DG8uXg1QAY=
X-Google-Smtp-Source: AGHT+IHCtcPfqdDo63JVjFZLu6nUCmFGqB7Ru0IT9/fdlLVlgUtoxdVwZ+BrziK8/If7+6YhMMbKgg==
X-Received: by 2002:a05:6512:2350:b0:539:9f52:9e4 with SMTP id 2adb3069b0e04-53dab3bfb25mr4119393e87.48.1731934996192;
        Mon, 18 Nov 2024 05:03:16 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da64f2ba8sm1587542e87.6.2024.11.18.05.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 05:03:14 -0800 (PST)
Date: Mon, 18 Nov 2024 15:03:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: qcom: common: Add support for power-domain
 attachment
Message-ID: <xtah7t5fvixbvuukkzthvq7p7crmwujqxnuuvddihzibxkqlyt@bxzvdwkigf6k>
References: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org>
 <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-1-b7a2bd82ba37@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-1-b7a2bd82ba37@linaro.org>

On Mon, Nov 18, 2024 at 02:24:32AM +0000, Bryan O'Donoghue wrote:
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
>  drivers/clk/qcom/common.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 33cc1f73c69d1f875a193aea0552902268dc8716..b4377fa09f7c0ec8d3c63dfc97d04fbb8cd6e10b 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -22,6 +22,7 @@ struct qcom_cc {
>  	struct qcom_reset_controller reset;
>  	struct clk_regmap **rclks;
>  	size_t num_rclks;
> +	struct dev_pm_domain_list *pd_list;
>  };
>  
>  const
> @@ -283,6 +284,25 @@ static int qcom_cc_icc_register(struct device *dev,
>  						     desc->num_icc_hws, icd);
>  }
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

I don't think it is enough to just attach to power domains. We also need
to power on some of them (MMCX) in order to be able to access clock
controller registers.

> +
> +	return 0;
> +}
> +
>  int qcom_cc_really_probe(struct device *dev,
>  			 const struct qcom_cc_desc *desc, struct regmap *regmap)
>  {
> @@ -299,6 +319,10 @@ int qcom_cc_really_probe(struct device *dev,
>  	if (!cc)
>  		return -ENOMEM;
>  
> +	ret = qcom_cc_pds_attach(dev, cc);
> +	if (ret)
> +		return ret;
> +
>  	reset = &cc->reset;
>  	reset->rcdev.of_node = dev->of_node;
>  	reset->rcdev.ops = &qcom_reset_ops;
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry


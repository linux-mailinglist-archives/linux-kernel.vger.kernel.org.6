Return-Path: <linux-kernel+bounces-390965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC6D9B8099
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E42BB21B54
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6A31BD4F7;
	Thu, 31 Oct 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qYh75Y85"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C681A0B00
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393481; cv=none; b=FggvMaCHqyGlHmQS23j5ZaI6riV5th9WPf6kXmdCSMfzbe2LcqAZ419P0jo09+K4wNx4pgcO2QFU+TM/MZzmY60lE/KmuYweEXxqQ1MtDzy4LipmVf7DH0KhQWbbp/3WEwLAzXBeha/3kpeYGkx6Zs41ynxNWLo8g3nUCcandZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393481; c=relaxed/simple;
	bh=9uF7kIftGSAOjKQHDNRn+MgvU0s5zXO+r+o+MTNjWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtBOCcPsUp+uyAFZ2DVErg+cUZrAwOZzNeuyGLpHP6a61sIdhmaUcgIOGyoPMvrtHwcdbQSQ4zgzMvlcIL+A93ZPTAChd4lpcvwseaXB+0kQ1kBD95Ngew2Dpphtkwj1rEtqcPHbZ+Qr8vChXKsDS+64XwbRJFc4EcrlkP6CJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qYh75Y85; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so1515486e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730393477; x=1730998277; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dElgT7L0zt3rmbay8fKLvEkV5UCNYIrNgV99r1etM3E=;
        b=qYh75Y85eonpzxu4UAkQSF7s+KYM+FxzJ9A3o/U38is93EaDjndATj7N4T78KSFShE
         7IFLENVQBB05evSPJFWWWRRXCza4WQfaCXoZjdXXaCk5ko6VSVC62CT2iXWpvTFinhym
         6P56GXPjJ/Fi/X8fieY0CUEl2ic3StfpRgw0AV92+hQa5XaY9ujXubjtIJq90iJFd4fl
         2v8Xbpg6dc8QuHVMXNeZl2x81Jzwlvi39nDAXMmKrA/KVE3l7RSIxSLP5zsSM0/jG8Wx
         JcAZ0fj3LLx6uUHn9QWhcMAHw2RjLcLj9eVFfN0VA8T5YMTqDQclVhO6JE9Uj/W2cveH
         5Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730393477; x=1730998277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dElgT7L0zt3rmbay8fKLvEkV5UCNYIrNgV99r1etM3E=;
        b=WrEOky+jCpsvM4JpHzAt4ihImj41BO4CjSSSiGaDKkNjIN0jO4Y+6H4IYrAhKEiK9R
         4CmCBK9qAoBUsG8IksVZLbLMgX5XfI1jEg7Ye9qou574EL5dwmnsaZpqZ05tcdYyOJjd
         r4rFWBeONmCiJSAg5K/I7HyEvmkkbKWYpgNqGPXTmqDApYm1UkvsIJdlEVbGrG5mEdlg
         MadIbXfArqCmLmswJ5zLlJNih7/2len3DReO63G0nYTwIGoNzRBFEo6jrl/gvm8WFofe
         jUYKlkdZaG3MFxXGKYhlkmVOeM0dBX5qQgGT0oobr7NU6rbMWmGHHnfeLLfDPF59xBjP
         qfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmov/24euf0wZBCiJR9xgV0FC+2VKAnSxCZ+quicY+zOV37bhW/AQq/pefkeQU9PkUYEcutzl5bKpBghE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0HIWOpFjR3NkvOP9esNcPnHG9AALUttCKgfnPIHw24rInbpUs
	KHEZ2RAbh5KC5LzvLrHABLiRLBfllUVGI38HBS/xG6h6mRiCcLmZtwKne0PB6EY=
X-Google-Smtp-Source: AGHT+IFBdgNmYFRwHU2uHUqUBdL1py3yIhuOmcLZEkX5lLCzBxA/ASmXrl7QfGHc2PZxttejJESocA==
X-Received: by 2002:a05:6512:3d05:b0:539:df2f:e115 with SMTP id 2adb3069b0e04-53b34909ffamr11186732e87.23.1730393477021;
        Thu, 31 Oct 2024 09:51:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce60esm255270e87.124.2024.10.31.09.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:51:15 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:51:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: loic.poulain@linaro.org, rfoss@kernel.org, andi.shyti@kernel.org, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v3 -next] i2c: qcom-cci: Remove the unused variable
 cci_clk_rate
Message-ID: <jt5d3473zg34yhgykgqftlvk6fqekankuyjj57uxl56sqa3xvm@nvfv7kwtcwex>
References: <20241031095339.76535-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031095339.76535-1-jiapeng.chong@linux.alibaba.com>

On Thu, Oct 31, 2024 at 05:53:39PM +0800, Jiapeng Chong wrote:
> Variable cci_clk_rate is not effectively used, so delete it.
> 
> drivers/i2c/busses/i2c-qcom-cci.c:526:16: warning: variable ‘cci_clk_rate’ set but not used.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11532
> Fixes: 823dfb7bdb21 ("i2c: qcom-cci: Stop complaining about DT set clock rate")
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v3:
>   -Modify the commit message.

Modify how?
What was the reason for ignoring the R-B tag?

> 
>  drivers/i2c/busses/i2c-qcom-cci.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index 5cc791b3b57d..a0ef43e99751 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -523,7 +523,6 @@ static const struct dev_pm_ops qcom_cci_pm = {
>  static int cci_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	unsigned long cci_clk_rate = 0;
>  	struct device_node *child;
>  	struct resource *r;
>  	struct cci *cci;
> @@ -594,14 +593,6 @@ static int cci_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
>  	cci->nclocks = ret;
>  
> -	/* Retrieve CCI clock rate */
> -	for (i = 0; i < cci->nclocks; i++) {
> -		if (!strcmp(cci->clocks[i].id, "cci")) {
> -			cci_clk_rate = clk_get_rate(cci->clocks[i].clk);
> -			break;
> -		}
> -	}
> -
>  	ret = cci_enable_clocks(cci);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.32.0.3.g01195cf9f
> 

-- 
With best wishes
Dmitry


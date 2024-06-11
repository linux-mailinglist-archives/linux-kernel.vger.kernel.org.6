Return-Path: <linux-kernel+bounces-210381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FC0904303
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E25283A73
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851535B5B6;
	Tue, 11 Jun 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QEbshTHg"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E0C58ADD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128706; cv=none; b=phhsV2ERmcfn2ZL7DNIm+MVcuTPKF0Xi3/hS4V3nA7L4hsWMhnWDZv0hicwRjaeOdO9u4YKt9j54OzFOc7vOZ5rv5A9fk64iLYmgHaQOo1CrzVYRGkTCLuk8SgQN2FvJNWV1b1fAZZodmK/LZvhJtMR/xizAcVfIb2S7QI97XY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128706; c=relaxed/simple;
	bh=CR0Oj0XOoZ7y22JghqczjZrf/GTITEydKBz1s5DymH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJKMk7msDTNy4oDgqYmcGq7Yg6opncqlgAB+Y+Il/0+s2s51Q+iAe6XCJ6V4nHMH187BZT+VCyszAGCEzFEQVpK0J4LgHMHs6C7dbvxMsmcUwvQHITJKupZBF/kQ5c3Ll+mKVzBywMlQ3dvZco2DosXJQeLs/q/3eVVhTCteygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QEbshTHg; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7046e87e9afso1158514b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718128704; x=1718733504; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1mU4E5MR7G8MdpFb909SPM49zIumrpDBhQvKM4R8Il0=;
        b=QEbshTHgnRoRzO62I5ZjBteygGo7Ma9Rv7YYUkIDX8V5NMAGcQ6hgWBEh4FCK+PTpo
         Wr0vC1IvsvxX7L7jqgdY0qsneRjX/xAXvnRXSr2JWasK75fOOFIf2QczxOn5m5KM/xxT
         Wdn0Tk5qzg7mFR7F/IpMovSvZirwySfPrDjbBtlnsx/VThHsJEouCqGFjPD5sQNAsNVs
         VdwYE/ls6VMOpYjbcE4Zy6uvVg3txsVOuWzKxnjtifQ/Z7PdeIsXS/4ZZdQ6atYnRsRy
         I05t+0/UwWVR/YDqWsm4lFWfii0Icb6mT69BVKr/PHGjlH3xVlwdveOI+QyWFE9bGHVR
         Tqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718128704; x=1718733504;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mU4E5MR7G8MdpFb909SPM49zIumrpDBhQvKM4R8Il0=;
        b=pBFSbnHXy1sJqoou2oxFBdNdxbFTO6j8GdtR7K5ohS/IMq1vH7Y9LU+qRAqodU9pB6
         p7XWyoCoQdZYn9RizHKMsEJnsvNhZd+amDDtYkm9vxyWue10wHhQNBoHeeioKk/g/ZUa
         RSsZRxj+QHg6vIgAz146pg0hVt8rjx+bRFJDbBdJYfAtOLoBPOyu+fGngkqOKOquSZ8f
         NrX56j7AJVK4vvTqOO3ZddLD6SFs9+7XjngWFgC2rsZe8fhRbKjNwm1phidTB1YbiM6A
         TI85v/Hn0V6xcsPO7xC3emmskcDhYAhB+QZkBnE/88NTU6QDsCbbURY+tqCqrUx8sHhU
         qRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4elvOlT0rwdI2PZozmljVGW1YSWCZ6UWsV60bUjcYjufEFjGaTPADBYK00ODUcxXQrGTEt+hUCPUaZ7JGyWzCI1S1ulb/mKaRblGe
X-Gm-Message-State: AOJu0YxYQrZsQG09sg9duVlngfdSuJCw9VRGRHXN1lI7AH9VHTmuPQq+
	D0ExFJURyToeEblG2gv816jk2ONjo7mBa0VBSd6TnQycujhoiXCW2UJBL+jez+Q=
X-Google-Smtp-Source: AGHT+IGV99rF9+F+Cf1PyBfibxQMwpPQeXSdH+G1wwDCeMYhzDOe4MWoLKpCLo8WlpBJQZWUdPTHOg==
X-Received: by 2002:a05:6a00:cc5:b0:705:964e:d9f3 with SMTP id d2e1a72fcca58-705964ee540mr7310001b3a.11.1718128704355;
        Tue, 11 Jun 2024 10:58:24 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:74af:2f2d:5f50:e6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd512e3esm8763123b3a.201.2024.06.11.10.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:58:23 -0700 (PDT)
Date: Tue, 11 Jun 2024 11:58:21 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Hari Nagalla <hnagalla@ti.com>, Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] remoteproc: da8xx: Use devm action to release
 reserved memory
Message-ID: <ZmiQPSvdkGzt6/sB@p14s>
References: <20240610151721.189472-1-afd@ti.com>
 <20240610151721.189472-5-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610151721.189472-5-afd@ti.com>

Hi Andrew,

On Mon, Jun 10, 2024 at 10:17:20AM -0500, Andrew Davis wrote:
> This helps prevent mistakes like freeing out of order in cleanup functions
> and forgetting to free on error paths.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 29 +++++++++++++--------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index c8b7576937733..1ce91516fc6e5 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -233,6 +233,13 @@ static int da8xx_rproc_get_internal_memories(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static void da8xx_rproc_mem_release(void *data)
> +{
> +	struct device *dev = data;
> +
> +	of_reserved_mem_device_release(dev);
> +}
> +
>  static int da8xx_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -293,14 +300,13 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  				ret);
>  			return ret;
>  		}
> +		devm_add_action_or_reset(&pdev->dev, da8xx_rproc_mem_release, &pdev->dev);
>  	}
>  
>  	rproc = devm_rproc_alloc(dev, "dsp", &da8xx_rproc_ops, da8xx_fw_name,
>  				 sizeof(*drproc));
> -	if (!rproc) {
> -		ret = -ENOMEM;
> -		goto free_mem;
> -	}
> +	if (!rproc)
> +		return -ENOMEM;
>  
>  	/* error recovery is not supported at present */
>  	rproc->recovery_disabled = true;
> @@ -313,7 +319,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  
>  	ret = da8xx_rproc_get_internal_memories(pdev, drproc);
>  	if (ret)
> -		goto free_mem;
> +		return ret;
>  
>  	platform_set_drvdata(pdev, rproc);
>  
> @@ -323,7 +329,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  					rproc);
>  	if (ret) {
>  		dev_err(dev, "devm_request_threaded_irq error: %d\n", ret);
> -		goto free_mem;
> +		return ret;
>  	}
>  
>  	/*
> @@ -333,7 +339,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	 */
>  	ret = reset_control_assert(dsp_reset);
>  	if (ret)
> -		goto free_mem;
> +		return ret;
>  
>  	drproc->chipsig = chipsig;
>  	drproc->bootreg = bootreg;
> @@ -344,15 +350,10 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	ret = rproc_add(rproc);
>  	if (ret) {
>  		dev_err(dev, "rproc_add failed: %d\n", ret);
> -		goto free_mem;
> +		return ret;
>  	}
>  
>  	return 0;
> -
> -free_mem:
> -	if (dev->of_node)
> -		of_reserved_mem_device_release(dev);
> -	return ret;
>  }
>  
>  static void da8xx_rproc_remove(struct platform_device *pdev)
> @@ -369,8 +370,6 @@ static void da8xx_rproc_remove(struct platform_device *pdev)
>  	disable_irq(drproc->irq);
>  
>  	rproc_del(rproc);
> -	if (dev->of_node)
> -		of_reserved_mem_device_release(dev);


This patch gives me the following compilation warning:

  CC      kernel/module/main.o
  CC      drivers/remoteproc/da8xx_remoteproc.o
  AR      drivers/base/firmware_loader/built-in.a
  AR      drivers/base/built-in.a
remoteproc/kernel/drivers/remoteproc/da8xx_remoteproc.c: In function ‘da8xx_rproc_remove’:
remoteproc/kernel/drivers/remoteproc/da8xx_remoteproc.c:363:24: warning: unused variable ‘dev’ [-Wunused-variable]
  363 |         struct device *dev = &pdev->dev;
      |                        ^~~
  AR      drivers/remoteproc/built-in.a

which is then fixed in the following patch with the introduction of
devm_rproc_add().  I suggest doing the opposite, i.e introduce devm_rproc_add()
and then get rid of da8xx_rproc_remove() by introducing
da8xx_rproc_mem_release().

No need to resend the omap set, I have them.

Thanks,
Mathieu

>  }
>  
>  static const struct of_device_id davinci_rproc_of_match[] __maybe_unused = {
> -- 
> 2.39.2
> 


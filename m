Return-Path: <linux-kernel+bounces-285114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE007950989
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AB3FB26196
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F11A08A1;
	Tue, 13 Aug 2024 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OlhHEa+Q"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58EF1A0729
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564512; cv=none; b=dMl84Hcu7SAvutDIStudZMoEJnw2xxu56zfSCRk3HbVsl3qYI4AiORc8jX3GuS91/BgLbBO7JLeNjWYs9qF0j3RI6S+5nxCgttnGFKgNmgvffmwWlXLG9UN9rznkeqeXXbTi2TJ31W/zc5qrC5ORgP1Os8pQQX6LZFCHNbtkkw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564512; c=relaxed/simple;
	bh=ofzzO/MDsGwGtQPGj1xQIn1dKHbuD3rWUlrc0rP5vzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuOpZuKVVqM3r4eEc3JBcomc2mdVTVAwq2lO17XmzLFFgB2Fuedw5fEuLOPeFhlg/NjbcO4LNp/orcPKD1j/y/daYR+L2oRbhWVh/ylo1nArUN+KkuN4w1bb4k1zknE815ezVTJ2XmiF/oi07RgTsgRGDiULmC712EQkeaX1MPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OlhHEa+Q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd78c165eeso45164075ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723564509; x=1724169309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XA69NfodEyCttT6a+GrneJTF8uIIfegjqkueNkAJX18=;
        b=OlhHEa+QUH22Kg0KKji9HZSAHrncprzcurOYQqWDHT9KMKI5Fwg8ryT6g8XrzB7kK0
         BflecDhnkalJJokAKchgRmC5vYHQ2hUVnmhQTUOxoDQEhNNKZNwxyHi49Kg+tfzeOyZr
         3tp0UD0Cg7nlAyfpKjIfJnDuBsIiu8bh/qkXJIOqsJ49nzJw7pWuR65GwptsOv5uUrg9
         ByJ96ORctt0LETNt08zKVgjC/qPkuYU8WS9NYKpAnEMUM0w+GE7YN24/5uOJpweEZ9aw
         sEMb4Y7oQuSb5tx2XsZwMFnsS45KnUNFAw69K2ocp94nF/qTB2lXEIfk3TDVUl91P3El
         mShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564509; x=1724169309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA69NfodEyCttT6a+GrneJTF8uIIfegjqkueNkAJX18=;
        b=rPDeaNRbjrEV7bFoqaK98Hb6Gso+rfn1mZVN0Un8J5GkAL0iwlrY2o36vJemriDNY8
         pJp6EV7TPDoMMTkWHVmRtRQNHSFcOmr/ou74ts/n/hJj0dofsoOvwCbphgqCnAxx+3IN
         xtSP7EkqddfiKmsq1f8+WFWPQ7gH69zB62QA4Q1N/6SxcHOwTgQs5Kh+BaBWcXyL+kB1
         FCxU+VRN88Wp3rc9/QVG2fvW6vcG39xs1UrVE7aZZh2pnQ0hip9sTXmhAc1pf9wfoyaB
         JIz+T8yHf6OyHL74UWZMSMR9kKQKkUYNKKU1jVZpqCM/OF57Q0/zHn4z4Mijp9rEwG07
         +Cvw==
X-Forwarded-Encrypted: i=1; AJvYcCVe3qdpKvMAmSnyZPu7BoGZfGy9N3E8apT0BxFgp54k7/SJGx7ifqsFZDug9ZLwYARJ9qryBHe2eWkexlrlkO6R0byjJjPFNsFvbu4D
X-Gm-Message-State: AOJu0YzyS/zzzBSXmTCusYnoOFiGG63F14LcwUEnK20PESdtr86Y7M4D
	t4lQ0RoAmCTJSrrBpw5QnxTk/6fp7mBbHbkK0Fpvc0rYieeC9QJt4nQw/TSIxkI=
X-Google-Smtp-Source: AGHT+IG9G6M+t+VKPSzwKnxIYBB8RhmRRqGfZJq4Bi9ZrcsR6TvNvFeeyp7dUt+EdE/zkwku9m48sA==
X-Received: by 2002:a17:903:230a:b0:1fb:a38b:c5a7 with SMTP id d9443c01a7336-201ca185904mr58149375ad.13.1723564509168;
        Tue, 13 Aug 2024 08:55:09 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:d596:d55b:d99d:7ece])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a93d7sm15220855ad.149.2024.08.13.08.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:55:08 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:55:05 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Hari Nagalla <hnagalla@ti.com>, Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] remoteproc: keystone: Use devm action to release
 reserved memory
Message-ID: <ZruB2VhA78GRWG9X@p14s>
References: <20240802182300.244055-1-afd@ti.com>
 <20240802182300.244055-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802182300.244055-3-afd@ti.com>

On Fri, Aug 02, 2024 at 01:22:56PM -0500, Andrew Davis wrote:
> This helps prevent mistakes like freeing out of order in cleanup functions
> and forgetting to free on error paths.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/remoteproc/keystone_remoteproc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
> index 8f0f7a4cfef26..033e573544fef 100644
> --- a/drivers/remoteproc/keystone_remoteproc.c
> +++ b/drivers/remoteproc/keystone_remoteproc.c
> @@ -358,6 +358,13 @@ static int keystone_rproc_of_get_dev_syscon(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static void keystone_rproc_mem_release(void *data)
> +{
> +	struct device *dev = data;
> +
> +	of_reserved_mem_device_release(dev);
> +}
> +
>  static int keystone_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -434,8 +441,14 @@ static int keystone_rproc_probe(struct platform_device *pdev)
>  		goto disable_clk;
>  	}
>  
> -	if (of_reserved_mem_device_init(dev))
> +	ret = of_reserved_mem_device_init(dev);
> +	if (ret) {
>  		dev_warn(dev, "device does not have specific CMA pool\n");
> +	} else {
> +		ret = devm_add_action_or_reset(dev, keystone_rproc_mem_release, dev);
> +		if (ret)
> +			return ret;

It gets sorted out in the next patches but we still need to "goto disable_clk"
to avoid git-bisect problems.

I have applied the first two patches of this set so no need to resend them.

Thanks,
Mathieu

> +	}
>  
>  	/* ensure the DSP is in reset before loading firmware */
>  	ret = reset_control_status(ksproc->reset);
> @@ -459,7 +472,6 @@ static int keystone_rproc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  release_mem:
> -	of_reserved_mem_device_release(dev);
>  	gpiod_put(ksproc->kick_gpio);
>  disable_clk:
>  	pm_runtime_put_sync(dev);
> @@ -476,7 +488,6 @@ static void keystone_rproc_remove(struct platform_device *pdev)
>  	gpiod_put(ksproc->kick_gpio);
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> -	of_reserved_mem_device_release(&pdev->dev);
>  }
>  
>  static const struct of_device_id keystone_rproc_of_match[] = {
> -- 
> 2.39.2
> 


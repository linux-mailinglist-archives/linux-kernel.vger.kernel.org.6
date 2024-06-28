Return-Path: <linux-kernel+bounces-234557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A0A91C801
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06981F22DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B777D3EF;
	Fri, 28 Jun 2024 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w6lGdzN6"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53776025
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609523; cv=none; b=Z48la1KjSo5U6uJOLdgFiCSw/EdbO+sNtS2IvLkAm88ABCckRSuG9bsm9RMecoj5JQlZV7RHxu+gf6E/uRIZnOKTBP5lGWUSHjVgY4IXzGrWNAiVEUFtO50iAyGa6z+lvXcaUnTilhfy0l879FaU2XttGkjUw0mZdK8xaqxFryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609523; c=relaxed/simple;
	bh=kHxWFVlmNHWAQf1QORSIdifFf5Z7ya20L13GAczi/nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnSt/YCgzFYr2sM8ly8Vn4uWryix9Q/Zo3/9cEhxwVCAcimztoWrDfgNXvfaCAMQJFZRU0xyamqxIOGkzbbbK0Dla+hLTAe79flNfuKoyfexZrUh5eX3xsRceHdmTkNmUOEygrBFbzCO37k7WCVO3F364JQdrpMlC3HOJPLGRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w6lGdzN6; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c21df2d0a6so490937eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719609520; x=1720214320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7RDdRnu5U6agoCXx+bt+KWtAlm7zdXncLje7eabaTM=;
        b=w6lGdzN63vkwP7tDgEHZvVT+r4qkD87QSgOrtNJRg6hlzMY3t8TSi3keodHdvgzmvu
         22P/Co0BygKTjppRb/5rMgU2EpbxliqOX+yDk6DJDkK1UZVWkU7RPJDVzkgOglTh9rqq
         W9X5pIpll5pKZGwVd345gHYoCB5Gq3mjt2AjAqnsE65abPHUSTxjxT5OG2wg0WmJiC4C
         0nfzXRXoFTLUhWQP/3Kdh943r6DBl+Hz4jEB6rcw6PK14CRaV4cLgHGaEkmUDkARBB/r
         ybgWjuYqmWbr1DvI8w7Vv732/KUMLclHHwQHJ0amDE686tPj0cypAo0/74lgJOCYkACp
         rGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719609520; x=1720214320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7RDdRnu5U6agoCXx+bt+KWtAlm7zdXncLje7eabaTM=;
        b=Xzvhl6QIzf+qS1w/v2p5KItiAPFyUPCbgW2D9igJyfDcMOArOC4W44Ez1saW+JL4SR
         vwSdePlxxACQXrNlpQ1gSsE/I6M0Ygir6Z7vMj1e16sxd+MfKR0ph2gzJ27lojceZ7Uw
         e7iRzpb6E++wW6af1BAml0EsCUtXqwIw+8LBuSZTdYw2Kl6Zrhi+WLFf9cDpafsqKwlH
         ni3C4wjiM65dQW+1QXrYwr8Z3w/aztn0HN5XT8FbCTV/7a3Ru7OCgDp0nEpPMSFSw2O/
         8PjTIWkSguKMckLNfZYfqChmJtm1pSK76URjw6VRoDC3WeQ7It+VeE+tQLy8fzinc63D
         /F+g==
X-Forwarded-Encrypted: i=1; AJvYcCVtLUXKUb2nvR110waoCuTB3YATFfNF4n4D22kC4AFaC7t29GQ/nI/TBK11hdBgODCOOTMcCEZyRC0hXijoc6r2sRMXQG8bAMvgwccJ
X-Gm-Message-State: AOJu0YxnqVgPHq0NWGrsGctnczBBz6zTjwnUquO5zKCQsZa27m+BZyTa
	xaAiC/FCR/ChVU6zNqdyA1fiKfPtRl5fIDJgyun0/QNHPGFTahvQuGyB0cgAAF0=
X-Google-Smtp-Source: AGHT+IFI2IfO4GAyS+D77AY5WcICSNCicQleQ/VFOi55ZTdWxGvITGied6rgwQkp/4Q4qX3pvU0HHg==
X-Received: by 2002:a05:6358:6f82:b0:1a6:4ef2:86ba with SMTP id e5c5f4694b2df-1a64ef28b48mr848766655d.4.1719609520580;
        Fri, 28 Jun 2024 14:18:40 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e53e:a53d:f473:181e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c7f76fbsm1699707a12.73.2024.06.28.14.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 14:18:40 -0700 (PDT)
Date: Fri, 28 Jun 2024 15:18:36 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Suman Anna <s-anna@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Hari Nagalla <hnagalla@ti.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] remoteproc: k3-r5: k3_r5_rproc_stop: code reorder
Message-ID: <Zn8orCbTx9VtA9Em@p14s>
References: <20240621150058.319524-1-richard.genoud@bootlin.com>
 <20240621150058.319524-4-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621150058.319524-4-richard.genoud@bootlin.com>

On Fri, Jun 21, 2024 at 05:00:57PM +0200, Richard Genoud wrote:
> In the next commit, a RP_MBOX_SHUTDOWN message will be sent in
> k3_r5_rproc_stop() to the remote proc (in lockstep on not)
> Thus, the sanity check "do not allow core 0 to stop before core 1"
> should be moved at the beginning of the function so that the generic case
> can be dealt with.
> 
> In order to have an easier patch to review, those actions are broke in
> two patches:
> - this patch: moving the sanity check at the beginning (No functional
>   change).
> - next patch: doing the real job (sending shutdown messages to remote
>   procs before halting them).
> 
> Basically, we had:
> - cluster_mode actions
> - !cluster_mode sanity check
> - !cluster_mode actions
> And now:
> - !cluster_mode sanity check
> - cluster_mode actions
> - !cluster_mode actions
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 1f18b08618c8..a2ead87952c7 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -636,16 +636,8 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>  	struct k3_r5_core *core1, *core = kproc->core;
>  	int ret;
>  
> -	/* halt all applicable cores */
> -	if (cluster->mode == CLUSTER_MODE_LOCKSTEP) {
> -		list_for_each_entry(core, &cluster->cores, elem) {
> -			ret = k3_r5_core_halt(core);
> -			if (ret) {
> -				core = list_prev_entry(core, elem);
> -				goto unroll_core_halt;
> -			}
> -		}
> -	} else {
> +
> +	if (cluster->mode != CLUSTER_MODE_LOCKSTEP) {
>  		/* do not allow core 0 to stop before core 1 */
>  		core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
>  					elem);
> @@ -656,6 +648,18 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>  			ret = -EPERM;
>  			goto out;
>  		}
> +	}
> +
> +	/* halt all applicable cores */
> +	if (cluster->mode == CLUSTER_MODE_LOCKSTEP) {
> +		list_for_each_entry(core, &cluster->cores, elem) {
> +			ret = k3_r5_core_halt(core);
> +			if (ret) {
> +				core = list_prev_entry(core, elem);
> +				goto unroll_core_halt;
> +			}
> +		}
> +	} else {
>  
>  		ret = k3_r5_core_halt(core);
>  		if (ret)

With this patch, the "else" in this "if" condition is coupled with the "if" from
the lockstep mode, making the code extremaly hard to read.  The original code
has a k3_r5_core_halt() in both "if" conditions, making the condition
independent from one another.



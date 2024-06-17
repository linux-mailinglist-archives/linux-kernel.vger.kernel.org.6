Return-Path: <linux-kernel+bounces-217767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B990B3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC90028CE84
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875AB15EFC2;
	Mon, 17 Jun 2024 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgZTHipW"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108815EFB4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635341; cv=none; b=oM+pTK/IF/PfdjLEggGH793Ey9RJkKU52PBamavVQDQYSTYgnMzNktr95Iu3X2FXQNXdXvl4kIk+LtZoQfh9lomOubFUpiw+SbrKFgQA6z4Tb6x+BP2G3dv1lFAI8XufwybvLKaVhiQls10DuRHrcq7+82i9ycUAMpO7ZTkc8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635341; c=relaxed/simple;
	bh=JR4bM3IEVw9/uptU8LIQo4w5Uach0rp8uHcOdCmDgt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sop10GKg2cLZKOQW0kKzaU8i3SvlLt30K+ezs5c73EYEARj9EDADrcfExkxAItzh6Ez4H7znveowP5xf9DYE35M/nT2zUzIqGFRyNme/ogOHoJSvCU1qs+EPI/ufeasVU2cQ4YmxDZ1Io+0dEc3UZ0KG4Jhl1l/zU149rdMh28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RgZTHipW; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-375daa47685so18153555ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718635339; x=1719240139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEZjeteQXfzQdcWVQrn0yV9Qj7kNGp+WUXl9yT7pJIM=;
        b=RgZTHipWzDLWD0NcP+D0ZnzLsnhYll/JN2zMyMyLtj1iXCdDpMeuBRtLrjHZ+i3c9h
         2RmcYtmBljwlstWIfPJHqVzY/Y5mjO1bm7D6tjTZTTj+vBiBcBEqzVfktDrbTlMXABsU
         Wl+QwuZhI8LM34WKbXFb/1p6+BIRVo0ixTwMLRk+wqeaAQQxB2CiCM5tR/brJunfzRx6
         /UwYyuKdCGMt8NgnFgAPhyydg5f4HOcOuakmEEQC/z7AsBr6h2cU102nkOMSGjsmxv9q
         /OrdEj2avr8eBbP0q4EmQd/PC1a4P+3Dea7TJXPCe3ASQxifhD6K7Ogt1sluyC5kgD6P
         APzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718635339; x=1719240139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEZjeteQXfzQdcWVQrn0yV9Qj7kNGp+WUXl9yT7pJIM=;
        b=Y5dQzeawQ9AlVDMRlWCdL3+jPdVAfkTD8ixJlHsIiSzhDFJhac4xnk+Ao3dp18aD+p
         kKRDtSEE3hTicOchs9i3SyGk2TFlnNsix22emwAKn6VTgAL0TKal4bJNTycGP08oo+iJ
         bm4zodcTcbo6b+2qum2sf7jSQyGZAPpCDXZniS5Pf7FWqx+aFDzQxQpcZ08hySKqVmRO
         n7yibqoPEL3m+Vmh+Xa5GvkN1crNuKB3wAqUyrL+nMgmiWfeBb1DbIzqxQ1IJBwQJm7n
         /rfa+iLaP3i7ITbC1Xvlcp5GNeGwjiV6JYClgbpv7GFZ51U6A79rwwLYvz4CD5+CJl/v
         mcCg==
X-Forwarded-Encrypted: i=1; AJvYcCWGnOlaIE2ZaAfsEqEoJ2JY7aeBgTQrZrEV3eJlYaghR86jp5yEGbOrNjoPzxM5m7de2gWKPFhJm4Y5m4PjcL9qCslRK0A2F97Tz0My
X-Gm-Message-State: AOJu0YxF1Da/QqseWEWjzfwupvxwHdQS4KLQYsLQ+Xolxg4kLkQifmU0
	B1K+Xo9auPZOsaWYdllB1bbG1N5jxRwQYFV7471gAUagXWMOwEGRtoRUMF2MAEM=
X-Google-Smtp-Source: AGHT+IEYXBLlZaTCF/KozlYWXmX+1dC92NpMDk5cKK1l7LyVT2phM7sLrhcf7MZdinEAwBHySA2uwA==
X-Received: by 2002:a05:6e02:152e:b0:374:8928:83a4 with SMTP id e9e14a558f8ab-375e0e30792mr118277925ab.14.1718635339363;
        Mon, 17 Jun 2024 07:42:19 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e681:7328:24ae:62a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fede16ad2fsm6720686a12.32.2024.06.17.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:42:18 -0700 (PDT)
Date: Mon, 17 Jun 2024 08:42:16 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Peng Fan <peng.fan@nxp.com>, Bjorn Andersson <andersson@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: imx_rproc: Fix refcount mistake in
 imx_rproc_addr_init
Message-ID: <ZnBLSG/Yy1E4A+Og@p14s>
References: <20240612131714.12907-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612131714.12907-1-amishin@t-argos.ru>

On Wed, Jun 12, 2024 at 04:17:14PM +0300, Aleksandr Mishin wrote:
> In imx_rproc_addr_init() strcmp() is performed over the node after the
> of_node_put() is performed over it.
> Fix this error by moving of_node_put() calls.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 5e4c1243071d ("remoteproc: imx_rproc: support remote cores booted before Linux Kernel")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/remoteproc/imx_rproc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>

Applied.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 39eacd90af14..144c8e9a642e 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -734,25 +734,29 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  			continue;
>  		}
>  		err = of_address_to_resource(node, 0, &res);
> -		of_node_put(node);
>  		if (err) {
>  			dev_err(dev, "unable to resolve memory region\n");
> +			of_node_put(node);
>  			return err;
>  		}
>  
> -		if (b >= IMX_RPROC_MEM_MAX)
> +		if (b >= IMX_RPROC_MEM_MAX) {
> +			of_node_put(node);
>  			break;
> +		}
>  
>  		/* Not use resource version, because we might share region */
>  		priv->mem[b].cpu_addr = devm_ioremap_wc(&pdev->dev, res.start, resource_size(&res));
>  		if (!priv->mem[b].cpu_addr) {
>  			dev_err(dev, "failed to remap %pr\n", &res);
> +			of_node_put(node);
>  			return -ENOMEM;
>  		}
>  		priv->mem[b].sys_addr = res.start;
>  		priv->mem[b].size = resource_size(&res);
>  		if (!strcmp(node->name, "rsc-table"))
>  			priv->rsc_table = priv->mem[b].cpu_addr;
> +		of_node_put(node);
>  		b++;
>  	}
>  
> -- 
> 2.30.2
> 
> 


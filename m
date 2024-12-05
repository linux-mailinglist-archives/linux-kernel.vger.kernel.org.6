Return-Path: <linux-kernel+bounces-433712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14939E5C0A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C38528F67C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F56222561;
	Thu,  5 Dec 2024 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fcl+UDwF"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476221D5BF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417268; cv=none; b=a7RsUdDivkNlmEzUicSnlWb9mcsFIhtpR7o8n1Nxh+Qh6s3ljXVrIM0z6mARrMafsRSnlao0+ZExLO+TwzKSYQ6R4/ZqJRlo1eGxexlNOnQ+DSwAYXolgHGR+XMRNbCoc1uOZbny+YyXft5JtczlIGw68AkxOiXl4zGLwuWHCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417268; c=relaxed/simple;
	bh=IQ/HGqC2oOZDUVKenCFCVNfvlZ9uRU2FlW6Axzv+8fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWN/NgiOCDZhBqB5X6nzkdz83VPyXmY7rbjQJAVOul/mG2SVRQh++CDLsY2PfRBhYLcOxmvpNGMtyHNs5BLhBo6sTKrX77eNRWyxXXgvJ5+x7GCmrSNhogtd7KSNxryx/mOkf+UTBbxZhq4xBs7H8juFaPi9C27RgVpSIIVs3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fcl+UDwF; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7258ed68cedso1158945b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733417266; x=1734022066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GGowWo0E2U0Rf9eK43iU5kiPqwDu4Y2pVeYyplVhdDQ=;
        b=Fcl+UDwFlfPaRNg6DgOueZOabHX5Mzj2OrS0QgksiQpp8V1zfn/LMI+xIEXpUnDyHU
         RsRuBOBAWe5OavhdSrQFkClcduzGKI3QlVbPimsjrz0W72PG5sHzKlXMxQjaDCfXmuZP
         lpfd3+j3+G8vnImYoJN93BcrcJ9cgc6mpYvc8+RApu0MwUbQz/nQcPc8n2UKE+paUR6L
         tVNjnQd8WXJ2lYguObG6tgDvM+9+aNFJEXZQgw+RM05OSbPbf8t9KwXgLVcurjcuv1Ce
         IFSpoyAo/4v6dGswA1jn7FiOv4aWaZYgT41fY5p5KfczxBagxmqurQv1BMLe1V7yrg+H
         3JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417266; x=1734022066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGowWo0E2U0Rf9eK43iU5kiPqwDu4Y2pVeYyplVhdDQ=;
        b=dvp3eAzO5a3PXPNRDYNVJvQGIt/lrjjiowtc6s0fZRjjtyqj4AntdCgwY2VWz0+dnU
         ez1cM69pPIK3V+H9clKIO60iQxGsDPDUF7nDTVGlkd7KRaD3Hx/HGIalBFUAxgg5mDpc
         tSFKs27FDImUvezxSO1I2szCREJYH6bLMagCJi5fUTV4lwOOL38I5aPf/RnwbPkweQ6s
         Ask6MYKoa6WiHxZansNm17gmJO04pljzT1JEUkQ8xUe4FZqnpcOs9AihkpwWKViJGDSa
         x5TJbfttM/ijDcIazMCEROMXWQwkw5Zj1U11xbRyFn+wKWub9Pom2A4L5BjH80NSV7hp
         h25g==
X-Forwarded-Encrypted: i=1; AJvYcCUhgL9VynkluUmPeqp02ry/37O2S1UDS2kzRyoI6W/Gi9G/4hVMGASmlCnRQ8n3jrTugKx0sqM1LbhPXkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3Tnr/UEtdKWC9vUXunioR/jCOn+YnSJ2mT2WOphbkhAAD+Gf
	F5Q4arNXJP5K4fYx8rpeBsjfTHK3NLwNpCUtBv/0an3udX7WgT+f65waIvpIDGY=
X-Gm-Gg: ASbGnctQiUJNC/VWcDdXxk5JFqkuDnxy9ShqdC1nFCUr+3dgulhWQDet+FvWUOIG3rV
	yoRGw7KK3WpMTV6Xh8kqc9cUYaKCUjEJE+g3bX3tgi9i8f9B+6zfw/MRLZZhRLpsQwsGfSdoCbT
	WQBYJSp8DzAN60MFu38TlFbMuLnYyC3uHzOvTaK7JLqVnfQsulDYMXw0U9FVZK+vF6EEWZezq6i
	+mowCV/9tdBQwCObKn820GzSicnrRajDcpq1xUAG8MrAIOqZ9LBXUXygg==
X-Google-Smtp-Source: AGHT+IHfdbN7q7iMS+18SQtbAa3CGAk6K7rAAw0BzwESRhSc460Et6yhn4diWwlO/9cKamVNlnvLvw==
X-Received: by 2002:a17:90b:1d03:b0:2ee:9e06:7db0 with SMTP id 98e67ed59e1d1-2ef011fbabcmr14575579a91.11.1733417265830;
        Thu, 05 Dec 2024 08:47:45 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:cdba:9225:289d:fd74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45ff780bsm1605849a91.42.2024.12.05.08.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:47:45 -0800 (PST)
Date: Thu, 5 Dec 2024 09:47:42 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Tinghan Shen <tinghan.shen@mediatek.com>
Subject: Re: [PATCH] remoteproc: mtk_scp: Only populate devices SCP cores
Message-ID: <Z1HZLq4iJQGmKDgM@p14s>
References: <20241202062826.66619-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202062826.66619-1-wenst@chromium.org>

Good day,

On Mon, Dec 02, 2024 at 02:28:25PM +0800, Chen-Yu Tsai wrote:
> When multi-core SCP support was added, the driver was made to populate
> platform devices for all the sub-nodes. This ended up adding platform
> devices for the rpmsg sub-nodes as well, which never actually get used,
> since rpmsg devices are registered through the rpmsg interface.
> 
> Limit of_platform_populate() to just populating the SCP cores with a
> compatible string match list.
> 
> Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
> Cc: Tinghan Shen <tinghan.shen@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/remoteproc/mtk_scp.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 0f4a7065d0bd..8206a1766481 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -1326,6 +1326,11 @@ static int scp_cluster_init(struct platform_device *pdev, struct mtk_scp_of_clus
>  	return ret;
>  }
>  
> +static const struct of_device_id scp_core_match[] = {
> +	{ .compatible = "mediatek,scp-core" },
> +	{}
> +};
> +
>  static int scp_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1357,13 +1362,15 @@ static int scp_probe(struct platform_device *pdev)
>  	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
>  	mutex_init(&scp_cluster->cluster_lock);
>  
> -	ret = devm_of_platform_populate(dev);
> +	ret = of_platform_populate(dev_of_node(dev), scp_core_match, NULL, dev);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
>  
>  	ret = scp_cluster_init(pdev, scp_cluster);
> -	if (ret)
> +	if (ret) {
> +		of_platform_depopulate(dev);
>  		return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -1379,6 +1386,7 @@ static void scp_remove(struct platform_device *pdev)
>  		rproc_del(scp->rproc);
>  		scp_free(scp);
>  	}
> +	of_platform_depopulate(&pdev->dev);

This looks like a sensible addition to me but I'll give Angelo some time to
chime in.

Regards,
Mathieu

>  	mutex_destroy(&scp_cluster->cluster_lock);
>  }
>  
> -- 
> 2.47.0.338.g60cca15819-goog
> 


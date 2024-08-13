Return-Path: <linux-kernel+bounces-285080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA859508FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF961C24459
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F291A01D5;
	Tue, 13 Aug 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXiy764L"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482419E831
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562663; cv=none; b=hyWMe7D6DYyGgvYZLzd7OiiXt1zP46ySNKRUHdtgZyJV5rGxaX1VkrShr5IsAPRaZOvyLpipC10gwByJH+cyv22HARYdRABgbauSgh4i9nnmQCJkUJ6DBcxzDYiYSbChTiOZaGKhYoycRKb9Bk9zG2SksPh1rwrDkx58KwraMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562663; c=relaxed/simple;
	bh=iax8nTB5naAhcfkw0pscNQSiKlvMu5KILn0pGkHWQKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UisO+OLuA1+p/avwpBKndqrHVxnu3LlYi/1+/8jiNbU4r+IZhJ6BzoK5mbyeFzdmyr2tIx9476KFKYjxlGqNx8t5dv8dK5h5AFZzEeb+BdaAj6VN3wgo23sZK0TRbG78BBAFR/3DDjfrLFO6d0IkbcIXnlQTN1M/g+bZebF+ZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VXiy764L; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3332375a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723562661; x=1724167461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oDUamF5J+1XHT0J4TpZt9iUNA0VNngLpHfz1pQpsQFM=;
        b=VXiy764L9L1iqvzgKJM5qFEw8/v4AAOfNRbcseaG6TWo9aFGNBDD1Nlmdhew1rTsIs
         bHSrJjjVg/fSAhDG01EnKjXR5C23M6MnCU2jeNm5dWIqhuwp+7pNIKjAo+svWVte759A
         l45cASH58Gti946BCSJaNIKlkrvMrqE0Og+ggFmz9CSTROWAdq0r1u95QbIfD/u5ntbX
         Czsvb5z53Ue/2ZsZL9BEfYgrK2/RCVUgUM4XFf2DzqhclKbXKjxh4+S+kUFQaq1A6jr1
         RHGnZ7OoZh+6Zoi8qpLjEf0E7ckpp3X3Fzl0OihzM3dtAhfOfAhJCo9wUX9vztVOovdE
         O9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562661; x=1724167461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDUamF5J+1XHT0J4TpZt9iUNA0VNngLpHfz1pQpsQFM=;
        b=OC37ZItIlOnI4p+F3B5oSu1cpiHWe6v6X+VG9Ic/OE0krnkYigG6qoR2MYbotWGKlF
         Gcd7DUbpk044MwSCoXteKEtd9ML8CSpkG0U4L7och/mckTovovriJXyh8iVPc9bnaXv1
         N4Rr9TfntIi640k+2L9PpK6kxDZF5KBMwe4/8uNRPhPmtlAQS3iu2LdkEzcBDV7OOlHO
         hFxnwaaWMExA4H8PlA8th6cFCdui0cEUNEbpA7/vDbCN6TAuCL9BSCqp+F7r8LeDxpvI
         zTMrX7XsllA5poC40lUqpJCYN7JzDdttVFJY0eH0zOyiTHRO4e0N51kvw0zOhA8y/x/5
         JBFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMS4sjZYuRO22mbvF99UaJHLc9AUd8SK+RRBljF1zbwkUyeSpXL3BSgJ1suEfPaVcqPUhkVJzXcYSKcKzoL65YNJkYQzTfBcl1s5NT
X-Gm-Message-State: AOJu0YzJxB4MYSMBXNC+sPC/72mMmr42RZnCYo+r6Jfhu92rVEw1/bVH
	OMhMBu88UrTg+cxAOiu9QgjvaVQn82ODInhFoRj/FfymSNL+INRYnckbjR9XvEGLw/L5zkFgjk7
	K
X-Google-Smtp-Source: AGHT+IHAxQb7Y6nkxCHFTuV+Yo1GDZU/jfnWNM34Zxjd3gA7zK88WOcad9xQ+GrBaPPGulVSnkAg5A==
X-Received: by 2002:a17:902:c408:b0:1fa:8f64:8afd with SMTP id d9443c01a7336-201ca127b19mr53908795ad.11.1723562661371;
        Tue, 13 Aug 2024 08:24:21 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:d596:d55b:d99d:7ece])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1ab426sm14760975ad.157.2024.08.13.08.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:24:20 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:24:17 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: Use of_property_present()
Message-ID: <Zrt6oej7Dsj8KXrL@p14s>
References: <20240731191312.1710417-7-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731191312.1710417-7-robh@kernel.org>

On Wed, Jul 31, 2024 at 01:12:45PM -0600, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_(find|get)_property(). This is part of a larger effort to remove
> callers of of_find_property() and similar functions. of_find_property()
> leaks the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/remoteproc/imx_dsp_rproc.c      | 2 +-
>  drivers/remoteproc/imx_rproc.c          | 2 +-
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
>

I have applied this patch.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 087506e21508..376187ad5754 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -509,7 +509,7 @@ static int imx_dsp_rproc_mbox_alloc(struct imx_dsp_rproc *priv)
>  	struct mbox_client *cl;
>  	int ret;
>  
> -	if (!of_get_property(dev->of_node, "mbox-names", NULL))
> +	if (!of_property_present(dev->of_node, "mbox-names"))
>  		return 0;
>  
>  	cl = &priv->cl;
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 144c8e9a642e..8d7ecc809c67 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -807,7 +807,7 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
>  	if (priv->tx_ch && priv->rx_ch)
>  		return 0;
>  
> -	if (!of_get_property(dev->of_node, "mbox-names", NULL))
> +	if (!of_property_present(dev->of_node, "mbox-names"))
>  		return 0;
>  
>  	cl = &priv->cl;
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 596f3ffb8935..2cea97c746fd 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -1059,7 +1059,7 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  	r5_core = cluster->r5_cores[0];
>  
>  	/* Maintain backward compatibility for zynqmp by using hardcode TCM address. */
> -	if (of_find_property(r5_core->np, "reg", NULL))
> +	if (of_property_present(r5_core->np, "reg"))
>  		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
>  	else if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
>  		ret = zynqmp_r5_get_tcm_node(cluster);
> @@ -1086,7 +1086,7 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>  			return ret;
>  		}
>  
> -		if (of_find_property(dev_of_node(dev), "xlnx,tcm-mode", NULL) ||
> +		if (of_property_present(dev_of_node(dev), "xlnx,tcm-mode") ||
>  		    device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
>  			ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id,
>  						       tcm_mode);
> @@ -1147,7 +1147,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>  		return -EINVAL;
>  	}
>  
> -	if (of_find_property(dev_node, "xlnx,tcm-mode", NULL)) {
> +	if (of_property_present(dev_node, "xlnx,tcm-mode")) {
>  		ret = of_property_read_u32(dev_node, "xlnx,tcm-mode", (u32 *)&tcm_mode);
>  		if (ret)
>  			return ret;
> -- 
> 2.43.0
> 


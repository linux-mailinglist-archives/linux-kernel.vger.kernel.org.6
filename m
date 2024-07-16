Return-Path: <linux-kernel+bounces-254040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADC6932B99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7984D1F207C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46E919E7D3;
	Tue, 16 Jul 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeJWbA1S"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D911DA4D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144812; cv=none; b=MJbzaUs3uvcjKQZ+UhD1vKX2LY33jnYq+V/PAf6Z1v8trPDHtRkZ8Pii0yv2OWhuZ9NdXqAokirMLp1MfyCy+8eWZTIft3GTN61WHVYjAyW3gC74KAHCNnNmZN7KmhivjbHkTpi5k17gauMAslhMZzrEx+tPnJabEEp1gS/0szo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144812; c=relaxed/simple;
	bh=Ov0ZxuRqg19DOdyaVwSAZjy1CSU3sqSqbZdr+Bo8tNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6gaTeWLbORPhDF+bsCVW7LIYJqNrl54ZJ/4W9FvY/ZZpsiI55avZfNpfR6M5ytRC3i+nVm9qFINSafUAY76RpHjA1qduznIf4QZsT0Wk7LNt/EvKoPU5zWlxWrkjuF3cW9rf1IANlC5wN67WvL3g7o6O9dO2/oVMTaBA5uJ66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AeJWbA1S; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb72eb3143so40675025ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721144810; x=1721749610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOZ0mHcem+Vs3dr0bori38FCvWKVYDMdvIY4Rdc3Vvo=;
        b=AeJWbA1SSdGEVdsc/Gd75fv/SMMsmEk8eT/e7boEoP/lAfNO55IWEgT7B0i2DpJA/k
         /FMWwH9En3RMKtham9KhgQbz4ukXuEnn21baGigD3FomrJ3acNHQORiAWpjCyFhTkv+U
         y1sdybpC0fn85j+UkuG+H/kh4F7XSqI+JsN7gaCkMOnUYatzqkbq76Q8jr4gQN/EMsfX
         2TylCXOjJgq39L6HB8WePtJs+GU0af5uTiLNG+9fnz1SvYnEcpyTd0i6ZReYU82vft+k
         ojvDkEXVtRrMQ65/pWOGRroNJJO6XdpVdSex0WBeHfnzT3n3cmv8m5CM+r908T0tw5pC
         GhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721144810; x=1721749610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOZ0mHcem+Vs3dr0bori38FCvWKVYDMdvIY4Rdc3Vvo=;
        b=Kur0mVHFeflvJiKwfrKz0PhOTLXHnWKCvUNxBLKBiJw3puv+4ABnDK1hqPiVpC5rhd
         i+AKNbDAqvqojmv3QNBBg16sXaqU3BogwyOvkehD023jxc9z16bhFRDdWPBUVxCYjYF1
         FS/wuONEw17imJaDeB60eA6TSDIeIPRg/FoZxMcvV5M8iccFZrsaMTRzHspBMzYctWxH
         t48r6UCoS09PpEOh3n/soH1HLZqeFqjU24G8HrqeUx3zAKsrk26HUSri0vo1MOzDBQEZ
         TWTw6A9sxFBkagq8p/3kOx/qhsinnevPecfWl/pXg6OTrwRRATmBKWudhJh03h7/SKQs
         KqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG6dO48Qc0yG5dMDbrsAS+DZTQ7TQJrT6snsgLK0+P8O8ylGf25bFGV5Su7Q4VfpQ/c9wh+7h2tBqZJ5YXId9hwh6hqYZ1Kf006I12
X-Gm-Message-State: AOJu0YwOb8343hc3M2Lsmcx/fIcxIuuk2gQfpccUA0nmDSKDnM6d64lS
	rmpJ8e5LshMUnaxIIl3XYIOrXd3E4RDh29cIYLmRf5yg1sHer42/w/LOiB9//7E=
X-Google-Smtp-Source: AGHT+IGuZHVU0ziAtoeqsGV04P2Tf0nyODoXzZ44+orFCy6lC6ncLmkiz+ZhBmIDQL7JpJUFd4iWGQ==
X-Received: by 2002:a17:903:11cc:b0:1fb:6121:dfc0 with SMTP id d9443c01a7336-1fc3e6cae84mr37740675ad.19.1721144809911;
        Tue, 16 Jul 2024 08:46:49 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5d01:167d:9cf4:148e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbc2782sm59434125ad.102.2024.07.16.08.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:46:49 -0700 (PDT)
Date: Tue, 16 Jul 2024 09:46:45 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 5/6] remoteproc: imx_rproc: allow tx_block to be set
Message-ID: <ZpaV5W94NvuJpvle@p14s>
References: <20240712-imx_rproc-v1-0-7bcf6732d328@nxp.com>
 <20240712-imx_rproc-v1-5-7bcf6732d328@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-imx_rproc-v1-5-7bcf6732d328@nxp.com>

On Fri, Jul 12, 2024 at 04:34:58PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Current tx_block is set to true, but there is case that no need to wait
> response. Linux just needs to send data to remote processor, so let's
> allow tx_block could be set to false.

Ok, maybe - but this patch doesn't use the new functionality, i.e nothing
changes.  

> 
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 552fccebf7e2..01cf1dfb2e87 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -90,7 +90,7 @@ struct imx_rproc_mem {
>  #define ATT_CORE_MASK   0xffff
>  #define ATT_CORE(I)     BIT((I))
>  
> -static int imx_rproc_xtr_mbox_init(struct rproc *rproc);
> +static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block);
>  static void imx_rproc_free_mbox(struct rproc *rproc);
>  
>  struct imx_rproc {
> @@ -369,7 +369,7 @@ static int imx_rproc_start(struct rproc *rproc)
>  	struct arm_smccc_res res;
>  	int ret;
>  
> -	ret = imx_rproc_xtr_mbox_init(rproc);
> +	ret = imx_rproc_xtr_mbox_init(rproc, true);
>  	if (ret)
>  		return ret;
>  
> @@ -629,7 +629,7 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
>  
>  static int imx_rproc_attach(struct rproc *rproc)
>  {
> -	return imx_rproc_xtr_mbox_init(rproc);
> +	return imx_rproc_xtr_mbox_init(rproc, true);
>  }
>  
>  static int imx_rproc_detach(struct rproc *rproc)
> @@ -794,7 +794,7 @@ static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
>  	queue_work(priv->workqueue, &priv->rproc_work);
>  }
>  
> -static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
> +static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block)
>  {
>  	struct imx_rproc *priv = rproc->priv;
>  	struct device *dev = priv->dev;
> @@ -817,7 +817,7 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
>  
>  	cl = &priv->cl;
>  	cl->dev = dev;
> -	cl->tx_block = true;
> +	cl->tx_block = tx_block;
>  	cl->tx_tout = 100;
>  	cl->knows_txdone = false;
>  	cl->rx_callback = imx_rproc_rx_callback;
> @@ -1083,7 +1083,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  
>  	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
>  
> -	ret = imx_rproc_xtr_mbox_init(rproc);
> +	ret = imx_rproc_xtr_mbox_init(rproc, true);
>  	if (ret)
>  		goto err_put_wkq;
>  
> 
> -- 
> 2.37.1
> 


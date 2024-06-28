Return-Path: <linux-kernel+bounces-234333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6799C91C55E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5821F25079
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8E1CCCA8;
	Fri, 28 Jun 2024 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxtV2BLH"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A681C68B3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719597875; cv=none; b=fYV765ioLhkexwj6l9M4x+xmCezedq1aM88T6lRUwz92+yN/mDUKX+fbK9GRvnVEPV8jVVuM/VN8qbE2m/BpOQey6jLg4yvWJjAvt1SKErqgj8bFgaoIAMXwpIpdEeHSxPDQQnderzH6Egf7HA7WVekIwfH36QIpm4vyQIn0ZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719597875; c=relaxed/simple;
	bh=lyCr9Ts8yOItO/JjBC31u0Jzvm/bIEehcd6kdgpqGmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4lwo4aTkVdvZU094jRPve9Dr6KoXE/DdXaM7j+B2Cz9yRbIuU/YlcPnkLybVrje5pWOZFS4x3hW6h4eSJ+Vh70h83raPvPAnT6V97zJUSpKaCYXO9aXZDmOppQWj8JzAfw9Y2k2eBPw+AD4VfvWu7AGwS+wEhU0RDKrk2FyRss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UxtV2BLH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fa2ea1c443so6888595ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719597872; x=1720202672; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H+ruGPETppbEAZdscNhJIuUHT64dVUBzmWwyvnp1b7w=;
        b=UxtV2BLHFb/9O6h1o9CA/8Vv/NfuTKXWDh+9SQmahY1MQRibbV/n8o7tyuekSdB8Yz
         +CQdjON5kqe5Mkm8VTGxyVZD8S5UxHY7sUhTyIOdIqdFnTTudhdtdnUg+rVrtCFrgD7y
         k5aebTuSyjLxXlvkJG9WXvzV3y9JvaAuWLbbiDSLYZAHpkscKn1dBZEUKmEvtpkRDMes
         zu9lNwLVWQwDnc/JPqffCG+gcjBBVZn65whi871j6a3ERZKwJ4nD0Jl6e5shWXKoLW7+
         M3ePNQ81SAILM/gZl+QczNAaPX+cg951HID+30E3uQwxJWY0Yl1Xv7sM6Qgxingt5d00
         U+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719597872; x=1720202672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+ruGPETppbEAZdscNhJIuUHT64dVUBzmWwyvnp1b7w=;
        b=bCwFvZxEDv90E9u+dSsF1wAQNvEcQoIr1vsFb99IS0thY2ZvS8y4QnIMOOyh1rk+A5
         vN+QMyrSS1wxw7YDwLyEin9Vgm7Y2LrhAtQ9TrrR8Q7uKXM6jlzD/RVGJz3lSsrvQa+Z
         tWfCzdqE3Ru54xf61EikPGoQhXGmxK1e2GYOfsO1mPzOeCqGHYO+WHVYfJHQs35qjb/u
         IvXZl4DE8OERcGaeYE4j/QaSKObhkvTikP7GQqTUJFD7mvxyRu3hhKWfj4f88p/rRtfA
         PLH8R6RDxzweCBahHcHOgYcVYfsc5NqktoLfpjAwgS57kREJKW19qgmNAecZRyFFZV/l
         2eBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwrGrBaFqlBjuDWJrb1ACBdg6PlloDOzbzyha+FKS4E+BCx63xXcuTcLALRtWfhwuZWTUj5pYZJaph1dvBNdJAD/8i2r+ePluzuQ4X
X-Gm-Message-State: AOJu0YykyMG2o2jWYJtiq7/lDZyhyozQxCqmUZIdedVgChO6Cj5XzLSQ
	D1h0qxOZZ5zI6b5xXRZcC+XWT4tHrsB2etTicjxxTiG7UkavlY6T4C83FEVdfKL0WaRZGENEk0O
	C
X-Google-Smtp-Source: AGHT+IGCvLrXWzySAlrNqbCAvh3eBYrqwRFPdz21iCBkv/nqIVi2SUvaRkJ9vc+Fe8iroSuxGmGXCw==
X-Received: by 2002:a17:902:ce81:b0:1f7:2bed:226 with SMTP id d9443c01a7336-1fa23ecee77mr197498935ad.36.1719597871540;
        Fri, 28 Jun 2024 11:04:31 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e53e:a53d:f473:181e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8695sm18341165ad.109.2024.06.28.11.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:04:30 -0700 (PDT)
Date: Fri, 28 Jun 2024 12:04:27 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] remoteproc: mediatek: Don't attempt to remap l1tcm
 memory if missing
Message-ID: <Zn77K/nny10G4sXN@p14s>
References: <20240627-scp-invalid-resource-l1tcm-v1-1-7d221e6c495a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240627-scp-invalid-resource-l1tcm-v1-1-7d221e6c495a@collabora.com>

On Thu, Jun 27, 2024 at 05:20:55PM -0400, Nícolas F. R. A. Prado wrote:
> The current code doesn't check whether platform_get_resource_byname()
> succeeded to get the l1tcm memory, which is optional, before attempting
> to map it. This results in the following error message when it is
> missing:
> 
>   mtk-scp 10500000.scp: error -EINVAL: invalid resource (null)
> 
> Add a check so that the remapping is only attempted if the memory region
> exists. This also allows to simplify the logic handling failure to
> remap, since a failure then is always a failure.
> 
> Fixes: ca23ecfdbd44 ("remoteproc/mediatek: support L1TCM")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index b885a9a041e4..b17757900cd7 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -1344,14 +1344,12 @@ static int scp_probe(struct platform_device *pdev)
>  
>  	/* l1tcm is an optional memory region */
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "l1tcm");
> -	scp_cluster->l1tcm_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(scp_cluster->l1tcm_base)) {
> -		ret = PTR_ERR(scp_cluster->l1tcm_base);
> -		if (ret != -EINVAL)
> -			return dev_err_probe(dev, ret, "Failed to map l1tcm memory\n");
> +	if (res) {
> +		scp_cluster->l1tcm_base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(scp_cluster->l1tcm_base))
> +			return dev_err_probe(dev, PTR_ERR(scp_cluster->l1tcm_base),
> +					     "Failed to map l1tcm memory\n");
>  
> -		scp_cluster->l1tcm_base = NULL;
> -	} else {

Much better - I have applied this patch.

Regards,
Mathieu

>  		scp_cluster->l1tcm_size = resource_size(res);
>  		scp_cluster->l1tcm_phys = res->start;
>  	}
> 
> ---
> base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
> change-id: 20240627-scp-invalid-resource-l1tcm-9f7cf45c17e6
> 
> Best regards,
> -- 
> Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 


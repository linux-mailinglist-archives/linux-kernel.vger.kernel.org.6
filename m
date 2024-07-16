Return-Path: <linux-kernel+bounces-254036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA60932B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F321F233F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5CA19E812;
	Tue, 16 Jul 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVv8GuY0"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3A19E7E5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144563; cv=none; b=jJA96WtrVOrlcvbB/mf+ra0NZZulVXx4qYD9TLNvHqfSPjetR1kfuGDrc3VMzAMWmexkCTiNIXx4aadP7wBGEWSG5JJhVyUdV1bXNV7jfvbGRn8wJukwGExbzT7q3jGWU8CkapZn9WMU/Fmx4WPXLC6urU5ghDqCEQ17KyQaKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144563; c=relaxed/simple;
	bh=rQQ1Qg6JSBfjSH2QZ8VvmzPD790Oe1XjwPlwbolB7ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTv0QIqtQJmwkmqW45liyxDsLDLm18VhLLH/UZUDX9H/BGLSD5s5DM0WJ8k3YDwjwSmk6eY23MuT/ax2J6x4pxZCJJ458lTQWalHhftoEucp1u2RC17kUkphbI3O2HeU+Fa4AIY3uPyXSTF/AdNc7ucNDOEUpVs8Jg3nSZQvpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qVv8GuY0; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-71871d5e087so4179990a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721144561; x=1721749361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDLjTilJpT2HBZBHwtZnBdq05Hhmc0NUomleiXquZZU=;
        b=qVv8GuY0L5xHT6QHE7zxcwbD5lZdOrBdP1RwBfSImP9HBCiA6gCezY4SaVhVUvoYRt
         IG6sSo37hXoHXEeMe7TeY3I7bYjvVS0r/a7mIDLWTD6r/VcU2EJQgGSE8ruQdirNw8Zs
         Y4wxMpTT1SkO24JdA8JfRJx3EA5bt1457wjOIDRhdhLFzZL7j5jeah/2wSHFMNAYjNMk
         UDwcg/fSKq6e16He7PnVjb4qVnq2jCpyyCTxtnBykruF+XVvXQMU73W4+1S76h09cBsg
         UWh0mJFDD5pPAXDvAyqU/HxJphuyYig8DTWncOIEjJkZhRxS4UgJt2p3jvUI5KHYvqFP
         2+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721144561; x=1721749361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDLjTilJpT2HBZBHwtZnBdq05Hhmc0NUomleiXquZZU=;
        b=fvgKOvZbbo8FjyBtO15RqX9TFlW2M5KeH+snj12Rg0vbfQipH6ltNs42+R2bcFe/JZ
         zZoLlirkNnBNxG/yI8RJDySonDjYHnym1bZ2yRC3aj5xVEvnd0NNeAxnzmJkzrtCeXx4
         c7XTvCT5Cm087VAPO/OMshYcw7l2cwgFLvj6FKd5wzB3Yyrt4gBiVZF6ha5s/URBIDEW
         eKrH32Ywv9NU97lq1yVefhzbDDLpqt3LMSdFaqHnq33HErZkhsm9mTQ6a0DGLItH458W
         V/TMcJzFfKsgCAPWCdoCjjgOHuSw9TtIrRzHd3U6AwPh2rJZwcmq7f9/eZOVu7aXtPqz
         Pkog==
X-Forwarded-Encrypted: i=1; AJvYcCUKj49O1H3k3SevHv4I6beu2Z7Mx18H5ey6qJpwo25La0aRXba4Mcr7NypWwkRfXtvX7AUCPAbHCRIY370wUQqg4g2YlHHzTt8usd58
X-Gm-Message-State: AOJu0Yx873fVMBY7BiXf8PMemgsYyoZiQZpmiqbfko2jEpN3B0gEWy92
	kcfx5xLCe+armgrImke+vkDew0bnarrcgn0QZghRjTNjWRxnnR3aPI4CaVjM470=
X-Google-Smtp-Source: AGHT+IFOsaKUXJaZMWGbZAXbmDixqd3fsB0nKaPU0B/B4/vmsuI8S5FQiPXCYpXlIkiFt2B8Xo+YkQ==
X-Received: by 2002:a05:6a21:3284:b0:1c1:31d0:c7a7 with SMTP id adf61e73a8af0-1c3f1210888mr2801180637.16.1721144561320;
        Tue, 16 Jul 2024 08:42:41 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5d01:167d:9cf4:148e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e33bbb564sm5051782a12.29.2024.07.16.08.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:42:40 -0700 (PDT)
Date: Tue, 16 Jul 2024 09:42:37 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, marex@denx.de,
	iuliana.prodan@nxp.com, daniel.baluta@nxp.com
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/6] remoteproc: imx_rproc: merge TCML/U
Message-ID: <ZpaU7TBfCQ7Tha1L@p14s>
References: <20240712-imx_rproc-v1-0-7bcf6732d328@nxp.com>
 <20240712-imx_rproc-v1-4-7bcf6732d328@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-imx_rproc-v1-4-7bcf6732d328@nxp.com>

On Fri, Jul 12, 2024 at 04:34:57PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Merge contiguous TCML/U regions into one to avoid load elf files which
> has large sections failure.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 9e99bb27c033..552fccebf7e2 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -119,20 +119,16 @@ struct imx_rproc {
>  static const struct imx_rproc_att imx_rproc_att_imx93[] = {
>  	/* dev addr , sys addr  , size	    , flags */
>  	/* TCM CODE NON-SECURE */
> -	{ 0x0FFC0000, 0x201C0000, 0x00020000, ATT_OWN | ATT_IOMEM },
> -	{ 0x0FFE0000, 0x201E0000, 0x00020000, ATT_OWN | ATT_IOMEM },
> +	{ 0x0FFC0000, 0x201C0000, 0x00040000, ATT_OWN | ATT_IOMEM },
>  
>  	/* TCM CODE SECURE */
> -	{ 0x1FFC0000, 0x201C0000, 0x00020000, ATT_OWN | ATT_IOMEM },
> -	{ 0x1FFE0000, 0x201E0000, 0x00020000, ATT_OWN | ATT_IOMEM },
> +	{ 0x1FFC0000, 0x201C0000, 0x00040000, ATT_OWN | ATT_IOMEM },
>  
>  	/* TCM SYS NON-SECURE*/
> -	{ 0x20000000, 0x20200000, 0x00020000, ATT_OWN | ATT_IOMEM },
> -	{ 0x20020000, 0x20220000, 0x00020000, ATT_OWN | ATT_IOMEM },
> +	{ 0x20000000, 0x20200000, 0x00040000, ATT_OWN | ATT_IOMEM },
>  
>  	/* TCM SYS SECURE*/
> -	{ 0x30000000, 0x20200000, 0x00020000, ATT_OWN | ATT_IOMEM },
> -	{ 0x30020000, 0x20220000, 0x00020000, ATT_OWN | ATT_IOMEM },
> +	{ 0x30000000, 0x20200000, 0x00040000, ATT_OWN | ATT_IOMEM },
>  
>  	/* DDR */
>  	{ 0x80000000, 0x80000000, 0x10000000, 0 },
> @@ -211,10 +207,8 @@ static const struct imx_rproc_att imx_rproc_att_imx8mq[] = {
>  	{ 0x08000000, 0x08000000, 0x08000000, 0 },
>  	/* DDR (Code) - alias */
>  	{ 0x10000000, 0x40000000, 0x0FFE0000, 0 },
> -	/* TCML */
> -	{ 0x1FFE0000, 0x007E0000, 0x00020000, ATT_OWN  | ATT_IOMEM},
> -	/* TCMU */
> -	{ 0x20000000, 0x00800000, 0x00020000, ATT_OWN  | ATT_IOMEM},
> +	/* TCML/U */
> +	{ 0x1FFE0000, 0x007E0000, 0x00040000, ATT_OWN  | ATT_IOMEM},

Here too I will need an RB tag by Marek, Iuliana or Daniel.

>  	/* OCRAM_S */
>  	{ 0x20180000, 0x00180000, 0x00008000, ATT_OWN },
>  	/* OCRAM */
> 
> -- 
> 2.37.1
> 


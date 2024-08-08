Return-Path: <linux-kernel+bounces-279275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E36F94BB3A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4753F280F77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64AF18A6BB;
	Thu,  8 Aug 2024 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlDx4VNx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF0143723
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113338; cv=none; b=Pj2jEo/2u+rjOGtpSMde0IFeHbQDaXwTnrCEB306rN8dGXgrdnAShMJJJftSyTsa4Ze6V9oEntiKLV3r9g7ADkcl8kQqaj3cNtCvUirVLzhMz87ehocKd/ZbT8Tm1FVb2TST86jd7EFDNqIb19LAjGW0E5rIR1FMxt5YkGIpLQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113338; c=relaxed/simple;
	bh=P5WkWuMuBZYslRPDaGbmL4Xir3nJ3nC4NhpsZuTy/BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+WgcFfQftegh7nrc1xBq5RoOy7LUkkS8qOMKtyLjtSJbKz1Xd8FleDa7jpRiZqEuv8xoyvOqPlG7KZ2JGN6YeqNu8VgNsESA+jyeLeCCuGt6fwhIbA5sEYDyqkIVDxX6Or5eS6n4g5/HRogXd4snpGGUYvX9jvgYve5IJDy1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlDx4VNx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723113337; x=1754649337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P5WkWuMuBZYslRPDaGbmL4Xir3nJ3nC4NhpsZuTy/BE=;
  b=hlDx4VNxAwcCDQB1Lx2nZEEC0cXFCO4zK1m55WqoHdRejXa+ufQeP/O5
   Me+3LTlD4ZCawuqNosWmhQuxnOxEfmMLuvwsrfIfWeGSCyzdbE4YZsgD1
   wngmSFhWBC57Y/53PCMH+wdvCypkXa/RD6p8oQh9Z3CbvsIuc8nD7q4aq
   TXQd5vbgYUPIHK5jRXrIxz13DCzSiZssURZwhgMjpjEoYcff7EJsA0LeP
   sM3Ij4yROuqRjltx7u4oX+BPDZ/Bledqq3VsdyRQLCkH1nm11icRzOFHB
   vvNLnMTVALg4mVmPO+/uMIAmk6PWQ75BfZV1jbQALDucVJR1XU/5swAgM
   Q==;
X-CSE-ConnectionGUID: Ovydl2zMSmmNFPuqOOTjdA==
X-CSE-MsgGUID: SkwXs0PoRSWJ/jGPLWCQtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38686049"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="38686049"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 03:35:37 -0700
X-CSE-ConnectionGUID: s3wnOjv9ThyGUOLWHcX9Sg==
X-CSE-MsgGUID: POL1YADgSwCsqBMS5jINtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57274416"
Received: from dneilan-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.245.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 03:35:30 -0700
Date: Thu, 8 Aug 2024 11:35:23 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: use dev_err_probe when failing
 to get panel bridge
Message-ID: <ZrSfayN4U6Lk3UCj@ashyti-mobl2.lan>
References: <20240808-ti-sn65dsi83-dev_err_probe-v1-1-72417aa275ab@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-ti-sn65dsi83-dev_err_probe-v1-1-72417aa275ab@bootlin.com>

Hi Luca,

On Thu, Aug 08, 2024 at 12:26:14PM +0200, Luca Ceresoli wrote:
> When devm_drm_of_get_bridge() fails, the probe fails silently. Use
> dev_err_probe() instead to log an error or report the deferral reason,
> whichever is applicable.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 57a7ed13f996..60b9f14d769a 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -606,7 +606,7 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
>  
>  	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
>  	if (IS_ERR(panel_bridge))
> -		return PTR_ERR(panel_bridge);
> +		return dev_err_probe(dev, PTR_ERR(panel_bridge), "Failed to get panel bridge\n");

patch looks good, but the message is a bit misleading. You are
not failing to get the panel bridge, but you are failing to find
a panel bridge in a DT node. Right?

Andi


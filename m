Return-Path: <linux-kernel+bounces-529773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E40A42ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5FE189EA98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C5C264FA1;
	Mon, 24 Feb 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="NtgrqWf2"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3804264F88
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420632; cv=none; b=oQnUdcRuJNYBDnK9eGpK+ovoNZIDiFyVs60dNl2otFT99acQPsHxknKtU6m9Cu2VrQQkpJwgoLGBDC4n+iy4h3wzbQ4O6BRaFTs7YuSy+Fu7CrZ6APQnrIol6WabTLO9snINk76OaUunW94qSiyrVMamIDLzzM1qzWY+ygOGv4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420632; c=relaxed/simple;
	bh=K8beOpLbiTBb7WuCs45dhg2su3D6mrOfsgBQ3ukXY70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1Hp0F+LXvCLsArloVjdoZJF1uQpZyArO+N0Un1M2icQobSdUQO3Fi+szfweSCMijfJ5fM3rBtkxiM75hR5zfI5rrYo4V8rL72D8ah69XIazQLyWLv2KhyqtAx09QLMHqMvApvGDvWDNWRHhxr/ZJKqWp5VcblN4kqT1JPBovXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=NtgrqWf2; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Mon, 24 Feb 2025 13:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1740420619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hr9YqOCA8Y3071Ik6hsTPZ9M/v7Zg4ekFpBsl2WDaLY=;
	b=NtgrqWf2iPGHA0+vBammpPjvlGLIDfDmYo5fnf0gziuMNPJzJbQmocyMGO+ox2jCnZHARg
	jKyVbut4Vcpj5XI1V/JlarMPSv2qdzrDYvQrjBwvhG2OGPguFu4zspV2txlMsdwdYW8VvW
	IpJNM2SOaQs5k6zH803EMy44vyuBbMJSt6eJKemA9idbU7zqL+tlOxO+jqkTeiLnL7JIqH
	1aJJ6hepTGrHbH98DJjANaM6UQG6JGABYSciCDiBJ9rna76wLRNzxqmi96uyzsOFH0mNPr
	brvBkZbWb2iUoMBMRQxb/GjsGXFo5Zo5ohwjSaHM0eZ5rR3rtNUMiE9qtr5mxw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] soc: apple: rtkit: Use high prio work queue
Message-ID: <Z7y2BpFT-70JrY2i@blossom>
References: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
 <20250222-apple-soc-misc-v1-3-1a3af494a48a@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250222-apple-soc-misc-v1-3-1a3af494a48a@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Sat , Feb 22, 2025 at 04:56:48PM +0000, Sven Peter via B4 Relay a écrit :
> From: Janne Grunau <j@jannau.net>
> 
> rtkit messages as communication with the DCP firmware for framebuffer
> swaps or input events are time critical so use WQ_HIGHPRI to prevent
> user space CPU load to increase latency.
> With kwin_wayland 6's explicit sync mode user space load was able to
> delay the IOMFB rtkit communication enough to miss vsync for surface
> swaps. Minimal test scenario is constantly resizing a glxgears
> Xwayland window.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/soc/apple/rtkit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
> index 35734ae8c9ce..b7f4654c3341 100644
> --- a/drivers/soc/apple/rtkit.c
> +++ b/drivers/soc/apple/rtkit.c
> @@ -695,7 +695,7 @@ struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
>  	rtk->mbox->rx = apple_rtkit_rx;
>  	rtk->mbox->cookie = rtk;
>  
> -	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_MEM_RECLAIM,
> +	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_HIGHPRI | WQ_MEM_RECLAIM,
>  					  dev_name(rtk->dev));
>  	if (!rtk->wq) {
>  		ret = -ENOMEM;
> 
> -- 
> 2.34.1
> 
> 


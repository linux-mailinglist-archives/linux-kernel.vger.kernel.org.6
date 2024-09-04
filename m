Return-Path: <linux-kernel+bounces-315490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112D796C342
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AE11F28FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6A11E009C;
	Wed,  4 Sep 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLBJkvHU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EAC1CC16B;
	Wed,  4 Sep 2024 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465618; cv=none; b=tRukRXcwGzoLTpTt8T+Ji4i3K7Gc+FFP3JRsjBX4c/BMAUNv1iWgcwuaaJ41RqXPylEKAIK/8oEPV6VYmUV04m8fhhxJ7KSARf8P9r1JgV+yc1Rsv56wf5MAgLIwp5VY0HWAG+J7hlZ/x5SyrYZ7wSyd/Ff9hV7pAIWUk+Ms2W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465618; c=relaxed/simple;
	bh=+3ODXSLmDXmWE0Ypt5vkmq+M5qRPpQx/U46X36rcq6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFlT6D7KKtORsDnk2ItzuQpRJAtFBLAtpW88TgBM4Db7so240m9CC26J3GKQ3jbyGn9up6Kvx9C89X1PFvC/q6BDPoPnBnMVrKgVpvSM1DsSYnN2GqjPdMEUb3CxyCro49P9HvHHvJd0VnleMa938ccTA6d2zDLzIx/ZV0XPNxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLBJkvHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67112C4CEC2;
	Wed,  4 Sep 2024 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725465618;
	bh=+3ODXSLmDXmWE0Ypt5vkmq+M5qRPpQx/U46X36rcq6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jLBJkvHUdvFupnyBSORH/jGNmc8W9/8wB3/moIQx4AafTtbF9vBgYDvRZ+eMEua5/
	 2wOa+vKlqq3glynWxmtkmAFye0YHfbWiKiHeSDz8yROklkX8N7+iJcOGXckG00khqb
	 4a+wEGPx3MtcVXvvAJeixpSJHx6mlM/huyZH5Vyn5rLkBS77N7E5z45ZV/54SzRVhZ
	 fD+OSxaLKffk62PNnko/OXcPCWPNOBNq5eHl1HrmhckZvQYSgLtCk1nNj7yjmHJOzY
	 2l8nQRrZzfQuz7fZjUECUwTwT2BEFQTA2KUpP9tnK3djhjvzPpN1jF6lPESD7B5Cyi
	 KMpOq3DDvIOkQ==
Date: Wed, 4 Sep 2024 17:00:13 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH net] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
Message-ID: <20240904160013.GX4792@kernel.org>
References: <20240903180059.4134461-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903180059.4134461-1-sean.anderson@linux.dev>

On Tue, Sep 03, 2024 at 02:00:59PM -0400, Sean Anderson wrote:
> If coalesce_count is greater than 255 it will not fit in the register and
> will overflow. Clamp it to 255 for more-predictable results.

Hi Sean,

Can this occur in practice?

> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")

nit: I think it is usual for the order of these tags to be reversed.

> ---
> 
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 9aeb7b9f3ae4..5f27fc1c4375 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -252,7 +252,8 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
>  static void axienet_dma_start(struct axienet_local *lp)
>  {
>  	/* Start updating the Rx channel control register */
> -	lp->rx_dma_cr = (lp->coalesce_count_rx << XAXIDMA_COALESCE_SHIFT) |
> +	lp->rx_dma_cr = (min(lp->coalesce_count_rx, 255) <<
> +			 XAXIDMA_COALESCE_SHIFT) |
>  			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;

nit: it would be nice to avoid using a naked 255 here.
     Perhaps: #define XAXIDMA_COALESCE_MAX 0xff

>  	/* Only set interrupt delay timer if not generating an interrupt on
>  	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
> @@ -264,7 +265,8 @@ static void axienet_dma_start(struct axienet_local *lp)
>  	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
>  
>  	/* Start updating the Tx channel control register */
> -	lp->tx_dma_cr = (lp->coalesce_count_tx << XAXIDMA_COALESCE_SHIFT) |
> +	lp->tx_dma_cr = (min(lp->coalesce_count_tx, 255) <<
> +			 XAXIDMA_COALESCE_SHIFT) |
>  			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
>  	/* Only set interrupt delay timer if not generating an interrupt on
>  	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
> -- 
> 2.35.1.1320.gc452695387.dirty
> 
> 


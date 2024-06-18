Return-Path: <linux-kernel+bounces-219003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A41190C8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BE01C226BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0415020B328;
	Tue, 18 Jun 2024 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNt27QS4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A020A930;
	Tue, 18 Jun 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704577; cv=none; b=rwhPZUH0nZodYOfynYaLy7E2CqbwLTxmJ4pECJMjuo8syfpiUFjWFJOR9bqG6T8bsYkUhb9mA8qqNFk6Tign5o+4nAPsVSuFUFnKByEfotDR8Aqf1C14mkUmznZXr82p3xPxhVBHcDqc+c42J/raCZodd9gQGmZF3Ku0mADDSwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704577; c=relaxed/simple;
	bh=KjFrD3x7om3gSIqL3pNxCEjKTXG59g1dkIyKmefkQlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewFGV/6nhkwdovik2nLGxY5BAPTAT0w5Ldl6DfGgWFCHAuFHoEN8ezpqzzygIHyCF1ieVShJhf3PLMq8oWV8HGw9GKugCPnNuRz89IocDuDTfVWbyG7kA3EHUzlcEy5HyBxW+R46YD0ftXOGjBk5wWOBWy1vHFmeV7ZasFfcIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNt27QS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AB1C4AF1A;
	Tue, 18 Jun 2024 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718704576;
	bh=KjFrD3x7om3gSIqL3pNxCEjKTXG59g1dkIyKmefkQlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNt27QS4sw4M6YYfzSPylnGv63F3Qqrd/RAWyAJGj4fx2OScnBYkYvlkTZDaJ3Yu5
	 x0JoOA99zqVx6Uu1F/sux9O360tqk4se7RLtW4/Ek7jcKpH/tJsde84YLolhRahDJL
	 PKsxU/zg2l21dIcDnae3V/CVqQdIEmN9JrQ2HECCW8dimE2kuLAdXlBTkSybDPD+jE
	 xesC0DGTbbOK14iuNgR/lkmycBLC+CSPxMg3lZdIsdpy3CSoiqu3T9tzIftqIvEZej
	 cRwDH8EzlLokxEdedE9vqP3Od6eQsorkBWDvC7bnLZ0KNg7LM9DMQWTb21hnfBqpZ4
	 ibv9T2zZr62uw==
Date: Tue, 18 Jun 2024 10:56:08 +0100
From: Simon Horman <horms@kernel.org>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: olteanv@gmail.com, linux@armlinux.org.uk, alexandre.torgue@foss.st.com,
	andrew@lunn.ch, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, wojciech.drewek@intel.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net v2 PATCH] net: stmmac: No need to calculate speed divider
 when offload is disabled
Message-ID: <20240618095608.GI8447@kernel.org>
References: <20240617013922.1035854-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617013922.1035854-1-xiaolei.wang@windriver.com>

On Mon, Jun 17, 2024 at 09:39:22AM +0800, Xiaolei Wang wrote:
> commit be27b8965297 ("net: stmmac: replace priv->speed with
> the portTransmitRate from the tc-cbs parameters") introduced
> a problem. When deleting, it prompts "Invalid portTransmitRate
> 0 (idleSlope - sendSlope)" and exits. Add judgment on cbs.enable.
> Only when offload is enabled, speed divider needs to be calculated.
> 
> Fixes: be27b8965297 ("net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
> 
> Change log:
> 
> v1:
>     https://patchwork.kernel.org/project/netdevbpf/patch/20240614081916.764761-1-xiaolei.wang@windriver.com/
> v2:
>     When offload is disabled, ptr is initialized to 0

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>



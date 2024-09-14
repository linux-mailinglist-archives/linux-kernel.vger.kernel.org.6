Return-Path: <linux-kernel+bounces-329299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A0978FBD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D621F2385B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530E1CEEA0;
	Sat, 14 Sep 2024 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="V/si4WmR"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49AB1CEAC4;
	Sat, 14 Sep 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307874; cv=none; b=bD4cJOcWBBrqxRUtEkbnpoTmPg/bT42t+DfwbqI3whxI8vsMZaJDtMF6lX6z3t41wMRW8MYsN68saIT+0y0f6IyvoBKf5nsT/jrABx9GY5b6Fo0wnSJAiOTRFO2y+smcOsdB2W9zs5B9FEbNOqdDUxpzAukMeqPxHkIep6yfx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307874; c=relaxed/simple;
	bh=lQuCovKkPxKUqkSM6dLvf+LTYz3rx59/IsS3+vLvl2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6N0Oy94uwLplEvUU+VdMMeldZ1ECuB8sIjrZuCZM7nmTLMG6/TqsjKcT1Lxt9fML20asvjBlmJoIZdryyZKYtUP3D0sxRJ/V04q0QX5vG/JvAGASQcS5koZRV2GhosMrUjwnowP621mcYhowfaUYjmuipSBMROqLhvJlctL3fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=V/si4WmR; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=93cKUn+WXxWXdpPau06HwygofLes83prKM3wRZ1aJSA=; b=V/si4WmRcwGdDPY7xSTd9CPgiY
	b2zGH7yKIppATzRtzFjSP+bqwhygBumjZDykoWXinEwGBDrDaDD+tDTmmWyqdy1P/Z9eoy/l8uU5F
	y+S+So88DF7xxP2dhn1lWErZD3Z+RzSONVJOJKPlxzClscIHyggbf0JU3BOMhwCkI85l5k6oLn4yH
	tZEoVfHcUWfmxmonXSYaZQWTYWVSjtvN/2uJlR6TJ5mO1slUtK46Y4SYvibf0J6ErvGFr25LX/Vdg
	BMDOOC+C0Ho8j8brHKV6uI3WhPVEMxpl6D3aTAodiNouI61WkvNBL31mla6JEU2A1ElS5X873oRPu
	vXyO90tg==;
Received: from i53875af6.versanet.de ([83.135.90.246] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1spPX6-0002qE-48; Sat, 14 Sep 2024 11:57:36 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yao Zi <ziyao@disroot.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH] clk: rockchip: fix finding of maximum clock ID
Date: Sat, 14 Sep 2024 11:57:35 +0200
Message-ID: <5815159.DvuYhMxLoT@diego>
In-Reply-To: <20240912133204.29089-2-ziyao@disroot.org>
References: <20240912133204.29089-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 12. September 2024, 15:32:05 CEST schrieb Yao Zi:
> If an ID of a branch's child is greater than current maximum, we should
> set new maximum to the child's ID, instead of its parent's.
> 
> Fixes: 2dc66a5ab2c6 ("clk: rockchip: rk3588: fix CLK_NR_CLKS usage")
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

@Stephen: can you put that on top of the other Rockchip changes for 6.12
please?

Thanks a lot
Heiko

> ---
>  drivers/clk/rockchip/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 73d2cbdc716b..0972e9f87470 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -439,7 +439,7 @@ unsigned long rockchip_clk_find_max_clk_id(struct rockchip_clk_branch *list,
>  		if (list->id > max)
>  			max = list->id;
>  		if (list->child && list->child->id > max)
> -			max = list->id;
> +			max = list->child->id;
>  	}
>  
>  	return max;
> 






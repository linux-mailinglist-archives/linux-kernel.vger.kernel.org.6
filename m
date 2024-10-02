Return-Path: <linux-kernel+bounces-347150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0A398CE94
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9CE2843A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397AD194A66;
	Wed,  2 Oct 2024 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QmQhCDm0"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C4567D;
	Wed,  2 Oct 2024 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857016; cv=none; b=byjpg7c/9itQP4Jy+KVOFcbmqeXFcDvp8Z/akQcN7GeaX3hUa7G40trEhr+GnL0alfHW1SjjJnO/ygqQPuGVHFnUnuihLDhNsK7KcnKJP5iPqTfcbdGh44YJ6gu+0QkLsIuPv3sVOLv4ZL2H92C7ioy4q9nukM6kejp5T1Jx8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857016; c=relaxed/simple;
	bh=ugm++Vn6eq+0/XTMnaZLHCTxcjpR9w6bZ2LELIj3xxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5nPg0vzVDL6JVUbvDZN+ftwjm7n31zedVIFpGsxp4KLoSYfsQ13C2OoHWMmmL/KkrQYjsG4/oAEDueTgoFGxjukXU0nocNMODlAc2PDPVnIGXAzugoSzFDk+Ook5oMloS81c7EA7rn76VYOsSCIlblrN6GQiRPGgkdiDI+NSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QmQhCDm0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6XX/IddAHu0DsNqgzpMUg94L+z/qNDIbA+BRdMiX+0Q=; b=QmQhCDm0eIlStLrzhgfkbtdh3q
	MOq7KBMzSsP9037c73W/A7vEmk3RjT1zVKhHGmEjPdYJFiLadzYG0sCOuhvNurheX5cGG/6cNdEy6
	SAZoBXnlQEp//fP+327dtYdcZvmPAE8a3bzoTPVSWOPUfid11mdpDQWyf2ADXTZKyfNgmvz23BjHn
	nzSwMJSl1AV4BRRvLDFI+j6DdDWJGRx+u/eoOtHUcekpf9kGw0og1v+lZYBhc0FVtIgY+d5rb+UBn
	J9Yct4VWGuHBetp9BulqntEode/M6TavMMLl1vNBzTwR+JyQ8w/BlyMKF2X+LfFAVabfJLcCx+9Gk
	1u/CE2ug==;
Received: from i53875aa1.versanet.de ([83.135.90.161] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svuXS-00036k-0G; Wed, 02 Oct 2024 10:16:50 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Yao Zi <ziyao@disroot.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH 4/8] clk: rockchip: Add PLL flag ROCKCHIP_PLL_FIXED_MODE
Date: Wed, 02 Oct 2024 10:16:49 +0200
Message-ID: <8495918.NyiUUSuA9g@diego>
In-Reply-To: <20241001042401.31903-6-ziyao@disroot.org>
References:
 <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-6-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Dienstag, 1. Oktober 2024, 06:23:58 CEST schrieb Yao Zi:
> RK3528 comes with a new PLL type, flagged by ROCKCHIP_PLL_FIXED_MODE,
> which should operate in normal mode only. Add corresponding definition
> and handle it in code.
> 

More commit message would be nice ;-) .

It's the PPLL for the pcie controller that is specified in the manual to
only work in normal mode. This is helpful for people reading along :-) .


Heiko


> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/clk/rockchip/clk-pll.c | 10 ++++++----
>  drivers/clk/rockchip/clk.h     |  2 ++
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
> index 606ce5458f54..46be1c67301a 100644
> --- a/drivers/clk/rockchip/clk-pll.c
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -204,10 +204,12 @@ static int rockchip_rk3036_pll_set_params(struct rockchip_clk_pll *pll,
>  	rockchip_rk3036_pll_get_params(pll, &cur);
>  	cur.rate = 0;
>  
> -	cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
> -	if (cur_parent == PLL_MODE_NORM) {
> -		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
> -		rate_change_remuxed = 1;
> +	if (!(pll->flags & ROCKCHIP_PLL_FIXED_MODE)) {
> +		cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
> +		if (cur_parent == PLL_MODE_NORM) {
> +			pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
> +			rate_change_remuxed = 1;
> +		}
>  	}
>  
>  	/* update pll values */
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index fd3b476dedda..1efc5c3a1e77 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -391,6 +391,7 @@ struct rockchip_pll_rate_table {
>   * Flags:
>   * ROCKCHIP_PLL_SYNC_RATE - check rate parameters to match against the
>   *	rate_table parameters and ajust them if necessary.
> + * ROCKCHIP_PLL_FIXED_MODE - the pll operates in normal mode only
>   */
>  struct rockchip_pll_clock {
>  	unsigned int		id;
> @@ -408,6 +409,7 @@ struct rockchip_pll_clock {
>  };
>  
>  #define ROCKCHIP_PLL_SYNC_RATE		BIT(0)
> +#define ROCKCHIP_PLL_FIXED_MODE		BIT(1)
>  
>  #define PLL(_type, _id, _name, _pnames, _flags, _con, _mode, _mshift,	\
>  		_lshift, _pflags, _rtable)				\
> 






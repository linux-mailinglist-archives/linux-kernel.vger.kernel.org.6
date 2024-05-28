Return-Path: <linux-kernel+bounces-192689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EDE8D20BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32A31C233A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A5917107F;
	Tue, 28 May 2024 15:48:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965E10A2A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911308; cv=none; b=mNYXYsYe/dPGqpp3U+AHog4U4V8AXZxGt9WifylldnkJf1rFrS2wtwSLZzUBsY8i91MK0vqBnT1mdV8L3SoHXeo4Gcvsxzi9UzJVqe9Uip9Wb9neNuGazLdM3Vk7g8xm8qYJEBWLTS8fi3PtpfFWYn+8c5EjkEaClVGLnCC4I5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911308; c=relaxed/simple;
	bh=WqG9sZYchyys4D5XzM/xFNcQEPLv6PSK1vKnXJvpQVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRJ57bfYJE0FJWJLvryIHcl4Oz6lSt9m5cuGelFU9NFu/mnupgcLUsRqZVMbc2VBzyjXI25tnK4LQhC+3FjW/6rADxweqE03w2qyx5muYjlQK9nraWDkyjPiQx7GrpkFleGiJ9FZOBeDykvEq6wB2j2lv7sCWDrIELb8rGIpfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sBz3c-0003Cq-9A; Tue, 28 May 2024 17:48:12 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sBz3b-003LZF-G9; Tue, 28 May 2024 17:48:11 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sBz3b-001P6V-1I;
	Tue, 28 May 2024 17:48:11 +0200
Date: Tue, 28 May 2024 17:48:11 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastien Laveze <slaveze@smartandconnective.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: imx: imx6ul: fix default parent for enet*_ref_sel
Message-ID: <ZlX8u6V6l3ZwurI0@pengutronix.de>
References: <20240528151434.227602-1-slaveze@smartandconnective.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240528151434.227602-1-slaveze@smartandconnective.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, May 28, 2024 at 05:14:33PM +0200, Sebastien Laveze wrote:
> The clk_set_parent for "enet1_ref_sel" and  "enet2_ref_sel" are
> incorrect, therefore the original requirements to have "enet_clk_ref" as
> output sourced by iMX ENET PLL as a default config is not met.
> 
> Only "enet[1,2]_ref_125m" "enet[1,2]_ref_pad" are possible parents for
> "enet1_ref_sel" and "enet2_ref_sel".
> 
> This was observed as a regression using a custom device tree which was
> expecting this default config.
> 
> This can be fixed at the device tree level but having a default config
> matching the original behavior (before refclock mux) will avoid breaking
> existing configs.
> 
> Fixes: 4e197ee880c2 ("clk: imx6ul: add ethernet refclock mux support")
> Link: https://lore.kernel.org/lkml/20230306020226.GC143566@dragon/T/
> Signed-off-by: Sebastien Laveze <slaveze@smartandconnective.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you.

> ---
>  drivers/clk/imx/clk-imx6ul.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> index f9394e94f69d..05c7a82b751f 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -542,8 +542,8 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>  
>  	clk_set_parent(hws[IMX6UL_CLK_ENFC_SEL]->clk, hws[IMX6UL_CLK_PLL2_PFD2]->clk);
>  
> -	clk_set_parent(hws[IMX6UL_CLK_ENET1_REF_SEL]->clk, hws[IMX6UL_CLK_ENET_REF]->clk);
> -	clk_set_parent(hws[IMX6UL_CLK_ENET2_REF_SEL]->clk, hws[IMX6UL_CLK_ENET2_REF]->clk);
> +	clk_set_parent(hws[IMX6UL_CLK_ENET1_REF_SEL]->clk, hws[IMX6UL_CLK_ENET1_REF_125M]->clk);
> +	clk_set_parent(hws[IMX6UL_CLK_ENET2_REF_SEL]->clk, hws[IMX6UL_CLK_ENET2_REF_125M]->clk);
>  
>  	imx_register_uart_clocks();
>  }
> -- 
> 2.34.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


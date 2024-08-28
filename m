Return-Path: <linux-kernel+bounces-304469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ED0962085
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05E91F24C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F772158216;
	Wed, 28 Aug 2024 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="SHdiDK6h"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6518157494;
	Wed, 28 Aug 2024 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829428; cv=none; b=ms2PFa/ownBCDEdTADqHf2+YAl9GQUKfnfCHV7rRuAVASXLIehrBDguxhD7sInv0abKslcpT9mxOkRWKEFp0KTtozqEBt4eypquhDityWGBpgStMxI9QOalHm03Ov0/zMYCPpUu7LsYuyHBtPNUX0t/4gA/Uv8gudBVNO3jz/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829428; c=relaxed/simple;
	bh=AnDRz3s+Akh9nNjep8PwRt6YI/1ulIb+StcovUeB1LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRJOAKF8qQn+TTNhRAhMD9WlwYLxFnfEKLtR92t5Ha5hrhOC0a2JrJBeW86w1Kkm02ZJ1vEZC/lgEVtT0Fs7uT0FUnc3ghi9+n0fFvj85dQx3FrnL4Qf9f51QxmyrqXFHEk0apGQcQCmASrpG3lHX2yG2wy/O7QN7X8/G1hxrc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=SHdiDK6h; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC19C148347E;
	Wed, 28 Aug 2024 09:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724829423; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=nNhkCfzyHMzEYGofIn7Ckl5mjzv4eT/hmvRvBJmLKpU=;
	b=SHdiDK6hfYorFd3WSLqsMqX2OtkNxhlvW3EXUAvp4qFlU21QrVkwdM3HiWoK8wo+ILeGF+
	Z80g05TDcVVaSN7tIxwnM+ebGEP3k98+Zrf5IWToYEV+3/CIaeUz9NkkRWOUKsvOb8yO35
	JLkp5fFOVEWFaILGuXLg818un9n0P1/iG+YVr7HszvEUKZ/oWb6h2LBK1CZVM/+Y4+ESTA
	lpCa0WHP+SjtmRKrmL4UTepkYdyBu3RvOlDCIdx/6mb2NH3RZJzY0m7jqFmwDfua6fiadK
	sPsbX/mKuEC1n4HNifaJVWcOSfJN9vblrnpv9eSs2otLK4Io3WJVlOZEsUMXcw==
Date: Wed, 28 Aug 2024 09:17:01 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: at91: sckc: Use SCKC_{TD, MD}_SLCK IDs for
 clk32k clocks
Message-ID: <20240828-unawake-unstamped-946e2840d0a1@thorsis.com>
Mail-Followup-To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240826173116.3628337-1-claudiu.beznea@tuxon.dev>
 <20240826173116.3628337-3-claudiu.beznea@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826173116.3628337-3-claudiu.beznea@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

Am Mon, Aug 26, 2024 at 08:31:15PM +0300 schrieb Claudiu Beznea:
> Use the newly introduced macros instead of raw numbers. With this the code
> is a bit easier to understand.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> ---
>  drivers/clk/at91/sckc.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
> index 7741d8f3dbee..021d1b412af4 100644
> --- a/drivers/clk/at91/sckc.c
> +++ b/drivers/clk/at91/sckc.c
> @@ -12,6 +12,8 @@
>  #include <linux/of_address.h>
>  #include <linux/io.h>
>  
> +#include <dt-bindings/clock/at91.h>
> +
>  #define SLOW_CLOCK_FREQ		32768
>  #define SLOWCK_SW_CYCLES	5
>  #define SLOWCK_SW_TIME_USEC	((SLOWCK_SW_CYCLES * USEC_PER_SEC) / \
> @@ -470,7 +472,7 @@ static void __init of_sam9x60_sckc_setup(struct device_node *np)
>  {
>  	void __iomem *regbase = of_iomap(np, 0);
>  	struct clk_hw_onecell_data *clk_data;
> -	struct clk_hw *slow_rc, *slow_osc;
> +	struct clk_hw *slow_rc, *slow_osc, *hw;
>  	const char *xtal_name;
>  	const struct clk_hw *parent_hws[2];
>  	static struct clk_parent_data parent_data = {
> @@ -506,19 +508,19 @@ static void __init of_sam9x60_sckc_setup(struct device_node *np)
>  
>  	/* MD_SLCK and TD_SLCK. */
>  	clk_data->num = 2;
> -	clk_data->hws[0] = clk_hw_register_fixed_rate_parent_hw(NULL, "md_slck",
> -								slow_rc,
> -								0, 32768);
> -	if (IS_ERR(clk_data->hws[0]))
> +	hw = clk_hw_register_fixed_rate_parent_hw(NULL, "md_slck", slow_rc,
> +						  0, 32768);
> +	if (IS_ERR(hw))
>  		goto clk_data_free;
> +	clk_data->hws[SCKC_MD_SLCK] = hw;
>  
>  	parent_hws[0] = slow_rc;
>  	parent_hws[1] = slow_osc;
> -	clk_data->hws[1] = at91_clk_register_sam9x5_slow(regbase, "td_slck",
> -							 parent_hws, 2,
> -							 &at91sam9x60_bits);
> -	if (IS_ERR(clk_data->hws[1]))
> +	hw = at91_clk_register_sam9x5_slow(regbase, "td_slck", parent_hws,
> +					   2, &at91sam9x60_bits);
> +	if (IS_ERR(hw))
>  		goto unregister_md_slck;
> +	clk_data->hws[SCKC_TD_SLCK] = hw;
>  
>  	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
>  	if (WARN_ON(ret))
> @@ -527,9 +529,9 @@ static void __init of_sam9x60_sckc_setup(struct device_node *np)
>  	return;
>  
>  unregister_td_slck:
> -	at91_clk_unregister_sam9x5_slow(clk_data->hws[1]);
> +	at91_clk_unregister_sam9x5_slow(clk_data->hws[SCKC_TD_SLCK]);
>  unregister_md_slck:
> -	clk_hw_unregister(clk_data->hws[0]);
> +	clk_hw_unregister(clk_data->hws[SCKC_MD_SLCK]);
>  clk_data_free:
>  	kfree(clk_data);
>  unregister_slow_osc:

Reviewed-by: Alexander Dahl <ada@thorsis.com>

Thanks and Greets
Alex



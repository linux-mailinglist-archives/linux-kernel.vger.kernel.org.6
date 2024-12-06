Return-Path: <linux-kernel+bounces-435043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1129E6EC5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45957188315E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E463205AC9;
	Fri,  6 Dec 2024 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCHplatO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01D5464A;
	Fri,  6 Dec 2024 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489971; cv=none; b=ovPCdXnMn1Fzaxquqg2sBgCIdiXEGZ/sLg4e5w3trQT9Uqfcn4c1g8JLckOb4V7YEHYHvZcQ885BTfbW2MeYQTTy3Cx+s4Z2oUBrHzYNaSFhmoJBAZ/0qb1nzx2x6rzg+RU10g8H8Ud2XxcsvlUVQT3zLe8F54CtMTsNbMCkbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489971; c=relaxed/simple;
	bh=7kZlBs8/qsHwIl5r8qzSVYO7uA12w337ENyPIR3/4bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9Yh9n97ac9x66gq6XHDh2GZGJ5UzTnnnycL3G4tY755c3hQblS3liKoorvdvCQMtmGsh7WWCtJo0zuyjrgVRDxTdh2i1nveS67wasZiJHJmttTPEWQoLc4BQrcANwFokzFhegIx4G/iV1jQE8V7v2DsYQM+Gsf5lz58kFVka2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCHplatO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534F9C4CED1;
	Fri,  6 Dec 2024 12:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733489970;
	bh=7kZlBs8/qsHwIl5r8qzSVYO7uA12w337ENyPIR3/4bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCHplatOiR9NWakpnvXfl+RRoMZvOPuIE5P8uck2x49RC4ewGLdfdBq2y87QbQb/4
	 RDHG9gGugqxZ8X5w2613ZkucytuRGKJuHSH9abWKvMnA/mGAFybB4jGlVx8p63T6lS
	 XP0EL4bFJ8fqjRFgSP9mJzivzFbAsdN75UHB0gpoKR/Khln575C+TfnCHsywBHlIbz
	 rN9laGmpKZ4Oqat0hilX+nteIIdnzYyWsau07GxEVmFstN2e9YK3yEYvO7kMRxp85K
	 MiWvMGv59ekSwNOu0HYzdkd3iqmzXPXaFbd/LgopPe8yHVzQb8R9aYlpMpc/ThColb
	 8RhF5PUQ/IEHw==
Date: Fri, 6 Dec 2024 13:59:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 10/20] dt-bindings: clock: imx8mm: add binding
 definitions for anatop
Message-ID: <46awbd7wxh56l3wmgj43zhz7d75was6drkmlydcjqgefee35ll@73jw2xxtpwic>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
 <20241205111939.1796244-11-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205111939.1796244-11-dario.binacchi@amarulasolutions.com>

On Thu, Dec 05, 2024 at 12:17:45PM +0100, Dario Binacchi wrote:
> Add the bindings definitions for the anatop node. The patch is
> preparatory for future developments.

This is never a separate patch but goes with the binding doc.

> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> (no changes since v4)
> 
> Changes in v4:
> - New
> 
>  include/dt-bindings/clock/imx8mm-clock.h | 66 ++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)

...

> +#define IMX8MM_ANATOP_SYS_PLL2_1000M		56
> +#define IMX8MM_ANATOP_CLK_CLKOUT1_SEL		57
> +#define IMX8MM_ANATOP_CLK_CLKOUT1_DIV		58
> +#define IMX8MM_ANATOP_CLK_CLKOUT1		59
> +#define IMX8MM_ANATOP_CLK_CLKOUT2_SEL		60
> +#define IMX8MM_ANATOP_CLK_CLKOUT2_DIV		61
> +#define IMX8MM_ANATOP_CLK_CLKOUT2		62
> +
> +#define IMX8MM_ANATOP_CLK_END			63

Drop, not a binding really.

> +
>  #endif
> -- 
> 2.43.0
> 


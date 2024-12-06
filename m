Return-Path: <linux-kernel+bounces-435047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE9E9E6ED2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1025A167A6F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7BF206F1C;
	Fri,  6 Dec 2024 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACTgGvbD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F71FC11F;
	Fri,  6 Dec 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490058; cv=none; b=EG+N2S5d3L5yfLPqOPe5u6jqF2QzDyJSnZhA2knmQ7KN4qSV+FFMZBCtAQH4lEEcjVI1u0W5iGJUmm4+J9brhyF7Pwi88nsWGM4H4r8Q8cRrthWrElQuGeMv0Yrr5Sw9ZHYuBTrMnQNn0y6HdqPtrhgbJgR0hSAufHYQ3nsr6Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490058; c=relaxed/simple;
	bh=qnHw0NICoJNSFfda7z3Yzm4l1maJwc3jy/JgCMdgy7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4tkgyzEZTuXAspH6ku4l7k/f+Eiinx3POttHUp3d4iKEBiNw4DLE/1ycg28rwRf07nCW93pfETDKbFGMhw51Lk+4QvioxXLAcLenDUW2NAWMiSfs1ytfkT+bDKu1QOPVKbBEB+6FBCcdO39/nsW4RGcc9TXueQZ/JtFoXC3yDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACTgGvbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26976C4CED2;
	Fri,  6 Dec 2024 13:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733490057;
	bh=qnHw0NICoJNSFfda7z3Yzm4l1maJwc3jy/JgCMdgy7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACTgGvbDzphR3QuOq24UQXXPfTPpm46grp44J+8aQipVfqAJ6imZQ06sZ2vaMbBtQ
	 CHZ0I8dqVbNhX+e9Beqw/pj11Oahrm+7H3Z5V7bYZ4n6HxKnihMEIqibp1BiSL5guU
	 nZDM0pJXGjqyapxcN8LD/sQJCGSIhcQHTOxezKp7/qaprBDYYqrEVVe6eCogabgPfB
	 CDko4TzWmjXiNqGGGIHx6GhM/ym7fVOasMQcN5pPsx3rvm2HADeog00iv9IJ2f8tDj
	 r8tJhysqGnZzegg2db2xLqltFLKx588ldAjcX5zNyXWaYmIeanOuJSiJuywynGmOEI
	 voHw4mlaV2zGA==
Date: Fri, 6 Dec 2024 14:00:54 +0100
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
Subject: Re: [PATCH v5 11/20] dt-bindings: clock: imx8mn: add binding
 definitions for anatop
Message-ID: <jgkbsxwhttebjpul43wtt6simygkst7bnis47b5pkevica2th5@n7elmf4u5k3n>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
 <20241205111939.1796244-12-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205111939.1796244-12-dario.binacchi@amarulasolutions.com>

On Thu, Dec 05, 2024 at 12:17:46PM +0100, Dario Binacchi wrote:
> Add the bindings definitions for the anatop node. The patch is
> preparatory for future developments.

I don't understand last statement. How this can prepare? Either you add
bindings for clock provider or not.


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
>  include/dt-bindings/clock/imx8mn-clock.h | 67 ++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

...

> +#define IMX8MN_ANATOP_CLK_CLKOUT1_SEL		57
> +#define IMX8MN_ANATOP_CLK_CLKOUT1_DIV		58
> +#define IMX8MN_ANATOP_CLK_CLKOUT1		59
> +#define IMX8MN_ANATOP_CLK_CLKOUT2_SEL		60
> +#define IMX8MN_ANATOP_CLK_CLKOUT2_DIV		61
> +#define IMX8MN_ANATOP_CLK_CLKOUT2		62
> +
> +#define IMX8MN_ANATOP_CLK_END			63

Drop

> +
>  #endif
> -- 
> 2.43.0
> 


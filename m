Return-Path: <linux-kernel+bounces-435042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8EA9E6EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E641E281A87
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A7E204F74;
	Fri,  6 Dec 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj4s5uyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFB205AA3;
	Fri,  6 Dec 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489898; cv=none; b=n/a6ohOagmvVzfLmognlGJ+6uK4Qy9A5wSmyiMie7YfRuwugYzmxUP8d1sSLNxwuE0eUa7Wd/7c9NbBPuuIijf7MJNmoyAU/Vc0yF2n38yhCqIiljAQk9tUqYlf+MhjPiXyh+CCx345nsdy+s70nDENylg+/m2YWw397pxA19n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489898; c=relaxed/simple;
	bh=0DPWLJNoBPA4d09rGw4XVjzfqhYj+boN76XLzVvjlbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOmpZQBtQv4HEJryEA1TOYgNtuu9s2Sd+Z6jMzhxWfnrG0eeDStj60vczYraJ14rTkhfLlJHuGwgmOVYse0GKShh8EDaVLuTo8yimOIqjKGPXeAB85NKwaQZhhqC2k0uo+IdfJchFASjBiEl+jnTpa/4sBmd75lNu5CxvCgpg9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj4s5uyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052D8C4CED1;
	Fri,  6 Dec 2024 12:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733489897;
	bh=0DPWLJNoBPA4d09rGw4XVjzfqhYj+boN76XLzVvjlbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tj4s5uyy1JcclCOgqxp9Az+6LLzAJCl75naicwpGr8i2wnTtdKhL2gqEgmOzpKBHu
	 vti6B6o/uLenSxERTQysRWIbIuvWNoPu9G3K7ikGhjbUSo/h0BBEKk/sL3Xm/7lUWy
	 m/WhokIrwoADniFAUAcAVn1X1BW+oFI81c5WA9grBUCmWv0erLC+UQ7pKF3eaVvNQP
	 4V8ggRCkzB7h6VSLjrEV+CGbwmt8QN52VXtMdtDbMtf5TvmVTCr5iQDrgQGkxIlMYF
	 /5rmecuLgjkzpHsVduippuIk+8nwj8INX+3PLW5vLVvDD8m7j7WJPjRRVyn7KRceow
	 7MzB3nVq2JHoA==
Date: Fri, 6 Dec 2024 13:58:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 05/20] dt-bindings: clock: imx8m-anatop: define
 clocks/clock-names
Message-ID: <227zmz7rg4t6j5ylbe4ft7udheffalcqj4uxxrwutcfwuvcm2v@qbih67ilxigy>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
 <20241205111939.1796244-6-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205111939.1796244-6-dario.binacchi@amarulasolutions.com>

On Thu, Dec 05, 2024 at 12:17:40PM +0100, Dario Binacchi wrote:
> Define clocks and clock-names properties of the anatop device node.

This we see from the diff. Say something useful, instead of repeating
subject and patch contents.

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
>  .../bindings/clock/fsl,imx8m-anatop.yaml      | 53 ++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> index bbd22e95b319..f439b0a94ce2 100644
> --- a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> +++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> @@ -30,22 +30,73 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  clocks:
> +    minItems: 2
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3
> +
>    '#clock-cells':
>      const: 1
>  
>  required:
>    - compatible
>    - reg
> +  - clocks
> +  - clock-names

That's an ABI break and nothing in commit msg mentions it, nothing
explains impact or rationale behind.

>    - '#clock-cells'

Best regards,
Krzysztof



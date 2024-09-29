Return-Path: <linux-kernel+bounces-343138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B2989724
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3AF1C20B27
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444A978C6C;
	Sun, 29 Sep 2024 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LImsKV1n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807438382;
	Sun, 29 Sep 2024 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727639114; cv=none; b=UNqz3bg+YWC06YcdM+Kz1BnHaQ/Ao6LGulBv1MClLG7mApXo3Q76SXQz+xqBr2jP/j2A+SwimGdT58v34cZrJWYzkKfl+AubTcg/KXAvJwko0azRMWXz9OlrsKPZamlv2JPphYtjTGn6U7r3NFDHuBp8U7nw776VE4NYkCfbZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727639114; c=relaxed/simple;
	bh=WLzoHAmvgk+kdS0lUkhv1MhbfAgTre8V7/wWH+dkjeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0UkBb1oeylSTIkRpxHVYn1YrUnkkKrJpdUeSbJbDL1sAgc9QVRET4SbICP6zsN8e4unD8uS8U2mcbgsTRkFY4EcXyU6Xwqml0K9I4UeEUlnl6wUJ1rMYV59u4MBZccEqnvlQXJ5eg9KVPRgvW40V8zgf4NuoSuMlgp0jMu7AYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LImsKV1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7425AC4CEC5;
	Sun, 29 Sep 2024 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727639114;
	bh=WLzoHAmvgk+kdS0lUkhv1MhbfAgTre8V7/wWH+dkjeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LImsKV1n5ncMCQk/d3KlTGOUhdZXvwGa/N4ENmo0Tp6AD0GTY0ZFmA0J5hpac7csF
	 /RsNnx9usT7caVvKDwpXVQfa/8Qa7kpbsrE5oG0MWHdh7yvHI7dGDI/RMq+7rUaFQU
	 EVI1w2ARgdKj/1NyvGcNRjxf2Cxg5SUH7FpkFFxo6TemRNd3h2GXGKXxCo4cd6E1Nb
	 4ZWrD5/DYmSFI7pXRlMXwQVItZ4pM86M0QkEE63XOk3d8m8t7Ao0dTXl3juElQGSKO
	 gziDCwRsllTkqxWnjNyfx9IKdoGMTQnvctJxG0ghCgk59ymXCB7d8Iz5KMu/P4cfym
	 8bRJem+pEyJrg==
Date: Sun, 29 Sep 2024 21:45:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: imx8m-anatop: support spread
 spectrum clocking
Message-ID: <3rbqwhjt567tj3jlddb5dyxotx2dha2op4xhdlq2x5qmu62ady@qscyq2p44jls>
References: <20240929172743.1758292-1-dario.binacchi@amarulasolutions.com>
 <20240929172743.1758292-2-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240929172743.1758292-2-dario.binacchi@amarulasolutions.com>

On Sun, Sep 29, 2024 at 07:27:11PM +0200, Dario Binacchi wrote:
> The patch adds the DT bindings for enabling and tuning spread spectrum
> clocking generation.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v2:
> - Add "allOf:" and place it after "required:" block, like in the
>   example schema.
> - Move the properties definition to the top-level.
> - Drop unit types as requested by the "make dt_binding_check" command.
> 
>  .../bindings/clock/fsl,imx8m-anatop.yaml      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> index bbd22e95b319..a142c04fef00 100644
> --- a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> +++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> @@ -33,11 +33,56 @@ properties:
>    '#clock-cells':
>      const: 1
>  
> +  fsl,ssc-clocks:

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

You just ignored my email and never cared to respond.

Implement the feedback.

Best regards,
Krzysztof



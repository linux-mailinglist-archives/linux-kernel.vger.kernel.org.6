Return-Path: <linux-kernel+bounces-398340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E99BEFD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7262839FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC929201038;
	Wed,  6 Nov 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxK/9pf0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554A17DFF2;
	Wed,  6 Nov 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902242; cv=none; b=MfLIqMAKFeR22t0J/U/8xEHCtM0n6iLxVL+R009dOBUyRukJItNQBXLngVus+ThvhV+JL9mOP9nAWiNX/0JYmGBljRfhhiK/71RYvzJ1ozUzDpVLxlEo23Po79bAriq/y3rfBhcdTLlO9b0wKp28e0me0w5nHnSBYqwv+K45g/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902242; c=relaxed/simple;
	bh=hR+M/12mz686XDw6qw79yyMcaey3EbYKRvazPCDOwQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JioNShFreW5TRsjSGnxYBvAbVYKH6RDwhLUsdqy/vAtQ/brygcO12CxiSkeveJ5Ez3i8OEhPsFdlc3fvWZyscaNoNEoU8F0LWTgdXxGFZA7umLvIFPebBzd6zHhzXQm/2HaDw0/kT6UqIidBaYnPWOoQQKywKpzBpwudexb6wzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxK/9pf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C0AC4CEC6;
	Wed,  6 Nov 2024 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730902241;
	bh=hR+M/12mz686XDw6qw79yyMcaey3EbYKRvazPCDOwQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxK/9pf0bxWdLwkJ0XFrOHc/8z9aGFghLqiMYid+PmJ4KUJHrrf9hchG0UZuKR5sS
	 JTk4Vhwpmmz2AcIrmkWeogxx/hS1lMNYA5JUMklzJnjthm016pojlcdRNdL66S9W4C
	 WI0+4LoX0k54++97cUt9QpSVWeHEVHV4EsxZ4Cxr8iikxOv326+hzoeNoX8VsJl+nK
	 uI4Ex2g18XPIbmhCvqt+R7VmC9DB3+Ms07DkgrDg7lIqG3k2bgaY8VLMDWj3/d4S4s
	 36j9fSScrodXntyF7oIqtADJOkp26IMc2WYrgHaPQKNvbYgA3Z7spI2wV0j0abOVe/
	 yKJ9lMPNwvqaA==
Date: Wed, 6 Nov 2024 15:10:38 +0100
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
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: imx8m-clock: support spread
 spectrum clocking
Message-ID: <4bix7me5vaoyhcuffyp4btajmhy7no6ltczoesopaz2fqupyaw@fensx4nn472u>
References: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
 <20241106090549.3684963-2-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106090549.3684963-2-dario.binacchi@amarulasolutions.com>

On Wed, Nov 06, 2024 at 09:57:57AM +0100, Dario Binacchi wrote:
> The patch adds the DT bindings for enabling and tuning spread spectrum
> clocking generation.

We had long talks about this but nothing of it got reflected in commit
msg. Sorry, I don't remember what I was talking in some particular patch
month ago, so you will get the same questions over and over...

> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v3:
> - Added in v3
> - The dt-bindings have been moved from fsl,imx8m-anatop.yaml to
>   imx8m-clock.yaml. The anatop device (fsl,imx8m-anatop.yaml) is
>   indeed more or less a syscon, so it represents a memory area
>   accessible by ccm (imx8m-clock.yaml) to setup the PLLs.
> 
>  .../bindings/clock/imx8m-clock.yaml           | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> index c643d4a81478..7920393e518e 100644
> --- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> @@ -43,6 +43,40 @@ properties:
>        ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8m-clock.h
>        for the full list of i.MX8M clock IDs.
>  
> +  fsl,ssc-clocks:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandles of the PLL with spread spectrum generation hardware capability.
> +    minItems: 1
> +    maxItems: 4

1. How is it possible that you change spread spectrum of some clocks from
main Clock Controller, while this device is not a consumer of them?
Basically this means that this device does not have these clocks but yet
you claim that it needs to configure spread for them! It's contradictory
to me and nohing got explained in commit msg about it. I am pretty sure
I asked about this alrady.

2. Why is this array flexible in size?

Best regards,
Krzysztof



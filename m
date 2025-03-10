Return-Path: <linux-kernel+bounces-553687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB0A58D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98FA3A633E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC1722258E;
	Mon, 10 Mar 2025 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuCX5OSx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BED3D3B3;
	Mon, 10 Mar 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593644; cv=none; b=hjYA0GMUV57iuEAhyQ77bi5c3akW2ixW30+mHtcjbtHpTMpRR44OUVQbzgxay55Nok/M3eqL2PVs+PP2h4noE02ruS7KW4+UIeQQary6Q1m3unf5qDEt9xb4+eAUhMZNmTha3izExhVfUYUP0tlLhMmNlxxjqPH1ng/9dyg+5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593644; c=relaxed/simple;
	bh=5pb18jHnC9oIYuysg+/rVDZqxx+VuW6N1Fk5JOZi52Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umIJeeYbPRlSIlenfab66cBHRm1rhC7rNJbFHAJvg0H0XNJH3ZGQzaLLdjK1HmndKkpvHanWGQ2lUEBfh+MXZinnsUU+cQGu5td/ngOSLIN1whiOs5Zzjr+8kwToTn980dPheH26lKc3+kjaIOFhwfQvEzjK4WGo84z5D6x3A9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuCX5OSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8967C4CEE5;
	Mon, 10 Mar 2025 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741593643;
	bh=5pb18jHnC9oIYuysg+/rVDZqxx+VuW6N1Fk5JOZi52Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuCX5OSxtvek+3jpeLGGivDX9bH5syZEQoh3fo7lIu2tSrUfzV1OSaBB+3YTJxt0i
	 XruzWeoeQam7CCtEEnyjDL4Ygz3VqYrPrJiJ7Np0TGF/EGCnkyUQoLY3X3JadalAy1
	 rOP/GHb6ALOJNzOOgNcC2cA3GUjWfSlDV4MGx4CpH+jBP+PdzHcGs57g/l9kxSK2k5
	 lFbrR25L7gee4y5RYyw8vmQVUSZhLdCxwn14Czzkfv2pobA9Lx7Bw12DUL0itcAoV9
	 pS2rWV4p74DN6Pe06y/fJw0WvemJiOBhpYR7o4y5zp8LpI8OvLCZZubb88iFxqeYVE
	 yukd9Ws74Pg3g==
Date: Mon, 10 Mar 2025 09:00:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Nikita Shubin <nikita.shubin@maquefel.me>, 
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>, 
	Ben Hutchings <ben@decadent.org.uk>, Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH 04/13] dt-bindings: soc: airoha: add Documentation for
 Airoha AN7581 SCU SSR
Message-ID: <20250310-aromatic-chihuahua-of-priority-4ee73b@krzk-bin>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309132959.19045-5-ansuelsmth@gmail.com>

On Sun, Mar 09, 2025 at 02:29:35PM +0100, Christian Marangi wrote:
> The Airoha AN7581 SoC have in the SCU register space particular
> address that control how some peripheral are configured.
> 
> These are toggeled in the System Status Register and are used to
> toggle Serdes port for USB 3.0 mode or HSGMII, USB 3.0 mode or PCIe2
> or setup port for PCIe mode or Ethrnet mode (HSGMII/USXGMII).
> 
> Modes are mutually exclusive and selecting one mode cause the
> other feature to not work (example a mode in USB 3.0 cause PCIe
> port 2 to not work) This depends also on what is physically
> connected to the Hardware and needs to correctly reflect the
> System Status Register bits.
> 
> Special care is needed for PCIe port 0 in 2 line mode that
> requires both WiFi1 and WiFi2 Serdes port set to PCIe0 2 Line
> mode.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../soc/airoha/airoha,an7581-scu-ssr.yaml     | 106 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml b/Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
> new file mode 100644
> index 000000000000..4bbf6e3b79a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/airoha/airoha,an7581-scu-ssr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN7581 SCU System Status Register
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: >
> +  The Airoha AN7581 SoC have in the SCU register space particular
> +  address that control how some peripheral are configured.
> +
> +  These are toggeled in the System Status Register and are used to
> +  toggle Serdes port for USB 3.0 mode or HSGMII, USB 3.0 mode or PCIe2
> +  or setup port for PCIe mode or Ethrnet mode (HSGMII/USXGMII).

typo, Ethernet

> +
> +  Modes are mutually exclusive and selecting one mode cause the
> +  other feature to not work (example a mode in USB 3.0 cause PCIe
> +  port 2 to not work) This depends also on what is physically
> +  connected to the Hardware and needs to correctly reflect the
> +  System Status Register bits.
> +
> +  Special care is needed for PCIe port 0 in 2 line mode that
> +  requires both WiFi1 and WiFi2 Serdes port set to PCIe0 2 Line
> +  mode.
> +
> +properties:
> +  compatible:
> +    const: airoha,an7581-scu-ssr

That's not a separate device, but part of the SCU.

But more important - such definition of choice of serial engines is
really not flexible, not reabable and not helping integrating into DTS.
Are you going to grow this for next chip airoha,serdes-wifi20, then
airoha,serdes-wifi21, 22... ? And then how the if:then: would look like?

Assuming you do not have here child-parent relationship, like usually
for serial engines, so then this should be somehow list of devices
(strings) you want to run.

Best regards,
Krzysztof



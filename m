Return-Path: <linux-kernel+bounces-172149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA088BEE1F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC95C1C20CA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC7118734C;
	Tue,  7 May 2024 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/7Z6wOs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F1187331;
	Tue,  7 May 2024 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113718; cv=none; b=WDYUAGz6i6brvSu1vzuLJJtOpi6xRnAMMUrUbCau9vjJLe5gMhCLx9KhhWYuwbnv6H6ZMi9NVGrntzVJ6DrsXQ6u9m93UQ/hY36P/UIUznQ/doF2fKJzjc9QVAwjuiakzDD6yy3u2YPwzdCuerDCBOf9Kq96pQiV3Ue4I8WypQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113718; c=relaxed/simple;
	bh=TCF7hOj8TOI1UmjmvR3q0z4EpIMUXu7CfZrmz7GNu74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oueZSEHCOCwuQB3Poy+iXLqLqc06di5zZ/HiMnWG2jvJoktQJDWaJ9+gGvSew6hlEUFOv/Syek/lrkSH4U+8nZ/tNz2LW6ZTDrzFgLYehSfoVrXTTMGacqu9AzvlqB4ouvh7zzglBOYfVeRoLRhTr3NFxs6Kp4BObd8fXvkMRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/7Z6wOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD7FC2BBFC;
	Tue,  7 May 2024 20:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715113718;
	bh=TCF7hOj8TOI1UmjmvR3q0z4EpIMUXu7CfZrmz7GNu74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/7Z6wOsYQeEg/baJMeFadmC3zvVzz2BSK+Ay9HgDzGibFrhHxxlM11/WYZnhIh4p
	 0PD9QrrfR1KEkjXnOcNwgNf+/RmqTZ6NKoqNJZjbAtBA+vZGHTpunRuQqDyZi6knoC
	 WOjIK42YJOnIk2VNva+KVBUSwdvDJZzoiYfXqV1pk1E8/sI9cWCBaiepHZzw2cDtEE
	 A1CORuNuRBxuMEQ+6ue9qY9jJzjYieLKHsQ3SI5vxdHT7BT5Bur/tHhLfE3lLmrWLe
	 8VwHu9kmqIJXTSyDXuBnHcHV6ihNU7fAmedPF7X07estjZELV33Sxd3GWQc/xSbwr3
	 3RgrJAdZOKBZw==
Date: Tue, 7 May 2024 15:28:36 -0500
From: Rob Herring <robh@kernel.org>
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
	Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Subject: Re: [PATCH 1/5] dt-bindings: display: panel: mipi-dbi-spi: Add a
 pixel format property
Message-ID: <20240507202836.GA997432-robh@kernel.org>
References: <20240507-panel-mipi-dbi-rgb666-v1-0-6799234afa3e@tronnes.org>
 <20240507-panel-mipi-dbi-rgb666-v1-1-6799234afa3e@tronnes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507-panel-mipi-dbi-rgb666-v1-1-6799234afa3e@tronnes.org>

On Tue, May 07, 2024 at 11:57:26AM +0200, Noralf Trønnes wrote:
> The MIPI DBI 2.0 specification (2005) lists only two pixel formats for
> the Type C Interface (SPI) and that is 3-bits/pixel RGB111 with
> 2 options for bit layout.
> 
> For Type A and B (parallel) the following formats are listed: RGB332,
> RGB444, RGB565, RGB666 and RGB888 (some have 2 options for the bit layout).
> 
> Many MIPI DBI compatible controllers support all interface types on the
> same chip and often the manufacturers have chosen to provide support for
> the Type A/B interface pixel formats also on the Type C interface.
> 
> Some chips provide many pixel formats with optional bit layouts over SPI,
> but the most common by far are RGB565 and RGB666. So even if the
> specification doesn't list these formats for the Type C interface, the
> industry has chosen to include them.
> 
> The MIPI DCS specification lists the standard commands that can be sent
> over the MIPI DBI interface. The set_address_mode (36h) command has one
> bit in the parameter that controls RGB/BGR order:
>     This bit controls the RGB data latching order transferred from the
>     peripheral’s frame memory to the display device.
> This means that each supported RGB format also has a BGR variant.
> 
> Based on this rationale document the following pixel formats describing
> the bit layout going over the wire:
> - RGB111 (option 1): x2r1g1b1r1g1b1 (2 pixels per byte)
> - BGR111 (option 1): x2b1g1r1b1g1r1 (2 pixels per byte)
> - RGB111 (option 2): x1r1g1b1x1r1g1b1 (2 pixels per byte)
> - BGR111 (option 2): x1b1g1r1x1b1g1r1 (2 pixels per byte)
> - RGB565: r5g6b5 (2 bytes)
> - BGR565: b5g6r5 (2 bytes)
> - RGB666: r6x2g6x2b6x2 (3 bytes)
> - BGR666: b6x2g6x2r6x2 (3 bytes)
> (x: don't care)
> 
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---
>  .../bindings/display/panel/panel-mipi-dbi-spi.yaml | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> index e808215cb39e..dac8f9af100e 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> @@ -50,6 +50,12 @@ description: |
>        |        Command or data         |
>        |<D7><D6><D5><D4><D3><D2><D1><D0>|
>  
> +  The standard defines one pixel format for type C: RGB111. The industry
> +  however has decided to provide the type A/B interface pixel formats also on
> +  the Type C interface and most common among these are RGB565 and RGB666.
> +  The MIPI DCS command set_address_mode (36h) has one bit that controls RGB/BGR
> +  order. This gives each supported RGB format a BGR variant.
> +
>    The panel resolution is specified using the panel-timing node properties
>    hactive (width) and vactive (height). The other mandatory panel-timing
>    properties should be set to zero except clock-frequency which can be
> @@ -90,6 +96,29 @@ properties:
>  
>    spi-3wire: true
>  
> +  format:
> +    description: >
> +      Pixel format in bit order as going on the wire:
> +        * `x2r1g1b1r1g1b1` - RGB111, 2 pixels per byte
> +        * `x2b1g1r1b1g1r1` - BGR111, 2 pixels per byte
> +        * `x1r1g1b1x1r1g1b1` - RGB111, 2 pixels per byte
> +        * `x1b1g1r1x1b1g1r1` - BGR111, 2 pixels per byte
> +        * `r5g6b5` - RGB565, 2 bytes
> +        * `b5g6r5` - BGR565, 2 bytes
> +        * `r6x2g6x2b6x2` - RGB666, 3 bytes
> +        * `b6x2g6x2r6x2` - BGR666, 3 bytes
> +      This property is optional for backwards compatibility and `r5g6b5` is
> +      assumed in its absence.

Use schemas, not free form text:

default: r5g6b5

> +    enum:
> +      - x2r1g1b1r1g1b1
> +      - x2b1g1r1b1g1r1
> +      - x1r1g1b1x1r1g1b1
> +      - x1b1g1r1x1b1g1r1
> +      - r5g6b5
> +      - b5g6r5
> +      - r6x2g6x2b6x2
> +      - b6x2g6x2r6x2
> +
>  required:
>    - compatible
>    - reg
> @@ -116,6 +145,8 @@ examples:
>              reset-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
>              write-only;
>  
> +            format = "r5g6b5";
> +
>              backlight = <&backlight>;
>  
>              width-mm = <35>;
> 
> -- 
> 2.45.0
> 


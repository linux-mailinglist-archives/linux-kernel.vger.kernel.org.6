Return-Path: <linux-kernel+bounces-420537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A459D7C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4C7B20F32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6601607A4;
	Mon, 25 Nov 2024 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYFrveyd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64C2500AE;
	Mon, 25 Nov 2024 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520750; cv=none; b=rR1zfDoaRC0vfGi3MHF1UiZlgSPjwcqh1R+02BgJpzS7W/l+RUYrWaj83tWJ7w6Fl5mb3dNQ2nBi82NCXO01BNujvWfkqEshDz0ZXK9e/zIj4UI/OssMzEJtra7AhtVQIzYwMA0lIcE7u6SwF99GYzBZ2x0oFuS7p/RyYu9LJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520750; c=relaxed/simple;
	bh=QkmKRQufxVbtOJlGOhCoU0r8+2yxxJyk9PPJcIydGG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhofHyj+CN37BFu0tgckGwNh1Sier5xfciCPZqTw/TObDgKvRR+VUDiEUG/Yv+IekIYcyF2si1x9BHzMPtylCnvSUEqLFj0ouKZLTKlrIN1ftS1ir1FoKt1w80Pz/Yhx2+DtpSU0Y3VFM7WLZB4ZoWXVqI1lNIKd2muufhIZJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYFrveyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A65BC4CECE;
	Mon, 25 Nov 2024 07:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732520749;
	bh=QkmKRQufxVbtOJlGOhCoU0r8+2yxxJyk9PPJcIydGG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYFrveydLiYRWlAIyh8GYlL0YM9Q896zpfUzgrP0F9/Go8fZEYiUzoU56kg8PVMbI
	 c0BolaJeNa1960vBUIJdWNczsAwuU5LjEenBa9nIm0/SHrtDlUGMjs0ASf9Y2QWrbi
	 odnBkyNsXl3TUXYUj0aXwkubOMoLldrvbsHk65USwfjW0KoIiZc/H739irmyq9cjsK
	 Jp/0N6/JvyJK7ut2EnOqctMa9QNnFqxpIK8EClS/Ro9X7CCRi1BX8TzQJx6jfDhA4b
	 Es3cOdNVgtyzREvIT7yFzdZmmMVMlyl54De87aPPHr5dcZwxTVVMwuz9KvqfDHN1mE
	 CY9x0i+yy68Ag==
Date: Mon, 25 Nov 2024 08:45:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindgins: display: Add Apple pre-DCP display
 controller bindings
Message-ID: <ksdp54qj55v7igvvcshl6y2cxpmqy7rlsh4xsixpptjn7s7wlu@76ejtq6ytvbp>
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-1-3191d8e6e49a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241124-adpdrm-v1-1-3191d8e6e49a@gmail.com>

On Sun, Nov 24, 2024 at 11:29:24PM +0100, Sasha Finkelstein wrote:
> Add bindings for a secondary display controller present on certain
> Apple laptops.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  .../bindings/display/apple,display-pipe.yaml       | 59 ++++++++++++++++++++++
>  .../bindings/display/panel/apple,summit.yaml       | 24 +++++++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/apple,display-pipe.yaml b/Documentation/devicetree/bindings/display/apple,display-pipe.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..bd25ddc6e09dd636c0221c854e594113f6011866
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/apple,display-pipe.yaml

No, use fallback compatible as filename.

> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/apple,display-pipe.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple pre-DCP display controller.
> +
> +maintainers:
> +  - asahi@lists.linux.dev
> +  - Sasha Finkelstein <fnkl.kernel@gmail.com>
> +
> +description: |

Drop |

> +  A secondary display controller used to drive the "touchbar" on certain
> +  Apple laptops.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - "apple,t8112-display-pipe"
> +        - "apple,t8103-display-pipe"
> +      - const: "apple,h7-display-pipe"


This wasn't tested... Drop all quotes. Do you see any file with quotes?
Why doing things entirely different than everyone else?

> +
> +  reg:
> +    minItems: 3

Drop

> +    maxItems: 3
> +
> +  reg-names:
> +    items:
> +      - const: be
> +      - const: fe
> +      - const: mipi
> +
> +  power-domains: true

List the items instead or maxItems: 1.

> +
> +  interrupts:
> +    minItems: 2

Drop

> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: be
> +      - const: fe
> +
> +  iommus: true


maxItems: 1

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +additionalProperties: true

This cannot be true. Must be false.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

This goes before additionalProperties.

Missing example: that's a strong NAK and prove that this could not be
even tested.

Do you see any device schema without example? No. Do not develop things
differently, Apple is not unique, special or exceptional.


> diff --git a/Documentation/devicetree/bindings/display/panel/apple,summit.yaml b/Documentation/devicetree/bindings/display/panel/apple,summit.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..dc281c1f52c1ed07cc2f7f804dcfd2f3b4239d89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/apple,summit.yaml
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/apple,summit.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple "Summit" display panel.
> +
> +maintainers:
> +  - asahi@lists.linux.dev
> +  - Sasha Finkelstein <fnkl.kernel@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: apple,summit

No, too generic. Panels need much more properties, this is heavily
incomplete. See other panel bindings.

Best regards,
Krzysztof



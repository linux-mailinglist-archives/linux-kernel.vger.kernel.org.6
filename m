Return-Path: <linux-kernel+bounces-416688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B7F9D48C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8242818DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12981CB339;
	Thu, 21 Nov 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVbnAJJB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0E12FB1B;
	Thu, 21 Nov 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177387; cv=none; b=Z5SAI+DbYjjXxUEn8AenYO1/adp8T7hGaVI/4yvfN/S9PswgONSLCqnlnAeK0pm952LmT/KlGBjhEHA8RcCiGIoVuv/eAfyB+MEzGf2iYCYels828qZ2fTA1NnveNhCqi56tKZ7wEbieiv0cZHbByUzc2adoFQCRzynXjTNzU6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177387; c=relaxed/simple;
	bh=wUfTnjHQ2yL4NbL5Y4AFUH82UDKPs5WqKTu3tB1fwgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYdd7JHEEHeQNQPavH/n07Fgp5/WElY361Zcd0RsP+Egn+uo0chaNP2MDuR4Hvbrnhur1LA+e5VKnRax7yUzJI9++KbzW/4a3ZDP+0rqrHyBWq/s593+QO0fjdFk0tHw9pRiA7dvLeWt0Pm6nb/jx3LdVbJ620qIrViiEmKjbrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVbnAJJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0775C4CECC;
	Thu, 21 Nov 2024 08:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732177386;
	bh=wUfTnjHQ2yL4NbL5Y4AFUH82UDKPs5WqKTu3tB1fwgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVbnAJJB0YKzqkLAlv+RUlK1bsic7FFTr3PrQXxxLvDMpvYiEsNj+QN9blVHNBrRd
	 vgV2DR9hjWxEx8BfsCc5nQUrG+ywgDIf5rE9YiVaDTVu2dv0j38g1AtXMjWtTEuaYL
	 ZK3WTn+KG7uIdD+Hlb1InkCXDpAw8m1TDGBUqADKtEknIZkMLOZilgc7bmFq5JD3XA
	 SQvZcTA2rS9DFCgbzPUuAckR0jEvsbjOk2a7WAqMZ00ZOBoS7ntM9I0wJAjY+jfS1h
	 yvQ+7xPUT9qU1fZ6SgHFoZBI/4/5lCx4GB40DjxL5VaNtLDso7JCXBZzWx2HfnxT/y
	 CjTct7UPCoYfw==
Date: Thu, 21 Nov 2024 09:23:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: keith zhao <keith.zhao@starfivetech.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, 
	william.qiu@starfivetech.com, xingyu.wu@starfivetech.com, kernel@esmil.dk, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	p.zabel@pengutronix.de, changhuang.liang@starfivetech.com, jack.zhu@starfivetech.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/9] dt-bindings: display: bindings for
 starfive,JH7110 display pipeline
Message-ID: <fza6u77alzm6ovzptkh7isztycn72pzae2f62kqeyj3f7ognou@lmp7cg4tr3yw>
References: <20241120061848.196754-1-keith.zhao@starfivetech.com>
 <20241120061848.196754-2-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120061848.196754-2-keith.zhao@starfivetech.com>

On Wed, Nov 20, 2024 at 02:18:40PM +0800, keith zhao wrote:
> - Added bindings to support the display subsystem on the JH7110 SoC.

Please do not use "This commit/patch/change" (implied) and past tense,
but imperative mood. See longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> - Included the DC8200 display controller and Inno HDMI controller.
> 
> - Created innosilicon,inno-hdmi.yaml schema containing common properties
>   for the Inno DesignWare HDMI TX controller.
>   This isn't a full device tree binding specification,
>   but is intended to be referenced by platform-specific bindings
>   for the IP core.
> 
> Signed-off-by: keith zhao <keith.zhao@starfivetech.com>
> ---
>  .../display/bridge/innosilicon,inno-hdmi.yaml |  45 +++++
>  .../display/rockchip/rockchip,inno-hdmi.yaml  |  27 +--
>  .../starfive/starfive,jh7110-dc8200.yaml      | 176 ++++++++++++++++++
>  .../starfive/starfive,jh7110-inno-hdmi.yaml   |  91 +++++++++
>  .../soc/starfive/starfive,jh7110-syscon.yaml  |   1 +

I do not see how you addressed my feedback. I asked you to split the
patch. Where is the split?

Your answer to my request to split was "Background is ...", yeah, so
what? You are not going to split?


>  MAINTAINERS                                   |   8 +
>  6 files changed, 323 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/innosilicon,inno-hdmi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,jh7110-dc8200.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,jh7110-inno-hdmi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/innosilicon,inno-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/innosilicon,inno-hdmi.yaml
> new file mode 100644
> index 000000000000..f2543aebc312
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/innosilicon,inno-hdmi.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/innosilicon,inno-hdmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common Properties for Innosilicon HDMI TX IP
> +
> +maintainers:
> +  - keith zhao <keith.zhao@starfivetech.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.



> +  Innosilicon HDMI TX is an HDMI transmission device integrated into the zap SoC.

Keep and extend.

> +  This document specifies the device tree properties for the INNO HDMI IP core.

Keep... but what is INNO HDMI IP core? Another name? Different block?


> +  It is intended to be referenced by platform-specific device tree bindings,
> +  which will determine the necessity of each property.

Not much improved here. Last two sentences are almost useless. Again -
document the hardware. Drop this sentence.

I already complained about this. I already complained that you keep
ignoring my comments and this does not improve much.

Since you did not implement my main feedback I am going to NAK the rest
except one more thing:

...

> +
> +properties:
> +  compatible:
> +    const: "starfive,jh7110-inno-hdmi"

I could not be more specific in my previous feedback. Improvements? No.
Stop wasting our time.

NAK.

Best regards,
Krzysztof



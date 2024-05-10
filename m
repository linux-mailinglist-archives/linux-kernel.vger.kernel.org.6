Return-Path: <linux-kernel+bounces-175790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF0D8C250E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF4B1C22288
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A46127B69;
	Fri, 10 May 2024 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elRO8c91"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B62376;
	Fri, 10 May 2024 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345321; cv=none; b=gH+WJhBkyddeFZd758KM3C2UIwQ0ZDYCiVmslxCuZCuqFeF1C7v4jmZQuB07oLg/ZJ8zTPqMfLSB9VVoBHmO+dIowQRdIs3Xm/xwMZvpC7aIpbxFosWvIM47gsgUbZh5Dl3PH8V2nNXSDa+GxgbtP7RXbHWh8/TklCnsMzCTOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345321; c=relaxed/simple;
	bh=V8xD1Koidl+pNdYoJfQFLAiAFVdTfdYB2dUbuhjigGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcWmCCkKh+tf/a1Uy08qw/74torTA8TYuW7TNkf1zhjkIV/6eqreOXH2JqWbIvqmgkcKFlZ/iGAp6VbLtnHARQ5k24R0/sgKn09Ejc7XbncRxF5/VpiOUA9jPAos43YBYQK5u/JuhDd//Wxoepn/25pnTH4T9sXoMT9TiCR7RLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elRO8c91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EA9C113CC;
	Fri, 10 May 2024 12:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715345320;
	bh=V8xD1Koidl+pNdYoJfQFLAiAFVdTfdYB2dUbuhjigGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elRO8c91+R0DCAXv7+SLp8jJSCziQgTrHU6dWu9qwHD6XqKBCLiHuCKHNSbrgbcQg
	 eJsQ0tFhCPQE2Y4O65z6uB4IrPGycaFkyuaOcB+YtDbvnjSSu49cJ0WU6MuQoLwWy3
	 VxtXhLaNg2Y2Mv5eWn/LmrdnOqvHRlj/7/dCfxp9tpC9NhIxjD1VnxnJ7Maz3PCPe7
	 LUqVWh0Ve9W2L+elph2QaZ0lc0RXMVlxbhOlTEuz25bOZUBWskDyl4CnteT7owXUgs
	 jlwx/DYGCq9Hoav6/8i3JoYd0Ef4TlYm3FuTRoOTqnsoenH6UTmIUB8FSOwqSIeAVX
	 EXF9K5LfHBQVg==
Date: Fri, 10 May 2024 07:48:38 -0500
From: Rob Herring <robh@kernel.org>
To: Liankun Yang <liankun.yang@mediatek.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	jitao.shi@mediatek.com, mac.shen@mediatek.com,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 2/2] Add dp PHY dt-bindings
Message-ID: <20240510124838.GA3916816-robh@kernel.org>
References: <20240510110523.12524-1-liankun.yang@mediatek.com>
 <20240510110523.12524-3-liankun.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510110523.12524-3-liankun.yang@mediatek.com>

On Fri, May 10, 2024 at 07:04:15PM +0800, Liankun Yang wrote:
> Add dp PHY dt-bindings.
> 
> Changeds in v2:
> - Add dp PHY dt-bindings.
> https://patchwork.kernel.org/project/linux-mediatek/patch/
> 20240403040517.3279-1-liankun.yang@mediatek.com/
> 
> Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
> ---
>  .../display/mediatek/mediatek.phy-dp.yaml     | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek.phy-dp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek.phy-dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek.phy-dp.yaml

git refuses to apply your patch because 'new file mode 100644' is 
missing. You must have edited the patch or something.

If it did apply, you'd notice it fails testing.

> index 000000000000..476bc329363f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek.phy-dp.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,phy-dp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Display Port Controller
> +
> +maintainers:
> +  - Mac shen <mac.shen@mediatek.com>
> +  - Liankun yang <Liankun.yang@mediatek.com>
> +
> +description: |
> +  Special settings need to be configured by MediaTek DP based on the actual
> +  hardware situation. For example, when using a certain brand's docking
> +  station for display projection, garbage may appear. Adjusting the specific
> +  ssc value can resolve this issue.
> +
> +properties:
> +  status: disabled
> +    description: |
> +      Since the DP driver has already registered the DP PHY device
> +      through mtk_dp_register_phy(), so the status is disabled.

What!? Please show me any other binding that has 'status' in it. Go read 
up on how to write bindings and what goes in them.

> +
> +  dp-ssc-setting:
> +    - ssc-delta-hbr
> +    description: Specific values are set based on the actual HW situation.
> +
> +required:
> +  - status
> +  - dp-ssc-setting
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        phy-dp@1c600000 {
> +          status = "disabled";
> +          dp-ssc-setting {
> +            ssc-delta-hbr = <0x01fe>;
> +          }
> +        };
> +    };
> -- 
> 2.18.0
> 


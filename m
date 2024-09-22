Return-Path: <linux-kernel+bounces-335068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D923397E091
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 10:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906B11F214CD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70CB19341D;
	Sun, 22 Sep 2024 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyUqkYX1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3143126C1F;
	Sun, 22 Sep 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726992911; cv=none; b=oA9noVCCPJodrf1Psp0+akY7+XYAoQTtT7iwTAScLQn3UamI1NE3YtWT0QbJBwrfht+isiut8o36b0n0oat/cK6iZITFmujSgHknnFnbP4YozSVlSVO+P7Bxv4wWz6ffbsRGDMhfQQcaC1znjMDrydx/6CMIcmbYCF40J0x+Loo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726992911; c=relaxed/simple;
	bh=06MB9jXULjLdJBovrribICw9x2wLyvoI3aMPRTsxqNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oz/AHwDUECP4djAtvDHjjusy2INFOnqfiLgnChoxnM3olWyQdUhvt+zbALwPpwcV0RYdalCaO3xcK6AkOaFsEfbbKEBbBSE/seoiOEFuGmDQaN8sl6Kg/U8aFvD1i2ydpuRWMJlhW7KHq4+VzOVAbsEzPnzgG+6uTh2hy8KrdsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyUqkYX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4454EC4CEC3;
	Sun, 22 Sep 2024 08:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726992910;
	bh=06MB9jXULjLdJBovrribICw9x2wLyvoI3aMPRTsxqNs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eyUqkYX1Fkmczz8O61XuUnU8gIMcwQ5yCETnVhXXvYWrGl2kIRDqeVUMLsRNSOC6u
	 Hf3qRCDaOBvwDLxucjJjaWVHdHqYaJoAEo3XL+gojteZStYgcYVhFXS1lk4OBwQ5JD
	 6/k5Q7K323UJOw5rIWziUuYv6dLI3JD8Wm8lewqtQ2k1SpW8a1dUoFJs+nOGDNEchV
	 +hNmt15XyxQ0GbgY9R3sd5oetEPLC4wR1chdRHZsdvD9RxtcgBwH/ds2GHR61Ge8vc
	 nbEhxrdC3TDaQe9Fm1Xc95cJuWe6rVHUx0L30OASHNGnl8hS2N6YpZKVvRwFOPHZ8j
	 EU0qDLuun6btw==
Message-ID: <c6821033-57be-4d10-9e37-935f7748570e@kernel.org>
Date: Sun, 22 Sep 2024 10:15:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/rockchip: vop: Split rk3288-vop into big and lit
To: Jonas Karlman <jonas@kwiboo.se>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240921222007.2301868-1-jonas@kwiboo.se>
 <20240921222007.2301868-4-jonas@kwiboo.se>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240921222007.2301868-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/09/2024 00:20, Jonas Karlman wrote:
> The Rockchip RK3288 SoC contain two different Visual Output Processor
> (VOP) blocks, VOP_BIG and VOP_LIT. The VOP blocks support different max
> output resolution, 3840x2160 and 2560x1600.
> 
> Add support for the compatible used to differentiate between VOP_BIG and
> VOP_LIT, support for the old compatible is kept for compatibility with
> older device tree.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 27 +++++++++++++++------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> index e2c6ba26f437..978db93cda33 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> @@ -762,7 +762,7 @@ static const struct vop_intr rk3288_vop_intr = {
>  	.clear = VOP_REG(RK3288_INTR_CTRL0, 0xf, 8),
>  };
>  
> -static const struct vop_data rk3288_vop = {
> +static const struct vop_data rk3288_vop_big = {
>  	.version = VOP_VERSION(3, 1),
>  	.feature = VOP_FEATURE_OUTPUT_RGB10,
>  	.intr = &rk3288_vop_intr,
> @@ -772,14 +772,22 @@ static const struct vop_data rk3288_vop = {
>  	.win = rk3288_vop_win_data,
>  	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
>  	.lut_size = 1024,
> -	/*
> -	 * This is the maximum resolution for the VOPB, the VOPL can only do
> -	 * 2560x1600, but we can't distinguish them as they have the same
> -	 * compatible.
> -	 */
>  	.max_output = { 3840, 2160 },
>  };
>  
> +static const struct vop_data rk3288_vop_lit = {
> +	.version = VOP_VERSION(3, 1),
> +	.feature = VOP_FEATURE_OUTPUT_RGB10,
> +	.intr = &rk3288_vop_intr,
> +	.common = &rk3288_common,
> +	.modeset = &rk3288_modeset,
> +	.output = &rk3288_output,
> +	.win = rk3288_vop_win_data,
> +	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
> +	.lut_size = 1024,
> +	.max_output = { 2560, 1600 },
> +};
> +
>  static const int rk3368_vop_intrs[] = {
>  	FS_INTR,
>  	0, 0,
> @@ -1245,8 +1253,13 @@ static const struct of_device_id vop_driver_dt_match[] = {
>  	  .data = &rk3066_vop },
>  	{ .compatible = "rockchip,rk3188-vop",
>  	  .data = &rk3188_vop },
> +	{ .compatible = "rockchip,rk3288-vop-big",
> +	  .data = &rk3288_vop_big },

Hm... that's not really needed. Instead of having three compatibles, you
could keep "rk3288-vop" as big and then my comment on bindings patch
could be ignored (you keep the compatible).



Best regards,
Krzysztof



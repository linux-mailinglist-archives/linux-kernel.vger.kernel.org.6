Return-Path: <linux-kernel+bounces-510961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63DDA32423
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA487A13E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBB0209F44;
	Wed, 12 Feb 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zp/YQrkU"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD2A2045BC;
	Wed, 12 Feb 2025 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358001; cv=none; b=SKtDit5ne2BXWg1EFNo1LInG0K0CZ8P7UCJk+fxKz2cYtsDCuOBrOEvpzjPU2O21Js8SA5xfuK8U56NOxv0kd8JJdMS/wSCYTb2Vbzkhs70R2wiDnzh/qbdjrSu3OCr6UK0oX4YFb+NRzwqYNhGxJXqm88DymawV3ZT9Y+Cizeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358001; c=relaxed/simple;
	bh=IECdjrzXu5v/OZe0SMdDGL6u05RTxEgdE9UCcnMVYlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsiLcIFK9x/qSow49oyecgg1AaD7KJWA6Nz72mtn2OQiTgK8OnL+hXuAXGgaJ+Aegzt3H1VB6TqEHXux1x/BZUJ8n+95rFYdntg+Ld7AkjH9gOtxn0wNSWsXfeMtpjHfehS2WjB+eJF/5J5RHfABwMWXuKq1kYGtRxFCSJK2nZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zp/YQrkU; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cMbXNzmQOH8F+1fl7QOJ8vHQpv6KHpW1bwAT7N9Q6cI=; b=zp/YQrkUlM3VKBJk7sx3RuhGte
	ESyz5mnvx4yt+lVEggZQ2bVDJCW6SIJZ5FeYFX3r4TZ7LlGV6oz6k5sCGy9L19In/4Wjm3jEEfrgx
	ej0uvffJTtniZjtVY35RINvOV0tLffeNuCvNdw/PNJb6S9SLszQs/bM4SIhcAvwJKeZqIj9LC6SP1
	5lPjf3g2n6XN2kAcuBgtfyn/WnpLJhb1Pakn4wXesAcI6PslxC6v5RxDNF3rc6vTXwqtjcAuPCc4Q
	uv7P3vKr0mtLEpfTDpfV3MZ27eItr7qbSkFyOiqKpUCKbjaxmIizNDA7iC1OE1zgjxle/5Q6/jTtX
	DWvRXEHg==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tiAT9-0003GU-5b; Wed, 12 Feb 2025 11:59:51 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: hjc@rock-chips.com, krzk+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 derek.foreman@collabora.com, detlev.casanova@collabora.com,
 daniel@fooishbar.org, robh@kernel.org, sebastian.reichel@collabora.com,
 Andy Yan <andy.yan@rock-chips.com>
Subject:
 Re: [PATCH v14 02/13] drm/rockchip: vop2: Rename TRANSFORM_OFFSET to
 TRANSFORM_OFFS
Date: Wed, 12 Feb 2025 11:59:50 +0100
Message-ID: <4064785.VqM8IeB0Os@diego>
In-Reply-To: <20250212093530.52961-3-andyshrk@163.com>
References:
 <20250212093530.52961-1-andyshrk@163.com>
 <20250212093530.52961-3-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Andy,

Am Mittwoch, 12. Februar 2025, 10:34:57 MEZ schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> This help avoid "exceeds 100 columns" warning from checkpatch
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

I'm not much of a fan of "randomly" renaming individual constants
(especially when one is now named OFFS, while the rest stay at OFFSET)

- on rk3568 VOP2_CLUSTER_WIN0_TRANSFORMED_OFFSET = WIN0 transformed offset
- on rk3588 VOP2_CLUSTER0_WIN0_TRANSFORMED_OFFSET = WIN0 transform offset
- on rk3576 "someone" sadly decided to not provide the 2nd TRM part anymore
  but I guess it'll be the same.

So instead of just dropping parts from the end, you could also follow
the TRM naming and drop the "_AFBC" from the register name instead?

So going to VOP2_WIN_TRANSFORM_OFFSET, this would also reduce the line
length accordingly, and moving the naming closer to the TRM too.

Alternatively, just add a linebreak at the appropriate position instead.

Heiko


> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 8 ++++----
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index ebc9cb93073c..8e1b742a7550 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1524,7 +1524,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
>  		transform_offset = vop2_afbc_transform_offset(pstate, half_block_en);
>  		vop2_win_write(win, VOP2_WIN_AFBC_HDR_PTR, yrgb_mst);
>  		vop2_win_write(win, VOP2_WIN_AFBC_PIC_SIZE, act_info);
> -		vop2_win_write(win, VOP2_WIN_AFBC_TRANSFORM_OFFSET, transform_offset);
> +		vop2_win_write(win, VOP2_WIN_AFBC_TRANSFORM_OFFS, transform_offset);
>  		vop2_win_write(win, VOP2_WIN_AFBC_PIC_OFFSET, ((src->x1 >> 16) | src->y1));
>  		vop2_win_write(win, VOP2_WIN_AFBC_DSP_OFFSET, (dest->x1 | (dest->y1 << 16)));
>  		vop2_win_write(win, VOP2_WIN_AFBC_PIC_VIR_WIDTH, stride);
> @@ -1535,7 +1535,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
>  	} else {
>  		if (vop2_cluster_window(win)) {
>  			vop2_win_write(win, VOP2_WIN_AFBC_ENABLE, 0);
> -			vop2_win_write(win, VOP2_WIN_AFBC_TRANSFORM_OFFSET, 0);
> +			vop2_win_write(win, VOP2_WIN_AFBC_TRANSFORM_OFFS, 0);
>  		}
>  
>  		vop2_win_write(win, VOP2_WIN_YRGB_VIR, DIV_ROUND_UP(fb->pitches[0], 4));
> @@ -3448,7 +3448,7 @@ static const struct reg_field vop2_cluster_regs[VOP2_WIN_MAX_REG] = {
>  	[VOP2_WIN_AFBC_TILE_NUM] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_VIR_WIDTH, 16, 31),
>  	[VOP2_WIN_AFBC_PIC_OFFSET] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_PIC_OFFSET, 0, 31),
>  	[VOP2_WIN_AFBC_DSP_OFFSET] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_DSP_OFFSET, 0, 31),
> -	[VOP2_WIN_AFBC_TRANSFORM_OFFSET] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_TRANSFORM_OFFSET, 0, 31),
> +	[VOP2_WIN_AFBC_TRANSFORM_OFFS] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_TRANSFORM_OFFS, 0, 31),
>  	[VOP2_WIN_AFBC_ROTATE_90] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_ROTATE_MODE, 0, 0),
>  	[VOP2_WIN_AFBC_ROTATE_270] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_ROTATE_MODE, 1, 1),
>  	[VOP2_WIN_XMIRROR] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_ROTATE_MODE, 2, 2),
> @@ -3547,7 +3547,7 @@ static const struct reg_field vop2_esmart_regs[VOP2_WIN_MAX_REG] = {
>  	[VOP2_WIN_AFBC_PIC_OFFSET] = { .reg = 0xffffffff },
>  	[VOP2_WIN_AFBC_PIC_SIZE] = { .reg = 0xffffffff },
>  	[VOP2_WIN_AFBC_DSP_OFFSET] = { .reg = 0xffffffff },
> -	[VOP2_WIN_AFBC_TRANSFORM_OFFSET] = { .reg = 0xffffffff },
> +	[VOP2_WIN_AFBC_TRANSFORM_OFFS] = { .reg = 0xffffffff },
>  	[VOP2_WIN_AFBC_HDR_PTR] = { .reg = 0xffffffff },
>  	[VOP2_WIN_AFBC_HALF_BLOCK_EN] = { .reg = 0xffffffff },
>  	[VOP2_WIN_AFBC_ROTATE_270] = { .reg = 0xffffffff },
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
> index 29cc7fb8f6d8..8510140b0869 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
> @@ -118,7 +118,7 @@ enum vop2_win_regs {
>  	VOP2_WIN_AFBC_PIC_OFFSET,
>  	VOP2_WIN_AFBC_PIC_SIZE,
>  	VOP2_WIN_AFBC_DSP_OFFSET,
> -	VOP2_WIN_AFBC_TRANSFORM_OFFSET,
> +	VOP2_WIN_AFBC_TRANSFORM_OFFS,
>  	VOP2_WIN_AFBC_HDR_PTR,
>  	VOP2_WIN_AFBC_HALF_BLOCK_EN,
>  	VOP2_WIN_AFBC_ROTATE_270,
> @@ -335,7 +335,7 @@ enum dst_factor_mode {
>  #define RK3568_CLUSTER_WIN_DSP_INFO		0x24
>  #define RK3568_CLUSTER_WIN_DSP_ST		0x28
>  #define RK3568_CLUSTER_WIN_SCL_FACTOR_YRGB	0x30
> -#define RK3568_CLUSTER_WIN_AFBCD_TRANSFORM_OFFSET	0x3C
> +#define RK3568_CLUSTER_WIN_AFBCD_TRANSFORM_OFFS	0x3C
>  #define RK3568_CLUSTER_WIN_AFBCD_OUTPUT_CTRL	0x50
>  #define RK3568_CLUSTER_WIN_AFBCD_ROTATE_MODE	0x54
>  #define RK3568_CLUSTER_WIN_AFBCD_HDR_PTR	0x58
> 






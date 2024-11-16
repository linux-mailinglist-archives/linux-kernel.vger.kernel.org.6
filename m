Return-Path: <linux-kernel+bounces-411870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE39D009D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 20:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A2C1F2247E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30D0195B1A;
	Sat, 16 Nov 2024 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="T7n+2asG"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB206188014
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731784391; cv=none; b=pR+EDsZ6mmwX2SBuke9Yfu28QAZC1fZs9h8RqBdUSzUlyiNtvs2FeAfyN8Y9NoblWaSVRchSmF9JXlTNKXs9rQ9mtIT6s1sYUGXW6v258cAUSfGAuxJIfyIS10Z0xnyyzOxGYhjnows0l2L98rev0D6Q2kNOPFkByuGjZgsYx9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731784391; c=relaxed/simple;
	bh=jRszqVjXdYsqvM5TdOvy8QPS2iCUZS6I42brtGKLxs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TF24lEdoNhBlcw+WLRjjzNM6V33V5D2CHiNqZg+jHuLEqr11197nrTwUJou/QkXKj3mWFVjaiyX7yc97yuOfIB0J3bCqxvAz4/b7gt2IFckiFKHCsjz0T76X/lq2OzoUqYOoaBOc75bSm2M/Y6CxZx7VmT6n8JZGXHQTpebuM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=T7n+2asG; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1731784352;
 bh=dmE8MJeWTk8bxqfJVKrL0wXJqPiElWsvJ7UCb/1ffyQ=;
 b=T7n+2asG+D+AIg0AIXwxwGvNHuGAYpGQDoOW1213jPP4LAk1yI5bqwdvVj9CxFhrf0gPfj+2G
 lejwXy8n/UPkai3wMnn+UtXLdYldQhjzrKhWC+ebAvAUce8kkPpHxhcWffsBrdwlfW0R1JspCD3
 sTIb0nPK3xutRjbCAiSK9XAnbfFvVMAEOkVG2UMsKNuRToQSEdE06kqLty9fHzteAvmmkmNXhzo
 7uOXnrU81Ais54aFnkJyyLiw5PaNgTQvxt6tCv7mbG3vZr0SMzGLkkvsznSpbO1bAP3H6Okpqb8
 MY40XL43rcc2x2XfK3KyPFTOrXnqyfc4noypsiMIKGnA==
Message-ID: <c79c1878-370d-45fa-a802-1d175498bb1c@kwiboo.se>
Date: Sat, 16 Nov 2024 20:12:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/rockchip: vop2: Improve display modes handling on
 RK3588 HDMI0
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com>
 <20241116-vop2-hdmi0-disp-modes-v1-3-2bca51db4898@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241116-vop2-hdmi0-disp-modes-v1-3-2bca51db4898@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6738ee9c127e0383f31a82d6

Hi Cristian,

On 2024-11-16 19:22, Cristian Ciocaltea wrote:
> The RK3588 specific implementation is currently quite limited in terms
> of handling the full range of display modes supported by the connected
> screens, e.g. 2560x1440@75Hz, 2048x1152@60Hz, 1024x768@60Hz are just a
> few of them.
> 
> Additionally, it doesn't cope well with non-integer refresh rates like
> 59.94, 29.97, 23.98, etc.
> 
> Make use of HDMI0 PHY PLL as a more accurate DCLK source to handle
> all display modes up to 4K@60Hz.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 34 ++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 3e4c1cfd0bac6fa90f4cab85e27c2a69b86fc9aa..dfe1a50132d596f036430d7db3631398d0802972 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -158,6 +158,7 @@ struct vop2_video_port {
>  	struct drm_crtc crtc;
>  	struct vop2 *vop2;
>  	struct clk *dclk;
> +	struct clk *dclk_src;
>  	unsigned int id;
>  	const struct vop2_video_port_data *data;
>  
> @@ -212,6 +213,7 @@ struct vop2 {
>  	struct clk *hclk;
>  	struct clk *aclk;
>  	struct clk *pclk;
> +	struct clk *pll_hdmiphy0;
>  
>  	/* optional internal rgb encoder */
>  	struct rockchip_rgb *rgb;
> @@ -220,6 +222,8 @@ struct vop2 {
>  	struct vop2_win win[];
>  };
>  
> +#define VOP2_MAX_DCLK_RATE		600000 /* kHz */
> +
>  #define vop2_output_if_is_hdmi(x)	((x) == ROCKCHIP_VOP2_EP_HDMI0 || \
>  					 (x) == ROCKCHIP_VOP2_EP_HDMI1)
>  
> @@ -1103,6 +1107,9 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
>  
>  	vop2_crtc_disable_irq(vp, VP_INT_DSP_HOLD_VALID);
>  
> +	if (vp->dclk_src)
> +		clk_set_parent(vp->dclk, vp->dclk_src);
> +
>  	clk_disable_unprepare(vp->dclk);
>  
>  	vop2->enable_count--;
> @@ -2192,6 +2199,27 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
>  
>  	vop2_vp_write(vp, RK3568_VP_MIPI_CTRL, 0);
>  
> +	/*
> +	 * Switch to HDMI PHY PLL as DCLK source for display modes up
> +	 * to 4K@60Hz, if available, otherwise keep using the system CRU.
> +	 */
> +	if (vop2->pll_hdmiphy0 && mode->crtc_clock <= VOP2_MAX_DCLK_RATE) {
> +		drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mask) {
> +			struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
> +
> +			if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI0) {
> +				if (!vp->dclk_src)
> +					vp->dclk_src = clk_get_parent(vp->dclk);
> +
> +				ret = clk_set_parent(vp->dclk, vop2->pll_hdmiphy0);
> +				if (ret < 0)
> +					drm_warn(vop2->drm,
> +						 "Could not switch to HDMI0 PHY PLL: %d\n", ret);
> +				break;
> +			}
> +		}
> +	}

Why do we need to do this dynamically here?

The device tree set PLL_HPLL as parent:

&vop {
	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
	status = "okay";
};

Could this not just be changed to assign hdptxphy_hdmi0 as parent?

&vop {
	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
	assigned-clock-parents = <&hdptxphy_hdmi0>, <&cru PLL_VPLL>;
	status = "okay";
};

or something similar?

For RK3328 the vop dclk parent is assigned to hdmiphy using DT.

Regards,
Jonas

> +
>  	clk_set_rate(vp->dclk, clock);
>  
>  	vop2_post_config(crtc);
> @@ -3355,6 +3383,12 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
>  		return PTR_ERR(vop2->pclk);
>  	}
>  
> +	vop2->pll_hdmiphy0 = devm_clk_get_optional(vop2->dev, "pll_hdmiphy0");
> +	if (IS_ERR(vop2->pll_hdmiphy0)) {
> +		drm_err(vop2->drm, "failed to get pll_hdmiphy0\n");
> +		return PTR_ERR(vop2->pll_hdmiphy0);
> +	}
> +
>  	vop2->irq = platform_get_irq(pdev, 0);
>  	if (vop2->irq < 0) {
>  		drm_err(vop2->drm, "cannot find irq for vop2\n");
> 



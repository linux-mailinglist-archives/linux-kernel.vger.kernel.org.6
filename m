Return-Path: <linux-kernel+bounces-395297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 869EA9BBBE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B196282955
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0781C4A19;
	Mon,  4 Nov 2024 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1+njhmS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5117583
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741393; cv=none; b=iWNAOKA4Jg5ULa3v3BfemzAyJZ/1SSPKnlbsOZVX8duQTYxRbrKSSKLCLKECkRr8q7iyp49ZQm/8hJ9LbHDBCJq9s5KTJl+jMSWzXBrSw7kS6rPTfl2iS8KEO08/1rSWOBgegw0i346JIMgjKBgEfC929INTfELGjpA29VdYfb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741393; c=relaxed/simple;
	bh=VIsm+vKuTiWLxy8wAD3WL4oTrYDz0+DlaUdFVPEaR6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEXAUzrzxDbu0gQegJ4ke5P5dxfH97c3day8Sny31Ev0RuF5prLAJztPQVKhzhm/fBj9oOjsbgr7l5cp32m10TwjSIcB2WXbysKaSO5eH3yMfKhWGbLnLXWYbq8PAJ4UHoodQOiJ7B9kzw30nfa2xkxMrYLrvs0rsS4JZC9SYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1+njhmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4221C4CECE;
	Mon,  4 Nov 2024 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730741392;
	bh=VIsm+vKuTiWLxy8wAD3WL4oTrYDz0+DlaUdFVPEaR6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1+njhmS9C1BnrW3KesZysOFKxuFALDbFR1vlBXfaD5I7h4iBZPIIkY4h1VvoQbPh
	 cfMYVpEODRoCc08vE5388BaJKGrm1XAhcTSqvWGVtSGLCmH1mhp26WC2ALSW639Xxp
	 EkwIVT3Ml1rrDaIS74t9EDDYEDq7Y9mS8Un2QOz9Ygg5MUEjhurM5QgTPOiVOAieN3
	 wPulMMf+wmGO0evh0Dt4fi0fvv7Ds5JNLVpZwyQPqBmEM6ozf4oW6C2fgGkUQsB8JY
	 mmcL1vYtMPRamsYCNVaoKKPy6lpWWuE6IfrN+qPWY2c0MSXiw/AaKXIR88x99+uWLe
	 aClf85IRVrBPQ==
Date: Mon, 4 Nov 2024 10:29:50 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Algea Cao <algea.cao@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: avoid 64-bit division
Message-ID: <20241104172950.GA741087@thelio-3990X>
References: <20241018151016.3496613-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018151016.3496613-1-arnd@kernel.org>

On Fri, Oct 18, 2024 at 03:10:10PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Dividing a 64-bit integer prevents building this for 32-bit targets:
> 
> ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!
> 
> As this function is not performance criticial, just Use the div_u64() helper.
> 
> Fixes: 128a9bf8ace2 ("drm/rockchip: Add basic RK3588 HDMI output support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Can someone please pick this up? It is still broken in next-20241104...

https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integration2/builds/2oNvJFRj8tkDieb6VfrMf4rh1Kn/build.log

> ---
>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 9c796ee4c303..c8b362cc2b95 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -82,7 +82,7 @@ static void dw_hdmi_qp_rockchip_encoder_enable(struct drm_encoder *encoder)
>  		 * comment in rk_hdptx_phy_power_on() from
>  		 * drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>  		 */
> -		phy_set_bus_width(hdmi->phy, rate / 100);
> +		phy_set_bus_width(hdmi->phy, div_u64(rate, 100));
>  	}
>  }
>  
> -- 
> 2.39.5
> 


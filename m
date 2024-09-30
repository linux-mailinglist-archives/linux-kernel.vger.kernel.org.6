Return-Path: <linux-kernel+bounces-343503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D784989BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0E81F215BE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44343170A23;
	Mon, 30 Sep 2024 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQGExqGq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EEC16EB54;
	Mon, 30 Sep 2024 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682293; cv=none; b=b632fi8fY5Keu4aYi5oib7udGAwrKtcTruq7LBVTqtnDn4CaBFSleiQ9ZVwg+azURiDn9ZeB+Te8j/Kmh16hpscmgUQ+b8bVjJdFYqYOfqk+dzHY/OQUabm+lBX9pClmu9PnZJhQTsII0p6vJe8Es+Afb9ph5Gnlh1GUyVM55Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682293; c=relaxed/simple;
	bh=hNlNzwLvuBX9rwWnjO4/JPLaI48Tlz1qJu1m0jUpdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlsPLrDGdoNT6iwAoITa3bblvFy6hW+48CAJmnfvPdz5yBxDU5LsYfdqcVYIzH2SUCGwFi7cYGlM1mr0FDea/zj3NbsLW1zjosLGp6K6w1nuaXPQAENk25YKgIeAcjmyW8v2Mt2XPa1S0fT8kxUxeHsLTSUfdK54KHgEwujPUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQGExqGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0200CC4CED5;
	Mon, 30 Sep 2024 07:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727682293;
	bh=hNlNzwLvuBX9rwWnjO4/JPLaI48Tlz1qJu1m0jUpdr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQGExqGq2aPE3j4VEmerBOuBA9h+AxXSq37e0bOCBjl/je9eYV+/ykLoVah07BrfE
	 GVpRcpdUYmGx0opBIcT2tWCB6liMeIfMnbp9hvKqEVhCOUSKPsY6PTVSyccnrg9A/b
	 epH66JiWfAQKHua644mmkoe6mw3Dz6x/AycVgQtL3LrwSQCBCUfOLmnZEmqu+d0sb6
	 oRO6cdYhak5DUXAaB2Z9mhBs+S7fFhG+kHPdBdQQsPNrkSrXcOT+m8DWXcJpkdoXvd
	 hK/6T+Sw5oNLLUvsFF92/E6p6ySbhyAZ7EY/jTvMwGrthrH+QGhP9avQj6wNWreY2K
	 ijU0JQ8Ec0hGA==
Date: Mon, 30 Sep 2024 09:44:51 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Yao <markyao0591@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>, 
	Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH v8 1/3] drm/bridge: synopsys: Add DW HDMI QP TX
 Controller support library
Message-ID: <hax2zu7wlpucxllqapc5dzjirvrkanxkzdxtd2shu3tlc53t3m@ctpcuxifl3ds>
References: <20240929-b4-rk3588-bridge-upstream-v8-0-83538c2cc325@collabora.com>
 <20240929-b4-rk3588-bridge-upstream-v8-1-83538c2cc325@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="s7gahhjnit22mlpj"
Content-Disposition: inline
In-Reply-To: <20240929-b4-rk3588-bridge-upstream-v8-1-83538c2cc325@collabora.com>


--s7gahhjnit22mlpj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 29, 2024 at 01:36:47AM GMT, Cristian Ciocaltea wrote:
> +static enum drm_mode_status
> +dw_hdmi_qp_bridge_mode_valid(struct drm_bridge *bridge,
> +			     const struct drm_display_info *info,
> +			     const struct drm_display_mode *mode)
> +{
> +	struct dw_hdmi_qp *hdmi = bridge->driver_private;
> +
> +	if (mode->clock > HDMI14_MAX_TMDSCLK / 1000) {
> +		dev_dbg(hdmi->dev, "Unsupported mode clock: %d\n", mode->clock);
> +		return MODE_CLOCK_HIGH;
> +	}

Similarly, you should use drm_hdmi_compute_mode_clock here, with RGB and 8bpc

Once fixed,
Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--s7gahhjnit22mlpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZvpW8gAKCRAnX84Zoj2+
dmA3AX9ZbkD3HSjUw8ZudFDWE7bSMD1N/4nblONlQVzDTPoRo/xUWVvxRifyIpHo
n8eWlTcBfjfxBcgbXzYRvbh16CIBICTLF7N9txHbxgi0eIVoUlyBZm+LQF7eS823
KwAALtJWVg==
=VY2V
-----END PGP SIGNATURE-----

--s7gahhjnit22mlpj--


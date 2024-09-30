Return-Path: <linux-kernel+bounces-343494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5B8989BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBFC1C21636
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F141B15C138;
	Mon, 30 Sep 2024 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHk8kVgB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4F13D8A4;
	Mon, 30 Sep 2024 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681765; cv=none; b=grs/VUnAAytA30kAMxogXL8eCCOQkabaQ/f8FKTRapybGHm3mzRunR9UJhu44yIEN4Wih4Aea6IZ0GiR5uMWwpIQb5vfv8AmEQHh93CcourTERdRnksM3R6qVtcZkwbLRV1ix8TtU7GwE7teUPcWHjaMnlD97Yv77E4SvDIH66Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681765; c=relaxed/simple;
	bh=UwQAYfkqO+7NbChaILjq1p3+O1Kla+UdCJwA5Zn+i+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVIxHOsnlHt6Smvk0DYMXCr2ej/O/NKCtA5pa31ZqlXW0CjSrHSPfHQLVX4+Mn0fHhCE0J02FUL4GyWCD/YcRXniVv6jJMajSRRO2ZUvY0WO0vmsJTD1usitbFCGggkOzJUbtzK5Z5aA7jCH5c9fJHVJA19d5A1N5NoxpGsv5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHk8kVgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62884C4CED1;
	Mon, 30 Sep 2024 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727681764;
	bh=UwQAYfkqO+7NbChaILjq1p3+O1Kla+UdCJwA5Zn+i+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kHk8kVgBpj2ON88akPzrIYylMLUgkV1Q6RkC0c2RjwJt/BSIJ87fNshgke5fe46ZJ
	 iYU3wwLz/69kaTz1omPQYJShXxSKJ4LGClpckh5sDkrdpInZCf3YgRU+SbKOqZvsiR
	 C8Xn1I1qxQa3k4ka/MSTR4nRRXlhF4MWv/e9dyB59hX3KoXUv+1PtHykAslywsg2f3
	 wahc09BFFjbHfGmM3aPRurHbNlQ4oR9cZ7P25Wgi5vuSanUHaYREnvBKycnR8Zmvil
	 la5KA0V5/ykcedOKIHuFB+hwMBF9CU1svFkKdsScPnOzIYe/D2q8rWjlRlMB3VC/u5
	 0fZ7wEnwu32FQ==
Date: Mon, 30 Sep 2024 09:36:02 +0200
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
Subject: Re: [PATCH v8 3/3] drm/rockchip: Add basic RK3588 HDMI output support
Message-ID: <i2nsst5bvz2emy54r7ll5pi6uihnvdodkgewevumhrdrr7jr6a@uui3shhzhz2y>
References: <20240929-b4-rk3588-bridge-upstream-v8-0-83538c2cc325@collabora.com>
 <20240929-b4-rk3588-bridge-upstream-v8-3-83538c2cc325@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="7s67ya4tohfqd2w2"
Content-Disposition: inline
In-Reply-To: <20240929-b4-rk3588-bridge-upstream-v8-3-83538c2cc325@collabora.com>


--7s67ya4tohfqd2w2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Sep 29, 2024 at 01:36:49AM GMT, Cristian Ciocaltea wrote:
> +static void dw_hdmi_qp_rockchip_encoder_enable(struct drm_encoder *encoder)
> +{
> +	struct rockchip_hdmi_qp *hdmi = to_rockchip_hdmi_qp(encoder);
> +	struct drm_crtc *crtc = encoder->crtc;
> +	int rate;
> +
> +	/* Unconditionally switch to TMDS as FRL is not yet supported */
> +	gpiod_set_value(hdmi->enable_gpio, 1);
> +
> +	if (crtc && crtc->state) {
> +		clk_set_rate(hdmi->ref_clk,
> +			     crtc->state->adjusted_mode.crtc_clock * 1000);

Sorry, I should have seen it in your previous version, but the rate here
should be the TMDS character rate, not the pixel clock, right?

Once fixed,
Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--7s67ya4tohfqd2w2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZvpU4QAKCRAnX84Zoj2+
drrdAYDIR05FELJA0qfbce9Chdkrm4BQoxsM7sNZLCHRE9StuP0VWBJNhNidV5Ql
k8L4akQBf2bEy3dcSYB6/4q5XJpS664ZDID1RP/TgfiVQJp8F+o0pEH1pevFglig
lzo1uFYjqg==
=sHau
-----END PGP SIGNATURE-----

--7s67ya4tohfqd2w2--


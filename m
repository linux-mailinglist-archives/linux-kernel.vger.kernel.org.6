Return-Path: <linux-kernel+bounces-441726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804559ED31C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D257284CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D281DE8B3;
	Wed, 11 Dec 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brDbfpvF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E61DE890
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937083; cv=none; b=ofkQXBSlRim8ejupeu2B+eopbmVbg4ZywFD1a0/3IQ1HRCnPFTZX8p+VwJ8BelMoKYXT4AQ36JnAeu4ciGYj1lM3ZBWKXpsUPIzyGqSIbG/3kmDfujGPckqr8xD0gh429rMx266JaKkzQ4S6r+Mo6roL8YHZxaECt0DoZ1y+uZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937083; c=relaxed/simple;
	bh=ZjqLUTJeWOjXACbZOVh3wgYJhq52PKF8DhiW1ihUFXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLxu/a2O+En/0ebGi4LiWwfPi61BkQ8GRPmxN7pF92xMmoe10V6rM1BNrasYjQITzRbRyVfNZXr4M7xnLwmxe51cw0dNQBBfX33Gmr1ZOC9UkidbLUOQFdkuMs/nswyVkysar5812xl4bSpGuaWQuHN37OiVzoxI7wgpV6fuNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brDbfpvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDC4C4CEDE;
	Wed, 11 Dec 2024 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733937082;
	bh=ZjqLUTJeWOjXACbZOVh3wgYJhq52PKF8DhiW1ihUFXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brDbfpvFmbj+5WN7Qa8cCcQ+ir/eS47ia+krt4FqmcYcuG9dKADaBEVXickH+Ex8s
	 W3+CgGj+CG3jGHqXfUbqCOZfJDeo109qrxjWITz0If3Ibvn7MuXANi8CcDdVWMKJ0G
	 m0186biZQ/7rlQSw797yMw9r4ZrxyiSNMYwGVsLmIOE0SxYyVU2tHRk4A/vPISq7O6
	 OX39q//AYj1pV+QEFpui4iq5birpGqQZfV0AuGNvPnCFaquSZ5T1y930olz0Fm7FBj
	 VL1dxR75xQ0lkTPsO6AWvZHdWawjbpnOOmP/8VDC7dO4DA2Y/rDrsK1MJvi+beNP28
	 rGwA7J1CyPHSQ==
Date: Wed, 11 Dec 2024 18:11:12 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/bridge: move
 drm_atomic_helper_connector_hdmi_check() to drm_bridge_connector
Message-ID: <cizvtql3vgh2eb66cywietr5dntctp6s7tj7krpchaoucergjl@7sx6mebum2ui>
References: <20241210-bridge_hdmi_check-v1-0-a8fdd8c5afa5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ypf273q5igxgmj35"
Content-Disposition: inline
In-Reply-To: <20241210-bridge_hdmi_check-v1-0-a8fdd8c5afa5@linaro.org>


--ypf273q5igxgmj35
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] drm/bridge: move
 drm_atomic_helper_connector_hdmi_check() to drm_bridge_connector
MIME-Version: 1.0

On Tue, Dec 10, 2024 at 04:16:46PM +0200, Dmitry Baryshkov wrote:
> Reduce boilerplate code and move calls to
> drm_atomic_helper_connector_hdmi_check() to the drm_bridge_connector.
> Initially the drm_bridge_connector didn't use HDMI state helpers
> directly, so each driver had to call that function on its own. Since the
> commit 9a71cf8b6fa4 ("drm/bridge-connector: reset the HDMI connector
> state") it depends on DRM_DISPLAY_HDMI_STATE_HELPER, allowing us to use
> the helper from the generic code too.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--ypf273q5igxgmj35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ1nHsAAKCRAnX84Zoj2+
dtCSAXwNO/fyrfSInuatzozSoYsfh/3NePNgNcP1I3uvQr8PTMO3RWV4oLXQCpJC
GnjHiu4BgL36QE4VHYKeZPAFfIZwx0XiK8izZVvIUgMazMO0UMcYb6nqcWsC0Guu
bU3bTJgmEw==
=3AHp
-----END PGP SIGNATURE-----

--ypf273q5igxgmj35--


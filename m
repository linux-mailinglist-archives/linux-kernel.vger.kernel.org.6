Return-Path: <linux-kernel+bounces-170152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D38C8BD283
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843E5B23E09
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6937156232;
	Mon,  6 May 2024 16:21:22 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08913155752
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012482; cv=none; b=pbnG38paFR99Q8DPM9iPPDC1TjoV26Ft9xRddFfGqsFL7hVnTstqmbQqilAnPgbNZe0/ZzXjf55LNwYHKX/DYudBYojLh1y1rM3PWmohYHN5pzPCuqCP8gAHteMEbqO+Eo5idjTycVI154+hsrzUbu+vbs9Ym4l09wOrH47AVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012482; c=relaxed/simple;
	bh=hH4SCqg/pYVdvvdEtlbEHY8w4yezkRxQAu26Sjylr20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCc46U+NopkWniPeLF2P/BOZWY9QxhePtl6cGWAZTEnEbDllb4lGhJ0kCCfjJsFfOHKlSNU5/3VlWUJAIbvOS9L7U3VXBSZjcW0t/aA0apNqysaeAcVkq+xgZPdtYPPptSUfGuXllo9dOTUf2paC3G8R5+3j/Ka8PDYYrVieZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s415J-0007im-LL; Mon, 06 May 2024 18:21:01 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org
Subject:
 Re: [RFT PATCH v2 15/48] drm/panel: ltk050h3146w: Don't call
 unprepare+disable at shutdown/remove
Date: Mon, 06 May 2024 18:21:00 +0200
Message-ID: <2957706.k3LOHGUjKi@diego>
In-Reply-To:
 <20240503143327.RFT.v2.15.Ibeb2e5692e34b136afe4cf55532f0696ab3f5eed@changeid>
References:
 <20240503213441.177109-1-dianders@chromium.org>
 <20240503143327.RFT.v2.15.Ibeb2e5692e34b136afe4cf55532f0696ab3f5eed@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 3. Mai 2024, 23:32:56 CEST schrieb Douglas Anderson:
> It's the responsibility of a correctly written DRM modeset driver to
> call drm_atomic_helper_shutdown() at shutdown time and that should be
> disabling / unpreparing the panel if needed. Panel drivers shouldn't
> be calling these functions themselves.
>=20
> A recent effort was made to fix as many DRM modeset drivers as
> possible [1] [2] [3] and most drivers are fixed now.
>=20
> Unfortunately, grepping mainline for this panel's compatible string
> shows no hits, so we can't be 100% sure if the DRM modeset driver used
> with this panel has been fixed. If it is found that the DRM modeset
> driver hasn't been fixed then this patch could be temporarily reverted
> until it is.
>=20
> [1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.o=
rg
> [2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.o=
rg
> [3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.=
org
>=20
> Cc: "Heiko St=FCbner" <heiko@sntech.de>
> Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

On a rk3588-tiger with WIP DSI patches and this display

Tested-by: Heiko Stuebner <heiko@sntech.de>

Before this patch on reboot the system emits
[  181.464230] panel-leadtek-ltk050h3146w fde20000.dsi.0: Skipping disable =
of already disabled panel
[  181.465056] panel-leadtek-ltk050h3146w fde20000.dsi.0: Skipping unprepar=
e of already unprepared panel

after applying this patch, those lines are gone.

Also the patch itself looks good
Reviewed-by: Heiko Stuebner <heiko@sntech.de>




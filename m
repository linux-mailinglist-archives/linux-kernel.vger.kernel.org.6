Return-Path: <linux-kernel+bounces-170175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C748BD2DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31E22836B0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E474316B;
	Mon,  6 May 2024 16:30:50 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AAB13D51F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013049; cv=none; b=bhG81yKko//4xhlVrv5HvZ70btlOOYXZlIP+FmL0ORZZaP+jE37sHEKmIiXkPYbbMbbS8VcnTttdLlcqnL3DtIfRsaIVf7zfQsclgCczn3zEKOaNU3n6vu2Et8C1XQY6y2bxBIe6DgVJcnAHdwFrCBuAdL78KCjjw+5owXh8WJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013049; c=relaxed/simple;
	bh=nQnd4aY/pG+UZoMQ241wAudPeJm5NS6R61L+eHJ1yk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwOQnLsP4UgIr4BZOAT3RKnC5HJL9uNysZMznx1JVepZzBURzUmcWS+yfGhPAKhR1pdBH6J35uTi65piFowW+Qmqp/cQoY+2NkI9gG155yv5pIMNlyPmyH7tCUf/FDfaTqe3m0+dIGEWLBclh++X8ilGQzUzWnULmgtObb/d/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s41Ea-0007pO-2R; Mon, 06 May 2024 18:30:36 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Douglas Anderson <dianders@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org
Subject:
 Re: [RFT PATCH v2 17/48] drm/panel: ltk500hd1829: Don't call
 unprepare+disable at shutdown/remove
Date: Mon, 06 May 2024 18:30:34 +0200
Message-ID: <3555122.aV6nBDHxoP@diego>
In-Reply-To:
 <20240503143327.RFT.v2.17.If3edcf846f754b425959980039372a9fd1599ecc@changeid>
References:
 <20240503213441.177109-1-dianders@chromium.org>
 <20240503143327.RFT.v2.17.If3edcf846f754b425959980039372a9fd1599ecc@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 3. Mai 2024, 23:32:58 CEST schrieb Douglas Anderson:
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
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

the underlying setup (rockchip-drm with dw-dsi) as well as the
change itself is similar to the ltk050h3146w variant, so I don't
see how this should behave differently ;-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>




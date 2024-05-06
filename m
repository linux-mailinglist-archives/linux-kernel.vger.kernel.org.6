Return-Path: <linux-kernel+bounces-170171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793D28BD2D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C292858E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E17156C70;
	Mon,  6 May 2024 16:29:49 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104F156C60
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012988; cv=none; b=Fes7HvjU4cO7KBLLFM2SJFJfTtww52kApFfU6/lzHuvRPW+erZ+QhuEy8xiYwpED/KiUhiQHAfolSyWfA51PT7NigCdjwBU/KfeTl1klMmRVyikKN5nxMnFBZX/r+iZ15dcC4+klwNaofsCUoQ2ouHbXHVmCMewqfmZsG9hbCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012988; c=relaxed/simple;
	bh=irpWkmoPStzbH23cwBbGY13D9tMbnujUBu94fibKono=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmfxIxih5wP7QxycJ7EZLoW8OBaTT2IFdcgW5TSFguPDKMz7LhKJEuZqB+eaq/j3rXzxAGRjZ/+fDE3UaJAqsOnDwgWyaChtCjnSfmL/gpmNjzhitZRU1ak5OkmGKVU3e2yeu1iuwtNDPiGU6MNz6zXMbhmB+t+2ObrK85WNN64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s41Dc-0007nh-IG; Mon, 06 May 2024 18:29:36 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Yuran Pereira <yuran.pereira@hotmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,
 Brian Norris <briannorris@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
 Nickey Yang <nickey.yang@rock-chips.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org
Subject:
 Re: [RFT PATCH v2 12/48] drm/panel: kingdisplay-kd097d04: Stop tracking
 prepared/enabled
Date: Mon, 06 May 2024 18:29:35 +0200
Message-ID: <3909960.LM0AJKV5NW@diego>
In-Reply-To:
 <20240503143327.RFT.v2.12.I711d07c4f4738df199697fd534c452cdfa46a21f@changeid>
References:
 <20240503213441.177109-1-dianders@chromium.org>
 <20240503143327.RFT.v2.12.I711d07c4f4738df199697fd534c452cdfa46a21f@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 3. Mai 2024, 23:32:53 CEST schrieb Douglas Anderson:
> As talked about in commit d2aacaf07395 ("drm/panel: Check for already
> prepared/enabled in drm_panel"), we want to remove needless code from
> panel drivers that was storing and double-checking the
> prepared/enabled state. Even if someone was relying on the
> double-check before, that double-check is now in the core and not
> needed in individual drivers.
>=20
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Chris Zhong <zyw@rock-chips.com>
> Cc: Nickey Yang <nickey.yang@rock-chips.com>
> Cc: "Heiko St=FCbner" <heiko@sntech.de>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

the underlying setup (rockchip-drm with dw-dsi) as well as the
change itself is similar to the ltk050h3146w variant, so I don't
see how this should behave differently ;-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>




Return-Path: <linux-kernel+bounces-170173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A958BD2D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8001286EB8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B8F156991;
	Mon,  6 May 2024 16:30:34 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240A41C77
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013033; cv=none; b=LUSXZVtNcjfbRzqB0zkc/TjY8TsokSe85oYvvHRjwfl9VTJaCRzUk1URVvZZAUIaDpF+2B9oUkNaPMR4EQLViHC67Ns6a9F/EoxO4EE3LnupQrUzb+imMfTK2As700hD4Q+j2WoIINAy+h16v9u/Ona6niTHGotumDK5abstu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013033; c=relaxed/simple;
	bh=Ns1sXKPWj780m2DteajMGtUHsUrjT0YHaSs1WW3dFEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MI32/OOLs2qCdm5S/ji/FAgyQqqcXNxrRQVygcE2PrnGIgzn1Im4w7YwBfH8Yep4/G6MVVgzd37SxY9nPIExjV5gSNaWmZuo/F25dHO+x2GwrgZ8nwBMrV5OXqUXrTN2LgEAz3ePCMGzJF3KU6iuqthRhVowX0p9A4n1qW5Mg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s41EK-0007os-Mw; Mon, 06 May 2024 18:30:20 +0200
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
 Re: [RFT PATCH v2 16/48] drm/panel: ltk500hd1829: Stop tracking prepared
Date: Mon, 06 May 2024 18:30:19 +0200
Message-ID: <2537177.72vocr9iq0@diego>
In-Reply-To:
 <20240503143327.RFT.v2.16.I4f574b87fe24765ddd4424437159b37a6481aa1a@changeid>
References:
 <20240503213441.177109-1-dianders@chromium.org>
 <20240503143327.RFT.v2.16.I4f574b87fe24765ddd4424437159b37a6481aa1a@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 3. Mai 2024, 23:32:57 CEST schrieb Douglas Anderson:
> As talked about in commit d2aacaf07395 ("drm/panel: Check for already
> prepared/enabled in drm_panel"), we want to remove needless code from
> panel drivers that was storing and double-checking the
> prepared/enabled state. Even if someone was relying on the
> double-check before, that double-check is now in the core and not
> needed in individual drivers.
>=20
> Cc: "Heiko St=FCbner" <heiko@sntech.de>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

the underlying setup (rockchip-drm with dw-dsi) as well as the
change itself is similar to the ltk050h3146w variant, so I don't
see how this should behave differently ;-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>




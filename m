Return-Path: <linux-kernel+bounces-367686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C79A055E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD531F26862
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8F9205E0C;
	Wed, 16 Oct 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BkQ5/39T"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2CB205E06
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070614; cv=none; b=B6i+/wZBo3n8jtUJB/7Sg15yaxTfdIwECH1OZqZO/5+M7KCsFNk2a0r1cxS/Yn+/rpaWluzTMJY0n6MjE/G0x6loUqI7vFXVqEweLSv6umEE6Kwv8OCx2aElJdypfOv1Oszxj640+wiM9WTzj5nXy9yrxDXWBYHXxljHfJ5DoZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070614; c=relaxed/simple;
	bh=qIx8iugOIUWLMHfINQK2rHyqZiPqD+qIYHJtrMpJ0AY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQA6yzTaWDCqvb2zQ2A0ZbSh8g6p2CO0AYxjsxz1rNESKg6xTnaZVpIo23exWMy877hK5WC7vNzlhqQyelo7GFPL6CZ2KxETSAgqaBPfx8QFTjS2F2lDKqM91SA+GZHb3Ptn3YZWjNLYJ+xUYFNMmDwZDG4lczD483ItLivEbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BkQ5/39T; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ekwlenqgozbevlhzioimqt252m.protonmail; t=1729070611; x=1729329811;
	bh=qIx8iugOIUWLMHfINQK2rHyqZiPqD+qIYHJtrMpJ0AY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BkQ5/39Tv+FZxVf8VlKSrWEl6fBQyFVYozY/gfIMWYYSwtNeJ6ykroT33nTXBGi/S
	 NazhFU1StdZo3ibic2l2OSF7pmvMH2gN0HTVhFi0wctl0QY19Z6baD4MDNvy2nbZnn
	 tp0u17XAr+wwLT62n8zzDSMMYzSF9LbNu9BJUgpds77t04fqj633Pc/yeUOvkUeVRp
	 4HBWbbPOJW9QlN7u9g/Uxt6YPX+7PYBv1b3fcPWGzeSNIHs33IgxdSXt6FiAULo2jc
	 5hV3B6pkQ4Dp4KwryrTJm5gxq/RyrXQEtvGtLEejtYXQGA0gQjeMMHKr0b286BLNZN
	 6dBvj3BcVlvYQ==
Date: Wed, 16 Oct 2024 09:23:27 +0000
To: Andy Yan <andyshrk@163.com>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, Daniel Stone <daniel@fooishbar.org>, Dragan Simic <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>
Subject: Re:[PATCH v5] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <bDA4Uh6mp04Po1miJIueRsMNZ9W09DHEnRjG4CzWBn243gI_ExYhjwC9j-KMgOvUS5ofKsAa926IGfVGz4fNt9P_kOBpTyIOakgbB9Sqc-4=@proton.me>
In-Reply-To: <13fc0084.1321.19292eec34e.Coremail.andyshrk@163.com>
References: <20241014222022.571819-4-pZ010001011111@proton.me> <13fc0084.1321.19292eec34e.Coremail.andyshrk@163.com>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 74bd86e8529d5379f9ae4a2020a10169c9e66dec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,=20

> >=20
> > static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
> > @@ -2790,7 +2945,13 @@ static int vop2_create_crtcs(struct vop2 *vop2)
> > }
> >=20
> > drm_crtc_helper_add(&vp->crtc, &vop2_crtc_helper_funcs);
> > + if (vop2->lut_regs && vp->crtc.dev !=3D NULL) {
>=20
>=20
>=20
> There is no need to check vp->crtc.dev here, set has been set in drm_crtc=
_init_with_planes .

I tested it and this check must be here because trying to enable color mgmt=
=20
on CRTC with no associated device, causes null ptr dereference later on in=
=20
drm_crtc_enable_color_mgmt (unless something changed in recent kernel=20
versions, last time I tested was 6.10? or even 6.8).

Best regards, Piotr Zalewski


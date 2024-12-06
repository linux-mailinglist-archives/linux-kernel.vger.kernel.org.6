Return-Path: <linux-kernel+bounces-435515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2139E78E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5415D1886BD5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7154D1FA25C;
	Fri,  6 Dec 2024 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TgMB9PJi"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4038D1D515D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513181; cv=none; b=V+JXumL2TYzGo/zbYkXuYh+FlImRT5ubWj6rapMH7Ii3ccRaPp4M4QU0At3mhyWYi7cRso9N3ubxqRNuNUeCQjxOE+MoiI9VMQH6V+o18zYOqpswlokoy6oLWQ61wquL/lYCL3HxAfrRZAKTw/nRhPDCDSg/DWDVovkjNfGY3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513181; c=relaxed/simple;
	bh=j7XXXKkIAYDG7MKyAJ5ACLlEnB9MdP6qrrb6nhhxNYA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ue1T/cDQWxKEQZ742of7GQt8NfX06LtIcrw1xQFgM4UbAKQZZs8CKA/LoIQRbBW0eWgWD/tYPoYZZajaWNsSNQe538RliqBQDbubmuIwVvRvUau0+X/2c2deTNRKGMIyd/J020varqGJrdsR86ne0YvbRavSgX3C0GHJxtj4O8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TgMB9PJi; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1733513176; x=1733772376;
	bh=X8JUvZDF8pZ0yrFE3tmHbXwwXfZImzkkNaXc3mj/tqA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=TgMB9PJiYp1AurePQcKDKKRhb5iu7GXqi7HXbRGra+wqFlXoUGGHvGPUG4I8EzHCf
	 38EZb0oX8K8OOhPCN4JxOEvRaHBabV/nh+bAmgtOaYnwjW7K5p1scQueIbixupVC5H
	 VUlhfcSyz/U8Kty3kKByJkbOUWkTGYIrcO1H3QI0FbuRidUd3yr6+ItKsqlPqydlTQ
	 nLok/LZDKd4/3MCaC9ICWJt5kavTRXGtjt0Sh1r6Ksb87k2amfohwKGNr6ZtsfQcEe
	 pfCYLGTLQlQAT0yQlrqSLzC5CBhMKMmJtWcJrEVNr5tCtfrDgsbBgmzhfDJ08byBhh
	 pbK1JdFAXvUmQ==
Date: Fri, 06 Dec 2024 19:26:10 +0000
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: Piotr Zalewski <pZ010001011111@proton.me>
Subject: [PATCH drm-misc-next] rockchip/drm: vop2: don't check color_mgmt_changed in atomic_enable
Message-ID: <20241206192013.342692-3-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: eb3005eed4d313c0c579f9dbf9bb42fd9ad30527
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Remove color_mgmt_changed check from vop2_crtc_atomic_try_set_gamma to
allow gamma LUT rewrite during modeset when coming out of suspend. Add
a check for color_mgmt_changed directly in vop2_crtc_atomic_flush.

This patch fixes the patch adding gamma LUT support for vop2 [1].

[1] https://lore.kernel.org/linux-rockchip/20241101185545.559090-3-pZ010001=
011111@proton.me/

Suggested-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm=
/rockchip/rockchip_drm_vop2.c
index 0c8ec7220fbe..d259f1c6571d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1601,7 +1601,7 @@ static void vop2_crtc_atomic_try_set_gamma(struct vop=
2 *vop2,
 =09=09=09=09=09   struct drm_crtc *crtc,
 =09=09=09=09=09   struct drm_crtc_state *crtc_state)
 {
-=09if (!vop2->lut_regs || !crtc_state->color_mgmt_changed)
+=09if (!vop2->lut_regs)
 =09=09return;
=20
 =09if (!crtc_state->gamma_lut) {
@@ -2669,7 +2669,7 @@ static void vop2_crtc_atomic_flush(struct drm_crtc *c=
rtc,
 =09struct vop2 *vop2 =3D vp->vop2;
=20
 =09/* In case of modeset, gamma lut update already happened in atomic enab=
le */
-=09if (!drm_atomic_crtc_needs_modeset(crtc_state))
+=09if (!drm_atomic_crtc_needs_modeset(crtc_state) && crtc_state->color_mgm=
t_changed)
 =09=09vop2_crtc_atomic_try_set_gamma_locked(vop2, vp, crtc, crtc_state);
=20
 =09vop2_post_config(crtc);
--=20
2.47.1




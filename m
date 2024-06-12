Return-Path: <linux-kernel+bounces-212179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE97905C64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B45D284718
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6326D84D11;
	Wed, 12 Jun 2024 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Vtz+E3fb"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78857E110
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222158; cv=none; b=e7juZPX/fNju8sM571SsMQf+LASwa2un7HdGo5/R+Vbrysg5jpMccTPAYHa0dNbCujqbLjI0wMcj+4zqTN2sWRbXyLQdw2Xy3l8DFQrn0Fd7BcIzYYt7OjxTnAJR2DSz7iJ8ZjwPeLWe7DKiEpQqS5oz4zwUGkQxIo8KMUPnxoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222158; c=relaxed/simple;
	bh=Dh2KtUvAtiglq0b5/QtxJb7/lWsVoYr0FusrI650O/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uk9xPwkQcD8MnCG+8+9iMb+QQumE2qz35ohFhnkuGOFDTunGqwH59fV/AaIemsU2mdXkfRFjUmIh+cjPNWYfFApKWWNdUKH6gh4j1TFsAa8oxfmSibNrmWMz7XSjGtVz0/ehDmDQNdJXGvjzQ1wMBUnkOi4IeyDJMVYQaN+JPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Vtz+E3fb; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ld6CWp6MvzsfLCexkDmw2gq97DL2MMR6pnNJDMxtfIA=; b=Vtz+E3fbD9VMAjoM7eXXw/SekN
	/PGXprwiiarZARHaEYw01wCUTLmPpMy3P2njBf20E2WoMhObsnQPJ/ht8zj8hmcbsthTvjr7CpFow
	B1fLTQ+hYpXR87n+bzFaP5+eGIkDr/NhT9QuGdD32fUZDRnP/aYuZBm1HuW103UfEIBaU7UBs9yv1
	dzaues67Dmyc8wccMFs0E1EssR4SLmIDKjRWRRz3f3V+Tmcelbfe++1CIAqYUW/xKBqYZVIY/9fL9
	E8g+/0zAE+dAQdKtaFF6QlAPRhEbpPds8lj9UPBh6ZX3/7HO2/xtFWUQqc2U3QQTFkCX/SBH/h8Ot
	L93b3x3A==;
Received: from [191.204.194.169] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sHTmg-002RtF-JM; Wed, 12 Jun 2024 21:37:27 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 1/3] drm/atomic: Allow userspace to use explicit sync with atomic async flips
Date: Wed, 12 Jun 2024 16:37:11 -0300
Message-ID: <20240612193713.167448-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612193713.167448-1-andrealmeid@igalia.com>
References: <20240612193713.167448-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow userspace to use explicit synchronization with atomic async flips.
That means that the flip will wait for some hardware fence, and then
will flip as soon as possible (async) in regard of the vblank.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 22bbb2d83e30..2e1d9391febe 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1070,7 +1070,9 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
-		if (async_flip && prop != config->prop_fb_id) {
+		if (async_flip &&
+		    prop != config->prop_fb_id &&
+		    prop != config->prop_in_fence_fd) {
 			ret = drm_atomic_plane_get_property(plane, plane_state,
 							    prop, &old_val);
 			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
-- 
2.45.2



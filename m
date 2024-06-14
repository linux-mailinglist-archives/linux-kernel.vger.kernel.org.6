Return-Path: <linux-kernel+bounces-215155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4D5908ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EFC1C21507
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54F61591E8;
	Fri, 14 Jun 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sY3VDxFt"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19A14F12C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379362; cv=none; b=XhOs3E0gAQRIu9EftmwB9pCbRg91HnlD4u9eDFEgFskx/p2vNix/hpAdb10FAcFcFJ8fa6aN2I8TF+ijBcOj9AS/8r4GdR3Npyyj9ZFHfUDXpNL3xycS6vmJcSW9XRyK+LzSN+x5IM3KBoyd0a74W4gZucEIC0GyP+9vV8uGamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379362; c=relaxed/simple;
	bh=Dh2KtUvAtiglq0b5/QtxJb7/lWsVoYr0FusrI650O/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKwEATuyCtS3Hj5Ie0qGUZ7yXPsMSEubSII1RsTQZF/RQLm7IGWdVHn5vPCTTS50xWMPyN16iAWQAhlHh9D6IDcIQPPcGf7ZXv5HWkcz2+044LKcXOwrIvSonZOkKzwLHqKiEA0u0djhOdQiYQtjUmBPAg/oIJRuoBfLMJMvQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sY3VDxFt; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ld6CWp6MvzsfLCexkDmw2gq97DL2MMR6pnNJDMxtfIA=; b=sY3VDxFtjDG94nMWnI8LoODQM/
	CfwK10xGRc3gV3HrREQ/ZDn40krSt42MQYtXj982F0l8ux8pMREE20+LBaR0YewLAeF9nbb9ohIPm
	s2Pm6tuAuwFFykGRP7Ex1ez0TFI2chX2sxZExktfwseTjoCbpnHnxbO7s2w6oDKjCCC4zFbA1LxiJ
	dnlT4+k/NG6nhQyZ9E7zKZVX2w9aj21cdqw0RVTBTw2BYm1ZqYEipwU04VOYHroSIKUa49fTW8dR5
	FebepwDSkhQXvw7AUtXvrS3mYBA/Zz3yYAzPXYW601GyWph0PSbs4pVaax6RKt5oYB2mEkB05MjC5
	kH22fqCA==;
Received: from [179.118.191.115] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sI8y2-003B8v-9T; Fri, 14 Jun 2024 17:35:54 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Melissa Wen <mwen@igalia.com>,
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
	Sam Ravnborg <sam@ravnborg.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6 1/8] drm/atomic: Allow userspace to use explicit sync with atomic async flips
Date: Fri, 14 Jun 2024 12:35:28 -0300
Message-ID: <20240614153535.351689-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614153535.351689-1-andrealmeid@igalia.com>
References: <20240614153535.351689-1-andrealmeid@igalia.com>
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



Return-Path: <linux-kernel+bounces-225777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E930B913545
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 19:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F78D283357
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13971758E;
	Sat, 22 Jun 2024 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OuS4P942"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3DCB676
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719076222; cv=none; b=FARM+thcYLoSXE08DlM2kLQjvw0may6yQakmmw23xSda9Oua8RjU8Wy5MDDjqD1Bp53krBj5Izunp/mHWXMrQbVsS4VGAml8Dj8bn2+yZ+KjOqYlyJPpxOPzyNrg+4ZsY7ss6t/0PrVdY8vJnh8DAvIcdYrp09KJGFKcm56mbMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719076222; c=relaxed/simple;
	bh=SQoEwEuHJ+iWmVuwJ24otA1ws+Xmdw2EtJn2Qf7vKVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eifdzdIyYGA5BJdSXiiV5bU3ba0CEc1KNHH1firbCHTJbFumh5YSU0fZxLQeWg7ZLzMdHpdrGZUPHiFIAHDVI7xTegUME/xeIaIyL+3DaEpspMlT6pudpEU8nRsfj+/hsKb8PO2qJPTPFaipcIrpPNFnle6B+1Ob7n5yEZtUN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OuS4P942; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=H+o6I3yd3ZNoi6S4FTmeSPrddOdzLyRU18zr6k0cESE=; b=OuS4P94211wsegv3PyljUJtsUD
	Rp1VAP5vACxzr9mMZXz+bEqG8fe6BJxbc7GbI/qH4JlZWe9MTcbxtBmvgo9p915CoE7hOMY/UMeU7
	lKyOde6lKeWKE9/R7MXf8d5RPoy/k2ZDjMicoFAAuP6R9HiFK0XY9PZ7/MrcKg/JToLrQvGXrXRgT
	t5jgZT9289kSGSaKKTn7FfC91PEFaM0xP2SiIenIx1TniwTxTNq6A9wFNsPrZuTJJsE5vFwY7b31y
	Z6FzZx7ONPR5c07+AgROF5cebHdiHv6fcAj5T0b4VKbHNe9xTrK3XnMcHnKXdtFP8p6HAXj0r6G5M
	cSS3T5Vw==;
Received: from [179.193.0.190] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sL4FU-006IW4-D0; Sat, 22 Jun 2024 19:10:00 +0200
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 1/1] drm/atomic: Allow userspace to use explicit sync with atomic async flips
Date: Sat, 22 Jun 2024 14:09:51 -0300
Message-ID: <20240622170951.738735-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
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

This patch is originally from a patchset, but it doesn't really depends on the
rest of the work, so I'm sending it standalone now.

Original thread: https://lore.kernel.org/dri-devel/20240618030024.500532-1-andrealmeid@igalia.com/

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



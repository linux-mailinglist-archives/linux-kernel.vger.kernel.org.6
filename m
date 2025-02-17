Return-Path: <linux-kernel+bounces-517012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F6FA37AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70E63A8E95
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B124183CA6;
	Mon, 17 Feb 2025 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ikI0hylY"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F90137750
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739770674; cv=none; b=BMHkmE6qkYVeJ+n4ON9M8/SXoLntzBv3/C8Lurq0/A/dpHmU3q1JCpAnXh7iOowqL5xupwvk9zWTpQlX/yzLdBiiS07KD2MczbmfB2C5huIVqE7vuQSq8pDVP4AidH6PZWN+OgR4AL9DKBOtb9wQ42NLys2hCgpDCOrRPdXG/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739770674; c=relaxed/simple;
	bh=aohlNE3sp+EZSse6h0vdAdyitlo7jWoQr65EYPkC03Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfdTW15Mc7fjzq06oADnqnt9IvJCGjU/25CvMohWNFXzcRVUmvRCkYhP+ztE6OPRC2S6t2LwcH/jxvV1d5jti9W1PbNw++P6w8RU5/RZGpSijVf4aQ33dshTiDVgPehEYKgVVt5F9naw2GHq2WeaS9rd/40nRHFU1bK0r6+02D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ikI0hylY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739770671;
	bh=aohlNE3sp+EZSse6h0vdAdyitlo7jWoQr65EYPkC03Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikI0hylYANVUoJGaDr7ylRKbTO2sR3u9EfO1DIzp+evkXAP8BXSvIdJ9OUd38dCrE
	 JEcV36YIjh6/A3rH5GsPdB7z+lbRmYCwLUg/5/BblohEJiezD5Iyj43x9cHpTlvZQO
	 H0DPvkr2/yskH0LzrfAhQ5s9U5daYu1nLaG4Qr5WQlU87VONU0Z5DPxnP6CxXW3T01
	 M1Qc45Zm8QftkfH5KuhTdr843cAtmiWGD+uyVJK8AHyL1FAmwMUSV1U7BEJQJ9Pg2l
	 qeqb+6OrdkQMQoxvb/GVXrxjqyRij/jT2tE/6f4oMMLFMKMM0tsxDCCuoB24f/746H
	 N6v+PRhcmYoAA==
Received: from localhost.localdomain (unknown [171.76.83.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B8B6517E154F;
	Mon, 17 Feb 2025 06:37:45 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.fornazier@gmail.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch,
	robdclark@gmail.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	valentine.burley@collabora.com,
	jani.nikula@linux.intel.com,
	dmitry.baryshkov@linaro.org,
	mripard@kernel.org,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] drm/ci: enable CONFIG_DEBUG_WW_MUTEX_SLOWPATH
Date: Mon, 17 Feb 2025 11:07:11 +0530
Message-ID: <20250217053719.442644-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217053719.442644-1-vignesh.raman@collabora.com>
References: <20250217053719.442644-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable CONFIG_DEBUG_WW_MUTEX_SLOWPATH for mutex
slowpath debugging.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - New patch in the series.

v3:
  - No changes.

---
 drivers/gpu/drm/ci/build.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ci/build.yml b/drivers/gpu/drm/ci/build.yml
index 274f118533a7..6c0dc10b547c 100644
--- a/drivers/gpu/drm/ci/build.yml
+++ b/drivers/gpu/drm/ci/build.yml
@@ -67,7 +67,7 @@ testing:arm32:
     #
     # db410c and db820c don't boot with KASAN_INLINE, probably due to the kernel
     # becoming too big for their bootloaders.
-    ENABLE_KCONFIGS: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT"
+    ENABLE_KCONFIGS: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT DEBUG_WW_MUTEX_SLOWPATH"
     UPLOAD_TO_MINIO: 1
     MERGE_FRAGMENT: arm.config
 
@@ -79,7 +79,7 @@ testing:arm64:
     #
     # db410c and db820c don't boot with KASAN_INLINE, probably due to the kernel
     # becoming too big for their bootloaders.
-    ENABLE_KCONFIGS: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT"
+    ENABLE_KCONFIGS: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT DEBUG_WW_MUTEX_SLOWPATH"
     UPLOAD_TO_MINIO: 1
     MERGE_FRAGMENT: arm64.config
 
@@ -91,7 +91,7 @@ testing:x86_64:
     #
     # db410c and db820c don't boot with KASAN_INLINE, probably due to the kernel
     # becoming too big for their bootloaders.
-    ENABLE_KCONFIGS: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT"
+    ENABLE_KCONFIGS: "PROVE_LOCKING DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT DEBUG_WW_MUTEX_SLOWPATH"
     UPLOAD_TO_MINIO: 1
     MERGE_FRAGMENT: x86_64.config
 
-- 
2.43.0



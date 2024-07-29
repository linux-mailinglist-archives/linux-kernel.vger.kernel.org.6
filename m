Return-Path: <linux-kernel+bounces-265425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C397893F10A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCC41F220FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052B13FD86;
	Mon, 29 Jul 2024 09:26:53 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42809135A63
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245212; cv=none; b=fbErgIRRJQvMpY6xTxYAcNKjz7G5d+TDLOTzzNGMMgAb3b5rtDdoPRSm27oFCK2H9riRTKSTcHEyS0lsbHUWwa8cE1/t9KNyY9iarx74kgy/+XZl06UF1MncpSR2wkZCJqr20nkWtz2Ql3CWvg+wbgbjX82zIUlrEti8ipzGRBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245212; c=relaxed/simple;
	bh=WiVYHby0gDFIsydXvgNrz6vK7ZT0j27BIyNpOfhYHi0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bnzdIsL+FEUUAiUhmTSWlsVgB0qzdY0GIB2w2YiTnI99FK0mG+ELdYUrW0TfUvfe4Aba3smYxYYRcdtxgkCU+ZXm5t7LrrqA2AQbHPG2gF8gvcV6SAIfdRjFg1YSNxqB3h6lpNI/RRa0EIISG0RaOtIT0CxUrndJTUAT6ddOM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:4441:3808:f850:4280])
	by laurent.telenet-ops.be with bizsmtp
	id tMSc2C0030ZURL201MScHA; Mon, 29 Jul 2024 11:26:42 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sYMdw-003sUd-Sq;
	Mon, 29 Jul 2024 11:26:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sYMeJ-009LXV-Uh;
	Mon, 29 Jul 2024 11:26:35 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/xe/oa/uapi: Make bit masks unsigned
Date: Mon, 29 Jul 2024 11:26:34 +0200
Message-Id: <20240729092634.2227611-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When building with gcc-5:

    In function ‘decode_oa_format.isra.26’,
	inlined from ‘xe_oa_set_prop_oa_format’ at drivers/gpu/drm/xe/xe_oa.c:1664:6:
    ././include/linux/compiler_types.h:510:38: error: call to ‘__compiletime_assert_1336’ declared with attribute error: FIELD_GET: mask is not constant
    [...]
    ./include/linux/bitfield.h:155:3: note: in expansion of macro ‘__BF_FIELD_CHECK’
       __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
       ^
    drivers/gpu/drm/xe/xe_oa.c:1573:18: note: in expansion of macro ‘FIELD_GET’
      u32 bc_report = FIELD_GET(DRM_XE_OA_FORMAT_MASK_BC_REPORT, fmt);
		      ^

Fixes: b6fd51c6211910b1 ("drm/xe/oa/uapi: Define and parse OA stream properties")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 include/uapi/drm/xe_drm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 19619d4952a863f7..db232a25189eba9f 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1590,10 +1590,10 @@ enum drm_xe_oa_property_id {
 	 * b. Counter select c. Counter size and d. BC report. Also refer to the
 	 * oa_formats array in drivers/gpu/drm/xe/xe_oa.c.
 	 */
-#define DRM_XE_OA_FORMAT_MASK_FMT_TYPE		(0xff << 0)
-#define DRM_XE_OA_FORMAT_MASK_COUNTER_SEL	(0xff << 8)
-#define DRM_XE_OA_FORMAT_MASK_COUNTER_SIZE	(0xff << 16)
-#define DRM_XE_OA_FORMAT_MASK_BC_REPORT		(0xff << 24)
+#define DRM_XE_OA_FORMAT_MASK_FMT_TYPE		(0xffu << 0)
+#define DRM_XE_OA_FORMAT_MASK_COUNTER_SEL	(0xffu << 8)
+#define DRM_XE_OA_FORMAT_MASK_COUNTER_SIZE	(0xffu << 16)
+#define DRM_XE_OA_FORMAT_MASK_BC_REPORT		(0xffu << 24)
 
 	/**
 	 * @DRM_XE_OA_PROPERTY_OA_PERIOD_EXPONENT: Requests periodic OA unit
-- 
2.34.1



Return-Path: <linux-kernel+bounces-542030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A2A4C4D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703B41888914
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50366214A98;
	Mon,  3 Mar 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ashley.smith@collabora.com header.b="HYgyjVIf"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1D19CCFA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015156; cv=pass; b=QOqSd2oYqyxG6g461/gM2hwDjQKkSG3r0LyUQcSh9bPsESCbxdV9T8KHRk2aqnPJkU6y1izlJoV9WJ90SYZp3hpAOl/CRE53fMkl96wl1I9vP1dBF00N/99toVn0l0znmyWWQRVkXvGmLinBYEnerVXMU0mM4YYicKlOFv/6ovA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015156; c=relaxed/simple;
	bh=l+s4d1Zp8kZdIu1ZGCtWDaymqlkV1H9cvStDVVDjIR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUlTjvPUQeOskZZhaHM2sud22J/4kO0GJcrDl9sbh46alJEiDZG8gwChMXoJYJ8r2fmnKTIrIIPQVNguYL0iwu4RY5wIrd7H364XF6x7dyH2EUhGqcBL8a47+fPFjsqejcl+INDwYIN6t0HL7USTQiXX+YHwfkBtdRBJFpAZ1yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ashley.smith@collabora.com header.b=HYgyjVIf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741015137; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kx2/9tpcRNxJv0M/M4WznHk0YsM7Xefav7qwpVYMD2mgfiqoUc2sktJF+puQ7priwZOrXaLpGMLG3rm8N1SSuoVl5pUiUgoVljvEsBiawJY6+ngGay5BvzHtBGZ087GtLw3uZDgVbjrariz3OPkzHyw7WKPjbpVz5Q4t1riIRNo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741015137; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C/iTLLU7L7PZsGrUCbrk0/fCDtfiKSdFLTKlNGPrcDU=; 
	b=Uon+SGgbyvYkjK4YtrKwyiMcSoLjd9RbernR8GL96sze9DmSX9StgrdZ5hc7yXNHydJqnYs/qr4lRJbdbQtILARgWHU2YUi8yppL6ER3snFsmLqwSBCIxv8bYXKE4pHeSgxm8GBds+Aaob1DJcq3Pyn1dL9htoV58cmSDQEJxHg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ashley.smith@collabora.com;
	dmarc=pass header.from=<ashley.smith@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741015137;
	s=zohomail; d=collabora.com; i=ashley.smith@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=C/iTLLU7L7PZsGrUCbrk0/fCDtfiKSdFLTKlNGPrcDU=;
	b=HYgyjVIfrTaphGehpAzQSsCEahgJefY4+RnaS84lMkrOlwuV78IU4jyPsxlJR4Bu
	y5fLNyfhdWJ3rKxgkl72wScWGxJtWd8o4/yJorgV/0T5bJ5lUZL3JC1QIheyDZQuAHe
	JnI6ucD6q6xvct/dXHwqY5He6+FRsz60kHp/j/ko=
Received: by mx.zohomail.com with SMTPS id 1741015134703693.1164829293207;
	Mon, 3 Mar 2025 07:18:54 -0800 (PST)
From: Ashley Smith <ashley.smith@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	Ashley Smith <ashley.smith@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panthor: Update CS_STATUS_ defines to correct values
Date: Mon,  3 Mar 2025 15:18:37 +0000
Message-ID: <20250303151840.3669656-1-ashley.smith@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Values for SC_STATUS_BLOCKED_REASON_ are documented at https://arm.pages.collabora.com/mali-docs/g610-odin-csf/register/CS_KERNEL_OUTPUT_BLOCK.htm#rp_CS_KERNEL_OUTPUT_BLOCK/CS_STATUS_BLOCKED_REASON

This change updates the defines to the correct values.

Signed-off-by: Ashley Smith <ashley.smith@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_fw.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index 22448abde992..4d3c8b585dcb 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -102,9 +102,9 @@ struct panthor_fw_cs_output_iface {
 #define CS_STATUS_BLOCKED_REASON_SB_WAIT	1
 #define CS_STATUS_BLOCKED_REASON_PROGRESS_WAIT	2
 #define CS_STATUS_BLOCKED_REASON_SYNC_WAIT	3
-#define CS_STATUS_BLOCKED_REASON_DEFERRED	5
-#define CS_STATUS_BLOCKED_REASON_RES		6
-#define CS_STATUS_BLOCKED_REASON_FLUSH		7
+#define CS_STATUS_BLOCKED_REASON_DEFERRED	4
+#define CS_STATUS_BLOCKED_REASON_RES		5
+#define CS_STATUS_BLOCKED_REASON_FLUSH		6
 #define CS_STATUS_BLOCKED_REASON_MASK		GENMASK(3, 0)
 	u32 status_blocked_reason;
 	u32 status_wait_sync_value_hi;

base-commit: 16e57a72780931c3c70dbc928aeee4a0518075de
-- 
2.43.0



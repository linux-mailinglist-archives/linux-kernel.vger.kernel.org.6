Return-Path: <linux-kernel+bounces-574432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87539A6E53B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3DD189A417
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8D91DFD96;
	Mon, 24 Mar 2025 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKBBz/i4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D31FDD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850377; cv=none; b=NcA296K/7QediAgE7FPWC2qoX3I5jnH/d9pLbDxDuSqmzSQUIv3f/AI7UNWK91IXuhMaRD/OShJpfDwXoEnuM217szu26b6S6+wiP0BqC9HxKk1wwdR5FAniAGD/lUkarWRC2kbt/gZsJo255yT4COp/RY+qgcGQGmQteVPlCSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850377; c=relaxed/simple;
	bh=9/opTEs0d9NV3O3X17FC8CqUB8UV/tH+pUR280IUGH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dchxdrVZTF/Sm2euyIn7JgZ7SWIwnUzGj2g/8YCDNnfPS3gPRXAX2zcXiWs/3WX/eu/Rc5WTs04eSgt5rXetjr/syDr90yacN391xskXcXkPX4EqqUq47ACfuk8m/3EqQ3nPYhma1CaW67NxU2fdP912bJ4qE0VCWsTfkvBfoqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKBBz/i4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CBDC4CEDD;
	Mon, 24 Mar 2025 21:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850377;
	bh=9/opTEs0d9NV3O3X17FC8CqUB8UV/tH+pUR280IUGH0=;
	h=From:To:Cc:Subject:Date:From;
	b=lKBBz/i4kh7dB0kWHp4zEStEsSfOcmbgMzE7FhrZCs+Ce8xjFZoD6SImnf+GlLpdD
	 SlglhpBatW04bmZsp4aUB7SYT3N73TaGw6+dJa0a/bJ+FmR15QoA9/MJWhc5q/Shie
	 0cvba7VqzD9TZWqYaNSNHfgJJbRoWxFZAsTB0zM4UAiumnP0MdhCeoglKgNjzXVWgL
	 E2huBq31DVRTuVxhm2fN+jdZxOggSWGWROwL0eQGgkoN49jpRgZmhBVWhXuLcrCKsk
	 7tSqeCdIpf1Smix/BjyN3yRKhsZpmSJv41Nh64ZDdn/IJTmBD6+6zzkrJ3Gl6FB9Nh
	 mcpABU+VZKNRw==
From: Arnd Bergmann <arnd@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Oak Zeng <oak.zeng@intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xe: avoid plain 64-bit division
Date: Mon, 24 Mar 2025 22:06:02 +0100
Message-Id: <20250324210612.2927194-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building the xe driver for i386 results in a link time warning:

x86_64-linux-ld: drivers/gpu/drm/xe/xe_migrate.o: in function `xe_migrate_vram':
xe_migrate.c:(.text+0x1e15): undefined reference to `__udivdi3'

Avoid this by using DIV_U64_ROUND_UP() instead of DIV_ROUND_UP().  The driver
is unlikely to be used on 32=bit hardware, so the extra cost here is not
too important.

Fixes: 9c44fd5f6e8a ("drm/xe: Add migrate layer functions for SVM support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xe/xe_migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index df4282c71bf0..aafb6209f2d0 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -1547,7 +1547,7 @@ void xe_migrate_wait(struct xe_migrate *m)
 static u32 pte_update_cmd_size(u64 size)
 {
 	u32 num_dword;
-	u64 entries = DIV_ROUND_UP(size, XE_PAGE_SIZE);
+	u64 entries = DIV_U64_ROUND_UP(size, XE_PAGE_SIZE);
 
 	XE_WARN_ON(size > MAX_PREEMPTDISABLE_TRANSFER);
 	/*
@@ -1558,7 +1558,7 @@ static u32 pte_update_cmd_size(u64 size)
 	 * 2 dword for the page table's physical location
 	 * 2*n dword for value of pte to fill (each pte entry is 2 dwords)
 	 */
-	num_dword = (1 + 2) * DIV_ROUND_UP(entries, 0x1ff);
+	num_dword = (1 + 2) * DIV_U64_ROUND_UP(entries, 0x1ff);
 	num_dword += entries * 2;
 
 	return num_dword;
-- 
2.39.5



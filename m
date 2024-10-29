Return-Path: <linux-kernel+bounces-386243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9839B40EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BC21F23143
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57806200CA5;
	Tue, 29 Oct 2024 03:13:53 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC031FB8A0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171633; cv=none; b=ncYimOWDLYr3PD5GWozrN1D6y8Is19SZcNdx33a/ppn/Azmkt4cS9gKyx/Y8HXS6h1uGBYD5Pjj/muph2fNW7XM6XyRI+exxo7cjZOro8KhTCk31koL8BKyGACij4iZPPXoMvyTnjD63icJIDh779FmTsaT22pFDX1RR4lxOpns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171633; c=relaxed/simple;
	bh=nNX3f8FaL7rNhwZ8UpoLxE7n6RkYN+iUEaoMoDOuWDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X45pDC28PNUEMfpQaG7EF1FChoKjpLJyaMyxIelehs4QiKq4JfsmvELXk4Ew1GvdKARvnLYcuMz0tuA4NRGx+UOR1++PChiu63R5afm4Jy1qsqxBCllnsg4Bwq5vKnTFqe3GH8WCbSMcrNWQ3VGvl0ju/IxkNzdkuqs0iDbWPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49T3D0ov018719;
	Tue, 29 Oct 2024 11:13:00 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XcwKj1G53z2K25NV;
	Tue, 29 Oct 2024 11:12:25 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 29 Oct 2024 11:12:57 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH V3] f2fs: fix to avoid use GC_AT when setting gc_mode as GC_URGENT_LOW or GC_URGENT_MID
Date: Tue, 29 Oct 2024 11:12:49 +0800
Message-ID: <1730171569-10757-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 49T3D0ov018719

If gc_mode is set to GC_URGENT_LOW or GC_URGENT_MID, cost benefit GC
approach should be used, but if ATGC is enabled at the same time,
Age-threshold approach will be selected, which can only do amount of
GC and it is much less than the numbers of CB approach.

some traces:
  f2fs_gc-254:48-396     [007] ..... 2311600.684028: f2fs_gc_begin: dev = (254,48), gc_type = Background GC, no_background_GC = 0, nr_free_secs = 0, nodes = 1053, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
  f2fs_gc-254:48-396     [007] ..... 2311600.684527: f2fs_get_victim: dev = (254,48), type = No TYPE, policy = (Background GC, LFS-mode, Age-threshold), victim = 10, cost = 4294364975, ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 44898
  f2fs_gc-254:48-396     [007] ..... 2311600.714835: f2fs_gc_end: dev = (254,48), ret = 0, seg_freed = 0, sec_freed = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
  f2fs_gc-254:48-396     [007] ..... 2311600.714843: f2fs_background_gc: dev = (254,48), wait_ms = 50, prefree = 0, free = 44898
  f2fs_gc-254:48-396     [007] ..... 2311600.771785: f2fs_gc_begin: dev = (254,48), gc_type = Background GC, no_background_GC = 0, nr_free_secs = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:
  f2fs_gc-254:48-396     [007] ..... 2311600.772275: f2fs_gc_end: dev = (254,48), ret = -61, seg_freed = 0, sec_freed = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0

Fixes: 0e5e81114de1 ("f2fs: add GC_URGENT_LOW mode in gc_urgent")
Fixes: d98af5f45520 ("f2fs: introduce gc_urgent_mid mode")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
v3: add more descriptions in sys-fs-f2fs for gc_urgent(2) and gc_urgent(3)
v2: make GC_URGENT_LOW also use CB approach
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 7 +++++--
 fs/f2fs/gc.c                            | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index fdedf1e..513296b 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -311,10 +311,13 @@ Description:	Do background GC aggressively when set. Set to 0 by default.
 		GC approach and turns SSR mode on.
 		gc urgent low(2): lowers the bar of checking I/O idling in
 		order to process outstanding discard commands and GC a
-		little bit aggressively. uses cost benefit GC approach.
+		little bit aggressively. always uses cost benefit GC approach,
+		and will override age-threshold GC approach if ATGC is enabled
+		at the same time.
 		gc urgent mid(3): does GC forcibly in a period of given
 		gc_urgent_sleep_time and executes a mid level of I/O idling check.
-		uses cost benefit GC approach.
+		always uses cost benefit GC approach, and will override
+		age-threshold GC approach if ATGC is enabled at the same time.
 
 What:		/sys/fs/f2fs/<disk>/gc_urgent_sleep_time
 Date:		August 2017
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e40bdd1..3e1b6d2 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -257,6 +257,8 @@ static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
 
 	switch (sbi->gc_mode) {
 	case GC_IDLE_CB:
+	case GC_URGENT_LOW:
+	case GC_URGENT_MID:
 		gc_mode = GC_CB;
 		break;
 	case GC_IDLE_GREEDY:
-- 
1.9.1



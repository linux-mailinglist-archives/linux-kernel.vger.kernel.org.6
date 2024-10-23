Return-Path: <linux-kernel+bounces-377251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F969ABBFD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D56F1F244D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C85B84A2F;
	Wed, 23 Oct 2024 03:09:14 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D3A48
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729652953; cv=none; b=Ft8/CE8X208jHncd6ZF4WInJi10DlHZnLpnqFZ2iRqdvlDVJdScLAVwYtWIIrgoIJ7QYHo3ArHmI2kwpNJWma77RwJgOyDrDdaqWU/0fuX5lIFqF/sYosxmRYyffMwAiJflHKzjsWIln7L1RcqulEdwYP53nMrBRn8+r4rXrsss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729652953; c=relaxed/simple;
	bh=MttCHFFE6PKiNfuw9PNlIS5sWom0wNh9ZRQByuro76g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1bBLo5N0YC31xNVwqqm31lZVRxOLQLZ4oBgcGKOSiF2+SNNSZ2C0dovGkpCcf94z8fZCDALHlvqkuuFkggfeeG64aOSLxL1t0Tz1pa9jQVhwQC3AUdeYhKnDxNcIBoFPnHr1804dWCsbZSyPb2SpTlKPrPTM2qFZrGqIJIM1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49N38U6W093116;
	Wed, 23 Oct 2024 11:08:30 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XYDWW05sxz2SRwhQ;
	Wed, 23 Oct 2024 11:08:06 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 23 Oct 2024 11:08:28 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH V2] f2fs: fix to avoid use GC_AT when setting gc_mode as GC_URGENT_LOW or GC_URGENT_MID
Date: Wed, 23 Oct 2024 11:08:03 +0800
Message-ID: <1729652883-12202-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 49N38U6W093116

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
v2: make GC_URGENT_LOW also use CB approach
---
 fs/f2fs/gc.c | 2 ++
 1 file changed, 2 insertions(+)

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



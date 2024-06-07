Return-Path: <linux-kernel+bounces-205659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCAC8FFE90
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22518B20ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183915B0FC;
	Fri,  7 Jun 2024 09:01:39 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E417C6C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750898; cv=none; b=MdkrdSYnF5hN5GtOVyGg9Gykz57QmUpzgKKTXS9+wf0DsLDp+NBby6JyGLHSETB4Vh7VUoY4mGE8hCgMmpVqhjX3VGkFOXvP36CdsPY7o629Y+FFFb/ElA3tbIljhfrr0oalIPCQ/hZ9N7Q0bEwtXQohNQpw8rJtZQIf7RhaFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750898; c=relaxed/simple;
	bh=WKtUVRZ3BEvjG0aZ2Mn4jkpRzDVrYF1ttd++DRwKSJc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fJE47djvvSGiCdsuF/cWj9zarX8CxYmQryOv5kuzIWn37WSS5clCyVRJMMg69Ks5eXvXPrdDnrzYYnZJUIfB1oBTYbTBFOUt0gCwPbm706eV920drFhinTcOzAt4HL9oeTRyklX7NAocJULLyXEaRtFXX7j/0wAAStD4wHvSsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45790osD077378;
	Fri, 7 Jun 2024 17:00:50 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VwZnV1WLkz2QcKjm;
	Fri,  7 Jun 2024 16:56:46 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 7 Jun 2024 17:00:48 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH V2] f2fs: enable atgc dynamically if conditions are met
Date: Fri, 7 Jun 2024 17:00:30 +0800
Message-ID: <1717750830-15423-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 45790osD077378

Now atgc can only be enabled when umounted->mounted device
even related conditions have reached. If the device has not
be umounted->mounted for a long time, atgc can not work.

So enable atgc dynamically when atgc_age_threshold is less than
elapsed_time and ATGC mount option is on.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
v2: try to enabe atgc in cp to avoid some race cases
---
---
 fs/f2fs/checkpoint.c |  1 +
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/segment.c    | 27 ++++++++++++++++++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 55d444be..7cfe4e0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1718,6 +1718,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	}
 
 	f2fs_restore_inmem_curseg(sbi);
+	f2fs_reinit_atgc_curseg(sbi);
 	stat_inc_cp_count(sbi);
 stop:
 	unblock_operations(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9688df3..8d385a1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3693,6 +3693,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
 bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
 int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
+int f2fs_reinit_atgc_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
 int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6e8a4b3..362cfb5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2931,12 +2931,12 @@ static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
 	return ret;
 }
 
-static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
+static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi, bool force)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC);
 	int ret = 0;
 
-	if (!sbi->am.atgc_enabled)
+	if (!sbi->am.atgc_enabled && !force)
 		return 0;
 
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
@@ -2953,9 +2953,30 @@ static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
 	return ret;
 }
+
 int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
 {
-	return __f2fs_init_atgc_curseg(sbi);
+	return __f2fs_init_atgc_curseg(sbi, false);
+}
+
+int f2fs_reinit_atgc_curseg(struct f2fs_sb_info *sbi)
+{
+	int ret;
+
+	if (!test_opt(sbi, ATGC))
+		return 0;
+	if (sbi->am.atgc_enabled)
+		return 0;
+	if (le64_to_cpu(F2FS_CKPT(sbi)->elapsed_time) <
+			sbi->am.age_threshold)
+		return 0;
+
+	ret = __f2fs_init_atgc_curseg(sbi, true);
+	if (!ret) {
+		sbi->am.atgc_enabled = true;
+		f2fs_info(sbi, "reenabled age threshold GC");
+	}
+	return ret;
 }
 
 static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
-- 
1.9.1



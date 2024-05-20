Return-Path: <linux-kernel+bounces-183661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1BB8C9C32
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B5B1C21B36
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7D356452;
	Mon, 20 May 2024 11:37:25 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55453E1B
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205045; cv=none; b=f9lN8OcbIbXlJRXLuzPfRvYpAUj9V9M7OK1n7Y9CYYFB/Y8+SRVHsd0P/87cARWhm+lGcAFe5nlFCV5u3gFgYGftZtLhphAuc2sq4MFi5Ach/bgcy2PMngXQ0UhB8pousNfcJJ03m8RhBmInDf9VghCt2rehODSaBeVkC6fERSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205045; c=relaxed/simple;
	bh=cj9mL1bGgD8z39mvLMM7/PQdXOTIZAKRgKgyy7lcLMQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oyKXJAdo1mbIzLWh1hSvIK341rofGMuFBeqFo5O4oxIZOz2IDkpooQc0OS3h2N+KCtC+9vcd/K+m+eETVQTEZdiZSjgE1znpDAj60cJ3fTJjOquBD9W2BKb1n0U/aNpKntrd1dD7hEoHlmKYg99mxQlBHEuds2UUfx5sSBnBWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 44KBaWh8040804;
	Mon, 20 May 2024 19:36:32 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Vjb672thwz2Q7LW0;
	Mon, 20 May 2024 19:33:03 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 20 May 2024 19:36:29 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH] f2fs: enable atgc if atgc_age_threshold from user is less than elapsed_time
Date: Mon, 20 May 2024 19:36:18 +0800
Message-ID: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 44KBaWh8040804

Now atgc can be enabled based on the following conditions:
-ATGC mount option is set
-elapsed_time is more than atgc_age_threshold already
but these conditions are check when umounted->mounted device again.
If the device has not be umounted->mounted for a long time, atgc can
not work even the above conditions met.

It is better to enable atgc dynamiclly when user change atgc_age_threshold
meanwhile this vale is less than elapsed_time and ATGC mount option is on.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c |  9 ++++-----
 fs/f2fs/sysfs.c   | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1974b6a..e441d2d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3694,6 +3694,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
 void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
+int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi);
 int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
 int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 71dc8042..44923d4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2931,14 +2931,11 @@ static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
 	return ret;
 }
 
-static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
+int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC);
 	int ret = 0;
 
-	if (!sbi->am.atgc_enabled)
-		return 0;
-
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
 
 	mutex_lock(&curseg->curseg_mutex);
@@ -2955,7 +2952,9 @@ static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
 }
 int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
 {
-	return __f2fs_init_atgc_curseg(sbi);
+	if (!sbi->am.atgc_enabled)
+		return 0;
+	return f2fs_init_atgc_curseg(sbi);
 }
 
 static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 09d3ecf..72676c5 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -673,6 +673,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "atgc_age_threshold")) {
+		if (t < 0)
+			return -EINVAL;
+		sbi->am.age_threshold = t;
+		if (sbi->am.atgc_enabled)
+			return count;
+
+		if (test_opt(sbi, ATGC) &&
+			le64_to_cpu(sbi->ckpt->elapsed_time) >= t) {
+			if (f2fs_init_atgc_curseg(sbi))
+				return -EINVAL;
+			sbi->am.atgc_enabled = true;
+		}
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "gc_segment_mode")) {
 		if (t < MAX_GC_MODE)
 			sbi->gc_segment_mode = t;
-- 
1.9.1



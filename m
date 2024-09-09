Return-Path: <linux-kernel+bounces-322169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4554697253D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AAF285952
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6930518E356;
	Mon,  9 Sep 2024 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz0Aylii"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655218DF97
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920400; cv=none; b=HXuksxScf/nq00HJZkU8TIL5R+UGtq1eQtsMi77LxqU11O/L9djt/mkTonSaz7gdUj9D8bP8hdDx7kTZu3dL33Qbss1qwvlKS23U5B0uUurekJQA7dmug+09g6TL6mnsr+sAM6YF2kpQlEus/5x4rNgcf59d7LbIM7t7bNw+Zo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920400; c=relaxed/simple;
	bh=eWSIN3BgTBktK2kkNavIVKIzZIWVMp/7jvF+eFPOf6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUHulUl/X5t5ktnh3auy8eCWNXK3uWtQLwQe2Tpz+FFgbmkrftC80MEZsMWFnfM89mF94VGhyURFVBMcIXRa6/eR6Q1yj5rVdSnYJ6SFPFZoyDzttaBAxkhh1NcZnPduxwrH1ZqE2egBuljmzFzUGNgGzLzz2nnet6IpxMT0plw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz0Aylii; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d8a744aa9bso3137393a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725920398; x=1726525198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQJ/nGsQ4DEh1vdP8K9rNtdn0Y5Ouc5JbFoWYWKuiIg=;
        b=dz0Aylii4tLhTDFb4ChLY8fNbM2WLpWeNaxT373HmuHmiSYTOKMK7wpzMAQAh499fH
         94hQSu7iKG4KA+DidZFIoOP99WTwrDHPOIrGPk3aV7WAhm5CBcHFHspqni1JiSU+BcSr
         flgGFi7dZRBQSwe4ScBRcGolIMD1oz+lVQgp24ffJz+DqJorpCGyjLpX91/qdYZljkGV
         Z1dpJ8yx9K397FF0m8ORoMcQK0ehKkRAAbPfKRVRgkv5udXB/8V1IpCO5OfW2xN0MgYj
         35k8koD/Dd1fEElLslgGpKOmU+IwZVwPT6ZWZMoSyePm3EtbDKNa7D08DDaFBX29jvY6
         T6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725920398; x=1726525198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQJ/nGsQ4DEh1vdP8K9rNtdn0Y5Ouc5JbFoWYWKuiIg=;
        b=d+LMbSjXKaLGpXHbkgZ3bGlPZGiyF7Sqt08zm+BlkakQpSxwopW3hJHlW6dxqgBQdi
         lUMhMK8QeM/2mqeqSHeW0BCUHXvlmbV2yOtp2lHPYmpY9y3A6BjXloQlEDhQ1kAaIz8d
         RmMpSy2U3Dgu9PF775GCKDSmBnK5ZKtPfUlFI8Wnkst9UUXoauPvxeqh/N8NHmPolr3o
         RIoH6eeO9M8g7xARLrVYfeI+Ei498OLUF144WlYmzZxEVmgs6qYBhVNZORg+bmKX1LBp
         TqCct27ZHOSefU56rJlEb2eyEwmzuWjGUiwyFJR6jPUslCd+zTVLBvoL3ppLAIZjnnpl
         LZxg==
X-Gm-Message-State: AOJu0Yw+GyxVTSsDI3ib3DXB/ixfGkF+ns97CCu38Z3t5sex+3x99Ka8
	GUt1+SYaQV+6LnCoqyXK0s2DJpVepKox5ub/3YXnkMLbiq1uI9Rumul4Bw==
X-Google-Smtp-Source: AGHT+IHVPTHzH7+XMEkQw48bj2F5rk5bRhOLsm40meb4RM6lVxu1iirHvVJM165fPzUtiQ5uQiQbUw==
X-Received: by 2002:a17:90b:4a88:b0:2d3:c05c:c51 with SMTP id 98e67ed59e1d1-2dad4b9af79mr12449301a91.0.1725920397740;
        Mon, 09 Sep 2024 15:19:57 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:ed56:14c3:db02:6c66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04988470sm5016840a91.54.2024.09.09.15.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 15:19:57 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2 7/7] f2fs: add valid block ratio not to do excessive GC for one time GC
Date: Mon,  9 Sep 2024 15:19:46 -0700
Message-ID: <20240909221946.2004046-7-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240909221946.2004046-1-daeho43@gmail.com>
References: <20240909221946.2004046-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

We need to introduce a valid block ratio threshold not to trigger
excessive GC for zoned deivces. The initial value of it is 95%. So, F2FS
will stop the thread from intiating GC for sections having valid blocks
exceeding the ratio.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: use CAP_BLKS_PER_SEC instead of BLKS_PER_SEC
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++++++
 fs/f2fs/f2fs.h                          |  2 +-
 fs/f2fs/gc.c                            | 16 ++++++++++++----
 fs/f2fs/gc.h                            |  2 ++
 fs/f2fs/segment.c                       |  6 ++++--
 fs/f2fs/segment.h                       |  1 +
 fs/f2fs/sysfs.c                         |  2 ++
 7 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index f3c533b523cd..2fcb16ca10d3 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -791,3 +791,11 @@ Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	If the percentage of free sections over total sections is under this
 		number, F2FS boosts garbage collection for zoned devices through the
 		background GC thread. the default number is "25".
+
+What:		/sys/fs/f2fs/<disk>/gc_valid_thresh_ratio
+Date:		September 2024
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	It controls the valid block ratio threshold not to trigger excessive GC
+		for zoned deivces. The initial value of it is 95(%). F2FS will stop the
+		background GC thread from intiating GC for sections having valid blocks
+		exceeding the ratio.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 62880fbb9e20..2bfad046dc74 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3920,7 +3920,7 @@ void f2fs_destroy_garbage_collection_cache(void);
 /* victim selection function for cleaning and SSR */
 int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 			int gc_type, int type, char alloc_mode,
-			unsigned long long age);
+			unsigned long long age, bool one_time);
 
 /*
  * recovery.c
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 319b4b80ba72..d3e3104c4492 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -196,6 +196,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
+	gc_th->valid_thresh_ratio = DEF_GC_THREAD_VALID_THRESH_RATIO;
 
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
@@ -396,6 +397,11 @@ static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 	if (p->alloc_mode == SSR)
 		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
 
+	if (p->one_time_gc && (get_valid_blocks(sbi, segno, true) >=
+		CAP_BLKS_PER_SEC(sbi) * sbi->gc_thread->valid_thresh_ratio /
+		100))
+		return UINT_MAX;
+
 	/* alloc_mode == LFS */
 	if (p->gc_mode == GC_GREEDY)
 		return get_valid_blocks(sbi, segno, true);
@@ -770,7 +776,7 @@ static int f2fs_gc_pinned_control(struct inode *inode, int gc_type,
  */
 int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 			int gc_type, int type, char alloc_mode,
-			unsigned long long age)
+			unsigned long long age, bool one_time)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct sit_info *sm = SIT_I(sbi);
@@ -787,6 +793,7 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 	p.alloc_mode = alloc_mode;
 	p.age = age;
 	p.age_threshold = sbi->am.age_threshold;
+	p.one_time_gc = one_time;
 
 retry:
 	select_policy(sbi, gc_type, type, &p);
@@ -1698,13 +1705,14 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 }
 
 static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
-			int gc_type)
+			int gc_type, bool one_time)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	int ret;
 
 	down_write(&sit_i->sentry_lock);
-	ret = f2fs_get_victim(sbi, victim, gc_type, NO_CHECK_TYPE, LFS, 0);
+	ret = f2fs_get_victim(sbi, victim, gc_type, NO_CHECK_TYPE,
+			LFS, 0, one_time);
 	up_write(&sit_i->sentry_lock);
 	return ret;
 }
@@ -1911,7 +1919,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		goto stop;
 	}
 retry:
-	ret = __get_victim(sbi, &segno, gc_type);
+	ret = __get_victim(sbi, &segno, gc_type, gc_control->one_time);
 	if (ret) {
 		/* allow to search victim from sections has pinned data */
 		if (ret == -ENODATA && gc_type == FG_GC &&
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index c063310c8dde..2914b678bf8f 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -25,6 +25,7 @@
 #define DEF_GC_THREAD_CANDIDATE_RATIO		20	/* select 20% oldest sections as candidates */
 #define DEF_GC_THREAD_MAX_CANDIDATE_COUNT	10	/* select at most 10 sections as candidates */
 #define DEF_GC_THREAD_AGE_WEIGHT		60	/* age weight */
+#define DEF_GC_THREAD_VALID_THRESH_RATIO	95	/* do not GC over 95% valid block ratio for one time GC */
 #define DEFAULT_ACCURACY_CLASS			10000	/* accuracy class */
 
 #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
@@ -65,6 +66,7 @@ struct f2fs_gc_kthread {
 	/* for gc control for zoned devices */
 	unsigned int no_zoned_gc_percent;
 	unsigned int boost_zoned_gc_percent;
+	unsigned int valid_thresh_ratio;
 };
 
 struct gc_inode_list {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 78c3198a6308..26f5abc62461 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3052,7 +3052,8 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
 	sanity_check_seg_type(sbi, seg_type);
 
 	/* f2fs_need_SSR() already forces to do this */
-	if (!f2fs_get_victim(sbi, &segno, BG_GC, seg_type, alloc_mode, age)) {
+	if (!f2fs_get_victim(sbi, &segno, BG_GC, seg_type,
+				alloc_mode, age, false)) {
 		curseg->next_segno = segno;
 		return 1;
 	}
@@ -3079,7 +3080,8 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
 	for (; cnt-- > 0; reversed ? i-- : i++) {
 		if (i == seg_type)
 			continue;
-		if (!f2fs_get_victim(sbi, &segno, BG_GC, i, alloc_mode, age)) {
+		if (!f2fs_get_victim(sbi, &segno, BG_GC, i,
+					alloc_mode, age, false)) {
 			curseg->next_segno = segno;
 			return 1;
 		}
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index bfc01a521cb9..43db2d3e8c85 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -188,6 +188,7 @@ struct victim_sel_policy {
 	unsigned int min_segno;		/* segment # having min. cost */
 	unsigned long long age;		/* mtime of GCed section*/
 	unsigned long long age_threshold;/* age threshold */
+	bool one_time_gc;		/* one time GC */
 };
 
 struct seg_entry {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 60693ec39a03..83e52f6061d0 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -967,6 +967,7 @@ GC_THREAD_RW_ATTR(gc_max_sleep_time, max_sleep_time);
 GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
 GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
+GC_THREAD_RW_ATTR(gc_valid_thresh_ratio, valid_thresh_ratio);
 
 /* SM_INFO ATTR */
 SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
@@ -1127,6 +1128,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_no_gc_sleep_time),
 	ATTR_LIST(gc_no_zoned_gc_percent),
 	ATTR_LIST(gc_boost_zoned_gc_percent),
+	ATTR_LIST(gc_valid_thresh_ratio),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
-- 
2.46.0.598.g6f2099f65c-goog



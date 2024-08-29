Return-Path: <linux-kernel+bounces-307753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9AC965269
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2151F24D71
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546C01BD00C;
	Thu, 29 Aug 2024 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+W6o+mP"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6C1BC099
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968382; cv=none; b=iWVG8KVNYouC+arIB8AaMTFrzbLNznDcuBRXTDLAMiJsUkQaSfS6/RneO59qUlSiB8RXRLEhQXDf2yIAvEvq9uPCYOQQ8fissu7EfC2XsGVuHKFTboJ+rf0bo8YE+vdwQw3j54OG14PtHH2qFeL1w2hIx++MdZBw9vmMlWq1ovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968382; c=relaxed/simple;
	bh=WsmpqkX3sqNeJt/fB1E9rdpVafKoB2ITTscUB7OlpAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFWAkzEhV5rxRgN+F++NxxPYEe5sax/6+FGfVe+Q5E0aYzq9H6noe83lXL+W86uf7nzAvHLhio0GKYqpVa7+490XLMOmqQedD6THrYQV0E86Q/rfQ08PvLySDBUzUq84pZqkj+peh3K+anoJc1cQtQFyz3g/lkxc0HNlJ7EBXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+W6o+mP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-715e64ea7d1so931322b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968379; x=1725573179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Lbaah111wuAwM01PbzQxCw0HL6ZCiCPf+qhy2mwy+w=;
        b=L+W6o+mPn8zpTHI/6YleYmBMXSdEuMXUU31ol9Z9i8jtUQk6dYF9wlxcEmTaWWM5av
         TwQBAgRjsjndIbUZcO6q+LMNaqGrGkvKoRWTS2DBB60ZOCHeylJhMvVIH2t8phsTPX5G
         nK0nTshbTNg6D6ygWbWiVlOmn7xrq6+FTz/LHwGrHQSDVHU0po/mvYfqP2DCxkmbuAkJ
         rG+8F/RbQEce7/PIRMky6lokWsrmALg0H3aI6JHWh0+F5cIX1qVgQNrxDqJ82BZfqttf
         JPDZVzIj+d6/0wXfmjq8mQlUFUsR2sCfYWk28fLiiKANsrmMWwBnl7K1lwJEdVNHEBwo
         YD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968379; x=1725573179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Lbaah111wuAwM01PbzQxCw0HL6ZCiCPf+qhy2mwy+w=;
        b=s1BWydlI3n9AxpkN5o+uq2LVdnGVSdncstPBjR2yPmhLI7GGk2GfPGQ12l0g5Z6SOs
         GFKPbKlJOHD9/j1T/BcgMm/b/mW/UgclrfRmDDxz6j/U+nazSCpCJX4ssuW8oV1isli2
         7Ng/89su2flayzFRk61pA/xKGB4ns8+nb/GEt0KBZwltvZQSRYUBgr+38+QGjdoXrVqa
         F/if0wP5U5YNPeWljnZcbMg0P88rCau9rTOkGSv3uRNjcms7Wacl7jOMyKcr97iaIf5v
         yJ6L5qOWhpAU7OdwrgcNjEyWxUD4EIHd9p4wEuQTpAv1HORlLIXp3fRWimuDvKtA2d7R
         uKHQ==
X-Gm-Message-State: AOJu0YxLmc9HeJEJD70Shkh2tVIYba9zY7peRz5PA9T+zPDlIr2rWIbm
	b20S3uqK5bs1SfJ41OSJmKMsB8J3sU8h+IxjbTvIyMGVll4+d9Pto8Bg+g==
X-Google-Smtp-Source: AGHT+IFLRqSB1/22xDRiHykjWNu41egh2fpOLOTNqn8YYnKw+U7sZvls915pHWBgE73Lrr84BhSk2Q==
X-Received: by 2002:a05:6a21:1698:b0:1cc:e9bc:2567 with SMTP id adf61e73a8af0-1cce9bc27d9mr2088942637.24.1724968378824;
        Thu, 29 Aug 2024 14:52:58 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:a1e7:73eb:e77e:3e2b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d512asm1705653a12.78.2024.08.29.14.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:52:58 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 7/7] f2fs: add valid block ratio not to do excessive GC for one time GC
Date: Thu, 29 Aug 2024 14:52:42 -0700
Message-ID: <20240829215242.3641502-7-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240829215242.3641502-1-daeho43@gmail.com>
References: <20240829215242.3641502-1-daeho43@gmail.com>
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
 Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++++++
 fs/f2fs/f2fs.h                          |  2 +-
 fs/f2fs/gc.c                            | 15 +++++++++++----
 fs/f2fs/gc.h                            |  2 ++
 fs/f2fs/segment.c                       |  6 ++++--
 fs/f2fs/segment.h                       |  1 +
 fs/f2fs/sysfs.c                         |  2 ++
 7 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 265baec879fd..2d3e42af0e63 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -783,3 +783,11 @@ Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	If the percentage of free sections over total sections is under this
 		number, F2FS boosts garbage collection for zoned devices through the
 		background GC thread. the default number is "25".
+
+What:		/sys/fs/f2fs/<disk>/gc_valid_thresh_ratio
+Date:		August 2024
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	It controls the valid block ratio threshold not to trigger excessive GC
+		for zoned deivces. The initial value of it is 95(%). F2FS will stop the
+		background GC thread from intiating GC for sections having valid blocks
+		exceeding the ratio.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ee1fafc65e95..8220b3189780 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3918,7 +3918,7 @@ void f2fs_destroy_garbage_collection_cache(void);
 /* victim selection function for cleaning and SSR */
 int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 			int gc_type, int type, char alloc_mode,
-			unsigned long long age);
+			unsigned long long age, bool one_time);
 
 /*
  * recovery.c
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6b79c43a57e3..feb80345aca3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -196,6 +196,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
+	gc_th->valid_thresh_ratio = DEF_GC_THREAD_VALID_THRESH_RATIO;
 
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
@@ -396,6 +397,10 @@ static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 	if (p->alloc_mode == SSR)
 		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
 
+	if (p->one_time_gc && (get_valid_blocks(sbi, segno, true) >=
+		BLKS_PER_SEC(sbi) * sbi->gc_thread->valid_thresh_ratio / 100))
+		return UINT_MAX;
+
 	/* alloc_mode == LFS */
 	if (p->gc_mode == GC_GREEDY)
 		return get_valid_blocks(sbi, segno, true);
@@ -770,7 +775,7 @@ static int f2fs_gc_pinned_control(struct inode *inode, int gc_type,
  */
 int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 			int gc_type, int type, char alloc_mode,
-			unsigned long long age)
+			unsigned long long age, bool one_time)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct sit_info *sm = SIT_I(sbi);
@@ -787,6 +792,7 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 	p.alloc_mode = alloc_mode;
 	p.age = age;
 	p.age_threshold = sbi->am.age_threshold;
+	p.one_time_gc = one_time;
 
 retry:
 	select_policy(sbi, gc_type, type, &p);
@@ -1698,13 +1704,14 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
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
@@ -1908,7 +1915,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		goto stop;
 	}
 retry:
-	ret = __get_victim(sbi, &segno, gc_type);
+	ret = __get_victim(sbi, &segno, gc_type, gc_control->one_time);
 	if (ret) {
 		/* allow to search victim from sections has pinned data */
 		if (ret == -ENODATA && gc_type == FG_GC &&
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index e8195eb4ca6d..59872daf88ee 100644
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
index 647f6660f4df..d9d47c0698d1 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -962,6 +962,7 @@ GC_THREAD_RW_ATTR(gc_max_sleep_time, max_sleep_time);
 GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
 GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
+GC_THREAD_RW_ATTR(gc_valid_thresh_ratio, valid_thresh_ratio);
 
 /* SM_INFO ATTR */
 SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
@@ -1121,6 +1122,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_no_gc_sleep_time),
 	ATTR_LIST(gc_no_zoned_gc_percent),
 	ATTR_LIST(gc_boost_zoned_gc_percent),
+	ATTR_LIST(gc_valid_thresh_ratio),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
-- 
2.46.0.469.g59c65b2a67-goog



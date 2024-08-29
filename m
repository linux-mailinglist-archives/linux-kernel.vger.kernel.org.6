Return-Path: <linux-kernel+bounces-307747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF7A96525C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3185C1F24D56
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91BE1BAED6;
	Thu, 29 Aug 2024 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnyXSPns"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679DE18B47E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968371; cv=none; b=PVH9RV6rKrkSoPoTaWQPiMVCX/DPvt1DFwOB7djNhS4HzqQo/UWRHMbT9cFk9KQgMzpOt/8nhOSck3J0QUIIK3Jru28A0QmmFAincBxcDNnHTtOyLqTxdBfTzlT+fr8gobC6ngbqXF48oIFnM7Je0UowpjNvCcb2HXG7zWh5J58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968371; c=relaxed/simple;
	bh=YW0/SsqxROFfoQ22L21efsY9aqADd26k0Eb5xMaEtRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dltO/ScQeiHe4RaYGVJJiiMFkcuVKRfaVr6r7WfGNsQjZ5645m06Kx9xKGVwERhMNcx1g4LDqPKrljeVvu9DoYvPhY1QMdotLcumQfuSz9PCYxIkdR2f611vuJt5bChMSB5isv1Z6UdhOnUMblNvzlHxbjvhU5Df8mwHIOm431o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnyXSPns; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-829e856a159so52221739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968368; x=1725573168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Edfu7fbFGAzqD2XrSR1tHmTZAuikCACk3QwSTIyslvw=;
        b=PnyXSPnscrFsB8wPADr+Sz8LD+ElG5hgMNY/HX+0kNmjKL05jwb4M7b8orIK2ko+MC
         GKYrHx8+afEtZ47TZ1lSgGw8lAAAB8UG+v8CxAeUj37anwPULAtsCLlOPkDm6/EKU7hE
         HJAlYu/8JxAPC4Jo6vsE57wicCIKDv3dVmZ2hy+upXhSL/moSkOiiHEEMDl/3XWok5fA
         mkuX4DNev1xwF2fS6grShtOUAWbuHOoIj5ep99RMYfs4d4WPt+AzpZhgFagwhfkw5vYO
         xqAf3jq9wv2HNtnO4+unm4aS04l+yTrGEHhMG4o0kPJ0S+gdW3RuFRujPHkhVx9vWKqt
         A7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968368; x=1725573168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Edfu7fbFGAzqD2XrSR1tHmTZAuikCACk3QwSTIyslvw=;
        b=QERGIXVQo1sBQKRlnIlvMa0p5kyF9NN8bKF6992uyCrk2fUUCL2rDhhtvBrImRdiYX
         G1B+sn78vDOlPlqkdujC4dXX5cDAatA6TKb+PoVlbO9nrztDYNAAIsDOpMtM3SfNDzGt
         FxL1Yhp07nYxIZog532TFZxdU9ZLqhSyjTJ+PPfiv5RAw+GVXsyaOFdYuV+8U4ONBZck
         1V15L0GiXDV2FtWAi+yGgJgIVBN8e1clFAG8b+Zxkm3wkbyyMTy5NRnd5hrT+ktBxGNQ
         Hj8M/JIoEzG6iZ8W3bnWW50u4V5qbWMBJLtUBpH4kTud+Uz8T/SQhHXBRRbl7U0OkAVQ
         qFSg==
X-Gm-Message-State: AOJu0YzZ/B/hzq8oqK/uXW+rb7dKyGLHhtn7grTGvXNQ6LTObcOs6A/X
	GO7rWpk/jDQNgcOIPsbsFcFD0yJx+0Phe/jQNcbaawFKsbvZm2Ub3IobIw==
X-Google-Smtp-Source: AGHT+IGTeTrFmeuCfOKUgfFM1WfBAV57WVShkDHfKq+CbbCKAShvP/Vh5nyJgX1QFkU9XX2U3VIuWw==
X-Received: by 2002:a05:6e02:1547:b0:39d:637f:97bc with SMTP id e9e14a558f8ab-39f377138c6mr49358335ab.0.1724968368209;
        Thu, 29 Aug 2024 14:52:48 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:a1e7:73eb:e77e:3e2b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d512asm1705653a12.78.2024.08.29.14.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:52:47 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/7] f2fs: make BG GC more aggressive for zoned devices
Date: Thu, 29 Aug 2024 14:52:36 -0700
Message-ID: <20240829215242.3641502-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Since we don't have any GC on device side for zoned devices, need more
aggressive BG GC. So, tune the parameters for that.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h  | 20 ++++++++++++++++++--
 fs/f2fs/gc.c    | 25 +++++++++++++++++++++----
 fs/f2fs/gc.h    | 22 ++++++++++++++++++++++
 fs/f2fs/super.c |  8 +++++++-
 4 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ac19c61f0c3e..5e4db3ba534a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2854,13 +2854,26 @@ static inline bool is_inflight_io(struct f2fs_sb_info *sbi, int type)
 	return false;
 }
 
+static inline bool is_inflight_read_io(struct f2fs_sb_info *sbi)
+{
+	return get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_DIO_READ);
+}
+
 static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
+	bool zoned_gc = (type == GC_TIME &&
+			F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_BLKZONED));
+
 	if (sbi->gc_mode == GC_URGENT_HIGH)
 		return true;
 
-	if (is_inflight_io(sbi, type))
-		return false;
+	if (zoned_gc) {
+		if (is_inflight_read_io(sbi))
+			return false;
+	} else {
+		if (is_inflight_io(sbi, type))
+			return false;
+	}
 
 	if (sbi->gc_mode == GC_URGENT_MID)
 		return true;
@@ -2869,6 +2882,9 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 			(type == DISCARD_TIME || type == GC_TIME))
 		return true;
 
+	if (zoned_gc)
+		return true;
+
 	return f2fs_time_over(sbi, type);
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 724bbcb447d3..46e3bc26b78a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -116,7 +116,17 @@ static int gc_thread_func(void *data)
 			goto next;
 		}
 
-		if (has_enough_invalid_blocks(sbi))
+		if (f2fs_sb_has_blkzoned(sbi)) {
+			if (has_enough_free_blocks(sbi, LIMIT_NO_ZONED_GC)) {
+				wait_ms = gc_th->no_gc_sleep_time;
+				f2fs_up_write(&sbi->gc_lock);
+				goto next;
+			}
+			if (wait_ms == gc_th->no_gc_sleep_time)
+				wait_ms = gc_th->max_sleep_time;
+		}
+
+		if (need_to_boost_gc(sbi))
 			decrease_sleep_time(gc_th, &wait_ms);
 		else
 			increase_sleep_time(gc_th, &wait_ms);
@@ -179,9 +189,16 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
-	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
-	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
-	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
+
+	if (f2fs_sb_has_blkzoned(sbi)) {
+		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
+		gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME_ZONED;
+		gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME_ZONED;
+	} else {
+		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
+		gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
+		gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
+	}
 
 	gc_th->gc_wake = false;
 
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index a8ea3301b815..14ae85f33235 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -15,6 +15,11 @@
 #define DEF_GC_THREAD_MAX_SLEEP_TIME	60000
 #define DEF_GC_THREAD_NOGC_SLEEP_TIME	300000	/* wait 5 min */
 
+/* GC sleep parameters for zoned deivces */
+#define DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED	10
+#define DEF_GC_THREAD_MAX_SLEEP_TIME_ZONED	20
+#define DEF_GC_THREAD_NOGC_SLEEP_TIME_ZONED	60000
+
 /* choose candidates from sections which has age of more than 7 days */
 #define DEF_GC_THREAD_AGE_THRESHOLD		(60 * 60 * 24 * 7)
 #define DEF_GC_THREAD_CANDIDATE_RATIO		20	/* select 20% oldest sections as candidates */
@@ -25,6 +30,10 @@
 #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
 #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
 
+#define LIMIT_NO_ZONED_GC	60 /* percentage over total user space of no gc for zoned devices */
+#define LIMIT_BOOST_ZONED_GC	25 /* percentage over total user space of boosted gc for zoned devices */
+#define DEF_MIGRATION_GRANULARITY_ZONED	3
+
 #define DEF_GC_FAILED_PINNED_FILES	2048
 #define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
 
@@ -152,6 +161,12 @@ static inline void decrease_sleep_time(struct f2fs_gc_kthread *gc_th,
 		*wait -= min_time;
 }
 
+static inline bool has_enough_free_blocks(struct f2fs_sb_info *sbi,
+						unsigned int limit_perc)
+{
+	return free_sections(sbi) > ((sbi->total_sections * limit_perc) / 100);
+}
+
 static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
 {
 	block_t user_block_count = sbi->user_block_count;
@@ -167,3 +182,10 @@ static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
 		free_user_blocks(sbi) <
 			limit_free_user_blocks(invalid_user_blocks));
 }
+
+static inline bool need_to_boost_gc(struct f2fs_sb_info *sbi)
+{
+	if (f2fs_sb_has_blkzoned(sbi))
+		return !has_enough_free_blocks(sbi, LIMIT_BOOST_ZONED_GC);
+	return has_enough_invalid_blocks(sbi);
+}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3959fd137cc9..790ec9d030c9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -707,6 +707,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			if (!strcmp(name, "on")) {
 				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 			} else if (!strcmp(name, "off")) {
+				if (f2fs_sb_has_blkzoned(sbi)) {
+					f2fs_warn(sbi, "zoned devices need bggc");
+					kfree(name);
+					return -EINVAL;
+				}
 				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_OFF;
 			} else if (!strcmp(name, "sync")) {
 				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_SYNC;
@@ -3785,7 +3790,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
 	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
 	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
-	sbi->migration_granularity = SEGS_PER_SEC(sbi);
+	sbi->migration_granularity = f2fs_sb_has_blkzoned(sbi) ?
+		DEF_MIGRATION_GRANULARITY_ZONED : SEGS_PER_SEC(sbi);
 	sbi->seq_file_ra_mul = MIN_RA_MUL;
 	sbi->max_fragment_chunk = DEF_FRAGMENT_SIZE;
 	sbi->max_fragment_hole = DEF_FRAGMENT_SIZE;
-- 
2.46.0.469.g59c65b2a67-goog



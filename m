Return-Path: <linux-kernel+bounces-322163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EE2972530
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 758FBB23644
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C57318CBF8;
	Mon,  9 Sep 2024 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3EhhbIW"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6DB18030
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920394; cv=none; b=WJy61T3Y1vnw/xT+9iMmlvD5xLi9OJ2i3VtrpNUmwfYl3NPHBhe85gi+pZjd34G7aDwWXuoNDDOErb+yyQ6u2hMHuiqvAk7MhyJ19R6RyBPUIAfsHEn5n1jqNcHYF9JSW/Zbheksz3Rz9qvWUYwb+zX7SMVADSRQlPKrAfSt0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920394; c=relaxed/simple;
	bh=iA1COSt20kOdcH5i/aELy2OeW6liVQUjyYDpjIJdCMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxL7PSJIo0Mar/b7zkj3YXvp/GqJsi+Z9K4YmRuDdrsvbuHKYOWeIXI7FCqwBcaDTbi4qfYavZHB4yNUI/Ue58hSNL3xB+PaulYlBvswfO0FYNx1PAqw05Xcfe+0X1kcGJsePOX5ney3oSrQgIAH5nDnbBQa/eaqQnDbtHMYPEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3EhhbIW; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8f06c2459so3127864a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725920392; x=1726525192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96o2jLIHz/bI5xeY8SRyIJjzjj2HXt3FtxwUFI6EfOI=;
        b=Q3EhhbIWYrcse86G2ACFiL+erBeFIZPWkkzucxijDlGm2QvAPvUaESrBY1q5LWbyvI
         KdkxmxQuU7rBPjOaEvTXkQ1Qn2asiSt7K+bENIZYMEgYeJcCqD08KmBSYYX9EXqCg+Lh
         5OGsnlcjzt9IewLieYJDfk67qu/hpdi/zOF2SjisxBxwAq/Wn+cujN9+fzE6d8xLGORd
         gFyaeAd1bR1tYx/SmjR9rnMKdjBfUbl18x4YBhHAIhJbhOg39BgbutiKbSztjnbU9oF7
         pU7ycs50hIJlqZYI/+RKHsWhP1QWtwUXXVYJmGKS8jb5ESw3BAx3cAnSN9PkRsA8Shg+
         0MhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725920392; x=1726525192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96o2jLIHz/bI5xeY8SRyIJjzjj2HXt3FtxwUFI6EfOI=;
        b=eMIbf88viT6p/cevcL1xB6Td3+VWsyt9M+6pDNU6I05iTSBPUXnYXpZ4aC/tIhfxYA
         wzXtOiv0xjwPU5J8Ep2/aPRdrV4ENJTv3ZIoWPUkT7PbogjA2dlLvNGiGTeZgO5/j+CY
         ghuZ/Rp11pYIEbJ3MntJBnpUCXZMvuFXZfprfKQUWJrajxOD7aT6HNUIiSqDn/2PGyvM
         mmsEwCF3H3SXyHQx52CRu+5iMPu/nU5DQEzCT+8/N2pVpg39i6B9VKtvgGD8LJteEkhp
         eIV0NQlEQubiIjAcs4tScW0jYaEM01/DIInkrMu+Zd6sXyUzzENxMAHoxaJAe7eKaQJv
         Sk8A==
X-Gm-Message-State: AOJu0YyWPQoAI3GxMPm0oECID/y0btCNLoUAav/FqNAjh8veBb/UP0SH
	Cofd/mTBe01NuSOlICnBpVZx6mZYWjtZRXkH7uwCz0AOsNID38uxaZPT2g==
X-Google-Smtp-Source: AGHT+IGYtptBMoCRyIFLyR68NFRnQCLG+PIh/2i8YAvc5XVEbC/o5hvfd2WlnY6N4BtfpvmnF8kruQ==
X-Received: by 2002:a17:90a:e651:b0:2d8:f99d:48d2 with SMTP id 98e67ed59e1d1-2dad50fcd09mr10727795a91.29.1725920391729;
        Mon, 09 Sep 2024 15:19:51 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:ed56:14c3:db02:6c66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04988470sm5016840a91.54.2024.09.09.15.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 15:19:51 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2 1/7] f2fs: make BG GC more aggressive for zoned devices
Date: Mon,  9 Sep 2024 15:19:40 -0700
Message-ID: <20240909221946.2004046-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
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
 fs/f2fs/gc.h    | 21 +++++++++++++++++++++
 fs/f2fs/super.c |  5 +++++
 4 files changed, 65 insertions(+), 6 deletions(-)

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
index a8ea3301b815..55c4ba73362e 100644
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
@@ -25,6 +30,9 @@
 #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
 #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
 
+#define LIMIT_NO_ZONED_GC	60 /* percentage over total user space of no gc for zoned devices */
+#define LIMIT_BOOST_ZONED_GC	25 /* percentage over total user space of boosted gc for zoned devices */
+
 #define DEF_GC_FAILED_PINNED_FILES	2048
 #define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
 
@@ -152,6 +160,12 @@ static inline void decrease_sleep_time(struct f2fs_gc_kthread *gc_th,
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
@@ -167,3 +181,10 @@ static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
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
index 3959fd137cc9..ca2101ad918e 100644
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
-- 
2.46.0.598.g6f2099f65c-goog



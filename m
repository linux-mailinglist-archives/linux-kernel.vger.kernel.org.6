Return-Path: <linux-kernel+bounces-322168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557F597253C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797301C22BA5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD05618E042;
	Mon,  9 Sep 2024 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgqSvPyS"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8618DF61
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920399; cv=none; b=mKlBql2EQYsGL/5BR4whfy+uh72oSbStIwY3dSRmh/euVwYkZuqiDnuFi2DG0YITEbwcEDoXSRoTcBp8/IGDERZfMdmJxKq1kmhpmu+pD50T7pDfo5/ODrZXjctizJVsaUE4Gi4+ZAK8qnt8/1qrbclK1zoOOvKjuslXzmInE4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920399; c=relaxed/simple;
	bh=ULOcM+u7ZrFwsUCVHBkBRnylKDud05h5ebz/HZ3aWnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZ8kT2ylCxM+pi6JLYiXNV4LLl/8C71UAt7m9iyvsd8YnErNWbx399nH0b7fRWPhXN2gb82X9zlVbKFACpFfl1WNpgzy1IPRXMJcAqaU3W3c/gZgRM3lWW27KUbf0KtGaOrCNIvjCi4EqC34rzgZQ0dDWAnF3gnYBMIs6/D8zDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgqSvPyS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so3814831a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725920397; x=1726525197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cla/Hu+x6KHpSAchLiy/oR8hbHuRD9DRfoz1PxleRLw=;
        b=GgqSvPySbaThmN0b4xAO5qBypqL+y7OUJgyBycpBsZpOtisB0LEeXH1TYQHZlo/Rsi
         hszb4+l+gQVymFJWVkfxkxLchjpHoStVzKbEpkCVnS4V3PMuZAQ/6JFlrnobmGyY+Zms
         WEvFzUbWFiMdu0nZzUaCKyH9rxv0OJR3KClAJiia66YRn0lpxXkbm4yF/biT3HZH9ozP
         EaDEOXKoutIT40hqhLPaEA1p0zo4AmVhpgyMvWhTMkeLtituhLeQ/z6SIW4hl92vTcIr
         lRBuUCUsvVCY1buW4O7kTC+Cj+QyDbYxtAjJwXZRrOpIoMhqV5kK+yOTIKDFPszSFnt+
         pHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725920397; x=1726525197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cla/Hu+x6KHpSAchLiy/oR8hbHuRD9DRfoz1PxleRLw=;
        b=tG9nCgK9BCSVuyPIV4JoI9kYVSjPqXcT2PfVn2jAuDNqEe/CSaXV9XTcvKVFSsqMEY
         hxTl7VbZQhu5X0vTEOSYozTPzLd9LaIYBNVbUxcBITGpAhKoOUSUmcP9hXprr3Reo1b/
         pBPgErvWwVClCeDhpnyOkA4VJJCr8a9WqfUSeZvOpmLTtSR8mFSW+097WUsGoGaqiQQ3
         bsG4+M1bIsFUftN1VsdsFuE5wUC+BK7zXbrI+rB18ony/4W1HiYPQxUHobJt+G8wLc0S
         SSCI8J0Fht4HOcdlHgXaDoInI93vZd8YXxV0b5UILn2KjVFan2XuAGuajx7H2EytE4L5
         g5JQ==
X-Gm-Message-State: AOJu0YykGSmcf1rbvrKovg0ty6+eOdTnHwz9Fi6jU3jJB03UNymKzthF
	bSFP2GojtxYvHvkEk0B4/OCpbZ2q0B87WiXOKQ2cBQ1FwImAApQ5ahbS3Q==
X-Google-Smtp-Source: AGHT+IGfEphEYe8iguFpalf0M6+gnZinIeoQ6xP0sK1afOnwfJgv0XG/DI5+vE4JW3HwyJDIpFiDKw==
X-Received: by 2002:a17:90b:3c43:b0:2da:5156:1253 with SMTP id 98e67ed59e1d1-2dad50141cbmr2814276a91.21.1725920396721;
        Mon, 09 Sep 2024 15:19:56 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:ed56:14c3:db02:6c66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04988470sm5016840a91.54.2024.09.09.15.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 15:19:56 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2 6/7] f2fs: create gc_no_zoned_gc_percent and gc_boost_zoned_gc_percent
Date: Mon,  9 Sep 2024 15:19:45 -0700
Message-ID: <20240909221946.2004046-6-daeho43@gmail.com>
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

Added control knobs for gc_no_zoned_gc_percent and
gc_boost_zoned_gc_percent.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 14 ++++++++++++++
 fs/f2fs/gc.c                            | 12 +++++++++---
 fs/f2fs/gc.h                            |  4 ++++
 fs/f2fs/sysfs.c                         |  4 ++++
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index deff703035e1..f3c533b523cd 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -777,3 +777,17 @@ Date:		September 2024
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	In order to fine tune GC behavior, we can control the number of
 		reserved segments.
+
+What:		/sys/fs/f2fs/<disk>/gc_no_zoned_gc_percent
+Date:		September 2024
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	If the percentage of free sections over total sections is above this
+		number, F2FS do not garbage collection for zoned devices through the
+		background GC thread. the default number is "60".
+
+What:		/sys/fs/f2fs/<disk>/gc_boost_zoned_gc_percent
+Date:		September 2024
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	If the percentage of free sections over total sections is under this
+		number, F2FS boosts garbage collection for zoned devices through the
+		background GC thread. the default number is "25".
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a59fec64eccf..319b4b80ba72 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -119,7 +119,8 @@ static int gc_thread_func(void *data)
 		}
 
 		if (f2fs_sb_has_blkzoned(sbi)) {
-			if (has_enough_free_blocks(sbi, LIMIT_NO_ZONED_GC)) {
+			if (has_enough_free_blocks(sbi,
+				gc_th->no_zoned_gc_percent)) {
 				wait_ms = gc_th->no_gc_sleep_time;
 				f2fs_up_write(&sbi->gc_lock);
 				goto next;
@@ -200,10 +201,14 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
 		gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME_ZONED;
 		gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME_ZONED;
+		gc_th->no_zoned_gc_percent = LIMIT_NO_ZONED_GC;
+		gc_th->boost_zoned_gc_percent = LIMIT_BOOST_ZONED_GC;
 	} else {
 		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
 		gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
 		gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
+		gc_th->no_zoned_gc_percent = 0;
+		gc_th->boost_zoned_gc_percent = 0;
 	}
 
 	gc_th->gc_wake = false;
@@ -1740,8 +1745,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 			if (f2fs_sb_has_blkzoned(sbi) &&
 					!has_enough_free_blocks(sbi,
-					LIMIT_BOOST_ZONED_GC))
-				window_granularity *= BOOST_GC_MULTIPLE;
+					sbi->gc_thread->boost_zoned_gc_percent))
+				window_granularity *=
+					BOOST_GC_MULTIPLE;
 
 			end_segno = start_segno + window_granularity;
 		}
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 78abeebd68b5..c063310c8dde 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -61,6 +61,10 @@ struct f2fs_gc_kthread {
 						 * caller of f2fs_balance_fs()
 						 * will wait on this wait queue.
 						 */
+
+	/* for gc control for zoned devices */
+	unsigned int no_zoned_gc_percent;
+	unsigned int boost_zoned_gc_percent;
 };
 
 struct gc_inode_list {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 761d1abd46a8..60693ec39a03 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -965,6 +965,8 @@ GC_THREAD_RW_ATTR(gc_urgent_sleep_time, urgent_sleep_time);
 GC_THREAD_RW_ATTR(gc_min_sleep_time, min_sleep_time);
 GC_THREAD_RW_ATTR(gc_max_sleep_time, max_sleep_time);
 GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
+GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
+GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
 
 /* SM_INFO ATTR */
 SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
@@ -1123,6 +1125,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_min_sleep_time),
 	ATTR_LIST(gc_max_sleep_time),
 	ATTR_LIST(gc_no_gc_sleep_time),
+	ATTR_LIST(gc_no_zoned_gc_percent),
+	ATTR_LIST(gc_boost_zoned_gc_percent),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
-- 
2.46.0.598.g6f2099f65c-goog



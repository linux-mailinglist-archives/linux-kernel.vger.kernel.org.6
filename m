Return-Path: <linux-kernel+bounces-307752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B2F965268
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80B51F21987
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27761BC06D;
	Thu, 29 Aug 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2BcAx2i"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B61BC078
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968380; cv=none; b=hbQu5D1cCNHJqalTZYpEslLXmNcCvtMkgHtA70zpRIF38LxD2ycDbMDT1/TpwHPQE2jzcfWrGkTT6H+1Z8z+SY6QJhZSX6e+sAdSTFHNAZpK/OREniE78Bh0315vNrnl7R4ZQTIIiCHa+zwkhK3QvVJkbZhpYeD98+qOUu4sfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968380; c=relaxed/simple;
	bh=tqn9R/YpyxDT8S5ewn4/CURmoBoa9Tg1+C5PX3nQ/Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbclWx0WtQUWnpTHuBL9zwZGE09t3EhqTZx5LToB+eS/cf3z38ILFfMpJPZDEHl5xy5zkPwj8seSlDlF6ca2EfyYNdd1X+jkaSc29adkdxZmNMvpC93FN0dMSDr7ALRQ+F31K7LDIMOkLbOGFguGEhxJLrJRcVEgqSv5VM9osSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2BcAx2i; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d30564949so4363315ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968377; x=1725573177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCE0wLcnJbc0xPPX5QrcdREOsfuAh2HyRWp/G1mjRP4=;
        b=F2BcAx2ishipF2bTSu0Qo0OZgGFQTfEy2cVsUW0F0Tqbw7yH4JFxLpS0BuSM7SeD2s
         U310kfP31bq1F6WRIDbRfKd6iV9Y+h6PvqfpIOOa8mSGkapcvtkEyLuM7HEOD0o0YPnW
         jrVAL21kZfLFr79OLT8C3nEvlSs5e/mxA9eHFpZzDycTIAdmFdDBEgFxLsn63mXZfufr
         y25fGxY5FWRirBAex6XpcRXqWePCYV4cVGCsX+Ko1KA9v4o3CJi72fWQIl8vggegrKfj
         +EjYcCl31wk9AR7h3DX5wAWLe+Pvs1MiayEY8MWQxdaVXfyp4Rk7+svXoTPXt/svGvMe
         JRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968377; x=1725573177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCE0wLcnJbc0xPPX5QrcdREOsfuAh2HyRWp/G1mjRP4=;
        b=rjmZaBfy0h5njdUDomI+wlOr/eyIz3w/xPJbV1J2de0gSaZqFyfVOlA48mQ+Os72pw
         q+tuxz8rergWYLRWBMyMtX+xum3zVZFcWtrjy5bCglHWt5BM7WtAhdjceXDi9IfO15w9
         YgdrJNH6YVgiJAtZaKmdpsfJ7nABO3bdRbzirJYSOsyE/I12tjiw0FaiBfCZ6gIzjwer
         u4AxkyXh42B7ZAQrpIO65L29oY7KXkOsiORvn4R6efUZHHwflZI7nAWkfw8DYmMdxKij
         r9GoWr/PnWm66zH0zx334MBC62g3p+8z1EZavqibOoQiM8o44K8zTEWGFKbk4yPH8uKW
         fMqw==
X-Gm-Message-State: AOJu0Ywg4XAb9BXYPZ9SMAN1F+gMFS4NurQhX/4hO3DFWPL8pQ6+ht93
	L6vD0uoOqh2bl8+ps9fgi8xfXiTE/WfSPab8L+qxSlH20QDA4vrELS/ddw==
X-Google-Smtp-Source: AGHT+IE0LMLaW2SFCQEnAxcRPDZaaNk8z4TmEdUAL7GcPO1HotWMRXyXRXgwaiwnYrlWv7QK3LyMcg==
X-Received: by 2002:a05:6e02:1e09:b0:39e:3b81:66b5 with SMTP id e9e14a558f8ab-39f377d80aemr56263715ab.4.1724968377453;
        Thu, 29 Aug 2024 14:52:57 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:a1e7:73eb:e77e:3e2b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d512asm1705653a12.78.2024.08.29.14.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:52:57 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 6/7] f2fs: create gc_no_zoned_gc_percent and gc_boost_zoned_gc_percent
Date: Thu, 29 Aug 2024 14:52:41 -0700
Message-ID: <20240829215242.3641502-6-daeho43@gmail.com>
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
index 4fcd0f824bde..265baec879fd 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -769,3 +769,17 @@ Date:		August 2024
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	In order to fine tune GC behavior, we can control the number of
 		reserved segments.
+
+What:		/sys/fs/f2fs/<disk>/gc_no_zoned_gc_percent
+Date:		August 2024
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	If the percentage of free sections over total sections is above this
+		number, F2FS do not garbage collection for zoned devices through the
+		background GC thread. the default number is "60".
+
+What:		/sys/fs/f2fs/<disk>/gc_boost_zoned_gc_percent
+Date:		August 2024
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	If the percentage of free sections over total sections is under this
+		number, F2FS boosts garbage collection for zoned devices through the
+		background GC thread. the default number is "25".
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 37b47a8d95f1..6b79c43a57e3 100644
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
-				migration_granularity *= BOOST_GC_MULTIPLE;
+					sbi->gc_thread->boost_zoned_gc_percent))
+				migration_granularity *=
+					BOOST_GC_MULTIPLE;
 
 			end_segno = start_segno + migration_granularity;
 		}
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 33848d550153..e8195eb4ca6d 100644
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
index 2ed773132f40..647f6660f4df 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -960,6 +960,8 @@ GC_THREAD_RW_ATTR(gc_urgent_sleep_time, urgent_sleep_time);
 GC_THREAD_RW_ATTR(gc_min_sleep_time, min_sleep_time);
 GC_THREAD_RW_ATTR(gc_max_sleep_time, max_sleep_time);
 GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
+GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
+GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
 
 /* SM_INFO ATTR */
 SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
@@ -1117,6 +1119,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_min_sleep_time),
 	ATTR_LIST(gc_max_sleep_time),
 	ATTR_LIST(gc_no_gc_sleep_time),
+	ATTR_LIST(gc_no_zoned_gc_percent),
+	ATTR_LIST(gc_boost_zoned_gc_percent),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
-- 
2.46.0.469.g59c65b2a67-goog



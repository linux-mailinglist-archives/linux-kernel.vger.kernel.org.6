Return-Path: <linux-kernel+bounces-307751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FCA965267
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A700E1F2190B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D991BAECD;
	Thu, 29 Aug 2024 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfMr81B2"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3441A1BBBED
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968378; cv=none; b=RS9HK8v5QUG1yL8RmmGJiBCs7f0YJLx9sHB6iuMYXF+YLkO1tkQRFKpP/jcrUB/Cuk1e5E5lUROyV0Dj1TZltXLbXM5siwJ6BGITWUgvXMpvkHxLTmGGyM4fvPY1MnpTp+aXMK9Bc+FB4F/jfRxVayOkdrd6E8H1gAt4uLYc2e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968378; c=relaxed/simple;
	bh=rlKP7yPvLnFrQYxbVVc9yjAkgBsEyvDMr0QRZexvYW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHcfwahg0VHCQSxyA8caaL0KjOxeYe9nCCNRizxNWBQWwT47X0yhPKTlbKxQsIb9SfeiS9H55kkVRfZ9XoaEymCP7h5Kbwp9Whta8xXJ7Jf6ntezu9EK/6SwHBvaS2IFZYyg/Yr5cZyQkgl3c/LenOnSrrUc2eaOipBciGGjXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfMr81B2; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d2256ee95so5359655ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968376; x=1725573176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2yDERBuwFp8nVKBjkDWK81Owor96SC7L8sKWZWfv3Q=;
        b=gfMr81B2FLKQ/eGmqhn5ORldnD/fuqf/XPP3XIDHKA7RX33c0pvmHmsCKJJ4gTXnIr
         OCigvO3IqZa8eACJuerujc6zOn23doeZgFTDJHaGfXd1I/WFvM156TGgDZg8jgzFE2l/
         t6VX7v4oqi5vimEvKxEqwDHh7ZPIDCwrOh3+0AVop1BkMDh+i+Yyb5LkXls7caYgO68T
         uEPhaBC2ksMkNuaaPQXZMQPJz0fBIi1nE5bMM5YdlUAPgHCEUHkaqCjpLldgkd/XuBVJ
         1oRoRzo1d/7stOvUfrFX2foVMLacItdw2xMDaZVPmUhlztPDWMcyueWSd7DB1SOxCmRo
         aFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968376; x=1725573176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2yDERBuwFp8nVKBjkDWK81Owor96SC7L8sKWZWfv3Q=;
        b=m5lyjGfB8VjDsUrf5YrnsA8GmbCc8kFCl3J3B2UvGmMd5UySQb4GQzNSTQ/1vmx7zZ
         P6i/ZgcIDsLECU4QmbfTxn92PayQPJ1qLQHxsjirU5K02EOFD74LmmtGd2xuNl5RAick
         PCHVGzvqPF4Zc7+M+8XOuZP1KlBrtqcPsXlhmOxAp6tM+4iKb2IqOteSkLr7JbARlJG/
         LLxabKS1IdxngjXngD43FSfkaSuK3ra3dolQSpeRPF+f+34Hrq6DU7llRnYE5VSC+e9h
         cy47cB2AuGDruGTc7xjfIAvXNFyf1ZZt7LDJglhAUe6jJUzHojwU8xp3Ps4yHnag6fbt
         TLAw==
X-Gm-Message-State: AOJu0YwqDkWI3VTYrgy/2DsPzF4ET6mplhsXHLu3HbyGvhuMXawAkjz8
	i5OTL0++k8DJbxUhCraoEQJ2Y4PGn7gWQbwEoomWyCrnjveDs9sovprHIQ==
X-Google-Smtp-Source: AGHT+IFtyUivTo4A1L+LEOlzGSFxyyn44PCEBcc9Wz4G26Eb8oCHWiMMdRZYIcxxv0rHM+CjSXGQRg==
X-Received: by 2002:a05:6e02:219c:b0:39a:14f7:1c1c with SMTP id e9e14a558f8ab-39f37866c50mr54459475ab.25.1724968376015;
        Thu, 29 Aug 2024 14:52:56 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:a1e7:73eb:e77e:3e2b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d512asm1705653a12.78.2024.08.29.14.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:52:55 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 5/7] f2fs: do FG_GC when GC boosting is required for zoned devices
Date: Thu, 29 Aug 2024 14:52:40 -0700
Message-ID: <20240829215242.3641502-5-daeho43@gmail.com>
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

Under low free section count, we need to use FG_GC instead of BG_GC to
recover free sections.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/gc.c   | 24 +++++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5e4db3ba534a..ee1fafc65e95 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1294,6 +1294,7 @@ struct f2fs_gc_control {
 	bool should_migrate_blocks;	/* should migrate blocks */
 	bool err_gc_skipped;		/* return EAGAIN if GC skipped */
 	unsigned int nr_free_secs;	/* # of free sections to do GC */
+	bool one_time;			/* require one time GC in one migration unit */
 };
 
 /*
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d6d71aab94f3..37b47a8d95f1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -81,6 +81,8 @@ static int gc_thread_func(void *data)
 			continue;
 		}
 
+		gc_control.one_time = false;
+
 		/*
 		 * [GC triggering condition]
 		 * 0. GC is not conducted currently.
@@ -126,15 +128,19 @@ static int gc_thread_func(void *data)
 				wait_ms = gc_th->max_sleep_time;
 		}
 
-		if (need_to_boost_gc(sbi))
+		if (need_to_boost_gc(sbi)) {
 			decrease_sleep_time(gc_th, &wait_ms);
-		else
+			if (f2fs_sb_has_blkzoned(sbi))
+				gc_control.one_time = true;
+		} else {
 			increase_sleep_time(gc_th, &wait_ms);
+		}
 do_gc:
 		stat_inc_gc_call_count(sbi, foreground ?
 					FOREGROUND : BACKGROUND);
 
-		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
+		sync_mode = (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC) ||
+				gc_control.one_time;
 
 		/* foreground GC was been triggered via f2fs_balance_fs() */
 		if (foreground)
@@ -1701,7 +1707,7 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				unsigned int start_segno,
 				struct gc_inode_list *gc_list, int gc_type,
-				bool force_migrate)
+				bool force_migrate, bool one_time)
 {
 	struct page *sum_page;
 	struct f2fs_summary_block *sum;
@@ -1728,7 +1734,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 			sec_end_segno -= SEGS_PER_SEC(sbi) -
 					f2fs_usable_segs_in_sec(sbi, segno);
 
-		if (gc_type == BG_GC) {
+		if (gc_type == BG_GC || one_time) {
 			unsigned int migration_granularity =
 				sbi->migration_granularity;
 
@@ -1908,7 +1914,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	}
 
 	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type,
-				gc_control->should_migrate_blocks);
+				gc_control->should_migrate_blocks,
+				gc_control->one_time);
 	if (seg_freed < 0)
 		goto stop;
 
@@ -1919,6 +1926,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		total_sec_freed++;
 	}
 
+	if (gc_control->one_time)
+		goto stop;
+
 	if (gc_type == FG_GC) {
 		sbi->cur_victim_sec = NULL_SEGNO;
 
@@ -2044,7 +2054,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		};
 
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
-						dry_run_sections == 0);
+						dry_run_sections == 0, false);
 		put_gc_inode(&gc_list);
 
 		if (!dry_run && get_valid_blocks(sbi, segno, true))
-- 
2.46.0.469.g59c65b2a67-goog



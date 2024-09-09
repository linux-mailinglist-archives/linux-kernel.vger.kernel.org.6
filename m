Return-Path: <linux-kernel+bounces-322167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED0997253B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21307B235FA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5187118E02A;
	Mon,  9 Sep 2024 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa86Scdt"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14A18D640
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920398; cv=none; b=TNghLLszoAJ2Z84SbDYFxHD98qFeVo46V/E/WjEwcWlDV0AH8zyhjAmsTeFtDRQmH6FhO2rMD3uaOsXWiFlEvDAN5HW+Bt9FgD2/HzwLYskYPQ+UQZM9GOth/vBa0Nbzvzo46yvcMZ/Hd90GkFLQTqgLZhUZIxPwn8Jj7+Qcrnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920398; c=relaxed/simple;
	bh=ncHxlOfjKTNcDBDJ0HFj4iMQZeiYpgibkSz9kbpBncE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ks+JGZNOseBOmnOfYC+Te4mJ9Uel8ooQnJV+5+0SuwDJN9BzIn/5CfrFEEcwBY9bs/d3+ZPOzYOf8hx7VFIB0SBt7jht2FfRJNfQ7THu2hZQrPL/Ykcgi3ql4TAsvEXpb6won+bOcMDjeULZCqjLElkuKJwvNG+Yt60a7v6p9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa86Scdt; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso3279010a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725920396; x=1726525196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4K3+hj6aGpbXAqhJlIDqPuZ5OSvQ2hWwcmdr3buziA=;
        b=Oa86ScdtA1z7P/NRn2T+9/qWUzIgzPNkdZ9klLVUs95B0UrHtfxBZP3/Dunz8tNSFP
         dhZ4S1wIN3RfJDVvk1m/lOHE9l5mHiZG85Gz2e3HAmis8FCXdRHfFcyWl1LWqXgVn4PE
         MjICkGh2Buk9AhWoyOcmot2L9/7sheqfqQ3E4JjabhkjHPRi3TGvysyOEoB5TnVQJd4e
         eigdXfzOfk18B9iLqaPdUSjIWXN7K+Cvnm9YY71KuQB5vIOKkx8ns9a7AOGZ+VhK7Yvf
         muP+neiuvsq80Qh54KwVmDpzD+vYTECGRWVeEBKIKUlTHNa8VJ5YPbtSFhLXXLK9OhTH
         nvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725920396; x=1726525196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4K3+hj6aGpbXAqhJlIDqPuZ5OSvQ2hWwcmdr3buziA=;
        b=Bi3QjbIEP/9ZVCrv2uJwoS7Mmhy42ByxjLeOYCIvGw1MBvPghyBU5LZrnxIA35+OXR
         Msrd3n5hgfZhgnyvUiaO8b9eU0G6MYOsQodnxuhf9Wv97q1EF3sOxTcDe/WjtYx+b3U0
         K3AOHybxvDO33eKb+O+fwEYfQdjbomiM51tk9ia6DWKFu+wWjCRCSQR+9LEnuhX+4lI7
         JKokJ3k8GxyjVa45H1Gd27sfkRoPG2ZfhWuRPu+Tf1o8RafwUFthdGtFCZt0gNezwMyi
         yMESdOa1q2weuazASvVglL7SudZIApPzzikY0tHvl11cCEv78ntKGrJplreObRKr3Eq2
         MYLg==
X-Gm-Message-State: AOJu0YyQTerWgl5BJf8rAbVhtYgQLWsTablAPWDEA3KenM9+yosDbtM8
	kt6DKcrdVNIL+HmIy+vMN2xHr/7bkkJpP2JYZ5i3xSj5OxleQLb1PInXbQ==
X-Google-Smtp-Source: AGHT+IGkmDIg9KV3CCSmtY+SzcDsmrRyyyiLqHx8z9OM9jAnq0cDAY0hqnch/xtkfI29tRAs6tMX+A==
X-Received: by 2002:a17:90b:3846:b0:2da:89ac:75b9 with SMTP id 98e67ed59e1d1-2daffa7fcaamr11312122a91.11.1725920395881;
        Mon, 09 Sep 2024 15:19:55 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:ed56:14c3:db02:6c66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04988470sm5016840a91.54.2024.09.09.15.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 15:19:55 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2 5/7] f2fs: do FG_GC when GC boosting is required for zoned devices
Date: Mon,  9 Sep 2024 15:19:44 -0700
Message-ID: <20240909221946.2004046-5-daeho43@gmail.com>
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

Under low free section count, we need to use FG_GC instead of BG_GC to
recover free sections.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: moved up the one_time field for better padding.
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/gc.c   | 24 +++++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a00e01e66e08..62880fbb9e20 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1293,6 +1293,7 @@ struct f2fs_gc_control {
 	bool no_bg_gc;			/* check the space and stop bg_gc */
 	bool should_migrate_blocks;	/* should migrate blocks */
 	bool err_gc_skipped;		/* return EAGAIN if GC skipped */
+	bool one_time;			/* require one time GC in one migration unit */
 	unsigned int nr_free_secs;	/* # of free sections to do GC */
 };
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9a3d3994cf2b..a59fec64eccf 100644
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
 			unsigned int window_granularity =
 				sbi->migration_window_granularity;
 
@@ -1911,7 +1917,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	}
 
 	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type,
-				gc_control->should_migrate_blocks);
+				gc_control->should_migrate_blocks,
+				gc_control->one_time);
 	if (seg_freed < 0)
 		goto stop;
 
@@ -1922,6 +1929,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		total_sec_freed++;
 	}
 
+	if (gc_control->one_time)
+		goto stop;
+
 	if (gc_type == FG_GC) {
 		sbi->cur_victim_sec = NULL_SEGNO;
 
@@ -2047,7 +2057,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		};
 
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
-						dry_run_sections == 0);
+						dry_run_sections == 0, false);
 		put_gc_inode(&gc_list);
 
 		if (!dry_run && get_valid_blocks(sbi, segno, true))
-- 
2.46.0.598.g6f2099f65c-goog



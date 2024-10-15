Return-Path: <linux-kernel+bounces-366303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC699F373
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC311F2448F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863EA1F9EB9;
	Tue, 15 Oct 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkYc2ffW"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907CF1F667A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011276; cv=none; b=aZQJwcnhLVQQoVZvnDUhoI06oy4qPN0LYVfc2J9eqRipKCFJ54OLniUO/M1qI717iHXl4Wk+40OQ1fQWf8v+XJi713uyFEWutogCr+EjTjcNRabGS611NZFRLHjJpkJpZjCkkblsHFdhLYhIFPqmPOJk05DpmF/+wCyucqG+AYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011276; c=relaxed/simple;
	bh=vrOm/P65PBxwXpliChjYHkeVdVy2DOuGBzVLnWe4WUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rursx7I+ycVQ0GfhhPBQcQ5UWidGV47l3l/odu1MpDrBORHpI/EiTwYwKZ20vxkVRYYfee/DmPLGLfrxWeFyghGmObZj1DNJzA/ALIjOJqjkAoy3zWaXUn7UihKcAE+RtEhF8FDFJXXvRHdmtHnSfoPFT+HcwBBkppLtHtOLwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkYc2ffW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so25588a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729011274; x=1729616074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XSIuw9t8qqAGU3LASSqlk7DcuPSdOBXbd/e951K8nWg=;
        b=QkYc2ffWR0Kdc7aDpdUFDF+YIuUNsdK1IFDMn1I+z/HxA581q+WAwFxT3LCf1bzeg8
         S3bYG48+WI5EonT2+BVU+a1ofJWLfrxPwe36i/SE7FyJCh2qkxHIg2m3eGQRxOSPn+nT
         ExELema47dJengGrxkbwk3NiuIL/e6wHQeSKFYBmEvpfg+JLfuYFSKaPvcqOcJneYsHX
         891RMpJvSSOcs1MwFyJwaJVMxKODkFyfbsfXhskMkbKSTuGECEdhBIZZ0BKgUfmr+p+J
         iaeZ6g8V6hTe1zJkai4C37q5pfWgSgkTX8OXEQI8vIs7sEiWK1kJB8KwBFA6njrqQxPj
         2ZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729011274; x=1729616074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSIuw9t8qqAGU3LASSqlk7DcuPSdOBXbd/e951K8nWg=;
        b=f8PskGjRv9UZ/tLNGuoxFc5wwEzqJLUtDIa+hPM1YwoK5onBG7zMtJvb2CMZjm7QrQ
         833yzoVO4ePp8SD0E2cT/Cag9HwY0QXikM99FraWdb1Dwb6qLwMT+95vDH8uMrfYMX8M
         IEKrQkGehW60coFm1Ix9N11Q86CZW48B6/XFVN9mDWjkJFB7M8zyj9aBuF1fc/pThWhR
         52GZ/ozSdzQLXtS692zWPmqWpRcGbIM5vRUAJ2kICZ22Dx5pbXl+8iDjzp7GO00vdDmd
         l5QzrN/9xzuLU2K4hukQ4t+kwGPiDvOeWsIFSnMH2T9YKdMF4+B9b8hJFbfIsz+BKleC
         FmcA==
X-Gm-Message-State: AOJu0Yyb9jJvSaGgw2MFfvjEg7sRJ/s/fJaLJf6kOqC/DkqX0HlUrVXE
	aacC3dPn+WIljtaeHfefe6WBwAgX0rsRBuxVrXq24p88NuSi5rZ7cD0mlw==
X-Google-Smtp-Source: AGHT+IHjqFnVFN8DEmdFfF7q+IxSajH9xKuy29tur0u0k4werNtpBJCAEGuQa+NVMnyC6hO1bUKQsw==
X-Received: by 2002:a17:90a:34c6:b0:2e2:b94c:d6a2 with SMTP id 98e67ed59e1d1-2e2f081be2emr23860881a91.0.1729011274442;
        Tue, 15 Oct 2024 09:54:34 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:efdb:1582:924:51c3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f7559asm2048927a91.52.2024.10.15.09.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:54:34 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: decrease spare area for pinned files for zoned devices
Date: Tue, 15 Oct 2024 09:54:27 -0700
Message-ID: <20241015165427.1158782-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Now we reclaim too much space before allocating pinned space for zoned
devices.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c    | 3 ++-
 fs/f2fs/gc.h      | 1 +
 fs/f2fs/segment.c | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 321d8ffbab6e..7d0591d28b71 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1790,7 +1790,8 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 
 		map.m_len = sec_blks;
 next_alloc:
-		if (has_not_enough_free_secs(sbi, 0,
+		if (has_not_enough_free_secs(sbi, 0, f2fs_sb_has_blkzoned(sbi) ?
+			ZONED_PIN_SEC_REQUIRED_COUNT :
 			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
 			f2fs_down_write(&sbi->gc_lock);
 			stat_inc_gc_call_count(sbi, FOREGROUND);
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 2914b678bf8f..5c1eaf55e127 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -35,6 +35,7 @@
 #define LIMIT_BOOST_ZONED_GC	25 /* percentage over total user space of boosted gc for zoned devices */
 #define DEF_MIGRATION_WINDOW_GRANULARITY_ZONED	3
 #define BOOST_GC_MULTIPLE	5
+#define ZONED_PIN_SEC_REQUIRED_COUNT	1
 
 #define DEF_GC_FAILED_PINNED_FILES	2048
 #define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1766254279d2..b982e80cedd5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3237,7 +3237,8 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 
 	if (f2fs_sb_has_blkzoned(sbi) && err == -EAGAIN && gc_required) {
 		f2fs_down_write(&sbi->gc_lock);
-		err = f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk), true, 1);
+		err = f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk),
+				true, ZONED_PIN_SEC_REQUIRED_COUNT);
 		f2fs_up_write(&sbi->gc_lock);
 
 		gc_required = false;
-- 
2.47.0.rc1.288.g06298d1525-goog



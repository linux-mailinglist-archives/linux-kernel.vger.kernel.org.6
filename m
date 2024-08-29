Return-Path: <linux-kernel+bounces-307750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FE9965266
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514B8B241C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC481BA89A;
	Thu, 29 Aug 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXUPGngx"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E421BA28A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968377; cv=none; b=tIw0myv5BtsVZ18faBDuwwhUR/zdv+RDSyly42SOvMTH2ibXe7cFbY+n7ZhB3JA3mICr4pEpvPs7epShD4MJzJx6lyGtk0PtuvR7bIwm5vmv+D0iYLUf5BzA5OsJJHGGHDsJTylCjaMQlbX+8Kb1NCei+SzEZTqH5x8v7nfcl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968377; c=relaxed/simple;
	bh=vgVv1H5PPkGEZiXEheBnBlT944JS6Sk7VyKOnjt8jwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpCcB7B12HvQQKmL8lmiS/7HLAuTYxcRuLc2dcd8EljcPjulMdqCuQZZSM2KImnBYE2KtDCEWx2CdNSKqypI0V+u9PVHiDGIh22a0IBlUn8RISLaM8B6e8SNqDCuOJcxn+tc+L8VQpML6HMcqvqlYTMHO2VMRALTTGl9whbIhBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXUPGngx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so991179b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968375; x=1725573175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5di2cQVabKUZYkrdLXdRKWcnXs84Me/LJIQm48KHUJY=;
        b=OXUPGngxDp2KL/H/H4fbZlHynvOXFTUZInbzNhzsZx4itnVBQ9NE1KIJcV9HPWp0EX
         02cm263JWS6ichorL0lr8azEdY3IvA4E1M99Vaiw63ivaCMqYhhwdDHtBLieXUInI1hH
         kSXQq7CkoRiTGPg0TB1PMstSHEDM7H8TwI93abQeiDvsyr9UJXDlzDB5+xiN3CrMDBst
         25coU4oZyNGBBL4kyjTMIw+R9X8juh2cZTOV3Ma6gkcZDqukG4+vBIaBg7LY3vEPNneH
         KIOS7zfwSRgpV6eF+Bx9sc2s+LKU04NRmdm3aZmd5+Ov573oTJCuMNJLFgA4FU7VwrTG
         5p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968375; x=1725573175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5di2cQVabKUZYkrdLXdRKWcnXs84Me/LJIQm48KHUJY=;
        b=mIAYP26S8/D5dJY55vmVowsP+U1Wj0wfw1f+a7yIo0ehse9k2Bsb08Tj59nJhGHHef
         QeSxn6jYF4301YpJNl08/uaUiFntjVq2zuW20Eb2S+uNK8QShgQspKuM5aiMkrB56VV8
         SgQp+vAUpW5A4s6zXvjLxVVw4Xe49eZsmwarmVOXX6nOv2Lh1OyOkl9o9X12rgAV6zZZ
         2cBTBh9QBXo5MZ21UU4zfVcJrfWlsaGDVBpT/1IXK/qF8Dvhm1cvSBZroQoyP+EF6ZK+
         MXPffZWcFRt89Rdms4uje61YKocxepmeIg5eqXPZcmFChIFNI0eLtf/wt51/eaUYANfk
         F7bw==
X-Gm-Message-State: AOJu0YxGdKRllfTZvLJfD3vt5QoaEznsppl9cFmxna8rS6bauOotUg0+
	eUcmSP14S+EPyjcw6gbGbXCRz2Su7z2U6o/tUchuSYeEokJC9lzMhjpW9g==
X-Google-Smtp-Source: AGHT+IGxnhE16JGql/YBxmn1MFalr9m8fkVidqAE2UlxFSw6h7S0cI4sb4YdnE5ovusiqZW5QWtknQ==
X-Received: by 2002:a05:6a21:4a4a:b0:1c4:f366:381b with SMTP id adf61e73a8af0-1cce10b09a6mr3425760637.33.1724968374536;
        Thu, 29 Aug 2024 14:52:54 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:a1e7:73eb:e77e:3e2b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d512asm1705653a12.78.2024.08.29.14.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:52:54 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 4/7] f2fs: increase BG GC migration granularity when boosted for zoned devices
Date: Thu, 29 Aug 2024 14:52:39 -0700
Message-ID: <20240829215242.3641502-4-daeho43@gmail.com>
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

Need bigger BG GC migration granularity when free section is running
low.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/gc.c | 13 +++++++++++--
 fs/f2fs/gc.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b5d3fd40b17a..d6d71aab94f3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1728,8 +1728,17 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 			sec_end_segno -= SEGS_PER_SEC(sbi) -
 					f2fs_usable_segs_in_sec(sbi, segno);
 
-		if (gc_type == BG_GC)
-			end_segno = start_segno + sbi->migration_granularity;
+		if (gc_type == BG_GC) {
+			unsigned int migration_granularity =
+				sbi->migration_granularity;
+
+			if (f2fs_sb_has_blkzoned(sbi) &&
+					!has_enough_free_blocks(sbi,
+					LIMIT_BOOST_ZONED_GC))
+				migration_granularity *= BOOST_GC_MULTIPLE;
+
+			end_segno = start_segno + migration_granularity;
+		}
 
 		if (end_segno > sec_end_segno)
 			end_segno = sec_end_segno;
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 14ae85f33235..33848d550153 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -33,6 +33,7 @@
 #define LIMIT_NO_ZONED_GC	60 /* percentage over total user space of no gc for zoned devices */
 #define LIMIT_BOOST_ZONED_GC	25 /* percentage over total user space of boosted gc for zoned devices */
 #define DEF_MIGRATION_GRANULARITY_ZONED	3
+#define BOOST_GC_MULTIPLE	5
 
 #define DEF_GC_FAILED_PINNED_FILES	2048
 #define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
-- 
2.46.0.469.g59c65b2a67-goog



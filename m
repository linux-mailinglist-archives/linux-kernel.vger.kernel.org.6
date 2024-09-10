Return-Path: <linux-kernel+bounces-322164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419B4972532
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B280B2367A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1129018CC07;
	Mon,  9 Sep 2024 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSOfy2Fb"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314618C901
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920395; cv=none; b=cpaJuopurfp36Fyrj+rj14CHjkOJmqot6Q7ZXLhDhYDS33jzdOA0fBUGuYR9dmqduyBbEDe/zcYIg0YS5GzUg/Sr9tJj+DN3JJ6oEhRRAPMgN4hBI7sqOihAswo2bqfpD1tvoCFzFWwjedVTId/+icAwOSfELTTlNfPEmsZjX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920395; c=relaxed/simple;
	bh=pCyOL5axT41avfjjtgaOpOIEespKvxRYFxfMWL9L7L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLT0kdVKV6Z1qjTVERHQeFEB+B/QE9pCiq8eHk0qXD7Pu+lw/tUyNae3dNB1xi6PkuiK/ifonlZMqoawU4n/EHg+HurvOPkHy2h8mW/l/jOGebIe5bPjlWST9cpLgWpakAKDEMyGTc228Qvoi3lvdR4W69rR4UVzHOjHGe4B1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSOfy2Fb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d4ed6158bcso3419587a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725920393; x=1726525193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGCC+Dv6h85N/mf1N7X2UqBFYf5VzPR2k8+fGtZL+fQ=;
        b=KSOfy2FbCe+GAaUsc83G1hckBkOScqX/IqicTGT5Qw2VVIskX+MwAQ5MVN6o2ruMT6
         u2kbNH8rY5CktUEfbfEO5ZVD4rg/pp8siCCnRRSi8Qlynyta1XHhRBZQBV2Yf8R+cj9M
         0pz2bexXCLs/t3kHwDCerd2f2wrla4s48rz1jEZIIa6of05mOOMkxRYz1HCr4Ut1zxV3
         CSMXCf6RaITTBAweJ9WXjyb08cXzOb9a4eovZhxySsAplqF2MJB3BY63/hlzPS8IIJg2
         ne3Q+kgrnOQ1GSOB9bAlh1ak7NeWLCNtwUrHT3/+wL9lQz+TdrxJbo3x2pZ7BfeJWzzl
         usUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725920393; x=1726525193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGCC+Dv6h85N/mf1N7X2UqBFYf5VzPR2k8+fGtZL+fQ=;
        b=pT9vM99z7yEoM52Ne2Xt13s07YZABEhtX8YzYUuCxXNlNg4vtvIXlePaXGt+TAMIsp
         +P6OXgDa9sr3S5Zuc65+ncT+RaZo9RmVqPP840d5YzvyfKFpqBT2RNO0TAVRFmfkO+Is
         98J2sp7cAv4KE3JVJnVXIMdHnuxghfFnAuXsHR2Nqxcgt09WF0VSVNChFoY+/OO+hLsg
         ZOhsveAZKkdSiK9Ms2EsGFn2fuUZm45FmcvmnbDjynu20mbJEAEmmaf0Tgz9wz0KlOPZ
         tn4zUnN5+i4nSI78fjtG0rMJaCcdDSSp9UEQk2ZFDKib4tXkg1dGG8hv6Wf+jq+ZZr21
         eoGQ==
X-Gm-Message-State: AOJu0Yx/y7lO187Rj7JVPPJkZuHkF5IVJcdCGzfMvxY+E6D/A2HkvCfg
	DYY0j4CVfdEHyEPWkLViycRFmlXZRI9H7NTNaR3oWMnL9z/du5VLoPGVwA==
X-Google-Smtp-Source: AGHT+IF+poKijXFR+9kbWavXc48h+JssHCWV+FY/Q/DkkEudniftOuE5WGPJoQNdnuKDdb0lIOEa+w==
X-Received: by 2002:a17:90a:ae13:b0:2c8:e888:26a2 with SMTP id 98e67ed59e1d1-2dad4efda3bmr11982776a91.13.1725920392551;
        Mon, 09 Sep 2024 15:19:52 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:ed56:14c3:db02:6c66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04988470sm5016840a91.54.2024.09.09.15.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 15:19:52 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2 2/7] f2fs: introduce migration_window_granularity
Date: Mon,  9 Sep 2024 15:19:41 -0700
Message-ID: <20240909221946.2004046-2-daeho43@gmail.com>
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

We can control the scanning window granularity for GC migration. For
more frequent scanning and GC on zoned devices, we need a fine grained
control knob for it.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: introduced a new migration_window_granularity instead of changing
    the meaning of the current migration_granularity
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  8 +++++++
 fs/f2fs/f2fs.h                          |  2 ++
 fs/f2fs/gc.c                            | 31 +++++++++++++++++--------
 fs/f2fs/gc.h                            |  1 +
 fs/f2fs/super.c                         |  2 ++
 fs/f2fs/sysfs.c                         |  7 ++++++
 6 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index cad6c3dc1f9c..9165f617d216 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -763,3 +763,11 @@ Date:		November 2023
 Contact:	"Chao Yu" <chao@kernel.org>
 Description:	It controls to enable/disable IO aware feature for background discard.
 		By default, the value is 1 which indicates IO aware is on.
+
+What:		/sys/fs/f2fs/<disk>/migration_window_granularity
+Date:		September 2024
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Controls migration window granularity of garbage collection on large
+		section. it can control the scanning window granularity for GC migration
+		in a unit of segment, while migration_granularity controls the number
+		of segments which can be migrated at the same turn.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5e4db3ba534a..a00e01e66e08 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1685,6 +1685,8 @@ struct f2fs_sb_info {
 	unsigned int max_victim_search;
 	/* migration granularity of garbage collection, unit: segment */
 	unsigned int migration_granularity;
+	/* migration window granularity of garbage collection, unit: segment */
+	unsigned int migration_window_granularity;
 
 	/*
 	 * for stat information.
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 46e3bc26b78a..5cd316d2102d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1708,24 +1708,34 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	struct blk_plug plug;
 	unsigned int segno = start_segno;
 	unsigned int end_segno = start_segno + SEGS_PER_SEC(sbi);
+	unsigned int sec_end_segno;
 	int seg_freed = 0, migrated = 0;
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
 	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
 	int submitted = 0;
 
-	if (__is_large_section(sbi))
-		end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
+	if (__is_large_section(sbi)) {
+		sec_end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
 
-	/*
-	 * zone-capacity can be less than zone-size in zoned devices,
-	 * resulting in less than expected usable segments in the zone,
-	 * calculate the end segno in the zone which can be garbage collected
-	 */
-	if (f2fs_sb_has_blkzoned(sbi))
-		end_segno -= SEGS_PER_SEC(sbi) -
+		/*
+		 * zone-capacity can be less than zone-size in zoned devices,
+		 * resulting in less than expected usable segments in the zone,
+		 * calculate the end segno in the zone which can be garbage
+		 * collected
+		 */
+		if (f2fs_sb_has_blkzoned(sbi))
+			sec_end_segno -= SEGS_PER_SEC(sbi) -
 					f2fs_usable_segs_in_sec(sbi, segno);
 
+		if (gc_type == BG_GC)
+			end_segno = start_segno +
+				sbi->migration_window_granularity;
+
+		if (end_segno > sec_end_segno)
+			end_segno = sec_end_segno;
+	}
+
 	sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
 
 	/* readahead multi ssa blocks those have contiguous address */
@@ -1803,7 +1813,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 		if (__is_large_section(sbi))
 			sbi->next_victim_seg[gc_type] =
-				(segno + 1 < end_segno) ? segno + 1 : NULL_SEGNO;
+				(segno + 1 < sec_end_segno) ?
+					segno + 1 : NULL_SEGNO;
 skip:
 		f2fs_put_page(sum_page, 0);
 	}
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 55c4ba73362e..245f93663745 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -32,6 +32,7 @@
 
 #define LIMIT_NO_ZONED_GC	60 /* percentage over total user space of no gc for zoned devices */
 #define LIMIT_BOOST_ZONED_GC	25 /* percentage over total user space of boosted gc for zoned devices */
+#define DEF_MIGRATION_WINDOW_GRANULARITY_ZONED	3
 
 #define DEF_GC_FAILED_PINNED_FILES	2048
 #define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ca2101ad918e..7b4908545793 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3791,6 +3791,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
 	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
 	sbi->migration_granularity = SEGS_PER_SEC(sbi);
+	sbi->migration_window_granularity = f2fs_sb_has_blkzoned(sbi) ?
+		DEF_MIGRATION_WINDOW_GRANULARITY_ZONED : SEGS_PER_SEC(sbi);
 	sbi->seq_file_ra_mul = MIN_RA_MUL;
 	sbi->max_fragment_chunk = DEF_FRAGMENT_SIZE;
 	sbi->max_fragment_hole = DEF_FRAGMENT_SIZE;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index fee7ee45ceaa..66d15609d5ad 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -561,6 +561,11 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 	}
 
+	if (!strcmp(a->attr.name, "migration_window_granularity")) {
+		if (t == 0 || t > SEGS_PER_SEC(sbi))
+			return -EINVAL;
+	}
+
 	if (!strcmp(a->attr.name, "gc_urgent")) {
 		if (t == 0) {
 			sbi->gc_mode = GC_NORMAL;
@@ -1001,6 +1006,7 @@ F2FS_SBI_RW_ATTR(gc_pin_file_thresh, gc_pin_file_threshold);
 F2FS_SBI_RW_ATTR(gc_reclaimed_segments, gc_reclaimed_segs);
 F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
 F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
+F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
 F2FS_SBI_GENERAL_RW_ATTR(dir_level);
 #ifdef CONFIG_F2FS_IOSTAT
 F2FS_SBI_GENERAL_RW_ATTR(iostat_enable);
@@ -1140,6 +1146,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(min_ssr_sections),
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(migration_granularity),
+	ATTR_LIST(migration_window_granularity),
 	ATTR_LIST(dir_level),
 	ATTR_LIST(ram_thresh),
 	ATTR_LIST(ra_nid_pages),
-- 
2.46.0.598.g6f2099f65c-goog



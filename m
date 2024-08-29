Return-Path: <linux-kernel+bounces-306651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D6C9641B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1E028BC7B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5391B2EF8;
	Thu, 29 Aug 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MKxaSjVm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234D1B29C3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926861; cv=none; b=NL7Dcdj8r+/edZot6/xsnB3SQ7GP1nXFf0fLPxjsgByC6G6oY67pjiwMOXSOIA6C+H8XvZc1/luZh4fVrblonBVd2asxlNFN+NvoxVym2fo7ydBLKSg9rltt7ILSuwV5DFXiIuLTH+V+CLbQKt6Q8q6KocXlWn3aNLZcPsnxi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926861; c=relaxed/simple;
	bh=40c3l0mWajhxNNgMzb4upe+3sYMx9023oFtW46W0GCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5HqZ++wOhyoGPUWU6wRrlH2SO5SO4ezWWz+mSPckHJDPEK2OkWp/fKQhaVNMDjNX8WxlYhkPXedvXAaFT4bEY5v91pXQapDHpf34c+8u4pHEv9yNsh5Of6ZQ8/j6oBBb1nwICB0WZN0cuH3PJOw78adfAwXElxSaGtMhFTCb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MKxaSjVm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-202318c4f45so4888575ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724926858; x=1725531658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxEuLGuLLlfpVLUQyjdn9XrbJexFuQp9KlY1lBVI+bg=;
        b=MKxaSjVm9BXskdU+F0QHgJeMpDXMoOy5cuUE/88V/jo6ZuAGC4BvgqSMHMRRXu/6uR
         CkYZZXUkfoww6v267HmYa7L7Wan1ohRPznY4vb4xJHosART0Uajn9tbWEmxHJiG1u9ld
         sLGCcdsVlPzyC568FyfEiIvPW2bOLIhhw2I/1uRsfTwoN4ye/yKjYHrMAN4V7DWp/M19
         nDXvZBEa3h2edkM8ZQRDkjuXjjWNJQwL/trBu3S5hpCzSbtjo5mCDqovUOx4TwzitmLB
         XtSasddh5vShMpZXtQQGXl9uS5fOPF+ME2rS3QEbrLLkHIKJzRrotWr3dbdf3gAto90d
         f2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926858; x=1725531658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxEuLGuLLlfpVLUQyjdn9XrbJexFuQp9KlY1lBVI+bg=;
        b=aEA1KtjpCkbxf/Ku9CZDBHXc/Mv7wGhbu0TIS3639jkk2JNGOgf4ytkLubw+H9sG9Q
         9c5Mf5/RA+UPFGRBqMyJoIX63sg9BcpD7A55b+sIALymdrcLSOur5FsNESradaXJl7Q5
         HBbrcwqggztw6ocdyOGLuTpQLnO+s38BxMtN6nJeRfquM/zNBk7mZqNxI4E3D/naw2/0
         RMBiDqBrBXOT2Dt+qUDaGudl2C9/bgLwX5CVPKSgruXJz10ZIG9RG4dZhSVs6XgLMvxx
         5U+BLZyjkfDRzo91Iko0sEX1zWPRcI1YRdFmlxsym1onxMBlTyfdLbfBGthGFKyYqmdJ
         1fPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqs8krhstxwiaSDxZ/qsc0qkplivSl2B0LLTkI28AVMhlsnVEZ3TEvUy/4A4+ExjqX6QMLcK/aeu/Px14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+JoThOPRcUIpfFMaqdHOGxcbMD+5yk2CNeIuYk8BN6yywsba
	F4wGZUfd0bzProU9G978NlGWO7IYnP09ErXoiwibrrfoluyEWQW6ZuKCTBlO44s=
X-Google-Smtp-Source: AGHT+IGiChsduuOeCBhmi3FuNaA5wdY9oxIgLe+AT8c04YtsobEYBqNcPH6TPr9CWLw8iWUvRNwL9g==
X-Received: by 2002:a17:903:8c8:b0:202:3762:ff88 with SMTP id d9443c01a7336-2050c4d2ebbmr33268465ad.63.1724926858195;
        Thu, 29 Aug 2024 03:20:58 -0700 (PDT)
Received: from n37-034-248.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155673a2sm8355725ad.303.2024.08.29.03.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:20:56 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org
Cc: roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	lizefan.x@bytedance.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH 2/2] mm: memcg: add disbale_unmap_file arg to memory.reclaim
Date: Thu, 29 Aug 2024 18:20:39 +0800
Message-Id: <20240829102039.3455842-2-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240829102039.3455842-1-hezhongkun.hzk@bytedance.com>
References: <20240829102039.3455842-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow proactively memory reclaimers to submit an additional
disbale_unmap_file argument to memory.reclaim. This will
skip the mapped file for that reclaim attempt.

For example:

echo "2M disable_unmap_file" > /sys/fs/cgroup/test/memory.reclaim

will perform reclaim on the test cgroup with no mapped file page.

The memory.reclaim is a useful interface. We can carry out proactive
memory reclaim in the user space, which can increase the utilization
rate of memory. In the actual usage scenarios, we found that when
there are sufficient anonymous pages, mapped file pages with a
relatively small proportion would still be reclaimed. This is likely
to cause an increase in refaults and an increase in task delay,
because mapped file pages usually include important executable codes,
data, and shared libraries, etc. According to the verified situation,
if we can skip this part of the memory, the business delay will be reduced.

Even if there are sufficient anonymous pages and a small number of
page cache and mapped file pages, mapped file pages will still be reclaimed.
Here is an example of anonymous pages being sufficient but mapped
file pages still being reclaimed:

cat memory.stat | grep -wE 'anon|file|file_mapped'
anon 3406462976
file 332967936
file_mapped 300302336

echo 1g > memory.reclaim swappiness=200 > memory.reclaim
cat memory.stat | grep -wE 'anon|file|file_mapped'
anon 2613276672
file 52523008
file_mapped 30982144

echo 1g > memory.reclaim swappiness=200 > memory.reclaim
cat memory.stat | grep -wE 'anon|file|file_mapped'
anon 1552130048
file 39759872
file_mapped 20299776

With this patch, the file_mapped pages will be skiped.

echo 1g > memory.reclaim swappiness=200 disable_unmap_file  > memory.reclaim
cat memory.stat | grep -wE 'anon|file|file_mapped'
anon 480059392
file 37978112
file_mapped 20299776

IMO,it is difficult to balance the priorities of various pages in the kernel,
there are too many scenarios to consider. However, for the scenario of proactive
memory reclaim in user space, we can make a simple judgment in this case.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 include/linux/swap.h | 1 +
 mm/memcontrol.c      | 9 +++++++--
 mm/vmscan.c          | 4 ++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ca533b478c21..49df8f3748e8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -409,6 +409,7 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 
 #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
 #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
+#define MEMCG_RECLAIM_DIS_UNMAP_FILE (1 << 3)
 #define MIN_SWAPPINESS 0
 #define MAX_SWAPPINESS 200
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 35431035e782..7b0181553b0c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4282,11 +4282,13 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 
 enum {
 	MEMORY_RECLAIM_SWAPPINESS = 0,
+	MEMORY_RECLAIM_DISABLE_UNMAP_FILE,
 	MEMORY_RECLAIM_NULL,
 };
 
 static const match_table_t tokens = {
 	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
+	{ MEMORY_RECLAIM_DISABLE_UNMAP_FILE, "disable_unmap_file"},
 	{ MEMORY_RECLAIM_NULL, NULL },
 };
 
@@ -4297,7 +4299,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	unsigned long nr_to_reclaim, nr_reclaimed = 0;
 	int swappiness = -1;
-	unsigned int reclaim_options;
+	unsigned int reclaim_options = 0;
 	char *old_buf, *start;
 	substring_t args[MAX_OPT_ARGS];
 
@@ -4320,12 +4322,15 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
 				return -EINVAL;
 			break;
+		case MEMORY_RECLAIM_DISABLE_UNMAP_FILE:
+			reclaim_options = MEMCG_RECLAIM_DIS_UNMAP_FILE;
+			break;
 		default:
 			return -EINVAL;
 		}
 	}
 
-	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
+	reclaim_options	|= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
 	while (nr_reclaimed < nr_to_reclaim) {
 		/* Will converge on zero, but reclaim enforces a minimum */
 		unsigned long batch_size = (nr_to_reclaim - nr_reclaimed) / 4;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 50ac714cba2f..1b58126a8246 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6609,6 +6609,10 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
 	};
+
+	if (reclaim_options & MEMCG_RECLAIM_DIS_UNMAP_FILE)
+		sc.may_unmap &= ~UNMAP_FILE;
+
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
 	 * equal pressure on all the nodes. This is based on the assumption that
-- 
2.20.1



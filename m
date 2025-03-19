Return-Path: <linux-kernel+bounces-567284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0BAA68423
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC64189C276
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DF122489F;
	Wed, 19 Mar 2025 04:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c7lBcP2M"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9BFBA3D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742357750; cv=none; b=IeNiM4suKdeZJ1z8d4LONVGywurc360cLk30uyE9yyvBIjvuF2fgAOWmuTuSSFpf/mwSj7QyO42g8DkBqGyFTAmKeypTlsqCLsLnAnkIqbOPa63p1njarEGWpPjz6XSPxUMkMIMVj67lWS1Of6PkeB9uX70JvmCnSH2i6n+tX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742357750; c=relaxed/simple;
	bh=bvpm/Fqw6i7GAN0MaUq2Ch7MP6ap4jSw6WjnzRhqRGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hwier2acJlb34yYSCF5f9eiTDNKDDeAfGtqC5rfHFYfUWWu2Sz+jVqpq8mXv/NZkV2/r1J+f9r0miYXItHXk0+DpjxI0zC7fk2dZdkL25Oj5XdVp7gHhjEeIGoHTy9v7wmMxr7E/7dTaONnEALN+p2o3cud2IDHyLdCejI5/StM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c7lBcP2M; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso4656573a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742357747; x=1742962547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ofUmcFoXUDulR5CEd/UA152CPLLCw0nV9Au5bxRVUcE=;
        b=c7lBcP2MteCm7ZFjLBuk07V900DjX/m3aoEmG3uYmIoyMF7kSO8w2RFe0e0Qn1yD4+
         3D8N042D0bUuKsE6aiCd2swSjnkEUrf81Ms3X81JcQESP66tCovnjVStrIxq3idXJUlD
         ORtlpFwWue7PSjSwqu+a8sZ6iMMZ/DHq5o2dT1URKticlbNpZUeoq3wxkv86Fvvpf2Op
         Z4R9GATD00DTdc0FOLEnbSSX10C0BgmK0pbss+d/d0IcUKXmRfPV9ddVp315v5cKLRl5
         WYfabrRy/yQBnww5Ttwnh7tQNe8Ctd3xsB6dMUkkNlgcPCvsEep+ARrxpSETjFQ4FZFl
         2bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742357747; x=1742962547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofUmcFoXUDulR5CEd/UA152CPLLCw0nV9Au5bxRVUcE=;
        b=Kve/Cx7dO0LVc1v7WgZcNr1sM+p0IRl3/jXQMphsInWpAxjXLlLmHJSvIVUzgtCOxQ
         fw65p17pSee+jYeQkgVLP/m5JVjOhlsQlGGlz9JxL0hc9ErkxVAgpLautg41f0Fx6c6P
         0RCnSgInUvCYn7FFwUvZBR8wqUGb0ndRbYIYL/4ZOBlirGnwaRhP9HjiJ0mSbXbwcx0U
         SkiWKc0E71yL/Ghqd2Pd+h2DkZJjxFwFvWTkUd+DVaAWb+dIWhypEPciKeQaCO8SDrNQ
         snmiWur42ZYUHYC1QiEYVio5aPcG0c+ebR2mJsRBrxUbd2IBpkee6/znLdVJeb3Fuqj1
         i7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP5PmqksyB3uY3GznaPWVoC6CjFrNYdP7TCUn1/XPcQL9ruEBGlKv7lFaOxd8cWIoDxG3fsCeFJRMT4Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziDDNljgx5H84YipM/IpNSyo0Nj2NgwQgNyHzkUNB78JWS44Mm
	jm8qBQLV79eM8a3+z9v94oCh2iXEZXyxhAL8ZCAF4yLadPMCvN5Zm0iHQTbif8KfcAqp/lD6q96
	w
X-Gm-Gg: ASbGncu9ryfpnuxFjctJgexujetCHs7TOBLS9vfn5mdggJxnvz+FQen94wUg6Qeoapo
	pzHpNTjNFHdWCrCNqw+niAWAwtJfoDoiGPEMb899232neUU2cdy6nBgzP/px23zYIu/WqiHM3xH
	MjPqU3NUTCgTZ6hk2kT0MciC+ByjXQQkYK46Ro5I2rfQH92h69sr6TOw0EXPd58HUkK6sO9LwZe
	6EUNp76hLPh88WvQtXkvu0TY7TmLeF1jV4zVDnEhWYY6MuSN71zLySo8znQAfyW9XF7JvoP0B2R
	0SY7m9RIStaeIug2RfLTifSx1ta2eGEPI+0xZRVQV1XpYTwW2AQaH2nZ6s7rMVlx8L5mAA==
X-Google-Smtp-Source: AGHT+IHoD1by/glIMwNAj++qJ0/prHOI4LYCs/XespnzgESYiHgFgUgG9fcobDB7NU+VAzYmUL8SOQ==
X-Received: by 2002:a17:90b:2541:b0:2ef:19d0:2261 with SMTP id 98e67ed59e1d1-301bdf942f8mr2382662a91.16.1742357747531;
        Tue, 18 Mar 2025 21:15:47 -0700 (PDT)
Received: from n37-069-081.byted.org ([115.190.40.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a44csm404799a91.37.2025.03.18.21.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 21:15:46 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	yuzhao@google.com
Cc: mhocko@suse.com,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH V2] mm: add swappiness=max arg to memory.reclaim for only anon reclaim
Date: Wed, 19 Mar 2025 12:15:36 +0800
Message-Id: <20250319041536.520852-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With this patch 'commit <68cd9050d871> ("mm: add swappiness= arg to
memory.reclaim")', we can submit an additional swappiness=<val> argument
to memory.reclaim. It is very useful because we can dynamically adjust
the reclamation ratio based on the anonymous folios and file folios of
each cgroup. For example,when swappiness is set to 0, we only reclaim
from file folios.

However,we have also encountered a new issue: when swappiness is set to
the MAX_SWAPPINESS, it may still only reclaim file folios.

So, we hope to add a new arg 'swappiness=max' in memory.reclaim where
proactive memory reclaim only reclaims from anonymous folios when
swappiness is set to max. The swappiness semantics from a user
perspective remain unchanged.

For example, something like this:

echo "2M swappiness=max" > /sys/fs/cgroup/memory.reclaim

will perform reclaim on the rootcg with a swappiness setting of 'max' (a
new mode) regardless of the file folios. Users have a more comprehensive
view of the application's memory distribution because there are many
metrics available. For example, if we find that a certain cgroup has a
large number of inactive anon folios, we can reclaim only those and skip
file folios, because with the zram/zswap, the IO tradeoff that
cache_trim_mode or other file first logic is making doesn't hold -
file refaults will cause IO, whereas anon decompression will not.

With this patch, the swappiness argument of memory.reclaim has a new
mode 'max', means reclaiming just from anonymous folios both in traditional
LRU and MGLRU.

Here is the previous discussion:
https://lore.kernel.org/all/20250314033350.1156370-1-hezhongkun.hzk@bytedance.com/
https://lore.kernel.org/all/20250312094337.2296278-1-hezhongkun.hzk@bytedance.com/

Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---

V2:
 Make the code clearer. -- from yosry's suggestions

 Documentation/admin-guide/cgroup-v2.rst | 2 ++
 include/linux/swap.h                    | 4 ++++
 mm/memcontrol.c                         | 5 +++++
 mm/vmscan.c                             | 7 +++++++
 4 files changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index cb1b4e759b7e..254cead74d62 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1343,6 +1343,8 @@ The following nested keys are defined.
 	same semantics as vm.swappiness applied to memcg reclaim with
 	all the existing limitations and potential future extensions.
 
+	Setting swappiness=max exclusively reclaims anonymous memory.
+
   memory.peak
 	A read-write single value file which exists on non-root cgroups.
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index b13b72645db3..60370bf989c8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -419,6 +419,10 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
 #define MIN_SWAPPINESS 0
 #define MAX_SWAPPINESS 200
+
+/* Just recliam from anon folios in proactive memory reclaim */
+#define SWAPPINESS_ANON_ONLY (MAX_SWAPPINESS + 1)
+
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4de6acb9b8ec..2e16d6b52fdd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4291,11 +4291,13 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 
 enum {
 	MEMORY_RECLAIM_SWAPPINESS = 0,
+	MEMORY_RECLAIM_SWAPPINESS_MAX,
 	MEMORY_RECLAIM_NULL,
 };
 
 static const match_table_t tokens = {
 	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
+	{ MEMORY_RECLAIM_SWAPPINESS_MAX, "swappiness=max"},
 	{ MEMORY_RECLAIM_NULL, NULL },
 };
 
@@ -4329,6 +4331,9 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
 				return -EINVAL;
 			break;
+		case MEMORY_RECLAIM_SWAPPINESS_MAX:
+			swappiness = SWAPPINESS_ANON_ONLY;
+			break;
 		default:
 			return -EINVAL;
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c767d71c43d7..08fbb8da773b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2438,6 +2438,13 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 		goto out;
 	}
 
+	/* Proactive reclaim initiated by userspace for anonymous memory only */
+	if (swappiness == SWAPPINESS_ANON_ONLY) {
+		WARN_ON_ONCE(!sc->proactive);
+		scan_balance = SCAN_ANON;
+		goto out;
+	}
+
 	/*
 	 * Do not apply any pressure balancing cleverness when the
 	 * system is close to OOM, scan both anon and file equally
-- 
2.39.5



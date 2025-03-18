Return-Path: <linux-kernel+bounces-566264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F56A675A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B531888C34
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A89320D516;
	Tue, 18 Mar 2025 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eW6X8GPA"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7B420D4EF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306029; cv=none; b=qAB9m5eqlx9w4agkdQssEJ7bjJU0Wm2UFpBFuzM67cphkrxtOOyxrQ7I3MTOapdZj8RBfc6eKK8irdPgpv038LCXxEEAyPLyFDcLonF+MWloG5poPzMph7QciYylpNLm0/qcMisX4qKc5JHs451z8qLcHldgcP6XCy54xW20IeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306029; c=relaxed/simple;
	bh=jYgJzEsVauIxFOObojWYLQKPvLvtLM+ZHhHkvmuSink=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fDgnJVlcKn+GZ5JLU9le8605dRRUoBPDHVs2IU1PfxJgJ5gWN8xVO7t52r/+u+yQSrVj8Ea2gkCKaaNuwhYhO1zetzK8NQq8LUdT2So/P2adW5lCel9wkIA2cQnEsPJpfXvwJUe7pilY8i8nb6aoJcQ6e4jvs2CuKoeU+WfGAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eW6X8GPA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224191d92e4so107632255ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742306020; x=1742910820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5HtI8PjPi7diwCw/mXwfk4KHB1o+8i1IdLEDe1XssI=;
        b=eW6X8GPALlAz0C8cO1MpzTrWR+Zs2o44X8UtxDkH2feWrGlkKONtyCDhi9mseNOCvq
         IM1PNfTeuspAbU8oBUP3YasvPNlGRW2C/olGZ70ZLQT8Mx7EXmWtDRLkpYZk6atBS2qB
         +s2Nkx1diV1mBE9LV+5+fxUADm7E7vmzqJ3oPge2hWxszVUg+QNOpyx8AGQ0ijxz1wt0
         T6U0jHphhPFB6tv5qvgZbVuLnFvFF/yqpcbZJhKpddIwtJgMfT/rBX325zMqTbyjkQl7
         LZIzbYzVx8S1YGmZWt9hYjrom21aMC/jNkkorfrp4mzvI98cCBQETXMJCJPppR2FXtLs
         Ng1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742306020; x=1742910820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5HtI8PjPi7diwCw/mXwfk4KHB1o+8i1IdLEDe1XssI=;
        b=qiKPYzN1heFJ8ilmTHIBtcyrypPj+AgOz8NEQMf9ANPFEqhKP9CJLWbD1zwz86eVJq
         DNXQLEzwVbHTDdjt6/fik0Az8Qtw6jhOZyZbVlO0i3inlj/wjT9ecSpp31NY/399Vird
         glZ0ba7Tl5kZKIscG3+bq0xmwmivCVb4yCBkRBzavnh/n9P8Yqu9Xem3PAtpiAD+XnxY
         FwwowaRfVScJEMH/fRwaNzfLXVvHEQQadIVcTs7aP4+nS+SQXZIUDlJxc31I4wN581i7
         j7xYxlkCdGsgqDVKWqyW2/lva0p3OeskZLORTyl/RoYIJMI3jkfJzOv/vNr00AxJZR33
         dusw==
X-Forwarded-Encrypted: i=1; AJvYcCWZpngPvasWfjtLmSk8ARCwq7ZWdHbKG7udZiIpF3ibheDdZQCDzQeEZzZuWQDF8OeQLHsUgYkobXajjGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/hBd4WpanbxSezzdQdnXGBRX6nEvjeSe6RODoUROFBdI+8Il
	PdmWn9u6sAzwTmem+B4jQccaB3MTXm+fafAE7ywoWos9znVJ6ZfoXT9B8Y6F0u/V+Sb6Pm0JPBr
	k
X-Gm-Gg: ASbGncstmbonu7qdeNngAWNDi0+zWOHWs3noOAdsP9pYo9kjLHUE+GxBgh3RMm6hzpb
	2dp7IQuq08ro5WXoajvAiULs6aJMUj3ZDoX4H/Kf0/VrTZnBt/s6PFC1HcTaukWFObGpxwGvsMN
	ntqfpQqjjWJxj1YzEY7vOmu9gC24ca4omtTi59EOvFoBYXN+cyIzuB+l/yaijSky7s5JS8kJMZ8
	0nRcvuSHxKJPerrAqEKaqhinjrWvAF08+1jjkQETDFJqISxD2wd83fe4koJIwOmrPhuzmB96UKB
	192K3b+P7Plyxly0u4Dhc9vpmULVdIgR/BbBaQpoux0So1X/+HOrpnhd9tJozUS2717NJbMAeby
	+EEsC
X-Google-Smtp-Source: AGHT+IFCJpsyTzvEK8x1goSypoUHMCPpoJCEBdCHWwjyQorzUNgYtOP1dk4bOaTLNY40mECVsbKFRQ==
X-Received: by 2002:a17:902:db04:b0:224:8bd:a482 with SMTP id d9443c01a7336-225e0aa7e06mr169975625ad.25.1742306020577;
        Tue, 18 Mar 2025 06:53:40 -0700 (PDT)
Received: from n37-069-081.byted.org ([115.190.40.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe905sm94166945ad.190.2025.03.18.06.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:53:39 -0700 (PDT)
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
Subject: [PATCH] mm: add swappiness=max arg to memory.reclaim for only anon reclaim
Date: Tue, 18 Mar 2025 21:53:30 +0800
Message-Id: <20250318135330.3358345-1-hezhongkun.hzk@bytedance.com>
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
 Documentation/admin-guide/cgroup-v2.rst |  4 ++++
 include/linux/swap.h                    |  4 ++++
 mm/memcontrol.c                         |  5 +++++
 mm/vmscan.c                             | 10 ++++++++++
 4 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index cb1b4e759b7e..c39ef4314499 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1343,6 +1343,10 @@ The following nested keys are defined.
 	same semantics as vm.swappiness applied to memcg reclaim with
 	all the existing limitations and potential future extensions.
 
+	If set swappiness=max, memory reclamation will exclusively
+	target the anonymous folio list for both traditional LRU and
+	MGLRU reclamation algorithms.
+
   memory.peak
 	A read-write single value file which exists on non-root cgroups.
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index b13b72645db3..a94efac10fe5 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -419,6 +419,10 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
 #define MIN_SWAPPINESS 0
 #define MAX_SWAPPINESS 200
+
+/* Just recliam from anon folios in proactive memory reclaim */
+#define ONLY_ANON_RECLAIM_MODE (MAX_SWAPPINESS + 1)
+
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4de6acb9b8ec..0d0400f141d1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4291,11 +4291,13 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 
 enum {
 	MEMORY_RECLAIM_SWAPPINESS = 0,
+	MEMORY_RECLAIM_ONLY_ANON_MODE,
 	MEMORY_RECLAIM_NULL,
 };
 
 static const match_table_t tokens = {
 	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
+	{ MEMORY_RECLAIM_ONLY_ANON_MODE, "swappiness=max"},
 	{ MEMORY_RECLAIM_NULL, NULL },
 };
 
@@ -4329,6 +4331,9 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
 				return -EINVAL;
 			break;
+		case MEMORY_RECLAIM_ONLY_ANON_MODE:
+			swappiness = ONLY_ANON_RECLAIM_MODE;
+			break;
 		default:
 			return -EINVAL;
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c767d71c43d7..779a9a3cf715 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2438,6 +2438,16 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 		goto out;
 	}
 
+	/*
+	 * Do not bother scanning file folios if the memory reclaim
+	 * invoked by userspace through memory.reclaim and set
+	 * 'swappiness=max'.
+	 */
+	if (sc->proactive && (swappiness == ONLY_ANON_RECLAIM_MODE)) {
+		scan_balance = SCAN_ANON;
+		goto out;
+	}
+
 	/*
 	 * Do not apply any pressure balancing cleverness when the
 	 * system is close to OOM, scan both anon and file equally
-- 
2.39.5



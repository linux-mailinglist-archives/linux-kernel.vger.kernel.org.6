Return-Path: <linux-kernel+bounces-285491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8D2950E21
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67E02844A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6FB1AAE24;
	Tue, 13 Aug 2024 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGWyvTN5"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41521A76D6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582082; cv=none; b=TW34xhMKIPOyfykIbV5gtMqsjC53Gn3NsysgXFfiJA09cT+DiLhvqoy2yU08QbvIShzkK8MMoNU/rMaV3luofDA5TozRY5ksZuulHNxmBkQQVG/0npAvnMgoQzwlqZa4Krqav1ilWco5cffiWtfRUzxcRNz9eEgPCw6spcIqcSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582082; c=relaxed/simple;
	bh=C/e58YefSGLLp6zQAuNfJl8UoPSA34YdN5tmlENHTfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mJmcZ+P+U5gwac5JZ+5khbITQ+a9EDnJX0cD9r2lPRfKgp9yJTlUVNpXGYudCm81+uaLaWDhlbl8/2QXrewJc2/8IZdnLJkWwzKquWZsO3+f7txWdxR9XEPziqYMmVZ9gc5MKBgxaVy+g2G1hkdSLtOao26lUDR1h8zcp7jNA5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGWyvTN5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-721d20a0807so5906712a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723582080; x=1724186880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AL9cOogrL47hO93mBXXtaHX7JJ+ZXjoDFTtox3tfTp8=;
        b=nGWyvTN5wgmjv14RtGZlkBQhlYFXa7BoU7He3DSD1/Cmndzs88VamXDDt97z91vS3z
         ShszqkiPeFfMJkfSITMJFInj0T+bnujAB2w7t5v50vp4QMX068ymxrsyy6s6c8pf/2QO
         ZLD9HMUOje/V7bjdc6vFq3jV7sn0L/RCCYOAl53XeS5n0XFD/NCqPUWBDy7RecnRCmUS
         brcsXM+qMgaAywtBGDS2htBqh/SwVCEUAEa6JHGqUAwSez2UABOGxep/4LI+zf9dnKfh
         22FCRBEfvdIAgrDXoO8E9js+taC7VNed6o0YNuiO6XmGh0lS+xuy4Wb8BduDiez7vgYO
         E+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723582080; x=1724186880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AL9cOogrL47hO93mBXXtaHX7JJ+ZXjoDFTtox3tfTp8=;
        b=vVHGBIqYC58PRnYHi+z5h/WWGyFQC9vO1mnT7i3NGZ04DkE2BDE7+16jASg8jS/Xqa
         jB8C+5S/sxMyvk6Am03c42GrT97LoWZmbi/zCQsh9GB2GHc7caqLTdDSoF4ztfnXAAhw
         Ke0BAcl/8C9dYzjysRLW+N2HB7Bo+1ogEhl67vEAS4nuKa3jVJflqs5r1b8L/DvmUTXb
         QYvMl9Q3x/LIkuTZZPQg7LfC99phAkAF0yPLz9d2XwgxLBgxQMD24ULU/+mwcckmyLsA
         HMkYiYQkOQTtJbJ7WahXt8ljzr3t9h8tvguyJbfKsbnkJUdnFJk+xby6QZYf1gfnfd75
         bGmw==
X-Forwarded-Encrypted: i=1; AJvYcCVrmNpGLEVKOCeYYFAWh31nhEqrV+fiDs93jPPHTC8/Lv3ILS8DcRj+3btpMobZks6VQC2vPFmeYd0BDzrcNTfJ0qo+t2Zozoq54LGF
X-Gm-Message-State: AOJu0YyMf/llgeWXdc/0m4SVcFKhpzUvcVAWF/aGTWxFIT3BJI+Kq34p
	soOmXt4HQ+BElws5YiorwvP6H57QIH/PJvVRx2djCIANMRJhbh2cPT+2YIuuAwplJRNPJLcO1xQ
	gq3dws3ksnA==
X-Google-Smtp-Source: AGHT+IFYKAB9rOjPeQV1OvEWBj+/G0SON71UCsBpqeijGE33YYArHBwlllAogxZUus4RJ93ox/3eY4q8R0h4Eg==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a63:4045:0:b0:77d:336c:a857 with SMTP id
 41be03b00d2f7-7c6a588a314mr766a12.11.1723582080284; Tue, 13 Aug 2024 13:48:00
 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:47:14 +0000
In-Reply-To: <20240813204716.842811-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813204716.842811-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813204716.842811-5-kinseyho@google.com>
Subject: [PATCH mm-unstable v2 4/5] mm: restart if multiple traversals raced
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, if multiple reclaimers raced on the same position, the
reclaimers which detect the race will still reclaim from the same memcg.
Instead, the reclaimers which detect the race should move on to the next
memcg in the hierarchy.

So, in the case where multiple traversals race, jump back to the start
of the mem_cgroup_iter() function to find the next memcg in the
hierarchy to reclaim from.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 include/linux/memcontrol.h |  4 ++--
 mm/memcontrol.c            | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1aaed2f1f6ae..aada9ef3ca44 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -57,7 +57,7 @@ enum memcg_memory_event {
 
 struct mem_cgroup_reclaim_cookie {
 	pg_data_t *pgdat;
-	unsigned int generation;
+	int generation;
 };
 
 #ifdef CONFIG_MEMCG
@@ -77,7 +77,7 @@ struct lruvec_stats;
 struct mem_cgroup_reclaim_iter {
 	struct mem_cgroup __rcu *position;
 	/* scan generation, increased every round-trip */
-	unsigned int generation;
+	atomic_t generation;
 };
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 937b7efc41ca..84de46ece9a9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1025,7 +1025,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 				   struct mem_cgroup_reclaim_cookie *reclaim)
 {
 	struct mem_cgroup_reclaim_iter *iter;
-	struct cgroup_subsys_state *css = NULL;
+	struct cgroup_subsys_state *css;
 	struct mem_cgroup *memcg = NULL;
 	struct mem_cgroup *pos = NULL;
 
@@ -1038,18 +1038,20 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	rcu_read_lock();
 restart:
 	if (reclaim) {
+		int gen;
 		struct mem_cgroup_per_node *mz;
 
 		mz = root->nodeinfo[reclaim->pgdat->node_id];
 		iter = &mz->iter;
+		gen = atomic_read(&iter->generation);
 
 		/*
 		 * On start, join the current reclaim iteration cycle.
 		 * Exit when a concurrent walker completes it.
 		 */
 		if (!prev)
-			reclaim->generation = iter->generation;
-		else if (reclaim->generation != iter->generation)
+			reclaim->generation = gen;
+		else if (reclaim->generation != gen)
 			goto out_unlock;
 
 		pos = rcu_dereference(iter->position);
@@ -1057,8 +1059,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		pos = prev;
 	}
 
-	if (pos)
-		css = &pos->css;
+	css = pos ? &pos->css : NULL;
 
 	for (;;) {
 		css = css_next_descendant_pre(css, &root->css);
@@ -1072,21 +1073,26 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 * and kicking, and don't take an extra reference.
 		 */
 		if (css == &root->css || css_tryget(css)) {
-			memcg = mem_cgroup_from_css(css);
 			break;
 		}
 	}
 
+	memcg = mem_cgroup_from_css(css);
+
 	if (reclaim) {
 		/*
 		 * The position could have already been updated by a competing
 		 * thread, so check that the value hasn't changed since we read
 		 * it to avoid reclaiming from the same cgroup twice.
 		 */
-		(void)cmpxchg(&iter->position, pos, memcg);
+		if (cmpxchg(&iter->position, pos, memcg) != pos) {
+			if (css && css != &root->css)
+				css_put(css);
+			goto restart;
+		}
 
 		if (!memcg) {
-			iter->generation++;
+			atomic_inc(&iter->generation);
 
 			/*
 			 * Reclaimers share the hierarchy walk, and a
-- 
2.46.0.76.ge559c4bf1a-goog



Return-Path: <linux-kernel+bounces-242982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E03E5928FD9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75A6B20EEC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 00:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6ADD2EE;
	Sat,  6 Jul 2024 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6hXgc1E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDFD7483
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720227407; cv=none; b=mB0solAg50QqVn5Xlq/W2pRcUoDPXORe7LYIaY0QPR/sHAKfNr4mSBTQ9DS1R6ju/If6JaiYyWDxG4IreEnFvvzEgdSoJzCn76F8oemUFYF+60uvNz79c07D82V1LyDtt9U3binQ3KK+enkYDRdemzS0B7COdiyYacqzxeTE+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720227407; c=relaxed/simple;
	bh=wwto9Nx1KOq8TXgm3m4jjxC1UDpA6N1LnMFTkOqoff8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VjFKbIGq+imDMtIwSi4sEle4/onMypmgpWsyUYThvD+4gkqNx/no10wUhHK4u5Wlb7bJFSgCZZ+qgzbXrIXLj2hov4EEIVsZhDRIlch/PKt4WRK9rQZGYAP9ammcvGbv/iqHqyv3Ws6HMBBzfHep+7nSSzbhjK7eqzg7WsFuAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6hXgc1E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720227404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITg0RmOa/Ukje0Aga3LKBuosEtPn/Vv8C83AigEih+I=;
	b=b6hXgc1EhAiB2mcMjLpmoEPTFnYZOrgR2rRCGr8+YuQtOytp6AQ3j8KtK2MuFdejJWUTUg
	iS3QOZuDEeXBuCkrkwnTeQFoOuuWcm59Rhlcty3KaJHXVOiUx+j0U3OnUe8X3vMzvcIH0b
	j+TPcFoNjqdlPMR1q7cFa3juE6wlcFk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-dUIBaMa5P26nHX_6jrwTMQ-1; Fri,
 05 Jul 2024 20:56:39 -0400
X-MC-Unique: dUIBaMa5P26nHX_6jrwTMQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 494061956095;
	Sat,  6 Jul 2024 00:56:38 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.212])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B9A83000185;
	Sat,  6 Jul 2024 00:56:36 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 2/2] cgroup: Remove nr_cgrps
Date: Fri,  5 Jul 2024 20:56:22 -0400
Message-Id: <20240706005622.2003606-2-longman@redhat.com>
In-Reply-To: <20240706005622.2003606-1-longman@redhat.com>
References: <20240706005622.2003606-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

With the previous patch, the nr_cgrps field in the cgroup_root structure
is no longer being used. Just remove it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h | 3 ---
 kernel/cgroup/cgroup.c      | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 522ab77f0406..542334bf72df 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -581,9 +581,6 @@ struct cgroup_root {
 	/* must follow cgrp for cgrp->ancestors[0], see above */
 	struct cgroup *cgrp_ancestor_storage;
 
-	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
-	atomic_t nr_cgrps;
-
 	/* Hierarchy-specific flags */
 	unsigned int flags;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4a818192950f..b6854ba702ca 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1327,7 +1327,6 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 
 	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
 
-	BUG_ON(atomic_read(&root->nr_cgrps));
 	BUG_ON(!list_empty(&cgrp->self.children));
 
 	/* Rebind all subsystems back to the default hierarchy */
@@ -2061,7 +2060,6 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 	struct cgroup *cgrp = &root->cgrp;
 
 	INIT_LIST_HEAD_RCU(&root->root_list);
-	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
 
@@ -2159,7 +2157,6 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	spin_unlock_irq(&css_set_lock);
 
 	BUG_ON(!list_empty(&root_cgrp->self.children));
-	BUG_ON(atomic_read(&root->nr_cgrps) != 1);
 
 	ret = 0;
 	goto out;
@@ -5383,7 +5380,6 @@ static void css_free_rwork_fn(struct work_struct *work)
 			css_put(parent);
 	} else {
 		/* cgroup free path */
-		atomic_dec(&cgrp->root->nr_cgrps);
 		if (!cgroup_on_dfl(cgrp))
 			cgroup1_pidlist_destroy_all(cgrp);
 		cancel_work_sync(&cgrp->release_agent_work);
@@ -5693,7 +5689,6 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 
 	/* allocation complete, commit to creation */
 	list_add_tail_rcu(&cgrp->self.sibling, &cgroup_parent(cgrp)->self.children);
-	atomic_inc(&root->nr_cgrps);
 	cgroup_get_live(parent);
 
 	/*
-- 
2.39.3



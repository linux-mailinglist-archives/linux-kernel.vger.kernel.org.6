Return-Path: <linux-kernel+bounces-180005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 799818C68B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08954B23493
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C91428EC;
	Wed, 15 May 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLQbEqrK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92C1422B9
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783489; cv=none; b=BYdsna/ZIhG6nD5s+dPonnhdE0IFE+vXBAKJ5FQ6EtjWToRdnfI+N+zuFw6siVTn2edxX2ZJ892br60wJVTqxokIUYVRNb2ghAcKx1mpoqlk49udnHR4hKZT7OkIQGjCQjAxGrdWetDJntR4g1/gBwyE0vo4k0E3WIsH0ad7E/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783489; c=relaxed/simple;
	bh=knddn969BjEL1cGIM/hhNec75ASOhQ8q9F478YWF4D0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=psaGMC1iAkduBMHt2yGuKnZ9QM6dNYOEVj6NrR+pXb0fJZe/PNrS+JUzU4tTBr82SCStmblwcPz8MgIROSryR5NmTZkiuQ7QZ3nPnE0WiOFR1tfMx7i4Nsstt0TtxdFgHfzFv9poWo1Adw8QV6kDggklP/bDPQfZ673EyhVDdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLQbEqrK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715783485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6D0kM1W2IVqoV/ykSNuolWPIzDpABZdm4eW8Ou5+aG0=;
	b=JLQbEqrKiAj0WZ/uqSyyVfxzkXZ0crbitbdapuTnZ+XvzcE5INLCOjPBAqSRBG+YuGmAo3
	rJR2AcbvuObQgdAwc6wXLiD8OZbt/JJ9i4h0NDh2J0wGQnnmRfqIgnExNgTxqFJ39vrLYZ
	+tRmrnsHgOWO1YC5IBcMQee9RSQi8Lw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-kQSitauyNaqCbg0FNlS48w-1; Wed, 15 May 2024 10:31:24 -0400
X-MC-Unique: kQSitauyNaqCbg0FNlS48w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8110B8016FA;
	Wed, 15 May 2024 14:31:23 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91A67400057;
	Wed, 15 May 2024 14:31:22 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] blk-cgroup: Properly propagate the iostat update up the hierarchy
Date: Wed, 15 May 2024 10:30:59 -0400
Message-Id: <20240515143059.276677-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

During a cgroup_rstat_flush() call, the lowest level of nodes are flushed
first before their parents. Since commit 3b8cc6298724 ("blk-cgroup:
Optimize blkcg_rstat_flush()"), iostat propagation was still done to
the parent. Grandparent, however, may not get the iostat update if the
parent has no blkg_iostat_set queued in its lhead lockless list.

Fix this iostat propagation problem by queuing the parent's global
blkg->iostat into one of its percpu lockless lists to make sure that
the delta will always be propagated up to the grandparent and so on
toward the root blkcg.

Note that successive calls to __blkcg_rstat_flush() are serialized by
the cgroup_rstat_lock. So no special barrier is used in the reading
and writing of blkg->iostat.lqueued.

Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Closes: https://lore.kernel.org/lkml/ZkO6l%2FODzadSgdhC@dschatzberg-fedora-PF3DHTBV/
Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-cgroup.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 059467086b13..2a7624c32a1a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -323,6 +323,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	blkg->q = disk->queue;
 	INIT_LIST_HEAD(&blkg->q_node);
 	blkg->blkcg = blkcg;
+	blkg->iostat.blkg = blkg;
 #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
 	spin_lock_init(&blkg->async_bio_lock);
 	bio_list_init(&blkg->async_bios);
@@ -1025,6 +1026,8 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 		unsigned int seq;
 
 		WRITE_ONCE(bisc->lqueued, false);
+		if (bisc == &blkg->iostat)
+			goto propagate_up; /* propagate up to parent only */
 
 		/* fetch the current per-cpu values */
 		do {
@@ -1034,10 +1037,24 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 
 		blkcg_iostat_update(blkg, &cur, &bisc->last);
 
+propagate_up:
 		/* propagate global delta to parent (unless that's root) */
-		if (parent && parent->parent)
+		if (parent && parent->parent) {
 			blkcg_iostat_update(parent, &blkg->iostat.cur,
 					    &blkg->iostat.last);
+			/*
+			 * Queue parent->iostat to its blkcg's lockless
+			 * list to propagate up to the grandparent if the
+			 * iostat hasn't been queued yet.
+			 */
+			if (!parent->iostat.lqueued) {
+				struct llist_head *plhead;
+
+				plhead = per_cpu_ptr(parent->blkcg->lhead, cpu);
+				llist_add(&parent->iostat.lnode, plhead);
+				parent->iostat.lqueued = true;
+			}
+		}
 	}
 	raw_spin_unlock_irqrestore(&blkg_stat_lock, flags);
 out:
-- 
2.39.3



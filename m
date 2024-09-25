Return-Path: <linux-kernel+bounces-337816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486B8984F52
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83C61F24642
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36986947A;
	Wed, 25 Sep 2024 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT/3ya8K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D554A18
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222788; cv=none; b=kvxheBwblGeErjWrzDi3og9jlB34zQHhkKzRlj4+ApgSflCJli00ioAZHt7QohrqjqkDnb41piW1OI9zMzhpD7GUT+l+7L6KmtzGfWzQqCvityhLc7fqhIGbGZ0ZpWxtmLneGXrjK0Svmp0FAFumbPsBoEdHAxQObXyd9SxNtAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222788; c=relaxed/simple;
	bh=zcUWpDMdMty+C5ghXKqwkj7R0AZXZqexFFnhFavlOGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0fGXG1ZvpeXBEi5MhZkDLT/85eUQSDUBTvP5/BgAr9CCQAfnwC4OWuhLpyiGc9QZmIZkiS4RfzoZ7UH5U98Eoa+fjlqsJMgfqpnXIhoOZkDVEwJhxrf/ZiCw8wfwT7WZdKQninsn7KkGadNCzYTSKNpLzD3zdtPTmCCc3FCCPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT/3ya8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2504C4CEC4;
	Wed, 25 Sep 2024 00:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727222788;
	bh=zcUWpDMdMty+C5ghXKqwkj7R0AZXZqexFFnhFavlOGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mT/3ya8KWywMfuavlzEO/YIsINvppTd5cE+nBZbeH81fYbea+UQuqSpRdZID72JiT
	 fZfOzl59VDN89UgeIkGYZczXWKWl0XdfNin50bTqZTDQLSbCHjLIDLek14pmTKhn5N
	 G4GFevUa7l+TMwWkzhal0f9VvdNVlHievReNp1E03HQax7xAzuE/Hn2JkOUPRf/xUU
	 4HPUh7WrWcBFKQGgWVsj4lxRW5ObU56c8bDYL+X54+8OJTRTUAyRVPza5AvVYIsL9y
	 dMR4V8QVigZLMiBaORFngMze5T92KiBPlUYQbqbR0cG06plXp5jJvTxCFZ3Al9cIna
	 bxxATQMohgw5Q==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] sched_ext: Allow only user DSQs for scx_bpf_consume(), scx_bpf_dsq_nr_queued() and bpf_iter_scx_dsq_new()
Date: Tue, 24 Sep 2024 14:06:04 -1000
Message-ID: <20240925000622.1972325-3-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240925000622.1972325-1-tj@kernel.org>
References: <20240925000622.1972325-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCX_DSQ_GLOBAL is special in that it can't be used as a priority queue and
is consumed implicitly, but all BPF DSQ related kfuncs could be used on it.
SCX_DSQ_GLOBAL will be split per-node for scalability and those operations
won't make sense anymore. Disallow SCX_DSQ_GLOBAL on scx_bpf_consume(),
scx_bpf_dsq_nr_queued() and bpf_iter_scx_dsq_new(). This means that
SCX_DSQ_GLOBAL can only be used as a dispatch target from BPF schedulers.

With scx_flatcg, which was using SCX_DSQ_GLOBAL as the fallback DSQ,
updated, this shouldn't affect any schedulers.

This leaves find_dsq_for_dispatch() the only user of find_non_local_dsq().
Open code and remove find_non_local_dsq().

Signed-off-by: tejun heo <tj@kernel.org>
---
 kernel/sched/ext.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d74d1fe06999..ed2b914c42d1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1808,16 +1808,6 @@ static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
 	return rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
 }
 
-static struct scx_dispatch_q *find_non_local_dsq(u64 dsq_id)
-{
-	lockdep_assert(rcu_read_lock_any_held());
-
-	if (dsq_id == SCX_DSQ_GLOBAL)
-		return &scx_dsq_global;
-	else
-		return find_user_dsq(dsq_id);
-}
-
 static struct scx_dispatch_q *find_dsq_for_dispatch(struct rq *rq, u64 dsq_id,
 						    struct task_struct *p)
 {
@@ -1835,7 +1825,11 @@ static struct scx_dispatch_q *find_dsq_for_dispatch(struct rq *rq, u64 dsq_id,
 		return &cpu_rq(cpu)->scx.local_dsq;
 	}
 
-	dsq = find_non_local_dsq(dsq_id);
+	if (dsq_id == SCX_DSQ_GLOBAL)
+		dsq = &scx_dsq_global;
+	else
+		dsq = find_user_dsq(dsq_id);
+
 	if (unlikely(!dsq)) {
 		scx_ops_error("non-existent DSQ 0x%llx for %s[%d]",
 			      dsq_id, p->comm, p->pid);
@@ -6176,7 +6170,7 @@ __bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
 
 	flush_dispatch_buf(dspc->rq);
 
-	dsq = find_non_local_dsq(dsq_id);
+	dsq = find_user_dsq(dsq_id);
 	if (unlikely(!dsq)) {
 		scx_ops_error("invalid DSQ ID 0x%016llx", dsq_id);
 		return false;
@@ -6497,7 +6491,7 @@ __bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id)
 			goto out;
 		}
 	} else {
-		dsq = find_non_local_dsq(dsq_id);
+		dsq = find_user_dsq(dsq_id);
 		if (dsq) {
 			ret = READ_ONCE(dsq->nr);
 			goto out;
@@ -6546,7 +6540,7 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 	if (flags & ~__SCX_DSQ_ITER_USER_FLAGS)
 		return -EINVAL;
 
-	kit->dsq = find_non_local_dsq(dsq_id);
+	kit->dsq = find_user_dsq(dsq_id);
 	if (!kit->dsq)
 		return -ENOENT;
 
-- 
2.46.0



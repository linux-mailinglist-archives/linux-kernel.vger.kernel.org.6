Return-Path: <linux-kernel+bounces-342280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EB6988D0D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1E42830C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC861B86F7;
	Fri, 27 Sep 2024 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmkgx/xB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8290F1B86E7
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727480924; cv=none; b=Ti8u3/PkzYp8qgRo1jTEGPK9g/ph61GNwZppPjRcXK/wQ7d8jBnql2iVSc5X8/eL0InGl1nN7cEskCk9rq+BtkFsv+mUbnfCsFOKEkefRmXsV/TqzUBSsaRTfhoeF/vQe2w8JFsw0IYwzvVyoIGAWrRT5tG1W6MsScx6SsIxiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727480924; c=relaxed/simple;
	bh=rfMcbOjD3p0NzqaCG839VBhZJT+iayiC/krDS6e2+Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrSVlnbA6IgEXtxsxLi1G36GHL5dWoUhAmfWV8DdeG5K7+nG4ZrOrnf1vWuprnx77voSvQ71lpB0OS9m8cTkP6nveQNJn8jEHafeKY8KdldUrsjttWTf3PlOLygxWtIt/TrRomoK4ROethkZuAJXlD8/dLMXHu6+L3MP5kVwQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmkgx/xB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC18DC4CED3;
	Fri, 27 Sep 2024 23:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727480924;
	bh=rfMcbOjD3p0NzqaCG839VBhZJT+iayiC/krDS6e2+Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cmkgx/xBfU9gz7rfbYOFDG1BI84sYG2ZZe03toE7QP0Ztp0aDAX6+MpXkPAFEN5yp
	 mnhbqzkLIT5hvmXnZhnCfIQJWMZrez7uh7VYa8fEWt8uYCgLY0HV5ZvQ1CNUPq/t3I
	 t/zjQObFw6/iaEtbqToKGI7kDPsfymndMXT63zeSCxqdMjZI3f7ELP9KTcXoVji2Ga
	 cSS7+7p0CpKlNIOEiM/xtf/Fm+1Tun+o80cSKuuR9a4+rL2KDXiSwZpnoi0TFFlmA0
	 czvixQmfXpvYCzD2eqAsvtx/+0HGRJ0AgyI8Q74lf/VvngjKu93At4rM7yFZNzm18Q
	 DSukns8670bdw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>,
	Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Changwoo Min <multics69@gmail.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: [PATCH 3/3] sched_ext, scx_qmap: Add and use SCX_ENQ_CPU_SELECTED
Date: Fri, 27 Sep 2024 13:46:13 -1000
Message-ID: <20240927234838.152112-4-tj@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927234838.152112-1-tj@kernel.org>
References: <20240927234838.152112-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_qmap and other schedulers in the SCX repo are using SCX_ENQ_WAKEUP to
tell whether ops.select_cpu() was called. This is incorrect as
ops.select_cpu() can be skipped in the wakeup path and leads to e.g.
incorrectly skipping direct dispatch for tasks that are bound to a single
CPU.

sched core has been udpated to specify ENQUEUE_RQ_SELECTED if
->select_task_rq() was called. Map it to SCX_ENQ_CPU_SELECTED and update
scx_qmap to test it instead of SCX_ENQ_WAKEUP.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
Cc: Changwoo Min <multics69@gmail.com>
Cc: Andrea Righi <andrea.righi@linux.dev>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 kernel/sched/ext.c             | 1 +
 tools/sched_ext/scx_qmap.bpf.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c09e3dc38c34..9f00c8b629f1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -691,6 +691,7 @@ enum scx_enq_flags {
 	/* expose select ENQUEUE_* flags as enums */
 	SCX_ENQ_WAKEUP		= ENQUEUE_WAKEUP,
 	SCX_ENQ_HEAD		= ENQUEUE_HEAD,
+	SCX_ENQ_CPU_SELECTED	= ENQUEUE_RQ_SELECTED,
 
 	/* high 32bits are SCX specific */
 
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 83c8f54c1e31..588b7dce44fa 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -230,8 +230,8 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
-	/* if !WAKEUP, select_cpu() wasn't called, try direct dispatch */
-	if (!(enq_flags & SCX_ENQ_WAKEUP) &&
+	/* if select_cpu() wasn't called, try direct dispatch */
+	if (!(enq_flags & SCX_ENQ_CPU_SELECTED) &&
 	    (cpu = pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p))) >= 0) {
 		__sync_fetch_and_add(&nr_ddsp_from_enq, 1);
 		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, slice_ns, enq_flags);
-- 
2.46.2



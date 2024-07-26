Return-Path: <linux-kernel+bounces-263778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B8893DA57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7E1282F18
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311A6149C61;
	Fri, 26 Jul 2024 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO0/NdwN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA4158DB1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031050; cv=none; b=iwlOSiVTCREUXsQTEc4qyZ/PKzy1hCwDfJp7wxAZJg+TBLDtCaHbXhKmY4bl7HnLEhvhKWrShkY60bOy+Bwt92l0x9sKVeaw3zgh6p+ioiho2G6ReJUwNmT34aOb/xDl/8PsLMCuby0ueoJwyxpsg9+YP9aaJyTdfsLKXenUk4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031050; c=relaxed/simple;
	bh=SK/q9IX8+ZNrXySOpPmzKAM8VwetiutydeoRgKiyPao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPglzaqX1uQapPOQPUfkpyMAkmYPkbzM8wGxtVfarwuNZIMqTuDajvHwo8L/iPnx4VkbCLlBhx3L6ABEH4XKlQGxQPx+GAJCT8rjaoKBkAnxX9LMAmiPEOKM6GcEmx55RviQ/RfRV4bnpxEP7487+0oxq4rPLoFitDWdQdVy224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO0/NdwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761A4C4AF0B;
	Fri, 26 Jul 2024 21:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031050;
	bh=SK/q9IX8+ZNrXySOpPmzKAM8VwetiutydeoRgKiyPao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SO0/NdwN/p0LhFc6GQDSsoAkHrOK1AZ4NVhXtPK0WK3S0wFaUbiaKLCk8mLAsoRDg
	 hx+/QnEu/B5a9us8RvLBDQWULZkHxWGBnuOiNvaSddVjpzHO9R8HB0UkCX7n7lTFYv
	 yZpzBN5dSrcC/ff4CYI5eixr1jOvUTM9MQj695W0bY50bVcbu27kVqex5imt+D8tcq
	 riPVU+ELznNnKXaq8c++ix4NVQmH2cI/XKbZ/Gf38VrbOsc9rIB2XisvpJvbhP5Hry
	 9EurUTVlYH3LVpeVZVEcoCg5TItRMAU/A/zO1kAG6V0h7T++Mu/Ai0w3RW2rL874Et
	 wdOAxu1C0M+4A==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 10/20] net: pktgen: Use kthread_create_on_node()
Date: Fri, 26 Jul 2024 23:56:46 +0200
Message-ID: <20240726215701.19459-11-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726215701.19459-1-frederic@kernel.org>
References: <20240726215701.19459-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the proper API instead of open coding it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 net/core/pktgen.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index ea55a758a475..b80b2704588c 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3883,17 +3883,14 @@ static int __net_init pktgen_create_thread(int cpu, struct pktgen_net *pn)
 	list_add_tail(&t->th_list, &pn->pktgen_threads);
 	init_completion(&t->start_done);
 
-	p = kthread_create_on_node(pktgen_thread_worker,
-				   t,
-				   cpu_to_node(cpu),
-				   "kpktgend_%d", cpu);
+	p = kthread_create_on_cpu(pktgen_thread_worker, t, cpu, "kpktgend_%d");
 	if (IS_ERR(p)) {
 		pr_err("kthread_create_on_node() failed for cpu %d\n", t->cpu);
 		list_del(&t->th_list);
 		kfree(t);
 		return PTR_ERR(p);
 	}
-	kthread_bind(p, cpu);
+
 	t->tsk = p;
 
 	pe = proc_create_data(t->tsk->comm, 0600, pn->proc_dir,
-- 
2.45.2



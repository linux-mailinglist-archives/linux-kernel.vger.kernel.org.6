Return-Path: <linux-kernel+bounces-278220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3641A94AD90
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BF0282BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8D1428F3;
	Wed,  7 Aug 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0tqa4vR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632BF1422BF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046583; cv=none; b=X+HtGn+iyZBuMIKzV+RWKP4OTVgWws1AK9ollF2xwnoeiBxLvtTw1rB+fTZj1PFPuh/sx/XxRDsAkhNef3z319SvOcjJ3JekkcQa4lRawRD2SPHo+7HmBEHjcZHDkbDSQe5mBOBsk5dP71PW8gNL28SV8iKls5k+oWFq1sfTHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046583; c=relaxed/simple;
	bh=SK/q9IX8+ZNrXySOpPmzKAM8VwetiutydeoRgKiyPao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYaojNr1D/reCmQEoRwn43CEw2LfHF3fl0xBLw6K41KIWowIfitasQOWKs2BhcgWUOEQucf0/LuENa1sKKEDHN2DCxxn8yNRHfuZbLELsPt3H2qd6xdhJZ0XMOzxzhbJyrR01ATH/krIDaJTKmf6WnjtSDWzaPJrZzyqa+/1aCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0tqa4vR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7BDC4AF0D;
	Wed,  7 Aug 2024 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046583;
	bh=SK/q9IX8+ZNrXySOpPmzKAM8VwetiutydeoRgKiyPao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0tqa4vREUqleGdV5pz1r+3P8GP3DGNCYbuiIbQoCnqf8v7lCCPwF8WzdJXttqRnD
	 jiZer64nx31xK+LJfvcwyZV8TEqXi12vnJOTri7FSJI5yxJDy6Qp5jvKo1RXkH05FA
	 R1wQkE1/FP6a4ktvGL/JxmVaPfVwcceMmp6aLks8JR1CbSM9QAyGyxA/M3WvD87bI6
	 yGefvdko26oXnAA+UtM1oRww+601YYqnKrfnAkJNSL+9fbioWnDF6B673/op8BPSxA
	 R7i1+mwAfCx3fDOof7NkFbUKL1BRxoK9wM9gBAoWHhKaFUnCQWYOI/BYH9lkrW7Nm6
	 791Wkwsp4bmJQ==
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
Subject: [PATCH 10/19] net: pktgen: Use kthread_create_on_node()
Date: Wed,  7 Aug 2024 18:02:16 +0200
Message-ID: <20240807160228.26206-11-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807160228.26206-1-frederic@kernel.org>
References: <20240807160228.26206-1-frederic@kernel.org>
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



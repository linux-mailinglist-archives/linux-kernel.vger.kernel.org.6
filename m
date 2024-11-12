Return-Path: <linux-kernel+bounces-406027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812179C5A39
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4744E285068
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3320013C;
	Tue, 12 Nov 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPQH5N8I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829920013B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421399; cv=none; b=fhbtr7YSSk/c+mEin937Z+BSh2mAd8cG13xnOnqb4wUZMqmakARC3TkiMESRHdkMByLfTfSilvTVRWGguiKZf5xsQcVW4QgyW9ySgYtifPaG6bWTv6mjIkHDJvUFgbq4ydcXViKubULUaDH1k3DSl41oztlbD265RGf53NI02FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421399; c=relaxed/simple;
	bh=V4HVzsI+XMBJjkzp/89Y6/G2AOKzwT5yoss94xIGubM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6y0+we2V9T53ivpUKwlPoaKeJwdLgu5E8cEPE86bigxdznbdvJwx8c9UnWStxPkxkJCnXpSqs25Hlktqa81t20VQSAK14TDNtJuUCmals+7wnjf68d7vNirhRBuHkpB/s4Kt1/in+8PIdiysDunl/KJL0EzahmbNCpFnL25kMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPQH5N8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46601C4CECD;
	Tue, 12 Nov 2024 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421399;
	bh=V4HVzsI+XMBJjkzp/89Y6/G2AOKzwT5yoss94xIGubM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPQH5N8I/Z7BgUgEyRBcG0VTrNB3Mrr1sgfqJbXoS12d4+OMCtKP3Yc40ux1ubuND
	 oIwCsfD/vCq+fhdZ2Bn/O/6ndTaaiDyGNlETWgCGxYmEnkfrADU/koReAob2NZToEZ
	 Umva1zrkOHHjTRKqEKZrXqvE4ZWbLlViHIN64+gLmNbPC9kFYMv9QerJX3cIOkhoWC
	 haFu4siYeua4GYRiBryiii97WcweInmihKQSOFxGGjuAsW1rTpAoAi66KCJzWq8gcN
	 e0YtloLUowBBiUNKdBqfAuqFxwyqKcHqWLgh38dQmQpW02snIg82B5HMsjl5xf70tH
	 f4nsn9vsWnVlQ==
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
Subject: [PATCH 10/21] net: pktgen: Use kthread_create_on_cpu()
Date: Tue, 12 Nov 2024 15:22:34 +0100
Message-ID: <20241112142248.20503-11-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112142248.20503-1-frederic@kernel.org>
References: <20241112142248.20503-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the proper API instead of open coding it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/pktgen.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 34f68ef74b8f..7fcb4fc7a5d6 100644
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
2.46.0



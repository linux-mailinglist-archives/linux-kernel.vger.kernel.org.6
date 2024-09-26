Return-Path: <linux-kernel+bounces-341093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F86987B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B681C231A5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2941B250A;
	Thu, 26 Sep 2024 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI0uI4kM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6786C1B1D7B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390978; cv=none; b=Wnpb7cwdgN52ekrNqR7nBf9rTFpDbljzyLUye/OpbiANCm/60/huM14NwBGdGsLGo21JyEnziF/qI4Y+A5JXcs3QOrTY1xtnFbjxsu23yX3vS9OmFYGvdzemo1d7ASFjPsruZes7QDBfFIgU8STO31czrOIFCLIDhiQVB/nyk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390978; c=relaxed/simple;
	bh=gUr/DwSlgazKo3bDvjslR9a806r1mqijOu77KKoOn+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiUogZ3LpGy9S1upQqG7ydKe1dD/p29fX4EUuGu+feduV0vGEmoMB9ikeeCknwNqaF9QAzry5+3ZXU3JI/bVjAMeZ4tcwGrEkTwewV6OB3edzSsEO8SfD3hTkO1ULs3naHckD/ndEoTSqTRGJ5BMh1gwai15gVxJLZfhfPEAYXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI0uI4kM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B1FC4CEC5;
	Thu, 26 Sep 2024 22:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390978;
	bh=gUr/DwSlgazKo3bDvjslR9a806r1mqijOu77KKoOn+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PI0uI4kME+DTI8MIVSdNq38EBh3qQ9TTcYVDw0KXx3n4nL25xmce6HsrwNwdw9OCL
	 aLgS5keF+hY4D96b7UQkcg/Rvsj/+9h9jei+GivK3vskF9Lf50mS66/C2xHHzhunAM
	 uPdqkbLimEipNPnlVnNjtPrzXosDJBfl5t6JjvdJ24MKVGg0aiCZ0swPFfXUKAN5oS
	 sutl4UKqQ6wOJNKxm6yibHyi4z1Pdamj38pO5+HNORfjnYBJtzJqgOcmbu6lCr7iDC
	 /dOCEiiQDQ/F+AFgGgpq1ZLG1bmSSW17sZt8wmESR1J5lHAPpNJ/gwrAaQmQlawUlY
	 UunnRHaSsfqow==
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
Date: Fri, 27 Sep 2024 00:48:58 +0200
Message-ID: <20240926224910.11106-11-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926224910.11106-1-frederic@kernel.org>
References: <20240926224910.11106-1-frederic@kernel.org>
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



Return-Path: <linux-kernel+bounces-331176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2291697A961
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555391C2705B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3926E18952E;
	Mon, 16 Sep 2024 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k50xj4ss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB361891B9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526999; cv=none; b=CZlK37fzfXMEGGRF/iVqKtjDnm7khU2hYS5q7+gB12SoqGl307UZMG6QFQjfJQhgYyGKaHXn9l3KyW7Bg3ChZtom5sgGaqSIL8Ks9ra7FdEI0QPrZC5lzL0fuS2pqufIImh6ymnoBIkR5jaH9NRI+hq/0vprkIZxXeEwRLuLpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526999; c=relaxed/simple;
	bh=p/q0EU8DcqVLYtmwEd+ypSMBsQxYazAACPSnm1FO+Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i41Ya6c4k/PiuPNDyl7rkKHeC+6f/IEn9gazBoXObEv5zhwTMqiZ2RhiATlzgw+jLGsobFDsP0yytCZZZwzWK/3qxaynbgZv6uxJ/nRokExBCjUdRXFTQMytC1k2MTeq6Zpf0Zms+lHwlaJ6F2JZmpkaL8B7sH/xXqJfPbsOvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k50xj4ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64843C4CEC5;
	Mon, 16 Sep 2024 22:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726526999;
	bh=p/q0EU8DcqVLYtmwEd+ypSMBsQxYazAACPSnm1FO+Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k50xj4sszX/tnOTuGB7qZJzCMkel38bEGF0zMnx4DfiMi7GrPwvVf94CO+zHZfZ/f
	 Dx2bdZukA2MC45mWYoLGjQ2CeQKTuMIkOGqwkvwXQ73CF86QfMOu7jaecRrKtQqMYS
	 MCKYVObv16CTM4ELxHH0NbV86otfW1X3KqoTd/koujbE+O1m51KJ5nxoCLMEfwyH02
	 DNQjnQymfhY26lMlxYFDuKrKwPiR4Bj15X0Tsm0MUe8ydoJi7BRSTz3yAAIvfPbM+E
	 KbIxKP9J+Quz6qbgU2IFxR8QeMeSp/sXaLjcKQNazgmPC4FX9C6HXwUKLiuvf5QKDL
	 Wmi8Lki5d7Tvg==
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
Date: Tue, 17 Sep 2024 00:49:14 +0200
Message-ID: <20240916224925.20540-11-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916224925.20540-1-frederic@kernel.org>
References: <20240916224925.20540-1-frederic@kernel.org>
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
index 197a50ef8e2e..4312692c490c 100644
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



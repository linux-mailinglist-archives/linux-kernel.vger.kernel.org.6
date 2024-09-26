Return-Path: <linux-kernel+bounces-341090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301AB987B47
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E961F22294
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A81B1501;
	Thu, 26 Sep 2024 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDZdbpy4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D31B14F8
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390973; cv=none; b=g1q6NMQah5WMxZaLP5xl2Lgj0rDjGiVxqi2QWlf1a2EEJxZC8+N3DFsh36od6kYy3yHWgeQGKcuPIMAXOleXEvn8+zeT7Bd3jGxnKJJTUPKSwWezA67B5TIPLy20n+SsvgaIgskgoCp3QwkzzaqM8hjLTxJ0HmcD9xD6W1ScPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390973; c=relaxed/simple;
	bh=bRL09e91cC7LQEEs/ysPp5d5gcrpXYKGy36AOC6GrXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQfwhCSWLLRszjj2Zk6J/B7RYPBle4mkKfFIQ9eZD3KzpjjJyqxfzTeuKnPdDLN9kfLXUv7gq993z46XRBfU96ZL8MNINa/is5Djnaw0Z7iCwp6/ajWlQyrC3DOVYCVWYRmy8plrUOYq5P8OqY39eNtmvka7B0zDwubXh6L/jNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDZdbpy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5459C4CEC5;
	Thu, 26 Sep 2024 22:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390972;
	bh=bRL09e91cC7LQEEs/ysPp5d5gcrpXYKGy36AOC6GrXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDZdbpy4WqqifeDkegM8x1sVTl+yI6iQ0P8bBrCuvgR1jYI1u6GHF6NzZa0ERvibI
	 cAkhHAH8POAjsMrWv8dUzeYrp7H2lW1xLce+GVcY0pLcxBKiCOZ2QSeSYanU76SraB
	 IZBNevGY31bNGdaOCTyF2PZz+cIa9D1f+oAxxrdyywwWBtq2xFfddeIVVA5tdgy2VB
	 5VbETBCp8ypSUyBL5sVZzchrOvhIngYb38QGkAPgQs55AXjpxGQybbuhvuMqpZnC3Q
	 xS+tZyEcX27kdmIVc/JQekudFEh4jPBZBZemzhpPuY/XXDC1dD7CiBeQ6fdw/enqkP
	 hUzv6Z71aJMOA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/20] soc/qman: test: Use kthread_run_on_cpu()
Date: Fri, 27 Sep 2024 00:48:55 +0200
Message-ID: <20240926224910.11106-8-frederic@kernel.org>
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

However it looks like kthreads here could be replaced by the use of a
per-cpu workqueue instead.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/soc/fsl/qbman/qman_test_stash.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman_test_stash.c b/drivers/soc/fsl/qbman/qman_test_stash.c
index b7e8e5ec884c..f4d3c2146f4f 100644
--- a/drivers/soc/fsl/qbman/qman_test_stash.c
+++ b/drivers/soc/fsl/qbman/qman_test_stash.c
@@ -108,14 +108,12 @@ static int on_all_cpus(int (*fn)(void))
 			.fn = fn,
 			.started = ATOMIC_INIT(0)
 		};
-		struct task_struct *k = kthread_create(bstrap_fn, &bstrap,
-			"hotpotato%d", cpu);
+		struct task_struct *k = kthread_run_on_cpu(bstrap_fn, &bstrap,
+							   cpu, "hotpotato%d");
 		int ret;
 
 		if (IS_ERR(k))
 			return -ENOMEM;
-		kthread_bind(k, cpu);
-		wake_up_process(k);
 		/*
 		 * If we call kthread_stop() before the "wake up" has had an
 		 * effect, then the thread may exit with -EINTR without ever
-- 
2.46.0



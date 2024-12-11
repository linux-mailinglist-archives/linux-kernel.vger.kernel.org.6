Return-Path: <linux-kernel+bounces-441548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF4C9ED00B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B1F284679
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052631DD0F6;
	Wed, 11 Dec 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TstP/GWE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF231DBB36
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931655; cv=none; b=n2/i0f6jI321d89YVqhjjncN6pQ/ROw75lBW+ZoueT/hTN9bKap9w7x2nQUlRr9U1rBEPyc/qUe3+8tkwhXvRb50tAA4k1j+MfE5eJ4rtjIv3Mr4SEjK4cRRA9UocdhxJjgneG+hZfzStGhqpvTZrDvOjGqs9T5vKjbjynV2Hd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931655; c=relaxed/simple;
	bh=bRL09e91cC7LQEEs/ysPp5d5gcrpXYKGy36AOC6GrXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzZcIEhyVUum2QdYYpTf0KZL2sSyFZRQEsVjMlY6WofPSZ1rP6jSnGnOYV6Dg2x6GQjf47SQJplSmM6tzNnb7repNbJ4H5u4vA5hCKFwGeQywcOyvwRD1d64DK1APq37iukX/0oJe/X38DJe5hZ8dA4O+l3WW7+uT8BEu3bDLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TstP/GWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CB5C4CEDD;
	Wed, 11 Dec 2024 15:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931655;
	bh=bRL09e91cC7LQEEs/ysPp5d5gcrpXYKGy36AOC6GrXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TstP/GWESXn5mz/0JLh0l91WVzrEpldhSPLVjcRZOfjfaRBDoQ8RiIEfowR2lsWYP
	 Rko9njDUpHK9O0sihWEULI9jWZm23b2vp96tZd/4UyoJS7EsbQkVaaTRV7pe9i+Hrd
	 U3tMzhk106Tzqdus4BlDa0GMqaCbt9XBQnmxobIj/KYKQ05j/VUN3wXUKpQq2jiJcE
	 kv/NySaaTLJK2HNg60sQ6d9PdiccerfOMOEzO2o3eIpk2zbXu6cCpQczNiRUreZ+s6
	 zE02REc6cCuTFtf8LgRrk/iKbFiA+It8XsPAeMmG5yzR5Ghdg4JVIpmZyfJCraMiGj
	 pYmVUTjqndtwQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 06/19] soc/qman: test: Use kthread_run_on_cpu()
Date: Wed, 11 Dec 2024 16:40:19 +0100
Message-ID: <20241211154035.75565-7-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211154035.75565-1-frederic@kernel.org>
References: <20241211154035.75565-1-frederic@kernel.org>
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



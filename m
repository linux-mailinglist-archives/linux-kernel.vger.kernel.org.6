Return-Path: <linux-kernel+bounces-263775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E990C93DA55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927751F22A74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B289156257;
	Fri, 26 Jul 2024 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7xB+7B/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8D156230
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031045; cv=none; b=HehfR8k1Mhsdf6nB34JibmzUwsjVWTSOqDAk03ASBQJYsrBX6QYSUmBvGXoFAyuEVJC/4DpEgLgiQPvpiR22wVL0bKHVsBbuSvFsfcJlIrhICzueQoRstRNmQGPwBZWuHf44ON5W5VRsFiOuMlvSoH9yTQPczxYxcQg6y66sVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031045; c=relaxed/simple;
	bh=KUPM3WCD3VyrnlEzvVZNfdnolRYrDWJJnT+Gw+3b/Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAb7t/OdUIv7A/PG9ctKsspibnnnZKG87r8p5m9B/adiT5xc6JT+S7/6qat23q9nnb+JQ3z4RoidL7b9Hm1W8vm7vxkHIWHGjfBwZMYQsb2Oq2c993mk2LMgxj+8Lm+HFIj88vA5SrNZyubuyWldF8sdM+kjFghu2gCfa+P+ZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7xB+7B/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD7DC32782;
	Fri, 26 Jul 2024 21:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031043;
	bh=KUPM3WCD3VyrnlEzvVZNfdnolRYrDWJJnT+Gw+3b/Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N7xB+7B/CH4lSoIo1HiT1+qTw9+wJAq2aSmIP4N16GSjzvi0SjpcTz5sP6DpJW1wX
	 0R2Zca1ViPmS+tA6juWFZXdZjfCQySN6tiP8mUQBt4qHUW/bsGpM2wPYtzHZUJfTjI
	 94ufFxgWH75hz2XPhPW1jFo11kvE8NfxhhVtD1sz0BipYnRxAyaPhep6lo+gGFA3Pn
	 dhQrORpQbR8HWfJKOAGov3x+mfuNNyA7vUw+VIKIOHU0fs2beU/nbCK+7VlXlcaUit
	 em3uNRgRk/Z/c+P9tGsgNWCX3FgzXXL4SkJGytmJUVqdwLuFJrTaHBPwuBjM/IXOjN
	 48KIpB6oKmnfw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/20] soc/qman: test: Use kthread_run_on_cpu()
Date: Fri, 26 Jul 2024 23:56:43 +0200
Message-ID: <20240726215701.19459-8-frederic@kernel.org>
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
2.45.2



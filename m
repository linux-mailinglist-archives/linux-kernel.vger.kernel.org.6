Return-Path: <linux-kernel+bounces-331173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AB097A95E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6AA28BF4E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CA1185B52;
	Mon, 16 Sep 2024 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1Xe10Sj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22031184526
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526993; cv=none; b=plJmsBdsyZwiNzoJ3WPLssBgRYc+RgYCHfAHlTparRVHqVFiaOi+wUyU+PUM3/sfLXnuZmVCvZEKn5OFcIEkOH0l0aNr8LdJLZS70QyrgVG/HlUrTSfDPzzX9v2halNzN6QDOTSwaeFXTgVEW5om2IWJbJV9MEJPH1Qva2kA2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526993; c=relaxed/simple;
	bh=bRL09e91cC7LQEEs/ysPp5d5gcrpXYKGy36AOC6GrXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHSaAhYuEHYK8of6h5nAqxniVIkdK7YF1U637OFYMLrvLLyLx79vzFQQ0O/UxiSFRHAKph4VOAsqzLdeXVKRPNmuZEkJutF6tze4YBzy4RYZpdXN578v7BHWybukZmCHGqKBNGThoTK33M7i+Wl+o2VRSBZogtZs2o1EYt+bdzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1Xe10Sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31DFC4CEC4;
	Mon, 16 Sep 2024 22:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726526992;
	bh=bRL09e91cC7LQEEs/ysPp5d5gcrpXYKGy36AOC6GrXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1Xe10SjRDFp1Tnjo4rEV1qSSh5I/fFYmkJvMjVN/tBBFXbHuDqfW2ZKpbL9bTGkv
	 U7tz8C47kArBx6KohU4yk94kVLrNEyfFFoMtu3sI1rGeB601xnuvrdFUb86o5jzxaw
	 pXK9Bd6V1qDtIWeD9jqJCTq9qnaq9XQo//DpeB/mhKF+NNXs+gr/abL/4fyQmiGxSq
	 mF4B31rqHLk0PajC+YeepD7dpn398dZY0XD8DZ9EJZmJhGVNOybAq569O4+8DOqx4+
	 6VPjKNaq3VbbLRUMck9HsrMHITLQNGh6AadX2R8FQiIm+M39JtECZI8lyhca0jGq8O
	 B0iU4+iN5HyLQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/19] soc/qman: test: Use kthread_run_on_cpu()
Date: Tue, 17 Sep 2024 00:49:11 +0200
Message-ID: <20240916224925.20540-8-frederic@kernel.org>
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



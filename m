Return-Path: <linux-kernel+bounces-278217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CA494AD8E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12C21F22CDA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053A713774B;
	Wed,  7 Aug 2024 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxgdW86V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6E13DB99
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046577; cv=none; b=ekmmgOGcljpnn/UAsIZEFfKMimU40HQqSppQHcHOOOUld6TmdAR5nXLd2GVR4038q4IGUc1F7JA/QS0CGhoPIPf5EDLg3wfeJfrVZu+AAsJH3MNxJEV5aQ+2Pr4BYMsz+T49BpJ7avPLl6zHyw4I+6U35+CjPlssnvdJakFbYcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046577; c=relaxed/simple;
	bh=KUPM3WCD3VyrnlEzvVZNfdnolRYrDWJJnT+Gw+3b/Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GY2zQ31m5MJn69ph8BJDejGUXYQDCItrKggn7VA7WtN0L0KW+DP7GdVPTlrcXQ4utwuDpTjPMCE/13bWf+WVFdLwzewefx/l0doTdhgEddrWwvJUfV1lVtYtTUqveHKUJ48CCOT4MN0z3jpMZwEvJRm08Q0IlGDpd0WkNM29azk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxgdW86V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77541C4AF0D;
	Wed,  7 Aug 2024 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046577;
	bh=KUPM3WCD3VyrnlEzvVZNfdnolRYrDWJJnT+Gw+3b/Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hxgdW86VQjHpSGHUf98BWxrZRkD06R6Ccu0cv6cOX9CckYr5DL6WgCHyUJPITgw1u
	 GOMp68XGvI7fa0AuF88644G5HoAo+GwSKJcZk7fSrHsuuIbc6P2c4iVx/DAmdajH8M
	 usbOEnUEt/Kns2x6r3YPU5krR83VwF4izoG6zusRFlvlIZUZQYhGFmtVJHHSeauKWr
	 ORcjrgt8H/gBJmRX1776nfNMVHWqyrwVMqVZdpAf51nkrhB3e7oGlPIZutgYstmY0n
	 nU3uBXr0XgyGJCWkXNs+qgL+yUYFjWfl+t1ACXpOJU7P+M3PGYiYpxk6nvplPijJZQ
	 NFd/CUyO3Ic+w==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/19] soc/qman: test: Use kthread_run_on_cpu()
Date: Wed,  7 Aug 2024 18:02:13 +0200
Message-ID: <20240807160228.26206-8-frederic@kernel.org>
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



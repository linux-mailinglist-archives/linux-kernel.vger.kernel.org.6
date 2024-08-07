Return-Path: <linux-kernel+bounces-278219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C01F94AD8F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B92D1C21CDB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784BC13FD69;
	Wed,  7 Aug 2024 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lsip8N2k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4313EFEE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046580; cv=none; b=idbwsFWkKT5n67u8LU2wnXKvvBGWFsYyy1T124Cb/tY3MkYREkQMLW6OT1k2GeuOd6y7CRxKfUYMg4EcccY74TSna8pd0ShtwDKCEd7ZLtRwITDkGJiXxV9TukmOaA40idxJ4KgS1kLkQP/yMTLKhemCh6kgsHd4H9vObaQz98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046580; c=relaxed/simple;
	bh=IZ4smXEyGOpkoZrnK52T7YfinkiKMtD7c8oxd58z+nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfBPP5NCC99/qyW6WSSXjexLXnabwihJ+ynb0ZPLpGIm/dsOvjGMwrPWjo3gFbTJlbsF9IK9zZ4pYjY670hRAxNNv7Yx+hrFPaENo/D62Yfq+d3amNxKq45t96URm2Tk8hdGNqlJMvHdvvWUw6WfyC4P2xiSrD7F0tkCRfoibyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lsip8N2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55919C4AF0D;
	Wed,  7 Aug 2024 16:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046580;
	bh=IZ4smXEyGOpkoZrnK52T7YfinkiKMtD7c8oxd58z+nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lsip8N2kZ07omQeUo/lKqpJqsGTgwWkp4/Cx3XDdhccdQJyn418EyG01hU5PlOcM1
	 wqvCEjGsgMB7ezYKwZIdLt/i0lXIM2LC5mwrQn5uqlyQCnWk8q3AnsHFGescIYoboD
	 NU2xc84MKZkVolsCWnUD0uESK/asd3LmDUyzOjVNXm1GFWq/DEsMHGXBf0rt0VibRA
	 mwJsL9EoeBNDwtMNtdhl6IyZUU87nVGhqKa60U4/X255/mcgAfeNiHCmiNO/vSuypv
	 q8EKW6Q8Vge8p/feF7ShaJwWzMSxjuexeoVZ7EgT+kjOWrdIms7Cz/7PjT7KgQm5uT
	 oTJKVKYL9noYw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 09/19] lib: test_objpool: Use kthread_run_on_cpu()
Date: Wed,  7 Aug 2024 18:02:15 +0200
Message-ID: <20240807160228.26206-10-frederic@kernel.org>
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
 lib/test_objpool.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/lib/test_objpool.c b/lib/test_objpool.c
index bfdb81599832..2c09dd91e731 100644
--- a/lib/test_objpool.c
+++ b/lib/test_objpool.c
@@ -371,14 +371,10 @@ static int ot_start_sync(struct ot_test *test)
 		if (!cpu_online(cpu))
 			continue;
 
-		work = kthread_create_on_node(ot_thread_worker, item,
-				cpu_to_node(cpu), "ot_worker_%d", cpu);
-		if (IS_ERR(work)) {
+		work = kthread_run_on_cpu(ot_thread_worker, item,
+					  cpu, "ot_worker_%d");
+		if (IS_ERR(work))
 			pr_err("failed to create thread for cpu %d\n", cpu);
-		} else {
-			kthread_bind(work, cpu);
-			wake_up_process(work);
-		}
 	}
 
 	/* wait a while to make sure all threads waiting at start line */
@@ -562,14 +558,9 @@ static int ot_start_async(struct ot_test *test)
 		if (!cpu_online(cpu))
 			continue;
 
-		work = kthread_create_on_node(ot_thread_worker, item,
-				cpu_to_node(cpu), "ot_worker_%d", cpu);
-		if (IS_ERR(work)) {
+		work = kthread_run_on_cpu(ot_thread_worker, item, cpu, "ot_worker_%d");
+		if (IS_ERR(work))
 			pr_err("failed to create thread for cpu %d\n", cpu);
-		} else {
-			kthread_bind(work, cpu);
-			wake_up_process(work);
-		}
 	}
 
 	/* wait a while to make sure all threads waiting at start line */
-- 
2.45.2



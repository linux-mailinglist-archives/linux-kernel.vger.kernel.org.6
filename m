Return-Path: <linux-kernel+bounces-331175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D497A960
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270DE1C24C56
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D2E188A0B;
	Mon, 16 Sep 2024 22:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb+VYvmy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF52188A25
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526998; cv=none; b=cLyJDQxOkYe0/op9Y5N/9JNmWGWpe6nxV5Mj42WVznbUwTPsgxpE/vL3t45x+GOLo3KMyfItHC+OdrKz6TapPKaYTjuKLWvYSJZLWAkbwJGSDrAWTyRgRYl796ap/sCZWDtvie5tiOM1ntItgHrd/YbBLQAKiugJrfM934bDw74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526998; c=relaxed/simple;
	bh=enUW/S4YDEZ+sWMYpYh7lWNjBrgDbZHgQprFKIrO1Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JD4e/0jun8FLGSRQiMFwFV+CyEy9klUbXyvZ2kfTqlMHH/MWowOFWaBtWH7ncnQGOuCw7UK9Cktc1ydSbc7qOIclHnMPHvyv/Y/2BiQhKUybMc4DrNr//u+le2M6ORtD6JjFJIVTiV1hHGSZ8h819gThohh/H1BI7WhY8aXYzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb+VYvmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A09C4CEC4;
	Mon, 16 Sep 2024 22:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726526996;
	bh=enUW/S4YDEZ+sWMYpYh7lWNjBrgDbZHgQprFKIrO1Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fb+VYvmyhR3W0frVOqdOcDIeAteNDf+9E+56TntWv0yx7pnE8WQqeR7TLTVqDoqzP
	 MMcKuPLeOzOPfKav1ZprRkyR+BPR7ZZEWSsxOdlBnncvdmLaHa7V2s7ns7HH91Ru7q
	 ZpipYpj+Q9E/zl4fkNRxU0BHE6ufuUoTUgOdo+Cm3rT91aD90HcK1dqPZttSpPBHdg
	 zxR+nRGOsWKd4K/9xteKP2or8UB9m1BsDFvSDI7gc04TfqxhbdnZGG2q+TPSECvfcu
	 W3pipW1uBOmpVjFe/pK4DtneoP2KfyD3jSLeLUnj9uHl4eXR6M5B705zbRfrfgkhkJ
	 pN4sgksHtpAfg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 09/19] lib: test_objpool: Use kthread_run_on_cpu()
Date: Tue, 17 Sep 2024 00:49:13 +0200
Message-ID: <20240916224925.20540-10-frederic@kernel.org>
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

Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>
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
2.46.0



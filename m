Return-Path: <linux-kernel+bounces-263777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87EC93DA56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5DA1F228B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E7C156F20;
	Fri, 26 Jul 2024 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttp1+U6F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4A156676
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031047; cv=none; b=UQyVklgm+jrkj/hUU87yaIpo+TA8cqkWvKOYomARzF6GZPgQBk7Va4CYTbgxXmly4PcHD42vh3JMiYTyFcxCfSFj34x8xb5Sr029nhkmNCPg95u5fj+RqwaNsClgCsFfOyE63apVpUNdppBAW68sAA4iw8fz4itxRoFNp44paUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031047; c=relaxed/simple;
	bh=IZ4smXEyGOpkoZrnK52T7YfinkiKMtD7c8oxd58z+nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBMi8pgVjOJ219MwnAHhovTP9bEmIi9IgpXH8hEn3Ib2bkl06vQexJz16bo3m4y7fW/sCPfN2AIHelZT1TMfOM4ijl/UG5FbusSn1PtEW195eJeLqEfvUxoS7beAeOuyUomDOlSyo/MJ4+/MAnh/81oS58MFGyIue7T1ldSV4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttp1+U6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80582C4AF09;
	Fri, 26 Jul 2024 21:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031046;
	bh=IZ4smXEyGOpkoZrnK52T7YfinkiKMtD7c8oxd58z+nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ttp1+U6Fmkh7Lx0lLRgOc0Nia44DE5Nh7wtY+5b2SOtGhC59Y387jxgVddnWlC7z3
	 hGtCTY4EdhGfIl6PQxm6TpPhjPLvnSVLmNK9ER/s0btLTSAFv3omSlsUQbXLrk7lFS
	 c5UPAcK86EzCmRA2RomRUzREz+MZLDYyfLCSkFbtoO83aUoMdOGSGONrlIN/aoj3YO
	 lefMk8gjoeyINBfKNJgrwZy7rqhn7fDUUKXPfeYRbRzU+s13iKGCPy9S4tqjM5I5hG
	 0EDrzqVKXlaogR3RjizuBjWtFZJpawyRHv5Wv29jPK4XSx99J8S8Y99elVQTaxmHym
	 IEHJe9WR5O1VQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 09/20] lib: test_objpool: Use kthread_run_on_cpu()
Date: Fri, 26 Jul 2024 23:56:45 +0200
Message-ID: <20240726215701.19459-10-frederic@kernel.org>
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



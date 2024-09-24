Return-Path: <linux-kernel+bounces-336447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52678983AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D67B21A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C9F1B85E2;
	Tue, 24 Sep 2024 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="gx8g5Blk"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2026818D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727142247; cv=none; b=WKq6O9I0WznZ1fnM2WHwkg0ooMuSxM4jwqBQ0gMx3E/E9cuXhqon6G5lIPBnzfWDARfwo77FA0qiV2qmismFqNl5pnIUjw+9pviKnLhfZymxUBn7qQyJYe2JoW1itUe2hOwoQm2ZV/yyP96lOCErde/HRhrPOpbl3HZoZ402DPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727142247; c=relaxed/simple;
	bh=8Q5BWXK24teTd4/4sKSAQLQnF11r5s4GE28Y8H/LMBI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=MpH2kioz1igiIG1DsW/gWZm5lrWSW81bi1e6yJo53mUtW5fA2ARhlw5jB6FwBiZWo52TS65Gkt556a9P/tnFHb+ajcwQkUcD63j/dRQ2MCncMMynur6qfALXFqKisreu0QdG6wqDafkWxF7sw0KXzWZL+rsWnulvWuG7FP3Wj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=gx8g5Blk; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1727142235;
	bh=/Jm3ihsi6kbPKFKGYfUVqcgUc5C1RRsOQArlQQYXQ7Y=;
	h=From:To:Cc:Subject:Date;
	b=gx8g5Blkv1NUkY3Rz3FblSAg+SZOtb5Vb8CLxmq8aLw2OMJA8VZ/82KbChPEXeunI
	 KRHcHmwvsL/lvreXpG9+MsF5WvJw3TGnlVfXOEq/CFc15GlAtCCwBDxA6BCovtzcAI
	 0KxpopOd7vmTUStzZePGNefZD8eX/uRQN4HnZiJM=
Received: from localhost.localdomain ([113.57.176.32])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id A9D2761B; Tue, 24 Sep 2024 09:42:29 +0800
X-QQ-mid: xmsmtpt1727142149tqkjzj2mo
Message-ID: <tencent_6DEF4AAC658C70E251EC42D0A870E8581805@qq.com>
X-QQ-XMAILINFO: NVJ0hJNx7N5SWs/yNIuDAWLYBAEKQf6zyOy4e25qQUQIcRzv+dr/xaaThPpHpy
	 W2zIKLPAYFOL7dO8NIqOMInKW4iNXr7DeZp5MKvrE9sX94LDOLPBdetfsjuDZDRhqIKwlm6xvvig
	 5FatG4W5DrupkJiCo4BisfZI4fhgy2MeTCf+UEgqFbhl3j4DlT9cUReCV4Zp/s9nAAq6CqpFTnwF
	 7YaDtYy1DaWa/gzug02os1VDOazScREv5ArilMU7wj4nqJp40csjoIUGlY6eWiW7Slj61I/zaXJ6
	 RV4lA1NEsUHjP0VFdUyUb5SwiASSyD2ILecKtq1mST196EKoprw3wFpfDcK6SLohJTdgM13AYSGs
	 bw3NRalrxh4wIWk1WWNgmQMQhzfMZ5qRAqWgfNykXWbUArR5ZqKGrGoxNO40VLr7k/JVQlSpFrEg
	 Q+F3cRLp0e0a3jIYTRgoEtV9m9Smum8W1JRxPFX8zpyh+5UFZNyy/gp7mXmfg01b3zK1V4ivJB/H
	 vXElLm2e/3p786+PpUPrr/y8474x054aX2nOlOayMQ7G60gqueFkV8uOzhfyqMvrbI/KrZ0ZyESA
	 4yGMGb40VqTqLIFI5vUd3Ccr52s6Rq2E//1IJh5TN05VV5c3+f4GWfCOZaC1a8jFu6rmxM34l9B8
	 2LbXYWv5KUuqV27u6FUeWemG74VD7zfitpaAHF9bNlSgLLvEwBIMCgd8I/+lSxCN1ZJrICjeCQL+
	 rJEyEBZXj3vdzhzhvajJVITYjs8WqgRs/b1NhY8MW8fkgGbRLFAwIgLErsX/kQPJj0IVD0z5FSbE
	 H6UvKwcQeaJnw7yyav8gI0AuK/WIpvT2Bxh5rfI1Nt2wp7AaPA46gK/4+oTGuX98sTR3Zygt47YI
	 APocYwNrOf9JgOVwcPFL09gwTy8R4jsOxapt2KDZwZzwdXZVzDZEWfHKcWGW++6G6kKLboPQ2ky1
	 PpbrdXmMnOQ4iNt/4N+PSK4PCseE/MnCq5hk3UD7cWx+c+7wIa3g==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Canfeng Guo <gcf2000@foxmail.com>
To: mingo@kernel.org
Cc: peterz@infradead.org,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	Canfeng Guo <gcf2000@foxmail.com>
Subject: [PATCH] sched: Complete Renaming of scheduler_tick() to sched_tick()
Date: Tue, 24 Sep 2024 09:42:24 +0800
X-OQ-MSGID: <20240924014224.9831-1-gcf2000@foxmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scheduler_tick() was already renamed to sched_tick(), but this was missed.
The previous commit record can be found at
https://lore.kernel.org/all/Zer1o5bhkiq1cxaj@gmail.com/

Signed-off-by: Canfeng Guo <gcf2000@foxmail.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8dc9385f6da4..6866908a100b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12478,9 +12478,9 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 /*
  * This softirq handler is triggered via SCHED_SOFTIRQ from two places:
  *
- * - directly from the local scheduler_tick() for periodic load balancing
+ * - directly from the local sched_tick() for periodic load balancing
  *
- * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
+ * - indirectly from a remote sched_tick() for NOHZ idle balancing
  *   through the SMP cross-call nohz_csd_func()
  */
 static __latent_entropy void sched_balance_softirq(void)
-- 
2.20.1



Return-Path: <linux-kernel+bounces-316685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC8A96D2BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCD01F22EA7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA437195B37;
	Thu,  5 Sep 2024 09:05:41 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2E194ACB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527141; cv=none; b=K64ups1wDw/FR1055+trLITRJxddSSwkLIaw8ijnz+yh4jK/5UbvT5IMOztuneWec9zDC7KtXRXjgNYTUwlkbw+RlPU8HPc9R7L/knwp1MWZT0eih3V+KmKDXLU0gjCo4TIRG6bOUenY+zljDLygnJriEoaat/SoWctXtWEET0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527141; c=relaxed/simple;
	bh=fou1ky3YJ3LdwC1iJq51HNSAs17I74x2iOFBBPnmKnM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X7fPQziovbkQTnMhc1SPeVX7ylaH1+XaxsxYPkGJeJDsycvoW3qA7CGrSdAlygSuy/MrLJB7f9I/X+1mgt9CPIAmhItigWzB43ODACc6843pH7HNP+gnJiKcU4mgag4hyqcUzj3zViyjj6rHhlJNmo1iBYleqCkUXzx3xY/Q/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48595GVo077613;
	Thu, 5 Sep 2024 17:05:16 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WztYc23KYz2PMKkv;
	Thu,  5 Sep 2024 16:58:12 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 5 Sep 2024 17:05:14 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <longman@redhat.com>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] sched: Do not copy user_cpus_ptr when parent is reset_on_fork
Date: Thu, 5 Sep 2024 17:04:58 +0800
Message-ID: <20240905090458.1173-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 48595GVo077613

Now, the task's user_cpus_ptr would dup from parent's user_cpus_ptr.
It is better reset the user_cpus_ptr when parent's reset_on_fork
is set.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3951e4a55e5..2fbae00cd1dc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2666,7 +2666,7 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 	 * do_set_cpus_allowed().
 	 */
 	raw_spin_lock_irqsave(&src->pi_lock, flags);
-	if (src->user_cpus_ptr) {
+	if (src->user_cpus_ptr && !src->sched_reset_on_fork) {
 		swap(dst->user_cpus_ptr, user_mask);
 		cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
 	}
-- 
2.25.1



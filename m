Return-Path: <linux-kernel+bounces-532888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E246A4536D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EF61882DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047D3214203;
	Wed, 26 Feb 2025 02:51:13 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A914830F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538272; cv=none; b=DtVxTpe2agMYBXgXlrh4dCd5NjZkP6K/yzTgODQpNI4gYiS7eGj/xo5NX2+Kgm3NqMf+ImtqjfS7TAopuiJQJ0vJErxVrqUPxfLimE9464SYy8OlJfBEtKmTvPoAVpGC6n0AN681qvF1+TvcJQNXDnDUdmOtMnggtQQrIFpV5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538272; c=relaxed/simple;
	bh=1Z6DV3nAh2GNp+f+3eM/MPMoibcOuIl5T7q6/Lj4WOo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QMKpNAnY0qBnKxeWgWg2NH3OuAJ7Rc75YNR/PmzUXqYXV0XXIHCFIujfQ30cKvlWTUL81Dyv15faRVzA+QCQs3XmJA+L5TuWsQ4LOHGXpIqyK1mgKbxGaE1Nwt2chHK7ZU+Gx3Opx+Rfhcix71PmBYOuDeCQ0kTAgyud1kBTgYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 51Q2oi4k080334;
	Wed, 26 Feb 2025 10:50:44 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Z2f410gTQz2PxVxt;
	Wed, 26 Feb 2025 10:46:09 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 26 Feb 2025 10:50:41 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <peterz@infradead.org>, <vincent.guittot@linaro.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>
CC: <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] sched/fair: Fixup wake_up_sync vs DELAYED_DEQUEUE
Date: Wed, 26 Feb 2025 10:47:41 +0800
Message-ID: <20250226024741.2274-1-xuewen.yan@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 51Q2oi4k080334

Delayed dequeued feature keeps a sleeping task enqueued until its
lag has elapsed. As a result, it stays also visible in rq->nr_running.
So when in ake_affine_idle(), we should use the real running-tasks
in rq to check whether we should place the wake-up task to
current cpu.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef435a7aa..2d6d5582c3e9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7342,8 +7342,15 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
 		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
-	if (sync && cpu_rq(this_cpu)->nr_running == 1)
-		return this_cpu;
+	if (sync) {
+		struct rq *rq = cpu_rq(this_cpu);
+		int nr_delayed;
+
+		nr_delayed = rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable;
+
+		if ((rq->nr_running - nr_delayed) == 1)
+			return this_cpu;
+	}
 
 	if (available_idle_cpu(prev_cpu))
 		return prev_cpu;
-- 
2.25.1



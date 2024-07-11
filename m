Return-Path: <linux-kernel+bounces-249057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F5692E583
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66421C232C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B351316B74B;
	Thu, 11 Jul 2024 11:07:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9AA16B3B6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696067; cv=none; b=GR/7n7ySaY58OAfEj2PvoLyvJfIegMB7ZddsgFAbtUVrUd9rbroonYxdQ8i1xvcv/gLmno6n6dXXpJytvikFRb5rkHWp0+hp6ERyN6N/bwfrg1nOZvEGeg1NCfRd55iOPrTKisKjDPTaGyiPFMCmbb4IAOw7SG7XXBYokHfk5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696067; c=relaxed/simple;
	bh=vk9Er2RCuPUirvgyNwnOlO/5DW8sP9cfTF1EKBZrFz4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=miH90+RGw9QPWByttzYiINczGl1cRuR/lWyyM6mfpXAfwZjnU5qCz4+pBlhDkLrVuGzCUhyfQSYv0vpzGpQcPNtN06x3/QgU7/9NCiyEyzHL3acAoOBZ9c1BBfq3Bq+m/eH3L63eTNQI78Fo2g77RuYTHj6x+7sjPdHPAXsukBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WKX4K1WMCznZj8;
	Thu, 11 Jul 2024 19:07:13 +0800 (CST)
Received: from canpemm500001.china.huawei.com (unknown [7.192.104.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 42A1A1401E0;
	Thu, 11 Jul 2024 19:07:42 +0800 (CST)
Received: from huawei.com (10.45.181.69) by canpemm500001.china.huawei.com
 (7.192.104.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Jul
 2024 19:07:41 +0800
From: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
To: <tj@kernel.org>, <void@manifault.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH sched_ext/for-6.11] sched_ext: Reverting @p->sched_class if @p->disallow is set
Date: Thu, 11 Jul 2024 19:07:20 +0800
Message-ID: <20240711110720.1285-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500001.china.huawei.com (7.192.104.163)

From: Zhang Qiao <zhangqiao22@huawei.com>

when ops.init_task() sets @p->disallow, @p->policy was
reverted to @SCHED_NORMAL, but @p->sched_class was not,
so reverting p->sched_class to fair_sched_classs now.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/ext.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ae9ec8f..fb83edd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3220,13 +3220,14 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 
 		/*
 		 * We're either in fork or load path and @p->policy will be
-		 * applied right after. Reverting @p->policy here and rejecting
-		 * %SCHED_EXT transitions from scx_check_setscheduler()
+		 * applied right after. Reverting @p->policy and @p->sched_class
+		 * here and rejecting %SCHED_EXT transitions from scx_check_setscheduler()
 		 * guarantees that if ops.init_task() sets @p->disallow, @p can
 		 * never be in SCX.
 		 */
 		if (p->policy == SCHED_EXT) {
 			p->policy = SCHED_NORMAL;
+			p->sched_class = &fair_sched_class;
 			atomic_long_inc(&scx_nr_rejected);
 		}
 
-- 
2.45.2.windows.1



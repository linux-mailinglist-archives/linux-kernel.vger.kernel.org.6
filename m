Return-Path: <linux-kernel+bounces-222567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172179103C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B7A1C21B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F4A1AC436;
	Thu, 20 Jun 2024 12:07:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D1170826
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885263; cv=none; b=h++F+Reuqehcj9y3/y9nqO5N/IqWj48jxKMFt/tvn+VUgv6kNLPPDqKj5gUfpma3nNXNEGekyO+kZpaicd5RvTKWmcaxwsRG6dZHEXrDvTbDeAgCCeQmvy66KTrABZa6mNTm1/148gej2laxyPo0wrCk4L54AbBdPJyOtih3ZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885263; c=relaxed/simple;
	bh=JxE0+9bfWpYEq5OJPVWKjLf1JFQpcvMVDRY3aBDVJNA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ic317DFjYINYfMkFz5izcR8tqu2WgpHZOo0YYL/Y3KIL0KGo9HZ2hA2orlNlQ0hTH8qrM7CQp5QIArFIucBrAMuOps8YAVif3Uukn+UY1RSC6WR3OlA9DllQO5AWa8LYyXHcAGLAu6u/FPTfohgxJlv+j5mlcWJMxUHA9KihPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W4fJ2412FznWjB;
	Thu, 20 Jun 2024 20:02:42 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C5071400D6;
	Thu, 20 Jun 2024 20:07:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 20:07:37 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] sched/preempt: Bypass setting same mode for sched_dynamic_update()
Date: Thu, 20 Jun 2024 20:10:20 +0800
Message-ID: <20240620121020.869707-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100008.china.huawei.com (7.221.188.57)

If the preempt mode to set is same with current preempt mode, there is no
need to update all the `cond_resched`, `might_resched`, `preempt_schedule`,
`preempt_schedule_notrace` and `irqentry_exit_cond_resched` state.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..eb409901c64c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8777,6 +8777,9 @@ static bool klp_override;
 
 static void __sched_dynamic_update(int mode)
 {
+	if (mode == preempt_dynamic_mode)
+		return;
+
 	/*
 	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
 	 * the ZERO state, which is invalid.
-- 
2.34.1



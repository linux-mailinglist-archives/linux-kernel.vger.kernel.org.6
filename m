Return-Path: <linux-kernel+bounces-310531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADC4967DF5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76191F22809
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FF12D613;
	Mon,  2 Sep 2024 02:49:16 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923F02CA2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725245356; cv=none; b=ZkGGIbHdUBBldzLLeWZBjXQa/F7Zr161yY755Dplu2Q1cyfkpS4CUKMO7lzRTUD0zPwbW3UOMDZCUjCf+wwxm88W5ob09XNEFHN+1VJ/WXdhTR6uTahI9y6mFIjTR4Z5c3IW0sE7idWLlRpLMfNB3umXA/yQjTqMPOAM6q2S5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725245356; c=relaxed/simple;
	bh=YjNlx5NOrC9uswH8XkLoBIZQQx9koPn3iZrVRUN7KjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FSnO5RMELqAgMGmXHcLachVx7/a1imPz8ayBoSm5cHK5MZVaVwQzuX/pba9ZKpXBQB3cpgo3LFTIHPwBmL1jmH8BYJTVby4T9ZRCZ9dv/+UF+hsrtc9RXakIQFSmL2LT2xfIY1SnBJbM/H3xeaOJsh/wq+txuKbyR4pRXvdFUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WxtRB348lz1HJ2h
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:45:42 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 54FBE1A0188
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:49:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 10:49:06 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] genirq/timings: Use time_after_eq() macro
Date: Mon, 2 Sep 2024 10:57:27 +0800
Message-ID: <20240902025727.2298958-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use time_after_eq() macro instead of directly handling it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/timings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 69f103b4c7a6..a96c0f1346fd 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -383,7 +383,7 @@ static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
 {
 	int index, i, period_max, count, start, min = INT_MAX;
 
-	if ((now - irqs->last_ts) >= NSEC_PER_SEC) {
+	if (time_after_eq(now, irqs->last_ts + NSEC_PER_SEC)) {
 		irqs->count = irqs->last_ts = 0;
 		return U64_MAX;
 	}
-- 
2.34.1



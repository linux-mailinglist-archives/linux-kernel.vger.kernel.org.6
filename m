Return-Path: <linux-kernel+bounces-280331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2261694C8D7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553A81C20946
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243EE1804E;
	Fri,  9 Aug 2024 03:22:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E51171AA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173753; cv=none; b=M4zQzf6Vnzzhr7PggTrejT9fTDaQ4qZFA7biFNNOQ7ztyDVMr0KNqSiw/Uzy317i665xJ8KsjGxLVrzRyvNASo5Sc9+LvlwzzwgC304eqaB4LrKZyhtoavhGMbHkt0jEPEJaGz8HlyGyFpuNNM6GTLG7yuQ6VfSA+2QFa2m5nLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173753; c=relaxed/simple;
	bh=J521jxAyjnrgFS2aTIwMih+7xtigj/dt+WOFny5J3fE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iBR4s57uFbabn7JtxRhtCH2rXfySEiE9puFgrv80x99ip7fzYfcIWnJq+bz/ZGdw7qdP8nof6BN0qDOs8P3IPPrSEr2pYQJpGg5g2TZXYYj1Myx6vZZq0ShcIjN5Wc6r5sAgP0vl9RPLW6mekFbREBqUct10VwTNae85qa3XC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wg8NX1qkZzcd91;
	Fri,  9 Aug 2024 11:22:20 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A2DD180AE5;
	Fri,  9 Aug 2024 11:22:29 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Aug
 2024 11:22:28 +0800
From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>
CC: <cocci@inria.fr>, <linux-kernel@vger.kernel.org>, Wang Weiyang
	<wangweiyang2@huawei.com>
Subject: [PATCH] coccinelle: locks: call_kern: Add rcu_read_lock case
Date: Fri, 9 Aug 2024 11:31:56 +0800
Message-ID: <20240809033156.2518473-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg100016.china.huawei.com (7.202.181.57)

Allocating memory with GFP_KERNEL may cause the thread to be put into
sleep, and doing so within RCU read-side critical section is problematic
as it might cause the grace period to end early and trigger unexpected
objects destruction. Involve rcu_read_lock() into locks/call_kern.cocci,
as this requirement is analogous to other kinds of lock.

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 scripts/coccinelle/locks/call_kern.cocci | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/coccinelle/locks/call_kern.cocci b/scripts/coccinelle/locks/call_kern.cocci
index 3720f86d67c5..89665ea61642 100644
--- a/scripts/coccinelle/locks/call_kern.cocci
+++ b/scripts/coccinelle/locks/call_kern.cocci
@@ -31,6 +31,7 @@ fn(...) {
      when != spin_unlock_irq(...)
      when != spin_unlock_irqrestore(...)
      when != local_irq_enable(...)
+     when != rcu_read_unlock(...)
      when any
  GFP_KERNEL@p
  ... when any
@@ -59,6 +60,8 @@ spin_lock_irq@p1
 spin_lock_irqsave@p1
 |
 local_irq_disable@p1
+|
+rcu_read_lock@p1
 )
  (...)
 ...  when != read_unlock_irq(...)
@@ -69,6 +72,7 @@ local_irq_disable@p1
      when != spin_unlock_irq(...)
      when != spin_unlock_irqrestore(...)
      when != local_irq_enable(...)
+     when != rcu_read_unlock(...)
 fn@p2(...)
 
 @depends on locked && patch@
-- 
2.25.1



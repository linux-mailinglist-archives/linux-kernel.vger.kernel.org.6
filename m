Return-Path: <linux-kernel+bounces-379149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B8F9ADAB4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800142826CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792B166F0C;
	Thu, 24 Oct 2024 03:52:11 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AA9139597
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741931; cv=none; b=G0PeYgz6mmDQFuRIGDk7zys00b9RETSHq9mKWV6+wbc5DlUmaoLtgCGU+bjYZYnB7fdfEUCttIoyHn/w/lWojaD74d+qTXbPm26uI/9CP4aCEZ1wEwi8qTkxtyAwHZuNSLKlKITNKoMsv8QU6GxLy7N3hPeEChOBkMg13KqrU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741931; c=relaxed/simple;
	bh=UpA1X2XvWzH2Urwsk2PMfrV3GwBNawj0vPXFe3qNKeI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EnDKo10F9a1gce868PMpQameSo1mkQn+SIVFVwVx+HK6NR14+l1Nh+BxVlhnS/m+kcaLoZaT7jX9nwviCj1+z4vC5/hvDhsRBuw0B8FSjpIj8KqBkYhOfDJOFWYM+ttEYdDelI7rr1diE28wlIZHj9i+Oy1Jf28U76cdzka0/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XYsQ833hyz1SDKg;
	Thu, 24 Oct 2024 11:50:40 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 189C41400CA;
	Thu, 24 Oct 2024 11:52:05 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 24 Oct
 2024 11:52:04 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <mark.rutland@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<oliver.upton@linux.dev>, <kristina.martsenko@arm.com>, <ptosi@google.com>,
	<liaochang1@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: Return early when break handler is found on linked-list
Date: Thu, 24 Oct 2024 03:41:20 +0000
Message-ID: <20241024034120.3814224-1-liaochang1@huawei.com>
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
 kwepemd200013.china.huawei.com (7.221.188.133)

The search for breakpoint handlers iterate through the entire
linked list. Given that all registered hook has a valid fn field, and no
registered hooks share the same mask and imm. This commit optimize the
efficiency slightly by returning early as a matching handler is found.

v2->v1:
Remove all WARN_ON(!hook->fn) in v1 as Will suggested.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/kernel/debug-monitors.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index c60a4a90c6a5..58f047de3e1c 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -303,7 +303,6 @@ static int call_break_hook(struct pt_regs *regs, unsigned long esr)
 {
 	struct break_hook *hook;
 	struct list_head *list;
-	int (*fn)(struct pt_regs *regs, unsigned long esr) = NULL;
 
 	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
 
@@ -313,10 +312,10 @@ static int call_break_hook(struct pt_regs *regs, unsigned long esr)
 	 */
 	list_for_each_entry_rcu(hook, list, node) {
 		if ((esr_brk_comment(esr) & ~hook->mask) == hook->imm)
-			fn = hook->fn;
+			return hook->fn(regs, esr);
 	}
 
-	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
+	return DBG_HOOK_ERROR;
 }
 NOKPROBE_SYMBOL(call_break_hook);
 
-- 
2.34.1



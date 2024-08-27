Return-Path: <linux-kernel+bounces-303156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEF5960834
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F3D284417
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690719E83C;
	Tue, 27 Aug 2024 11:10:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6231919DF97
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757030; cv=none; b=L9RQrmdr1nAiYz+gp8vl8AV8UxKkBUd5M3mQjpeHyaHOP9CeVigEG4QyqjRapzbXTzwYfUKZFIsw3A8pdDox2mSJ8Ywr6KrqWPlN/jC9gXRQHfc67rf8VPS8qXPLuDpcta6ooB9Q3jAgcm3JeYkLCvgISKZMvFDaI/EYcWSFzxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757030; c=relaxed/simple;
	bh=lbYaSaAGW7Fs7enOSuZ9sJxEHYtVx3ikrVsZBahkQbU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K4WTnQTfxvAFEN20xvYVtEY06TphY7QipDZvs7TwJCZTq6aCbJq871thYqCd5+6xNQlUb9P5t+s2Sa7UDyNzSzPR5NuSkoU5JqgGA4adBRKxknve3e9cHJcGi2Fdarhg4sbrvE9CNsLZYtdjiwQK/quacK2bVc1CFkiozACJjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtPtL3bjRzpTpd;
	Tue, 27 Aug 2024 19:08:42 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 06338180064;
	Tue, 27 Aug 2024 19:10:23 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 27 Aug
 2024 19:10:22 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ptosi@google.com>,
	<liaochang1@huawei.com>, <oliver.upton@linux.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: Return early when break handler is found on linked-list
Date: Tue, 27 Aug 2024 11:00:46 +0000
Message-ID: <20240827110046.3209679-1-liaochang1@huawei.com>
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
 kwepemd200013.china.huawei.com (7.221.188.133)

The search for breakpoint handlers iterate through the entire
linked list. Given that all registered hook has a valid fn field, and no
registered hooks share the same mask and imm. This commit optimize the
efficiency slightly by returning early as a matching handler is found.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/kernel/debug-monitors.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 024a7b245056..fc998956f44c 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -281,6 +281,7 @@ static LIST_HEAD(kernel_break_hook);
 
 void register_user_break_hook(struct break_hook *hook)
 {
+	WARN_ON(!hook->fn);
 	register_debug_hook(&hook->node, &user_break_hook);
 }
 
@@ -291,6 +292,7 @@ void unregister_user_break_hook(struct break_hook *hook)
 
 void register_kernel_break_hook(struct break_hook *hook)
 {
+	WARN_ON(!hook->fn);
 	register_debug_hook(&hook->node, &kernel_break_hook);
 }
 
@@ -303,7 +305,6 @@ static int call_break_hook(struct pt_regs *regs, unsigned long esr)
 {
 	struct break_hook *hook;
 	struct list_head *list;
-	int (*fn)(struct pt_regs *regs, unsigned long esr) = NULL;
 
 	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
 
@@ -313,10 +314,10 @@ static int call_break_hook(struct pt_regs *regs, unsigned long esr)
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



Return-Path: <linux-kernel+bounces-574662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D1BA6E837
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63491898CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AE817799F;
	Tue, 25 Mar 2025 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLSRx2/2"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4A63CB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742868098; cv=none; b=BreD6iJoU9ghItjrtnZLpKZvna92YGQNMoEgapjrpYjRSpwcoXGxXK6320xwspaAUVHKsjOez4A/VoR2F/5ckrKOC3Npt9df/tiNeazHEI4xfitfiLXAgxbw7hPF7Jo+8nFZOxBlLIeaQDgckerdl067jMjhBXpUgVsfzg64Oh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742868098; c=relaxed/simple;
	bh=0XiKQpEx/LJRMqxAe2fPCzSIjY7oJZHtPeKkCipBQhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AB4KP47Fvd+J/sw4MsIWPjmJeNMUQkbLiloZ8EiuyJ1sKwT1m57MbcCYQUzmfdd1KuDNTcS9Gvpo3LfxmdNVMPKtxNgLSu9GjX3EB8Vq4XSX2rN7aXawWTJ5Qwrx81J6Q1zz9H+R08Bsq5xMAJqmN2VaVAVMDie32NXBPY9KLFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QLSRx2/2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4393ee912e1so17075e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742868095; x=1743472895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugyR/LCYHKfgKcf3dWgRzREDXmHjGBwxKIlqYssVg5c=;
        b=QLSRx2/2LrJwBw4x0YAsWHy5pwCdnGunZrwXwda2g5y6JwpEv9h6ncgTCWygz6V7iS
         qZ1z1FYcgnsVYZi1FhrjgPUcEEeKczAbbAWQdU6WpuE/ZHFh2BHQiw0e8/loh2qR/fNn
         UafIT+mSOQaHSqr6ds3gVZ5w6t+eqQPhrAktOJVTlTKh4NuQstOb8E13v+9AmjPoyu45
         A/XkbB+ORVICmMtrY03RRbtT6DeslvoLX+m3YwZg7xURK88sEiql1/Qnut3uc0UrvD0b
         9xrcnoNddMPmddbpOueii9cAR6SNJtFxItndLLrkj1wJ5J9V1nuS8/kpOlz3toYjviwQ
         WZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742868095; x=1743472895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugyR/LCYHKfgKcf3dWgRzREDXmHjGBwxKIlqYssVg5c=;
        b=ISMljcckoCJaeZiFhkUIMXaPBgY/bggxlnpVI2TjJOWHN8HjnKeHkwMeouI0FxvoNs
         x9PURUJ7ssbLeKm2dqYfHKwz9XD9NInNEznX0w/tCYqr6DH1wJ1f4sjnUQ6KLwrDJj1x
         ATqn2Rqo5/SMPqfdNr53g4aabwvI02EMw3oFTfugcOEMMxe6V4hDSaMwZGB5ibobkOES
         E04xFWpPZN70g/sOUmTgYRo9ZFfyih8KLxnExYD9j77rJJJQn0vFwbJheHhUfxQnSyyA
         TdOjXgJAN6Jy8iKeF2yUIS0WiYukedhXPCZZ1dZbRTtJVNPja9BJyWF9PHoEULjBqSHb
         BigA==
X-Gm-Message-State: AOJu0YxMuKYpeRhqkwM1wKyPpIZTDddffmOp8Ee2NKsO6Pcpik4bDwTw
	GIIun2YsvkyH7nRev8lqO+UTbXN0c8eXAbLUA5Ksn28bgIN4H3KYILury1aULw==
X-Gm-Gg: ASbGncssYMyMULHWYTe3QK+ZVWybUcGdNbCLw1yjIhWN7dUO9/NrVEXrBSk86urrbzV
	uo1u1V/7wUuoWPCnRj8+x/VmWoDolnqO4m7Wa4nuP9cqnaZQd4/J5L1MPAUoTnNELjR26BS9bIt
	OYl66c0rbWHRUUgx78mpbQZ9V7Wv5XUvJqvZs7bwsr9bwNcs4KCUtSHbXDrM6U3lS+ksUWWvq8P
	pYRgRa8yDK6mKYzSMiJjBIxKGZDh5fav3F5E2qiYPd0f9aI61ENGDq4fbdsuol7nY72L3Ncldq6
	mq/HYDx71HzM35I7u/NC1pU0PjWpphIp7w==
X-Google-Smtp-Source: AGHT+IEwxGzlEsa/yozvMpG5rLjzDpAwrA4wJBU/u0n8ghpuiKmN+mvX2t2n1Qc8jeK5DBv88CYXIA==
X-Received: by 2002:a05:600c:5107:b0:43d:169e:4d75 with SMTP id 5b1f17b1804b1-43d5a3ac61bmr4371355e9.1.1742868094984;
        Mon, 24 Mar 2025 19:01:34 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:fbb4:5f96:b3e7:71b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm12579021f8f.38.2025.03.24.19.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 19:01:34 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Mar 2025 03:01:23 +0100
Subject: [PATCH 2/2] x86/dumpstack: Fix broken unwinding from exception
 stacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-2025-03-unwind-fixes-v1-2-acd774364768@google.com>
References: <20250325-2025-03-unwind-fixes-v1-0-acd774364768@google.com>
In-Reply-To: <20250325-2025-03-unwind-fixes-v1-0-acd774364768@google.com>
To: x86@kernel.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
 Dominik Brodowski <linux@dominikbrodowski.net>, 
 Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Vernon Lovejoy <vlovejoy@redhat.com>, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742868088; l=2348;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=0XiKQpEx/LJRMqxAe2fPCzSIjY7oJZHtPeKkCipBQhM=;
 b=Tax2z5kRDsKeRF1KcIuAqhoJvHIkChW3L+IfLc0L9ACU+OJ8RoC4iLWFojZlE1rUBHYEaDlCW
 dzULsxhB8t+CwIcRcRZOBrKHMmVAC2Kvp6ejVgaHQV/9vrYVI+I2QEf
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Commit 2e4be0d011f2 ("x86/show_trace_log_lvl: Ensure stack pointer is
aligned, again") was intended to ensure alignment of the stack pointer; but
it also moved the initialization of the "stack" variable down into the loop
header. This was likely intended as a no-op cleanup, since the commit
message does not mention it; however, this caused a behavioral change
because the value of "regs" is different between the two places.

Originally, get_stack_pointer() used the regs provided by the caller; after
that commit, get_stack_pointer() instead uses the regs at the top of the
stack frame the unwinder is looking at. Often, there are no such regs at
all, and "regs" is NULL, causing get_stack_pointer() to fall back to the
task's current stack pointer, which is not what we want here, but probably
happens to mostly work. Other times, the original regs will point to
another regs frame - in that case, the linear guess unwind logic in
show_trace_log_lvl() will start unwinding too far up the stack, causing the
first frame found by the proper unwinder to never be visited, resulting in
a stack trace consisting purely of guess lines.

Fix it by moving the "stack = " assignment back where it belongs.

Fixes: 2e4be0d011f2 ("x86/show_trace_log_lvl: Ensure stack pointer is aligned, again")
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/dumpstack.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index a7d562697e50..b2b118a8c09b 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -195,6 +195,7 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
+	stack = stack ?: get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
 
 	/*
@@ -213,9 +214,7 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	 * - hardirq stack
 	 * - entry stack
 	 */
-	for (stack = stack ?: get_stack_pointer(task, regs);
-	     stack;
-	     stack = stack_info.next_sp) {
+	for (; stack; stack = stack_info.next_sp) {
 		const char *stack_name;
 
 		stack = PTR_ALIGN(stack, sizeof(long));

-- 
2.49.0.395.g12beb8f557-goog



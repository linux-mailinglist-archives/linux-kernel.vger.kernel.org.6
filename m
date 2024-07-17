Return-Path: <linux-kernel+bounces-255446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1EF9340C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5ADB21F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DBD1822CB;
	Wed, 17 Jul 2024 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="XkDfZDlh"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CA8181325
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235129; cv=none; b=pYSuduBephmFnPDp9+Fo6mZGG/XZMpXLNIhQVrEdSL54/uKGocIGccnguQOsecHG4JG+rojnOw5t1tlUnc9nCzGXPMJQkPxj4kR3FpRFlhMurB941OTbMboz57nJ8cV/5sbalKd0tS9zjRucCBt4vL9q+0MkJfcOu0Y0omGdugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235129; c=relaxed/simple;
	bh=lxuBxbsvbSTaBL3FDYSDk4R6N1GFasgWz5NnAw4s9m4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i/iteZRmbVp4MTU6DA4lkuqQ2ETXy3aDqt6p7JP4voWkZoQzYjkgByfiIjP/B/9GqrlBYfG+5MqGfqju0fmUEPXy2180Om/iW/Ala62yuJPcBGv5XKNNkJSHH4lPgeDepHjE+ms689HT9US8dGSM4kCOYBu5be0fuKDQReelcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=XkDfZDlh; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=Zo/5oazRpbAgrjs/vD05WtrETdZb74HbIk71IzrBl/Q=;
	b=XkDfZDlhJwGfETALq61e8zOZZxkHA4Egs/GfQZms1c2xHhI1a8xDuUTVWSWb7M
	3UwOgLlYKkK1eyXUubolCbQF4Lh+J2+VJcUkn9D1S4MMWh7eSkzlb4/wlqeYmcZ7
	hFvTB6Tpz728tw6tg1e9ZXjWlT8fjNK/kZ+LFbm7XCuXA=
Received: from ubuntu.localdomain (unknown [36.112.164.132])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXX7kD75dmr2TQAA--.5868S2;
	Thu, 18 Jul 2024 00:19:16 +0800 (CST)
From: buckzhang1212@yeah.net
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	buckzhang1212@yeah.net
Subject: [PATCH] sched:add panic to remind that wake_q_node should be WAKE_Q_TAIL when emtpy
Date: Wed, 17 Jul 2024 09:19:01 -0700
Message-Id: <20240717161901.2375-1-buckzhang1212@yeah.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgDXX7kD75dmr2TQAA--.5868S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4xWF47Gw1fJw1ruw4kJFb_yoW5Gw48pw
	nrGF1UWr4kJr4jyr4xJry5Jr15JF1UAa18GFn7tayrJF1UKw1Utr1jqFW7Arn8Gr4Y9FWx
	tF1Dtr4rtrsrJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07befHUUUUUU=
X-CM-SenderInfo: pexfy65kdqwiqsrsq5hhdkh0dhw/1tbiCQUfr2Zv-hYflAAAsW

From: "weihui.zhang" <buckzhang1212@yeah.net>

Here is a kernel exception ,wake_q_node is NULL.
when wake_q_node empty ,it must be WAKE_Q_TAIL instead of NULL Logically.
Maybe a hardware bitflip corrupted the node ,add panic to call attention.
kernel crash:
Unable to handle kernel NULL pointer dereference at virtual address 00000
pc : wake_up_q+0x58/0xf4
lr : wake_up_q+0x7c/0xf4
sp : ffffffc0138cbb50
x29: ffffffc0138cbb50 x28: ffffff8080d49e08 x27: ffffff808206a500
x26: ffffff8085cc5c00 x25: b40000704f903000 x24: 0000000000000fd0
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: ffffff8092695c80 x19: ffffffc0138cbba8 x18: ffffffc013715048
x17: 0000000000000000 x16: 00000000000002a0 x15: 00000000000000cb
x14: 0000000000000000 x13: 0000000000000006 x12: 00000016201f7e4a
x8 : 0000000000000002 x7 : 0000000000000000 x6 : 0000000000000002
x5 : 0000000000000003 x4 : 0000000000000000 x3 : ffffffc0138cba20
x2 : ffffffc008258efc x1 : ffffffc008258efc x0 : ffffff8092695cb8
Call trace:
wake_up_q+0x58/0xf4
futex_wake+0x2c4/0x450
do_futex+0x1b0/0x890
__arm64_sys_futex+0x148/0x198
invoke_syscall+0x6c/0x15c
el0_svc_common.llvm.385418249754134116+0xd4/0x120
do_el0_svc+0x34/0xa4
el0_svc+0x28/0x90
el0t_64_sync_handler+0x88/0xec
el0t_64_sync+0x1b8/0x1bc
//x0:head ffffffc0138cbba8:  ffffff8092696508 *node = head->first
0xffffffc008258ea8 <wake_up_q+0x28>:	ldr	x21, [x0] 
//cmp WAKE_Q_TAIL if eq jump,but here is NULL.
0xffffffc008258ecc <wake_up_q+0x4c>:	cmp	x21, #0x1 
0xffffffc008258ed4 <wake_up_q+0x54>:	mov	x23, x21  //ffffff8092696508
0xffffffc008258ed8 <wake_up_q+0x58>:	ldr	x21, [x21]//kernelcrash
x21=NULL  [ffffff8092696508]=0000000000000000 node->next=NULL
init node fist:
|wake_q_init
 |head->first = WAKE_Q_TAIL;
empty node next：
 |__wake_a_add
   |cmpxchg_relaxed(node->next,NULL,WAKE_Q_TAIL)

Signed-off-by: weihui.zhang <buckzhang1212@yeah.net>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90..ed755c2ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1015,6 +1015,10 @@ void wake_up_q(struct wake_q_head *head)
 	struct wake_q_node *node = head->first;
 
 	while (node != WAKE_Q_TAIL) {
+		if (node == NULL) {
+			pr_err("BUG:wake_q_node corrupted,node should be WAKE_Q_TAIL when emtpy\n");
+			panic("wake_q_node corrupted\n");
+		}
 		struct task_struct *task;
 
 		task = container_of(node, struct task_struct, wake_q);
-- 
2.17.1



Return-Path: <linux-kernel+bounces-219677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D9C90D65F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E8F1F21A29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA2768E1;
	Tue, 18 Jun 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKVz41ct"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD82139C1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722723; cv=none; b=XWAZIUXkyTBwD4Uq7zvsOnfzOyR5QYpHPFUWQkMkKxX2z5hfY9fZl7rNIvYvjSL8rS6IFC9c8DLRz7gDIHde8jsnb/6y1kFblKYN/sPFAY6pf7utXv6LwzpJAhc5If0xKrFvBiq3c7+/uiQBdxXs+ihvLv0TPwdYP85bKTgkOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722723; c=relaxed/simple;
	bh=J2+M0QZB+3iNVpJ3pCU5SALGJs3I3cxIThL9w+gyU9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HK6QQ64yUFGV5a+F5d2xE8twp3wWNC1YHL0xV0/NTHuR2NyYjtj9fRfOGC1jqSRQJFGpk7BHedTY9tW3Crg2sZA+3mlWP74BVaSE92p3bZ+FdR4rFXBp/qsvu9nKU8HsGqshyoFLU+LnHjKEwIEmyJqYwzQKCyvZwxoNPCKerxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKVz41ct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608BCC3277B;
	Tue, 18 Jun 2024 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718722722;
	bh=J2+M0QZB+3iNVpJ3pCU5SALGJs3I3cxIThL9w+gyU9M=;
	h=From:To:Cc:Subject:Date:From;
	b=NKVz41cthMe7Fer2+MAJuymZBSA+QFw1ETHg7RW4SdSyRUxvOfS8dsn5IE8flvlBg
	 CgPsR1kVe7bEmPhmA4yH75NC1KTRpaPnC22J3QDU64rL55XY/VAQXpTGQPK9JLpsX9
	 qKz0Oq0mDc8ydV1AhzvOPlfVu1B+fRaJRJsakERLssd28n5d0EDr3Wo3U1X6111Qri
	 Tm3EVeBtSaJjfuuaf+FzsiHooKBjMvBrZuemyKl1QJclf2RkydgtEC2p7fvW4LORsv
	 /hTqYaFdKH4km3+MaNhb3Ocd/NitUAWgSipgy+d1TAUOBm0v9HWp74R0VeCYBia/0n
	 jIAL1ADvrdo5g==
From: Puranjay Mohan <puranjay@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Matthew Bystrin <dev.mbstr@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com,
	rostedt@goodmis.org
Subject: [PATCH] riscv: stacktrace: fix usage of ftrace_graph_ret_addr()
Date: Tue, 18 Jun 2024 14:58:20 +0000
Message-Id: <20240618145820.62112-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ftrace_graph_ret_addr() takes an `idx` integer pointer that is used to
optimize the stack unwinding. Pass it a valid pointer to utilize the
optimizations that might be available in the future.

The commit is making riscv's usage of ftrace_graph_ret_addr() match
x86_64.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/riscv/kernel/stacktrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 528ec7cc9a62..6cb7f9ca9d82 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -32,6 +32,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(void *, unsigned long), void *arg)
 {
 	unsigned long fp, sp, pc;
+	int graph_idx = 0;
 	int level = 0;
 
 	if (regs) {
@@ -68,7 +69,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			pc = regs->ra;
 		} else {
 			fp = frame->fp;
-			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
+			pc = ftrace_graph_ret_addr(current, &graph_idx, frame->ra,
 						   &frame->ra);
 			if (pc == (unsigned long)ret_from_exception) {
 				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
-- 
2.40.1



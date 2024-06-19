Return-Path: <linux-kernel+bounces-220625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3053D90E48A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A041C208F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8D768EC;
	Wed, 19 Jun 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arG4GsNk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6407763F1;
	Wed, 19 Jun 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782315; cv=none; b=q/Fr+laF9ChKSm8aPumKAMI7oTEEAWbLh9RwoiS+6iDXZ50kTjd7mAldL2oTQFNFUGhUA+fHnTeRV8PAOdDwRlu4XWexKGyO0dL2Z0AKbGLnKzxxTCC8alHYdjEyJ98LOrRKMV4lkshT7C+7jTSCvChE86DKbp8bM1jpY8vQ8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782315; c=relaxed/simple;
	bh=XTCI3kDrpbBg4Lfz1ZdVs0Sn3hc3Wsh1jH1Bj8wlh68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nsVWWh4wL/MAfNS96ZS1nNwFZTkHpKLMRbgHBEdiXtholGYtuQdq9fWw/meIPunS06dM5v8PNzzTF+J9iMOosJcz5eNfWnA+YwnsvpVVhZ4nMjRdQ6WYOat5m3wDtiO1L687vqrGmkg2GkDKg6a1j0RpAJq/kGONTx18fVm5IB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arG4GsNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0884AC2BBFC;
	Wed, 19 Jun 2024 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718782315;
	bh=XTCI3kDrpbBg4Lfz1ZdVs0Sn3hc3Wsh1jH1Bj8wlh68=;
	h=From:To:Cc:Subject:Date:From;
	b=arG4GsNkTijnjq5fIHD9G1mf6WI1/AQwv0wo6LycvxqJ7mLKtrPd7im/qxHA1nz4p
	 dLPyCoDZ89WoftflAwGgofukr1Dhyp0SNenEF39J2C+CM+ltVsIeYn4+bx057Lkfw3
	 rmssGAVf5VprJemTIVFgZWKSAf/+Soa+H26ApwjJHfxNQgIZo71ehVPRag18Dbhrow
	 BsnG3FFfJpixRwISpDzPe24FOzkyZZt0Miy3b4iRQyM1q+vG0jMCV222dw5+Y0Gv+k
	 9ZSG4LHcAdOJpF4w0GJTRAZ/FGstrIjc3VffnzRpbTP5670QySnmkc4vTOGz8bjF+l
	 6gh8m1YpxCx8A==
From: Puranjay Mohan <puranjay@kernel.org>
To: Guo Ren <guoren@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-csky@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH] csky: stacktrace: fix usage of ftrace_graph_ret_addr()
Date: Wed, 19 Jun 2024 07:31:40 +0000
Message-Id: <20240619073140.48817-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ftrace_graph_ret_addr() now returns the passed in return address when NULL
is passed for the 'idx' paramenter. This breaks the current usage in csky's
walk_stackframe()

Fix this by passing a valid integer pointer to ftrace_graph_ret_addr()

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/csky/kernel/stacktrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/csky/kernel/stacktrace.c b/arch/csky/kernel/stacktrace.c
index 27ecd63e321b..1d72f18064c2 100644
--- a/arch/csky/kernel/stacktrace.c
+++ b/arch/csky/kernel/stacktrace.c
@@ -17,6 +17,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(unsigned long, void *), void *arg)
 {
 	unsigned long fp, sp, pc;
+	int graph_idx = 0;
 
 	if (regs) {
 		fp = frame_pointer(regs);
@@ -50,7 +51,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 		frame = (struct stackframe *)fp;
 		sp = fp;
 		fp = frame->fp;
-		pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
+		pc = ftrace_graph_ret_addr(current, &graph_idx, frame->ra,
 					   (unsigned long *)(fp - 8));
 	}
 }
-- 
2.40.1



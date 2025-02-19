Return-Path: <linux-kernel+bounces-522444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAE5A3CA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 124E57A8BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A4624E4DF;
	Wed, 19 Feb 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="twRevT1T"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D821B9C5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998425; cv=none; b=YJuJ5C2ynBqLUL6boVMaIfqJohNAAFg9WCWQPKX+iIFGWULaEa8dVdvZKEKnkyGP/WxLU6jwH7YhvWjdgayEILTt1yO8TXR23mxsRqFPUDH6ekWRJSSxkMo+yBGZO8W3r1z7IDCXQC7oquH1Q9e0pbd84CIHmDTh8bQBHVww5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998425; c=relaxed/simple;
	bh=1bgCtD1tB9tu6ISkUH5KPHRBYFyrqLFJvIEu5+stnUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aC6PSBjytl1EvKZOiJup7doUhNYrGg9dnT7Qoug6+30MpYgf0urzNbylAb+eNnJwqrgMAzykPtTf/r7tle3DfWiWobDr9/pa9jrAR7wVLcNOVSudFWqIdczkpb/nYYJoeovxjx88J+WlQHlb8SkgwkR8YMk/6Hc/TuWZBiNrL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=twRevT1T; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1739998416;
	bh=1bgCtD1tB9tu6ISkUH5KPHRBYFyrqLFJvIEu5+stnUg=;
	h=From:To:Cc:Subject:Date:From;
	b=twRevT1TQG3RBXYP4v4t6ogPjEluGxCY0pZViyEcjZqXRUjohJtIE/XsPNStwmrct
	 RbAfqQ2cPOj28nWgBU3uC3FHJh3xt3HtZLKbE50lZ9+KbrpdoxEBK8GBwXawmUOLfP
	 ZzstOe0i6q/QtSJ52I/aEilswlLKi+lSokT78wD1b3Wf0ftPG/R9XlInYLxAR7LM0Q
	 NBmYNQMsIEe5p4R6+cahZZgfT9DRuFEtuFZexvnD+cbIBd39P4maK9Qqd4Rd0dOzge
	 X23OV5HQtkftuZ/fBCAyEqcNbhlDdU4nHpQpTuaYWOxTlVG7YbWoth2bA8ic4gTlwl
	 YC23AzsTSuryw==
Received: from laptop-mjeanson.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4YypX03mHfz19H0;
	Wed, 19 Feb 2025 15:53:36 -0500 (EST)
From: Michael Jeanson <mjeanson@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Michael Jeanson <mjeanson@efficios.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rseq: Fix rseq registration with CONFIG_DEBUG_RSEQ
Date: Wed, 19 Feb 2025 15:53:26 -0500
Message-ID: <20250219205330.324770-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_DEBUG_RSEQ at registration the read-only fields are copied
from user-space, if this copy fails the syscall returns EFAULT and the
registration should not be activated.

Move the activation of the registration after the copy of the fields to
ensure this.

Fixes: 7d5265ffcd8b ("rseq: Validate read-only fields under DEBUG_RSEQ config")
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/rseq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 442aba29bc4c..2cb16091ec0a 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -507,9 +507,6 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
-	current->rseq = rseq;
-	current->rseq_len = rseq_len;
-	current->rseq_sig = sig;
 #ifdef CONFIG_DEBUG_RSEQ
 	/*
 	 * Initialize the in-kernel rseq fields copy for validation of
@@ -521,6 +518,14 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	    get_user(rseq_kernel_fields(current)->mm_cid, &rseq->mm_cid))
 		return -EFAULT;
 #endif
+	/*
+	 * Activate the registration by setting the rseq area address, length
+	 * and signature in the task struct.
+	 */
+	current->rseq = rseq;
+	current->rseq_len = rseq_len;
+	current->rseq_sig = sig;
+
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields
-- 
2.43.0



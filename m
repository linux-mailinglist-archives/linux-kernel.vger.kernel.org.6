Return-Path: <linux-kernel+bounces-541566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E939A4BE5E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAF716955B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1981F63C3;
	Mon,  3 Mar 2025 11:20:41 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931931F3D49
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000841; cv=none; b=HCBCW/76p7Ionqjrw7Ij1Qo6swoiux9LCc/YhxNppDv5YUNOE9kGlfCQpboJxwXyArtW84AEcZw6Wr+rXFxrhtZwr99LPb85unD1r3sDwib0nO7WNbaVUIu3rTj3uBVFwuavmKeVLCOu26xfC9NcxVhiUSE6HpPvWOEnJPHexa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000841; c=relaxed/simple;
	bh=q9uPqLTY23wTOJPd4l5UeTu14FuWmA115jTfrX5akA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZeHYBdri7Nkp1e0w6usIh8XyfOSK2xSXYa5vElDVM1Dsm62BdBLAYu02zqxK450L/FSYG2jHM76OwXYa7bfg175R2iJR2XoO5zYXgOm6DqKdI3h6INQBZaL4dhb3IRJ5wgQPlC0M13Rw3qaL3n55oQNXB8BttrSF1ja/Ih4RMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 7D91C72C97F;
	Mon,  3 Mar 2025 14:20:38 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 6902F7CCB3A; Mon,  3 Mar 2025 13:20:38 +0200 (IST)
Date: Mon, 3 Mar 2025 13:20:38 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/6] ptrace_get_syscall_info: factor out
 ptrace_get_syscall_info_op
Message-ID: <20250303112038.GE24170@strace.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303111910.GA24170@strace.io>

Move the code that calculates the type of the system call stop
out of ptrace_get_syscall_info() into a separate function
ptrace_get_syscall_info_op() which is going to be used later
to implement PTRACE_SET_SYSCALL_INFO API.

Signed-off-by: Dmitry V. Levin <ldv@strace.io>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/ptrace.c | 58 +++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d5f89f9ef29f..22e7d74cf4cd 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -921,7 +921,6 @@ ptrace_get_syscall_info_entry(struct task_struct *child, struct pt_regs *regs,
 	unsigned long args[ARRAY_SIZE(info->entry.args)];
 	int i;
 
-	info->op = PTRACE_SYSCALL_INFO_ENTRY;
 	info->entry.nr = syscall_get_nr(child, regs);
 	syscall_get_arguments(child, regs, args);
 	for (i = 0; i < ARRAY_SIZE(args); i++)
@@ -943,7 +942,6 @@ ptrace_get_syscall_info_seccomp(struct task_struct *child, struct pt_regs *regs,
 	 * diverge significantly enough.
 	 */
 	ptrace_get_syscall_info_entry(child, regs, info);
-	info->op = PTRACE_SYSCALL_INFO_SECCOMP;
 	info->seccomp.ret_data = child->ptrace_message;
 
 	/* ret_data is the last field in struct ptrace_syscall_info.seccomp */
@@ -954,7 +952,6 @@ static unsigned long
 ptrace_get_syscall_info_exit(struct task_struct *child, struct pt_regs *regs,
 			     struct ptrace_syscall_info *info)
 {
-	info->op = PTRACE_SYSCALL_INFO_EXIT;
 	info->exit.rval = syscall_get_error(child, regs);
 	info->exit.is_error = !!info->exit.rval;
 	if (!info->exit.is_error)
@@ -965,19 +962,8 @@ ptrace_get_syscall_info_exit(struct task_struct *child, struct pt_regs *regs,
 }
 
 static int
-ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
-			void __user *datavp)
+ptrace_get_syscall_info_op(struct task_struct *child)
 {
-	struct pt_regs *regs = task_pt_regs(child);
-	struct ptrace_syscall_info info = {
-		.op = PTRACE_SYSCALL_INFO_NONE,
-		.arch = syscall_get_arch(child),
-		.instruction_pointer = instruction_pointer(regs),
-		.stack_pointer = user_stack_pointer(regs),
-	};
-	unsigned long actual_size = offsetof(struct ptrace_syscall_info, entry);
-	unsigned long write_size;
-
 	/*
 	 * This does not need lock_task_sighand() to access
 	 * child->last_siginfo because ptrace_freeze_traced()
@@ -988,18 +974,42 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
 	case SIGTRAP | 0x80:
 		switch (child->ptrace_message) {
 		case PTRACE_EVENTMSG_SYSCALL_ENTRY:
-			actual_size = ptrace_get_syscall_info_entry(child, regs,
-								    &info);
-			break;
+			return PTRACE_SYSCALL_INFO_ENTRY;
 		case PTRACE_EVENTMSG_SYSCALL_EXIT:
-			actual_size = ptrace_get_syscall_info_exit(child, regs,
-								   &info);
-			break;
+			return PTRACE_SYSCALL_INFO_EXIT;
+		default:
+			return PTRACE_SYSCALL_INFO_NONE;
 		}
-		break;
 	case SIGTRAP | (PTRACE_EVENT_SECCOMP << 8):
-		actual_size = ptrace_get_syscall_info_seccomp(child, regs,
-							      &info);
+		return PTRACE_SYSCALL_INFO_SECCOMP;
+	default:
+		return PTRACE_SYSCALL_INFO_NONE;
+	}
+}
+
+static int
+ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
+			void __user *datavp)
+{
+	struct pt_regs *regs = task_pt_regs(child);
+	struct ptrace_syscall_info info = {
+		.op = ptrace_get_syscall_info_op(child),
+		.arch = syscall_get_arch(child),
+		.instruction_pointer = instruction_pointer(regs),
+		.stack_pointer = user_stack_pointer(regs),
+	};
+	unsigned long actual_size = offsetof(struct ptrace_syscall_info, entry);
+	unsigned long write_size;
+
+	switch (info.op) {
+	case PTRACE_SYSCALL_INFO_ENTRY:
+		actual_size = ptrace_get_syscall_info_entry(child, regs, &info);
+		break;
+	case PTRACE_SYSCALL_INFO_EXIT:
+		actual_size = ptrace_get_syscall_info_exit(child, regs, &info);
+		break;
+	case PTRACE_SYSCALL_INFO_SECCOMP:
+		actual_size = ptrace_get_syscall_info_seccomp(child, regs, &info);
 		break;
 	}
 
-- 
ldv


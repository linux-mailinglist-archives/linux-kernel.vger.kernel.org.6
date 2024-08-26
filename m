Return-Path: <linux-kernel+bounces-301255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1830595EE3B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C685228504E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5965C152160;
	Mon, 26 Aug 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="jhAklNXX"
Received: from out0-218.mail.aliyun.com (out0-218.mail.aliyun.com [140.205.0.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181B1494BF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667235; cv=none; b=So460wVFlzDsWyZNCs10LtlV6dwsa6qYB17j688+szKbCQ6EwGdJ5oHAU9J1XONKE5VS3Azq6hlU3HYyv+sjx/nl91UivkSKmkfnomQ6hSiOD5V6y3unRBCag119JoSZjQOnKypPQyFtvP2DyiGEJQzdjzcPtF7pkd+9jZIqLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667235; c=relaxed/simple;
	bh=C4x7iKn1TrrmJ72tbs7DBcaMP9bMwwOCRS+8Ucg7zv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RmvD7hcf7sXUOrrw6340gdBDI1CRwFFfgqKpfOe2PX+QYt6A/BobO9FKMHOTgI17RSZYeuLq+atvLxB3Wc6ce9Of6pFyaCvWB7isQ1TMgioKD0dY8M+qPiU4hpogm9U3dELsQIMGhg3HiCxRLDzElU2S0f959CLmhf49V/1WY3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=jhAklNXX; arc=none smtp.client-ip=140.205.0.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724667225; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9bUZVJugjOokUMlJ2o17PYTbMBQk6FoNOY0ajvacRoI=;
	b=jhAklNXXsq5epldnba1IILpoLv30JG8TmUqma1tTzRwtGgnzIdpseiIbMmkQkmBruhoYZk/Wng4n1UGNj3MZzjCR643zCssJF6TwMKQYpUeI8o3Wee42FcijRGN3V6728Xe6n4zNYGuDfekSbT5DetRtyo+0/nzoDmVeYTS5xZg=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z2YRsdP_1724666908)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 18:08:28 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 7/7] um: Remove outdated asm/sysrq.h header
Date: Mon, 26 Aug 2024 18:08:15 +0800
Message-Id: <20240826100815.904430-8-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826100815.904430-1-tiwei.btw@antgroup.com>
References: <20240826100815.904430-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This header no longer serves a purpose after show_trace was removed
by commit 9d1ee8ce92e1 ("um: Rewrite show_stack()").

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/sysrq.h | 8 --------
 arch/um/kernel/sysrq.c      | 1 -
 arch/x86/um/sysrq_32.c      | 1 -
 arch/x86/um/sysrq_64.c      | 1 -
 4 files changed, 11 deletions(-)
 delete mode 100644 arch/um/include/asm/sysrq.h

diff --git a/arch/um/include/asm/sysrq.h b/arch/um/include/asm/sysrq.h
deleted file mode 100644
index 8fc8c65cd357..000000000000
--- a/arch/um/include/asm/sysrq.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_SYSRQ_H
-#define __UM_SYSRQ_H
-
-struct task_struct;
-extern void show_trace(struct task_struct* task, unsigned long *stack);
-
-#endif
diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 746715379f12..4bb8622dc512 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -11,7 +11,6 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 
-#include <asm/sysrq.h>
 #include <asm/stacktrace.h>
 #include <os.h>
 
diff --git a/arch/x86/um/sysrq_32.c b/arch/x86/um/sysrq_32.c
index f2383484840d..a1ee415c008d 100644
--- a/arch/x86/um/sysrq_32.c
+++ b/arch/x86/um/sysrq_32.c
@@ -9,7 +9,6 @@
 #include <linux/sched/debug.h>
 #include <linux/kallsyms.h>
 #include <asm/ptrace.h>
-#include <asm/sysrq.h>
 
 /* This is declared by <linux/sched.h> */
 void show_regs(struct pt_regs *regs)
diff --git a/arch/x86/um/sysrq_64.c b/arch/x86/um/sysrq_64.c
index 0bf6de40abff..340d8a243c8a 100644
--- a/arch/x86/um/sysrq_64.c
+++ b/arch/x86/um/sysrq_64.c
@@ -12,7 +12,6 @@
 #include <linux/utsname.h>
 #include <asm/current.h>
 #include <asm/ptrace.h>
-#include <asm/sysrq.h>
 
 void show_regs(struct pt_regs *regs)
 {
-- 
2.34.1



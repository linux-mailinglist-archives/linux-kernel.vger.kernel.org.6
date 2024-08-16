Return-Path: <linux-kernel+bounces-289508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6601F9546E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248701F2383D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9030F18FC92;
	Fri, 16 Aug 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aymZKUL2"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02421DFFC
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805051; cv=none; b=Ox2E+qy99cND+a1kFmWm6LuUst7ZewdZlXMFfB/DgYBd3qRi2TkAgbJN1H2Ccvgf4vad603lvpTq3Y1+K8LXWciWUSCT1/389nPg/RLWKEYuNez2+8dAe8aPxARToarpxAPzP1qH/LbHEnMWlE3Zir9jeNm9NA7bLHh+4tusg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805051; c=relaxed/simple;
	bh=pf9oduXs//THOyX3WdgI4DSVkjYeaSBR5XBkMBiIDpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UKbFhH1tfifEFHWBQNZmDiSRSmrgaBQ4cLdiqtVMnDqW0sUuEdZn388Wx5bIfioK0kIIos1CXCR53pQ0Ic8o5PDxl4XabP9RfgOtgilk8hLx2p+1cemBA7TF8YmgfDBq5+yp76xBomhj5SH2+4KLHP9q/B+MD77yKTl0DdulOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=aymZKUL2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47GAhGAS2276985
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 16 Aug 2024 03:43:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47GAhGAS2276985
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723805000;
	bh=yDT1Z2ddStwr/KrrrVicweVCd/eYZAYklSTxUX5GZbg=;
	h=From:To:Cc:Subject:Date:From;
	b=aymZKUL2szDa9op6VrqCFzBgV5Q/20dfvs3MC1GAFHmWt2KGHU/XVmCSqVV7cWP0S
	 84RXAExvc1HhmkYDHA9iu5xNuT5W6NUrWh5iJm+FcdA9aKe+lF7kdWmN1qVzrqngSI
	 hJvHAhPTzFuJL+r/T2ByCD329ammyveqAUvroHgbKXSVESvwwSazvG2oPE1gd7BSRV
	 ZbAdLbmphPQk4a97uH5fGuhrJGbu/eucyHC3OH6HsjVXh2hQdyUWSt7tAfIvg/0cLJ
	 HM4E0pFg4A4WMSB272CXdbOZnFs7/uSmm4xk3pflVZbIfqS90xTg8Utj2+LuCvl+JF
	 0A64mD1S5fSAw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org
Subject: [PATCH v1 1/1] x86/fred: Set SS to __KERNEL_DS when enabling FRED
Date: Fri, 16 Aug 2024 03:43:16 -0700
Message-ID: <20240816104316.2276968-1-xin@zytor.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SS is initialized to NULL during boot time and not *explicitly* set to
__KERNEL_DS.

With FRED enabled, if a kernel event is delivered before a CPU goes to
user level for the first time, its SS is NULL thus NULL is pushed into
the SS field of the FRED stack frame.  But before ERETS is executed,
the CPU may context switch to another task and go to user level.  Then
when the CPU comes back to kernel mode, SS is changed to __KERNEL_DS.
Later when ERETS is executed to return from the kernel event handler,
a #GP fault is generated because SS doesn't match the SS saved in the
FRED stack frame.

Initialize SS to __KERNEL_DS when enabling FRED to avoid such #GPs.

Note, IRET doesn't check if SS matches the SS saved in its stack frame,
thus IDT doesn't have this problem.  For IDT it doesn't matter whether
SS is set to __KERNEL_DS or not, because it's set to NULL upon interrupt
or exception delivery and __KERNEL_DS upon SYSCALL.  Thus it's pointless
to initialize SS for IDT.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/kernel/fred.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 99a134fcd5bf..266c69e332a4 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -26,6 +26,20 @@ void cpu_init_fred_exceptions(void)
 	/* When FRED is enabled by default, remove this log message */
 	pr_info("Initialize FRED on CPU%d\n", smp_processor_id());
 
+	/*
+	 * If a kernel event is delivered before a CPU goes to user level for
+	 * the first time, its SS is NULL thus NULL is pushed into the SS field
+	 * of the FRED stack frame.  But before ERETS is executed, the CPU may
+	 * context switch to another task and go to user level.  Then when the
+	 * CPU comes back to kernel mode, SS is changed to __KERNEL_DS.  Later
+	 * when ERETS is executed to return from the kernel event handler, a #GP
+	 * fault is generated because SS doesn't match the SS saved in the FRED
+	 * stack frame.
+	 *
+	 * Initialize SS to __KERNEL_DS when enabling FRED to avoid such #GPs.
+	 */
+	loadsegment(ss, __KERNEL_DS);
+
 	wrmsrl(MSR_IA32_FRED_CONFIG,
 	       /* Reserve for CALL emulation */
 	       FRED_CONFIG_REDZONE |

base-commit: a97756cbec448032f84b5bbfe4e101478d1e01e0
-- 
2.46.0



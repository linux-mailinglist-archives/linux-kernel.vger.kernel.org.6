Return-Path: <linux-kernel+bounces-532530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCAA44EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAD818957B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5696C1C5D56;
	Tue, 25 Feb 2025 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EymTiIzi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788D211A07
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519161; cv=none; b=GK2QJBNuMuARysGWFm1BLuFIL5SsogYcYdTZmq4wi0xuX8v+IiyVLutY338zptO3Zr7BCmIeBVGxGilLcWXscHoJ5T0RkvDjkCRyLwAkXrOTY/tCc1lLzCf6gAOZXp2YBYLqSIpMfhFSdf8eBGnUuKhiEhbK28X6p41X5gpuZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519161; c=relaxed/simple;
	bh=QsXx8hv4dHpsWFfNbCo6d4M5NjQQqjTrtRkdRqcGzP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NKLBA/aJuzUhnxcSsxSUe3koGlnAxlIdO803Km3M3wRssjK/fwCUWDJumOWTuGKR1ka7skUL8jr0PgKrX5LVh/2Z7HbGa75yBKh2tQx//OeM+Y3ncw3486yAAWDzkPnVPvY3upL96g4mWJAg2ATbSmqK+8QBOQo+UbgAPP/FTtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EymTiIzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CC4C4CEDD;
	Tue, 25 Feb 2025 21:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740519161;
	bh=QsXx8hv4dHpsWFfNbCo6d4M5NjQQqjTrtRkdRqcGzP4=;
	h=From:To:Cc:Subject:Date:From;
	b=EymTiIziC3/RFm7NPx3b+fy7j9kGk/cNosDbdOuIJ9BnX0uHXi9aeJupJhR+VtSuz
	 33XGsj6JbQm+vvhE3yF65D+2ospQwoD3+8PRC3Pt64uyFLwGbQw0v7v/5lZbbL4Epf
	 ePmZ5HLlWRDaNBL43M1catPDgyBIqleC572GQ8Yii3AMR9LymBO8kkF3zrdfESlEcF
	 +DV8j3DMogArksPSZZZgaRvAa6mgF0xFNKdNB49Z1YWMHn2wIMhgV4c2JBu+oJ+a7J
	 avNeGLh4boj//D2bqjqE8PsIOuUiETLrPIEdsLLdgS07OtDOE16wSu1LPnQiGsqNXZ
	 075eId5IYsAtQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86: irq: define trace events conditionally
Date: Tue, 25 Feb 2025 22:32:33 +0100
Message-Id: <20250225213236.3141752-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When both of X86_LOCAL_APIC and X86_THERMAL_VECTOR are disabled,
the irq tracing produces a W=1 build warning for the tracing
definitions:

In file included from include/trace/trace_events.h:27,
                 from include/trace/define_trace.h:113,
                 from arch/x86/include/asm/trace/irq_vectors.h:383,
                 from arch/x86/kernel/irq.c:29:
include/trace/stages/init.h:2:23: error: 'str__irq_vectors__trace_system_name' defined but not used [-Werror=unused-const-variable=]

Make the tracepoints conditional on the same symbosl that guard
their usage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 385e3a5fc304..feca4f20b06a 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -25,8 +25,10 @@
 #include <asm/posted_intr.h>
 #include <asm/irq_remapping.h>
 
+#if defined(CONFIG_X86_LOCAL_APIC) || defined(CONFIG_X86_THERMAL_VECTOR)
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
+#endif
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
-- 
2.39.5



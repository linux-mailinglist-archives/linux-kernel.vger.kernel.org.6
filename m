Return-Path: <linux-kernel+bounces-434883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 401329E6C4E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1D31888B58
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE46F200B85;
	Fri,  6 Dec 2024 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHXbDXNb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB820011B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481052; cv=none; b=KVVM8L3BldWhDEEFJVtMm5XDFvyC8TWnuGscdBoi99tyIXWNTRL0g+EuUKpYccfidZtMcFVE8Qdly1LlhVCfV3ITI8qRhhbdIVnOjRNSNi8EPphDlUhxRl9Pp2QLQWavRabaBE+8EUZcxfCnd2YcDRPfZvjiv3er51MangCSdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481052; c=relaxed/simple;
	bh=TdCiC4trXOaAjQ2GPqcynMhXgfPnYYs71r34sk+/ehY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCIy0IiJaDrotwbvA4A/I/2iVcAV6joFgOKhfzuDKxDWHSbTbOizeLQZlJglmZgm1fHG8hIq+Bw72ACq50hbPWD5pKYKh49w0J887f39vE94Lzub1APhcgi6NbxpBG0fNP5++iVDdCWHhANFmN17OBlCYifLUbs/DZTxsTaVrK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHXbDXNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70309C4CED1;
	Fri,  6 Dec 2024 10:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733481051;
	bh=TdCiC4trXOaAjQ2GPqcynMhXgfPnYYs71r34sk+/ehY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHXbDXNbqwt10mM+0PfYXJhxeUGnOnVvX34tA7McqewHigm9ARhSJvWdc98i2mSUR
	 N+zQJoDiOYTM82/Zr01RFBOe4dF/6vjIti91vRhUkgfE2SfXEKybgjraEH0vpMSqfQ
	 1C4fpSiBUL5BSNC++5+z3bAWgAiYhUQrhyy2EObx38pP0d+PGE+LsahneiRbWzv9mh
	 xDHvlqIrkFttXYi3nekxx2hfRXA7P2PESZiVa6PzjoTfSfUOR1A68eQdajgdZ0KAOA
	 tmXnKFzf7X6VX18qD+BZmhO5QkFC5VM4XB29u3NT2F5NLhNTmZU26z/kCpnYfwzO5g
	 zG1FzNEhTuW5Q==
From: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ning Sun <ning.sun@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	tboot-devel@lists.sourceforge.net
Subject: [PATCH v2 2/4] x86/boot: split kernel resources setup into a helper function
Date: Fri,  6 Dec 2024 12:30:29 +0200
Message-ID: <20241206103031.737458-3-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206103031.737458-1-rppt@kernel.org>
References: <20241206103031.737458-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Makes setup_arch a bit easier to comprehend.

No functional changes.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/kernel/setup.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 2383e73fc140..c34316a12897 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -524,6 +524,23 @@ void __init reserve_standard_io_resources(void)
 
 }
 
+static void __init setup_kernel_resources(void)
+{
+	code_resource.start = __pa_symbol(_text);
+	code_resource.end = __pa_symbol(_etext)-1;
+	rodata_resource.start = __pa_symbol(__start_rodata);
+	rodata_resource.end = __pa_symbol(__end_rodata)-1;
+	data_resource.start = __pa_symbol(_sdata);
+	data_resource.end = __pa_symbol(_edata)-1;
+	bss_resource.start = __pa_symbol(__bss_start);
+	bss_resource.end = __pa_symbol(__bss_stop)-1;
+
+	insert_resource(&iomem_resource, &code_resource);
+	insert_resource(&iomem_resource, &rodata_resource);
+	insert_resource(&iomem_resource, &data_resource);
+	insert_resource(&iomem_resource, &bss_resource);
+}
+
 static bool __init snb_gfx_workaround_needed(void)
 {
 #ifdef CONFIG_PCI
@@ -842,15 +859,6 @@ void __init setup_arch(char **cmdline_p)
 		root_mountflags &= ~MS_RDONLY;
 	setup_initial_init_mm(_text, _etext, _edata, (void *)_brk_end);
 
-	code_resource.start = __pa_symbol(_text);
-	code_resource.end = __pa_symbol(_etext)-1;
-	rodata_resource.start = __pa_symbol(__start_rodata);
-	rodata_resource.end = __pa_symbol(__end_rodata)-1;
-	data_resource.start = __pa_symbol(_sdata);
-	data_resource.end = __pa_symbol(_edata)-1;
-	bss_resource.start = __pa_symbol(__bss_start);
-	bss_resource.end = __pa_symbol(__bss_stop)-1;
-
 	/*
 	 * x86_configure_nx() is called before parse_early_param() to detect
 	 * whether hardware doesn't support NX (so that the early EHCI debug
@@ -894,11 +902,11 @@ void __init setup_arch(char **cmdline_p)
 	tsc_early_init();
 	x86_init.resources.probe_roms();
 
-	/* after parse_early_param, so could debug it */
-	insert_resource(&iomem_resource, &code_resource);
-	insert_resource(&iomem_resource, &rodata_resource);
-	insert_resource(&iomem_resource, &data_resource);
-	insert_resource(&iomem_resource, &bss_resource);
+	/*
+	 * Add resources for kernel text and data to the iomem_resource.
+	 * Do it after parse_early_param, so it can be debugged.
+	 */
+	setup_kernel_resources();
 
 	e820_add_kernel_range();
 	trim_bios_range();
-- 
2.45.2



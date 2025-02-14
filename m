Return-Path: <linux-kernel+bounces-514641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9DDA359AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9493AD78D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AB422D7A0;
	Fri, 14 Feb 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/aMYHmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364822333E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524029; cv=none; b=ZvJj1fIhK9Ch9FRvOAGlK4WtuNMixnkge9aVN430jUKAH2wS5iVl312FO9HN+HBEtc60IWdlW2seBv0ktiDxPgg+C4z5rRHxBHuga9fftRg2RYx5BIR8+TMQkBJzGd8kxz4Inl5ZDBb491tkBikCGOpLK5c7/WaFVchChjTqMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524029; c=relaxed/simple;
	bh=JBOCSEE2UFn2Mr+tW+G9E3WK4Id0nTUslPRT+LCjlO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYL+OCCCmCW0sF66xoKb7MZx/HYdU3RFadCfNF7tZetUe5VfzjCR1yJnaJOyUNumCngL8KCWwu2X94KRKit1Ez89CU56xJXWifU6ABIEs2UIFxmgRG/7ifzi7gkG9ldF6II+SfaEZ9ydPuQeN7p0j6Bctj74x73Weih8myREdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/aMYHmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EB4C4CED1;
	Fri, 14 Feb 2025 09:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739524029;
	bh=JBOCSEE2UFn2Mr+tW+G9E3WK4Id0nTUslPRT+LCjlO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/aMYHmAF7zXztPDyAwgYfwNCW2vmWaYmKokDIt/nzkXBNrZPsSKUvNwG6FTyTglC
	 8xzbeAPUIsHl91YslgBcQsbfqB5VR2pjzn4LDsp7nHP0WvEu34brRy7gMYxRnFZ6WJ
	 uAVCTYEjbgGubFlMnbb1WIEMj/jGb2gcsGRVzCHsOTwTyxb54iXH8swGhEEkSRPm+8
	 6BhyxRFKxmtby+3h4lCH5tZwJEQ07UI9BBkPVJTfeZx4hQd2wkBBUMDRSkoA6b6kMp
	 Arp6ELnb4c4HHl2vAvu0tUwhlMruAyM1q6AeLkIAOYPzSuCJ1bktuZqGzOPx7aG5Vu
	 aAXCc2FwWRTqw==
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
Subject: [RESEND PATCH v2 2/4] x86/boot: split kernel resources setup into a helper function
Date: Fri, 14 Feb 2025 11:06:49 +0200
Message-ID: <20250214090651.3331663-3-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214090651.3331663-1-rppt@kernel.org>
References: <20250214090651.3331663-1-rppt@kernel.org>
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
index 4baadeab8a2e..3d95946ab749 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -527,6 +527,23 @@ void __init reserve_standard_io_resources(void)
 
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
@@ -845,15 +862,6 @@ void __init setup_arch(char **cmdline_p)
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
@@ -897,11 +905,11 @@ void __init setup_arch(char **cmdline_p)
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
2.47.2



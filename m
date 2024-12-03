Return-Path: <linux-kernel+bounces-429349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D848E9E1AD7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF1B1670AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1782B1E3DD1;
	Tue,  3 Dec 2024 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5GfogGW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA32E3EE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225146; cv=none; b=j4aABlkURwn7lESAvzJzzmpq/JZj7OF0byHPvaZUuO/rxOHVrw2DLnHi8432y9WD8eCYzIG0IsB3ZM7pWSZJ8pxM4uEsP7Rlbk6g41aJPNuaxngNF3+a62HHWYb8i13E7aGNun72YT7pIPfMuWR/OhvXLWcrk7cyG0KAgIlDjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225146; c=relaxed/simple;
	bh=3brcZlN/EtB22P7W8O0IwuXGJUL7oNC1W0BKB52By/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3K5WjVk5gVlPn++TkvV+RlOlRIut2qMSyQIJWbX8cOdIctAQmkxcLM78nzhjl/huvfizW/kpJIZQMFBpYtQcjDulMhcHPPgewSEWHgWGhp6eGdIdY7IxQ233vKTKpIgYnWyUYVcDrScq71jHoTRqLW+/lUHjt1QsE/fLfUrDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5GfogGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3749C4CED6;
	Tue,  3 Dec 2024 11:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733225146;
	bh=3brcZlN/EtB22P7W8O0IwuXGJUL7oNC1W0BKB52By/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S5GfogGWhCZPHYq13El1AEJ5HDv15Aycf1xsynvjR4ldQpkMkx+IFP1YJqZZrusnT
	 3uwjoF5tRyoa/S2wesrD8J1HQrvSa1/GViwuLFvts4lR+ZM8q/9UqQLRpdw52gg0ry
	 eckRioLRwBkLOPhbY664bjZxZ9oMUxGhM/jbpoTK4JMz0+mn6zBXEkej1eNl2soUi6
	 NEhFOKYfXglEp/8bgkg9ti3UclTy9BBIYsp60GlvnC8dCuwZ7v6FwPzFiHDgQ8l127
	 CnwQoA6MlEh9FHmmWY6aG2OPBtWlB84g8lUGW+4XHT3Jn18vsySOFOsnpesjXfLB/j
	 swGXpOV6m1YOw==
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
Subject: [PATCH 2/4] x86/boot: split kernel resources setup into a helper function
Date: Tue,  3 Dec 2024 13:25:23 +0200
Message-ID: <20241203112525.591496-3-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203112525.591496-1-rppt@kernel.org>
References: <20241203112525.591496-1-rppt@kernel.org>
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
index 2383e73fc140..d299fe5bda25 100644
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
+	 * Add resources for kernel text and data to the iomem_resource
+	 * Do it eafter parse_early_param, so could debug it
+	 */
+	setup_kernel_resources();
 
 	e820_add_kernel_range();
 	trim_bios_range();
-- 
2.45.2



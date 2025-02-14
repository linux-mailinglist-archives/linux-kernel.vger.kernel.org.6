Return-Path: <linux-kernel+bounces-514640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91651A359A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CD53ADCDF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865C322D785;
	Fri, 14 Feb 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTxvwHqi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8022D4F9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524026; cv=none; b=F2cJOfumiGSWE0G6Q9YTgS/rLXeocJbhLM15dzl4ZOpSgynBjcg7znfi8O33wJsL13KJJ9Uz9i41I2AtU1SIneYXS12JYrHaljyqHDmLX4VHceM2LblIGwCRjfMHwFOPFSxhs5S5NPtkQ8BxeJr/mV07GvqYT+B5r/2Ou/8a7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524026; c=relaxed/simple;
	bh=VY5cC0OoCHotTTh2bcJ4AeYC0N/aiMEZXSr5lf6qmUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQmcecFwmiNtZ6HZsQZpbSQpmq7QwBFPcHNPtnQm8eVSX2k2kmWmqqUiHyWFhyg/aBX0i5RZkZlCoj6dqSAgMRuXU/WD1wJhjsEBFwciZW74aCuAods14jXAX3d9SKZRIeTha+3f04/9HY+sCOpso8JJNbON5sHxFoDGLsP2WMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTxvwHqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE96C4CEDF;
	Fri, 14 Feb 2025 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739524025;
	bh=VY5cC0OoCHotTTh2bcJ4AeYC0N/aiMEZXSr5lf6qmUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTxvwHqiRGf1kGHE5okKZoB3eZhB8Fyu6VPQTx3MO7VMl1rWT7+t9gd5mHuTx/sJm
	 KR0ycYlWdjX8/88Sg9Sf1GIhuilwv6tYTRbooWigXCKpgsmvu7eyfwMnyqsz8fzAgJ
	 HAzeSyXURUZqGDbLlohAJeP0/no1x/z6eLx7DMVlgz+ZrzmLuC+ZCBD37dwzLqrTrn
	 9C4jR+65jSUW03p4pJK5tymKSlcWBCEQ4cqMRdEeFDY0GnO6xEFm/FnBU1tEDkpHHX
	 a1J79cj9umO9s7VgSKfovEmo9dszNPGB+S/RazXkc4J/tNVtFheKQz43qn3OtBfmw/
	 Piudi6JV9sU+A==
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
Subject: [RESEND PATCH v2 1/4] x86/boot: move setting of memblock parameters to e820__memblock_setup()
Date: Fri, 14 Feb 2025 11:06:48 +0200
Message-ID: <20250214090651.3331663-2-rppt@kernel.org>
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

Changing memblock parameters, namely bottom_up and allocation upper
limit does not have any effect before memblock initialization in
e820__memblock_setup().

Move the calls to memblock_set_bottom_up() and memblock_set_current_limit()
to e820__memblock_setup() to group all the memblock initial setup and make
setup_arch() more readable.

No functional changes.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/kernel/e820.c  | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/setup.c | 25 -------------------------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 82b96ed9890a..8d8bd039d2ac 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1302,6 +1302,36 @@ void __init e820__memblock_setup(void)
 	int i;
 	u64 end;
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+	/*
+	 * Memory used by the kernel cannot be hot-removed because Linux
+	 * cannot migrate the kernel pages. When memory hotplug is
+	 * enabled, we should prevent memblock from allocating memory
+	 * for the kernel.
+	 *
+	 * ACPI SRAT records all hotpluggable memory ranges. But before
+	 * SRAT is parsed, we don't know about it.
+	 *
+	 * The kernel image is loaded into memory at very early time. We
+	 * cannot prevent this anyway. So on NUMA system, we set any
+	 * node the kernel resides in as un-hotpluggable.
+	 *
+	 * Since on modern servers, one node could have double-digit
+	 * gigabytes memory, we can assume the memory around the kernel
+	 * image is also un-hotpluggable. So before SRAT is parsed, just
+	 * allocate memory near the kernel image to try the best to keep
+	 * the kernel away from hotpluggable memory.
+	 */
+	if (movable_node_is_enabled())
+		memblock_set_bottom_up(true);
+#endif
+
+	/*
+	 * At this point only the first megabyte is mapped for sure, the
+	 * rest of the memory cannot be used for memblock resizing
+	 */
+	memblock_set_current_limit(ISA_END_ADDRESS);
+
 	/*
 	 * The bootstrap memblock region count maximum is 128 entries
 	 * (INIT_MEMBLOCK_REGIONS), but EFI might pass us more E820 entries
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cebee310e200..4baadeab8a2e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -866,30 +866,6 @@ void __init setup_arch(char **cmdline_p)
 	if (efi_enabled(EFI_BOOT))
 		efi_memblock_x86_reserve_range();
 
-#ifdef CONFIG_MEMORY_HOTPLUG
-	/*
-	 * Memory used by the kernel cannot be hot-removed because Linux
-	 * cannot migrate the kernel pages. When memory hotplug is
-	 * enabled, we should prevent memblock from allocating memory
-	 * for the kernel.
-	 *
-	 * ACPI SRAT records all hotpluggable memory ranges. But before
-	 * SRAT is parsed, we don't know about it.
-	 *
-	 * The kernel image is loaded into memory at very early time. We
-	 * cannot prevent this anyway. So on NUMA system, we set any
-	 * node the kernel resides in as un-hotpluggable.
-	 *
-	 * Since on modern servers, one node could have double-digit
-	 * gigabytes memory, we can assume the memory around the kernel
-	 * image is also un-hotpluggable. So before SRAT is parsed, just
-	 * allocate memory near the kernel image to try the best to keep
-	 * the kernel away from hotpluggable memory.
-	 */
-	if (movable_node_is_enabled())
-		memblock_set_bottom_up(true);
-#endif
-
 	x86_report_nx();
 
 	apic_setup_apic_calls();
@@ -990,7 +966,6 @@ void __init setup_arch(char **cmdline_p)
 
 	cleanup_highmap();
 
-	memblock_set_current_limit(ISA_END_ADDRESS);
 	e820__memblock_setup();
 
 	/*
-- 
2.47.2



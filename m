Return-Path: <linux-kernel+bounces-429348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0617A9E1AD4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE09D284A89
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476041E3DF7;
	Tue,  3 Dec 2024 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJIQqbil"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519E2E3EE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225142; cv=none; b=e+9TWEAzOR1iJrR1kGHa3yVA2zAHz/F5Bc5VDjthXvGiwuqyAkm4i8ct2bCeokSqILIIz1zsWaIBIyHZTtAMHV+u/TIrNz7QycF/2zPTw0pBqzfOhKleOYkPsH8w9R/Xn5fFN8tkOEoNMAGaQRySu7PL03BQAss393BRBXJUecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225142; c=relaxed/simple;
	bh=QkAEFz3xw+ZBO/hWpzE/zygn3rvqxAe60reWmHTa+Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sd85MK3gyBT6oj0Ff63rjlhZjqRRubNqB6mQSckFZdF/xGW9THJjZRdyhVowmizPdfIzWVhfI92i6D+qrtnEC6wVYKVw/FqdDYO90cwS/RbMOrFYWx2DrwS2FXBgydG80TTZ8yq8hiXxd8ajJVICy8eco6J3J+Zm8La8HETg0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJIQqbil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AEDC4CECF;
	Tue,  3 Dec 2024 11:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733225142;
	bh=QkAEFz3xw+ZBO/hWpzE/zygn3rvqxAe60reWmHTa+Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJIQqbilwbDRAf2Qi7IqCKrKmuVyC+st/e8ziD/oIVRrrAExgrL64rad62hYsJATQ
	 s36tR9X6EJZ0Vq/xvpgDoEbX9b8tVX6dqP44gXe4WbgbtnI75T45drSexWBnHwXthB
	 ckVSK3N1yL20PaRsrM7uXWbrZ+WUmOlo9kgvf8gWP1e9jZX4YH9nZEKRjEuSb9Z0pk
	 YdAmy29HT83WNVAWNWU+tGfttpZKvsYk3+qULi7wt2QvA2rW/uIsykFv4AoSwV1j8j
	 j/OakJI0vCiYhqu72Y7+NPBzDf5YDDwShKj8iFZbnL4k1NgsFzejsMsXD6YKvoZFe3
	 0kt2wy73nvpzg==
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
Subject: [PATCH 1/4] x86/boot: move setting of memblock parameters to e820__memblock_setup()
Date: Tue,  3 Dec 2024 13:25:22 +0200
Message-ID: <20241203112525.591496-2-rppt@kernel.org>
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
index 4893d30ce438..cb9985fd3881 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1305,6 +1305,36 @@ void __init e820__memblock_setup(void)
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
index f1fea506e20f..2383e73fc140 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -863,30 +863,6 @@ void __init setup_arch(char **cmdline_p)
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
@@ -987,7 +963,6 @@ void __init setup_arch(char **cmdline_p)
 
 	cleanup_highmap();
 
-	memblock_set_current_limit(ISA_END_ADDRESS);
 	e820__memblock_setup();
 
 	/*
-- 
2.45.2



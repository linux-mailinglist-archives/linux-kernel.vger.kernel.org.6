Return-Path: <linux-kernel+bounces-434882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E3D9E6C45
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C24A28A507
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C8E200103;
	Fri,  6 Dec 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHDRxMNa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA520011B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481048; cv=none; b=RpOyZR+USVa5WiaPeq0ADco72ulvtwWlDpVAseTnrppGr20RZZYJXWbGVJMmkUvBUfpPloxHHvf9T1IXiChIfsrvT8BYF0jYpgvFQsJyJ4niEMPENBPlJBkD2kihRgOMHRILCvj2YYtmBSxjLv7n51xr5CynYcr5+r7fTWpnVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481048; c=relaxed/simple;
	bh=QkAEFz3xw+ZBO/hWpzE/zygn3rvqxAe60reWmHTa+Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evFXWSFJdXV5FVsLjkQ2YOOZOKC9C+3u9H3GxcISzfA2/pfN8C5LaCiaPIIecM1sQ/YSIJzikkhOcZo4NBhv9MwBIuPtaqiogKecuVq6UAx5XwygNGgKOfvJw2pcrtRBbzGFcu4z6BNPt2+GcVN+hJgLaNZUTW0bpAh7OoY+3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHDRxMNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94536C4CEDD;
	Fri,  6 Dec 2024 10:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733481047;
	bh=QkAEFz3xw+ZBO/hWpzE/zygn3rvqxAe60reWmHTa+Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHDRxMNarJS5HBmSR4ql1xNEjdir/QtVjY3D1n1S0A2ZVdBZJ9Mu5/g42pWeGnNJf
	 aYIEKcROUMOBw66nzhvPgrUD/gCKP3cQsVIFlvaazvuPPJQGrXTEKWuGOYNNHfj371
	 /hzNMEF23xU/UaiftPCNsQa6FPGgNX+6YHzS1IS9fI81RMd93MzYTN/QGL7vtCibKR
	 XVzefVwKNENGhYSt87x7Ijq5QAQ0GJgpOQi2iSuq59tumKHIZHkypCkjfLSSoO5M7y
	 pvC54Y0IpiavV3TjzGU+4isTwv2+3ZzsMlgdnmC+kGHEfpMBUHoiOKj2lO2CPAexcC
	 s+HcXniCoeuCw==
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
Subject: [PATCH v2 1/4] x86/boot: move setting of memblock parameters to e820__memblock_setup()
Date: Fri,  6 Dec 2024 12:30:28 +0200
Message-ID: <20241206103031.737458-2-rppt@kernel.org>
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



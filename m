Return-Path: <linux-kernel+bounces-561045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E6A60CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CCD19C1FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A28F1DF963;
	Fri, 14 Mar 2025 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNrmi20F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73213541B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943660; cv=none; b=RxKLupG8n4FbTwjTM+hzrRQY+KFv6UTSOeJJsmgJ91RfPsIy4Nsr42u5ULKo7JgPpSxSwOTugWZ1sZUdNNW/C9J1Av7TaWOEa9lniwV0TmiY4ZCG+p/EBC0od0TOSxIPpxVSuiRcm7lvJz9H9+0RlbIyPbxRFCZpkMa/l0p9N/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943660; c=relaxed/simple;
	bh=yWdsovVXoJ8xVmJBCdB3UBfkVvPv+VF6t7+dFWYz7Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uUfxswsj4yoj0iw/bqF6yNl43vJB4atO7nffFCt7bX3YolFwUOmNOEURaOVoarLSASrzGgYM3SX4fueE7H5dGlM5zeD/F313T2JIeqkWt5cF+ILwKE5ZDWvARxC4Uf5GJ+EAT0RvQ9B64gobv5hRDNEdVDvegw/tP/UglyN6hlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNrmi20F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7BCC4CEE3;
	Fri, 14 Mar 2025 09:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741943659;
	bh=yWdsovVXoJ8xVmJBCdB3UBfkVvPv+VF6t7+dFWYz7Yo=;
	h=Date:From:To:Cc:Subject:From;
	b=kNrmi20F06kegZUj6qTqit+FX3s7ZAdcv6rZOmkYRHxB/EUH+WBawvfQeMLYnUXnr
	 u0pjcMLbzK7wuqx1KWAGsTbtWs1V97Q8COW8YNwsGHzmvTCFl2n6QWrvNFSqJFndeg
	 GEskk0N0sbbXoU0x80MUloBsQJxDZDk7MuGSKHwgYjVOw6/d5dDeF1x5h2vNpqBk5G
	 ahmOD2qXfy69UvfxaoUZ+CpAS29zDLq0xURuzMwbFMZ2n3zYsRptz26ZF6FKARa8WK
	 Uar3ggGPrZyEj1ckfQ0acfh6vN+wXnnA70zNxYOzW4riXkPIF4uhjUdsczLuXaPSKa
	 uhbSuDBz0KQvw==
Date: Fri, 14 Mar 2025 10:14:14 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fix
Message-ID: <Z9PzZnXjnMnWFym9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-03-14

   # HEAD: a2ab25529bbcea51b5e01dded79f45aeb94f644a x86/vmware: Parse MP tables for SEV-SNP enabled guests under VMware hypervisors

Fix the bootup of SEV-SNP enabled guests under VMware hypervisors.

 Thanks,

	Ingo

------------------>
Ajay Kaher (1):
      x86/vmware: Parse MP tables for SEV-SNP enabled guests under VMware hypervisors


 arch/x86/kernel/cpu/vmware.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 00189cdeb775..cb3f900c46fc 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -26,6 +26,7 @@
 #include <linux/export.h>
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
+#include <linux/efi.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
 #include <asm/div64.h>
@@ -429,6 +430,9 @@ static void __init vmware_platform_setup(void)
 		pr_warn("Failed to get TSC freq from the hypervisor\n");
 	}
 
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !efi_enabled(EFI_BOOT))
+		x86_init.mpparse.find_mptable = mpparse_find_mptable;
+
 	vmware_paravirt_ops_setup();
 
 #ifdef CONFIG_X86_IO_APIC


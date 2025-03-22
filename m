Return-Path: <linux-kernel+bounces-572541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8FEA6CB43
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1273C189AFDC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F7231A24;
	Sat, 22 Mar 2025 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b="MzHAif0d"
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6994A05
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.222.135.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658372; cv=none; b=bIVlvYMNUDQu1vcJY73nKFtS1MtXlnobfppjacGEBPxl8pTwZe0uMOr8ZWrg9CEH09dHqGGNPdxqvoWwO2ui8222VJLJjsyyM+5lgYKPzJQCPcvIJXmhP08yxAlBCvbf4GvlT4lG9UBSxPKvPxcZFXdZaMdxs/LkeZ4qQHGsh+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658372; c=relaxed/simple;
	bh=SuzvMPktzoydjCyL0FwpRFaRBIUwk4cAP6JvclOH7xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4XW9v2B/S4AHIfwztViYXLwn3axI5QXh+gks2ckhXWisi9Kg2wDaMC3OCYEJvdAn0OlybWl8WFwqHZZ7NHoAl+Yjlo2NpPmmvZYvQdHvykH9O2npfcEiiczUs7EAcoI+CXIU995lWdQ4T9Jgbbc/rP05FsySfwHGByAiS3tUG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl; spf=pass smtp.mailfrom=o2.pl; dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b=MzHAif0d; arc=none smtp.client-ip=193.222.135.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 45669 invoked from network); 22 Mar 2025 16:46:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=20241105;
          t=1742658366; bh=RrZUUnezMD9sA4ZZ1DlOQpAlOKevEYBgM8pi3Xou/vg=;
          h=From:To:Cc:Subject;
          b=MzHAif0d8A70zpmtUSoD5/fqBHlZ8anW+VUNUxeeuAiKYzuV+etj7+tqeRcaxz6wS
           PMZ7dUCfgTdKo+xxlRz+uWDuMmPz2HgFg85d2HTJiU08t48uqJRZ60ZCXC7rF9SNlU
           q1WgjEArHzgKYKGuxrH14nlH1NOx8lzIDPOS3kLmdc3uI4fH3yH9Qsj873ssT0XwrA
           NKa4+QBg6BuhX2y/xNaYfFyxsYhcu8nYgwfyOX4OQdhuNQxWYFIvhqnfWgSAG0r4Na
           oudzYrME4w9ODhvF26L8FET6xdSkUuYnRMcgK85/qkT2VQutPm3eSzJLRHUvEDn3K0
           2cyJ8Ds3FC2KA==
Received: from apn-78-30-75-41.dynamic.gprs.plus.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[78.30.75.41])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <x86@kernel.org>; 22 Mar 2025 16:46:06 +0100
From: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	David Heidelberg <david@ixit.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/Kconfig: correct X86_X2APIC help text
Date: Sat, 22 Mar 2025 16:45:41 +0100
Message-Id: <20250322154541.40325-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321-x86_x2apic-v3-1-b0cbaa6fa338@ixit.cz>
References: <20250321-x86_x2apic-v3-1-b0cbaa6fa338@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 3b34c97aa0aaf5ce3c954b86151f96a9
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000005 [Qaat]                               

Currently, it is not true that the kernel will panic with CONFIG_X86_X2APIC=n
on systems that require it; it will try to disable the APIC and run without
it to at least give the user a clear warning message. See the second
variant of check_x2apic() in arch/x86/kernel/apic/apic.c .

Also massage some other parts of the help text.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Fixes: 9232c49ff31c ("x86/Kconfig: Enable X86_X2APIC by default and improve help text")
Cc: David Heidelberg <david@ixit.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>

---

This patch fixes a patch currently in tip.git master and depends on it.

I have not verified recently that the kernel will work at all without
CONFIG_X86_X2APIC on systems which force enable it - but it was working
in 2022.
---
 arch/x86/Kconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e72cb7779038..ef48584c8889 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -471,14 +471,15 @@ config X86_X2APIC
 	  in 2019, but it can be disabled by the BIOS. It is also frequently
 	  emulated in virtual machines, even when the host CPU does not support
 	  it. Support in the CPU can be checked by executing
-		cat /proc/cpuinfo | grep x2apic
+		grep x2apic /proc/cpuinfo
 
-	  If this configuration option is disabled, the kernel will not boot on
-	  some platforms that have x2APIC enabled.
+	  If this configuration option is disabled, the kernel will boot with
+	  very reduced functionality and performance on some platforms that
+	  have x2APIC enabled. On the other hand, on hardware that does not
+	  support x2APIC, a kernel with this option enabled will just fallback
+	  to older APIC implementations.
 
-	  Say N if you know that your platform does not have x2APIC.
-
-	  Otherwise, say Y.
+	  If in doubt, say Y.
 
 config X86_POSTED_MSI
 	bool "Enable MSI and MSI-x delivery by posted interrupts"
-- 
2.25.1



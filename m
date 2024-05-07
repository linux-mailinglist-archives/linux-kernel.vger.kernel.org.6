Return-Path: <linux-kernel+bounces-170695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4808BDAAF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0C01F254A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B26F066;
	Tue,  7 May 2024 05:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prRdCP2g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE576E602
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715059817; cv=none; b=RhmYhY7L8I+pPRZZHrW1mbGWou0h8uSpXBdOoi3eVt8HD199V1LyWj7HpqyI4Q2rVx3dtjSINMn3JIJlwabNzJV1Yv4sQigtuwrP3CfGTzmPYXQFbVMkyHz+dwb73c87dVhQQuNdo0u3ajJ2lzJeegP5wUILVwFNhQkhl/Nzjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715059817; c=relaxed/simple;
	bh=rjjbb87qU0Az3V5tnqRivUixNJ5fK4IwNpaXSwSoEyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHj6Jsum50M97HoKti/tR+BeUX8U1Ov49g8pDkz/kpGFE5GOE9fbVMswY8/GkTKeEJV0+pFFaGoShGzqTVUrAKGXGDrKC0qQ2DmWbXA1f5+rNTG+uJ5RdSi9cQ2NSohjA92eiUw3Hc0WtPo2cPU3TaOEwpxKODKe9D5I/bdMEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prRdCP2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958C1C4AF65;
	Tue,  7 May 2024 05:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715059817;
	bh=rjjbb87qU0Az3V5tnqRivUixNJ5fK4IwNpaXSwSoEyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=prRdCP2g1WIHQ6TnRGJ6c13LybTEElCD1qSCXAh1DwIp1eLggps4Ipp1zdZ/QCsLG
	 Zlj29uzTwEjaAXplnphLtVCnNc0NMpvhlAPk11Rsx/fQBesEl0feWPHW1uY/OI4sBD
	 jzUbNKk1xIr/tPPFe/k4JMHudCfCXtUGlP28GjTaAKc5FNs+cIsvMo9I4bxNlSdhjJ
	 PihDmFqvhphN1nXSiZpnNPUhb65kkKPt1SdaQMpWkLf+tsora9Mf0ekmuMJs2ji6Ol
	 WoFy0nh7J6I7W/CQq3Y5gVis5sJMfHmOKStLF3BvNB7H5esJ9GRIm/VToFvtgrn7hj
	 x42M3c+sU1wwg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>,
	Maksim Davydov <davydov-max@yandex-team.ru>
Subject: [PATCH v5 3/3] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
Date: Mon,  6 May 2024 22:30:06 -0700
Message-ID: <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715059256.git.jpoimboe@kernel.org>
References: <cover.1715059256.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cloud environments it can be useful to *only* enable the vmexit
mitigation and leave syscalls vulnerable.  Add that as an option.

This is similar to the old spectre_bhi=auto option which was removed
with the following commit:

  36d4fe147c87 ("x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto")

with the main difference being that this has a more descriptive name and
is disabled by default.

Requested-by: Maksim Davydov <davydov-max@yandex-team.ru>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 +++++++++---
 arch/x86/kernel/cpu/bugs.c                      | 16 +++++++++++-----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 213d0719e2b7..9c1f63f04502 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6072,9 +6072,15 @@
 			deployment of the HW BHI control and the SW BHB
 			clearing sequence.
 
-			on   - (default) Enable the HW or SW mitigation
-			       as needed.
-			off  - Disable the mitigation.
+			on     - (default) Enable the HW or SW mitigation as
+				 needed.  This protects the kernel from
+				 both syscalls and VMs.
+			vmexit - On systems which don't have the HW mitigation
+				 available, enable the SW mitigation on vmexit
+				 ONLY.  On such systems, the host kernel is
+				 protected from VM-originated BHI attacks, but
+				 may still be vulnerable to syscall attacks.
+			off    - Disable the mitigation.
 
 	spectre_v2=	[X86,EARLY] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ab18185894df..6974c8c9792d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1625,6 +1625,7 @@ static bool __init spec_ctrl_bhi_dis(void)
 enum bhi_mitigations {
 	BHI_MITIGATION_OFF,
 	BHI_MITIGATION_ON,
+	BHI_MITIGATION_VMEXIT_ONLY,
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
@@ -1639,6 +1640,8 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 		bhi_mitigation = BHI_MITIGATION_OFF;
 	else if (!strcmp(str, "on"))
 		bhi_mitigation = BHI_MITIGATION_ON;
+	else if (!strcmp(str, "vmexit"))
+		bhi_mitigation = BHI_MITIGATION_VMEXIT_ONLY;
 	else
 		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
 
@@ -1659,19 +1662,22 @@ static void __init bhi_select_mitigation(void)
 			return;
 	}
 
+	/* Mitigate in hardware if supported */
 	if (spec_ctrl_bhi_dis())
 		return;
 
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
-	/* Mitigate KVM by default */
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
-	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
+	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
+		pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit only\n");
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
+		return;
+	}
 
-	/* Mitigate syscalls when the mitigation is forced =on */
+	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall and vm exit\n");
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
-	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
+	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
 }
 
 static void __init spectre_v2_select_mitigation(void)
-- 
2.44.0



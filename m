Return-Path: <linux-kernel+bounces-230107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC42B917872
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C3C1C222B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A13614D2B7;
	Wed, 26 Jun 2024 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAMRDTZF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6075F14AD1A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719381735; cv=none; b=RYRQ4Ar3iWghMQGRZiLl9Xu6xUgqcGcmsjrMWL5/qVFjEltYsr9yNEPLIrClz/rA3RgZtcsL3YHIZQaZaY20fF0jjwY04aB3/cjllpJfUbARNvtDgD2eME8uUHqopRX5SY/btAQorMUZwZGajjjcROKg5Zgvao4LckKjmysVVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719381735; c=relaxed/simple;
	bh=k+dtPWzbOil1sgDKHTHJbXRZWoGn2dqcKS5r+PR978U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/nnrO9zl35Nc6KqM7yO5Mz3iCltncy+vvYSGBkhMjwB6p3533P9iO1uPPKb5v6A1ZS1dL0aELptV+rWm4lWlfzuDOpZCDO+SYVlboUKuXFrtNn1GicIa1a7RVq47ZSAGcF4hwJigPe+xymvbfJkjmiPHr5rVRxxVhhAcxoqFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAMRDTZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04632C4AF0F;
	Wed, 26 Jun 2024 06:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719381735;
	bh=k+dtPWzbOil1sgDKHTHJbXRZWoGn2dqcKS5r+PR978U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAMRDTZFcCNUVbNB55B/ickGz8X62DAu0mm5AGOndWUZmagWDpnUzcZ5O52LhdfyY
	 p+CoBsaU2jbbpLsNA2CKaDfkKm4Eqac4rTS8NsKr+Q+eloIJ3K5CSeawAu1cD7ucuV
	 4evnJn9nbdEv7bKZs1qk8g058f1cL8fvFEpODndobhFuawW3Up7FcfbiSJlnbOJ+kQ
	 6QTXZkivJbKFVCTYSpXk15T763eUeSxx3vKZnfQWpRAKcO/icFs5Lm16PGpI6CP3uu
	 fMjIpToH9J46lvsTkt8YcoUbfB3lkOQVMNL6FcbYEU6VT9Kyd4hjplt8NF3WaPujAt
	 wSxVlUAD07mAQ==
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
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v6 2/3] x86/bugs: Remove duplicate Spectre cmdline option descriptions
Date: Tue, 25 Jun 2024 23:02:01 -0700
Message-ID: <450b5f4ffe891a8cc9736ec52b0c6f225bab3f4b.1719381528.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1719381528.git.jpoimboe@kernel.org>
References: <cover.1719381528.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Duplicating the documentation of all the Spectre kernel cmdline options
in two separate files is unwieldy and error-prone.  Instead just add a
reference to kernel-parameters.txt from spectre.rst.

Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 Documentation/admin-guide/hw-vuln/spectre.rst | 86 +++----------------
 1 file changed, 10 insertions(+), 76 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 25a04cda4c2c..132e0bc6007e 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -592,85 +592,19 @@ Spectre variant 2
 Mitigation control on the kernel command line
 ---------------------------------------------
 
-Spectre variant 2 mitigation can be disabled or force enabled at the
-kernel command line.
+In general the kernel selects reasonable default mitigations for the
+current CPU.
 
-	nospectre_v1
+Spectre default mitigations can be disabled or changed at the kernel
+command line with the following options:
 
-		[X86,PPC] Disable mitigations for Spectre Variant 1
-		(bounds check bypass). With this option data leaks are
-		possible in the system.
+	- nospectre_v1
+	- nospectre_v2
+	- spectre_v2={option}
+	- spectre_v2_user={option}
+	- spectre_bhi={option}
 
-	nospectre_v2
-
-		[X86] Disable all mitigations for the Spectre variant 2
-		(indirect branch prediction) vulnerability. System may
-		allow data leaks with this option, which is equivalent
-		to spectre_v2=off.
-
-
-        spectre_v2=
-
-		[X86] Control mitigation of Spectre variant 2
-		(indirect branch speculation) vulnerability.
-		The default operation protects the kernel from
-		user space attacks.
-
-		on
-			unconditionally enable, implies
-			spectre_v2_user=on
-		off
-			unconditionally disable, implies
-		        spectre_v2_user=off
-		auto
-			kernel detects whether your CPU model is
-		        vulnerable
-
-		Selecting 'on' will, and 'auto' may, choose a
-		mitigation method at run time according to the
-		CPU, the available microcode, the setting of the
-		CONFIG_MITIGATION_RETPOLINE configuration option,
-		and the compiler with which the kernel was built.
-
-		Selecting 'on' will also enable the mitigation
-		against user space to user space task attacks.
-
-		Selecting 'off' will disable both the kernel and
-		the user space protections.
-
-		Specific mitigations can also be selected manually:
-
-                retpoline               auto pick between generic,lfence
-                retpoline,generic       Retpolines
-                retpoline,lfence        LFENCE; indirect branch
-                retpoline,amd           alias for retpoline,lfence
-                eibrs                   Enhanced/Auto IBRS
-                eibrs,retpoline         Enhanced/Auto IBRS + Retpolines
-                eibrs,lfence            Enhanced/Auto IBRS + LFENCE
-                ibrs                    use IBRS to protect kernel
-
-		Not specifying this option is equivalent to
-		spectre_v2=auto.
-
-		In general the kernel by default selects
-		reasonable mitigations for the current CPU. To
-		disable Spectre variant 2 mitigations, boot with
-		spectre_v2=off. Spectre variant 1 mitigations
-		cannot be disabled.
-
-	spectre_bhi=
-
-		[X86] Control mitigation of Branch History Injection
-		(BHI) vulnerability.  This setting affects the deployment
-		of the HW BHI control and the SW BHB clearing sequence.
-
-		on
-			(default) Enable the HW or SW mitigation as
-			needed.
-		off
-			Disable the mitigation.
-
-For spectre_v2_user see Documentation/admin-guide/kernel-parameters.txt
+For more details on the available options, refer to Documentation/admin-guide/kernel-parameters.txt
 
 Mitigation selection guide
 --------------------------
-- 
2.45.1



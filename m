Return-Path: <linux-kernel+bounces-230108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBAF917873
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92D1B22EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1177614F9E0;
	Wed, 26 Jun 2024 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmr7lgFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9DD14D447
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719381736; cv=none; b=patFyJ4VZihfdN5388NTGAu6xTpJNLc8RD9tMofuxNfzoBuvnZEW4+a01uvoYtcZldRRii2LoljoNU66B5IlRy1AqY6/V07eHQcYUHnFpL9OLJy+PvcVDapFv1PEzNOq1phz1vfeDBv1RZkBz8CETv6Ek/FgMcC/nRQQg08zZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719381736; c=relaxed/simple;
	bh=2YVTDZYyZc5toIi6/I5KvVx6buG4jkWRmRMdivrW5yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjThSpwbE4LxDj6QVDKP4twTwoq7TM0ge+v7V9qwRkSK8WVcsSPpGnm8zZ+dBW8N6VxuxMxok1bxLl48X5jQkXskiE/yz+XFVDKuyBw7Xr2VtSJ7UEhUVSCf0eqMGEhwdnv14vvP9R738WGz1+XzVqEs78/ZSL5Q2QUSoMBakN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmr7lgFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270D5C4AF07;
	Wed, 26 Jun 2024 06:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719381735;
	bh=2YVTDZYyZc5toIi6/I5KvVx6buG4jkWRmRMdivrW5yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmr7lgFp/4VuoKNtB/Gz+oFsiKhrh7YqV2vjDYNcku2YIKq+e8Ag5tAVD/91XDpue
	 +kAPuKXe78aXPFRNm8xSIp7IGzw0lfvhdGJCUOmBRw63kSXEjjg7hM7agsU+NkKdVG
	 OervrTjUYlWbV+j5R3ygIbOFMeh1PdMSLOcTjFguK0m5imR8EHXsHdbUVT4ZVo9Zde
	 PtmuXpdl3hfkSVgxf4ub9P3Jw0R8nfovrzjqWQIohsbODG+McwFBHoPO7dTyeQL7kT
	 JD/vfXRt78fWMPKn/87EIX6F7qpOuc8AU5p3NBOEY3HS4sUEHHi5WK9YO0hrwXKeDq
	 oSnHH66gh67dQ==
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
Subject: [PATCH v6 3/3] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
Date: Tue, 25 Jun 2024 23:02:02 -0700
Message-ID: <2cbad706a6d5e1da2829e5e123d8d5c80330148c.1719381528.git.jpoimboe@kernel.org>
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

In cloud environments it can be useful to *only* enable the vmexit
mitigation and leave syscalls vulnerable.  Add that as an option.

This is similar to the old spectre_bhi=auto option which was removed
with the following commit:

  36d4fe147c87 ("x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto")

with the main difference being that this has a more descriptive name and
is disabled by default.

Requested-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 +++++++++---
 arch/x86/kernel/cpu/bugs.c                      | 16 +++++++++++-----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11e57ba2985c..ddf4eff727ab 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6136,9 +6136,15 @@
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
index b6f927f6c567..94bcf29df465 100644
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
2.45.1



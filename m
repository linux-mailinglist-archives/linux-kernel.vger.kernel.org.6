Return-Path: <linux-kernel+bounces-224612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9F69124C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D76285F13
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA201174EEB;
	Fri, 21 Jun 2024 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If3dWySM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706B1527B6;
	Fri, 21 Jun 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971682; cv=none; b=C1Y74X7c51c8B83CLAs+YqA82Yyi1fO3s5lHtUL0LK99m/WGy6Dv4hOXc6wlNVfhI/pRRHaWQ2tmBXqUBtIcU5yOrFP0JgORX3xsKATt/0gjuNKe4Sm0cqVSc9RNuE01Xe52O2nF8g7UbSpJ+M7XbkDjApT2He3RQpd/YwgkqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971682; c=relaxed/simple;
	bh=P7yQsP2EdAv8XJS2w3pZ/D+CDZqz6T57I2/snHYfelo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UTy8c6AsvqKYOTcyMHbOM8W3PguYujYESv0zvPJg6s36OhV543Kq5KXrm9wA2q+387PMix95z7/thKQHJ2fHBcUfwKZckR2VIKON9+uAf83XvQJlQ7y5QXdH3w3XIbobH1QNzb/LihfCxIOC5NsaaM0lDUY6JclZIek5Lxlti1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If3dWySM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB73C2BBFC;
	Fri, 21 Jun 2024 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718971680;
	bh=P7yQsP2EdAv8XJS2w3pZ/D+CDZqz6T57I2/snHYfelo=;
	h=From:To:Cc:Subject:Date:From;
	b=If3dWySMO4bhvWkBHcVDU+HkAxUPjSmGyxB3aObUBzvQFDmie7YSAdFdnKJzfRbB9
	 8wT4906NyuyldVJNFGU2bnTBBCWJeuNMSvQDaMf+7cXgoYrFnXUmPAIkmmOi7h4nvr
	 ZjTMD15nY9nJMm1skC93FqeOKmc5qkodCX8W/NnDhOYT+skGpGkE4saQt07DkcdYD8
	 ekroCYqQQTPq9/7IL4q+R7fReEYeW9o7bvjKgzm6+JxrS+SkHEqH2YnJ0VbiYkzeWR
	 ftKe/Ibm5egfQg/0JJ+/rw3ogwPR16ykPZQ7R+FiCeFU4CBhkY88PhUwEs7olzKDWR
	 WuBostcgwQdWg==
From: Amit Shah <amit@kernel.org>
To: x86@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: amit.shah@amd.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	kim.phillips@amd.com,
	david.kaplan@amd.com
Subject: [PATCH] KVM: SVM: let alternatives handle the cases when rsb filling is required
Date: Fri, 21 Jun 2024 14:07:43 +0200
Message-ID: <20240621120743.59330-1-amit@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amit Shah <amit.shah@amd.com>

This patch removes superfluous RSB filling after a VMEXIT when the CPU
already has flushed the RSB after a VMEXIT.

The initial implementation for adding RETPOLINES added an ALTERNATIVES
implementation for filling the RSB after a VMEXIT in

commit 117cc7a908c836 ("x86/retpoline: Fill return stack buffer on vmexit")

Later, X86_FEATURE_RSB_VMEXIT was added in

commit 2b129932201673 ("x86/speculation: Add RSB VM Exit protections")

The AutoIBRS (on AMD CPUs) feature implementation added in

commit e7862eda309ecf ("x86/cpu: Support AMD Automatic IBRS")

used the already-implemented logic for EIBRS in
spectre_v2_determine_rsb_fill_type_on_vmexit() -- but did not update the
code at VMEXIT to act on the mode selected in that function -- resulting
in VMEXITs continuing to clear the RSB when RETPOLINES are enabled,
despite the presence of AutoIBRS.

Signed-off-by: Amit Shah <amit.shah@amd.com>
---
 arch/x86/kvm/svm/vmenter.S | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index a0c8eb37d3e1..2ed80aea3bb1 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -209,10 +209,8 @@ SYM_FUNC_START(__svm_vcpu_run)
 7:	vmload %_ASM_AX
 8:
 
-#ifdef CONFIG_MITIGATION_RETPOLINE
 	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
-	FILL_RETURN_BUFFER %_ASM_AX, RSB_CLEAR_LOOPS, X86_FEATURE_RETPOLINE
-#endif
+	FILL_RETURN_BUFFER %_ASM_AX, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT
 
 	/* Clobbers RAX, RCX, RDX.  */
 	RESTORE_HOST_SPEC_CTRL
@@ -348,10 +346,8 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 
 2:	cli
 
-#ifdef CONFIG_MITIGATION_RETPOLINE
 	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
-	FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_FEATURE_RETPOLINE
-#endif
+	FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT
 
 	/* Clobbers RAX, RCX, RDX, consumes RDI (@svm) and RSI (@spec_ctrl_intercepted). */
 	RESTORE_HOST_SPEC_CTRL
-- 
2.45.2



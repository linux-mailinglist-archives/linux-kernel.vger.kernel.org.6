Return-Path: <linux-kernel+bounces-418752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A579D6515
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7247282D57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AEC185935;
	Fri, 22 Nov 2024 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXo0msdE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029CC4A0C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309632; cv=none; b=nZaqdnUetgW5uE7EFwmaMn6Ivw/HKpJyecZuDz6ERw2iAmxu2ydVvGALK8F/K2tCglaXkEMBdfm/BwvDNsdh5sP/nx2QDoxEG0Ga0n0kVpKbLKPM0gULui9zb7KOPLy6lxBXyZ8EY2A5amcpNwadvBx8TRWxLdVsR2XLykcsM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309632; c=relaxed/simple;
	bh=3qhg2k6JiEwKQWFh2LzVnW3aZTztGwmmg0YUgGjAsvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAO5UPtNtMPFp7So9gNQlev63ypg4YohxwLhUEfRJAUEEZqq+cdkL0W3Y9EX1h7UhLXc4Z+hoeueG1nBPbvCqSk9c3nD/ikIYSudVZivjZWr5LyCqL4AfSTOXO2TaB+e6DuwtrMKFtANoNCxtvNjuu5eSHr0AFtz2I4rnHViQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXo0msdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A0BC4CECE;
	Fri, 22 Nov 2024 21:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732309631;
	bh=3qhg2k6JiEwKQWFh2LzVnW3aZTztGwmmg0YUgGjAsvU=;
	h=From:To:Cc:Subject:Date:From;
	b=JXo0msdETVurbWQZyJSlspm/l9IOBA9+GT/2ETiWAW+M60vZhBLy5lWlmXnIfgzFu
	 EgdBtZqtcvnQVlBGXuqnJHzm7Pt23QszMTzaBb9NKyo2li7LSnFii5BlEebf8MOFTe
	 6bk2t8014AQTNN3hPquJb3q5xJA1L1+3tf2mrsN7PPxw4q7h5/3HWGjrQ2kTd6o3Aq
	 MLX4efSlyDhxRw9cbhKnpMeMQxcHZ6azPGsAIFl4/2oJZ2t4/waP0Mlp2RCm/BjDWh
	 4GM8utfZ6LQFUMB96lEqqgLo5EIm5HzYEojf7y8b3gpwI0BU4N8CO8HTYENsG8UcOy
	 TtWLSfUl5sFlw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] x86/cpufeatures: Remove "AMD" from the comments to the AMD-specific leaf
Date: Fri, 22 Nov 2024 22:07:07 +0100
Message-ID: <20241122210707.12742-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

0x8000001f.EAX is an AMD-specific leaf so there's no need to have "AMD"
in almost every feature's comment. Zap it and make the text more
readable this way.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeatures.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ea33439a5d00..c2674834106e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -440,14 +440,14 @@
 #define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* Speculative Store Bypass Disable */
 
 /* AMD-defined memory encryption features, CPUID level 0x8000001f (EAX), word 19 */
-#define X86_FEATURE_SME			(19*32+ 0) /* "sme" AMD Secure Memory Encryption */
-#define X86_FEATURE_SEV			(19*32+ 1) /* "sev" AMD Secure Encrypted Virtualization */
+#define X86_FEATURE_SME			(19*32+ 0) /* "sme" Secure Memory Encryption */
+#define X86_FEATURE_SEV			(19*32+ 1) /* "sev" Secure Encrypted Virtualization */
 #define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* VM Page Flush MSR is supported */
-#define X86_FEATURE_SEV_ES		(19*32+ 3) /* "sev_es" AMD Secure Encrypted Virtualization - Encrypted State */
-#define X86_FEATURE_SEV_SNP		(19*32+ 4) /* "sev_snp" AMD Secure Encrypted Virtualization - Secure Nested Paging */
+#define X86_FEATURE_SEV_ES		(19*32+ 3) /* "sev_es" Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_SEV_SNP		(19*32+ 4) /* "sev_snp" Secure Encrypted Virtualization - Secure Nested Paging */
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
-#define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
-#define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_SME_COHERENT	(19*32+10) /* hardware-enforced cache coherency */
+#define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" SEV-ES full debug state swap support */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
-- 
2.43.0



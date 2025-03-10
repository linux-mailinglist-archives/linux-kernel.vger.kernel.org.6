Return-Path: <linux-kernel+bounces-554290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B5EA595CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B626F188E848
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB2822D4E1;
	Mon, 10 Mar 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPZ1YSnU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A13E22CBF5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612293; cv=none; b=lCNpsawEPE3extke+cGP/93bShwn5FN2Do7X9Uac48ZnQkGh9H4772B+PXa5afXXF3Y0rwOsSK/wzECQbwUEF2utzjP7z22/yKk0PYgbrk8GwvT3cvOK8HT+/5y9XrRxldQPdTxL6zx+eYLic1HS2rBjnOOwyhO0r/pR6d4NYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612293; c=relaxed/simple;
	bh=1sPXlOrJgc2EhQcV6hft1tTfyoeXcFPRPvUKeNq3yfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=heam2Moy7az7O+9cL9jIjujSbybkLkvy7kTl9qF90fS8ov8l0o4gK/r1y7motjFKg0F5j+5EqITREIohdsRduzN2p/zCGEYk919eYyp8gamoiGn5IWreolv0n/D9q3UogMaeJJ5To1Q5WkZOWsGex0VxmXSAJhr781j1yZwpYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPZ1YSnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D68FC4CEE5;
	Mon, 10 Mar 2025 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741612292;
	bh=1sPXlOrJgc2EhQcV6hft1tTfyoeXcFPRPvUKeNq3yfc=;
	h=From:To:Cc:Subject:Date:From;
	b=dPZ1YSnU9FAWDhgF5MpWC2QUKcwHi8O/O44pcdb6Y4xZMroJUgsrfUYBNqZrmR6pX
	 PBLqx1N2G3o6b8OnKK75BK4mwy+TUwr0a/gqmah5J8OPlav60yad9do9sXSMoB0PGD
	 xsI408VzkRITOmrxSIPGJPk6KXE4tVsL0I5L1V8KMHC0Nb+xLpFLRdA8qE3ycd+GJ/
	 je8x7THwni+aqlXIyVCQKHqWJ0M3SeOsDzo9uVdSPVjX+Ui4fd8wMflQx/ciMCCQla
	 38aUdhYQqvTkx+p4hckgf09D9TJ02ZpM6rIN5eKbBepSGuRPWk43g/eMDQaYWomk9X
	 sswaWhlWhbsiA==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	Juergen Gross <jgross@suse.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] x86: coco: replace static const cc_mask with a function
Date: Mon, 10 Mar 2025 14:10:59 +0100
Message-Id: <20250310131114.2635497-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When extra warnings are enabled, the cc_mask definition in asm/coco.h
causes a build failure with gcc:

arch/x86/include/asm/coco.h:28:18: error: 'cc_mask' defined but not used [-Werror=unused-const-variable=]
   28 | static const u64 cc_mask = 0;

Add a cc_get_mask() function mirroring cc_set_mask() for the one
user of the variable outside of the coco implementation.

Fixes: a0a8d15a798b ("x86/tdx: Preserve shared bit on mprotect()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--
v2: use an inline helper instead of a __maybe_unused annotaiton.
---
 arch/x86/include/asm/coco.h          | 10 +++++++++-
 arch/x86/include/asm/pgtable_types.h |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index aa6c8f8ca958..e7225452963f 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -15,6 +15,11 @@ enum cc_vendor {
 extern enum cc_vendor cc_vendor;
 extern u64 cc_mask;
 
+static inline u64 cc_get_mask(void)
+{
+	return cc_mask;
+}
+
 static inline void cc_set_mask(u64 mask)
 {
 	RIP_REL_REF(cc_mask) = mask;
@@ -25,7 +30,10 @@ u64 cc_mkdec(u64 val);
 void cc_random_init(void);
 #else
 #define cc_vendor (CC_VENDOR_NONE)
-static const u64 cc_mask = 0;
+static inline u64 cc_get_mask(void)
+{
+	return 0;
+}
 
 static inline u64 cc_mkenc(u64 val)
 {
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index c90e9c51edb7..74d461cc8e20 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -179,7 +179,7 @@ enum page_cache_mode {
 };
 #endif
 
-#define _PAGE_CC		(_AT(pteval_t, cc_mask))
+#define _PAGE_CC		(_AT(pteval_t, cc_get_mask()))
 #define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
 
 #define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)
-- 
2.39.5



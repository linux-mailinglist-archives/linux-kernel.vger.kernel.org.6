Return-Path: <linux-kernel+bounces-363887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD2E99C828
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C8A28C93E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A086A1CF7AE;
	Mon, 14 Oct 2024 11:01:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41F41CF5C6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903696; cv=none; b=F92Tmu6kq7cdwnUJmaED4vIucBEbORorUw96ROcmrJ4KhfB6Dz+SW0qyrjzFMnG+8qI6G4hdFuJ59jmvSI+J/IPRxUtdcNhh4Xhu3oue7QwOea3Vqh7yGfSam56A4cgP2d53alQbFWgLOrWkD2TgTLsEj2QxADXVzbpszQd4Xx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903696; c=relaxed/simple;
	bh=/ZHyHtxcZoPFWLCTpNj9MSXJ1mm2JtsMGiDaZkCQeKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+8YKopb+COa+Yki0Vbdm5CFoD1tGJHfWM3RLzODhWlkm7G+3lgBwtJSnmzCmST1FD+/stbH8D8zaxMNT9nkibWkhWZ6ZEXI69biKgHVYeiYNM3U7bceEVMIAyiU/5GI0NPh6mDG/s8Dnea2E3wXihqcCAzP5/0N4MOz8E0ZcTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C45931758;
	Mon, 14 Oct 2024 04:02:03 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C54893F51B;
	Mon, 14 Oct 2024 04:01:31 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 41/57] arm64: Pass desired page size on command line
Date: Mon, 14 Oct 2024 11:58:48 +0100
Message-ID: <20241014105912.3207374-41-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow user to pass desired page size via command line as either
"arm64.pagesize=4k", "arm64.pagesize=16k", or "arm64.pagesize=64k". The
specified value is stored in the SW_FEATURE register as an encoded page
shift in a 4 bit field.

We only allow setting the page size override if the requested size is
supported by the HW and is within the compile-time [PAGE_SIZE_MIN,
PAGE_SIZE_MAX] range. This second condition means that overrides get
ignored when we have a compile-time page size (because PAGE_SIZE_MIN ==
PAGE_SIZE_MAX).

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/include/asm/cpufeature.h   | 11 ++++++++
 arch/arm64/kernel/pi/idreg-override.c | 36 +++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 5584342672715..4edbb586810d7 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -18,6 +18,7 @@
 #define ARM64_SW_FEATURE_OVERRIDE_NOKASLR	0
 #define ARM64_SW_FEATURE_OVERRIDE_HVHE		4
 #define ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF	8
+#define ARM64_SW_FEATURE_OVERRIDE_PAGESHIFT	12
 
 #ifndef __ASSEMBLY__
 
@@ -963,6 +964,16 @@ static inline bool arm64_test_sw_feature_override(int feat)
 					    &arm64_sw_feature_override);
 }
 
+static inline int arm64_pageshift_cmdline(void)
+{
+	int val;
+
+	val = arm64_apply_feature_override(0,
+					   ARM64_SW_FEATURE_OVERRIDE_PAGESHIFT,
+					   4, &arm64_sw_feature_override);
+	return val ? val * 2 + 10 : 0;
+}
+
 static inline bool kaslr_disabled_cmdline(void)
 {
 	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOKASLR);
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index 29d4b6244a6f6..5a38bdb231bc8 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -183,6 +183,38 @@ static bool __init hvhe_filter(u64 val)
 						     ID_AA64MMFR1_EL1_VH_SHIFT));
 }
 
+static bool __init pageshift_filter(u64 val)
+{
+	u64 mmfr0 = read_sysreg_s(SYS_ID_AA64MMFR0_EL1);
+	u32 tgran64 = SYS_FIELD_GET(ID_AA64MMFR0_EL1, TGRAN64, mmfr0);
+	u32 tgran16 = SYS_FIELD_GET(ID_AA64MMFR0_EL1, TGRAN16, mmfr0);
+	u32 tgran4 = SYS_FIELD_GET(ID_AA64MMFR0_EL1, TGRAN4, mmfr0);
+
+	/* pageshift is stored compressed in 4 bit field. */
+	if (val)
+		val = val * 2 + 10;
+
+	if (val < PAGE_SHIFT_MIN || val > PAGE_SHIFT_MAX)
+		return false;
+
+	if (val == ARM64_PAGE_SHIFT_64K &&
+	    tgran64 >= ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN &&
+	    tgran64 <= ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX)
+		return true;
+
+	if (val == ARM64_PAGE_SHIFT_16K &&
+	    tgran16 >= ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN &&
+	    tgran16 <= ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX)
+		return true;
+
+	if (val == ARM64_PAGE_SHIFT_4K &&
+	    tgran4 >= ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN &&
+	    tgran4 <= ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX)
+		return true;
+
+	return false;
+}
+
 static const struct ftr_set_desc sw_features __prel64_initconst = {
 	.name		= "arm64_sw",
 	.override	= &arm64_sw_feature_override,
@@ -190,6 +222,7 @@ static const struct ftr_set_desc sw_features __prel64_initconst = {
 		FIELD("nokaslr", ARM64_SW_FEATURE_OVERRIDE_NOKASLR, NULL),
 		FIELD("hvhe", ARM64_SW_FEATURE_OVERRIDE_HVHE, hvhe_filter),
 		FIELD("rodataoff", ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF, NULL),
+		FIELD("pageshift", ARM64_SW_FEATURE_OVERRIDE_PAGESHIFT, pageshift_filter),
 		{}
 	},
 };
@@ -225,6 +258,9 @@ static const struct {
 	{ "rodata=off",			"arm64_sw.rodataoff=1" },
 	{ "arm64.nolva",		"id_aa64mmfr2.varange=0" },
 	{ "arm64.no32bit_el0",		"id_aa64pfr0.el0=1" },
+	{ "arm64.pagesize=4k",		"arm64_sw.pageshift=1" },
+	{ "arm64.pagesize=16k",		"arm64_sw.pageshift=2" },
+	{ "arm64.pagesize=64k",		"arm64_sw.pageshift=3" },
 };
 
 static int __init parse_hexdigit(const char *p, u64 *v)
-- 
2.43.0



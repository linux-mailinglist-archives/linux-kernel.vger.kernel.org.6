Return-Path: <linux-kernel+bounces-531255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C331AA43E27
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FE67A4DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C976A267B73;
	Tue, 25 Feb 2025 11:46:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB7126657B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484011; cv=none; b=QevQhihYiFJK0Y6MxagtRx19OErdXaDL2J4pFrBLsetzSYWi+u2VbYhRZGUptjZR2nvZh32CwS53hEs8VTTupxiCEkVAQ24By5gkG5/gZd2NaLmFKwim05njcRESVzVhtTCTdnjZ5YoeK9gkRqCuzTmlUlkmzYQ9NrBGhXVyS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484011; c=relaxed/simple;
	bh=ZsEQIftbTmVerN7S6MZlM8FeIPYbmhoavD4Mxnf7fJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWJp4+SC2j/ERqiubAhWLfloPg1rkp4XLcIG234guuUsnPiqWwA4lNgoOSYQ7WzK41dtMZAj8cj9F3Me3YQpaIpEYMNTTcy2Z36CGGzesJQioVCN+JnVmCQXBovwk3TD7L/LxM+u6j3TaLknm0NnijmGE8Tz9AF3TMLaSDzoJv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E6031516;
	Tue, 25 Feb 2025 03:47:05 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D51453F5A1;
	Tue, 25 Feb 2025 03:46:47 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Luiz Capitulino <luizcap@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
Date: Tue, 25 Feb 2025 11:46:36 +0000
Message-ID: <20250225114638.2038006-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the range of present physical memory is sufficiently small enough
and the reserved address space for the linear map is sufficiently large
enough, The linear map base address is randomized in
arm64_memblock_init().

Prior to commit 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and
use it consistently"), we decided if the sizes were suitable with the
help of the raw mmfr0.parange. But the commit changed this to use the
sanitized version instead. But the function runs before the register has
been sanitized so this returns 0, interpreted as a parange of 32 bits.
Some fun wrapping occurs and the logic concludes that there is enough
room to randomize the linear map base address, when really there isn't.
So the top of the linear map ends up outside the reserved address space.

Fix this by intoducing a helper, cpu_get_parange() which reads the raw
parange value and overrides it with any early override (e.g. due to
arm64.nolva).

Reported-by: Luiz Capitulino <luizcap@redhat.com>
Closes: https://lore.kernel.org/all/a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com/
Fixes: 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and use it consistently")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

This applies on top of v6.14-rc4. I'm hoping this can be merged for v6.14 since
it's fixing a regression introduced in v6.14-rc1.

Luiz, are you able to test this to make sure it's definitely fixing your
original issue. The symptom I was seeing was slightly different.

I'm going to see if it's possible for read_sanitised_ftr_reg() to warn about use
before initialization. I'll send a follow up patch for that.

Thanks,
Ryan


 arch/arm64/include/asm/cpufeature.h | 9 +++++++++
 arch/arm64/mm/init.c                | 8 +-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index e0e4478f5fb5..2335f44b9a4d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -1066,6 +1066,15 @@ static inline bool cpu_has_lpa2(void)
 #endif
 }

+static inline u64 cpu_get_parange(void)
+{
+	u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
+
+	return arm64_apply_feature_override(mmfr0,
+					    ID_AA64MMFR0_EL1_PARANGE_SHIFT, 4,
+					    &id_aa64mmfr0_override);
+}
+
 #endif /* __ASSEMBLY__ */

 #endif
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9c0b8d9558fc..1b1a61191b9f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -280,13 +280,7 @@ void __init arm64_memblock_init(void)
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		extern u16 memstart_offset_seed;

-		/*
-		 * Use the sanitised version of id_aa64mmfr0_el1 so that linear
-		 * map randomization can be enabled by shrinking the IPA space.
-		 */
-		u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
-		int parange = cpuid_feature_extract_unsigned_field(
-					mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
+		int parange = cpu_get_parange();
 		s64 range = linear_region_size -
 			    BIT(id_aa64mmfr0_parange_to_phys_shift(parange));

--
2.43.0



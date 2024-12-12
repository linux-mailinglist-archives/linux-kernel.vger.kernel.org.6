Return-Path: <linux-kernel+bounces-443323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5949EED47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276A918834E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF89522332A;
	Thu, 12 Dec 2024 15:40:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA262210F8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018031; cv=none; b=ttHgzrLOYZ/eoYdoK+J/8UIKFBtnQzxPfvQY9CXGnzj45fSaB/SBGOOfGcoMH0eU4HqwZ8KCXZAOPlIHBGvYC/2ZxH/oq8zm5BIInw5uWyi94g0t/SWkHEz2b+N8nd8jMzdd4IVHWae64SDjiP9sL8mggkdh7DcvTAS36+0sBpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018031; c=relaxed/simple;
	bh=bSOvre0t58j/TqCqbTNcdA73MRdp/l8UblSimqiQj8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tn/UengDdE2dt7jpl3cohe3cexsccxg4pSw+aSEq2HQsoKuC7JE+b6fUmEy9Ij+VxLEnBMRYl9+bBhzDOVIedBHLPvJ8E6z7fZ//e5XjieQLs6hMJroUc3kZ1c4+Iolg3n3xyuOGu/GU88gPpHURp4qheyJ3poD+XCWvgMGuSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1936176C;
	Thu, 12 Dec 2024 07:40:56 -0800 (PST)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0E123F720;
	Thu, 12 Dec 2024 07:40:27 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Zeng Heng <zengheng4@huawei.com>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>
Subject: [RFC PATCH 3/6] arm_mpam: Delete unused function resctrl_arch_set_rmid()
Date: Thu, 12 Dec 2024 15:39:57 +0000
Message-Id: <20241212154000.330467-4-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212154000.330467-1-Dave.Martin@arm.com>
References: <20241212154000.330467-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function resctrl_arch_set_rmid() appears to have been left
behind after earlier refactoring and is now unused.

To avoid needing to answer awkward questions about how this
function should apply partition ID namespace remappings, just get
rid of it.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

I'm assuming here that there are no pending branches that implement /
use this function.

When moving tasks between monitoring groups, resctrlfs currently
extracts the CLOSID from struct rdtgroup and passes it explicitly
to resctrl_arch_set_closid_rmid(), so there seems to be no need for
a separate helper that doesn't overwrite the arch's control
partition identifier.
---
 arch/arm64/include/asm/mpam.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/include/asm/mpam.h b/arch/arm64/include/asm/mpam.h
index e5f385767174..df725d2d9d05 100644
--- a/arch/arm64/include/asm/mpam.h
+++ b/arch/arm64/include/asm/mpam.h
@@ -93,20 +93,6 @@ static inline u64 mpam_get_regval(struct task_struct *tsk)
 #endif
 }
 
-static inline void resctrl_arch_set_rmid(struct task_struct *tsk, u32 rmid)
-{
-#ifdef CONFIG_ARM64_MPAM
-	u64 regval = mpam_get_regval(tsk);
-
-	regval &= ~MPAM1_EL1_PMG_D;
-	regval &= ~MPAM1_EL1_PMG_I;
-	regval |= FIELD_PREP(MPAM1_EL1_PMG_D, rmid);
-	regval |= FIELD_PREP(MPAM1_EL1_PMG_I, rmid);
-
-	WRITE_ONCE(task_thread_info(tsk)->mpam_partid_pmg, regval);
-#endif
-}
-
 static inline void mpam_thread_switch(struct task_struct *tsk)
 {
 	u64 oldregval;
-- 
2.34.1



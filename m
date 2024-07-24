Return-Path: <linux-kernel+bounces-260644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB68193AC56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815481F2413E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 05:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B58E3FE4A;
	Wed, 24 Jul 2024 05:46:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3BB5695
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721799994; cv=none; b=N0Ls26qswJq7b2q6FR+Mx5W1HvpYb7Jv/tfs4C+/xyI96F7CMz6vYwalc+QJRZGsBcdQ+o0yzxHW8FtuAEGr4DxOCpZA6TIdrWQQEo6ykuz/c8ttgR78L4oIHkdGedh4xmrw6/dqku/pUkzdOsGSZyg8h8QLWmVdCFvvjPNPDfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721799994; c=relaxed/simple;
	bh=2sgPD8xMawfaUe5M4mi0VSlquAoqCB7ijM3djXbkjds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aOssnoE4VlNEupwDgqmDs4wezlUGqIdms+x8/K90BnlHxs+Y6QXqVz+Ue8HOTDzEmy0DZwTmgpoDz15suqELNV00zq95/J0Zg4gahUmndY+zCD9A40QOEJlTUaHVk+lpNjTeAa4TjJVFl1LERCZtyF3qsCMo63uNLI9FRE5PMyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65DEF106F;
	Tue, 23 Jul 2024 22:46:57 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.54.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECDA13F5A1;
	Tue, 23 Jul 2024 22:46:28 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: Replace compared GIC version with ID_AA64PFR0_EL1_GIC_V4P1
Date: Wed, 24 Jul 2024 11:16:23 +0530
Message-Id: <20240724054623.667595-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open encoding for GIC version code with ID_AA64PFR0_EL1_GIC_V4P1 in
gic_cpuif_has_vsgi().

Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Applies after the following patch that fixes the given field in tools sysreg.

https://lore.kernel.org/all/20240718215532.616447-1-rananta@google.com/

 drivers/irqchip/irq-gic-v4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index ca32ac19d284..58c28895f8c4 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -97,7 +97,7 @@ bool gic_cpuif_has_vsgi(void)
 
 	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64PFR0_EL1_GIC_SHIFT);
 
-	return fld >= 0x3;
+	return fld >= ID_AA64PFR0_EL1_GIC_V4P1;
 }
 #else
 bool gic_cpuif_has_vsgi(void)
-- 
2.30.2



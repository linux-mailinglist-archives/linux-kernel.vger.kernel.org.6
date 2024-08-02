Return-Path: <linux-kernel+bounces-272329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBA2945A52
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3513B21F26
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51EC1C3F35;
	Fri,  2 Aug 2024 08:56:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856E01C3F1B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588974; cv=none; b=Xx1Bu4upfuTMyTSoeigRyG531OlGWmmoOVUaBL1RNm8Xm07wurd/B4laBLGZLEihU9yRFvwMVxy+CJGo0YzS3DxE0CEZHHYvY4LLNoYOLLCS8tTwmoO/+TpIzKBQ8uUXcCVs2Jj87YaBYC7AB3dot5oiIX0KSiOyoGCSKvBy6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588974; c=relaxed/simple;
	bh=Mb9WDkqLU/aQEf1I2Y9pAvGcPFmnhBvD2qvfNmVm7sI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=be0NLuoVsIbqq7L+jBP37JcsVPjADkpfGcWOY78mDLgZmy2sBNSbq6M83rQPgiNxNXGSaX4gCAmeAPlNLUMD3VdFolLxA+UrfK4YRurjNjCqEK2N1k9xSDdUIgTUWwXZ5ctT+LOodtmllmyeVgxfVpGTSSYq5g9Apo3lAVIu2aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AE3D1007;
	Fri,  2 Aug 2024 01:56:36 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.56.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A12C43F766;
	Fri,  2 Aug 2024 01:56:07 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH V2] irqchip/gic-v4.1: Replace GIC version with ID_AA64PFR0_EL1_GIC_V4P1
Date: Fri,  2 Aug 2024 14:26:01 +0530
Message-Id: <20240802085601.1824057-1-anshuman.khandual@arm.com>
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
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.11-rc1.

ID_AA64PFR0_EL1.GIC field value for V4P1 has been fixed via a recent
commit f3dfcd25455b ("arm64/sysreg: Correct the values for GICv4.1").

Changes in V2:

- Updated the subject line per Marc

Changes in V1:

https://lore.kernel.org/all/20240724054623.667595-1-anshuman.khandual@arm.com/

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



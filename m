Return-Path: <linux-kernel+bounces-272362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD70A945AD1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA101C22F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CAF8F47;
	Fri,  2 Aug 2024 09:19:25 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DEB1DAC4F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590365; cv=none; b=MbXROvbYvaiB5q55p69eC0k8biNNoujtak8NhbQ38WQNHNpvs/Ub4ot5U1dpujH+8zwymAYfWwTuZlN39AaOgsbb/Sjn3zL2zSkyarn1e6IdN1NVPZ/NachmYzBpXLEayvv1PYKxwG34+Nn4rEpAfOSSqvGeibxyTZwnG8OuJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590365; c=relaxed/simple;
	bh=t91oUSCw6oje1J3rVWrMxurCJ8NX2swgfnuwDlpKbds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NbdkIonqZH/lcZMucMi8CWObTQR+NM7SyYlpS/ILtGx0GHV+6u2HDFTAjdaVx1VknQh0almXmsiE2W+kyWPrLyGT9QinVATqMCqgD0FjrnztIEXpr5JoOwa+YLTkpwowK6XxAFJv5fdz9p+nBcsn6XHDSrtxgPjUQGdIVab+eMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wb0bQ3KtkzfZFj;
	Fri,  2 Aug 2024 17:17:22 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DD02D180101;
	Fri,  2 Aug 2024 17:19:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 2 Aug
 2024 17:19:13 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <bhe@redhat.com>, <akpm@linux-foundation.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH] ARM: Support allocating crashkernel above 4G for LPAE
Date: Fri, 2 Aug 2024 17:25:10 +0800
Message-ID: <20240802092510.3915986-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)

As ARM LPAE feature support accessing memory beyond the 4G limit, define
HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH macro to support reserving crash
memory above 4G for ARM32 LPAE.

No test because there is no LPAE ARM32 hardware.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm/include/asm/crash_reserve.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/crash_reserve.h b/arch/arm/include/asm/crash_reserve.h
index 85c9298bd3b7..33a2f18b0ec1 100644
--- a/arch/arm/include/asm/crash_reserve.h
+++ b/arch/arm/include/asm/crash_reserve.h
@@ -19,6 +19,10 @@ static inline unsigned long crash_addr_low_max(void)
 	return (crash_max > lowmem_max) ? lowmem_max : crash_max;
 }
 
-
 #define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+
+#if defined(CONFIG_ARM_LPAE) && defined(CONFIG_HIGHMEM)
+#define HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
+#endif
+
 #endif
-- 
2.34.1



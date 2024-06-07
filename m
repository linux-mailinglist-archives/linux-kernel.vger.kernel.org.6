Return-Path: <linux-kernel+bounces-205559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015A28FFD70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EB61C21C0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A4215A842;
	Fri,  7 Jun 2024 07:45:39 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFE422087
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746338; cv=none; b=kuXYQW+iQbD0SmX9SL4ftft1cRkZrfC9w9dE69vaFQgi1OkuoNrZPeKo1UAgDgL1gbYvhV2CTe/dPnlHg0maZ0UoQX7EKUIpDbtLU42aw1Fd8hA0qqVCOYAnwk5aK3PdrBxCssWbsvkZoLCbrdfnTSazpwjZVv5jLgrhgFsPHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746338; c=relaxed/simple;
	bh=fBYzqO2MqL5LabOsEo0xOFZB5GFvOo2gyT0fxSbSprE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dlOmRRMUge69BFPFRkrlX/RGWBDlhyrairRayMhvrQvLnidxNPmrrnZ8+YEfKsTHG7IcK6CEzZwTdzwgTvlOhxZ9VFO07vk9W3klOMeriIWOdPFlCsya10wDsIXpWXNBaPsCXN39EouMC+lhJ7lLPUj0vuNBYJ1lmj/1jhApKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwY613GyTzmYG8;
	Fri,  7 Jun 2024 15:40:57 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BC42140123;
	Fri,  7 Jun 2024 15:45:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 15:45:32 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<dianders@chromium.org>, <swboyd@chromium.org>, <sumit.garg@linaro.org>,
	<frederic@kernel.org>, <scott@os.amperecomputing.com>,
	<misono.tomohiro@fujitsu.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] arm64: smp: Fix missing IPI statistics
Date: Fri, 7 Jun 2024 15:47:16 +0800
Message-ID: <20240607074716.4068975-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)

commit 83cfac95c018 ("genirq: Allow interrupts to be excluded from
/proc/interrupts") is to avoid IPIs appear twice in /proc/interrupts.
But the commit 331a1b3a836c ("arm64: smp: Add arch support for backtrace
using pseudo-NMI") and commit 2f5cd0c7ffde("arm64: kgdb: Implement
kgdb_roundup_cpus() to enable pseudo-NMI roundup") set CPU_BACKTRACE and
KGDB_ROUNDUP IPIs "IRQ_HIDDEN" flag but not show them in
arch_show_interrupts(), which cause the interrupt kstat_irqs accounting
is missing in display.

Fixes: 331a1b3a836c ("arm64: smp: Add arch support for backtrace using pseudo-NMI")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 31c8b3094dd7..7f9a5cf0f3b8 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1039,7 +1039,8 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 		}
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
-		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
+		if (i < NR_IPI)
+			irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
 	}
 
 	ipi_irq_base = ipi_base;
-- 
2.34.1



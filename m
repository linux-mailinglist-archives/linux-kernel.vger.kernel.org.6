Return-Path: <linux-kernel+bounces-238680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68348924DC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6CB1C2293E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35CF1DA33C;
	Wed,  3 Jul 2024 02:24:00 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D89454
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719973440; cv=none; b=m8lCHrDy8FZfnYc7qbz8hilRnd5rEdFWgc9bDdcf7RfLlvMGcl0VoDiFydq7Ur04qfG2VuMOe0OFrBb7kv66gc2pSoX9T2uoRLiUFpf6vO3Izyj92WvV8bEtVNOqxbahgsVB5lEVWU0CL6QZxfSpi58ak8VOAwn/qSkCVKz4dYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719973440; c=relaxed/simple;
	bh=uHUNtsPWp3XTzToO0P+8INuIbRELTA3kuv716G7A6Ik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eg716DMOT2HjaicP9Bdd6fOT7s3+uS0OC55xbpON7YJ/32BQDHzhvAB/gk1dFYeoIKkiC9CreK+afKknJGS+sveDccgvPabtHYGFJahxAF7jhXt0R63tXiae5PjuELmpJ9JBHbpL87oyTfm6K/VquCLMkiMFKMDChxXrPHdjJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WDNlp1QHqzQk5P;
	Wed,  3 Jul 2024 10:20:06 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id EB695180A9C;
	Wed,  3 Jul 2024 10:23:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 3 Jul
 2024 10:23:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<samuel.holland@sifive.com>, <tglx@linutronix.de>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH] riscv: Enable generic CPU vulnerabilites support
Date: Wed, 3 Jul 2024 10:27:32 +0800
Message-ID: <20240703022732.2068316-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Currently x86, ARM and ARM64 support generic CPU vulnerabilites, but
RISC-V not, such as:

	# cd /sys/devices/system/cpu/vulnerabilities/
x86:
	# cat spec_store_bypass
		Mitigation: Speculative Store Bypass disabled via prctl and seccomp
	# cat meltdown
		Not affected

ARM64:

	# cat spec_store_bypass
		Mitigation: Speculative Store Bypass disabled via prctl and seccomp
	# cat meltdown
		Mitigation: PTI

RISC-V:

	# cat /sys/devices/system/cpu/vulnerabilities
	# ... No such file or directory

As SiFive RISC-V Core IP offerings are not affected by Meltdown and
Spectre, it can use the default weak function as below:

	# cat spec_store_bypass
		Not affected
	# cat meltdown
		Not affected

Link: https://www.sifive.cn/blog/sifive-statement-on-meltdown-and-spectre

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0525ee2d63c7..3b44e7b51436 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -85,6 +85,7 @@ config RISCV
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_DEVICES
+	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
-- 
2.34.1



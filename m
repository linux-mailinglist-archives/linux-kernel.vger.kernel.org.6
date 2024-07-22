Return-Path: <linux-kernel+bounces-258429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CC9387D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FC21C20DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209C5168BE;
	Mon, 22 Jul 2024 03:52:14 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108310979
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721620333; cv=none; b=sqKCr5lLJBGbG+IOfvnmZ2EwV/VVyawdgKcc1oV3drodMxFEQr5LKZFsSE5EMFIaLEo4j/EbeaD9/te0Ru2a8Kn612G9SDjmN1AH8aFiG3sKq0q//umADIlmVVCELx/tXgJ4BuIbisra2c7nvGpU8gKs8BFCic0OGJBhlwnC/+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721620333; c=relaxed/simple;
	bh=sr6QXu0aogv3BiDGigv5pkL4kHTAC+h15lyetZR7/ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCrHpU4qlw8vZulzDGUx7p/QKJNbXSFQRG8OQWKefctHQuqRcKzcuoR/Sg/AKNXrQbaD4qg9UddHWHnSiT5kGGsOPf/dJx+l1Uv4PiiG/OaUHZQ+l7oZiROvO9hBytkBm1ldmPu7bc0/V1HeAw2oco5Gs6ZhhwDowCi9oJ2WwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WS5pS4cxPz20krZ;
	Mon, 22 Jul 2024 11:48:00 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DD5BE1A016C;
	Mon, 22 Jul 2024 11:52:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 22 Jul
 2024 11:52:07 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<arnd@arndb.de>, <gregkh@linuxfoundation.org>, <deller@gmx.de>,
	<javierm@redhat.com>, <bhe@redhat.com>, <robh@kernel.org>,
	<alexghiti@rivosinc.com>, <bjorn@rivosinc.com>, <akpm@linux-foundation.org>,
	<namcao@linutronix.de>, <dawei.li@shingroup.cn>, <chenjiahao16@huawei.com>,
	<rppt@kernel.org>, <julian.stecklina@cyberus-technology.de>,
	<rafael.j.wysocki@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v4 2/3] ARM: Fix crash memory reserve exceed system memory bug
Date: Mon, 22 Jul 2024 11:57:00 +0800
Message-ID: <20240722035701.696874-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722035701.696874-1-ruanjinjie@huawei.com>
References: <20240722035701.696874-1-ruanjinjie@huawei.com>
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

Similar with x86_32, on Qemu vexpress-a9 with 1GB memory, the crash kernel
"crashkernel=4G" is ok as below:
	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)

The cause is that the crash_size is parsed and printed with "unsigned long
long" data type which is 8 bytes but allocated used with "phys_addr_t"
which is 4 bytes in memblock_phys_alloc_range().

Fix it by checking if the crash_size is greater than system RAM size and
warn out as parse_crashkernel_mem() do it if so as Baoquan suggested.

After this patch, it fails and there is no above confusing reserve
success info.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Baoquan He <bhe@redhat.com>
---
v4:
- Update the warn info to align with parse_crashkernel_mem().
- Rebased on the "ARM: Use generic interface to simplify crashkernel
  reservation" patch.
- Update the commit message.
v3:
- Handle the check in reserve_crashkernel() Baoquan suggested.
- Split x86_32 and arm32.
- Add Suggested-by.
- Drop the wrong fix tag.
v2:
- Also fix for x86_32.
- Update the fix method.
- Peel off the other two patches.
- Update the commit message.
---
 arch/arm/kernel/setup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index fc0ada003f6d..aea320dcac41 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1005,6 +1005,11 @@ static void __init arch_reserve_crashkernel(void)
 	if (ret || !crash_size)
 		return;
 
+	if (crash_size >= total_mem) {
+		pr_warn("Crashkernel: invalid size.");
+		return;
+	}
+
 	reserve_crashkernel_generic(boot_command_line, crash_size, crash_base, low_size, high);
 
 	if (arm_has_idmap_alias()) {
-- 
2.34.1



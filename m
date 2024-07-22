Return-Path: <linux-kernel+bounces-258430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0376F9387D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350C31C20D60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2A01799F;
	Mon, 22 Jul 2024 03:52:14 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9812B8B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721620334; cv=none; b=G0isXPQ1GHXo+8PRmxbQVQh7GbrMAdBcECWI+krAbg2YZouFV1fbALK62htVtsV1djD78YmXdNA6yqwUc+uRniaX3qFS5XLSo/yQy6Fq877iV12lb29MHcvyt/wlnZ9oMo3fNw5QD+NQA3zlzZncKrR8V5c79qBe49+1uk571dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721620334; c=relaxed/simple;
	bh=IWFco5zE7qmDL7q2Y1gm33E8h63HaHGW7p+keXeovuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsMz92caVQI9KxdvuKaFZl8at03s19aZXVp0iUxQBZuZK8fY4QyEaW+/Dx17pPlWZVE47xIj3w2JtAZqe3xT63lsXVFzQNW9noUMX0/kQzw7kUBT25KtOEWR+YhSJZFPIENb380L/uRdUP7rR4ysYmpNc57UdQf//MDx6pOkjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WS5pB6SQcz2ClNw;
	Mon, 22 Jul 2024 11:47:46 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B63621A0188;
	Mon, 22 Jul 2024 11:52:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 22 Jul
 2024 11:52:08 +0800
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
Subject: [PATCH v4 3/3] riscv: kdump: Fix crash memory reserve exceed system memory bug
Date: Mon, 22 Jul 2024 11:57:01 +0800
Message-ID: <20240722035701.696874-4-ruanjinjie@huawei.com>
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

Similar with x86_32, on Riscv32 Qemu "virt" machine with 1GB memory, the
crash kernel "crashkernel=4G" is ok as below:
	crashkernel reserved: 0x00000000bf400000 - 0x00000001bf400000 (4096 MB)

The cause is that the crash_size is parsed and printed with "unsigned long
long" data type which is 8 bytes but allocated used with "phys_addr_t"
which is 4 bytes in memblock_phys_alloc_range().

Fix it by checking if the crash_size is greater than system RAM size and
warn out as parse_crashkernel_mem() do it if so.

After this patch, it fails and there is no above confusing reserve
success info.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index bfa2dea95354..5d66a4937fcd 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1381,6 +1381,11 @@ static void __init arch_reserve_crashkernel(void)
 	if (ret)
 		return;
 
+	if (crash_size >= memblock_phys_mem_size()) {
+		pr_warn("Crashkernel: invalid size.");
+		return;
+	}
+
 	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
 				    low_size, high);
 }
-- 
2.34.1



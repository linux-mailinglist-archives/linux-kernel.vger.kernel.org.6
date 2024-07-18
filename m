Return-Path: <linux-kernel+bounces-255948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC99346EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA2AB22906
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462863A1DB;
	Thu, 18 Jul 2024 03:50:40 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C677B36AEC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274639; cv=none; b=R/RHUqcfGa/gTgM7m6NEqrFfM1Dp2wa0468pvts9sL34sLE41RB4fhu47AlT+mR67dWTdnoy4ibcv+c1avbQeIWe1GF7ctT4aHrWqHs5HZXxqYbc+VKimwjGuwpj6MnRlViDaaK66mIvajabNKfLK+hCtr2WdSAw0+4dS6ON6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274639; c=relaxed/simple;
	bh=hPjFuAYXQ4gZ+F4+tJIPygYSQLZ4FMGp+bNz4BBr+TU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4HAKyy2q7TN3zQYdZAIPB9Tq5f/01+z/kB3sRjDxuBFof4tB4213GKHbt/fGRONtESR8LStDJkt3uN7ZBaGGQXK4RN/upSg6Nl3UPLF/IDtuW8Mlst0ySIs2/AeBaTcIGYkxnjOx6a5990PhCAUmX0ULWf8HV6brIkf0V+e9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WPdyZ6ZSXzQm2G;
	Thu, 18 Jul 2024 11:46:30 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3489718010A;
	Thu, 18 Jul 2024 11:50:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 11:50:04 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <arnd@arndb.de>, <afd@ti.com>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<eric.devolder@oracle.com>, <gregkh@linuxfoundation.org>,
	<javierm@redhat.com>, <deller@gmx.de>, <robh@kernel.org>,
	<hbathini@linux.ibm.com>, <thunder.leizhen@huawei.com>,
	<chenjiahao16@huawei.com>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 2/3] crash: Fix x86_32 crash memory reserve dead loop bug at high
Date: Thu, 18 Jul 2024 11:54:43 +0800
Message-ID: <20240718035444.2977105-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718035444.2977105-1-ruanjinjie@huawei.com>
References: <20240718035444.2977105-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)

On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=512M" will
also cause system stall as below:

	ACPI: Reserving FACP table memory at [mem 0x3ffe18b8-0x3ffe192b]
	ACPI: Reserving DSDT table memory at [mem 0x3ffe0040-0x3ffe18b7]
	ACPI: Reserving FACS table memory at [mem 0x3ffe0000-0x3ffe003f]
	ACPI: Reserving APIC table memory at [mem 0x3ffe192c-0x3ffe19bb]
	ACPI: Reserving HPET table memory at [mem 0x3ffe19bc-0x3ffe19f3]
	ACPI: Reserving WAET table memory at [mem 0x3ffe19f4-0x3ffe1a1b]
	143MB HIGHMEM available.
	879MB LOWMEM available.
	  mapped low ram: 0 - 36ffe000
	  low ram: 0 - 36ffe000
	  (stall here)

The reason is that the CRASH_ADDR_LOW_MAX is equal to CRASH_ADDR_HIGH_MAX
on x86_32, the first "low" crash kernel memory reservation for 512M fails,
then it go into the "retry" loop and never came out as below (consider
CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX = 512M):

-> reserve_crashkernel_generic() and high is false
   -> alloc at [0, 0x20000000] fail
      -> alloc at [0x20000000, 0x20000000] fail and repeatedly
      (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).

Fix it by skipping meaningless calls of memblock_phys_alloc_range() with
`start = end`

After this patch, the retry dead loop is avoided and print below info:
	cannot allocate crashkernel (size:0x20000000)

And apply generic crashkernel reservation to 32bit system will be ready.

Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v3:
- Fix it as Baoquan suggested.
- Update the commit message.
---
 kernel/crash_reserve.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index c5213f123e19..dacc268429e2 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -414,7 +414,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 			search_end = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-			goto retry;
+			if (search_base != search_end)
+				goto retry;
 		}
 
 		/*
-- 
2.34.1



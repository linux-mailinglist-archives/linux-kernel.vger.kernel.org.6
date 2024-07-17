Return-Path: <linux-kernel+bounces-254786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA6933791
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88500B234E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD491862A;
	Wed, 17 Jul 2024 07:04:23 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1A18C3D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199863; cv=none; b=pN7NwV5OR1z0eKPzgPcDwkljBh2hd7iFhSFytQqLliP04Kjm/YGNMesUzue6NE8oMQ97xYepjovUGU+EgQ0w7UegrLt+0s7KEeO1Ean5X34EB60t9TaVLjW365EYn7bL9gehgeIIEVR4gDFldajj5m9qWsGqaxDViynHvtwpY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199863; c=relaxed/simple;
	bh=I11NJ0Gbqwe9dWfknWF6VjfJ44JAxBnn7MH/gKrRGrU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fc2tul7pBdfOOCZ8nEyMGb9YSu0dVHFP3YpfJE7u+Igk6e4x5J61gVOC09DsiEijFZuaSl2Y7F9oF3n4CeC5FLdZiOaKY8WyWiPI8/dq5lwFSkgD7hHceN060q2Tlhx4LnB+TXlMVRxpYZLaMH+qteYjUFlsgFfZ5H988sc9Acs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WP6MF4lL3zdhck;
	Wed, 17 Jul 2024 15:02:33 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5486718009B;
	Wed, 17 Jul 2024 15:04:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Jul
 2024 15:04:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<akpm@linux-foundation.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] crash: fix x86_32 memory reserve dead loop retry bug at "high"
Date: Wed, 17 Jul 2024 15:09:04 +0800
Message-ID: <20240717070904.2671147-1-ruanjinjie@huawei.com>
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

Similar to commit 8f9dade5906a ("crash: fix x86_32 memory reserve dead loop
retry bug") and in the symmetry case, on x86_32 Qemu machine with
1GB memory, the cmdline "crashkernel=512M" will also cause system stall
as below:

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

Fix it by also changing the another out check condition, the fixed base
situation has no problem because it warn out if it fail to alloc.

After this patch, it prints:
	cannot allocate crashkernel (size:0x20000000)

Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_reserve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 03e455738e75..36c13cf942f4 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -409,7 +409,7 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		 * low memory, fall back to high memory, the minimum required
 		 * low memory will be reserved later.
 		 */
-		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
+		if (!high && !search_base) {
 			search_end = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-- 
2.34.1



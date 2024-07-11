Return-Path: <linux-kernel+bounces-248693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F90C92E0CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2FECB220BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B231487F9;
	Thu, 11 Jul 2024 07:28:20 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33061148318
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682899; cv=none; b=Z6vtQZgvnsiw9GfZQVwIs/ZNH9P8x1jr8shPjaETJ21WupzgksiSgTrhAcWXTg1KdmUyMFjeGap897KuAengHdw0I4kSDg9HgXDXRSvZfedOyW7fyT3qsAYbFZhJWTjd3ZarPzYzp4sMQxD1yGmc/LiDGBekuAwWkZ0HoDW6LDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682899; c=relaxed/simple;
	bh=LooyK1nesgxXPrZ4cwneopS5lVW518hX1UEmAKtwnlU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WWubUbaJZ9LC9pHl3/f97GP0mDgt/M2TXGi2PIPmoVNHrFqGahuqVL8qsPfQKtG2Z0Qabcogpq3YrbCDNZeoFT1CcNUYhYt+jSF3e8XSiW7GUhHJl96s+PxxhOqbxYDrZqt5lrBq7G1GZnzpS5TpD216yIbsyeDmYVzRsENtIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WKR6n1FQrz2Cl8D;
	Thu, 11 Jul 2024 15:24:01 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C297180018;
	Thu, 11 Jul 2024 15:28:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Jul
 2024 15:28:13 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<akpm@linux-foundation.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 RESEND] crash: Fix x86_32 memory reserve dead loop retry bug
Date: Thu, 11 Jul 2024 15:32:31 +0800
Message-ID: <20240711073231.1289883-1-ruanjinjie@huawei.com>
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

On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=1G,high"
will cause system stall as below:

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
on x86_32, the first high crash kernel memory reservation will fail, then
go into the "retry" loop and never came out as below.

-> reserve_crashkernel_generic() and high is true
 -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
    -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
       (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).

Fix it by change the out check condition.

After this patch, it print:
	cannot allocate crashkernel (size:0x40000000)

Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Peel off the other two patches.
- Update the commit message and fix tag.
---
 kernel/crash_reserve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..5073ae205f79 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -421,7 +421,7 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		 * For crashkernel=size[KMG],high, if the first attempt was
 		 * for high memory, fall back to low memory.
 		 */
-		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
+		if (high && search_base == CRASH_ADDR_LOW_MAX) {
 			search_end = CRASH_ADDR_LOW_MAX;
 			search_base = 0;
 			goto retry;
-- 
2.34.1



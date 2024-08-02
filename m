Return-Path: <linux-kernel+bounces-272327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DD1945A50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FCE285B28
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B261C379B;
	Fri,  2 Aug 2024 08:55:19 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E791B3F39
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588918; cv=none; b=GTSuqcBM5GpNqVCvODjcMBQAJkaeRigARR9YdLxnm7O53Tl5Neu53tywtWlO64REYBiYuJA0W1+kYxAhsbuayk9BcSb/uOYnhZ675IUalzuZ2eX7HfzhoFNAYq4SXxNdn3YiLVGpSC5sHHy0YUinsTPCPqBtHk1WrVSiHhH42II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588918; c=relaxed/simple;
	bh=O5jvbu3MtWjmYUGKvqRru81bPNjFjYTWjEl4WR/cmz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BVxYeESxCZCLbZL0WxjixqcbQ0ufhl9FGeWCtEeUMklahwc3i3j7H0Qd0R8LwymsRJKmZseXSpMd3SibCwON/sEavV2NqiPV4JHnm9HvZ3ZQQGCzHsivDTyqts+tEAKel5AM/kaOb5+RjnuJ3i1IEybppYc+I1PBCL/c0fHJkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wb00X2n0wz1j6NP;
	Fri,  2 Aug 2024 16:50:36 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F8A31400DC;
	Fri,  2 Aug 2024 16:55:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 2 Aug
 2024 16:55:12 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<chenjiahao16@huawei.com>, <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Date: Fri, 2 Aug 2024 17:01:05 +0800
Message-ID: <20240802090105.3871929-1-ruanjinjie@huawei.com>
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

On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
will cause system stall as below:

	 Zone ranges:
	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
	   Normal   empty
	 Movable zone start for each node
	 Early memory node ranges
	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
	(stall here)

commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop
bug") fix this on 32-bit architecture. However, the problem is not
completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
architecture, for example, when system memory is equal to
CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:

	-> reserve_crashkernel_generic() and high is true
	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).

Before refactor in commit 9c08a2a139fe ("x86: kdump: use generic interface
to simplify crashkernel reservation code"), x86 do not try to reserve crash
memory at low if it fails to alloc above high 4G. However before refator in
commit fdc268232dbba ("arm64: kdump: use generic interface to simplify
crashkernel reservation"), arm64 try to reserve crash memory at low if it
fails above high 4G. For 64-bit systems, this attempt is less beneficial
than the opposite, remove it to fix this bug and align with native x86
implementation.

After this patch, it print:
	cannot allocate crashkernel (size:0x1f400000)

Fixes: 39365395046f ("riscv: kdump: use generic interface to simplify crashkernel reservation")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_reserve.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5387269114f6..69e4b8b7b969 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -420,15 +420,6 @@ void __init reserve_crashkernel_generic(char *cmdline,
 				goto retry;
 		}
 
-		/*
-		 * For crashkernel=size[KMG],high, if the first attempt was
-		 * for high memory, fall back to low memory.
-		 */
-		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
-			search_end = CRASH_ADDR_LOW_MAX;
-			search_base = 0;
-			goto retry;
-		}
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);
 		return;
-- 
2.34.1



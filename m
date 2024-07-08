Return-Path: <linux-kernel+bounces-244389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2092A3A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153641F22A2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB2D13B798;
	Mon,  8 Jul 2024 13:29:55 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52213774A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445395; cv=none; b=HJllPsoTStREuSYMtTRJy7ChyshK4W05xwPNXmvfNU2FTZyigTfNBdljGQ+K5/fWVkxEK7j5m0CWmJLQ9hgRtYnevgrOw1199lXapX4oI5F+jyOT3WNU2AlYEFPXIfMZp0T5Av8uFV23ebZdpnZIfTwZ647+3DIkT4kBTWZzcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445395; c=relaxed/simple;
	bh=hDmU0jR2eMDhbsTHQrUhsRIFhS1zJ2pGotJO/aAfgBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AumIi4Wg2uuMVReKarZJVmK1Nde2Yo7yHEtNUzYzToMK6jNAd/AWDR6U0tXmL2JqZodNF0ARNL15WWDv3NdBh5Fr1wgGp1mhDp8W98GiMI88sejtO3Lg4jIh5a1gPHVZLPwcL6hz7uUAmPpu8PKnJbGjMmDjRLii7lJx88sODbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WHlHl00R7zQksh;
	Mon,  8 Jul 2024 21:25:54 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B5267140415;
	Mon,  8 Jul 2024 21:29:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 21:29:47 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>,
	<gregkh@linuxfoundation.org>, <deller@gmx.de>, <javierm@redhat.com>,
	<robh@kernel.org>, <thunder.leizhen@huawei.com>, <austindh.kim@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 1/3] crash: Fix memory reserve dead loop bug in reserve_crashkernel_generic()
Date: Mon, 8 Jul 2024 21:33:46 +0800
Message-ID: <20240708133348.3592667-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708133348.3592667-1-ruanjinjie@huawei.com>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)

If the platform do not support memory above 4G, such as 32 bit arch,
and CRASH_ADDR_LOW_MAX is equal to CRASH_ADDR_HIGH_MAX, the high
crash kernel memory reservation is meaningless and it will cause
dead loop and system stall:

-> reserve_crashkernel_generic() and high is true
 -> memblock_phys_alloc_range() fail and return 0
    -> search_end = CRASH_ADDR_LOW_MAX(same as CRASH_ADDR_HIGH_MAX)
       -> call memblock_phys_alloc_range() again and fail agin.
          -> search_end == CRASH_ADDR_HIGH_MAX satisfy again
	......

However, the current check only considers the case where
CRASH_ADDR_HIGH_MAX is greater than CRASH_ADDR_LOW_MAX. Fix it.

Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/crash_reserve.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..e18fb1bb5d28 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -390,6 +390,11 @@ void __init reserve_crashkernel_generic(char *cmdline,
 	} else if (high) {
 		search_base = CRASH_ADDR_LOW_MAX;
 		search_end = CRASH_ADDR_HIGH_MAX;
+
+		if (search_base >= search_end) {
+			pr_warn("crashkernel high memory reservation failed.\n");
+			return;
+		}
 	}
 
 retry:
@@ -410,7 +415,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		 * low memory, fall back to high memory, the minimum required
 		 * low memory will be reserved later.
 		 */
-		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
+		if (!high && search_end == CRASH_ADDR_LOW_MAX &&
+		    CRASH_ADDR_HIGH_MAX > CRASH_ADDR_LOW_MAX) {
 			search_end = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-- 
2.34.1



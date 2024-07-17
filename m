Return-Path: <linux-kernel+bounces-254830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC64933847
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A36FB21684
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA49D28DCC;
	Wed, 17 Jul 2024 07:50:02 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0AE1CAB1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202602; cv=none; b=H/gMtVKFgtV6QraD9eAhXUj0k6WdwOEZwiduKNyFHBNbmYz8PrE6jWOXAXQt8DSKkoHyiaF/igXn+sWEr1AdvBjn/GXDXu2qG/U7wii5pjMGFWIP1lKKvHbkWoyF183SEeQQmYkAXcagAUVebVUpwQqipbx9xnJ8tbDg5ovrrnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202602; c=relaxed/simple;
	bh=7cfB05wqWfZ7ZLYsZf4c8t9HiM1SeJC/CHEPTLl6qLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIKdtjkyOHUIqrAlBxO+HBH1s7v9WdMYfRL07BFwqVaD5KHfC6kxteoP1mKVnsHdd731gOSkzLLUs4uq5XGCxkSzID5TtEI4+zCNHc+aShvymSaBV4B/RrbE29EXZWje/4p2RpyirK4Q81syXEu9cMXO4Q2mZLkQSNspS27fZOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WP7PC3JZ8znb9y;
	Wed, 17 Jul 2024 15:49:19 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C38F1800A3;
	Wed, 17 Jul 2024 15:49:57 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Jul
 2024 15:49:56 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<gregkh@linuxfoundation.org>, <arnd@arndb.de>, <deller@gmx.de>,
	<javierm@redhat.com>, <bhe@redhat.com>, <robh@kernel.org>,
	<peterz@infradead.org>, <julian.stecklina@cyberus-technology.de>,
	<rafael.j.wysocki@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v3 2/2] ARM: Fix crash memory reserve exceed system memory bug
Date: Wed, 17 Jul 2024 15:54:39 +0800
Message-ID: <20240717075439.2705552-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717075439.2705552-1-ruanjinjie@huawei.com>
References: <20240717075439.2705552-1-ruanjinjie@huawei.com>
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

Similar with x86_32, on Qemu vexpress-a9 with 1GB memory, the crash kernel
"crashkernel=4G" is ok as below:
	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)

The cause is that the crash_size is parsed and printed with "unsigned long
long" data type which is 8 bytes but allocated used with "phys_addr_t"
which is 4 bytes in memblock_phys_alloc_range().

Fix it by checking if the crash_size is greater than system RAM size and
warn out if so as Baoquan suggested.

After this patch, it fails and warn out as expected and no above confusing
reserve success info.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Baoquan He <bhe@redhat.com>
---
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
index e6a857bf0ce6..791d5f046163 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1015,6 +1015,11 @@ static void __init reserve_crashkernel(void)
 	if (ret || !crash_size)
 		return;
 
+	if (crash_size >= total_mem) {
+		pr_warn("Crashkernel reserve memory cannot exceed physical memory.");
+		return;
+	}
+
 	if (crash_base <= 0) {
 		unsigned long long crash_max = idmap_to_phys((u32)~0);
 		unsigned long long lowmem_max = __pa(high_memory - 1) + 1;
-- 
2.34.1



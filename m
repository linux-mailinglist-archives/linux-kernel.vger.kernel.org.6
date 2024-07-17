Return-Path: <linux-kernel+bounces-254828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C193383E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E804E1F22881
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCE31CD16;
	Wed, 17 Jul 2024 07:50:01 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB81CA80
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202600; cv=none; b=qoE1ZXn1Wkm3TJXpgrsSXMTeIgiDm4XJa75jyCgVHo0luLwq50ysQsOYWykBJbXmSo5QhMmXpVA/A8AVd6cakGHSYa0YjzzA+A4ccnc3cZ4DMK3wTT8Z4a8XtrYWP7IEhVDehzL7w+Edza84t1SGTut1fQfx3OuyYSa/+cUMAek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202600; c=relaxed/simple;
	bh=oZZuOcd5k/lY+KJ8M8Pe2lZiMTEJa6EaJvfs//FIdfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrCBAw7Gi1V0l37XC+nKflwukdx3HsjAHR8zbRO2ZFSzo2ByQsqQIQixQFWgTieE1SvUjpL5ayk18B8bVQ9lsaRsbCzUwq6Z8UGt2IQis3gBU5M0XkW9gGN+YjKtS7XZpUgGKC6S1Rhmbi8jvkaWpn9md7QZTBlHm6Ed+iT2SdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WP7KF6L0gz20krH;
	Wed, 17 Jul 2024 15:45:53 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C7C451A0190;
	Wed, 17 Jul 2024 15:49:56 +0800 (CST)
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
Subject: [PATCH -next v3 1/2] x86/kexec: Fix crash memory reserve exceed system memory bug
Date: Wed, 17 Jul 2024 15:54:38 +0800
Message-ID: <20240717075439.2705552-2-ruanjinjie@huawei.com>
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

On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
as below:
	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)

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
- Handle the check in arch_reserve_crashkernel() Baoquan suggested.
- Split x86_32 and arm32.
- Add Suggested-by.
- Drop the wrong fix tag.
v2:
- Also fix for x86_32.
- Update the fix method.
- Peel off the other two patches.
- Update the commit message.
---
 arch/x86/kernel/setup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 05c5aa951da7..c26373029b77 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -481,6 +481,11 @@ static void __init arch_reserve_crashkernel(void)
 	if (ret)
 		return;
 
+	if (crash_size >= memblock_phys_mem_size()) {
+		pr_warn("Crashkernel reserve memory cannot exceed physical memory.");
+		return;
+	}
+
 	if (xen_pv_domain()) {
 		pr_info("Ignoring crashkernel for a Xen PV domain\n");
 		return;
-- 
2.34.1



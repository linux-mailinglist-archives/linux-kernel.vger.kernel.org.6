Return-Path: <linux-kernel+bounces-265686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4985193F46B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E759F1F22DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBE8145B25;
	Mon, 29 Jul 2024 11:47:16 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B59817
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253636; cv=none; b=P0UbTDYqD9KMKiWcT26l14lod0/KrjE2tr6FV5y47h1gXo/vLIUZPNC+go8aNz0qCps6bszBTMnaFtj8H162t3fzRASGqyTWMZZ0B7If+nnKqr2HnShd1JvCOgb0jTrY5V57auMo1EqLMd8fD6D5LAWQl5Mpy3N4HdxD2E0Wg4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253636; c=relaxed/simple;
	bh=DrDDx1tjZc4+DP6s+1WmfatygIPl0lO0VMe7Hyvpsh0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WVPO6AW53GQWVM040e+G2XpxyAzdwK8C5ywURyHsNip+xiRymjZ1xp9k4QiHSwD9E8Y/c4C8HQVy1FvoxuT3VVr0XMnXR4B8qsvyO+jMwewQpTUYB9zivZdWLMa+lLoE99OJ5/rT+v+4PQ+O3MqkA2GlRIPQ7VLh/0FT/MMBsds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WXc0Q6h5ZzyP1c;
	Mon, 29 Jul 2024 19:42:14 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A9691800D0;
	Mon, 29 Jul 2024 19:47:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 29 Jul
 2024 19:47:10 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <akpm@linux-foundation.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <rppt@kernel.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v6 RESEND] crash: Fix crash memory reserve exceed system memory bug
Date: Mon, 29 Jul 2024 19:52:52 +0800
Message-ID: <20240729115252.1659112-1-ruanjinjie@huawei.com>
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

On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
as below:
	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)

It's similar on other architectures, such as ARM32 and RISCV32.

The cause is that the crash_size is parsed and printed with "unsigned long
long" data type which is 8 bytes but allocated used with "phys_addr_t"
which is 4 bytes in memblock_phys_alloc_range().

Fix it by checking if crash_size is greater than system RAM size and
return error if so.

After this patch, there is no above confusing reserve success info.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Mike Rapoport <rppt@kernel.org>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
v6:
- Take off Baoquan's Suggested-by.
v5:
- Fix it in common parse_crashkernel() instead of per-arch.
- Add suggested-by.

v4:
- Update the warn info to align with parse_crashkernel_mem().
- Rebased on the "ARM: Use generic interface to simplify crashkernel
  reservation" patch.
- Also fix for riscv32.
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
 kernel/crash_reserve.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index ad5b3f2c5487..5387269114f6 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -335,6 +335,9 @@ int __init parse_crashkernel(char *cmdline,
 	if (!*crash_size)
 		ret = -EINVAL;
 
+	if (*crash_size >= system_ram)
+		ret = -EINVAL;
+
 	return ret;
 }
 
-- 
2.34.1



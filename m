Return-Path: <linux-kernel+bounces-244388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE7892A3A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947001F2299B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61A313A899;
	Mon,  8 Jul 2024 13:29:54 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675B3137757
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445394; cv=none; b=HFfyMV7LuA4H9DEiLRwyDCJqiWUlXPQ/agvx9zvF3QDlK/lTMYmr9N28i3QoBuE8VPwGbzok2zf0CujTLDZRRmjR272SJYKjcAtZfKzF0U2WfNZozcJ/QfqY2/89/M8BYNQ+9aTNP9fAG9wdF8ZIqslYiuqCUQQtvgdhrxRNRLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445394; c=relaxed/simple;
	bh=v0m01wOgJdCx25vKCu7GRWUXyEUDmtefnlx+KwmQUEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8Ip8Bi51GrWgYygVNxboGLFX5SUTsubR22LVCYVvC98s2Rn9bzT76VghSTVUye26XutAV6tTMADNtrRilkJD+XOoX05EUbsGE25VGj62uCU9bX4s55PvwpcKRqarM485me4KbPeala4dnMw8qa5rvxK+4U2yvrm6b5GazbSLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WHlGs2J4bzwWPg;
	Mon,  8 Jul 2024 21:25:09 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 8465C180087;
	Mon,  8 Jul 2024 21:29:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 21:29:48 +0800
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
Subject: [PATCH 2/3] ARM: Fix crash kenrel data type bug
Date: Mon, 8 Jul 2024 21:33:47 +0800
Message-ID: <20240708133348.3592667-3-ruanjinjie@huawei.com>
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

On QEMU vexpress-a9 with 1GB memory, the crash kernel "crashkernel=4G"
is ok as below:
	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)

The above info is confusing, because the System memory is as below:
	# cat /proc/iomem | grep Sys
	60000000-9fffffff : System RAM

The cause is that the crash_size is parsed and printed with "unsigned long
long" data type which is 8 bytes but used with "phys_addr_t" which is
4 bytes in memblock_phys_alloc_range().

Fixes: 9d17f3372306 ("ARM: 9190/1: kdump: add invalid input check for 'crashkernel=0'")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e6a857bf0ce6..59e1a13b5cf6 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1012,6 +1012,7 @@ static void __init reserve_crashkernel(void)
 				&crash_size, &crash_base,
 				NULL, NULL);
 	/* invalid value specified or crashkernel=0 */
+	crash_size = (phys_addr_t)crash_size;
 	if (ret || !crash_size)
 		return;
 
-- 
2.34.1



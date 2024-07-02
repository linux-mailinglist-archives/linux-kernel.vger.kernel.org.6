Return-Path: <linux-kernel+bounces-237346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA9F91EF85
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D541F2389B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9CC6EB7C;
	Tue,  2 Jul 2024 06:55:37 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5BB55C1A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903337; cv=none; b=q+AwUAO07k+yei31dhSsR7hrn0W7/f3k3WTXtAT0DsniQiAhXsPDK/mDCO7s6st99uPgZAbMWy1WqCiVvPWpvmUGL6DytA/Uiss1Y//2PZk+esJErlOuBMgmj2b1Du7oa47xZr/SmWdP1jgR8KqfX6Z4pGbuZUeGAGjLwTr78CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903337; c=relaxed/simple;
	bh=x+SEkEj656NkHk0dv7h0S3gvsmiPq7ZBZhp+ZqQhVrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtI/9ZeoRZaqUsd95kNG5znb3rD7oTeAe14wlFsjQ26TSKJy9Yujd8RjApv0W/VvIZRJXGtb791J3Iad3V23TP0wZJiWt+ggJZAhRvnJcVtnm+rEywvFFp7I4eDGZFFhpCJmkYa5Avj3NhJkNP70X3olb6GhdyvDwB3tLRFbH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WCtvn4vFXznYS3;
	Tue,  2 Jul 2024 14:55:17 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id BFF1914022D;
	Tue,  2 Jul 2024 14:55:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 14:55:32 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
	<eric.devolder@oracle.com>, <ardb@kernel.org>, <gregkh@linuxfoundation.org>,
	<deller@gmx.de>, <javierm@redhat.com>, <bhe@redhat.com>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 2/2] ARM: 9322/1: Convert to arch_cpu_is_hotpluggable()
Date: Tue, 2 Jul 2024 14:59:06 +0800
Message-ID: <20240702065906.929987-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702065906.929987-1-ruanjinjie@huawei.com>
References: <20240702065906.929987-1-ruanjinjie@huawei.com>
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

Convert arm32 to use the arch_cpu_is_hotpluggable() helper rather than
arch_register_cpu().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm/kernel/setup.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index f91e2b5b8b20..e6a857bf0ce6 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1201,12 +1201,9 @@ void __init setup_arch(char **cmdline_p)
 		mdesc->init_early();
 }
 
-int arch_register_cpu(int num)
+bool arch_cpu_is_hotpluggable(int num)
 {
-	struct cpu *cpu = &per_cpu(cpu_devices, num);
-
-	cpu->hotpluggable = platform_can_hotplug_cpu(num);
-	return register_cpu(cpu, num);
+	return platform_can_hotplug_cpu(num);
 }
 
 #ifdef CONFIG_HAVE_PROC_CPU
-- 
2.34.1



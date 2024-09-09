Return-Path: <linux-kernel+bounces-320827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A22A97111D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951221C223FA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4A41B29BC;
	Mon,  9 Sep 2024 08:00:44 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9C1B140A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868843; cv=none; b=D8aUKkD0iBJtbnSnWz6tBAG55bHMts2FnaZin5paDoXYZNU7hTNphcOVprTCbvyWQfNhqCHNVpO1laFQP7oCvj42JsA4baRQ6XBmeNeJMdSWGUjw+Os0nK1WxgBV/unZCkQ3nf7tJ6r82iFnrIO+3Sn1v2a673OFb2nm07a/NKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868843; c=relaxed/simple;
	bh=ogcmpBLpjyq6NEwlho6xu9UIrzimtjarCi3qYB6loFA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OBLsUNRdDLpHHxmlSVmTe9uqRrjHXaajVFjkHwYxJfyDupaMsUB5+iP/xTwL0YwkdzNz6RmtKq4AF69AqIaxjmd3q3+6lz7/EO3CbwlXTofZ2Mz78OZki8bhIvqfpqhbqcp2EKciOGsrYKg1/i2XBG4cQFdurFOwCNqd2oJb5VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X2K4q3DQdz1SB3P;
	Mon,  9 Sep 2024 16:00:11 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id A3DC91400D4;
	Mon,  9 Sep 2024 16:00:38 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Sep
 2024 16:00:38 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <pmladek@suse.com>, <tony.lindgren@linux.intel.com>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>, <rostedt@goodmis.org>,
	<john.ogness@linutronix.de>, <senozhatsky@chromium.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] printk: Export match_devname_and_update_preferred_console()
Date: Mon, 9 Sep 2024 15:56:52 +0800
Message-ID: <20240909075652.747370-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)

When building serial_base as a module, modpost fails with the following
error message:

  ERROR: modpost: "match_devname_and_update_preferred_console"
  [drivers/tty/serial/serial_base.ko] undefined!

Export the symbol to allow using it from modules.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409071312.qlwtTOS1-lkp@intel.com/
Fixes: 12c91cec3155 ("serial: core: Add serial_base_match_and_update_preferred_console()")
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 kernel/printk/printk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c22b07049c38..6ff8d47e145f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2620,6 +2620,7 @@ int match_devname_and_update_preferred_console(const char *devname,
 
 	return -ENOENT;
 }
+EXPORT_SYMBOL_GPL(match_devname_and_update_preferred_console);
 
 bool console_suspend_enabled = true;
 EXPORT_SYMBOL(console_suspend_enabled);
-- 
2.33.0



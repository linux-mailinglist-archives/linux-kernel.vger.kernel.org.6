Return-Path: <linux-kernel+bounces-382954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C949B157F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47D11C21B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040A17D896;
	Sat, 26 Oct 2024 06:37:23 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6E1667DA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729924643; cv=none; b=NDPHz6d75C/a3G7Pe/+iaCo9P+qXqyYjHdtBg4OixGmKEeWXFp/+OzzLDMAEoW728wcxUBqdb+PPJKsdxclj2Yk8DxYAR1v4emRcTGRijHmNnEB/5PvGymv6tIVgCEeal3hmc5dDT7H8xTgNz6JRzFHnUaEr4lv16Li5bep1NGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729924643; c=relaxed/simple;
	bh=3aayOifFWOq6eVdx5jYBqrbk/BV6RwNRk06IFYdb6YU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lPASGff2R/LxocDNYE91f+OqxeoxJ0iLKae1GvzFC981uMzehjzEGgISvRDYWMBSwcrmpWLrZaBajXNT4mC0I0NsQpir7kd55f2nmDls7NsAH5GMajH6VYv594Jr9+pI2jcZic9wDAP01nlh9h5UIlBy9szWV4TZgV8sbqKI4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Xb8yy3b12z1T8Qw;
	Sat, 26 Oct 2024 14:35:06 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id D2728140F9C;
	Sat, 26 Oct 2024 14:37:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 26 Oct
 2024 14:37:11 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <jiang.liu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] genirq/msi:  Fix off-by-one error in msi_domain_alloc()
Date: Sat, 26 Oct 2024 14:36:39 +0800
Message-ID: <20241026063639.10711-1-ruanjinjie@huawei.com>
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
 kwepemg200008.china.huawei.com (7.202.181.35)

In the for loop of msi_domain_alloc(), if ops->msi_init() fails,
ops->msi_free() is left out every time when i == 0, which may cause
memory leaks.

Fixes: f3cf8bb0d6c3 ("genirq: Add generic msi irq domain support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 3a24d6b5f559..396a067a8a56 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -718,7 +718,7 @@ static int msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		ret = ops->msi_init(domain, info, virq + i, hwirq + i, arg);
 		if (ret < 0) {
 			if (ops->msi_free) {
-				for (i--; i > 0; i--)
+				for (i--; i >= 0; i--)
 					ops->msi_free(domain, info, virq + i);
 			}
 			irq_domain_free_irqs_top(domain, virq, nr_irqs);
-- 
2.34.1



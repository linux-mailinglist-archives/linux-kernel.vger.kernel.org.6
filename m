Return-Path: <linux-kernel+bounces-304463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A94AD96206D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5841F2481A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CA5158A04;
	Wed, 28 Aug 2024 07:14:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB10328DB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829269; cv=none; b=SEMRocWzxkf43etbES2dHipIbcH45/7wjExu0NJiNZb1Hlo4I3bfRLU2Kjp0PGBsynktrs89wlzVO0j7QYFdFBKYvVn7iiZV9v8LPpFVgSy4WmLp93KC39Ccv/cc9qt21JDkQ/ZICvoWVYBh/mNaVzyORAFkjdkNEQ2bd62DgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829269; c=relaxed/simple;
	bh=MLxsYjshGA9NSvX977x358JfgU4Vpz9sQSh1uAlc+3s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HhkEw5JhcIxjp37ZSBj8gVykSWjBwmN0h1PHLgLXXRJt4ZCZ9Q5NOqPCw+we0JdZYH/tl5KY+9CLk8OcV1i+Qml8R9EDCtJUBD02sOp1/jqDqwMRcvQuE53Izzj+Y/7wTBKs7t4zXRxmTZPtbFsSdAXS/WFu7M6J4VC1D70TShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtwbZ0JJfzpTtv
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:12:42 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id CDEA0140202
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:14:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 15:14:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] genirq/msi: Use kmemdup_array() instead of kmemdup() for multiple allocation
Date: Wed, 28 Aug 2024 15:22:19 +0800
Message-ID: <20240828072219.1249250-1-ruanjinjie@huawei.com>
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
 kwepemh500013.china.huawei.com (7.202.181.146)

Let kmemdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index ca6e2ae6d6fc..3a24d6b5f559 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -82,7 +82,7 @@ static struct msi_desc *msi_alloc_desc(struct device *dev, int nvec,
 	desc->dev = dev;
 	desc->nvec_used = nvec;
 	if (affinity) {
-		desc->affinity = kmemdup(affinity, nvec * sizeof(*desc->affinity), GFP_KERNEL);
+		desc->affinity = kmemdup_array(affinity, nvec, sizeof(*desc->affinity), GFP_KERNEL);
 		if (!desc->affinity) {
 			kfree(desc);
 			return NULL;
-- 
2.34.1



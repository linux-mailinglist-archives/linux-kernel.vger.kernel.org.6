Return-Path: <linux-kernel+bounces-306734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2929642AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7275B252B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1B618CBE5;
	Thu, 29 Aug 2024 11:07:28 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998F19066C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929648; cv=none; b=Mu0uVN4j82XmdiyokYsZxKkkigNl9N+pIXY4hVLgxLEkqr3qfHjXIeYdvN2hZHnZW+o4ijEL3+Ma9Pk+BQcoH6X5/k3on14KqXaZUDzyuDv7rmWBmEy688IfYDZF1XndA8Gm08F9vsEkzyMc+CADiI3mKFdiri+xviykwVTBs/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929648; c=relaxed/simple;
	bh=TUw1P8VqmA8zpx1+EN0iducPrVcZOZ95N/mfpYC9Ous=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nclzp/Jm3vd3YYyb7NSQ+sBCTD+A9Ejk30YUNgqkMBp2Qul6kxSdpL3LRNFSDSvWRfpCmIzHb/tpgwYsCOWB0wQl6trFnXcXQmVd493G/atjKC/IR4imfkFhV8q10oVqDNyDPrBVMgflLqDG4zGdQPaPlV3mw17egM/BiwgBqS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WvdfB1ZgdzQqkW
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:02:26 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 203BD180105
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:07:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 19:07:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] genirq/proc: Use irq_move_pending() helper
Date: Thu, 29 Aug 2024 19:15:22 +0800
Message-ID: <20240829111522.230595-1-ruanjinjie@huawei.com>
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
 kwepemh500013.china.huawei.com (7.202.181.146)

If CONFIG_GENERIC_PENDING_IRQ is not set, irq_move_pending() will
return false, else return irqd_is_setaffinity_pending(), so use it to
simplify code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/proc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index dcf8190a58ca..230e75f3faae 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -52,10 +52,8 @@ static int show_irq_affinity(int type, struct seq_file *m)
 	case AFFINITY:
 	case AFFINITY_LIST:
 		mask = desc->irq_common_data.affinity;
-#ifdef CONFIG_GENERIC_PENDING_IRQ
-		if (irqd_is_setaffinity_pending(&desc->irq_data))
-			mask = desc->pending_mask;
-#endif
+		if (irq_move_pending(&desc->irq_data))
+			mask = irq_desc_get_pending_mask(desc);
 		break;
 	case EFFECTIVE:
 	case EFFECTIVE_LIST:
-- 
2.34.1



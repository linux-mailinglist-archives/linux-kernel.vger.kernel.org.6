Return-Path: <linux-kernel+bounces-285794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057B89512E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E39282D82
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03F3611E;
	Wed, 14 Aug 2024 03:05:05 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B21CD00
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723604704; cv=none; b=mqptJAcPp/nbwTrSTihL4seybG129scp+AS2qjujtOP8ZI3f3pou76zn2EZVfPOolwwFHXZunCh404gMgDpZRGgtpYPQUyE2RVjTU1iBsEQoTiZnMMK6S49bC31CmZy3Ftl14bbUB5MbIjPaRvwKAE4F6W2WnxS4ECNiq4x2NFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723604704; c=relaxed/simple;
	bh=7ER6YHeiHWDNtoJlxd77f9A8t7GS/umMYecLJAuQyoc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cibv+2D6kWcQ+xwX5RhmOmhdpYlBA38ZzJlMB9Bv/0v3oYuKdFCe3edMA3WiEsXQVl/GBa/pFqPidYFdgnR+iay+pENg1rGwjmUVo4TQSXtekYN0CqbmfqQznSKHKfr/fLbPAVZ1jM8hjh1Tah7Aj0ldMLxqZwy3OWEimE6xjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WkCkg3dTRzndv7;
	Wed, 14 Aug 2024 11:03:39 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id C169718006C;
	Wed, 14 Aug 2024 11:04:59 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 11:04:59 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <cw00.choi@samsung.com>, <krzk@kernel.org>, <lee@kernel.org>
Subject: [PATCH -next] mfd: max14577: fix module autoloading
Date: Wed, 14 Aug 2024 02:57:10 +0000
Message-ID: <20240814025710.3875859-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/mfd/max14577.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index 67bf4de4c0c1..6fce79ec2dc6 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -143,6 +143,7 @@ static const struct of_device_id max14577_dt_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, max14577_dt_match);
 
 static bool max14577_muic_volatile_reg(struct device *dev, unsigned int reg)
 {
-- 
2.34.1



Return-Path: <linux-kernel+bounces-271189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C79C944A97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F11B212E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F018B489;
	Thu,  1 Aug 2024 11:47:37 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8284161306
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512857; cv=none; b=twc7xXeLQsFVmVgDM5EY+Kip1uttVn/lCVoFSGBdE6RaYOUUPg2aCgJHJawCFTPLxRMQStnh2EwM5D+Csy9xH2YSSAMmT5hTBpbKCG75dqb6XE/FdgxuQ+8I2wgjg/iK1bFdPIox56Cnw9nOl9FqrizM4YX5VCHfeqxBBB9Zkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512857; c=relaxed/simple;
	bh=PPW8O0zKxhQp8j92DMFbh5N8gj5AWu95bb2fbOCnf7I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k30GsBNL0N0MmELnKjzL68pFg65MpE7xuG3PTHvzUShQbEQxgIZQeSxJHYQbUgsuqxTZdWk/N6tTrrsK7PJH09oee+sENxMM4YQXOEpSNEEQ8QLZsd4JIv7+Zc07MFiLudcTCy6BRYS7PUw22joiBHOSAH7EEkk9MWUn2IxBREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WZRx11R7nzfZ8b;
	Thu,  1 Aug 2024 19:45:41 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 37D1D180102;
	Thu,  1 Aug 2024 19:47:32 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 1 Aug
 2024 19:47:31 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] regulator: max77857: Make max77857_id static
Date: Thu, 1 Aug 2024 19:45:36 +0800
Message-ID: <20240801114536.472796-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Fix sparse warning:
drivers/regulator/max77857-regulator.c:430:28: warning: symbol 'max77857_id' was not declared. Should it be static?

max77857_id is not used outside the source file. Make it static.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/regulator/max77857-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77857-regulator.c b/drivers/regulator/max77857-regulator.c
index bc28dc8503a8..1216cc3a6f72 100644
--- a/drivers/regulator/max77857-regulator.c
+++ b/drivers/regulator/max77857-regulator.c
@@ -427,7 +427,7 @@ static int max77857_probe(struct i2c_client *client)
 	return 0;
 }
 
-const struct i2c_device_id max77857_id[] = {
+static const struct i2c_device_id max77857_id[] = {
 	{ "max77831", ID_MAX77831 },
 	{ "max77857", ID_MAX77857 },
 	{ "max77859", ID_MAX77859 },
-- 
2.34.1



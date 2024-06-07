Return-Path: <linux-kernel+bounces-205290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 043908FFA78
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9314DB22C27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB5013A89A;
	Fri,  7 Jun 2024 04:26:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655471748
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734402; cv=none; b=c+RT6y7kI5hDpFDd8IY0IqtmCjojaHWhoIPpbFagIYV/i7bzPKG6K86wyUUFY7tf3BP2HFYBYRsBjmTAcJfLpaU0NNo+UipQqsOFskJS0dEevefCwiXfIbKA1KxmKQmXub/a/TWIYmlqSDm5mgKfxRhsqfp6s2T8htFkAYzarYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734402; c=relaxed/simple;
	bh=GQySivaiRX14z1eZ89F5JjO7WBQlQwYooAtohJTTEDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvSEZ94gTgARTcmRWsWmHOFjmiKQ+m0q92A/nK5y6f1SiXgalqptnLTpqdYRj+OUFvrCIkVBq7YQMm6q8cytKqf0x24wPM3juSCf/kAzGZ4Pm8cqAifu5hBSCfzqGGkupW09Uk0SmAaSFiKMmtgjKhgXXqzzUa35RD26kfEk9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSm41G3LzdZMD;
	Fri,  7 Jun 2024 12:25:08 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 18E0218007E;
	Fri,  7 Jun 2024 12:26:33 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:32 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 008/110] mkfs.ubifs: Fix wrong xattr entry type
Date: Fri, 7 Jun 2024 12:24:33 +0800
Message-ID: <20240607042615.2069840-9-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

The type of xattr entry should be regular file, otherwise xattr entry
and xattr inode have inconsistent types.

Fixes: 50044efbd6e713 ("mkfs.ubifs: Add extended attribute support")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index 51852861..8bf073ce 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -1255,7 +1255,7 @@ static int add_xattr(struct ubifs_ino_node *host_ino, struct stat *st,
 
 	xent->ch.len = len;
 	xent->padding1 = 0;
-	xent->type = UBIFS_ITYPE_DIR;
+	xent->type = UBIFS_ITYPE_REG;
 	xent->nlen = cpu_to_le16(nm.len);
 
 	memcpy(xent->name, nm.name, nm.len + 1);
-- 
2.13.6



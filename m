Return-Path: <linux-kernel+bounces-561169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B809A60E41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344247A81F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4581F3B96;
	Fri, 14 Mar 2025 10:09:25 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FF225D6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946965; cv=none; b=jDiI9Xc01ip258K0/a+ZpmoqJPVv4DADsAgmicF3xOJ/WWoJCs5YZXbY258y+SCJlQ4lD9WFhFotpx3/iQeyLG972olS6RBO8dkKaNOf15q1loQXQjYHlbQc6zpzQdbnLzPe9gvd+3hIwXikkFK/fIESBfhdIjOt6UGOlHcvsRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946965; c=relaxed/simple;
	bh=Ipiu4UcihF/H2I3k8ATRaM653+z5hfvop4r0YJgDL/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=riK2kKJSG5eVQw9VJAn59UDEd+QgAqdNubB8u4Zxdvgse4SglEzJxH98e8dOQsOFMpb+LAqpuscYHTjggLOEDes469hL0usvp3+Flg+l5BMs+1nkeybguU1dLYNsHxRfYyfZTtxbdhhYItrgfmDe8BtVB4PJZ2ovh1z/ZnSzfYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZDg622dPyz1R6n8;
	Fri, 14 Mar 2025 18:07:38 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 692B4180069;
	Fri, 14 Mar 2025 18:09:20 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Mar 2025 18:09:20 +0800
Received: from localhost.localdomain (10.90.30.45) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 18:09:19 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2] soc: hisilicon: kunpeng_hccs: Fix incorrect string assembly
Date: Fri, 14 Mar 2025 18:01:43 +0800
Message-ID: <20250314100143.3377268-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn100009.china.huawei.com (7.202.194.112)

String assembly should use sysfs_emit_at() instead of sysfs_emit().

Fixes: 23fe8112a231 ("soc: hisilicon: kunpeng_hccs: Add used HCCS types sysfs")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 8aa8dec14911..444a8f59b7da 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -1539,8 +1539,8 @@ static ssize_t used_types_show(struct kobject *kobj,
 	u16 i;
 
 	for (i = 0; i < hdev->used_type_num - 1; i++)
-		len += sysfs_emit(&buf[len], "%s ", hdev->type_name_maps[i].name);
-	len += sysfs_emit(&buf[len], "%s\n", hdev->type_name_maps[i].name);
+		len += sysfs_emit_at(buf, len, "%s ", hdev->type_name_maps[i].name);
+	len += sysfs_emit_at(buf, len, "%s\n", hdev->type_name_maps[i].name);
 
 	return len;
 }
-- 
2.33.0



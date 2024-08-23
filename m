Return-Path: <linux-kernel+bounces-298189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD48995C3A8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3100F1F236A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94A238FA5;
	Fri, 23 Aug 2024 03:20:59 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0B25740
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724383259; cv=none; b=Fa6SrQYNV5JXDjkpmK4CKplbPH8VsQTdQH63k4mJcoJlzIC9PlPlquczTbCLDAfmyNJMk3/C1XuyW6Qs/AorKFRSkL863A/5hvPddXhueNzqs1vqhfkOFOHdWy0TTE0Qri1DQYhw8uJPIQPmfaMbjwAi/pai0Fja4lzJrQCRymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724383259; c=relaxed/simple;
	bh=TZ2PX+GbEO+93R3uc4tSB2tMEon/Jsr3dpqtAyklHxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgE21/0rO7MoY5WXXKcQO0LlrmxSkFAsJji2wdASl3WdcTRzHYE0Cm3WJjbEHNejlSbJ7BKxwPLstMBhL9nDNayeP77Fcy32rCGmrDpA3eefRwEoap46Djmm86VLHjDw7/lu2BhLsW8QzRmbXDBwZSxKeAvf2omX2nsNlKVFiN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WqlZz18VWz20mNc;
	Fri, 23 Aug 2024 11:16:11 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id A64E41402E0;
	Fri, 23 Aug 2024 11:20:54 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 11:20:54 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<Jonathan.Cameron@Huawei.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 2/6] soc: hisilicon: kunpeng_hccs: Return failure on having not die or port information
Date: Fri, 23 Aug 2024 11:10:55 +0800
Message-ID: <20240823031059.32579-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20240823031059.32579-1-lihuisong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
 <20240823031059.32579-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)

Driver is unavailable if all die number or all port number obtained from
firmware are zero. So return failure in this case.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index c4a57328f22a..6e88f597f267 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -451,6 +451,7 @@ static int hccs_query_all_die_info_on_platform(struct hccs_dev *hdev)
 	struct device *dev = hdev->dev;
 	struct hccs_chip_info *chip;
 	struct hccs_die_info *die;
+	bool has_die_info = false;
 	u8 i, j;
 	int ret;
 
@@ -459,6 +460,7 @@ static int hccs_query_all_die_info_on_platform(struct hccs_dev *hdev)
 		if (!chip->die_num)
 			continue;
 
+		has_die_info = true;
 		chip->dies = devm_kzalloc(hdev->dev,
 				chip->die_num * sizeof(struct hccs_die_info),
 				GFP_KERNEL);
@@ -480,7 +482,7 @@ static int hccs_query_all_die_info_on_platform(struct hccs_dev *hdev)
 		}
 	}
 
-	return 0;
+	return has_die_info ? 0 : -EINVAL;
 }
 
 static int hccs_get_bd_info(struct hccs_dev *hdev, u8 opcode,
@@ -601,6 +603,7 @@ static int hccs_query_all_port_info_on_platform(struct hccs_dev *hdev)
 	struct device *dev = hdev->dev;
 	struct hccs_chip_info *chip;
 	struct hccs_die_info *die;
+	bool has_port_info = false;
 	u8 i, j;
 	int ret;
 
@@ -611,6 +614,7 @@ static int hccs_query_all_port_info_on_platform(struct hccs_dev *hdev)
 			if (!die->port_num)
 				continue;
 
+			has_port_info = true;
 			die->ports = devm_kzalloc(dev,
 				die->port_num * sizeof(struct hccs_port_info),
 				GFP_KERNEL);
@@ -629,7 +633,7 @@ static int hccs_query_all_port_info_on_platform(struct hccs_dev *hdev)
 		}
 	}
 
-	return 0;
+	return has_port_info ? 0 : -EINVAL;
 }
 
 static int hccs_get_hw_info(struct hccs_dev *hdev)
-- 
2.22.0



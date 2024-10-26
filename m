Return-Path: <linux-kernel+bounces-382956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3429B1583
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EA21F22815
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC99178CEC;
	Sat, 26 Oct 2024 06:48:21 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577929CE5
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729925301; cv=none; b=A7oBtz5S39UYdE+76WenqnEETQ03EUuJp9akq8GipeG8UfhD783/PE6BA+EYduG7IvlvFzvbGbP15eM4IDiIpPGnHLRJ/87iaDbKhzZDXeMnpIcpKQWlTb3EGdWFb8icm8L3zenBNFv2tHdIaJXx7wIvlaw9jeEQ0n6yiT9xUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729925301; c=relaxed/simple;
	bh=O1TNfheB2a6EsFNPEZm3Dl2z5HQZBQXW35QyllVBiX4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IaGorxpQ26DOhebYdyiWHOhBKqCfrgA2oY6tMEhJRnF+cveg7tcgubGrh+kNU7p4jknZu4+9CGmgxR30PijKOSjnv5IgD0DOkHj4tjeQZGhD76KU6HJxHVgwS2zl1pl0pyOFZEAkKaA/+eUF+6G5O2OwXlA/bTVk55iwPuGbPDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Xb9Cg43MFz1T94K;
	Sat, 26 Oct 2024 14:46:07 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id E3CEA180105;
	Sat, 26 Oct 2024 14:48:12 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 26 Oct
 2024 14:48:12 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <gregkh@linuxfoundation.org>, <andriy.shevchenko@intel.com>,
	<quic_jjohnson@quicinc.com>, <jinqian@android.com>, <jia-cheng.hu@intel.com>,
	<u.kleine-koenig@pengutronix.de>, <alan@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <bobo.shaobowang@huawei.com>
Subject: [PATCH v2] goldfish: Fix unused const variable 'goldfish_pipe_acpi_match'
Date: Sat, 26 Oct 2024 15:01:50 +0800
Message-ID: <20241026070150.3239819-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Fix the following compilation warning:

drivers/platform/goldfish/goldfish_pipe.c:925:36: warning:
‘goldfish_pipe_acpi_match’ defined but not used
[-Wunused-const-variable=]
  925 | static const struct acpi_device_id goldfish_pipe_acpi_match[] = {

The complexity of config guards needed for ACPI_PTR() is not worthwhile
for the small amount of saved data. So remove the use of ACPI_PTR instead
and drop now unneeded linux/acpi.h include.

Fixes: d62f324b0ac8 ("goldfish: Enable ACPI-based enumeration for android pipe")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index c2aab0cfab33..ca78e5833136 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -61,7 +61,6 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
-#include <linux/acpi.h>
 #include <linux/bug.h>
 #include "goldfish_pipe_qemu.h"
 
@@ -940,7 +939,7 @@ static struct platform_driver goldfish_pipe_driver = {
 	.driver = {
 		.name = "goldfish_pipe",
 		.of_match_table = goldfish_pipe_of_match,
-		.acpi_match_table = ACPI_PTR(goldfish_pipe_acpi_match),
+		.acpi_match_table = goldfish_pipe_acpi_match,
 	}
 };
 
-- 
2.25.1



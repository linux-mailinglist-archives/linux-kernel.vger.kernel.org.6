Return-Path: <linux-kernel+bounces-381143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661C89AFAF1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965871C2238F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8762A1B393A;
	Fri, 25 Oct 2024 07:27:57 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C2667A0D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841277; cv=none; b=iOAkHmaKo0GuEw26YKHB8GNdXIsEni6uw56Ppzb8uig7trsSmWHiGaBa5D3Vht1xzTxn4+WlZSEyDnPq3e/PgqGYbVHLyH09CXbfepR4ZuDOLdXYwE0A9JlJizwjOVJCpOy4tjdPe4sQh4/sd6K1dlTo36i6C6kU8R7Yw3QKXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841277; c=relaxed/simple;
	bh=aSskqC5U1RElqxtAfFaHop8tdRPJwgBs3Aqv5brV6tg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I4IvriZpyRKRLX5DwJ2gOdC/g/UY0UlSQFRdNDv84fT2nWZrPgTvZqvzz9Ns9+f2HRf1snn0bGCAnuCJujTJTVcYa+naYpK9RLain0hDHjn5r9AO5gpBv/ztqHiAobL3grMTkHXMx8pr8qp3bxdg58kQ9j97lyKeZJyC4Ej+slc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XZZ5C0nvRz1HLbH;
	Fri, 25 Oct 2024 15:23:27 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 12DEE1A0188;
	Fri, 25 Oct 2024 15:27:50 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Oct
 2024 15:27:49 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <jia-cheng.hu@intel.com>, <gregkh@linuxfoundation.org>,
	<quic_jjohnson@quicinc.com>, <u.kleine-koenig@pengutronix.de>,
	<jinqian@android.com>, <alan@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <bobo.shaobowang@huawei.com>
Subject: [PATCH] goldfish: Fix unused const variable 'goldfish_pipe_acpi_match'
Date: Fri, 25 Oct 2024 15:41:29 +0800
Message-ID: <20241025074129.1920707-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Fix the following compilation warning:

drivers/platform/goldfish/goldfish_pipe.c:925:36: warning:
‘goldfish_pipe_acpi_match’ defined but not used
[-Wunused-const-variable=]
  925 | static const struct acpi_device_id goldfish_pipe_acpi_match[] = {

Only define the const variable when the CONFIG_ACPI is enabled.

Fixes: d62f324b0ac8 ("goldfish: Enable ACPI-based enumeration for android pipe")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index c2aab0cfab33..aeabacba3760 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -922,11 +922,13 @@ static void goldfish_pipe_remove(struct platform_device *pdev)
 	goldfish_pipe_device_deinit(pdev, dev);
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
 	{ "GFSH0003", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, goldfish_pipe_acpi_match);
+#endif
 
 static const struct of_device_id goldfish_pipe_of_match[] = {
 	{ .compatible = "google,android-pipe", },
-- 
2.25.1



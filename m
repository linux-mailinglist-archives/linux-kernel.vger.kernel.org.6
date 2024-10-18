Return-Path: <linux-kernel+bounces-371817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F0B9A40C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762BE1C25C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16A614B970;
	Fri, 18 Oct 2024 14:09:17 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0724A08
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260557; cv=none; b=tnLYYyZ4afVklMorz6GAlk5B9aozwuHGctaVTjqzCurDTUb8DBy/+uP3G85lbjICGT0nRGQ5a+f6DefMMOtd+QQtTNOBb+TYWwVIrl0FmvXXwASqhSM5p1eFaT2Lm0kxZkn+ThjJ/uDPNpvhtFWK5yw2X1ORM3g0Kbk3B2/RwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260557; c=relaxed/simple;
	bh=LbSAVAatv3CnXikzzYlGLA1iYt5kVqgUs0buejnxxHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qi3Cb/jDZrxNg2V6FTDV40Opv4leE2dZ5pCCQi1bpoLtnoc8bYP41oRyeN189/Z2uNzY3xhKAEOX8YsC0+yLdWtjslmRakyDIXZmtExXf4/6NEoj94JFR7b/tX/LLXeeVfs4DTklJDgbk6rpbPtMr9XKshBhQ1UV383AWhO7g/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XVRKh08FLz1HLDp;
	Fri, 18 Oct 2024 22:04:56 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id AD88F1A0188;
	Fri, 18 Oct 2024 22:09:11 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Oct 2024 22:09:11 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
	<coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] coresight: trbe: Fix return value check in arm_trbe_register_coresight_cpu()
Date: Fri, 18 Oct 2024 22:08:58 +0800
Message-ID: <20241018140858.711-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)

Function devm_kzalloc() returns NULL instead of ERR_PTR() when it fails.
The IS_ERR() test in the return value check should be replaced with NULL
test.

Fixes: 39744738a67d ("coresight: trbe: Allocate platform data per device")
Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 96a32b213669940..93fe9860acf16bd 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1266,7 +1266,7 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
 	 * into the device for that purpose.
 	 */
 	desc.pdata = devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
-	if (IS_ERR(desc.pdata))
+	if (!desc.pdata)
 		goto cpu_clear;
 
 	desc.type = CORESIGHT_DEV_TYPE_SINK;
-- 
2.34.1



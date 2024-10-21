Return-Path: <linux-kernel+bounces-373780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B5D9A5CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906FC1F20FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCA91D14E2;
	Mon, 21 Oct 2024 07:21:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4B1CF285
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495307; cv=none; b=pDAhTTShwm1mcs7/zUV2doWzecWFfPYyFt+Vi3tEpzvq0nbD1Hwq/rowyleRICr5hElLeoZ1182dy+ktoy16cPoIrd0YXnhBuNp/wxZ8httDdNvCQQNOhIAZoJM8Xs0x6YOW/pfVa7/uXNC7XjGUE3Gnxr0Cm4zltK90KAYMUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495307; c=relaxed/simple;
	bh=jyoot00kEOccWXaaTnZ5kkvm4fU1594iZ6EhKInLnL8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T4uXUIU4MCYcgZCiCJLvTmzYoJ7SaPiL3/Vv25sk56gDzvi9YTQBqwr7x+4S6G1hbQPbhKw46BGVe/EAkwi7CAbtH7WQ9hJjMJw986iySe/Re3WPRK+IY6P+cCkK1XWjf/ra/YybGhRqV/fbLuFgi0E94Nvyt6P6j9tLKdxb1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XX6Bm2nyCzpX5r;
	Mon, 21 Oct 2024 15:19:44 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id C866A18005F;
	Mon, 21 Oct 2024 15:21:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Oct 2024 15:21:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
	<coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>, Markus Elfring
	<Markus.Elfring@web.de>
Subject: [PATCH v2 1/1] coresight: trbe: Fix return value check in arm_trbe_register_coresight_cpu()
Date: Mon, 21 Oct 2024 15:21:19 +0800
Message-ID: <20241021072120.739-1-thunder.leizhen@huawei.com>
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

The commit in the 'Fixes:' uses devm_kzalloc() to allocate platform data
memory instead of coresight_get_platform_data(), but forgot to update the
return value check code accordingly. Fix the incorrect return value check
for devm_kzalloc(), which returns NULL instead of ERR_PTR() when it fails.

Fixes: 4277f035d227 ("coresight: trbe: Add a representative coresight_platform_data for TRBE")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
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



Return-Path: <linux-kernel+bounces-276093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A793C948E46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A852886E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DD81C232A;
	Tue,  6 Aug 2024 12:00:58 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC5165EFA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945657; cv=none; b=hVJ8CR43fVsZiiNYfhCtmet7af2qwYb3Xiw9AYnniTWaDhGWN7UnjFVtecEFG7n7BKMRO3D+9Kn+8HXFiwdpjK8V6/rl9L+T0q0Q5+fjM1+pQtwmFfO5IMgVyUpKi0V+jA+pFQqi3Sn7KbYtDDbga7vAG9CYPpjJVGqe6vPFIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945657; c=relaxed/simple;
	bh=MsSt96AGd2jq91O4H2m69HgMZRLLGD9PwgnN+FW8BRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QDKX2HdZ8I/moQxoZO9A6PnAwyz0ExlFxq86F7I/c03AfNHGWSZmtovyZNAs3CMJlT1kxPAItoL7MqvjAWqxoe4gaTzLg7PO/cdJRlOy4Qm3ITn26XR+UQWFCRtQ3xpg4aUpxwqmjDnauazrOcNJoKXAM8P07+4aK1ZhGCEj1js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WdWyl246Mz1HFnY;
	Tue,  6 Aug 2024 19:57:51 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id E038A1A016C;
	Tue,  6 Aug 2024 20:00:46 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 6 Aug 2024 20:00:46 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <sboyd@kernel.org>, <joshc@codeaurora.org>, <gregkh@linuxfoundation.org>,
	<kheitke@codeaurora.org>, <cuigaosheng1@huawei.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next,v2] spmi: pmic-arb: Add check for return value of platform_get_resource_byname
Date: Tue, 6 Aug 2024 20:00:45 +0800
Message-ID: <20240806120045.3113451-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Add check for the return value of platform_get_resource_byname() and
return the error if it fails to catch the error.

Fixes: 39ae93e3a31d ("spmi: Add MSM PMIC Arbiter SPMI controller")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
v2: Add the fixes tag, thanks!
 drivers/spmi/spmi-pmic-arb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 9ba9495fcc4b..5f5f2f0a10b9 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1808,6 +1808,9 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
+	if (!res)
+		return -EINVAL;
+
 	core = devm_ioremap(dev, res->start, resource_size(res));
 	if (!core)
 		return -ENOMEM;
-- 
2.25.1



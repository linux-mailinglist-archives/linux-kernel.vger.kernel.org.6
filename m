Return-Path: <linux-kernel+bounces-301041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7286E95EBCC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152911F226B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C9615574D;
	Mon, 26 Aug 2024 08:21:04 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54113F45F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660463; cv=none; b=omEY+CrLMfyDW+hlCTEe92WSg4JbypNKth6x47l8RM8T0pbBYMFi1mPsyaS+DyTm5+lE96lhxGkO0jwsW5r4OV2911lh1kDAQ8Yb0IN6w+4gZJhYAzryhtOc4dTlm6CQf/x3uoOH6/SCVOTRhR5LbSsqGTywZdBKyMFpXIgvzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660463; c=relaxed/simple;
	bh=nYyO6LwgVFzXt2p7i0oGLkc8P1po82g1BGlszDnuFBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqmXdeVpeIsxRD70gwSLn2KEaeWeLRTXjdHGZ+oJDM94ID9cronP4N6CkFF8hhVMEytZ5H3ekPNvnxx7ASX3CqaFPeovLsaLMsNAbhZX+onlvcuRt4vpcJxQxGYtpuslbOtRc4zn5mWM/O7h6hhQPKi8A5LnhC66KQt0TWw9F50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WskBQ14dKz14Dk8;
	Mon, 26 Aug 2024 16:20:14 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8872714037E;
	Mon, 26 Aug 2024 16:20:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:20:59 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 01/12] mfd: max77620: Use for_each_child_of_node_scoped()
Date: Mon, 26 Aug 2024 16:28:36 +0800
Message-ID: <20240826082847.2591036-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826082847.2591036-1-ruanjinjie@huawei.com>
References: <20240826082847.2591036-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Avoids the need for manual cleanup of_node_put() in early exits
from the loop.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/mfd/max77620.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index 74ef3f6d576c..89b30ef91f4f 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -400,7 +400,7 @@ static int max77620_config_fps(struct max77620_chip *chip,
 static int max77620_initialise_fps(struct max77620_chip *chip)
 {
 	struct device *dev = chip->dev;
-	struct device_node *fps_np, *fps_child;
+	struct device_node *fps_np;
 	u8 config;
 	int fps_id;
 	int ret;
@@ -414,10 +414,9 @@ static int max77620_initialise_fps(struct max77620_chip *chip)
 	if (!fps_np)
 		goto skip_fps;
 
-	for_each_child_of_node(fps_np, fps_child) {
+	for_each_child_of_node_scoped(fps_np, fps_child) {
 		ret = max77620_config_fps(chip, fps_child);
 		if (ret < 0) {
-			of_node_put(fps_child);
 			of_node_put(fps_np);
 			return ret;
 		}
-- 
2.34.1



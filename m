Return-Path: <linux-kernel+bounces-433171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACAF9E54BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491BA1882D87
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50497214A60;
	Thu,  5 Dec 2024 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="oPPlOlW2"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A1212B19
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399909; cv=none; b=P+kHT2zz+/n49OHfwHPrlrlaxKwuybTE59o7GEc8BZEzutko4LjkjcAjMfZqT7OLNfOiB4nLSfeghQ7ftaDF1vylLtY5AalYDzRcmXxqRzwUkw9AP0DJp5xZoje/HuaXEBeGBc0XtTwWhvfaCNDRHio2xSOpPz1dnyke8NkeCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399909; c=relaxed/simple;
	bh=YIBROYubjmg/zp0GLK68YuHoWqN46lpaVYYnVqcxdCg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fmXYLYPU4OPd3gRoRBjVCr4os+u0kiCupE7XtOn4Xt5RHHz4KSlAjtrOTAaTLUaj3W5FglvVNyi3GABwXPWGRg21oIwo+FSbjcMzMAwM1F+ciWKhW96qRvRpRb8ib6TvJ6FoJjEgNnOQQnvtTaZs0Tl9siRfIqLOI80nHJLrX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=oPPlOlW2; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B570HfW016009;
	Thu, 5 Dec 2024 05:58:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=V/xuBbh+eTmcGMXm
	hDDJV6Wnq2SDi8S7eszYlBr2JdY=; b=oPPlOlW2BIA7T6mrsM7WNQurNXNdsr7o
	WpTin7r4xlQ3IpeM0oFIaamiNGnPKmqhceNrXdS+ssqRxE1h6KHJ+wNZMw8PDHEB
	DnD0ijusj4tDjzWEmwLnmTaQguMmCMgramzUg3MGajKxS+HW4lp7+C6L0YX3m0OI
	IMq+5Cgp/53Tbv+vkQ53IrqSWnaur8vyBNbFkHhmIZMGwLnJhYyQPXQryqselhG8
	8O87ekwEf4hRL2ZskfNeOgMPMCM3TFx2IgvIarwaPiT9XyouFBB65+KI2yuefqMD
	gculyZTBHVidTkfOIXOVf8ZtAHGpv0jUrqxcQCC5MeqfqmamszumQQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4381022c8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 05:58:24 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 5 Dec
 2024 11:58:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 5 Dec 2024 11:58:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 9DB1282024A;
	Thu,  5 Dec 2024 11:58:22 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH RESEND 1/4] mfd: cs42l43: Prepare support for updated bios patch
Date: Thu, 5 Dec 2024 11:58:19 +0000
Message-ID: <20241205115822.2371719-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NxZvSvx23ombRUN2pMB6PPwAp0GhZOCI
X-Proofpoint-ORIG-GUID: NxZvSvx23ombRUN2pMB6PPwAp0GhZOCI
X-Proofpoint-Spam-Reason: safe

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

Newer bios patch firmware versions now require use of the shadow register
interface, which was previously only required by the full firmware, update
the check accordingly.

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index e5f17fc430e4..11a1b7f1e121 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -48,6 +48,7 @@
 
 #define CS42L43_MCU_SUPPORTED_REV		0x2105
 #define CS42L43_MCU_SHADOW_REGS_REQUIRED_REV	0x2200
+#define CS42L43_BIOS_SHADOW_REGS_REQUIRED_REV	0x1002
 #define CS42L43_MCU_SUPPORTED_BIOS_REV		0x0001
 
 #define CS42L43_VDDP_DELAY_US			50
@@ -773,7 +774,8 @@ static int cs42l43_mcu_update_step(struct cs42l43 *cs42l43)
 	 * Later versions of the firmwware require the driver to access some
 	 * features through a set of shadow registers.
 	 */
-	shadow = mcu_rev >= CS42L43_MCU_SHADOW_REGS_REQUIRED_REV;
+	shadow = (mcu_rev >= CS42L43_MCU_SHADOW_REGS_REQUIRED_REV) ||
+		 (bios_rev >= CS42L43_BIOS_SHADOW_REGS_REQUIRED_REV);
 
 	ret = regmap_read(cs42l43->regmap, CS42L43_BOOT_CONTROL, &secure_cfg);
 	if (ret) {
-- 
2.39.5



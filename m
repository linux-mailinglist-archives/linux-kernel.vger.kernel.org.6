Return-Path: <linux-kernel+bounces-217682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F2A90B2E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFEA1C21B94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEFC198E8E;
	Mon, 17 Jun 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qjyMtkAk"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A021D953A;
	Mon, 17 Jun 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632443; cv=none; b=m58wcb92mOegPlE6AxX59J161vaOsgTs/9AzyP+MLTx+qON6So6DzVbzHLdl/FeBnODlP5YW162wVlWU/tVT8eHEvzvUeEIPFob3+NUhcP0+jQ46zUoSfnwYSllIV1KQCvglO7aW4Y4WPzjSHDDTno86mcBWg6IKzZ4vCHrB4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632443; c=relaxed/simple;
	bh=OkXAeXiSMR9q2KgPDAvjGfQHai3NsT8ZxFVGcUPxbHs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I9HK3/nbUxl/rFjfvFsvdWVlt6MET0pfB6Qsc8snBdOCd7lwqx3zQM+auwy/l7bIrtP+tibvni4lE7Y+vCxzbLYCtmWgAucev2jYNYLYXpaxFSKfCUeUlMpE2jHbnx39risZtuLbJG6pSJahFFOtbm+yDTtc97kBO4QI8575UrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qjyMtkAk; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H5aOHK023213;
	Mon, 17 Jun 2024 08:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Q9ihO4w628bMz136
	f8/Vddts0+N5M5iKJ+D+B8in+1I=; b=qjyMtkAkuZEpFWv+s2lo5BBU7LjJrDBS
	ZKCDuUIePqhmbCHI+MojCru3UxTgJFNUI7pcsKAbm17eZOshWtZmk+a0u3VyxDhO
	6ydHByiRmV3reb/rq20JHKYRfyFZwifOiTSSrKFTmxRBaE89IxnfR8JGeKTDH4UG
	kAgV2OTeG9OwjAzm2kAXsQHkpcDyXoaOOJZ+/7tK5Ki1JfGdf0Vsydp3u2+YHZYm
	+/G7sYeNKKrABIR0IxHWsWujQS6573NcLJxl63ZrvEnHOXtiUsG992vdhbXChKmT
	hGauT7JSvWi3dIcZuCKFef7IvbD9dodXcOKHLCM6R3ZUMC/n2ipc5A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ys8by1rbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 08:53:43 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 14:53:40 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 17 Jun 2024 14:53:40 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.31])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 735C5820248;
	Mon, 17 Jun 2024 13:53:40 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ numbers
Date: Mon, 17 Jun 2024 14:53:38 +0100
Message-ID: <20240617135338.82006-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Rn7sdFrjrK0EIUNROXcVN37vn7ZbU_iw
X-Proofpoint-GUID: Rn7sdFrjrK0EIUNROXcVN37vn7ZbU_iw
X-Proofpoint-Spam-Reason: safe

IRQ lookup functions such as those in ACPI can return error values when
an IRQ is not defined. The i2c core driver converts the error codes to a
value of 0 and the SPI bus driver passes them unaltered to client device
drivers.

The cs35l56 driver should only accept positive non-zero values as IRQ
numbers.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Fixes: 8a731fd37f8b ("ASoC: cs35l56: Move utility functions to shared file")
---
 sound/soc/codecs/cs35l56-shared.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 27869e14e9c8..880228f89baf 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -397,7 +397,7 @@ int cs35l56_irq_request(struct cs35l56_base *cs35l56_base, int irq)
 {
 	int ret;
 
-	if (!irq)
+	if (irq < 1)
 		return 0;
 
 	ret = devm_request_threaded_irq(cs35l56_base->dev, irq, NULL, cs35l56_irq,
-- 
2.34.1



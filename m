Return-Path: <linux-kernel+bounces-433173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE449E54BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92126164432
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC42214A88;
	Thu,  5 Dec 2024 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="I2+u2TXb"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6E207661
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399911; cv=none; b=bk5LuqBcn5tkNKl9Fjl0d2P/JfgunREeWEcWt/D3uIH2XHlmrS63P+rTExeS9mwv85Yx17HtBePUGeMcZMSHfHusfYcGkjsWgrDJATOBYO8t5Z0BEpHbyWLOGQE65ZT7l7QT9Hpjf1EJJ1BCU1oKJBiqadINvaEsCrCoP6uDWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399911; c=relaxed/simple;
	bh=box41ZSfJrdqPvo9RiDNxqEg5L48s3gAybqXLE7cnjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjnvFvmfgpdfQn0+CAbHWWRNv7+AGaQrWo3bnUiLrJVjiZQpolnCdWEhAiiKWTMm4+VvanId+Z7yIdHrt4V7ctRw3hqwHiBUZrEkLUdVJIYEBv39zM0R8A8+rikLmUgYTN9WvsOiCoJw9UmA3JbG5nmLoF9pUXu9ZgDrKUyQ0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=I2+u2TXb; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B570HfY016009;
	Thu, 5 Dec 2024 05:58:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=XPXTWDuHLZOrxcRJyPcBgA38NsnSdUQLez+1Z9pwm/M=; b=
	I2+u2TXblGuInDLBiLgxloLwStN4nL7pi0DFXt3PwRu7qN3l7eM7srZwr+VcA9LR
	G0W5sYmuFkWhKfVu38ivteYS8tVbOnFqh2yHs/N3GeHgFHG3WIh4AZ7HCJqLwvCQ
	sjhk9PnSiD9/d1/bTYK2M7JtmAROh2QgqpzcoblPo1hne7VRTYf9R1l5z4srkj03
	bIHXyPTIPA2bXvNs2LvIGIOgGj5R7yYgR0zhTGi4SSRXAXOOXecySyKGqI/i3UVe
	pT/dTdGM882vcOYoAETlp2fvqTVGhyMG1rcfh7qgawuVnaXUn5HqfsWFqESylYOA
	0oJrqq9XmLT8L1Jsb31wow==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4381022c8a-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 05:58:26 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 5 Dec
 2024 11:58:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 5 Dec 2024 11:58:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B99D0820248;
	Thu,  5 Dec 2024 11:58:22 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 3/4] mfd: cs42l43: Increase the SoundWire attach timeout
Date: Thu, 5 Dec 2024 11:58:21 +0000
Message-ID: <20241205115822.2371719-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205115822.2371719-1-ckeepax@opensource.cirrus.com>
References: <20241205115822.2371719-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: C4w3btQqZB1-LaELpEwQ3UljUxqOeK0L
X-Proofpoint-ORIG-GUID: C4w3btQqZB1-LaELpEwQ3UljUxqOeK0L
X-Proofpoint-Spam-Reason: safe

Some SoundWire controllers take a very long time to fully power up. As
such, increase the timeout that the cs42l43 driver will wait for the
device to initially appear on the bus.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 167d4060b230..9572c7fd419a 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -29,7 +29,7 @@
 
 #define CS42L43_RESET_DELAY_MS			20
 
-#define CS42L43_SDW_ATTACH_TIMEOUT_MS		500
+#define CS42L43_SDW_ATTACH_TIMEOUT_MS		5000
 #define CS42L43_SDW_DETACH_TIMEOUT_MS		100
 
 #define CS42L43_MCU_BOOT_STAGE1			1
-- 
2.39.5



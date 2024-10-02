Return-Path: <linux-kernel+bounces-347454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0F598D2EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584FC1F23360
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC9C1CF7B0;
	Wed,  2 Oct 2024 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SZNP5S0F"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64F1CF5FC
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871520; cv=none; b=RCZx0jLpmi/MO3bxjgHm5DHPiZIqcJmaD5wQYWGUhPDYiGYDo5pZ9MzBpuYGXlknJwIfI/DSWxr5PU4VQHPAziDwDv4Q8JprlHAq9p+IGJmSypToCODmTDtdegrkfilVcxUbp8xo17KvgY66SrlrVqrnqjX8AC1Ji8+7vqno6O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871520; c=relaxed/simple;
	bh=CuNqCFcoFEvHSrHuwGXvjjiMviHDxcjjaMi7ZS8UL2w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lnd0t2WO2LrXPP9cH3otWyrbWauedqGPCl5SpGDZ7zj9Hj+HpMqkjDl8c4WVZIJlfTsQmrpyZVpf0dhAwgOI7uaSfUCBvZKI71eZpPK3RSAvF3qyDJ1dkyZv73faOmY0ZQ0SIf2YbfolnT8hI2DY+/lwbc+pBvTOPKypxRZFozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=SZNP5S0F; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492AJpw5027317;
	Wed, 2 Oct 2024 07:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=JiTy131EgbXOTdgc
	D3Mq3WlWGaBVxd48cc9703ryopg=; b=SZNP5S0Fsf7mXY1r/7P4ohPSd0dA8AES
	4HPjtrWkcaiPet4v+dKL8PpDSH+/xkEppgkKThzCb2jy5sl7EhY4hDn1BgqTIlSp
	MesLckxxv7+1hqJdZjYsVoCmeZFf0w/E3CdjOgMaMstcVEoP2QLdUHtlQvi26ieT
	/nd7Hntv3PpXL+mZtWQASJD4in9IaKFovOIfCVKqzmwJnm+CZUiAeEEUVRCKkwbz
	yA7ukmVSixleVfg46o424q+Tx7m13GP2itQ/GxUKzS7Mg80ZtU74zpowiO6gK2BS
	w8YMOB6ijKc0UIqh1AnRNUODN2MYTlzorz7PNpdBSFYA6Z9LgpvzCQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 41xe7jvyx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 07:13:13 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 2 Oct 2024
 13:13:11 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 2 Oct 2024 13:13:11 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CD0EB820244;
	Wed,  2 Oct 2024 12:13:11 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>
CC: <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: cs42l43: Fix issues in probe error paths
Date: Wed, 2 Oct 2024 13:13:11 +0100
Message-ID: <20241002121311.162691-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: idLFw_MgFEmHRPEcRy-ia5DG8DYUwUmM
X-Proofpoint-GUID: idLFw_MgFEmHRPEcRy-ia5DG8DYUwUmM
X-Proofpoint-Spam-Reason: safe

The error path in cs42l43_boot_work() will lead to an unbalanced
regulator put, when the driver is removed. Fix this by relying
on remove to power down the device. Also the boot work needs to
be synchronised with driver remove, to ensure the work is not
still running after the driver has been removed. Add the required
cancel_work_sync().

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index ae8fd37afb75..3b4efb294471 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -967,7 +967,6 @@ static void cs42l43_boot_work(struct work_struct *work)
 
 err:
 	pm_runtime_put_sync(cs42l43->dev);
-	cs42l43_dev_remove(cs42l43);
 }
 
 static int cs42l43_power_up(struct cs42l43 *cs42l43)
@@ -1101,6 +1100,8 @@ EXPORT_SYMBOL_NS_GPL(cs42l43_dev_probe, MFD_CS42L43);
 
 void cs42l43_dev_remove(struct cs42l43 *cs42l43)
 {
+	cancel_work_sync(&cs42l43->boot_work);
+
 	cs42l43_power_down(cs42l43);
 }
 EXPORT_SYMBOL_NS_GPL(cs42l43_dev_remove, MFD_CS42L43);
-- 
2.39.5



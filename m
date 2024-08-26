Return-Path: <linux-kernel+bounces-300705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EDA95E766
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263411C21196
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A536EB7D;
	Mon, 26 Aug 2024 03:43:45 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F918027
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724643825; cv=none; b=S4Rc4wfSZpqyeFwfkwrXcKozZAjZgz6cd/1yzhdRM+i+iF/57EiTBSuqOg9FqLHGVLDDfJDTk4jXVW+FDP9c0iVv7WkvyXZgz3MEEleHcmSJSvp3sCZz6Kid4R/npgZfP+LecJiXBhx/MnWG+JowpFS2Lw1ZOlm76iIhrLuc7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724643825; c=relaxed/simple;
	bh=TieaZ3g53TDKKxb/6Q4m97HljMf2uibIIWFtoMZ3MoY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=roKkCoF9y+s2liXS+dkv11+CKmkYKPlADdFkGhxGNzMA+vl4tp82y5wwc30MRr0TAVILsDctKfgm7WfTQEs9ONNuugmj7uTH5Qeg/31HTrobE+nrSpzz18zDdxKrkxGCIs0F+4HRRXQdMwfHUqhTPwFmbmmIp1BpPsMImwlN/6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 26 Aug
 2024 11:38:21 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 26 Aug 2024 11:38:21 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <alexandre.belloni@bootlin.com>, <jarkko.nikula@linux.intel.com>,
	<billy_tsai@aspeedtech.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1] i3c/master: cmd_v1: Fix the rule for getting i3c mode
Date: Mon, 26 Aug 2024 11:38:21 +0800
Message-ID: <20240826033821.175591-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Based on the I3C TCRI specification, the rules for determining the I3C
mode are as follows:
I3C SCL rate > 8MHz: use SDR0, with a maximum data rate of 8MHz
I3C SCL rate > 6MHz: use SDR1, with a maximum data rate of 6MHz
I3C SCL rate > 4MHz: use SDR2, with a maximum data rate of 4MHz
I3C SCL rate > 2MHz: use SDR3, with a maximum data rate of 2MHz
Otherwise, use SDR4

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Change-Id: If0e1100ca601c8a2f96ecbcc0f74e6fdb5e273df
---
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
index 638b054d6c92..dd636094b07f 100644
--- a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
@@ -123,17 +123,15 @@ static enum hci_cmd_mode get_i3c_mode(struct i3c_hci *hci)
 {
 	struct i3c_bus *bus = i3c_master_get_bus(&hci->master);
 
-	if (bus->scl_rate.i3c >= 12500000)
-		return MODE_I3C_SDR0;
 	if (bus->scl_rate.i3c > 8000000)
-		return MODE_I3C_SDR1;
+		return MODE_I3C_SDR0;
 	if (bus->scl_rate.i3c > 6000000)
-		return MODE_I3C_SDR2;
+		return MODE_I3C_SDR1;
 	if (bus->scl_rate.i3c > 4000000)
-		return MODE_I3C_SDR3;
+		return MODE_I3C_SDR2;
 	if (bus->scl_rate.i3c > 2000000)
-		return MODE_I3C_SDR4;
-	return MODE_I3C_Fm_FmP;
+		return MODE_I3C_SDR3;
+	return MODE_I3C_SDR4;
 }
 
 static enum hci_cmd_mode get_i2c_mode(struct i3c_hci *hci)
-- 
2.25.1



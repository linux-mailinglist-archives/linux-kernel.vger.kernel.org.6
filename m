Return-Path: <linux-kernel+bounces-565984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD2FA671C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640577A4455
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF2D20896B;
	Tue, 18 Mar 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OdHg6rMf"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AFD1FA14B;
	Tue, 18 Mar 2025 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294857; cv=none; b=kGOJf67FKWJX0fMWnUtgjUrWjDGwVbYW7wGPNmRjUSNL5Ty+V3GIyP2GbpTzr3zBRWfrEMAHNlqs3jbK2kpmCZXnfTgaUmTJOqWcktLtwVjjq6d40YQsAISJlvGRzGvUoGcqGjVyLBtmEYOpLKjnp+O4CQuBIrMg/Q0FvR9U4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294857; c=relaxed/simple;
	bh=xjjm6uUFdWoj9rCADOjpstQTqGdlzI1AsiThsAQZ/P0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o4euOSLJ34c4DlNSyHbM1GQu1gZ7N1k+wx4Ef2HTvikYSLm/bOmQo1i2bFFxkzhwWLbDHFgCYAxcQpXd/7Y+burEX1jddQePU+wvOxouIAJdTNsMwrldelK4aRPDd0l2k7HmDuTUczKZNySlta2r4FY5J3kv76LKbeQ6h22QT0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OdHg6rMf; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52IAlHD13130046
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 18 Mar 2025 05:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742294837;
	bh=lFhoZzRIA7Uvs1Mtqf1M7uFFXyhhUO8+AwRShrEMx34=;
	h=From:To:CC:Subject:Date;
	b=OdHg6rMfM8DDVglH5sCTqIOIC8KIcLKADXbAYIY8NQXl8xouGPv1WDo9AxtMnvnwM
	 t6sxYLb5Ps+aD2Zo0O4I+bUh/QppbygNKZAirPMreP8iJUi4/nPsl0A8zBx2JvZK6i
	 ZjPn8Y/LRjm7Jt69Kf1QcnPR+cSsAQqcs+ATy4b0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52IAlHWu013250;
	Tue, 18 Mar 2025 05:47:17 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Mar 2025 05:47:16 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Mar 2025 05:47:16 -0500
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.98])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52IAlFIG090666;
	Tue, 18 Mar 2025 05:47:16 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <peter.ujfalusi@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <perex@perex.cz>, <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH] ASoC: ti: j721e-evm: Reduce log level for EPROBE_DEFER
Date: Tue, 18 Mar 2025 16:17:15 +0530
Message-ID: <20250318104715.43267-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Drop the log level for deferral probe to avoid flooding in kernel logs.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 sound/soc/ti/j721e-evm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index c0fa72e626ff..2057d46ad884 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -913,8 +913,9 @@ static int j721e_soc_probe(struct platform_device *pdev)
 	mutex_init(&priv->mutex);
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
-		dev_err(&pdev->dev, "devm_snd_soc_register_card() failed: %d\n",
-			ret);
+		dev_err_probe(&pdev->dev, ret,
+			      "devm_snd_soc_register_card() failed: %d\n",
+			      ret);
 
 	return ret;
 }
-- 
2.34.1



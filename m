Return-Path: <linux-kernel+bounces-202217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD6D8FC966
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493761F23DE8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D079191493;
	Wed,  5 Jun 2024 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="Gb0W7zja"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD71946D3;
	Wed,  5 Jun 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717584717; cv=none; b=pGiqJnF0UbxBm1fSXD9f8EG7iaz5mgCn1sqdWX8MO8EskjA10MSMDTUsblB3JWFFRvmY4Qqc5wAueC2LG1IET/aup3oqLZd5YmAL0FQnImFJOBK0G7bhDiUYhQraIIc+tRkBw7+aPTtmpPAGOxsNOJtbmoGGRiEvMK4EYURhMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717584717; c=relaxed/simple;
	bh=JgcnB+Jnu79wChlRxQ6yAuCFP4ya7asdyOsYYtVBMS4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rJmPzwBNaQMA/H1+4Oa8W7t8RsZZGbH8oM2uYJS0nCiv+ugCocX06Sptk34+2Xwkx4BJJUfISyKPOZdwGt/2cDlmk3CyW+pNdcP+FXx21SduWop6JxGo0urWbRzZM1iCJpe2wflWAnDzAQ848BC/tCS+z8ULt91isP5jZEXscE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=Gb0W7zja; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 37B29100003;
	Wed,  5 Jun 2024 13:51:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1717584695; bh=qTW8vJZuEk1pq+43pj+Rrt+D8s/7mBU+BfhX8XQU6oY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Gb0W7zjaJ+SUG6qlpLFQf3iQ5WAjAXAstizjVBHtHCb5CaLe9aR1wAeOpP9bvFh6w
	 OkYqgemttLPnaMt/0j1B/P2GQQMk/LpyfaZvLMBEU7q7Nuhs6Zs/0kYmzElTEptDFB
	 8YgPHZDZxyyuaNneF0VNNs0Yg0bCE75yW3l0yvwyUdxe8VpvpUco6vpPqYx2OaMnRj
	 wBLdbGXQ1QM4z3HEufrXSQE71CHexsgbmsfVLl41UXHVzLvYzPTaHFxsGy87VI/Fvz
	 ncDRUkjoT6Mhhrtl239s4l9d6SRWM1SHMyH4StghGCHTmkipvUf6Ms9WS+2xfjzLX5
	 V/xvyKs1L34PA==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed,  5 Jun 2024 13:50:23 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Jun 2024
 13:50:02 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Banajit Goswami
	<bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
	Venkata Prasad Potturu <quic_potturu@quicinc.com>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] ASoC: qcom: Adjust issues in case of DT error in asoc_qcom_lpass_cpu_platform_probe()
Date: Wed, 5 Jun 2024 13:49:53 +0300
Message-ID: <20240605104953.12072-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185736 [Jun 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/05 09:22:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/05 07:06:00 #25449783
X-KSMG-AntiVirus-Status: Clean, skipped

If IORESOURCE_MEM "lpass-rxtx-cdc-dma-lpm" or "lpass-va-cdc-dma-lpm"
resources is not provided in Device Tree due to any error,
platform_get_resource_byname() will return NULL which is later
dereferenced. According to sound/qcom,lpass-cpu.yaml, these resources
are provided, but DT can be broken due to any error. In such cases driver
must be able to protect itself, since the DT is external data for the
driver.
Adjust this issues by adding NULL return check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b138706225c9 ("ASoC: qcom: Add regmap config support for codec dma driver")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 sound/soc/qcom/lpass-cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index b0f3e02cb043..5a47f661e0c6 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -1166,9 +1166,13 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		}
 
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-rxtx-cdc-dma-lpm");
+		if (!res)
+			return -EINVAL;
 		drvdata->rxtx_cdc_dma_lpm_buf = res->start;
 
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-va-cdc-dma-lpm");
+		if (!res)
+			return -EINVAL;
 		drvdata->va_cdc_dma_lpm_buf = res->start;
 	}
 
-- 
2.30.2



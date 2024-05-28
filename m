Return-Path: <linux-kernel+bounces-191791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F195B8D1423
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDE1B21FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5E661FD7;
	Tue, 28 May 2024 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="QiyfBI0K"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B92E3E4;
	Tue, 28 May 2024 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876093; cv=none; b=GmFD1fiE/VE7HAe+uB+XAuJBBxatqgQUs04Gbybr9tqKzvUSBjFNfqx7VmPZ4HFBEZyYbpSD2iJj2SfKcS+SImIgbjsz/yHu5GCvof/2xjxhKQBpDxh1YN9QiAN3rJBAfJbfKYc4IeE8wjvfpSTKpJ9m7UksPsbIz8+gP9ifwxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876093; c=relaxed/simple;
	bh=FWwiQJnEWQ1zWGZjioH6FsikxBabtLZV59Yeprqhk24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNujgr/by+y9pp2aQVTfp+54nz4wXsqEiylIXh9ulHYzxz3+rxn3OhNZVb8pAUCGRSjCd10Lm4ZXcTBDAJGVSsMA3tAGFpznETjybLLBrm96Qgr2dd+aSO+pTN4ZXMbakdq0BAo4smRmV+QFHZJ575rPZpT0o+7nTesZ/CU/T9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=QiyfBI0K; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1716876090;
	bh=hWVGDop4CMdttzkZ9iY+AX7rqs58LS042GQleDHAADA=; l=1525;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QiyfBI0KtJHR8P31sXeJ+2VT6fVgzjyNB44JC+9qSWqu1OcMWQUaq9P2+zNPDKPrD
	 acMpLu8j/laCPED1ps/xYJLjV8X0symfd1peIQYogEQDaRwlyAae3HlbOz1KM+RpTm
	 2ygWCAPloAyshjUok9emIhxijgxS0SPQbkXGrCDQayb63iGVaFL6XV5RhWJyD1tc3a
	 XKb3KaXMdAI/QDWy3xYa5ls1APoWc6ti6KNuw0dDAd7Za0T16b6424fO726MXR445t
	 XoRpujyJEcHUA4NzMuqtkSo4gsDUYNPHsmn0qJMeOJoFf+ELVzx9vWNTRzcHBcpNde
	 nVzJLnzCyZ16w==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213192:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 28 May 2024 14:01:21 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 14:01:21 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 14:01:21 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <cy_huang@richtek.com>
Subject: [RESEND 3/4] regulator: rtq2208: Add fixed LDO VOUT property and check that matches the constraints
Date: Tue, 28 May 2024 14:01:15 +0800
Message-ID: <39357ff9e6e5f3dec5a6f7f833a3591c0defc63a.1716870419.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1716870419.git.alina_yu@richtek.com>
References: <cover.1716870419.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A fixed LDO VOUT property has been added to specify the fixed_uV of the regulator_desc.
Additionally, a check has been included in this version
to ensure that the fixed_uV matches the constraints.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
 drivers/regulator/rtq2208-regulator.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index f6afa4e..a5c126af 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -350,6 +350,7 @@ static int rtq2208_of_get_ldo_dvs_ability(struct device *dev)
 	struct of_regulator_match *match;
 	struct regulator_desc *desc;
 	struct regulator_init_data *init_data;
+	u32 fixed_uV;
 	int ret, i;
 
 	if (!dev->of_node)
@@ -374,9 +375,15 @@ static int rtq2208_of_get_ldo_dvs_ability(struct device *dev)
 		if (!init_data || !desc)
 			continue;
 
-		if (init_data->constraints.min_uV == init_data->constraints.max_uV) {
-			desc->fixed_uV = init_data->constraints.min_uV;
+		/* specify working fixed voltage if the propery exists */
+		ret = of_property_read_u32(match->of_node, "richtek,fixed-microvolt", &fixed_uV);
+
+		if (!ret) {
+			if (fixed_uV != init_data->constraints.min_uV ||
+				fixed_uV != init_data->constraints.max_uV)
+				return -EINVAL;
 			desc->n_voltages = 1;
+			desc->fixed_uV = fixed_uV;
 			desc->fixed_uV = init_data->constraints.min_uV;
 			desc->ops = &rtq2208_regulator_ldo_fix_ops;
 		} else {
-- 
2.7.4



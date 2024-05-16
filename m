Return-Path: <linux-kernel+bounces-180827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FF98C73A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734DE1C229AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D88143754;
	Thu, 16 May 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="uuSOEL3v"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C952576F;
	Thu, 16 May 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851262; cv=none; b=baOBZJL5egt+ROAdWJG12YC9V4wPx1rRwkSzswuBuBL8H0RfbVKzUdJoDtC1Xb9JzUs9zoHu0YJhz2Q059W2d/ZZnnbfYdGsbjbnzQ531yiz/ebkbSNVk/m9kRChLbu1J02JTsDEIF5nf9thWFzWNsuCsQMUp+FX7kkzK+SGRAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851262; c=relaxed/simple;
	bh=bIVzihWWVq9niA9Ho7xTtq5LxcYk/bE+AtWltj09Pw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIfT3dgtzvrAj3BnQQkazdgOOI0z9+PJy/7xEcpkMkyjOXfyRwl5C7qqE2KYEk073H48IsUymhgjBUANjPBkP1bqJQPByuOb8zgnnKdxJq8+CLsSbX7lZOZO9fXlx0tRjLLHyc1aV/qkht/85C8ZnoNHz0PqaaT1YBd8+b7eEbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=uuSOEL3v; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1715851252;
	bh=c6c5jWZX4urHdDWMJYnCIZDawbwhb3BsVFUXThE8GBc=; l=1531;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=uuSOEL3vIVRgTWlWBcD9xyrlZLOHwQd552+Afs3uaOUeTEDCr9jKFqbGpNCWgKX0c
	 ajl719K3WaKQ4cbDfrDZUDUOnvmQNQ+tBsqYz0alFPNGVMd3K7lEhTrM+iF7Ak2RcL
	 U8dr0YC3rt4senACmCGY7iSwWsHTNKtf+Jkeh1YGVNPH3JNhOlmVFu67ZCLjkrRocD
	 n9X4mv1IY0EuZei9mJH8bKhVf6xIFB3vfTHH6QgWKqPavTsyq8HY8tqqb7KmyNm9pG
	 OWXXkIicX+kJFMA01S09VhRZDuzk6XxiXFgiGaB7XlJvgHEz+P0I5pNEUGle9tnl8k
	 Lgo5J7to28a1A==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213212:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 16 May 2024 17:20:39 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 May
 2024 17:20:38 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 May 2024 17:20:38 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH 1/2] regulator: rtq2208: Add fixed LDO VOUT property and check that matches the constraints
Date: Thu, 16 May 2024 17:20:33 +0800
Message-ID: <7c28d2e61d2fc13066ba4814d1ecfab8f344aaad.1715846612.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1715846612.git.alina_yu@richtek.com>
References: <cover.1715846612.git.alina_yu@richtek.com>
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
index 39147d6..c2c1689 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -377,6 +377,7 @@ static int rtq2208_of_get_ldo_dvs_ability(struct device *dev)
 	struct of_regulator_match *match;
 	struct regulator_desc *desc;
 	struct regulator_init_data *init_data;
+	u32 fixed_uV;
 	int ret, i;
 
 	if (!dev->of_node)
@@ -401,9 +402,15 @@ static int rtq2208_of_get_ldo_dvs_ability(struct device *dev)
 		if (!init_data || !desc)
 			continue;
 
-		if (init_data->constraints.min_uV == init_data->constraints.max_uV) {
+		/* specify working fixed voltage if the propery exists */
+		ret = of_property_read_u32(match->of_node, "richtek,fixed-microvolt", &fixed_uV);
+
+		if (!ret) {
+			if (fixed_uV != init_data->constraints.min_uV ||
+				fixed_uV != init_data->constraints.max_uV)
+				return -EINVAL;
 			desc->n_voltages = 1;
-			desc->fixed_uV = init_data->constraints.min_uV;
+			desc->fixed_uV = fixed_uV;
 			desc->ops = &rtq2208_regulator_ldo_fix_ops;
 		} else {
 			desc->n_voltages = ARRAY_SIZE(rtq2208_ldo_volt_table);
-- 
2.7.4



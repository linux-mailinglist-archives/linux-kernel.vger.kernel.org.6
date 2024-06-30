Return-Path: <linux-kernel+bounces-235151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2081D91D0CB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A80B2115B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB912D75C;
	Sun, 30 Jun 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="M05Yp/Vh"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2072.outbound.protection.outlook.com [40.95.54.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A592772A;
	Sun, 30 Jun 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.54.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719739060; cv=fail; b=W/zXNaQXGDWjmbhWgKHFU4IRkQwuabjTqT+Z9Mo/KUDWdIH10IK+N5CjRuohMziNvwBOgKrl5ZwpTiSeK0ia5OQWUD+Bh17KjaRObt9f4ui0fV5Z+COf4Qfmka6Zls1vxA2KXFZTF2wfmED1UNcysBnVMaljpTJmHNEsR/euXQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719739060; c=relaxed/simple;
	bh=GnyfSv7QkhA7zPkRFFrDoA5veH+tHW0eFScv/1PKOkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QEP73zPqLT5LVHpuJGbcUltq1i+6+nuVr3BHfdZMbS2BDHH3iWfel6j87l2ba3+fQDoFR4oueD9uAyR5i2mIlElHj0xnZCHQLNlrv3z7d2yCmolZrzFWf7uE0HzSL0C1p/sRJfOE8SAw54VJ2i6ZOCJepj27sy3ZUVPkHa0N4jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=unknown smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=M05Yp/Vh; arc=fail smtp.client-ip=40.95.54.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mApApJUHv925GvHu9o5DOSruOGH4hDrH6M5alAV10Io61/7JieNiI/Y10AsIxMoqkmuwXjSGhlvcD3p/Ww6YLugBG1oB81aGbC+zDDCSUaxGtnqqKW9sZsH5k0qCpoGGSM5CR7Sb8pmU2r8jqkcV+klcpsmVEf9BaX8k4ijHeG1wQKNPt49gDF/vsWLsreNd003JcOfofh7M4AsJIPYsLxxGRsbMsSSknxgL+x0LuS4wYZlxJWCiFdl1wOrMoicxUHXhU3O3GwuCK2mLDdoD1yQ2wARxY3itA2NagQGkvrsYvIlOBgYaZia71lORzaUfZW+ZhsoekqtD2FC9x7wzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCm8erJtZ8rIaLo0k+IVn4iwFBzpQAbEX9Y7vJpHDns=;
 b=OEGi3qw+pPBOHyhnXnlEC4lvOKc72tbTGi0N41dsgfFii2hfsNEAzbmTOwIT4DE66twSCKWrdu+v6RujdQvlzvY86ks15tqDF5lb8NYsRf/NtQsskkaHPzS4U22rhgaNWWMVWsU02FTMiSOibVL1VLogydqALeIpBwlrEPqk2CrlN5hMXAbkcO33TulF2eq0uk6Wv/DMo/PX5BMvB1sGMv9OFY/ioWI5FC9F/L+1uvdskQ2W6ASb4hSlBeqgBOAVMk/7S0xmIiVwYWq/D+b5BwBb/4nOAhJ3ke2Ku19H4tM1uSukXFzvzAXLU3SXnefO7azGf5Inna9YY0Pqzm8Vew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 175.98.123.7) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCm8erJtZ8rIaLo0k+IVn4iwFBzpQAbEX9Y7vJpHDns=;
 b=M05Yp/VhtrXCWCW3AWkH8REUtGGPbPAkVUk//ZVe0msecY8FZLNS3WXOnPjyiYRrERnmB61D62jI5tEtmIkhJYlTcGtBsB7kk3leqNkSsRGYFrbLUuiRblwBNCa099fu0ZvT89Rq9pzkpcEKypmtpZNfhLcm7WLUDwjYD9gE8BM=
Received: from SI2PR02CA0005.apcprd02.prod.outlook.com (2603:1096:4:194::6) by
 SEZPR03MB7631.apcprd03.prod.outlook.com (2603:1096:101:10d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.26; Sun, 30 Jun 2024 09:01:10 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::3e) by SI2PR02CA0005.outlook.office365.com
 (2603:1096:4:194::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 09:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 175.98.123.7) smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not
 signed) header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of taln60.nuvoton.co.il: DNS Timeout)
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 09:01:08 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 17:01:07 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 30 Jun 2024 17:01:07 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 5E0005F5B9;
	Sun, 30 Jun 2024 12:01:06 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 51637DC0913; Sun, 30 Jun 2024 12:01:06 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v2] dt-bindings: pinctrl: npcm8xx: add missing pin group and mux function
Date: Sun, 30 Jun 2024 12:01:04 +0300
Message-ID: <20240630090104.565779-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|SEZPR03MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: cac945f9-1151-407b-ff05-08dc98e32ea0
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|7093399012|376014|7416014|48200799018|82310400026|61400799027|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y/rNCl6B4Iqot5drCgUDScFUmNao9HYR9PEUQOdbfzXu3IQ6DIwZi+UXtChq?=
 =?us-ascii?Q?oFeXOh3CzK+G8rtSu90Qxc8ByvlBEwLuWlN5lGKM97E/u5EzR8laMpqQi8EA?=
 =?us-ascii?Q?WhdEpAa8rlg+4R8+R47terb4LG6p4icvFIN6v45G/Pk9Kwo0IY+sqBPpnwdx?=
 =?us-ascii?Q?JTyUVc5apyj2kaAPlw18otRyjDyJipsKsWGkRPG9bHIq8CH5+vbTWqoHOUc/?=
 =?us-ascii?Q?zUuujPoo9SbXhI23nbqQt44uGBFnakmSnfz1gMCnL4i2tQ9zb3S2kDZJ8Rkk?=
 =?us-ascii?Q?1abRb6Y4RbyUJmtaDw0qvUlitkhsAAf00qmVri3udwkEKrsOp8vFxGecEXxu?=
 =?us-ascii?Q?yK9kIDNbkHyX8ZRbFGZc6uYVNKoV1bCd3h63OrZvkX5AHYE/WsHfPswVCjRN?=
 =?us-ascii?Q?NqSBLTUjoO17c5DWKItDyp7q/+zHHXHVx1vn15YMov2GdP0dW5sUomr0vatf?=
 =?us-ascii?Q?tCLYVCAJriDa5IatOqg2L+EmpF4hGJY/r/Z91m8X0o8tgbflgfK51/xBX4Nm?=
 =?us-ascii?Q?8Wff4iVXLdkIU1MMSkeA1qKjmOkye0lDIowc4WtOCeHDMvkxzFEzka0Po6Ru?=
 =?us-ascii?Q?i+7IeIW8rdJJYj11EAq5MPBsY9LeeMHt+X1bwtANAOXgShknXBebEt04izhS?=
 =?us-ascii?Q?7mdMnOOAOAadAX/TgHdfUWn7TETHNE6xeUe58JJ1w8qXI6yazt5D9bGBT/4P?=
 =?us-ascii?Q?NcxmZwSy0pyPT7g5Ds/ZlqixfOwo8WaUEgt1LdXEv+cfM47RBenxa/6Y9p2W?=
 =?us-ascii?Q?KQLYlpy5kAqoACJ3tEXcYi5k1w+2WWxH96tipAqB3R34gLo8Qwmwcn+fCg0Q?=
 =?us-ascii?Q?oy68KMou6JRgB8p+yHILltV/egqZqiQS4DlDXvfVC2OYahpayACsWnnJvURG?=
 =?us-ascii?Q?A4LgfT8uIFW61lPgJF00IEsfDjuTOG3RjCf6sLMfisV3ALZlEf7w+nONmfyW?=
 =?us-ascii?Q?8hXAQRtWtP+DCurl6s7+RKZdA48SKnjfcqtwccl6HurnY70CmZdLm7i+2JjD?=
 =?us-ascii?Q?pczdwnRDHuzboR0obiMqdBq3DQS4APJSuMFUqZSmGMqt2A8MoYMxok9+ITEp?=
 =?us-ascii?Q?1KIh7yRww8v/hVI6Zb1eqkU8jyt9ga+HM3UpdXVHrAVqmXoiILg6qYSo6FcD?=
 =?us-ascii?Q?nwFEVLtjl/QEnXjwZL6m83JH/sq9ZFa2Mzju0pH4grXHUAAT8jC1nbYtLmg+?=
 =?us-ascii?Q?T7g4yLfwgcl3IHhnM9vsLb4c0QtfnOLc5o+Mjys7Y4dbCmcCkabNGbKRSTjH?=
 =?us-ascii?Q?d7bHsBkPVp/mkCiGirC0kNFqGuuIDmnvYxjtkOgs86Z9J4mAdYa8JkKcN9WQ?=
 =?us-ascii?Q?FGMxe4zoqsC4ho41dFx+ktNn5dvdPhpofk/fKGzhTiMqcIaXMVCwk4LfE/qD?=
 =?us-ascii?Q?RtICv2hUoQN15+bBWuas3XiXWJ2JSiD/ZBNrGaUzsViJaoi8Zy/tM4PmUR82?=
 =?us-ascii?Q?B3J4YNJd/NxF4Fi+HD1yakZjIgdlFH7X6PfKSGvF4EX/WQZaI9fM0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(35950700016)(7093399012)(376014)(7416014)(48200799018)(82310400026)(61400799027)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 09:01:08.6131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac945f9-1151-407b-ff05-08dc98e32ea0
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7631

Add the following missing pin group and mux function:
smb6b, smb6c, smb6d, smb7b, smb7c, smb7d, bu4, bu4b, bu5, bu5b, bu6,
gpo187.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
V1 -> V2: clean tabs.

 .../pinctrl/nuvoton,npcm845-pinctrl.yaml      | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
index b55d9c316659..814b9598edd1 100644
--- a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml
@@ -85,11 +85,12 @@ patternProperties:
                   smb2c, smb2b, smb1c, smb1b, smb8, smb9, smb10, smb11, sd1,
                   sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8, pwm9, pwm10, pwm11,
                   mmc8, mmc, mmcwp, mmccd, mmcrst, clkout, serirq, lpcclk,
-                  scipme, smi, smb6, smb7, spi1, faninx, r1, spi3, spi3cs1,
-                  spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b, smb0c, smb0den,
-                  smb0d, ddc, rg2mdio, wdog1, wdog2, smb12, smb13, spix,
-                  spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3, hgpio4,
-                  hgpio5, hgpio6, hgpio7 ]
+                  scipme, smi, smb6, smb6b, smb6c, smb6d, smb7, smb7b, smb7c,
+                  smb7d, spi1, faninx, r1, spi3, spi3cs1, spi3quad, spi3cs2,
+                  spi3cs3, nprd_smi, smb0b, smb0c, smb0den, smb0d, ddc, rg2mdio,
+                  wdog1, wdog2, smb12, smb13, spix, spixcs1, clkreq, hgpio0,
+                  hgpio1, hgpio2, hgpio3, hgpio4, hgpio5, hgpio6, hgpio7, bu4,
+                  bu4b, bu5, bu5b, bu6, gpo187 ]
 
       function:
         description:
@@ -109,11 +110,12 @@ patternProperties:
                 smb2c, smb2b, smb1c, smb1b, smb8, smb9, smb10, smb11, sd1,
                 sd1pwr, pwm4, pwm5, pwm6, pwm7, pwm8, pwm9, pwm10, pwm11,
                 mmc8, mmc, mmcwp, mmccd, mmcrst, clkout, serirq, lpcclk,
-                scipme, smi, smb6, smb7, spi1, faninx, r1, spi3, spi3cs1,
-                spi3quad, spi3cs2, spi3cs3, nprd_smi, smb0b, smb0c, smb0den,
-                smb0d, ddc, rg2mdio, wdog1, wdog2, smb12, smb13, spix,
-                spixcs1, clkreq, hgpio0, hgpio1, hgpio2, hgpio3, hgpio4,
-                hgpio5, hgpio6, hgpio7 ]
+                scipme, smi, smb6, smb6b, smb6c, smb6d, smb7, smb7b, smb7c,
+                smb7d, spi1, faninx, r1, spi3, spi3cs1, spi3quad, spi3cs2,
+                spi3cs3, nprd_smi, smb0b, smb0c, smb0den, smb0d, ddc, rg2mdio,
+                wdog1, wdog2, smb12, smb13, spix, spixcs1, clkreq, hgpio0,
+                hgpio1, hgpio2, hgpio3, hgpio4, hgpio5, hgpio6, hgpio7, bu4,
+                bu4b, bu5, bu5b, bu6, gpo187 ]
 
     dependencies:
       groups: [ function ]
-- 
2.34.1



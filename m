Return-Path: <linux-kernel+bounces-271135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605929449FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8564F1C24185
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E7170A29;
	Thu,  1 Aug 2024 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UKjBHt7T"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602F16DC03
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510154; cv=fail; b=eTQrpUbfvOVCQQy19yDRQUF/XiOYtiXkxY+Ll31/UW9B3AV48ntgrZfrQDVWn/DfQccdNHV+K6rN1NVmD/2Z9pKG3C0SFFEElUBZYQVPe8QrKDjK52AGhdoRZAC1mENtoqTCr2Q4hssBPOpg/oBEQ8adu/ww6kUDZA7KYOtLmoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510154; c=relaxed/simple;
	bh=gtwkvZCJlUMnrN/MRWFX+LYDhb5PMy1XLsMcw9wqb5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FN1wKo30mIxSX5H7hBuXDG2WTb5veIfpmBHJCxTE0KBMFMwfso4LZm/MGwkl0ILtZHcV3DeRb59A3S5gS7wIW7nmTTkOB8Fl/El1smmb0tAcdztJoanTQDlMvp1WO65N6SiezN0cXriByjcZs5UBX0DnJHnqXOgyCqyLYpz5Y9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UKjBHt7T; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXUD5WM8dlOk94+la5eGy+ZkovIRH+oGKjnCQfLStQy/VqMN9jQjoSdKhSRKeIXC3lzsAtBholQjPtgo0bJJX6JF5bbTahMqE1O407enDQX30fG7VFVwoBGMkAZmjUn/r0HV6ocE1vgzXcxTWI5iO6K95P/zChYMcZ/ZrHeZjwcB/RB8JgtjvZ7C7fTcS2JAuOBdMUJGg3Q6+QbUCe/mnHD20iDdNMwuGAntOqSA2DKTWm2Mlcxl92+KVsTbeqW1XBO8mlmT6ltYAivFjbPnoK09dpOXaNoCOMxSG2w1MMhVIGHvP3ZF66XOq+SnipT1qhJ3q+N63+NGJBGZEK46xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTiYlLydw/ccrtKhQ6AfuedkSpQ2Uwf4ZVNCmhMDrB0=;
 b=iAj0xC+uNL6O+FLq7z4qMmg8OyUM/uE5W0EtWxkvV+CUKlIRF0Pq/UHuaHvqAD9+Rlicg8sijagblohrW2xFJxB7cbph6vam/pU9CKKnW/jIoVzIiWZXPUcHYgYIE+eLinBU9/a30n1Y0+qlxEcRPu4hVed+wX1Ydyqrjba9wkivo0uVeqy83krzf7TMfwFCMp2e5HT6pWJoY8m7nCfKXELoO46TOIZzNG2oIaRhaTcvT4oFDYQC98XPUx5xj0448VOZj+aPopC6xTfpiTRpGbZqjMdzWNmqxzjM46Vd/j22n23b94ItRMlAk6CrWP5EK2EB4En1JLfl/Hp3RR/hMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTiYlLydw/ccrtKhQ6AfuedkSpQ2Uwf4ZVNCmhMDrB0=;
 b=UKjBHt7T1V+mZSjDmPAvXo5KTCOVZtdkNdnjNM/gfMitsOU5e8L2oXjRmoVFcmsUmTYEYvfCooPJZbZ1qlVdgDrjzEiNU5oay2Jnylyaar3KLhokM4yB2aGTT3pimdZI9xTCmlsdjOXZpFRYSQAIzusSiaBmADLYV+cSGrHmyUjiWfWfDh5hoIDMyt9OZDu+9lq9wsbiRUEQHwVK5STqextti1OxFh8wL+r0IYzfJ8YNxaQYFXjrO8/5sNdUPNUniwxyKu2Ww30CSM2fyjRePlZz+dx9H6iIB70AWGIJyouc6F36zIsOh3wsBNDS68sQGBopPCMJSOkuZHGw4+tUTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by PA1PR04MB10171.eurprd04.prod.outlook.com (2603:10a6:102:460::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 11:01:15 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%3]) with mapi id 15.20.7784.016; Thu, 1 Aug 2024
 11:01:15 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	alexander.stein@ew.tq-group.com
Cc: jun.li@nxp.com,
	xu.yang_2@nxp.com,
	linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] phy: fsl-imx8mq-usb: fix tuning parameter name
Date: Thu,  1 Aug 2024 19:01:36 +0800
Message-Id: <20240801110136.1031689-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|PA1PR04MB10171:EE_
X-MS-Office365-Filtering-Correlation-Id: c59548e4-a790-4256-5beb-08dcb2194359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q38I0pdgOwJzzX4350SU3dnxcEOsWaW683nDcu1dSzWIutOaUHZuQVgDNJkp?=
 =?us-ascii?Q?aPjF0K2uI54PPY6/ZePc8zPwK6kmPE2p6oYlu30oP2V4mULzFpNkcUQOAKye?=
 =?us-ascii?Q?t4KkwtC4urW1Fgr2R0KIKTbIhBPyTCZYPxiW8gm6GYlKX8VTnjlu37tpyy5d?=
 =?us-ascii?Q?GZVqWP2l+lf95oUwcp6cIatHkmesNMhkBfd6Rsn/Gj/7OnpPd9FTjUAjQRWC?=
 =?us-ascii?Q?kRtLtbhX4MYaiLFYlnIThsHwUMQizAXF3FU2zInS9wMXgmXlTzIDv/hUFIXK?=
 =?us-ascii?Q?iW4Pl6S+ojMlZdvBZqSknNHbTopLSU5XwsdKlRzCpLwfjzu6DkX6FHD4HI4f?=
 =?us-ascii?Q?/WxamxaYrNP/PW7rEMMpZz+7HiBCgV6Jqw5RnxJCSEJ/wOx2DE/TmapsYAo7?=
 =?us-ascii?Q?nJqjPOjBePvV34rjt+65zH0zyXbN48c99HFOckSSZ+tC+2YNY3HhWA/zRdVV?=
 =?us-ascii?Q?LpKQBkkUdhBOf6ipzEg2GkO7i2qC+WAmMdENO78xFEx32GckVabwwrByWiG6?=
 =?us-ascii?Q?G3nhbiFZugCXA044TMmu0J2kjWvDtE2djhSscBcu9CRIB8fF/JUvFu95pH3k?=
 =?us-ascii?Q?OQti2Y02OmprmRWodueDnYAfv8H1cshyL1Mxrl32vQvRk2CnI07ttHrvadmz?=
 =?us-ascii?Q?55UkxwpTarjulfZOjFxPlrOeKIq9opbTms6lZO6UlFZTYxmCqVPpaJlqWgs3?=
 =?us-ascii?Q?MH5Ov8oOgtSMoyruf9DRzhN3OFvFCym1AaED8MMMk9WWOFvfPU3Rcy3f5QT7?=
 =?us-ascii?Q?LNswvgeQrKpuLH1MqfphGqtOKFEtbQD3Ks8on8+pcYfKAG2+3FMushWLRJrM?=
 =?us-ascii?Q?z4dM1Ek/sqYbtlRXhwrB62WQae+A5s6YaANsYhEbEOdqDFKa8DoRPovTNZ9M?=
 =?us-ascii?Q?b/+7llVBQFFjHCcZQVQNCEoiM8j7d9w3u2rdfoJQ+KPKu0Dn6+TnxCtx1Gjv?=
 =?us-ascii?Q?epZ9qCg1KoUHs24JpJW0vDaFNos+WVfOJNgRQtS4rSoN/3eWsCYQImnfaJfE?=
 =?us-ascii?Q?uJqewvW3A1VmHXq7HSCPXzgpGmthvdmY1r0euYl6RsEoLj35YN0KcCJvsM0X?=
 =?us-ascii?Q?GXYgsSm6chJmBvvsTRt63wVqg5uQmECHyWbtAOu9f7s4orA9kRCFs7cgVgss?=
 =?us-ascii?Q?q37q1COW+6cDDW8fMI0Oh38V+U+4LS5aGi+V0jzPCgZRPksjFiUgEo5hnr4Y?=
 =?us-ascii?Q?skg3TaNTJJm7dVtgtcXw/5cS5BClU+fXFJ+tiLzOGjp9PR8OwLFeUi5Gie2w?=
 =?us-ascii?Q?zp5RH07XJHyK52doXDRww1ASwyukDiz63XexizqqSw9qRlegdD3bTHEz2CVP?=
 =?us-ascii?Q?aXr7ODLhaKjDF+GqwN7fsoQIXoLK8lmK9fLkh5LALTk0LZ7+R4Do8CKCTa+s?=
 =?us-ascii?Q?sxjx1n6yp4ITGhGPk94EhG9Y8rJ2q9gei551gF616L6JwaJ2QQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/0ikFndlUY/uIAUmBRhg2pkvzkybXR/WWJtbRY6p77b1q+uiwaELEWBAcfa?=
 =?us-ascii?Q?CKK60JBJoR49wSZrcIAQWCNiQTpoSZf+uwdRtZrjBqi+i4NbU0SsFd5WYnEs?=
 =?us-ascii?Q?o4XiVV81CrBKBzONyghfnvaSzh30ze+ZFPfl1zv5FwZKI9XBax3NKOVX+JFP?=
 =?us-ascii?Q?DqHTZ7cAX8bqVMrZTvKsi7cUTd6nr2IhMNQNm96R9uk70tCP12Bqdd3+llob?=
 =?us-ascii?Q?LMRxhQZreFUBVvLMTje9hxAps7Z/izDUDDsM5kmEK8g3a0KjX72hUiSJnfw2?=
 =?us-ascii?Q?bJ+7DnXERP6gU9qX9nQVNWhrAPlwu6OW1QTFAY3xxeG5ryFw0YF8qo9xIeYv?=
 =?us-ascii?Q?cT1jQXaKWr2wOn+Ws+8tj+QrGBpk5TnYyuhMdDO/q8QEX/8WdQ8H/whzviy2?=
 =?us-ascii?Q?4p9V/65nHC9Td209dgb+7qOFrqpbZmlp5JBk2NLN6e9PL/S2HPwKxw7clUYb?=
 =?us-ascii?Q?5EWut/+dQPkoiso+53jWJKz6wC5tz8IAEWnrnSxKTkYNVXlreMACxinvZFy2?=
 =?us-ascii?Q?Y21G1njxTqO7bBYabo0gZ8L4HpoODASl3ajaG13diIkwoUup2k4siE8mzw6J?=
 =?us-ascii?Q?PLoBmVC4FVi/K8NdX4ACOPrc0Uf1ZVXdt/QvWQI/vDIgwt9YohI2hePlX6fs?=
 =?us-ascii?Q?VSTNwstLPFuL4a8RBjC/fMiWG2ZlU2cXERlRY4Pvj7grh5jJku/ZTUZ5Inc5?=
 =?us-ascii?Q?optTcJYwDpQZGU9Oz2nQXl1R8TVAtmCSvuKyur4j20NSj8XgmzSth2M66FpU?=
 =?us-ascii?Q?I7meTVuIHONlXkVhhjohL1Y3/5WgmNSEM29G/bAjIcee0wrust5WPEcQMdPp?=
 =?us-ascii?Q?zgTqZGsk5BrvP5f4d6ynyukb0ekRIAh2q3x+Cgy04yUub1rr5bzcosMpoZWA?=
 =?us-ascii?Q?gNw1scWc9NTKFnFRgf9jVNT9ge/lcp1jFVxS1VHXVKNq97cOjQq8h8wAR9z5?=
 =?us-ascii?Q?1bLRZaBHf1CLiR1mI6zrKe6wnSkzDkJgarFS2MGhTXumSm0/hWnOO1TW4Zfg?=
 =?us-ascii?Q?feUD6jGbP3l+ftYRlV19vbm8seTCy7GkxpyemEIDE8/futnW0puaycc2EgPo?=
 =?us-ascii?Q?HTSrPLwqHYEVvGXvkojW1asnoSskh8wrX7/vP1w7N6VH7UStEL4MPYikEwN0?=
 =?us-ascii?Q?JsnA+byvtKmc6Yv8hpHdyj9P3EOKL3H1UQyxWArhPhRrk4fcoWI7sN1zI9w3?=
 =?us-ascii?Q?EtOSSHAhgNDC+Dg7a8EiuBkhIAX7+WbIm3QJrxyD01KY85X6OnEvsGj7YToR?=
 =?us-ascii?Q?NqUYovhnhDmehPiFhOV34+5p5XojahTcfDGeRpRDs/bwQMMpCkGHMkSuqiA9?=
 =?us-ascii?Q?AQ8uPBkamVdMkuoYjQRcuFGIT3i+IGzaNbCf052/J8F45tejOzb4+MjH8LT1?=
 =?us-ascii?Q?BTxNSXiDFYojgii6OBkGGQFx2DG5VogkZ2bwnUxMFzXCkM140KJ3+FYo7eL2?=
 =?us-ascii?Q?/PUgstrhV1/AIszuQ6Ef0xjfXPP5qqX7qv0snP55kshGGpUjQgDFIzWO0v1j?=
 =?us-ascii?Q?pkbOFPqkvqeol7tiINkf006My+0OudB5U8+MkkYuNbAbBWBnsu5/TTxGAAxI?=
 =?us-ascii?Q?l6Zz+JHH5CbBb309FkAik2bUzcyiNIsszBJ7Rewj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59548e4-a790-4256-5beb-08dcb2194359
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 11:01:15.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Yv1Xz81JVyIMr8caDhJ8wluf/e14j13Oe4NnjX5V34KfrLqy49wLpSQDHpS/tcboA+HGwFmzh2wC0SyVvYTDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10171

According to fsl,imx8mq-usb-phy.yaml, this tuning parameter should be
fsl,phy-pcs-tx-deemph-3p5db-attenuation-db.

Fixes: c971874a89e1 ("phy: fsl-imx8mq-usb: fix tuning parameter name")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - add fixes
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index 0b9a59d5b8f0..adc6394626ce 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -176,7 +176,7 @@ static void imx8m_get_phy_tuning_data(struct imx8mq_usb_phy *imx_phy)
 		imx_phy->comp_dis_tune =
 			phy_comp_dis_tune_from_property(imx_phy->comp_dis_tune);
 
-	if (device_property_read_u32(dev, "fsl,pcs-tx-deemph-3p5db-attenuation-db",
+	if (device_property_read_u32(dev, "fsl,phy-pcs-tx-deemph-3p5db-attenuation-db",
 				     &imx_phy->pcs_tx_deemph_3p5db))
 		imx_phy->pcs_tx_deemph_3p5db = PHY_TUNE_DEFAULT;
 	else
-- 
2.34.1



Return-Path: <linux-kernel+bounces-369263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390459A1B00
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D26C1C20CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D4198852;
	Thu, 17 Oct 2024 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="An7+lrNN"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C6199225;
	Thu, 17 Oct 2024 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147875; cv=fail; b=DWj24aOkZ7Hs0Ccf5FbzYhzhf9+BeADIOWWeEyJFkMs4Ca0H311HWbU4McBy6tZXhZ1gxPOFF5MLzuS5UyJGmkUgED6fO9/MFfslsuzWIj/snkOP20f2pKJ9KqvMZRPLwPtPcj8Kf4JLXemkk2fqbZ9zc11T5sJTuGsxhX+TyTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147875; c=relaxed/simple;
	bh=wTkA3ngYBhMsulTRh/8lBQFKmSkAkOePEg2Kmiq1HAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3rllUon66TejOFfTi+UNwaHVK11dDlFP3/4l0ueXQqYp3/I+DPUMoHlNY8E9E71/nLYt/03cUG82ajHGgHldxC0xipCIJ8DU18mPA/J3S63UQjDHI+X99W0+5Tq5sjOxlXp7Wwbddmonj6sMMf3ywjfPyghJKrCH8fE5uaI/CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=An7+lrNN; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hw5h0dPTP5AlehC5wZRsJoQPZ5DERSr/OMRcKuKWVWlyF7btCBQ8bvKbTnU5Pn3QN38UHoRL4e6W9jdFXgGn6owcVuohj9hsh4TM1GTGQb6LOhb/K0FodnJMl7tKnvrz6imjoQ7wjlChnuzBMxz+61ZzHB2FN4UiV44uD31F0erqFZVFcz+NquUh54E/2FPLF0Z9joT916LEaJ+dSn6JojsLMdA8O2P9SQ5GndKN55yFPBAtpjs5UWjTNw06RsUeSaEaqxVrqbm2Fhvwgd3VCqvCAvSyofyim316jOQhqd880/pHHCV/JkwFZoXPcsyQbhUtyCHRW55jKiJzBd5A+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MJPG4jjD/tGPJ2fbTa4lfbpamOfTzslr5V3dRrJePs=;
 b=Mop5jJEHY55siFkU6E10SVBGTUcOr81KF76ba1fXcs+Y5Bg1MJZL13A12H52lWOToPQub7QvltP4o3HCg2nlYZ07TVUcsszmvuxoVueU3cX5a/WoHKwPUR4gHHJA/QqaWcKLpGujiqHdaC/KDtVwnanIPrpUk+1JrLCL0qMUX/zEvKJTb2QDoDxBfzqC5XeSUygveBl6gINCtfwFraA9VxsHy9g85FO2sXb5yARxvET+zS4dV7WVHW3HIBkQTDhMm/Q+RCTQdTRoSZD4fKFIflowVML3rV3qLtloTY2G17oFeRJWf7VLP+TfCD6WLeRjSvtjAFMPHvbRmYPUJRYkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MJPG4jjD/tGPJ2fbTa4lfbpamOfTzslr5V3dRrJePs=;
 b=An7+lrNNKy4hNtX/8Ee2v38x8csDk2dxpmVFTXjg9JvpJ7kdSayGl80aBcwUBLfZnr09pL8OXuoJZ9QaJyeNsI3XMEP8o45rFqcmAgyAiG/boz95zhEFe7wPtaL/hSMhb9vptGwd5gM6YxvEoFmfJ6LzLFaifVUs+K1sC4GCZyWph9XrZHCqnK4IcwjPYdYy7fl8ZiwK2WZNNPEF6KR6nJhRT9vpulEwI4GNn+0MoCsmBfjYBGxv4PK6muofNN1VgY+cbMb/yg3IwqIwFBjEia/PKg2ChkUHpuBz5b/EbZQmA2JhJeC/gjYjGJ+edrYckiHuzufVdyDJbr72NHlAGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by VI2PR04MB10148.eurprd04.prod.outlook.com (2603:10a6:800:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 06:51:07 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 06:51:07 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] clk: imx93: Move IMX93_CLK_END macro to clk driver
Date: Thu, 17 Oct 2024 15:51:34 -0700
Message-Id: <20241017225137.1158924-2-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017225137.1158924-1-pengfei.li_1@nxp.com>
References: <20241017225137.1158924-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|VI2PR04MB10148:EE_
X-MS-Office365-Filtering-Correlation-Id: 55538ab2-f79b-4d1c-e793-08dcee781387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YE/mWWzYjmzieQmfUaWyVUReoFEXfl5fDj8gaV7XZa4R3pyZmD2Q6IgIlouO?=
 =?us-ascii?Q?ofCiPS3zDMqKh/go+6Zbyt92MV+Sev9BB890MAzlw0gXcjdwGXrDKK+s0Qbu?=
 =?us-ascii?Q?wOrNXidtf9Tc8dV2tE6/sjiflelx1nA5g88x7b79rVkkmrXd2Nlp48SDmt/F?=
 =?us-ascii?Q?/0q7uBjl4AedTrZuGFUj0qspUuAzSshUJd2YwfaKliCSv+lrmm6bYV9Bq8CH?=
 =?us-ascii?Q?gNDw7y+3Q8hlmWg4fyeAVCPmuK2FV3O5dSHgP1fD1oDwbDVN+MNXeH1Uo3lK?=
 =?us-ascii?Q?qDIyvqPL2yrIiYTa8KXEmA6GSAyOsJvaXOnyvdIg4YOOrAhKG/OMIyhH+plr?=
 =?us-ascii?Q?w8NzUNXuU18rDSINoKATfW3swhtwoEZI5LsnzFOxfQ9awL4MgdkI+cirAQWZ?=
 =?us-ascii?Q?NO+aEwJykCAZvn5NiRXUFWvbjar7uRl1XBAl5LTVzEgO55XaBP5C0FGjizgE?=
 =?us-ascii?Q?lB5L1odY7eoQHBeQzkSiGbFiXL0prQr+J4Tt9NI8yMw8xK5aVd1Jum8OYnsr?=
 =?us-ascii?Q?X8HMoSYlbsWwGs0YJH+yx5pwRkBntF0enJVOKyBl3e3Gx/doXGhppYaHIpCY?=
 =?us-ascii?Q?4OY/IP7uB3mdybY6heUbX7mLkB/OJt+wQBVdSyehQJmp+6M5g6b0v11PbghF?=
 =?us-ascii?Q?IQ+jiAZV824ixVDF28BaWc7m6op38Weuz5tUzYIByJsPT38FCRIul06xt5zj?=
 =?us-ascii?Q?lJxE94cRr+t6x6ObwwQUoxpZEbGis/PEyIBY6RU9TQur1GSThY8ahDL6j2JP?=
 =?us-ascii?Q?3NCmuL/5AgOGpulAxDKyOXmgePuA2d39U1xwILodMHUHQEc7QzKr6P2z9nHz?=
 =?us-ascii?Q?hjKO0FTGLuNros+SE46CW7GO570C71cQlvGY6gehmswrHOuQGKD8dLVTf73j?=
 =?us-ascii?Q?C6IFN2RguhPSJZ0EOgsp7xiE6+osiPNU/Aapura+MIzu7OwslX5I47GUv7GQ?=
 =?us-ascii?Q?22lAAeFDaYPnHDof7rE3/xjrZ4NyjvPSCTjWWmjKlBOmIL2KsLtenDBZcKNd?=
 =?us-ascii?Q?51hLgXhPlsgY2eigbNPM/P8nY6iDTxRhnvFDa7vMCBGoRCciu4xxRRyAjTzA?=
 =?us-ascii?Q?3HfGt5bqvjRsJU8GkkrL0HyQ1mG9uhwwEYo1U07dLyGzQkelFFrOaMUl7Op+?=
 =?us-ascii?Q?cBWKGAUGGeF6CA016jw8v3XyEw5r0S/MFHC6zlvWKPXkRuXi7s9jNEx0QRmE?=
 =?us-ascii?Q?n+V5N90CuI5RHXh28PQupOZlMDjbWRuo0+uxoEACN9RO1krNBCMloTo9hsH9?=
 =?us-ascii?Q?kSbZBGr5UXNQfkjZWPpIyM01UE9HS0Iv9Vg0Irb1XnQHzHJOkAq3/aSCJokH?=
 =?us-ascii?Q?PiqYX6rNOnqNDdcWWv7Mz61hu19NpNR5KREY+6MCdW/GISZ3TE9gGK1pewkb?=
 =?us-ascii?Q?OZVEb0ammiI1j3Zjo8c/vM22v9GN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t80GHyx7ESZYpmrPerh4mSVimQwyfU6rKg+i0vUfFqg5FPJpSyZLhGfc7nhe?=
 =?us-ascii?Q?6hGh5XykXi0sUmrGrmpfw/HD0o/rNEIH9mXe5LkQdxeYcrL1yGPLYjBavlYy?=
 =?us-ascii?Q?mSdGD6hW+/RRk8xW2gV+fakRs6IqHbPOxFVzOdgDTMbZtQCHUiyWhGLvuvv5?=
 =?us-ascii?Q?XI4JHLdyvK0AnllxNagc6LR557VUyL4hOd+JM23GxF2v2h53jyZd1WtarwUl?=
 =?us-ascii?Q?k0NfRN3jaVHaZdlJZz0W1AUXTU/V+8AM2zKPnN9b5aQMM5SY5LS6+6Pc+MG9?=
 =?us-ascii?Q?68YQFt6RqUznJ8SlPxyf29KGcPeXVfqTohQBOb2OCN699qUAieIEWA0XACj1?=
 =?us-ascii?Q?Q5JgMbNII5Wu461AYStHbio7Fne8NC6883o1rBV1NHwwc34maXHxlkvrQDYj?=
 =?us-ascii?Q?IDzj/wuHpr6wm+SCUhSOsbYJ++6Ww85kdCCiIx3a4ASLiUVt0NtVL7eo8nmS?=
 =?us-ascii?Q?ZYkqUVj8d6Ud1d2PnnQ4tgBFsVK6ER5M7E0hALupumcvjZzLf5laMUqx3Pfq?=
 =?us-ascii?Q?xY7Hp0oIrSf8kRece+oSB5S1ZnMI7fcyJ+07BvgeJoySvRmlA3fhHFqrXdgs?=
 =?us-ascii?Q?dyU2g23/eAEqolcAhfP9buu/2B0DA5cpevMrj3bGF+Bdb8ufHKMGRN1oWcII?=
 =?us-ascii?Q?d4zWpe2aKpxoUtdBJCtRzgiWTBnhz4M6dAgkpOO2cEZ/YFYaMP7t9HUo5TpT?=
 =?us-ascii?Q?VsBenKyn/eSEuj7xjwLLf2vd5DHHt6DiYHHgNJBQRCT6CWhBB1MaLpkBcNyD?=
 =?us-ascii?Q?hmmcJ9EzqsYjgFKqVHPeGwBMiBqB4Z0KIzJwZFfmGgYeoovENUTAS3wMZTsM?=
 =?us-ascii?Q?PX0WTzp6cmHZdpThss+U7roRNgu2wtevgHWCgETyn7KkbI15Tp18ZqrFsQ0a?=
 =?us-ascii?Q?gBIUA2G2RenvBrFDFeeFr/ERyjK5jeTiaC9L2eQV6YiOqxnmW6IFw14ARpvW?=
 =?us-ascii?Q?OqI3JJvUOBzdUuShmGVWe2c7kEVZuTeNUMZUxY9GqQ0yY8xZvbjMWOixHYJq?=
 =?us-ascii?Q?gBAmr57gGXbf5c3nTyJclpD8pqMVBB0VSuuH2O9nz+KdljJTx4sf7uuAbEEw?=
 =?us-ascii?Q?NjlPL3Pk4X9PymPf/qoCzPy+WwNEUkTT75vgeI/1rOjvPSQs2lmFJy6WOXZF?=
 =?us-ascii?Q?JdNcwcAoTCOWH2Q9lACq9M6c1MVpeXqPvg83qGYzyCkyLgN5RkUcUBYPYtJ3?=
 =?us-ascii?Q?rCkzBmXlgOseeFGDkE/L+vIyjcW840larbX4FKMtzULEQfI7ahcaLyqQGu5m?=
 =?us-ascii?Q?N45FhLizAZqAuJsnqLoAKDQK5YHLYbAuRNxi3Xw9oEft7D5bzPBVPoGPyNVA?=
 =?us-ascii?Q?A1U94BDQpLgJpMnnt9B2w2tPAYgkeFnxTlmoMOd6KPxESnwDoVZS1BcyX1Il?=
 =?us-ascii?Q?L1bQh8QectZ13ZERsYQj+S1cb7SOU8LkZZiN4HcuLBeXWDWeidQ270bTRtix?=
 =?us-ascii?Q?Xvsqut6hni86+XCQrE9VR/L7T0GEsRKq4NsGM5fl20O7IWisrcs+R11ELXck?=
 =?us-ascii?Q?tI6yzfj0O3iUVnVNbYVQsPtWOhyIaAxI2eRx6O5JmJZhVD19SjogwKvJU9+F?=
 =?us-ascii?Q?kJGwUYIKKVmT6sk6HnsJtmlv+Nr8u3F7pAIkvxBm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55538ab2-f79b-4d1c-e793-08dcee781387
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:51:07.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDWAWyYvxb/fuCeT12Rupumxg2lov1V2rWOr5foZkQRsVV6p7HszZ5DO52Kg8+uUhYHWhe30Im5CAEHjWEdLyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10148

IMX93_CLK_END was previously defined in imx93-clock.h to indicate
the number of clocks. However, it is not part of the ABI. For starters
it does no really appear in DTS. But what's more important - new clocks
are described later, which contradicts this define in binding header.
So move this macro to clock driver.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/imx/clk-imx93.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index c6a9bc8ecc1f..c8b65146e76e 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -15,6 +15,8 @@
 
 #include "clk.h"
 
+#define IMX93_CLK_END 202
+
 enum clk_sel {
 	LOW_SPEED_IO_SEL,
 	NON_IO_SEL,
-- 
2.34.1



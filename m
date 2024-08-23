Return-Path: <linux-kernel+bounces-298654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2740895C9E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 285AFB2262C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5216EB4B;
	Fri, 23 Aug 2024 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fAEg2xCK"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070.outbound.protection.outlook.com [40.107.215.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB314D718
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407636; cv=fail; b=bZCdMQnUHtV6G6LEaDdYr5fvz6UxpRWvqaPh4V7w+bYhlFiDD/qT51pc14YEtX6QM6znO9jtFrikIPxbQT9XdlHQN+1gt6CxChoWJ+WMyhotvnyxicAm06W/+1FQ1ImzTwKiUKATnO3/NNsCIFZBFRWBsBteOoAGkxllOg+8geo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407636; c=relaxed/simple;
	bh=ejI8B1Tu52m8uhSqvYDQFQXtjbhlUVqcJQv7eGKizlM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nGQUtmL+5ZysxMkenUXCqC1ByobQnNKbYDJgZW3lLsf5AzFYFKVhESWWlpoemJVqgphybf6mF+Be2Fp+R016oqqM15e0uRi6QPJkRodgOo7LKFBtekqzHC888tOXvsyFwMRE9nkD9SYnxEsAfJTHhv+fypntmVKFM6LSrw/E53s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fAEg2xCK; arc=fail smtp.client-ip=40.107.215.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MN/lXssxAadKFNttY6ar4OVEDLbSGHwhYahKmQR607UTezeEGDpXgXv0eurXg8hhVvoJhWpKVj2SbK4votteqx2VcAyFgpGfZyDDt5JTXODlcpu7etgcNL5YHJKzprSzv4oRqu9g0NnKjylBmvJL7mkZdQusKwMzz+LxqS3Xv9MUYOP0RhBZ+1p/12JoUyoSJiM4BoIDa+/d7fa8NM9EJUO98IsUYESE8+KTHb9+Au+/9uBsHb15YHJrVDhpYnc9X+5F8GOfQ04Z3nyp8P6DPzwjus3NDtTeszcYBSRzQqL8TY2mEF9NfxvOh16jrvvxWvYYpzGYp+gRWMU1oo0qcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EHUn24YG36cLVjG5O/14gIB0agEy14wH49NLOISuHQ=;
 b=GwfTGKbUDZbUVuZCcUY3EmQ9EnckJaOLTTHz7CjBhB2Y2k9nlmIkGEfxkbwQkYv4O5HYA9ktuykFcXyx9AhCbr7oRIxFJZy5k2+9pGjTaHVOh8szttHJTM/zKFfGIhZ5rLRg/4flCgQWx+k3qLiye5wPIw0nHNNIFNeRDVO25aa7vlQZIWucgoogD0xecTEHxsllTZ0JuDZRZnUtG4W1T4N3EoCHX0DOgzKu1wVKFi+uMW7OIis7azRgKbkWlsjGPKi5Q7lLa+4Jg4+V2fc5SeEeiQbxL6olZOxXIET6sSkhke532IkH25/fqExYQXHp1bt0c+/E7us/ZUJ7D3o8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EHUn24YG36cLVjG5O/14gIB0agEy14wH49NLOISuHQ=;
 b=fAEg2xCKybCskWsdnBftw4FzMtDGvlRTxYDfAimssnp3DHKDTYT03yILP2GXvdCtkEws0R0LekO9+7Fb3LrG4nX1Uc0RwObXPaqGlt3Wkhct1tG2Rq4NXKC/OdRtfu+P+s6FFvucZQNL+qq7OBtklnWY6X9FMu0DDHADsAZQJf+4jhpnLT+wHAnlSMtJD9ROl00m4GQcyUqYpON9Dn2QBXdHORyUsZ9KwV6xQDQ+3NNvvbiK9O1eLmbrP7MVlTmoZRaTNATGvc2TP0A3sCLHAL4ZfIknpEjImTDUNqwStxQSUsZTOS09XpRisP+w8Zfo1PaDwbvDgnIPzSKRNMzSYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SEZPR06MB7176.apcprd06.prod.outlook.com (2603:1096:101:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 10:07:11 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 10:07:11 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 1/2] bus: imx-weim: support compile test
Date: Fri, 23 Aug 2024 04:22:10 -0600
Message-Id: <6afc96fc30403966d9be783c659b422186000a86.1724408198.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SEZPR06MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f142688-c93e-420a-3920-08dcc35b5afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ijweLMkDK3qsll3oRPq3C+JlpUY8LHS6jFLmpvRq+kh1aP6Lldng28bSUGZ3?=
 =?us-ascii?Q?pFqdGHE59H57JZ4Nt3x2SrpdBdVZ+cOz+hOFIdxqrNxlefvTyjBYDNjYxBC/?=
 =?us-ascii?Q?rqFn6PScM1BWqMWDBfUEFB4AhOFeyTZe7TuHiSLtfMMAqSigjLI4kOAlT/ID?=
 =?us-ascii?Q?VobIf2YDl+2YglQLtcKJvMUVvYiEaz4W8J5yTwsExTj09RIjh6lILZXm6NL/?=
 =?us-ascii?Q?GJeuwuY0IA/TgeL4WIHciipwLOG3nC6dF/O63U81rwpKY2eAv8nIfKBMM96N?=
 =?us-ascii?Q?wcApJJNE///Vonxn5BSacF2LhIfdf6ub+Tuija0ZFWTxS2RtrRLdBVF2wSu+?=
 =?us-ascii?Q?VwLF6e9c+F1ozHf5tu2ZS6Df5v+yPmP8BgbdPHlAr8kJEKLYN0lKoRYFqkVK?=
 =?us-ascii?Q?+l3j+3v4Xu8OREhtNpE3fW1a7cSh4B6KOck7LfGwKjoAuqQgZ7jyU3b3kCTJ?=
 =?us-ascii?Q?9LYCEji0nCmQpwqAueh6BijnIbCcrdjWDE5cL8R4UHcLzwRZ2awX28z3TYOh?=
 =?us-ascii?Q?MGaCog4oQSw3X5W7tEfz5VNFq9+Yn0u7fM4JbFAJ0IFzfyUfLBNfeQ/eSL6K?=
 =?us-ascii?Q?54U8geD7RCq/ddqsCSCKMClK57BpISw1jZ7FyqL+DXsQv9Nio9a6FJEoho1m?=
 =?us-ascii?Q?QTcrMZQsowZv720cyYW2+oht3o7klahG+TdGRuKkqICo39rwPPTr+nZ7kGzD?=
 =?us-ascii?Q?ctCdU61aLZP1p20gCyoglBcL50MycNUUnwvbnkhnH5YArTGsenbnMdy3Ffuk?=
 =?us-ascii?Q?1JvI4C8ODinlm7imzVLdRRfQedldKcHSBSp9HWFSAhF+HIgE7p0phtRpxWR/?=
 =?us-ascii?Q?NSYT9siJC2Ls9A4CQenbYiQT0e4sCV5669myPLjrl7o5MUtJOBSBvZ2WA9U9?=
 =?us-ascii?Q?6C3aqxN/sw6WbXnTWD/v6ANb29o3YWuxaLwhz8LuNsj2GN1nhzanzAO0KHSi?=
 =?us-ascii?Q?xCGtjWIgZyw8Z8T4sfVvPSsxaUJsXbNchM/88NkSOqbg7tBhaIBsCcIXUQAA?=
 =?us-ascii?Q?pB3fapTEvQNr1Es3JT2DeQ0NAbWkD4URxNo5GfHPtXZPu2k8pAOFZcePRZSp?=
 =?us-ascii?Q?zx6UneYsoteitinYtLnOE2k+7qSwTwj2pgka2Kr1WsTZfAGIKpakdoLMP0H1?=
 =?us-ascii?Q?k82LvPNmA6sLOoaiFg17r+O2VI7ppGSFT0zN+0xn0mqPxIpOaRw+nEEoEzOs?=
 =?us-ascii?Q?wTefSNENhSKhZTFW6wvp+iz0i5MjwFhok6VFvgeIECpareeSHY/q3uP5N81b?=
 =?us-ascii?Q?qqPJ+U/KNZ+QIfjqtIJnqHJa9AVIGDA5r+G3S0V54nyLH2l1HitZ/X4B2wlo?=
 =?us-ascii?Q?N0FFaYP5/1e8+LBKepg9sPQdrZirf9fcqWcHEICaaRyee7xYGBQK3cLqwkv1?=
 =?us-ascii?Q?b1XxYQtPAWVJySS60MexFJXK/znrF3RIiqKltNqwITco5IDJeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9j9xekhoHPeMfQv1BByZbM1tOFrSZThGiDkZ1YvA50SzU4DTsiEK3UiZabh1?=
 =?us-ascii?Q?38gKTAeS7xmsRfywe/h+blmJRBWKyUjc4KCohLR2MiZWibtbyE9oToCr8von?=
 =?us-ascii?Q?IWFSMpCBcXBHSkQtds2ZV/Rq1C5vF+dZ5/ymDmL5XVw4fQLUpjHGxsCOG03E?=
 =?us-ascii?Q?5E8knmke2wkb6LUO5t4zqjADE4ZnF8Vh5puseVMpcC7WtaJLOitbYUwn/GB4?=
 =?us-ascii?Q?2yMogpBkZrqbxC0rc0LfxbjXf8MTXC+DxKKhZ7MDx/0SsfQt9VeHAJrkpKuS?=
 =?us-ascii?Q?Q6RhVQUch+hTxp2TXDKBzQAJ1EfHgevt/15+HP1yE0jTJS58lV72gNG9hJJe?=
 =?us-ascii?Q?Va+5gfziRR1h6RKmVADeaLzmOsjO+nzL7WjHHwMk5ybu8nBHgfAKT2cEJvN/?=
 =?us-ascii?Q?w/2DzRFCeDDMXJOA3WeYODs+oSfVoHzK4zUko+WqvaVtfcxEYkVhYqQmgazd?=
 =?us-ascii?Q?LGibpAF74+DJCpyTcLw9ah0SHDVkQoMpGi96n/atkUziN7UEQrmoq95TrsSw?=
 =?us-ascii?Q?W8HS1a/6zf86NnGCJgsbaIRBvlGRquA0uyryuJHynSpEWy6CqgyrFIB7DqsJ?=
 =?us-ascii?Q?ADeGV+JwrIlDGPKOhq3Xsawfl3b9/mT07fByLvu1t6UYRHnDSn+ZsmE4EWak?=
 =?us-ascii?Q?FkqbMs2iXTOkLbOPKzKmi4TZdW6dXUeshLJMXF53REwElX7fG5NYh/33IwEE?=
 =?us-ascii?Q?96ML4eq62fJruWPL2jqK4ub6Wu86SEm8lLmkqJqqX8OYd3U+Iv6HTkEpHNDI?=
 =?us-ascii?Q?hs58y5wndVeyVx3EvTjelZsMV3dtdvQQLDyXFWJB08jnbkKMSysUXTb4EoFN?=
 =?us-ascii?Q?t5+fNB6E++UmIH1ebtrFb14AxEc5rK8mn8HtjNhrQZRA9IvOPUqslDg8YFF6?=
 =?us-ascii?Q?d89qdyDKAl7iy+iqPzeNNmCG5Tz5ILAps63SfYyYCHOMDo2/IKEvaHdMvDZw?=
 =?us-ascii?Q?SAAzBuJUQGDbftgvLZzzez3h7A96L0nTgaz1XZYxBH0QAbCe/zg3gLskKbhe?=
 =?us-ascii?Q?bcyl9LsJkCqAfEETtS+3geW1Gem3RVrrRecrPAyqXQZxE5JKNZ1i86PjnOtL?=
 =?us-ascii?Q?OCuRB81Wle5ovYNb81yLb1h0o7i25TvPK0fHQtATNe+aqyxHQ+KrVf2f7YhS?=
 =?us-ascii?Q?r0+M9v0KwBvLZ2TRo2hSXRISbwJTX6NXcoV5/SKaIrbHhmDKUxziiF2j7YiX?=
 =?us-ascii?Q?LTNKsbWeSHZxaFQ4n8GrzHT+rsWmRgVIReSi3nH51xzE/v/Fwy25YRAnnz2j?=
 =?us-ascii?Q?boT0D5F3a5h7eo5UIQZLfb8xK9xG6hbCEkI0wIWPG+uLuGO/gc739BA/oCQs?=
 =?us-ascii?Q?ZubwX5Qh2AqsjB349/ZmVYMl8U/w+mV2gamAAxrVWc1rLX+39811yl9rdDhZ?=
 =?us-ascii?Q?X09zhNcZIuduOkrLZom42GYqMMRk37mfZShB8+TkplQHH4ko7j/yd9M3oY1I?=
 =?us-ascii?Q?BMeOan63e66qR+OUJUVW5WFMJuL4UZhjzujRPWLdxnj19v6KKqh1YS0nYjUh?=
 =?us-ascii?Q?u68KlEuCsXZFPNPYN+h+kKhia2UfNF3z15+YL8/C71zrDAEIiMuTYu0lguzo?=
 =?us-ascii?Q?YHMx4znrhdgqdG0mDfpC9+vx5OKcvQHOMETQzK2p?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f142688-c93e-420a-3920-08dcc35b5afe
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:07:11.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkTJpDmaNEWxPHzQGJPfOQoq4CDrRKc7czkHf0/Ibb1XBsFRlL/bYzhcCCkct20pBUTLAOju0+O4xASq2l0Pgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7176

Add COMPILE_TEST to support code compile test

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 64cd2ee03aa3..ff669a8ccad9 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -89,7 +89,7 @@ config HISILICON_LPC
 
 config IMX_WEIM
 	bool "Freescale EIM DRIVER"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  Driver for i.MX WEIM controller.
 	  The WEIM(Wireless External Interface Module) works like a bus.
-- 
2.25.1



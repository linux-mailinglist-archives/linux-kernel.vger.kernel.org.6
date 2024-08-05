Return-Path: <linux-kernel+bounces-274110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E98947380
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6779C1F21147
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4035D13CFA1;
	Mon,  5 Aug 2024 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sp9R73Tr"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253A6762EB;
	Mon,  5 Aug 2024 02:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826611; cv=fail; b=RLm/xx20AC0ZUOvk0VUs8rrdVSjbNsKxRYh2j17c11P30jdqiG4A6U8hgYZBQasbd5zfqQakbbje/cREPuNjWR6tcj9biQZiFW0roCpInG9qm/jly9BxwyNXFM9cgheIKgtF+AI4lNY5+W0Y7wUyq41Li+bcFHQGyObnba6Oey0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826611; c=relaxed/simple;
	bh=zLzDIwe4jtGanLQSFYrNBcPUoFCsYG4pFIshyALp/64=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZqTFAeDmrjCaUSaUrCwTe4R6rB34zK1wT1/u3KZilV75VUIrHLH3jD3xBZJEC806VNcr9ta9BSqy4WS2LuaE+9R9Pl2ymvvvPQ83CxeGzRUwbAqQn+Ik6tQQ95WdKrAncGgLOcGDYjkyoiD2tYuZPzb0biBUjGQVYJ7AEYtTzFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sp9R73Tr; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3DSCi4d9d8Rx8DNHs2N7Zphe0FCN2EoO97wIETHZx790G1UIky2LSzOZkqpdsI/c83yLGcxqmlRORw3+zvGG78G5mkRMAcP2W/LzuOLiMFyI4ko9u80G1QwldPBfVzjtJvvde+4i1ajrF67sv092GQENz9W+/a1qbc17YS5LW10MwnZdTPAr4uTaYUDNQbB92CbDNX9qHJhr5gox1uKNOsmubbCxClE/WVO4/fnknBnEjmHiIJzYgxrz7QEXf06ih5JNEm9/Xf0VmSsVjk0XnYCedD95Cc6+YDJXPQsJe5gm4BLiHjD0iadx2Qoh+yofyMzTMa6aqT4wNEaf//NxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyUj/fe47xD+UYeF9QYAUOnDIv/c4LCDMeoS1QVat+U=;
 b=kqcy+JBU4jC8qXIzMrnNsr7xoKZeP7vcv8oWNMqroQmupvYZzt2eCIAC7mqewfGtP4EagGUrQTZI2BtSbk5/rP1GVdmZZgqEPKZIG4sR1DPEnQTkUs1NcCjBL4/Mt5qC3/je12PMgTi6Hb8AXjjNhKOZjG69b8K+0W2xP3vRaDMYkOGmCAK8+FXnS0MBu3cGOX/k8oQaZs2ZTl+/AHPqPj19Yctip35eJ5NnTwkUYMGgaZDD31qYyjX8ONTnfVX2QacG0laeB2KFCknZ+Dlo51/PoGz6jto9Z+uEIljIIAkfBN0b6rzaDxs1MHi7nUprJnhnxI8FUXBUKJSxLTT9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyUj/fe47xD+UYeF9QYAUOnDIv/c4LCDMeoS1QVat+U=;
 b=sp9R73TrgcRngE54F6c0G8DjAgdV1BOgjlhXcZXSNT0643wD62UHvDApEyAd7kVTJRhsXeliY5hyZrYFABiJku3s6E1pa7MJIXndy+a7cBWPbqn1culwKQ+pX6EK0SwSbvo8tl8LNikz4B68YiGuA+BB/YQRF9nZa++olaaEhrCUQs/ZflZ8Q5AuBgO+7hUqt+pc6OA/Og+ovT0GY4QTWkcb+BODNhLG2iYpXOOoUM+dKg5iudRn5KJZEDWxkRN9cNmYy5WeJS6tBViOFSkb3/BQzl0KleZacmsoq5C9mf+5WYxyfzUEJ9lDgBtDnzamJoWqhjsNsZh4qHTYEeIN1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS5PR04MB9943.eurprd04.prod.outlook.com (2603:10a6:20b:67f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 02:56:45 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Mon, 5 Aug 2024
 02:56:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx95: correct L3Cache cache-sets
Date: Mon,  5 Aug 2024 11:05:35 +0800
Message-Id: <20240805030535.3027963-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS5PR04MB9943:EE_
X-MS-Office365-Filtering-Correlation-Id: 9041e4ba-3c97-4d33-191e-08dcb4fa3da0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GQV40OpXr5LLV7Cn1R07d3cMh5OQoqM0myi9xJNyZ6j+dDtRw85daqhlWkfj?=
 =?us-ascii?Q?hS5XNR10m0OR8tCS9tJP5iMGYY8LtLBsu+cBsYGBFJLi9HXk5FL6rRQZsOUG?=
 =?us-ascii?Q?mG+zgZ5JZbntykwyYgnT5GUtC+cNE63KpK8zitLJKpWvLEx5tssLyBAEOTS0?=
 =?us-ascii?Q?1aEYb7fhRuJ3GV/ckWkJ91lXlf6ag6VYTu2oBieOODIC+B73GhcemmkMG8GK?=
 =?us-ascii?Q?+PHzvJJU5uMTty0S32vC5kgaNjEHRgcQv5xdBBilqgIwmLZN2HaVGw+BhW8h?=
 =?us-ascii?Q?RHxNP6oNzqxzHHYbzjETJVSvRfhMy6Y7u0zWRTHBjOttWrH+UbSmjGHWO6aR?=
 =?us-ascii?Q?DZe2iJxI8zr0u9biusqiALKVzTlgC8ncNyo0Xv9+XHBWzzNPYiozu7yPbqVz?=
 =?us-ascii?Q?Any9urHULsWrcuZnFauElIQuZ2qj5O/KpyzrkjFTPhXuwIC0qt0zJamJmS8z?=
 =?us-ascii?Q?SEl1qhIxmcaw4S/jaVN3ClPvlHhPANp7/sZ8uKFfs1DPZjGnB/WsWzgUSF2k?=
 =?us-ascii?Q?6z5VxtlVcQ/sx9aom/eS9NmVhdLpvnxofvS+tV1VZuzzqL7yoFcuauvVH0I/?=
 =?us-ascii?Q?jdW/LyrX/YC9jnuJjcJHpoEmyJXMfBRGMxJeChQyqEZE7quRUnHhwZzzpb7W?=
 =?us-ascii?Q?dK0pojlt5WnhaKyG4puBjzhLNpQRoP8t3TXKA7zzx013mF/3IbkgsYMYqIH8?=
 =?us-ascii?Q?+TkufiR5OJQNhjCp68+K05Y28cXgwGNfO7W4OHPEkWWtEG7RJ6Q1xwvGdNC4?=
 =?us-ascii?Q?u/D3wqaFGTlWYzIkl+AnEiJjWEUoOD9VIT0WbgWrlwgecsVIyUJvXiWeF3d6?=
 =?us-ascii?Q?qIWb0fp3pnEl1OG3zHYXp8c0l+t8tS3ESGl5JfihYor6McIPKlZtmNiDejq0?=
 =?us-ascii?Q?lYZgxYhgUNN+SLDxJaup8hGX+Testd24yuwJlXpAKqRXC+IE0evGq9eEfd/R?=
 =?us-ascii?Q?ZVZJ/X65RwcUYu791yYWgOo2YWhD8VKtqWjQf+9bJZfg5wdGpS5aPAOBz4hz?=
 =?us-ascii?Q?QdirShaq34ZtsIAVBLUjLDK1NqgSAUVbQAu5h+YNfU950tFWXqJY3u/8I2L3?=
 =?us-ascii?Q?QakgxvjtztJ/C5h6YWnsgjn4tMYwnzvF9Cer4Ln/FcAuQysKgJeSC2MR3BtU?=
 =?us-ascii?Q?k11xERi8SF0VpecsyPC7fKzDpydsrdiAz2iBegw6/ZU5qhBn1Hggx4rkbQDI?=
 =?us-ascii?Q?XkTlFIOZTQZd8hJ2a4QnYEGdD2Eg5WDaDVZtHQ1xHTO4Tr9IftbYd60sclCb?=
 =?us-ascii?Q?fGcMI+1hL4ffz6x1u4ODqlCRyecxZBb+rfsF3RV7A3VOjZ0G1XKssauibyCy?=
 =?us-ascii?Q?LAGqgU2OZxUm5Q/xxlzx7sY7B6NyG4r4RYaQ0BL7Fng4HAtxiSWH5yOr9M+4?=
 =?us-ascii?Q?7qx9yYSpB14+jSefs5+08p2NlaH7jDE6D4FsyH4wJR3n/vZVjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ZDf5Fq10RfZzeUTu5AdIwZwqIP6C3/jUUWzhxiAzf90s2jx4IRdDiVDFoGQ?=
 =?us-ascii?Q?On9wD0n3KKVGqmBn8QxEGavAtJjjWWgX3RjL7PMHnEDaiXFtEWZgul3kT0mp?=
 =?us-ascii?Q?u1Z7NoEI5QRR6Aq/lqLy/59CqoKR+bgx6cTp2SS/WyYMPwj70tH85Frz2NuS?=
 =?us-ascii?Q?/IdRXJmdzkgyWVjbjsGlA1MkOwWpEVlpUlL/ik4m21Xzw1RWphG4T3RngRx2?=
 =?us-ascii?Q?GnGQGtmGmrIYJAnocBHgad83SZ6J0lCl45ObntA4DLeQHsvEwoXjtv9I7YEm?=
 =?us-ascii?Q?QwgKBAutEzSsy/hcolHTS3mBvAJXqW6D3p7p+uHP9a+vut6QsdoEYyfaiQOf?=
 =?us-ascii?Q?lPT3wxi8jPqBXlrB46qEASmZ44AVX7MDCqjDCn/HnIa2lNSG7fPih9TXVT6P?=
 =?us-ascii?Q?nlFE4UyMBQC+FM8Jmf+JMZ5dgj5zWLQMlxXiaGCoyeMlTnoT3UQhPpcgxMC6?=
 =?us-ascii?Q?epH+Phij8PG15smnGi9gSb07HzmF6TVRdqphKVH0XpB3Ykpiti76OwINfuQc?=
 =?us-ascii?Q?a5G33jy+aW8r6VTXHUFWDOcKSeO96DqNCLOhR2wq7e5bd5zGscvb6qSMhRdA?=
 =?us-ascii?Q?9au4zxFwwbiDAoe2diQ8z5UMFViHdBe5DWEHkxjrktJl4J/ExVnpuYNXH01V?=
 =?us-ascii?Q?Dnhg5Uz6btPGZdMUSOf6I5RS0eAcfvliIiWvYMOnWYM0/rx0ik/YCfSjmOT4?=
 =?us-ascii?Q?xql5dyPDmBczm9/tm98cALuxf6YECvUV8CJTacvKBWa6b8oqi+JN2M8Zv1Kq?=
 =?us-ascii?Q?iiB8VarCErXmtZMvARe+dyHEkDGS33BVPURkdhK2WzF3x55DP2jhnSuGPq1X?=
 =?us-ascii?Q?xOHT87y5EkY41wbRsF2kiwYuru9MHRkxMK8RYKtDzZB/VRFSCKHikdMYiNis?=
 =?us-ascii?Q?+JnLyJqx75k9AfK8/OXxN4iiqQKFI/kcKkXpR8hd1kB7Q3iWYsoqc/1Gkjxx?=
 =?us-ascii?Q?FW5JeOrnuczDRQkEkP2JVA9XwFW6d/K6bSecWEXhzJph7YvbLro0HHgM2Zc8?=
 =?us-ascii?Q?sOG+Sf5gPlFbIbKEB7+NfJ9qO3pXJK093BhWNT6fgIb+dAduJS+tzE/lwwf2?=
 =?us-ascii?Q?3oxmIIkNiUXxgsMVAXzUuifw99FuHQaEjuJmES22i+38efExYsyKgm6K/zzF?=
 =?us-ascii?Q?K4z3j2r7BAC8TDO6sMKk3EFfx/WPm5OqqLIBYXQqDp2wez/ZGs+/wa8ej7/V?=
 =?us-ascii?Q?LnIpCL5g08Tmdnhm6XHlIusx9AafDhB07MoZDjDLJr2xphVJAHsp/jPm/6wE?=
 =?us-ascii?Q?i9DlO44+r8pkwDH+O0FXFelmRMXKKy+tIh1vw99jQ6JYQE07kzsO17detBv4?=
 =?us-ascii?Q?Gz2yFIyzmWZRmKchGMeghhI6P3Bzq/FafZNYazSm1H0gqvArnuSh7/BQh60s?=
 =?us-ascii?Q?xK5+oNePuZBWVo0IqRPu74JkxxKpUJa65yw5mIOPtTcggUyrpaW3w61OxPK2?=
 =?us-ascii?Q?4OJWabohI1d4p2nRzLP8hbp8nklaj3wMlWwopoZhUooUYxsGtcQ3hbhIlu69?=
 =?us-ascii?Q?CX7Bk2raJeqhfSuw0SY9fSg0D+EMTEV8b81iImvQA28Nf+zWEZj+6HlWzDRb?=
 =?us-ascii?Q?XJq2uEm2/xsSNastmxh8gBCIzB9Zf1Kabf1MAdxW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9041e4ba-3c97-4d33-191e-08dcb4fa3da0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 02:56:45.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iw7ye5pHcG3OEp84TgiR3bSXQR32Kht8ML9v1WADlsaGZusCxkt8mgdCHymSSEYyyeFhKFr31DGq2+JKqPG4mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9943

From: Peng Fan <peng.fan@nxp.com>

The L3Cache size is 512KB.
Size = Cache Line Size(64) * num sets(512) * Assoc(0x10).

Correct the number of Cache sets.

Fixes: 5e3cbb8e4256 ("arm64: dts: freescale: add i.MX95 basic dtsi")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 3499d4eb2496..425272aa5a81 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -187,7 +187,7 @@ l3_cache: l3-cache {
 			compatible = "cache";
 			cache-size = <524288>;
 			cache-line-size = <64>;
-			cache-sets = <1024>;
+			cache-sets = <512>;
 			cache-level = <3>;
 			cache-unified;
 		};
-- 
2.37.1



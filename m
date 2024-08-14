Return-Path: <linux-kernel+bounces-287035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABB29521EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7D52825F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416E01B013F;
	Wed, 14 Aug 2024 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KDm2DmsZ"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4D13CABC;
	Wed, 14 Aug 2024 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723659470; cv=fail; b=uA3him6EOBb3Xz7M4/eizpSf9ult4WzvmMVz+zI7b8TA/YHy0Qkk8565G/UKoHcX5AD11TjTPGbKBdiBAAkyJus+5Q0lacqEn2J/6a+H28EHGpyEStJ2kugDyHeLzVOQEDubIzj5gzu9cg6eUc3I1BVtR2sMN6K7mSRR6a7AZa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723659470; c=relaxed/simple;
	bh=0OeenwlKPIgRkns/o9CqjgfaWgco9YJP5xQjuk5tpy4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OpkeAHiegwDQ2QcxmtFkyhqWxb6T/p4IWNbAYRd2rUEX7bigCrZbq8qcLISj1FvAQZ1yE4UMgCYxIw1T3Ox/cUkqN/he5gmjAJHK2b1ILmVqXIlld12QpMd11+cFipzkB+9PH+9vfvOKMMEjRNXRn7V+f3aKdPfCXtGDYWDh0Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KDm2DmsZ; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZTnuarXv/U9NvIgD0XU/5fH8HZdeksXr3/TaTCwpJFAPSdFbyHTV2voc5FyheV/KrKrMPcDnCjq1a8OsgP0HTsoXBJOV/o9bxpiELGla7P8cbyVXOzzZUHetHkHJuXqvY8mvCeczuYRGhWjk3N53WexPoZyiXjge7Nb9X+GtDnDrxP0Xt6EMjNfexGZq06Hpf+dM7VjgBkWqD0yjFzCtSnBe+5buY8IxLKrBhm/D7iiPk6ESyVImJYK4uoQe3q08IVgZmcDoW4fVSPMTZl2Ye21A0D+Ptar/64HRoTRlAE/OKoZnRVROvGsN/J94IEmDziC8L8MQCE56Y+Hq6q2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2/YRs/C/9uEJsAzER3w1y+EKOzV1Ne/AUPJxk/nbDQ=;
 b=xNp6YFjrmQOLFr+abKU1LzH/wAaC5lT/rx/n45HGiQ48JwmwrXu95jHp2Dtz0FymLATGR6YMc3+15TZt///Vdd8PzMjcMo9o1pCzgH6LsAZiGljKAE3od5lwU0Y3ECMRfQGb3hxh44YiBpBEjYPqslA3t8mcYMdoxvhOIx+uDu2zp1LfagVZ/WMbHUazCQeSKlQqsqB0p2ieyR2bSjwUgOP7AzRR7xY/dBbOxxjXkJpEE8o+kx1mAsoEGZ71A8Zh3/7cQcevS8nIaOrqVH9JrT+5drp5TKGdLMwLL5gaJmakdoWHCG5M/4LBGWcOWVyGN23nv/+DPIgoWpgh4ZVEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2/YRs/C/9uEJsAzER3w1y+EKOzV1Ne/AUPJxk/nbDQ=;
 b=KDm2DmsZXJApR1jWAjEXcXa2i7cP1z6blmPU3fFpdMR+fxxGZ2mNAZlG5FYNjXLzaNrSZEp+U1eUPeq8iORZBYZC5g3UcMD69RFhxAFGodGxMLGRUpqRnbmGdfDJWmsSO3doTi9YS0/JP33lQvJABTcZ1wdc6dvyc8QT+9kO0KsM/6tKFDFvKMUbQBY6sGvROCxluxnyWFA3a14uQLuN4ElUbYT3UBl2Pv2lOAKQPuEPnKz3yRkJkSSJAA+81uDjLly0q6aK3F5/BPL0u5x/NQK313GYTgInxvwdWoY+ljBApjomjQs9vpH37i7aLQ3LQUginZS6hFMnyj52XVFocA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9956.eurprd04.prod.outlook.com (2603:10a6:800:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 18:17:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 18:17:44 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt to yaml
Date: Wed, 14 Aug 2024 14:17:26 -0400
Message-Id: <20240814181727.4030958-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9956:EE_
X-MS-Office365-Filtering-Correlation-Id: c51ce261-9609-4fbe-0c19-08dcbc8d64c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M204OwyrJXUOROy9/GF1ujfZCB6vWasPoq8Yd4FjrWUaMk6FWI7A3Rnl296m?=
 =?us-ascii?Q?wS969ROACb4rWig0vQVpauqujsnOpIVzminNM5/LVyKjUvBT77kavH+xThhw?=
 =?us-ascii?Q?mTI8Q6pns/Ip69+MKgiHA3T6YiGuK8hJ5CnfGS2mAA2C6l2ZfBqeEOtCMdQi?=
 =?us-ascii?Q?2gCT04DKyGCHpGBr2nmc2pymqRrP7QT0W0nN/wwJa4Ftev19fb2UUaOGVG/F?=
 =?us-ascii?Q?a31/gnl4hNtefNduCnHYypP3pn+L93g0wowvxHjDNYYZOgfHbYXGYgBcbiOd?=
 =?us-ascii?Q?cZmTogLz4tNz+MiJCbOsQqUTXI2R1mcidxZfEa7WviP6oeOeGwesRDYWTzOV?=
 =?us-ascii?Q?LloUxxpwGV2H7C/+JcVO5uNH+rGaXclz5shTzi0b9mZP7SvxVO9ezRYWAVDk?=
 =?us-ascii?Q?nJ6Ls8bswi5It8uKrTjZqYVxS860ZlCbkxx4j7ec6CC0D7kTUhjv1997l+sr?=
 =?us-ascii?Q?WwY8Clnuw2EV+3Ub6qX8cWwcgbZDq2+3OCMquEn/OJOmsYjd2Mv3bugCu2VC?=
 =?us-ascii?Q?Q3SMHOmESgT/GMT6MWvDmEKkcwgl2+1phmdOSWFAlHxIBttO3/srMt2htGo+?=
 =?us-ascii?Q?AL3rC7rFiK5qBOyj+KV3Uw6uPEhg3bh68bKBmam29S/1NXbvmORCb4n8J5Tb?=
 =?us-ascii?Q?hiHcyYZZ9xL/DqoNg+b/8QWOpfvy3a/4tJOidSGC4qyXZDcl8lyJA5kXk5Vx?=
 =?us-ascii?Q?3342IBonhzgWRxsvobesv3IIwQeG+z6LPnLmYM4i9B+FLfP6zvmibuiVXvFg?=
 =?us-ascii?Q?tvDxhkuR1pIaYWd2VGMQHuA0K6/pHzDxU/2nQ1pyKrUlHcWOaw6Yu14vVAd8?=
 =?us-ascii?Q?ZS4cv+jp8+H1TyMllml8ayFvWrTABwV7o1ubX9+vZ1nlTJPBaU/ALqYcy3+S?=
 =?us-ascii?Q?J3OFq3OzeJaAGtjk80YBPya40Gg8Bfm3cJPU6p4upHkFTwPgJ5qEWKkmHRVi?=
 =?us-ascii?Q?n7yGOT89YLDnbInd90iFMHySSPoXL93zZI4XByaeZEw/fGStoZsIPeSM0vED?=
 =?us-ascii?Q?usIlMESeDZqFMdSmdvA3rAusvQkPePxE+5h1geW/NqQBnezO0FKmfB19clFy?=
 =?us-ascii?Q?t/gr7YbJUk6d+tm9acULCzJ72dAtKjcPqOgtpPcCssmP8TaoY5lQMkcS8a3I?=
 =?us-ascii?Q?OnjlJHYgjyPbIRn78i607RUimBVBV8b09GpkwQszP/ESfP7UGdLuLnUDLD9s?=
 =?us-ascii?Q?pRlF8nP1yCZ3YnCxY8I9ZaYt1/2p75ocRHgTQakOcx9HLbohjoiW1SBPpGjd?=
 =?us-ascii?Q?Z/n2SmKRxRaJEcRF32BlvmLlUi6a25JI0OYuejho3F+g9iWwvM3xOdnZvxVc?=
 =?us-ascii?Q?yW6YTTxhry0fM+Dxq+yuSsNa7wGpTcULKh4z6iWXC+ryey3zaAJluq8uzEr3?=
 =?us-ascii?Q?YtbjIf3DN5g7CzT9cqLRvqNtZ+LT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lYXoien00vtRmj2+dpJnS23OdGCUL19DrEdns3ECl2UbZNPNOzq8IViIkuXe?=
 =?us-ascii?Q?aV6O57WPjeF6Rd32Etk/+10sttR7h+WUsBhe17wHAuokUu+vKOoDPxoQTp1u?=
 =?us-ascii?Q?HM0aqflH11vjIOS4Z5N0e2udIJdi9uYn7ql61XCNtas8BmOkCPlsAiM5Wa/i?=
 =?us-ascii?Q?A9Tw3zPtMOfRG2mplg5sHd/nVlDX9OP8eQLkSqiQLnhseg5G8WmB+9oZAODI?=
 =?us-ascii?Q?qB7+28CG68szrW8FkJFSp6t/tx9QpHV8BZ8A7ac6HXNBoqTmVU3hqXFwv2DW?=
 =?us-ascii?Q?vT1qtIgzeegUX3G0Kwhue6NfTAt004FsOprBwY70UW2I1VJDb8XeePYqNGWm?=
 =?us-ascii?Q?eNvu134ANZfdcOrNRr+bpTILzlMTD0gdsNyiw9eHFt0Pv3s8oyUeulXZcFrY?=
 =?us-ascii?Q?lUnRNkFkqRelBmuk9rRbYNK5QEdeDsiRi+BCeW6GBAaQbs1eB2c4jfOX+kH5?=
 =?us-ascii?Q?7uyN7omFO93b2c+4Ty9l2mqioB0/y0aCry0W+SoyPjFxbfH2riBMTjUb7ARa?=
 =?us-ascii?Q?6S7WpxBj5VoKPQc/Xmjz+fxZRg5F0u7/sdkpftrptbvVOk+8XObbMazn9uAT?=
 =?us-ascii?Q?+Bw2by9qNBR+iTaWVshIcPN2c1m7vbMj/Ye9+bOHdj8Z/AM71Zmzxb0xg0EY?=
 =?us-ascii?Q?VB9BliNtymVvFjvh58RAc7yTFx/RFsImEdttoFZXPuo4c69ONcA08Q+NCQHG?=
 =?us-ascii?Q?hIynvlOhllYPMn4fn/WY9bgfm8D4KbDTls/q9r9duFDlyl4HCWxhoGbdF7d3?=
 =?us-ascii?Q?XjCIspn+Ep9HD6SmWDMSSIa1UteDdb6tFGem7QKfs4xxRe9rlIk08mI6/iOQ?=
 =?us-ascii?Q?WWUIKXhPB4Nkh5lBcVm+duW8PkadsULGBSobY4k/DURGK7szAQhMpA4vAsuO?=
 =?us-ascii?Q?v9Ec/VwJ28M6OjwquxBA7twu0u2lqSt+uJfxaUAdvFVuTfaaNxEa7ZxF6bWN?=
 =?us-ascii?Q?6clMB0NtAwz8cd3EOb/Dd1JTFqil6nGRK6K6DVI4WeVDBzlJluiH7CKIx3iT?=
 =?us-ascii?Q?iKjGcmqYrtDamudsmsm7vFYicwLnF6JcZj+A0BgdSVJcBwOEr6v6mHUkGcm6?=
 =?us-ascii?Q?VNyCnfIXvjl6TB+TVWdzO+Hmcl6F75w6fNuToOhG+91285aDJTGVqlwWan78?=
 =?us-ascii?Q?eQ/5px03dEWHN168IMspgQrOL62UoWkmdDUS6gnRZWQm43swjCGroyNULkJI?=
 =?us-ascii?Q?ZYy0654btiMq9eEVvs0aMVijXh7kUmtELUVIOo327EEpu0a9k6xbL5wGTpcO?=
 =?us-ascii?Q?s2EL1sGm3DHb5VmrLiCq1nzwmgkgoaxJ4xhHjX6ng8tWQD/6x1jBQWy2vIOb?=
 =?us-ascii?Q?qhaiRIwza6mW5rMdZwsKGvfu9wX28eY7J8nb6ZfMqZrcMmsJ7tXacltoaZYy?=
 =?us-ascii?Q?FrZTwKhe7XB5t7kw2qnoUKb4r26dYqWyQs5uBgq31jcRXc+qwy1sPRXhZjEG?=
 =?us-ascii?Q?JuREHJoHltiNEjF9Y2OEUWJYpeAQz9XLZj5iOT481/RtQQwQS9GYcavTXJmx?=
 =?us-ascii?Q?SpsjdkPMoPCoScR9U5Wx9RXDb4vg6nFY25paYVNWgYigFYycQKz4npPZqh7+?=
 =?us-ascii?Q?vsvf1Ug9G/1P8RKTIh5lWtHX4yLERbmn/izQ4ECZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51ce261-9609-4fbe-0c19-08dcbc8d64c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 18:17:44.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ28i4EY3FvjT8KCsTCKaWNCkpKu4HOd7YLm2HVli6vQEicATKdkvLjSFXtZbbdfxchkQ5L8AhCOyFWGoz8OzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9956

Convert binding doc ltc2978.txt to yaml format.
Additional change:
- add i2c node.
- basic it is regulator according to example, move it under regulator.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
	failed to match any schema with compatible: ['lltc,ltc3882']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
 .../bindings/regulator/lltc,ltc2972.yaml      | 94 +++++++++++++++++++
 2 files changed, 94 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
deleted file mode 100644
index 4e7f6215a4533..0000000000000
--- a/Documentation/devicetree/bindings/hwmon/ltc2978.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-ltc2978
-
-Required properties:
-- compatible: should contain one of:
-  * "lltc,ltc2972"
-  * "lltc,ltc2974"
-  * "lltc,ltc2975"
-  * "lltc,ltc2977"
-  * "lltc,ltc2978"
-  * "lltc,ltc2979"
-  * "lltc,ltc2980"
-  * "lltc,ltc3880"
-  * "lltc,ltc3882"
-  * "lltc,ltc3883"
-  * "lltc,ltc3884"
-  * "lltc,ltc3886"
-  * "lltc,ltc3887"
-  * "lltc,ltc3889"
-  * "lltc,ltc7880"
-  * "lltc,ltm2987"
-  * "lltc,ltm4664"
-  * "lltc,ltm4675"
-  * "lltc,ltm4676"
-  * "lltc,ltm4677"
-  * "lltc,ltm4678"
-  * "lltc,ltm4680"
-  * "lltc,ltm4686"
-  * "lltc,ltm4700"
-- reg: I2C slave address
-
-Optional properties:
-- regulators: A node that houses a sub-node for each regulator controlled by
-  the device. Each sub-node is identified using the node's name, with valid
-  values listed below. The content of each sub-node is defined by the
-  standard binding for regulators; see regulator.txt.
-
-Valid names of regulators depend on number of supplies supported per device:
-  * ltc2972 vout0 - vout1
-  * ltc2974, ltc2975 : vout0 - vout3
-  * ltc2977, ltc2979, ltc2980, ltm2987 : vout0 - vout7
-  * ltc2978 : vout0 - vout7
-  * ltc3880, ltc3882, ltc3884, ltc3886, ltc3887, ltc3889 : vout0 - vout1
-  * ltc7880 : vout0 - vout1
-  * ltc3883 : vout0
-  * ltm4664 : vout0 - vout1
-  * ltm4675, ltm4676, ltm4677, ltm4678 : vout0 - vout1
-  * ltm4680, ltm4686 : vout0 - vout1
-  * ltm4700 : vout0 - vout1
-
-Example:
-ltc2978@5e {
-	compatible = "lltc,ltc2978";
-	reg = <0x5e>;
-	regulators {
-		vout0 {
-			regulator-name = "FPGA-2.5V";
-		};
-		vout2 {
-			regulator-name = "FPGA-1.5V";
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml b/Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml
new file mode 100644
index 0000000000000..20ae6152a2572
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/lltc,ltc2972.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ltc2978
+
+maintainers:
+  - Jean Delvare <jdelvare@suse.com>
+
+properties:
+  compatible:
+    enum:
+      - lltc,ltc2972
+      - lltc,ltc2974
+      - lltc,ltc2975
+      - lltc,ltc2977
+      - lltc,ltc2978
+      - lltc,ltc2979
+      - lltc,ltc2980
+      - lltc,ltc3880
+      - lltc,ltc3882
+      - lltc,ltc3883
+      - lltc,ltc3884
+      - lltc,ltc3886
+      - lltc,ltc3887
+      - lltc,ltc3889
+      - lltc,ltc7880
+      - lltc,ltm2987
+      - lltc,ltm4664
+      - lltc,ltm4675
+      - lltc,ltm4676
+      - lltc,ltm4677
+      - lltc,ltm4678
+      - lltc,ltm4680
+      - lltc,ltm4686
+      - lltc,ltm4700
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller.
+      Valid names of regulators depend on number of supplies supported per device:
+      * ltc2972 vout0 - vout1
+      * ltc2974, ltc2975 : vout0 - vout3
+      * ltc2977, ltc2979, ltc2980, ltm2987 : vout0 - vout7
+      * ltc2978 : vout0 - vout7
+      * ltc3880, ltc3882, ltc3884, ltc3886, ltc3887, ltc3889 : vout0 - vout1
+      * ltc7880 : vout0 - vout1
+      * ltc3883 : vout0
+      * ltm4664 : vout0 - vout1
+      * ltm4675, ltm4676, ltm4677, ltm4678 : vout0 - vout1
+      * ltm4680, ltm4686 : vout0 - vout1
+      * ltm4700 : vout0 - vout1
+
+    patternProperties:
+      "^vout[0-7]$":
+        $ref: regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@5e {
+            compatible = "lltc,ltc2978";
+            reg = <0x5e>;
+
+            regulators {
+                vout0 {
+                     regulator-name = "FPGA-2.5V";
+                };
+                vout2 {
+                     regulator-name = "FPGA-1.5V";
+                };
+            };
+        };
+    };
+
-- 
2.34.1



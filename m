Return-Path: <linux-kernel+bounces-307173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E60964973
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BDF1F20D47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8AE1B14E1;
	Thu, 29 Aug 2024 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RkAJv2XF"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2066.outbound.protection.outlook.com [40.107.247.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3411946A1;
	Thu, 29 Aug 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944023; cv=fail; b=OpcNWCAnD/E1PmPGMMLb76iaIGpPYAaILwjzkTnzF9KxVZjOArmyBeUpXyunXwW0/5DWPVDCz3lyo4M4KNcv5G3J2ZrDwbl8KYPEkjeqpROiGxis3JH3bT276nCA9W88/1WNzVSUS5/gkNukueFJTJjZ8vPs3lcIa7MZrcxUIHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944023; c=relaxed/simple;
	bh=+2fgA9TC+dwBHPxhLaXz9ckHiGb2+kaiUE1u+W4r4hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L1JDJCicJAgzVPChQ41UFMTArthDXLCxlN3kAyX2liYmXz1hWiJRBpAhaZ5f5WrROSBrXkpmZxwJ7XTwjcd1PCU4z2c7gW45wAhlRDr/zlCg8JfMoV2dWIjj6NldaaYff36nsGkLMZ7utcQPNdp1DDYGzQjbiMcrpEXJ0J8nOoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RkAJv2XF; arc=fail smtp.client-ip=40.107.247.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJ+EDVcaXr0L34nhj7o36Ucj55T+GhHtZjyMz1l1cIgpufD97fGeDKraDNug+4feN7f4+nrm+YodnkfP+8bLTMmAGOelwR4Xk5xD6C1FSl0UE0brkP821gu6laZWQY+BFqyG62CkYwO0XNmA0kxCqI+NYpL/4SpdGqM92FjkpxL/XtC7tANIw/vukPXcrgb/gAkdeEXW3nsqyj4pkzTWfoIXC6lRJcRsNnmaag1WHkYPafJH9MexyvlDtanur9xPQsfgsGcUQi2GzV6PXW+4KwKzcqfLARYOX7u362qQOpljF+/n/9BAVI2PVO+b4Xlo/mCaq9QNzOK+AvwKu4U5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Llouk6SmK1N/zD9TTqyLaymBZafmnJCw2vSUCq2JL7M=;
 b=pDdFae86qUcfvFBez2SlycHc5ieijWJh0CLyarNdXN1vpHSTZlFcKhez5Z4HrwE7Y83Ly6lh6B8zpn3SDdeWW21t0jdZV2zttm9mIgayl4UBOL1arKbjyqU2p0q3OrLIfquC2Y5GxwXXjmRiFwER1LmiIQv5BlqnmtQvk4QLnUmwqYjXWZ4VYjwmv1+JCuZSCVvkrIlSm3QUkp2DJIGxHQm62opEeMwA5cHGpf4KZSrDJoeRxbIN1s7kIwAe9MJrHMyhbZV8x2/rCnZJly2FM7dvXjJ0VGaolcTVM5buR8eW14Pn7zpuzsU3XdobgXVPLvrWw/+SWzHA6iuAGBVFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Llouk6SmK1N/zD9TTqyLaymBZafmnJCw2vSUCq2JL7M=;
 b=RkAJv2XF3Yd3f2gwR41aQgn7Ek6JnNzCYo+BolLtCJ5ttGEFyzpM1S+NGTYtFRsdi0/6RXM9XpFyYAWxEicSCCFle/PhG15VsoZD5UfDvORR96EU+o6wNbkNvtoA5wgp6pkIImQnwj5ME4fQ4/WMzzkn8gSM1vUOpt6ZzwNf8LYU6n84HANbyxcHXQ9In+KUzjkn29y3qlU5T3a5oL9ilMu2kcnrCbJFbFIApFnJWxHOdxEVicQzAAo0qswABLFqToPLKjaHzMs04qN59OWqz3HL4qOGXXPChX41KhDGutw1mfToKYY4rWC+UHuETsemqHvyFir44BYdBnnyQZu5qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 15:06:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 15:06:57 +0000
From: Frank Li <Frank.Li@nxp.com>
To: linux@roeck-us.net
Cc: Frank.li@nxp.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	jdelvare@suse.com,
	krzk+dt@kernel.org,
	lgirdwood@gmail.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: [PATCH v5 1/1] dt-bindings: hwmon: Convert ltc2978.txt to yaml
Date: Thu, 29 Aug 2024 11:06:41 -0400
Message-Id: <20240829150641.1307906-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5a1cd7-192e-4dd8-e6f6-08dcc83c39b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/dcNV19SoeS+yYuSwZTdxplCu6rpekc9iRVG1F6mL75Z5A3SgFSPwYFpHAO5?=
 =?us-ascii?Q?03bQUPhhi3v2auFjA/xCcs5U6YWYaWKk5B8ES/eBxkqzCWMnDxrpUnVoOx0Y?=
 =?us-ascii?Q?x+FuElelp2ls6yub/v6GFgtyc+iYLWVEOtV/wJmhO+h2aTmkPBanDNm3T2KR?=
 =?us-ascii?Q?N/gAu1B/5UBMuMKeT937XOAatw3ktDGCUVwRUzmYgQ1hmO6EONaHoTWCjqvi?=
 =?us-ascii?Q?ARFgea3oXsWuNMV8JjfjdewRWra+CPAoJDXqcvYFk6WM2q00Pkiv1vGEhAUu?=
 =?us-ascii?Q?wRL/SbBTa9BeX4n/tuxH5O3Yf861gLsV7MojxlVtiZWFFw4OgVNdZ6HFl2e+?=
 =?us-ascii?Q?NM4kdYxZRYb68bQc3oWaMy1aG24l8VYujxlrxle+rpd96eUwgXeAHxtA27jF?=
 =?us-ascii?Q?ZfiHGKfadetE84kMshEa3sPhbREogp0ia1rlWOn1jiFRkG36xIKbLhtKj60S?=
 =?us-ascii?Q?twdRfo8860BghDxtSFVOyzJeuvNRMdHHysdUxOkXNrFqbgyae2uPnE/RPgPR?=
 =?us-ascii?Q?SxDojWN8VGQTMTVMsBvXu15EXTqIztnRDd8x/lASoRSQtmUExedxdLgqfhC4?=
 =?us-ascii?Q?va9k3HkIY1Z762CEg1D744P6wga/lGEMJgnhLp1NJUWLmFYMdJ/Z0dAbcMCN?=
 =?us-ascii?Q?Ma9GaYtDJOiZB9mMhs9Qe89idica4efH6tvtm/Xkq+TATVDzqgQvkNouHaaN?=
 =?us-ascii?Q?Ae+C9DZ4gku1VPVUYxMVV+Jell8ejo90Ft9U0Yl0syddfdk7UvGpzUUCgBvt?=
 =?us-ascii?Q?aP9YQ6gXDj66hqv1fEm09RLKpUg8EpWAQHak7fEpo2HjrDqpPGhCFvb4H5/f?=
 =?us-ascii?Q?9RcTu6btKfqh+MxwkZ8LDYQdwSqAdMFPqCgT5Zq8hxUPDL2CtgFW6aB1zFff?=
 =?us-ascii?Q?FsIniazYKDjrwfigmV66v+geQPX2p42jE2DFcAhan+GsPmrj6k2UIH7vjwNu?=
 =?us-ascii?Q?LE1kWt1SxQTV3ZCLqWlyJXeBliqBGuujefnMXyRho/ZkVP97GnYX2sbviWW9?=
 =?us-ascii?Q?IqQxo/7aRgmaZITH12cBwZRmEkr7d2Azs6OHyqHKN1MmLWpb7ZNQiV1hIBLl?=
 =?us-ascii?Q?KKrqqT6Mt0sxmjm7vyAdSUDmijMJhl8aryoKqsSy5D7GCBYF4JlIGpxDBV7A?=
 =?us-ascii?Q?CklKIAzGybM5Dvp6XXJzxvpHv5+GYYouO/EW7+v8N75+PBHYGQ92WaOKsnm0?=
 =?us-ascii?Q?oGCL51IUra3oGVYTDWcirBQ7nQbuxnYm1Tnoei7gMc0FEmS8l8ATl4pQPblG?=
 =?us-ascii?Q?ecjIOXZTOl2Ydm9b+ODc0Unms7RI8rhru3VqnuHBwqORmXkOiKMXQD5BWG6H?=
 =?us-ascii?Q?C6I8SvhvlevvqlkHfcxu06YAcaN1mb0c64rlz/Im1qbl2UAH8cJ8+1a6GSwz?=
 =?us-ascii?Q?voGANSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9mZntt8We4DTmxDTDmOMS/nIAj9uyVcGO3ZAdeydWmbgeidkDiu0MaqAtiOo?=
 =?us-ascii?Q?V8fvIyhWY8qQmgQKrXqDPg2hKLiWoGYEfqizAytqQcAERI+USpeC9Rqx8lbR?=
 =?us-ascii?Q?5Sn9rBqVu35jJUuJ8Ve5OqB8e61V8z/eq6QxCzjCa5GoOUEO2zZPpgAC5qQ4?=
 =?us-ascii?Q?7+wj9pgLBkOF9BW4BfuPjOym5+PMMw1qqYfS0bUvXETePTtjeWnF24QGODkQ?=
 =?us-ascii?Q?LNw2iW61FpziPGsHH3P5u1YE3AOkMSlXJ8Yyw3DxKIML7HObmo2m5TJYkLM6?=
 =?us-ascii?Q?wevXffKO643TAT37GXbjJqUZs96INnYc4hcH7TRawjY0uOxk0vF8Gj9qdv5Y?=
 =?us-ascii?Q?DBzoD+MinvKQgmLFTqwwamNWsFzdLWiKMQRzAqwBQAIiDr61DDX1AO+gKfce?=
 =?us-ascii?Q?1sA8WfWnMs4BcvMCOasdnQvU+x0KJqwOwO5TmNItDvkHJUTDNgYDDCePXcTI?=
 =?us-ascii?Q?7fmrxZGnADQovhdXiVSsD0WasbxNiMFaX9o94YHmiH2jNvuPokn469xgnfvu?=
 =?us-ascii?Q?//cUVFSBYw3VqsxmKaCVQ2BwIf3jPPMdTnN62C/7yYySEWQgp0kELtzNxq9H?=
 =?us-ascii?Q?KPr0f3mzXModzjSfO/kZZpSWI1PkYOOGpxmenNTXQ1780P+yIN96DwVUPTsL?=
 =?us-ascii?Q?ZBokgmYzyAQHwTA8muPahkX4WCbcwXrBtPp2sUD7wS6aaQfdYFbJd+vh9Obn?=
 =?us-ascii?Q?zphDNgGBPjpJarGTCa+CLvTeZJiAUdNov7FS4dRhQXVNKDkdweYkJSlhZRpG?=
 =?us-ascii?Q?H4Mk7cSneLCEFXR/6fM2d4Ja95/mWWoVjB9/IJBGLIydiH916O824HWP8a9u?=
 =?us-ascii?Q?Gf47kBChCJCelzRfffaEy5gxvfN6Y+JvwvKZrccN4EqK/jdjzPby4H6dSn54?=
 =?us-ascii?Q?XzSp/NO6RQY26c2NyUPiwZ3XLjzm9QIlX166kWHp6AnSS7UugpzPjWY5X2zv?=
 =?us-ascii?Q?nwU3BEYkJx9XKmG45SZQQD7/t6vigsMAs8dERbFniKE8o7MD5ATnjXrbDqEr?=
 =?us-ascii?Q?vQvBTovtXtvegRMaMT1dQt0Q3JDmZF+wKjnRBoH2/Beg8pmr4HANzG6U/dMa?=
 =?us-ascii?Q?ojEzVue+MMyj4OnmVt7hut1lhwuqtdhGidEaCHphIqSCy16kqIeJ2t5BR+9L?=
 =?us-ascii?Q?HjMttoUAYg34uM3VjaD0bXiPgd2RnVG4GmM1Vpgj7aVIA4yvnOuXP81NfeCL?=
 =?us-ascii?Q?Q1NDAsl9eokINGOpbwmLkpFAfPlrezMRTa3Da51TYBAWa5KgKl8ryqWpDlb1?=
 =?us-ascii?Q?81sMm+zzgn+WbHmkiXUrrqpX9mBPyoqO3A0Ce+EHSPpu7R+c2mL/ZF7vJWue?=
 =?us-ascii?Q?B7HbZCI08I7ed5BHVDpEXyWbgecxwyE4jY8YInHI/ihwf2/TK06DMNdBTPWt?=
 =?us-ascii?Q?lzBTCsfO8aobkN9m6gjajneEcikAdQtgZRNxYMjHhYT/yOTZWt/dN3/279Hj?=
 =?us-ascii?Q?0mFG+ubAZIOTiyv3Md+Aey0XvANB4AVUGYBOtOyzy9uEvPyTwX08hYcGKBJa?=
 =?us-ascii?Q?igPSykkOkTPo476vmDyQwQVO+DqMT23q8kXV9L11GLso3EOKt9aQ10ZVapOe?=
 =?us-ascii?Q?bgmx2FqstpctmeL1zkA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5a1cd7-192e-4dd8-e6f6-08dcc83c39b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:06:57.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dh1oLyVWBUY2V4Oyv2us58C5zbifIBqLRciACv8Di5xZbcvKR4XNOrDHzXfjDKtbAfeRLvNCzzkg+abUJZquVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

Convert binding doc ltc2978.txt to yaml format.
Additional change:
- add i2c node.
- basic it is regulator according to example, move it under regulator.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
	failed to match any schema with compatible: ['lltc,ltc3882']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
- rename to lltc,ltc2978.yaml
Change from v3 to v4
- keep under hwmon directory.
Change from v2 to v3
- put my name into maintainers.
change from v1 to v2
- maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
- update title to (from ltc2978 data sheet).
octal, digital power-supply monitor, supervisor, sequencer, and margin controller.
---
 .../bindings/hwmon/lltc,ltc2978.yaml          | 94 +++++++++++++++++++
 .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
 2 files changed, 94 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt

diff --git a/Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml b/Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml
new file mode 100644
index 0000000000000..1f98da32f3feb
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/lltc,ltc2978.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Octal Digital Power-supply monitor/supervisor/sequencer/margin controller.
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
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
+        $ref: /schemas/regulator/regulator.yaml#
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
-- 
2.34.1



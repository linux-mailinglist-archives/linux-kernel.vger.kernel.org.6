Return-Path: <linux-kernel+bounces-301868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9BE95F6AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24721282644
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FF819538D;
	Mon, 26 Aug 2024 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QpgWhoz4"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013007.outbound.protection.outlook.com [52.101.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56965476B;
	Mon, 26 Aug 2024 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690205; cv=fail; b=MvTRnWRmi19U71MQHsqtNZlJZTqzTfEAfcq0ohQFil0OsONrcwraX+QZjVhjr9XZhTv9IEN/TscN0lOl0BS54F0LPi1DMrZhamT5HRx1+7b+E25qxXjuefffR7aRcA75sB4tdfBICr0MyBaHf7+uLCx9phD6H2lToXNikoL2r6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690205; c=relaxed/simple;
	bh=GConoWA7KnbeHQIhqk0Et7Ru3GusNe81+6MF3tzVrWo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sO3JI3QPk701ouQI+p8djxOExS8dQBmXtrQdZ919t/0E2z4aEZDUsrvQKmfozUhXQZDbYsowdFUvnNQtG5kFO69St5Hgk5H1fm042y8zgB5b00Bil7Q2hb0Jh2z7DfM9QpE0azeJgjcdtqtGR5azIu9K+A3QudYWFwD6X8eSf/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QpgWhoz4; arc=fail smtp.client-ip=52.101.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aE//q+mXkmnhr7wfwSm76rjmz72I1kSVqMEYyOn8F8CtLPDOhga+m90sg2HEDesufhxSXV0G1zh8KTchYHToUKp5pEdGzzhB4D+4g5cQg8whHwfZ5kMmsIO8dzDwsFJQaur6Px3yq8jV0NnSQoryFm5j5qYxZr8t9YHHI1e0j4HduaADNPG4q2BmjkCkIzq5kjA/QJYaV5O5n8hlpr6ZdwvFCsScv5rFTKDHeZgR5VD2assv9qIcP1NK1HdhLGcAkEQnaUkDD6c0I7nJoytJvqBVtzPIFQTAnl9nGg0ovXrMUaEA4gjz+fzVT2ZvxCsyQAc80nUkDnnD3+i2y2nzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaQJHZsiwti3NVp8gATXFagLt8zdcwWqweY/7gOSKx8=;
 b=DS9UWUCgedUCHLHI7XK/eu9K9nO+kam+OTrF5YNPZMhctUM7or0tXDb3zERQSoiGdSdcG9SWQLfCYZd8Q715vCqBFFnpX+Mpd477/cy8MZ/EFukcPj8lco4AyAra7BvoyTefvEa6Pk6PZHGMpaWxwUsjIRlGtCHl02AkTWmxyWprZkWbWzEuzYGX0BUXvOBZnwkPz0MO2rSYEbOIZbeoWH0nP4EIPIJ7hOuOdZVJ7t6V+kVgSZocmueodL+HQFERlB1vr5qodtQ8glUpDNZy9hAeq/JORlAj9kckA1UL4a9x2PQX7/JUbj5SuNVMroALZYQwwKL/nolOSyvt7GrjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaQJHZsiwti3NVp8gATXFagLt8zdcwWqweY/7gOSKx8=;
 b=QpgWhoz48i/DpMHLWNGomLC43SancFvOAGSGb+cjWTMJYqPHiRrhUIenvdDSv7eFElzFeYPyrNN1CZRMaZW267qcOYwBAGU1RPvASFllR8V8wRjt8CqwzLpFbL+HA4SqwWdhSl1fTbvDHshJUjSgKEaJh6e9oFuvDKVuA9c1vXv+Txz4YJ3dhnG0Fliv9qGpU49JDtlzij6J5UXMvabZeb0vE2tOi6NKP1VLrE/LSYtXbhDXqk1r7Evqi4SB8asaB3Fpcyj460+qFWpv7YoPkD2CprAW5Go7YgJPp7gAdCAdunERb7TtU1V1gohh3yLXIGcXjdY7Ldqm2ExvNHNCRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 16:36:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 16:36:39 +0000
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
Subject: [PATCH v3 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt to yaml
Date: Mon, 26 Aug 2024 12:36:25 -0400
Message-Id: <20240826163626.961586-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c31173f-4198-4080-0db4-08dcc5ed42bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ZUMb+dBc9lZ2CHOMqJi9ilxpNInaOhf/46HPBb7BnCXP4YxdTEXqcoFwltt?=
 =?us-ascii?Q?L+YKUAA+YJEVt1tOS5w80TVa0ce0ATQZ8MkvHRIhk40JdNmFH42Ks96yaFvI?=
 =?us-ascii?Q?6moTKnXOSINjqFA3kRnOa0Tj4WKORJjqRRQqduX9ddeJv+aWz0z8ueneIZ6x?=
 =?us-ascii?Q?+J3+9vN2NYPkR3Xq6MeMH8bVz7tV4KJGxH96iX8bXMytAyIUapSKnaCiaYke?=
 =?us-ascii?Q?MGtFVsMP+iTmrl8xgUybNgemxRbRnulLwhLDse3KoRNxDJLtXM+ig9sH9TGB?=
 =?us-ascii?Q?E6ygxU7ZT80iNKGdK17/b+6hSKfPMlJISOo9OJXcIANiR9A9k3WHvmMR9UzC?=
 =?us-ascii?Q?cbmpJi4U/9WObfN4PFG0oAKxIoIW8gUZQbjUbpBtqey44pI8DH11OUHRDUXG?=
 =?us-ascii?Q?49Vo2sJyqhg+7Cyvc81WpKGxHHbqw+UgxBZi8AgJEwo8rK05L5cTNnMYznWe?=
 =?us-ascii?Q?wghgVSzczaYOC0e/LiFU4bnjsMRUIr0wCDPwcYjpw316VNi9cLBaUlnVyL0h?=
 =?us-ascii?Q?NTzlnDfG453UNr8id5B9zt5bmqVZye79b35+g2Hz6+c7b2LovoOXFk8Lr5wh?=
 =?us-ascii?Q?so8oHKPeufFBaDAtwzBupRiAYd8NrQOc2/8gZmXeQ41XMc4WYZo4HeAf3E1P?=
 =?us-ascii?Q?DcU5aTqXYc7jVqfgPjgp9MxY3kzsTuerda1kHgePuF2D60cS+95qxh6GEVWH?=
 =?us-ascii?Q?ytmMyyeAuRqjFXzcBPxF0aAJexrp+FAY2tvveLN7IHEBjRcRYj7Gbb+rlJWh?=
 =?us-ascii?Q?TYW285fgy9dxYi9of5vB8ddNOI4Ea/NmN53kcziVqlhOoj+O0gF5b7m2caMB?=
 =?us-ascii?Q?j2N5yTbL+pJflucKVEtVsUUmjiIqMZQTRFbCR6gKYYmN2hU1J8lFAYK5Q+ZF?=
 =?us-ascii?Q?XFHQRFk8ErMRdOtEPizCk02qn75r1tn+9qi3fsgYmdGjIOFEHv/wWNAMNy9a?=
 =?us-ascii?Q?Z/1dBapO8gDjO1IWZWh3cFd/EMhBk5LhlRYDuk1AHG9Y/lTF3MjgLGIYRLA+?=
 =?us-ascii?Q?8AMZRuxW2AvgRGZuzmaz2GRZQTzwwZ/4HtJPsvih7xnlbe/sZWCp1TKdgpWg?=
 =?us-ascii?Q?JUM1B5qTs1/FNV2DvoQvvoILG37Y/NZ0YOgWogn7f9jIRpVPUXdh7fOy6m6z?=
 =?us-ascii?Q?mbCziJ17SwBKrU/xN+2agS0JdkWPPnMx3JOm1QdkrB9lSfe5O6WK/Qng34IG?=
 =?us-ascii?Q?pKyqTn7E0xOxL6Vh2d9Rt5T4FuL91lmmzvkI0mHwxI3RRA+e/e66uwxvIiQi?=
 =?us-ascii?Q?1XGoricKnGAgJpodBU0dLZKDnF8/Luw3nsFc5KLVrDeEYaUGMnptRNjd+LWq?=
 =?us-ascii?Q?y9pCseBthAKBh/h6CVFQd1pw601kgtAPgaIPUqCNpIm19MukYMYEdgrMhGFS?=
 =?us-ascii?Q?iOOQPVe4fQXQfoySFrEbPzZ/gUZU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s9KGiKtLw6lUzEpoQFnLWnuc5B6xTOJwGdQJF53aDc5gdz4XvfPsgqa5xL4F?=
 =?us-ascii?Q?3CD8CHuc4i3XngMXdkJBvAX/c4Tgn3feX1BFdHZeeHbWXwJeQEpYdvErsm9F?=
 =?us-ascii?Q?gZkF+KGvtC0ByxsFpKQ3zGKN4oOq/oQ8CevFB3SC4z9RqZqOrnmu5qFxXMdg?=
 =?us-ascii?Q?ugX53QmrIhi//fZ1gdWemZ+KteneMo6SauOhoY857UpQhCl0EQamXcs2l3Ah?=
 =?us-ascii?Q?nW4UplHgc6xvW1JhqJpaHHzCZj0JyPszfR7kbaATpC9iNmiAu8d4ntDlVfNl?=
 =?us-ascii?Q?U/irYphHgMLpxiBbu0gRfpDF9qBc0sTkKnVYXA/Tj3/PSroEzhD2B5utyj4x?=
 =?us-ascii?Q?yu/bkIhFGdNRWLr4DC86SOMQCgx9cZT/N7EjC+fZKCHurUMbIp50Q1anHDcv?=
 =?us-ascii?Q?9VUQGrKHZA4Wlz8tzEpwoDyXOAqXCov9MXa8RKeTBuI5Yqeu6yMxZCx0ZJ6O?=
 =?us-ascii?Q?lYIfsPUcE68KFpLpDiO0sgwxv65h+1DBUj8SK8rWRU14yI5QmMViWDv22NBr?=
 =?us-ascii?Q?tsgO/ehdoHYdKRT9jB5hZAhj/xwhqxxwK1/SC58t72wE3nh0ehXYjB9vPsPl?=
 =?us-ascii?Q?aSDdWWx04zsfr+TYk1MQmCLVHzTxX+DO8udQd7mb6EdBAA8NrkKJrzYEMCdH?=
 =?us-ascii?Q?S3TWlBBKRTV4tXyIo19l9B4sZvphCQ1fyQip/FOdUNLctWMUVLULl/KZ/GZi?=
 =?us-ascii?Q?Zsod29BVKfkbE48VEIK9zM0+UzhMzrFmYt94A1M81qPb/lEnqdR4mBbZBq77?=
 =?us-ascii?Q?ysgrJ2dy4ufU72F6qbvggFylQtCwuPiFDXXTW9iLQMAy+bHUCcKkPWx0bhpt?=
 =?us-ascii?Q?CikQJxUHiTnf7DkXRL4mXcsoSN0zsGlsbwbBIS+yFM5jSljRELgBBznmSNqi?=
 =?us-ascii?Q?Hh55e6LisHXvs9VOgXNKyTM8ngjZVM0RxNk5Pzb5+o+3Hkl69XV1hHmK0//I?=
 =?us-ascii?Q?S7Esvk+lG03rUsX72HGLo9Jet8VLbZgzSQh/2VW7TeR7F7PraVzsl/Gx03PB?=
 =?us-ascii?Q?YAdV22Qls1r28P2Tb/oEqe5RyiqZfPYTwNur9Dguks4LxWmZm17G33tqIrja?=
 =?us-ascii?Q?U5idiGx2i8ntj15p9tmHNwvtK1q/T8cnAv3MVEt9QLyQ57xX3NSluMye4ooJ?=
 =?us-ascii?Q?14ICMCH6mPXzZD86K9wCZg25mKcOzc9nHINB8DmrWAblEgek3Kp/21GZQZr+?=
 =?us-ascii?Q?0nX4VeFAP7kgNbd6JvTO7AcWWCxeKujpYnIstVPlQ/Rjid+NIqWDmeU+GlIa?=
 =?us-ascii?Q?srUojFMUx0/fJVM6zGbu6FQmBKrYwu+tTIaKSMP+urtQ9URxEGLpbj9kOFQF?=
 =?us-ascii?Q?P2CxPy3vWOoGX4X1Pmlf8IArYO84iRxjRgSdPpBmipRtcOKBwp2+XCe96cvb?=
 =?us-ascii?Q?P+6qtbe6h5s33tVE9JlH6MINsineqkh/ghJ17sUHZF+VlWRMslGsguWEE0Xe?=
 =?us-ascii?Q?jjKUUTwae65y5JskKdq5xHHbeI8s6Vxeqt8vOadnKpEcbIbc5mWb+KsCOLNr?=
 =?us-ascii?Q?MSggJcTdRjDK+iFFPzSTLZpWMtd6m42bvZYGVGdf9aJamtn1c4BwRalyL0b/?=
 =?us-ascii?Q?HPRJBu//YC+QpKLhgIo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c31173f-4198-4080-0db4-08dcc5ed42bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 16:36:39.8781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxUkSg0F2ce3QB8vmJ72eKQNrzf2cLCXf15XA+vQAg1tDOHgsTCBBwKaXatFDe5GjmLd0XPzZGvIE+28/LjX+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6941

Convert binding doc ltc2978.txt to yaml format.
Additional change:
- add i2c node.
- basic it is regulator according to example, move it under regulator.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
	failed to match any schema with compatible: ['lltc,ltc3882']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- put my name into maintainers.
change from v1 to v2
- maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
- update title to (from ltc2978 data sheet).
octal, digital power-supply monitor, supervisor, sequencer, and margin controller.
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
index 0000000000000..7270daea87f0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/lltc,ltc2972.yaml#
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



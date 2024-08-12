Return-Path: <linux-kernel+bounces-283713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A15394F80F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174861F21B92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB4D1940AA;
	Mon, 12 Aug 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LPc8nVK+"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B815C143;
	Mon, 12 Aug 2024 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493893; cv=fail; b=cPewoe5v6C0/+zz6bgTq9AVmLmXrPCckPZzEx3NrvtOoWAT65SzNzdkyf8bbT5DVzVfBGbCNFeDF9Se84UwKdAd9rHdjAbIiJkIshTVzX2luWZwE0ZwbYnxIfmGAFb4JA99UBpfFsAm+IZUdIha4Gax5yeujTJLJb8WjugHABrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493893; c=relaxed/simple;
	bh=tYUKvSiSWY8P3AR7053BCHUAOpgKjgH4SPmJ5yxKbgY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rdiv7bmGmIIGm6rVP2ha3X3aSWLDvcLooFL87rX8VHGFqhRYVK3cwOlyiLjfIpgEjor6LbberjjkG7SDs8P4Hg35GZnfPDyXYdxOlAOWrykWdSbD3t4BeKRYeSCxniisM9/ONe4Mzp39Gx/dsn9JgK5G802cFpZx4rihnoOrcLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LPc8nVK+; arc=fail smtp.client-ip=52.101.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9d7wihxRxIh+vaSDHAtrdJs6E6L0Yct0ab8tWKQYEgHdool359rCGalWhzQXAx6r+wDUXUb9AmLNwAwdbEcvudXOzsMK2gHiSJ9+bwy4BiLpCVHa50pj3m4iL59wXHvRLeEAImuEyzjrIPr0D47h6qV+92bdGIqLy1C7nQI5o+pNkoTxcDth8FJ0B+0S5+QpWVjxiAGXrkKMmDDXwQv1QcNT7Z2DHDXAhk3AkYPaow7aHt6B2xb/hgIeWk6T0njFjTrjSGFfz1oKoFSx+Vfu0dzJwt4mPCyxFtBiMNSjmUCiHTiV4hx6QGzWw0RvPbQEs0ZyPXdVFwukMuWVUCQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nbterb+HSbKaPt0W5bzJVRStpVvkjA+xshgb+yKeS0=;
 b=ENBZGVEXnsCEul90y4CqldjQCafsCHvoM42ds9IIAM+GFaV/nKMUSEHnb/b7OfsOgCkT4ZG8fdNL2SQV/fpPFOZAnqL64zczujqwmdBNoAZFBcGvilOw6yQJuJF2dWVfYu6V3vS47fB11X9Y/bbXHXhkRW7GaV6zZomwiSKxpcZpgn25P8BWnjtrcJ+koXGP1m6sP9IFb8eaeKeiKWEoceI2nSpcCWg/N0F5HGmHKb8HxuK9dFQX/9IG0L6W6GdPQqdnLOz93fAHHF+m7RqBjYXgl3hm8YRck8dWIJi1havYTnt4txGmWU4JAdMb1dIaZFpDBURcLWSJUabdhXE9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nbterb+HSbKaPt0W5bzJVRStpVvkjA+xshgb+yKeS0=;
 b=LPc8nVK+seFQBr1rK+5qTJdBNgxHtVjARASTH74tfPQAmrWXL0XF16LKPjLh5K5bUDlFPSnNc7Uwf5EJaY0kQ/kMvo0Nd6BNldeq567BaiHZ1IwW6AHZk+ZA2pDmhmgQLjI5uusgHVSr6YUoE6lLlwkTqF75u1kczcPJPueg5Owjww9e2nNTqPF01usDRrn65zU4HAIU755qzp9uWy5iyxUUxXqMfpkZUFsRZP2OP9Rml3ozThLf8U92FIC71wG2q58s4g5e4UwHgQ552wWv0uZtKC76z1ZyREhRuKVCx9mitPfkBBjNGQXWzpINRN0grED6RTtiWHj6Hkw0bsxPFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8345.eurprd04.prod.outlook.com (2603:10a6:10:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 20:18:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 20:18:06 +0000
From: Frank Li <Frank.Li@nxp.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list:EXTERNAL CONNECTOR SUBSYSTEM (EXTCON)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: extcon: convert extcon-usb-gpio.txt to yaml format
Date: Mon, 12 Aug 2024 16:17:53 -0400
Message-Id: <20240812201754.3830198-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:a03:54::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9240c9-803f-406a-79bf-08dcbb0be0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pVTSkSCoUJj4QfNzdQbNX/mU78y4/fTlt+3UVtYyx08o1e/I1GUaEozUBVLR?=
 =?us-ascii?Q?qgtpXgJKLNYyTy9yT4voP9iVfyQqOJCrotxzkccZMHDu83L3sP3YEfpS+/4P?=
 =?us-ascii?Q?RLiiN6m39FkAa88Qrd8RKjZMMzt0wJDOZLqUiyGxb97DSteIOapabVcLMf2b?=
 =?us-ascii?Q?NzpTIn3lIRoqe402B8dnZvb43jUoOz3rEzYj1Kj91YZG2R6eCr7yUBWqVOEN?=
 =?us-ascii?Q?o4wEA+rmBg/tEP3KbAKYDOUmrvoylZRkRTrdrW/E4P9p0olfZdUJNJWoaBTb?=
 =?us-ascii?Q?zSlsWuJgFK2LbB2X/EcVNO6Fniue5dWo368j915ymIAwa499gm02EyoDS6Ea?=
 =?us-ascii?Q?cOKIYUcbkqo7iPlDImSj+ktWgJJV9gbdzY/ccTHsT6eN3qTdMM1mMcCrFcTP?=
 =?us-ascii?Q?JGzX04JdYWwRISabZeF4THJqRbC6TMm3Fyh1v3x37Cb4Y2cQwbZIoh+BEpte?=
 =?us-ascii?Q?p2XAjHnPl1GDvQZijjR+Vn6TQ8NGd1rNkUoaTFYXts0vLlkdL095h9hCk+QX?=
 =?us-ascii?Q?uoK1GbWJRkbaHywSxIJzjtW573XgtceEi6E++HXslNq+BnCfmefkq2nnywFp?=
 =?us-ascii?Q?VfkLcY+nxkgxA2b0GRrynqTPeQH7VD/e5+WZyTJivtlzplaPjl0FxJBIju6m?=
 =?us-ascii?Q?ro8l3uWmlZHSOjX3VFgRcFqRfk4Izv0dRj6Sax7c7GyqOLchMc3Lu9eJbb3P?=
 =?us-ascii?Q?rF4gfFrVvqVMlOvyccDU8meIJL3aGiHJJ7Ij7u3nUui/T/iSCo53YpjfiYRT?=
 =?us-ascii?Q?Au0cNuApQoYFYSRYqqlYPG5bwBG0C70Us88NGamA1ic6zMeAPfcJAFqffZQV?=
 =?us-ascii?Q?381VjFf0Pck5p/5OWy0M6au0MbT3R+4pm14PdcFRz5aMyrup8axztvwNdynw?=
 =?us-ascii?Q?oM1UQhTHnM4hetUKepmN69T0mhylmMz9uSIZa/y1Mj74/L22xET3RbhHdx0i?=
 =?us-ascii?Q?Z8qJ8sfmlj4Sz8v0SytfB1Mq6CXdhjl7pAI15x4WxABfMbGeVAmvqX2ZJifm?=
 =?us-ascii?Q?YfhHlkZnYKQPFvL8oz4EXUmyUekn0/uO364ySRMjZDvH2UfZDhVzvE29ju8P?=
 =?us-ascii?Q?MaeRbGNbotAmGaSp3UB37Ul+lyYB+QkSPtcuryWjR2O1z2bFWlFCqH/BGPXl?=
 =?us-ascii?Q?KtuVcGnejIfJsFcEknUWhSNfHiKwKHshCrulNr1fsuSbjGwcGmzMuFMf62mM?=
 =?us-ascii?Q?Lwsjrjv+DoUavQgPAnoxYidYs3y8/riTZwY3x9/r+2mCnkYf5iQkN5oVj05X?=
 =?us-ascii?Q?K3Qqkuv+CZUqaVTWStA4g+99TmAAL1Nj+T4w9y4OIhKivfvK4lGt8sk6Jr8u?=
 =?us-ascii?Q?QgolVjgFRE0FUlixv2XoFA74Wk4ygoob+idZwwaBSBkxnH9FmiEM+yys+nO9?=
 =?us-ascii?Q?eKEsTQs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oNdkIewGu4DhDveFMqsvuuX3RSt9UWuQUGCyzvMXHOVyW9eJRpnluvFr4bwg?=
 =?us-ascii?Q?7z75f0YbDffYjvsDMJks/b+YDMIskmnoUccyh7SqS4ZR7U2LQy15JSXM8TwK?=
 =?us-ascii?Q?J8XgxZfXloFt958htUbHATQeZiM/pu2S6NtI+p34Zk4i5+F0mvpbcYPcqsQA?=
 =?us-ascii?Q?2v71qJvLxNfy3i3tfh5uipCob4A+5fq5WME7vr58QCt7AeV7/OHI13b5eUkj?=
 =?us-ascii?Q?YITH5zEl2bE2KEFlGwqOUGhkPSqxJWYmDDyrIUHdNwH2AbzlDPSt4xL2E6Mu?=
 =?us-ascii?Q?7o5m1WwJk/TG4JoX44y5yymKpXnDh/vAGWqco8vec2fvQp6dTEpEqjZoz42l?=
 =?us-ascii?Q?NRR2SFI1yekSqG58QA5Lth1sFx9CBJfXIh7WrRMTHWcsxGObmvkScrE5if5S?=
 =?us-ascii?Q?MbFn6TU3R/WLWdsQc1qMT3cx/WBa91bhnORVVv0+FTbLUB00BWJ0Z27/xwlA?=
 =?us-ascii?Q?/cOtivJEHIonOeKHZoNBHBbfxt0IaSrNBDYVN+Lg9eJhiBMZXWd4aK7iOPWn?=
 =?us-ascii?Q?p7VrDm11zk/6FZylyXJn9YIHBpOgmYeR6kcqD9iBauxvuQtF3bk3ePTBb9y2?=
 =?us-ascii?Q?7+Y4szL1lbIynzK8ldJsgM8loHfuhMEeUouMgdIo7jqewQS2XKrEG/uP5GZ6?=
 =?us-ascii?Q?IpAvCumARc9HqfkvHH3lBE8oBjOvyc4tuughvf5ziL3r3hEziKVeFHz1xNKX?=
 =?us-ascii?Q?2AABQz9TCPvrBhbM0RxHdoQ4Xtj9oBRwtM2GoZMg3axSYwVqSsV/hbsHRHXZ?=
 =?us-ascii?Q?9wxpBOYKJXXJS/eI8peZYjOPN81g7YUO8Rg1CBkbyavXfQ576qmjfVrQrWvV?=
 =?us-ascii?Q?9gZ53OaDoK7u0iX0eVm7KQSvheQQdIhZ+6kTzPHZi+L/rPr0qwSUvZyAwt61?=
 =?us-ascii?Q?oXjPWq3kWSSXD7NNY5FLcxu5wVAdrjOD8d5wI5fh5O0cmHeqTCsY7MYRvGdQ?=
 =?us-ascii?Q?JSqr0VQZEIPcHfyfqnLWAXlyQpyiQ9RrmA+yNEqki7VIrwEY0wfWKWCDrQCf?=
 =?us-ascii?Q?csAeHKbgIHnzh3wDGpjz2Dht96iJU2jm5mqq2B15sSmYCAyQrNdZluHKHOj1?=
 =?us-ascii?Q?hiHI2S/fttwewCe73Uh5AeWAesbNv9bv6hBwbMqqAYhkpzjGp0xy6TOohWZc?=
 =?us-ascii?Q?DgPLaZzcUU7jXhbdYScyz9I70Rovp8jNKwZ+UiRuFCKVi+5R9UHqND+vWnSj?=
 =?us-ascii?Q?Anx1X57/eICUNJw8jyT9dAyKwUQpQhT/EJehxMbVUY9hN3VSWznLgK6Fe6qa?=
 =?us-ascii?Q?7LcyIDFweIGuJNp+JEj9taeDUb04P99poCIxCsxU9wTz8uOAmO2l3pxzt4DO?=
 =?us-ascii?Q?N83iloa8V//iK9H1/oz1kyVaGIc8D2YYlNoCHKHXoAAKW4OtpfccMdUGRlNc?=
 =?us-ascii?Q?DA3J3KGJPwZqbrTf0tlj6yG8bc2U4//XHGw3xlxbvNH7iQcynOqtz6vO0Ck7?=
 =?us-ascii?Q?/qddIHR1LX4FKxzFIx4TMQNGYRJu8nODzbf3T1uVLjXVBx1SziTd3RNOOt5Q?=
 =?us-ascii?Q?2QIs+rsK8AlJaSGgtJZGCo7YlS1jPzFlcLI54ubPME7y+tfPEnzlaSCcCfPV?=
 =?us-ascii?Q?0VWViGZQQguyWOOfNW0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9240c9-803f-406a-79bf-08dcbb0be0a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 20:18:06.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0fECWkAMT701dK/IC1w6f0dsusDagEEygpCUm7sgCXupWleHco5pjAaFynLSAP3vsrseFcWEabhAxz5OHGjmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8345

Convert binding doc extcon-usb-gpio.txt to yaml format to fix below
warning:
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb: /extcon-usb0:
    failed to match any schema with compatible: ['linux,extcon-usb-gpio']

Additional change:
- rename id-gpio to id-gpios
- rename vbus-gpio to vbus-gpios

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/extcon/extcon-usb-gpio.txt       | 21 ----------
 .../extcon/linux,extcon-usb-gpio.yaml         | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt b/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
deleted file mode 100644
index dfc14f71e81fb..0000000000000
--- a/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-USB GPIO Extcon device
-
-This is a virtual device used to generate USB cable states from the USB ID pin
-connected to a GPIO pin.
-
-Required properties:
-- compatible: Should be "linux,extcon-usb-gpio"
-
-Either one of id-gpio or vbus-gpio must be present. Both can be present as well.
-- id-gpio: gpio for USB ID pin. See gpio binding.
-- vbus-gpio: gpio for USB VBUS pin.
-
-Example: Examples of extcon-usb-gpio node in dra7-evm.dts as listed below:
-	extcon_usb1 {
-		compatible = "linux,extcon-usb-gpio";
-		id-gpio = <&gpio6 1 GPIO_ACTIVE_HIGH>;
-	}
-
-	&omap_dwc3_1 {
-		extcon = <&extcon_usb1>;
-	};
diff --git a/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml b/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
new file mode 100644
index 0000000000000..1caf58c297d34
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/linux,extcon-usb-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: USB GPIO Extcon device
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  This is a virtual device used to generate USB cable states from the USB ID pin
+  connected to a GPIO pin.
+
+properties:
+  compatible:
+    const: linux,extcon-usb-gpio
+
+  id-gpios:
+    description: gpio for USB ID pin. See gpio binding.
+  vbus-gpios:
+    description: gpio for USB VBUS pin.
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    extcon_usb1 {
+        compatible = "linux,extcon-usb-gpio";
+        id-gpios = <&gpio6 1 GPIO_ACTIVE_HIGH>;
+    };
+
-- 
2.34.1



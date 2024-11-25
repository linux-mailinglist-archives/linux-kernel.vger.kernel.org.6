Return-Path: <linux-kernel+bounces-420707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C419D8266
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A322163734
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5817D19309C;
	Mon, 25 Nov 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OfJt46K/"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2071.outbound.protection.outlook.com [40.107.249.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A119307F;
	Mon, 25 Nov 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527221; cv=fail; b=AoZUh/wKNZujmhJz6ZRChe64K40APnY6x8qsHULsSyLMFF6vwzwILa5bxldmQmrHJvoYjnksK6HqIdwTUkVyPp35P6L/Nd3pOGlz914XlyOXHB6DaE8YTuWNsIYtZ1O1Da+SqCzFlIuYtHeHFtN7wzBxRoUKS2mllD4pZF6e2BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527221; c=relaxed/simple;
	bh=toa0KYG1lcsX/pN3XwwSMy7kYEb3ys1Ysy+pKcYiRUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCndVBkWAGukCacpoK/T+LLcbDHq4Iq5VMCx8j+XVYQBZ88x+MLU0DECiJLrLfpuV0po2lmzHvz17JEksxZGVgCUHOCAzjG9/mei1zBJpZdXjdG4Im9IdmTb6dfcHH7H746gVa/eGPWKSfK2bcaVqChdsI5zGtIWOtT96Y8lT04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OfJt46K/; arc=fail smtp.client-ip=40.107.249.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+aRfQyt6OBGnid4mXMtxIsaIZZHn+xr2XMn77Uss/UuGBDklSrKaPhT3NeKMc0R3YBF5dGusRcDX/dQsZAQ89M7PqeHam4JxcVQ6Jsp3Hg4HJVlOeHPXipr+k4BKenTrL3ze/24OfDdZkhG7kXdKGSTbEl3yOZjw32J5gwAvrXb+yXyDRxwWTjvpDOMfzjBdj5+/73AYWu4G1z4qSqmo1IHnEmjQEgDwLAOQe2qfGbYYeJD1VQ5HnWfbdu/me+ArzL0NPXEz2fsEgoWEn7m32v6GUUcNzR4S3Weu5PPpdjFHPttCDow2yevyMpbfelDHhD1mBz9kmLI/6VNbsRmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ+B2/N03l9c78vsCZN5PzmZB4ox5S6YcNX/ON4w+fE=;
 b=KOyVZ5AF5dmXPBqXFxpZi7QDSAiEHTNqn9x5dUN0qyC7Wbpm2GsWTH1XOhEYgKUt3mMmlh8XeFYLiLH3DFC/uKUlj/AUBaI/CKZ6opuK9F+7MeotsNzdkcU8EjL6dhPUNciI1skk1F9j8xmCUAQZBs5D0q2SjfmhhWVSbQR0Kmoq6ls7gahHm1Z7z/V4AJVP2tgZ9w57emZF6jU+D1J0WamcnigMHPYl3vFKe4Y1QboJSlXzJieZAyGaW4LaRrAool5BvmNm5bbibubOJDcP+F8M5qNzIgtFJAU020Y7o02JV1BRZk6KVW4AxDKcgf/EtsYrjBx/Vm9C8igXOFbviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ+B2/N03l9c78vsCZN5PzmZB4ox5S6YcNX/ON4w+fE=;
 b=OfJt46K/YCQMoNTe4rJra7luQrfUxdzlc4bJlbDSlBUEjj7rdDsrcmN+hk1tNWYmGez/tutDV+BgtkdR+yhqDfzF0h8DcZ/35BwHB/VQ6vvr2sX+GvkP9stTlG3epcwGI01gO570Xsm2tRshOwi0NR3q95FvPSFBZKZIPTC0G/h6PMA0y3JTyv1uhHnA3TVVOhxt7gDhyHi/Zx729lRMB0hasjE+FIBxu69OAK8mNZzhPAyjdYiZQu/eI841bqHUjfpxCcjn+GNnoz48iVoNn5DwJxYy0J/5KttCs9870sOz9K/R71FeaHgDBnLrsD5NxzMwgF1yzTh5AkGhc5Ur8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 09:33:36 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%6]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 09:33:36 +0000
From: Liu Ying <victor.liu@nxp.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: p.zabel@pengutronix.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	glx@linutronix.de,
	vkoul@kernel.org,
	kishon@kernel.org,
	aisheng.dong@nxp.com,
	agx@sigxcpu.org,
	francesco@dolcini.it,
	frank.li@nxp.com,
	dmitry.baryshkov@linaro.org
Subject: [PATCH v4 04/19] dt-bindings: display: imx: Add i.MX8qxp Display Controller pixel engine
Date: Mon, 25 Nov 2024 17:33:01 +0800
Message-Id: <20241125093316.2357162-5-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125093316.2357162-1-victor.liu@nxp.com>
References: <20241125093316.2357162-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: ee338747-3f59-42e1-4422-08dd0d343ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UycDjQnzxgvotxWUQQJIy+Kw53VNw0lHaFQEbosWr/yvzC4p1peQFypvfMXG?=
 =?us-ascii?Q?3oBDe59Hwfm12Y8RN4qrx1yG6UNt1Lk9WUrYzAdJHOEyH+aEIBm/Boq+43eb?=
 =?us-ascii?Q?BeYu83ZbgIy8EPuL+s1Ap6W6eWf5lr6TyTUFsrAZ7r1tMiujEaK3YGBNlc+U?=
 =?us-ascii?Q?REC+MsloP+Sr16+qYnq6iCosylEJG9/UisofWpUHC7gBmOmzz+zmQ9ejueKn?=
 =?us-ascii?Q?SXEM3yryPAspVWTzbndXlZfM1YamPWUqDNm4YPbOBESm0uym63ZDW6LFe+Lx?=
 =?us-ascii?Q?xzzxne1RTwp+B3VFDNx3kJm2YjkQk5Iy0u9dw7ADG1Pp37k/Ppup3yM9+dig?=
 =?us-ascii?Q?g1HS4dEkT+m49x77zGUH2Tq2cQONmCbNnpT1QIL6HBe5QJD5ofOt2K+e7kej?=
 =?us-ascii?Q?cykJLgTEdsqVq4uQ4TZu9THE2o3oGM2GiUtcmdq0EbXan+d8j+cvjy9kwzDj?=
 =?us-ascii?Q?XBPGQvSPhG0+YJFgvkxFAks4NqMyi7Qo31u07lq5eKViCpV3xsG6rzvN7jnX?=
 =?us-ascii?Q?cVOsA6ShwAq+hNxv23KhiBtXFUMWmF1Go7WdNWb4Mqm5SxDzYCanbgSNqxqq?=
 =?us-ascii?Q?WWWA5IcfLMbXrMAU/t1OnjIF8ul8Iq6ZvtC5yDeRL2tPO9fS1pC8ZYOI5PJg?=
 =?us-ascii?Q?0WdnI7lDK7I0ijhpfXgxcvh7tM01iVnnohTCzLeXF9w625q1rkW3mf5gWq5n?=
 =?us-ascii?Q?5YMMqN90RmqtUC/eKUowv/G8987s1Wnzjf8LFLnZmXwLtgcMBHEH51kRrnAy?=
 =?us-ascii?Q?lORxqSYCr/dINf4H5p1Ko2xdYktmzPcQj8ld5QBjycvmybysI//qNJXYxFfs?=
 =?us-ascii?Q?0KikOiy4fiDc1vmLnHid0LCoy42lLdn6vkCNR/N0Yis4SW/ff9IiDE9XXPQu?=
 =?us-ascii?Q?GgT9cXywvTZPpTcC+gfrLQaCI5YdEvblxoKHedCc0qKJNLR+bDi4WvIBqz7j?=
 =?us-ascii?Q?CXrE8DYIqV/3ZEpwuSHXHX6tBwSKD2YXMOxGEASsSwQ/+Vx47tLlin4C44yI?=
 =?us-ascii?Q?97Gm1N4D3PB3EvGKq5af150nIXpoazKv5VJqqUa0IosAyYA7MEby8NQKxr2t?=
 =?us-ascii?Q?lOb4qQjlFLVx7oybscsyQSrRv34WHwvSlY6zOrre/wRw9Fd/mD5xmC4rHEWC?=
 =?us-ascii?Q?iVW9tn07AThf/X3puR9tat6kQHAQZFSv+oQZAo8ucjkoQgcdLIvDKqp/3t9w?=
 =?us-ascii?Q?Xcz9bmPW8VBojE5xD8YDySWgXXIReDxN5ZYTwbZS4erPzK4eipHZC/dJhkjy?=
 =?us-ascii?Q?yca/clqHajnX+nbaXAzLWoRRX2GTdU2EUXZcghIDG+fkOG1rdiBBeaUZyO1T?=
 =?us-ascii?Q?1YSM0YgJmGezf7gAAiUjkPWR5IaR3SXGh6aSigkDuUxh4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uZWv5FErGCs5wQQr4t8NP7bNGMxHDeLrWJdaUEb3JQ7tOgclxShNHe0MULWw?=
 =?us-ascii?Q?gne/K+oSU+GV8O8QCF5dFIyS2JMs7eipAnmJ5jugXyBRbAL7Z6GnGOWsnnUZ?=
 =?us-ascii?Q?hew5Sh8PPI//ozeX9o1g8RT+cVqqrNIymJIIkOShWR/Uk2/o9hNtCbEbYwok?=
 =?us-ascii?Q?BIXcM9K9yDUGBA9i4NHJlucGHe+pa+gGMBX4iTG3elYn7wPzpXXOsMon80MM?=
 =?us-ascii?Q?M2NKYSH1tXeceY7YO6MskSetJS2C8fdKN6i8Lk3LCYtXdjc+hi8SNl22nAg1?=
 =?us-ascii?Q?uq+O+EmSOuBccUl6NZ3ebOzSJlfjABXgRWTx82rb/mOLkt50k/mR3i/Mr+jO?=
 =?us-ascii?Q?PZ+3pflMfUXGUd0l5gZTDHKmhL9JkydcltzKVJWIVJhQvndbbANk0lekPdwk?=
 =?us-ascii?Q?zeNyhPcaWi3zcsYKAbzv5KPwwr8hAtLtdcrihkmCoduLoJYBZFoQOPqgkOs0?=
 =?us-ascii?Q?bDdimWestQKBH0qQYbmh7qUdOf00yElhFnEhkRhdaZ1a46NJOzUsGMrciGQ1?=
 =?us-ascii?Q?3LuEE8bcP4kXKcIuj32lHHgHy9oOQTjY9h2hIx7sLm1eWV4Xuvbsd6vJMVzg?=
 =?us-ascii?Q?nQrs7RjmzAtkxGm2YS0jcMbMsoC9TyR1WNmKMnkPABM9OfzCWjum4KOGU43V?=
 =?us-ascii?Q?Jnvakx6EaPIrhY4kFAVJlj/MPQuU7tlg/ALcv0sd9N6SbFjxu71dYKdPB8yb?=
 =?us-ascii?Q?/y2Vz5tQkA+iscJqa2bR0Nt2Ijv+slXHtQEaAUH5cSCiEe0W8SYygT+1tUCK?=
 =?us-ascii?Q?ciCJ9KrsaljdKTCrdE5rtC/tB+G2vPN2vpPDisU2NTReQ/mHvEK3VSep7/VK?=
 =?us-ascii?Q?MTrDvR+ddohGDia7k4+9xLzIRyT5p5rbY0bd+fQ6fQe+TN6RgSXzp4da5ut/?=
 =?us-ascii?Q?e9hbcP6uoCochr1SiT5p9a4wg2XEl0MqcQfyfeMeeNu4FZuXvzZe6IUZghDx?=
 =?us-ascii?Q?pmGZbCc9UL1ildfMns73T2ZinWkkibIkHbCbnKeUISjCP3FuegWyiSCPKcbz?=
 =?us-ascii?Q?tbjPz9jnUyvWtJSCXbeSGegUPdQYddU08tiN7j5n8vCiVE3hXhKEqljixJtF?=
 =?us-ascii?Q?P8xWKq8EBBv/7H6f8791lJL58I9R1H2BjuAsGvu4q/dTj8rwLGj8WQlkP+Cx?=
 =?us-ascii?Q?LspccjhmR58hv4C/r9nNfA61YR3SHipkkixDYywWpgriynkZsuQi25t9f8B5?=
 =?us-ascii?Q?xeltZ+mOUW2AAbuJJyiEznr4aJDzTXWZcO9DT06nJhqLOlhmLMFbZeORa56X?=
 =?us-ascii?Q?szdpKRfMOj1L4fH2+bziW4SsM0Vtk/nZT7idgjwmVmSUvXGuN6DgzIPo2eK1?=
 =?us-ascii?Q?kaqMbialIDDRtquHrbIl1Khxw9tJtU3CeznGAqXPz5V0KUNW/Tia5o43K3Cc?=
 =?us-ascii?Q?DLSLkiGyUcpEmsts43PvgpMkjGDqxXxb0g4VCTx6zn9gTb1N8n7c/lhRvp2U?=
 =?us-ascii?Q?FzlUPsliK2vI5dScEJuPYeX8hE6mcpt/SwcSYmU194kvMYe4Wl3KEsRs22IZ?=
 =?us-ascii?Q?1YPsxhOhtXS+Kvvxy3KA6OwcfY+n7Jwe4dPMU59H4NtB3ftlPKEt/EPzMUq+?=
 =?us-ascii?Q?SdyqyluxNh/OY5jdVMzyNZCop828ouLtYmbFga+/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee338747-3f59-42e1-4422-08dd0d343ca3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 09:33:36.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+2klOu0a+rVo3S1ZQHNUf9TCTxlGB44BQEOgE9mZqDunalYx2ADKT3+jxyZniqmGeuMNWKXppVJV+kmvQJMWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825

i.MX8qxp Display Controller pixel engine consists of all processing units
that operate in the AXI bus clock domain.  Command sequencer and interrupt
controller of the Display Controller work with AXI bus clock, but they are
not in pixel engine.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
* Collect Rob's R-b tag.

v3:
* No change.

v2:
* Drop fsl,dc-*-id DT properties from example. (Krzysztof)
* Fix register range sizes in example.

 .../imx/fsl,imx8qxp-dc-pixel-engine.yaml      | 250 ++++++++++++++++++
 1 file changed, 250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml
new file mode 100644
index 000000000000..633443a6cc38
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml
@@ -0,0 +1,250 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qxp Display Controller Pixel Engine
+
+description:
+  All Processing Units that operate in the AXI bus clock domain. Pixel
+  pipelines have the ability to stall when a destination is busy. Implements
+  all communication to memory resources and most of the image processing
+  functions. Interconnection of Processing Units is re-configurable.
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx8qxp-dc-pixel-engine
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^blit-engine@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-blit-engine
+
+  "^constframe@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-constframe
+
+  "^extdst@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-extdst
+
+  "^fetchdecode@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetchdecode
+
+  "^fetcheco@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetcheco
+
+  "^fetchlayer@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetchlayer
+
+  "^fetchwarp@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetchwarp
+
+  "^hscaler@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-hscaler
+
+  "^layerblend@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-layerblend
+
+  "^matrix@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-matrix
+
+  "^safety@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-safety
+
+  "^vscaler@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-vscaler
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+
+    pixel-engine@56180800 {
+        compatible = "fsl,imx8qxp-dc-pixel-engine";
+        reg = <0x56180800 0xac00>;
+        clocks = <&dc0_lpcg IMX_LPCG_CLK_5>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        constframe@56180960 {
+            compatible = "fsl,imx8qxp-dc-constframe";
+            reg = <0x56180960 0xc>, <0x56184400 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        extdst@56180980 {
+            compatible = "fsl,imx8qxp-dc-extdst";
+            reg = <0x56180980 0x1c>, <0x56184800 0x28>;
+            reg-names = "pec", "cfg";
+            interrupt-parent = <&dc0_intc>;
+            interrupts = <3>, <4>, <5>;
+            interrupt-names = "shdload", "framecomplete", "seqcomplete";
+        };
+
+        constframe@561809a0 {
+            compatible = "fsl,imx8qxp-dc-constframe";
+            reg = <0x561809a0 0xc>, <0x56184c00 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        extdst@561809c0 {
+            compatible = "fsl,imx8qxp-dc-extdst";
+            reg = <0x561809c0 0x1c>, <0x56185000 0x28>;
+            reg-names = "pec", "cfg";
+            interrupt-parent = <&dc0_intc>;
+            interrupts = <6>, <7>, <8>;
+            interrupt-names = "shdload", "framecomplete", "seqcomplete";
+        };
+
+        constframe@561809e0 {
+            compatible = "fsl,imx8qxp-dc-constframe";
+            reg = <0x561809e0 0xc>, <0x56185400 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        extdst@56180a00 {
+            compatible = "fsl,imx8qxp-dc-extdst";
+            reg = <0x56180a00 0x1c>, <0x56185800 0x28>;
+            reg-names = "pec", "cfg";
+            interrupt-parent = <&dc0_intc>;
+            interrupts = <9>, <10>, <11>;
+            interrupt-names = "shdload", "framecomplete", "seqcomplete";
+        };
+
+        constframe@56180a20 {
+            compatible = "fsl,imx8qxp-dc-constframe";
+            reg = <0x56180a20 0xc>, <0x56185c00 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        extdst@56180a40 {
+            compatible = "fsl,imx8qxp-dc-extdst";
+            reg = <0x56180a40 0x1c>, <0x56186000 0x28>;
+            reg-names = "pec", "cfg";
+            interrupt-parent = <&dc0_intc>;
+            interrupts = <12>, <13>, <14>;
+            interrupt-names = "shdload", "framecomplete", "seqcomplete";
+        };
+
+        fetchwarp@56180a60 {
+            compatible = "fsl,imx8qxp-dc-fetchwarp";
+            reg = <0x56180a60 0x10>, <0x56186400 0x190>;
+            reg-names = "pec", "cfg";
+        };
+
+        fetchlayer@56180ac0 {
+            compatible = "fsl,imx8qxp-dc-fetchlayer";
+            reg = <0x56180ac0 0xc>, <0x56188400 0x404>;
+            reg-names = "pec", "cfg";
+        };
+
+        layerblend@56180ba0 {
+            compatible = "fsl,imx8qxp-dc-layerblend";
+            reg = <0x56180ba0 0x10>, <0x5618a400 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        layerblend@56180bc0 {
+            compatible = "fsl,imx8qxp-dc-layerblend";
+            reg = <0x56180bc0 0x10>, <0x5618a800 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        layerblend@56180be0 {
+            compatible = "fsl,imx8qxp-dc-layerblend";
+            reg = <0x56180be0 0x10>, <0x5618ac00 0x20>;
+            reg-names = "pec", "cfg";
+        };
+
+        layerblend@56180c00 {
+            compatible = "fsl,imx8qxp-dc-layerblend";
+            reg = <0x56180c00 0x10>, <0x5618b000 0x20>;
+            reg-names = "pec", "cfg";
+        };
+    };
-- 
2.34.1



Return-Path: <linux-kernel+bounces-225117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C573912BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7591C24006
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E741662F0;
	Fri, 21 Jun 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dZHiRBcm"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2083.outbound.protection.outlook.com [40.107.15.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D2E15AACD;
	Fri, 21 Jun 2024 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989014; cv=fail; b=rZzKVVSj3S++NIlsJGHtpGNSy5tkTsrcwhbq82fYqRLNnTMqZo311YG8UjnetytBAJunq2UXvLrpUW3CHJ0l374XhM4VORaafgG/Q9sebO2GY3l5/pBV7/QGdGv/BXWkKXvwkmsg+WxhrN+wOPrHp8I9RXugxvBD0WJNA1C/BRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989014; c=relaxed/simple;
	bh=Z+/AE8dTiwIc2E4JvaENeCqYtxmXLa0AEvzNZpPoPD4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YmfaYIWcIcAK+ORhb1+NhKWChKQJup00u2sesduMDdM4pCFaVS+9HSd7wEAoWgEpT8s1vSzzORM7Te739Nooww1vGpKIneIRKfTwAJRAIuWT75hTR0Ku2psDPXLr+N4+Ykz+YyEpQPZHSS6/fn8LC3ekil5kr0NRnsHaXaDoUzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dZHiRBcm; arc=fail smtp.client-ip=40.107.15.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0BidYWeP5E8cT5DhffrUe1o/rq/XsLa9IRxeqLJ9POQwsEW69g7Gqf3IradrTo8ZiS2nlW3852BrcStJS1BnUInnYQxz6NyN3pjjeu4isqpqtW393OKG0fZqkMsgpw5HIYTwwa//xSQ7qwQ/FebN2YMMRQ0Oy7nKBUU42EymXDYBRDbDlYVs9Gqviz2K1v5vDWpYrdsEfQUbpJZsOKqGB6BDexznjtt1/g+fU8hPAeoCEI4Ff51SvhRRhPbfLH5kNm7abuFuourIqRORBMyKeDem2gTEKs8nJ1nvd2En1ME4MqpHk5gHHGb/IJngcd0TO+510+0Dli7COA6sRQbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMYsmY0fSCxB0avPYo9JTsfYPt9DlP/ON9eCfJS5rZE=;
 b=At9SYRDN2wmnyZcwuiE3XErGFIk2IpOK1Iie36qaI86ZO/d0ymhSQcvlmSoguKQWvARbGXG7NMLf0zkHgktBCNLMhFEAaD+RINZ78cK1yCQWRf6boJIvVtT4WXeRxyJt3d8f30klZ6vXTebLv9EmtuUIHvYygWjo67jJXSW2JAsp57PZWHD7eRJRYsnLUB+plBZva1aFmr67CaV3wpnj3XwJn604+tyqpdU6qovJcbVTLTEPStuG4r4ry3OofIVLLODHNsBa1P99evwdukArEIqjdhIzEvheLrLcVB5XtKSpGRqyY3maWJwAGnCnHbEQCpWKGgnnfuoWf67jLHAGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMYsmY0fSCxB0avPYo9JTsfYPt9DlP/ON9eCfJS5rZE=;
 b=dZHiRBcmVy9AR+OhFD4+LKk+iXFvtr7ZQfJ9rFberQoBwJsNqN4InEn7HvJypYPDDKMU3Ta3dPWW7RkCox7l6FOEcqgfvfXcJoZKLya/XquPd0Q7o+5Tuqeb3MI2X+E4AfzVq+z7yAioI7J+heeyC6ZzqRgvXFN3nZn30RIYMO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9884.eurprd04.prod.outlook.com (2603:10a6:800:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 16:56:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 16:56:49 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: nvmem: sfp: add child node unique-id
Date: Fri, 21 Jun 2024 12:56:37 -0400
Message-Id: <20240621165637.2283864-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:a03:54::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9884:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d84a8a-8dbc-407a-c862-08dc9213247e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZfE4VI39leZU6KrMhD/nVsdkDvqlP2dXxMGUNnU/c8t9EIC4mh0grcHQ4CHh?=
 =?us-ascii?Q?fl81amXd8ED3uemhk3HY+Nc8EeiMGkj/ClbidXhJG6F05Dm9adY6s7kZJmKx?=
 =?us-ascii?Q?f8emn3BYfgr40qzsLJtEocYKvynP98Bfp3PU2clBPsmI3BAfnMYm9uAWP1Ca?=
 =?us-ascii?Q?z6x+JAnzMiXjw5wqY2aKCc/kibi4MxWCBWogW7rE9CmTnqkDU74EVP21957I?=
 =?us-ascii?Q?Dk+s2ig5AeMwv3aAeGUWn33CFIKnWDtzigIQd9B/ykBOfDZsLR7uLtD8Zp4J?=
 =?us-ascii?Q?ENxeqEdd44ul7NESvG89fdxt9Fypb8t78VAmqHIDLEpMx57s5SKvZTidS8eZ?=
 =?us-ascii?Q?Rz2Ns+HToBBlb2XlONpfDgJ6iLPlAiVp6MOEnWE1iLgXSf3fnjGhBCIIaQCb?=
 =?us-ascii?Q?3rT+BLcEItDN8KlaHEV3hklItkFKHSIRwV560i7tsdtRLb0ZY76Elklzj3qa?=
 =?us-ascii?Q?eyHPlrk2N6ZMWuinYYrNKUSM5fljECB8DYscOWB1Zi/Y6+0n0Z1bUfI6AQDc?=
 =?us-ascii?Q?z8PpxD42Dm/yk8zBq/0ZIIleS8zamlKoPaqOapm19tnDNRntuL8l345264Jp?=
 =?us-ascii?Q?KXxiZMjM+lr3z52B1AGZpm+dbWQcu/DiWOTCqOwt5fgLwjiEEHIpXVucq4zt?=
 =?us-ascii?Q?+A9VV6qL1OZRTYvt7ffTxUaGoe3h9PTcdUgfNb+/sFgZC2qHe3FTTj9Rqzl7?=
 =?us-ascii?Q?mdcYrN0ToAgq2AmIbw0A68BDk0Ze1dmulzSZ2TcM421fw6NbwEqCadBXu1p3?=
 =?us-ascii?Q?QqH3CX1sK3Z14WMSK3F6P1jAFqtQpI9fWVDJzIUV8mmUQ8nNc9TBYv7JEzlj?=
 =?us-ascii?Q?qjBacwCrgGHumR6YlRf7bR0e6jWywpmaZ0Ac4qBYeQu+54y9F7FgCGSK8a5Y?=
 =?us-ascii?Q?b7XA/evck9fZTIj/XdQzqPRFNeYWEpSyBbXPqRXa2jAP177OofoFrC1NhOgj?=
 =?us-ascii?Q?DecgrO4GHnTFyySOiiPQws3mVwb7OvCBR8SnNdGtsMRExhXEjbIcb45Ahhlk?=
 =?us-ascii?Q?sTv82QzhkcXGHfsI/oNnpqhy7KFDWFmnGdYMJ8/1lvuJ84y8Ka+y+3i5UoD3?=
 =?us-ascii?Q?DLzr2MFyHaRtQ9/ZWIdC9qOfBZnWK3tS98bj7BmJyDYx/CtVRGIsYg3lje0D?=
 =?us-ascii?Q?CNJ0Q5nijqYtl9cufZGkG9eE8qNzu7xsmAbCa7vu5sgNJee0tLjMWoMUVZBi?=
 =?us-ascii?Q?UV10ML+Pys+H3EbNlMt0lPLcabv7Zsr7vQxXOvaf/TUtcOR/BpNMhRB30uS0?=
 =?us-ascii?Q?10oYlplpH266RWQq4l0CV4Tw2i0pl75Rp9ZmTmoXQBpZXhdihAWxldP0b15W?=
 =?us-ascii?Q?lqkuwhwGlIDlwZUsB22iI9cMDenKlvFY/hIk7artlyES206lDRB5NkONF6Uo?=
 =?us-ascii?Q?e0dpraM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gr0pMwDdgUBV+1N87cJdnm4q2YnsJixURjr3ohFFIrmjdm7ZU1Jr80koMUSu?=
 =?us-ascii?Q?6gyigNE9SsNs8not1yoIueLv1NriN388E02IWYzpmIIbYvvC+JwL3Ea6e3zf?=
 =?us-ascii?Q?lxSvknHaJetbdcQRKhB4jftpuUz2W+TATbuqcSraoLNnz8PHe27AXoMl2JgC?=
 =?us-ascii?Q?KW+fdvzZ+eIsIRkaY/KDJc1YZbRGiFLQxdVUrHp+FFhd/P/FbenSAUogSdWJ?=
 =?us-ascii?Q?vgUv5ySnLCluwDAVMhwepFnFZONnlGcOuy7G2ri91t1CkUlFHYDoPzSTpvZV?=
 =?us-ascii?Q?TaygrleVWu2cysJnTZrRNGzfIH2/6WvF55nB4FPgXvwLl6V0gjxIbC7HDb48?=
 =?us-ascii?Q?0hBGHHuhjN9xhtOJDREA/3nKNtxWeny/AZhlfGkXfqmVT+6sVTPDhy709Cgd?=
 =?us-ascii?Q?CiPzJ+g9sQX4AH69pYlPB00UsvdZuHsTma9QFIzcShID105aS6RUNxHxRZAR?=
 =?us-ascii?Q?ZyXOHWvj3xxMZEq/tRx4vYgEAHtuLiEZIMmFTT9Eco+1gCPtCWhgOV6beZmo?=
 =?us-ascii?Q?toPeK/3Ua/+Fn4Dzkt6SFgQWEwN2M0cp2z4lwTDRznuA3nrSLRYqjpjjWPyR?=
 =?us-ascii?Q?pdjskBlFT+8vqyrCMWGgD0YB6RtWk0X1N1xEsdzah5b02bszdks7gLEVc4fF?=
 =?us-ascii?Q?6WIbERWfs+08jL94YE0tek+Qg7Hj/UxmDOgoyoeLGaAf9mGH2//kwZxLgEhc?=
 =?us-ascii?Q?8FZtfjDPbYCqUw9bdRV/4DyFtRA9m15UU+kz9zNY4wNd9y630TROQM3hosBq?=
 =?us-ascii?Q?gPmSzSlzvN3j4/V5H8GcFzxBYebBmhf1px1+HuefgHNoCYAiZa0DyfY0wHLv?=
 =?us-ascii?Q?0wrxP9qv0eQjws1c5gkHouOahI1NCMzI2aAbT4sKAh6Uj0GoiynkRUAsCneK?=
 =?us-ascii?Q?aMlD1C88sWxuO9xJeQz2pfSPRuOtuZstbHYVsT4Mvb+df20y3UaYUCeDCScL?=
 =?us-ascii?Q?SA0e486oiHvIoJAAduW9u2Lm8bGRxEM7El8hx3cBfv8y+D9kPjq8lk/b3ou1?=
 =?us-ascii?Q?1QasuD0nhb/KHonqyYeMvb6hF8R60OaTkI4RsucBPtQLRpBQGrezxuPVxnJQ?=
 =?us-ascii?Q?6LRk5ZslgaiwHRKhNa9EQxsZ8bmhIluXnkPkJxEvzhzg4uAMMmfvsxCoCWk6?=
 =?us-ascii?Q?dZazQ3CtAbrb8SWC0CMwAi9vvG+z5cVElGVLgWOJiYa6B8IGHQ5SsNM9EnVm?=
 =?us-ascii?Q?NLoVUoBpFA4/llJ6Jn2mXgbBeLj7p08pNiaq01xzP2orVCGOFmXrDF9oaIQ2?=
 =?us-ascii?Q?T8qjGOxqVwdph3oNMCXw3DMU6eKqW6tgvOpj/cGbDTLVIWqA3dL8YHfY/Es/?=
 =?us-ascii?Q?Y0l+JRc8gEzZx0nj1JM4Tz7vlfOauT4Em0mImXCHVfWU1Q4EJYW6uF9xr1MU?=
 =?us-ascii?Q?6wS0a6jbV1/DBLNuKkar7uM9Yo0FPLGOiDcBVFYutq/Tf/LvXbWpPKrPlFe0?=
 =?us-ascii?Q?S7nhBTSu3M9xCRe1P9EBDJgNwSm0BFHudrzp0I3bkLRu0meK3NiEHRZNQn9K?=
 =?us-ascii?Q?4LPdpwXhKFRSVoxaTVFTqePeXJR1vaHaGayr734kfHxR/Yt0ACv70SA6wrim?=
 =?us-ascii?Q?FSzm6H8r8GqIwkbABmI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d84a8a-8dbc-407a-c862-08dc9213247e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:56:49.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wIHhjhuji3K2T5o4x1nJar13K55stb/1T+6zst81BZ3QgrH87JX53eZJ3n/0FnPvA4Oag9x0LH4iEJ7/PBMLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9884

Add child node unique-id to fix below CHECK_DTBS warning.
efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/nvmem/fsl,layerscape-sfp.yaml      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index 70fb2ad251037..8c0bdaab711a7 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -42,6 +42,23 @@ properties:
       The regulator for the TA_PROG_SFP pin. It will be enabled for programming
       and disabled for reading.
 
+patternProperties:
+  '^unique-id@[0-9a-f]*$':
+    type: object
+    description:
+      Chip unique id.
+
+    properties:
+      reg:
+        description:
+          Byte offset where the unique id is stored
+        maxItems: 1
+
+    required:
+      - reg
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
-- 
2.34.1



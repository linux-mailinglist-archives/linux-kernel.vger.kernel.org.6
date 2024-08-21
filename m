Return-Path: <linux-kernel+bounces-296096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654A295A58C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149FE281571
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF52416F0F0;
	Wed, 21 Aug 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z8TzT3kq"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975A137745;
	Wed, 21 Aug 2024 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270081; cv=fail; b=ddW4QulwYeIA7EOucqMjLZUlhU/EMsjqNKGDRYOGwFU2drIHzsu338hpHvNrZdhOUPM9w89mzRLN9BEOmjcONgsLXH1Q/6al2UVwRcexEGVMlbSqV8KKoiqfefbXcgjUr25Qz5kJ5aU6S7GAu24EP8RyLy+9Q8R7Wx4MTHpQJWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270081; c=relaxed/simple;
	bh=YNWUNbEqQP/+d1xIm+T7JYlhMpkMyZKGlYjFFsOW6nI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XZn4gydTwBS4qHnKnoHH+QcIEUCdQGwA2yWA3rrHnPaYIfXa3JrfLF1i59O2X2qx+JtVu1bgxmkU8JNWJYGAOlglgkQ8Ekuu1tp5ikVIyM34/Jz21tf4CRTlHYo6vZRL3hsur28uHnyEF53MkjFrFQCQbJO0iDTNhC+n0QQCXVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z8TzT3kq; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUwCBdx+7jTq4VkpOOxTFmfueT7YuXJ0wUS1J8WrsElj4hJWT86javvI3aTM8/F5O9oBPBkcmyimpNXOJyqxMJx7e6i0AtoFF3qOqImGI58TKMkV9Bn74wAA1g0clKk73D6x61i79ITupLGkSR9XLiMZoNHQDGsSsBl5yY1UcpLMukW2Mgs+uuuKkmpXashyOxEHlTgg171vUCC6ht7BsPf/L9/3mKVojFDH2to1eAja+B4U477JPKsuTB+U1Sk0cDyTWRznV16CLi1Mcd+qdENFeMPZOYiT1beDCJRzMaX+kbtuMeubFkXXbZ2kUgNP8fI+k0Zd5aKPfPIgSAk3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXPu4iuoyvubmSQ0rIDKVrEZR5ROy2M4fK6tAy8BsiA=;
 b=tZWSG0fMO8ERNEJORwMSC+nXLX067Gqi9lrki047qfM2EKuoFdli3FEsDlquAneY4MvXz42ktuYqRiqvPCqydYWB8qBMfMSJBGcbsoSInmPDz1slvMMCsYXnxKdKhYTnrmvmGxqcbVCdtfKTxIIS6wSoTFGkVxuZb19TezQT2o0+OzH/8AlMZ5/70yFFxsJsQjR1tEY9u8B8NqUSpwBgI5E9O2g5ftxsEbjmZB/j8QkkX2zYhsoMxwWxcvs6GA0opkVr/DyHaveS1CpEvydQBiubk6c/uimehLFzuQMU3tn2z6uj49s4HDap7+Rmv25gVtxyQuhtd+icAEAM37Ftew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXPu4iuoyvubmSQ0rIDKVrEZR5ROy2M4fK6tAy8BsiA=;
 b=Z8TzT3kqWzYcwCHlnB03UVxtYSqCBeMiZmqaTHZ6XplLbc5WGCOpAOVdW/o21nnUxSlC1lpLL42Nn6W2f+wDvkxqyjTU8AQHe6WA0CMosi+/QFEylZEJXBovMyQuEcxgpcYg7Qso3tfPslq90QAv4SpSavq2IUcpbj/GIFoQ7Jt6/GI9wv+DsCV9uywwkg+834ISCMxvZ8A1XEanzoUtKoaPSMG/P2AQSWxe4A2ymr4TN8dYapC6Pf+s3lF+UItWEsU/AU4EyZNyalD9ZdOjS/APeLfRRZePLYJYFJJRIcEUg0h3K/ktGuG8uYg9k5a0U2z6ICawPJE3Qa+JnYeTCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10320.eurprd04.prod.outlook.com (2603:10a6:800:21a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 19:54:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 19:54:35 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: nvmem: sfp: add ref to nvmem-deprecated-cells.yaml
Date: Wed, 21 Aug 2024 15:54:19 -0400
Message-Id: <20240821195419.581889-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10320:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b049ff-6de7-4c7c-c6ca-08dcc21b14f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?74nXzdE8tIqFic9iSyvMWvmTig78wdNF537C1QfZojbQn7gxGr54BhPv6OSs?=
 =?us-ascii?Q?NDi4cogm+GaMbrfOW6OQJhMOoVlKt7sd6mH4nn2LdOvLne5lgLqR8knnbBZh?=
 =?us-ascii?Q?5XPk4mttDxc+XggA+U4DSartakA8YhA5oHD7RqmsC7Ljnz52WMXqbrZUwV7c?=
 =?us-ascii?Q?7nfIc5r8zNscvKJn3TFsoMEk0CuXRoCvDizyExQQ1jdXUxxiyFwQdfbMPYpd?=
 =?us-ascii?Q?hLXwdoPToLIbX0RTsTs7rZAX0W3oMSAmoeGa0ryLbX5fzvHVy1g7us6s4ojF?=
 =?us-ascii?Q?UAZJdFqeCFVz7LNkS48ayRy24R1YLCU3jjQmQpoF0+PjcQHLQOFH10hbz565?=
 =?us-ascii?Q?Xe+p0GPYoMqzpp8lktHstC+C5G0mFcpFMv6omAw/za8levQ1fyY+ETi9dk2t?=
 =?us-ascii?Q?/la3gFqYqSSKmsDTg8OBZMNp1y9Ta9KSBKSA+/kEErxScRZmV03/4tSfS5yW?=
 =?us-ascii?Q?qUaF45w2oltTqn6UInB60VXIr4w3cE6HpBl3OQoaaysE04Xnt7KxYkNYHoGe?=
 =?us-ascii?Q?LM2sfPgLOtzGV62BlEyPbmzbdIkZqzdKOMemTWEgxkoa+14o9D4hUJ5u0vJY?=
 =?us-ascii?Q?DI1Spwllreq9TopiFlIXHOJbPYLH7RBRSm/8KDDwAsK3AmbidXRF6ImDfM/P?=
 =?us-ascii?Q?kpM4Ysy/88Ksws7DdDPRQVHXXnw+1BK3cGA/KxwHRFdZPw5b5+uZNN2daf2e?=
 =?us-ascii?Q?m/1R3nch1TI4VU52ZVuJTjJExj/StqWDsAmc6hkGXnfmhraha1wn9bu37EHe?=
 =?us-ascii?Q?DdiuOzOtVisd2ieWnrtMU+a4iQmJ3R+S1KTi2Vj1EPeSPWByAcnySWe4nZOe?=
 =?us-ascii?Q?TST/0ken0QjbWikFzHL2LwiYnbK0Is0IYP0/FfqyaCzV3K/UjaZlpcTD0Dpv?=
 =?us-ascii?Q?ywrjePBFgTPo64ECZUsuo8f1dZig+zgMkO3460fAO1xIBf4s/Wi9q2CyWZtb?=
 =?us-ascii?Q?qzHHNHaW+VP036/tXM8uoPJdstLJPExbuV/XCGG9Y97rh5Wu7H4EmAZaN6vm?=
 =?us-ascii?Q?lh3xSiR2UKr8Mcg4WU1j4Cx5x8K+TSZo87F8YIgmbqAr8IzK54y5WGtRyXvf?=
 =?us-ascii?Q?ICnQ4da5DTFjy2JQyT6pyqGFEsllao+NOkDNFOqMM3lZJfIu5MqTxy8pm84E?=
 =?us-ascii?Q?4+3ZGf8Ve23cj1wfdM5h3O+a15rwNtHE2K8csmyYRXfHSWac024mT6DmmVaU?=
 =?us-ascii?Q?IARIPp0TirE3bmt4bJNZJxSkgk4PNoHkV2DNmpgN2+ZlfCyq03GLE5+Fj+5u?=
 =?us-ascii?Q?lAdoJ0nMAzHrydFAao1/FH/mMZJGLcnKqsC8gHNhDpai+DIxkucFlO1JBt5G?=
 =?us-ascii?Q?JTVA0xbMbOUkWy+lGjM+Z93+RpmnT9m8M5LxICRtTitKqDwo8amW5pOMPQ7t?=
 =?us-ascii?Q?GA7JMvtKjPzFmHdLqKQWm5Nrzz7/pxcCfNACH/7lcrRJhUAqPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tiEyiUvfW3tKqG/DSui1j8nmZpiV5LOU7HaspzN0Y+GkiDsAuLrKlbRoMznj?=
 =?us-ascii?Q?4pdodDTCe5ydpVQUuSpMthhU40GaX/+2zUvfxsi7D+0k8z4BqdIRRwxJjBzP?=
 =?us-ascii?Q?YFghmH6NBKFO0BYiFKwFlWqlYWxbH1P7sPyriw503hW1Oa5KRebz47bmYqBz?=
 =?us-ascii?Q?yuG1oKejtbqFyCJTRpRs/9FRKathyM+dnq4g/aprUREGhb4yy2XVBW++cITv?=
 =?us-ascii?Q?dpfHMmohMbBxivUZPeD4PtvNukd+pKbCeS/GmV+SicaXOU7DuP0BjnCA0EeR?=
 =?us-ascii?Q?LwFwFbwlq70TBHLeBi2BEdVn6BTrCJZ8rMBp+7YXCkQfa8BbUhXcFT/27yee?=
 =?us-ascii?Q?wjYpc+3NakdEqW1QIHlUATVnDVo5Bd01lq+KHysjgEn359dBWl20w0ylTxOD?=
 =?us-ascii?Q?krdMlphocrV84IACtz3pwWYgE7FHgDvT9usm0iRe2BRooNi0ffxvfdxT4/rU?=
 =?us-ascii?Q?UofDTCecbbjgT631S/clUi6Gz1+Ef+3+KK+MyIVI8XGR1uidQ+Y2pkg6uiq1?=
 =?us-ascii?Q?WALAQlGSp6VKOUPlmYRxX3zyD/+bigrkHJU0QARSvhSsrd5B4DiTyIteTlSS?=
 =?us-ascii?Q?9zej79uiMEgXXaLYWL79HuWmPPn6zviehszYLoNIz4BE7BJ4nCMio6uLXcGP?=
 =?us-ascii?Q?IWLx1XLqbFgqX3DzjCYmSUhX1iEvZUHhCjPfA/KpHaTuoG3g12l860br3dOg?=
 =?us-ascii?Q?U4X2oi7o82mpVPmeTCTW8YG1BTSQ/sRXRIFNKwJleVpe9zDpxW+RDw5cxc/Y?=
 =?us-ascii?Q?QNeuAwJPLXmFqaV7bw0Y8rNKiTcBQJlNjBhcnq/HIY6C1cSepUNrpUMcZRPM?=
 =?us-ascii?Q?xCVEutqFCXb6854bM5dx8aMOYgKEexDEDVGqULZ9mdkzozFPXZ1gmBYiHR4H?=
 =?us-ascii?Q?6DwmpKdBc8LPF7c+1jxC2tPOV2VLkh8M40FrnVb1KFKgKwgUOEqE813GIYgH?=
 =?us-ascii?Q?k/n1cY6OOjO9Gi4nflLfGxS6h2K4/K6YIzBrCAmSJo3jW96BRRmzr+yF2C36?=
 =?us-ascii?Q?Bg710z6iJ89MTXGuT1sPPBK9oGhyQ/XahFJam/o1eLz+hK1IP1+NsOvuum6y?=
 =?us-ascii?Q?kl6H0M76Rs6lom6CAeYeXMdiujDVIXavhDlrAFjTgiJ1SzNW3BdXNxmkB7LI?=
 =?us-ascii?Q?NREIcC1Io8UjpK78sJPHmqbbsWnEEBTFdzUvGw1dft4IAVN89GRe69mhQ+d4?=
 =?us-ascii?Q?9thv1mwihc7x2p8yr8uzJs+r387rHkkc3jvK9gpvxS5CR4HTFut3OcLsKHma?=
 =?us-ascii?Q?BhvkBQTFomztzuz1Iu4CZ0LOvIOjvT1ShVX584KEaJV95rkXWwCqVZYYXz/b?=
 =?us-ascii?Q?obKmoHcT/+EIi2P9bnf3urOZRCehzYDlhsPH4UyNJ9oQ3TXL+VS4gRhggmDa?=
 =?us-ascii?Q?6SVOcKpSGdLASgI0vZ8duHsZyMmms8+N6SwWbFFf9k3hsneIRT0xgI2U4TeP?=
 =?us-ascii?Q?y2ypmvgrgsuMT0nTWq+I9jFa4Y1wNf2KO71X/j9p17/rGwW8msw9ThO5ayxM?=
 =?us-ascii?Q?4L/gbkhs3fRcA2DEwwp8NuJZHZC8cEXP3bmDzDGOjCXB2H0t0oqTpS1e8/ib?=
 =?us-ascii?Q?zLC/fPAmuIVWIlcE3fvCOKG2q0Zeysuw8jRhAlXb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b049ff-6de7-4c7c-c6ca-08dcc21b14f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 19:54:35.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Xa0u1eUNMhjezTTEr9GTq0xN5AiZb79/FGvuxu8rFgOfUgTbeq4qQvJnPvldc6yVj170XQmN++os0TOYpfQig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10320

Add ref nvmem-deprecated-cells.yaml to support old style binding.

Fix below CHECK_DTBS warning.
efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- ref to nvmem-deprecated-cells.yaml
v1: https://lore.kernel.org/imx/20240621165637.2283864-1-Frank.Li@nxp.com/
---
 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index 70fb2ad251037..1b20b49eee792 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -15,6 +15,7 @@ description: |
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml
 
 properties:
   compatible:
-- 
2.34.1



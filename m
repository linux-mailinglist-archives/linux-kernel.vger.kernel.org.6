Return-Path: <linux-kernel+bounces-233282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0991B52E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CFB283D30
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8081CAA2;
	Fri, 28 Jun 2024 02:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jIXz9Uq+"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADEAFBEA;
	Fri, 28 Jun 2024 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719543261; cv=fail; b=YtAqMzLFAQsVznRSLwwrrY1mMDW3YbbMypGVKpRlWNuIbW07pzsEdJUuJcPTohgtw6VUsVkCuWFzTphIDKBai92lgYKcUS9w6+ZqzQbx7NowCDn6xReXfUVHlxov059kvWTJnB2YTiEopCEjWomZADCaA4wSmn94N8TOAuQ4vA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719543261; c=relaxed/simple;
	bh=8/15Si8pwemn36wC1W1RjiQydivnkipRg12o4w7HrHI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KjTaZrasL3ugdh0KrohvTdzk9s8uYj7fZ3l3meuf+lCaF9hOMqKUtB17tpi3xfsr/jTkpAqI7Gx8xUCX08ivRt5/2nP6ugDGOyOUK+RgC2F7cxPBWigD/ylv7piiwK9Ilwj967cADO6FvDK6BiBpVcKTmDND2bOXyWBQHlyadC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jIXz9Uq+; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQvwrXncmRxUdl7BhZufJzeHliZs473lHGqrSd9anT/ucL3g2hNcsHADOna4hvb9ozFTZ8aRhZ3LrENBQvwW0tziGBvYHYPTlrLS92dkZeExsCHAySVXsJOCA4JmrKO6yuDuTb1Gs5CjtzwCIbgqYu6627G0MBspfUMEG/wc/ibDXLDlem4Xs5+2IWc36gfuG22FRkVgjEQGDTw+F9LyxvNvr+uDMcYDhQPY3QgJlamdr72xfWKfuoqgcAy8D+injr309xjt/r99hxS4Qhp1qJoSGPG5M0XlV6Gq+abGy/hKE3+A61EzHrpCP6aj8eXpi0bGJoSailMazESzC2Dlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KZsKeciv5xpE3sq4kTqRJTP0CKZAuvHGGGSo0d0/Y0=;
 b=a/0SLMfU/Xs38pOeLTB8dlTlf93SBrMayomOWLXT/STp18HN8daMzd1DKE9SNFv+F2bsR+cMHwFNkOPPOn/3bI/zpdt3vB9elOuF31JRNKcmcgVbDkqKzEwy9EBETrSaZdeA+uyvEtPf2DXuXRNG3KZpVjDtUpQbwZBykxCb2HdRfngDQJx4Jp3YyEsrBc1C0h8Y74dBaXaKsZRtjmz6UpaQhWHXL4F993ob8Pu9VS1VaH3oufs2SOVwdXLj68+Z4wT0uuF+Upf/Gi872u+Ky8zAJEtuQxwvGaRhjUY8MEoXtT7gKBHT3vVNZVH43vUzXAdVqdWiHa8dvJ+cq+sFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KZsKeciv5xpE3sq4kTqRJTP0CKZAuvHGGGSo0d0/Y0=;
 b=jIXz9Uq+ta+yNcdsXhiId/dIb9gVO0eBF+Y42A9FP54OKteV2xydTcYj6STdTQyIHcjcRwn1HeHoWijq2S9jOcUaWSIEsR1lei9Rvvzk08ghaGdtQmGG7lkETla7AUFAXk7ebEVgQKg1GUxnd1mo+32Heu+EcBFlzCVlQFMJD1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AM9PR04MB8129.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25; Fri, 28 Jun
 2024 02:54:16 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 02:54:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support system power protocol
Date: Fri, 28 Jun 2024 11:03:09 +0800
Message-Id: <20240628030309.1162012-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|AM9PR04MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 47878b49-3a77-4262-281f-08dc971d97fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hg5xWlurL9LXDAAtXnFmbG8U3qTbJn7ikfjM5xykse8wTIBb+eqCmN6hr1rD?=
 =?us-ascii?Q?vO8nN+1NkNVoDKONWG1SWGe6AiAsOcDJ4sfRhRdhm0rtrI6NAljw2QFszSdI?=
 =?us-ascii?Q?WrMrBPo4iFfMG+nZBRzEGWlkafEbofgOtr0/SNCbe+8OCNheORntGEKfKRrp?=
 =?us-ascii?Q?UShkE7uKb9JBCz2DVlpewT6RDOl2usbbRxOEtFusxWWPlhWhvNtCYvTZTj0V?=
 =?us-ascii?Q?/oOocGiXXs6l0mg+MG2ckQTG7WSCzS3OVHwjit9Er+yfULOyv+Zc4AvPFF1q?=
 =?us-ascii?Q?pF5PTR0FmfJHe3IvxDVEcKop1PrPHKZOZA1YKq1F3ZnhIHOp9N91n2VtEtTA?=
 =?us-ascii?Q?264OWSOKdahZ7QrboViuJXts1ZCMaZ11uaCurMN+LYw+yswaGu9KVCVdzliL?=
 =?us-ascii?Q?2ir/FCd+YnoJcyqweo6fDhY4IE4drOvCN0f3lWTjpKP84OLLngaYpTYubYpE?=
 =?us-ascii?Q?BBDNxpwWbRusvNBjCsGth703EnLk0MFprXfaEe1iFjXVu5MNj45IE8mKq3XK?=
 =?us-ascii?Q?aSGNN9nXHeCbLIcTkOzCik7Tc9NVU0hiJLwhrXwRNgHIdzs302gPpNnh5Am6?=
 =?us-ascii?Q?mYuoo35W61o8uc8li4/IWR9hcY91nZKEEHxVhw7Yd8QWbuC/j67eV4/aJkHF?=
 =?us-ascii?Q?LKqkq/e6nGE1ZcwH2jXW1vko7Gp/JtpDzTj6YpxKQW6YXifSFcuEGcDpgkDe?=
 =?us-ascii?Q?CZxzF7CLSU/zagvv7zu9feRvXsL0jOfFLiCdHU0jts68GdQEyG49AQVou8qZ?=
 =?us-ascii?Q?a8hASVSd4g15NHobe+TqAkmnN08fmi+pHrrBsLrouKZMrcFuEenaOA5hj2xf?=
 =?us-ascii?Q?ha3uNyH6Fat3Yn2txXD5lb/+wa6ECo5QdcxjMSXiWpQXbqjAqODDQozN5UYl?=
 =?us-ascii?Q?VvWE+IdzmmriHIDSm70NfVUKgLs00k71zvQRqgTAXq+EJH2EEzcwf+Uosdnj?=
 =?us-ascii?Q?f4Sxc+c4bGrdMnJMIuFxI96dZsbEdWRWzwzrvFesT5ebby+m2vm1XmOr1Rcy?=
 =?us-ascii?Q?DCPJrXv/GGD5YuSzVwkhjS6SKwgNHSDScqpFqTpyFphSiNUwTuX/jNC7PDGO?=
 =?us-ascii?Q?pt+2DLhA77YS/xRKh+Oh8hU4uLU+vhQqKdJj4fkmEyQUsZ+kAcRB7ss0ZW38?=
 =?us-ascii?Q?A5OrFIHuNvXiagQesv+r/iGyuyMqVYZ1qSAWi1umtOEEme5t9OFStpn8Dd9E?=
 =?us-ascii?Q?9p2SvH82xbXDdSTygSLCn6xOcrmk6CpPJcem8vw48h1aVKbOmMHqyxn0a/pL?=
 =?us-ascii?Q?Mm3jFHGWYCd87zl0+VmdJ/yaSI8rMe0VqN1UrxxQN9lErpBT5fM1vhqsBf2I?=
 =?us-ascii?Q?7U6CvF3Ht5JbsnY3dc+lCYqJgS2xa52FR6nSLDJcZ9Dz5hPNvDk+IWFH1cYr?=
 =?us-ascii?Q?LxNMnSENOpn2paWS1+4AWnipgGdv2hBqP8G7xN1+1jaYxUT67w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G9flGG1bNcuc+NuYE8XbqfuBnhrpWB2g4u7f7yNpo0uWLUXJVq3hZJJhLPYc?=
 =?us-ascii?Q?Kxi1Yn6l2pWFicQhE72MAqHLLazX3g1xkmj5noLKHUDwlOc2FakBOv9HdXLu?=
 =?us-ascii?Q?hswwCfcBNamvURW/Zq6FhWb3MdrwNURITrzfIayOILYV0koO3n0OvHYLrGMn?=
 =?us-ascii?Q?GGsg4Qi6Z+kwenebklFpwuBrQc0OU0ON5wu5j3SdQXaB0Mkjg6qx/YcMp2Q6?=
 =?us-ascii?Q?TSPwh3cVcF8l8Cy2z3w+bwHDsPNvcC57bbUsbRUwAXH9PBj7XZbKbjnlb2pX?=
 =?us-ascii?Q?5zpCAxwjoNi4PQYM8BjkGjLijr8DBzEtWfRXsw0Lp6I3poMwGbeLrSR+ULsI?=
 =?us-ascii?Q?afQ+utfU4lkwhMLSuib5rR24+/cEb+YL9Uv3HqI7zcMpz0gpTPc75SzdfY19?=
 =?us-ascii?Q?ituxhBS3wPJew1FRsy3eRWOjYgBeSdHZOZqfZJi784CmHOfUC9EOgBz3JYfG?=
 =?us-ascii?Q?yhi4Y1aE0CRpEwrecagaGr8QxucL8IXuspnrZn1oeNIIh2q49JWIWv7ZsMls?=
 =?us-ascii?Q?CSzt6DwNJ/K3UnN+LOFQQEc71Exd2eVl5VOOBw7PCRWzlhjMuOxOGsDwGOYo?=
 =?us-ascii?Q?M15ODfWCa9sjMF+HTPxun1zGdniHEC1LAmBCwSqoJ42j4DJKAY38fk9/MQRH?=
 =?us-ascii?Q?p2s4fLv2vWKFMkw/hirH1gvbtcOmYHHDm4FiQ8Bl8d7HyOjoYCUwmIG2kAzT?=
 =?us-ascii?Q?//HOA6Y0dlFG/v0f9CVYk3vSBjd49tEzv3A07Gtm2ecR5bxWnudz6g9afDmL?=
 =?us-ascii?Q?Ekb8ALW5Fw0+kHjNAJSEOpwq7BmNZgCZzgFsv5Y+JHfRgvnEIdQYtUvthgtW?=
 =?us-ascii?Q?JAJB15f53zV+iDYKHPXb8NvFyr8SS1D4qLEkqr9WkB80lkesittWFCM5jvyF?=
 =?us-ascii?Q?wb/uMjMAutOnJKL8CXDxgiJiArp9TcwIQNeRN1INa7CjWvb7Xy7C6JWAkhjL?=
 =?us-ascii?Q?pFzbOwI2zLvyc+ciXUUChphUqVpoJ00VRH9wopB+SDOkO/Nr5mpa1apaNx6/?=
 =?us-ascii?Q?20v+iabEp379o/inz12DEhJDfiU87z0ldM+klSVd3MijgLjRnXpptaZaSjxR?=
 =?us-ascii?Q?w14IALCckg47p9nZth94ulqMzK98v5lVfXFDtE1+wlZfkvdl67uYKxn71Jhl?=
 =?us-ascii?Q?8oqeDP8l2FfbLJ53dM+wAnUpsnK0KYLA0BDpyaeN9XVQ/eKrS5+++pajXWP4?=
 =?us-ascii?Q?VQD1ytIKD6HgpOP1tbiTZw0mgZRLyPXNrKPhql5+IrzYsdOfr/+ej6acJ2m9?=
 =?us-ascii?Q?VEFUhVCE/4Lmd9PFiqd/NycwdJP+KtokxG8y31wqRPUOg8H3A8tSaA/O74aF?=
 =?us-ascii?Q?K+gthH6mM0lxvda7pRdR1ANkxC/CHsZNSTELj2G5IhsNWJzyF11f5YvopnZe?=
 =?us-ascii?Q?I9eGw8KzrWwvc8bJ3JrCTH+sUnUuB/23kmerre/D/4cubU5SZ3h+1GlMzwF7?=
 =?us-ascii?Q?wjOOSswADpgTcefPfYx8+iRfyPViRw7O88aKGbgZsvKuxyK8fONtvW4+r1nE?=
 =?us-ascii?Q?WWJ5TQJKw355h9UCJvKNmvNh3XlK8/httbzwkNPzyg0undJzsXrTPSI8jN7v?=
 =?us-ascii?Q?51xKeVH3IjN6XSzGmt6pk8uSYk30T1B5Qp/DKou6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47878b49-3a77-4262-281f-08dc971d97fd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 02:54:16.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7dI9eSAQvsQrso0IGmaWm1k1jwdgxb0ToJ/IKljrK68oy1pmdLXI/Tp45MQiT4ug9Yx8pGwHnhvKBiJDk1jlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8129

From: Peng Fan <peng.fan@nxp.com>

Add SCMI System Power Protocol bindings, and the protocol id is 0x12.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 4d823f3b1f0e..ebf384e76df1 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -145,6 +145,14 @@ properties:
     required:
       - '#power-domain-cells'
 
+  protocol@12:
+    $ref: '#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x12
+
   protocol@13:
     $ref: '#/$defs/protocol-node'
     unevaluatedProperties: false
-- 
2.37.1



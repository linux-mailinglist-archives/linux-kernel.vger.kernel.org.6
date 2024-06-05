Return-Path: <linux-kernel+bounces-202128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CF58FC81D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B1EFB261AE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7018FDC3;
	Wed,  5 Jun 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vm7/XYDB"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F218C34B;
	Wed,  5 Jun 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580359; cv=fail; b=DEWw/5DsXs4B58OFCtHLgZgw7uaP3ecqdWpBbISnGt+veg3BiafDUZcFm+LuePQdAsp+FX+yW75v/HRffEd79wWkQKwZXpU418N+sJWaHKRPtt78fuY4HOYoCibRNwpC4/HeTwNQgJ7kyIC9bAb83eCgJyv5wzqdvwzd/Ghsz0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580359; c=relaxed/simple;
	bh=DLwxT2pRUSsZEQbM/T7TvxHZuDNf89dgCEyrvuuXLEA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D2B9Pb/DFzTRemZTrHKsA5dJQsTDYOoCaQVsoEsJnLyE5gApt3ajh4hIOT2Y1bxTrHWfVy7zx61wmkDOvKDFU37yux4BBGGi46g4ccINUTqRoTmMC3P12DUZOSof3LB2EKePsqoVOnAdfHzj3SF4yuPMebvN32SrKvdG+iE08VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Vm7/XYDB; arc=fail smtp.client-ip=40.107.6.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWFQNOnGpSGAVbJnqn8V4DR0q65DqxZlXUA8izh+aejf6ubeelWwUblR+R4332NnxbINZ+VPpbojx7pePb/l+5WfF0hbImldu5y2xu7oAU/wR4dtRqtTltfDfnGtwnvgNi8vpKYUehqW919nslrtR/n/qmAWD4ooePiNFTxaC9dVQQYJXoXqVqQyPPMO6cHIZ5Qr3ygPIZX+kUID3q3/TZij5HfiqX27i/qOD/+bVHA36C5tmUiK11p37yaMsGsV+OJItKNsfKdotIJefYtREMtBlNCyG8Ed8v0M/uLiV5meY2AkTUhUtEYfU25yLVI87BiqQ1jdMMPmbuiujnx++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emrWWXRdrMwTagjAgdl0gdJwScmGG4NPaFtdOuh6l/A=;
 b=OTOl8bJ88IZWgvZoob9DG5Gxd46zFCliOyFCKgM1SaiqD4FRtATRlZmLONHUceJc1iKUCQ62DP4N5VwESo5CI/ESZEnOK0ZNlHy+70qv2wD2xyjSrIcYdC4HSna56QFKS9qxmKnanGSMF9tgv77tUQCsQPyYfDpPmDScTlnQPxblmB6qIwPCuBWlr9y9AtxXhPqTOaM3f9JQ2t34JvRRN4+QQ++GCSL/m0H6n4y3+coB1mPX3kmQKGjObX9KSrwxAEyk1kpVAYP0qXQKbuYR27hY7r3myiOMg37SKpZCTOwWLcQnKBeqf2B9xE62P6h5V5htSLEGMmyAbJPZEqzRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emrWWXRdrMwTagjAgdl0gdJwScmGG4NPaFtdOuh6l/A=;
 b=Vm7/XYDBgzSP9P4KRC+lOaNORaZCQ/cgCv8ntY5pWFED7sG6odoy7oU6iyYtCY/IBgacQUuu1NXfS3fv23vCn3UlEMRMH7gunQHiAOGGHCGS7wdJUUsASLd4tXEJEk/fjyjZlFHA6j50o9u31ms72qcGzvqwk7Wkwxw7lQAP3y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by GVXPR04MB10519.eurprd04.prod.outlook.com (2603:10a6:150:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Wed, 5 Jun
 2024 09:39:12 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Wed, 5 Jun 2024
 09:39:11 +0000
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
Subject: [PATCH 1/2] dt-bindings: arm: fsl: add i.MX93 9x9 QSB board
Date: Wed,  5 Jun 2024 17:48:11 +0800
Message-Id: <20240605094812.1074027-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:3:17::24) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|GVXPR04MB10519:EE_
X-MS-Office365-Filtering-Correlation-Id: d78476fb-867f-4c60-91f4-08dc85435ac1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|376005|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vQYU8ueaFdEaHNEFe7GXhITN5BEBzTKdVsCdBi9legcz5ZT0pAmKKZQ4rXY4?=
 =?us-ascii?Q?X6OsT+Ri44aFIgkzis/8xdrzKUvGAAZv/XOfWXmXUl2OMr8JuPSehBCTECRN?=
 =?us-ascii?Q?wXRqdTRcsk/41XphkTBLsB6IyEz8L7ajrJJzVu3EYs7XVNKbH77FdeD7Y90/?=
 =?us-ascii?Q?JWx7oa6lvKUCA3Mh+tBetuv9SxT+1xia4W2KTV9yF1xR9Fs6pNaY9km7qL0i?=
 =?us-ascii?Q?Bwfm0HstMBUuvnNbSn462grDyNOOZXhFvV2DLR/B6mZ5i63ujeEZqHOzdptQ?=
 =?us-ascii?Q?8o3kOI8M9ugT53/WnVGs9TTOBnHuet+/EeZnt0RKzFi3RFYcqqwtCQPMFfNJ?=
 =?us-ascii?Q?go/q5QbcOLrfRISMX27CzLY3J29vsKnXnk78r0l8gghE+llXCFr+gQnqCNKP?=
 =?us-ascii?Q?hr40/VLRIjnwOABiekm72Uf7eKkyq5mNISav5xNb2LC1PldbStxaGSKGPrim?=
 =?us-ascii?Q?Vc2AJCaAaJ1oOBwxZA4uPIXvJbfVc3hEncq2Iq7M3+uU3ZULSxPVBs0ZLu2t?=
 =?us-ascii?Q?varJUT+iBu2rJxgSiCK9hG64bmBlqeQPvrBusLOCOZlPH/64sS0GE/IqdAju?=
 =?us-ascii?Q?rtdRD+RHchSWcquj+1bjBOEKttp5keWDeQhv8Z3eBplMg9Y3r+RGUyeSdnC2?=
 =?us-ascii?Q?KmVbAojpimCaE/KO10fsd/JwvX14oUmh6SMIPytwTJxZyTtpGcZycbrpqXGP?=
 =?us-ascii?Q?odClPjglDhB2d5ME084KSSlLuTO9Ir3OckJihvAfQvukI32Oh3LA1doW3v1a?=
 =?us-ascii?Q?vdTGtqyU5qPXRWbypwuRunw9aoeP5dHlfH24yV6DXW++l20wzgCJW4ZJzEqL?=
 =?us-ascii?Q?pGd88mZymkeo4TAXE0jmbG7NHqRLa5859BVPbC4sB37Cw4hN0VKy15fWdcCo?=
 =?us-ascii?Q?qLthP2lUvfzKqxj2Stt+NTSWjOW4LQIREjTgySyASe4mxHjVmk9OuTOno5NC?=
 =?us-ascii?Q?kCzrjEKJkGHBSZnH3ZsNDZmMpD0w2zEh/9BlpKZa4fkmtUXoLYsDHVOzkSO1?=
 =?us-ascii?Q?fqk766XN17Qb29Z+heSB4/FhzGS4UzaTfif/dRksv1WAlNknCNkGJk0BeI7m?=
 =?us-ascii?Q?GnW2Ed3iywbPiPFaXQftPYt0Lv9qdwAXJQqKBcI7eiR3FDjU6Gt90okpoEt/?=
 =?us-ascii?Q?f/2C4uyHtUzxuu8/UlYUPXKokHEMD0VktGr/Qvi+qYS9GYXGJ7wZtGvZqwK8?=
 =?us-ascii?Q?jXAuv716N9dLKCgCeJ12BtRoNxDVf/7pwQjKHnRDaXnne7wVvkMzUuSGppXh?=
 =?us-ascii?Q?tpiqvNYHcnoSFYelFDmwd5WPinkcZut1vADxZeuGYocfGhm3gVGBF54Se/a3?=
 =?us-ascii?Q?4xyCktCAnQfqtXCc3rlgUFHi1kC7oO/gQf3SAUcJghJMsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eknvF0EqGGETkl5t9UBCFJ2CirV5UbQEJvrLd9wMgXHVkU041cWfHttB6j9S?=
 =?us-ascii?Q?4BXgp8HnuuKlpUQi9yFMvBEyFV98HSXFZWz8C8jyfnMmv+Db8he5cEPSigix?=
 =?us-ascii?Q?DjdzbaawjYUoPw/VuS5JqB1SWm4Z6eqd6LLr3w6rMua/7z0DrWjZVH5/2Ln9?=
 =?us-ascii?Q?SvPo+1Pg8ohApBsYisHA5FkjOltWiepCQXP/SVfYw5lkfHlqyfBndaPodEZP?=
 =?us-ascii?Q?ierPq2nMSAL7+qNvbQEiESbTuZd17vzCWeaNDRv1dgTv1RWIyLyzWmkAa4yC?=
 =?us-ascii?Q?Fb++6Uh/hYdnoAVVS+TOez3XXDZS/Uzlazu5XJFRJAijF02NG1dIVXyLG+XV?=
 =?us-ascii?Q?PazWYfLHRjydSM635Fsj6xC+WZ/NIobicOskUXF7JL2Kt0FVbQ2oN40bGv7h?=
 =?us-ascii?Q?2mzXiq6LEIBmmzOKiFOaBJbJSmlE+xDSZf+GA74Dt6rqAd7F1YRYhEQgarfq?=
 =?us-ascii?Q?5v/MII5tqt9JGEAHSW2XYIQrisjXWtrnWp0EA/6fHLaFMezxZH57k+w92o76?=
 =?us-ascii?Q?dE/GKUV1PEwLaLVIDOJSTuOdMUycCakGNV4655RC4P5S97FN3KMEbOqxhJBk?=
 =?us-ascii?Q?oCFUQhzjClInxu79CQeDbP4WvEs+rq8MC+A1ECkAirA5yVjYqurd9OyPZxEe?=
 =?us-ascii?Q?pIIZa6uO73NmfGAZfWosHgvoCPCXmoQzym9TxhVoocmTebP+CigyrEMMJuEU?=
 =?us-ascii?Q?iSfJQ8E7LYUfCeXad6ihBstQ+CH9BsPF7kt3JTK5QuIXGf/5aAx/rJmRxjz/?=
 =?us-ascii?Q?QddyE3zkC3sSf/cBBOez77Q7AUHCN6RpximDtoW5Oymx6QToouktvLUswmS4?=
 =?us-ascii?Q?xgUAQD+KUhQNg6t9nPbCCOCTf2QdHsyD7S4IsTh0VjkHtkhsDlAYJBeuHky8?=
 =?us-ascii?Q?62DikpUIlQgoPPXjh/7ypZnnyVobXPilOwTTFMR+wJFDVTyhJSGVCrDqCnCr?=
 =?us-ascii?Q?jOAmrZgo4gd/mGu+QE3wrdu3+HFbOEbE+bHu6Esu7OaLESHGRNqQz2D81EjJ?=
 =?us-ascii?Q?yaJ/l1kw6MpzE07pgKbVaPGqW/l/Q+18Sr96RrtNzDkfBicID1Oj6et/4dAh?=
 =?us-ascii?Q?XE9E+iAswh+JM6Liv4DumYeY1I55MPGeUSpi4nB3nv/kcgwW+v2z7k/wJiaq?=
 =?us-ascii?Q?HzPoTKdZTa5cOg9uXDh8+RWPP7w6Ekq0G7DFY/mX6eywjoYbjCYPeaC9L5L9?=
 =?us-ascii?Q?05xeN9t1uetCcSIfjeyxgMKcp6oIsaJGa6au24VKatl/aRKmSnn2xe2HdCTq?=
 =?us-ascii?Q?nyNZdfCNa1oi3DP1vfRhEm35b78pUE7Er3lnfdlWP5qX5UWXMslAlWVmOcSv?=
 =?us-ascii?Q?f9J2JBPK8x85z3FfB8QbQu2LlQHD/ZyN+TxqIEydfzAHwGSdjxrv/Ysxr16f?=
 =?us-ascii?Q?14Ghw+GK8DlRF6Dey4dqTHV0W1/9o6YMBOPb1oTH2Zxx88Ngyzw+JT7n9ZbK?=
 =?us-ascii?Q?gDKSMcORwVtPOUA4uxLlgtW1dQKxTNxPgLevpu5kbZ0+naTXFdzOKyUewfcW?=
 =?us-ascii?Q?XL/VyWOioZIETp10lxntCUktDFPkLIhuiTy3J80gPSbq10seRYm0Z7koBG4Q?=
 =?us-ascii?Q?qnfRg1GgbsBvbHrxxGJAtK4qzoLXX/zlGCZeXqsT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78476fb-867f-4c60-91f4-08dc85435ac1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:39:11.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUq7fCpYc8kMzLnN8ZG9H9hXPmRz3aD+fsBY5b2vcJ8qdSkdAOhBYcJq8wBw471Qymf7murHjXWAsNIQ42MykA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10519

From: Peng Fan <peng.fan@nxp.com>

Add compatible string for i.MX93 9x9 Quick Start Board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..aeecf4e70dcf 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1272,6 +1272,7 @@ properties:
       - description: i.MX93 based Boards
         items:
           - enum:
+              - fsl,imx93-9x9-qsb         # i.MX93 9x9 QSB Board
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
-- 
2.37.1



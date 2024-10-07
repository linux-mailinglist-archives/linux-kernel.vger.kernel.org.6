Return-Path: <linux-kernel+bounces-353695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD25D993137
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30951C2037D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6D51DA10E;
	Mon,  7 Oct 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fLPwlF1W"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04941D9325;
	Mon,  7 Oct 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315067; cv=fail; b=KTPFh/INhxQSnaVP/rau7VygvjgU2yA3qkVpNnqWI8KtkyZJYPOv7T/izm5HG9nLdFAvXYoXp7fvJUh7+RAUiuma7vfdS5TIpWD9oqlRt4zm4aJ01yn5iMjxk3k0UqQQBCbSqkE+N6XbuJTat+IIZ6dVqMyPjVhetn/JTZ3WywQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315067; c=relaxed/simple;
	bh=leny4xWnKvTSKse+mZZQBbbcMp5KO5xTHkRDt9Xd6kA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BUXMo/Fbr8nAg0pdxYOwSMg7GzygebfvyyDO1X5p7HKjTK4lcF1rLbRCYqMOr5eaAN2hDGdDH63OdGhdtZdr0y+Gey6kcUlgL/0gM2Zzu8D1XLJckdidKBWX3aVZaYZiF4B3w9SKfz/UKNAHH+CzevW61OSLpaMCNf0TVJEIhao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fLPwlF1W; arc=fail smtp.client-ip=40.107.104.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVR7jYeapiHxIvIm3JSM/fAtT5ZuDA7alexIAfilZpUq+uDKkAv665dqeOeS2+s8WTYPJBQeGaUOXN+Sb7ttoQRigGMPrEqO6//cGhDVQIeWVYhuH7Akg/L7d20tgLmMlRuC16MrSKnmY1vHMFWi7YbHPJu06htjbbW2nwUmpddNBWV+uJAaI2w9M/L+zayjlkwrz/UrLHw4R9MPqYFV5o75M9ivyD6Bmpn5SxwY0YmO8/oYJBuDTXJ3BctunyF+hfBEVCOSNvNA+rxc/RmNPqqXRUOe09NJr6n8kd65iZqr1ZjyCmyPey3q50z3v/kw3X3KRwTh3P8TQhzDaNiikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiRq5JQXtlaWx2AEnVUyA5N13DfkbF0KIp2qTKLTUzI=;
 b=Bb/ME8uixiK5vyOR/SGYNGdgj9Bk2t8EIujKQwm/wPtS4hXtXyPyRQO/J1lBQidOX1B+WAGburHMJYQjHaXY39YkyUPGuhKxd9ICxWwrtNUapnUBQzy7Kmc2jRzFpGSfYm07SYCUW5YLgm05pkBEfxd1SQ/10WrYoxL37NF4rm71RfnLqASpEmmd7SIf+PV54qglp+qvkQWVRle4stxV73RgqTFelH4fOyV2TiAtzezllbHnntYDM8H0TeRnVNVM3OR2H78dLKyfFINS+OrD6ZsqAF7x2D5S0DuutLq8UouPu1aD6V7c0upMys/VTy+86D4QHuN6clAicR5kDafXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiRq5JQXtlaWx2AEnVUyA5N13DfkbF0KIp2qTKLTUzI=;
 b=fLPwlF1Wb3fPtVfY+dqaiCV+sk5mtPmXyY90Zw3NOcPgCiBTGUdaA0EKLh+h1neX8EFIoRkBgZ9dL0Ww3oT8TjwAThBCd2BiSNA+vGASJLC40IF9X4LUY4MAy5AZgSjrxYeWjsZ6fMnnwQ3y/q23Z/HiXDkVfQgMg/ve0Pi5hzLS3w2KSQLUc7jAsrMNg7iowCZj6fuiPjxDFaKwx5yJAy7okjNsmt6/9VyUXEG+uxH5gCBpNyN+dVAY52dGI4H+U7AI6PGu5maGWg4HKmzz8uD6PE7fpn/2fctto0zd+npAQRqmFoaK64e6lFMwT3A6R4MPBe6jbPiFmMyk2EMdVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10362.eurprd04.prod.outlook.com (2603:10a6:10:563::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 15:31:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 15:31:03 +0000
From: Frank Li <Frank.Li@nxp.com>
To: laurentiu.tudor@nxp.com,
	stuyoder@gmail.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] dt-bindings: misc: fsl,qoriq-mc: remove ref for msi-parent
Date: Mon,  7 Oct 2024 11:30:42 -0400
Message-Id: <20241007153047.807723-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10362:EE_
X-MS-Office365-Filtering-Correlation-Id: e347c11f-c383-4958-4a63-08dce6e50daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yK1bmsFHgrUDnyuOHjMbf8nXEhDUr6mX5mIrGf7xd4V1jMY+LGsFVSlZUAjW?=
 =?us-ascii?Q?BLujNN28tYYmFUeJA1LyCc2rma7O5v7g3si2eqMn3g60mpYF9sRPEwAeIIZ6?=
 =?us-ascii?Q?lkz1YagMUqgBkCRP4g0GX8ULjs3/bMY0y7jmXiNBBrfl+cM4UvSN2gJhkpg0?=
 =?us-ascii?Q?cjhWjjXFE9vgR44UayucyXLkDZidrUMy9GXf2JzuKRZjs1drSEspNPBXv4+s?=
 =?us-ascii?Q?mWnBfOedmSVGZ54JL7DlysymSJWeKVrHUU9epZD4RqcW9n/uJX93TlO6/8gF?=
 =?us-ascii?Q?yIKnn6zhtc6IlZehO1Kx2vDXn9GMkljv5zImS7b5BJ6Yon61hYr51WMm+4Kh?=
 =?us-ascii?Q?K9tjxKc//D+IWp1MtYmD3LM4CkW4CySRWVmxhGtCMCFk8SyosvVSk2DBk/oz?=
 =?us-ascii?Q?3O5U+0DtjN22mCtuMriAnwrIIdWITwEEzOS8lkx5TmKQ8318aaJO1Uzfo58A?=
 =?us-ascii?Q?8oiI2Cxx0wDgeR20b5kbQStFr/UityexFEGZ6g47hR3jjPCPVjkYWComWO0Z?=
 =?us-ascii?Q?WFWEHe9VVh72c6NjfFk7eZRkjakfjUoqOZSZI88sSJH3wet2yqh/4s0a5ky3?=
 =?us-ascii?Q?PXAZ9gM13bRLaCxAnhJxlpfwRnAz5M7K6CygflmJiarwmsAi4o5psDtxvaT8?=
 =?us-ascii?Q?7Dg9/Aorn9LDPjm9lmy/vzCuw/jlxR8BJY1IGJMG0NRp2NfgY9235h2lABf4?=
 =?us-ascii?Q?7pF90KOFyZBJnWgfHxWTLojVz9dSEqB2dCjQo/KSVXkkzRg/zMmZnDImGfKO?=
 =?us-ascii?Q?9MTkRi7XCw4VKosrEAFdicCnP22Gu6GIpTKOsXxDYWT4bed7ct8vlSbGCZjJ?=
 =?us-ascii?Q?dhj3ylNuk0XUlQngvU1JoiOE0GV9ZELj0CHtQia05+1SQJpx7KvEcaqNmX6v?=
 =?us-ascii?Q?93nkydRTndi2inToNvJRYlhzmIRxYT1khyRt6MtDRWcP3ahzbR1avt1FDC2R?=
 =?us-ascii?Q?qeKxNx4FAF+xAvCJcaeGrw23x9yQBQ6coaFSiy327MYmyzaNy59EKlwdp/QD?=
 =?us-ascii?Q?hGEVuudlVQhGEytCSZ4rD0XQwTerkjilq5vVM3w1j6DRyjFaUQMZhIodXI8O?=
 =?us-ascii?Q?e1n4CG3xNKOTtDWj230tPnK3avjtO1COORTM3uka8Sx0o4lhdJhNtaFb8yOp?=
 =?us-ascii?Q?pZTfQMAy5/lAuYn7cr1v9WX/8YmVD5G2VoZ9QXv/2YrrKBYuLXtfLBKHfVfC?=
 =?us-ascii?Q?rs30Z0R/Ur09GeX0kt3Yk9RkBd4Ue2YLTWT8Z9RaAzhF/Oc7mSqibxJD4e2a?=
 =?us-ascii?Q?JHLxKOWuVoThMeQnb/0ZQJWDPgTRsHR4PminYqKpj5hyluLQwX54lBBp75y+?=
 =?us-ascii?Q?E/E4DfqDU5/hMCbBQQen4z3z9Pk+xfal+UT4Ublg0l3v1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nTWEVMfI3bkFMCkee4pIeeNp+ChCnWHhiBCVjOAcQoThJyLjWS9h4m9sNg78?=
 =?us-ascii?Q?TrA0nHWYuL4G7Pw7KcQCzBvb+nuoaFWLpzYNwP4u8fyqyN793iZ67aMzjfWu?=
 =?us-ascii?Q?wCockUITDF1u9PaGQwYQMEBMtsKgdmD90vKhOeU2Wfh86OMsnvqWQWuKomyi?=
 =?us-ascii?Q?yUDEcF0wAmWUb96aYchU1bzHo10jQ7js8QJ0JEZEirzQFcLVjdmg1pw4tSnj?=
 =?us-ascii?Q?y8i/wxatP0e/+bZu4WCXntTpBaC8/M8YnEk4cNk02zGnfhnNYKaeaOpe+XKA?=
 =?us-ascii?Q?xKuZAiNInwMdzZWejsWZWHxxtsu1eUOwCjHY8R4bodHW4WwiA5oEBw1O5gfK?=
 =?us-ascii?Q?uGm28IvQHyq+L6m5b8FODv06Pvy/RZ6oEdblhV0AoaZp4zctAYsD8DS09/Hg?=
 =?us-ascii?Q?wYEHH9zN/Wo9CRYhisDx4yuj7T6Nths9QSBFn9UT1EKBRjQrsLggwzbliUo2?=
 =?us-ascii?Q?QK8tT/OQGuVDw5/mDjahGZG+QY5vZVIFwsW1Q7gfbfUJW6t5X7Gj02wqTbxl?=
 =?us-ascii?Q?bYpbeNpmBWVJ+84dzuRkf8pNQnIQy7ElWTHKWJHjqTsNI073qlSC6h1+rqZi?=
 =?us-ascii?Q?KV6ffCTyF+E317rNgJSXHpdcKzV0C6F50zZhtCjj9sG3kuBvNETq2D10krSh?=
 =?us-ascii?Q?ADnxPvrgE5um7QhCbVtVuZbFQL5NM4xKWNFOsuNMTBd1By344C8G7XuO4jhH?=
 =?us-ascii?Q?WYVs1jEwD1w5ncPCp+wB1fjbe7yAYahIeDIBo1qKbeFdUbyKN05uJ6pbTkhk?=
 =?us-ascii?Q?xs6Nm6FGqWVmtasVsghmqGPp9DU3SHylvZqypxYvHDUB67r1LRu4Wb6KVpyI?=
 =?us-ascii?Q?PigBE8EviwVcoMO3Gbf/2t7jLhEeUlstEb64THa/gD5SYtz9siM5uC/40h0/?=
 =?us-ascii?Q?C/oYqU8N8lsyAs9PXvkJgsfg9mYi3ZWLh4eRaBVvQVoiJGoWEzFasKd6ePm0?=
 =?us-ascii?Q?pfk1AUK4TQ0o3K8Rva2AhnSWg/nOSCo49AFRYZTJcNMpjzBEgClCgNjQjxFz?=
 =?us-ascii?Q?D24Er4BC6iFl56ubR4PGun4mfDaBhVRqHiFcaDtTq5IRh69aIJIpkwnp6YGi?=
 =?us-ascii?Q?4SNP5vTaUEGArPdbimvmDzdIvrhtk0gUMrs4uPRfql8zKTgDwl9zYRiCHgeu?=
 =?us-ascii?Q?D0qsR2xU3xKmmHMMFbEs5vgdeMl5ceSmWlazpH5Z3CWhAQ1dL+ZbZmWrWGwL?=
 =?us-ascii?Q?C7pY1jslF8aMrNEyQaYjFDx7ytIYiCZJ1GD1AQHYUrBxYM+BNwh3sNFIhoqs?=
 =?us-ascii?Q?OUpMNczPpx8ixeDp4M30DElipFLEPTA8N/pbrw78MiZQBA3LAuT03QfU+0yx?=
 =?us-ascii?Q?3zOHMLChZVIbCDAmeZue01Jj/tmBbLa5XZXH0o3zeHun+A0zzqWBcaFxGaSf?=
 =?us-ascii?Q?/qesMGALNh9ZRceX5p7mLtGlDdTU92Xq0GcIIUuqALgWbCwfEZV97IBrA8AO?=
 =?us-ascii?Q?OMSLomh5q6Ookl9GvNsYk5PHKNxP02URMEG/ZQoRFKra7pgROPeGHPl4TlVZ?=
 =?us-ascii?Q?lRTAJjlNw64dPyJi1yq4sdIy+m1xtSERGcurhgK+KKQbqwY0jfeynzA4q6+7?=
 =?us-ascii?Q?b4gn7ttOiC9TZkMAMYZ1qKZ/NBX23GGpYz9vEUqf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e347c11f-c383-4958-4a63-08dce6e50daa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:31:03.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zm0I08KxnOJCsShgKiV8Ma+1bHD2lDpvTgGEuYH75PhNL/y+uJN2fmTFBP5uhIGnwDmISYWc3Vku5pYJGwGpWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10362

msi-parent is standard property. Needn't ref to phandle. Add maxItems: 1
for it.

Fix below warning:
  arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: fsl-mc@80c000000: msi-parent:0: [16, 0] is too long

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- Add krzy's review tage
- send include maintainer, because file name change, get_maintainer.pl
have not return orignal fsl,qoriq-mc.txt's maintainer.

Change from v1 to v2
- add maxItems: 1 for msi-parent
---
 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
index 01b00d89a9921..df45ff56d4445 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
@@ -113,7 +113,7 @@ properties:
 
   msi-parent:
     deprecated: true
-    $ref: /schemas/types.yaml#/definitions/phandle
+    maxItems: 1
     description:
       Describes the MSI controller node handling message
       interrupts for the MC. When there is no translation
-- 
2.34.1



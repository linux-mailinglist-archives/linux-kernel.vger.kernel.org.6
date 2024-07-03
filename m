Return-Path: <linux-kernel+bounces-238727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635BA924F13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8042A1C20C3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089BF4F615;
	Wed,  3 Jul 2024 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kvELeQrr"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44673FB31;
	Wed,  3 Jul 2024 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976109; cv=fail; b=hKRovWpCkEu3ovTdDF0mbFn06tgWRz2vdhwzegdFTxjXTDGaK4IKCNMYsSIsiZhxRHc7JxbdX36Lza3pW63e6OF/7eU9Ija2mpUE7YqNWivzreeWsKNauX3u+ymJyzgbqbf9SKBS0Ae81zOXR44syGsGoF6RTPn06NFxvVqmy00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976109; c=relaxed/simple;
	bh=4cDOXiiGYi+5pFfJMFVD0ZCBwZL8Kl6L2SxLoqyP/Fo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sOrAyVQAtrwdcpm6tCsf00HcxzGpjFApp/nZDUqvozPX8YJB49IqiWJsxyKBos+DBXCGAWmHyv89O49SJVc7vIshwj2rNGNVmKqSpFJjFp5k5Z/mZd9uYBw8gG1guD+1JpVFhhmuuEC4sprEJSbGSt7NFbcZiXfMSn28Lq+xowY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kvELeQrr; arc=fail smtp.client-ip=40.107.249.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRglS6bSptGVwhSb4NU7ECl6q2MC48GlNYoyRlQNRe1vSxUHtrnNsdXl6yk2yHpyzxwvhqfMJbAjV7XhPLLTwSMCLUNQyyZ3WqS14LqiZ6sfNH+v6sdMnyV/CoIKRQ/3cp4JZEZ1dYdPxQwgmybzpHC7t10ObgDZkVcklzvUOirY48czK7mnjGFP8a88CFlTaZOhRNpHVuCJE+OmbYzkPUCNBhFssJdhF/qPcPXnihhFZXWrsjjEltJJnEpw9QS3UrW8Q05BarJUSw2C8/X2MhYP0Dbr7M/JzwBQ59Lhsxl9vc3bcqCXDQeA+f8gahgSkmeqdnPJ4gsWdedSAnkWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Anqs+ftUgw12gsXDagwnEZjP9HLqeMgaU5TvwKAKvPM=;
 b=OhRyK8YA0x9LdnNjTvLSVHKefWJlYVDH+HHNY4xCOUnlSqGyvlz0geYQE9WOutGcjyF09KN8us/ot1Ud5jSdgh6VQZQuvu3/PQcP2YfoKoXBGix7/53pjCqXOcv9q7yqD1ohjqZ67AbCnJH11Jo0+1MzEXZEgItYzWUklgi2wi8ZGvfGwYKFweHjLdZzR60rifqy0aUGjAgmoOvBbnZTNv2dHpbFjkF4sOAKrnr21hibejiJO+6yR2gVNlG3BJPzreKaLCiXVxusDx29/T/bPIDoj4uJvmBKmXItW3r0CANeOcYY0QU10fM9HZgkaPVLFUg/4ndfcxPk/2U7OFF47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Anqs+ftUgw12gsXDagwnEZjP9HLqeMgaU5TvwKAKvPM=;
 b=kvELeQrrOqhoFtS6u+DEpf8zUIB08INGhgw4eGtOgpCeIq1hF66KhexZoXWO0wus2cbXtSKrht4rCtnED2M7Ra/YR8E8Be1Jz69z4d9BqKRK+jaJU2CexPDSzZOZowqHV1Rk41H/75mFm/f39OJcDHMAtVymLyD9xe+cCNK8e2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 03:08:22 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 03:08:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce property mbox-rx-timeout-ms
Date: Wed,  3 Jul 2024 11:17:14 +0800
Message-Id: <20240703031715.379815-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: c937a819-4b82-4860-b2d4-08dc9b0d64b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e2K35wEuMjCEXEx8IMJYzLKJdCW4ZtPEF8H5tq15dPxY8dcaLdEx6CIJPfQu?=
 =?us-ascii?Q?TxCjqijzFXLvFSK62A8YCeLoeNUNfUmIUaZeSE8t5uY2NGXaj8KzNjCIuOZ1?=
 =?us-ascii?Q?OPA3xdSjMutWaxD/grYaYZZ2MtdzjQqJkHivDJMo3wgB0ZGigHzy3Jj+wwSb?=
 =?us-ascii?Q?K7ZY1UfvC5KeTLgWdmZ7iKONdPOkh9kgsae+MHVqmOG6D95rdDw+fJ/p9viA?=
 =?us-ascii?Q?ZTap2P9A566e6uOxBNmn93TUZysyoN3+h7hCuhML2lvVQmRNSAUQ6zCQCVaV?=
 =?us-ascii?Q?/b+kl6ZfLWQT7HTspVA2KUZtBre49oQWE4oymOQM9xRrFopO1EMgWrGBbNm/?=
 =?us-ascii?Q?PGlf1hQrjGsnbl9k29alw9deCFpGuOj4GqwKIJZOcD4hIR04NH3rt72qv1qE?=
 =?us-ascii?Q?yFrvjkfkU2snfNkujTCx40aVapEy0prIo+XJt64YHdDOSFisNAjFsqpfZP1h?=
 =?us-ascii?Q?IY5uqd6gKHS2t5tl+h9oY+b5vWPoHuc6JmUGV/wkkROUc/3HMf3KfSOHsNnI?=
 =?us-ascii?Q?dxS691LWpMvC0KLcibj4/8D+WbuLauvXRInsI4oG+kdxWPjGd7iTnTpeSRg/?=
 =?us-ascii?Q?r41GwV+G3bS6Kd7b40+1cyk8qGZhtK0jKG42oXY/f3roynDt0KbCtZC4m9hy?=
 =?us-ascii?Q?YrMEYN6OSXn/ungc/O6cZklR/g6tZXxaZZYzQYLnQwNwRNmcywYW1hkPC2+N?=
 =?us-ascii?Q?/t/6AsfatvXkGDT60AlUJ7LTOtyWdFIEqOoguQCfwrZcCIg3KdNjAm4ejHx1?=
 =?us-ascii?Q?FizSrGx1s4tKStw2A15mSmD116dTBkDOX+4wPCrQyHoKzRLM9CF7e8X0Etbv?=
 =?us-ascii?Q?bGiF8VORe5+Oy5cu53ltufe5bhZ+0UKa4r6xZRqAy0YcfXS++NZR3tX9lUP9?=
 =?us-ascii?Q?OB6B2u34S6NzNtER0v3bCkmZX8Mm6mMMRpBFEF4r2CS4EzSyqgsWr7dysZjj?=
 =?us-ascii?Q?kMrLa5IgC+P6dHwnv/t3YNSJpAoAkah0pyHNymiXc6f+sXQUuRpAnVjpGWM6?=
 =?us-ascii?Q?B51zxtBipLjrXgbyoVSL/M2hBPtZ372pCCk4LYn0pcPYSxlOEdRbj7QPSA9K?=
 =?us-ascii?Q?i0Jzr7qHJ4UdCn2/msP68xMnhq2W1CGV/11sd1xbJLZmOHpO7cOox7KRwwTP?=
 =?us-ascii?Q?1JKf2r3ZD8SqluL/y52/Q2TpGzdDvZjs9ow12kj2bBmAU4yzGg8EpVFo/9Jk?=
 =?us-ascii?Q?+pEhlLFrhY7KH/CimN0V1rHMzjyXbByHKo6VmFpoiSlzEbVyyYU9DHO6Fu4E?=
 =?us-ascii?Q?7Lp6Swq4UcExtLnP+3I9Y0fdKtAvYAhcshPL6pCvjta9BJOSglatlwFYnnwB?=
 =?us-ascii?Q?gW9K5Z0GD+CPyE5LYwtbl4rwOdqzrC/3SuIZeWG+FPJcGWEW4yOwwt9blWvq?=
 =?us-ascii?Q?UPjBHM03qu5uPeqi1FnaD2PfBeajHWqzU8T70ZJl/gKUIDqwLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5QfSj6q8HBATY/mQ8F783kfwXQsuXF2ZmNNVKnuNwwF97dijSWGwD8WLf8PI?=
 =?us-ascii?Q?OCAwyIZs6awwkm/LDc9pQOmvGDSLTiKOp5EirBLkAvSWL68Cy8/9nOTDXzWw?=
 =?us-ascii?Q?JNLCAxSg7QUzgE9Cz7R6H040InqZMkSqO0j7isJDV9mQHsoSxbiwTVI93p8R?=
 =?us-ascii?Q?MdH+Af31JFwzieboeXtTgaAfnnZrVZNjxQNd1EErjMaj3w7u+dqk1sBFF/N5?=
 =?us-ascii?Q?wqxtHc+DTKWKF8wgB/fWdDdDZZeihljxjmJ7vcKOiSjR1kENaXBl3lRiLujV?=
 =?us-ascii?Q?jQ/IevNlSu/oTCacybdeih0EkRh9cL/AqsqiVrNwmKQSorpFrl3FVt2ob+Wi?=
 =?us-ascii?Q?9EWZIA5cAYsQxqYyIptRcYeQWoSwC75ERxp4+meWXmWxM8MoNpQQOwKry57j?=
 =?us-ascii?Q?mk2ubFCQfGM+UpaanWWNhd9eiZmhAafQNdMAY0I32iLKHPcKdU8ck2K25Ce6?=
 =?us-ascii?Q?AL+4p9LZVuokZbCTBucWLrDeIeiN8gAmbQj/bbufEHh1w1CIBcrvGNdUoIFx?=
 =?us-ascii?Q?5cFkcNDLSJxjo8CH8GNFf9UCbv7iKKWYr3fpm7DNc01UaSjtCpMf3bJCWhmY?=
 =?us-ascii?Q?vNRQAKjF/241wLiz0h5919OQIwMeTPX8GsxnrPq3+hTi6zJxtM1p3CiVwVO2?=
 =?us-ascii?Q?ioboKMMGUfltdWc3kCntlVo5lCDXS+g8mxlwAmwtR8bJCtr7bEzFTTj/EVn5?=
 =?us-ascii?Q?bY5AzgVSx6xTN42i6yckXIPiiQdJ4r5LJ+GklIp6909nbp9Y/vHQuAl2oAq9?=
 =?us-ascii?Q?WONL4hPgSO4EPkhh/S7k+gKtZZiKAp0LqcdbDNWCmnNGSeO33t0kWPpi47xz?=
 =?us-ascii?Q?JEWPPYUrl48K1pfhNMa8DdosQFv+EbjXXBctaPUHF7KvK+4VuelfcFF/Ywtr?=
 =?us-ascii?Q?EINeRPRQyKl/FiWkssBHH3Fp46fz3RVdohxh1DO2iHz5v1nIWZpsuwWjsUHv?=
 =?us-ascii?Q?/MYQaMxC7ZtU0ikk0XOvKaqjIA93VD0pji7/yStHhAk67jx29FVDqq8UZef7?=
 =?us-ascii?Q?n1uAAsLe76D42nEEanFSila8a3JpXU/Hua5Z319NU/qdpO4kUXZRuSqcB+eu?=
 =?us-ascii?Q?CCNR3jfjnS00MfYsUzhCB39MdDPlDfnQ0UcqdWrjzdoXLuN1TrfVTc+njqu0?=
 =?us-ascii?Q?G4mzqmR94cn/ja2Gl5l4njzNBwXOG9gSIlQl/4iXnsW3HsReLbKPXCONkF5V?=
 =?us-ascii?Q?53RziSM7lW/LkrKNPwO2VV6mn/2J1aw7lmmThEzgWIBq09p92TPeKFJK24ae?=
 =?us-ascii?Q?53BrzchtoRlBQruNn4HvjzsgwdKguNoTLuVvq2Ff+plTFB6yI+5SCVaE2C5M?=
 =?us-ascii?Q?TqTrNzsFhLnVy0/F8qcNetxTJ+iQhIxtL3OgWp5RuxFNYE/My7BvHk68qYYo?=
 =?us-ascii?Q?eigIRfZIdh4IZVug7pY/aO+GJ68NO7X8H5M/+XppFJKBDmJWaULwJ8TjMUUh?=
 =?us-ascii?Q?+wiBO11PMGy2VlhfdxtdoXMQG6T7H/bv34AEe9/Ky1V0jzw8YQHlovc/8yd+?=
 =?us-ascii?Q?HxpDhg3njoUCKM4+5zidK0HD6ns/seW55q2f4Q6S1RsvHPnidGveAtF16gEG?=
 =?us-ascii?Q?kaDh3/N0vhJn/vryFIsaZucu+P4gXx2sZMMNMTny?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c937a819-4b82-4860-b2d4-08dc9b0d64b3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 03:08:20.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igaueNygnb+/22E80AtMGGeH2kJK0oGXiFfZhd+wWy0ZPt1oTSIZA/FhxN6ewRuYvpqnyHjmXZ1N+ppfHlZqtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

From: Peng Fan <peng.fan@nxp.com>

System Controller Management Interface(SCMI) firmwares might have
different designs by SCMI firmware developers. So the maximum receive
channel timeout value might also varies in the various designs.

So introduce property mbox-rx-timeout-ms to let each platform could
set its own timeout value in device tree.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Drop defaults, update description.

 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index ebf384e76df1..dcac0b36c76f 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -121,6 +121,12 @@ properties:
       atomic mode of operation, even if requested.
     default: 0
 
+  max-rx-timeout-ms:
+    description:
+      An optional time value, expressed in milliseconds, representing the
+      mailbox maximum timeout value for receive channel. The value should
+      be a non-zero value if set.
+
   arm,smc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.37.1



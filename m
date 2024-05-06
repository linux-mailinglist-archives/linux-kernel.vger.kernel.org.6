Return-Path: <linux-kernel+bounces-170183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CBA8BD2F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FED283C73
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9B9156C5F;
	Mon,  6 May 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eQL9eTNM"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2059.outbound.protection.outlook.com [40.107.13.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601E155757
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013632; cv=fail; b=izyvX8kJstx9lj9wsYQquyB9NncnB976+Eut5k61EScCP1GAr4HVQSS/fV2SGN+AmAQqC0nsd8XP9k89fnwAjRPPI6rhBVOoCuaeUeBU6eckQU9ecA5+M8IBq3EsiqNF1cJh7HTH99u3SDfN/It4cfgRZRi6XE8aCCNcN1ByjQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013632; c=relaxed/simple;
	bh=q+vRvbyxBFdhNOd4VngQWt1QUluY0Vmc8GGJEmDIHNc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PDGKCbLKtWTN1JUCaUOQZzFurpb5JnPe9YD91TaqvW7keDMPy0cRxpwkX5OJw4gen2up29BsNfJcHMak+pD3HGK4sNBAlK6BSB20I2Nf6wuM+kJeVidFoNQgkIXWNjZHMiV/4GYJ6otd+bwQi6GdR/1iBIqBHpw6FzFj0T3xzk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eQL9eTNM; arc=fail smtp.client-ip=40.107.13.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4EdCr+TAD39jUdCty/h+cP1qlHHtAXpqEIqi3h+YZanGvNN2MhDWwYcxNHeHgpp8CplxLvIuPdEP4mC0UfOOAAACWRXCVaB/z2nSNu/rnm8tm3tUgY2/odGRq0IHRDpk6Z1gEM+NuowY1YTqBhm58s8NCyBw00eLuay16x7IOvgkAnbw61u4xsGIGG/UFYRCfoUHV2DVAeh+h0J/nULHS11hU9I9yV3UprKYfU3GA7acjMtBh6GhDrZMGwY9cmrEhrr4jOmlg4SQfeiy+OnKcc+6mLG0B7EHrtqcsxf1VbPOA0QUpXE+BHrxEH5ANiimsHoiX1F9+zOJX3FUpRpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE3RPDL6QL2unNktTbkb+AOZpVlVxRBdqM05c+svhD0=;
 b=k7OB0+PWzwi7p3kEUahK6QMNE/HqrvwujMMeMZXsLUjaQcK4djXz9NG3gV0wMjFyhynoUhlleu9Mhi3WW0M2Ws2jLuE+sVHrhei5O1Mvbo829QEuFyxbjmRfpvb4ydM4iJKscsCXmc5/kEQYCuvUTzz7yt7OvTCZSOecJeyT0QW5Iokz3kEKveT3h5+klFxxNL0Wyl0EG0R1xkjeSxoaIR5vIM0EsvUv+r1t1Y7vPTucUtdlU/rhao3RKDZgOxWw0fR1NKiWHE0whXED9iT1hbiawNSOfifTKwjq4Vdw0GmGzDjn8M/mAC8pOPl7Foq3/Y1OarHgLs08+xFpRdn2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tE3RPDL6QL2unNktTbkb+AOZpVlVxRBdqM05c+svhD0=;
 b=eQL9eTNMr0ovvKr+mYfRmWJnzMCKAPFuQlHCobqa/4b8YL5AkwQRMeBR/bA7JeFmlBemNBr/gmbs219tg+hwUgSmn6ZCaJNFkQobzOoNhagrE518w9s2gtp62LIvmZ6uO8g41EicQD//liYJI+6fXTkfnIlujXlUfd8pW7WwWlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 16:40:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.039; Mon, 6 May 2024
 16:40:26 +0000
From: Frank Li <Frank.Li@nxp.com>
To: miquel.raynal@bootlin.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	imx@lists.linux.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] i3c: Add comment for -EAGAIN in i3c_device_do_priv_xfers()
Date: Mon,  6 May 2024 12:40:07 -0400
Message-Id: <20240506164009.21375-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 8929be52-c684-45ee-e55a-08dc6deb3b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a7LdjT8+niJkRId1MHRLZ1ayoPhH/6HMvPvHkUektx+Qppe+poRRbIogzFEZ?=
 =?us-ascii?Q?OsSt8WSzWQeVBfvkbyjZyP6v3LomlITIGwAftimPEEzPupJ2gw8XFbz9EfNn?=
 =?us-ascii?Q?FrRRliTWTs/il+UJk4Et2CvymWqbJNpNF01OHAl9sReRBAdk+wMNBwn6bcqm?=
 =?us-ascii?Q?m1A6e6ZMuP9b/fht/hzWT7qzsOGRaAUAfK3qb9GedleH9QoOH8zdnoi58tA3?=
 =?us-ascii?Q?5UdgF1PJF7++sG9HkcCch+/JbSfiTNoZpbdlae28l1ZKg9vt1DruwDIwtl92?=
 =?us-ascii?Q?6zxZ7LGNMg6Ubqp2/Rf3Ey1m4Gi8p/00Qd4mHif15htHcnI1e5g3o7sDeIvw?=
 =?us-ascii?Q?8ACVL0DAiYgYfob0SUmBN21LO9hc+rD4JKq8Rbv81/JzJWhb/nHGM5KwmoYn?=
 =?us-ascii?Q?p8RgP7+H/vckkhvQKT3xb0z+R5iQsIX9F/qW0pPeHHwXoxHYauae0N30RfHe?=
 =?us-ascii?Q?simHYdEU+kdzteojDny1jv5bXvIbbX4Isk/MbEvDLSjeE4vDSANYcbmXunB6?=
 =?us-ascii?Q?kp7WHKdIxiVt/J/pdAaq1RBjSMy8/fdOdrqKvHN/U2kzXOdWDQHF/dazhQ8y?=
 =?us-ascii?Q?kNq9T6cQUJz6jnbGaYuE+UBBqtD6nLn0Nsgap022O9PLYYziqZNQWEWlg73x?=
 =?us-ascii?Q?/NCJl/EQZHaFhQ2sWqh5avlS0AZRtJbAjlhd638PCI6cAN/zTCbGhYPubOok?=
 =?us-ascii?Q?9j8GSRvtqplmr/8lGPC1akVRxmaLLQONEpyyAX4RdPh2iHOdnKinVWkmnein?=
 =?us-ascii?Q?gcCNioyfxhtbXWDIfgPuovV4oegMDaOqbT0XeWrkKFEcWtb3aZ450iUokoTR?=
 =?us-ascii?Q?D08FY34Dj0x3txcV1/O3Zy7mc9uNTIdvlbw7N/LuFKBPVM3E9KpNO7zXx6dN?=
 =?us-ascii?Q?1gxgHyQIYUWWtVChseSzV5nUe5y8bROrrMxcY4hsp6VTpdE6d2e+zWfMd4gy?=
 =?us-ascii?Q?uH+IvtBwafhKN7SroZ3R8Yf20MArm6fqD8MZ8x2ggF5kv0ltpkqgUahizKPk?=
 =?us-ascii?Q?ypfjp2uFxnMDecjcGWbB7Z9PLOwmD95uGXKX+VDYyJxYh4kkAslhBM+LjUrV?=
 =?us-ascii?Q?WelTATTgJpPQrhZFHkf/OiL6sX/o5G0WQBOnNYSdPCu7yaSzvpsfKQGzni9z?=
 =?us-ascii?Q?cTTdcvPJyXcUgXyzLa/sbI8b2OGUJieBS1nG2HU3Zz2x0/w2pFhrJTnRmKsR?=
 =?us-ascii?Q?kAkgv0jtagUgQBPALWzMjO8NlSUk2+DTASRILUqUvqiPMbcpsjNTN4CDkAvm?=
 =?us-ascii?Q?q25UjZekSytpv2kNbElSKLapEsEh5W+AIZQBP6xtO7B5Muj9cvV/iy6MlcSp?=
 =?us-ascii?Q?/pO1L+frKDS7VcASkDaafl6Wumfe8ES5f9NJzZg6Ubo3Vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1EXiCe1j6onSzht7fWx7L8975QyOtm5hQ7ofbnKQcH9bZNQodLAKtQRVsCBx?=
 =?us-ascii?Q?Jzj2a7Wwdcmgc1DLwpKfhfgGO4z/lBwCFBpmuSr8MZyK8dyFF8w5oR77dE5u?=
 =?us-ascii?Q?aNsLMYY/aTGh/7Um6eZCOmyhuv23dmmPEGPnfUaPrtmBM9i7w8OTIMDGdFjr?=
 =?us-ascii?Q?Zw+mkOQyfpc0aeX90RK+ULtVaV/EYAoQPSsuQ5xDk0NOkqpF/UP3RriKeEWe?=
 =?us-ascii?Q?tfgiMmsnFgdHG8tFPmY+/qgyGQjQY5qLxlSMVcHBEkvqi1p4j9kc15kYTpj+?=
 =?us-ascii?Q?GE9IJYMMbXGwrqpA+yq3DBmvbk7UJFj28hw650OWfgJfbn6sYjb7Tc2dPW3X?=
 =?us-ascii?Q?lMFKTy7205kZ1aZH5lo3a2rRdP037EAZ7vlRDS4UUE7VGR3iLUg69he4iuJg?=
 =?us-ascii?Q?N6etcq7CMKApXIMuYVNtXLayOhpGrFmyKXLqsuqWXoQ7Hmx2ZZCumBRvAg/N?=
 =?us-ascii?Q?+KJkQJW24pklkHZKejgzs7eqH4bmF8bpdgxfSQMwC81FcLt9yvoafpzBJbW9?=
 =?us-ascii?Q?ciYbtvpOMXbwrClZc+vGF1ICJSp+JyINCKZIRF2N3D4pFzlcCgyDbixeA3i4?=
 =?us-ascii?Q?0ckIvjODCydurmghwU9dJ4eaYzf88l9ncijOC06aoVKO30a4adIsMb2Eej/m?=
 =?us-ascii?Q?QeplgN94gW2BGBMp+qCEunjHx4Uk1vk6zsYw6DsggRsRzfTNf4dAysic3qgH?=
 =?us-ascii?Q?SLQzsp8Rr+gxj/TkKqqlYOfwaP2vXgzt/dHuq8geJEmRvc1HZCBbtLy/eVRX?=
 =?us-ascii?Q?z0GoCtwBtbjjrDd14Z1Ktg4axMfNRk9QRo/Vnph/IdCNYLdi7qTsoTv+fcI0?=
 =?us-ascii?Q?cJ1D1s2VY+Y1TKLq4i0rBt/p2ML3Er+8FAhYGEvr+4Vyl/ANkJw6cTaOUYsR?=
 =?us-ascii?Q?t61nLUbbCPueMJLZHToKc9nRgPl50imyZV/jjjosMElEZwy+2Fr396fRQ48Q?=
 =?us-ascii?Q?c2flxWkUTk/x/skEmWvZwZB2acfMbBUJ5GePdx95aBBSyFkHSAj1Ebxckqwd?=
 =?us-ascii?Q?KuVK7iKoQNpPd5Z0a4M7MYQU5sxupFBYffNbOFosYUey6bveFhb0Qxi/L/b9?=
 =?us-ascii?Q?fZZlXPVlhYoLQ2HCssI3OeMNjo12OiIFzYUqnt7SrSiyLjtDrzPsALLJdwm4?=
 =?us-ascii?Q?t5BeaMRdiajVkHlHU7SQ+e9vz3LVPsomt2O85FEN3O6FLQxqrs2yb63DvG1a?=
 =?us-ascii?Q?jRB8XlhoJ2eufiSrGYGn6/0R6psfvH4TK2rJNZMRDCXyaD2thY8gOtrnkW49?=
 =?us-ascii?Q?Oq535AOzTBUyTvBEMylgQE0oejl8r8F4bH6/3ufxisEz4DB9EYAVBEiT8DD9?=
 =?us-ascii?Q?1mP+yRgwm/0cHr2irSAwDJ7oBieASrb7ZM7Ai/F97OOq/cm6pDWh2YApfTSk?=
 =?us-ascii?Q?Eshknu+QEx1pvDo2f9X61F0Bfto1T6tRif1KWQsQ2+iNEMAYmhq734BeJd/B?=
 =?us-ascii?Q?NtiElo0HLvv3EmUWvOO2S9Qsjlqz1hS+tQEXmSUOs0gUpNNmIbMG2UpnlpIZ?=
 =?us-ascii?Q?63EuYrjhdA9k4DKhzKcCHqQP44Fv0oEpBLf5EVXMrDWA685XXfKa9NRyq0ip?=
 =?us-ascii?Q?ehQBXmlCJBbtz8FFDNA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8929be52-c684-45ee-e55a-08dc6deb3b58
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 16:40:26.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Spy4mvgeojPZiI6VK1EJ0ClhgcFUUKBFSmmUxCpArIomt0jDm34uLy8EugTmTo34SbmKrlAr9dZXyRDmc82Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429

In accordance with I3C spec ver 1.1.1 09-Jun-2021, section: 5.1.2.2.3, if
a target requests hot join (HJ), In-Band Interrupt (IBI), or controller
role request (CRR) during the emission of an I3C address in
i3c_device_do_priv_xfers(), the target may win bus arbitration. In such
cases, it is imperative to notify the I3C client driver and retry
i3c_device_do_priv_xfers() after some delay.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - new patch

 drivers/i3c/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 1a6a8703dbc3a..b04a55a1337d4 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -27,6 +27,10 @@
  * This function can sleep and thus cannot be called in atomic context.
  *
  * Return: 0 in case of success, a negative error core otherwise.
+ *	   -EAGAIN: controller lost address arbitration. Target
+ *		    (IBI, HJ or controller role request) win the bus. Client
+ *		    driver need resend this 'xfers' some time later.
+ *		    See I3C spec ver 1.1.1 09-Jun-2021. Section: 5.1.2.2.3.
  */
 int i3c_device_do_priv_xfers(struct i3c_device *dev,
 			     struct i3c_priv_xfer *xfers,
-- 
2.34.1



Return-Path: <linux-kernel+bounces-375616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B49A9839
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C2F2831ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E6B12C552;
	Tue, 22 Oct 2024 05:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lbiVWU0/"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC384A31;
	Tue, 22 Oct 2024 05:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574367; cv=fail; b=YWvi/VFkRc/qJdk8Mbw786iG8BkR2Pu/VoNFFU2FDtinfRj8nwSnWbCEeVQhhbnsGe5hmr29gRlSxqK7KpI2dUeNxvIQ32lTEd8UzPgLzi8AOpuPB4A7DRWPnI9eZQXJIszKKaTzwAu74p8SydQ+SCAH+BOAW9gzBhOU8mt9XL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574367; c=relaxed/simple;
	bh=qA5fAi1XePqDaSHoK2YqF0RxgqtWREMJupmN/KwyicA=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Qguakn9RyCXdJ+5QtdZwGsjbzvDJB1HHGWASqc2F+CaywO8sW1fmP4GMJJ74piK3Sr02Kne6O/U+59Gl02ci7lluR3owIuWSpQOhhEQbZuVXXT7cFSbcqe9ZuSqlSMxxM5DvEFt/WCMPjBCvGRTiAmutY+ortd71QP0jn1JYl4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lbiVWU0/; arc=fail smtp.client-ip=40.107.105.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQZ6Fi1/EIK0eoJBlGFYmDaPutDRSVBLWdfoVpifgGK9iV5IqgD6pgVK88wFQfS0RJP6429/CZjZQhTfKRXx44cE7zt4knDjiI4zx9YKOF5F6+1h6fJz8Bp8xGnqm+DXOUlD26zSNNUfTqlZme0cHPJUGX0OHgPow3qO3Pc/nPLbpgdSi/AQqM2FBiNwqcUfE8Te+vKhlHzNDAxnfOJhv95AMSpnjWQ3SZheXa1sMBAipU8mQycoftmkDWoOtPfvwr+FIDlEiSC9tLta2RLb2JB9rYCqDMcqVHd0s4HgD0fC+asBVpiAvbIadCvIXPO838nMXi4aKSFqtjjV8grpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JWlDLRqayejzDNUpimKGxKFH0qk/z77sp+iJCeOU2w=;
 b=jaeiPLUeEhsuIdQje95qDb5rcuw7PAomhqLAIp8gan280q01IhQ1Z1Yud8YtmFXoCFehI8dnKd4Pg9MA4qhkqTMsGAuitRfKt5XMFA1lOkIxoff/AX2al2BqGp+774fNoAFZHqUnU/Wdeg8y+fqRnjiSoGwOXoJgozSFJprTsai8Ep4uCzl+O/iydpaicfA4ut+1ceJq+azENFX2Gtq6ZnIdhy+rf4awPPPC/CsJxjFNE1fzIXEd22rWLqKe2zBRFKr9+UE+sqUG4wuk3m33kSwQjHGECOMnSxl1pFh3ckRCVSPTLrJSfd8KUdn7ygJQGxE4cz+/bpEIc7PClcigMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JWlDLRqayejzDNUpimKGxKFH0qk/z77sp+iJCeOU2w=;
 b=lbiVWU0/hyjLCB20qoPc7GCkbLhTnq4kmEn1QsRMAZrBf++xPv3obl69nvCvRnBPKILRclv867eYvfJ9/hxZft+uoUSL0ovoV5WYceGa6z0yOe91vY/MoiGOaPzNq30X1hcnJTayOn+iJcRzKS2WVQTkHxPGlpuZo8HOlwH593CuDgpaOvqPaad1FlpkNTDtVvlqy6EdKFWn6Il9Vc6Cr3cgW15M1fBFFqMApSF5/7HdpXBiYRMveHbNo5glNTT2wY2fZ7Pb7Lu15G9+DPP5V5pmwVhNMMR7S19EfG77Lg7UgbSWfml+KV8Bs8R/UPotnna4aAA6VKY5ARtDa3HHSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM7PR04MB6853.eurprd04.prod.outlook.com (2603:10a6:20b:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 22 Oct
 2024 05:19:22 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 05:19:22 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH v2 0/3] arm64: dts: imx8ulp-evk: add sound card support
Date: Tue, 22 Oct 2024 13:29:16 +0800
Message-Id: <20241022052919.1946074-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To VI1PR04MB7055.eurprd04.prod.outlook.com
 (2603:10a6:800:123::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM7PR04MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: baa40295-988d-448f-2200-08dcf2591603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?11o1GrpTC4A8ZNlFUb9F7mSSmByWN0ed+vaJlSaRWbWwY+Q81dP/g4XAz1KX?=
 =?us-ascii?Q?NoeSYgkqy0Rll5z5MOmvimhU9KwRNyfgJar6yxFPGOwyDu/kRSFzk9sZOOmO?=
 =?us-ascii?Q?5sbZnrtPGhCxiRoTW7d2d/o4UG1/hWxE67ioSg1oko5PwPtW8+kUPyHucFSp?=
 =?us-ascii?Q?wc5LpbYQ5UdPckubaIx7WZe391OKtAg7c9L7k1vzkipyaw+on8YO8SVzkiTx?=
 =?us-ascii?Q?k7YInS1nellGehNL7Cy3WDfaBIVcw8eIJi9g2jI9AE9lYRAQBheN7Oi5LI6l?=
 =?us-ascii?Q?kcjMouBPxPOcnKd1tIt3CmuOJ8TINBHmT5xTql4+e+qa5srS7h5rSZ7EJWij?=
 =?us-ascii?Q?nT5bfzSdSIaoRDXKnFqNPeMWrS/Ul/H/dgX4BdtwZ7U3kLY+b8XOAG5CuWvb?=
 =?us-ascii?Q?MW/chxeZFs78KP3nyzvPET3TkF496zKmlyd9JCCmGoJuGwqD/ZReDk0HPtiQ?=
 =?us-ascii?Q?zf2ZterpnD9JW+DgErE+i4M7S7FXV/+54hrzf3MLI2VHGNZeT6BAzuDQ6Ua+?=
 =?us-ascii?Q?vRlg/NHrBcmAwlO9hJoJwYOEtTqbsV7vQGfjUbgX46qw5sG2Lvzk8QrIeQUK?=
 =?us-ascii?Q?tCz/ULHns2R6gaQgfCxy2/CjpMQKRpBf2WO1msXM9+mpuS40Ojh1AMMwEzDL?=
 =?us-ascii?Q?MoBP+cSPdh4sd1ooxAj+ZND5GpDyy6jMh5U8MTuAJHJfpzJD4nbI/s4fAyiG?=
 =?us-ascii?Q?I+J3zc+vjW4BsbqgM/rrLrNNONMYreZDp5fcri/Vv4hyzebdl00/HQ8FaO7R?=
 =?us-ascii?Q?c09mNvadrjG/O1UC8K9vNqOx82wglWM8Rus1s53l0IvG/8IGVpYADNG0TDGz?=
 =?us-ascii?Q?Gi3mENiT5iInBcAoCCNTIv3eXKrhX9h2UXrTi/SXVeac1jE4XoW/tSSgsuKU?=
 =?us-ascii?Q?1ZrEJFuA0k1q8SdD4yBw6lSTHS94XrcU40gmsrUxUZidiz0AL6hGLTkohSBX?=
 =?us-ascii?Q?O+AT96iuIxOsvHYpl0mcF8BRUaO78OfhIVhbcrVlzoUfQQak9OxMrKIRf4Z4?=
 =?us-ascii?Q?5VEfnaUYaX4wDyepxHKQOn8uYW4yHX8Oa2aUqLaegA32c80m/VIJWf/NELw5?=
 =?us-ascii?Q?qTxGOIaKQYeVTNoSj9zsTCGhekQJU/m1uVFc3rBmdNbofjUH9QUt0XangQQu?=
 =?us-ascii?Q?GS4UAvSisJYvaphseTgz688FBGol16XhQgeTcRHdgMKznCFq4bogyGTreCl0?=
 =?us-ascii?Q?q2LwMQX9LjkC+fIcXdA8EQP1ZIInhbkX/9FkKyXUUMP2Nte3IiKDqZhGfbh3?=
 =?us-ascii?Q?UwY2nG6SSxLBf0LE5jNYiYheQbbU8A9UNb0tADIAz7sXPeUVMfGITVArc2tD?=
 =?us-ascii?Q?Nguou6uH0TkZl+gNUR9MMcAax4n/z3sKn8i33opRKN+5/tRGKkAYZOrszoHP?=
 =?us-ascii?Q?wbrsUDpRVi4KGH4YBYELlxFaIvus?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3E2C6ALnUQh5594Bx0E1i8EWuJeVnzrc6n9hiKFEyJzv4HU8xN1wzHF+sZZ?=
 =?us-ascii?Q?1yburweeos60wECCoo+dg9HPvOzqFUvMHqcb36ZLgvT18d/p5XucvpYBnzim?=
 =?us-ascii?Q?tp9HLu+ClnRyFBpHaYc3t0Th4QsNqGwb/hbRrKwXiIoajc4A4M3Wtu1XiFOK?=
 =?us-ascii?Q?Jl1tcyr/7ISi2YyxsAcy/9scRSKklSNZrqGi3uxYZThu7cbCVm1asUmuduZL?=
 =?us-ascii?Q?bETE7juOhODckMbZhES9mRGQ6O1dkr1SaVMTGLOVtlnLQWK2TUODlPc9lu83?=
 =?us-ascii?Q?v6TbG5RxflwWojWRMD4fQi/VcJhIdMDPkIjW0EmrekGDEz3REljt5ytGG4Qp?=
 =?us-ascii?Q?wRGPsbGrMDB51Q+mB7kLrzWerAfwoD8MX7/QMMTvsSoIe79LkdPJFeg7dI0g?=
 =?us-ascii?Q?v0KftM98xmiOxNsSUkuLHTR7X9KRicmLP2/NUll8kfEhex1whLtGbNXSXHcS?=
 =?us-ascii?Q?8k3AysNRUBTPXESDO0pxQ4qBkO47bGRvJlfkLmgyNiqVaiPWsu9mIbkYU+7h?=
 =?us-ascii?Q?mRm8+MM87UvaMyQwFGKp7RjnGBXPJu/jBPzc72kbHYiPMZeNW3vmNo4I5KlY?=
 =?us-ascii?Q?K09Nuwqrjdsuh8F0XsFVaOJf6vAo0JXydjcKpW5Ph0drcEjq6qMPpJ8pfPy4?=
 =?us-ascii?Q?HDQ7Qu9rS7yr/tvM8HR3WlFEXMEk+OtEiGa+NmAF4xTpHugPBmdFZxQFMIoq?=
 =?us-ascii?Q?RaZhWQ33IKVs/mcgGc/l5BawDNs32GesphRSb68qrciXzQt93eDhQJS6PFj6?=
 =?us-ascii?Q?UOaVX9pxqmVj0gGjHqAWG3J+krN5PKkXq+sgWQDhFgpG/HbFgy/dpAdbENKb?=
 =?us-ascii?Q?2uxWBYoZ/UdVyIujRFpsN5MG7s1TBbiG8qUPkFUIjY4RDQpub4HCZ3/KjsiF?=
 =?us-ascii?Q?PXpzfO6xSBsDPh1hNqBqhr2oAqJe5BXelre+PJ/0bIHwznXgiYppvXp3kt3S?=
 =?us-ascii?Q?xxEoGJzWTanRAbR8hZfRGF7foP8J1qr4TndrL9tv4QlS62RrQkjplFWA5jJR?=
 =?us-ascii?Q?A4PVFP8lF5Aqwq/9KQw58Dl+hwYR33EaCWo/Rx1BjYJvDHB19vQMk8BWAFXx?=
 =?us-ascii?Q?jabXr/ZeFotFJFT11xKdBuRCDm2ajDgDRGsO0XCzCjyW9pNedLmNUoeU1VyQ?=
 =?us-ascii?Q?Qf0PFi22iia4X+rK7e1q9SVlt7RflUhKoh4DQDLKOhKzCAVbRnEWSikBFobZ?=
 =?us-ascii?Q?p4xeqwC5wS5mxgLJVaBqZvWg/kT1BdXZOZ2pzB1qBIe5Dz4VLaywz3x6J3Kd?=
 =?us-ascii?Q?mIx5JwtJqXnzWc+v9gGFQYb8YQQuR6aYfxs7memx8W9RRhTlI+ozTmabjwzB?=
 =?us-ascii?Q?wwGJmr9bMhOZ4VfQLENq7nLVP1OaX5Ei+97/dXeKn4Z7jvJMxEjYc09AjBwp?=
 =?us-ascii?Q?Ir5nxI0HfG3/MXE1ZHMSC9bWJEjYvfI+uOkrwCx3xBULJtBOCyaYaSLkyDZV?=
 =?us-ascii?Q?5wVPRxttbvZVNDD3ULis/BETnZchk01Iaku/5Qi53UumUBANyPFuSaEdGmH+?=
 =?us-ascii?Q?jFxH4TSzQX3foUKY5g/I9p7H/Lf2HCJW0bX5UG3iuHRj4EdGh8KPbHPWK0PT?=
 =?us-ascii?Q?fJt3aIRpC8z6T1JsvbQWRsV2HjLph8Ii8TJHbgKD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa40295-988d-448f-2200-08dcf2591603
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:19:22.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4K6jYWf9UAKRVQ25PjMVabm6y+8PNRgnj6JOfwvLrUUPeA+YcrQ3E9Ws0pe1/Q6WQdj8QoWNfrh6AOJGX7f6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6853

add bt-sco and spdif sound card support.

changes in v2:
- remove 'status' in edma nodes

Shengjiu Wang (3):
  arm64: dts: imx8ulp: Add audio device nodes
  arm64: dts: imx8ulp-evk: Add bt-sco sound card support
  arm64: dts: imx8ulp-evk: Add spdif sound card support

 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts |  70 ++++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 212 ++++++++++++++++++
 2 files changed, 282 insertions(+)

-- 
2.34.1



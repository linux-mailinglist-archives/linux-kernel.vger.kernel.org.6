Return-Path: <linux-kernel+bounces-233162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D89591B314
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A34283A90
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B431A38D2;
	Thu, 27 Jun 2024 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cDyACT4a"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507601A08AA;
	Thu, 27 Jun 2024 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532772; cv=fail; b=Kzf6795fnZUcC/chT7JXytqm7homBZgNrmEZ6CnAmLis9w7vsgkdUhArn2EAK7OU6+/fYfRMgI8OTR/fstF7eJFFQCoq/sGQBVC3REmYoRY0O3F8A2ASCXRHBsGCqUAAztj+fokxgEzrS5p6dTLfHNb/4d09JGgnae+kO7/Z5k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532772; c=relaxed/simple;
	bh=cA4S9ldsMK3tMb4eB31AH8p7gJmJTZTALB0x1GxEc/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MZpYKLgmW6ClEh7wVmyaVF6qmqLSpsHlVQh9Od7gaHjl33zvRLN8k45G5TUPtUv+DRS8uOIMCsqIV3Zs5w7V7hD8zk+1QXBz4f+A5q4niQYcTgsal8K4q+acmZStg4u32UMMGn+hH4jngXibSXWRGxlUpJJru1647bPKxXIBNSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cDyACT4a; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqjFshzb1MgFXfySEfvNp4QtOzXlFp1j3o5LCkA9vAVWwVJaJKYJd/p4qqbLnYwHKL0lq1/R32QkAALKTGday6aZ+Wg//dALAopYTew+0g9dDJoOlH02s/o38pK2yDrFMSjm8PMf8goI59bn4XOAT/h82GsI9TAfLItsvqCu7CzMFWaLEntDwjLt+Xwbce8iq8ngDeD82M5xd3d/lHMlXgKh7wxxyCA7ObFxWs6U5byxdtgaPexDkAa+co8ezcIuNnFFOSNKzgHMJBWoMO78jxI9BaK11pDwMAb6Tc3fcAvxKJHEfz8I7ZugXOrbAYRRttfW+B3+wAuw8tNgr4FVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA4S9ldsMK3tMb4eB31AH8p7gJmJTZTALB0x1GxEc/o=;
 b=bMWa27B5wmkxYvFNHlVxCEP0jessC/MEoSnAo8yGo4MREQK5J1p15cpw3OI95LLy2Wpsw3HDkfxzHr6ruqYveqZudL7SKNx6p/55Rn/bWAYjhsZ5Yaw1pqDSTrvFk3VKFejYXJEWNH8Am4AYs5df1dwXWSrbxJspctyAzdcqjzjscx+p4+RhPhLXrDI06JklFlOVJrcOxLPvBG05Y6vpYsQBEfXOKAAQExLn+46dm9b0UT2d07e8HFDfJr+WDnDIZcjLTOr+ujpgTv49I5TEQv3XD8Mcf+C2lG9zMoGbUzw3gED5KrWIjnThRHALAhQ1+7Vf2gqf6d7PqpPbBVYL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA4S9ldsMK3tMb4eB31AH8p7gJmJTZTALB0x1GxEc/o=;
 b=cDyACT4arGuwTJ1Zg6/p1gHTMMEzC/FB8EAksjf8MipxSP/lL18z3+PaSiVjwBSdFlAvk0E5GM4avHhUcqaB1bK1lrvgL0IKSuXO/6WFxRCF3UTrwMzNogzowHlP6e2qPRRFG5ZflW/ZS3iEWSGD98eajP85MYBONSQvQhLm/HU=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DBAPR04MB7237.eurprd04.prod.outlook.com (2603:10a6:10:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 23:59:27 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 23:59:27 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "open list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/7] arm64: dts: imx95: add edma[1..3] nodes
Thread-Topic: [PATCH 1/7] arm64: dts: imx95: add edma[1..3] nodes
Thread-Index: AQHayN1v0+wFKp6Rak6i/qArSq508rHcSj8w
Date: Thu, 27 Jun 2024 23:59:27 +0000
Message-ID:
 <AM6PR04MB5941F3D425422792D6AF2FD888D72@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
In-Reply-To: <20240627220001.692875-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DBAPR04MB7237:EE_
x-ms-office365-filtering-correlation-id: 60464c51-0aa0-465d-00fc-08dc97052da4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zg3ZHIjR5XZr6CisSslI1fvlLFhqQd/er4wgWT3ywlg2Ypf1xKPtYAcvhsst?=
 =?us-ascii?Q?B7SrZJkcQKnHWrQoD6+3DQOIJR7h0PNo4ElP/Kc5BNWOiXOyJGrkDwNB0R8X?=
 =?us-ascii?Q?PnuTrmFX4pfDk844PhPsP7+99aHctE1x8qJsll6j+r8v+wGP6H4qqXgTgk3+?=
 =?us-ascii?Q?50HPc/uC9fgfrm933DxY5mwlPkftto4Ls0zI4evi4CB8RXxyk8cbT64KJx90?=
 =?us-ascii?Q?v97bvQTIp2UWwgHLqE+wPmP3y7XN/u3r9T3CZFgvwj9TUS9H+u1kjY4qxEVn?=
 =?us-ascii?Q?QBQxgxX9JHNdc8Xc+U6QcTZHiBsf2eBy+VAWJQCUqh2pmL+anBAHTWIfpmGc?=
 =?us-ascii?Q?vL4nGofIpFjrZj50FpbUXkA3/wXeWyYmFX4B0Y2hZARKTCgBshd3HbVlfvVj?=
 =?us-ascii?Q?4+GOrJDDabh4US1fPTwtRksCOpVI5fOtQYuxcVWDHpuavoTIggG1ACdZ2E++?=
 =?us-ascii?Q?7tBR5NuYZk24wFJu2CH5Q32IbnYxF0SYWKvTbf64m2VLe2Z+/xDMDVvOcBnQ?=
 =?us-ascii?Q?SAOTUdH+V3o7uWvaUPedXg0zv5zj5kcjMIyz1ORViOkiy2jHoeDFBzhLerI2?=
 =?us-ascii?Q?wEqjeGpJHlFkfj0j9AX9kpjWpw6F4gqEvSSAmHMV1zh4BDguzGr2tgWAKTil?=
 =?us-ascii?Q?SslPoHTkMHO9qZVlxMVhDrUDGwB8RI2A0yZzKPwtLG7e4n7s8Nw1sTMXR6Zq?=
 =?us-ascii?Q?6ShCkAsouEfFoUG7Q3FS4+r/ZvmgkR5uumZxyqVlf4Nits/roZ7CT0O9aRLF?=
 =?us-ascii?Q?k6nD7QlDMPOygKON50ZamfLr4szCdjhQPGsnyXQANHMXEB/QymEURz2sCDgU?=
 =?us-ascii?Q?Ac8GT68+a3+jU5dR7jNQml3rFjS3CjxDWHDQCKRgKp6lYl4l5jdmxpqEnw81?=
 =?us-ascii?Q?XzJhjhtjpSS1bI91dvKXqhLOR9zACQ7jMRFjrxdTvbT6xyYgByM5ZSWStwhX?=
 =?us-ascii?Q?EAJKxWgpjBClferdj5BJEoNihn+cqJqJtPtX+eT6rPtgvcNOK8li1Eb6e08M?=
 =?us-ascii?Q?1cXviU6lQJ7cMDFiDUvvMVYbSYWBPXQ4z63HTXpQtZ2AxjO4w63kQx5EIgwJ?=
 =?us-ascii?Q?ITTa1xSe5lVS/7tRYEjYbLPgM9PziDHepxunu3pnH0ejXm1g+j+Tp4JtrqQD?=
 =?us-ascii?Q?cyDIGS3+OGo1EqkMRAJjsFNrDDlr2nUKuZjahiYHrQeFHSCFi8/X2q3+WwBO?=
 =?us-ascii?Q?Sf5z+ug7fheQKLH0z8VILEfnY8HVTufhIsCFEimQeO3ET1ASv/Pj9n198xAQ?=
 =?us-ascii?Q?mHBFpgxKhp05aNZan6M0UBAmqPEwNrgzCWDt+UPrvSbSWzhqLXxkM5MBuB6I?=
 =?us-ascii?Q?IUzXoD9s4uHl9d7tVARzWlfW3vSZ2nBCqbys2F2x1Ta4L6eua/OrpX/dbAkP?=
 =?us-ascii?Q?fJ0JGKhY/XVuLSG8Wwr+xlCmMIanGyiid4KetZFvpnLBWTnma2XBLIqhg8NG?=
 =?us-ascii?Q?s/C44i49TNk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1gDp+8NznTdMurYQB/bCf6Bhjy2VJF3sjmuljkOQ7UXevmEzs6W95S+7lTOr?=
 =?us-ascii?Q?ph65i5mgfOxpPL2GCXR0ZeUfDyfD6HOpUHQ4HutXFnPBFGPkTgTYuEmKCR3e?=
 =?us-ascii?Q?kIk9CNVcVnLXASouRgCVOFJUTbQl+vxrodBGUTmKzdKX2yBtRpGzS7+5mv/e?=
 =?us-ascii?Q?eNLGvSjYk6ZuaFYXZFO/8ux0cVbN5AXKzH6EGuelDAnQQkcSp9RNmV8n1Dc9?=
 =?us-ascii?Q?qvU3JKBN3+8uRxZ8mXDWEoUnQTkjs7wxT9LJruxgyeHFmXMXNsxFgkFdV92J?=
 =?us-ascii?Q?L7hBveLRI1qOZMi/MW3zGu5a4novH+izJh+hC2swGYYEJPvkMy3MAY4dpgv5?=
 =?us-ascii?Q?fP5HqMU5yHKdObufmjxw/V9fJJ7REBi+CqPFqcrmITKdR/jJxUJE6rKggrUi?=
 =?us-ascii?Q?m0DhjuA9SkxenzDSPehG7ZlOkK2bVCxptBmgirJXw/gol39/gr9260lyfZUE?=
 =?us-ascii?Q?s4Q2YFOxzRscMpzkMrWhs8DhSP9IWpe1nsHYGaLY0/pILlmMjHqX3ODS5byS?=
 =?us-ascii?Q?/bNFHWSG1REtuy7lkVSLug5YGWzNGJAk3xsfrZ2ZwP0sB19+cfkK2iig2YiP?=
 =?us-ascii?Q?cYqMRcsk6DZvNhzN30eqK6Y4sthSyxmbi/m6sIN6VYozshBcTaKEGXFZN7Lz?=
 =?us-ascii?Q?nEY++fh4HtJ3aGLEtK0ytL3PXpv5MEqqWo19IRvm3Dkw/gBFGi2o/JuJhkzy?=
 =?us-ascii?Q?rf7WaPpuuuy7sVCc+Qe+tz4HzAr5gIx39Rgp1p0detPcW5RJiSKorSjMxiXH?=
 =?us-ascii?Q?fVYVjafkWOmgGNg9IfdoL7OloxBt10pOieNo2xU6+prHSfwr6MCNNUvtOQgn?=
 =?us-ascii?Q?L9ZqCdrWZSd+Y/pqHZlcTYio1pMwRhYG9QA8z2bR3Muvz79SIC2WOzV/iJBQ?=
 =?us-ascii?Q?p0Yyn6DXYL948XAvgcQgH5HX5JttJeU6WKHsnkrK1M8hu+StQnndxhtG+5B1?=
 =?us-ascii?Q?rV/wGb2NFUI6NM50XDqa12yGfvMD+bPVsLODxtOi5528T9sW9xfG8onV+X7h?=
 =?us-ascii?Q?mNYmQqTAy/EX6F9PLfmRwtsH7i0LSZYgsuo/VuI3+octYsct3KIKjt7lfMRJ?=
 =?us-ascii?Q?VsdgyKDN+si7wcPXZzvd/X1P8svCURcPacqJYZxSTX0MbYW1X4/ZCaNRQx7a?=
 =?us-ascii?Q?2lHLgsbJu3i6D82xkgG4mUFTwPtxETKtllagHqpAUZPSYpDMpRdv6Fro1UN2?=
 =?us-ascii?Q?8CQ2vG9YEVcljwmMxajQ4FJ4BPeI1BhKUALnzCjXbNlB4maM+L/XyvzOiOxy?=
 =?us-ascii?Q?M/V4+vsG0bAhRFmsqEy9dEdJzdXYuCHzkWGA5ajmEyFHTHt2REGo6DeZw5Sh?=
 =?us-ascii?Q?7R8YFVaYlEpI4UhqAm60XwsNOApsGtEg84aL5nHri1SGS/MU3CTf69BIa27U?=
 =?us-ascii?Q?Tjub7aP22N/IXilL6jbcB3IOdvgpVVO9AYyWMEn+Q/YwwQgUSzJp018eUAIS?=
 =?us-ascii?Q?Ecjql0kKcgNmTBbK696qbDOaT5fENjfxvtIc65/H70Hi5roZkj8Fi8vyFllm?=
 =?us-ascii?Q?L5GMB3huYWZXMnyGggVpy3IsG5bPtL8BzcirFrp3jSoL6o5O8y6Q/WbtFpGI?=
 =?us-ascii?Q?Bk4zzUg35i6VzEr8ysg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60464c51-0aa0-465d-00fc-08dc97052da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 23:59:27.5811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mc7+z7dvgBl878QwnUuVBvG8n9JSSlLvyeGiWfylYQ8JTddY5eHtGOOE6JYd0cmGkJvTuqyVBqzKK61HTHfHbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237

> Subject: [PATCH 1/7] arm64: dts: imx95: add edma[1..3] nodes
>=20
> Add eDMA1, eDMA2 and eDMA3 support for iMX95.
> Add dmas and dma-names for each peripheral, which use eDMA.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>


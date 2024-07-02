Return-Path: <linux-kernel+bounces-237583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BEF923B24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847371C225A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD889157A61;
	Tue,  2 Jul 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="px7fKEdD"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1D157483;
	Tue,  2 Jul 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915259; cv=fail; b=dOB9x1JK+zLY1MBAJm9FauBJxkLN0DLd6Q1ZpGOTiTaBa4Xosr7+HCLM6vxypJgjyNNChaeT902bB9UeUutUSEuFe7hcr0sb4sfbwsYjeIPji2ifHeysM/uWshBYSppN5yS3YiDTOyAhvTOidqQ0fGglWscM2qY7EUjtHOusCgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915259; c=relaxed/simple;
	bh=netccLHQ3C1Vtu11xm7yMgzLiN3po910nesUzBQem/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lvgiubO6BGgPdnK8IrZ/nSg0JKUkasfMnAokZFDKJbnzDy6df4G+FgK/9E2kXnrL3NDj9ta5MOQT/5rp+yzCLufld20JNA6NB2xlURhYzemQiccXwic2Z/OlNxJZMxaDBPyzC8k8y3U4HvOpLraNj6dsobzLN9WMySNEja+R/yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=px7fKEdD; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+sa+XtOz/B7cTTs/sNuSopSA+rMJSB+98AchA5rrsFaZAg8QLG4X3f15Zn8X891n084jDs3vyGOv3tnJKlAAYxuUnxpMgplfuGiFJYZZD0qtUzWAsxoUvhWQ3y6t2YG2ZMQFcVsZnY6YAqbNQM+jEKsaryEyFweEbAE02hhnyxIeWYd67/+GU2L3xia1VvW/LB1DdviuVioTJ3RISZMNOT+Z4/C0tqx97eFmKpxlZBrVqvt/uuZ7nFtVllSKmWSBbJuahpz661BSbdVxzSYyEsFIKP9XjUWl+NmSdt1mA44qNT6nOGL35HqYAB0QmrWFFoOEmqzikGBg7CJ0vegwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=netccLHQ3C1Vtu11xm7yMgzLiN3po910nesUzBQem/U=;
 b=J1y3ZNnzc/exw9QZQOVWanv6ZaUSdLt5MtRu2i7hfj2YuLF8QsLGSjNgm+lHCjPTuwQxe3VFxq1n46i1kYONqSwtM9CgYdN43qVVR8e7ZP+Glz5l/PVHouMEvytBQ38SE3iBP1YZQ0lEG5GR6cWPLWQuE1s2Gc+0dWOGVup0bM6+eN8WH4zVuYDIgG9/SJXkvTPjjD2Z1XrdY0j/wi3AnKwtLFKJXdW9NZeWtdhNpa6438JzLOd7Umulql6+ELPapww34jz2HD1p4cv4SwL3sqjzIV02qZs1BnF01RFt10jWnVUChxzfc3UrVfL2/eIDnSyZyCewUJqWQWNgWwD+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=netccLHQ3C1Vtu11xm7yMgzLiN3po910nesUzBQem/U=;
 b=px7fKEdDtshV2hlXn8IH2Syc+aFCWHzclB6ZpiWZT0cOMC+ap2jdXT+SUjfOwEAE3cqo/RtbJQ6cCV5DPPTw1W4ch67j3RzlO6GTqBj/uad6fkWN+w30ak7Czj/bVdsb08A51Iugxu8oIS9GLe9iZXfHs3kkKX3sA8MYzYCPPIs=
Received: from DB7PR04MB5948.eurprd04.prod.outlook.com (2603:10a6:10:8b::21)
 by VI1PR04MB9833.eurprd04.prod.outlook.com (2603:10a6:800:1da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 10:14:14 +0000
Received: from DB7PR04MB5948.eurprd04.prod.outlook.com
 ([fe80::c0af:95ea:134a:5cda]) by DB7PR04MB5948.eurprd04.prod.outlook.com
 ([fe80::c0af:95ea:134a:5cda%6]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 10:14:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Diogo Manuel Pais Silva <diogo.pais@ttcontrol.com>
CC: "abelvesa@kernel.org" <abelvesa@kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "EMC: linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] clk: imx8qxp: Defer instead of failing probe
Thread-Topic: [PATCH v2] clk: imx8qxp: Defer instead of failing probe
Thread-Index: AQHazFdj9R9W+yCzk0Gpome//ZzQy7HjOF/A
Date: Tue, 2 Jul 2024 10:14:14 +0000
Message-ID:
 <DB7PR04MB594880A7CE8BA67F493044B188DC2@DB7PR04MB5948.eurprd04.prod.outlook.com>
References:
 <DU0PR01MB93828B0E6808E33C608BC0E29DD32@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
 <AM6PR04MB5941651E3920794104B3D24F88D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <DU0PR01MB9382F1AC496F22A20C074BDE9DDC2@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
In-Reply-To:
 <DU0PR01MB9382F1AC496F22A20C074BDE9DDC2@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_ActionId=feb09c1b-e3b6-48ef-89cf-48121eb19752;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_ContentBits=0;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Enabled=true;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Method=Privileged;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Name=TTControl-Public;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_SetDate=2024-07-02T08:05:07Z;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_SiteId=5638dc0c-ffa2-418f-8078-70f739ff781f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5948:EE_|VI1PR04MB9833:EE_
x-ms-office365-filtering-correlation-id: d40862a9-15f9-485f-1b8d-08dc9a7fb9ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PucJl7ITv0BNonft9VL8n7L1+nQSKWjBUjP7yLuaNt+93k+FfKgYEhVYzQtr?=
 =?us-ascii?Q?6+3eqXm1F6THxUZ9Q01MammOAAwpT2mk5Q+3SeomRPPKMSbgGGmkDTKJItAF?=
 =?us-ascii?Q?oXjfh3zkqEsL1+AkSO9ZggzkdBLSNNRHWWrQ4X3VZmfDB8CTDoE5xiKJ5JFb?=
 =?us-ascii?Q?pRUnXLVK7rRMjc5lIg9xEaIC4v95id95sJeQj5HI7/2AFCUe8bWakcd0Kk3f?=
 =?us-ascii?Q?CbQf0yTxZFy12EMmZ0k3jvgW6jAW3mKGERHE8z8/+Wma8L8jtlHa3/qqnR/d?=
 =?us-ascii?Q?UNH7gQNatsALuJxhpoTRzltU/qhPO+4o4XqQI+bqveZhwPQq2j24C0tFjzZk?=
 =?us-ascii?Q?cHOPH8tgT/dXoBy/fJfrfRgtuzs574dC4LbwkjYaVBKT/yQ3+KOANpFpXkAl?=
 =?us-ascii?Q?tcoxKAsT5rGppwfg7rq/LFy74o8WJr2UFZlmhLU83scn0c3G4LlsgDdcMeQl?=
 =?us-ascii?Q?aoNIGpa2lrSZVehXhS+uvD8gUWBCVfCMzdhrRttu7ycS2ux3duIUj8Wu+CEB?=
 =?us-ascii?Q?P8vJOOx9Jwi+Fe2gl9ncAUE1XwPMxNx53wNx+bKi6lN8qY4+QvSeW8Frstdk?=
 =?us-ascii?Q?UMmheIXXMwR+KmLJ4S/354IZRlvDRYDh2yVsdV9lz3mSTUIevyXBOUBgVC8s?=
 =?us-ascii?Q?JzKI0k+ox/ya1X1+uC77IFdyNG9Lyc05evkOkxXBEW6l6QQybFtsl1s23FOt?=
 =?us-ascii?Q?XMCXt+Biq00x2jZAsK3JxAr5ZIuz+qDuZoyDEi44oX3ve7fpd5C5m1mSTGnE?=
 =?us-ascii?Q?fXvydbYg4eBeNiIMvggf/UZmDVfPkwBaZopBReJeo/HzoZDUnET/c7d6BQQj?=
 =?us-ascii?Q?pq6m2wI9xETeUxdEVRyZS2NEIprUDL3xGhVpwd9O/ZrNBfNb8dyhq/EIekCS?=
 =?us-ascii?Q?Pdy8UMvltLFE8B3gtSL9ENfGnWPh8qzTBB863RkiO27u1ggPtGLSdbOzeAtW?=
 =?us-ascii?Q?X3njJvHbt2nwX1wboBSDJ/7f/ED8W8RYB43FV6ow8h/4qrfCEApk/3hKHFup?=
 =?us-ascii?Q?MLGSTagFhm8BDrM/YIPonC9Blmj+DcDsIL/fesZ70h8gBbZTsKdifUPznmwb?=
 =?us-ascii?Q?P8//2PaT6yg+VLQwU/76nrP+iApFwu/bpyedeBFU5QC751AoRS+M68ZyZo4g?=
 =?us-ascii?Q?JILcAuZKqQoss4O6A2uIfaIaJkmYPnFhRRY+Hkhkzr45mihN1WOayTJW4tfP?=
 =?us-ascii?Q?9orN3V9QBRboDfg3tpowHJ+01zC0M2fqUThuYS1IxW8J5063rqtaD1NLBoTJ?=
 =?us-ascii?Q?A9m94fHn/ovhypN6bN/fPnAWwoZ/FsqT2XY2AAnECyGN4crippJGcwMZ5CFC?=
 =?us-ascii?Q?tAcPuvVULXP7F1fEfaJHGEuIztQuA1z+bACrzzNi+tN47T5p3p1GLuK89MVc?=
 =?us-ascii?Q?vVSgZCiDRNop/4j43ipJswtnvBlKovQtaicza2L2glHanLfU3A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AMF+ol67QAUuCBpW7BrnMu0icbIpFKEO91bCCJto6kXJhOJVXHe5O0xAKQP8?=
 =?us-ascii?Q?60BvtpzK79lexBnh2+FJbuCV1xO6KX610PCyK6K/cgodBPFFYDUNWfF+5/4B?=
 =?us-ascii?Q?ycj0kLJXxDAVX0TvQGbYE4395mhsPqbVpbtSgFSq4MkQnpt0T7ZUG6rz48bx?=
 =?us-ascii?Q?qCd+wnnJ8cBBGt4cv3VcShMYCLkuVazhI4OiXLt81CZK0EAkahmV5VJEqQY2?=
 =?us-ascii?Q?82Mt37Jhz+KUsG15kx0bjGZhS17k5taAp4v7kB3V7vx1H5ce/RnbiqAMkMKz?=
 =?us-ascii?Q?O/ALPINqQ45rwTL7gC8FqLUTqTsF/+KWLCg8tcbTXl4cYz7RnwkqcV1g0j7O?=
 =?us-ascii?Q?bI6duhZYu4pae4GBhMy8QIEcvs5hCHiig+E6znFMh/ayhpt6gzP4Lhoo9+Ly?=
 =?us-ascii?Q?D40i01IgGs+QRWMygn4wq8Q7oJa8k+AOPvtMa70yBpUWz8j9VPDcVsVsjQEC?=
 =?us-ascii?Q?FnKw5UxTplnzGeOT2PKfF11zI+M9kWCVc+weYle89VjWE/lCTvhondSj234T?=
 =?us-ascii?Q?lpwlMQLuH8EvVktCSRCPFXRI562YZ8NjuNGk0U8zTnf4B20HNEvRF/qg/TBI?=
 =?us-ascii?Q?Bh/UIB6Aj52oFer6GOxs8AF7k5zNEwRpTTfbE5DiIE2xUANugagTcRjjLz77?=
 =?us-ascii?Q?xcvVtTDlu3VxL8Zwy+ovjb7wZ2/38r2OAw8LtFUwGtkDLuwloIidczTr+Kj7?=
 =?us-ascii?Q?AUSt8QE+LyRiO4E8/a2I4Vv2gAbHlMKjZhJKS+CFEBfhPsslOAH8x5+tTiBu?=
 =?us-ascii?Q?NYB5goRKW8osQi8OR/IDTOIgxsgmTJMOTdaarkzO0U0lunElNqDomU7LJISo?=
 =?us-ascii?Q?xryoSJBW1xSaFm6SXHII5pqEii+6tyWGjv8Ig445PFWzA61tSgDbiyTeocWS?=
 =?us-ascii?Q?VJ5pfjLOVV/rim2GDm8nNdebVaGuTyAbum9o/HNBVrSwZzCmPGL46r+JRsLw?=
 =?us-ascii?Q?ZxsdABeoDS2qR7aQ5VLn7QKE64UpQxtA2m59WT/PUUU83mStq51dJRImWRFo?=
 =?us-ascii?Q?xFIR+cdZKWUKXsZlnPNoeA7e0+SvoS0JSnKjdVV6GUMfDamaCyA6fTL7pfww?=
 =?us-ascii?Q?SLcJM5wu25nOuGzK0uEQi04SMPOCnjmfhMf15nXtUZSJkoEMvm61Sf8Lv0rx?=
 =?us-ascii?Q?YUoXAnYNQQOj8PdGYYo7Ir4DG1r/OWmK892inbahrAbBsnGM6DLxwmopPS5a?=
 =?us-ascii?Q?rxap2AaBOVnNhJCQVLGmdTbcmal7txSgTsAGgBKmDb0UIWxMSM5h5hP9+NwF?=
 =?us-ascii?Q?Wl/EJDSbc/pkrd7CoRczEspuNPtxyAo9rGNCnPPH+CJfIDWrJA8gGMg11eGC?=
 =?us-ascii?Q?UujYYOUyAUbUvb5n4TNCrqUQjeHLqQUbWWq+YIlwR6+Mkd7EnHoFoSZcx4Wn?=
 =?us-ascii?Q?5sg39ERnGZUZeLHoiKLa2KH1y9MNY/Nu90EKw55ErmVcw0+9WALONjdcE2CY?=
 =?us-ascii?Q?G1kdj1+higSj3lVturNDWD/JchSSjhKzZyjdEHu4iyp16ro2Gn91tTnwj8cV?=
 =?us-ascii?Q?+ZJkhuCvu666W5hbl3kqWVIsT967+Qj6vZl1HxTl0vwmJbo7TzRGtvr7yQ1D?=
 =?us-ascii?Q?l10tMhOq5QxaoszMolA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40862a9-15f9-485f-1b8d-08dc9a7fb9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 10:14:14.5698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHTniWPUmpVYj10J6WKVo+C7MkQy29rJhk1PSADjf/sQB4jRckEG+XmID+lznYZD0qfO0Qj7PtB2jhEeSPjBrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9833

> Subject: [PATCH v2] clk: imx8qxp: Defer instead of failing probe
>=20
> When of_clk_parent_fill is ran without all the parent clocks having
> been probed then the probe function will return -EINVAL, making it so
> that the probe isn't attempted again. As fw_devlink is on by default
> this does not usually happen, but if fw_devlink is disabled then it is
> very possible that the parent clock will be probed after the lpcg first
> attempt.
>=20
> Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>



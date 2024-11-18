Return-Path: <linux-kernel+bounces-412407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 968CD9D08BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BB71F21A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425513A89B;
	Mon, 18 Nov 2024 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DG9O8skx"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575EA33FD;
	Mon, 18 Nov 2024 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907164; cv=fail; b=I3CsSBPNQ8xax+wnXUtcJI92EYFYo6Q9J7cjtyQ+jf5HcoypeL/uXJvIn2rIQ9Ct0myEM6fuFGlgGE/IzzNTH5sZJvIM94AJjYmQiqgPzL782l7tc3QlvIXwOwnoaqGxnYRlH7Zmcpy6sdw44XNaL2ubUfeBxXnJgjgU9xemLj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907164; c=relaxed/simple;
	bh=yAe/64ZV6lGI7WEty13Vxe12JpNAMymEOnquFBTennM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aebn8M8y2Uq7ljalc+VHz9XVh3/bXDcqH9iRHVYw27RxHfJmQ2KF5WjNQqn5LbIhBrKotAyATbblOQTKnKBN87BHhBadJ+U+cO5hI7o9NtXex0vuyCvHPwU9BhkM2G+AOJMU7OlXqEqQfqGrmwAhGwCSPiaCTUAnsvN1haxs1c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DG9O8skx; arc=fail smtp.client-ip=40.107.105.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggbusprMn3HTiRq4T9n1079OGvy7u7O5Cw+yoA5vAyCbElU2D/RmQICD+z+PHUsxwO3EiB9etMJBSoSmQp33AKJ0Jy6revF357BEsP/wBoBuU5Jju1/Eq1RVyT9zSa1U6ZoWhwlcWsdJqr0TfWIN/lStQe402/4+NgDQ2+EaygU7xLveDtXwukdh6Ur2zqEgz23Aj5wC0QZl/oHAVjz7ZvmF6+JQNUcWWiWdiCRmv22786+GsNS8VYHyZozDCt8Stn4lthq1E0odn2onXx1MxCYPF66vzAyf5X8YNNSGF9+YuAgz4AmoJWRQvlDSCC7dP9b+eoxfUbU5hOXfnwGwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEwTvyWGvX271jza1v21caqYIlFSAYV0ATkPMxEnHVE=;
 b=hsRnxW+9uFdM+lFFRo5i04AIUTPNFrv402pq9hBUBQqz+LUDyqcXz1GFo5mmiRt6LN1AEqDV889nWJS2ukLnUJF/VYX/bPJ2WqLnWM34VrM9dZrd9Qkhl9gUeL7ttbr60h7xbQpaD7QvGuMoGQ6eMJzRtP/sxItsms01Ddvj11EJcWpr6eIEV5IOBZVKCY050M2r2Pml4hNdxMWCa3KTdb+nQ2TmuSa0nqCkzhiijhNfkU7efMlE0QYdsiG77QCtQLvA3J6fOECkDwINqc9MelyzRAOePiJSqAnF6vgWA1BokW5gAMu+F3H/GtyJOW33r421pfgXCz92ucydP3ht9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEwTvyWGvX271jza1v21caqYIlFSAYV0ATkPMxEnHVE=;
 b=DG9O8skxIpBerUm7DJIPuv9GpDadn/Tv+OQugdYFUlnOja6UYMczgRaSS5gjhNxMVUJWtZE9p2jre5ZaHaZikFrflG1jKVpnWTNKLHfAwUiPwZjdJNiNRK+chWleUkPogA0eZA5ViQcI+Zh7sNiHeXk84CL3KHWof9D0M59GG4Ab39lfMVrY+JoydhJf8zN0BDJb3hHGdOWYNZaYoQ1B7jb2SbYeCcb1IqLJmlCPqA/cycvDu7zMvlDqHrIK2Gq5oNkm9SAgILFrDBRtsQ/nsilSoEvkBDNEcKzvej9QIwVfs4MfVTxxYQncSOgy9/lFTxvyiIZIcdvo1vgS0IL4QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24)
 by AM9PR04MB7508.eurprd04.prod.outlook.com (2603:10a6:20b:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 05:19:19 +0000
Received: from AM0PR04MB7058.eurprd04.prod.outlook.com
 ([fe80::d7ed:56bd:30e4:4ed5]) by AM0PR04MB7058.eurprd04.prod.outlook.com
 ([fe80::d7ed:56bd:30e4:4ed5%3]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 05:19:19 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: francesco.dolcini@toradex.com,
	joao.goncalves@toradex.com,
	marex@denx.de,
	hvilleneuve@dimonoff.com,
	peng.fan@nxp.com,
	hiago.franco@toradex.com,
	frieder.schrempf@kontron.de,
	alexander.stein@ew.tq-group.com,
	mwalle@kernel.org,
	m.othacehe@gmail.com,
	Max.Merchel@ew.tq-group.com,
	tharvey@gateworks.com,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	konradybcio@kernel.org,
	neil.armstrong@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Subject: [PATCH v2 0/4] Add i.MX91 platform support
Date: Mon, 18 Nov 2024 13:15:37 +0800
Message-Id: <20241118051541.2621360-1-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To AM0PR04MB7058.eurprd04.prod.outlook.com
 (2603:10a6:208:195::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7058:EE_|AM9PR04MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ff7d80-9e4f-48d9-a6c8-08dd07908da1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?jeLWcSGLhES6fmuUCeuJBSCJ+gP1tQb5ePd1IFa89b3mtxmWFBgzFtmzhp9g?=
 =?us-ascii?Q?+0b5pjsO6VePjJm6USuppfAUWPk4xI44iRX7ec4Yz2v5a5uFxhKqfO7erwEV?=
 =?us-ascii?Q?TIQOCMPFwi0hZOxkWQhGnfTT/nwXSd5wcVKOv9G36boUvrmVm7uCdb0LmCgM?=
 =?us-ascii?Q?ROBACRL7EyaUayFEMwZw2798zW2eIhCpTkle5X/zBVKDH2rDyeeUWv3vl1A7?=
 =?us-ascii?Q?WB+1o/0UE2nv5P9BcaQ0voW1zDWVZUQde66hjam6V45DJku9c8fKs7hMSAAu?=
 =?us-ascii?Q?Xz5wqhXIdb5mdCgCWAqZH64PX31gxKPrMCd0+Afev7lMDD2GIIyW7NvtOjek?=
 =?us-ascii?Q?t+ijDYNMWhqWw7uRpq6MGCmIWQLNFIG0WsCi3nhbmFVUh8pOGF5T7BXD56rc?=
 =?us-ascii?Q?fK1QjrDc8SSbjO7OJl+NMpwpwheK/4wgf19ZfWwaIlGie+1FjGhL+MkSpfMm?=
 =?us-ascii?Q?lyQRcGCjgFspazL0t/3YPTnh7T645UEp/WzIdy89FPG1VXeNnChkfJGrKyDv?=
 =?us-ascii?Q?tHr1WIiyE7tuPMjqyrsM+kb2Z2Hzj14jm53+yOL4FrjO+amnaNJ0ROpl1ytg?=
 =?us-ascii?Q?Ede/tyWqAZBXuLTkbNkRSw/3UiwzsWZcQTNuHj0wnSgpb7jslH0mzQOlajLC?=
 =?us-ascii?Q?ai8rilZDoQXOfBSFz9egiqtrKnyfvmqw6deitzOqS9Yn4ozw06k2TxOC2Qnr?=
 =?us-ascii?Q?cZUlDnbrBt0dhacbI9d21QMtLYsQn5UlmBzIquWR60/8V6qB2TA1+o5xSVZs?=
 =?us-ascii?Q?VeVI1vVKjKQZEXLWmd8w4c8GzZ5/sNz1mAYyB1dnuQHB7l3WJAxBg8ePZcBQ?=
 =?us-ascii?Q?RCvp9gKFAbCQhxuQkbZua8sKTQM87FIUJsmBBtyJcCAkXhXgni8f5gZrs0B/?=
 =?us-ascii?Q?RpIUv2150mZqCfT5L3oL3iYTw+0neoiGuc/gbAbsVb+DxCGWdclAgI2IV381?=
 =?us-ascii?Q?xCPk/rKM71tM0qjGfBsdKToSA2fAl6yPbgWGkqKTflzgPyXMb8COYvtqSHB5?=
 =?us-ascii?Q?qTcDoaMmdHwxbu9oTuFVRelWUr1ZEXymasLgsZNYKnADl+3ALhZLBdpudlvB?=
 =?us-ascii?Q?kabHqEpaUD7X0OuiVR7p/wpRN2gMMM7A8bMi4IRiFkC1yY7fRp0tGqvL5Coi?=
 =?us-ascii?Q?GMskY82YD7W19bYQcVxPMcb/XKJZWcMdx4HYtohiNhPdwi+TvkQEIykfTlNh?=
 =?us-ascii?Q?qVXqeA1TrDJO5k15jwMkD79K7rHEl8xZIGNl6A+AeRgl2k3R6ofYr4Vfl95E?=
 =?us-ascii?Q?jgIcABovaZhaTW8BdsJSsHCAkvCtST/3/AjCyJJizJXVLfz0tRQtB5VjhVdv?=
 =?us-ascii?Q?IZblNJg8SJAnUJjapRdzkpbCIWEOPa6kNgLLufM8b865Prthno00ZjpN2rTA?=
 =?us-ascii?Q?Og4Fu7tPGeuip/sCKATeD2a8Etid?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7058.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?pKVbyOd18MR6qPb7EVPPrPLUmDDzHanxZgNtA8E9mT2h6NvH+gXkT34ORxh9?=
 =?us-ascii?Q?8o8hNUFh3TY1IU8NpFw3ArtybkOWNrTNMxwOeuBaSgCzrDU0K0b1mwLPJaS0?=
 =?us-ascii?Q?fcyxG9MK2e1Q/asDKCg/eR04mJVzP38mecUK3tBoLcuE5mUlt7njieVCCiaz?=
 =?us-ascii?Q?9f8+WbNgk1p6C1iHXATpNUu7LR4F2MW/IY3ISC6odi4R8RZvtW2w4p34/Z73?=
 =?us-ascii?Q?197mJZc13VsVS4M2OWs9Gp1su98D9tWOS2BDmQYJs6gEWJAHCUimQQFw4J09?=
 =?us-ascii?Q?92EGvyevIW+l2Iv1vxtKqtcVRDM+T+gZeRnpBYdf/6hx8wZxZ/+BBuAXmRdI?=
 =?us-ascii?Q?1ktYu6DjUQd9CYgi0DfMNSaMoaVNO72V6gYU+71O5zZ2paeiWrz8/TPzUM8m?=
 =?us-ascii?Q?xLict+eXO3YzT1yztsDsZl/PHNV5vXRelA5IG7uYGafDEoqcZAwI3IDv47JZ?=
 =?us-ascii?Q?wgEewzzNXuA8WWpm32Dg+IJw5ouwQCQEe9FkZkpYe/bNvFAX/fQWFsADyG3P?=
 =?us-ascii?Q?tBlzlAah3g6cZGwtY3Bi8EWV8OxXYTqCKtcYhgVDGev1nbFq9O4eH9kZ3V0L?=
 =?us-ascii?Q?HvfHzJOYXw61j9rH1+DRVObxt8687iez/Nu4tWGJwdeJVfgdgfiJ5feZwN4p?=
 =?us-ascii?Q?LSprtXDsIkfkhQ8KZrphlSBzuf6mJGV7e9Tc7o4J6Uw9ACzPDLkarCeUJskI?=
 =?us-ascii?Q?DYprFF2TY2WJa8+rlO55okNjSipKPZxEM71gjLTMcDkmVy1Km4GcGew2sh1t?=
 =?us-ascii?Q?wEUCxGY8hdqqDiSfJ/VmCicT1qfoJ2DM1/6/C4OykpZqsYSHXwGOprhokUgU?=
 =?us-ascii?Q?qhAp8uI173nSz6d9xSsk/mxkBhEu1x4ASLU+WXqAV7fw0A4MnaGanOUS79sf?=
 =?us-ascii?Q?UbS6rWxSGhvl9U77cCnsGO9B67OzK1069XHUauyLfPe7x6PlszLbPwQ35nj8?=
 =?us-ascii?Q?7t45dVhV59ZZNK4lZbixrVpyL1XrQmdyChwK3zvFC432eR8lBbNulZmwAg6h?=
 =?us-ascii?Q?InaKlqcWX/MYpqBK3kycuYoM3VHXP+aI5HTHmmkOjAA2GrsFrzzok/jWysEj?=
 =?us-ascii?Q?iDrhkF5zgHoyyC0dfXDg1PoZmV7HTxbwV5OQZYH/hrExpX2aZSzGFe1OxO6E?=
 =?us-ascii?Q?H8qHpaEPXRn5T86zrioQZ52RY6RmWh2UfWkyFP8LXfkPBfw2YaGOPXZvtDIG?=
 =?us-ascii?Q?t9UfsFM2069HxkPQdXpsmgg2AAjyX6sIbL884RuKehwi4uXWge9fLsmyrlIp?=
 =?us-ascii?Q?1/eCW9uv+GwneqIklthOTtvsMUTQCM3YY0UVMekSualWxQIRhZUICKco76GB?=
 =?us-ascii?Q?bqf8T54jJh7HXeK60NOS8aVc5I77xrTWAdPQV7IqNPf8/f8ZzfoPlpy3erJy?=
 =?us-ascii?Q?0/tL9EtafZdZ1zuHKHYzOi1Ppy+TNMKqKDB7StK2JNlg4TA/ElceDPhXdP+k?=
 =?us-ascii?Q?Sm5VPZoEJ8udm1fiFgxSoyBeaby6JhcY+IXPJ2xmI/X5ICdFJojExOztGHZt?=
 =?us-ascii?Q?PYM1QIitcZogI7vPaMBv0kCp/pC/3scdTgGIf6rx+CF0Z9enqo/T/x9ntcGm?=
 =?us-ascii?Q?8Vrpe0U9rqmjLFFFYtEw/eS6Ily3sZprs07qcSuh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ff7d80-9e4f-48d9-a6c8-08dd07908da1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7058.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:19:19.1794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyfwoED+VpFxioroylVQK3SMsZCkVZRQO7eszq+mALwDDtQJ8LPMYaXZKgcBzc2Q3z5fGya1edNaipWI8FLt1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7508

The design of the i.MX91 platform is very similar to i.MX93.
The mainly difference between i.MX91 and i.MX93 is as follows:
- i.MX91 removed some clocks and modified the names of some clocks.
- i.MX91 only has one A core
- i.MX91 has different pinmux

Therefore, i.MX91 can reuse i.MX93 dtsi.

---
Change for v2:
- change ddr node pmu comaptible
- remove mu1 and mu2
- change iomux node compatible and enable 91 pinctrl
- refine commit message for patch #2
- change hex to lowercase in pinfunc.h
- ordering nodes with the dt-format tool
- link to v1: https://lore.kernel.org/all/20241108022703.1877171-1-pengfei.li_1@nxp.com/

Pengfei Li (4):
  dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
  arm64: dts: freescale: Add i.MX91 dtsi support
  arm64: dts: freescale: Add i.MX91 11x11 EVK basic support
  arm64: defconfig: enable i.MX91 pinctrl

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    | 812 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx91.dtsi      |  70 ++
 arch/arm64/configs/defconfig                  |   1 +
 6 files changed, 1660 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi

-- 
2.34.1



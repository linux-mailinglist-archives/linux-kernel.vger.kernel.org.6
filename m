Return-Path: <linux-kernel+bounces-435376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 973329E76D1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FFD18856DA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA1B1FD7B6;
	Fri,  6 Dec 2024 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VDsB0Qly"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CCC1F3D30;
	Fri,  6 Dec 2024 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505188; cv=fail; b=OolRXKWuHSYNL7l0ax9Kum0/hSAy1eiFdmwCR6P7Dc9i63OjJ9F0gWE8Yh2VfBIbtIDJyLf022wGc0sX8UrX1LlATMbs34YXuXeVyiAe4YlEAqun5TjBTpViryKK0BMNp6sSYmWz82QMpwNXKO/Ub6pv+/PoAXqqHbVEWY/nn/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505188; c=relaxed/simple;
	bh=4LdR112CXm52Imu/EVsovUCsKvpaGyiLbHrDmQcdTfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cLA6tDZdGbMH7X5AJinGf0sUTEyJ8EFZ1mMgZuJqGci02I32os22LqUnAoR/xxvDUOhEDU67T9KOpf+arubvV+N9ueKtIFMA1nIezUQAc+NDkJeyWFa0UgWb5gWwynB/tYvDPn9EJiZaoM2jYsrdoIk8IFa6Za4Mp3cg8Zth0dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VDsB0Qly; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieCqnNZrVGdDWMPzUPMNlXN6HCK/EUbXGNH8wA0N4srfK6InZ3yKCyMa4L1gvlO+Vx0FlYmy4qdV01EJKtzAchtby1WF8aCYq6N3ntg4PAIaP73jwikVzTIJFk9vnfLY2caONnbwjG0Q+wvsaE7kFEwfkbt8f0PgEMhMTT7pjCvywMPY+P0N7j92P41vViViOCy8bMwWzhbdZwqr59YPG6m/kaP74OZg9tfoSsw0i3STeVQV9R/GcbcaOwbrAuFtSFV/flqHYpKfJelhysGFsgdibTl8/dRP+BVxQg7j6ASn9YQkQn2mb2S1ySlBlp/iEbpWrLiiHQiByPa+ABLzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wABbDVJQ3oZuPHOe5VSFmpGXgydhFhVxkVH0V0a5nXM=;
 b=fOjCIGAaznr4cjiempGOJPiFeRDQ+pbZozwIqVMJkqMka/s7P6Lx7JxbBVaPGxF0cjo9MjgcsogQCvrw9EOEhkJSoqyJ+HlIwuliIOlI3+LohuHROZcJ4N17cXuAtv9NcYxgYnzLFZJtHmvKLrlbW7EEkgxG4ZDoUx96TI8tGz1H9xRYbo8evLTha0kc+XY5ZKkczPBxXoh8Os3cx49585I1iJ+I6v9meetD317QnYkXeH+hSXDK0qErh32ErZDfIg9S7SZlCT9g53mO8q63Hx6p/llxom6vZumQ/l+Zt2bLo4P9G7N+F725lzc05PpKPHnGNKhBx1K+8oU+mb5jpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wABbDVJQ3oZuPHOe5VSFmpGXgydhFhVxkVH0V0a5nXM=;
 b=VDsB0Qly1W35mWmpEgt/OBy4E/1VGoK3maMV0qKD2Kj0P+TDjUILC3j+2dti11JjMg/+s5B3R8Lab6SEJY+MVapUjFR8khi7KwD8fkqpQfne6rEhhnCtcxv5sF3rqX3OJTlPo9RWKXrt65QQ+lNcaXuG/XLvhpM8bFObd6igEsrIhFds8ePli5ZE95apfWgN6ylgRwZbeQJ9dtTsqzQwlaykpeD4B2iAePaNb7IVpjb5k8bOyAFv+Gc3aLl7S+itUfKr5+z43uUrSkcfP/TFmzFK5HlCw53qGzGxAIDEoi+juu2TPj/ubXbQcPNHzQZSi0m39ZANpayKbtj/2K58qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 17:13:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 17:13:01 +0000
Date: Fri, 6 Dec 2024 12:12:51 -0500
From: Frank Li <Frank.li@nxp.com>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH] arm64: dts: s32g: add I2C support
Message-ID: <Z1MwkyWka3yDm8Ez@lizhi-Precision-Tower-5810>
References: <20241206123119.1688712-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206123119.1688712-1-ciprianmarian.costea@oss.nxp.com>
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 95693d6f-0b7a-4fe8-057d-08dd16193ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oxwf4riUl6cBMBn5Ve/TL5bKxVpvm1Tazzy/FJkqSWK6/uNUirsa7kaBpMwZ?=
 =?us-ascii?Q?CbMQVa1E5BrQ4Y48y8xgetOiYR+YJGDx1r6IfpgTr6QdTKaDsSe/d0LhEkzV?=
 =?us-ascii?Q?sjRSJKj9LCRQRbQMA6wBL6KdV34Ib8loqquwmgxSt3sPNW6b9dXxPCwDXDfc?=
 =?us-ascii?Q?FPPsUlsfkYcNEFEO2XPXIvC510rkEOMVMpANUgo9zOcyytf1ny6qy8hfxGS6?=
 =?us-ascii?Q?E6miQutMNkzfDZaFGlvExTKWlaeSwSSsZsrHejwHjlLyrjotqEvOKxiGUtWW?=
 =?us-ascii?Q?qq3FeSuKMf7k/mthXghpMmY7tALrCe3Dw5LLTUl16wT44PNlKwSJxsaojwB6?=
 =?us-ascii?Q?WwSdyQW5S9gHJeoVlbh6CSGZ1tR+eJFDqN/53gI2xcD4uUNXmQpKU0E4Qx7K?=
 =?us-ascii?Q?VS5rquD+VaCjxnp5ySOlWDBOV/krdIlXwh0yl3kdIQI88lhXyj71t5CjKOzc?=
 =?us-ascii?Q?LoH8y1I6o6cvr3/TlzArc1FzdZaTpfv0HiCVBg7DdTivv5NwFlw2gu/Uv/of?=
 =?us-ascii?Q?SgvwbGKEmH52nj7fK+0UudPpCfXK9jM7YigIjQpbSiBZ11TGcGJOt9zLhDex?=
 =?us-ascii?Q?kbAZJe7uRCkd/d2chUOtjWa+5Z89bzxs0OcEddFgoImXBD0yymRrdUzUX7hY?=
 =?us-ascii?Q?xAku61d5zvhsm5D9lqxXzH5V0+p7UOtJYJHuH82U78RaEUN8IIIdalIXWEt6?=
 =?us-ascii?Q?+QEmK08F4VWyZNWkIVXZxgh/lhhVaXhApy/3phitLhHQ4+Y0wgZWGPE58Msf?=
 =?us-ascii?Q?s5Ge6MfhII1LoGTuUjQMvKEed9Kk7CXxGQqMQSf2hEatMZ6gMMCuRQLEDfd2?=
 =?us-ascii?Q?UtXucMGkyTdUEnGh7XsNMtWIKlLfmUlHz+fF9CKevtzEKWvDZ2uil8kwHc4p?=
 =?us-ascii?Q?KAbeHDpak12F3aPdl5aPyxzOuxR8iVeRaAlXJdErOz09RGH2328cZuvN5F9v?=
 =?us-ascii?Q?k9inUOW2JdndMYPx9aV6ZABVjjj88nu5riaLRmig/cL/3SL8tJ7u5reicYGG?=
 =?us-ascii?Q?FIs2ufKz4iyaM5sPe4gGyWuIYhH5NsD0Hxp4Xblxttcga9Zca8xOkz3Z45fq?=
 =?us-ascii?Q?0Z3o49JHP8mV/wVS27cxQVygYAawx3e7CyLWqfKL7U1J1tn7XIep9xn3rXrC?=
 =?us-ascii?Q?Eyey36r01yh96lXXWkRmhQN9fbrXthZQ2scSRHLTxC9UaV//mgwImQdqbgbi?=
 =?us-ascii?Q?KQI3wG+vGtqYaENleML3XKU40CACqdWxTdyl43txAQrpRpGxGE/z2tJbivWU?=
 =?us-ascii?Q?b3Os2peQrNRmIuo9HWvX2oR632sfyJVgEudZOcGU7fQ5JbRgy4DHXbMbdfhD?=
 =?us-ascii?Q?MIn90ssj8nJ6Q/28BR5Lfg4EJl1+AymrMYh1xSbG+YNsR2tvQAA8sHY/4V6W?=
 =?us-ascii?Q?4htNRNGOH/jPOdQmO498iH7IAXuf1uDyg+J4bBy1CCl2TwHKDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EEkec0zk7FQ5eXS20mKCJHukD3LEzacSdgg0+YrPKmwfkmE8OGOtttogm03c?=
 =?us-ascii?Q?/fs0jSTQKGgD0ki++b3U9wQ8Ldt2GqE6qIIA6ibU3po3IwCpat8SqD8DkM4e?=
 =?us-ascii?Q?+DpYIra8pCP7Z3LX/6tqkC2ZAHU+yRWSSn6DM+cCa5nG4Lt07W4qLxljKqBX?=
 =?us-ascii?Q?enQHN60Y4X68RtVa58DXCNVJ2ExNQWqTIwAfmztleWRfW24g45b+GbAdq25W?=
 =?us-ascii?Q?oxfFlcb/r3mcROMnyuXewLTfrbVii5ca9/mfeBE+ugEWdMImhl+VzR4hsfUI?=
 =?us-ascii?Q?uo2ccO8I0DF3f+cZWMqV2hFhZg4WG0EIpaRUO3vsfiAwsuAw6up3z5tp2ljX?=
 =?us-ascii?Q?qpqMx6sV3jh2wNnWNLSSm8bHsNNDdf8FeVXql+MySQ9DIROpC6MBAAzWOnfZ?=
 =?us-ascii?Q?uNaXdUZ5wQPfRKDDhSLBJO97l4qW7hTZ14SC+5eHiF5PzKbk+LZmUbmSE3HU?=
 =?us-ascii?Q?H9Jyrxnoj9rzk8AL/JTKG1PCoFTb+S/Z/oZF6oqlC438Z+koVIhukZWgmmQL?=
 =?us-ascii?Q?i59EoXvz1q8PYu0OZfJS2ICGiCcqJBhqRCtAS6bAb296ORxooq5MrqsOUxia?=
 =?us-ascii?Q?UTJFSowEhIwcJnkMDvWXGax0pKkSYhHtmknM2aLBvRA0fkEy/Gr6HH4HVyNS?=
 =?us-ascii?Q?+Kf5Q3ANNs1/Z97EIrIH8Eo+Dcq2rDBZzF2D/CJ7TE4W7q3NnALHX5JfJMuB?=
 =?us-ascii?Q?m4bWO+u/gvQRHdU2YRfLgol3KlyGUrXe8T0JyJq7dXvwi90JyXuSYCFFTMQH?=
 =?us-ascii?Q?7PgGKOSU+xSWaLFlfsTfJ1m4mr3SOa6K3LIBY1NzdKOg3L8k64zTvRY2cLTN?=
 =?us-ascii?Q?aqN1DDip5CE6hHsl6tN1RfXu4i1NYpUcnCXa7uYz17LB0AuLb0R5wIrPGYrz?=
 =?us-ascii?Q?egbhAZj6GYDIht8sfcU/WPe1EN1vDKXPYaQz0AY5YZpPXJNoT6GqpgdQdAWD?=
 =?us-ascii?Q?g0pPyn5BU1DhvKDV/bke8/ciGP4lbCKZSU7D1BkMlyXfn1YJ+ZUKWmztWA5L?=
 =?us-ascii?Q?RGNaki/X1g7t8JSbabT2QBOG4pYaEENMAMs7Zyq40eqZIKitLeqvirSCqcqM?=
 =?us-ascii?Q?HEq3oko96X5QndeOVPyOeWE7WgWZfUM0pGQK9t/+jBcTTeaozlk71Q6rfH+u?=
 =?us-ascii?Q?UNrFh+3xHLj0DciM+IRNNoybsF7pejaFfaXNrKTdqhOIZ1ojhcYCgJDkH3ca?=
 =?us-ascii?Q?76I/d2j8U9BY3YOXx7JzNm1iF7z0Yb6J4Kz0lGtGH6sIoQNd/MJgXZGoRmN7?=
 =?us-ascii?Q?R2GdS4jtC5FJVBlQzApRaRsIbb8Dua7hLX7H+SYVMvKcX3t/OYTNMyLFh0W1?=
 =?us-ascii?Q?EsilSFFOOA/Vilxn2NLpFDtCDNVer8PTd2h/XCuV0VrjBlUJ7iDdzyqQdGli?=
 =?us-ascii?Q?uDXU3SK8LwPvetAA0vAGRWjYs9CNOFeAiqY2C0Iv4im29eNd6184qvQoNVUX?=
 =?us-ascii?Q?Qn7CFUaCosU95h6jDfGNqsnqHItO54a7qyH4hsTNykLEET+0Ju/1jWQap68l?=
 =?us-ascii?Q?VfTJt2oYSL/tUOs8Gt7R2QC2ASzzJyFqbViYCI/lUIHFBtRHyeMmPeNsjv20?=
 =?us-ascii?Q?FBgSBQwy8mPD2bMqm2REWeCqunUk3zX9YGDIS8i7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95693d6f-0b7a-4fe8-057d-08dd16193ce6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 17:13:01.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6v0DCQ3GuG7xvPm2ldmppfM2dUJ062Rn6iRHrbgVKEOapXmXTqn1LG7keMf31nswuPkN6D4hIrqEHm4gUT0Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355

On Fri, Dec 06, 2024 at 02:31:19PM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Add the I2C Devicetree nodes and pinmux for S32G2 and S32G3 SoCs.
>
> With respect to S32G2/S32G3 SoC based boards, there are multiple RDB
> (rdb2 vs rdb3) and EVB (for G2 vs for G3) board revisions. These versions
> are quite similar. The common part for the EVB revisions will be
> centralized in 's32gxxa-evb.dtsi' file, while the RDB commonalities will
> be placed in 's32gxxa-rdb.dtsi' file.
>
> This refactor will also serve for other modules in the future, such as
> FlexCAN, DSPI.
>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi      |  45 ++++++
>  .../arm64/boot/dts/freescale/s32g274a-evb.dts |   1 +
>  .../boot/dts/freescale/s32g274a-rdb2.dts      |   1 +
>  arch/arm64/boot/dts/freescale/s32g3.dtsi      |  50 ++++++
>  .../boot/dts/freescale/s32g399a-rdb3.dts      |  12 ++
>  .../boot/dts/freescale/s32gxxxa-evb.dtsi      | 150 ++++++++++++++++++
>  .../boot/dts/freescale/s32gxxxa-rdb.dtsi      | 124 +++++++++++++++
>  7 files changed, 383 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index 7be430b78c83..0e6c847ab0c3 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -333,6 +333,33 @@ uart1: serial@401cc000 {
>  			status = "disabled";
>  		};
>
> +		i2c0: i2c@401e4000 {
> +			compatible = "nxp,s32g2-i2c";
> +			reg = <0x401e4000 0x1000>;
> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;

hardcode 40? can you use macro for clock index? Many place use it.

Frank

> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@401e8000 {
> +			compatible = "nxp,s32g2-i2c";
> +			reg = <0x401e8000 0x1000>;
> +			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@401ec000 {
> +			compatible = "nxp,s32g2-i2c";
> +			reg = <0x401ec000 0x1000>;
> +			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
>  		uart2: serial@402bc000 {
>  			compatible = "nxp,s32g2-linflexuart",
>  				     "fsl,s32v234-linflexuart";
> @@ -341,6 +368,24 @@ uart2: serial@402bc000 {
>  			status = "disabled";
>  		};
>
> +		i2c3: i2c@402d8000 {
> +			compatible = "nxp,s32g2-i2c";
> +			reg = <0x402d8000 0x1000>;
> +			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		i2c4: i2c@402dc000 {
> +			compatible = "nxp,s32g2-i2c";
> +			reg = <0x402dc000 0x1000>;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
>  		usdhc0: mmc@402f0000 {
>  			compatible = "nxp,s32g2-usdhc";
>  			reg = <0x402f0000 0x1000>;
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> index b9a119eea2b7..c4a195dd67bf 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> @@ -7,6 +7,7 @@
>  /dts-v1/;
>
>  #include "s32g2.dtsi"
> +#include "s32gxxxa-evb.dtsi"
>
>  / {
>  	model = "NXP S32G2 Evaluation Board (S32G-VNP-EVB)";
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> index aaa61a8ad0da..b5ba51696f43 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> @@ -7,6 +7,7 @@
>  /dts-v1/;
>
>  #include "s32g2.dtsi"
> +#include "s32gxxxa-rdb.dtsi"
>
>  / {
>  	model = "NXP S32G2 Reference Design Board 2 (S32G-VNP-RDB2)";
> diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> index 6c572ffe37ca..666e4029e588 100644
> --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> @@ -390,6 +390,36 @@ uart1: serial@401cc000 {
>  			status = "disabled";
>  		};
>
> +		i2c0: i2c@401e4000 {
> +			compatible = "nxp,s32g3-i2c",
> +				     "nxp,s32g2-i2c";
> +			reg = <0x401e4000 0x1000>;
> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@401e8000 {
> +			compatible = "nxp,s32g3-i2c",
> +				     "nxp,s32g2-i2c";
> +			reg = <0x401e8000 0x1000>;
> +			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@401ec000 {
> +			compatible = "nxp,s32g3-i2c",
> +				     "nxp,s32g2-i2c";
> +			reg = <0x401ec000 0x1000>;
> +			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
>  		uart2: serial@402bc000 {
>  			compatible = "nxp,s32g3-linflexuart",
>  				     "fsl,s32v234-linflexuart";
> @@ -398,6 +428,26 @@ uart2: serial@402bc000 {
>  			status = "disabled";
>  		};
>
> +		i2c3: i2c@402d8000 {
> +			compatible = "nxp,s32g3-i2c",
> +				     "nxp,s32g2-i2c";
> +			reg = <0x402d8000 0x1000>;
> +			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
> +		i2c4: i2c@402dc000 {
> +			compatible = "nxp,s32g3-i2c",
> +				     "nxp,s32g2-i2c";
> +			reg = <0x402dc000 0x1000>;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 40>;
> +			clock-names = "ipg";
> +			status = "disabled";
> +		};
> +
>  		usdhc0: mmc@402f0000 {
>  			compatible = "nxp,s32g3-usdhc",
>  				     "nxp,s32g2-usdhc";
> diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> index 828e353455b5..eb73a5dcebe7 100644
> --- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>
>  #include "s32g3.dtsi"
> +#include "s32gxxxa-rdb.dtsi"
>
>  / {
>  	model = "NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)";
> @@ -39,6 +40,17 @@ &uart1 {
>  	status = "okay";
>  };
>
> +&i2c4 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	ina231@40 {
> +		compatible = "ti,ina231";
> +		reg = <0x40>;
> +		shunt-resistor = <1000>;
> +	};
> +};
> +
>  &usdhc0 {
>  	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>  	pinctrl-0 = <&pinctrl_usdhc0>;
> diff --git a/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi b/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
> new file mode 100644
> index 000000000000..a44eff28073a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright 2024 NXP
> + *
> + * Authors: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> + *          Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> + *          Larisa Grigore <larisa.grigore@nxp.com>
> + */
> +
> +&pinctrl {
> +	i2c0_pins: i2c0-pins {
> +		i2c0-grp0 {
> +			pinmux = <0x101>, <0x111>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c0-grp1 {
> +			pinmux = <0x2352>, <0x2362>;
> +		};
> +	};
> +
> +	i2c0_gpio_pins: i2c0-gpio-pins {
> +		i2c0-gpio-grp0 {
> +			pinmux = <0x100>, <0x110>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c0-gpio-grp1 {
> +			pinmux = <0x2350>, <0x2360>;
> +		};
> +	};
> +
> +	i2c1_pins: i2c1-pins {
> +		i2c1-grp0 {
> +			pinmux = <0x131>, <0x141>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c1-grp1 {
> +			pinmux = <0x2cd2>, <0x2ce2>;
> +		};
> +	};
> +
> +	i2c1_gpio_pins: i2c1-gpio-pins {
> +		i2c1-gpio-grp0 {
> +			pinmux = <0x130>, <0x140>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c1-gpio-grp1 {
> +			pinmux = <0x2cd0>, <0x2ce0>;
> +		};
> +	};
> +
> +	i2c2_pins: i2c2-pins {
> +		i2c2-grp0 {
> +			pinmux = <0x151>, <0x161>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c2-grp1 {
> +			pinmux = <0x2cf2>, <0x2d02>;
> +		};
> +	};
> +
> +	i2c2_gpio_pins: i2c2-gpio-pins {
> +		i2c2-gpio-grp0 {
> +			pinmux = <0x150>, <0x160>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c2-gpio-grp1 {
> +			pinmux = <0x2cf0>, <0x2d00>;
> +		};
> +	};
> +
> +	i2c4_pins: i2c4-pins {
> +		i2c4-grp0 {
> +			pinmux = <0x211>, <0x222>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c4-grp1 {
> +			pinmux = <0x2d43>, <0x2d33>;
> +		};
> +	};
> +
> +	i2c4_gpio_pins: i2c4-gpio-pins {
> +		i2c4-gpio-grp0 {
> +			pinmux = <0x210>, <0x220>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c4-gpio-grp1 {
> +			pinmux = <0x2d40>, <0x2d30>;
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c0_pins>;
> +	pinctrl-1 = <&i2c0_gpio_pins>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c1_pins>;
> +	pinctrl-1 = <&i2c1_gpio_pins>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-1 = <&i2c2_gpio_pins>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c4_pins>;
> +	pinctrl-1 = <&i2c4_gpio_pins>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi b/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
> new file mode 100644
> index 000000000000..d992c0c9e695
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * Copyright 2024 NXP
> + *
> + * Authors: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> + *          Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> + *          Larisa Grigore <larisa.grigore@nxp.com>
> + */
> +
> +&pinctrl {
> +	i2c0_pins: i2c0-pins {
> +		i2c0-grp0 {
> +			pinmux = <0x1f2>, <0x201>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c0-grp1 {
> +			pinmux = <0x2353>, <0x2363>;
> +		};
> +	};
> +
> +	i2c0_gpio_pins: i2c0-gpio-pins {
> +		i2c0-gpio-grp0 {
> +			pinmux = <0x1f0>, <0x200>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c0-gpio-grp1 {
> +			pinmux = <0x2350>, <0x2360>;
> +		};
> +	};
> +
> +	i2c2_pins: i2c2-pins {
> +		i2c2-grp0 {
> +			pinmux = <0x151>, <0x161>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c2-grp1 {
> +			pinmux = <0x2cf2>, <0x2d02>;
> +		};
> +	};
> +
> +	i2c2_gpio_pins: i2c2-gpio-pins {
> +		i2c2-gpio-grp0 {
> +			pinmux = <0x2cf0>, <0x2d00>;
> +		};
> +
> +		i2c2-gpio-grp1 {
> +			pinmux = <0x150>, <0x160>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +	};
> +
> +	i2c4_pins: i2c4-pins {
> +		i2c4-grp0 {
> +			pinmux = <0x211>, <0x222>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c4-grp1 {
> +			pinmux = <0x2d43>, <0x2d33>;
> +		};
> +	};
> +
> +	i2c4_gpio_pins: i2c4-gpio-pins {
> +		i2c4-gpio-grp0 {
> +			pinmux = <0x210>, <0x220>;
> +			drive-open-drain;
> +			output-enable;
> +			input-enable;
> +			slew-rate = <133>;
> +		};
> +
> +		i2c4-gpio-grp1 {
> +			pinmux = <0x2d40>, <0x2d30>;
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;

#address-cells and size-cells should be common dts to avoid set it in
board file.

Other i2c2\i2c4 have not it. I suppose you can remove it here.

Frank

> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c0_pins>;
> +	pinctrl-1 = <&i2c0_gpio_pins>;
> +	status = "okay";
> +
> +	pcal6524: gpio-expander@22 {
> +		compatible = "nxp,pcal6524";
> +		reg = <0x22>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-1 = <&i2c2_gpio_pins>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&i2c4_pins>;
> +	pinctrl-1 = <&i2c4_gpio_pins>;
> +	status = "okay";
> +};
> --
> 2.45.2
>


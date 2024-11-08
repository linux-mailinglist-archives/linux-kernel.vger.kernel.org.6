Return-Path: <linux-kernel+bounces-401389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8CF9C199E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3121C22CFD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D00A1E1C14;
	Fri,  8 Nov 2024 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oS4c4EHd"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59D1E1A1F;
	Fri,  8 Nov 2024 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059864; cv=fail; b=mumFU+XOhKtjcvODANZnyQISpy1nyTD9VfK1f9YxSu3Rt5cBqdyRb9h6M3RBPXtG+lcoSNkQ3gu9kwHb66qnDyFgBq923xc98oNI7aHOc0dh6OjIFS+3ifNsacnyjheGF3cppZ/WegUxslMS0+QAv4l5VFc2S5LfSJ61Sjo5WcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059864; c=relaxed/simple;
	bh=nh0A1WMcErYJS64TRat6nmxC2tzNDUj1ex7cueyMOeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VVEsr0KtbIqCFaiY5UNuAnS/ejwIwm/cVbgn0Q2Hyigostt9IzVlokcbsAM/YlS+n3xHrhW6VwTtobMU1PfbeQVDGlgD9h0NlV0+BBKaC9Ai0CLwIUAG4z5IxRpa8WatPjWtgJHPlgv+RrKDrYjmB8cPjsaG24oTG/1piMUoebY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oS4c4EHd reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6x8Q6enjAK4YlwoWMazEc+PJUkT2Cb4Wqpuglu3sed1AHb9vpaNLLOyZ9/y5Cuxg3pXbY5rBFZRRW5UYBXSIMmsN7iZG7zSzb35kai8LwlOPmeuJijvz7YSB+XRaAwwk/OIwA1PUnmOk6G/fpjdjH6dwh5f3fvYa5IOEwuvZ6HASDy7Fieo9XcliEnsImUAxnqpfqFtoN0k+/os35SPxVjYdlwXDQoJ9xrqUeSRaUmKLSkB7ydObnGv+w2Iy5Xwu3ZisAtvKmMqQfFwBqGJ7jsIEoX6iWTKwf9IHNplRZRcxct8Z5q4pS+gJmoo4lz/JPmDd/TezsuMZ5w+cHYn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KanM/CPFj0gNKIVLVSJAZiIBT3bk/N8tQR1B/ISWfw=;
 b=ctfC6PTO01HP1J2HY2LKsMmEfbZYRDJqpJCi4WB4+FN/2ix/FAaNnS4VaZYTmVT6p3L65TnDRnhtNRcMpJ0dmmj3OPNjQa2AzY27BuHnJ/fkz/d4F7bkJAuuX+CkLpaavn0P+lhNL7UTwFrR75hBcmxJLu6Khm3hJXJR8b4p/yEUv0jDgCTTKOm5O3WqHzBjbPglcNjxnWCu2utaZoaLmMR1bYOgiWy2SMNxoiOE2uHx7kw9E/a895CIHmsyMaXJCn2CXlhOF5Y+PfHY/2bTIh6225Exn++1Yenei4KH68AEXgbXl8HGgk9Zu9NXRbnLLjqd4QKroa8T2SUyB0Kq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KanM/CPFj0gNKIVLVSJAZiIBT3bk/N8tQR1B/ISWfw=;
 b=oS4c4EHdc4Mz1QqDEcjPw3aiKtRWWlAkyGTq/uLIgecXMnoRIR4v4VET9mkkRUptmn4WNyJ7qKw7UWTU9ipfn9rZQJKbRwI7dxTN0XgK8l5gqLsErI9AGUagbyO1BYKdgtjqvTLpPUA4Yxv5bPG1ZEOxMVNuD8K8PoeOJMUtkI3Dh2kxTn0CaB872ClT0hnZN9sauOIZr6zSzkY60yXiwMFh9Mkgb+rc/9l53qpfXSi+CRc6xRFByr5f9r9ssv1Dz4hL5S8ibfmL+RqhLQkqMbNSZlesktsLY+wqN/0Qo8Lb8Os/AuZnFiH5DFhrjJokLeJCFDdLqGjdR2/6jmKA7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by PA1PR04MB10577.eurprd04.prod.outlook.com (2603:10a6:102:493::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 09:57:38 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%3]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 09:57:38 +0000
Date: Fri, 8 Nov 2024 17:56:46 +0800
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, joao.goncalves@toradex.com,
	frieder.schrempf@kontron.de, marex@denx.de,
	hvilleneuve@dimonoff.com, peng.fan@nxp.com, m.othacehe@gmail.com,
	mwalle@kernel.org, Max.Merchel@ew.tq-group.com,
	hiago.franco@toradex.com, tharvey@gateworks.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add i.MX91 dtsi support
Message-ID: <Zy3gXvuWb76beZKo@pengfei-OptiPlex-Tower-Plus-7010>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com>
 <20241108022703.1877171-3-pengfei.li_1@nxp.com>
 <2350046.ElGaqSPkdT@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2350046.ElGaqSPkdT@steina-w>
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|PA1PR04MB10577:EE_
X-MS-Office365-Filtering-Correlation-Id: a987406f-62fc-420b-efe3-08dcffdbc704
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?hCEPUPSq7Knregwk0vPUDU6lspOPsL7wS1hHiZbb+ZyQs1yFRvXyQXsz4j?=
 =?iso-8859-1?Q?tR+Qe5cjN3ZbPEOzaBqYwMuuoOYIiee3i0ksqFRqiozAj7YazZ7s0Q3/w/?=
 =?iso-8859-1?Q?A85ycUfpOCn9I3AahvMcvN5VXwcyljQRtGURtU1kMVwyYTZ6u6oePZffum?=
 =?iso-8859-1?Q?GNH7ua+cvLpkZAFD9WlwMj20zdAUNkgvuHKzfbyIB+KU10RIyyxuyG3B43?=
 =?iso-8859-1?Q?GBRWcksRILqQmRIHhuQlOqQIAVBHrRvbKn/tF5vXCEMH0mG8a61qM+FpoP?=
 =?iso-8859-1?Q?QNtHoG08gnJuZYSJY9X9pEBo4nP3NlGAmgqDX1oCaiEKpZ1qHnBdHELcrG?=
 =?iso-8859-1?Q?z/Rx6iLV7BroY5wCNHHER0gaYm/bJaQ0zMjBngVIu4SU6cIM5WSxKZkVgx?=
 =?iso-8859-1?Q?Rqc13T0oYaEEMkS53MMumXaiWYljiq77ll6gyd76grYvtlNtfvgZv9LUUO?=
 =?iso-8859-1?Q?b0AKLVbQ/NWFY+DJbInrYrqJvgZz1huFgDDefVKFXQjoZN0+SF3kt4FSHf?=
 =?iso-8859-1?Q?B2LauLYiGJqqGBngbepgubVI3MQrp25qawlq90JvdM21vu3QPr58u1S1nJ?=
 =?iso-8859-1?Q?LW/ps4ZGVkdiHiJahf1o8Eclk7xzFpZtxddui6EbqlVclDcb39a19MGW9/?=
 =?iso-8859-1?Q?6HbJGA41MLLtXMJ2LV3gfRBeTKiuxIpJmE22bGMkFmEmzBIu6QAiqxewO8?=
 =?iso-8859-1?Q?CSpTUuXxNbG4w4NLWsisnfzJ50wbGubH4hfrMGN0vRVVPXJ6tOu9a64spi?=
 =?iso-8859-1?Q?HJtAcmg6ZKwfIqy+sfnFCHhPrD0OCAvu7Qiu2D3omkAwsra6xxmx9+6NRt?=
 =?iso-8859-1?Q?at/vODmdWLLtws+h/Yct2kHxe/0n8AfdsbOxWzQb7/gams8bzFG4+Q1Uz3?=
 =?iso-8859-1?Q?SQKqdzZwJjYtQpYk1UvIm2Crtrk8CKuIvCAHJC8w79neDQFWoDSwaViYQU?=
 =?iso-8859-1?Q?Ga3BhY6Ks9a79CtsSAE8YUsPyoFp3O4QRFbm9+pnWqdJF/v/kwnG3DzSPf?=
 =?iso-8859-1?Q?MrhMPysKKPbE6me8AhwU24unYr4WWRZVFmZx61adBOT8Nku+phidtq29q5?=
 =?iso-8859-1?Q?wOlpePGDR0nHDCR0zh4OQqAExs04+rQUQyTFPw0R+tQwD7cfrm4BvypWkF?=
 =?iso-8859-1?Q?xdp10O2AdFl/c9P40XhsYZB/ZvMwEW8lUUV/eLzN+AS6zvM2dxs/CDuZMH?=
 =?iso-8859-1?Q?hIUmulhLRwL2SXcrogX3XwFobb28U+TlqQVj6OUVcRFk70rLIuywywJp5i?=
 =?iso-8859-1?Q?KEubrRvOB5pZnTv+7cbLajhU+FBk/s71pomXUII0pkb3E9L6YO31e2Z5Je?=
 =?iso-8859-1?Q?lu+Axh/cHxA8KXXVy+aiu1xNqgRNQ+pn/Ub9kqYQLncuSxygAcO560+kUF?=
 =?iso-8859-1?Q?KdcOeQAQUZ?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?yhMPjkoXs/v1s4KHockI9uRpxn+zhFPaHXPBvEmnqgvy4eOB6Bofa7Ywc+?=
 =?iso-8859-1?Q?V8q6HArWHACVto4tqc42A7QVgNrgwh17oCXbPO9PcV5cB4WnrVYd2U1SIw?=
 =?iso-8859-1?Q?/MsS+L/q8TEZn7+RVXt03fjC3dHUEImTiwPyfVk/pFiHvt0CyosVj7CkKQ?=
 =?iso-8859-1?Q?gkblcoDjutDmdgddHwmir0orvseEP28iwRimxrBhhEMWa9dpE/Lt364uVD?=
 =?iso-8859-1?Q?p9IrAp7uagfF+upmqwybhxxvgd0IqLcrX3q0g2CYgDT6Bs7wP4cxolJKn2?=
 =?iso-8859-1?Q?K5FVYV6nTs9slIekNo6Ff9ujpk0lQFecWb53836xcy2Bl+ssQhOrAJAnC7?=
 =?iso-8859-1?Q?MdoxtbwuogvgyvQTw9D9xTjbWUZq5H4ZBkBJys4ucYPchEaJVrUT2Ptb+h?=
 =?iso-8859-1?Q?JLXZ1OiypN9q3enZSUYq/8sj7hm0cU/OonP0idnKDJqRcsUbkBqlSEaGje?=
 =?iso-8859-1?Q?5IR20LEoa2DJsM3GFcqhKPsRhtJPEGoBxdGDG9n8UJwisjIW42xYzPG8PG?=
 =?iso-8859-1?Q?MeURruPI6Wl2Oj2aQ2Z3henS/W42VmhRnn/blJcSp0bQvRBjjXFGe53+3W?=
 =?iso-8859-1?Q?nnV9qgKSYIiWZayxr14zUJ6cELEz6HwYvEkD8FPIJyGK/zQnEjwhjo09Bz?=
 =?iso-8859-1?Q?0R0ryYFKrV5REuBqsTzTxDUe3Yx3052SDGrL7jFoOn0fWbPioLIlkKX5UW?=
 =?iso-8859-1?Q?6pGy+3OTcVoAMfwtjcaO7w2D9l5G2KtfT7+1HN8lWJTA3Tl4tstA5HooXE?=
 =?iso-8859-1?Q?Ivkk6nNyag3SBSOCIlXKamV7pJwGHRHcLx82P8B0SdCpMiT55W07zICQ6C?=
 =?iso-8859-1?Q?hQRYFSb/Wka9WkmDBX+z+o7JS1n+R+f93Dh+lUxEe2NwbtBIwQawnJOgFk?=
 =?iso-8859-1?Q?LP8gu2AVjY9TgN3a/bf3CQNE/K77fm/gjgPuJ1aI2Ouq16nAmCRd60J87G?=
 =?iso-8859-1?Q?JA6GjwG0dQ8GpuIIBn1VXIDB13ap4FbkTmrJGbqfZ3uuNphmNxI01lhDgl?=
 =?iso-8859-1?Q?wA8GBo2WFVMOYorsJALGMXWjEIS2I45Xv3ZA0SxL5pkmAx35vwJzY06FOX?=
 =?iso-8859-1?Q?HZvoY9pd/3S+qBT2rrGVVAppo951LNVlAgnUvpJFb3Q+avDnMJixEVkUym?=
 =?iso-8859-1?Q?zOPor5kvPONvuRG9Ntm4t1KHvbC1nL9wMm6RCDmcn5j3KK7u4pffQGulIu?=
 =?iso-8859-1?Q?TV5oQJN8t1uqKNvKYgQUKga1smCrEEx4ouHK+doyTKcp9cSCWymVYaGMj7?=
 =?iso-8859-1?Q?C5+l0ZWrHw2tMZcDBDT1XaPTwu0NpJkIOlKy6riuRU2XcM1ud4WhPRJidk?=
 =?iso-8859-1?Q?84dg50RGsS/NLYoTkqY+as5gWccZO2r9dKG+ShXUMAPpOKVlRYDlnvFQ1c?=
 =?iso-8859-1?Q?nrtj2Z+h6Xf/ZwS1YPC6n+XuozE2+cbgKt1WItTbAa9Jvyid/UBACQirwQ?=
 =?iso-8859-1?Q?iGpedpwlApFFun/KhtjRfBYpq61sSQSpjSNzinFmeQe1vsfWQQS0W2BkAX?=
 =?iso-8859-1?Q?3FUBJ0uMfLZ4nDzs8bjlTdw+O04+FWoTsVkMBrBYQz8+pYydbaZ348qeTx?=
 =?iso-8859-1?Q?WrJooZtFrPBUoxOAvP5/2NtmfyK7z4FguUo/N0QraCJSwRnYGNbqgkavAg?=
 =?iso-8859-1?Q?Q0ywujZFm1D4SPjIrMDDohZB8fWkZdQhxx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a987406f-62fc-420b-efe3-08dcffdbc704
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 09:57:38.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FvyByOG03z4mkf82xcKOLFe09GXTMNVRR1Ji/c6hrNFexkPSc7UM7oO1JcoPmRuUAr0ljP5Y1pAmeGp1rcb6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10577

On Thu, Nov 07, 2024 at 01:49:50PM +0100, Alexander Stein wrote:
> Hi,
> 
> thanks for putting me on CC.
> 
> Am Freitag, 8. November 2024, 03:27:02 CET schrieb Pengfei Li:
> > The i.MX 91 family features an Arm Cortex-A55 running at up to
> > 1.4GHz, support for modern LPDDR4 memory to enable platform longevity,
> > along with a rich set of peripherals targeting medical, industrial
> > and consumer IoT market segments.
> > 
> > The design of the i.MX91 platform is very similar to i.MX93.
> > The mainly difference between i.MX91 and i.MX93 is as follows:
> > - i.MX91 removed some clocks and modified the names of some clocks.
> > - i.MX91 only has one A core
> > 
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 ++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx91.dtsi      |  66 ++
> >  2 files changed, 836 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx91-pinfunc.h b/arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> > new file mode 100644
> > index 000000000000..bc58ce2102b2
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> 
> FWIW this is a 1:1 copy from downstream kernel

Hi, thanks for the comments.

Yes, it is same as downstream kernel.

> 
> > diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > new file mode 100644
> > index 000000000000..a9f4c1fe61cc
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include "imx91-pinfunc.h"
> > +#include "imx93.dtsi"
> > +
> > +&{/thermal-zones/cpu-thermal/cooling-maps/map0} {
> > +	cooling-device =
> > +		<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +};
> > +
> > +&clk {
> > +	compatible = "fsl,imx91-ccm";
> > +};
> > +
> > +&eqos {
> > +	clocks = <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > +			<&clk IMX91_CLK_ENET_TIMER>,
> > +			<&clk IMX91_CLK_ENET1_QOS_TSN>,
> > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>;
> > +	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
> > +				<&clk IMX91_CLK_ENET1_QOS_TSN>;
> > +	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> 
> Is it just me or is the alignment of new lines not matching?

Not sure about others, the alignment on my side is correct.

> 
> 
> > +};
> > +
> > +&fec {
> > +	clocks = <&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > +			<&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > +			<&clk IMX91_CLK_ENET_TIMER>,
> > +			<&clk IMX91_CLK_ENET2_REGULAR>,
> > +			<&clk IMX93_CLK_DUMMY>;
> > +	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
> > +				<&clk IMX91_CLK_ENET2_REGULAR>;
> > +	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> 
> Here as well: Is it just me or is the alignment of new lines not matching?

Same as above.

> 
> > +	assigned-clock-rates = <100000000>, <250000000>;
> > +};
> > +
> > +&i3c1 {
> > +	clocks = <&clk IMX93_CLK_BUS_AON>,
> > +			<&clk IMX93_CLK_I3C1_GATE>,
> > +			<&clk IMX93_CLK_DUMMY>;
> > +};
> > +
> > +&i3c2 {
> > +	clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
> > +			<&clk IMX93_CLK_I3C2_GATE>,
> > +			<&clk IMX93_CLK_DUMMY>;
> > +};
> > +
> > +&tmu {
> > +	status = "disabled";
> 
> Why does the TMU needs to be disabled instead of deleted?

Actually, the i.MX91 also has a TMU, but the i.MX91 uses a different IP than the i.MX93, so a new driver is required.
However, this new driver is not applied yet on upstream kernel, so it is disabled here for now.

> 
> > +};
> > +
> > +/* i.MX91 only has one A core */
> > +/delete-node/ &A55_1;
> > +
> > +/* i.MX91 not has cm33 */
> > +/delete-node/ &cm33;
> > +
> > +/* i.MX91 not has power-domain@44461800 */
> > +/delete-node/ &mlmix;
> > 
> 
> Shouldn't the following node also be removed?
> * mipi_csi
> * dsi
> * lvds_bridge
> * lcdif_to_dsi
> * lcdif_to_ldb
> 
> Also in downstream kernel IMX91_CLK_MEDIA_AXI, which is IMX93_CLK_MEDIA_AXI
> upstream, is set to 200 MHz. Is this applicable here as well?
> 

For these nodes, it is only in the downstream kernel and not yet applied to the upstream kernel for i.MX93.
So they cannot be removed in the upstream kernel yet.

BR,
Pengfei Li

> Best regards,
> Alexander
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 
> 
> 


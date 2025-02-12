Return-Path: <linux-kernel+bounces-511813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF63A33011
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BED3A8641
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDCD1FFC70;
	Wed, 12 Feb 2025 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VF6U5G2K"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D3B1FCF62;
	Wed, 12 Feb 2025 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389744; cv=fail; b=Iv51yXeb8uW07yInx7Ll6JQdd+b2SnNDf35Q8pHiV54HEJR12GpeOsm6vessdgJvjF6ZjxH4e+ZF/OtXm3HnPfZrCk/giJbXcZEMI/YAgbiOSDNmhqPwd94u2metQAivdhT/icgJ6QpX9ldMCZjZMP7n7LiwrHQeilUvkvZ4G6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389744; c=relaxed/simple;
	bh=iBdDDkyvOciVE7edzB+8lEpImG+OYHsQdtAiC8tME4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HHdf3DfV/TkN07C+KzwDT4EWuqejMDMlAWusiW0Bt9E2yns7iE7xunvBpxuMMoZOrRBb2TnQk5kRKjJH6k0Ujkwm5Ifoa3jbPcl/B06iNWVINxyklBHzASPYuzSGMQ6JfsiO9RQqTWS6aZ1qmD44i8r9Rn5u0FRMCFbrWPsKCzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VF6U5G2K; arc=fail smtp.client-ip=40.107.105.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmZh8XAGmpi5giegC94nfB5EQZW/AazMkwXywWboLvf1mbXwiqR6+cQe0QFDz0s/wPNmI3gwPtnJN0wATNH/7/YPZm6EKT9O6X+CD3ji2IbZbr8aBhbVp3ycqWFDp8/pqfrSqJuanKV6HK6x8sBeKt9BqqtUbRvXzJTMVabuODAODKc+UArRbyShjPRxoU9wPadl+dPhRB7DWP2A9K7QvXiPc+EpYRcuSbZ+sXmM+MhZdPzDw2kQAfpiBQNWjEJNxIHOPI1jUW6ppjp3jw7wtWeQpp03dAPIwDlWs13qtjGdmH9f2/7RnHinGHAGWCotaENbHtNZ+29tPaXdSr/ApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T65Rd79xbeAK6X6HqpoA9KCp95EwdRNjPM2kVcAPIxI=;
 b=YqyXIIzbXnPqpy/OGn328jnMqncpbKHLW4lLVoIi47tRb3oIDVBYovRdotNs24Jq+9zFszB7aC76ecmAwN10asg1EgG653sv1pepu0T5WiLfh+y8YR0Ga9/fhF7okJV9OUJWNwr2bv6JDqDcb7bdbn5gN5+TroGwx9D4unqG095Q/pL6xbwNVOiBr1/IoNvzd/jq3/uwtMZ7YUqet1h9cMxRrGWDcPCWW8Anj/4NYlZcWP4GliFhO3q7YBh5O+X1Q7f5jG+VcAF3iJpixYrDDoZEgSvQj+OazwNUC8dZCUDuXMe0VggDVSSvGPAsU+rsA8y+YAggsLWZCFDJV8m4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T65Rd79xbeAK6X6HqpoA9KCp95EwdRNjPM2kVcAPIxI=;
 b=VF6U5G2K3MY9xecuj45n99nIySj0Y+XjObkmX2Z4xEndJwsH+tgG/WrCpHmXOaMdHzhHGU4Uw+CQaNLSwKiFQT0x2Tqw28ICoD0L/g5tysWNAVnd9wVu74L180qlFv+VQ7k/3ujhGX5Au9RNlwmt96UuMYmpyxtimE0aX7JLvRQZ76dR17bRpf5DOe+6mMS6V8kG4MMItK+Ltny1l6ynnS4IcORF5OCytKzCpd4UBNulGh7fGn0Q/6ePBbp045oXl9ULU4lrH28PsdjbSwfABuPQN4nm6X0XXHcAjRL6Wb2UH8uVo8erw6NNAkkkWr8PCc1IUcn7GyPf4P6zWB3sJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GVXPR04MB10431.eurprd04.prod.outlook.com (2603:10a6:150:1eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 19:48:56 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 19:48:56 +0000
Date: Wed, 12 Feb 2025 14:48:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, shawnguo@kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	krzk+dt@kernel.org, conor+dt@kernel.org, festevam@gmail.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	aisheng.dong@nxp.com, daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com, shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com, a.fatoum@pengutronix.de,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4 5/6] arm64: dts: imx8mp: Add fsl,dsp-ctrl property for
 dsp
Message-ID: <Z6z6ojBTTFKIkc2/@lizhi-Precision-Tower-5810>
References: <20250212085222.107102-1-daniel.baluta@nxp.com>
 <20250212085222.107102-6-daniel.baluta@nxp.com>
 <Z6zGLn3B6SVXhTV1@lizhi-Precision-Tower-5810>
 <da63fc79-76f6-443f-b1fe-c4242cb45328@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da63fc79-76f6-443f-b1fe-c4242cb45328@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::25) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GVXPR04MB10431:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2b27be-ad34-409c-a721-08dd4b9e4965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XE1SFlIObWjvcq6TeVFnd74qwiXMEQAXItbzlIVgILtQVb0t+iUSs1jDbtGL?=
 =?us-ascii?Q?QH2XkfzoaCX7xdwmMLjTroSpaJuu9kis30xgI1ee7By654af8XXppp2J5GX3?=
 =?us-ascii?Q?amiHXijCte4z9lL6UNUBrCWKkw9ZKmo3Fe+KvmHoVsKtPQXaJEpMcYwn0N1m?=
 =?us-ascii?Q?liooMS8KzoyA/gAQbtlYobnXDILq3zK5nH/Oi0EkxduJFyx0xgde6t2gD4Kw?=
 =?us-ascii?Q?IZiezj5NW0Y4gb6R/LSdwZnbYzvM0GU5awndKBsg8BX3SF3AkVmt29Kd1mlV?=
 =?us-ascii?Q?T7Bednp3UXliEplNx/JBMlWPA9+fPVUFICJv0U0mP2pdKY+9p8LFmuodQzSn?=
 =?us-ascii?Q?dQggdGJJiROmfyuhMzjDR6uAE5Yg2Mh1+a4M822qTgeuIdo0ySqEQ1h59Qmx?=
 =?us-ascii?Q?mj4BOgyPkqPZ8TsPyNfA/Azbts5t6Mz/4WdzYLsgwoeiLipIGg4fEAHPOFuu?=
 =?us-ascii?Q?c9dISq9N/SfRIeyD8bSrNVLNGVMT4H/TFvXDL4mQD3cfi+AhUXc5sApyj5x/?=
 =?us-ascii?Q?AdB45WniO0Z8gLaGDDeOE6/Fd2DytCdN/pM3Vbc6NMdpGhJnLAFEH5bkgeFs?=
 =?us-ascii?Q?D5ZP3c4YFAFS/bo1BxQtrpxLRnW/hOmawg7ekDjYpnJEW/Rh21LL9IrOasSJ?=
 =?us-ascii?Q?PiglSnkjwzzbvlZ7af6s22Uf1OIO3qRelzLcctYLrOyVAMmwjlTymrStmerX?=
 =?us-ascii?Q?UZM7HUfEUgQlQ9KyegUMqa45q5ZpVzJQyXtzOGP3PINclULy2PtMKzbH0GMR?=
 =?us-ascii?Q?jwqpxUaDoso0N4HeDo8TU6QDkgzwb2pKsazIImUc3VWaJTJYuGU4em35Hh3m?=
 =?us-ascii?Q?C8d21OI1AQLSaMxUlZ2IypdEuonOZPdpA1+ZObdRbDcg2Gu/sEf4lHFOLbHU?=
 =?us-ascii?Q?FMcBqNAkW1vfC6rdiSg8XbCW+WLBqr460F2EZ+nYeCwiut/unlTrIHpiiN12?=
 =?us-ascii?Q?JXtZUVXn407rwW8CxezEL3OaQvCcBnKyb1rXrctdSmhBkmH2XEUVtvyJHWqP?=
 =?us-ascii?Q?aLFZgMXBVdA3x3ueM9++nZ7UQMffGxWLNYPhcwVAK4my+7DW/2c9zVMUghSz?=
 =?us-ascii?Q?HU/mnHvjIcIXuAB3yWsiJWf1mrzluynfZXj5UbPKxZdf+CO3xih1EyRQIJjp?=
 =?us-ascii?Q?1c0eVrUt2TUo8qrMVpTVE6tTjDXMkSP4i1vRQXmb+Ns20O6m8NjQLeeQz/GR?=
 =?us-ascii?Q?2UgffPIux5tPLtSeHv31+Inc+Yj0MlYiFrrfe7pd0llwxiNNFCRhGeuZeENr?=
 =?us-ascii?Q?ZsfDEveomGXVrYmc24tpYXwhTc2c8+wVR7SpMaE/4f0hLTRdyZsT/FQkwKau?=
 =?us-ascii?Q?0s5XUqsyb0TzqgaUBqbJsCRrgkpF0BUlwBYm+LdRhH748tjEXRcz6cId790Z?=
 =?us-ascii?Q?fQfX7PPEX027biFWiOZB97HJQiX1WrPpwCnJ+4LyrtZt/9Q2fowsRNJezgx7?=
 =?us-ascii?Q?FKVAYZyX7E67Yt/Giaug5swd/iTaMICU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FxcEPA46/7rQX/4x8ht4+CaQ+eU3XLvsGZiZy1KVODI0s63sPxlNU67IjPzT?=
 =?us-ascii?Q?R0sOURsYjc6U9xAVE6FfTH2sg8MkfiQ0uJozVN1LyUaRqb0aSwA7CcZ/vykN?=
 =?us-ascii?Q?QGe9MjMMBSpg9pLusLC5Tc7J69XK3s/IpTdXLR0DfTqgZN0MoSG5RdPqly0I?=
 =?us-ascii?Q?fSxaYlvpqrxA6IT6/G8oi45ondRX23SxMKocTZ9R/zISANPDbYwmm51zk1EE?=
 =?us-ascii?Q?PT/ENj7YPn7gQoKyNOWHmTSFMa/qGcv8+hR7l3na3eYe7miQ7/ipBoPRghiO?=
 =?us-ascii?Q?Hrw6tlBL3nziHXG+r36m5irnmfZ2xhiJGv0LTM2HeDU02FT1qF/KFGad+m8/?=
 =?us-ascii?Q?Po0hNBfHkd26tcS/x3oCr30jHgW3ysxXFRcZ4HZzGEGUztyM40C6XzQoWaK3?=
 =?us-ascii?Q?AyG6D5GTqKTB8x//cLCthM+sLNqHLVlXNT94bsrIZcgGlVqcY0uWZ6JXOlG4?=
 =?us-ascii?Q?MIWNrlJE/slW1NjMnFPWq+Fl2st0akvf2kU3tT2s932ZmN6JsC/Q8Be8yu21?=
 =?us-ascii?Q?avpSUTpjB7N/GGb73eWY0OaGsQ0ChDyt6vbUwtfr+BOkzuua2N3fg6QAKA55?=
 =?us-ascii?Q?Can6NUu/16qmpRG6L/KJzY25n3xnIEcBgjvYiwzjOiQ4ovnXcp5FrEClQde8?=
 =?us-ascii?Q?Zk27SUDPXG7DIl22bASs5A08Pw2RWFki2W1T/YWNpCzCvqwPFzA+LQmc/mSd?=
 =?us-ascii?Q?d8NPnkdmg87vlr1XEm5CsmWih9LXkZ052fvwuRXSF9CpPYIyq67IuXK+99Nx?=
 =?us-ascii?Q?doh8UTpelO74ar3HS8XumEQJG+ThDhAUqwflb26wWfbY7tquSeUgdtwRDkBa?=
 =?us-ascii?Q?JNlsUCgv8RvONnBXg5Z/p1XHIaRQsZAp5jR90fs4xAMG3xGDC110dfgE2xWG?=
 =?us-ascii?Q?P98t70U1lzOwk3aeq5xvPIeycW6gcOXiw2yI4aEtbwvdmc4kb+k5wrmPlIC+?=
 =?us-ascii?Q?2xbDRPYVlraTqzwMf0aI2Hiy7YwgMg/gA9YUObrjME3iaj9nKmBWWbHIYPNC?=
 =?us-ascii?Q?e6ZWgnjSlMyZav0oICeAqyv/YzZDA4u6WNNJty+xbQ4KHU+TdWvM7iYXIQmt?=
 =?us-ascii?Q?4L4/LAEdvUjH5B81jKvNxEX+EcPrN+bU029z/qmZ+krll8+rYVg2CLbtOLgZ?=
 =?us-ascii?Q?RiphTukkoOS9ceXtmb0N+K8t5fhl8jOqY3JrpeJ3uIWjmrPemY+tlcjiu/pX?=
 =?us-ascii?Q?dLVgyNx2gDkDnz9j6rs/x3V1beBxHRe89hyKWqnMwUEAoizGHkiBu3U8SpMm?=
 =?us-ascii?Q?0LFAnzwXhSxxp2SCRYzyO66rDDE/dQE63QPAbtHrdieqFBQFX6LNuGfiC9Ra?=
 =?us-ascii?Q?Z8S7ADuwnRecurt79Lq0xhOjUDbK5X+NG9ecBn//YvzlIeq3LfmDG3diktV7?=
 =?us-ascii?Q?gug+pmMDIuIJuMkhmOTS6P0H9gMW0EST/XOFhNQaFU+wliASWQdqsuVKql9i?=
 =?us-ascii?Q?dvhVsWUS/PvRdJUoi1Xwy62X6UcMFRmPAz0hIj+ByWYAial+eYas825ueWCv?=
 =?us-ascii?Q?bsd6O6+x5Z8JW/NgQ0+/XbIDQi+lfGvdKGLW6EI4v7nwQifgE8Iyvq6aiu0L?=
 =?us-ascii?Q?CQ3+C5bTIpfGk9DT1rw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2b27be-ad34-409c-a721-08dd4b9e4965
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 19:48:56.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuoqGU+qIXXicPV5chVZPqTjloAUi/fxdTLNYBRyUMHGGpvXGPZ32KXX7SzZf0s/rEWm46AqLxp7r5C8R3E1rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10431

On Wed, Feb 12, 2025 at 09:04:47PM +0200, Laurentiu Mihalcea wrote:
> On 2/12/2025 6:02 PM, Frank Li wrote:
> > On Wed, Feb 12, 2025 at 10:52:21AM +0200, Daniel Baluta wrote:
> >> Audio block control contains a set of registers and some of them used for
> >> DSP configuration.
> >>
> >> Drivers (rproc, SOF) are using fsl,dsp-ctrl property in order to control
> >> the DSP, particularly for Run/Stall bit.
> >>
> >> Note that audio block control doesn't offer the functionality to reset
> >> thte DSP. Reset is done via DAP interface.
> >>
> >> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> >> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> >> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> >> ---
> >>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >> index 14cfbd228b45..46b33fbb9bd1 100644
> >> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >> @@ -1609,7 +1609,7 @@ sdma2: dma-controller@30e10000 {
> >>  			};
> >>
> >>  			audio_blk_ctrl: clock-controller@30e20000 {
> >> -				compatible = "fsl,imx8mp-audio-blk-ctrl";
> >> +				compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon";
> >>  				reg = <0x30e20000 0x10000>;
> >>  				#clock-cells = <1>;
> >>  				#reset-cells = <1>;
> >> @@ -2425,6 +2425,7 @@ dsp: dsp@3b6e8000 {
> >>  			mboxes = <&mu2 0 0>, <&mu2 1 0>, <&mu2 3 0>;
> >>  			firmware-name = "imx/dsp/hifi4.bin";
> >>  			memory-region = <&dsp_reserved>;
> >> +			fsl,dsp-ctrl = <&audio_blk_ctrl>;
> > I think kk's comments in v3
> >
> > "This should have been implemented as reset controller, not syscon. It's
> > really poor choice to call everything syscon. It does not scale, does
> > not provide you runtime PM or probe ordering (device links). Quick look
> > at your drivers suggest that you have exacvtly that problems."
> >
> > The above is quite good suggestion.
> >
> > Your reply "But for Run/Stall bits we need to use a syscon.",
> >
> > Run/Stall actually is reset, Most system, release reset signal means dsp/core
> > RUN.
> >
> > Frank
>
> RESET and STALL are quite different signals w/ different purposes so
> calling them both RESET is confusing and inaccurate.
>
> The syscon is used here to control the STALL signal (name of the bit we're using is RunStall)
> and has nothing to do with the RESET signal, which is why it's implemented as a syscon rather
> than a reset controller.
>
> While Krzysztof's comment does make sense, I still find it odd to have this implemented as a
> reset controller despite it not having anything to do with the RESET signal.

Regardless hardware signal name, the logic function is that release a
signal and let DSP core running. So we still model it as reset-controllers.

Did you actaully pause/resume DSP running at your drivers?

Frank

>
> Also, do note that the two nodes are in clock provider-consumer relationship
> so unless I'm gravely mistaken this should at least guarantee the probe order.


Return-Path: <linux-kernel+bounces-415815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFAC9D3CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61A2B27C95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087131AB523;
	Wed, 20 Nov 2024 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ePaBaL0i"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFC1B4F2E;
	Wed, 20 Nov 2024 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111088; cv=fail; b=b8ieLmFtoPOLo19Olw3C8N+LDxWCLZBHtqaEAwPp/JuKFprJVKUbXYDxSGwHl3mPSHX4ir88eAU/Co8by1AFSehEY8BpU31ZOE97TJHqAUV2jBrBN5YiTbVihVC9TQBauWnJkaYKQWPmJEAtJ0FqhCcNIfZiFM4psAGtdWNtgtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111088; c=relaxed/simple;
	bh=yAFdWNv7ZErSLzcP2Zpyz7G9oUUoBL8CynD/xM0kd9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZ8UUj5xuFxYCKlVcnkL6aDsElfFZIkK8oFQBof+G7EhdxyH3xQX4KsVt6OVZ6xW6WHyB5vovFQ3Fej55Lf1AnWWt5amy+nGU63x7Vg36JqJfyV326Q0GlFjQJz+zb3lQD+Tve3NvdCZv1T6YPStTHLAZh9EohniDWAfzZD0Cuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ePaBaL0i; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnC4FaUfZVsqb0zO/FzzIgI1TKIf1wog/az0acldhWoE4d7mVHwSy+fQhaq+u3TMPW/+j8gHbIGcWmVMHuIEDNN7zKWu1oG7J/GfSAQWNGFJ9syUXhevZpS9FAxydxL+CAZAZ8hPKUEp1yyMPZeh+PnZ2WLoXs6AsPL/V0/PtXKTmRlCspeRNX6A/Wk+W4jSki1gV+SrZ80/drsjl5TQqlhL0q+3eym9Cc3FAdX+oLVaLljCQ+N/Hot9ULyHmTC3DDTCb36+GB7l32KESZZgv0azHCuT0anhTWegZu6YEQDDP2GuphScrqsb6MDGK4eClDGp+OxMck5hF0o6bPlLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcuY47uV8AHjXEa78L4D04tJ8yvbgCveBFU0fVCAapY=;
 b=oUFGC3sEAsaPp+OxAPtcX+qwY43maNpkhUpupV4srAaiRpaTuOpK7JaI9RQonnvUWNMWO+gSrlJgrzhAMNxckoXQjJ0MCPkYWJvwDen9anWv9157cblBWJWJqGd3oFv1GpUYfCWuSmesAxlzx8CLAiT3GT6QDJeNM0gxhD4xofjreM7UElqgUVMdL1Nse5IH2L/BEZ7YdIjgaSndeM4BviLHXxqQMqh+DBZipu3J/2s0+zgjzyg/qORIUFnjTAeC94VFohx4d23o5CsWXpFdhA+PM39apYznbXgEQBF3lwM18Jmxl1D02SzYcKI4pgwIA5fu9JxyAzil3vs8gZfapg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcuY47uV8AHjXEa78L4D04tJ8yvbgCveBFU0fVCAapY=;
 b=ePaBaL0io04pbS2Y3yzmHPHudYMQyIj2Uy/eb8x4EF8RtS+qy1THpKSGyOvHnmsMaaxM4CqneEt7SoxQQm5GtFX2yhuj3ahCRa9H1mGJN3XuSqM4dy8HP3H27WCsyer8toSGf74r8RVtL4OVyXL84JvjDDbwMTzXrgHwGiln3s3RlFfLQCEIuj3TfRMlno5cBFzAbKGUkrIUPlf//zJMlSVkPk+HEyFLmWaplNmRu/gQ+RxCJfziis5cdMtgIS6PDql1H2qTmrF0mJMXDwjJm5vEyLuZV/CHdO6fuuP32eoMryIDz1DNOo+xum0elQ39hcXo0q8FvxKDCFlUBwEotA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:58:01 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:58:01 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 3/5] arm64: dts: imx8mp: Add DSP clocks
Date: Wed, 20 Nov 2024 15:58:56 +0200
Message-ID: <20241120135859.3133984-4-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120135859.3133984-1-daniel.baluta@nxp.com>
References: <20241120135859.3133984-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::7) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: db554c01-4534-4085-e525-08dd096b58c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?akaD3qbZmOhuFumWUxd/DZecfiZ9if14FJnDPqEDSEoXTSWO5fuDlYh7kPd8?=
 =?us-ascii?Q?jDyUbmPmo2Fr8PfnN2UPBLgvx75Efql0tme3dFVzvtZQ5BTWx/ZocmB4zsI2?=
 =?us-ascii?Q?uqvlnHj5rIC2fx1oEXb97/koSvBXghafqkgMDKwQc8hc88dvJylDPZyBHB+e?=
 =?us-ascii?Q?cOIpT5HMCX8yapNf+XfMobBw7Abw7qCAAG/UtJiyMV3g8Sq6h4LunflM7N7l?=
 =?us-ascii?Q?H9bsZ68sxGhZXCl+Wi5ilNdhyZie+a7cZF4JucSMJ/ydVg42HMV6cgU2QNQt?=
 =?us-ascii?Q?WVeHV1VVSWvSwwh4S5e9olGsjZO92/8o6tEbawvVQZBIwTeBLdrtnNCS8qtO?=
 =?us-ascii?Q?2icB9AKnQUPR1Ok552upaHz45bsd6pfk1PLqJAs0/9IxViijuTJa9nqOVJ2O?=
 =?us-ascii?Q?KUn1K0F+syZPrcu1kqJEUxS186Tf9LHQpGD/VfkyabMonDYgF3/PK/IBbqM4?=
 =?us-ascii?Q?WFMjBbjRZvQirPVCDJ+H203mqUxdqovrrlJUqP9A8qi8aHbzqQCLfZ45IJmJ?=
 =?us-ascii?Q?Bo/EHbcOU10cL2WMLJKwQ8yW9elWl0kELJbXuqUW74YedbiobnZpZw/u4r4B?=
 =?us-ascii?Q?Nx48kf/u2kJkF4gq3uoW8eDBHqKaiTx/cjAMRgcXMmgWLLr3J0yOAfFzKHWU?=
 =?us-ascii?Q?ISUdrq58OesWaLs1XTr/40GKxxK0crDymLSCgArgcrMIcBieVUhS7Envaj99?=
 =?us-ascii?Q?+L1AsoiQoY7c4YyUtPhQUldUDu0cLXszkHcER/to8UuekQy82j4N9ToOQowt?=
 =?us-ascii?Q?p5Y+R/KGFp38xDQboWiAhCLzFJzF65W74AwG8byImTDx6GNGGyNXOrUkNl3H?=
 =?us-ascii?Q?S5m7vK6on4wxNV+nWEu71qmZxxQz9vgoShGK37CO6pqnij1vEO2W5W/UlRk+?=
 =?us-ascii?Q?9l7PDx8zXZG4kqaHgku3cyeTTBXFiBVrhx7bijcE5sZr2q3zfs/A3NSkH1mP?=
 =?us-ascii?Q?wcsX+5tHtCqE0D+6souL1MajX/wgwAHZX4odp+4avnYtco8+UXWCGLkZLJrC?=
 =?us-ascii?Q?depNQm0IZlRMqj5UX2XeF46VIccfVMqdhUqBTiiRNtulbUS9AA6kK2DF8gID?=
 =?us-ascii?Q?PCwsDA3UWQIXY7ItjHE9JXDmYexdymK8zZSQUMPThKjURtGYgvDrgS0MnlDm?=
 =?us-ascii?Q?Y7LfFGahoSFr0P+WZXfu6OHyOvqF2EqmG5govIrU7xC2twCxpqa3CC2VmfjH?=
 =?us-ascii?Q?B1MKuwcHMIYA3yOMrRrLG434oIUcXGHyVwlESuXd/za9RBMjPWuwwTdkxZpc?=
 =?us-ascii?Q?hI66UAsftDS0kTOWq1Ov+imiePh7VAiCvQurqbaPKUsimwsY8E17E48I29YO?=
 =?us-ascii?Q?ESXovdKYD5UIY0wcnaKlJdQi1NwfxhBKLFtJOLo5nvOTGcBhij0IvEkbMqst?=
 =?us-ascii?Q?gX9IRSM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ICEHq2gdx557IrD8Pc6nPTYtz4MEaSFK9it2Ms10Nw6AJ5sXPCAyVYkb0jn3?=
 =?us-ascii?Q?M7xh+9Gs/rsKOvp9XN7NPh6L3tyaDXM0861lAQcicQroz8u427WCm486T4ao?=
 =?us-ascii?Q?jhTTLRBk8dj3kuxKaJ+ZOuyCvrffCs8SFVKJ56B6Y87XXYMCERcoG44HjHxS?=
 =?us-ascii?Q?xkctE9zPdMRIA+hdZqSskJGOMSTIkaNzE04Llc6/67iTfN/958QdifcUal0J?=
 =?us-ascii?Q?N04hoq4b/pl+n9WEPT2P4fV3xvKMPdto4pWfHzA0gEaNYdBWC2YKfRhi4fOE?=
 =?us-ascii?Q?U5uzn/ucJ+g9ehWiX0gE26KaVJ78zTOnT89OdDnUwJ/Sn6C5Slv8LTgKvlgI?=
 =?us-ascii?Q?oHpWL2xDNYj5QqjGza85cTacjFbW8T8UYyFYIcLB3G7CEb+GImTbsTq7c5eO?=
 =?us-ascii?Q?q96kjCDNWVTcx84C3zneY94l47BReaAzzwxKUP1t0ZFO+EdwPDiqEYwVBIFy?=
 =?us-ascii?Q?QFgU0ArbztnzMp+V+gTKOP1ywhIrMOQ/zhJVo39vki+/aZTMeChbgu8qyzrZ?=
 =?us-ascii?Q?5YeIYZIm2ZSRhfXqfmlqSkKGvHpXgjJjpF4Yuh5UBtFgOP3AMFD4V0rdy/Dm?=
 =?us-ascii?Q?nIcSttqWQRcprh/PtdSgS63+nQO4umoqwRVcLXpdDOeZ6cm1qPH/ebp0zczp?=
 =?us-ascii?Q?nZ7hJVoM56YwIMdjxr//P3+PpbS6SNEtoXhzyriA3shPPNYvHiRlsZ0yVAQE?=
 =?us-ascii?Q?nH37pVhqnHgKyzr72oPffR1e12SR7zYKkyDeCZ7Ugs717oA05JK9YXxOBimM?=
 =?us-ascii?Q?wHXQPRMNIqxL85xLFYbbD+ZTNgo68oNn9/CDcULR3eRdarqMkNa3Hng/dnVd?=
 =?us-ascii?Q?K+5U+s26Hwi6I6e9OyU+qr3JisvaxAWuB/zIGBYgXw1LC/Z2FaP9wOcyH1rb?=
 =?us-ascii?Q?AUUKpafmFbt2kVPFHT2+5QEaPRpnD6nzko5rRu57IVbI9PLrjX+REyT6TbHA?=
 =?us-ascii?Q?8hml4wq7kKEB4MKMTThMtC39CAKM7qdJeyY0z/v1mla8oi/alQq77DsmxtLd?=
 =?us-ascii?Q?eS2ipsy4IF8ktlOanT5+GotIDbsKUqzsZytquBQPGqlLsL3HAkT/uMOqyPFX?=
 =?us-ascii?Q?hVr2ygRHYIfHTLeN9aYVAJ7t66cdlQEtWTZh4NZAgOs7x0hWquHa2Jf5Ft0c?=
 =?us-ascii?Q?6bpd07q3KXSSCgPtljBsMdF0MaaVL21VPAawHIWwMvDc6F2t4CO/UNDG6/UV?=
 =?us-ascii?Q?ipkLfOCc5OgsWaqz/MpW6XaBdhguq2xCpQgM0dClK8YU3ZB9uEUpgh5Sz5+C?=
 =?us-ascii?Q?VTT3WrpB2CYYzCWGxMNQj0bzDTk709NiMxq+kO/WQyPcZXob79oDFYBPHb2s?=
 =?us-ascii?Q?H0bzw3rX+Lpnvj6QYriHBoca6aTYhK3WYrcH/gbhwZFNAVYNBpk+oTb3uuxd?=
 =?us-ascii?Q?6/kJxbrmCoAOjc4oBsG9tk8Srp4ja7WQMDT+5ZiVJxj24Imb2Ms9/Gq8Up+4?=
 =?us-ascii?Q?YD+XmFzW4p1fx2Nhe4SNtxUHVTA1RhNBFGvrfPVxnq4JAQ68h8q1UA0ympCA?=
 =?us-ascii?Q?/f7D/7QYDB64YzROOKTPoy6I5RMg3SViISfwJI0jGbBsAQUftt9rCtYMPiWn?=
 =?us-ascii?Q?eL9rbLB1DXjAf367OGE/N2kVZ0NBNdkUFvsGZJmJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db554c01-4534-4085-e525-08dd096b58c6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:58:01.3800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tk5CQ1JWmz7WrOrwCm3MHbtkq/+zm5KCk5G0DYfCcTqKP7Z6l1Llwewfgynu7I1NNwyyBtkM2EAUbfIf1bK+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825

DSP core needs ocram, core and debug clocks.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index abc8f0d4eea0..41ff40ab5da2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2423,6 +2423,11 @@ usb_dwc3_1: usb@38200000 {
 		dsp: dsp@3b6e8000 {
 			compatible = "fsl,imx8mp-hifi4";
 			reg = <0x3b6e8000 0x88000>;
+			clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_OCRAMA_IPG>,
+				<&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_OCRAMA_IPG>,
+				<&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_DSP_ROOT>,
+				<&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_DSPDBG_ROOT>;
+			clock-names = "ipg", "ocram", "core", "debug";
 			power-domains = <&pgc_audio>;
 			mbox-names = "tx", "rx", "rxdb";
 			mboxes = <&mu2 0 0>, <&mu2 1 0>, <&mu2 3 0>;
-- 
2.43.0



Return-Path: <linux-kernel+bounces-401412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F589C19FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A821F25A8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417D41E22F8;
	Fri,  8 Nov 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OV1A55Bp"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F11DACA1;
	Fri,  8 Nov 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060443; cv=fail; b=HhWr40o4FGNLGNnS0+s2tQ1kPoroNa3TD0cGrQJbl+lBrzjy4mM476RIqfbrCQ2UNDiWdTgejlX//TDoWbs5n0HwwCP5ptub0VOB+ut5rDxjdnDHzqYMi5/8EE0F2tyt0FrHFiG/JwO7fZ9s5O5c960bLIMKiExiOEsfgj2zWSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060443; c=relaxed/simple;
	bh=5uzVpolquJ6+smR3Tb4DT7W2ShM7qghictF9CRO+VVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H5LBUjzuDXNTGwldN/zZw0DVB3Q8IoROb32Wv2z4SnyWpfEo4TEHGg9UVrlOAsPoH7NwAopZwO3jp1XeEsf2M2AU7qv6Aob0TSPZ+mY4jbqpm+xTBLF3kNlCNHLTJu8ITHo00orjGPZCD6vlx8sleJ0Sj2xQoiI4W65/3vOGix0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OV1A55Bp; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0ziQqeofagHHftFv6kRsu/gPkzynP6fIWOLQ0CUOpiQxFfG7OWdGc/uYieO09+lsRYdeVOrJV9NNijVr6wbw7avvU5WIiL2BCYl51ZXthKohg62lGwzp/ZLdMbgnpxWMsl7pN2NWAhnMHwS03aqMCQVdnroHawGea8kAwiqTDW8vgNnvWsqUff148KmqKn1ptxXOvwY1FWHIgvrrsyPyYOzch/QImRa8ZmnCPTUy8wrAFf7ZcqSs9ZQHX2DoXhk316m32CgKmB/laQAmPA3Fy/sUXkIjpsznWFMoFueA0mPH37ETIoZw5WkUpIOwGg70W+b6OhYdxwQR08TSlaWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X1P1hsYEor2W5Yfd9/7Ar8zCFW7xOI+q7oLtO6ek/I=;
 b=cgURh4YYHkpgOpfzxA9sRR6I/h68hd7sB/nFtFzt+h8AM2jLdxHAgQ8oAptcHfQK0MNDHAz57l+TID9PZjUXvFDBC5g2dlFslJTEqdQ8V2tU3PV0Pw4NL7IyV/kLnOhtJF3oKyVoJ08Vum654mXLg5gvxanBPA/3qk5TP9PiSLPwydstKePyQ8RZELj6IBYgEFF0VfGTZUvH8vvYIFwINskdX0M3lAgbNKQ25vqCtysgQ9JNHlUKz+yZaGwFB2OVIUIRy5kv71FSZblnig8yjybScW4ZpNmKCdVjto9ih9xRnHfCCYYts6bW4xp42PwzFEwu/jaViV01PDWQLa9Heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X1P1hsYEor2W5Yfd9/7Ar8zCFW7xOI+q7oLtO6ek/I=;
 b=OV1A55BpYDbycFu9AwNym8zFcPNt8wLDyb8uAdXiJ8Q97lSfr6P9iaTFC8eyhcjbiuA3Ub6PmUCbnYqdVxMCpwFlgPZ7DfnBRw13XewI2qNXGej2qMy/tHhvCT+InJWB9lVu/gPB5WqBTyKJK/BDMhKzoAcPLOQn+l7h212l/GYIE+FFddR94UNMZLg0TKsMGJc8mkaMg2kLhtXeNxIGcEjJ4m7VxwO7bBSX2L01IAOz3u4SMtSbdXyWwm1QvmxNEg9+rRdo5TPl+qYW4WInYZzXgEZTCPcNwd9KGMoZJiXDKqLOxdgQ425IKnuMIXSeAMGUAYlZ0obhOuwNUPo9GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DU4PR04MB11030.eurprd04.prod.outlook.com (2603:10a6:10:593::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 10:07:17 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%3]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 10:07:17 +0000
Date: Fri, 8 Nov 2024 18:06:26 +0800
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
	joao.goncalves@toradex.com, frieder.schrempf@kontron.de,
	marex@denx.de, hvilleneuve@dimonoff.com, peng.fan@nxp.com,
	m.othacehe@gmail.com, mwalle@kernel.org,
	Max.Merchel@ew.tq-group.com, hiago.franco@toradex.com,
	tharvey@gateworks.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, ping.bai@nxp.com,
	ye.li@nxp.com, aisheng.dong@nxp.com, frank.li@nxp.com
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add i.MX91 dtsi support
Message-ID: <Zy3iogT7jOLEvf1S@pengfei-OptiPlex-Tower-Plus-7010>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com>
 <20241108022703.1877171-3-pengfei.li_1@nxp.com>
 <2350046.ElGaqSPkdT@steina-w>
 <1907807.tdWV9SEqCh@steina-w>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1907807.tdWV9SEqCh@steina-w>
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DU4PR04MB11030:EE_
X-MS-Office365-Filtering-Correlation-Id: 77adcd43-f71b-4c35-3b63-08dcffdd2006
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?v1FNPaQR9WSbl0bF067PZGh/IBhPZFt8GjH4O2taDxjR6N0BaJ4PZFpfuoFT?=
 =?us-ascii?Q?SZvm3HAOX3YNHnCBwgsUzEDWDGfYJCPSTngGwoPFFCetMCBJsfjjv0wsr2L4?=
 =?us-ascii?Q?lhouaUDhSrkCcdDhlVcx0zjFDlSDM7yce8UeqC/yL52W1uWaRG6A2FroiwUC?=
 =?us-ascii?Q?jQyECcF/B1UIDOTfo4LXHV3Zt/iRAo3dJxl/pAmE2ZE+sTobpbvOe9vq6V/Z?=
 =?us-ascii?Q?GmFh0AK3Jadyetrr/e08IBDBNilyN9nIaUJZkPg3kW7rN/eF70bMVwOZu7kp?=
 =?us-ascii?Q?O2KweEWRvWB9Wt7i1DBIudv2DZHOpAy+iQtJ3e160ckTuHgR5W7kkZ31evOp?=
 =?us-ascii?Q?J2ZqfZ8hp2B89wccQvkJKQWlpVtQTsYmlVLvgIcKDU5ezlbTPKjktVr1jMvs?=
 =?us-ascii?Q?IX/OfVvG6piLMi5HrbQCYWdw3FQAPVopA5qwXogJnr+Nij7pzAQLTWR3J++V?=
 =?us-ascii?Q?B5PcyMi5AkRv1DwECEJTWq+j2MnQUhEuGvDSFmGEfKKZog4A+7MDj7NtxSMT?=
 =?us-ascii?Q?c/pcfMu9QsS9H0UxlmzqCKxfvnaSlv4YlyeZ25cnHXQzzftnVmnPMqWLx594?=
 =?us-ascii?Q?174jayjorhwQAMNRmk7YH/Y6sUx2pWJFQA6ag4UAqSL35fyl5e7f9h7XblHB?=
 =?us-ascii?Q?rLUKJ40pQqK3pMcIAs/kiKujd0CIZliKAAPOpLFWyUvE7+YNl895m1LLJszj?=
 =?us-ascii?Q?WMpxR9s7aCe9fUEYQZ8B5mZrkuzYP1EXGZf37UOjr/rhpbotsMZzF2BSzAwG?=
 =?us-ascii?Q?cG3WtLMZZ8E9vqP21ODfEPijLdtBx/hoMsMU8iqU94ZywlZUy56FhJqmPmmv?=
 =?us-ascii?Q?H08R6TJNbEkb4AdrZF3PdjEpuQp95cgcBU2JTU3ZoWljH9PMPIhf810P1hsB?=
 =?us-ascii?Q?byz+rksnr/lmZ1Hi08Siko+gkz0bX/nLFwdTwb7BzPJj/8yE4x7QzDrcmCEK?=
 =?us-ascii?Q?atwGB/D94RNzkp7L3mCXNrm4Jj34aVhAqKvnrWJzs3v+YBEUz6Efva1zPROz?=
 =?us-ascii?Q?TeKsYqISzVKN8ZBqoUuWI4q0xHqwGBWEIx7Umlt6sr80VPBRDTXreG67W1LY?=
 =?us-ascii?Q?bNc8k/EuHNdQzfMu1v7h809pNKBueJFvAHfpMHAeY6gYQTkQBiid0rV5lM8C?=
 =?us-ascii?Q?9x+GxFYhMASNoY7m9Vhr0riTv1NnQ+N4DQLjHsdYp2FmdZ1JKGSju7Ne7K14?=
 =?us-ascii?Q?IvwCHS3IV2b4tUjsP+EmdffbCtdCuvs9CFM0J+/NJz1epQo2HM77Oow06ogd?=
 =?us-ascii?Q?rb67jsK7XTtOEW50jjqh2Sih5RLrbYpQGpkdBAdnEizlr88oX3LCIZ+dR8NI?=
 =?us-ascii?Q?Eap9W9OqqCQrB1i6QAZO6VdxqXnqfvoFyv6LY/4bNhPhDXaLtOK0ujOnyLxp?=
 =?us-ascii?Q?s33SuFk=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?5o9Qr2CfJpzebDHtdatfTo037r0vsyRkACS6m8xCmcz652ITyKNkQFS+E+6H?=
 =?us-ascii?Q?QwIa38qq14YeCPCx+gBYc6NFZqCD8k6bQTr2LUnk7NzQqW7iS84DNOMv7hiA?=
 =?us-ascii?Q?uEYDlbJGls1Karglap9t9SJYGomfPW2Fm7Wn1CJUlFv4sC42JjUtrjWkSCvn?=
 =?us-ascii?Q?N22uAZS0QFJEpqZT038qQKS+E64xm2ykDT+3heDZjsict8NGWsmf4Y4rPjvp?=
 =?us-ascii?Q?3btV0knkIVSmJXpRoldwmOIP7eXATWDDy1b5kM4RH4E3EOL2z+Dd9eqZfIn9?=
 =?us-ascii?Q?ZFRJPKaWVNhzf+pVrwqQ7etnmp9a3ufmZ/dDIbBkq+74kOxrkO7zFeKm0tHV?=
 =?us-ascii?Q?Ah6eQzEjOgDapeseG2l2XohmFXjYAyWt6FDK2edQEYuPNfkukaAT2ichnU0z?=
 =?us-ascii?Q?HWvG3kk8RonKvyse75ngOipPhFoObyOShC7wuOvE1N3V1gIQwyXM2betmWa6?=
 =?us-ascii?Q?I2seT78WXSG6mRm3io4G6n5IyXb98eXDrt0GYg0pEET3mxY6suKhDfzoEHdB?=
 =?us-ascii?Q?mhtxsfoba12JdXPCvjNTmS5phnlDWrnp4TmXocdhUncNQ95JGsyULmjxHDbW?=
 =?us-ascii?Q?1Bd2/VTou38A5cBzF/M/TQH4SNB95BTcMqThTVltWVVJGhxopC+YuYcMxO1x?=
 =?us-ascii?Q?zplQ5NOqqxFbD607O50c6VUFl7RIxtoy5Njvc5HaFK21/mLL9UNq+6OznPOh?=
 =?us-ascii?Q?qzudr4AcL78wurFZMF8I8s2crJ9Xb8QNODSqAS3cTkU8Dpq/fgiYoZ13lH0x?=
 =?us-ascii?Q?QMmZ4d/mO+dmzICju8adciGz1Ge4uMsZRoatTKigdRgpOU6aGJ1NQpSq5ZvM?=
 =?us-ascii?Q?Y+a29OiAz8NsfawJkXxAxRBtpqffy2ab7l8WUulXpyVfpEG0nvIxKNi6Sfc2?=
 =?us-ascii?Q?+Ub4olUw49AeU/0FG2svKcXE2EbwR5AHZKLW5Xi8XtnRXNxGq4mAtAdaf9S9?=
 =?us-ascii?Q?cTTl5XD8QXj8zUbXQN153L9hjqVOsVebRCIAYfI4nEhzeaGCVbd+Vaj/Ar/3?=
 =?us-ascii?Q?hcj6Q8YRmk4R6VIBQJ+CFSbUlEItEQxErgTzSaLrteJcn9RW6yZu1xAB+4uP?=
 =?us-ascii?Q?0H08Yx0suHHUQmkH5ebo3oiHzBugm6VR1K7k+bZSfOQnBxsigK/BYtDOFn1p?=
 =?us-ascii?Q?flCia8/Da1zpLdjtj2NcmQ4CtC/4j1lqJo7l6GBuJH8++HARbaWDgY2tBLog?=
 =?us-ascii?Q?Gi1Dckw+QCb2NfqYjTR/rqNPUm+PGGPoW6bOTqQkEQtwsBFAaTGLP2vN4VM4?=
 =?us-ascii?Q?UUycL9AoREJQbDtWirgWbOPvoQrNEVIe0vQ0062uR6/70OwKxh+mTkTHCZxv?=
 =?us-ascii?Q?V2bIvrc4vgqbx+M5R7rgKI2Dk4bMntaSBvLk8g5gjC1W9kzewknfPt4IpSfY?=
 =?us-ascii?Q?+CkrwXYnzul/FYL1kWMAChCnsRKtYomClma2HRI+RNE5hcPwbPNkxJc0mn6S?=
 =?us-ascii?Q?D6FbegF+C5fYSb+dWENQHYYHDfDGz0Lm9brGEOTjSiDqMZGirPsHYPYn+Zso?=
 =?us-ascii?Q?xdvPuxbVr/Pv08MwwTbwhUoW0Y+JVIGFUOzvTqxZeZrl07yGq+mFSKO7+ska?=
 =?us-ascii?Q?w0AzWBGcaKmhszFkiPQyv7gERrGRW64MDjuy6u0y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77adcd43-f71b-4c35-3b63-08dcffdd2006
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 10:07:17.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPsLm89b8Zpi3aPxq0J7W9wSStR04sDl7JMr6hpNaW0avWLDlrLYm+V1IVVUzeH6H5I4Jqd88hvhkJeLdrBF6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11030

On Thu, Nov 07, 2024 at 02:06:27PM +0100, Alexander Stein wrote:
> Am Donnerstag, 7. November 2024, 13:49:50 CET schrieb Alexander Stein:
> > > diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > > new file mode 100644
> > > index 000000000000..a9f4c1fe61cc
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > > @@ -0,0 +1,66 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Copyright 2024 NXP
> > > + */
> > > +
> > > +#include "imx91-pinfunc.h"
> > > +#include "imx93.dtsi"
> > > +
> > > +&{/thermal-zones/cpu-thermal/cooling-maps/map0} {
> > > +	cooling-device =
> > > +		<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > +};
> > > +
> > > +&clk {
> > > +	compatible = "fsl,imx91-ccm";
> > > +};
> > > +
> > > +&eqos {
> > > +	clocks = <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > > +			<&clk IMX91_CLK_ENET_TIMER>,
> > > +			<&clk IMX91_CLK_ENET1_QOS_TSN>,
> > > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>;
> > > +	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
> > > +				<&clk IMX91_CLK_ENET1_QOS_TSN>;
> > > +	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> > 
> > Is it just me or is the alignment of new lines not matching?
> > 
> > 
> > > +};
> > > +
> > > +&fec {
> > > +	clocks = <&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > > +			<&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > > +			<&clk IMX91_CLK_ENET_TIMER>,
> > > +			<&clk IMX91_CLK_ENET2_REGULAR>,
> > > +			<&clk IMX93_CLK_DUMMY>;
> > > +	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
> > > +				<&clk IMX91_CLK_ENET2_REGULAR>;
> > > +	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> > 
> > Here as well: Is it just me or is the alignment of new lines not matching?
> > 
> > > +	assigned-clock-rates = <100000000>, <250000000>;
> > > +};
> > > +
> > > +&i3c1 {
> > > +	clocks = <&clk IMX93_CLK_BUS_AON>,
> > > +			<&clk IMX93_CLK_I3C1_GATE>,
> > > +			<&clk IMX93_CLK_DUMMY>;
> > > +};
> > > +
> > > +&i3c2 {
> > > +	clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
> > > +			<&clk IMX93_CLK_I3C2_GATE>,
> > > +			<&clk IMX93_CLK_DUMMY>;
> > > +};
> > > +
> > > +&tmu {
> > > +	status = "disabled";
> > 
> > Why does the TMU needs to be disabled instead of deleted?
> > 
> > > +};
> > > +
> > > +/* i.MX91 only has one A core */
> > > +/delete-node/ &A55_1;
> > > +
> > > +/* i.MX91 not has cm33 */
> > > +/delete-node/ &cm33;
> > > +
> > > +/* i.MX91 not has power-domain@44461800 */
> > > +/delete-node/ &mlmix;
> > > 
> > 
> > Shouldn't the following node also be removed?
> > * mipi_csi
> > * dsi
> > * lvds_bridge
> > * lcdif_to_dsi
> > * lcdif_to_ldb
> 
> Add mu1 and mu2 to that list.

Hi, i.MX91 also has mu1 and mu2. so there is no need to remove them here.

BR,
Pengfei Li



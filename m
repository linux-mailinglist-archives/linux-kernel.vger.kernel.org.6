Return-Path: <linux-kernel+bounces-303714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3A7961422
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A584BB212AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4AA1CDA32;
	Tue, 27 Aug 2024 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RQ8yhu1f"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2067.outbound.protection.outlook.com [40.107.241.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD91803D;
	Tue, 27 Aug 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776456; cv=fail; b=hpj6tcTkhM9queeh3w2FTk1GBc9OxENYe9FJpmRQ3tzuXboqutcYuNL4zQUcfGE3Oc9pzsjazMuQqLa9iPI1o+YBbfiYDiqtphLWzcmLVajBFiDRGBK8rFk+1TxiWYY0VPvfVJbtYMWVt+xVd6plQbkNyYe4t9cf8ogq3dR16CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776456; c=relaxed/simple;
	bh=rgNibf+JMxon/4dnKZhY1PzlF5Rg7USzawe4bdn6Ahk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OVAQLug8lNOohSszLvs4gB4MHFnuU+wg2tTagM0y1LlHu/zgImvJDy29yiwzz9RFRIBNLpyeTYZ7174CHptuRFaSotgViOZVTJqCfqdA9o8d6doP1vqx9vjwCn6GvXFx3KJEV2FUsdyAWfC4bhdEpbzMJL+n7ixOcYxlApenRco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RQ8yhu1f; arc=fail smtp.client-ip=40.107.241.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fImDnSvxBCw7J109S5pe0GfINiiooiwMmFdRJUu6PSnZuFB7p6DNyaBZj/U6Sri0mADEf9pJBUICPWyHbHxlq8R5qS2qW3GNGj9099WSuRyDvyZ2njmg7P86U+pZCU/D7eB9k1MLiCQvC368UxB4edKo4K07VBe/jXoG64v55zfAg2C2maapEmel3YANXgjBr5htI+fTNTcvdsI9ExFV4HJp8vDVpzH/4tTHhyEd3IewuF4RCs+uQDXn0lfQ0MO6XLCcLKAe3xHGnkbUasbBfOah7XLUGT/WK/a9lC2u3p/Y2jRHUhG1X2KSMLPJ/A8ItJo8vpSpQKVemeiMxZVKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viuyt9f/hPxvEury42ZG6B+1GmXMJwPO63BvHxSc9/g=;
 b=tUgoCdtKVK97eKGiPkTZYYJiVXPU/pOxKFryCAwLaKTvW0uYdeIJbXSkcY0LBh86BB8few3bGH723K99hVIzU/NfD+fqYfF/CaS6OQDTx2kxP+uglYjou1nr3EJRd25vXEVXkhIZqv3NWDRtKrqI2CD7ddmlSS/S3lWi9x77aY56wvVXPjboQcIzEZckaFAZVEvqLNjDMV/35yVBTH6BsgR0O6rAW+p3JEqeHRKLAJGApG2JczhStfzZItf9IQL51cEtMP2I7w8IpTwgOJ/d/bGWtNBBw3NNrzwgtF9oz9vQ3sDO+Ly1QIWUV2MREMfPLdsL/Wh6AskwSizW70dH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viuyt9f/hPxvEury42ZG6B+1GmXMJwPO63BvHxSc9/g=;
 b=RQ8yhu1fhMauzFSqi5EUN3a3sZ1QXYkL0ChMNbdAF3q7d3YRErFQp1eByLCG4xCtgJ+77LVBd3Zya8w2yKfoS36PEDjP8D8U7BponTh0yui3FNDevIE2GorO1gh1PQZ3BpgMklpGame6H+Ov3yKZOqL8R8yPEDQOz6dkWV+3qJ1RXNmgilDllS3+x0fZ3ZvB/qA/Bntk3jV2N2h8LpyrwWReIbSxQ/SiwOnZeK5/yx7w/a7OArNaROJvs6CiBK0njyJH22x5IrF8tbKoXyAMkoTL6yIGhhENKymgOrdQvAAlek9szHEMXlb/Twaf0f1drhT6cn4sutIkD4zt+3DJcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8393.eurprd04.prod.outlook.com (2603:10a6:10:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 16:34:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 16:34:10 +0000
Date: Tue, 27 Aug 2024 12:34:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt
 to yaml
Message-ID: <Zs3/+uqK1iZTYU0l@lizhi-Precision-Tower-5810>
References: <20240826163626.961586-1-Frank.Li@nxp.com>
 <20240827160010.GA3965737-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827160010.GA3965737-robh@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: 26695b2c-7a9b-4fd4-e735-08dcc6b613ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?APnD+b1iXpVRlx6olOAKg/hwJLP2J2euDjfU40ATBgEEP++vqwSOSl5nOc19?=
 =?us-ascii?Q?nmjOTjCSNKm2gH+TDekPMxbshryt/Gae5lGh8IcxfjBw7rgponTrNBknzbFV?=
 =?us-ascii?Q?ZQ2ecEXzrWntWOF+a3DVNUEShr0xJdVGynmFV9YyI/UizwWmyLDEsGxlA+HQ?=
 =?us-ascii?Q?pQW2aoEcw4FgcEocPAw/cwDXR/5x+J1I7K13nFhxKa62kZQ/Fy4FAffDL686?=
 =?us-ascii?Q?ZsbK71CGTDq56QW/8hxUwcZGrtmkvCNAg1Sy/ydHzM5FsUL+w3gJ37b1SPMu?=
 =?us-ascii?Q?pnmJ5xC8SPFTRq43dTfXmoFr71XiGAaxfhrxqf3xfvFqiK1LKQahuJCmx6N8?=
 =?us-ascii?Q?dJMdB4EyRcFpxMvuz4DeXJK2+mCTGUpZ+OLlds9kUE4XteSaWhLbCoC01YKS?=
 =?us-ascii?Q?MOYSBpXT9uuU4rD+EjOSVroTbOkjY0a/cmlHhC7O3jTFmAcyTvVtlsW5+Fz5?=
 =?us-ascii?Q?qexwuYml+7juIWA+p1PyrvCrMRU9cX6BbE3D/qnraqRmPaeaBx+qA43LiZcf?=
 =?us-ascii?Q?WVmQmPfywiPSHl6uDodLlC2Nt4yvzpjZ4NoJBpJNBnGMlUFayuk9Dgw5DM0k?=
 =?us-ascii?Q?px07ehisX7pmOezZzu2otfY0WQaP+idNbc04q/HPo6188REDSOus/3kIyyMJ?=
 =?us-ascii?Q?qeqnGWE+7yMipMR8UNaBearidbEWWwb4Zo3DlYXKtci2qO8HGSerBI9a9D1C?=
 =?us-ascii?Q?uLp4hvb8TTU4g4PYa58khX5Vc+16l+tIVPcsfYYxuArTlGoME/uVlWVBETFd?=
 =?us-ascii?Q?z/EoWWWdah3px4F1EYZyHDPT9asE8kreFnr9T4oUGx+K0pFEVM/86PSdx90w?=
 =?us-ascii?Q?A/UZYK5gCDLXDM7aLg4lKdzMTGGqQao/QSlxHuSncKMUh2HFShGrEDA8rPNP?=
 =?us-ascii?Q?lmv1Tp2peBt3+Co/rNxFj++Fniv6mtaNaI6xmf/14ha3DBLLN7WBvMUpyRIL?=
 =?us-ascii?Q?XwlaF2NmxmC3/qLKz1VGwN6FK7nUZ9XsRePq2u49AA9Ec46t+tiZc7HyMbc9?=
 =?us-ascii?Q?LhzbHUdzMN46d5GtWaA1ZS+SVCL1stB71JEcpkZa295ZhrnXZd3UjTrS5JKS?=
 =?us-ascii?Q?camcqJzvhgROK+6RDKpAa3uLmpuR5MF8MWRVWfH4Q/x+OWZMJ0+sglRMlDx6?=
 =?us-ascii?Q?YcP9V/wyvva/0TIhj+GG9N11cpxogXfa5XPIxvlvdSU932D1HWvbXYkVH9P3?=
 =?us-ascii?Q?9QZ/EzfOYqFU3yyqGWGHR3ggOc9PXyeFSh8AvNcbVRc1ipdktMr0WHONZpQa?=
 =?us-ascii?Q?7NqbZfuqPDQi5YDH2eaFRLyUNJkcbjMSqIDVYtEUf4IZpZQTG4TEW1Sk29of?=
 =?us-ascii?Q?aZGd25uc4wzmSbMkswyKx+63sGlOpiGN+9ay63/irexDuiXWzJjsMeKUxEQ4?=
 =?us-ascii?Q?BqVymSqOyHo+1e2h0RnsD//sQuLz6lkcI4c54Tz7I9jlctqQbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pvNsvrmu9Y3RNy1LG4dIC7w8qhdJzygOfVZX+LCxy9f6r+psDmYPkeHHtNa4?=
 =?us-ascii?Q?M83GKNXZ1Fe3MkhXEar3pgf8TZHyKHXN8ytlu2saict+68MyqstTKZ9Hk0q1?=
 =?us-ascii?Q?SCpTppQsiZZizE1R+DNl/OUVsAwJRXz0veVO+yiwUerMqX8dEit5HdQXMe1/?=
 =?us-ascii?Q?qvuZzDZ2FrQhN+/SWdmNQQQZqyiF0cwnRnaYBlBF0UsHoKejAy2TYw06Jszy?=
 =?us-ascii?Q?cIMcwkTfqX4cyD0z1fbjdIUPWXUGB/kmv+NvT06X0DHbGR8FMlbiYSMGdOQl?=
 =?us-ascii?Q?tP6gPoXn/DvyK7ThcdIQz38ebZMymJWJjpAwf77A1awI1Z6NlvOGGbsSwSix?=
 =?us-ascii?Q?uSLVDRSm4cDoLesBJol5xVNw6fcrF5YHu1E66O9wukrE73lnWCy3ekx3q0kN?=
 =?us-ascii?Q?XdhDLcF12hc6hATpCb5lH9sck2qkkScf1vo+RVWCVYUqxyIEEcT+AbLJgygj?=
 =?us-ascii?Q?s0ECBk5RAGQzzdHIFM1wPOc3GGzlct4WZv3+WT0wCbL35ou+g8nM38QUUijZ?=
 =?us-ascii?Q?TtAFPFwe6HcyVfAhuEEMQ8fCBwyJZWOqK8FkWKDT1wXqxUHiccNf+/KrLq/i?=
 =?us-ascii?Q?0L4Q8US2rrMikBqzh5qJp0PxPhnBFopruNEh3sHMioNgqp7unonexHSsiuw4?=
 =?us-ascii?Q?O6/eLh3o9mGm272GzsvC8X3wDi/4uSsWx5p4157inkU7cjCktw0FNffZcuGz?=
 =?us-ascii?Q?ulEZkPnKVyFFU50khmUj8iEUQ3jA5Nj9croHYiaC0jFEXWX+e8NTJaqy7xgL?=
 =?us-ascii?Q?rO6Rwn0wt3rEriCOLlDBYjPMEm05Rai53fqchlHwefGHnn+xWZUpOcBQOS0C?=
 =?us-ascii?Q?0EBuQsBl9FuZZbE8A67MJsg+cTy0UYincK3wX4vs59YPYYPfS/6/LkDstSnI?=
 =?us-ascii?Q?aVpC0TR/bEgcYMDi2ldc4exNL4WpvaF9VT0dy+oyjnnw+T8fFiH82qTRmKGL?=
 =?us-ascii?Q?u7/NZvsV+qOxKTsgrxPkvxmXRbFw3qBjBmuDwm9p+w4BWml9/bEVMSeByT4Z?=
 =?us-ascii?Q?7Qic9jFBcFyhU14c90csxAsiWMQaDNOYLcOPKxZr3RKw26+PUdcLFrFC3h/q?=
 =?us-ascii?Q?oDzCfiITUroOFbwFRjCigxU7fX4MRt9UWpsBYp6tNX+pdFQ6d8yoets6Y+fM?=
 =?us-ascii?Q?JuTCiDTESjcrAsimAQwHGq15Eh921vdcuLVX9hj1qHIIUj8eXyQq8TTEGNxs?=
 =?us-ascii?Q?NhD9U6aPrp7F679FiY7Qqp5fxe72o9LUYD3pcN70Jtzgu26bBcwWNVHRsEpf?=
 =?us-ascii?Q?feWN2ZrXapls4VK//deEvqKUKFkZ7bRMqTwo1BbRIAY1W4ReuRORHA/nzwMl?=
 =?us-ascii?Q?jVNzsePfPhpF1XxxPaIfWQFu+cUp4dgpANRcE97VbqwSZ81D5LkyxPDL6i8F?=
 =?us-ascii?Q?ygeNlwPmJIQmhRkK/Y93VZ5/bG4uROyLF64iouTA/pZHnwzNjDywmSwp7YqE?=
 =?us-ascii?Q?Xbfg+FNw3XkIfrGSGJZFQLMzvCWKdfqx1ofkmAbNZChlTD7RDlWm9ak1cxHF?=
 =?us-ascii?Q?73U++4E10c2oDaapRW+9OswHYdwtK4mR0OqRwIk2IoXjGvoLmBM+O4ZpgeJf?=
 =?us-ascii?Q?ve9vflgOEt5JgGK7vomZ2ffNLG7z3J3t+IM86l4t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26695b2c-7a9b-4fd4-e735-08dcc6b613ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:34:10.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9cPu/02oYdiXqyz8+Uc1Rj8LC8JB0irBJ4PCPcsT9JC4JoJZ005TJOpJzRJB1MqFJ/M0hMtx3KUWniK4dfBIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8393

On Tue, Aug 27, 2024 at 11:00:10AM -0500, Rob Herring wrote:
> On Mon, Aug 26, 2024 at 12:36:25PM -0400, Frank Li wrote:
> > Convert binding doc ltc2978.txt to yaml format.
> > Additional change:
> > - add i2c node.
> > - basic it is regulator according to example, move it under regulator.
> >
> > Fix below warning:
> > arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
> > 	failed to match any schema with compatible: ['lltc,ltc3882']
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v2 to v3
> > - put my name into maintainers.
> > change from v1 to v2
> > - maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
> > - update title to (from ltc2978 data sheet).
> > octal, digital power-supply monitor, supervisor, sequencer, and margin controller.
> > ---
> >  .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
> >  .../bindings/regulator/lltc,ltc2972.yaml      | 94 +++++++++++++++++++
> >  2 files changed, 94 insertions(+), 62 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
> >  create mode 100644 Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml
>
> Based on the discussion, I think it is easier if we just leave this
> under hwmon.

Okay, I will new patch for it.

>
> Rob


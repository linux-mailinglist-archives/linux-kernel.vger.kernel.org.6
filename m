Return-Path: <linux-kernel+bounces-211773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C2C90569E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF101F2495B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA781802AD;
	Wed, 12 Jun 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PtttQiZW"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C5917A931;
	Wed, 12 Jun 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205231; cv=fail; b=fwMZL2HcF2OjUY0WLZPmbtC1Og8pfsluJcfVuMV7PMJITZIWdbwQWqkA3AXNYdALwIJDfJNRp7LXLwnqOCp5avTvfZ7r3eZ+/FCVN/kC+EmachnbtgPMkvkWiXa2Is7rgwu69FbNMaWvOGW86W2jKdEW8lL6nIkf6lgjC86ghLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205231; c=relaxed/simple;
	bh=uuqubonLACuCu5HFdUz1SdZyHCloSWbf5DhhycjJurE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D5VzToN1YcfAWan2gXHin36s7qmsn5FaHBFExUszQ/DO5yd5fSAipMwmUBnxHPYUgWLFDLN+KlBRup/a7WZNjK84XwIntXxpM2zjr9V0VNg539MlgVvt8QsoWV2YuntU86Q0wPvrTxRo4+4wcnqBBHrGu938zfSyQpDqFE786/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PtttQiZW reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnyJDgbWJOyETxCKf1F8ERb+9b0ti3Xtf4eneN79gmhYYw5Q8yjZ9lgubIZPo0aM3z4LtY/SAxNEVCzcyIiuAzekI0cFOwSjFbq4Zj5ZydgiOLSZfX7urCSyYL4x+QzOr9lyfu0ZU1uEOWHoFWyzgaKlUnPEH+lx6bWZQcHwo+DFhe+L0TwO+Ik7C5bP2MKJpN624pGeSThZhILFHnzKOkx6dEyDMhZMjdkTCR+dd5yJw3gEFrv1zKWvNElKPYHOcFo3TmLHJwBxe8QCYORD1/IjotTA/5W5OZ7WO/Wb9eGKblr07gHCjP+gnqzKDD7NEJlfHFHPfVG9LyjhwG1wQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPMJpx5kjiqxmIZX0rg/+aiGh2XkJvG81tIyNHj8GH4=;
 b=GhtzZYRez0jfNKTpsdC52zf4AinwToNZqUALqQbkWJllRv8d1PzgYyAYrEG/O3VFtWn3ilrDmSPSqa3PGUwnfD7t1vx626DOErWpCM4XQRRTLv8Q4jlIAm7tmFC0DrQ4jxZHBE/KrlGJtkDHy184pF/6RU1pADNnA6vMm1mgQANLd7SpLhfv4FJl77VUutn2qTFblD6f58at9ljFxHtDr4zARacAMC4eU1ldZpuufMmf8jibRouNvpmxQvSIC0szbvyFC/F82QBXei1pA0NDzbf3h6F3ry0C+gjwyS7DrQlJcltOkqlXBnfZb4RiFETsC+rQDLLwCdaj43AswYRyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPMJpx5kjiqxmIZX0rg/+aiGh2XkJvG81tIyNHj8GH4=;
 b=PtttQiZWzwI437CUR6lal8MDuYIF4rexjTBEVu/ajbwVRO+37AASIkinCo85A0rnDz2sM7Fx+j7FjxVJ7dgkQgy8BrQdpMWeTgH0Ey3l2gQMVmlLXprsugTRKlrmGbYCO9Y1uf676RJwj2pF7Pc+D5k5gIwvxOHwtDYfI+TdIpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10572.eurprd04.prod.outlook.com (2603:10a6:800:27c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 15:13:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 15:13:45 +0000
Date: Wed, 12 Jun 2024 11:13:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] arm64: dts: imx8: add basic lvds and lvds2
 subsystem
Message-ID: <Zmm7IjyZnxLvh5p+@lizhi-Precision-Tower-5810>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
 <20240610-imx8qm-dts-usb-v2-1-788417116fb1@nxp.com>
 <5792284.DvuYhMxLoT@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5792284.DvuYhMxLoT@steina-w>
X-ClientProxiedBy: BY5PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10572:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d70f0bb-71fb-48c4-cbb7-08dc8af240d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230033|366009|376007|7416007|52116007|1800799017|38350700007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?02zaiQMgWC5Z2OTT0gF5X9fGKTFrfqC4OOoBySl+7N9P4pXPOzDYqvokqZ?=
 =?iso-8859-1?Q?mk8NsjwfK+OvI9nr3uE0dXmHeHrnqzYcF9B3CpN9iJdkhEzMlxoaexHGnc?=
 =?iso-8859-1?Q?72YDAuXKD7N4QJmuZzf9GFQYKG1cRhauj5v4hmerc4BPYjb/LGP98EbGIC?=
 =?iso-8859-1?Q?Akt1bwW+v6qNOVYwVrFr65hsFL8OZ+8my92JNvK7vpssHWRbb6m3VboQyK?=
 =?iso-8859-1?Q?lXfcBonCh9soqa6p6owtD0HiPfRRlou0x9AIIZcC0xilTja878q0w+zDEn?=
 =?iso-8859-1?Q?+e8JXIcg/8hsogjtLNWuOsNoAI3kdpm6wf5tw4MSBJW+6hO0a9UfjqKdtY?=
 =?iso-8859-1?Q?1c9XYZBTBWRpXlKir1LS3tRwM8T4SihcOr7twcx5Df/a/VIeBDPHbxhHhF?=
 =?iso-8859-1?Q?ELr/Q7QJw/wn6rImnVwd1NvqoeqlWgrVXiT6Nuxi4PsjkVyUy7wfp4DIcs?=
 =?iso-8859-1?Q?14q/Pur52sF6a0WLyPv/lrTzJ6fFw1iRSpNPaJuQ/48n2bo9OoQbPZHaAZ?=
 =?iso-8859-1?Q?VuU3RjFNzbD2NjLdJIZVkZJz987RTs+IYn7oEeBxx4r+7qWsHnfiKeHHRu?=
 =?iso-8859-1?Q?d8eTzg+LLBiU5G8kbXKXtO2x363h2eH2aPwMvBTEvkYddZNPOYg9yXfCGI?=
 =?iso-8859-1?Q?KvKF2mQCijWWbEM35kfS9c+vfYyn97HdvcaxU5ey6rEvhI1JqZpDMgvxny?=
 =?iso-8859-1?Q?3NyJNyn26M1xS+z5GjzjlBORasf26Xt0CO6+uWZa+UJ75GxGeRNX18pUrN?=
 =?iso-8859-1?Q?3f5y7JVqrhlnEeLf1G/dX+2zOAPEU9VmBgQp/DAOSNvtFwzgpQ5dsmjEU4?=
 =?iso-8859-1?Q?FXZc961QPHZaewVs6d5LeJWkc8qMGGrIqpTpuwF64YXZVSy37e03S3Epol?=
 =?iso-8859-1?Q?YSokTYsF66FImyIUggMj/FHApb0iPwrhr1WHkeARm2HjSdiQyA+cjebDSh?=
 =?iso-8859-1?Q?n9gW8ha+Jda4asRcAfliPzAU/zpphly9lu/DyKSgosecCVb0fxUwhVdplS?=
 =?iso-8859-1?Q?uzklBViaUbFCSLU1AsnI5D8vdNGnrlhQhfO7uIQk6gy/tWROrXEdOBP7U5?=
 =?iso-8859-1?Q?6ak0QFBUAD215Wsqvbmb5lp5KOGGmEyc8vprl3UQwl1JcN3Jm1xANxYz7s?=
 =?iso-8859-1?Q?pP40beRVsHjUPS+naNCiiTc9DibVYbvSbhJDRbFplyPwAyzzt9eJwgjj8L?=
 =?iso-8859-1?Q?71rfWvNfGY9/gY2xbsWaURgN+loQLqMuhC9TCkkfjhvIeMgWlFMeZOskZa?=
 =?iso-8859-1?Q?20WZa9E+PNtgs3A/Yq34wzd1jTO9QjqWI/OotqAl0Eynz7ttA2nWDjCU3+?=
 =?iso-8859-1?Q?rtU6jBPd3mkYzrCiQYbChQJLQXCuvay9sqNjd+6pVLq7sVzccQ3WbQ3EGK?=
 =?iso-8859-1?Q?IPUEcXSZVL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230033)(366009)(376007)(7416007)(52116007)(1800799017)(38350700007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?uP5jSU0Qv3ZjfJgI/g5E/BtJ5V6wAgIVC8tq4SlVt3rNlAVFQpkCvfGNNn?=
 =?iso-8859-1?Q?yCLGuGHnev9bLwHRkimWox8SeJoApgeqaJ13lESPpLi3O6ZUFmN2ODXTbG?=
 =?iso-8859-1?Q?nkOsecEaQXrCebfQLrYD1B4Si1Vyo5k8OGxOMFVoUzyy6iIv7JRIR5L+Pu?=
 =?iso-8859-1?Q?4zPFJY5R6WaeXsFQtOUAXK/h1tor6Eb8/aXiadt6AOeE8KgNxpPha38EM0?=
 =?iso-8859-1?Q?zs7fenDh4RhG0MfodaCPvooK1cbze2I5vpcQphFsbZrxh2rPdlINWughDB?=
 =?iso-8859-1?Q?WVdH8lC/2IGS1mcT0GAnBA0mtq7KlV4+K2dbePopTxFm9185MqvDyU15le?=
 =?iso-8859-1?Q?5MCaMOJOCTQDFPB3044WMNVugIT9KjPXop0pW/K/VYuQJ9pN55ao275gI8?=
 =?iso-8859-1?Q?c18fEwuZT7nSQEIPP/60CsQrWwhma61kXkhUz1i76wKpAArqi0L5GbuJyl?=
 =?iso-8859-1?Q?jaxZKOoyvt+utAYYbJNHVRDfUjRM4C7AD8yH+UWZjJFrK42kpm8CUHkqCe?=
 =?iso-8859-1?Q?TS4ltoioU+Nl045M5z01DZPqGAaPrLTXkgy1Za+k3yhullWAkP4SqTebQ4?=
 =?iso-8859-1?Q?CkuKWSZkvLqDJqWFzLikktUx2oeYt+h64C4J5/9XZnncmmqPnDTEE3N5Jh?=
 =?iso-8859-1?Q?vEhVYPayh3NQM+7I35CcWHuqowqCjA7Ah073qZRSFey15jmbN6kpkZuR3h?=
 =?iso-8859-1?Q?c6LXCNL0dFQNMLG8K12Z4ignDGYpB2x32Gc9qFv2fTFezgYR4YdGaUhl+0?=
 =?iso-8859-1?Q?uq279JPiXp3z98Gyb46G78ef6tWiKkNY+c6rGoZUlDg5Gl9l7BKl8XD5A/?=
 =?iso-8859-1?Q?NYn3o5CPCeERZxoXamfvOCL6TGtCUzgbTIv9RNhuGEEOYocUZumm5Ar94N?=
 =?iso-8859-1?Q?04jIDYuS7q/pfdL2mxYcdmfB9S0eafnAeZYSAQPdKNEP+ife8MMVIRdm5v?=
 =?iso-8859-1?Q?GDLlrKKVqDzBBGzJpCVSUnBA6NXSJkQuMI243Y4cHd8SIqgjzxar9QyPrO?=
 =?iso-8859-1?Q?4t5XV0atnGRe0j9YlXsHvaAx5VsUvUFt+OJ8ntlZ7hSGuWp+sIXR238lUQ?=
 =?iso-8859-1?Q?w+J8g4zja6cPkWV0yi5yTd1Osy5C0DC6qm5GnBCqYLF8QjBoNJ1zWYc/FL?=
 =?iso-8859-1?Q?2UuyV+qSQ/e5m9Ju85VyUmxboNtna2CY7nCz6UtvNDfdzpcxySSbyxauTq?=
 =?iso-8859-1?Q?bOECOSzetAJd0ncl4VEJtuM+4dEF6R6nF7eY8cXhZly8caj/fn39flqJIa?=
 =?iso-8859-1?Q?FLUrOHcm4XeNH3SJefr4uC7xGD2p2BqsRSiUMlOfbYAy0YuhFaCSsw8eu8?=
 =?iso-8859-1?Q?TQkReJWtBp4c0KS54w8NKOCgP9rDOxvBC9EgW+oweuIy3tJsCdrVUDCTcP?=
 =?iso-8859-1?Q?n3awSN80+zHaF171cxpY8PgvmGJkokvfGS8zfUhNwsni7rwIelSD/oelei?=
 =?iso-8859-1?Q?as7s24AIhUgZjopPGQvKLzegUmzrKXa4frO4CcqL/FXl2uPR1efbJ+/7sL?=
 =?iso-8859-1?Q?V0SYY/M0IheMpuPL9xXL8htj0a6ghLCnpS0knHE/BdcMFXVI+G2dEOpUzM?=
 =?iso-8859-1?Q?9SoZNf/w/yQmPNpouaRckLXSPSkVv8CdBB3u6X+hCKeKwcaURH0HRZjPIR?=
 =?iso-8859-1?Q?rIodN8YU1gLP1JMbWASjL3vQqVzOGZwYmf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d70f0bb-71fb-48c4-cbb7-08dc8af240d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 15:13:45.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkndRH7r+Tz3lqfzAwfsbMJXXRoPnWEdwANw0INexRF3q5EkQJ0V76USQOx26IM71HKn5wSNU2rclbjpBbR0tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10572

On Tue, Jun 11, 2024 at 12:05:35PM +0200, Alexander Stein wrote:
> Hi Frank,
> 
> Am Montag, 10. Juni 2024, 22:46:18 CEST schrieb Frank Li:
> > Add basic lvds and lvds2 subsystem for imx8qm an imx8qxp.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi |  63 +++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi | 114 +++++++++++++++++++++++
> >  2 files changed, 177 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
> > new file mode 100644
> > index 0000000000000..55fd60446ad21
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
> > @@ -0,0 +1,63 @@
> > +// SPDX-License-Identifier: GPL-2.0-only and MIT
> > +
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +lvds0_subsys: bus@56240000 {
> > +	compatible = "simple-bus";
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	ranges = <0x56240000 0x0 0x56240000 0x10000>;
> > +
> > +	qm_lvds0_lis_lpcg: qxp_mipi1_lis_lpcg: clock-controller@56243000 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x56243000 0x4>;
> > +		#clock-cells = <1>;
> > +		clock-output-names = "mipi1_lis_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_1>;
> > +	};
> > +
> > +	qm_lvds0_pwm_lpcg: qxp_mipi1_pwm_lpcg: clock-controller@5624300c {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x5624300c 0x4>;
> > +		#clock-cells = <1>;
> > +		clock-output-names = "mipi1_pwm_lpcg_clk",
> > +				     "mipi1_pwm_lpcg_ipg_clk",
> > +				     "mipi1_pwm_lpcg_32k_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
> > +	};
> > +
> > +	qm_lvds0_i2c0_lpcg: qxp_mipi1_i2c0_lpcg: clock-controller@56243010 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x56243010 0x4>;
> > +		#clock-cells = <1>;
> > +		clock-output-names = "mipi1_i2c0_lpcg_clk",
> > +				     "mipi1_i2c0_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
> > +	};
> > +
> > +	qm_pwm_lvds0: qxp_pwm_mipi_lvds1: pwm@56244000 {
> > +		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> > +		reg = <0x56244000 0x1000>;
> > +		clock-names = "ipg", "per";
> > +		assigned-clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_PER>;
> 
> Is IMX_SC_R_MIPI_1_I2C_0 actually correct? I would have assumed
> it's IMX_SC_R_MIPI_1_PWM_0.
> 
> > +		assigned-clock-rates = <24000000>;
> > +		#pwm-cells = <3>;
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
> > +		status = "disabled";
> > +	};
> > +
> > +	qm_i2c0_lvds0: qxp_i2c0_mipi_lvds1: i2c@56246000 {
> > +		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +		reg = <0x56246000 0x1000>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		interrupts = <8>;
> > +		clock-names = "per", "ipg";
> > +		assigned-clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_PER>;
> > +		assigned-clock-rates = <24000000>;
> > +		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
> > +		status = "disabled";
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi
> > new file mode 100644
> > index 0000000000000..12ae4f48e1e1c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi
> 
> This is only for imx8qm, no?
> 
> It maybe makes sense to rename this file to imx8qm-ss-lvds1.dtsi

It plan include in root node, it'd better keep consistency with other
file names.

        /* sorted in register address */                                                            
        #include "imx8-ss-audio.dtsi"                                                               
        #include "imx8-ss-img.dtsi"                                                                 
        #include "imx8-ss-dma.dtsi"                                                                 
        #include "imx8-ss-security.dtsi"                                                            
        #include "imx8-ss-cm41.dtsi"                                                                
        #include "imx8-ss-conn.dtsi"                                                                
        #include "imx8-ss-ddr.dtsi"                                                                 
        #include "imx8-ss-lsio.dtsi"                                                                
        #include "imx8-ss-hsio.dtsi"                                                                
        #include "imx8-ss-dc0.dtsi"                                                                 
        #include "imx8-ss-dc1.dtsi"                                                                 
        #include "imx8-ss-gpu0.dtsi"                                                                
        #include "imx8-ss-gpu1.dtsi"                                                                
        #include "imx8-ss-vpu.dtsi"  

}

imx8qm-ss-xxx should overwrite common ss part.

Frank

> 
> Best regards,
> Alexander
> 
> > @@ -0,0 +1,114 @@
> > +// SPDX-License-Identifier: GPL-2.0-only and MIT
> > +
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +lvds1_subsys: bus@57240000 {
> > +	compatible = "simple-bus";
> > +	interrupt-parent = <&irqsteer_lvds1>;
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	ranges = <0x57240000 0x0 0x57240000 0x10000>;
> > +
> > +	irqsteer_lvds1: interrupt-controller@57240000 {
> > +		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
> > +		reg = <0x57240000 0x1000>;
> > +		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-controller;
> > +		interrupt-parent = <&gic>;
> > +		#interrupt-cells = <1>;
> > +		clocks = <&lvds1_lis_lpcg IMX_LPCG_CLK_4>;
> > +		clock-names = "ipg";
> > +		power-domains = <&pd IMX_SC_R_LVDS_1>;
> > +		fsl,channel = <0>;
> > +		fsl,num-irqs = <32>;
> > +	};
> > +
> > +	lvds1_lis_lpcg: clock-controller@57243000 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x57243000 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&lvds_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "lvds1_lis_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_LVDS_1>;
> > +	};
> > +
> > +	lvds1_pwm_lpcg: clock-controller@5724300c {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x5724300c 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>,
> > +			 <&lvds_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "lvds1_pwm_lpcg_clk",
> > +				     "lvds1_pwm_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
> > +	};
> > +
> > +	lvds1_i2c0_lpcg: clock-controller@57243010 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x57243010 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>,
> > +			 <&lvds_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "lvds1_i2c0_lpcg_clk",
> > +				     "lvds1_i2c0_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
> > +	};
> > +
> > +	lvds1_i2c1_lpcg: clock-controller@57243014 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x57243014 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>,
> > +			 <&lvds_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "lvds1_i2c1_lpcg_clk",
> > +				     "lvds1_i2c1_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
> > +	};
> > +
> > +	pwm_lvds1: pwm@57244000 {
> > +		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> > +		reg = <0x57244000 0x1000>;
> > +		clocks = <&lvds1_pwm_lpcg IMX_LPCG_CLK_4>,
> > +			 <&lvds1_pwm_lpcg IMX_LPCG_CLK_0>;
> > +		clock-names = "ipg", "per";
> > +		assigned-clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>;
> > +		assigned-clock-rates = <24000000>;
> > +		#pwm-cells = <3>;
> > +		power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
> > +		status = "disabled";
> > +	};
> > +
> > +	i2c0_lvds1: i2c@57246000 {
> > +		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
> > +		reg = <0x57246000 0x1000>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		interrupts = <8>;
> > +		clocks = <&lvds1_i2c0_lpcg IMX_LPCG_CLK_0>,
> > +			 <&lvds1_i2c0_lpcg IMX_LPCG_CLK_4>;
> > +		clock-names = "per", "ipg";
> > +		assigned-clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>;
> > +		assigned-clock-rates = <24000000>;
> > +		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
> > +		status = "disabled";
> > +	};
> > +
> > +	i2c1_lvds1: i2c@57247000 {
> > +		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
> > +		reg = <0x57247000 0x1000>;
> > +		interrupts = <9>;
> > +		clocks = <&lvds1_i2c1_lpcg IMX_LPCG_CLK_0>,
> > +			 <&lvds1_i2c1_lpcg IMX_LPCG_CLK_4>;
> > +		clock-names = "per", "ipg";
> > +		assigned-clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>;
> > +		assigned-clock-rates = <24000000>;
> > +		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
> > +		status = "disabled";
> > +	};
> > +};
> > 
> > 
> 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 
> 


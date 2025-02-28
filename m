Return-Path: <linux-kernel+bounces-538830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5753EA49D85
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA2F17A6462
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A0781724;
	Fri, 28 Feb 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C3duHlZq"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55E075809;
	Fri, 28 Feb 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756786; cv=fail; b=Ortapl31mO2OToyEYK2deloSLRMb/H94WF8bUZqIb8Mf/Ws3aX+FtjHSOwodPBFxGRRZjICyYx6ULEKMHlQ86kBRrUZitEd3qf93+omkn2GPGxD2hDZujRzK3cNlfj7Qzgusu7S1konXuz/9gCkFqLpsWxEn4r/JwkBux6DAo4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756786; c=relaxed/simple;
	bh=e3gdQPtaP9Z2QDdc8Q1LbXSB+PEjmG49uE9xPt4TCj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q61tLApitM0K2ymBQVFvHS/+VgwJ28xG/IFDzkbI2yCppc8wqsglY4KtggkvV9ltiOlm86ZF9AX/zl6shFRgp5rl4WZQ7k7ANjCuiU4DgTpX3L9XnrlGqoWXWVc3Q0Xbbmo3hqtnmSwMjFMyZ2AO5GsCh1z33Nv2bqw7ygq0FL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C3duHlZq reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8FikN+YuS+ObiIhO0GywyWiv/S5/T0ywEqsA1KhoXEPRF1uJ5bN4z3TGz0Aq2acACgv229hCH9wM04iY7imeh3LKs02b4LowpjfycF83qehENshJQKeNX8HXS+NDtP3UEiAmWqu5A5Qc7/fvTw2QxaOTvBw0XZ3HXtXovp4wYkktiooRQfyIhB9zkGDORnZpMx0jp8Gh+t/Rku7fjLfGcDdyKKPWudene9TnOP2SuYeBQUt4sw5pyS0Yl38kcK9w2vsAqLtsuJReurE/EfsHiFZXRgeiZcYWK2/l2M4/EHEf0Xko1UWbveimxzYlPA8/9o77+3F/bp9h+f15DlgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtWT2eleqY4oUTEVILZbL/ynZ+FMzNmMIXhOOs8wLdw=;
 b=MjyS+jkxI4g/HHdC+NEtzifkfUmIS/tjyH9s7ODY0+lt8K/K6DKChxDQH6Zho5dL0aMZNzxm9Tme7ExEbdPpx+sbI4e8VbojKhem+uELtI6a00xYl7LldMM9h6Rgz2w5uPB9PHcus9sgRpHia/XpdU8STP62ixmx99ZEK4dG4RwjHBfjo8nsm34UcyRrNszK+1ko7/JMo30epDQRNCRr9qSm37e+tSMLZsdFPbqkMIA3zx/ftLdUGNbY4FkSkpIkorm7TLnGBuzPOxeHsYfa+p2BQOPKmAbY/27kf1qbMhdOpXCcrNLtkU5It8lR9yQONjGlKc0IuTtUXW7LrlKPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtWT2eleqY4oUTEVILZbL/ynZ+FMzNmMIXhOOs8wLdw=;
 b=C3duHlZq3DyYwxbKiiwID8xFv02ythXcjXmXImEURzNlHngNpRk4H8ckYP/ZISbfDm42qrKkbEABvE72J2fY2rSc0UuGgkHAveR+rzQohU7EzcT6jkEEM9p875XeaBxw+SQu/gvSU1xFmIXou2TCMOgiFrf6oQEcVJVoT+SMEOUuY1c43Cv/peBNfZvnu1dBKkGcpQURinw9Kdon5Mn7nLVZB83PO847Enu3kVq89uEhk6FalpeC2sA1Vnbkl8Tv8UNNKJWDbugrPi2RufzwA25H3KW4U0opcQkwo+yXHjuWxBNAVdAuhwd7W8GnXLUNb3H3IT2qdAn/UyUZSLmCtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7915.eurprd04.prod.outlook.com (2603:10a6:10:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 15:33:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 15:33:00 +0000
Date: Fri, 28 Feb 2025 10:32:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, hongxing.zhu@nxp.com
Subject: Re: [PATCH 4/5] arm64: dts: imx95: add PCIe's msi-map and iommu-map
 property
Message-ID: <Z8HXIvAZcvNY72Jx@lizhi-Precision-Tower-5810>
References: <20250128211559.1582598-1-Frank.Li@nxp.com>
 <1819305.VLH7GnMWUR@steina-w>
 <Z8CVU/RWXSNe7bfN@lizhi-Precision-Tower-5810>
 <47051102.fMDQidcC6G@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47051102.fMDQidcC6G@steina-w>
X-ClientProxiedBy: BYAPR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: d932bc1c-1b0b-4768-082a-08dd580d2f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?OmcGX525oJE09Yjkglx8STKySFDQs6ji9fJ50WRL6USpPRYBbcUgqe7tSx?=
 =?iso-8859-1?Q?BxMlGcpQtx0oRKUXom5QdWNVAX5+KAkMn/vKovmNAim/iULG8pSyW1RpSS?=
 =?iso-8859-1?Q?LhTfOP3fFm9CGip5aFELDlDvXAvTuMOCOArtzZ9uGd687I/odmoQCjjKoK?=
 =?iso-8859-1?Q?LbBlhkIeE9Rf7bYq79hYUG0q+ZQxvJNazV08cTrgk9+JFxSdES6brWY9x5?=
 =?iso-8859-1?Q?BbgHom/AV4xnfk65OkBpEfqLRPEcqwmZtc1tSFKuD6b+DFaO73Us9JhDt/?=
 =?iso-8859-1?Q?fO5dTrScCZhO4W2+53l64slgX4npgY3jmzF0vOyyqJ2HMSkoW9scitC4X4?=
 =?iso-8859-1?Q?8qMYuj270W5/0sheOW+ph7rt+oEVYHhsoyOFnNi1RnNztkosHze9O4vJBV?=
 =?iso-8859-1?Q?WiXoQ+YP8YNd7SteovJJLAjSiD/3F1Rk7mGdYVWTe0I0Wi/U9lGDM7v5iT?=
 =?iso-8859-1?Q?dZoyaaPf41Dcn5i++t/kdHbJojhQAsbR/jFWEIiMndm1ifIyYLBfyhhtup?=
 =?iso-8859-1?Q?i3sScwRTLoNTkDRNMtHw0Yz+9zNXNw9pjFV7qBu360R46Y3BIntk/qXUJA?=
 =?iso-8859-1?Q?M3IoTbov1S+DgDqtY61mZHMema/5vM9G/ozeerZY+F9IN5Kkp+5sAn8rQB?=
 =?iso-8859-1?Q?gKFjtl3Oh6Jtgw9qvjxl3G4f2570he+GQJUth1L8VxLZZDFLCOMmH/0fUQ?=
 =?iso-8859-1?Q?GKN4t5kQrPjEUlQusCn21C+zne25NYar4kobmdPTd9wCUpDpAK3ZZpUI5t?=
 =?iso-8859-1?Q?adOAxLKDK91sv+T4mX0xerxEeMDre8DN5rmrB66Xhyml2fDgvajnvcu2/U?=
 =?iso-8859-1?Q?hLyihJXdYmVjuz/X0gBfj1wq8Nsvdyc9GtdOiSYnz5NHZrAV97re/yeNjx?=
 =?iso-8859-1?Q?PxcqceLU+vQhATDqLwrtK6tbXqPWTsGgQDaMZBjrTCVC3dJN+h4p4ZZbn5?=
 =?iso-8859-1?Q?T6Ovj492qPPkgKQfeZ/E5vk4dUlqV8sSBLJCj2f3Oc8HfQu+f7ZV1/2M65?=
 =?iso-8859-1?Q?sb5Lc6NDINC1MiASglX3rUyV5wftPvta7ufcyIHJ0K5aLTZEA0oLacBaOP?=
 =?iso-8859-1?Q?Mz1rUAa1/u151t4rtQzuhSC3wM5KCqPjn+1LOLp4xTlZBFZM+1OGn5CwJr?=
 =?iso-8859-1?Q?oVp9rUtwYsgq8y9XOeiKqr5GOOL3O7xhSuqT9r0rZbcErha96f1cwUX/O1?=
 =?iso-8859-1?Q?03JwUZF56NVIt1x1GhC+xhdpK94VERKVG2hMhRHTqUxffE2BME4lfCk3wv?=
 =?iso-8859-1?Q?bZdOWn2PlJiEKwaamWGh5Aj74zHOJXCzd4VHPScMDeIDgsbbJNjpbcZrJq?=
 =?iso-8859-1?Q?jnNwVQCDi1Uo8J978i7l9Sp8w/+ap+7Sr2vT29C9qMVNYU6+YJjtQg/L70?=
 =?iso-8859-1?Q?2tELUF2udTX+5LiwF3UGyTeMgh2fk6svJokV3FWUdsKp3S7jm4780+fHq2?=
 =?iso-8859-1?Q?bNasl+6FAay+LvEF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?bnJjQ8IY6kxsVL/gabQ2x0dcFtgn5Mk9szDJ16e1uubXf2Ko7nJaEZJ86K?=
 =?iso-8859-1?Q?/Z/yAOx+EX8t8sxj3vvdkgrX7JXObPGNsFr/DqbcjzRcp8XhIMfGPg8Rhk?=
 =?iso-8859-1?Q?g82Pni5cShhMdRO1OXoR4+VGJIXT5cr5xw5dc6ZMFeBk2Pcvojr8pCzVw2?=
 =?iso-8859-1?Q?AFgnH5i9Kx5pE6YXGSRvHq4f0YpfQ2VjhVrTNQd+PfhIbR1ncmgibQUoFq?=
 =?iso-8859-1?Q?jlBLR8vHbdAzSXdblU/KvwGaBFOe4XX5qyE4Q0TgWz3tidIkmnbtRGh0jZ?=
 =?iso-8859-1?Q?pjeModfapKH6zFCTizf7H8+FfmtMp66O/0U8Zz/mZFAnvKWGLCN82Vcr6g?=
 =?iso-8859-1?Q?K+cR1NxFKepvd6Kh8CR5HXluOW5U2FEo54buTjZIpsK0kxtunDWxcm4Oo7?=
 =?iso-8859-1?Q?CoTiAwnhVUGMy88lp3aCE1FSG2q5l26xLwyxEv63bFbbrmVebYwUwmY/bJ?=
 =?iso-8859-1?Q?6aR0hV9EHCOk2H1Zq8VZj2BgKVARrEm6Zpe9UmCLv4kj2I0rXLaixrk5ZF?=
 =?iso-8859-1?Q?6xgWKg/tTzhXLo/WhziRnJLZnu9kxeNxPmpZ0mPRIh7aNad2hYlPxJsGQ5?=
 =?iso-8859-1?Q?aUteHnhCvJDqiQZ78uw7uc6IuCC1L373WZSvZ4SUIDsdrxK6HeNtbZbJUs?=
 =?iso-8859-1?Q?HdMl6epUsR7Z3GRhrtAAh4+qEKgxDC+xaXaCQnk3wNKMaT7Mp3x3cdcxeC?=
 =?iso-8859-1?Q?eXut5WuXUc795dUCABipa4Kt5BVz6eNbvVP4eta/I8tdQ1ziF6OcfMUb47?=
 =?iso-8859-1?Q?ZRKQRrMc0Uu8F4S20o2iNiJa6GmJ5HGKyj7AzkRtGLJEF9j4oqWxOZRV2E?=
 =?iso-8859-1?Q?OON71YSeMs7x9Ph4yf6/EBqSawjDcUs+mmmJ0q5tUO/TxUnah0KDy/8nnd?=
 =?iso-8859-1?Q?OkaFAHFcCp8qofxVQHM9AGFzRSx4SzaQMDvaHanVL6+M6fF7gaLCY4crvD?=
 =?iso-8859-1?Q?YNCIJmeBj5yv0ktXfl86DmZEk9SwsFM44nXiA3s/af1wHuN5n765yY0lAy?=
 =?iso-8859-1?Q?DhrhYrZMhFO5BSfAPMGUauQeC9OpR2x9pJGZrlBpcT6vvs74k9acQ8BYoc?=
 =?iso-8859-1?Q?oU9RGSj8oDXyDk30u+Hie9a0MEF0QbljOc87nTclCXs5Y9mJyLlIm7DYEs?=
 =?iso-8859-1?Q?iDraHmIQNHkaDWmLoCIaNe9+TPN2hPg/0RgpuYwe7u+WSC9/TbFsE1IRm2?=
 =?iso-8859-1?Q?jqyWdWYHhY/Ud4fqSX0cKy5NtS4Ko7sr6U3Jnu72l6i46iWCzOkY+b+i+q?=
 =?iso-8859-1?Q?/YAfj2vT7EkWYi2qc3x78MHJWIRCuiWg1zByv1n/oL4C2t9418jARbjTm4?=
 =?iso-8859-1?Q?9d9ZI5eFB5fofSXQ55SyuOJbROIMP5fo3e27CdsobGjGSCGa0ysUdyHyv3?=
 =?iso-8859-1?Q?ALmth8K9CAF1onzfY8RYfbhDBjQldGWg2z2KLbnU0Vwf7xmy0akvXj4NET?=
 =?iso-8859-1?Q?LsR5cHfXkfG0GvFG61j7voN1nlUtoOLbErWiIJRORwW+8TMW9CUkJixVB+?=
 =?iso-8859-1?Q?bkM8JD9XPJCZOsTpzBu0W64zpScLXCI12NySBbp8elck1hyUj3vVjKxn4Z?=
 =?iso-8859-1?Q?Q3CZJ4HrHMCoUuln3VBbsh5bnE5KYL5nXouhfev6NVu8mLLpBMwvBTgMy9?=
 =?iso-8859-1?Q?e2U5w4U5/UAwM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d932bc1c-1b0b-4768-082a-08dd580d2f43
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:33:00.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epOYAOYlehm1xSpeTaGu/e8vogR0xRyd+CceHtVV+Dsaiou9lhM6nOdd6LjMieE7kPcyiP1pOqk60CyoJu6x0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7915

On Fri, Feb 28, 2025 at 10:08:58AM +0100, Alexander Stein wrote:
> Hi Frank,
>
> Am Donnerstag, 27. Februar 2025, 17:39:47 CET schrieb Frank Li:
> > On Thu, Feb 27, 2025 at 08:54:13AM +0100, Alexander Stein wrote:
> > > Hi Frank,
> > >
> > > Am Mittwoch, 26. Februar 2025, 17:31:26 CET schrieb Frank Li:
> > > > On Wed, Feb 26, 2025 at 01:11:37PM +0100, Alexander Stein wrote:
> > > > > Hi Frank,
> > > > >
> > > > > Am Dienstag, 28. Januar 2025, 22:15:58 CET schrieb Frank Li:
> > > > > > Add PCIe's msi-map and iommu-map property because i.MX95 support smmu and
> > > > > > its.
> > > > > >
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/freescale/imx95.dtsi | 14 ++++++++++++++
> > > > > >  1 file changed, 14 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > > > index 6b8470cb3461a..2cebeda43a52d 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > > > @@ -1573,6 +1573,12 @@ pcie0: pcie@4c300000 {
> > > > > >  			assigned-clock-parents = <0>, <0>,
> > > > > >  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> > > > > >  			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> > > > > > +			/* pcie0's Devid(BIT[7:6]) is 0x00, stream id(BIT[5:0]) is 0x10~0x17 */
> > > > > > +			msi-map = <0x0 &its 0x10 0x1>,
> > > > > > +				  <0x100 &its 0x11 0x7>;
> > > > >
> > > > > Aren't you missing msi-map-mask = <0x1ff>; here? Similar to pcie1.
> > > > > Either way, with this change PCIe on pcie0 is not working anymore,
> > > > > regardless of msi-map-mask.
> > > >
> > > > Yes, it should have msi-map-mask. During my test, I have not enable enetc
> > > > so I have not found this problem.
> > >
> > > Just to be clear: This is not about enetc. This works fine here.
> > >
> > > > > Without msi-map-mask:
> > > > > > OF: /soc/pcie@4c300000: iommu-map, using mask 000001ff, id-base: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > > > OF: /soc/pcie@4c300000: no msi-map translation for id 0x300 on (null)
> > > > > > r8169 0000:03:00.0: error -EINVAL: enable failure
> > > > > > r8169 0000:03:00.0: probe with driver r8169 failed with error -22
> > > > >
> > > > > With msi-map-mask:
> > > > > > OF: /soc/pcie@4c300000: iommu-map, using mask 000001ff, id-base: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > > > OF: /soc/pcie@4c300000: msi-map, using mask 000001ff, id-base: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > > > r8169 0000:03:00.0: error -EIO: PCI read failed
> > > > > > r8169 0000:03:00.0: probe with driver r8169 failed with error -5
> > > >
> > > > Can you try remove iommu-map and keep msi-map? then remove msi-map and
> > > > keep iommu-map to check which one cause this problem.
> > >
> > > With only msi-map removed, but smmu enabled:
> > > > arm-smmu-v3 490d0000.iommu: event 0x10 received:
> > > > arm-smmu-v3 490d0000.iommu:      0x0000001100000010
> > > > arm-smmu-v3 490d0000.iommu:      0x0000020a00000000
> > > > arm-smmu-v3 490d0000.iommu:      0x000000009b0cc000
> > > > arm-smmu-v3 490d0000.iommu:      0x0000000000000000
> > > > arm-smmu-v3 490d0000.iommu: event: F_TRANSLATION client: 0000:01:00.0 sid: 0x11 ssid: 0x0 iova: 0x9b0cc000 ipa: 0x0
> > > > arm-smmu-v3 490d0000.iommu: priv data read s1 "Input address caused fault" stag: 0x0 r8169 0000:03:00.0
> > > > enp3s0: Link is Down
> > >
> > > With only iommu-map removed, both smmu enabled or disabled:
> > > > OF: /soc/pcie@4c300000: msi-map, using mask 000001ff, id-base: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > r8169 0000:03:00.0: error -EIO: PCI read failed
> > > > r8169 0000:03:00.0: probe with driver r8169 failed with error -5
> > >
> > > Only if smmu is disabled and msi-map is removed the driver probes
> > > successfully:
> > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > r8169 0000:03:00.0 eth0: RTL8168g/8111g, d8:9d:b9:00:16:10, XID 4c0, IRQ 160
> > > > r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> > > > r8169 0000:03:00.0 enp3s0: renamed from eth0
> > > > r8169 0000:03:00.0: enabling bus mastering
> > > > r8169 0000:03:00.0 enp3s0: Link is Down
> > >
> > > > >
> > > > > Without msi-map/iommu-map:
> > > > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > > > r8169 0000:03:00.0 eth0: RTL8168g/8111g, d8:9d:b9:00:16:10, XID 4c0, IRQ 166
> > > > > > r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> > > > > > r8169 0000:03:00.0 enp3s0: renamed from eth0
> > > > > > r8169 0000:03:00.0: enabling bus mastering
> > > > > > r8169 0000:03:00.0 enp3s0: Link is Down
> > > > >
> > > > > pcie1 works as expected. But this is only a single PCIe device, rather than
> > > > > having a PCIe bridge.
> > > > > Any idea what's wrong here?
> > > >
> > > > Can you help dump more information at for PCIe bridge case:
> > > >
> > > > imx_pcie_add_lut(), need rid and sid information.
> > > > drivers/pci/controller/dwc/pci-imx6.c
> > >
> > > Just to be clear, without msi-map and iommu-map I get:
> > > > imx6q-pcie 4c380000.pcie: rid: 0x0, sid: 0x18
> > > > imx6q-pcie 4c380000.pcie: rid: 0x100, sid: 0x19
> >
> > Can you help dump register value PE0_LUT_CREQID offset 0x101 for your
> > smmu-map or msi-map enable case
>
> I am assuming you meant offset 0x101c, as stated in the RM.
> I added a dump directly before printing "PCI read failed" in r8169_main.c.

Can you point me the code about where "error -EIO: PCI read failed"?

I tested nvme devices worked at both PCIE0 and PCIE1.

Which PCI switch do you use?

Frank

> Unfortunately this only returns 0 for both PCIe devices, so I'm wondering
> if this is correct.
>
> > 2nd test.
> > change IMX95_PE0_LUT_MASK to 0x1ff
>
> Unfortunately I do not notice any effect/difference.
>
> Best regards
> Alexander
> --
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
>
>


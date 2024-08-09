Return-Path: <linux-kernel+bounces-281299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0569494D53C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF640281047
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CD63B782;
	Fri,  9 Aug 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EUe8huNK"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED7D3AC2B;
	Fri,  9 Aug 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223516; cv=fail; b=P0rFC5GBuelzJ8/80AyjOoVO/8fVp/4F6AXbCQzqhmI3VKaUBOVFjHy8qw4SeVzt8DNuyNP95hdeasPIIhqbXtkgx7zIP2ZeFhmYaZ0v+2Kl3HpxmF38sg2nFVsC9vzkW161RWRbDv21wo5+UqIXr6aF/FoSunGXxUGm5tfLvAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223516; c=relaxed/simple;
	bh=HBSc8zqPkLQB4mkoyaPdrz4w/4Q/8CaRXUiSMG4DybU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f4tA765wHFUsBPI8/cdBtljEkN81ap+UCaQXpObNc8EySJOGFEC7JubHlhuKQc0lMxVREDVkCSejQDrYr3YjEnwr8l3WosfsdlqtOkB2fHIDLIF4Vf+wknnLFNffw91Fnxtgf3px7KZdz53gTp8elQWbim2moteiv2uYZAJvK/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EUe8huNK; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBzOaHGNwThFN7IQMjaIiWboxrZWcLq/nz9PV6/oHgaYCYiPWP1tPrBAg85pB5PVCe8BGoHIwKQEaIOIjWJQ1rLDje4r4WqaFcNzgpVcE3GrgFq6GWY4UBJVJZb8jcgPre422vfeKAVHOODPtGbv5EKF8ssWQxbS2SXyQ30QVyZIt7nW4qlBqPBBuQ2nzsN8uNJlcqk8BXnsRgOoeYvWsjbbIPjnqhDB7PBQ51u5sMBK58ibXfoISUxv73d9A8okjPdRNQs1LDt8p8kSAxR8m7QC4+nxWiOO+o0YxBkkCbTHg4yoRF5uAS+GIAoke+UDd80TuxWAvuc6JdS6oJ5l8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inX3uZ9dqtdeLtpiBCWaVSFQDJI+ma5zZO2ZxwI8Gos=;
 b=w+76icnViG4qfINblkuVqpBESORjvaaYCgbNMeZDX9IMfk6eiI2wgH/aWJkUFiZuO69PzL43jjWtN5a+uBsZgTRHoyTQh+/2kbbUq6qx6cpKz5CMNXEWMpdu8tYblMl2rMq2OQYza9HYRL+jlVxCVugQvaDeO6W+27PNu1Z2v15Q7zv1pIj5lm4slrzMq7xZ6L2bDr4WgVxhg7UT6yvMxzHR+8z1Pf4TAq7V6aGqMQQ11V++kblAKuc6wK0gXuPWvkNZ5TXXEtjO9iRstGcbJDgzVPzSXX+FflP12feRkjjqKN/VEo4lL5DIfCn+dK9samW00FzEsSIqJ2Y9VfzJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inX3uZ9dqtdeLtpiBCWaVSFQDJI+ma5zZO2ZxwI8Gos=;
 b=EUe8huNKlOqKiEFqMPH68/IUxO9p0+XhRbwU/s+ILEpBV9+AuvWBbVnOA2WUoWI2U5UAa4W6AObNUgdyuTNlc2KcAa1CKqnrAgCAIwJWkvcKGqFI5B10160fbnINfNt43gEzZG42iAJeuEUDjrJMrz28VrwUSgXexHJVZG50WRrKoX1t4hsbhdcuH3WlYWfFAI0PA16PYys+T0BNwfovL2q56sAXXocvDIPOrZCsB1mAydVvb8pYMUcxW9LGM+F882YLgy8QdhQf07URvZvNRIBTbeCNi3akQlJbLyhWfQil69d49Z1lJmkNGtITbg1AGJ7b2kJpQmrNv6ihdxAfgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8193.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 17:11:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 17:11:50 +0000
Date: Fri, 9 Aug 2024 13:11:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] arm64: dts: lx2160a: Change PCIe compatible string
 to fsl,ls2088a-pcie
Message-ID: <ZrZNzqDKUaOqzl7k@lizhi-Precision-Tower-5810>
References: <20240808153120.3305203-1-Frank.Li@nxp.com>
 <20240808-frosted-voicing-883f4f728527@spud>
 <ZrTphsdTZVsbiGo/@lizhi-Precision-Tower-5810>
 <20240808-linoleum-evasion-ad7111a2afc4@spud>
 <ZrTvB/3GGIhEOItT@lizhi-Precision-Tower-5810>
 <20240809-freewill-compactor-4f441a4a60bb@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-freewill-compactor-4f441a4a60bb@spud>
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 264189ee-e1be-438e-c000-08dcb8965bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?exXsO3kqnPNcP4/8usa+5A986r7fImdjbhQwUOjnuPJiGfA/VQVRj9/yVvP3?=
 =?us-ascii?Q?R618bDK680M3sUpaOv+4PTy/kbpqwqcyQe8BOVRdZpKRn4UbPLVP7tBBscjy?=
 =?us-ascii?Q?PIpGXLQngnjITlG3c8uqhTgDS8SX7UOAXYQUnJLofZ8ydyeAYa5etbdCjLgb?=
 =?us-ascii?Q?eB1lmwh2P78I3pWnciEcAGxNnWVuaAyu80KYicGWEGXe6Sd1Nm/T3Ak9uc/R?=
 =?us-ascii?Q?TvenCui9FzJqrcjIdkhgB7nffq7wDsY8LqZqYMU3CM+TR59l6nbVl5lFIGS7?=
 =?us-ascii?Q?5ziAtFSQrQkVOCFhH70QfLGsXkztGJUz59eT3ug7RuXznKVBEeAXR/NJK23l?=
 =?us-ascii?Q?f/gE31XqAYSQYveMfFOkCbfYjKxRa8IzikuhwOOZfVuN3HwrT+FwudkzQUoK?=
 =?us-ascii?Q?8mJjhCEgKrZ2+CH2gT/0t6b4F4VThbnxIdbpoSCv0LDYOIQE+IB58ALgRUAy?=
 =?us-ascii?Q?HhSn/wTSousuW2rrz2rDJQQ/HCCceTsuD7JTwuOAPmlZZV/qJDdPKgq/aQNc?=
 =?us-ascii?Q?OZ4dAJI0G1TB36hhPDwv8RyI++wu6h3dL/WUW7p+rrQZsFdJjQLe4PQgR6AA?=
 =?us-ascii?Q?s+WtUp1/sdhPreQcFHC4Vgvbg8Vkn242/2SIHDcoexHkEgtvIfK9JTyGaAQH?=
 =?us-ascii?Q?jOMXSB0TR5ELbNz/ZiISQCxTNm4NaH0luIZHT3SydAYXJtiUREQx4u6rbTxQ?=
 =?us-ascii?Q?Za9hM/NT6u2MDEqYZ7/lxdmBxs4hu8ja62FelGpNOhUl9nghyGP06pJPAG67?=
 =?us-ascii?Q?hLU9jHRMBkpFVUrJWgCeqjAhkEjotVhzeeF4utnRQcJ853amTn1qZ1VVgRK9?=
 =?us-ascii?Q?1MZQo3deJkfpQNXVH+5xoW19NAitrVYxHp/rJPV9MQsIpZwgqx5T37YyHklG?=
 =?us-ascii?Q?1pkbr8karcRtq09j80fdyrkxLNy0kelD48kqjgpb5b7Npm9lA26f93lu1+Rc?=
 =?us-ascii?Q?ssnRFMbY708h+X52EvGNeQKRXpYC6/0ymAgw1QVWGbsVBHVHaVo68I7nWlcB?=
 =?us-ascii?Q?02QnVswGtrjkjQe5yIJR7ifwFsOg7PZ0SKiVGd3HCE44xhpf87jZxLCcZxE/?=
 =?us-ascii?Q?dxhEy3oNYhBVVxMamdCus8etXVPpXxCrby5UvILrCTv7CMG0BYfPS+cfunnv?=
 =?us-ascii?Q?YFoVvjMFWrgFMueyeHrhfyNsPWsiQ5wBz5I/3a+cYqrMc7lsHZoc5bF49A7r?=
 =?us-ascii?Q?pc/JI1Us6fJxJh+q0RIK0E4RYeUbz4oLsV9Yh5PtYEV6s1jwOJyiRZHCsqqa?=
 =?us-ascii?Q?Y6QIWzEKOgC0pr4iR7TJTsfa9HafdrA+RcO29r6oH1iK2E8yyX7jYplQUcaS?=
 =?us-ascii?Q?ylYqtgDvVNyaAnzuCrldqwHAL2GyeVliLmCvrrT5MVho0pz2JPwvodlQbTm3?=
 =?us-ascii?Q?K6ldT1U2Go9dpEvbC8f8LeaADLmOHu+qR3uzgZxGM2UNl72DBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mLUCTb4TfL2sVkYQKMJwC6vfRwcAqnjjJ1Yg2q87Cfeo5WKp4rmVpRQQZCdU?=
 =?us-ascii?Q?kvKut3ALJmFNmbxV2403Ve8msgjiC7k7sIXgC/qOPFUsYUFISmuRmaeQN1eA?=
 =?us-ascii?Q?DUc/oJWwPz472+qwGOl6Dtg3L44/7cYsR4ZPWP1n50Pzeq1bdtxkkyRuEj7d?=
 =?us-ascii?Q?Qw31zlfmo5n5u0iAEguVIfKDrntvVAX3ti5nArh2nEGer5njjzciwRy6tcPc?=
 =?us-ascii?Q?pNm5TQuu8OQWHbguOaUA3WZd5jGsjNPmexDq5UnosSb1UlXFhfDMHUocnhA6?=
 =?us-ascii?Q?/o0WMi1Mx5qLdtgmpHcy9VJWaTD81/UfwRXLzjx3vWbtCgeCbWdzZEcMVwSi?=
 =?us-ascii?Q?vqCcCd5m8oQldhpGUfjdb/nXzBx124UzHk0ZoVEosNHz43IjvFanSXX2WF4/?=
 =?us-ascii?Q?ziVkx+x5pMvRVtmG0GxYQa4V64hT3+y1ilkf0EJHd76Z7kqAfsBJYErGi2Jw?=
 =?us-ascii?Q?Y8w3cZWtyvd4UA3zXIDWy6/hwqer5NxEAaz30d6QmUQkzAPyPPdikb1zGMtU?=
 =?us-ascii?Q?XeFRPuMk65y9hOkR5fQ/k707Ru1v079mUm4a3xbjL+PSgcQiBxTbd2IEAE29?=
 =?us-ascii?Q?SSrWI+qY98Mk03VsRAkUg0XWUonL3aKYqZy+M//k5Z+D0ao1f4xu0Evj5Vie?=
 =?us-ascii?Q?8FfKhgBht/ie/FIk/48UUb2m19uv1YBlVF1YaAcJvHme6Z4gJuQf/lzpujgI?=
 =?us-ascii?Q?Rh1QD6jg8z4aY89BfaINO1UyRYnMQEgFvt56fC4NBd59Nh5BLn5kJxJRr0h7?=
 =?us-ascii?Q?vQ/q4eP4JK0Uv0hECSg0o2xS43WS63gaLMNPBJKuI6t3yLonlW7F7bEwFP/S?=
 =?us-ascii?Q?AmF9Rhb3cf5BxmV/nUzR+6qQ8z0ghDOSFT2Z8IvvlSq0ou/gvC49f/lJo/uT?=
 =?us-ascii?Q?PpaVrCiIUejorj1hLWF/up1dKHgb7QQuuJh9eoTZWuRUR79VnOE1+3/ooQb7?=
 =?us-ascii?Q?abhlepOT94s1MiugqrQANLTDzLZ8kONqJVdFKPrVfo/usV17iMXa0G2jaOds?=
 =?us-ascii?Q?uGzeqWU7l3k22Z6u1Q70kRd1Znw5WB+eDRAGq/S8015hdjlBY6w25spoB/b/?=
 =?us-ascii?Q?te4A7lIo27njOPnKEySERr1Oy8QRqtkgDz+4RE1c0G9ZDnrwBy/gQrvHyWA2?=
 =?us-ascii?Q?GIPt6rtDy0uN3tPKBD4NphSyqX0YRRS5flPXGs09FiQX2xZx+4TfAXNUfmFJ?=
 =?us-ascii?Q?cGU7sXWUd0Zu2/gbvP9VaUC1b/+zg4LctTQwxpwFvuJYSjkBpuwshHsogjly?=
 =?us-ascii?Q?5zAW5U+FY+funSKKQzUkJea3WkIslmiBTB0CXYzM8Ah5UpLqODnMF0duZP7/?=
 =?us-ascii?Q?JAju7O3sVyQ2OeWQ7hvlRkas1D8lzPA7Gm+dUmb4pUT/G78KQKcWX/LA/v52?=
 =?us-ascii?Q?eNb1iA9YiEGJDyR5h4pXf4+HaZpVL3uMJDvNnhk8bRN30PbQFKD1UjzxE2hT?=
 =?us-ascii?Q?TP6EuAtdCtIQMc7vyL+8WHQb7+zVFrLL5tTd+/PJEQDVoscylZ2db0m0Vvpm?=
 =?us-ascii?Q?8LGrxnZ+ip8XVPk/8jisg480QYZ1K1g+vuquPUSA2CcNYNhDvfhVIkDW2D8l?=
 =?us-ascii?Q?cZxdYUcOWFS1P4hJTq9egQprSKHKCm9rFNWhhUIo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264189ee-e1be-438e-c000-08dcb8965bda
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 17:11:50.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ch9LsiQ0CEsaxKrBNhQjrO4IgdSlhDFXy9VXdEpq1nUnK9CEwrgkBCYpC8yXroRRpbUSNP7wrJpRqLybFY6scw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8193

On Fri, Aug 09, 2024 at 04:07:25PM +0100, Conor Dooley wrote:
> On Thu, Aug 08, 2024 at 12:15:03PM -0400, Frank Li wrote:
> > On Thu, Aug 08, 2024 at 04:55:14PM +0100, Conor Dooley wrote:
> > > On Thu, Aug 08, 2024 at 11:51:34AM -0400, Frank Li wrote:
> > > > On Thu, Aug 08, 2024 at 04:34:32PM +0100, Conor Dooley wrote:
> > > > > On Thu, Aug 08, 2024 at 11:31:20AM -0400, Frank Li wrote:
> > > > > > The mass production lx2160 rev2 use designware PCIe Controller. Old Rev1
> > > > > > which use mobivel PCIe controller was not supported. Although uboot
> > > > > > fixup can change compatible string fsl,lx2160a-pcie to fsl,ls2088a-pcie
> > > > > > since 2019, it is quite confused and should correctly reflect hardware
> > > > > > status in fsl-lx2160a.dtsi.
> > > > >
> > > > > This does not begin to explain why removing the soc-specific compatible,
> > > > > and instead putting the compatible for another soc is the right fix.
> > > > > Come up with a new compatible for this device, that perhaps falls back
> > > > > to the ls2088a, but this change doesn't seem right to me.
> > > >
> > > > It can't fallback to fsl,ls2088a-pcie if fsl,lx2160a-pcie exist, which are
> > > > totally imcompatible between fsl,ls2088a-pcie and fsl,lx2160a-pcie.
> > > >
> > > > Previous dtb can work just because uboot dynamtic change fsl,lx2160a-pcie
> > > > to fsl,ls2088a-pcie when boot kernel.
> > > >
> > > > fsl,lx2160a-pcie should be removed because Rev1 have not mass productioned.
> > >
> > > Please re-read what I wrote. I said to come up with a new compatible for
> > > this device, not fall back from the existing fsl,lx2160a-pcie to
> > > fsl,ls2088a-pcie.
> >
> > According to my understand, It needn't add new compatible string if nothing
> > difference. for example, it use fsl,vf610-i2c for all i2c without add
> > new soc-specific fsl,lx2160-i2c.
>
> No, you should have soc-specific compatibles regardless. Just because
> you got away with it once, doesn't mean I'm not going to complain about
> it here!

Rob:
	What's current policy for this? Not only for this one. If new SOC
appear such as iMX10 (maybe many derived chip i.MX101, i.MX102...), there
are bunch of IPs, Do we need add fsl,imx10* for everyone, which most part
is exactly the same as old one and bloat binding doc.

	I remember that I got a feedback that required provide the
difference during I try to add new compatible string. I am sorry, I can't
find origial dicussion thread.

	Anyways, a clear guide line will help us greatly.

Frank

>
> > So far lx2160a-pcie is the same as ls2088a-pcie.
>




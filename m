Return-Path: <linux-kernel+bounces-337295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B3F98484F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C67E1C21799
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967341AB6D1;
	Tue, 24 Sep 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ViP2BD5L"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013042.outbound.protection.outlook.com [52.101.67.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944721A4F30;
	Tue, 24 Sep 2024 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190611; cv=fail; b=Z0KkGGZ4JtZ7OAH6lcOQFXjs37xULi1sGCZdGcKY2xsTi8dZToADqQJH2K9DiBGAlZtwrPDP5HZNBM6Pv/yCrkmP8Lu/qskx5TriS8D2T53IDbWK7n1mPRZNkaP5LyvtdlK6qRq7Y242ld9+bWETrfcCSmmMdKpUvNvF09xo68g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190611; c=relaxed/simple;
	bh=y1IAs01G5U3Q+tYsiTjFnv/wtLXyY9LKQdFTOaCtWu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g5neGZSBzZrPymG7jkXPIB5SX0WIVyPGOC4+CttVH3+LsZtMef1MV9+Fb5Xxey5ejPGpvzqs7rLW5eeqRknbaFwq2UJCWgs32dd0FniWPr5ZoUZh654Z19xp46pJXDdKMeFrtExj4aj57FpGo2SaaEJjyoXH1kAb7jAhS2IpOFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ViP2BD5L reason="signature verification failed"; arc=fail smtp.client-ip=52.101.67.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBuKNsIC+Hy33NFWktEqvH65BOug1Gozm9Q4rGuzf35usK6zpxyCUuHto5nJX6rcjQLm9YVtzbT1HSJMkJ0fGTe4zAyLIot4Qtc5A1hTT/POjgJZ0wvDyYqjyG+FYT4fLKWd+TGYrw4JAC/pnpLMdUYrsSzFsfmLzs+ubUQrGWynb/u3so7WREowlIVFd1ecFDDjySyfrWz9ntq/0Bye5OHFZpkJlV2DT57lM0YTnTvEwRGquRc2kVQ9OMzRE7VYb/rzQuLGNwCtgMJV/Z9PHpXoUwbjfb1pnb0rzl9f+kVPlq2P9vGmhNKjqyGCyAFZHjUa5ZQMCDAqZl6TTEkDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUAaxgEJf7mAPVUw+KWhH8GrsUmYxnIrVt6vindvpq4=;
 b=mVFeUDUTFAag6BlJAT8Xcn8NQ20e04xDy59/7EwT7zzVgvDBeCDmRywMdhJJNwafzJ/lQrh1YEOftjCnd7B73A44EPF6XlSCCzJY7LtzjFD3fG19wMmcGdegq8hHba9JGA2H4phCqnlfMa9SOPt6Ertr9qOtz/pm57ETavkhG0AIAA+boAp4pJQKxDXRiJL4j549fci2i8JOf6CiYJb2ab0pVRTbFOQJwTWQ5qCh76xCxePVg3f5k68pJ1AHWw5qzhG+XEHexPdtvUmuaUOw6fng72cjYujgeSZ0cwa8bIMEmP5Kcje2yst4ZehTY9nH8A5OMjHkaPCOUnH1hZtGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUAaxgEJf7mAPVUw+KWhH8GrsUmYxnIrVt6vindvpq4=;
 b=ViP2BD5LQpON4luWAFjEzOlk89nOtAwxkn8YkBVR6gXdff1P04j20i2NR5SexyduiqGMtVYr61BBE7UeHuVc3Vblfg2Pg1z1FVIikpGTGCA+Johs0hJmr6+XO5isRRFG04cELuD1bXKrXcRdNKbteo7BVzQxDMqnRKwVnregBWHSTRrRnPppSqVE+kYmQmxTa7OELb85UFfqkA9weh1A0knIE7SVYg0RuJ65O5qsxmllqqS0PRwbVHy9xXYzd6d7+tA3RszhU+LO+oz6e+Bp6hTREeS9kq5y9o7dYNB7PcHiGxPiIX+SczIbsdDZ7UQMh1Y+A5P5JNndJWcm7NOgpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8249.eurprd04.prod.outlook.com (2603:10a6:10:25c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 15:10:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 15:10:00 +0000
Date: Tue, 24 Sep 2024 11:09:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 3/3] arm64: dts: freescale: imx8mp-verdin: Add Ivy
 carrier board
Message-ID: <ZvLWP62Gw0nygxaF@lizhi-Precision-Tower-5810>
References: <20240924114053.127737-1-francesco@dolcini.it>
 <20240924114053.127737-4-francesco@dolcini.it>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924114053.127737-4-francesco@dolcini.it>
X-ClientProxiedBy: BYAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::48) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca14873-ee64-4f61-eb03-08dcdcaaf573
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?ZbTVZiEo7ycF1JMpPttekoLNgSWvxNLOxfoloFUtHHRuyzAO52DH/tsn6G?=
 =?iso-8859-1?Q?S+BLLgyjTIu9HVBofWj6Ld3wJGMFkummqXRn6Ed2FKipmFoZTJcasvQvHi?=
 =?iso-8859-1?Q?nZ9g0ZjsSMvUKdiRiviHktBSei+Nb6VP1P4QNMCktiYDOnkdmby3Fz7wVm?=
 =?iso-8859-1?Q?q6p0q58u5NSp796EnIqBI3CfleZLy49cU7iWkFuJxbl2xJ/oMRWCz/y+FL?=
 =?iso-8859-1?Q?PtKKOT1JAb4TnsDDqqReNr4Kj25+H6lc2vl2KmNgPp0M0RxIo79CLSzZcJ?=
 =?iso-8859-1?Q?engYo1EZG+0BMShSg9roSKkwzPz4FYHyrQqht44qmyEqKn2UFcYDoIIIVc?=
 =?iso-8859-1?Q?wY3GgybzgM9I9iUIlth35Oqm41PdGrjs6aZu/hI8lTJFR+LFUKKsgC/0OE?=
 =?iso-8859-1?Q?9gL8UO5J8RzPOnFn2D+b4F9qHyQMVH2CMq/Jw984YwIe2cJG/617+mQUIe?=
 =?iso-8859-1?Q?xTQx1xA2T2WXGAkgXivntC7q1FO511NW6nJP8C17NTPZNvhvjB735OxxXE?=
 =?iso-8859-1?Q?Q6lc+S2XxSClBi8enFAgopM3GExwSsBuc+TTs34gXz9AFt9ltaJsdfl39G?=
 =?iso-8859-1?Q?NiSzXhl/k4kqITTuNAOFco8IL32vVhVHFvHG1XVpvF63G7nd+3eWpg3ADq?=
 =?iso-8859-1?Q?QBVSkvaDI+7k0eFfjH+hR6knMn/XATPvw0BSnynfZYM4JWneAU6/GCVfqY?=
 =?iso-8859-1?Q?jtqOekf52643BVqgJCZKHrJvD/qf+Sna5BdsXD+HFogSLtM3FSEvuh8L1U?=
 =?iso-8859-1?Q?Pg7rM/lUwG+L2R2n2yWCaSd1VkLsqzpdhwpPsgK/oXe4hFY/699ent0SnH?=
 =?iso-8859-1?Q?zxQjYA9AF1rSevdSSvveHw2jeLsgKOk11tn27uEUodJnCKOMbm2OiDDVdz?=
 =?iso-8859-1?Q?Lcx/CaL60CnmggKdUNUEsPKROq60xb6LIIctYm87svaFI3w5N9/4Ulk7Ls?=
 =?iso-8859-1?Q?8DUpOwAOx0icq7mcZ9qDR9PAfF53AdRiJKwEIx51irgR3Dd5h0sMzVlomZ?=
 =?iso-8859-1?Q?qfN0QJ9g7BG4kxRE4kqPPEY0VFEyGVoxKSA0LmZnkqssnXv1/T7pjqROge?=
 =?iso-8859-1?Q?Z9Jck6tHxPlhLi0DmPt5JeFT5xzZo7ZUXl1yed9y/ZDBLn7fmk3hV5j25f?=
 =?iso-8859-1?Q?I9b9l2Ii3bQTiVB7Oa4/X+bZSRGkqlpSmdynorIJC8R52aMooEsyYXybeY?=
 =?iso-8859-1?Q?jclT7QvvG2j1JTR/Jv1a0jYxnQJMJO1co0I9K9YYpg2VK9JOVM6fo2ERxR?=
 =?iso-8859-1?Q?QLvTDh6rgzfOCy7rdCgoactNG5NTbOBTbTwjzuyvI7CFFS883lRR4ftsrI?=
 =?iso-8859-1?Q?tfX/9GltIGzwXB/Zxo5dpmwhvg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?B3Tm1L7dkvBhoEkyo138reUcTHWUC2zdQttJUGogbNiVeHo+WadP///Yrd?=
 =?iso-8859-1?Q?2aKcgXeERqM1VmFA+BJ+RaJDEi9xeX7rloH05q/lLZn31PjXR3Sq+C1Q3b?=
 =?iso-8859-1?Q?kPgP45/MhmsuSawrvnB6yOYhj2gVFX89p5WEKLnz9Jkxe4GScglU81GTBN?=
 =?iso-8859-1?Q?LYHUIGEMueuxSoLSGVrTKASiXVUt4EqKN+Hv/Lcy/i2Ch6k8fdLpRUx8HI?=
 =?iso-8859-1?Q?FslqezWwvpTRaVUzNWGhLvi4M61PzdF7P0Aa01jsNo5nZJ8trMxSffaXHE?=
 =?iso-8859-1?Q?L4N1fs5ZWIMWXf+U5EYnujgzWl4bzoyTtdtRmvQXc7IEOKa1/1laA3L50w?=
 =?iso-8859-1?Q?3uJgfx+q3hmuYfen4ddGcQhI+KCWx0DFY6tfZyYyvF6hP8AtErTq4Yv3YK?=
 =?iso-8859-1?Q?GhGxOD3h5es6VsymoBUsVZ3Om7aBvJpT5vVZGiWli7qiJnHz0epReaPPZQ?=
 =?iso-8859-1?Q?dIs17oHiRDaggLxfueDIpfj1F+0q6KIETe8Dc89r9RK7B9iZUQuGmskxo6?=
 =?iso-8859-1?Q?0RZue7jPR+EXDDFS06BBJYV1ioyh1ZqkMzO0b+l2zqRt/N5RK3IK+LpmGC?=
 =?iso-8859-1?Q?hHP+cm47ulFb8JIgGQOWFaY4vPjLDizIwkY9Q9oUDr40HYbV74N3woFcXI?=
 =?iso-8859-1?Q?OLtcDt8NdWhypNtLYCCv0C3tenN4QXVFfCghsvwsXxvAS8/E9G3vmh6YTl?=
 =?iso-8859-1?Q?eAYe4JW5mkJ/+/gpTF+zWMMZpJYD7PMajYxNy9zDLhT4zhppDUdI2qJc2r?=
 =?iso-8859-1?Q?DrUOn+0/bURUc/4vCPK1tls9n2QvtLzgD9EN3gp6hnIZWuuMmHr15F1C3N?=
 =?iso-8859-1?Q?CaDFqbNWfo+QfdOG83lS1Ty8CmvCWXS7rVWLl8NA+FyzIbajmv/pnEPVhJ?=
 =?iso-8859-1?Q?eKHquDjPHYavIyZ8qfAsSRSYgOwkO4gqx/9FE8YelHWHymCOsd+hSjT/+M?=
 =?iso-8859-1?Q?1WgqoBOpws+azvXgTC+P7K69vctw26f5Ew3AbVSo+JbkomuJVdR5YsTffT?=
 =?iso-8859-1?Q?aHcjdRZa6Ps+PomdlJYt4KcHXE4gNPMBZiTDXQ/lmzMpDwaMp3NkEAqoOB?=
 =?iso-8859-1?Q?/DDN6eEQa+2+a2qVLJWX+ESc0+D5h6xhyZG9rwQL/rShq2Qh2REll+Obz+?=
 =?iso-8859-1?Q?lc13UfazB/+OFqSHMc7qS9JUq2CpUPm0RlIKE9qzhSkH6dchS/DmgjaFZy?=
 =?iso-8859-1?Q?o966eaDdwdjRj+K2/+NO5Ea7MneNkdLjeeNmoHw5Lu5V23vfAjzcUJbSXE?=
 =?iso-8859-1?Q?hGFLthUKLZGROmIXxKIC1QTuk77DiUa2a1O+svfOBX6ahkqXFhshuNJbID?=
 =?iso-8859-1?Q?3OR1yIFXIffUoT3bTy3eLyn8vj3/64Efapqlxj/OQTYza1pO7nD2Tkh6QE?=
 =?iso-8859-1?Q?/FUSJNP4uEFMo4nRNrDtTN4GRGQB028/fvbuyjtddPFJ2b4trsSy/IGp2K?=
 =?iso-8859-1?Q?H2iluVRIqQesTsumqQcEn9PGny6rX9G68TK+c54NvLzqMGc2pDsrt7vvqf?=
 =?iso-8859-1?Q?Q63IORGSQeX+Z53XSsilm2WIzn6o/qbsuiHiaIe/o90OPJgln89xFNwTJH?=
 =?iso-8859-1?Q?vf7QkNLyJqT0pfUFeqf0vWoJOJFC0lZi3cEssmflhVwf3rNJyv7NnJ3+0K?=
 =?iso-8859-1?Q?37kitMtm1Hb1M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca14873-ee64-4f61-eb03-08dcdcaaf573
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 15:10:00.3234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFCMvxSxu+bAIWUfgNev54Os9/Zbv+59wuO+E+5p94c6ma2OwBIzmw2oDTt7H0nmfvzpv+yw2BLWykwuMSKl2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8249

On Tue, Sep 24, 2024 at 01:40:53PM +0200, Francesco Dolcini wrote:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
>
> Add Toradex Verdin Ivy carrier board support. One notable feature of Ivy
> is the analog inputs. These inputs are multiplexed, allowing the same
> input to measure either voltage or current. For current measurements,
> a GPIO switch enables or disables the shunt resistor. This process is
> automatically managed by the Linux kernel using the IIO and MUX
> subsystems. Voltage measurement is always enabled, but the voltage
> measured by the ADC is scaled by a cascade voltage divider. In the
> device tree, the equivalent gain of the voltage divider is used, which
> can be calculated as follows:
>
>                ------------
>                +          |
>                          .-.
>                   R1=30K | |
>                          | |
>                          '-'
>                           |-------------------
>     Analog Input (AIN)    |                  |
>                          .-.                .-.
>                   R2=10K | |         R3=30K | |
>                          | |                | |
>                          '-'                '-'
>                           |                  |
>                           |                  |--------
>                           |                 .-.      +
>                           |          R4=10K | |
>                           |                 | |      ADC Input (Channels 0 and 1)
>                           |                 '-'
>                -          |                  |       -
>                -----------|                  |--------
>                          ===                ===
>                          GND                GND
>
> Vin  = Analog Input (AIN)
> Vout = ADC Input
> Rth  = Thevenin Equiv. Resistance
> Vth  = Thevenin Equiv. Voltage
> RL   = Load Resistor
>
> R1 = 30K, R2 = 10K, R3 = 30K, R4 = 10K
> RL = R4 = 10K
>
> Rth  = (R1 // R2) + R3 = 37500 Ohms
> Vth  = (Vin * R2) / (R1 + R2) = Vin/4;
> Vout = (Vth * RL)/ (Rth + RL) = Vth/4.75 = Vin/19
> Gain = Vout/Vin = 1/19

which properties related these value?

Frank
>
> https://www.toradex.com/products/carrier-board/ivy-carrier-board
>
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   2 +
>  .../boot/dts/freescale/imx8mp-verdin-ivy.dtsi | 512 ++++++++++++++++++
>  .../freescale/imx8mp-verdin-nonwifi-ivy.dts   |  18 +
>  .../dts/freescale/imx8mp-verdin-wifi-ivy.dts  |  18 +
>  4 files changed, 550 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-ivy.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-ivy.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 9d3df8b218a2..349ff1af0361 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -189,10 +189,12 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw75xx-2x.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dahlia.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dev.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-ivy.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-mallow.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-yavia.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-dahlia.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-dev.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-ivy.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-mallow.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-yavia.dtb
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi
> new file mode 100644
> index 000000000000..db1b4ee7728c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi
> @@ -0,0 +1,512 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2024 Toradex
> + *
> + * Common dtsi for Verdin IMX8MP SoM on Ivy carrier board
> + *
> + * https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx-8m-plus
> + * https://www.toradex.com/products/carrier-board/ivy-carrier-board
> + */
> +
> +#include <dt-bindings/mux/mux.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +	/* AIN1 Voltage w/o AIN1_MODE gpio control */
> +	ain1_voltage_unmanaged: voltage-divider-ain1 {
> +		compatible = "voltage-divider";
> +		#io-channel-cells = <1>;
> +		io-channels = <&ivy_adc1 0>;
> +		full-ohms = <19>;
> +		output-ohms = <1>;
> +	};
> +
> +	/* AIN1 Current w/o AIN1_MODE gpio control */
> +	ain1_current_unmanaged: current-sense-shunt-ain1 {
> +		compatible = "current-sense-shunt";
> +		#io-channel-cells = <0>;
> +		io-channels = <&ivy_adc1 1>;
> +		shunt-resistor-micro-ohms = <100000000>;
> +	};

Suggest you use https://github.com/lznuaa/dt-format
to sort nodes.

Any problem, let me know.

Frank

> +
> +	/* AIN1_MODE - SODIMM 216 */
> +	ain1_mode_mux_ctrl: mux-controller-0 {
> +		compatible = "gpio-mux";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio5>;
> +		#mux-control-cells = <0>;
> +		mux-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	ain1-voltage {
> +		compatible = "io-channel-mux";
> +		channels = "ain1_voltage", "";
> +		io-channels = <&ain1_voltage_unmanaged 0>;
> +		io-channel-names = "parent";
> +		mux-controls = <&ain1_mode_mux_ctrl>;
> +		settle-time-us = <1000>;
> +	};
> +
> +	ain1-current {
> +		compatible = "io-channel-mux";
> +		channels = "", "ain1_current";
> +		io-channels = <&ain1_current_unmanaged>;
> +		io-channel-names = "parent";
> +		mux-controls = <&ain1_mode_mux_ctrl>;
> +		settle-time-us = <1000>;
> +	};
> +
> +	/* AIN2 Voltage w/o AIN2_MODE gpio control */
> +	ain2_voltage_unmanaged: voltage-divider-ain2 {
> +		compatible = "voltage-divider";
> +		#io-channel-cells = <1>;
> +		io-channels = <&ivy_adc2 0>;
> +		full-ohms = <19>;
> +		output-ohms = <1>;
> +	};
> +
> +	/* AIN2 Current w/o AIN2_MODE gpio control */
> +	ain2_current_unmanaged: current-sense-shunt-ain2 {
> +		compatible = "current-sense-shunt";
> +		#io-channel-cells = <0>;
> +		io-channels = <&ivy_adc2 1>;
> +		shunt-resistor-micro-ohms = <100000000>;
> +	};
> +
> +	/* AIN2_MODE - SODIMM 218 */
> +	ain2_mode_mux_ctrl: mux-controller-1 {
> +		compatible = "gpio-mux";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio6>;
> +		#mux-control-cells = <0>;
> +		mux-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	ain2-voltage {
> +		compatible = "io-channel-mux";
> +		channels = "ain2_voltage", "";
> +		io-channels = <&ain2_voltage_unmanaged 0>;
> +		io-channel-names = "parent";
> +		mux-controls = <&ain2_mode_mux_ctrl>;
> +		settle-time-us = <1000>;
> +	};
> +
> +	ain2-current {
> +		compatible = "io-channel-mux";
> +		channels = "", "ain2_current";
> +		io-channels = <&ain2_current_unmanaged>;
> +		io-channel-names = "parent";
> +		mux-controls = <&ain2_mode_mux_ctrl>;
> +		settle-time-us = <1000>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ivy_leds>;
> +
> +		/* D7 Blue - SODIMM 30 - LEDs.GPIO1 */
> +		led-0 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			default-state = "off";
> +			function = LED_FUNCTION_STATUS;
> +			function-enumerator = <1>;
> +			gpios = <&gpio3 25 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		/* D7 Green - SODIMM 32 - LEDs.GPIO2 */
> +		led-1 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			function = LED_FUNCTION_STATUS;
> +			function-enumerator = <1>;
> +			gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		/* D7 Red - SODIMM 34 - LEDs.GPIO3 */
> +		led-2 {
> +			color = <LED_COLOR_ID_RED>;
> +			default-state = "off";
> +			function = LED_FUNCTION_STATUS;
> +			function-enumerator = <1>;
> +			gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		/* D8 Blue - SODIMM 36 - LEDs.GPIO4 */
> +		led-3 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			default-state = "off";
> +			function = LED_FUNCTION_STATUS;
> +			function-enumerator = <2>;
> +			gpios = <&gpio4 2 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		/* D8 Green - SODIMM 54 - LEDs.GPIO5 */
> +		led-4 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			function = LED_FUNCTION_STATUS;
> +			function-enumerator = <2>;
> +			gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		/* D8 Red - SODIMM 44 - LEDs.GPIO6 */
> +		led-5 {
> +			color = <LED_COLOR_ID_RED>;
> +			default-state = "off";
> +			function = LED_FUNCTION_STATUS;
> +			function-enumerator = <2>;
> +			gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		/* D9 Blue - SODIMM 46 - LEDs.GPIO7 */
> +		led-6 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			default-state = "off";
> +			function = LED_FUNCTION_STATUS;
> +			function-enumerator = <3>;
> +			gpios = <&gpio5 01 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		/* D9 Red - SODIMM 48 - LEDs.GPIO8 */
> +		led-7 {
> +			color = <LED_COLOR_ID_RED>;
> +			default-state = "off";
> +			function = LED_FUNCTION_STATUS;
> +			function-enumerator = <3>;
> +			gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	reg_3v2_ain1: regulator-3v2-ain1 {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <3200000>;
> +		regulator-min-microvolt = <3200000>;
> +		regulator-name = "+3V2_AIN1";
> +	};
> +
> +	reg_3v2_ain2: regulator-3v2-ain2 {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <3200000>;
> +		regulator-min-microvolt = <3200000>;
> +		regulator-name = "+3V2_AIN2";
> +	};
> +
> +	/* Ivy Power Supply Input Voltage */
> +	ivy-input-voltage {
> +		compatible = "voltage-divider";
> +		/* Verdin ADC_1 */
> +		io-channels = <&verdin_som_adc 7>;
> +		full-ohms = <204700>; /* 200k + 4.7k */
> +		output-ohms = <4700>;
> +	};
> +
> +	ivy-5v-voltage {
> +		compatible = "voltage-divider";
> +		/* Verdin ADC_2 */
> +		io-channels = <&verdin_som_adc 6>;
> +		full-ohms = <39000>; /* 27k + 12k */
> +		output-ohms = <12000>;
> +	};
> +
> +	ivy-3v3-voltage {
> +		compatible = "voltage-divider";
> +		/* Verdin ADC_3 */
> +		io-channels = <&verdin_som_adc 5>;
> +		full-ohms = <54000>; /* 27k + 27k */
> +		output-ohms = <27000>;
> +	};
> +
> +	ivy-1v8-voltage {
> +		compatible = "voltage-divider";
> +		/* Verdin ADC_4 */
> +		io-channels = <&verdin_som_adc 4>;
> +		full-ohms = <39000>; /* 12k + 27k */
> +		output-ohms = <27000>;
> +	};
> +};
> +
> +/* Verdin SPI_1 */
> +&ecspi1 {
> +	pinctrl-0 = <&pinctrl_ecspi1>,
> +		    <&pinctrl_gpio1>,
> +		    <&pinctrl_gpio4>;
> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>,
> +		   <&gpio1 0 GPIO_ACTIVE_LOW>,
> +		   <&gpio1 6 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	tpm@1 {
> +		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> +		reg = <1>;
> +		spi-max-frequency = <18500000>;
> +	};
> +
> +	fram@2 {
> +		compatible = "fujitsu,mb85rs256", "atmel,at25";
> +		reg = <2>;
> +		address-width = <16>;
> +		size = <32768>;
> +		spi-max-frequency = <33000000>;
> +		pagesize = <1>;
> +	};
> +};
> +
> +/* EEPROM on Ivy */
> +&eeprom_carrier_board {
> +	status = "okay";
> +};
> +
> +/* Verdin ETH_1 */
> +&eqos {
> +	status = "okay";
> +};
> +
> +/* Verdin ETH_2 */
> +&fec {
> +	phy-handle = <&ethphy2>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +};
> +
> +&verdin_eth2_mdio {
> +	ethphy2: ethernet-phy@2 {
> +		reg = <2>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +	};
> +};
> +
> +/* Verdin CAN_1 */
> +&flexcan1 {
> +	status = "okay";
> +};
> +
> +/* Verdin CAN_2 */
> +&flexcan2 {
> +	status = "okay";
> +};
> +
> +&gpio1 {
> +	gpio-line-names =
> +		"", /* 0 */
> +		"GPIO2", /* Verdin GPIO_2 - SODIMM 208 */
> +		"",
> +		"",
> +		"",
> +		"GPIO3", /* Verdin GPIO_3 - SODIMM 210 */
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"", /* 10 */
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"", /* 20 */
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"";
> +};
> +
> +&gpio3 {
> +	gpio-line-names =
> +		"", /* 0 */
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"DIG_1", /* SODIMM 56 */
> +		"DIG_2", /* SODIMM 58 */
> +		"REL1",  /* SODIMM 60 */
> +		"REL2",  /* SODIMM 62 */
> +		"", /* 10 */
> +		"",
> +		"",
> +		"",
> +		"REL4", /* SODIMM 66 */
> +		"",
> +		"REL3", /* SODIMM 64 */
> +		"",
> +		"",
> +		"",
> +		"", /* 20 */
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"";
> +};
> +
> +/* Temperature sensor on Ivy */
> +&hwmon_temp {
> +	compatible = "ti,tmp1075";
> +	status = "okay";
> +};
> +
> +/* Verdin I2C_4 CSI */
> +&i2c3 {
> +	status = "okay";
> +
> +	ivy_adc1: adc@40 {
> +		compatible = "ti,ads1119";
> +		reg = <0x40>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio7>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
> +		avdd-supply = <&reg_3v2_ain1>;
> +		dvdd-supply = <&reg_3v2_ain1>;
> +		vref-supply = <&reg_3v2_ain1>;
> +		#address-cells = <1>;
> +		#io-channel-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* AIN1 0-33V Voltage Input */
> +		channel@0 {
> +			reg = <0>;
> +			diff-channels = <0 1>;
> +		};
> +
> +		/* AIN1 0-20mA Current Input */
> +		channel@1 {
> +			reg = <1>;
> +			diff-channels = <2 3>;
> +		};
> +	};
> +
> +	ivy_adc2: adc@41 {
> +		compatible = "ti,ads1119";
> +		reg = <0x41>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio8>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +		avdd-supply = <&reg_3v2_ain2>;
> +		dvdd-supply = <&reg_3v2_ain2>;
> +		vref-supply = <&reg_3v2_ain2>;
> +		#address-cells = <1>;
> +		#io-channel-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* AIN2 0-33V Voltage Input */
> +		channel@0 {
> +			reg = <0>;
> +			diff-channels = <0 1>;
> +		};
> +
> +		/* AIN2 0-20mA Current Input */
> +		channel@1 {
> +			reg = <1>;
> +			diff-channels = <2 3>;
> +		};
> +	};
> +};
> +
> +/* Verdin I2C_1 */
> +&i2c4 {
> +	status = "okay";
> +};
> +
> +/* Verdin PCIE_1 */
> +&pcie {
> +	status = "okay";
> +};
> +
> +&pcie_phy {
> +	status = "okay";
> +};
> +
> +/* Verdin UART_1 */
> +&uart1 {
> +	status = "okay";
> +};
> +
> +/* Verdin UART_2 */
> +&uart2 {
> +	linux,rs485-enabled-at-boot-time;
> +	rs485-rx-during-tx;
> +	status = "okay";
> +};
> +
> +/* Verdin UART_3 */
> +&uart3 {
> +	status = "okay";
> +};
> +
> +/* Verdin USB_1 */
> +&usb3_0 {
> +	status = "okay";
> +};
> +
> +&usb3_phy0 {
> +	status = "okay";
> +};
> +
> +/* Verdin USB_2 */
> +&usb3_1 {
> +	status = "okay";
> +};
> +
> +&usb3_phy1 {
> +	status = "okay";
> +};
> +
> +/* Verdin SD_1 */
> +&usdhc2 {
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpio2>, <&pinctrl_gpio3>,
> +		    <&pinctrl_ivy_dig_inputs>, <&pinctrl_ivy_relays>;
> +
> +	pinctrl_ivy_dig_inputs: ivydiginputsgrp {
> +		fsl,pins =
> +			<MX8MP_IOMUXC_NAND_DATA00__GPIO3_IO06	0x96>, /* SODIMM 56 */
> +			<MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07	0x96>; /* SODIMM 58 */
> +	};
> +
> +	pinctrl_ivy_leds: ivyledsgrp {
> +		fsl,pins =
> +			<MX8MP_IOMUXC_SAI5_MCLK__GPIO3_IO25	0x16>, /* SODIMM 30 */
> +			<MX8MP_IOMUXC_SAI5_RXD1__GPIO3_IO22	0x16>, /* SODIMM 32 */
> +			<MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19	0x16>, /* SODIMM 34 */
> +			<MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02	0x16>, /* SODIMM 36 */
> +			<MX8MP_IOMUXC_SAI3_TXFS__GPIO4_IO31	0x16>, /* SODIMM 44 */
> +			<MX8MP_IOMUXC_SAI3_TXD__GPIO5_IO01	0x16>, /* SODIMM 46 */
> +			<MX8MP_IOMUXC_SAI3_RXD__GPIO4_IO30	0x16>, /* SODIMM 48 */
> +			<MX8MP_IOMUXC_NAND_CE0_B__GPIO3_IO01	0x16>; /* SODIMM 54 */
> +	};
> +
> +	pinctrl_ivy_relays: ivyrelaysgrp {
> +		fsl,pins =
> +			<MX8MP_IOMUXC_NAND_DATA02__GPIO3_IO08	0x16>, /* SODIMM 60 */
> +			<MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09	0x16>, /* SODIMM 62 */
> +			<MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x16>, /* SODIMM 64 */
> +			<MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14	0x16>; /* SODIMM 66 */
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-ivy.dts b/arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-ivy.dts
> new file mode 100644
> index 000000000000..cb49690050ff
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-ivy.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2024 Toradex
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp-verdin.dtsi"
> +#include "imx8mp-verdin-nonwifi.dtsi"
> +#include "imx8mp-verdin-ivy.dtsi"
> +
> +/ {
> +	model = "Toradex Verdin iMX8M Plus on Ivy";
> +	compatible = "toradex,verdin-imx8mp-nonwifi-ivy",
> +		     "toradex,verdin-imx8mp-nonwifi",
> +		     "toradex,verdin-imx8mp",
> +		     "fsl,imx8mp";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-ivy.dts b/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-ivy.dts
> new file mode 100644
> index 000000000000..22b8fe70b36d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-ivy.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2024 Toradex
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp-verdin.dtsi"
> +#include "imx8mp-verdin-wifi.dtsi"
> +#include "imx8mp-verdin-ivy.dtsi"
> +
> +/ {
> +	model = "Toradex Verdin iMX8M Plus WB on Ivy";
> +	compatible = "toradex,verdin-imx8mp-wifi-ivy",
> +		     "toradex,verdin-imx8mp-wifi",
> +		     "toradex,verdin-imx8mp",
> +		     "fsl,imx8mp";
> +};
> --
> 2.39.5
>


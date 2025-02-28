Return-Path: <linux-kernel+bounces-539034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB95A4A004
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF98188DBE2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0427427C;
	Fri, 28 Feb 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ei26qR9T"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6BC1F4CB2;
	Fri, 28 Feb 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762720; cv=fail; b=SImxzvHu8bE5cfXHkjdQ/AxZexSD1tYFJr6hWVFzDUfavq/VpPuv52alFmiyu/sTtjL/+3pVka+JPk9r7J3P/7MI2+kbcMEQXX9uUCVd0NNB9wxSU2SjIoDxQO8qOelh/ZUwm8emw4YZXjYFHfpg4XL9TdnnsSyr51uBWU+exTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762720; c=relaxed/simple;
	bh=ytsEaWy3Heg1+eYE/NW6yZWfNJibA9InohKY/lAaTgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M1+XgHy8iQFkzJKpeZ+VJnbOGt1t9gs8q1WncH+gsTs+R2QfhSkykGoVps0RJoMUp3R1GXXBkixGQPxo3q3zROuEyWXsOXWjur7mhbEaI0AtzBwt//Zhxoi9qB5h8jz18HbsukOEb5fRl9qeDol991cGjL04InX4RqzWu0n+EbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ei26qR9T reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDfX4y9U+VvTHK+DN9r5kUBJCOy8ZbQE4HyCXr8ySuL/2y66fhtXQJx9neh9Ol4/JCD3kvCLP83RZSmQQm926FiUGw5NTRBJJgsBJd1Uj7ZCnM9e41NbkykT819rFA3AvGoIfxAmjUmXrr7vYFRkdO+4QYJ9IbnqUXpzvIPLcVOgScMlYZJYBJgng355tajS4YYrZE9mG1oiRDG5Ev+TL8HWbuesfWabhgNwi1YSIOP79DQe9vMYNY245yNY1XnXMw1seN8xpxJlH6N6qPDypjNB9TiDus9mxyhwE5BFUXRcQ4PjEgOpR936Rg0pcNIiNpFCI7cMeTVGl8DEiwltRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wke8UjKKRAPcISyvJWTWeKSL/jeTf3ukEY+aHI1oFY=;
 b=TDDNbPEGyEOzdKyt0LaHpiVUkJPuOxMlSvhgdeQbPtf4UE1Qg5AwkAyfDRRf/zi3q3wBT5N2rzzCaPf9JQ3cqWJkv2R3EMyrYAfeLETixwWje3lU/D5GBrHxoHtVgttmpL5j2pdkKdMG/250vZaqMW7kn8q4YCjgkMGhETq/VxNQ4LSY4+auVAmDWWnDwJVl/6aQTnwKJk79rg0JttO5aCP2/YV3hd2UOG4gFYtcYnU54ul9HWK1rcWbVdvE0AzpJjqhOtTVd/wgVeqpocUYcGJB6bo12ppxQzfeSYWY8Rl4fbAIyEL3qlW8avIRmabXn24PtQpCKl+ecT/tB8cicg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wke8UjKKRAPcISyvJWTWeKSL/jeTf3ukEY+aHI1oFY=;
 b=Ei26qR9TwmHu2/+2IW5p9yFEjrZw7VGOiGCKTNioZqkwbgYfurxNz6mUDu11woGc1mwKKyjtxStcIsWncaQNnTPYFcXgKfzBXqHhwZgLR8kB3zMoULgNbHCer9kcLNh+XJXMbtcbxCNAyZcoZymXgxrS6rVRrXqpXP/E9oVRJSe3hYK+/9Yrv6WJzQop4ylT7l9rCMQBeYBoxka3tJWGW46TMf4JCswKPH9R8x//hBoI7Nv5mkyeoTFU0sXtCEXM2fl6IVWjrrWMtIPMSuRImKE0IQefhH7QNni4hG6oUDxShL/lkrwfrVUBli9Ky6q8PFuwNEK6BxKFMlepoI4pYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10531.eurprd04.prod.outlook.com (2603:10a6:10:55a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 17:11:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 17:11:55 +0000
Date: Fri, 28 Feb 2025 12:11:47 -0500
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
Message-ID: <Z8HuU6ULEN756lyr@lizhi-Precision-Tower-5810>
References: <20250128211559.1582598-1-Frank.Li@nxp.com>
 <47051102.fMDQidcC6G@steina-w>
 <Z8HXIvAZcvNY72Jx@lizhi-Precision-Tower-5810>
 <3661300.LM0AJKV5NW@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3661300.LM0AJKV5NW@steina-w>
X-ClientProxiedBy: BY5PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:180::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10531:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c78609-07d7-48a7-96c5-08dd581b0093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?jP8SNKio7jXF+3DRPnJ+PCKVoERSEzK3mk7gE0XxU/kAO6BgvSQXTD/ZE1?=
 =?iso-8859-1?Q?p/s2uN58UQFvt0QcaKRj1sKul0FkqOapVBBrCt1gOg4WZ2heorZTMclB+P?=
 =?iso-8859-1?Q?x/frPIxxG78qx584iuSJeQOyFMwA2kbCdF9f+z3dPgkul1hzF+o6bZFX6t?=
 =?iso-8859-1?Q?9OhvTAA++foqg4dHniyM/IZYUI1dLfv+x7mOnezqUz7jUmaNLTilDkbgeP?=
 =?iso-8859-1?Q?Ad2JyliNYDiKmhN1fkLrYCt7UmJlfOJES7lqClYAojhdworLUMsCd6v+U6?=
 =?iso-8859-1?Q?yMDWRFpoH6iQWUjv/aH0ICHPYHzXGIH+XlO5D7YjCvd2XmZbMHkeOLdGic?=
 =?iso-8859-1?Q?w6O9bua2k5WiTFR3w++Cu+VyCP8lZ7pHwfbSV1uchsFx//T3Wvep3kaLR8?=
 =?iso-8859-1?Q?X6vOcsI0VtmM1fxgZWX8u5LNeBhV/G94Bc+ipqmGwo4/9D1SRkqy2F1zKD?=
 =?iso-8859-1?Q?gj/kcyZI/WV8cNm676UrUytB8KcSJtHs4nrDPM4Q+atrM63z8FRUTuTotu?=
 =?iso-8859-1?Q?6jAkrp4AZBi5GrdSvHtXjAxy6fHYon23pLF0fKXuZ8hFuiulSIbedAHprH?=
 =?iso-8859-1?Q?Mr/W11lXXGhma8C35xWaLJRmkbD2oJ2R7w2VEpCUKDmL8qL/SDV0s9d4nK?=
 =?iso-8859-1?Q?3z8eR6WmlcGRi6AqKG1foVoAl8R7yhjsiSHBRuzoGITqxI26DPjqzKm+HC?=
 =?iso-8859-1?Q?wsw5Z6S/vrqX1lv7tuEayPehNAHcYEhJP+fUQxeyYyp31FiHNMY92IIRH8?=
 =?iso-8859-1?Q?O9r9vL1a8Q9Dg0SiCo2zHMxO9az8lNPUDjpOKpEBry9uEKomPntgcvUH/v?=
 =?iso-8859-1?Q?DLETdK3oChjEAXj6ZpU7BzHlXVeLvzqW2OY1XzMdVtuEC+wHo30CAZmhM3?=
 =?iso-8859-1?Q?D8To5GE1reMYYf/7S5xS1ruW6RuGxB4Jp1iF0iN0Ajmv4n49CJUyus1XCz?=
 =?iso-8859-1?Q?OZTWFpN5bhvF2XcROTDRkqedwLA17cE25EQ0JK8m27PAW4Baf+RCsgi/vg?=
 =?iso-8859-1?Q?e1kgvkrAAt+Q2MustyrbGuykfvZN6nSrtwt0iXoCwGT2X+8xxvJ1y/CnYy?=
 =?iso-8859-1?Q?gG7Vs3niSNG8zikuvk0coe+ma707fMux9ounhAOGpLhDskgFv4qBiyE97j?=
 =?iso-8859-1?Q?2hx2Qi1qTORs4lknCcZ6hQm1MShGvgTRkgZVpGntZKS3iRDdEAcJ5pS6fr?=
 =?iso-8859-1?Q?Zm4xddLI2MyoYev93A67JOSBc9k0qkRPhKHDUVwjE54PYG+orlS9M11X51?=
 =?iso-8859-1?Q?2MdvZMRHJuG8kTfJhVqhFQS8S0zrtKYQjNDCLCKgv2E+BgnXJ4oKo3Q+2s?=
 =?iso-8859-1?Q?KCQjSraej/Mt7pMwTrTEck3iA5Pen/72rQmf0A7t6aJJTuPpvfurRpOvas?=
 =?iso-8859-1?Q?Pb+GIkjqlgqqEqvthVHYF3edNEffqoyPNaiwmTzABWywyt4nGyprbJx1Gd?=
 =?iso-8859-1?Q?XZcTVEkk5o3zOEDa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ij1zWOPgzhSiZSeEAot7JxiYaeel3jxYGvLFzKENsEn0j5VwVsLt7KGgyS?=
 =?iso-8859-1?Q?hYLF8prjVAQ++njRlwPRDu71U2jH9fH8dpseKft6EJbIr3Ypyq1PyeH/Je?=
 =?iso-8859-1?Q?AvaWH3x4tSAOcauFmlp88oochtlC6IfqaSlOlzckn6puKXe+PTyO+6iaV9?=
 =?iso-8859-1?Q?ECzX7hYEaGGEUsVrNCbsUzBl04tWAit1UaTvVsn0Wi4hCb69l3ApQVk4M6?=
 =?iso-8859-1?Q?sahjW2ZFUBBYQ455w0bQXx3PQJJU001DtNG5a3Fg37Qk0JzFFzlb8ShG8p?=
 =?iso-8859-1?Q?oiLO3vxJ9w1NIYzsvXCHgPIAxGrefNEEKTqbH4auWQT38VIha/PbBoViMO?=
 =?iso-8859-1?Q?I21Z6+Z9qon5WNtgmv9tn9mNnKOoY/SkPxY+XN8koRoZGf/wzStCZFoghD?=
 =?iso-8859-1?Q?98TPLLtQlulcA28yLAfqVuDbzMfoXyUv25XbUUldfFf8VQKLC1Z6ldnDk9?=
 =?iso-8859-1?Q?cU8xcIFhvkBwNT65tqoTrL9Jep/bg8CjCZTBmUWIQHJyxSSmve5OdzQqZg?=
 =?iso-8859-1?Q?M1kM1YVy61PomSRwcGIsvzZi7p+0w/hGsx0Bhw1op77fw+LD8UIzEYjBl0?=
 =?iso-8859-1?Q?txFPQ19qlYpeXO/haFZFqJW9OEEpPXKRGul7QLVNHvWAXuVw5w/vTRVXVU?=
 =?iso-8859-1?Q?tTeVAwzjC2Ts+hsHPPza02J/nBOnxI/DOYGSUjF7LjEKkXCnSK60uAqlxy?=
 =?iso-8859-1?Q?LnsHV6KUjlTF8t8ys/MvnLrGfSkGIC5DukdO0YjtpR4aL0cOjqBLyH2WcM?=
 =?iso-8859-1?Q?t4p6liNY6VVFNHd6lwcDfEg3GzAbIpek4XHxaMmLg8BqcryZ7Ft2MG/lQ7?=
 =?iso-8859-1?Q?NG7FTqEnBkcZgr7pEXOoKkArtENk3h9T0DtAqGtnyTl/Xt0Jlpl7Gbaj/8?=
 =?iso-8859-1?Q?d8bDOZ9z/8A90fHPZ8vbTyMm3gSQzwGwc9JifktmkuMDDhiea2x8gSROdc?=
 =?iso-8859-1?Q?DsIzQq3gd7hi/63zbcIv8eteW26l27bLowPBhRQ+WCWElF3Da3TlaJHOwg?=
 =?iso-8859-1?Q?0kxP+4P6PTMNHReLJXsk5rDC3l6mTDFt/fE6cpEwNobSu1rkJglJrauLAB?=
 =?iso-8859-1?Q?4f6bGjtrZmvIafwCQCdoFAMYKqLG7+KEYgKflVjO6dyGzYEzCxxnmrUYbl?=
 =?iso-8859-1?Q?0mu56ZO7j2+IjKyNAo45qMTGMfH0X4XHAPOODnsqTyRr+9u2yrmVm5a1GB?=
 =?iso-8859-1?Q?rbAw7VwFwLnr5i9YeL94TJyQp53bXAdft9dam7HU/xJQSFHbkDJxJqjK9Y?=
 =?iso-8859-1?Q?Zhe2GVQzPJcFltI+AauP1sHI3FK43nAUIhYCLgEs6quMCRmGib2CoTQoZl?=
 =?iso-8859-1?Q?VZNwvKp2lsP42rgv2X+GwUvoibIX6LfObzRDW88yq90Chls5/C6v7pQet3?=
 =?iso-8859-1?Q?FHkm9jm/ELoLy0ZOjVn292Uwr/XzfQqTzXRW4gg0bFqmMEShIYZ2oJzw/L?=
 =?iso-8859-1?Q?91P1ftaVf8I80hAXUqiMC8ONB/5GwWWHzHJ0tX0fOGqdV0Tm2P93umqOUJ?=
 =?iso-8859-1?Q?gUXdbHFWExrLCudJqQyI1ZQxGP6OpahGb4U4wx/XfcMO556mKgMMSBB1uV?=
 =?iso-8859-1?Q?zZ139Nd1fD9D5NZo8OyYjoXxwxQ5lCA0YwhNVbMw41GnqRekUhUjAOUxJU?=
 =?iso-8859-1?Q?pvs6wz8caAvAD+gZvZxyowqVNWBvWdZNnd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c78609-07d7-48a7-96c5-08dd581b0093
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:11:55.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCnrj3uBZaKe6egbhFZJEHv88y+tlVdLapE4lrrMTymxa6cf0jLZNx0ONONq+fi1QfOedKsVeuzLLa82PNj/kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10531

On Fri, Feb 28, 2025 at 05:01:15PM +0100, Alexander Stein wrote:
> Hi Frank,
>
> Am Freitag, 28. Februar 2025, 16:32:50 CET schrieb Frank Li:
> > On Fri, Feb 28, 2025 at 10:08:58AM +0100, Alexander Stein wrote:
> > > Hi Frank,
> > >
> > > Am Donnerstag, 27. Februar 2025, 17:39:47 CET schrieb Frank Li:
> > > > On Thu, Feb 27, 2025 at 08:54:13AM +0100, Alexander Stein wrote:
> > > > > Hi Frank,
> > > > >
> > > > > Am Mittwoch, 26. Februar 2025, 17:31:26 CET schrieb Frank Li:
> > > > > > On Wed, Feb 26, 2025 at 01:11:37PM +0100, Alexander Stein wrote:
> > > > > > > Hi Frank,
> > > > > > >
> > > > > > > Am Dienstag, 28. Januar 2025, 22:15:58 CET schrieb Frank Li:
> > > > > > > > Add PCIe's msi-map and iommu-map property because i.MX95 support smmu and
> > > > > > > > its.
> > > > > > > >
> > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > ---
> > > > > > > >  arch/arm64/boot/dts/freescale/imx95.dtsi | 14 ++++++++++++++
> > > > > > > >  1 file changed, 14 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > > > > > index 6b8470cb3461a..2cebeda43a52d 100644
> > > > > > > > --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > > > > > +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > > > > > @@ -1573,6 +1573,12 @@ pcie0: pcie@4c300000 {
> > > > > > > >  			assigned-clock-parents = <0>, <0>,
> > > > > > > >  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> > > > > > > >  			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> > > > > > > > +			/* pcie0's Devid(BIT[7:6]) is 0x00, stream id(BIT[5:0]) is 0x10~0x17 */
> > > > > > > > +			msi-map = <0x0 &its 0x10 0x1>,
> > > > > > > > +				  <0x100 &its 0x11 0x7>;
> > > > > > >
> > > > > > > Aren't you missing msi-map-mask = <0x1ff>; here? Similar to pcie1.
> > > > > > > Either way, with this change PCIe on pcie0 is not working anymore,
> > > > > > > regardless of msi-map-mask.
> > > > > >
> > > > > > Yes, it should have msi-map-mask. During my test, I have not enable enetc
> > > > > > so I have not found this problem.
> > > > >
> > > > > Just to be clear: This is not about enetc. This works fine here.
> > > > >
> > > > > > > Without msi-map-mask:
> > > > > > > > OF: /soc/pcie@4c300000: iommu-map, using mask 000001ff, id-base: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > > > > > OF: /soc/pcie@4c300000: no msi-map translation for id 0x300 on (null)
> > > > > > > > r8169 0000:03:00.0: error -EINVAL: enable failure
> > > > > > > > r8169 0000:03:00.0: probe with driver r8169 failed with error -22
> > > > > > >
> > > > > > > With msi-map-mask:
> > > > > > > > OF: /soc/pcie@4c300000: iommu-map, using mask 000001ff, id-base: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > > > > > OF: /soc/pcie@4c300000: msi-map, using mask 000001ff, id-base: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > > > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > > > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > > > > > r8169 0000:03:00.0: error -EIO: PCI read failed
> > > > > > > > r8169 0000:03:00.0: probe with driver r8169 failed with error -5
> > > > > >
> > > > > > Can you try remove iommu-map and keep msi-map? then remove msi-map and
> > > > > > keep iommu-map to check which one cause this problem.
> > > > >
> > > > > With only msi-map removed, but smmu enabled:
> > > > > > arm-smmu-v3 490d0000.iommu: event 0x10 received:
> > > > > > arm-smmu-v3 490d0000.iommu:      0x0000001100000010
> > > > > > arm-smmu-v3 490d0000.iommu:      0x0000020a00000000
> > > > > > arm-smmu-v3 490d0000.iommu:      0x000000009b0cc000
> > > > > > arm-smmu-v3 490d0000.iommu:      0x0000000000000000
> > > > > > arm-smmu-v3 490d0000.iommu: event: F_TRANSLATION client: 0000:01:00.0 sid: 0x11 ssid: 0x0 iova: 0x9b0cc000 ipa: 0x0
> > > > > > arm-smmu-v3 490d0000.iommu: priv data read s1 "Input address caused fault" stag: 0x0 r8169 0000:03:00.0
> > > > > > enp3s0: Link is Down
> > > > >
> > > > > With only iommu-map removed, both smmu enabled or disabled:
> > > > > > OF: /soc/pcie@4c300000: msi-map, using mask 000001ff, id-base: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > > > r8169 0000:03:00.0: error -EIO: PCI read failed
> > > > > > r8169 0000:03:00.0: probe with driver r8169 failed with error -5
> > > > >
> > > > > Only if smmu is disabled and msi-map is removed the driver probes
> > > > > successfully:
> > > > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > > > r8169 0000:03:00.0 eth0: RTL8168g/8111g, d8:9d:b9:00:16:10, XID 4c0, IRQ 160
> > > > > > r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> > > > > > r8169 0000:03:00.0 enp3s0: renamed from eth0
> > > > > > r8169 0000:03:00.0: enabling bus mastering
> > > > > > r8169 0000:03:00.0 enp3s0: Link is Down
> > > > >
> > > > > > >
> > > > > > > Without msi-map/iommu-map:
> > > > > > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > > > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > > > > > r8169 0000:03:00.0 eth0: RTL8168g/8111g, d8:9d:b9:00:16:10, XID 4c0, IRQ 166
> > > > > > > > r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> > > > > > > > r8169 0000:03:00.0 enp3s0: renamed from eth0
> > > > > > > > r8169 0000:03:00.0: enabling bus mastering
> > > > > > > > r8169 0000:03:00.0 enp3s0: Link is Down
> > > > > > >
> > > > > > > pcie1 works as expected. But this is only a single PCIe device, rather than
> > > > > > > having a PCIe bridge.
> > > > > > > Any idea what's wrong here?
> > > > > >
> > > > > > Can you help dump more information at for PCIe bridge case:
> > > > > >
> > > > > > imx_pcie_add_lut(), need rid and sid information.
> > > > > > drivers/pci/controller/dwc/pci-imx6.c
> > > > >
> > > > > Just to be clear, without msi-map and iommu-map I get:
> > > > > > imx6q-pcie 4c380000.pcie: rid: 0x0, sid: 0x18
> > > > > > imx6q-pcie 4c380000.pcie: rid: 0x100, sid: 0x19
> > > >
> > > > Can you help dump register value PE0_LUT_CREQID offset 0x101 for your
> > > > smmu-map or msi-map enable case
> > >
> > > I am assuming you meant offset 0x101c, as stated in the RM.
> > > I added a dump directly before printing "PCI read failed" in r8169_main.c.
> >
> > Can you point me the code about where "error -EIO: PCI read failed"?
>
> The error messages comes from [1]. As far as I can tell, this is the first
> read after pcim_iomap_table().

Strange, it is CPU read MMIO, should not go through iommu at all.

>
> > I tested nvme devices worked at both PCIE0 and PCIE1.
> >
> > Which PCI switch do you use?
>
> This is a COTS MiniPCIe ethernet card [2]. If I'm reading correctly
> the bridge seems to be a P17C9X20

I order the same chipset one from amazon. Let me debug it after get it.

Frank

>
> Thanks and best regards
> Alexander
>
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/net/ethernet/realtek/r8169_main.c?h=next-20250228#n5454
> [2] https://www.delock.com/produkt/95237/merkmale.html?f=s
> --
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
>
>


Return-Path: <linux-kernel+bounces-339447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14683986535
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E33289604
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F484644E;
	Wed, 25 Sep 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E/gnKi9z"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957691AACB;
	Wed, 25 Sep 2024 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727283218; cv=fail; b=GTiUDO0ZaaRIV73nItJkA531T6fI8ImnfbZ+W24GYa4mvUak8Mm9J2sJWuzbnShcHFV0NaBMruBvUbtvCJ9z/C2FzO4Bl0X1VkZRRxND+6bBeK6rTZNuIh+MqwpbSEB4qLmvvroQtFf73QG03PsMZXPRuQD64lIXyFFiVl5Kv60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727283218; c=relaxed/simple;
	bh=gIxfgegB/QpLMwsxuO9pQxBgTNjFQlWAWKlhe6b5IvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YQbBjP/rmK/n4XGqv6hP4GHXFf2BrVUJhq03TMZq8uUgUdGSGdbyRkRGSTResZkecDuOtzxRM6ogMZ21Obv1/svfiG2uNbIOMHgZawM7wWoj9U9iq3QDFf0ypg+pVBOfFJsi6f8pMEga7yqvwM5gRpjGpy0y01tIUyE/irl384Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E/gnKi9z reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZM9B7M/hxN1lhyBtVrEdzPmmqH7pnMaBeKrx8CGwPzFzK52duBNm3Yh7y1qL+xIYQWfsGi4PqkkyZE+3vlfdOWSPIOc3eV79cgVMGBb/yOeHz97eSZu+tsVLJzUo9lhMC4m4EoJlzy43enS9q9pTzN4m3gzCqpLR4mUxY8wibKYGapjgjxsgpsiAXsJR2ovahZMG5nRrs2xCwpGRUW9Yvyfan+d0j85dDI6Fu0bJppM0yCE9s+Mi/pw6ALJkJeAO2u4qyiVkSRIhjwKcW1BuBE2aMS9UDpSIwp4Qa5bqpNgEhMqW1NcgXiy9BWpMffODUpJfceECJT0CXHY4cCnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6LUtWyjmEbF/wUfwUSGsjdTLkCJIT3yZehnJY6B2Cs=;
 b=nYhCo+Mf+Y/3Gu38smIytwh6qrnloky0KPwSPl8fcUuQ60/4YL8qIyrib/nq+eKAbq7nDe040s0kRSeaY0FXUc0cffdGtgM75EI888Kwkem4xR+3Eg8a7iObBAwZMcC1TCg+qHGiTM0k5mYxIYZdWKuNVukPEZtlOZ7V81MhbECC6ha6nysQqzm9UTtPPPPGmz+p84fMeZ03v9Oqi2BiYStjYcKiZNkbJvUfDP1nWCcMZTrd4GjNMYqPVm2a50kcNUxn25pSRU+pFnPZQu5P7abKBunMNdFFxNeF9RKDDKNIddybmX8XLvomx96JLN4WfYuFvQR+0RoHJVpLB/qMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6LUtWyjmEbF/wUfwUSGsjdTLkCJIT3yZehnJY6B2Cs=;
 b=E/gnKi9z/v+q+f+PAcZb+nHeHsy35Y4Or6d+OuXtHrciXADtIm12+vBO2nN0G1WJh3KqsqYkAB7B4KaJVHjo+EoUnbvkcGVWKtSso9ZPEseUfGI4sajmHD2TKO5nRtegaJb4MYZkavh5Zu8WV3iKZUv4iDnL2nPKXGJ9qM9tJ5N3kIFE6jEK48hMNFxYmCOE9peZbCLem0juchFnu1OmfV+PUEu2w20r3Vx4VoLq6Frd4Ax87vClhuy8jjobl8PJX8iv57h0TJDlGjcTQ9Zsj5AKWOGvOgVwrp9pojLagJigzZyWuCTwlcUeY1pm7sIEmZm1ppv/4zwxOeJAA8E0Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10884.eurprd04.prod.outlook.com (2603:10a6:800:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 16:53:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 16:53:28 +0000
Date: Wed, 25 Sep 2024 12:53:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/3] arm64: dts: freescale: imx8mp-verdin: add labels
 to som nodes
Message-ID: <ZvRAALMmdlttogD/@lizhi-Precision-Tower-5810>
References: <20240924114053.127737-1-francesco@dolcini.it>
 <20240924114053.127737-3-francesco@dolcini.it>
 <ZvLUmqM5FWqKPxoi@lizhi-Precision-Tower-5810>
 <20240924170254.yx4v2m23evppfa6l@joaog-nb>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924170254.yx4v2m23evppfa6l@joaog-nb>
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10884:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d489a6-ced6-4dec-1210-08dcdd829498
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|1800799024|7416014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?H7zj7/qTf2NGPcsUVdxmggNjrlFMg2pratrzYxWbQZRaDEwlWC6Jh9S3wl?=
 =?iso-8859-1?Q?NJK3LNsBzJ6T/lwaLjP6auFOIEbvC6V60YTVfYaTr5I6nLJBEf79QE4e27?=
 =?iso-8859-1?Q?6t8V4tyZvmB3Nv6bYe43tNCbfzrzxp/YTl8KjcUMnCkygpTwfcQuRy81bE?=
 =?iso-8859-1?Q?YWr+cUhHk1SJ580EiHNgHTjuY1vYuw0JkqlrdrFALsgznglbK9GRDUiLda?=
 =?iso-8859-1?Q?AWoZ4Wv9DyaOL2YtJhWhcvYfvz/sEUGJmtDGUiL/0/PNkl/7g6w34xtVml?=
 =?iso-8859-1?Q?6epV0dPjpHmHGYYeVx8wcEukJHkJ4Yi12+9G0x+Gbl8GGHPxjirNsTvy5i?=
 =?iso-8859-1?Q?x44jqJfCyYLjPGgX27OQh4aeKWpGCJIKJMdW4Gv4GUXfHlzuG4zmGEtldI?=
 =?iso-8859-1?Q?HIcCOHANgdKoK77eykuk1FZAS3vV8swMA8F+RQXYQxwzZT5vHFFOHGdXIW?=
 =?iso-8859-1?Q?7MCWzb+QaPeiCbb0MlMIOd0kTVBnHtsoMA8ew0GNwqPW59rcDOSwy6jwtZ?=
 =?iso-8859-1?Q?UUnyRwTK+bui6H04noa5iL9RqsG9q/Uac1OkgHzYERb7kTtZFVeQAPaf98?=
 =?iso-8859-1?Q?DM0D4EidXRxfvAHmTECpwJw4SkNJurXdc8xzt+HbrVMgbQOD4354XRKENc?=
 =?iso-8859-1?Q?kY3ZkVEW4C4SQ2VcxKjO5SzeF9053h1XTk114zq2QcXuYygg47c8/WoOmA?=
 =?iso-8859-1?Q?Hk479mjiJm+X+AX0r4wRVhm9w6+lnLtqUxy64UeYJJsE1ldgPkkRGgwcIh?=
 =?iso-8859-1?Q?LzsGRbXRQvL1P0JxqisL80/ChClx4Xep8RcQPqUiKkCStBZqbVDKJgbk7l?=
 =?iso-8859-1?Q?L6GPj789YN38xTKF1o4ekHDywCfLrNMflwbjkyuToC4/UU18/Lv+6kcSBP?=
 =?iso-8859-1?Q?GeZTtriRsqGsd0YcP5hEECZUVYpXjtnvElwW1kA/0RQ6QLN1YrlfOVDs4/?=
 =?iso-8859-1?Q?B3a2oaOAjMN24hOOrUD5/50iCBgOsJOyEHf6rme/644phVLg5sZ6iVX4tm?=
 =?iso-8859-1?Q?EvGW47/JtGcg4UbS5V1bAN/ma7UWh9AId88azxtUdf53DVqEZWl00E3ZXP?=
 =?iso-8859-1?Q?aQ3N5njv0D01RbMhJMM20v8P6CZItgJtUwqWP0K1F+m543VK9Z9Q8OWGpT?=
 =?iso-8859-1?Q?6pqoGzhwmO51F5b1yl27LS8B9nwqj8p/EozCW29FlmlJo66b7AOQmSaLHk?=
 =?iso-8859-1?Q?occ0Vw6+vu5+3muSlqtV2m88O7mvefnmjxPqeIsqUKw6FH8Rpq1V1lLPLZ?=
 =?iso-8859-1?Q?00FcKqoES5YsmFsxYrBodx4XR+jQn2DB4CivQk05IhMcjs77qB24YaFkLf?=
 =?iso-8859-1?Q?AsydL9u6jB19gWla1Cslr4H8Vk0zZa5djn8q7v7SS3ngCmEvA7NVeALz7q?=
 =?iso-8859-1?Q?7YxH0TFcxiqd03vPqxj7he1DK1njjvG5D7Hp8raj3Ps7+N0nt4siM0x66y?=
 =?iso-8859-1?Q?wT5h2+dZpFS7BdZodZNvwf+Hy9iGKq1v5dX9Hw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?DDZYPimlBLNBEtNEgir4UG/J+iwyE0j1o6e+N1zE+pjQPUM64tCkOsB9YW?=
 =?iso-8859-1?Q?vSvK/KosrCuCa88ZbD2ZxvQw2vPFUEfEK9GFM+VTLtmRrZp+7Nym35kjm2?=
 =?iso-8859-1?Q?2RFT03DDN4VNfqDhkuZT12LrLHn+ph99cOiU3QqvczSCkOvOtg6gyU5F7Y?=
 =?iso-8859-1?Q?CwAl9tFHu90ItTovoplXC+dWcRyP/2LBkEoW/dc1mnZ2hn5+NEw9Jwfisn?=
 =?iso-8859-1?Q?6bak8vrxtp2+0zZA2ayrzfL7kp68uNqyD9fjM8ut5si9HOxo8ef0ubtbhD?=
 =?iso-8859-1?Q?XbD8sNnOSXtAOymqphsm4Zsw5Xlf3yILX8+ir860WLCYA8PQO3CfFU5tUz?=
 =?iso-8859-1?Q?sRJ834r+JqO4w9iok/5aKKiyVQOp2XLW2zkiTqOxQVaxf+JELwKVkllFe5?=
 =?iso-8859-1?Q?V6WAoDDqaTXp0qHlPyp88onWGmlz4kRageXaL3gRsjInTpDjZ0MD5E7XRH?=
 =?iso-8859-1?Q?+RUbP41BifB9wh4wH19OTMRSQAfrumjvRd2R0VCeCt80PAT1NZnCPsh5ZK?=
 =?iso-8859-1?Q?yf9yiM9Ys0abPI7h4bUgpyGogNqXJH1oJuYzPxnO07mvHJhYu+Q3Rbs2gZ?=
 =?iso-8859-1?Q?GT1eeQWzofOMnywTkhOIEsN5JElMD0UmjomtEwSHO2EH5siJtm5WBbaEjm?=
 =?iso-8859-1?Q?BWH6ThcvfqRkTT/uzrFZosNMqVGwCdq6snKPBqJgTev1HtGRWDm05GGxvM?=
 =?iso-8859-1?Q?gpmoaFyT/lLeuR/YeEqt7kMAI+p9HgLf6ZhK5w+Zv9XPlrinD0svToytyS?=
 =?iso-8859-1?Q?JM3+sqQTRdWQm2Ube0pwjy1dz0ogHMoKY8DBTnlJgXPLYdNBPm9JsQkEZO?=
 =?iso-8859-1?Q?xCeilRR28F5pkpw4reia/SZEgzSmPYoob9J16abaRYRTa53i3Pp7oTZVaj?=
 =?iso-8859-1?Q?5vjS167h4S5ETJ9SzjTUblsTW03HqiGVLm7GDGF+Iq3UtxKwinjaDcrlmB?=
 =?iso-8859-1?Q?z2/nkphmXW3Y8uJQgAqlU++oHYQnRtoN817yiu4ToiUjCOBP50pEqSCNs3?=
 =?iso-8859-1?Q?Y4xhnxAiHEXCU/wG05feQU47/wXoBCq9I0ci49UfKrCQLYoxNWimli+mq7?=
 =?iso-8859-1?Q?XlPGbda9KCz+oBxihiqR0PTMQiVxlqrd5umTZ+U0w87n8fCfAS0yK4fSzB?=
 =?iso-8859-1?Q?TT9aYIHIEv5D7preTUVSfSXutXVMnUqwtopbcmhJcIA4fYRN+ZQqHKOm0E?=
 =?iso-8859-1?Q?fN5gcAcim7naNxv0q1VXHMTmylnAtfnKGakNdveHKRWNb5FhOrj3tZ3UFd?=
 =?iso-8859-1?Q?O5H/KwCqbW8ZZBWzNpXMNvez9dgIkpq3GeDkn5uCqa3BKCkQwH9z0xLKtJ?=
 =?iso-8859-1?Q?B0FT/znkaLm10P8CajXs6ledvh3bLe6QH0NXqPDyOqY4dD3ffjfNGk6/vU?=
 =?iso-8859-1?Q?0Afb3d+Db/Re4RO87lTpIRLbMVgiBIPtkBRVa6Qtq97Rbi+f24ZRBubpKZ?=
 =?iso-8859-1?Q?K+Qr3FBquKQcBed6QnNZktWKAFi9MLP0vsav55Y05bWaS8Oq27YhQqrIdm?=
 =?iso-8859-1?Q?o1Q9uAQ9HyMH0ZRx9xdjw0t52dUiA1z5/Z/bQJ8BfyW036xfl/15S3HrR9?=
 =?iso-8859-1?Q?/KYoCuDSKZ9EIjHh+VbUZyuJZxGg28M6PQLpxaL4sqQwf5IbLacjwtuCpP?=
 =?iso-8859-1?Q?PP+BagjmvESiA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d489a6-ced6-4dec-1210-08dcdd829498
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 16:53:28.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UH+RO8sweX6VxhrGyRquRVruBV8L1oh3kdUad41FVGlOPK6pY+yid266rsLbZYZxpryJtCIh2Hcya6s8jDuzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10884

On Tue, Sep 24, 2024 at 02:02:54PM -0300, João Paulo Gonçalves wrote:
> Hi Frank,
>
> On Tue, Sep 24, 2024 at 11:02:50AM -0400, Frank Li wrote:
> > On Tue, Sep 24, 2024 at 01:40:52PM +0200, Francesco Dolcini wrote:
> > > From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > >
> > > Add labels to ti-ads1015 and fec ethernet mdio node to make it easier to
> > > reference them from other nodes.
> > >
> > > Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> > > index a19ad5ee7f79..e9518b7c7aa8 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> > > @@ -320,7 +320,7 @@ &fec {
> > >  	pinctrl-0 = <&pinctrl_fec>;
> > >  	pinctrl-1 = <&pinctrl_fec_sleep>;
> > >
> > > -	mdio {
> > > +	verdin_eth2_mdio: mdio {
> > >  		#address-cells = <1>;
> > >  		#size-cells = <0>;
> > >
> > > @@ -591,11 +591,12 @@ hwmon_temp_module: sensor@48 {
> > >  		vs-supply = <&reg_vdd_1v8>;
> > >  	};
> > >
> > > -	adc@49 {
> > > +	verdin_som_adc: adc@49 {
> > >  		compatible = "ti,ads1015";
> > >  		reg = <0x49>;
> > >  		#address-cells = <1>;
> > >  		#size-cells = <0>;
> > > +		#io-channel-cells = <1>;
> >
> > Why add this? it is not related with what descript in commit message
>
> The #io-channel-cells property is required to reference the ADC
> node as an IIO channel producer in consumer nodes, otherwise, DT check
> warnings will occur. I agree that the commit message could be improved,
> but I consider this a minor issue. Would it be acceptable to keep it as
> is, or would you prefer a v2?

Personally, I like one patch fix one problem. I am okay if mentioned in
commit message. Anyway, it is up to guo shanw's opinion.

Frank

>
> Best Regards,
> João Paulo Gonçalves


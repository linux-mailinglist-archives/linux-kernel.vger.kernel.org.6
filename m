Return-Path: <linux-kernel+bounces-561558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED534A61374
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EB93B2971
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD18D1FF614;
	Fri, 14 Mar 2025 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QmJPnLlG"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2047.outbound.protection.outlook.com [40.107.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ECE1FF5E6;
	Fri, 14 Mar 2025 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961777; cv=fail; b=Qh8EDYzcJF29hlcNmw3g6haxmUbzg0G4NVWIGJpdG6vQuy6vpQN9jFRMZdmc2s71MVcvj4YABcV02Is4Aow7S9JMFiae3cPMGem/WrBT/Bu33MjHIFTfq7yCRpmBXZSnYnswTZhR4LgQtq0/xaRqVsRDykBE85V94lINAVSn6Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961777; c=relaxed/simple;
	bh=uKGwibNuMNxkKWX3QisnhanPmnXEJyh/xIjcM9SyZuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LU/Uget2+S6pIwYcFGzByZ5KPBVjUzFW4WihBFuHo033txuWII25c2bn49ea/8Gc/OXrp9IQcf3I+IDTnqs9/6dDuHbTJ3rxnL3dtCFmZ+QrwsOG8ntafycCBtZ6vCmEFPg5+X3siV880nu2SAVJjKg/t1Kd+fiyy9gs57uvu5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QmJPnLlG; arc=fail smtp.client-ip=40.107.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwIo6rKvK0XPu0D1/EA3KeGdn4M8fBpamD5bdks/SaUNcaPF4YfB0zwy/d+dmBLeD2Md19Ik2/LdmhZQS38ar33Fs9bCBmDScCQqu2I99M7Tai9pbiTQVokLHPZOLx2WFK0q158/PjRvMJ7Pk/n+qtoWS4oQXHA+MzDTSZ088lwGI9mzqtZ/qTQ8k+lyHpVpp8dqDUX5WBfG5r4ec3HW3j9Os39hbdCiweCFc2LumJkUVBtPJV7JAYVxlROqKkpqDJVSNTOlARKkoLj3Mjoo2KXpt2S7ShA0TAEIJHci9cttNkZ14kxbPw0xPEg+GAeDi/EyfZyNQijnVWcJXTyukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTZTooA5Q8N1N6ODfScYKQtnbDb+tYtJjLEGwXMylTY=;
 b=zB2HAzkx73H7olbuPE/x9iDgfQ41gzrIzzuV+IZapZn6B4H/ivplfcDd1/xPA1/itp5/zxQbEXfaFY9pjJwNaItLlRFifEp0xDJU4e38dbbIYP4LkTaLYaaT+g7fZZ86BsVAdk3B931bp6bqTFD1bS/0ZxBxug4igEPW9a10ZsvDheAuaMfagnz68D3FhMeIH/eiRH3KZwXQXBRkf9GauxWJHSbxr7qvvIs0UP8YR2IqF8bmPz2oeZGJABFur7+7iMyqiLSMPl5MDu2wQdjEMQ2OgKmD7SYM/El/LOV5HFZDHIOiTa5NCN5t9vQGucLFcUu3aE7RsFoPZktBqh+Zww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTZTooA5Q8N1N6ODfScYKQtnbDb+tYtJjLEGwXMylTY=;
 b=QmJPnLlG9Vw7q5GGCqQmhvU0sq2HaD8fopWoPaG2HZ/7yHUiXn2ETtLnekHlYn5CeZ4vrAO7B1PNexAv8KUWbr6KzVV5RKi5TZd1Hvk/Vcz7un/T/QcyJw+ImLOV/mkNdVpfBlfPeWgk5BDFT2FTYrYKWzVtfjh8MU4eB2/4BnzgobJig0SzuEDnBw5eS1AUubWHt9zTD55NtTVh/7j+QF6YTNcPPK0MVaYpC0KdHFLpHx07zb+t4xIVg63al3cPTI2bqQdEyGP56FM/Y7VxeqWegffKtveCStDcKa5UyeinaLsks0OargcBxZKWzcOhdmAeO647HYzxd7CLr2hY7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU7PR04MB11091.eurprd04.prod.outlook.com (2603:10a6:10:5b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 14:16:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 14:16:10 +0000
Date: Fri, 14 Mar 2025 10:16:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	kernel@pengutronix.de, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: imx95: Correct the range of PCIe app-reg
 region
Message-ID: <Z9Q6I2roECiCkXG9@lizhi-Precision-Tower-5810>
References: <20250314060104.390065-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314060104.390065-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BYAPR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU7PR04MB11091:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf115d6-a67d-4548-7267-08dd6302c53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gFyUaVVPXVSIcjiIvfZo5FUnZXycvrGgLte1otbB7+OteT4RPOEE9mm358XJ?=
 =?us-ascii?Q?9kUMQ0+mUrAHnuMDvnogfESn+jMQ/lHZG4ksSvN+T2Ai47/QQMrulDBT71Ec?=
 =?us-ascii?Q?oo7QRRkvLWdV2ypfArWwEzm6qWYZ6iuyjZcCh5lWDqZY45iiHSg/8sB7gJsR?=
 =?us-ascii?Q?p8c7ssitJ+QETIzLChdsqi9+xC9jEJi7xa8k+unFFRHjrx5keLVSwT0deICH?=
 =?us-ascii?Q?Ulq8CrQF3BoWEke1OGxO1PTdkzA4g3MUwNYtXNujrb8W5f8TwOdDR4HwbRDa?=
 =?us-ascii?Q?ZsXGEMInziQQbovvfnJTU3q0rYiOd5TDpInT3DmCAdQgdwFH3aYJAbEHMgew?=
 =?us-ascii?Q?/wZOCq+1J+wxccezbFPWutYZUH/UE43Zrr4sPavBFACHcDiXkIf2mBLfowc5?=
 =?us-ascii?Q?40btw4LHB+ZaX1aiqO7W0sOUYA0lzk0GOp29HaZRGPLU4lMk264MHR0QsxNc?=
 =?us-ascii?Q?GPNgin589ht6u1Vn/6XfceuUhu3RYl2DYz4dBIvG3y5HQnTca/TvnfHGaU06?=
 =?us-ascii?Q?5ticy3OVBMecjGuNP4y1FbStCdHNU/CGgZxoxokwtDwrVlYAMSXgjj5QL7yO?=
 =?us-ascii?Q?ZbCRuU2p6LxfYFT9sEOc95sZGG1jGu+iu3bUU3iZRqVVTbS45Xuh0ISzJDgz?=
 =?us-ascii?Q?B5brQCSTa4ll/y0W/sT907d4465AgTCQ5GkT2U0WFTA7zGbKQbP1Yt9ts+Ga?=
 =?us-ascii?Q?uzOPO4iK0hvznJ2Xo2Alo5WM/zttowCNDBBe8q/aErTisfm8xwiHGzi5xX0A?=
 =?us-ascii?Q?68C1IXgTD0liav0qrD4uyv8Yezp6PguhjHZC0tl+yyRbZkDdrvQCZtucyjur?=
 =?us-ascii?Q?ZpRNcZMKtr9JKFEdfMBYwzT8YbxmAgWOh8YUaV1aK1Jty4zVEFm1OwqGozqj?=
 =?us-ascii?Q?Z4dzVcdvXZuJh90uSUsOUrfi97xAcMZhM0GKYzQEBGCSEzTlmsO1YBELYpo+?=
 =?us-ascii?Q?xUH2gkXopxdMTn5X6pWeJUAJFcXtzJ/42yILloXNoQOpe+Yu5qoz/Unc4ZxE?=
 =?us-ascii?Q?YxH0F4Se8BD/+DWD8cw4EkA7HYZ8HC/w/qSxw1udIXCjhSrRsfoaS4AGRszn?=
 =?us-ascii?Q?t7G868OQxi7kHdyp+vh/js70Q941sU21H7TPcElzirIAQCMmkSvOihCEyJcY?=
 =?us-ascii?Q?Eu4FYQR7O4Z75ymHikC6Nzn5Nii9xISYlkXss6UV/nBQVBAq3cVsRHqGGxmt?=
 =?us-ascii?Q?zKypie6Tx6bs23ffKlT9sY3EnlsacMj/Waa0x2O+0V82P9iOtMSGES85XCmy?=
 =?us-ascii?Q?wQA1jvQUq8XcIkBwSNvXifBzbqUZPdapUZ8eJa7+8luWxEh/Ik1YmEtwfqN4?=
 =?us-ascii?Q?2RyRNr+9lt5hMEyzWtQFMME8Y/Z3Rgi144U+ZpV6BWOlHi3Onkjn9PG9hlbR?=
 =?us-ascii?Q?T2UcurSAtkcWiai15kuRSBiaJHZZHqGB/qxZY+XxAjqPySNooKXpd4PAykQR?=
 =?us-ascii?Q?wGq+KmnKbYEOTWnXnrqgnzs3yWYHnqOq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vnrQQx/S8OUh/brf1mVET4DpY4kXDuMz1/i3qB+3rduG2eiZ+j1ZWSq7vvI8?=
 =?us-ascii?Q?RpCZezd7l1TyI3bjRMW78+DUSqzurvFuuFcp4lS4hAG5hHNZBhOV6ziSXPe5?=
 =?us-ascii?Q?yCRPHgzWflUFhCGPkYOW+R9YW3z4UZJk9wkfoKF8zpsZIw6hqBah/yTCXF1t?=
 =?us-ascii?Q?MpYF0SaSwrrSJBYp/q3JHjyEDHVpfArdMJAfBt/OCpnG/wmgwLuc9BnRTzqU?=
 =?us-ascii?Q?zsokDoQE0s7kz6p57JpvFSdAXz+j4fn6JL4HHDEf35Lt7vvqPMPbe7CF3+aB?=
 =?us-ascii?Q?ukPa22eQKM39655QtREIQ3e48c3qYpv9mVt11QqLhQw/3a1DFxIhTOgrwFRV?=
 =?us-ascii?Q?J42AEErn1HC6D6S1FpA6UrbeBsI76f29uevV/5LFZMxaxyMeUQWW0Ie08jR+?=
 =?us-ascii?Q?e+rfeV8xHZOg2TOlWXgY4jjS9j8YuBnCW+qZPj5mSEDEwRNfB87oEKENd0JO?=
 =?us-ascii?Q?TihipT3f5GVVHda8AMOibLFA+WTts8bny+InjGVZ8S+iuWbtzvJkwf6Dn1i9?=
 =?us-ascii?Q?Sy3H2B9eC3U1W0FoT89uSJi0qzvtYgd3bme2lnjRFLNqG/kws4RBI3dwouaQ?=
 =?us-ascii?Q?7LIEnMSP8plGXTVCtK2W9POTr1fyGsI62VYYwXH5dtxkPBD77mSVp+2XRf/S?=
 =?us-ascii?Q?kH5QmZufd7Wp6cuogepQhqjvYP0uc9+1yQuHWW8R3Ns/Yk0zINq5lS66+RFd?=
 =?us-ascii?Q?9ANs2IU4lr/w5MpIXS2+q6zE2UxtlYQy9HrPyv2nXqytLV6W5z0SN8HoIgi6?=
 =?us-ascii?Q?M4/9987ojmW6BnQwo7Gi0Dlf3bdqluEznXdTA1KaIwEF60TDUAwjjeXaC9FN?=
 =?us-ascii?Q?qMeUyA9nwBsPHiBwNjJerunRltOit+Ea1Oun3+zj4hzaOo9jQorxUtseT6+j?=
 =?us-ascii?Q?CKtdaBZKSHJu+QhH+PXWOWkfIdUjNnIZrXtn3QepRbXwZJQIVNUKaNNZCgRn?=
 =?us-ascii?Q?IWQ5jzIL5Ejhrh4FHZ/cW2NUvXQAAUWODcu2L9E1mOIcVvwXS7prk4LFVPWF?=
 =?us-ascii?Q?aY9IYySxcosC/7R91basJS563lTqep6phD4ILjK3aSNp6Pfq66HnxQUbwFDi?=
 =?us-ascii?Q?sN2llBWuxcSYqfpLXH604h/ifl1pTlyq9mG+UM0NrOwyZWdvKza4E6JbNJab?=
 =?us-ascii?Q?MvFJWZkYlQcK5QejOxkmAvVV+rbZ+RFKHoA8TuzlofrmG7GDR6y3P3hfTlZf?=
 =?us-ascii?Q?511Xnl45Yr99MSpWZt0BuVa0rLFGMg+cXQC4tjSHbXfedCgxL3le8p4h70b8?=
 =?us-ascii?Q?uEmUGK2OPbxEWweufeaPuh2rw+PmWhj7YUEfq3EFbW3kUbfhdE349sjzKRBt?=
 =?us-ascii?Q?ISdUfVbJc9CWRMtEve06qbMQ3zMUyAUtBsMTQeIMfMX8uRcB8mE+JycBnZc9?=
 =?us-ascii?Q?JgfVufFzpHho3So7Ei4qiLzezVk/zXTOHgvecF8WC9P02K6LZQ1BIYpNjPk3?=
 =?us-ascii?Q?qRk77xPPEbNFHzd+RDLO8JR/CUjBpF/Hl+VB3yhioAYmGYZj2Ogz+MMO2zhG?=
 =?us-ascii?Q?EXXkox8D0n16xpXMT0Jf3URT8YLOL++F07L59FzJXQffvkVBRb5K70UZtpdy?=
 =?us-ascii?Q?wKdJMmuo9BmGja6UaOS1XLjfItNaxHRwFFseagcL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf115d6-a67d-4548-7267-08dd6302c53e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 14:16:10.8337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFfxWN6Lhr5dRjQBz51aWUVjyPi8Fa7hF5OlPRw/An+mgTiBP2qcUXsSnfBGeki4L2BEU/4j2DgB7NxEsUKcyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11091

On Fri, Mar 14, 2025 at 02:01:04PM +0800, Richard Zhu wrote:
> Correct the range of PCIe app-reg region from 0x2000 to 0x4000 refer to
> SerDes_SS memory map of i.MX95 Rerference Manual.
>
> Fixes: 3b1d5deb29ff ("arm64: dts: imx95: add pcie[0,1] and pcie-ep[0,1] support")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 6b8470cb3461..0e6a9e639d76 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -1542,7 +1542,7 @@ pcie0: pcie@4c300000 {
>  			reg = <0 0x4c300000 0 0x10000>,
>  			      <0 0x60100000 0 0xfe00000>,
>  			      <0 0x4c360000 0 0x10000>,
> -			      <0 0x4c340000 0 0x2000>;
> +			      <0 0x4c340000 0 0x4000>;
>  			reg-names = "dbi", "config", "atu", "app";
>  			ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
>  				 <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x10000000>;
> @@ -1582,7 +1582,7 @@ pcie0_ep: pcie-ep@4c300000 {
>  			reg = <0 0x4c300000 0 0x10000>,
>  			      <0 0x4c360000 0 0x1000>,
>  			      <0 0x4c320000 0 0x1000>,
> -			      <0 0x4c340000 0 0x2000>,
> +			      <0 0x4c340000 0 0x4000>,
>  			      <0 0x4c370000 0 0x10000>,
>  			      <0x9 0 1 0>;
>  			reg-names = "dbi","atu", "dbi2", "app", "dma", "addr_space";
> @@ -1609,7 +1609,7 @@ pcie1: pcie@4c380000 {
>  			reg = <0 0x4c380000 0 0x10000>,
>  			      <8 0x80100000 0 0xfe00000>,
>  			      <0 0x4c3e0000 0 0x10000>,
> -			      <0 0x4c3c0000 0 0x2000>;
> +			      <0 0x4c3c0000 0 0x4000>;
>  			reg-names = "dbi", "config", "atu", "app";
>  			ranges = <0x81000000 0 0x00000000 0x8 0x8ff00000 0 0x00100000>,
>  				 <0x82000000 0 0x10000000 0xa 0x10000000 0 0x10000000>;
> @@ -1649,7 +1649,7 @@ pcie1_ep: pcie-ep@4c380000 {
>  			reg = <0 0x4c380000 0 0x10000>,
>  			      <0 0x4c3e0000 0 0x1000>,
>  			      <0 0x4c3a0000 0 0x1000>,
> -			      <0 0x4c3c0000 0 0x2000>,
> +			      <0 0x4c3c0000 0 0x4000>,
>  			      <0 0x4c3f0000 0 0x10000>,
>  			      <0xa 0 1 0>;
>  			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
> --
> 2.37.1
>


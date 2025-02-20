Return-Path: <linux-kernel+bounces-522892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57CA3CFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53FC3B746A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC88740BF5;
	Thu, 20 Feb 2025 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wddBpduw"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547CF10FD;
	Thu, 20 Feb 2025 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020444; cv=fail; b=tKS9RMywoImCXMshPcLu2jk9ePwuuVLdul9HrGbM94IqQNRNkWAPsFPogcLTiC0nIQP5E0dQS/DGxdqxrN14Ib4yCZOJR22ELFQbyIBa1n5DZrVzHAuP40GLZJGZSFz4dKGGng8DslfvCL01NxcrTFPOu83/gBXtSby+6GYWedA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020444; c=relaxed/simple;
	bh=vveJ2zaA3kzCxEkuLa8GLGBFiyXwIRFGP2rLY1xaWfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sBmopcZXGi1KrawxVeLfotnBEitQ2qd2UqWpy0MJNQ/ozR3vdoC5gCiWd6XWr+sJJFCFQieHhYfAyrLbmL4l5nhzoqWVIyuT9yygUpcc40lDlRmwMiviJFGysWBEUB2JbIZyAYigkkjYSkhPcvsT7x64AZYXeTU8fjVQ/VvZdXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wddBpduw; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tj9psAzM/pCetBcz8ghfZnlPNLU2zkKzN9XGGoalc3BDu0ubtuwq+4egCwe+jIlq6yVrlGBe4KUVH5a1oNkGsdaJXjJtjO+4/rLjHzyxFInSYuSRSMVIMcPx6aLV0wJM5I/eskecE/0kfuJH+gjNbBwRYJzp5ff/LTOy/b3nFtzDNKIzx6kygNHLmDli3v7SuU13uATkuaLNiF8CYgBVp0pgHYsoRs7Q2701jqYyRVG2/LvXOmHs9Pq4RYPo8vRAqu+LobOn608NKIwMIaxO8SKVz0jPnjJbU3xYd91duzlgNQhptAceBh3QWe+V214g9US1Sk9t3uSd8Ia4PfSyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vveJ2zaA3kzCxEkuLa8GLGBFiyXwIRFGP2rLY1xaWfg=;
 b=jpVgmte3JApkt2ApoqWtYx843EplCgaO6XTrv3nSFheJ57LNnRZ+iGuOphnOc/m4g0oTE5cquasBKoCtbQrhK7z/N2CiDh/5tlXMtQtESXoF78DPFDeH+fmZSWpg1UhvKfw/U5Z/smedtg8qw/oDf0qN/jHNFdbQtbYAII0SJOUWl0u62Sis/SGZbcIAaxbvLFlzYWu26IU3fyWJ/AWi5p+FjbNykM34nfXh6wK8+PDql2hczFsdht8RVI/hRkjLn4v77mlYjfV0/6mY6vXmzX1M/cELT5PdRKsacbNZ14PoksOyDg62DamP8I+RpmuRMoWiL8OeLEcww51Owbpocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vveJ2zaA3kzCxEkuLa8GLGBFiyXwIRFGP2rLY1xaWfg=;
 b=wddBpduwW2GOSxmvzV9FNNSnRQoS52CIhEqWdSPa475sL+CDTo4odVwa4QaxIFjimbThxU12rMSD3URMBu2aRlREA1wT8m4Io2etu9oLrkkGJlVNOxs0n5WuW023NsSmYcyy6OSsQFNzSg2FHcp4/DRX+kcXKR0a3oGY1y/Ui1yYpmXXwY6y3N4dNpHIedlxjY5zYKpM9S3Z5wm8Y4caJq/1GzBf9vLwznCpWioFcKvgFocd38ZX7SpVNQ1Tw28ErLSC2aLIvmfVIwM7cNa16J70ta2cCq/6srZo91nl5w9iPyEHNNJ/oh/v+dCo86J6nbAV2E2fo6vv48X74YnfiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 03:00:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 03:00:38 +0000
Date: Thu, 20 Feb 2025 11:00:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Abel Vesa <abel.vesa@linaro.org>, Marek Vasut <marex@denx.de>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] arm64: dts: freescale: imx8mp-skov: configure LDB
 clock automatically
Message-ID: <Z7aawuaQIBHbma3j@NXL53680.wbi.nxp.com>
References: <20250218-imx8m-clk-v4-0-b7697dc2dcd0@pengutronix.de>
 <20250218-imx8m-clk-v4-4-b7697dc2dcd0@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-imx8m-clk-v4-4-b7697dc2dcd0@pengutronix.de>
X-ClientProxiedBy: TY2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:404:e2::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d69802-90bf-4754-3edd-08dd515ac103
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dkNvnVTJFVlFOVbz1oi3DtAGdYa+oPB8uZ5yuQvZL7hc/6Dxu6xvkPQ9+gur?=
 =?us-ascii?Q?yK+9HA1UnDrysPC/tolGbGW/EJEkAl05YMpB7O/IoQTRBI+IH5raVB4BZd35?=
 =?us-ascii?Q?cV9NJfji2wNDex+ghLOwVqI76V39ibMeSXy6lqj8EcEGEzxuEdnjaVtsg3FX?=
 =?us-ascii?Q?/EN1PRLOpN9llsVuUNiwE3o0pWyNSvQ9x2wGpZa203s02Vyw2xrUw5fVMjjY?=
 =?us-ascii?Q?qBfjAnkNO5qiGkKuFkTnoEe4bYH7tSKliuvw3lSIycjX3EPvkDq9Zdf1t0UA?=
 =?us-ascii?Q?9+8bd//XQFL43qboa5cs2c6u/1xZvngfd47SrS2l6NZ7JV7WuV0xIlzeyX9M?=
 =?us-ascii?Q?Lfbnh6TkP4RcSMUfAltviom3wkHlX45tMB0QVMCcpmeDeObX3cs67GQgvZ2w?=
 =?us-ascii?Q?zJJhALIfSID260h/LFBvprtthTnsDMyaUaX3skwd8aaRDX+u2NAyePb/2HDF?=
 =?us-ascii?Q?18oT+IFjEzmVH2biWr7DUFvewJpLCPzO0dLd4D6lBf84UFNHivaAVLweHNpt?=
 =?us-ascii?Q?yuzwONU+mhTG7ale4bkR1Q8wP7WscGZ/ow6HSry9VN4BYFH0zM3tpv6oTeKX?=
 =?us-ascii?Q?ATCbtGpEV2l0f+ScBLigQ1Wq4+BHfctffBJywj8CX+hH6zTzaH/IoA09qq0P?=
 =?us-ascii?Q?w36EfZIzPMJtmjYXgXPmP8s5W82K0SD904qNc3H1x5DYZNyljUcmaI9Cj3AR?=
 =?us-ascii?Q?3RlA6N39lcPizBYo0eNsg7/rtm8Ojf7LH/R7ZmZ7KMxe7n4a9/x9l1i93igf?=
 =?us-ascii?Q?NByYZm5JU6wKLCbsf7Qz112PmqfzsNAIbWs6/5AXd+mQZqr+ljJuxoH+0tr/?=
 =?us-ascii?Q?w0I3qBS6HuQJGQlgqSYSD061yu6UTKZW5cHqb8SdneBrZ+UMUUf0RdnQTh5f?=
 =?us-ascii?Q?QBoc/42R+Gq65IHCvzCJd2Yt31lDjPKT9gJnV45tiPDGGUKX2q19zTVSxW6K?=
 =?us-ascii?Q?WFc3R1KVH8rKkazUcPVUU0flV7ynrOKfwGd22Ec7s8ukY7qGBPAMIB1ijPmC?=
 =?us-ascii?Q?fTnm3M+6Sri1c9xuq+vz8TPNuGo+4txAYZtGrHETp7NCTK5hQkrH+2UMF2WE?=
 =?us-ascii?Q?0L092Z94qp/LjVeFSh/WKVCfZkb/p+19gr7Cn6oGIG1fP2/opJbrNV9/ndlF?=
 =?us-ascii?Q?h42DFSrtYNxomyRFPCEk5OZH8VKNs4A+L5yGgUdePIZFc6hJEpH2PdSx/BBS?=
 =?us-ascii?Q?akri+KHNFECV/jm/rCviNtbkmtcrye59ccJs7VQWXL0Z6lT+o/ykXyY8UYeQ?=
 =?us-ascii?Q?MRwY4gx7kNk7pyTqZWNgoZhc7mazI06LHvY66ka/9O+b8DnkIu2cGFDNrlxg?=
 =?us-ascii?Q?Euq9DIBBgrNbfUlze1FCFWFTO0iPPyzJY3KzzdL0A7t2zLz3chgK+wKq+Gag?=
 =?us-ascii?Q?hOZP0ljl3MRGusQ7ytqEnnDoS0f+eZMcR7WlRbn1DsoNuA8pEYilJ8mXkEa0?=
 =?us-ascii?Q?rZLg3oKbecx4O99XHWeGyPWepIcyKDAb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HHNYmgQFxXYl1MPPWCskmKq6LlZN6tvU/GIviEERvh+kaVCAb1h+aZHqWxQv?=
 =?us-ascii?Q?yjOVxVa4ASxIAp4a7xG3Ew6tFJdmETjwDovYrzyEnakMZk6nhr58j3cSNtNp?=
 =?us-ascii?Q?X2KVfJp9y1tH6DvwsXgeiZohLxMEztv8WjetG5ob1xL7N91YejJsOPMFQXoH?=
 =?us-ascii?Q?Cz0xkJKyC8eCAo/P6E4Ib75GEir1QcuB44h92JkkZ/ZlGYIRTpJ8U+IlIE00?=
 =?us-ascii?Q?WoMGHpOkhuNgPzK7uKbS7A/0dSgQplNbsNPHU/Oqc5l1k9s84TiZg7BvtA8j?=
 =?us-ascii?Q?7au9QfkuUd6whesXAmWPxe+Q0sBpnYzyzSzCgKxu8VzN4rxEdtoLU5XBr7ht?=
 =?us-ascii?Q?YZZE0vXvADSs44l62BjMgRdoJ4llILOM1hoYRzJLSkWX/Apmf4RhgfmozmfD?=
 =?us-ascii?Q?72lKMns+mlwDRH07QW0mGUrYzsO3T+0TuZze7VaWyVJeHr7ahS/ysWqel1ow?=
 =?us-ascii?Q?6t960bEtYiXmvizwf1QTxKIqkaJdENNHQdXuehd7YTMHt+b/sY04jFtEapoP?=
 =?us-ascii?Q?voMnlM5GY2f+lSLkASB8ljHAPGJA8iQfWr5re4+1kw4SGo0eI2XbnbkQPF76?=
 =?us-ascii?Q?L6d/rQMrVIBvE+vOHFTRTfUK11N5gKm42QZMhBf8AKcyw/BMIcCxgXYO45lV?=
 =?us-ascii?Q?qZHLxw/ERTjB3xmyUBUu4Sh+wRCtOUbSjGSaV8WLAHyMTGX/L9vC5w3mALR8?=
 =?us-ascii?Q?5PzjvQw+1Yz/8gMRwvQm3blKh30RzWsloL+blaZO6BZUc+s50gbs0tGJed+7?=
 =?us-ascii?Q?/sXkLqt0FPiE9KFHkh3flrspdbSXIdgbeZw0U9KxznASzYqVhIEV1L5e24XN?=
 =?us-ascii?Q?PeKLXhFabJ8OkRgOBVdt+RCP+RduzFySyFyWnGpRA5vQwNoE2ut9vdLnrk5O?=
 =?us-ascii?Q?y9DyXhDlaxsJUwap0NR5jZBqZI3cHG3jD4uDDKtAWmHm0Yokow0GJ8kBZ5q6?=
 =?us-ascii?Q?R7bd15yPOUwPteC2jKB9l675zfgOGkqAgXmjIFwv5hUm46Xnb71yWl3+1DWK?=
 =?us-ascii?Q?jIQYe96hKSNb3dIr9OjF8okPqWVWXR2H9j5V2YslCfKubK8SrRHV5BYewPdg?=
 =?us-ascii?Q?7lMDQU6qn1xhJiUGPhLiBjFzKan36aNrZ5S7+KdzzujQ7geyF5syZkzLkea0?=
 =?us-ascii?Q?RIv5R1yzrRNa1q5ghzliY7WMWlYvh5vePAQZ3xRpzDWWoFwyFNMgqIC8+nOi?=
 =?us-ascii?Q?7itLEyUgiOIswDdlBES1kt2xtVFdybXfXmeeIGvQ1Ix8bj7Yxb342PsNOQkX?=
 =?us-ascii?Q?OT7JvAzIKLdwWl2Q9Wffdo9eh2j4WbDIMUYqMTq6nDL+XAlaYOZ9MdtAWurv?=
 =?us-ascii?Q?lnQ0d7yElBDFJNjbpbilajgzUnyn/cbabJz4i6Qs6lc9drqMc6v11PDFTAFR?=
 =?us-ascii?Q?99QHQ+bFrmqKcGl0Ev0oaF19OHLJAam4n15/CIR42gBA/bOv2Dv/C0W023/U?=
 =?us-ascii?Q?90ZMKhHYWayPO2k7ggxVZu4yufMBKoLHPPTZAg7jc+ytxaubK91qPv9fOOaI?=
 =?us-ascii?Q?Trq0ehBDE9fjsEWMET7w+1NmWR7/7RySdjDG8b/Z6f0bB/FL6HLZ2NIPEMNj?=
 =?us-ascii?Q?lsr/egHGVqhpHVMvUzmdONFS9Gu+kKf/uHuIPNfv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d69802-90bf-4754-3edd-08dd515ac103
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:00:38.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGUBUS/+43jh9M0kYRH8t3DJboXPRjEN5C00Uhv9BZzbH3h8AXUAJA/oNldEJK+sfl5Ebu4oxScFLFRTXSpNIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

On Tue, Feb 18, 2025 at 07:26:44PM +0100, Ahmad Fatoum wrote:
>The comment in the DT mentions that "currently it is not possible to let
>display clocks configure automatically, so we need to set them manually".
>
>Since commit ff06ea04e4cf ("clk: imx: clk-imx8mp: Allow media_disp pixel
>clock reconfigure parent rate"), this is no longer the case.
>
>Make use of this new functionality by dropping the now unneeded
>assigned-clock-rates in &media_blk_ctrl.
>
>Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Acked-by: Peng Fan <peng.fan@nxp.com>


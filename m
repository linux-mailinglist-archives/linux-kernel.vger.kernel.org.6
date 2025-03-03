Return-Path: <linux-kernel+bounces-540914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD73A4B660
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1177A4390
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F214601C;
	Mon,  3 Mar 2025 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YAR7xt9l"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10C182D7;
	Mon,  3 Mar 2025 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740971049; cv=fail; b=J8GdpyWhAX3e6WAH006Cl7nbbL3scHvoT+pDy/XKcWhWZa41mltXJl+GPw2m/nUsuVn+ayFjW6DojNZZ6P3yTDLB5GPg2SrFiXkcsTcer5BeJTzNY1LHPSEPP6BmiLdxfXbtE1nM0zZ1pansxxMJPFaYBunDnEcObta+5jcFnXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740971049; c=relaxed/simple;
	bh=FILKx3QjX8dujLcv/7+S6UHoapkVHYB/kHtiw8X1rMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IxMVxreU/JU6ds5qF1AckseUysP9x4XsbutyKz5zxV6cHCwORBnCs+MNE05mKJ0vPAE7ccD/ux8qV/Nf8CvTciria8qGxBpimNfPgJggq4iCs195dID+1sCF1uTIa1zTnT2OmWfEo6i9gYCbXhLe9OK8ydcWFlQpSc6OIG0gu5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YAR7xt9l; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEP5wnpbpq6LbCGgzyPrQEDfYGKYhXtcGnklhAxisLr93begvFfpsQXPiHfDWCbBwR0eRJP2R0Ed01wRDOL0uNwIV7Z1IuTQVPfd16tfmpAAZ6emcEldqTum4S6mGTDA+w7oUuh8/wVomvnaT8iYuky3SLeAR1HNXnMjvaH4jRRdVVDoX3O8dtfKWejksZaaVHBkYFprQHgh218wYmGsx+qMPRAUngd1VpirHqtccPIKeZnt23/ru80JUtSO5mKfK//BI6TTWoKo0pwcd4/KCQ2ry1lCtbZw5G29xwatNKM+N+RAgwhb9akHyNvwdPZz6zzjQxy/PO4G8u/w7pQD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/miYNMAJDChTWfW6zjuDqoihqynDPcW2BrxsQZ+PMWU=;
 b=dpk7f4ibKSWSKrAx8rLmNKCX2oI4o18Wj5DkKWZL/frfRLoybQGhHGRcW5uBI23mSmxayER1c6Ib67td+tyQBF+qwelDMzaA/rKtXmcB6jujmFGv8H/gFCyHhplC7xoi/AHBWYyP95bXxMDzF9rl5+gAjXYe0vh8hybivLKATstsrdPN5T3uq2bSirtMCsVTn3iuDUyLFpnkb1kEnKqfDGi5KYRBe1Wsf5wJWyLZDvQvglvMo4/oDm+nntLPE+aOoH2euiLn7fhZaC0InQejENOHlPKxXaZ/HNDQwSTcbR31U5CE8OjLTOz62fFR1HkyqA6mcXBAI3t3ilCQjIxZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/miYNMAJDChTWfW6zjuDqoihqynDPcW2BrxsQZ+PMWU=;
 b=YAR7xt9louOutiqNGNK8YpP490sp2Q4buDeT9ikmMMBcDrinMnu0cFGX09KDVAbrLauMPJTlRyPFYp7Q6v5Re3LWSSokGmtMl2DH2KGFCO6zR1yK/eFPyWlv3LCPX4OZvR43KQAg8eSMo9T9J8IYUuz+Sqeq/UAB/HLoTT31FCOv6xYQdKoWsle6ifpjuyjVW6cQM492FOSqATz7nPlVryLROuo8K/N9t2ltoeAuxGMeKDvGAGGOujWW1HTqzfVG0Ayk1c5TW+U7+ggC9C1H4ENuyJGI2jeg4WMou9RTUPbtXAu9+8Pec4Df9+URhceG9BcZc0cu2saHYQOtHGCGeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 03:04:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 03:04:03 +0000
Date: Mon, 3 Mar 2025 12:11:25 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Abel Vesa <abelvesa@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH NOT APPLY v2 4/4] clk: scmi: Support spread spectrum
Message-ID: <20250303041125.GC13236@nxa18884-linux>
References: <20250205-clk-ssc-v2-0-fa73083caa92@nxp.com>
 <20250205-clk-ssc-v2-4-fa73083caa92@nxp.com>
 <Z6SqeNsAqbZM8nr1@pluto>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6SqeNsAqbZM8nr1@pluto>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 090bc34f-615f-43b9-bc32-08dd5a000d50
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3F1z8D0EIqIw31trvJRQqhAJmceGbLoapj2i923wethBMoVpuLGaAQJGGKRf?=
 =?us-ascii?Q?jtDGShhpnAd/a8bNDWhdQV3XGezb5mEswTMRSfY8TtZGK4Fhd1i6IAleFNhn?=
 =?us-ascii?Q?LHjzHZByggIzc43+jo0rB2WkhSQx8mPrsVbRXFm1kZALsfz6qcv6xsK7DhVg?=
 =?us-ascii?Q?fdcjzoQh6/2/Dh1T4QrA05A0fQobHirXzUm+9fMMtE90QqYVMJAK84ofLIw6?=
 =?us-ascii?Q?uPZ14XAR/4SV83nbmUbtsjqmF6U/+bCetcMTDoENGYTroLJXWvLru7y/hc7Q?=
 =?us-ascii?Q?z2dY5ydeI229sQMnpNRyw/ezwzrDyE1+5eGuR7IDhqufF47CSHko6wbGgWXp?=
 =?us-ascii?Q?QdSy7T9QPAhgVHZFMyIyWDc7OdvUzyzQ3G5iZKkrKPc0rsyobQEgU1IH/Vre?=
 =?us-ascii?Q?tfoLD3XF6kqdrSQRE4Qu+9JRPVyk3Ot8LE8TYU9xmRQbCTg+7Uw8RYX597NA?=
 =?us-ascii?Q?LcMoI+juNQaAjYPQt13SnEh2RtnhNzhITgRRBhFU74sTMOE2+YuiAPdAowsx?=
 =?us-ascii?Q?f2NOg4G6kFfU4DQrf3MevH3qv+LVn1XV7scKLAUxiMM2lo94RGNQZFkQseF+?=
 =?us-ascii?Q?tIR7nVk+ILoekoi9sMNP2/aZayxRlNviL0PUHYluxypyT8341THm7OLWbyOs?=
 =?us-ascii?Q?8P5FnWJOpRaNBFFLthwIKL07IXjNKD4wPNXC91CX3mEYiJNERJYnJY5Wvgqz?=
 =?us-ascii?Q?onUG6dcimQ63PDF4Vk4EPUmzgREsqW5w1KElPGZdSMEAeCiTtin9h83IT8JS?=
 =?us-ascii?Q?mChGVNftaEFm9wHjHbFPRP9JFZJXwNp+LQsymJNIBZAO0SzqvHHXxMJf3QVX?=
 =?us-ascii?Q?mngY4wwDqrG893F+OdZrK1zEnuai/lpftYoHVEErd1YD4iMVaRmDSv5UVzli?=
 =?us-ascii?Q?xiYIzzwNMPVuNNoevmKXc+CDHFLC9ArpgZGEcss5+WIB0YGrnljjmqDaMEZx?=
 =?us-ascii?Q?5tVNqny1OCSZ0zaxNNFo9vx+Eb5td4Pm5VzTmrSrNlbgp7IYOKKA1HnJXbW5?=
 =?us-ascii?Q?uI3V6IsI9qm88E1BtJZQBT7l6TxbLtKQQZxbdqKKraWP0i9vgg9MKSDEm9KX?=
 =?us-ascii?Q?lPCj38niXGzcT2OQmOn+uDYLmHMO8TqIBdHhGXKKp6lzchFCUdRvDPZ0Ipbf?=
 =?us-ascii?Q?LeoX92sA+jU8CK21nFzQZsNxeOI3MOAqoeHlgK2vsQ00N4DAiR6hqXZJ1Oeo?=
 =?us-ascii?Q?Br1Kt/A/CkT2UWwQYEBSz5rtaqlGtJLIIjz16/dQ11DW9cemII4LqstVpf6m?=
 =?us-ascii?Q?i9jkHt+ewXWpukjPRHxhV6g1SJjvidEhOp7b4bbHb77IniUHCOI/0wXhMkzZ?=
 =?us-ascii?Q?VA901QOJdq2s5z39r3eI3jQWKhDkJszFiwvlQ9VoVToErZzh/Yeb/RxkgU0m?=
 =?us-ascii?Q?zIxUmDgMFdBGWY9r3m94VGQLrQAIyik9avZxMUTAD8pD3abNVhxrgJ5tQ7li?=
 =?us-ascii?Q?QRTZMMPU4OIqshPHanXswNv7udZcQkxx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bmw0iHW1BqGDXfsnK3Yk83QXyETFDOXQejw/E3J2Sqd3aLmQFQCU65b5GXmj?=
 =?us-ascii?Q?bEnWAX0Ho3zXiEz6ZeYs23Lj2bDIpEMA4Dv3o/t7kJswOGU4s9CVpwLWKhdU?=
 =?us-ascii?Q?OyrVNuTsheL3RZJMooIERs/gfzMN/0CPIG6bE/9ZlA3NEkh0obdAHOP9Ncj7?=
 =?us-ascii?Q?KcbBRGT34xnQzIZjtw6p+eXsMDaHc8cJ51sgMS3Kc6HkU5yJV6QcWRmIJ+Ko?=
 =?us-ascii?Q?C0exfYG9r/5bKTmE7BcEIWMu3BAlb8rxTlgxbvd/oARqj2EcQ3/uLqEkNAfj?=
 =?us-ascii?Q?QR3EXjyJED3/rQNG9cW+Pz6s093uBw2LFh+SbQCvl8RDvK0LugNAR5OTDpQk?=
 =?us-ascii?Q?aOPjv1fUNJbHl4adh3fW+JprtqC36AqXbgkH92g03mltygr/vFqlfwmXJhcW?=
 =?us-ascii?Q?Ka0seEAeon4Bmso2+x5UW38ijLt5k/Y1GHA84iPGbO19BMwhHMuClvyKVXbJ?=
 =?us-ascii?Q?GD/t3BJOhtvqh+zw8WSiR1OayLUwC2nFWMO23XhAgO/zXTcm/YrpG8lwTcby?=
 =?us-ascii?Q?/EHdMVvzipot/vkLTTKCZyGXhP3jwiwYES2MMd5Bc2cGfymbihAdIxtpuboc?=
 =?us-ascii?Q?UAO+H2CddF6wnk4pDhyUiDUVW3UB6P3NvQ1B3/EZp8P850AQCJhlaY0b4Ad1?=
 =?us-ascii?Q?0vk/iWBbyATpg/UaZIZngCLGeJzKa8ofVok0JD4sZyS0asINZMd9IIuqvq8y?=
 =?us-ascii?Q?SaPk//VGm6XYcq1RCaoUC4bz4pHYy9WZ23Yr8K5nhXnBqUDZI/u4M4dyCnDf?=
 =?us-ascii?Q?QM/kxwN/aSS2eXs5W5kQqwdQVrvPi3Ke4bZC+YdBj33SdmpharDyeplB1rcb?=
 =?us-ascii?Q?N9JvxK/8FLiayaBoKbhc4T/Z2JxouCbTm1M1QIMn4A2wWrXXhKs+SpgjXjPI?=
 =?us-ascii?Q?LdU63vVwG2bll7/fXASyVvTxT0MXoh39WE5zvsF7a/CjytOEfmDSlKkDESLs?=
 =?us-ascii?Q?Ltnza9x21d+wgpSaotjkYxgihs8SSMkgB4Xl9CJnJrFSDnIa7aqAkzO7rCk4?=
 =?us-ascii?Q?hiatVFeRvlwVi3J+Bi1CQFubMbXNDQJhmVdUvwfPx94+nYXNJ46NT8GO5VeJ?=
 =?us-ascii?Q?lzuqsjVFocfUIV6aTIZ22VOCHB07VUx8csxqhaiQYVLPHmLiKSFOm4MLUA7i?=
 =?us-ascii?Q?GTLCKbAL2b9waY7fGImJuikAp7lYIRSuGv9prSAx0uvr+ZOUeJGzMHxWOPE6?=
 =?us-ascii?Q?0g3Euo0IqZTadb7yJEuKXlo9AyBZqwDlr+b7Nig32DTcZgwzE4cgKi3oA0r6?=
 =?us-ascii?Q?RtVrrHpM+Q5SZR8Djdn/zLpfReEHva8+XCUrqoOCjMdbPc+xc+Gn5c5COa8T?=
 =?us-ascii?Q?iqk6Ip3zt0uMKLN44u6P8OEym46QVIIq9WJiSbaNW8mNLyXTIo/3STLNIC1A?=
 =?us-ascii?Q?A0OYvY5tXZ49a7fzeYptsfAwRrnOJaa5CBF/XZ0f9UCrcwjKHukm2NyQLEwy?=
 =?us-ascii?Q?cBVq/K3kgVtc82G8RUozeRXsLQ7/3jb3+Bgh5hvOBP/32HmtWNmGGfSClyaz?=
 =?us-ascii?Q?QgrXuNutpTH/dhJs5XB9pSJf/kezEQ7CfhZ0bjlrMUf+C61dqDZ05ljY7dMc?=
 =?us-ascii?Q?VtITFo0JshmqPvogDiWEbqS8P7IN3AkzkDcygRsM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090bc34f-615f-43b9-bc32-08dd5a000d50
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 03:04:03.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2DvSBK0Ktx/HoEd5xvE7fI9tvgjx6eFyCPg9QTXmeu/lh7BbOjl+j03U2Aku7gzYyqX31kA//YelmPgCwCD1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308

Hi Cristian,

On Thu, Feb 06, 2025 at 12:26:32PM +0000, Cristian Marussi wrote:
>On Wed, Feb 05, 2025 at 05:49:54PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Support Spread Spectrum with adding scmi_clk_set_spread_spectrum
>> 
>
>Hi,
>
>I forwarded ATG with our latest exchange on the possibility of using a
>standard OEM type instead of Vendor one if it is general enough....

Do you have any update?

Thanks,
Peng

>
>...waiting for their feedback on this before reviewing further...BUT
>just one comment down below
>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  drivers/clk/clk-scmi.c        | 47 +++++++++++++++++++++++++++++++++++++++++--
>>  include/linux/scmi_protocol.h |  6 ++++++
>>  2 files changed, 51 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
>> index 15510c2ff21c0335f5cb30677343bd4ef59c0738..56b9d0166b0170807c1a83fff391033fecee2159 100644
>> --- a/drivers/clk/clk-scmi.c
>> +++ b/drivers/clk/clk-scmi.c
>> @@ -23,6 +23,7 @@ enum scmi_clk_feats {
>>  	SCMI_CLK_RATE_CTRL_SUPPORTED,
>>  	SCMI_CLK_PARENT_CTRL_SUPPORTED,
>>  	SCMI_CLK_DUTY_CYCLE_SUPPORTED,
>> +	SCMI_CLK_SSC_SUPPORTED,
>>  	SCMI_CLK_FEATS_COUNT
>>  };
>>  
>> @@ -98,6 +99,36 @@ static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
>>  	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id, parent_index);
>>  }
>>  
>> +static int scmi_clk_set_spread_spectrum(struct clk_hw *hw,
>> +					struct clk_spread_spectrum *clk_ss)
>> +{
>> +	struct scmi_clk *clk = to_scmi_clk(hw);
>> +	int ret;
>> +	u32 val;
>> +
>> +	/*
>> +	 * extConfigValue[7:0]   - spread percentage (%)
>> +	 * extConfigValue[23:8]  - Modulation Frequency (KHz)
>> +	 * extConfigValue[24]    - Enable/Disable
>> +	 * extConfigValue[31:25] - Modulation method
>> +	 */
>> +	val = FIELD_PREP(SCMI_CLOCK_EXT_SS_PERCENTAGE_MASK, clk_ss->spreaddepth);
>> +	val |= FIELD_PREP(SCMI_CLOCK_EXT_SS_MOD_FREQ_MASK, clk_ss->modfreq);
>> +	val |= FIELD_PREP(SCMI_CLOCK_EXT_SS_METHOD_MASK, clk_ss->method);
>> +	if (clk_ss->enable)
>> +		val |= SCMI_CLOCK_EXT_SS_ENABLE_MASK;
>> +	ret = scmi_proto_clk_ops->config_oem_set(clk->ph, clk->id,
>> +						 SCMI_CLOCK_CFG_SSC,
>> +						 val, false);
>> +	if (ret)
>> +		dev_warn(clk->dev,
>> +			 "Failed to set spread spectrum(%u,%u,%u) for clock ID %d\n",
>> +			 clk_ss->modfreq, clk_ss->spreaddepth, clk_ss->method,
>> +			 clk->id);
>> +
>> +	return ret;
>> +}
>> +
>>  static u8 scmi_clk_get_parent(struct clk_hw *hw)
>>  {
>>  	struct scmi_clk *clk = to_scmi_clk(hw);
>> @@ -316,9 +347,17 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
>>  		ops->set_duty_cycle = scmi_clk_set_duty_cycle;
>>  	}
>>  
>> +	if (feats_key & BIT(SCMI_CLK_SSC_SUPPORTED))
>> +		ops->set_spread_spectrum = scmi_clk_set_spread_spectrum;
>> +
>>  	return ops;
>>  }
>>  
>> +static const char * const scmi_clk_imxlist[] = {
>> +	"fsl,imx95",
>> +	NULL
>> +};
>> +
>>  /**
>>   * scmi_clk_ops_select() - Select a proper set of clock operations
>>   * @sclk: A reference to an SCMI clock descriptor
>> @@ -370,8 +409,12 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
>>  	if (!ci->parent_ctrl_forbidden)
>>  		feats_key |= BIT(SCMI_CLK_PARENT_CTRL_SUPPORTED);
>>  
>> -	if (ci->extended_config)
>> -		feats_key |= BIT(SCMI_CLK_DUTY_CYCLE_SUPPORTED);
>> +	if (ci->extended_config) {
>> +		if (of_machine_compatible_match(scmi_clk_imxlist))
>
>... please NOT this also here if we use a standard OEM type :D..if it
>won't be a vendor thing anymore, you should query with CONFIG_GET, OR we
>should think also about adding some way in the spec to query the support
>for extended configs like we do for other clock features...
>
>Thanks,
>Cristian


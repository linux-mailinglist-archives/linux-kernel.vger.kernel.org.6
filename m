Return-Path: <linux-kernel+bounces-354454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065CE993DA9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAD5285E6C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E21445C0B;
	Tue,  8 Oct 2024 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iWSCVrtB"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F733986;
	Tue,  8 Oct 2024 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728359134; cv=fail; b=Yadqj95u9U6ZBkWQDwiXX9WJkRxTUp8er/PMeUF/qeIfVf6mjxmqGLjcNAvdke9n6Nz1LTpnnCvFNpYIrm4ddgUcmRbW22otonjd+32AZUYQ1UEYFJTAiNxKFLGTSYotK4+wgcxWTmFQe3FApTBedgDOBvTVRJz1R15EDhLAh7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728359134; c=relaxed/simple;
	bh=uLBH9cv8HEUgbaboCImGiNtkgfDDR4iYjT06Z+XuuCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XqBAm42QkEQrqUrmdolMol7F8B+Oh4gq25k8deOnX0Lm9WEJaMJm/5fsrONXWnZtm6bzynfsxmrzbtB3uWM3y4pmp9FbC3Cjam6mNhyOt09NwIi1fbnYNNCWumOevf1wa1Zm4SqEU3NTK53s2wVAk8dzSfRkubgsjV6eAKBI56g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iWSCVrtB; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLOOb/ZckQ+F3UHP8IAeVWei/5Ki1xlsxNSsCElPWKP2sPgmnRjs8s2uDhuhaDjgRlqBJp17rBFOsoGe4Zwii95cNTz4FRF+FIvQaZa5SFaDLUI2/9MoL+gqWg4kJXoX8jgNUZxKp68npkKZf0fstoOYpyDrnicmWP1vH30MnVq+ArdDY5jnwSK8l2vr85zkKiw7rQMDIkfbKEyTWpBvrojL7HiI42lfYk0T8RtX2jFHymPU8ICDz2mMuIePay0WXFAKNsI94IUU0YG4lJsFx/s5cm9N4iZsf0pL6lYzxrMbOud7BIbcF7nZTVqYpGH7rT+9EiUHs4J1bEo7wIZgpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZfG/12P5VW6DmX60cgbOV2UHdXKld1EemIGa5wDe7s=;
 b=crfTT01HxOmvM17Ckj9kLfm1MozONman9L/aStH2O5b7LMgk1qm5FkXGjDi2Dgm62oV+7/Sy3gXy9+nak3vaLUsw4D4GFWRpR0IPNnco7qM1wh4LnH07OFoX1Cu8SoC308dEtTfcFqvEmmUC05MSKyK1hrC70/1fYTYXtNWOiOh3f9ZP+gZ8ZkE9QymHDibzclGGEPJz9mCvngnAt4wyYvZ9cVnscAXQv2PusEuSV8nkxEZhR7scPPRbIsx2WjLQszk0g4s1heiSQ+Gd5fCes6mLuc99otFb0Xn3M6SFmdRNXrxSUUWaa2Exsve5OPMstbNYIUgo0VWq0iTl60tHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZfG/12P5VW6DmX60cgbOV2UHdXKld1EemIGa5wDe7s=;
 b=iWSCVrtBuudFdsrHSL9CUJybaULA/Nhy6kNIL8SEl4HXNV2BPasJXpQfXj+R5qn83YSNYw3i87qiEgUlQtQLA0MAQoDhb00/SKmw9rViuFx+0giffwIC1/GDilFlMK28l9BIKVY26L6PtACUsn4/GEH8BttxArjo+tm6bzCo3LojYjTTbEOyjidlrrNNKRlM8gDi9RGnMaQxYKN31k1QJptLqMIUEbd+cHJREz0ncOhSi/oeUVPrLVaBk9eyWwsGqSXFA4UfomRk0k4p42hjS/f45i4VwXWbyp/a9KStlIw/kLWbTVLfw/gl3gD0tRdsIOQuYasGZnYS5WFbBEBoNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by AM8PR04MB7985.eurprd04.prod.outlook.com (2603:10a6:20b:234::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 03:45:29 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 03:45:29 +0000
Date: Tue, 8 Oct 2024 12:47:43 -0700
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, ping.bai@nxp.com,
	ye.li@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] clk: imx93: Move IMX93_CLK_END macro to clk driver
Message-ID: <ZwWMX66RCfxzCkkO@pengfei-OptiPlex-Tower-Plus-7010>
References: <20240627082426.394937-1-pengfei.li_1@nxp.com>
 <ZtAeGWtJDMyTVkjc@linaro.org>
 <Zu4Ng6DAYcQHCqPJ@pengfei-OptiPlex-Tower-Plus-7010>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu4Ng6DAYcQHCqPJ@pengfei-OptiPlex-Tower-Plus-7010>
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|AM8PR04MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 4deac49b-c72b-4a27-b9a1-08dce74ba6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zJhQvPC8zgXNccZa3udH1XSCJl2MrKKaYoVt5o7Q8cMdL1so8jxB3PfMm3AO?=
 =?us-ascii?Q?iyWIJhlahbV5QOW62H6PK1eLfhdi3NVEMbGWC+ftAlFnfvnEZHv8kZ6R3yZd?=
 =?us-ascii?Q?0lE3ZM6bH5oJXUtkJe+E6nezS45deLP0ZLc87wh+M/8LLl7GP9NtarA3K1Ym?=
 =?us-ascii?Q?3sRpnZv2/u/2avalZa8Wc4Ku7ge7ZAovNjlf05dFdIgps9QQ06NVzAWAjquv?=
 =?us-ascii?Q?3ORRHrvA/d0BAbN5wKTFEAzmh2z9+RAJ2S1VypUTCOlRe2iarQFYn3sELjYK?=
 =?us-ascii?Q?uWIt/rdGbp2sd4Oe29YO7FiDs07gQ0aPDfsQUNZoNt+u6e1wF7Z5HW+RG3fm?=
 =?us-ascii?Q?cZC3QpmD1JrzLhAufARzCHhIWvf2vrMwTB0YBzyZFPxzZSkJTeWjpmImkT+3?=
 =?us-ascii?Q?dOsJ5LAnyMuJiYbe7afWR2Emx3sR2LjMCoHllXKwNXUKeZYMyT8RM24Ot4NG?=
 =?us-ascii?Q?kCBHrIN/lnKj/yxfvpcUY/24KncEO79O29ehKFNmQqVdrJrtIpnTip87B+Ea?=
 =?us-ascii?Q?Lraz6wZAo04jSFiNWhIg1OLrqDIIo7y8w5LCpfPc9uX75/oVdPdoRGPS/c5l?=
 =?us-ascii?Q?h23Ro8f+I0xjQwVyyQYR0M71DBngInPPBF+I3pk5bfUw9TUlATpPJh4wBGOh?=
 =?us-ascii?Q?QEMiYVv1RMte9XmB4OCbIGKq3ABOveVUwe6vKNjhisqc/D7fvMYV8s7dGqsy?=
 =?us-ascii?Q?N35Vg0quUNPm5b5gubFnEfJ7kNzFYHWP+csiaEOMerGbEgosPYw+Pfp6oAXp?=
 =?us-ascii?Q?6+AFaDthuLSkqPkqfMtx+iEXr+mEotvM5ouc26zU4xtrg6p3bqjNPqNRKPw+?=
 =?us-ascii?Q?gUJ/5jLeEwOaI6AHePGFsDyBi8PXbMKE82R21VMY8ovb7ecTORbE8jo/l+7P?=
 =?us-ascii?Q?OHMm8nbuFA+n/vRCZu7Ow5cBXS95zORN+4a9YVC2hH/yQ71grW9L1y/L8L6j?=
 =?us-ascii?Q?6/lrkR60/eIg4dfcmR7fK+AfqxDGryqjH5Z+t8+jNp+9+rWsl3ugWtbsuvfz?=
 =?us-ascii?Q?fbV4DtCBaXIQcPS3Joy3XaTkCx/zHif3lIUj9+XXFFDTbraj2lEr4kh/cRYE?=
 =?us-ascii?Q?PFWiOpdt6OmMY8fscy7dXszYjCX18ByzwtUiQgi9lKhrW3YG9fOrVVRnl/cd?=
 =?us-ascii?Q?O/iqaMNzcH3k8Ce2nc9BAh//nGRxCpamKC9o6kqNkhZL9GArZu5jiaFzMwc2?=
 =?us-ascii?Q?QPXMjd0+H0pRi5vzr8KEVp97LWTafg+CItbtrwMdeNx8/4HfuaanSLDSqHdj?=
 =?us-ascii?Q?gQOS65QhH6onCqBzxTlb8LwhR8p+ZUiwlg2trTPkmaxORxPZ3e5mLhm5gXJm?=
 =?us-ascii?Q?s6ky+wE0mgA0ILmUMxElsKxGG4EQ/Np/c120reS6vppoNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oE5p/AjcCYHx3J0ZlWwH7Oml61MqbpmhdO3EeznaIyey/yNiiZ0o8i+tQYCR?=
 =?us-ascii?Q?CJqKuO3oUNQxwFUKONUEguNpggg7F5i6Zjk4OPuCBWLm5SCAs7JLLMnrfnRu?=
 =?us-ascii?Q?dFXYaJsZx7nsJGQPffb8r7dzFlINts4HHZobka13HwzIGYSZCY0ZyAWrgY9C?=
 =?us-ascii?Q?FzGpliTV6bcRQVw8waj8IQHmFpKl7kOvELHyt39mb4rJN50hi/WPhCb9lkrF?=
 =?us-ascii?Q?mt8r3VwuKEeOiFdOEo4U3hmm3pwsgVZC/tnm1DitqwKeFcFKcfW0pFtBLXSk?=
 =?us-ascii?Q?32/irM051j5TlN66FMn5XswWepUPI+W/7R/BZ+CTD4zE5qFfvd2hHrVhBlyu?=
 =?us-ascii?Q?4Q8wiYBrOB7DUf43nSbeTRbpG5NFyDcptDTFD8xqQbgy54MDnIdXe3R4LsdE?=
 =?us-ascii?Q?1t2leaxOMx21vxuJdEd4CShPd9cGHTlpsHUOI4PFH7jLjZDFPXM0FDv/DW26?=
 =?us-ascii?Q?xv6YfyfNfNVMbhYO5tIniwzVD7qMj3/S31fpKdIkbo7mO90/Msoe5abl3TPG?=
 =?us-ascii?Q?Ctk6BUxcZt6bNqp0GU6P3e7PNw1fBfGZLDi5cBp/McMnxzv6Vo7zJysNIrJ5?=
 =?us-ascii?Q?exMIX5snAOmv7LEECmiYZaCMKY23TKfApRKPUmQax4kD0ZAR98Sa6Fa/mhXz?=
 =?us-ascii?Q?Y9GL8NS14akQhpfLoxmodUs3bVsnyI1KE4aQBDabvTxVVuc6oeq/Bt9Ipjtc?=
 =?us-ascii?Q?nMQd5Gkfbc6TrvRfGsEObdhhTEikOjmPVyW3hsOwa3jQEqEiBfs09hEHCgsB?=
 =?us-ascii?Q?WQxD4fkGiBFbM9kfyiYCC8YjjY1LH8PrU1SaD34EAsmvnYBzAgSuos2QT1lH?=
 =?us-ascii?Q?s8KOgr1+WDGcFpJqomc8lmCKBLBCAItmZ0ME0HgL/feTkO03uH6s5DoYlyEw?=
 =?us-ascii?Q?svqaYiCWBQkA1rPfHxUVhXGeITY2Z4pRCS3GnNH2z+BQKzGrL9YbNI5IaSdK?=
 =?us-ascii?Q?RVWjT+wZdyqhOxhe3BOks7iN7lha2l3KCJAFVzFuPaR8CFZmf9sUQUeEDd4s?=
 =?us-ascii?Q?qDV9L7I4IcOUs2g3XwqMhMxu6WTCs65d9dPvsRYKO8C+4zuRC5D0YJCEa5RT?=
 =?us-ascii?Q?gzmdh3fp/Stntzd9ZtTGP560Hc5guOOol5jxJRMP70Q5ez2FuOrzIRGMumEP?=
 =?us-ascii?Q?gE9Q/mzsXHP0ktYGLMXy5UwSTUF5Fxj4lGbqMUyuR+SCJderRoEs/wUjsCha?=
 =?us-ascii?Q?G1xaNzJLGeigRFCb9z/FZgQV5+jybKm/zJ2hG4dd6gtgowjNhkY2Fjbmv/hi?=
 =?us-ascii?Q?lCIwzdKSvUwdBUxIOO6c0xXX6JkpSTAPRlmeMu5wtb7jk6H1LF3CCpA2tCj6?=
 =?us-ascii?Q?naQQJYWlvNwq0HyOj1OxgtYK9L3zQd853tM6hhXZMXb0N7sPMNna2pDGcgHb?=
 =?us-ascii?Q?nFd5VwXwOIaQEVVSzzH4TcR0LrhfTK8U3SfRpK3RSuSn/fdVjCY7aHbsGx4s?=
 =?us-ascii?Q?sn0epbfDa56RJTFR2FDTNH7AmbCwtULXquQqAP6M7CEveBvCps3LmvXzPZyG?=
 =?us-ascii?Q?Sh2QEqdtjPaWxymGbFlw6JN2tiN23QjgWajDldgG3aEs5NYUwBF1i1UArjz2?=
 =?us-ascii?Q?6Vi9oJSeZgQ6kR6iO9xy1WAs/dOLxhvz9aEny3kK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deac49b-c72b-4a27-b9a1-08dce74ba6ec
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 03:45:29.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSiTu+GNhn9vwQicu908RVFr4yKYw/bJSI63m08urvKxngd3dM6lRBTE3f8mfIdQBoZrKHFdU+Egw9jVNp/RlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7985

On Fri, Sep 20, 2024 at 05:04:19PM -0700, Pengfei Li wrote:
> On Thu, Aug 29, 2024 at 10:07:05AM +0300, Abel Vesa wrote:
> > On 24-06-27 16:24:24, Pengfei Li wrote:
> > > 'IMX93_CLK_END' macro was previously defined in imx93-clock.h to
> > > indicate the number of clocks, but it is not part of the ABI, so
> > > it should be moved to clk driver.
> > > 
> > 
> > Right, why?
> > 
> > All other providers have been using the _CLK_END from the bindings
> > header. What is so special about this ? AFAICT, nothing.
> > 
> > > ---
> > > Change for v2:
> > > - Use pre-processor define to simplify code.
> > > - link to v1: https://lore.kernel.org/all/20240625175147.94985-1-pengfei.li_1@nxp.com/
> > > 
> > > Pengfei Li (2):
> > >   clk: imx93: Move IMX93_CLK_END macro to clk driver
> > >   dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition
> > > 
> > >  drivers/clk/imx/clk-imx93.c             | 2 ++
> > >  include/dt-bindings/clock/imx93-clock.h | 1 -
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 
> Hi Abel,
> 
> This is a modification based on previous comments: https://lore.kernel.org/all/20240604150447.GA604729-robh@kernel.org/
> Actually, whether this _CLK_END macro change is added or not, both is ok for me.
> I just want to add some new clocks to bindings header.
> 
> BR,
> Pengfei Li
> 

Hi Abel, you are the maintainer of clk-imx93.c, so if this patchset is ok,
could you help apply it. and then I will send subsequent patchset to add some new clocks.

BR,
Pengfei Li


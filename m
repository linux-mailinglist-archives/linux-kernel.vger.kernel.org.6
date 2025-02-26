Return-Path: <linux-kernel+bounces-532826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C31A452A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B4F1884006
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F8C19D07E;
	Wed, 26 Feb 2025 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h+rzmz8C"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15424212F98;
	Wed, 26 Feb 2025 02:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535460; cv=fail; b=XCxL1MzqnrFw1Eeo1QK40lh5ScyYv6JflG9r+nI5Lt7Det7dM8BIyPgv1DUB8+pngnS1yB04JNeIEfyKVZx96Q0TetM/+TB5NtnGOiqFTNVjdeJ5MSMYrzWlDV3jPpRkg5pdL8L+Otb3AT8Zb0ZLGCwaibpO7mYMbwwAj67/gZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535460; c=relaxed/simple;
	bh=d5KcNjPKIHm4zXg/8j89YbJgE34IRoIkUdSQwFC7Jw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AXzvKNT2CTONc6yK5qHPkeZR2geQhVk636ezivLC3ZD3OsqQ7SKw6OoBpfFeBO8weyyiwiBQkVfoliLIXxbAIj5ZsF3cSgyMABwkIkoA6sAzVeOtQJhusISzMC0k4nedOsPgaFIYEIRsITZ4L+kDZhh6xA8+9LUQxeH/FFqMMb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=h+rzmz8C; arc=fail smtp.client-ip=40.107.159.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0W2tokyjT8WacMnf7DSSY2zFCm07eewDCNpw+QIQWmprsmbfzrtjYb+LKW5DzXakmqg/OITUiE/uBxkU8rgHkwvMTJGMhxr7w/YBbZ1U/LKGPNCUkCP2oPOED5bYpKnlSec94F5+RUDdx2HF1z/nMIvniBxvJHSBsCpkiY1XgWmOyjdZP3kmDSOGDwowh97N3XBI1u5Vr1qjQwXnwcX4uIG07iZXoBnjj9x+uNBvnRh6kElvfkftbeQo+tCC0M6WVznY8BYK35rnY/BCFtKVQU4zd7TtpFmMN/3Q97TBfGFGB7w+5P9Q5YIRqTHmkiVp/qDrxIHXer+rtKIkJcqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5KcNjPKIHm4zXg/8j89YbJgE34IRoIkUdSQwFC7Jw8=;
 b=bTyAizqYHFaVcd+7VmSWjb8EQn17NFd7TLilYGWHF9ydi7bM4X3VzPkrXGg5QPylGIwmebI4eXXxx51dVAXCR4FO1PhUMGQN6zz1AAA6eozWiXaFmuPD8cAY1GH4gG161zjW9eW4L95dZPHY1qk7DkifPGFc5NUL9v1MMKA4Waa/uhrHbnA8IND/MH3ADZm/46kIkCQgScCAD35KDSRXyEk4x8ZwZFxG7ppIkEUG3p53V0vdzSKi1aJJwSd98VPBHK+lb/6Uwp4YPrtys8dDsF5AE38NqyS/7ShNP2bkMeZqjLDoqAeOG2KCtZadKha8w/FV7U2aznaeyx4ADGCoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5KcNjPKIHm4zXg/8j89YbJgE34IRoIkUdSQwFC7Jw8=;
 b=h+rzmz8Cub0aPpPd3+psAwxq2DZ7Lw+oOR454JIX+1gFj55J2pPqiWBgEA8IxB5Xjmpk1M0UYL/dBYIXI4EA+Rx8pRjxAOXPWCVuMKb/o84sN7jPKSuze/2PVnmBQ2kZFZ2Iums80juvwGRhkpSyGjDgHmPvkuQTbvn21kD7YwKPDUG8ykVcIvS9GLq5Fo8hWcs1vs6oIwyys7jW70mbfqZxr7/1xJ2kcfiX/VQBhyHNy8MVY4wTiTgrDDL2kltB+OAQxKBtk5JUYkT6suKSz7/x/OLN9Rybg2tRhv++3BJepnM7U2mSwTi5fJXjNigsXsTPsct+65JUaDRIK49Lrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10901.eurprd04.prod.outlook.com (2603:10a6:800:267::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 02:04:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Wed, 26 Feb 2025
 02:04:14 +0000
Date: Wed, 26 Feb 2025 11:11:26 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, Chuck Cannon <chuck.cannon@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 3/5] firmware: arm_scmi: imx: Add LMM and CPU
 documentation
Message-ID: <20250226031021.GA16342@nxa18884-linux>
References: <20250121-imx-lmm-cpu-v1-0-0eab7e073e4e@nxp.com>
 <20250121-imx-lmm-cpu-v1-3-0eab7e073e4e@nxp.com>
 <Z5DhM1VLv2uCCVwT@bogus>
 <PAXPR04MB8459D4C2CA3D5AE58B2B509788E02@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z72ZxspU3hfGZWez@bogus>
 <20250225124203.GA31590@nxa18884-linux>
 <Z72uLenEmCwDCV5c@bogus>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z72uLenEmCwDCV5c@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10901:EE_
X-MS-Office365-Filtering-Correlation-Id: e410313e-6978-4254-5097-08dd5609de2f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OmnoOmbuQ3fSa9Hh9pQIz8/gtFUvbvxOVD+Ixk3cN6sQCw/L+dDUO+UNzTaU?=
 =?us-ascii?Q?utAQE+vz5dq5NeCq2of3GjD/XpkEjbe5Iw6teQzEewKNDKcHwsKLcxDY8yL7?=
 =?us-ascii?Q?b/mDaew3TsTIfiAvxEmKLGxDIHaI4KOmeiDvIHXKL+EWiebu8ZyxGdc9txD6?=
 =?us-ascii?Q?gJlwguV77Hrycu/y+Fw1bU5Ce9jldk6IeR6rNqC9cBIWP6DBG4j1XISiGnSa?=
 =?us-ascii?Q?0V2+bs6DJAu5xqi+S5h4IYb0KdxtRygKw2nscyku1lvWiu/LCMhDUKv+6SIn?=
 =?us-ascii?Q?p17TNuXEGXdaaGCsiamCuSC94Z/pcBQ+ChUJh2gmLaPZWDGmB19BHPKDENbC?=
 =?us-ascii?Q?bTrciIemPUvcSkIhlaftnWC57mrMD0tKg2Bm/cfeKYy2hfxoWgESM7lAF4TK?=
 =?us-ascii?Q?3PMLV6jXzMfVEbKTFKpkdk+Gu6LyXTfUpqC/BZxmxG2BavCnl0Fo5tYokLyW?=
 =?us-ascii?Q?pLYB5A406XWoMBhvlt0wLbRx/wOHRcZRrsZevNKhjAOtqhzBx0uMyNlzwH8y?=
 =?us-ascii?Q?IehN55NK7uHhOmpdb/xZEETCLlECT+8rRdjqjV2RPrCuyw/Hq0xOzEYvKvo4?=
 =?us-ascii?Q?YHA4p6qwrIAsBTyuWlztxU+7ORP+DcVZPgl4Al7ld+iB44qKx9Yw7CnXZNYl?=
 =?us-ascii?Q?NBuCrutiNkhbHj3PiHRV5BWoR/ywtUPdnbx7gthC7U8Q0bTQrEeUeE3xy0Uv?=
 =?us-ascii?Q?sUoBKT/257NFoL0pmRfDEnDnwwoZXMYgLtGcix/lgUJHxQfK4RKh+eT94NeY?=
 =?us-ascii?Q?5ZkNx/yBT/mqz/PgFFApLS8ESvHufM9YLFB1jS54tqdgNCwgsZjGvBctsj3W?=
 =?us-ascii?Q?2puTYCQ2uocgPB4tWcXS5ZOxpCpF20e7gKtU9hBRZcarYZ7Cgzfyyg9iqQso?=
 =?us-ascii?Q?CuJ6fNvMciqeyEI6cRCNQz1mTkL0O7d4RVqXRQykkwje5nlPoCdKn90FRIvF?=
 =?us-ascii?Q?ZtGNgybPmCqGxdMPBn6K1A1OZEIb9r1SLGX1ALYjYJq/jmY7LweAU0hbktmu?=
 =?us-ascii?Q?4c2/XJqeaozyGXyw3YAW8OPUwxD0UO953GBcmg0daaulRtKFST6AuTIKT1eu?=
 =?us-ascii?Q?p+Tc4gpyfH4SnZGRMx15QiKOy9qEsxkYUryV04aEec7V4jRa5cKCZp+4wwv1?=
 =?us-ascii?Q?Jat/bp+lOaCvrDvofBJtCboYZVYs2K07QuZgPKYB6SBbSBy9zhswx0u1Yz0E?=
 =?us-ascii?Q?NZN9DoqwgfrFcs1GI7wuYgB1xl/KWTJ8irv/ab3MDbXrHu05sEfYRrXXTGXJ?=
 =?us-ascii?Q?kVFKocLmYCFCSOQ53bbIGsOY9/0k0S+ovAbq5AVaVO84gRsZqup6FsIZaNvI?=
 =?us-ascii?Q?B0xAexyP6F87o/tEw/JocpuJc9BrqPbETu/lk6b9U+pi1ZQuVSAlSWG22/PU?=
 =?us-ascii?Q?N2ZOrEf5ucGNhRo7/Q2pcY5uY1MOuFgmHDt+6r0Nah+EzmukW+fsrihbQCho?=
 =?us-ascii?Q?GQzRtWfoorvu3X6HTMdW37qjJq/VJuVwLtUSAP9Ew5S2YdYHwCb9QQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PNi6SzkP0CTvbUKpT+qXPbe1agipEHMKHXtihijnf9Ukd6g0G0AYL6VuADmq?=
 =?us-ascii?Q?B7CyRivLhq9PUW4biSmDjF4Kf+F9dqKwMyinJ0OffMnLUbpUBQ+VcTTL4qhF?=
 =?us-ascii?Q?xbwaMO6KTJMYYNcJssTfNj1qQvVuvtGiTtwVCBRWbtt1GJI1Tx49ZvdYnF0B?=
 =?us-ascii?Q?3et7hQbukAzIGuWnkj/kAp8Tnonwji0qPVI+RpjOxvF6++85mHtN0s/h0ujj?=
 =?us-ascii?Q?hKZ+otX5b93ci8CmOlmnrIjiVg/HnGHqGdYOflHSawl2avXoHYD5nPL9PkOQ?=
 =?us-ascii?Q?rAvN+l1M/dfqDn5GAD+czrYWDStonOgL0SkX1K8UUtwmPQeSaasPPoIpSeWA?=
 =?us-ascii?Q?3lSeL472qBY9pyUo7l1z8f/dvVdBoGMyTAURNg6ATKlOy85Ty52TMkTJ+iia?=
 =?us-ascii?Q?JtJ+qNKm6ZgBf24k+gmvNmsy7fR43X19+3YhedySlN16iY2KFR1ESFkXJprn?=
 =?us-ascii?Q?7A85e8JSfIr6d3eh30Iwi53qARwzNIa4Sq1JrfzkR/rhs60jxQnAXZaotnBU?=
 =?us-ascii?Q?lTGPYBCNDXwyzUgq2AyAT3SL+ooSN4Ytk8+ERFMlyY8EVvLAxWcIANstP+uE?=
 =?us-ascii?Q?nhmYyRPVhLZJkIrX+YzWHfk6Vji2jVXn3G3nTgavC1zulFs/pXC4IAI5gCjO?=
 =?us-ascii?Q?tbU3NmvjSxF9sc+zNX/4ySPeJbY8tRBFZpbElK3Dh+5fqr3Tuz8Q05rVbahT?=
 =?us-ascii?Q?3hOAYXRT7VKeRH25XDhXVlRhf2mMXlwSCqQUrXyFCmj5erAjlAUsTFqD9e02?=
 =?us-ascii?Q?ERuPQLZL9fKiMxikrOpuTSmBNWdFPGFWaAEdpgJgJedFJD5f/CsdoL3dYtOn?=
 =?us-ascii?Q?vaKWbGiUYTvSM75Qlvdbfok7d/iu+N8k2+mXOjyuJ4jGC8VqHEYkiFyZPzP/?=
 =?us-ascii?Q?F/8TuliT8WocmmG4mKaet10JQYH4jgUblqky79LNomoX+zLVDeOMeOJjZT0c?=
 =?us-ascii?Q?Vz2lpfT6gAJQnjrC5iw0u8w9oVq/amkgOlD7p6MT0fS7ay6Y/VeBEB7ykLXz?=
 =?us-ascii?Q?baDsBzgzqGhVNOBValyPo+hAe/furBKMh05AOLNOvQPVQQEHEjMfnUzjww/9?=
 =?us-ascii?Q?T9rU/Ni2J+mOFpQNZVL2njrUbxgyX3BzgMkdXP+QJ4PfEzPaOdYVPWqUu/q7?=
 =?us-ascii?Q?+rrJaw2q0m9KeqoTkGi0xgmP3P9l4MdFT3uGtPGGVE+yQT28xAYcAtC4TyLA?=
 =?us-ascii?Q?FM2lddfLsYBGsZ5Q8lwp8JXdEjkOcXbbLH9aLyRc7vi1gdPtP2lIFVuBemY6?=
 =?us-ascii?Q?sUuRnjq9cJVHtdIIvOZNC1LAz/oM85rZUsJPltDdwkpgRhGPHKFYm/rcDajb?=
 =?us-ascii?Q?lL65hTsvW5004NNq/nXeqF0j2ktg8gZwl6VUIzWi6otHPK5PzM5p2oerbhEK?=
 =?us-ascii?Q?WTxQ8mqDxfwrUfm7jy1tqzhLPh8FwMhmMgNo1IQV6ubzEZDFhPsUOOaGIKf4?=
 =?us-ascii?Q?bHWPm7wQrsu7H/FYOvAmjFYXdTTLnkmMy+so/rdlSq0N3/LrBHDaUHE/tatR?=
 =?us-ascii?Q?SeMWzPhcsLnosj9jyL834wJ5yVNkkTM98uFbBzou83OyoDyi8w5x0453986N?=
 =?us-ascii?Q?yKw+EcCNLtxzqQce/FqpNXCfR4UWO0InL9MzW2D/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e410313e-6978-4254-5097-08dd5609de2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 02:04:14.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q93iJ7etbhyPU3SBkrxa3uzVL3e9WUMVv4wVw9PXryCTrgULD9eWf+aSrarBrvp6MHQtOrriMVdYPCFGI4/qnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10901

On Tue, Feb 25, 2025 at 11:49:01AM +0000, Sudeep Holla wrote:
>On Tue, Feb 25, 2025 at 08:42:03PM +0800, Peng Fan wrote:
>> On Tue, Feb 25, 2025 at 10:21:58AM +0000, Sudeep Holla wrote:
>> >On Thu, Jan 23, 2025 at 01:30:43AM +0000, Peng Fan wrote:
>> >>
>> >> This is to manage the M7 core by Linux. I just put more documentation here.
>> >> CPU protocol is also used by ATF to manage AP cores.
>> >>
>> >
>> >Good
>> >
>> >> > Also what other CPUs are we talking here.
>> >>
>> >> M7 core
>> >>
>> >
>> >Are they referred by any other name in the system ? I reason I ask is using
>> >plain "CPU" is too generic and confusing. At the same time using "M7" may be
>> >too specific. I am trying to see if there is any middle ground.
>>
>> "CPU", if you mean the protocol name SCMI_CPU, there is no good choices.
>> I could add a note that "CPU indicates the various cores of i.MX SoC,
>> one CPU represents one core"
>>
>
>Just a wild suggestion, you don't have to take this. Can it be called
>SM CPU or something ? If you can't change the firmware documents which
>is understandable, I suggest we call it sm_cpu or something appended before
>cpu to distinguish it from the AP CPUs on which Linux runs.

ok. Let me try this in v3 and see how it looks like.

>
>> The documentation origin from https://github.com/nxp-imx/imx-sm
>> hard for me to drive a change to use other name.
>>
>> Anyway if you have ideas, I could bring to our firmware owner.
>>
>> >
>> >> In general I would like to
>> >> > explore the possibility of collapsing this with LM protocol. CPUs within
>> >> > LM is LM's responsibility to bring up. And CPU can be seen as an LM for
>> >> > sake of this vendor protocol. I am not get into details here yet before I
>> >> > can understand what these CPUs are really in the system and why we
>> >> > need this.
>> >>
>> >> Our system supports M7 and A55 in one LM, so A55 use CPU protocol to
>> >> manage M7. When M7 and A55 in different LM, use LM protocol to
>> >> manage M7 LM.
>> >>
>> >
>> >The LM(assuming Logical Module/Machine) is an abstract construct, it should
>> >apply to even subset of components within an LM. Just wondering what are
>> >specific reasons do you think applying LM protocol you have on those M7
>> >CPUs alone in A55+M7 LM would not fit well.
>>
>> We have internal mail "NXP-ARM SCMI OEM extension" between NXP-ARM that I
>> could not post here. In that mail, LM is explained.
>>
>
>Fair enough. Please don't share any info that can't be. I understand.
>
>> It is the LM protocol design that it only applies to the whole LM.
>> If the LM has A55+M7, A55+M7 will both be handled.
>> If the LM only has A55, A55 only be handled.
>> If the LM only has M7, M7 only be handled.
>>
>> When M7 + A55 in one LM, using LM protocol to handle M7 will make A55 not
>> work properly. The current linux usecase is remoteproc, that means
>> stop M7 will make A55 also stop. So need use CPU protocol here.
>>
>> When M7 and A55 in separate LM, using LM protocol to handle M7 LM works well.
>> The usecase is still remoteproc. In separate LM, A55 CPU protocol will be
>> blocked to handle M7 CPU per firmware security.
>>
>
>Thanks, I am now clear on LM has A55+M7 and M7 only. However your above
>statement relating to LMs with A55 only is not clear. If they run Linux,
>they just need to still use PSCI and this CPU protocol shouldn't be used
>to control them. Can you clarify on that ?

yes. For A55 only case, the PSCI should be used, and ATF will use CPU
protocol to manage A55 cores when needed.

>
>Other than that, it looks like we do need both LM and CPU. Just asking
>all the details so that if in future we have a similar need that needs to
>be a standard protocol, it would help us better.

Appreciate on help reviewing. Not sure you have time on V2 patchset[1].
I plan to send out V3 early next week(should be before RC5) with your new
comments in V1 and Cristian's comments in V2 addressed. Please let me know
if you have any conern.

[1]https://lore.kernel.org/all/20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com/

Thanks,
Peng
>
>--
>Regards,
>Sudeep


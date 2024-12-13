Return-Path: <linux-kernel+bounces-444211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9429F02E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A86316A87B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CFF1531C1;
	Fri, 13 Dec 2024 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yBMwHp6x"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3013C9A3;
	Fri, 13 Dec 2024 03:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734059155; cv=fail; b=Tj5mvtUPIsLJkTAVyEazdNYZ6JhaXIm6VcVP03KUE8+OpfiXnm0LzsMZh1VJEREIPf0PG+u0QHmL1NLQEle6C+DPgjt3tXvYLWk2GdmvBT64WPgbS6LqSbfntBA27WQi1cBux2+20oD7yexOhaaib4jeKx2rootaglpEAVQvnZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734059155; c=relaxed/simple;
	bh=OcDdcfFL3jIyL1vLbGFYOFHa/FOgXqzVU9JKOOrcPAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mcmQS0VHb2KU/QoWKlGWXbezdhYDPzbac2c8Etj7ztCgAmC+VQjav/GM5JfadnyIezoSlR3NR4Rt2zDyFRRWu2AFB8/y5VPuOgxtiYjzknufV65ZUPKbSQgaRfk++OisLni4l14YCXMI0epdX6yA0DMFvYmAp1KuSu1HFSeoBpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=yBMwHp6x; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F10jWmyMz+n8F1meatuf5uGMQlfENJkyXbuhUN3KbEsTZw7SeGlfbJgU2f0tIwFS46KTbOYhdyfnqvMNdmF6RyCNDoX1b7M+6efzFYtYcTt8Tkxvx5xoTWcUzg/2ygl7qEGXSh6M+grPP2GV2g++tRBvslqz3Hk2ZQs4+FWrfDF/plwbt4NX9Mwq4MwV/x525/4AhFusybHEkCFjBaY8uSPW8zK+PC8+3qa7ihiyoFeL1gLBjo9PIhAqZwerj6T3qJZCyPIn1JakjJp+2vLvz8XYffUe06g8FXuLHZ+2dRw33M5hXH/XCvSMyd9kqtObycf3tT6g1EhtCaD+iZ3daA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4+IHymAFG3fzlRz2VYk5n5TawhB5HXg0iTaFK1jZDQ=;
 b=VPihQve6Rg4jPPGiA1u45K8MxiZnmqdv8uM3s5Rg3QS9bOVAXyU3JizEmhmp2q4mS1syHAdAEP8Ki08qaGmYxDpxmBImW3MRLtuR3icp3yHTsKmov+MfROmbTxEGA6iw9ltxV5nWUubI6dq9Hp6KGrIDQ1uzCdH8xW133y6H7N/AKjdRaUxf5WT6CmGGb4Vk7CINQmJ+YdR4sq/dbm2FzkqhZC+7CjJfiaUX0isgds6bgMkjV36p8jtf3QwKtnk5gbylkwevtESx1GaEgarDjiXjDqrYrs5joRJ6pLIwKxB9XfDV7LRu87txIHPccKbFxnWfWGuXiaeLVwJsPpBkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4+IHymAFG3fzlRz2VYk5n5TawhB5HXg0iTaFK1jZDQ=;
 b=yBMwHp6xMosrGx9kfV3ajC9whNo0sumikJRIGNIYfEJ+c52IUqo3XnJEQEDTFyRRkyoohQd9By677uGlI/QRQ+0lNPLOGF4is2UfjvSvVfeACJwPxmUGK4B1zO2/Dgz2jfb7WyBJ5Cl0VKIOa9QEqqpIYdu36cccLtOSe+4HmIK9a/s2msZ+mksI/Gf1fHu53GXP/N1rec/4bDzlPu3/GdPsSYPOo8Uus+plPTZ8q3TyFQIYBfzG+KRX1Pr7p4DDlBXcqu2Xubrw7W27tS9Hz2DTZ6ey1OlEA5G1eqXb/3ITAh2P30bGgHNfwsJfJGkT/mG2PO82iV3rFdeZbmd6BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 03:05:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 03:05:49 +0000
Date: Fri, 13 Dec 2024 12:11:00 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] nvmem: imx-ocotp-ele: Support accessing controller
 for i.MX9
Message-ID: <20241213041100.GA6948@localhost.localdomain>
References: <20241212-imx-ocotp-v1-0-198bb0af86a0@nxp.com>
 <20241212-imx-ocotp-v1-2-198bb0af86a0@nxp.com>
 <Z1shTD5QLRXB1wAk@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1shTD5QLRXB1wAk@lizhi-Precision-Tower-5810>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebf3232-7db4-4eb0-f696-08dd1b230b88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KnjAtnaxZeW4tJZbKPxQn0rU49O8IPegiTc6OaZNWHJo6x1Adt7qOySMavK1?=
 =?us-ascii?Q?7ahkFnwNejGDXm6x54tu0dxm8onf81j5nhQDLGvNeqYd5gUrqgZ91Cs4wfrY?=
 =?us-ascii?Q?teLydiXaA893pHmYyDzIBl0U1Tfn/ODO9h+kg4Jq42x+1JrOJr3n3AOHy1d4?=
 =?us-ascii?Q?1tzW4DyZpOmt6bpk8apBOAdekOrrUPg+nSzVse/ll8w1lLggv2fkZkA1go+C?=
 =?us-ascii?Q?PgLzMeSR2d2Tbg3MT/9eK+WDv2IHJjOZqdLV6uC5nHY1jdokp7wHrTFainyV?=
 =?us-ascii?Q?j6ij/zWhXF7s/ON+lNp0xh/QMDT/DFk4gIjoROYapVHRcp+qL8WwMUbKuGHp?=
 =?us-ascii?Q?uD2N6Xd9E2Iys+GIwGSo5IIBh77aUn3R9Cn4jx0yfGp+xqTOrI+kT7NrmLvu?=
 =?us-ascii?Q?O6drKufJp2n5+K39/B7qpydUI95v2aJTa9D1VIhV44HFwoQYbWOiod6VHVe+?=
 =?us-ascii?Q?KIUn/ovWOJF6dcfHL1PNIPgElYodGbvirYb65aBvfCBBguQaWJW+q728cDN4?=
 =?us-ascii?Q?/FMKbn0rkbUWyDMbmHI/1nkQuHU3Ix009XFE+vFSIyeN3j1ppHqKEYTOjFI9?=
 =?us-ascii?Q?fx5FjGgA1GiCb0BIjMUNALdnrpy0X9SdX4rl24rLcgWiwkm17O8J01dqBe0t?=
 =?us-ascii?Q?nCAeIXj5mAAHWquOl6saNNtBjW4XSWgKbfwxpHiZ8Cyn366HsToGo7GtRRbL?=
 =?us-ascii?Q?YWJvNPicU/WVf54OcKba5YTkCNLohlqIxZw4X2Z9CHElsxQb6ZVjUBUX5oJ+?=
 =?us-ascii?Q?teLDKEnpTHb70C+WcyaO26agdegkQFDCp1DT6Vufahb/9MsEO/ksHXIkyFFH?=
 =?us-ascii?Q?6GDGw6VE0puRMTykzad3/auTtahcF3Ia3KBvSkhcLwy2fLMVNjHCEBg8aAcF?=
 =?us-ascii?Q?VKK0SrciJZZ0xf9WLYEpWlTfDRz3Glyz76NKLXJk34p0HwfBcgxxDjcXf5am?=
 =?us-ascii?Q?D2y6pZ/ifGyFHFVGv1pzQ9TbhPuNnxo3LPtrb9EPhTMsA59CjGT1XXm1cWgK?=
 =?us-ascii?Q?fS0HgGfAjrBaugukXWwva7zOWAZXyatQdkQ4zMUD8RQWUdPGbbBWT7BS1bEu?=
 =?us-ascii?Q?BtVQ5XbWrTv64UfWNYVzdoHRWCFLU/ZGnnIO7JAoMkJYxK638WK+YW8bz+3B?=
 =?us-ascii?Q?kHWf4LEw5YJf5hOJJfcvj0aasHhMoa18LRWlcA6/USLrMlH3P00XhR8mjKf0?=
 =?us-ascii?Q?+FQP5joA7XnK14LDt0HsITRKVUVzD0rqvIjo+3+zcK6TWdk/vMHS94TsVFGe?=
 =?us-ascii?Q?EjfHoGktKWW3BlrdTMmC+ae7LAWVWJpYDKzJd3M2i5I0JcvhVPhUYIKPaw8V?=
 =?us-ascii?Q?ndukOFgR/A78qdIQFd3/wsrYWhdbyuJhPIqgyIgQnT6aDd7MHBLO5rYBFYT5?=
 =?us-ascii?Q?uh4CtoewQIHI72U6PRLxdz2MUKzlCF18cEtVaxK+90yH6Nfeuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?grjXuLoVvuYGLe7pzjzxnQUcc4Df6/g7kZg0RBINNT7K7ZDUJoF7EQhqSvnG?=
 =?us-ascii?Q?vwl7swRk+/tbzJSIuL/MuGjgyxawlMZyLZQ8xj8d1ZuggYd+vHZTuULpEjs1?=
 =?us-ascii?Q?+MT/TLrCbt/V1nOTDR9qY0HMjrTMcAm5U6KD2ZSdHSmxeKLqbzAG6ItChduk?=
 =?us-ascii?Q?IUvDLMIFuXNHy+9Xr/DxBD0gn6UyusHaGDyso19J1JeXZSugUh8BfgOSIH/R?=
 =?us-ascii?Q?Z9myweA1qO3MjeNEbKrczxESEJ1uLq1OHHVeF6P7dxFTkMtQT3GijjPq+JNr?=
 =?us-ascii?Q?70jcS0L8p7osCEJbV4cn9tSPz/Qo8MGIcM5KeOFf+YM5ji3t9Jt5Zs2b4i5J?=
 =?us-ascii?Q?w3DBQfsdtXEewmsdexJBF8ze/FEZPkxj2B/s9v7P9lD2NAr9v/uv3dkHf1Wp?=
 =?us-ascii?Q?1BLWZe81t1LcEJ0YjI8nW0MvaeiyC4TsLNSn6oRSuv/6Vqy+IDXPp4R8+Hqr?=
 =?us-ascii?Q?/fMEHQfF3smUJACRFvsXaSmE1PGQKRpG0FXS/mbF6H5sH+K5ebSAsDD/7Qth?=
 =?us-ascii?Q?aD4kgJZJ9Mgr+jbOa5f6/mLh85yUeKF6Sf6TZPVC03Zk7yaSUina49A8lZcw?=
 =?us-ascii?Q?E7DDQamC4pSB3v3xz1PZqXw6saZT2KpNC/pMLHXS2ZM7jOew5KvXeBvJBMGp?=
 =?us-ascii?Q?DzY1zLUnk9QDaiNtUMu+cShuTPMVR5QXEMS/yOEAd8KNz/L8+xVAYsqrKeLl?=
 =?us-ascii?Q?QX9OcKlRKRiuLyylemC25BhxJnKWVZDOIJrtMKWrhrZ/FAtxIDNZo7CgNFz4?=
 =?us-ascii?Q?aOyKULBRpZe6+2Qo8JhsL9flwlu6iLxYMeE83cc1GPiIrACNh3fO24qXH3CX?=
 =?us-ascii?Q?0J5zf7C4CC6+Drd9s5cBICVpM6SfypTExAhyZsXmC51KIPLl9G8HwLOtjvEZ?=
 =?us-ascii?Q?cgdSjA2byaJM2AR8++7yuDE8tJnuGoZLmY7ByRJ45rspdLyzTTw2oGprRbhF?=
 =?us-ascii?Q?4uHJ4aMoRleDgw/4uE9stW3tfmMIi+Wd8Nro/LG7/WbUmSkSvUMXPO8alAT/?=
 =?us-ascii?Q?U2of32IeQ5aojRsYyRPY2TEiu3OSsFZiFRqTV9m89uaCDpPqIGh66CGz59E7?=
 =?us-ascii?Q?V1d16B5JhauWC3oeAiFudZWQe8PI363bOqSr9an1is5QgGW0R7TP4mPadxGE?=
 =?us-ascii?Q?awhYyFod2T3e9fgS1rYhtegYT+UMyGDtTRM7qpa5Y17YMb+KVcM7cgaSER+N?=
 =?us-ascii?Q?2IBq4nT+vOl7344QIQmW2Bicjix1kM9uue0FHQE2Kb1hYg85cjfN3MAjbUML?=
 =?us-ascii?Q?tbiIcJKycbWu5fwxcx8IrUcazEKlRk0UYY+7bk5pIT2vG8QcCOObQb/Gbmv0?=
 =?us-ascii?Q?jGD4MdZa0jGaMyjxxqzVYSleXiCMhx4tHEbF6gl6Pi6JIZGg5AoDxgZkAH/j?=
 =?us-ascii?Q?Y2TOPJzC2HA0XlzwZ3Hq07WJsabfUVecVtB531XuYe7UDTeIRTcWA6p0k7th?=
 =?us-ascii?Q?PXsGv7q98kYDLMHkBUnXl2oZRe7dy+S6AGesjKzVm/lsCW6b1q1nFtLxOHAW?=
 =?us-ascii?Q?H5EoagH4JaSVxbTBbY4xek4HGpSe1R8DY/uZ+SOLeU/Dv0ry2iY6BM72PJFR?=
 =?us-ascii?Q?UZ1lekGXBlmZQhHSpfibk5Hact+fS7RVHtcSJqSY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebf3232-7db4-4eb0-f696-08dd1b230b88
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 03:05:49.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhLnwOmFNIFSQreMJnToQA8fQLd0lwGS65CKEnUWIeWwPXLpGdIWSd5oi5N/2i4F5lmY/rOEF9pBGTmx148EDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775

On Thu, Dec 12, 2024 at 12:45:48PM -0500, Frank Li wrote:
>On Thu, Dec 12, 2024 at 04:24:42PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> i.MX9 OCOTP supports a specific peripheral or function being fused
>> which means disabled, so
>>  - Introduce ocotp_access_gates to be container of efuse gate info
>>  - Iterate each node under '/soc' to check accessing permission. If not
>>    allowed to be accessed, detach the node
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  drivers/nvmem/imx-ocotp-ele.c | 187 +++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 186 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
>> index ca6dd71d8a2e29888c6e556aaea116c1a967cb5f..542539b86efd2d38be2903c1d0ea72f918ff5b75 100644
>> --- a/drivers/nvmem/imx-ocotp-ele.c
>> +++ b/drivers/nvmem/imx-ocotp-ele.c
>> @@ -5,6 +5,8 @@
>>   * Copyright 2023 NXP
>>   */
>>
>> +#include <dt-bindings/nvmem/fsl,imx93-ocotp.h>
>> +#include <dt-bindings/nvmem/fsl,imx95-ocotp.h>
>>  #include <linux/device.h>
>>  #include <linux/io.h>
>>  #include <linux/module.h>
>> @@ -27,6 +29,7 @@ struct ocotp_map_entry {
>>  };
>>
>>  struct ocotp_devtype_data {
>> +	const struct ocotp_access_gates *access_gates;
>>  	u32 reg_off;
>>  	char *name;
>>  	u32 size;
>> @@ -36,11 +39,26 @@ struct ocotp_devtype_data {
>>  	struct ocotp_map_entry entry[];
>>  };
>>
>> +#define OCOTP_MAX_NUM_GATE_WORDS 4
>> +#define IMX93_OCOTP_NUM_GATES 17
>> +#define IMX95_OCOTP_NUM_GATES 36
>> +
>> +struct ocotp_access_gates {
>> +	u32 num_words;
>> +	u32 words[OCOTP_MAX_NUM_GATE_WORDS];
>> +	u32 num_gates;
>> +	struct access_gate {
>> +		u32 word;
>> +		u32 mask;
>> +	} gates[];
>> +};
>> +
>>  struct imx_ocotp_priv {
>>  	struct device *dev;
>>  	void __iomem *base;
>>  	struct nvmem_config config;
>>  	struct mutex lock;
>> +	u32 value[OCOTP_MAX_NUM_GATE_WORDS];
>>  	const struct ocotp_devtype_data *data;
>>  };
>>
>> @@ -131,6 +149,100 @@ static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
>>  	cell->read_post_process = imx_ocotp_cell_pp;
>>  }
>>
>> +static int imx_ele_ocotp_check_access(struct platform_device *pdev, u32 id)
>> +{
>> +	struct imx_ocotp_priv *priv = platform_get_drvdata(pdev);
>> +	const struct ocotp_access_gates *access_gates = priv->data->access_gates;
>> +	u32 word, mask;
>> +
>> +	if (id >= access_gates->num_gates) {
>> +		dev_err(&pdev->dev, "Index %d too large\n", id);
>> +		return -EACCES;
>> +	}
>> +
>> +	word = access_gates->gates[id].word;
>> +	mask = access_gates->gates[id].mask;
>> +
>> +	dev_dbg(&pdev->dev, "id:%d word:%d mask:0x%08x\n", id, word, mask);
>> +	/* true means not allow access */
>> +	if (priv->value[word] & mask)
>> +		return -EACCES;
>> +
>> +	return 0;
>> +}
>> +
>> +static int imx_ele_ocotp_grant_access(struct platform_device *pdev, struct device_node *parent)
>> +{
>> +	struct device_node *child;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	for_each_available_child_of_node(parent, child) {
>> +		struct of_phandle_iterator it;
>> +		int err;
>> +		u32 id;
>> +
>> +		of_for_each_phandle(&it, err, child, "access-controllers",
>> +				    "#access-controller-cells", 0) {
>> +			struct of_phandle_args provider_args;
>> +			struct device_node *provider = it.node;
>> +
>> +			if (err) {
>> +				dev_err(dev, "Unable to get access-controllers property for node %s\n, err: %d",
>> +					child->full_name, err);
>> +				of_node_put(provider);
>> +				return err;
>> +			}
>> +
>> +			/* Only support one cell */
>> +			if (of_phandle_iterator_args(&it, provider_args.args, 1) != 1) {
>> +				dev_err(dev, "wrong args count\n");
>> +				return -EINVAL;
>> +			}
>> +
>> +			id = provider_args.args[0];
>> +
>> +			dev_dbg(dev, "Checking node: %s gate: %d\n", child->full_name, id);
>> +
>> +			if (imx_ele_ocotp_check_access(pdev, id)) {
>> +				of_detach_node(child);
>> +				dev_err(dev, "%s: Not granted, device driver will not be probed\n",
>> +					child->full_name);
>> +			}
>> +		}
>> +
>> +		imx_ele_ocotp_grant_access(pdev, child);
>> +	}
>
>Does it mean ocopt driver have to probe before other driver probe?

Yes. devlink could make sure ocotp being probed before other drivers which
needs access control check.

Regards,
Peng.

>
>Frank
>


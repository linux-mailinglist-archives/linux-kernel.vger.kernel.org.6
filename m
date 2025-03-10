Return-Path: <linux-kernel+bounces-553616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835BFA58C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B194E168AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8A51D5ADB;
	Mon, 10 Mar 2025 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IoB4N6Am"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2066.outbound.protection.outlook.com [40.107.103.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68581C5D7F;
	Mon, 10 Mar 2025 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590551; cv=fail; b=W6BeTjqF5GIBmMj/58zDloepITnEQuOBpLhRMksMKSEc3ghpn7elAQW7zst1eUSdN3q9LIzuijKUUevh7drN5FWxdLd0nZXZJPmCgOTEASIUz4jXhfzNNiSA+BNE9Gg+ZxF5TxY0RtyyVgOJpoABc04A2bmNxNS7x9ssg9L4cqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590551; c=relaxed/simple;
	bh=I17veHMAkRHH04oZTcFJG4p+UvsnQVJk0+zL7wUO1rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YOf+dp2e3PPmEAu0uBcETHJFrDlf1Ntx25A5EmE7lH7kqG+1UaBv2L0L0yfGbkDHVBDSST7NOKre+c123uLtCLxUKmHAexBc0dIiVW+b/m66+QFQw5O+pkt6m33fBZvzDVVVf2J2PVYUMTvwRZ/qGExXr/WolJwMK9qek1GHI/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IoB4N6Am; arc=fail smtp.client-ip=40.107.103.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLHQZg70yPjdQytrHn7Q07R9IDk6XJ9Ble31aQy6ZJ+yJsz1cgTn1MedANFaxlKIjaHz2AoO6LjN341X+BFWCAYkvm1WNw1K2aYJ79+kArALTkAIo2ovaSeWVbxauzhlQy3WpDbxBX7UkzDVIFz+QRNqWrml+IyNStlyZMu5p1IDJfGsTujS95FyN4sCaRwwfj+HDYy0wNZ2qjTRx1+bTlCZ3UgTXd8utYYFTXltAAdsXhpL9jRKSjGb7kmSYXlv8ZpjG74jd/9EanDEynANm0tEA1Dr7+zYkYr8+l8MC2UeOceSIfs2J5rMbilrzEWcFzRmsnAlMMs4tdLFh+5VKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9aa3SVhaVcOh3KHNUXGj9lGOSerdEKbJc5HGVxhkSs=;
 b=xZsb5AoOD4lZJ3+B1amqe3h6/ioGQeGmJ7JKtPnP4j8sCct5DV0qkrrbwaGJWkNLVlKUtYA/U+MbuWNe/xlGn0Yd/JY+GNPzrmuEEFYZ8MqLdBfOfwcSQNAF6TWIec7JCYRBhKKAQ5cUX6bER94kWO6PFjUl2Ed5VG9DmbWFOdfIjH+Ha7Ga9M+jqowSA5OLtx8Ko1pp6Ygrp/6bxFVnFRsu77LHtBwAQtrk7oPgZEbL6QXxSCZAohfzoCqDwKooUPCMfM0ENl7+tg26QaEUPTUVKLoxr81h3cCLH2uojYpZA3ZAEWPafJE7iiI6jzbdHMBHXEL4bEK3bgaE7FIlMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9aa3SVhaVcOh3KHNUXGj9lGOSerdEKbJc5HGVxhkSs=;
 b=IoB4N6AmuO219u+4NHfkIhxVL22zsu6Y8mlAYv5HIETVNzMpyQ68OXttYkH9e+iGg5F1XScgK8IrCLuZAP7qwIGEzENCCeEdqK0flJqc7QjzDOwKL6BXzJsZVBkhSOSIblR/I+49wndB2zS8LaYqiz6/cJg52QQGMF0mkTosexf7l+OyrrQuQnD0YvdKPoRC+1mTSIK4FIGNvCsPFhJ5IRj8p5tFTBpKJ7T5xOJIL8fYyEFxGoYQJSfvbOpt/+70rM54jr+FvUdGJTWiiJPjmTckS0I6DxIrtN9u4PI228XOiCyfplocVcd/UfaPT1rM3VdK5nBFnKlviDn31CYoNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10080.eurprd04.prod.outlook.com (2603:10a6:150:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 07:09:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 07:09:02 +0000
Date: Mon, 10 Mar 2025 16:16:35 +0800
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
Message-ID: <20250310081635.GA16799@nxa18884-linux>
References: <20250205-clk-ssc-v2-0-fa73083caa92@nxp.com>
 <20250205-clk-ssc-v2-4-fa73083caa92@nxp.com>
 <Z6SqeNsAqbZM8nr1@pluto>
 <20250303041125.GC13236@nxa18884-linux>
 <Z8iKErarE0lHWxEy@pluto>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8iKErarE0lHWxEy@pluto>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10080:EE_
X-MS-Office365-Filtering-Correlation-Id: 859082c9-7c3b-4796-43b7-08dd5fa26fbb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LblzW5yJBAIL+/ukU7EFqUuT294LQ7U9axMHY8agc0i31Kr/ZnfIzftt1mwV?=
 =?us-ascii?Q?F64bxU0f9DLUdmi7gEniLqJ3yC1rNiSXg4250ed0Bu78Or26g/JYXl+KjbIX?=
 =?us-ascii?Q?wIARSmdLqI2JE/mBHx8B5Uar5FfhLj1+ybyRaFb9YafIYydD6/0bXahjcFh9?=
 =?us-ascii?Q?jZSKrAK2t5SCubyzsi7sgwxfSBaAY4Vg0g3iz5GLAOd50W+ZLA9Z5w3QA/9a?=
 =?us-ascii?Q?Z29hgyA3Cdqm1YN8WsXW3FpdtQknfF58o8BzxLRPMkc3RIj5uh3WG0pvJvjw?=
 =?us-ascii?Q?fAcq1pyU/hJ4DmjjdhyVA2Bq6JM4m6uJsqTkmB8w/nNWj+1P83fh+NKLpxBJ?=
 =?us-ascii?Q?LRFsDo1iKFUfnZzekJcAXL8Ex5QLsinO5KXQtQkc132rYnIYx4PtjyO0FPou?=
 =?us-ascii?Q?KBDYXCji9Oos+1tmkKtewMVFc72Y40E4h+pxSW17vtE6mpxHDoY6cMINQJaq?=
 =?us-ascii?Q?4dIaP3Benw3xmO62/Sn57ya1nKvPPu/h8Js24ajerB4zIDsw1N7kFipiDfD+?=
 =?us-ascii?Q?Mgmd25aN55HWz984wFnfSNx7mhHXqyrGh/3WNwIYDHWTkvqEaA983U914cYf?=
 =?us-ascii?Q?ld7KzeAhAI6ECJCBViPOSdytGDAyc9FUj287UjStP/DYakvIUlPNXvMNtnwP?=
 =?us-ascii?Q?X5BQb3W7FtfkxnX2zjvu1/uIxNjGqXUYowuF8W8arj15rwnvOFemVgoek/gl?=
 =?us-ascii?Q?jkG7XC0fWGijb9Pus/gpgpD6MC5XJoGUP6NElMKLxlm8VX5e9+fgUX6t5ths?=
 =?us-ascii?Q?2BqLM2SsAVzmRiRXip7O9Hx/ud+4Set0viWKbL7kPzx6I02xBq6FPizf/j31?=
 =?us-ascii?Q?+3UXW71vGkgvh70zWgpxT/S2kkjJIKDKQDg3CKQYsyMJcDfDhStbO1eWhlM8?=
 =?us-ascii?Q?mEhZmrUWhi8TEYGCM9TSHNmxUjNdIrt5nrdcvBmjhRBG0ut323CFr2l0EEc8?=
 =?us-ascii?Q?zL8rxzSSrnNWzgoKjMesQg6kXNQqRyTL4yhF1f017o6U5ysQeC7SSxvnNa3q?=
 =?us-ascii?Q?qzg7DBomlFreYWS6nKqtim9SqeT4PMucVwndLIwetq1qUOcKamsz86Y6erSy?=
 =?us-ascii?Q?s03Kqk9Pxq9HHP0TeSOiu4T9fgtqIskJPmBUiJU218EUln/Dihqbgl2/4e3l?=
 =?us-ascii?Q?OOpExHr7KYaj0Fkrsq9t/Vdy+IWJJ5ZNKdNKvUR59coOZ2jXaEUBZNHGtSb7?=
 =?us-ascii?Q?Ncccsu23OYQzzTxwNuA9ie1Y4hNzhuhHg8yHzkDpiG8y7nURhbFMzgtkQ1+U?=
 =?us-ascii?Q?5DrSgEevxE9uJdkYOH5gyVMU52/kArfdqFCC9WSDHWaHbWfxwfHx8fPYUsBj?=
 =?us-ascii?Q?pnFQWOmAC3saKNonO5OwrVkJWfkOD0I1P2ij5PfQta5zZUtx4LXloMb9wn8O?=
 =?us-ascii?Q?P9hw0lcsmuZgcauxwotPjH/9ulc1ISyExGo8Hy09zeHsnJ0zb1SHnEtja1ZB?=
 =?us-ascii?Q?YY/W9/3DeVudgilKrh8xfKQan/knrGVa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iZr8ApeDyLisZEQFvQL2tBSfhzJP8rkNRLVWaPOOGCgcKBZXDkwQLfhIwOFv?=
 =?us-ascii?Q?38flipgPnOH6J5yeU/cLP+mFn/kfQx7R+ub1AAouyZvIHcESilniI471+2gg?=
 =?us-ascii?Q?gka/gIdGHIDsF2zwJI3H+9EzdO0d+6EeyywTT8xKXFvUXmRqBQ0k0mEhFTO+?=
 =?us-ascii?Q?FHpoZoaoT3zt50NBX62y75YNqsBT+R0auXtrJL+Hn5wf/0MvM0PXzsSn3n+Y?=
 =?us-ascii?Q?Eo3a+6Uv1Hq9WH+Jf8hj/uuxeFdwmGUB3cK6US8zyDVL4M7VI+Ct6H/9gL3Z?=
 =?us-ascii?Q?2nnmT6cqiEKdcgGzQiYWfKISwMuwEACgneN6cd0Jok+JZpNHossKE7YaGuZz?=
 =?us-ascii?Q?QBQhah6fI+9RJHknv3weWzm0pMYpnVZZWrWYeDcxQs2Z9QKuOGOh68yXKvGB?=
 =?us-ascii?Q?4CO8Htlj0G5bKe1X81gJxB9uTvjF7hsmhEiR24DEVl6pcVgI35w2PIhhuWjN?=
 =?us-ascii?Q?FcZpYqPKAnKZtzXXBn07dlEq9zqtJuw62qJfcbx4XGO0MngriHkHZSAWgWze?=
 =?us-ascii?Q?wVEBx1tzgKJHeNLcB7ISOmEJCRmowjCjh6RVs9HX2BkS0yILU1OoH/3m3LBG?=
 =?us-ascii?Q?xNKY1gMhzRnIc5WXfCCIHaJyluj4fgBr8CQKW4RF5FcQo0r4IPnHCK3qPqPn?=
 =?us-ascii?Q?PGvOFbWJklAiQz80sg0uBR7zYMtflfSyJ4A3AUaS3GSXWQs3tVJVNKDQp3OW?=
 =?us-ascii?Q?d8XHc3nFxMvgkWJSHsDZ5gI3/81qdCx2etEOPDJu8ir3m7/plFrmmhRliuUX?=
 =?us-ascii?Q?kH3V/eCde37OqOyiORuL1sRiAfy1sr8q7opym7VUOQl/ReWGmKcIQD0cC8Q2?=
 =?us-ascii?Q?WkgzDzLXBkfxfADbm7tEP4zLCnakWZ6QK4Co5YlDxfhGSLQcRHata8mZb+rh?=
 =?us-ascii?Q?Vk4hze1RHs9HInIoxyDDD7Fpv6HC83SMDRh9CkE6AIauL7qAIAsAKamu0Dmg?=
 =?us-ascii?Q?txLT0Hce24gLP5BPcA5lo+vsoquOLp9u+V2GMekZxm4BOgbvcpp4hxpXZ/Mk?=
 =?us-ascii?Q?bOuJWICyAEAKPE4+KVXDXohQvk3GwfbkSNflOu4j0jRAk93rdq/QbxUFqX+x?=
 =?us-ascii?Q?8MCcqlARuxa9xUHo2YveOEJMTC8iJNN4H9W0mG2ececsOoBWdisMkUSrYfTN?=
 =?us-ascii?Q?NkWn9/da+l84AUEXsFlO3KSzkmBccvqGYsBh1zSMzBoRIDrc4BGRLbRwrDO7?=
 =?us-ascii?Q?IvQmBhBOre1x92gcVR3vImiPGU3GxOHXrv7hj6AjnxqLM1duRGwCnhEuojtX?=
 =?us-ascii?Q?yyLses+cQsrcYYL5cQr/vMhuy/Wk7VUri8fTRcvZY+DRDWTwKHWbUSJyZJ6/?=
 =?us-ascii?Q?Lp7fYOiceqP2wKYwL5oLp2BOS9zAIydvkTy6TLO78rcyNwG4ihshLOqXQJq2?=
 =?us-ascii?Q?3gTkP2EpwidNHQNuDrPvj3VEUM/UaJ+yoCj1CjsYpoV3559WoHPWQ1wlAotN?=
 =?us-ascii?Q?7BEmIBIKLZo5kb1m9acz/y2jeemX9fa1NqObLzjFL5LPzcbXVnjDEzwft3Li?=
 =?us-ascii?Q?GMT8nm4S8EiC/vbxXpGrGBpitpnZ3A+0shQhlk0cNFPJpoXnEPzrPMHzLet5?=
 =?us-ascii?Q?tfSMsOyoSoeNGySFXaWdptvIGbubpAak5wlIAt1s?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859082c9-7c3b-4796-43b7-08dd5fa26fbb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 07:09:02.3183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Os/1aQXTmksCicalR4WD2yDob+RMqQfakJY4ny+kzvKiuVnEa2wTUXuWqmyuJriScuhd5HWyHBWMzzSF6duY6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10080

On Wed, Mar 05, 2025 at 05:29:54PM +0000, Cristian Marussi wrote:
>On Mon, Mar 03, 2025 at 12:11:25PM +0800, Peng Fan wrote:
>> Hi Cristian,
>> 
>> On Thu, Feb 06, 2025 at 12:26:32PM +0000, Cristian Marussi wrote:
>> >On Wed, Feb 05, 2025 at 05:49:54PM +0800, Peng Fan (OSS) wrote:
>> >> From: Peng Fan <peng.fan@nxp.com>
>> >> 
>> >> Support Spread Spectrum with adding scmi_clk_set_spread_spectrum
>> >> 
>> >
>> >Hi,
>> >
>> >I forwarded ATG with our latest exchange on the possibility of using a
>> >standard OEM type instead of Vendor one if it is general enough....
>> 
>> Do you have any update?
>> 
>
>Yes I think you can go on with your original plan of using vendor OEM
>types: as of now we are not gonna standardize a new commmon SCMI type
>for Clock-SS, given there is really just one SCMI user of such clock
>features...maybe in the future if more users shows up...

Thanks for updating me. Back to how to add extensions in clk-scmi.c,
do you have any suggestions? I am thinking to provide vendor/sub-vendor
for clk-scmi.c and use vendor "NXP" sub-vedor "IMX" for spread spectrum.

Thanks,
Peng


>
>Thanks,
>Cristian


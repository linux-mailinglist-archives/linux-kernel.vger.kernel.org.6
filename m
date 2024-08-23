Return-Path: <linux-kernel+bounces-299452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1395D4C3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC04D1C21A36
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8B4190675;
	Fri, 23 Aug 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KxgbUg7y"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ABC18C32A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435864; cv=fail; b=EvK3ciIZhIdYg8MR3J1igftRgy4n+GqPqLB5rHt3wq7xlSzf02FaWc6XBKgASujIYUJ102xHxsooJdL/IIqrKWuUtFKQqSJKp7vgxJio8jl22CKv+69r96ugMXhYkvj4L/rSy9IJRhjrX8zgqgWGpD/uCLyUcYODd40AhXFjfx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435864; c=relaxed/simple;
	bh=D92hrD0PevcR/W6/fgYdi6C7ZRcIVFUHvkhYmAQJRq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qWiB26xbbcGcPQRbm87+UOUPJyHaTseu+IYwVKNLM44+YGCoO0uxIcuqFkEg4qg3/XKLDGv00rkiGpRmn5biUOVfX3GkT6E5/TrjNtHm7YKl27CZEfMB42QLcC+ppdAVbcRDUyokGMzWwg3VIvantYhTUBXhLUCYFMwIxuiav0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KxgbUg7y reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiSleAqNJs1ijpCIVHhAHAOr32JNModdd95C2+nXE5gYmHDcz6Motfc0zkKWgVA6Sc3gCtvtyBhZvM9fgmcwEygtUq3NWOaObgC0mO/22w8ov5k7h3QHVQqDyVrje5fcGEuiC7KYiETMf7IIUGPWL8RJCqkaBKAWJw+5ByPWEDLq26ql9/10kgy80wzxZBNFki5I3fyHLlJK6pp3D8gEfkcolWAXhzI2RVZ0JA0eWhtdN0B27BXjsY8kWc8Kjqo6acpCyaq7XtyGGI1Mj3IWeAa2H0eN3caAbq45olFBnGhAJirJVaO1dut3IvHNpYHgsJuCNBx+wM/UQGhaiowCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4/PvhBzlO+ugpjkP47kEDEkfDpb7beUYYo8SzwEMvA=;
 b=zRSwqvBrFIS4imqGTpqgCvlg4GAqw48x3v51W6k7pT/tqV1gqIk7iGNrQmAKvTAAsFI22WQGChOPitvBx4p2bf3Aotfu1lv/344ohI/jwl0yB0ibHK4iyDluIhKE7+P2DxpAAIKqVRCRxA1IIdvosqTbU9HkcUQn0NKHHcwl5o0NrTwGjAN4m4p+1Uio33529hzUe7gCRK+h6CZqPIXER3ofcHL9IKQTawir8HXdRAYD0lgSc0ViQJVJMDoH3PeR+GoZDFzKbRx+GjLQ3f3ktFHBQgYf9+bSsUX8C6zxz4G/45EIuZ2El+MDDpCcvRRZxR4oSajFGeAj5pdsH5KWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4/PvhBzlO+ugpjkP47kEDEkfDpb7beUYYo8SzwEMvA=;
 b=KxgbUg7y9AZdcqtbuJ9fPTEjwv/ALI2Y/4DZfjfl3ifrTFYzaO/K2skmYMW8OUp5wLiX80fFtfB7cScjGe/agzE3rmxMsIqDycT8hyaTdyV5v9Fr+BQpg6KbMhXbPf5obBA44MDATRSr/cw/zrmL2z8DCZDh3YH4B+9JaLT5XlKZT3ZM25Qz0TDWtj35hqcUYyEMIaGq/x5TdM6SxN4R0S056tnYeDHTQ0+l9ZpYAnT49QlTiVwMCJncEnOBWByzmMp9UdHK5KoOaKJajcw/B9asfLPxWQQWoIpViPuhbyEV+CT9Drx2FoiEX57vSQV8dxuK0PrwgN41DwCKU0Q4Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7852.eurprd04.prod.outlook.com (2603:10a6:10:1ee::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 17:57:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 17:57:39 +0000
Date: Fri, 23 Aug 2024 13:57:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Conor Culhane <conor.culhane@silvaco.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 02/11] i3c: master: Replace hard code 2 with macro
 I3C_ADDR_SLOT_BITS
Message-ID: <ZsjNi4RQ+GKxZpUH@lizhi-Precision-Tower-5810>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
 <20240819-i3c_fix-v3-2-7d69f7b0a05e@nxp.com>
 <20240823175502.3d518a69@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823175502.3d518a69@xps-13>
X-ClientProxiedBy: SJ0PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 708b994c-c134-4854-3270-08dcc39d13dc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?0yW3XWs/wn6jZpwuX/z82I79iMW9OFelNO8qdo65/WyM21LYGAs/mdF0aK?=
 =?iso-8859-1?Q?uiy2ib+tNh5X2/blzVAV0irDc3cBMQz4TdpXXfwX/TGkG/YlNX8nYHzOGY?=
 =?iso-8859-1?Q?G2ZSExJJnZd25xvG2EgWPWhbaTTlRQKOwEu748/9gtTWIcZWkTE0zFgma1?=
 =?iso-8859-1?Q?pcDDgAMTGrUbQ99+KVtM6EXmOHL8ugVzQmaXBlim/RS/VnHa05yHWflbNt?=
 =?iso-8859-1?Q?fdRByc82jyLWJHyr+4CjUh/trY3IdipTUEqMGLb5aX4AtNjT24bwUswick?=
 =?iso-8859-1?Q?HBWyf8PW1DKpRTICYXUGx6QF5Dq/PZnsf77SmfvP7tp+io9YvpOUE72are?=
 =?iso-8859-1?Q?cwcHRuYAuU49AX3p3JM1SxQ7GghKpipV+LmLOpwT8Lrxyr2tkWnB47eSJt?=
 =?iso-8859-1?Q?+Fw3FvYesaAUPQLiwQ1hU9CJT91DD3yxclz2L619z18YXkKBdaxGgJ+8TK?=
 =?iso-8859-1?Q?DqPCdavsFwabDkzhM1SF7vzFDbwHAiKXMnGEutpBP1sHK3lo4Qnm3bYy6D?=
 =?iso-8859-1?Q?vkdAcY/QD48nYZIyMIIJZGEua88Z3ShC0xarM03VpdklPj1YhyIkZwDVlB?=
 =?iso-8859-1?Q?BKv6ZBzC20CGqIFxoIe/U1X/0NjB/BDuSatPaoleODxB9+2ocz2twj7Iku?=
 =?iso-8859-1?Q?7C987iy2viVV12WM1XH2yJAQMwCjbFZs6wuZMDjY92npJpraN/SD2m1gem?=
 =?iso-8859-1?Q?2cIQnHYxLTwHeJbi6yjywuJVZEq1oZlu5gQgDEVCUnhdPLNk5dL5Koe6ER?=
 =?iso-8859-1?Q?Fv3L0iGaXFxvrVpJYTvagpO6qESgj3bVXHqr/G6VewH3eaibY5CUfryE1V?=
 =?iso-8859-1?Q?u8/+6zZNATS1qdbS/kG9XMTqPQzVSGEZuR1wb9JrnCsVkiNc8tqX2RVnaa?=
 =?iso-8859-1?Q?xhYBBfrvNsGdU7zCu76aFu0NrxU9KaRwspTx5Lv/9SRcdSjm7wt+lJg+V/?=
 =?iso-8859-1?Q?zyQUevpVkEm3acELzKZcVZZVmx1S6FpgzoxdWHsrNYn49FnlytoszVrN2K?=
 =?iso-8859-1?Q?pBn2SsNDaJcClqxnTwh1bXZ9FEKrjVH5Ip7/U8rRAvBh3tOrauYQNQ6vyt?=
 =?iso-8859-1?Q?2hQUsOVc5I3pxJIlW2try9phi1HAM6W87IMcraZWR//0Z2GUgMU/+hIM2A?=
 =?iso-8859-1?Q?rb0e/aamQTx34DM7g40zSnC+yMPJUFHipFdCJAVlA2cGm3/4bV5ynMpPCr?=
 =?iso-8859-1?Q?0iwHvASxyhai1rGhRQsaxjiT8MRnQxiOw4inHZBLQ1JkpA3KXuF/0X1dvx?=
 =?iso-8859-1?Q?IkuLDSTYI0wbKZ2Q4XMwCbB3BXxyvStx1agPe8tZMhwsRQgezNqfEiII1e?=
 =?iso-8859-1?Q?tKOZhK0H7nbbobCOCb0ZTEDgYEA5zVunbXw35R2XfdZxL3v5xoLPPMPQG4?=
 =?iso-8859-1?Q?z71eC6kSPPxqU0vnmEvZPPXWCyzfT7Z2zvaBpxl3gcSiN0lW2ROvHFTkaY?=
 =?iso-8859-1?Q?nQIt/DxbT7HSx7l4TQu2H9u6C2TVgZpjBzHE4w=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?IVrm/O+rW6wIMdPVf5YVowDBkJdpa0sqVmmNCusC8frlPInOvuPFlmFyDO?=
 =?iso-8859-1?Q?jy8cXSt3ATBZauvMMu0QNFWlBAcLZ+zjmLxjkiqkFZEpLyGds1aiGrbAIs?=
 =?iso-8859-1?Q?/mlDmIjIJZxuN6HlGrahXLAlPzpoTy9+ESFVP3JFysA77LmfhBH+A2Uv81?=
 =?iso-8859-1?Q?+ezdhvSPbHjrAAFO95NcL6VlPNZz3f6Q0NxcsBbt68fJlBQ4iAIvyR5bz7?=
 =?iso-8859-1?Q?wxmDA3nl3zfUcuK2hD1Hq+94keBsX2jBzTY5jmbJNzIdYKelHFEvskpOYo?=
 =?iso-8859-1?Q?NSr2quUbYCgYjpbNpJR0v0Waf2Ar6ZBJQBywUnH3VwZMgAHp5ICJLlFunI?=
 =?iso-8859-1?Q?VQy84K9UuiakCCyfpbh3m7WH/JFxSvWrvsh39sTjXnjk8YlsXTqGvv+WyF?=
 =?iso-8859-1?Q?Q7K8qh7+Ux8PVhZ6rWgGgCDgulW7UaqdY4NutV78qsJ5xO1mZCyh8DzFr1?=
 =?iso-8859-1?Q?Q9LqbEsNKl5rkmqcF2o6tP/kUM15LClJ/TVGZINdMEVujAD+BmSNjIlfO2?=
 =?iso-8859-1?Q?XE7ObDytIoJU79Y02oNQao+a5YWsF4QmjiN6c9z1TToLh7+JH3g+AH+Nz4?=
 =?iso-8859-1?Q?iS+tAIPbHOFrWl/I+jN8aRrmQGmIH4Zdz2lBVAbM7peGMIyn6qUlpF8mxn?=
 =?iso-8859-1?Q?X+h4zyBPX3O42JFDHd9mo/YOwPtBuJqRnsT/+Luuw/f+OSEyNVsJ87iIAc?=
 =?iso-8859-1?Q?fqUedQ1oaN07D4MwOL3Vsv4mickb2PSB1fo6QsGY/hq2bF8RS3H3QwLWQg?=
 =?iso-8859-1?Q?HMHmw6YH5xu2r6/BNFnhc9ad61s9uzhInyiHsddZG223cohhbOHXYBe8E4?=
 =?iso-8859-1?Q?4Z9CRwsK6et35BvZJQmel9dqdyMgcoHIKkZiCAscQt3D3ZAdo7KdIgG8pk?=
 =?iso-8859-1?Q?nDEJ5VflGLmzP1CZKFfMz+U/7Xa4QkZFy/n5OVdnVUPrtHCm8nSycchMks?=
 =?iso-8859-1?Q?dsxzsbAxjXmHU0H3uzbqM1CTd2Hzf5QIimXiEN3toQQdsS/cGxIzQD8/6h?=
 =?iso-8859-1?Q?/OGJ5d24EpRMs09HoBlZ3qrftv1BR/toXYry/0c/t4Namsd3aVP6cvXLRo?=
 =?iso-8859-1?Q?dq1ZHtxRjn+WAbaiw+yQrRLzEZ+q54SEg852a9GftNIhBjP6ptMIRVhNdu?=
 =?iso-8859-1?Q?adyVCAeDbytxmu1UAoBPfDIcxNjAItkDd3UmogoxhHS/X2coao1JodD1C8?=
 =?iso-8859-1?Q?RsYW6p38ylxB+Y+1+Jn/wAkR65fiPsJlrzqqdiAcU95cMLdd3lHcT60rrs?=
 =?iso-8859-1?Q?I5EtjlspSkfzcmI4Cj1vwaex3GqjzxADLrmw4+GhjdzVst/APYxWKxDrlq?=
 =?iso-8859-1?Q?FY1ywEV0xzu5f6P8OAqnGRZfZCNRrfVMLRvTIVtuXqP+iVbAgMR4AbFgGk?=
 =?iso-8859-1?Q?sOlfnOOwh/9aXTC6XBUl5BWjzVrC2BwygpCTL/HSVXz4J9IkIsFStiiTl+?=
 =?iso-8859-1?Q?TzxCNlJBM3kutZQ4n+mC6ZPULf+buu7H9EBstJHPi5nlVTTmOqwgYQ39Qn?=
 =?iso-8859-1?Q?AW2EZiLL7eE7XaplNUbddj/SBbD7cAMDTmyg/ojy20q94wv2PktxbwWFOD?=
 =?iso-8859-1?Q?/x4hb3QP/386BQp/6wnLmBJW8FjP5Jp+ClOJ5D+QP+v9Bm6eBgJX46kpsO?=
 =?iso-8859-1?Q?ZUR46DKIvwRou/LkV3RRYHERM5T7X/VNEx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708b994c-c134-4854-3270-08dcc39d13dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 17:57:39.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7yHewMaetaR9R5uRtCMd8jOFveC9Dy1uXowHUOJG7xWr8NMeG+6kmiJqAW6pOQgFTfMtnW3mSdcdvkPIjMyfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7852

On Fri, Aug 23, 2024 at 05:55:02PM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> Frank.Li@nxp.com wrote on Mon, 19 Aug 2024 12:01:56 -0400:
>
> > Replace the hardcoded value 2, which indicates 2 bits for I3C address
> > status, with the predefined macro I3C_ADDR_SLOT_BITS.
>
> I'm fine with the idea but I don't understand the macro name. You're
> talking about status bits and yet the macro is named addr_slot?
>

How about I3C_ADDR_SLOT_STATUS_BITS ?

> > Improve maintainability and extensibility of the code.
>
> Thanks,
> Miquèl


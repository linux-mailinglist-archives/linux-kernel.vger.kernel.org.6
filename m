Return-Path: <linux-kernel+bounces-536959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39022A48663
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757F616C3D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6B51DDA17;
	Thu, 27 Feb 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hHV785ds"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB91D5AD8;
	Thu, 27 Feb 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676286; cv=fail; b=NtAjux4jH+G6ofspC/rJKY8YxT20vCKMnE9e/ZTzByvILN6tUYJWmmsl/tI5Ch0u5Xyk48/BZUicNhwLTRVsDKO/kLYJOURqB7SoI3Hho+nq3E3FYPv4Q+YkSH7FNdOfOt24LpUtQoLVt8NvviVVJQYp84DBXQ5HStUYYrUn1L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676286; c=relaxed/simple;
	bh=5W7u1OMsMNNNo9pzkdoPf68btr/k/rlg2f++ZZVyHx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kYFLsvQH6CKBteMzByjZr4sJoIoIk17rmRiVc2ed5f2Ebfo0JXcEOe6gdW29lGhcHCxD/CkYOq47lMMUDWV2MdnBsgxSu07W9Hj6+7hJxg8MqvyCED+JHHCc5jIYTOElXvY4vQQnECbkB4kQBD2MaQk5Srqy3WP8UYXhkNJ30MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hHV785ds; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE6e2F976TqWS7FDRVPDpO1bB4L5ktsSsieCiPYrqfOE6dWTPogKLmA2UbrR56Q5XDw9Iw31y0gcHuswdVmKCpbAI4aACp5qtix2T+RcSYQQqbyktW0xTt3GPwMncon0I15QPkmbgpzPSoeu9ruf4i5/udO2bAoSLSusKfYF5RxC69q/hRUyQNQBODwpd/pHHBf5LqQRZC0R0Wl+DdEogLKiXBSbw+Bb2Y0YmsFQiHRuQgBurdOpeMQ8eQoD4SCe7Gwov2uXMiXiYQkou2nxPtcvrmuwqDH5U3xWDJdtSWcPwDMID7X9Ji5pl0adftIPb3nWh4gWwSLFzjsQ9m1dLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuOWlL4EMxgz1nQt6/z20SRZ7a2yrMqcJrKeuM/GxF0=;
 b=pU/+AAZdlAm+/jeWAlPXZLMrYWgGOYE1S6Zeok0QFk157RkB4+xMo6EPVjPCkJjrmoIfuzU9pOrjIsW53Vj7+XWfm9B9UJifwNPbwlL4xnOkEHgfFVYT+ynRp9syMlK6Gk9U52COndqiQblaGwk8G32Ka9l/TkkMIB6OwthWGF5mrGf1zej3/Hd7FzLi6NI+9TtfBuRH3QreF2Wub4XNU1sRXh7WW1/gCrLsZBos/vzH+pXT5TXmhUGmCBz3uESVSTNB1S2zBjm3jS9JLuimF9otLlpPiL3hPYsBg131NMI2IU0mHxFrlHXmNCLp3jconjet5SW8yc1an5ZTzZp7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuOWlL4EMxgz1nQt6/z20SRZ7a2yrMqcJrKeuM/GxF0=;
 b=hHV785dsMD4oyUPiZtma3m0+sef5IlMAyUQp5GBjl+9Sd7GxYmtRYaHGudFRw1w+cFQMwyFgLRvyBU3HMBVCnCBiPmlKg8edr8L+4y4ZGGWoU+PmJGyag/AzeOZOk5t9b4c0j0xZ20cRF0gJHvvqCwbMgIC8USYNDATL7tICzh74lh56J3/1sE4uRvBp+l2mMOkxCWqNYF60FgiWFUd2IsGGotpMc8hIMeFU2Hiw2TB3tkuaEj43txjy9vXyF7DFIcF5Pvk8lPaJ94ngL0ij3N3KMF5VpiY9hi2mdCG8OOglN6uZBJ39XtxTJOv24UJ0Z7PBLJRQpccIT0UwRONTDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9442.eurprd04.prod.outlook.com (2603:10a6:10:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 17:11:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 17:11:20 +0000
Date: Thu, 27 Feb 2025 12:11:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v5 2/5] i3c: master: svc: Add support for Nuvoton npcm845
 i3c
Message-ID: <Z8CcseC8bLefDVG6@lizhi-Precision-Tower-5810>
References: <20250227060131.2206860-1-yschu@nuvoton.com>
 <20250227060131.2206860-3-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227060131.2206860-3-yschu@nuvoton.com>
X-ClientProxiedBy: BYAPR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:a03:54::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: ec085cbc-8d9e-443b-a152-08dd5751c183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Skz6VWmsuTLAYcCHZ2Ke/ch9g/veY/j/KDEHTDma89Q0eT3YdUdTsFFyJnxa?=
 =?us-ascii?Q?5XU3c4y6TDhQQ9oHzBVHxHl6iGIC9bqXER31iY2f8ujIj/i2hS62Fkr5mR+K?=
 =?us-ascii?Q?Ro52gkZrLzFQw7YKUz6dSuI8ielShQ1doixwT9YKD+k67ebZZwYON1yym2Jg?=
 =?us-ascii?Q?6nxngbs903IWqwxGcXzO/yOPZ9pYoj2ODGpHl0x50upWj1P3u5zpb/4lniFy?=
 =?us-ascii?Q?2ICi0EG+x0GicXFNmuXgQDvnPOJiDFKzO8Iyk7av21MxUenoWYSRRuJfHmHR?=
 =?us-ascii?Q?4BCL+Fj64hmltQ1XOtuSbY8D/VKmmW9VtSnTtmU7iRH2Hw+O40wt586XWz9E?=
 =?us-ascii?Q?cZ0A5Hzp+tIQn99Q8OKJ4Ity+mShihXxLwXFzdkFh/X1Wx9awqYmXaolPoe5?=
 =?us-ascii?Q?uCnyCkWudJTVg55bYh37/rmfupD5b3gCMMJv4QuxTNlJ/9YXIBA3A6b1V+l1?=
 =?us-ascii?Q?Bfmp7HwCH7ez/o0vcb1JxMrDs+0lLDXC/oFhFb5Pi0HBgKaFl6SgbgdOa8/W?=
 =?us-ascii?Q?xkA7B2XZhPpPxJ8hIWsEnTnD252r/L+31H/en65s9KvBqQMurcLpaSlvZzSt?=
 =?us-ascii?Q?duQ7Wjc3tslLZBu4EkTRFenau7ryKLJPM6yZFu8jO5YQ1tIegceMZ6JORxeb?=
 =?us-ascii?Q?JsgjjE29w9TfSGKjdeArcEWwA558Sm1wEzHPCPmJOECJKvnMqyzB1y30v9UE?=
 =?us-ascii?Q?HKmaIDCC+Wh/8eMVehKLXngSPuVFMruXWNSDtRyTSZT9j8iNJspNW1fwS7aG?=
 =?us-ascii?Q?RWg+V0vwX6UPSHA9vR+D/M5EWQoezlmCP/SpZ9BbDQIXHrrotzmj4w8wPMQC?=
 =?us-ascii?Q?R0m5oE9VStQAeYU8vknEMGsqIPPR8P2fyKIrV5hpJcuoTjrcxBANqhBj3SNv?=
 =?us-ascii?Q?nBWZuHLUpHDFXjAbCtP0u8hYygMCu07Tb1uYLvbJb1Cynj/8p2E2DjcGGSue?=
 =?us-ascii?Q?qbK57UAoKfkAMhi+ZOw7Ip6FYh4Z7wKja2F4BEMfTksELgn//fypZU4VugCf?=
 =?us-ascii?Q?vgfzgqJimBB4+7FdVWt1r234c0Z/9pqeXirl+baXTEzuWlgwVPdFAaJST0zi?=
 =?us-ascii?Q?BjWdebkC3y8Kh0GQ0rZnhKpyXnMNXGQrW7Dhdlv2qqsADsc/5Xe67GDCZWIE?=
 =?us-ascii?Q?fI+tUGm7LlTzbrhjvgGnPojTnKkZ+aXrVGF9eChdTKuCDtAZJVFmMmUSbQEs?=
 =?us-ascii?Q?iIUqfHGdrDiITXn6V0MpKLlM2smMwqufgQM41Rp2HFaRCm5tl9jwCK+iEvaz?=
 =?us-ascii?Q?vC0Zs6m1LCQVJbu9kLqb4940y6no+yCZWFZ6DNvOLfGoS+kZjdKfs8gtwqNN?=
 =?us-ascii?Q?0egr8DaR0Qmkj7HOM/jfCZ9SxR+EXNp3ZhoWJ6a7MYQ43m6B9NS/pVgHUKds?=
 =?us-ascii?Q?TV+lAajlIhA4Rc6giZW9OocriBXwdJ2H3/Gt/0InYxvBA3FI5aGWfzsiN8P5?=
 =?us-ascii?Q?UxTEq5XSTtB0Y7rdd/Gx8ps+rWmDTKYh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQnqdH3+WwEFhzQhfwPjcwKm3W6iS2nIFilZYXcSf/u/Wxj3LJ2LxWrkgC6X?=
 =?us-ascii?Q?aB+7ZxwToG4doMwPP2ij8IIyAbDDtDUGjaITAHugwwdi6fyG9pQK3Ni9Sn5O?=
 =?us-ascii?Q?DTYcYmRuD2Dvxn7TwTL0k82dGAr+wtxT/IIIY8b+N3Ai/JB2AcBljhE7NQAf?=
 =?us-ascii?Q?HDwZZlhJbOO3ALDed7tJnqjmNG2FzqH8TFL9HFWL+CpfRIIPI1CTdhEPlvTh?=
 =?us-ascii?Q?FrUVQE3YyVZqNTWapWMVdB4jAwAFp+zw3bBR2kiKzR+Be7uwMHqk4iUTXVdA?=
 =?us-ascii?Q?LwPv5H+RaUMuPHr2NFFnozRyvZzA7WgyK7ymZS0FF7TYVrhdg1pgzdah3VQ9?=
 =?us-ascii?Q?sH7lCq2NCcIWmTpzvysfzAvO8kHprRMbHhWouzSAO/j9eebqeK4A/epLWj+A?=
 =?us-ascii?Q?7Gw+JOQodjumLDcrQuNCCTJh9pha2EEEY2ZaSPPNqbc/CWLMfGENFJETdx4t?=
 =?us-ascii?Q?TfwFM1CShzV1jNZn5pf2Zi3zvMGhD0/atRKDaKaggseQzGf76+GLb5i/0MZM?=
 =?us-ascii?Q?XQiw7Ftmtiq/QhnHyhan5lsCqt/QDZDLo8mRo7xaZlM98pwnEgmA3S3aE+lA?=
 =?us-ascii?Q?1RwxLEluCkxk4W3t7BhH85KFa6el63FlNcuAJnKW451FCY2kRPG7SpQ/n9Pw?=
 =?us-ascii?Q?uxRRXoPDsQ+6C74yiYYXx0jmBwNYFVj4pbun4oxc40t4zMTXRYaMjQa7iC9+?=
 =?us-ascii?Q?5vsPQWA6lLDOgrOzE5hrbEuLanQg8ofyfQSQu69Huj4YmjUgnY1GIswHtMi6?=
 =?us-ascii?Q?oGTRNScXIVMp1RrOwEAnPt5kEiW5fzf/0eMQyTwEvRbHW7F3Lnj5YzZPkupy?=
 =?us-ascii?Q?3OY5YZaJscdePquyTEAbS1lR6n4LEh9kzMKuZizXx6kAgxXtfvkuSJnFB85s?=
 =?us-ascii?Q?CnBTPEGWcsklBTgnlJg3N4iHdg40kgEraLxbU0KckzFfNLP6iBM5d1CCa+Mx?=
 =?us-ascii?Q?TLuqX7wmXk2V3GjHGjzyU8O4lNBTuQhEYz/fL57wZgzTSZlr4nVVz3w2vgHB?=
 =?us-ascii?Q?dBxeLLnc4r1n6X7LKlbioFyAWgpzgxHMH/dMBne+a8pmXJOQtSjkVKzvR4qm?=
 =?us-ascii?Q?3bPR7b6kOcdti8mdGDR8joRhcOrCRW793ZGyp5s361XegkoXmszyaiq/F3ql?=
 =?us-ascii?Q?Kau77bJ7bLJ5csFZDzVAFDw0A0MRajr2cf6oV4a1ITH67v8MLLko67q94J/4?=
 =?us-ascii?Q?4RQOEvS6rUCklca8SAuppNSC9DkPibjtJVfmzC3E4YhMwsbYbSMCQl0fTjYu?=
 =?us-ascii?Q?BMxT3jIlGQQC8m+9prhGUBaSgDgbJntU+rRJcAmmtI8JbxstVs8TfdBycGBN?=
 =?us-ascii?Q?G8Rp8FtA84iVNiL8KNg1+dxevPuWKF2H2ZeD75aYI0+aS4wYLwA72tkpSNGL?=
 =?us-ascii?Q?NKzkcRXT7tsCbG19QD787l1EkroijSV5zFI7AgBp9wHg2e54OgaCqpjVIrAc?=
 =?us-ascii?Q?L8qLV/6emWcTeEZJQwWPqcLGx4haDAUahRmioJ9bbxhQHB6K95cEylGqvUfG?=
 =?us-ascii?Q?B/jeTkZaZ/YbNUJvrejZTcW5GO/8bVzchW1L/O4VZryTgkRBxBk920xMH4RK?=
 =?us-ascii?Q?oJYu5+hqFlKFj5XCV7+Lk+iGMVCqAnQlLuTUPnv9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec085cbc-8d9e-443b-a152-08dd5751c183
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 17:11:20.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th2s/yUd5GqM1kSGBmK4f/W76igjtZVOc2r1s/tR/MKaaABNYDZkHxdYM8vAm+GuGx3nMugPpqs8E1k1DroWKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9442

On Thu, Feb 27, 2025 at 02:01:28PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
> Add quirks to address the npcm845 specific issues.
>
> FIFO empty issue:
> I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> when new data is written to FIFO, I3C HW resumes the transfer but
> the first transmitted data bit may have the wrong value.
>
> Invalid SlvStart event:
> I3C HW may generate an invalid SlvStart event when emitting a STOP.
>
> DAA process corruption:
> When MCONFIG.SKEW=0 and MCONFIG.ODHPP=0, the ENTDAA transaction gets
> corrupted and results in a no repeated-start condition at the end of
> address assignment.
>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 56 ++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index d6057d8c7dec..9143a079de53 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -32,6 +32,7 @@
>  #define   SVC_I3C_MCONFIG_ODBAUD(x) FIELD_PREP(GENMASK(23, 16), (x))
>  #define   SVC_I3C_MCONFIG_ODHPP(x) FIELD_PREP(BIT(24), (x))
>  #define   SVC_I3C_MCONFIG_SKEW(x) FIELD_PREP(GENMASK(27, 25), (x))
> +#define   SVC_I3C_MCONFIG_SKEW_MASK GENMASK(27, 25)
>  #define   SVC_I3C_MCONFIG_I2CBAUD(x) FIELD_PREP(GENMASK(31, 28), (x))
>
>  #define SVC_I3C_MCTRL        0x084
> @@ -133,6 +134,32 @@
>  #define SVC_I3C_EVENT_IBI	GENMASK(7, 0)
>  #define SVC_I3C_EVENT_HOTJOIN	BIT(31)
>
> +/*
> + * SVC_I3C_QUIRK_FIFO_EMPTY:
> + * I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> + * when new data is written to FIFO, I3C HW resumes the transfer but
> + * the first transmitted data bit may have the wrong value.
> + * Workaround:
> + * Fill the FIFO in advance to prevent FIFO from becoming empty.
> + */
> +#define SVC_I3C_QUIRK_FIFO_EMPTY	BIT(0)
> +/*
> + * SVC_I3C_QUIRK_FLASE_SLVSTART:
> + * I3C HW may generate an invalid SlvStart event when emitting a STOP.
> + * If it is a true SlvStart, the MSTATUS state is SLVREQ.
> + */
> +#define SVC_I3C_QUIRK_FALSE_SLVSTART	BIT(1)
> +/*
> + * SVC_I3C_QUIRK_DAA_CORRUPT:
> + * When MCONFIG.SKEW=0 and MCONFIG.ODHPP=0, the ENTDAA transaction gets
> + * corrupted and results in a no repeated-start condition at the end of
> + * address assignment.
> + * Workaround:
> + * Set MCONFIG.SKEW to 1 before initiating the DAA process. After the DAA
> + * process is completed, return MCONFIG.SKEW to its previous value.
> + */
> +#define SVC_I3C_QUIRK_DAA_CORRUPT	BIT(2)
> +

Generally define QUIRK when it was real used. I suggest his patch just add
struct svc_i3c_drvdata {
	u32 quirks.
}
And svc_default_drvdata and svc_default_drvdata. commit message said

Add quirks for difference compatible string and pave the road to support
Nuvoton.

If alex think that define here is good, I am fine for this.

Frank

>  struct svc_i3c_cmd {
>  	u8 addr;
>  	bool rnw;
> @@ -158,6 +185,10 @@ struct svc_i3c_regs_save {
>  	u32 mdynaddr;
>  };
>
> +struct svc_i3c_drvdata {
> +	u32 quirks;
> +};
> +
>  /**
>   * struct svc_i3c_master - Silvaco I3C Master structure
>   * @base: I3C master controller
> @@ -183,6 +214,7 @@ struct svc_i3c_regs_save {
>   * @ibi.tbq_slot: To be queued IBI slot
>   * @ibi.lock: IBI lock
>   * @lock: Transfer lock, protect between IBI work thread and callbacks from master
> + * @drvdata: Driver data
>   * @enabled_events: Bit masks for enable events (IBI, HotJoin).
>   * @mctrl_config: Configuration value in SVC_I3C_MCTRL for setting speed back.
>   */
> @@ -214,6 +246,7 @@ struct svc_i3c_master {
>  		spinlock_t lock;
>  	} ibi;
>  	struct mutex lock;
> +	const struct svc_i3c_drvdata *drvdata;
>  	u32 enabled_events;
>  	u32 mctrl_config;
>  };
> @@ -230,6 +263,25 @@ struct svc_i3c_i2c_dev_data {
>  	struct i3c_generic_ibi_pool *ibi_pool;
>  };
>
> +const struct svc_i3c_drvdata svc_default_drvdata = {};
> +const struct svc_i3c_drvdata npcm845_drvdata = {
> +	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
> +		SVC_I3C_QUIRK_FALSE_SLVSTART |
> +		SVC_I3C_QUIRK_DAA_CORRUPT,
> +};
> +
> +static inline bool svc_has_quirk(struct svc_i3c_master *master, u32 quirk)
> +{
> +	return (master->drvdata->quirks & quirk);
> +}
> +
> +static inline bool svc_has_daa_corrupt(struct svc_i3c_master *master)
> +{
> +	return ((master->drvdata->quirks & SVC_I3C_QUIRK_DAA_CORRUPT) &&
> +		!(master->mctrl_config &
> +		(SVC_I3C_MCONFIG_SKEW_MASK | SVC_I3C_MCONFIG_ODHPP(1))));
> +}
> +
>  static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
>  {
>  	return !!(master->enabled_events & mask);
> @@ -1868,6 +1920,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	}
>
>  	platform_set_drvdata(pdev, master);
> +	master->drvdata = of_device_get_match_data(dev);
>
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, SVC_I3C_PM_TIMEOUT_MS);
>  	pm_runtime_use_autosuspend(&pdev->dev);
> @@ -1959,7 +2012,8 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
>  };
>
>  static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
> -	{ .compatible = "silvaco,i3c-master-v1"},
> +	{ .compatible = "silvaco,i3c-master-v1", .data = &svc_default_drvdata },
> +	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
> --
> 2.34.1
>


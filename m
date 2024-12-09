Return-Path: <linux-kernel+bounces-436661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C459E8926
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FC718865D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA8E3D3B3;
	Mon,  9 Dec 2024 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="UoB/Bi0J"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010044.outbound.protection.outlook.com [52.101.229.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33DFB66E;
	Mon,  9 Dec 2024 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733710765; cv=fail; b=u+X5uHMR59PzOmF9/aXbrPDDzl333d1mYTsuiJkGG2mMK753oRzyjrMlOTv0fEyOzlUfyV7/EfEyPostRYQdQ3nD2gqdJPZAM2LXsjO6BSEyMOlmuAipIx2ol47bd2e4Ea1KivKGw6YKJslQNOR1NcoAZbpn82npRforRNx+SMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733710765; c=relaxed/simple;
	bh=2MfQ8sUEiM8lrWCrgJT69cIfF9E1J4+a79tYedi7yqY=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PKfjxU23cKw+FRT3PXlp/VMBIA4msX/uPJzvxS6unD28kiMQE6bARp/GpwGATO3y1OFdJIMkzuC4ekghSDZ7b/96Os86dLkPS3gQu0fcYOxylKJEMH5DyWwsNe+fb+aMLv13p/RxKMQSXnf5gl+Vud6fXekXVJ/9Gp/7MvbyDTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=UoB/Bi0J; arc=fail smtp.client-ip=52.101.229.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuRk3unk2A3HqgU7QUNlwavPqykwQPua25bHb5a9T4EMfW2YrB/dWGdlX2LiGRg061c4N98kfBo/PU707pGhUugB7lEi77pOR84F+gniDaH3P69ArvXKwY95v/Zj6Rid4YLDRIhAOQVYKggRp1hdLsCCxDHnh4+hBjtpXGwLAxA6dwfsA7zjx2qaTNK++Jw+/CtBNUtSvYSUtglfbKAB3dY5aWfAkgx5VXDPtmFIZVRk7HlRYZ1P/4oYLs9PR4sLJ4V9KTQJtI46dEgVUU0ydHcW33Q78uaENgzpUQ1kKZ5UGpXt7vFNOz2X2N+kQLkMkAdQhegCS4T9heEHwHpq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr7ho4A+12jJgtbKfH6Zd3j3xhQUqGYKO4aranx4X9A=;
 b=IwfARympibF6jXI8I1QmKQic1MmV6SWUxGGE2dtzJCKGfp5GRlXlLgboU1pOkxwEBwSjDVfS++FKw2stweeeDE8D7ADpCxhzWA2RH2BzD3E+UtLcDKIAyRWdkHLI5bzv1boPNymXIc37uPpJ8Kc29PRqhqjARmeosjPj01RNF0cDukVyxPrRw52jAb/vupCY5Mr8e8JoyTfCBKfHRzUW42IHffI/bHBuRXwROXXW1Dxj0/fvvF+k6xQPAp57lPhG4ZKys6KKh9/VElLHK61M+4IKg6zxGvyI4JAQMWUID5aA6NXMsQFABF1WxYTOSt/Cu/fMGOROhbaKYZYDFmx9og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kr7ho4A+12jJgtbKfH6Zd3j3xhQUqGYKO4aranx4X9A=;
 b=UoB/Bi0J98HxhgY+AtoLqS4enS/1spbukv5qyphFY12C8p7u86y3KQ0fKMRtoRxFrfkLEL3om+5GWqugHz5FobleTPABcQ0G34LccpRktAjaiYAn+supewhAUqueYHFB3tqibwHYxwVNadKvz/iHZp11pS/H5vhuHQe0Iw7xCks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB7026.jpnprd01.prod.outlook.com
 (2603:1096:400:bd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 02:19:19 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 02:19:19 +0000
Message-ID: <877c89oaxl.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Stephen Gordon <gordoste@iinet.net.au>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: audio-graph-card: Call of_node_put() on correct node
In-Reply-To: <20241207122257.165096-1-gordoste@iinet.net.au>
References: <20241207122257.165096-1-gordoste@iinet.net.au>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 9 Dec 2024 02:19:19 +0000
X-ClientProxiedBy: TY2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:404:f6::28) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c4d126-e27c-4700-e21a-08dd17f7e323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bzoP9REQ12Nl04TY39ZNzu+fwe6vqkv95MTiF9Q3+xfru7VDDuNwPrJmaPAZ?=
 =?us-ascii?Q?o7/WDXxZZkzpD5DCIQN6+fBLMc3ty45uTtC0Opo9A5Kcb5NhB1IFsdhh1d4r?=
 =?us-ascii?Q?cz5AKvSgEVAViEwFy95DAIqcI8mpXaWDasPmY5UL2ozGn/md11SBGGsCS2o0?=
 =?us-ascii?Q?uuKlpLbUHeM54AC0Yw6YFsxVddTsPopZnE/EZhe263m5G2ig00QiZFwWmAz1?=
 =?us-ascii?Q?N+swdM4WuFhT36WtRSD/ifd06mzm7dYrwP44VEeiTpTkYgiGhZAkUGaKQzP6?=
 =?us-ascii?Q?byAetoi4Il8fWylwVqREzC6dnVbx+4HGBF0wRjWwjz/9UPCcUxref4Y7IG+e?=
 =?us-ascii?Q?iftlyBPVk4CKKt+YsRDSGiySablx6UyqRHzxHsvQ6ucZ1DuPRNHw5FvCCPo2?=
 =?us-ascii?Q?WunR4r8kdH0uWCnAobjkpI8imzUdRi3ZZfjwc0boR7+UaWJciI0sH/uXvMV/?=
 =?us-ascii?Q?WSTL8uyKu11kJy4ADJkIw0BvccYk0cE5Gz8SLZzXYh6i7aUifMDOBVZjZ1VE?=
 =?us-ascii?Q?m9PyPNyHTvgQRUvIf8QDuUGHGf8ARLSc3JhOzCgZ3DgVzXSPNeueBxDU5gz9?=
 =?us-ascii?Q?uS5NZAxcJbE3qxitvhJfPtMnAkiplA9BlABOlyzYqjv2/ILxrnNOeqd7ZMpN?=
 =?us-ascii?Q?HgW7riKyydU4ZHxq1NppnklykFf0fXd2eu21SW+TiJ/W3K1b/QnsWSf/aMRa?=
 =?us-ascii?Q?cwUrFtiXvkTugME3z+2chmaEDIAc9f/3j1O4LkomzHkkz7l4vhqmqaQjXhQr?=
 =?us-ascii?Q?VBzyMywRWDcPRCg/rVqvCPJKjyQnQf1vM6lOTN730/b9osFJ6pWUcWWmGWxR?=
 =?us-ascii?Q?JWjz6966mYGXRsJCbm18CJTvj9H/jqJa88KeCTKRZrrAucB5lclcNf81RPcj?=
 =?us-ascii?Q?5UqQJhacJR34PKg860P/4MQ137CAqIv83Q7oBuOzOL8Cqmk3vOZYNH053QwA?=
 =?us-ascii?Q?bsw9PpewvlqeED6tYX2A9ia6X3LrsdrQB6v/nNVu8yArta14aX7qHxmAm/mT?=
 =?us-ascii?Q?TWUL52akJB615AuGDTpXcHudm+C1qIhKozBit0nQSAY1xBCQfJQIc34DnKI9?=
 =?us-ascii?Q?9qMgas85zK+mSEOjiS8Dh7zmcmv93Jz/JSFhQAllGR0rnyvXx+t8KCCGzalI?=
 =?us-ascii?Q?5iW9EhbE2ycngPYDAH++YbW58nznyajJ6eG5OhiVXwk1bffTpKnme4j2fEck?=
 =?us-ascii?Q?F5lvWK7bK8W3doFAbl3V+2BHimWhZHNIz+73/ttM2ms+kC25DJ9mwMT0nrVh?=
 =?us-ascii?Q?e5e/9b91Emjob4MV5y7+YGvvF7evsR1MvYnzZD36B7Zq0QYQs9vQliIjQdwU?=
 =?us-ascii?Q?t5TUsOBKHLcmEbYc0GS0hwhM/3vtSgFMogtQY4elPPd4u0GgWqDEJ6lL1+KC?=
 =?us-ascii?Q?F0grphBcPIT9Nr8w6RnR2P7jSmT8i7kaDhGrj55eQ6XP+DgSFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hlLuAPTU53UwSm9OIylTzn4DAe8AEEBPD4aW8xzgew2alF7TxtdFuLl8uwGW?=
 =?us-ascii?Q?STKy40FvkrbsupvP7OtmRaxxDqkCB2wOJp9zBKudlVz28tlQ4jkbd2sorT3S?=
 =?us-ascii?Q?ecZ7LfpbbDOQHdX99I6fbkzsDKiWa72OgxJWGMPr4HVy9hulj33tJyoxmtDQ?=
 =?us-ascii?Q?qy6s6od+SQxVsOXHNNkv+fhJsyul84T0A4BmfeaOtAJugWtO9lh3ORcyWdE4?=
 =?us-ascii?Q?IEFkilY8veSHjHwcp5E5NjY2sex2biunPjJH760+K9E9mAs6wCOSdIi70jUx?=
 =?us-ascii?Q?v9W9BUlQZuDnR0OcqPKtN1bVi4OsYfJCLS2SAzTDnVFbKBNQD+OkRYahLb0F?=
 =?us-ascii?Q?UtK9mVhM4i6cVexfVtRmZNzR8jBxMpdayZ81rv3FK1Xbrcr4DoPR4fz1E/Ea?=
 =?us-ascii?Q?FfOUWeyz2YMeDYeUWLStw4LKzCz12WAC5NYCmC3dDbtobdSDwmnqJs24r5yX?=
 =?us-ascii?Q?tF67758tLgZeAHQnMW7DwL+Rjh8EBFb9vE1Qv1esOGEtjxn5Dkscq0BCuWU4?=
 =?us-ascii?Q?11vfMvmtQOb+iNqBJYbi49XcypekM5OhGc3/O8utcV0pSrIanu8raR8bFEkQ?=
 =?us-ascii?Q?Uc8isHdtA/2r6Jyx6QkWWkFn5zPqLCertYYS2wCuKM+KHO+P4B/O+o0TSfcU?=
 =?us-ascii?Q?9JlIOxDUM+BZm/4DXcyyRJAO4memSamFAUibn3KDPsgTiR3Dppl2GXaBvzqW?=
 =?us-ascii?Q?BFFFj1pXFYwQiRJ76rDRtUJJ813RIrmSWi6InEpMPYDZmM2TDz3lGY9br5MY?=
 =?us-ascii?Q?br/K2s1aw+D6qdKvD6YUQRK9/W+sotUgkPW4Hk9I1DoPF7m+lVXLNNmt10Kt?=
 =?us-ascii?Q?6yRD6Y72O5kX6c/ZcJQtfwobWrsuiNekkRVUSWB/vpfnVCqSqfSY6srLbiuB?=
 =?us-ascii?Q?vjpvA45BJL4rLsXTgJMJVsozHqOpCkJwU55t1xS26QA8Azcqs4fZY1NGSQB/?=
 =?us-ascii?Q?uhXVQaEtpDDK/uzv4LxheBg82q/P+96ynyVuGYdNKxwXJfpi4Pt4yhhcto+i?=
 =?us-ascii?Q?g/YIQByqRa+y9UvWW3sbq0sGE/G4FtoJ7sjMmUbW+Nqgso/JoZcYKDJ3qNio?=
 =?us-ascii?Q?+oFCgk7o0/hVh5jo5n4sY7ckb7mV6TrPWu//46iT0YLbxt01ZxyzUrDzgtYp?=
 =?us-ascii?Q?aoH0mluPHpGIwYcz4EPyR+vFpOrxxvKBk1DXpl/Imb98Blwi1/w7irgc8Dip?=
 =?us-ascii?Q?9C7fsfi0dgz8xdRm2YxyngQSjvF9uCm4BVuXAHFQKvVQDc3YuRI5m8OMxLL6?=
 =?us-ascii?Q?cQ+YjjRi5bGimKeJttjD4PPkDK2oU4sjeF3OaIyqXz6uHdug5E+137enCMi7?=
 =?us-ascii?Q?0wsreBEBsMlX/Mbqt8l7rVcMJmJjuFjY+oQwGN2P8C0GCA1LqfpU3EGnef7e?=
 =?us-ascii?Q?LeoZvFABp27ehwF6YnKUwhewgxwQx44f9BuX5Jz0oJfq1LiHmotU26BwfVpc?=
 =?us-ascii?Q?v884X3+7HQbd8XBwbnLeu+028j5rJzCSR7OEl47LI4lzr0Wg7EEVNtqW41V2?=
 =?us-ascii?Q?SDBk+q7/6JItc6W1uLERbou6+bnwiNZBuBxAG9OhO0ex2bnV5bhsXgPHp91u?=
 =?us-ascii?Q?Eigzf5naZRPXUJeo4urLjN6QB+WaOCd8MN0xkIVNjyYwAV5DGBnZX+qHigRY?=
 =?us-ascii?Q?KzNZ543sU76h2sT4QfX7Y38=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c4d126-e27c-4700-e21a-08dd17f7e323
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 02:19:19.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXbNEy6mAUdJHvHh/P8zkgl5hpwByftLoceqK1cWFs4E2heNQOqLI7QHe3oS/UFam1Iavhdrhldji8aPAbQQbjnft0d+2pu3FFnWQEw1eVZ8zzJLhVV8QqeaU2OgeIce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7026


Hi Stephen

> V2: Adjust commit message
> 
> Signed-off-by: Stephen Gordon <gordoste@iinet.net.au>
> ---

Thank you for pointing it.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

But I think git-log comment is strange (you want to indicate it under --- line)


Thank you for your help !!

Best regards
---
Kuninori Morimoto


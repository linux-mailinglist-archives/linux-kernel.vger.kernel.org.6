Return-Path: <linux-kernel+bounces-391086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D599B827F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4782C1C20FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEB11C9B7B;
	Thu, 31 Oct 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="SmXQr7OC"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2125.outbound.protection.outlook.com [40.107.236.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056A1BCA05
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398946; cv=fail; b=V/ptvIiBr5k+eEeg5IKuZyHwiQSj8+fKK66dmqmdI/sblxraVoYso//iC0YufZrPuw6RJCemBVU0n7EE4QtkBJIX5kmKTbWZa2SKUrfgTfnJd70g8C+CDESQ23glg9ppbn48U3lP3tPEZKmFQUNyzX4noISwxUhItjYhhZmUrOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398946; c=relaxed/simple;
	bh=swMeq/QptfxJhl3lOFIjTnzH62hWLRVNZN7atVeBpFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AEBwKZ9D7ZQ6UPSxX3sL9iJjFxlmjpl37qB++VXXo0aFl6xWzu/gyPA3+16ngX2YuZqsKZJTewiEaGLfPS0qyyY2+YXr2EXhu2dbteeHGceeBLJ3S24uwFYqKy2t1pRzORDdZuBkVVmIUckSBn/UCCW05BFk70jU83oPTOC48/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=SmXQr7OC; arc=fail smtp.client-ip=40.107.236.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4PHAtKlLX+hN7Ix4LY+HkpOX1zVodn/2dlUyNw5nIXNLQkhr8HD7+j2buozBR9esxqvcp5yNlBzR44DYTFltubzbKdQ3lIxBTcfJyr/0oxXMjKxU/T6TCid0U8NbZTw+OGWDMEbhyWi5XO2DA0ftNZqyrsD8fiw2kimdldnkLvecGX/oT6jnm3mgA6WOladlLnFRX9rS1q9AmVHGOBIXxRkSONwyUXlM5VcrzsoKvCOozagI8rtpVNjMiTPOWWQF564vKtu0bR16K0/7R4aHpGwlKHfp61y8Qv3HM9s5Z0C3l8HjCvp8SeXucSkEmcNvRRPIHsrofHaLlnKq7c8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swMeq/QptfxJhl3lOFIjTnzH62hWLRVNZN7atVeBpFQ=;
 b=PjkHJYa/ZlOlN+WQNoqniWuOl/IE58hVyPucT5HITnEWTGb3Se/LFELQfqgE3AIMFHc4cHs1rrC8QQnzxxOuloQnHTdZY4YCNaykMj0ZO5iHX53Xu7TuPTCWziXDRc33gaCFl2oJu5dy80awlFNYQa9954WUiaHVuiPhEtWVtMC29greq7IF1x8DhUraqGpYI698MbyVa8pnjesGQ3c6r/a/JlyJZjyJbgNqiYi14aSh3sJa47lyg2zhdipXfyVLCChriiBFTowCuU+yI0HMInjg7d87bFlqY2eA4pl1K2vgJSRHnqtDiQzFBhURgrjHkcfJgjiB/lqYq6jr5FDSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swMeq/QptfxJhl3lOFIjTnzH62hWLRVNZN7atVeBpFQ=;
 b=SmXQr7OCpeztyNEIbhp3aMDE9OyNuvdNYIJwXTKHY0Vupb+aq4ML6jROyt3UN5sjsOwVEKp380zsMzXZBaXCP8d8vam3J/o2GJpYqkT82ExzdkB8I9bjoMxGez3way/TIK2fFYvnS6ggkXsiQKQx63rXiELmTHwOewxfiIIVmxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by LV8PR10MB7776.namprd10.prod.outlook.com (2603:10b6:408:1e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 18:22:20 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%6]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 18:22:20 +0000
Date: Thu, 31 Oct 2024 13:22:15 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, linux-phy@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: phy: ocelot-serdes: Fix IS_ERR vs NULL bug in serdes_probe()
Message-ID: <ZyPK12UOTR7LrAyO@colin-ia-desktop>
References: <ZyOUr7iDa9nFBxgq@colin-ia-desktop>
 <28bef742-84ca-4d52-8d19-258f1a3d695b@web.de>
 <ZyPCgOByeVNZC5rt@colin-ia-desktop>
 <9d381d9a-3d4e-455e-a1e0-ac737f8d7852@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d381d9a-3d4e-455e-a1e0-ac737f8d7852@web.de>
X-ClientProxiedBy: BL1PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::32) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|LV8PR10MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f290f90-01e7-4632-bfa7-08dcf9d8f4ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AqEe01V2t29umczQgRyQjWqNu9dSgCZh6JQ4o9k5K19XmQHdWDXyy61Z9qJt?=
 =?us-ascii?Q?00xAzQv9PMAdUw4CwrRy+4wlMoIwyqIl5YKanpMk0/EvXnfTffId5XFGYwFB?=
 =?us-ascii?Q?706BStN4qPoOlUn2mn8hIlAs2kQmCcxv3rt9P9h4qFzNabHzewFISGA2N7on?=
 =?us-ascii?Q?tKFoVrUPV86ogB/+/vLTRJ2XFJ+UbwmHEgy8KRVOGZ/Beihey7+TVAjvqVZB?=
 =?us-ascii?Q?xTlpa1scj0o8/7U40sVciCiwdUPHB3Qw9mpj5I7lWelU7uI5/01gduKdPcWi?=
 =?us-ascii?Q?4D0rsKipkLVGZK/CG/QNcIdA8+yAVh8ZJqNOodKPvoCb4M1pCuyyHpu3KPiq?=
 =?us-ascii?Q?e62QGqHrO0ZjnxjL1D9NEC37wBiZJyKFSrOHpVtNvnKHsfcypE0J4+tMQELr?=
 =?us-ascii?Q?kzsHsRQPylEMkLO8LZyY3U2OnCi4hb0YA9vRRjOHOhfPScpZPk9/SPJhSGz/?=
 =?us-ascii?Q?taUMvrAvz8fMTtx/D6XV4SwGWr7/LWE1rHJ5syXBXnQIYeDNWWNHA70L0qfB?=
 =?us-ascii?Q?e9ZwR6WJio7dOQgBOgJj9oj9G/dxVHD/amsPN5GMaXomAtCP6MkfswU4CZua?=
 =?us-ascii?Q?KjFrOec/jcwur2FMdZxCtYBTWn7w5wrgzA1ngERBbbMfTkQ1SCkm53ysrb+U?=
 =?us-ascii?Q?HPQQ8aQuih68x5xdNQU280GkaNGRp3/nsg2n7ZwmJpKcrrPY9b6xPrVSSl5E?=
 =?us-ascii?Q?nwsKEtwGHXGIINK1SmRj7ODo0wNFrL92qrDpMPk3ZrkVv/066yx/xnOJTUUH?=
 =?us-ascii?Q?2z8LMs3aSsfEyXz3x49JLa1LGkNEWZjsX8OswOA5DMew0lPpE+HptjjFHBO0?=
 =?us-ascii?Q?Q48Bexo75dQwBN95z9WK4ArEBDod6JBOAPm+cvaYxaZPJVKdOBiSGJNZp/TK?=
 =?us-ascii?Q?/HQRnDF1OsSArFHM6IrtekCIEAwWOBpRnkXdI2SGo0AP+Cws2Z7Q52w9T2tX?=
 =?us-ascii?Q?HuwvzzbgaEUbkTiGu2rsXJLKzMgQa6jKAVBbWhCA9+sH25DRmC4ZXk5gj0Qh?=
 =?us-ascii?Q?HkA/RzBDKZuPhEL8S0178+Hk/Q0GFTcm/d+AF4FKMghrms5/35w/GhsasBk6?=
 =?us-ascii?Q?btU8OerFcFdGYNP5uHzWDplgbVEO4r/300zstwQaNq4qXp4qxhCOB4M0q/Bm?=
 =?us-ascii?Q?En2jHQ5tE2KRTkqiS/yUlErENiWO0ronqzBUFFzDn2If0ejF0RIO2Erlpa28?=
 =?us-ascii?Q?g9v+JmOllv1caoeFw61P0qz9vx/9kiVkB4P3REQvXAdNFWVJQdhYHR83KgjZ?=
 =?us-ascii?Q?1+sJyAHt2zk9Xy5IKjPoE6RTwtJ5TXoDcSAvy3OiT+7v1Y/rnr9WATHKAQYW?=
 =?us-ascii?Q?Vz1sdJjVoV4cuhvoJ/BRlnsY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xJ0ZqmD2n5aQXiLFH3A6cqauRKJLpgmaGdEwWDrhOSKIHFSbnKYBfMUnLI7m?=
 =?us-ascii?Q?LU8XzNfw9tlfXSyirpNRlNw2oaLoVPiy4kCNDFkhB402RusU3AU/2J/cNnsY?=
 =?us-ascii?Q?SQXnZ1S/+zcGD5TjP5nLeh5DMz7bL4LU1PB1gP60th0jyBYZqycKey3xGxeu?=
 =?us-ascii?Q?49mCGkVrUT6uT0FaiBaZy8XhFDlKO2lioVj3YFNcb/uR2sVgTfTWTQwQA9Tz?=
 =?us-ascii?Q?SARz5/DPBLxaCfaRCArGgmRVIhhWD254AsRYcsMvvm2RPMS6aWUx2VcTB9Os?=
 =?us-ascii?Q?WO0T3HUzSVzLGyQe0uQ6K7TWiMS6/5rOGM4bFJv4XjEx5EEvmT12RvPWofPp?=
 =?us-ascii?Q?6lbcFoiGntd4zfy94XnIjVHZY44gmGbR/FY3VfF/+j/bkwWdobhlfkB3r+Wh?=
 =?us-ascii?Q?fwJ9YucSBjD+DoCrmJTPENqcBFLxxf4ytU4uGdF+7hc16ttYIrM/xYF1Eqsg?=
 =?us-ascii?Q?2u3uyn4bYL3dzZERwkN9GzV8gviHct4jSZlRRI74ws23A1ZT2rnIq2GmmTTq?=
 =?us-ascii?Q?B2Egobois5qnwyOGAjvynD8o5gGNQOm+1hxDrur7vqW8xn/g+pBZDjRCj5Q/?=
 =?us-ascii?Q?Ha2lgk6LRMI8XK30kWgvueo1reJHyLn3RvWKSTUK1ePVHwrGSScY9uTreW1/?=
 =?us-ascii?Q?WdR61FJNPZE3lbAhoZVy4YM3W2pqqr214nmGzmBTQXdAABLh+i9HjmgZIIff?=
 =?us-ascii?Q?dwnZ2wA5sIGKu+geOGEuUxh00aeTHF8vRaPRz1gYTwt0WWSVzSwVSQBqDiFy?=
 =?us-ascii?Q?Gnnz53tjQ7uQi5b46l/W1uO9wjMLhDeDtmL8t3XbeD4yiZRjNuPNh6eH5lG1?=
 =?us-ascii?Q?JgAQHk4efjiqIQp1rJJ51HZp3WcYdMIl90usFh1TMVfWMHhI6megGaodBC2F?=
 =?us-ascii?Q?cKOEoA+k3K/yR+Z25f0VROVZCKEmQB81TtCELOb0qeqN4bQc21AhjdacMMO+?=
 =?us-ascii?Q?wAX1Ct9oa/OxJZqcXj3vIUimHSJ7C0z0BbWzyi5uoKPYAYZblRBgm4s+46Hr?=
 =?us-ascii?Q?PpMiDpnQDtrUQQCp4kwia5RGrIexxcrAshxz+m1omFiD9ywhDgbO4HFG/+0/?=
 =?us-ascii?Q?nQX8vJ7jqu+y3Nn7V6OuAR9a6pOexwAWARjY7Hqxl0m7HFTL7saxFhNFrveE?=
 =?us-ascii?Q?b9QN0ecmVtWT83v5HXSneuxyUcHcUxTeEH6eJNfPx70kkFti4gjjMyxdm1mZ?=
 =?us-ascii?Q?LIcEMbpg4BtEyqrM6c0FB7hf+OY0+fMF7vlviENr/oi70FDU2Z7fenpTDUdS?=
 =?us-ascii?Q?cLmyK48qzlfcES06EOH+Jo0MZfI5bi7FIgpMN06XxDDkzPjekIbEjaSC/Be0?=
 =?us-ascii?Q?VHuTjKxLB/nI8kyqfjtOwmbFZiT1a7DoCP7gsajFYAhgWfcfOkvvHNIf0beA?=
 =?us-ascii?Q?vjZg3U4v/Vu6JeywlSFGsrXqQogpm9hgGF2nXn64Cxq9z7Z7Tdc+3rzwy7KP?=
 =?us-ascii?Q?waVGKmukV6GTRLQr2mK5wUnTG6bCP9s179oR1AQdIhANX3QtjqCT/s2r417Y?=
 =?us-ascii?Q?OxV2VMgyxZdaT9HcDHB8uPFBw0DuKDEYF9pmfALO2hubkvc8it4VJvm3GaNU?=
 =?us-ascii?Q?AzXe+nute9AyojUnykAqORVkKgOVQHsEcP02ML32mZllDXjsgIhFKczpm4L0?=
 =?us-ascii?Q?A1Tf1z/yH8nO82ckx9aJPOE=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f290f90-01e7-4632-bfa7-08dcf9d8f4ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:22:19.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJ4VhHjU4YXzNOrJK+1DUXeCnVYKHHSxnV7uDk60CY10QAgJmYQcezDZNizdKDBN0TWl5aE/CG54qqYhK6SxTB/ql3zMmi1rOJeVtKxE5m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7776

On Thu, Oct 31, 2024 at 07:09:17PM +0100, Markus Elfring wrote:
> > You're absolutely right. Apologies.
> >
> > Acked-by: Colin Foster <colin.foster@in-advantage.com>
> > Revieved-by: Colin Foster <colin.foster@in-advantage.com>
> Please choose one of these tags (without a typo).

Sigh... Today is not my day. I don't know if there are any actions for
me at this point. If there are please let me know.



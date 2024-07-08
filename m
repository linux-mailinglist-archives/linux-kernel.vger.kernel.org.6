Return-Path: <linux-kernel+bounces-244486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F6D92A4D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2991F21BC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F6F7CF3A;
	Mon,  8 Jul 2024 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KObOKQeN"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD61E50B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449331; cv=fail; b=pDtVR2gj94tG/SLLYnwc1ZGqQHgdGd1DatNtAfDLQcqLZYXpgyYtYon+3Dw/3X7GkwYshz8fw0tSx/e4SwG+vbF4aa7Eq/79R1atNXID9PFmNZNAIpFAvjPyg9w/+s8u5Li04rEmRVVUft4JIsDYHAvsCOWK1UOdZ1W9yRF+c0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449331; c=relaxed/simple;
	bh=p2JJcP6qEYhOuRZA81FLQHekUswDvOjJGTarWifhG9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fcBVtt79Fv5VTfRMvEAVLl8J7iziSsSCw30JxY3M0g2UAtFWCRWIBg5HQyNLCaBL+Eo+w8idcd3WkTXwtDBUh2SOg73F4oFT78pqNA6M5X9wC77xgt9d1Tt/nu6QVbpRuTxfeqIosBAXTP/gen0i7YH2c8uz5LQRKl5K2DBEE9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KObOKQeN; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMzaDTKhvT2w0TNhBZ5bnk/DiHXdTlnPWB53xme8fOV5i4PQKxHcDD5Z7kOJtFUpgdOLUFGdOFSmoIW1eO6KuotUtptYk4r4lJeaJNJU16NhAZ8TSdNzA1m87I3fK33UOkYIjgHt3QMEjdvm7LxoE6t0RrFDpe7hpbcK+ZX+fqx2uOBnr24+1Bu3ZmGNegKv733pETnA6UwpHfhC96+hlZGBOaEKq5ChD3d8hfeTHUV1TQ93dcUlT9GCbZVj5zyRFC2afrsOEPOjm4nP+fRYSxT/5tFVCYAnXPfSVqs6dXRjg1XWgkUyMq8x31XbUD9FrvBWGQO9r5z5/PntW0nk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTVpVnNXZFGrQVaVpPadvTCaiLGqq9J3BIGfjWFLHis=;
 b=iCmBcAHib4tduqT4mpLyg0ASrN5GTicyOx6hcH8E1Oec5hEiBDFABZ4yJw0E4YdPvTuuFICBUDTC+t2scoYNCDb+tAJZgF1F0CPPFreLrhZjhu09zBwQ+mSF+CbQZWoFjm6BRl4HLZmt5sFqrrmicFBFz976g0y9TQ+45S8mVGLMkeWILjXlB6v++cKl8AMS+h/baZxu3r5WICKr0Kghx+6X8u5dYAF+ZmyQLYahT4V/wMkOatRHUVuaqeUd7l5JInN9/AM0FfHWrGcEgNZQL20qGo0T+4aAdr6Vc/4QxyeLPZTw6OC6JIrtrMTsrCq1cwsqHBhxSBRgTHwXdjkSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTVpVnNXZFGrQVaVpPadvTCaiLGqq9J3BIGfjWFLHis=;
 b=KObOKQeNWCI+VvPCQYvFvwzU96jx3M4FVxK+v5c0aeygDcluim1sIX6GxtWLBlShi+w0sVCqNWsWoX5Tv13OPDBhY+iWDYuSR5gF2EPBgSP2oCL8w978Ou/tZM3vh0XoubxUc30ZKibH7xQFOy0qT83Nl0vYJGEdGo6MuI3SJQceEwalPnke6VYh9RAydof2hzTTLUmoyhHNbZ4uNbt0dWjdq53CF87rjfNOp7e9ALJ4kS+BrGgriISvzeJHtrinRKaTHQqTgd0wnMFFXbN0Htc43APNPRGERXWp/sJdFJZBVKJ/jVynsKqIi1znp//byvHl/kMM1lDeX7CVr27Tdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:35:27 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 14:35:27 +0000
Date: Mon, 8 Jul 2024 11:35:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 00/45] hugetlb pagewalk unification
Message-ID: <20240708143526.GE14004@nvidia.com>
References: <20240704043132.28501-1-osalvador@suse.de>
 <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com>
 <Zoax9nwi5qmgTQR4@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zoax9nwi5qmgTQR4@x1n>
X-ClientProxiedBy: MN0PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:208:52d::6) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f9d59a-1ff0-4530-d8a1-08dc9f5b35da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nLs0XRCtYIllqdq2gh/HVFvcyXTSNn23n+BY7w4RbpoUTDNnMO/cdovqJ1t1?=
 =?us-ascii?Q?7zBbqLNuE8JckowHk8fp8WwAn1btCK5/pica55CJdX4VaLle2b3k3CpbgmDJ?=
 =?us-ascii?Q?JiyekbeSNxRZ4avlrl3YrqSGb/TUJaWsMv66Dx/91cqPoN5pwKQnyyGRI+80?=
 =?us-ascii?Q?T4sj9iW7xZOskpH7929LFolMGSuFT3prC1CZkq1KY76ZuF25zRZWHWBdU9BY?=
 =?us-ascii?Q?gu6xO5eTX666eo9Tp9q4PYLbHDMN/539fTiO7dleabJoCAAp2ui54m/zaM9I?=
 =?us-ascii?Q?0P1+UKImwRd8r/V9RhlMn6P2ml0RIE3HVt6glCVldf5J196nowJ+1rdeO3Ei?=
 =?us-ascii?Q?EITCtw7wGXB3Y+mXI39t85zwVMiu4/XoQ++trjhcz2Iea4bgiQdJhFZjd+wP?=
 =?us-ascii?Q?rwVxZ4zMyeARy6cLIxOJHr4g50w/aCWLw9Ey6vMp9cWs6fFXAYfVun7nYP2D?=
 =?us-ascii?Q?PSnoK0SVrNtTgYusPQWd4NfBwXCwZzunGGxTuKknO4w1y6cUenLaUkH9VN6q?=
 =?us-ascii?Q?bh3zVoqBJ9AHYqLffewI6PD/scPGzasD3W4p+nyEydgNjxseT1vPlRTOf8Hp?=
 =?us-ascii?Q?v6u/EhzU+AYJ0UbgYgjOOqjEefXNDP4a/6YcOiTdZmnR8nJ18dtCwy9C2jbb?=
 =?us-ascii?Q?XXd1I8cxe5rN+T28mWCT/50GWOv1eapWLagM5SbfjxaeV/a0TmnhikzYS+vY?=
 =?us-ascii?Q?iT3L89cHXp/6wffNM6g8JApMVaGhHH6RhIxvIdZmeqTwv+Wwi5+UyerCaIZH?=
 =?us-ascii?Q?u0DDrAiXAQgEBQOfAcOXsclvrY7Al6sw5xSykAFpA8nPHTEagG0VqVmwYdGL?=
 =?us-ascii?Q?/5YeojGVlkBVJNygUIdZnaGqg8S2d418DocNo/lZ0KpNAqEVDnogDo5SQeqy?=
 =?us-ascii?Q?KGlw7/Zsvjs/u8mbY85lEAbQIbXGO+r3mcix9ZbK+nqaJiNp3i34OrkbQR8n?=
 =?us-ascii?Q?KyKYAjwBVA/MzhbdP+dkQD2F7uK0/VLV1AR8zdarNRUAbc1grZZp7UmgxHBX?=
 =?us-ascii?Q?a/C0vBsC45FXxxv4r9KceaDrDCQW3DYQhydSdKIXAyhlIEgIaew8lai8XmyR?=
 =?us-ascii?Q?BePegEe7JOwdmnKN+iW/1oA9Ia2qKLr0vRMM4pZPewwgTd0S3AitZo8cQAkX?=
 =?us-ascii?Q?byB//xu8Mqj+KgdpaMmEfqyZsVYVxVVtIhtqT9YqrjplhzgGSYlIZkk2Ir+0?=
 =?us-ascii?Q?ZM2/FCLcKHpt5F0adEG3mugnZoCgGNJ/cS57EPT0KP7vBsOE9Vfh/EZqtVhU?=
 =?us-ascii?Q?pGo1y3+hVCDjiHhPyPWTwzgwMwI8b9AGYuGRNvuWMA/0/8F0uMD3SggeLS1A?=
 =?us-ascii?Q?SMjAGdNBvR4ZIQnCP8fvFhk4+kclutOfgnemFOmBqrZgMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?czCMt31WLq/pTJraiuXl7QAh0k2g6gPTdB4fRkt9romcWqVdhkvLwYgHk4ri?=
 =?us-ascii?Q?VS38VGNsrczIFHPTeu4kxXpXPWaxi8mVfdu+azwCgn6escCNp0oaijBvTo3p?=
 =?us-ascii?Q?GApHeblU87LZCbyKfNDGrhAptfs6OfOd3siNBw8uiMuQaXiuxIHVaipW2vSk?=
 =?us-ascii?Q?By7er3D+OEzbTSnabGKO8ivqm9Xwx3G4Xy/pM8aS2CNqByJFyKHHoVNec+mm?=
 =?us-ascii?Q?a1NOFnRHBtuJWM3yUSqe4YQ4t7Gu06K6ZdyDfD9P5o1nmcYZpu9FIO5rhHM6?=
 =?us-ascii?Q?MbVoH92lFPCELvFSMDhSPqtOWD4lpCdtW+yjDU2zjR6Chj++oH6NHE7Kw7qT?=
 =?us-ascii?Q?rh8wabVSzGIMOXXIlpIMKQ7wOccSDdsCOiOSsEzEAC+Aw54hsCUFJUJURrIp?=
 =?us-ascii?Q?waFDdg/wZSIeZvAgYpKcyPOlAcle8nWPCNIoA51QRgl8O6OXAp8TNeP1Ih0r?=
 =?us-ascii?Q?sVT1Zb6XjgRKCKH8Bp0vn9cIAoom7e5UYROpCl9YqpvFquYJVZSsKblLSpSS?=
 =?us-ascii?Q?uARUasF7EvNHfaqknBdyh5c2foIrdO3OfY4xziCn4CmCzWjZtKnqn85Ky8pQ?=
 =?us-ascii?Q?bzmzLq+dtYD8i1uMiYDeCX1nGFjxdQH7NuCNqQvJQ3zpGCi7qag+kZGp2SkD?=
 =?us-ascii?Q?fBlTnbu/hP4uDuJRnvyaUTUsQilOU2J0oKRsuMzEzE8pPcoa0vqnx0hEqib0?=
 =?us-ascii?Q?Co1jBe5E600kA4Urhj062lYLUqj/cFaD1IjfDnHyRL46YlxAjdInxWH4/NAi?=
 =?us-ascii?Q?PWMQZ2Gon5SrkNrrCFz5GaANR0YWCOT48vJxFeucDVtpkvz5rJAwyQSBXtg1?=
 =?us-ascii?Q?l7crgZrtrtw3zYhHceyucNEKCFS3nK1Y5uVb3Zfb9mCExpzE370qZyehs+hd?=
 =?us-ascii?Q?R0KXDhdltTxqLR72nTd3T7HlFs9d99RDPbVM5vGlx/cIF8baoztxajFpZAq4?=
 =?us-ascii?Q?4sx4YVOK+NDYI5ErwG00DGLNnHpJa1aZ+5iuAM5hOYq8/5GXWfDs3WPXwIuo?=
 =?us-ascii?Q?EhzUxOKHA0rXdoQ0s37GAZIJ45YTqVsORp6kpTtLBs11Cr94RfM3ZkUo5LZ6?=
 =?us-ascii?Q?Xs/6t+nbQ+B2qge4BPO1rZJ4Yav8xet5OpLXcYduP7IQRmDjvIYbE5K0TBz3?=
 =?us-ascii?Q?bNoBJgrNl87ZUuldQs0raXSCkcFrzcmeMsdIbSggYLAmgblsx68Jcey/ndNL?=
 =?us-ascii?Q?kjajiFi8g//hX6vKFBFk1P9p+BldPOkveTu462x/3S+h2PQFRwvkrWFSvt9N?=
 =?us-ascii?Q?8jeUIXY8e5iRdDL08GNzlH03UCnBXHCodYv4Vw+lL4KB9uETQMTugZzcK0TF?=
 =?us-ascii?Q?FJm8OxfCVrUb7tCoi5DF0R2UqAWFRkIgWyUNpHLOXJ3I1q/Kmw0dy2DIvogY?=
 =?us-ascii?Q?gp5Yhs5RxypOevGt+ib9uS5kiD+UbO3/khSFgbyGRys7EfkKShPA7iqkI6kb?=
 =?us-ascii?Q?kIJAQHQwZpE8z9Nbg+OKC2X1s4ZFnKVYIaT1d+Rv4ouiJlvBx4U2JcE5BMKX?=
 =?us-ascii?Q?2fr6oVRNK43097ZnFzDn4Ra/DVR3TJprzJxFEnGIq/r2X9mcvAMvWF6h9Ypl?=
 =?us-ascii?Q?s6nn6VWR6N9jIYI9Jx6HhtHwi+jssvKELMf/G7vT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f9d59a-1ff0-4530-d8a1-08dc9f5b35da
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:35:27.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+rdXffOAnXt/tDohXwR8A294LaixkYdptY9if5CV3DfnmC7CPMrW4zZADmrd0lo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772

On Thu, Jul 04, 2024 at 10:30:14AM -0400, Peter Xu wrote:
> Hey, David,
> 
> On Thu, Jul 04, 2024 at 12:44:38PM +0200, David Hildenbrand wrote:
> > There are roughly two categories of page table walkers we have:
> > 
> > 1) We actually only want to walk present folios (to be precise, page
> >    ranges of folios). We should look into moving away from the walk the
> >    page walker API where possible, and have something better that
> >    directly gives us the folio (page ranges). Any PTE batching would be
> >    done internally.

This seems like a good direction for some users as well to me.

If we can reduce the number of places touching the pud/pmd/pte APIs
that is a nice abstraction to reach toward.

It naturally would remove hugepte users too.

Jason


Return-Path: <linux-kernel+bounces-262821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDDD93CD24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECDE1C21B13
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F7A2771C;
	Fri, 26 Jul 2024 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="PutrALMb"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070.outbound.protection.outlook.com [40.107.117.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1D364DC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721966464; cv=fail; b=oUwtGXqDS5NN/GyOADngjENlteRGAyUNBjGSrODCkO1BX3kn5G0RW6Vq+3xRJW/UQUsC+M/P44kxFDHIUBSHa3DieHAvCIPqWvXsF6tFcsDLSBvpNMHpSTFZDz1nlQZpkumStTP8Vrd5MakAA4S110K4EY80iFIqInV+JbaEjEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721966464; c=relaxed/simple;
	bh=Wcr8Xnu+a4KaXWSY73xZuEvJC3ToSdj7HJr13hOJ6hQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsbL2Kz/M//1V1J055jYFhLmmP4odHrGDCIwxl/0gkR8mIRt7Ux8B6c5yFXHXgAjpouxXH9FabvQu1K/NkM3AiyBqVhtWhUdJUtGxLkcM95e4Vr1ENOhS/kMu5Uq8YlZ00aBuEi85nN8DOoh5sxfFIHTKlNPM0QkYUv/vRUDpMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=PutrALMb; arc=fail smtp.client-ip=40.107.117.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfIV3dcB16nOib4A/Ag11lMvLutX9zjgZZtJFqvfm+9Xrq+QXtFeKOg2Aj1vYlvVmzN9BIWxU2AfcMyv41CHOWhmhJiYeLuafRk5597sHBYYaiHXghWBarWXtHSOPWzlttaJHGZybylfij1JJX98QpazY/vGuSOBAnJyJKJvJ3IrocK3pkl6Y12scBocBY0xhdxxmhbbyUE+RQ+ca/P2B0i0XCVX0lW3gOMEJLRfbNiLXDA0zqRSytEJ/UqnkN45tq2/DhaE/O/HahgaD16jy0EUYswiMZjd1owwiKqn88frXpsldL4JGn9TWa7S+ThEjDWOmGeTFIcsesLGWPqydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMerNdeIjj4nrSfNi6Bfl8XzPhMaXZM39NcyU9gy3zg=;
 b=YmELeEUjYJgq/BALdFy2KIhI55eJA2IyuUsyShYjVstErizyspL8NhUP9Kv14/GOlgZhB9dJRNRNQ2j56VEkVjESV0OdPY32lP0Xm2tfYAI6nzxJGDQnHwIxOnA+kDQusBKj73eRZy4XS+SkCsWiF+GZ4uBIokEKs/JFoj5BojSggpNYFQ/e7jENsjuT+7T2cqUcUlkCJoxHnjTnRazSNPCv/TUxQTbCeBBx+IXW+95QAP9zRX/1+i0HfWRqm+HrF+fFR1qLpf3zr6mYl+BTN8xZ/Ds6rHnxNioD5gG9GqF4sVlRil3q5jvSsBqD3t8mmuLjxAZWUoocD0zVLmBB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=redhat.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMerNdeIjj4nrSfNi6Bfl8XzPhMaXZM39NcyU9gy3zg=;
 b=PutrALMbwBGv/iVc2IQXuKpp3qc80paU9fbW65NeHjTe7ATRZJPW+nCrjGyde9FUoj66oR9iR9UsLjU9vzRenHf6B/KOY15hy1QZZaoJM2eCHoINjUEQSpveUh6KlKs6znjlw9ilRQUcWurZkL40GC7EKAUiQkOrD6FjsFDEaEQ=
Received: from KL1PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::19) by JH0PR02MB7510.apcprd02.prod.outlook.com
 (2603:1096:990:63::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 26 Jul
 2024 04:00:59 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:820:4:cafe::28) by KL1PR01CA0127.outlook.office365.com
 (2603:1096:820:4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Fri, 26 Jul 2024 04:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 04:00:58 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 12:00:57 +0800
Date: Fri, 26 Jul 2024 12:00:52 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Baoquan He <bhe@redhat.com>
CC: Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
	Tangquan Zheng <zhengtangquan@oppo.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect
 __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order
 fallback to order0
Message-ID: <20240726040052.hs2gvpktrnlbvhsq@oppo.com>
References: <20240725035318.471-1-hailong.liu@oppo.com>
 <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com>
 <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|JH0PR02MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 5211b894-7b22-445b-982c-08dcad278ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pFsOl7rhZWv+IKzEnmLXVQF09fWkfnapugfkmyt/HIxD2/otxfQqcf/XkVrm?=
 =?us-ascii?Q?JG+RsZxla6/yC19ntwX8189gld5jFed61P4nB4kXF3X5SpAh78WHmLs5kNkM?=
 =?us-ascii?Q?blOW8f9s06yWde4zCWWHCX9NF5PVWZRAE7t51ehvfZ9qylK3BMfvCgL0Sgj8?=
 =?us-ascii?Q?oO6pHyJyyb0pmhPRFDgT1EFpW/aiDMvNs6lSs0zYyRxG7vLxninxnVM/WliN?=
 =?us-ascii?Q?GWksgSK5kwnDeXkO9LZ6QDCbbOXMYYvjB9t3rsroyge0P5+ra1QLTJ91MmDb?=
 =?us-ascii?Q?MSonxbbjXzY56GPYG3w9SEnZXb6anuv7233lM3K0VkFBWFuyVmCSQFdkOba3?=
 =?us-ascii?Q?+b/2Exx5czf7DqM4oIEpoUkMPsd77OlTpR3yq73TKrCND0ygFNaBKXD/zsW6?=
 =?us-ascii?Q?q+MnC5ePJyLUCNHsQXJPuweWen76Ex/yj2f8hRWN0kF9ro5e/hhfOC0Cy6fn?=
 =?us-ascii?Q?fuwV4qmQ0mK5snK13WLda/VbL8+jNoFdI1EvJiMX53alF95dLMNeaaJvT46k?=
 =?us-ascii?Q?qE+EgHQ/Ba+3+Me5D2oONOCJsjVLho5IUnCK4iypfsLrQzI40bTZcJFZMJUP?=
 =?us-ascii?Q?qtO/C304sPUPNBJytQOzmWsiYH8XTFfHjDsCCy2+4/ug7n/1UHUTjZXGj5fM?=
 =?us-ascii?Q?STETde53ph6WZM+TmaJ8YomPSirI/n8ewMwFZNyCVJLaoSD1lTsvnbo6OEZT?=
 =?us-ascii?Q?fOpb17KMaGfj33YQ5GA93v2BSog4sqrM/P67Nb7d1OCwG16aFLg6Fqo79er4?=
 =?us-ascii?Q?Yi6v0JEcaedG/XxKAkQ2sDtaVG4aMKiSXGICgIcdvBbPgGzmm7IgGWwbEZx5?=
 =?us-ascii?Q?/sjjvvN6I8ShurmTdhEHjePcq0SHB+TosLFV9FvyfDsBZCJExmLtz1meBLnj?=
 =?us-ascii?Q?0GrAuEg/u+Tce0msoYXK4khnCh7C1XFh85dtJMpYhp0sz2Q0oGJPIM9QVauh?=
 =?us-ascii?Q?iby6XxYKPT7/C7jnQ7attsU0TOnW9htkrGouq0jMen6bLZJfl8JpRfQW/csT?=
 =?us-ascii?Q?ZXcvrgY49Oa2BCE9ZJantu9IGZJh7Sh1dtQNONFbX2zYaPWvSyvRJt1d4Vl4?=
 =?us-ascii?Q?3YDILPGx1IMoGaZVqstyaXc00aCEKkPbszAvvAdV3B/TKCmqSJIAS8Gl67m0?=
 =?us-ascii?Q?fKMst+ikJ576cdpNmIcAvWe3zsdiPRQj/2eDuOWXZHqsVIQdUpYeg2Snct2E?=
 =?us-ascii?Q?mvh04/te2HTfHgf5bojqqYkel/fUe7ICySaSm5S45vc/S+uvuvtv4gvXCP3j?=
 =?us-ascii?Q?bZZVGRQ76PIFlSAqoNg872cTz1x8jt9+FKjvblP2TmtOtD1j4QJGqVUhpeMh?=
 =?us-ascii?Q?YxxBTpLgBdQlmLhDeRXU+VbuEskXkC4bJ4FSo2EiSDyHBHqr6QBiqwA7ooO0?=
 =?us-ascii?Q?rbov4JtjyIHdKFbKlRtuUh0OFMeqS40jpl2ZO0kmhIuCjhkCkf0SnVY8awIa?=
 =?us-ascii?Q?JydmO/xFskl9M9bRmdWAdXPAj8c1cRoe?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 04:00:58.8299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5211b894-7b22-445b-982c-08dcad278ebf
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7510

On Fri, 26. Jul 10:31, Baoquan He wrote:
[...]
> > The logic of this patch is somewhat similar to my first one. If high order
> > allocation fails, it will go normal mapping.
> >
> > However I also save the fallback position. The ones before this position are
> > used for huge mapping, the ones >= position for normal mapping as Barry said.
> > "support the combination of PMD and PTE mapping". this  will take some
> > times as it needs to address the corner cases and do some tests.
>
> Hmm, we may not need to worry about the imperfect mapping. Currently
> there are two places setting VM_ALLOW_HUGE_VMAP: __kvmalloc_node_noprof()
> and vmalloc_huge().
>
> For vmalloc_huge(), it's called in below three interfaces which are all
> invoked during boot. Basically they can succeed to get required contiguous
> physical memory. I guess that's why Tangquan only spot this issue on kvmalloc
> invocation when the required size exceeds e.g 2M. For kvmalloc_node(),
> we have told that in the code comment above __kvmalloc_node_noprof(),
> it's a best effort behaviour.
>
Take a __vmalloc_node_range(2.1M, VM_ALLOW_HUGE_VMAP) as a example.
because the align requirement of huge. the real size is 4M.
if allocation first order-9 successfully and the next failed. becuase the
fallback, the layout out pages would be like order9 - 512 * order0
order9 support huge mapping, but order0 not.
with the patch above, would call vmap_small_pages_range_noflush() and do normal
mapping, the huge mapping would not exist.

>  mm/mm_init.c <<alloc_large_system_hash>>
>  table = vmalloc_huge(size, gfp_flags);
>  net/ipv4/inet_hashtables.c <<inet_pernet_hashinfo_alloc>>
>  new_hashinfo->ehash = vmalloc_huge(ehash_entries * sizeof(struct inet_ehash_bucket),
>  net/ipv4/udp.c <<udp_pernet_table_alloc>>
>  udptable->hash = vmalloc_huge(hash_entries * 2 * sizeof(struct udp_hslot)
>
> Maybe we should add code comment or document to notice people that the
> contiguous physical pages are not guaranteed for vmalloc_huge() if you
> use it after boot.
>
> >
> > IMO, the draft can fix the current issue, it also does not have significant side
> > effects. Barry, what do you think about this patch? If you think it's okay,
> > I will split this patch into two: one to remove the VM_ALLOW_HUGE_VMAP and the
> > other to address the current mapping issue.
> >
> > --
> > help you, help me,
> > Hailong.
> >
>
>

--
help you, help me,
Hailong.


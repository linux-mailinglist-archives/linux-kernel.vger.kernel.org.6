Return-Path: <linux-kernel+bounces-366468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF4399F5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3257D281E58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA56C203703;
	Tue, 15 Oct 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R+oof/2G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="klxSLz5i"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3519E1B6CF1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017399; cv=fail; b=UseCBTwsgOHFKS111TNkEpUjJ+s9Tt/6pLleMG2ilHSCmeDqNTYOZJBv094SagjwWFHmzXupal8QncGfFoQhFGivlM1MturNzNCsMiIF3TxrplO/QeXRkC+emA5gaxNra8/ylAyLpCWBDHOeC1Kc32q8sQCUWZWgWSvBfk6J/MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017399; c=relaxed/simple;
	bh=cDprGniC4qEmfbiilprybtfw8QPHZCxpwLI7CRXbLFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DiH8h8jFv7QDdxiYg6XP+0kL4F/roJhbuSDWO7KLrp5uA9eG5WZMUefxJSgjy7tRbHl3bThnVrtQ3yjELpCWpgFpdo5PqShlC8ey5LfYPjNCOnmG4CPfoQK7fz9tAknDoUsZdxATl8RKHJ2GlO+cPmjPV9OEJmeGfFP+l4zquew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R+oof/2G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=klxSLz5i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtiPT001626;
	Tue, 15 Oct 2024 18:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=mnuj0AwJz0QpobRw1B
	IRx5t3p6X9ByUdS4Mfr8ukzig=; b=R+oof/2GRtw0smZ3vZNITvFbIXURwgSz7T
	vv3Hk24hxerL0A7mRdfMjO3Mhtfzqtgaw0F2z9kvbxAhiYik3wCdnxKF2LZEXp3T
	cj1neZCSt/jmgBbvd4ZkBwrXYCYlHT9M4mbaLfuQcpNCI92x609zNU35uHAwXjgd
	WuQ6ZQjhaKCOcE0r4nlYuxnXzlvamPWueFtx02K7pG7p/j9sbpv3CC2PRqVKgk77
	sfkqsLrVKPOI398YyZ64fM3uiesmLPIurPoTIzVxD9AxgfyqyIs+SuGXn4yEV195
	T/c/bqzbd8SJxPhYbDzzosmFkkNIouI48YKyEmLET2Sgtc0sidzQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ahrf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 18:36:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHQM7O026416;
	Tue, 15 Oct 2024 18:36:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj7uh1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 18:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7FpTIUMwroLaIbGTvv9c3haaSaR6O2iOkzqDEfMXKJOPg5cbfk5UZumdDIb86Sf9k6Sbt1szwwCIbfIN7eBwLwYVWMAyJvgKBEn99oWTaS0VYPDfMnXiAJv1buRhFydEm4uVKSb2St9HOdwGhZOWB7igaSq8uqIEJZp7deAGFH0cbIMMXABhxEjt3Kbg//Q9k0mclqPGKgjT136puwQP92oYN01hbc/qJ64WUHgXzm4CAveIwElGwrn9px2tR2XPRSBK2IVot0AjyORIr36s0b6SkRvMhQe1SQuVeWfUevuNuGNbsKQFUTvp8BQn+xMXUPPFvVJAm8oDKA79bFz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnuj0AwJz0QpobRw1BIRx5t3p6X9ByUdS4Mfr8ukzig=;
 b=D55B5m++eC/O+m7RHtEDLYVTaJoYvcIUH9LRZZMeKNIbQUlJYkXDRhl1VUew/oJFVOqiyasdxgv/ZFNTfJjXwMbaEzQJGvBqf0LDrzGj/GWv/lomoomLo9gLNts635spPrSalKXV0wFgZwKT90RMegfCeC7L6pVW7GsdVXqXD2no8sb6XWOjbNp+HGSZRK4yFCdktzVommVzlfzKM76dOQduBbGOTFNd5EKT/ZhJlQTlgVbEdkJDN6XY68CgUN3BJT5F9L+BVUOJl+AeYQr1jG9TQtt106LmhOoBYijYFfxBJo0cXuqoxKoOiahXSnl2jhD+lqiiKLT7INdMB6A6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnuj0AwJz0QpobRw1BIRx5t3p6X9ByUdS4Mfr8ukzig=;
 b=klxSLz5i40ViA1lhXjlvkHTEkh3F01L/hkqh4cO/ov2dBrEi03AuYITsmiCb05TGqZy2cEoQR1NaC25k1dPTdNWZzBo0LnIH7wc8MmzQW6QDCSoTwgR/TdvX9jltGv1YP+mKGijpk7k5JsoY3rFl/QywyseO8pvS5kF2dBlo5Qc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4596.namprd10.prod.outlook.com (2603:10b6:303:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.29; Tue, 15 Oct
 2024 18:36:14 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 18:36:14 +0000
Date: Tue, 15 Oct 2024 14:36:12 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/mmap: Fix race in mmap_region() with ftrucate()
Message-ID: <bxfc6bku3emyv2f7ukcspjznermiphomr4kxud5ow3vyfnjyyu@dlehi6dwxwmg>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>
References: <20241015161135.2133951-1-Liam.Howlett@oracle.com>
 <6bb63c4a-2ef3-4f38-8639-db1f0455c870@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bb63c4a-2ef3-4f38-8639-db1f0455c870@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0396.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4596:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fdb5ac-46e2-42f6-3fc5-08dced483fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9KsAyfQvzLcgn9/xXzUxhO41cHyEXGxLKpNFEh8hVe7HC/ohV8Y2bGlyiquU?=
 =?us-ascii?Q?yqu3IEX2IOf1gXhllPcVK22+0ffZzUZocKAhj1L562MrDgKgN6cYSHWSqCbE?=
 =?us-ascii?Q?+ADtulpnrWc6Bjd2ZsPebPWEnGVLNTWBgwtjkmIpOTZpRjKTUskHuCgE3G4T?=
 =?us-ascii?Q?BHKHty4lMDa+cioOVzoSKPSFpQcdJgvZLDG4ArHb642ddAQf6MZrCa3VS6sN?=
 =?us-ascii?Q?hKsOsVMOMfmOGMX+NrzefvPJhSP8b3DNzBRIYeiDIGmJjs2WylweIbzQATx/?=
 =?us-ascii?Q?Mu/VlBoF6exRwq9lIBP4Wzej+ESrjJJYLkZ9MR4PVh/X1Z9wWYO/ymp8QNyU?=
 =?us-ascii?Q?01AIiUkl/Z4mkBngi+DnY1W+s69bH8Ylu3t5QEqYcMmk1cuVGEdRCFqSq6Wm?=
 =?us-ascii?Q?BRT8AYN0Dtkc885HsX+U+pxHgUCQb70it6VUecn4TxGQ9esgQ7vYMvSbULMN?=
 =?us-ascii?Q?VqaxdaBFT6Mc5axFgK1m0pwaOVIR7I37c5EQz+dYB5zNDCRobZj/fSKiN9td?=
 =?us-ascii?Q?HZBoD8AiugrNV3IHBAJ1s1eU0Xw4ccwsX88POGUog2PBhJvHsIxalG3HY+b5?=
 =?us-ascii?Q?sA1qSNcuvnFh+Rt5smbvn7mw71ieI5jaK4iN8XyunrOgS9ZUpUjO+okfHEMG?=
 =?us-ascii?Q?WYQAaHQ4RVEAjFWEI55nwu/IFoMjvJeFeplxvrFk22CdKjMyzHhGKUK5PHmi?=
 =?us-ascii?Q?nbBdarto4lmQugbRDe3nsH2bKjuIajyVKb/0PHwbyaqHAO6+uSAidJO/Sxlk?=
 =?us-ascii?Q?hWtfC1AXoZ6JXrbaPaFpg5gsgNV4zYqC1hGDI1+u/B+ynFWRFOTGwo/ku3F2?=
 =?us-ascii?Q?w21HtXrx58r48QhTzmUqwrORsYv/3inbeqykJY7IujikJX6eb1j5Ao5yEnGl?=
 =?us-ascii?Q?IAad+n0DehfEsoy5gRd8d7ApmJ+bMMTFHelGWM3u3bChIeU5WxB2s9ZHH6zY?=
 =?us-ascii?Q?376IUTOU0n3GXY5vmvA3E4O6BRAv6xMmrI34AYO3tjMU+sGPZucZwuyTlKU3?=
 =?us-ascii?Q?hPRg6OIV+0Sg/KqruZUDA7he6b5wq1D+HfoS5HqzMPHQGwnnDCDftp55tTfx?=
 =?us-ascii?Q?oXiUWk3kMbIVh5PejLD3UQUcjKqizneaPqNtBLUgxrFSAMjQcP+vO72VvfyC?=
 =?us-ascii?Q?PH/iLtCwMkWQTl0lT6hX7/ufi7BLC1ku+Od1vSbIoT4fdV5PD8b3u19PhFBX?=
 =?us-ascii?Q?gvcT6WtYTJUUwyYwHAn0BcvpOWlBYpXT74UYV5C1a+5QZiEc1+rxtMdYRRDP?=
 =?us-ascii?Q?wV4eStqqGTCaRupRemedLibcL5CaJNUaldxtGVvEDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EmpSJeGFlFpwIciZMx28R/5tzzzSIvp/hU8x33uvgu512L7/iBuxqimFFwfo?=
 =?us-ascii?Q?ZNcfBA8X4ycCVTATXhy5MFLsZ6I63pumQ0HfC6LlDNcWnoRdgT6qWGBN9E5/?=
 =?us-ascii?Q?EOwIYaam77xIZG4FT9mXfBonX4dEOlu/FKyy5805A++Iuu3nghq0LcWnCn1X?=
 =?us-ascii?Q?ef+f6b8Mim8rOs6Og4OpZSzs+g27h1NSaNat1bD5FPpu+y2J5SgG0/tik2BB?=
 =?us-ascii?Q?LxfJV+XL/EAICHDpq2j+1Fu7r5lqp1MI8GzzbjkVXDWz2QYl6dMXHSfKaho+?=
 =?us-ascii?Q?YW+0StyGfa9Z5yZnE4reeuqLyfubWgfZeDCJdxQJGmN9LwRpHwDnFEAw8GZL?=
 =?us-ascii?Q?8SFIpho/+F3/ab6BFwS0sahk/uGI9EeAyHrT4yohTe0wO3Rcr0PK9T1QH3Ob?=
 =?us-ascii?Q?nWLe6C/3egHUYpp/zn2FRQXXL8X4EJBEQlVF0D4fp5sUumL0wjTvEiPdy9In?=
 =?us-ascii?Q?OL6PRhXjL0eUPCQOdPybCq4NNI9ImYxNPLMdnyoKj9+aQCMCyjKw2Guut9K5?=
 =?us-ascii?Q?wKXrbauGdjS9zNQEFB35IbrqaIVnB1vKHv1mhDn6puX78MjDUsbDejjNBASm?=
 =?us-ascii?Q?oY1Uwjf5iJ/NrSz6iSwyp4Fgqhy8CZDvI8aQm4lWwz1sTepyulgu/cfVbJBl?=
 =?us-ascii?Q?wwvoIosdblR/DexGnY6NJbzSb3MfQW9GKznoeNj0ncLv7Cy5D4WDrxih2hSY?=
 =?us-ascii?Q?TuJ0ji2JskPtzXap+mwm5hTGT6ldMicQA/SfTapDCLPxLnmJdYpv+i8tPf5l?=
 =?us-ascii?Q?E33+JsNXG4caXcIUQc2VplVgfrikkH5YUyKtTC7AwIQsRSeF/sGj1ybKvFi0?=
 =?us-ascii?Q?+fWq6490KuxOzTOI0SYEFVHhK7Zi6quYPIrnTaBcVnsqJyQU+QiQGV/QiaXV?=
 =?us-ascii?Q?Nnb5JnDoSCWOSZi9w6GLYZHCiHzxLdlde+FA7Tq+QqSwFzGBb9mtVyi/zxCi?=
 =?us-ascii?Q?JHMivEl6nJr6IUvxQ9v5irfveoCEqx3zPMOukXfo5+AEAedR+Zwp2oCeaiab?=
 =?us-ascii?Q?9TY5yymwl+yE9hhk1BAy4PPqRjOfvrJPpG+MGqgcTH3LwiDw/TfRTrj3bXqE?=
 =?us-ascii?Q?bfmjOGzcRCOHwuVyjY3qjGloDTLblQaSPINoIYDTjM/+uETU/+UPVW2cCIdu?=
 =?us-ascii?Q?DIp1q26hJS5XxtSz0qf/q2eFPTCS61Ckt8QujgBVmFLtSKAogexf2e5+kDKZ?=
 =?us-ascii?Q?dlJpRBdCCJ8SzC2eXexx8vRdKHe+ZsyUbvGeRwkBJFLMAFOl6d5eyPsSjNaM?=
 =?us-ascii?Q?8FDkXX9hXeXn8WwIPdktaQyQvoHrQiVIzYToLrRC/KrYGugiLuS0ZiMk84zL?=
 =?us-ascii?Q?4M8dcV9eqBm4YCYZBp865CqMW4uYbe8wtDdJWjfvliZ+bi/julfKD7QC7frP?=
 =?us-ascii?Q?Up0ExgzI+39bZM3OZzoSmuoPiJqyouMtBmUh+3wqyfaQGoN1knY7vD0kHn28?=
 =?us-ascii?Q?Dm1e0oPJsAIrvhANFbQxYOwrC2Wp+l/LAW3MoiCUCCf0sLBlL2S6meyfH9KX?=
 =?us-ascii?Q?QgFIfpRwGqHTVrW4B7C46krm3Xuq5lxTLmQmgmfD43udKsOqhOkPmM4W0xKv?=
 =?us-ascii?Q?zCKK41sOqc1hgIo0F5hv7kDz5UwA3vn6KFQ0pNyUgFUFiptdGLQJOwIEfrkQ?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/l6h0+0LF3RTj0nsL3zuoEUkBPsY2/Majx8dG6j8Zjvb9gYIIeKr1hH3Tvcudy4d/08a8TpoJVPbpy1xcv37miXd5Xbz+AKX15ZRjS/N2LF+onhXxga7L/7ZMGqoXHiLg/+M9D3DPG89UFe9ghwSGI0DtW7FOA3/rm078l20GMaKMrKSZRqyZuIX1qIACu6uQigD9y1pDp2EP4PbDx4HlT/vrVDwyKG4P2One07W1tJbrx9EtKC2MyzIr1o6asJx2I8FlVp+Hq2qps7y2SSYpwRHsJjPLtxHgZCxsIDQuih0npgTfINeFmp49xHnjR+kRtqasHLk6PcHgggceS4VdlBD47bSyaYwMMJaQfFDgtNB+F488yvZDBTAwX6WqPe3MJV5VGVaPxYSxHh7ZXCi9tdjyx4qyOy4AQxG4agnJ59NbyDbHVlD/Pdx+M8cONaLAkcrIAsPpdPNiNpEhgkdRGZYriHMqkrrSTFWK/OrN0/5Ug/4MveMkUHjaXN4PgSZK+SjeJdUs6/uK62Jcr4fL7e4ClsBf7Hf8uIxLgnTSGsj1LLSqtIL0uYQRPaUxskeCLloVyrb4NMkJkaKCQVnmHUcKItLpaoepKNU/dHwobg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fdb5ac-46e2-42f6-3fc5-08dced483fc0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:36:14.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBOKcziBu4aaoKpJlRyOib00uG7Ejx2Jr6MOwffJlWSlTEFlkQFMpJSt7JUMOMrM1MHaJ4vJMGPSmHNdBxrqew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_14,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150126
X-Proofpoint-GUID: A0-ZLDpuxuNDIzfXQLXUgGISkUn8nyWv
X-Proofpoint-ORIG-GUID: A0-ZLDpuxuNDIzfXQLXUgGISkUn8nyWv

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241015 14:23]:
> On Tue, Oct 15, 2024 at 12:11:35PM -0400, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Avoiding the zeroing of the vma tree in mmap_region() introduced a race
> > with truncate in the page table walk.  To avoid any races, create a hole
> > in the rmap during the operation by clearing the pagetable entries
> > earlier under the mmap write lock and (critically) before the new vma is
> > installed into the vma tree.  The result is that the old vma is still in
> > the vma tree, but the page tables are cleared while holding the
> > i_mmap_rwsem.
> 
> Nit: old VMAs (can be more than one).

right, okay.

> 
> Hmm this is not correct I don't think. We are not holding the i_mmap_rwsem
> (nor could we as free_pgtables() ends up manipulating this lock.

I meant we hold i_mmap_rwsem when clearing the ptes by calling
free_pgtables(), which does what we need in regards to locking.

> 
> Rather, free_pgtables() unlinks the old VMAs from the rmap before removing
> their page tables, the key point here is that we have not yet established a
> new VMA that makes page tables within the range valid and accessible.
> 
> Before we did so _prior_ to this, making it possible for a racing
> ftruncate() to grab a PMD right before we free it and then UAF.

You have totally lost me in your wording as well, but I get what you are
saying.  I'll try to make the change log more clear.

> 
> Now we make that impossible.
> 
> So I'd reword this to that effect.
> 
> >
> > This change extends the fix required for hugetblfs and the call_mmap()
> > function by moving the cleanup higher in the function and running it
> > unconditionally.
> >
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
> > Reported-by: Jann Horn <jannh@google.com>
> > Closes: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
> > Link: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> 
> Other than that, LGTM, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> > ---
> >  mm/mmap.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index dd4b35a25aeb..a20998fb633c 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1413,6 +1413,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vmg.flags = vm_flags;
> >  	}
> >
> > +	/*
> > +	 * clear PTEs while the vma is still in the tree so that rmap
> > +	 * cannot race with the freeing later in the truncate scenario.
> > +	 * This is also needed for call_mmap(), which is why vm_ops
> > +	 * close function is called.
> > +	 */
> > +	vms_clean_up_area(&vms, &mas_detach);
> >  	vma = vma_merge_new_range(&vmg);
> >  	if (vma)
> >  		goto expanded;
> > @@ -1432,11 +1439,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >
> >  	if (file) {
> >  		vma->vm_file = get_file(file);
> > -		/*
> > -		 * call_mmap() may map PTE, so ensure there are no existing PTEs
> > -		 * and call the vm_ops close function if one exists.
> > -		 */
> > -		vms_clean_up_area(&vms, &mas_detach);
> >  		error = call_mmap(file, vma);
> >  		if (error)
> >  			goto unmap_and_free_vma;
> > --
> > 2.43.0
> >


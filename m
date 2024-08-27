Return-Path: <linux-kernel+bounces-303216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38513960924
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D552B238F2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672331A3BAE;
	Tue, 27 Aug 2024 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B7TZ0Jaq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rD8dCahM"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131021A0707
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758885; cv=fail; b=mb8GGmqpQgfZbN2bTkN/a+ucYFQY4nQVmUHQplR0oVGoCB+97vcmSOAbqH64dfjYivqDOSIcbp4tUmlGi7Zxeoebmk+9PHnOREurzp7FGRefGHD1wYUzM6nikqkK07ekepXpRv7kfeKwSbEP+FGgghS/kC2ak1V3cqea3VcjoO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758885; c=relaxed/simple;
	bh=9053K+K+3AufhiLzrfWYuPWHMA+E21u+bHCK5wqqpAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tfv/dzNGN7gtaj0quUiVRxPfHWBOO4QhRhrjgnzd4yu/02IWLl3doyCrr8x7kFwfuWBubyxz9XCBBNOJ4n+QAMCQnk0PuLKoEC84cKXyLtqFbx1ASCIyb2y5fDaRUimO6nehxWc4y81ydGAktix9IdOifUrNePMO2kRfoZTjMVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B7TZ0Jaq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rD8dCahM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R5trKV030635;
	Tue, 27 Aug 2024 11:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=DJrV/Pd5g3tMyJB
	S338taYTW6zp3MJcHk3zXsUQISI0=; b=B7TZ0JaqqlJsD7X1Et8fJ/Ny1fJDEy6
	gqchxyD/r3FCWijF8YJW5qHiHtlxYhvqOXApg1uQlO+aUM+WYO8/kCizMN/XYo2d
	/OHgyauY7G4KVjUFZ8WEgUkzdeGUann85JqURGwwLGiHk50WkPvzGqWHAAUepTJD
	hL4oeIrw9bjpaBoFmZ+JZzOr74HCsLkUQ3/tr0ShA0M4HMVE4SgHuxWr94hEa19a
	1zQOAE5aFBm+zoVQkSAmfPtsHe/T99NyuyHvwVY2hflYjuE/2So4qs51/eB8Jn/o
	EKn0wL7kXLFo8qdziLxaoLJmqyy2hMayKThAHLXFV2vVT5C38JuuD4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177ksw8tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 11:41:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47RBVLtL017403;
	Tue, 27 Aug 2024 11:41:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5s7mmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 11:41:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOrhThZD4WcbLwialxi/to3AUuiSrcQ8mZN6Tns9ZUw/2EvJCrLQ1HMNOuKK43uQk5yqLWfisPkBKyxmbpXJ89h+5WUsM+849aQ4R+rq19YEiW+ngXPiSY0ZoazmP3Jm9qF2yxjwFZzBRyuXwvCjtNKQzdSZ7/HMMiRallozGNSvQpg1k9Q64D+PwMtHyMaBReo5VVMWfaj/9qm49gvywEr3O/6vh54YYq8iRzcYqh4o2oubmoIf6ter6kAQGcz4IGcpiwGzctbnIeIwwmPZ1qbL2QshG1BY6lK+P6ZQM2S+mguCx66Nos75TRSYza4KyVZLyaGL13oJMB5laAQIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJrV/Pd5g3tMyJBS338taYTW6zp3MJcHk3zXsUQISI0=;
 b=R9OrWJOXNFjK9hvS+qNL1Ei2kRm/7m9Fe1JhAX+KrKy9HU09+yN6e6a5maYSC0bpj0SrdJz74Gl+vpA6BngOu1UrFDTVFfe5UhpQ2+XkYZ4hvd2nNDIGrRataypd1DVg2aLEUD7Mt+ZQjc5AU5IHrtpgqbdFBeBB9/j6y0Lul9t9UgPZJOlmCRtlSMz8c1U5JRTqSyp6QdW2QXIuCLN/YCRkNPbEzeVjZNq9aiRzRYt9o72pFZ7pT858nbyoCaMxOhKSloylR0vLGPsStrBTtHgT938vulprREnKORCSfQsLQKB9JKNj+nKPl4W/MFCRhlj9O9O51qy9vWPhDcpnuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJrV/Pd5g3tMyJBS338taYTW6zp3MJcHk3zXsUQISI0=;
 b=rD8dCahMkpSAjBZXLFpO/sLX3VQFQhLeujg9dLYwYIYoGZh9wtMXSEZaIhFFridAm8/cIUF29HysHkmUgoaU6Tlo9Boh0HCARxP07PBOOdHKicFkPxsz36dNuS9jblulh788VvFTGLNmv4p2Kgi01BDal1aT94BhZvI7NuuvU0U=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB6015.namprd10.prod.outlook.com (2603:10b6:8:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Tue, 27 Aug
 2024 11:41:05 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.017; Tue, 27 Aug 2024
 11:41:05 +0000
Date: Tue, 27 Aug 2024 12:41:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 06/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <c0ef6b6a-1c9b-4da2-a180-c8e1c73b1c28@lucifer.local>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P265CA0252.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::24) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: c48e8c91-5b09-4a1c-19ae-08dcc68d22a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bjRjMo5QZHMw6+KdKr+/Pfm53ILyZp6v2VaozwRvltTAjLkoBXMMobScEvM9?=
 =?us-ascii?Q?cFe0n7LkPa3ljR+kBg5rx7G8DGbZEOtrV2m7Rfm7fSH0mtonDCOq5UwsUpdm?=
 =?us-ascii?Q?AiHyTCKnqBSILNVonoAjOSalAuiXYEzbWlDt24X3u2QzXfNFpN6PDYZvCakv?=
 =?us-ascii?Q?qLKo66BEt6HBxqQYlOQ3+BBS9AlXLCSZLlCczK2TJ5kvR/kvWsTZjJv0PQd4?=
 =?us-ascii?Q?q1Dm29iz0MHcvF33uaW6ginxkAylvWr9BocWic5wfgCaMtPNPFXtTZj/kvtv?=
 =?us-ascii?Q?Q/ZAUhGZ0f1pLGr8rpqYnHHhvHwf+D3PavZmxwmwiJM4I0a8h4TDqhmm3Scb?=
 =?us-ascii?Q?lKk4KVXjl0pkMCo8iZXWosbuYyYP48JysNi+VYxUTAS261X0n3JkcGvHoeP5?=
 =?us-ascii?Q?1sQCcSpUhTBuQLWjLmPLP9l6iuyR2dZ+RoZziKne3nFaVxF1niig+mB6k5/V?=
 =?us-ascii?Q?IoEaVi4mYqxy2Xoelx70ix41pyhidOw2M0q2mOE4ez6AliTTKwoTrsDA1kU7?=
 =?us-ascii?Q?M8ap2gCbUcx+HNK+25m2O7an+O23USuGHEOUoydrLtYqTEHTYpq5N/kb35S7?=
 =?us-ascii?Q?j8SABTJGaCp+mYTbYuGZjcyMLUIlJ5+ANnAECJdli71ACluW7/YctwSrXJ4e?=
 =?us-ascii?Q?EwbAeNQKPfuE8xkwBGFB/TKAlu6tYs28a9TNxg80GhfwFWI1EIKZvK8B6mME?=
 =?us-ascii?Q?tja0rb1wROdh0MeZprT9fp6ycQBPmbhxoTwo66jQXnkotmBM2gQbHDxueBTV?=
 =?us-ascii?Q?fHx2WmzDcO2sWZoyU9WNaBQ7dRLu9n42PwgqujHP6zx9psTf3imC/87W2rYW?=
 =?us-ascii?Q?tW4y0mgq2Q3uvKi1V7/Q0G6P93X8cA3T64DBWw2aXG7WKSs1sVDtROzUsDft?=
 =?us-ascii?Q?CDeDhhOQzxg+dU9Aiyk+hMAGoOP6TkIhfU2dzUUfF8RgOGZOXIqXgYSKZU6j?=
 =?us-ascii?Q?9JyHzV8r/Wq0sjlPItVgoMqDWdbf1B4xgPUzHJYrm4eHJX1GOzYRMKCWczvH?=
 =?us-ascii?Q?I1yJGethJ4E04HqgtXeSAMM8B3Gj7Zbcd/H6VeqahQ/qNewUYjetLyNb1E0s?=
 =?us-ascii?Q?yHWhN7Nku3RY3OKVzIQgU4BsuhBcvX9KiTO0zSpBK7yhHsQeSOSqLBIbLwbj?=
 =?us-ascii?Q?YBA+6axB+Iszk5mf7TdnKAItxnmZ5CE93+U/jhlXdzVEa6xqEUJC3j/1RAzq?=
 =?us-ascii?Q?9yHPdLcj7aDfz6KJxoEtuTxcLT3iHHzkmwCL+T9gD4oWB7lU8l7WJQqayUp5?=
 =?us-ascii?Q?RCiHyu05oyAX/xDYU+9uOqsSiXzJfhqIfs3whNRtciH45yjCu4k+2hwtTxs8?=
 =?us-ascii?Q?yeAdL4KoSOJGkF0XVKv7kVm6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CDNyfLKH0IoqVU++z4I88UZyeEO23qvEsgIkXDdSUpyijJNMZ+Rl+hErlTz/?=
 =?us-ascii?Q?a2tkFG8HCkaeSnJvH1K9KS1z8zCHHek5WGC0g0hfFp0ZB/uCvumPiSkJ9Wpt?=
 =?us-ascii?Q?2tudIUtr9rV/dOA2YaQEk6yfkKSSnW32UmziyLrfRVLd8xy9B30EWJmT6WVj?=
 =?us-ascii?Q?CA9njZOvkIMO7Sxr8fEqN9D4OWT8y3LhUam0Tq0pTE8+z2OpnliWeCBXMRFd?=
 =?us-ascii?Q?Y7henjA6SgwNTrOI1f3zrD3YnMrQfRhpCscghpTfLhyFG/iwAGC+QDq7JoqP?=
 =?us-ascii?Q?GwIAdvMkXuB/CHJTyrsC6L3FLzJjA37uUdksyMW3zroJP2vpz+1hR0naOu+0?=
 =?us-ascii?Q?TRqGISQeHFfq5nljhY8NxVpPJe6MtUx2ddoGOSMNioAcPJfZAICHCRX+KGnT?=
 =?us-ascii?Q?VHyr77v5rfegv3jBVuxmGEC9vYU8SENEyJoiuklnV82mIP10p8WLx0vpFFqM?=
 =?us-ascii?Q?duDjo+Hd0/yF0wCOYzJSyR9Ew/t7wpKRm2VBg0oCOb2MclDJIP+OabIjlwSG?=
 =?us-ascii?Q?YlmYFU+tGnsIZNHG917qavu1wplHzHwYJPj5ibrsd3DOtAFHSO8rrozzMLa6?=
 =?us-ascii?Q?HD0sJ+d91PO/LZ/UjWxHY9IE9Dl2o8mC4muRAvOoRt0rqCriWHg65l3fqC8c?=
 =?us-ascii?Q?7CKojNbUsS05RsqOu/TNSYAwjm+G412G7Jl5/c9BamPbY66nyaU8qTX0Cyfm?=
 =?us-ascii?Q?kXMykwV/OYk00T8rPllbogNhHLWcJqH5PcmSMw0MxWcxrglVkHiZeqQPOxUi?=
 =?us-ascii?Q?ZYl8yitZMVyuCuaoeXPOgZSFyFpYMnrl7ujb1xDBjWPqVR3qqkgz5XSCqe0l?=
 =?us-ascii?Q?FKNubMZdBaXMpl0FfHx5LKPQh4qdHlZEmpTaqNPpWpIT4BxKe0K+6+d4xJlr?=
 =?us-ascii?Q?KvzTk8HmmcnsqJuj4VmBuo1j2PflmR6B3ecssJ2t0EJb/BQticxLncXzdejG?=
 =?us-ascii?Q?OaRr1f4jtNqzAois66+K/sUX5v+dvxVL8A806djkRayVav4JPJ/cwHyASIcf?=
 =?us-ascii?Q?k8saWxvkbERHn2W4TDeZrmgWgteBh+Z9TSLphvYXvdu1Fr210xu75v36c8Mw?=
 =?us-ascii?Q?mjYAsKzKFoHS+poJ0yRcm5UVbsZPFa2E+K85YAXOKXAqO9bEj8XFuaZIWqm7?=
 =?us-ascii?Q?X43a5BzR0Bay+LrL4oiTQIRg+IQUbqe1t95NWwpcOQF2Bn3ngOuG1YTzvtSH?=
 =?us-ascii?Q?sjm2Vg5tMir6eni0TovTkGvizIfJ5VEtqoNc4LVEchudf+dupgrYO4aPvPWv?=
 =?us-ascii?Q?D1KK7PJB3ug/Ltke+7kJ/07QenjQTJdksEW9APWySevT/RhTCc8o+P8a1x9M?=
 =?us-ascii?Q?ZTohKa79Ej2hF4LxjVqiVpa9D7OlU+/Qb4gVcFXTUvXT7g0jAfzXTcermDGT?=
 =?us-ascii?Q?FfjHKbWX+cax0cc7EkhFLSjegR9O+XG11+DMyUlvGRHjE1zOGGMzxvCM1bG4?=
 =?us-ascii?Q?BubDOOmfhPOI0xJVNG/D/xE2tzacNm3pIsU/txwnHS4henJ0E4QcZyGgupLY?=
 =?us-ascii?Q?4sSk1VjiPEjAXAdMAB0VJc3zQDsc1vycaR2+cKWOrwFmMn38Qj3FrR8K0FaZ?=
 =?us-ascii?Q?WHQojOrtLiS6+bvSrOXlQVVSCiZW53E3uky+iTD/Hv2vYNyQiSABv/PXpMjO?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LYZtwd/EuG+Pik1SCOESesvd4RHYhAaXdf7ILo/YDjraPayLSzUhAr4pJMDBT2vAoBLsL++S9PR8hLsoG5DC09pqP54qcMbLPEBmok8H3aW7IQHSm34Dt6ox+lPh+YVE0yToaVgZdKXCjmhi9w1XpE6Qm/261Df5qaAJioMd2jeqXv/4Do4JE+LMrvVOZt+GLV+qgucg53U9dPt0PPw89lzGD2rghvutksuzmxi0QCkuLeu/M4hmt6wEkmPkl1VWHaZ98kVDl/nomZQL9ZHdAgS9cjwlLFQi6Bg6fD3fM6Hipgh/oscpC5eoL37UQvQyezIM6drgUC/AzIAraemcwAppqhj6rPfxcWhswFa7BUujhzSU961oFt/FKXCXstAYPhcFNrwP9F7VeOTKWdwq0/P4G1Yeu6iRZq9xz89/ws6dCsJjnoNW9p7wvV2WHvGG68ZDeR+KTNBpGPvOMm350rP9OjadXfe0yUup9RLibOzXcAyWDUTtwn3/KVahbUL0fUsRMeyNq3n2iMKuEgB2iDAp5AOlE2Nl6OMp/eMHUshJGXnkFSMQTJlVdeF4/OtVQYgS4M6xKn0maORRmTX8LgbeT19SwWhNu7We1saYbRc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48e8c91-5b09-4a1c-19ae-08dcc68d22a0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:41:05.4697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gY0p1GZajQcJwNX1IdjnSTaF7ZDnKoOLACx/6y8PBUHL++cgKh6A8Lghh8UOEIBwoqpmUC66jDLqa1bpx+LPwE8p5gCK+C8MV0eYaiOYKfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6015
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_06,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270086
X-Proofpoint-ORIG-GUID: MVHWGe6EPHzgWTveAzfhMDpCkWOYQY2w
X-Proofpoint-GUID: MVHWGe6EPHzgWTveAzfhMDpCkWOYQY2w

On Fri, Aug 23, 2024 at 09:07:01PM GMT, Lorenzo Stoakes wrote:

[snip]

>  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> @@ -1426,9 +1536,10 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  	struct vm_area_struct *vma = *vmap;
>  	unsigned long vma_start = vma->vm_start;
>  	struct mm_struct *mm = vma->vm_mm;
> -	struct vm_area_struct *new_vma, *prev;
> +	struct vm_area_struct *new_vma;
>  	bool faulted_in_anon_vma = true;
>  	VMA_ITERATOR(vmi, mm, addr);
> +	VMG_VMA_STATE(vmg, &vmi, NULL, vma, addr, addr + len);
>
>  	/*
>  	 * If anonymous vma has not yet been faulted, update new pgoff
> @@ -1439,11 +1550,18 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  		faulted_in_anon_vma = false;
>  	}
>
> -	new_vma = find_vma_prev(mm, addr, &prev);
> +	new_vma = find_vma_prev(mm, addr, &vmg.prev);
>  	if (new_vma && new_vma->vm_start < addr + len)
>  		return NULL;	/* should never get here */
>
> -	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
> +	vmg.vma = NULL; /* New VMA range. */
> +	vmg.pgoff = pgoff;
> +	vmg.next = vma_next(&vmi);
> +	vma_prev(&vmi);
> +	vma_iter_next_range(&vmi);
> +
> +	new_vma = vma_merge_new_range(&vmg);
> +
>  	if (new_vma) {
>  		/*
>  		 * Source vma may have been merged into new_vma

[snip]

Hi Andrew - could you squash the attached fix-patch into this please? As
there is an issue with a CONFIG_DEBUG_VM check firing when copy_vma()
unnecessarily moves the VMA iterator as reported at [0].

Thanks!

[0]: https://lore.kernel.org/linux-mm/202408271452.c842a71d-lkp@intel.com/

----8<----
From 53b41cc9ddfaf30f8a037f466686d942e0e64943 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 27 Aug 2024 11:59:27 +0100
Subject: [PATCH] mm: only advance iterator if prev exists

If we have no VMAs prior to us, such as in a case where we are mremap()'ing
a VMA backwards, then we will advance the iterator backwards to 0, before
moving to the original range again.

The intent is to position the iterator at or before the gap, therefore we
must avoid this - this is simply addressed by only advancing the iterator
should vma_prev() yield a result.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202408271452.c842a71d-lkp@intel.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

---
 mm/vma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 8a5fa15f46a2..7d948edbbb9e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1557,8 +1557,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	vmg.vma = NULL; /* New VMA range. */
 	vmg.pgoff = pgoff;
 	vmg.next = vma_next(&vmi);
-	vma_prev(&vmi);
-	vma_iter_next_range(&vmi);
+	if (vma_prev(&vmi))
+		vma_iter_next_range(&vmi);

 	new_vma = vma_merge_new_range(&vmg);

--
2.46.0


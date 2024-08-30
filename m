Return-Path: <linux-kernel+bounces-309014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1213C966530
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840131F249B1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5C71B5838;
	Fri, 30 Aug 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BJBhTWe/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TA/qNjsN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4E1A4B6C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031213; cv=fail; b=FNCYsopzAmGR8HLTvO8Hrw0WGw43iF9115VYJARcvHSHDex95LSfaX/dPCxo+4PgdSLaNKUyW3vR9INugIjig5yZRwrX7bt+mjLXXdGrrKJiTBEbKaGu8K3gxNttlYB8SbN88+VrTaT03aQj1QbZGxQsWhGwmycKud+5FwiOPUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031213; c=relaxed/simple;
	bh=dxZ7P3XLWFFraUyhPeeI6ZrlAFa3Khkqyo7YOS1/3SM=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s6oCP7ij85ym/g9VxN3+OHCtDGSvzXt/x08yX4YlxhJ3zIAmqAxPjSHgTvBpUA/ZgBeDbf245d4NKFVr2Z5MvAcZUPm7HsrVtFIuiPvVO18D6EYaTCZ8bXsxpUmA1gD1dwMzO7A+6ttoIxstYnzVlRq0kCX59twOERfm0MQc6Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BJBhTWe/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TA/qNjsN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UE0VSK018906;
	Fri, 30 Aug 2024 15:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4mbI7mBQa+oyDcf
	+Zsec/e3l4oZ7KW3svbn8s/Wg/wU=; b=BJBhTWe/OhRuCngdqyTEKYRRpYBwcYL
	MYnqdWZXORLQUOzgmeNir36Su/zq2tcsZUif9mo6VdBVCP4uma++Fn0O+YEA6zIS
	u1y/MCNLS5BOwJL3PdhqaSgo5+TG8Y5KjGzw809x3tozzQxFMjJ0a24h84/FseMG
	LYNjzJ1UG66Ly1E7akdK4mdKNLzpHRW41KY7PWVN6+d0d0FxowxMV0mF3DvZ3OBA
	Jwrum8W34yfO587i2CoVzUpmyVU3k1Vk9G0Wy0pkVF1Nk1wMm+fctw81xa7UDgwO
	Lcw/i2/jBOPpQrHGwClI+q8+lk/omc30nDF7/HBj+TtKLp5ZFZIzlew==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugy0ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 15:20:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UEt6ER036491;
	Fri, 30 Aug 2024 15:20:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jpqb45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 15:20:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHQ8tryQw5Q64tLELUE4SNGyqwIcqZ5lJz45SK6lxEKccnt6YTzfHVXhEIATZobGuoog14TRtSmVybi8i5USyYBUqri7BmcGHtqHIzee4Hps1Fy0XGUNaeGzKTFM8uCS1qhytJrsHpjVdAwL+i/Fe+KSOAPzmt1RWsgUZPiaCuzUgaK+bUcTteURg4QcMwKGWEIxzJm8BcP8zs0l7ZmsvQLS3Zu+mTaZqRsVxGtOHepWRCjxCxvpcDItgzSz4JDgXLAt+Sd3SDfDqMW0x5srI7OBR5jMoQZRq5u9ARb99KoBgQcg3CyFRJtY5GMfreAwKjBA8raNuA67FAR/B6DnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mbI7mBQa+oyDcf+Zsec/e3l4oZ7KW3svbn8s/Wg/wU=;
 b=HcD5Har+wEjYFj8xa2G7R6f8xpOgq+M+7uxmLo6D6X/H8mryr2SXGae83hcdL367V13xMjjVvctDm1EA0Ri/SQrYLOegFD73cuJg0yp3ggiqPQqDPOpi66NnnPUrXY/9P3RzAroBy8WAqYsCbznXXlOn4NY7ncUC8lP8W8UZO3u9kyOe0f33RkJGeNA4wREQ7OviSM3KoOeBw8sjEkt1nsi8hPUDrnPHyL2qgsq1ha20c8p71abdRozo64mLHInkaf/wS9GNxyjoE6iw/XSp36HXgGJRBj1FzWEe1IGNvrdjDwC7pwQqta/pNgt8LneqICopeIA4Lc/TWs5THQG3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mbI7mBQa+oyDcf+Zsec/e3l4oZ7KW3svbn8s/Wg/wU=;
 b=TA/qNjsNztR1wt60uXnDynFQKtre4aMSi9V4taWUHIx/HtxW9N3fBMASLZyxgMTUc3A5Lk7Ryy8jrx/PiHnTT5Lr/K7XSpxaxI0eYtOAnMU5miHpBmSRte6ukjVg8JN28x6Inccjv8qPDmLVpPv53001JBY6aPz2X5uxXB1+jqc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 15:19:58 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 15:19:58 +0000
Date: Fri, 30 Aug 2024 16:19:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 06/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <5b641d45-3898-40c9-8288-f2aacae1400d@lucifer.local>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
 <yyywfqdagobkzz26znuqgembxq7jkciq6kbhhhdvo4gox4idke@ixtspzmu6ttv>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yyywfqdagobkzz26znuqgembxq7jkciq6kbhhhdvo4gox4idke@ixtspzmu6ttv>
X-ClientProxiedBy: LNXP123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::25) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 311e3462-27db-4aa5-7ef9-08dcc90735f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ukNLqP0sZmUkzJHGi5qhp6X5x4j2xt/NCDvf4ZLM1s0VpIhGITn8S2X+6UPG?=
 =?us-ascii?Q?tHx5WtpktWw3bnKxc497A2JuaJ8SKsiYi5m40jAXJkusEpgYP+ZTG1ur95N4?=
 =?us-ascii?Q?Id7QdCZC79hs/Ka8Z3AhuJ2czwJ1wCdEpEcVKbK7b3Ea1m0ZyLsvOOEg/TDK?=
 =?us-ascii?Q?Zy6hJgJKPoYp6uScA/D4FRQsZalflLaivM3m4DcLATHONSbGbfpXZxJPFcXe?=
 =?us-ascii?Q?ulNal+UHmQRHAvKLMwVjNlB4hEW1osoBaKrjMNELxf8EmaNBF0etjgtEhRhS?=
 =?us-ascii?Q?vHKJMhI3xahp+LM2UnZ1MWBlWxxeJzUq3X8ZC0g3GxHh+MIy1E8C+C3O3N4P?=
 =?us-ascii?Q?zu/cHO1GSzUwMENZOIkaEDxaVN4A3H0z5Je5ykRjZ2DGJaBUjJ98v1FEF9/S?=
 =?us-ascii?Q?aCKuzcOvhqPoGnUOhIzsx/KuX9aXkRs1+9vJwklVSHLsiKgt5gFYVZxjXAmC?=
 =?us-ascii?Q?1fCe12j+7AVoS4ck+tT/USfglcQbxINX4bOGNtf9FyE8qyEUK1aPakwXGkXA?=
 =?us-ascii?Q?FZpy1d//Ee7NvQWdVuDpQSNzGWB+XnGCQGSt67tKBWlolZ931NkuAqwtPJ/v?=
 =?us-ascii?Q?7V3IeOjrabkTGAlmj4NgH7s8bh+Z8vwtGklDuBu1OeVCn9S6iREuoyyNCWyy?=
 =?us-ascii?Q?0ltDCxuNN0SGNtU+KkYWcBduTTHbZJsTIw+haRf42jSWVAPgj1iAPhzINU2u?=
 =?us-ascii?Q?u3uPo3kV7RMGzCmsGijt3lmQASc4GMULrw48s+Y3e9+J77C0s4Z67Z8Ke+ys?=
 =?us-ascii?Q?+MX3Fh9U903H2Po6P+rGl+983zMFcizFFAhDda8ysvi5bWuQ1W1wEv/CNYBO?=
 =?us-ascii?Q?6KS3mfTZz4nlrpn/5UWVNaincAUGdNwfb3SO1mJb7zmNub5TsZQWQYQunm0Q?=
 =?us-ascii?Q?2OrDQuEqp7a+8f0wwfEGXwuuhk7fpVA6GgyZfXBNSsAArjB3iRttJSbx8J++?=
 =?us-ascii?Q?rNG/1cf5MZlGl/pE9tq5R4GP8UKQWY+wfLK0djPZefUbXO+dTTBhxV9nVx2Y?=
 =?us-ascii?Q?9tKfpRm7/r2aNrr6ryoZwUHVb5h+l2XtMOkJdLDLdbRWmEUmBvS8qQ+sakxa?=
 =?us-ascii?Q?BsE4x9sFh/+GjUoahIKxIE+Y9YH+RKtkcdFy0fWxErXuDXgTQcVaTp9ekhYW?=
 =?us-ascii?Q?h5MHKIUvgTs0eysqXdOxe3Pa0zb7QO4Ua3Y/lqm2FYIuE+9MDDywcytye7/H?=
 =?us-ascii?Q?NrTC0/6EsHxpB8pSIEPBjwZAfuX1twoOMjsFoAMm4JYqoQuHAW8hMj+y0uwV?=
 =?us-ascii?Q?QmZUWVd9fAorj6hoMqqoaf2liZPQ0WD4jal9Hc0uFESMKJHvG07lelyumuUs?=
 =?us-ascii?Q?Jhx71JRg77T6M4ZcCF/GOtJJEjftSrZelRB4XAlnlxfnUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FZOqzO3kwZvdgzAayLBGojMV5vHdjy5K2nWJ2cNZUh2WVYxIuWlXiE5QGCpa?=
 =?us-ascii?Q?9TKpPegXBKw0TQXvSytrlowSZ376R2zpJsyDJ6YnWtvxoIq2u/8EKo6bkoCB?=
 =?us-ascii?Q?y6yYOldKucxnwrcwpT/DgYl7iBMrH3C8DgtG2aMy2HKqiWExWs/RSGO+4qMm?=
 =?us-ascii?Q?ceOwKZnw/eIyiWnuLLxKgRYWYSgImOzfJtcCmHdivUoN7Ft5AomGzg9bNTc3?=
 =?us-ascii?Q?zAi9tbC6nodtMJlQjpVMcy5QgdtUFKMOBQlE9tqomDn+d8cYRap6yx9INhw6?=
 =?us-ascii?Q?mrmGTgdeXks8ofl2mFPmJWJSpxz6H7UrgZkBVDeP1AbaLySY1MP1+d9aAufj?=
 =?us-ascii?Q?yOwi/WR9GWXLtzdyZKb7ruqiyqTEaQuZpydCdzXdoAynqTzGuV5tFUbCJut6?=
 =?us-ascii?Q?RaEc7gF598YPGF6oe/OYkT7nRLq7f4+Nhl4vxKvZs9C+kk8RWv+Lp6eqft1P?=
 =?us-ascii?Q?WTp9WKJ4f+bJGmfmLkkUjpB6e0fjnpks/+hINzIFtbVhU6ERINFPiAXkaXmV?=
 =?us-ascii?Q?bMZGhXPst+9iccK36n3AFpGWmVaHAg/iwqGGs6+3ojGVQW+9F5jRVDXO17js?=
 =?us-ascii?Q?o4SNjYli34T+I5Q8aJcN6PgHQGDMh1WYWOC2ucz4Fil//Wiv4d1nkFQn8/JY?=
 =?us-ascii?Q?Y1x1Er8yYXx5bY7mnkjb667tOTyzYeSBS+1PpA5x41V8jryBGHO7ndFoTfks?=
 =?us-ascii?Q?EQU7vlRlgpsVtxJIuHUxGpE0iJGrp6zOT45awXtBPlpABv/HABHyxdM57dfK?=
 =?us-ascii?Q?XFMRTdp+huk5hh7ki3ONwSDQlSxfvNKe/L4vIsZ3FGVT/RmCLkbZWjudu1hp?=
 =?us-ascii?Q?lHcsyqnIeQkdygX+9E1Ktn2jRGTVJvzUTMCnAg79q/fSBFS6MJcKW1Fg9zSR?=
 =?us-ascii?Q?9FC+VIW63sI0yJdPpDi5re6A3t3mGJ/3gknmxKv8erOje5ULQbR2U+3NDMQW?=
 =?us-ascii?Q?gMvkLBylzhDS4+kTbGUvkyIPIdfWPg6srDV7kA4dm3tbjeQrvOXCMzetV6Wr?=
 =?us-ascii?Q?1F8uq52iIq8YSPzCQEQ5vEqLaHXy/g+yvWZD/msrHyaHOyrGW1JTXMcHCxfe?=
 =?us-ascii?Q?4nPjDpB5f06nDzhgOVHnanDQtz1m/HlbbXCLXE/FK7ez2mbdFj3byqTgEooc?=
 =?us-ascii?Q?WN9AGSTEICItEbYr50jIY3ofD13ewqlppDtbV3Nb2f3rTY/SEqZTon/ia9aN?=
 =?us-ascii?Q?O0c+zR/IKqCKHQCeGnPtC/JoZI2AyQPLRl2wHZ0iI9KnbuXMUO3DooFbddlw?=
 =?us-ascii?Q?CKze1+oGRXa0ssjIeZ8bOc5zPOZsiY+XNXRFmdjZEKZofkfbwJfNba6WukRU?=
 =?us-ascii?Q?FWky+8Rgb8SjXDevi42PrjUuJuki5ajr2e7GRXT1R4FX/ldiVcdO0twgN+nM?=
 =?us-ascii?Q?dxRGP2/T6IKPtTkmlHvqSIyQw8sS4qSpuJMLjLTS73inHrcbnJH/GfYV7r+w?=
 =?us-ascii?Q?MsTDOw7J6nSSxI8RXYrA/A6zZMTPp/MI6YF8iyo8J3BbBBAb7e6m+bzcpcca?=
 =?us-ascii?Q?59ppYYBlNHGSvxgojXORoH8G9NZOkqTA5B1EQ1y51tDsxZp8UlmHLik5I2he?=
 =?us-ascii?Q?ndKcJYiwpdQef2tfjoBt9f6PdLJKEfgOvbBkNgQDZrbehLveu0OHDbL25oXW?=
 =?us-ascii?Q?dKZxHKRjhGSRzpkRAaAHpj7Q55K+IjyJV0qI6S0oFFy2KzP6Gxi3FRHnlT9/?=
 =?us-ascii?Q?aezAfw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TGCT2/i6NQm4GnCYDL72WfK/Jt1CxlF9FYuh4K9x8qz4M97cu/1ypDyA5TMq9kVKzlREhrbid9Pr/0BYneL+pVqVc1xEOBs5uK4WSN/NKl0C7J7BUGKg87yrxzTplpWWcjO/CvWa7KHaxi5TzyCHz7/nUNmEGZQUgGYCAO0M1HT/lid3E2IwbWguGM3fUNmuaQvCPNbFTgzSL3Hu1JHza5yJmv0N5MNEhc+8DlMHvr6cXHkE08EzDj2AJ8wW+81Wq8b+HIUoDGHrioLDw1OpYZhF3D8lciR+DlxfZnM+ptFBDRWBWbpeWeAK5HJE5XnnNLqWzWcFpwEoW2C5/GgTFsFfLZcfGQPEAABGo1xH4m1d74wrgQUWHBGZlEbYSH4geQkiNi1Q1OFcttWU72PfULUcsvGIHgVXmPpQ+LNpzHal2xRMAeWFrHBSekAwqsTCpMYDeeTD8lDXmXqGNYwle6cTtRB/ECYuygK13MLFFg/OPkpbiTDy668MT4h61NQtQ4Dn9mrVkQTRFx1QobksfjaLU8n21buSm6j43lzAAjRksoZ1xcHBMyHvygV/yv0OVHV3HK+LbMava87vFZWhHkwwQzbpQchSc+NP1AYwhlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311e3462-27db-4aa5-7ef9-08dcc90735f5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 15:19:58.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zglz6VAPOSnQX7K210qLZwvMhBWgvMS1+YX8tJM+EaJMXYMXLjcj/KqPBF6MyGtjqnyoH6GU17FL1ZlMvDdYMwk+BU8IA5REOCJG/FHHMBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300117
X-Proofpoint-GUID: I9T9vYRozSCEMelIJZOkSuTKdwdFSrNC
X-Proofpoint-ORIG-GUID: I9T9vYRozSCEMelIJZOkSuTKdwdFSrNC

On Wed, Aug 28, 2024 at 04:52:07PM GMT, Liam R. Howlett wrote:

[snip]

> > +	/*
> > +	 * Now try to expand adjacent VMA(s). This takes care of removing the
> > +	 * following VMA if we have VMAs on both sides.
> > +	 */
> > +	if (vmg->vma && !vma_expand(vmg)) {
> > +		khugepaged_enter_vma(vmg->vma, vmg->flags);
>
> This might be able to be moved into vma_expand().

Sorry for the multiple emails, but am working my way through.

Can't do this, as relocate_vma_down() (and the original implementation in
fs/exec.c - I checked) does not invoke khugepaged_enter_vma(), sadly.

>
> > +
>
> Extra whitespace

Ack. A lot of these are to subjective taste for clarity, but am happy to
adjust these for the most part...

>
> > +		vmg->state = VMA_MERGE_SUCCESS;
> > +		return vmg->vma;
> > +	}
> > +
> > +	/* If expansion failed, reset state. Allows us to retry merge later. */
> > +	vmg->vma = NULL;
> > +	vmg->start = start;
> > +	vmg->end = end;
> > +	vmg->pgoff = pgoff;
> > +	if (vmg->vma == prev)
> > +		vma_iter_set(vmg->vmi, start);
> > +
> > +	return NULL;
> > +}
> > +
> >  /*
> >   * vma_expand - Expand an existing VMA
> >   *
> > @@ -474,7 +584,11 @@ void validate_mm(struct mm_struct *mm)
> >   * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
> >   * vmg->next needs to be handled by the caller.
> >   *
> > - * Returns: 0 on success
> > + * Returns: 0 on success.
> > + *
> > + * ASSUMPTIONS:
> > + * - The caller must hold a WRITE lock on vmg->vma->mm->mmap_lock.
> > + * - The caller must have set @vmg->vma and @vmg->next.
> >   */
> >  int vma_expand(struct vma_merge_struct *vmg)
> >  {
> > @@ -484,6 +598,8 @@ int vma_expand(struct vma_merge_struct *vmg)
> >  	struct vm_area_struct *next = vmg->next;
> >  	struct vma_prepare vp;
> >
> > +	mmap_assert_write_locked(vmg->mm);
> > +
>
> There are a few unnecessary whitespaces here..

...except here :) I like to keep the asserts separate from the rest of the
logic, and local declarations on their own lines.

[snip]


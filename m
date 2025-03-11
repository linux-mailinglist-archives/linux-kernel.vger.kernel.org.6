Return-Path: <linux-kernel+bounces-556250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2466A5C32B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185123B1374
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C525B678;
	Tue, 11 Mar 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BvLRIYy0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q9PAhVeK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F80F25A62C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701731; cv=fail; b=pCA6I309U92W0h0v9tD8x5ms4a4d2sW20I4ukpqIsmvkV6Fkx83eBo2sJjD4wkIrg4oGsCxrfKtIzelZXa0DyiOytg44M9HA69C0LTEUIPEQD5s5dv0eEi4C124QZ1Deaos8aid0BFlk5e/hc5OMqHiJeAAVKDEcOrzvpeSF0I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701731; c=relaxed/simple;
	bh=tOyI+yiIIJMJUJOCTiGTJsEobGhwiTN8HL60uOT3Ycg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kv60o1jGXq9bjx8NBCcVZvlSdJHFWdiKezcnPlsFSwXMDhcJYpnfF0nDqhSCVnU9GgrzxB6fPT9Dp/XC27GtYYpdUfq15QwmyUWxqy+h/pffXdibUVb1rpFcuiS4/htI1JxxNpi8Of7QozHmCVBioJ4Kfpbont9fEdrpYLdtvWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BvLRIYy0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q9PAhVeK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDMtxC008448;
	Tue, 11 Mar 2025 14:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=vrEaZuQ+VPEIw0G2Ni
	0rayWvISjdW811miiAZ/PfUPs=; b=BvLRIYy0EYdsp5B6UQEzNpOaveY+m2a6LY
	A/Ca1z7Et4SReaW1KinJsi2wYi/M28YMLM7JUJ6LZLcihiQPiSXp8C9ldxKZ3+Tn
	JaTAOHB518WzG7Feo22yPUcMwE7K19xIJy5lQlHU4+Js4c4nf35lq6FCH48x5h3R
	KrzNjLJwyh6+cpqsm8D7qD11EpEKV37EZYkFfSKDe/lNiOEJZhu3AnKfSeYn/q5U
	42fKu8DXEKInlnLZWLNMfynrfG6xo9i38y1LvacGUShFD8j0mIiRlmtI4XAfuAJu
	M4aJ8ptq5G1eWoooeNprKxbWi/mdnvAzGl7dOwvM7+/Lua0qt5OA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458caccw05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:01:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCxI7V026241;
	Tue, 11 Mar 2025 14:01:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb921v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:01:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMUgSjRoPYO1YnmJmqEUDdxeOGuZ+gkrX1uruSIrS9iFB+7GCjU+V02bAztoxpI3ArIMrdFBtUA7WeHCKvwuCvAbxWzoafift92ZavCzutaN/aVdx8S+MW63Fx1pvdh2VY6jnXvd9wq9wEuYc7lmTVmj0TaFEICdb6sKmRrDoxv1gCP0TbMpdXB3aWZ+pXbMiOMogZy2+/hbMaTEJauwnvDxiKLLumGEYXtuMY7+jT7SXXyxL40ZUwf3oRPx/BKErHKomOUQEG6QEXU9xJuH9Zreag5rqdBcWaL7z0T/9JRkM0ehrX5iQ+nTtvFjCaO0po0VuvIFHIaOQW6/MGNpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrEaZuQ+VPEIw0G2Ni0rayWvISjdW811miiAZ/PfUPs=;
 b=IKdNI+EVdhIU7obmJPzEWbf9aylPTlZ6ErurMVGINBe8Udig6RJN8fTlzsGnt2In2Hv2ozU1uwDkIUam6sLLWYWWB3yLL4UNmnOAhXRe3/58MNQzIiody+hEUHHS2bLVw7ncBi72cWNZhmzWo9j3ndrm+wznb2MSTEvXWyWE4U4dYsP6eMYkK23NsqhKYIL7TSCY2Oxp1ZyFcgaCI8DO9pIIiHrd03wHxlSzkFSAMLMmKZTOS4lzKUNkaErrmCDAfV9qjDIt3f8tJWZcxQGSY6dmil1EpByJd/csuzGSwyEaNHWbhKX6dz6Alo6TEeDiwumdRX0ea2IgKRVu6k4BzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrEaZuQ+VPEIw0G2Ni0rayWvISjdW811miiAZ/PfUPs=;
 b=q9PAhVeK1Gs7kE0sj1gw/gf+Qm7W0QsWhI6r1/ALjyz7A+XaLbmfYWAy/XocT7P2FKeBNStGCTDy4QrL9rtQ+rLLOcifrD7Y1jsmrS0ehJTKU41iUQvH8iazmF33/Yd3z6I8HOepjoNGJfbRakHytYZ2bMvqplqhDxs64j37icM=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:01:23 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 14:01:23 +0000
Date: Tue, 11 Mar 2025 14:01:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 9/9] mm/madvise: remove !tlb support from
 madvise_{dontneed,free}_single_vma()
Message-ID: <246b547e-d7ad-44c7-9652-6f5a72828b26@lucifer.local>
References: <20250310172318.653630-1-sj@kernel.org>
 <20250310172318.653630-10-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310172318.653630-10-sj@kernel.org>
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SJ0PR10MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fad2a86-5802-47e5-41e5-08dd60a5353a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SqU8plccN4HgWJ7dKCfLFE5IxGrXrBbwmo7tiun/578+YpvcB+B+yTu2i1hy?=
 =?us-ascii?Q?1ypAKQ4fLMb5txf8CDCF6PGJmhFzc8ZX/bW8BKZNOolCx4ITW4C+pK3kZs+I?=
 =?us-ascii?Q?OyfU9noYfw19ZrGxuqVm/XUXeXpzRxtX3x+gmr5yMTXsXHrGPHToaICelD5D?=
 =?us-ascii?Q?dphOoG2bpiztBnZf3GFUjsJd7k6U7HkcKEyqaBHuwmRwzQha3F2crfJdiLKu?=
 =?us-ascii?Q?efvvrykqJxIUnMfZ0vQJoANrk+wF+kd2+n0NO0458PlmKc2i2rKvgnRZxjWR?=
 =?us-ascii?Q?4pc4YYjmPDc7ZOE9hgGzGnmAmVeLNhqxdb6YfFNco8bPq5+i+3Hb4XNTvWNO?=
 =?us-ascii?Q?XYmU3fjSFGpcH2/HGAYKS5KmPcHKF/CrHadwmZn9GbpzIZJx7UhB72VIdi/z?=
 =?us-ascii?Q?ZC8TDWcAWgmkwddc7KWa7aZ/HGV6AEwZ1qxa4zVTbdfyE5+7CLleUDF6wSH7?=
 =?us-ascii?Q?dkLoXhGe4vmIgipH7MBDledmr5gGTPibMgADyb01JOBZ0ko+Yq8/5PBm2HAZ?=
 =?us-ascii?Q?5v6D5HZOYUCZBG66R03mjTAMLJAyoY0aiHaaPOiuxGQAOtV41UjNrJeuqznd?=
 =?us-ascii?Q?BTZsrsVjpTYTG4GGFKMkulyJ2Vb1YMtUzBUHa5qH4270h5C5lQKR6O+pddv8?=
 =?us-ascii?Q?jZjJadDE8X7er1nKKndY5FNaBpIAOKKeKv2S0YgNItaBK28aX3mxBZEAuhg4?=
 =?us-ascii?Q?BlqPsmKG2VY2RptO0AlDndf9FKkdseJy1YjoMk1M6xYbH5T64/m5u1xprg+3?=
 =?us-ascii?Q?xI2ZrOlAmADp5tEz1lHrEhx/uu1P91dPxvgsqE+lVNxzvN9tooa/EnjRuShf?=
 =?us-ascii?Q?HPIFt7lTCU5bqm6y7Nng9MYFAZ2Kq5h0M41iEFJBUb5Z8QeJYLi6/Ftfq4Ms?=
 =?us-ascii?Q?0536eJIHqRpwmlV1KA1N/svxiSs2gL71UglHJebTMuRNNTP9dT1KgBQEgj1t?=
 =?us-ascii?Q?3FFD1+dmQ2lyepJT0zBj2HBCYgbpbgEjjvC2AfGhB5VggWZ4l1VsfBTEu8wd?=
 =?us-ascii?Q?k1gBf6Kx2ClTxXJZNewtMYZLNjYh1UbKwaYdibodC/W3KcYUbGCPeXSeKGwK?=
 =?us-ascii?Q?9ABQz2A3wdgGPUgqhqhrdPgywL7pI0UVkQuLEQLuUPR7ZjGLNBFpYxgi2pSL?=
 =?us-ascii?Q?Hvti/hGxL5FGsciaXQ04aBdl6oOrupTVLaebFST8xfFq4Yk1vvb2tCysZzgq?=
 =?us-ascii?Q?CEuxMI4sJx437lYKVPnCdropUPbaMGvBmqSqvs0G8R1G3lJO0zmXrmbMMvcc?=
 =?us-ascii?Q?GjZQFjbZvGORyRYnCaER2vVuUJC7IPgjKJf5+SmOasHnfHPq/TOycJTzBOPk?=
 =?us-ascii?Q?R0jqhSjxc29nzj67yWuAH+20/KQRwnh9Eai2kqZpwyn91Tcv73QRJxUfpyw4?=
 =?us-ascii?Q?XpLg0XJJ8tPr1hCpb2mjurogf299?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?81pUZSSDpG52t2+1hGmhFmuk6DintUw1XnH/lYi/aLnDLdDFaJE4lFw/0rUP?=
 =?us-ascii?Q?uo8GM90/knvUMkIj68qskxD2FeaQZug2803bkf92UwsE3abTWylHONJOfr9k?=
 =?us-ascii?Q?Ej1Ml/viVXBiFCxEKW+OpXO5VJR/K05coo1dbpYPwy4/JAmt/KWsYLQoNWur?=
 =?us-ascii?Q?zBQ6munfe7QUIt86MSR7M6/ZSWD5nULLJTzogJr00+Tk3QW/PvxasLGL3AK1?=
 =?us-ascii?Q?4gBz+Ih0vaAyJWIoPJdIPiRwGhvmmfoKAGhvtjrbzB79F4TMqGFGC10iNGAn?=
 =?us-ascii?Q?8F/pLSG4YeCF8tUWa5YSqBc/NswnKxKnRo1wCasr3F8KsGvdb2JBgMYCNeZN?=
 =?us-ascii?Q?L1rWNEwjNA/cPf1fFq+2OJIzF/fSZK2/R4GhG2Cck+CxBa+AWCYOrQ+nMg1v?=
 =?us-ascii?Q?ggqYNasOpy8gQZG90fANTAFqalUpZPHqYVhPQxO9FgwHHG3j/GgKgBgBzwho?=
 =?us-ascii?Q?X88Gqi5QUFlP1lN3DJsPCzXau8rp06uzSeVdKLXZGLv6y7YkXQVC8su+6snW?=
 =?us-ascii?Q?30jPOLVCijT4E0YS6lc6ienr2G5XN2OmNbPpub4rwLXGSMMSVbAiWxQFTptG?=
 =?us-ascii?Q?493E6q5JKvVhSiOMgZ5ktbDLTtyxNgiLJoAhtNNpK66ME7bXMHQQ/q3Nv3/I?=
 =?us-ascii?Q?p1TvC1050Y7SGMpyuqgL6LZOuS/IfeOoExcgbqAn4PxbZr8/v+8rvjdBo/vt?=
 =?us-ascii?Q?SS3QZJa3balhHNHzs10mwuoMnnpuvTjFwBKW0lotCjDoiQr9q29Rm0d5VoEg?=
 =?us-ascii?Q?twt/rnmEqHAdhw31a9IZqMpcNSbcz/144hf3g1k+oyeQ056UJrolBzXOpWcF?=
 =?us-ascii?Q?vOXamAL6OMbJsG9vMaqnrUps8ukXehhfHCjRm8YM3GaTXxr5dXNlLJcSljKW?=
 =?us-ascii?Q?bheRTaOURdM/wrqs+to75FrAb5kGXrmcJZkiiEg6gSFyhld2QysppO7dzISw?=
 =?us-ascii?Q?NSX21GBeJiB59DKiE/UXqff2DYuhpNY7QLkbW/biLJwEebFHdzipp6fIcsrr?=
 =?us-ascii?Q?qgJxtc2ftn0NBw2oskiq0M+28YAjZGbW8C5O6KvbjIa58KenNwSriuQYoXHB?=
 =?us-ascii?Q?VM9uRaW/pU6yLc8BMS/TXrBBLa4NC3B/8xwVE7Lvsm/ZaNssJDenDOLbSZrM?=
 =?us-ascii?Q?OfLW8i7WLoMnmmZsqC+Opic2vYynEmJhzl9ux+QyBwK32KmdFjAoeqVEoEHK?=
 =?us-ascii?Q?xj2PrmDu3WQSauWXNuL9N2yzS/tgzB6905cp47a6JmAQTuhbiJbn2dz/5g2B?=
 =?us-ascii?Q?NRys8spLnXXf9J2vD8ctpfOsHuybRr0ep7q9HLcqTfkBsCrGwwG6mrZFMQPT?=
 =?us-ascii?Q?5rBet1H88YYjlp1EoU+MbEeUOIC5ke1f8rRb8R7BRBCWpGTno9RS6J2RWqgT?=
 =?us-ascii?Q?oIIHbh6Exrr1xjSvZYZ14uXMlEB+zaIg3nmUWWDMLkuOILDmv5qN0TOWBm59?=
 =?us-ascii?Q?yaPzkNtMoprdKQTwytPCfdS2F68SHGs8FhA0A6lEGUz3jtTkXCP2m7LY9jgw?=
 =?us-ascii?Q?A1PfOzdge1SQiEzXTjY8psSIc8voQogQ+2lN45wreJKXers/APbXn2eL3upv?=
 =?us-ascii?Q?MyoyTZ69q0mPSAosmKUINuZ3622dCKegV6qTw+ixjsK5Mx5Bj7I2ZXREnXD9?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B/znWAfKj99JdvNvVDzSuDQ24HPl7RBYeo1U5NTxH0b8YOw68xswn81jo89PCabXOoKJrGKpGseBMo/IkEevAqOXJhd/1mJNHXn4QGInj8246KuHQlNa3AzEgtz3pMvxwrWZfjaCkx2FkNzV1ZUNSF33Mag6IUh2Ux5fOGiR7gTr7FAZ947eezp9ef5gzxX0v60whHI0ZF73uNVYbXWZyogS+jyuBmaZk6N+5IOszvJlVwBMSN9kELNl4Y42R6B70k2h53VEgyZzkj2lbd4+RVoCAM0XO1whrC4W8ZeRQN3PGINi+8lgG21XrhKcZvrah1tmj7lSYFseipF9mLbeI9JDwsUT1eORNgM94c0HSDLZ5v5LHP5MrlEJrvs9YY9HbI5GuhlH3uFI9WCeIUqtviXlblpm+hRAycVvY8WTZedheOAB6h5LchUJ8zRBG90NZGEyygrRH7vANv/gZofCKHkFtpEL+jEUHqj3YsbAwe7SJ3FRYMKCurVsJuyiGukHGnQbHvJU4qywHFV2tRNXc4EmouUqklYE7aXS98O/Cv9VpFA3tmkg4RVRVTK/LW2Z2RwXbg5AUNlspBIBpSdXvR1dLhvkGWkjABm0rUowG2A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fad2a86-5802-47e5-41e5-08dd60a5353a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:01:23.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1fv0ZsxjU17C2zlrvT0dZm++fJZkxtopW2LlMZhkqS/Wu+4SvjjwO4GYSCwLmXKO95Eni1eeCCa/Xhx2HIUfdqm5OGYXYY+Is/kSZex/NY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110089
X-Proofpoint-ORIG-GUID: Vf0h7vrhSDD8Mp4oOeGY1jun3exkPtWg
X-Proofpoint-GUID: Vf0h7vrhSDD8Mp4oOeGY1jun3exkPtWg

On Mon, Mar 10, 2025 at 10:23:18AM -0700, SeongJae Park wrote:
> madvise_dontneed_single_vma() and madvise_free_single_vma() support both
> batched tlb flushes and unbatched tlb flushes use cases depending on
> received tlb parameter's value.  The supports were for safe and fine
> transition of the usages from the unbatched flushes to the batched ones.
> Now the transition is done, and therefore there is no real unbatched tlb
> flushes use case.  Remove the code for supporting the no more being used
> cases.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Obviously I support this based on previous preview :) but I wonder if we
can avoid this horrid caller_tlb pattern in the first instance.

FWIW:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/madvise.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index d5f4ce3041a4..25af0a24c00b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -795,18 +795,11 @@ static const struct mm_walk_ops madvise_free_walk_ops = {
>  };
>
>  static int madvise_free_single_vma(
> -		struct mmu_gather *caller_tlb, struct vm_area_struct *vma,
> +		struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		unsigned long start_addr, unsigned long end_addr)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct mmu_notifier_range range;
> -	struct mmu_gather self_tlb;
> -	struct mmu_gather *tlb;
> -
> -	if (caller_tlb)
> -		tlb = caller_tlb;
> -	else
> -		tlb = &self_tlb;
>
>  	/* MADV_FREE works for only anon vma at the moment */
>  	if (!vma_is_anonymous(vma))
> @@ -822,8 +815,6 @@ static int madvise_free_single_vma(
>  				range.start, range.end);
>
>  	lru_add_drain();
> -	if (!caller_tlb)
> -		tlb_gather_mmu(tlb, mm);
>  	update_hiwater_rss(mm);
>
>  	mmu_notifier_invalidate_range_start(&range);
> @@ -832,9 +823,6 @@ static int madvise_free_single_vma(
>  			&madvise_free_walk_ops, tlb);
>  	tlb_end_vma(tlb, vma);
>  	mmu_notifier_invalidate_range_end(&range);
> -	if (!caller_tlb)
> -		tlb_finish_mmu(tlb);
> -
>  	return 0;
>  }
>
> @@ -866,10 +854,7 @@ static long madvise_dontneed_single_vma(struct mmu_gather *tlb,
>  		.even_cows = true,
>  	};
>
> -	if (!tlb)
> -		zap_page_range_single(vma, start, end - start, &details);
> -	else
> -		unmap_vma_single(tlb, vma, start, end - start, &details);
> +	unmap_vma_single(tlb, vma, start, end - start, &details);
>  	return 0;
>  }
>
> --
> 2.39.5


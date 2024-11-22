Return-Path: <linux-kernel+bounces-418393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4199D6128
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3EE28239F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C917F14387B;
	Fri, 22 Nov 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L0wHfp6r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kAusPbT6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D796A009
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288480; cv=fail; b=IKyR684HuqRQMEQjNvWw0zSZK2nCKUlgIO/E1tM21T03n4MYBNogxRPXxVbypWb4kdHXiYg5me7YwbICjHHu1Feskv/ste5anuCJ9Bw6VlO896Qq/UIPXRHM1KbWrK44u1vLg4u+hDebbFRheqs9HqZLtu6tqPWoZHdqe8b9TdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288480; c=relaxed/simple;
	bh=DWEcr0FsC0p/OnlHarXzuTYcz/ORGnF7NZtAhldXwQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S954bL8SMhvX4VKgEHl2jKXoKpLVweQg0S3u2CMplpg0qtfWfYTu4N71/U2BD3DyWBUss+yDxLWEvNgN+CHWK+4ht+FnQbBFXOGykTtlog6AmNbna4opgnohWQvFZ9Z4tKpl4VNrdfV6dDPIK4qmi6eY3MFuXAADD6LqzWhyK3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L0wHfp6r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kAusPbT6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMDFpAB019312;
	Fri, 22 Nov 2024 15:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Vdi2Urf42kW1pcrnMR
	uJm1PrQ+2Cum6XhCtRTod31dM=; b=L0wHfp6ri+evMZgH/gFQ6D5l38r23f3N0N
	niUJXzLg+PhjP1lYp7KJgUq9+KIozy9AqPw/GcwbHexE1+6ia7TFzD2KgKvsb4W5
	J7OG4TBF4Kv2BL8EQWqCwBo4A/2/rlblEiO6x+gNumI+LUvvwsv+ugOk0M5+qQXT
	lVOs/r/r8ByLDvuEaQ1KwxtnDXH0+fzFYhDBygwrHUDPFO6Nt0vHJuvvXUeZ+pc6
	cnhNM6jhyOcDARSYYXP5HK8Elel+46L8Hr/gy0XQtYyqLgt6Kajvw9CfJilj0QHc
	qTYwNrKGth9YBWFir/6oNPpd0A3GJK9mmnmpDH3ym/H4RdNwFAoA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtcc931-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 15:13:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMDdHHK037121;
	Fri, 22 Nov 2024 15:13:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuddb48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 15:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jk1qzA0C0+kzWaqGUfayIo/kLm+ZsWZxh1SLCOFND49WovwF1vTRzAWJtcZJmD+sghcGEjnN2BRYaG1iyjHBjVjH6Bz6AUkxqiZ2G6YjNX9opLOrjUqrPJ5Yuc0VEEnTfmIOF8lvChlkoKyGE2uZrxmhR6Rbz17VJEOX5mf8/d9GFmRAtQqPTSDwb2l9PvbfNoOoMS6Kl3huHofxLC0TyaP0MC7O9fI/h1FY4ZoqBQDyrHMP0Vz5QqKMcX8OUFcLdRcUZbQBn+rMeUXLImnax6WXK9WDpBFoJkyUgkrCNPS/o8gvYfZpn+gFvpbnh3hYKyL57OqSN/Cq5m5Ak+jWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vdi2Urf42kW1pcrnMRuJm1PrQ+2Cum6XhCtRTod31dM=;
 b=ODJiqw2T9KocHGNbWikc14ZD47+9obRDQqno6DhSCpAhTzIkf+GCBG/Hqnv2lnuGSXL5XM2bX+WjiZRYlojpVSUTCxjWfc4yPYcj+JkOxwqCbMlNoQhZ6e3gv2/Xkz8j6e6rAHWOW4PE5oFYRbVRoKbqjdoTqnRH3cRYr+TOYKTQ/BkXVnsdw4T/WHtod2I9coh02QGPehEvFsBPVpvanCpVS7NO/udr/DxNHxD69Pr6/QCQuNcxdIxIWpbrWgtkFh57ukaNyo48TznDEdYNMHAMyEZYBnAZDrx3ovroju/GiIfisBDOJfTMDIKGFCID2qPqOM4b2wIhWFmcmHmPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdi2Urf42kW1pcrnMRuJm1PrQ+2Cum6XhCtRTod31dM=;
 b=kAusPbT6IVwgPrYPFFpu0WhREhtuU834awldzYbUjUvRcjnnPPxFfCIJSJLy0sy75MLX2uf4Cfi2j+jLqw0YADnI4xN44gWnXwKfi1nHlS+WwohWfscsL8x0xJw9PvZqPhdBgVJE4hBoz2fCkfTMlPBvvU3bQfi4VD1gOVAc2Ck=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 15:13:53 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Fri, 22 Nov 2024
 15:13:53 +0000
Date: Fri, 22 Nov 2024 10:13:49 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, andrii@kernel.org,
        jannh@google.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
        mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
        david@redhat.com, willy@infradead.org, brauner@kernel.org,
        oleg@redhat.com, arnd@arndb.de, richard.weiyang@gmail.com,
        zhangpeng.00@bytedance.com, linmiaohe@huawei.com,
        viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] seqlock: add raw_seqcount_try_begin
Message-ID: <p5nwzg7bbesjrto24g2ryk7kl6r43677e6ksdueysvaujpuibl@bwjk24zkesix>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	andrii@kernel.org, jannh@google.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, david@redhat.com, 
	willy@infradead.org, brauner@kernel.org, oleg@redhat.com, arnd@arndb.de, 
	richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, linmiaohe@huawei.com, 
	viro@zeniv.linux.org.uk, hca@linux.ibm.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20241121162826.987947-1-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121162826.987947-1-surenb@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::22) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf016c1-9737-423e-58c4-08dd0b0846a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UE8OYq3nnQQ1hiQYc0dIBU5gbuX0jhUNs47TdO3te+mPyeBaH3lrb7xHgDgt?=
 =?us-ascii?Q?N1mXDfw1nKXTnaS9PACUErFAqW5Ul3JW3AMkcguO8koYEMB/VdcsH+M8dzvj?=
 =?us-ascii?Q?/zvLiaX+5ZX8dCerBYjRU3xv7rLKx5L4ZOFQOg4hCJk6XAcKyEXeM+N+upH4?=
 =?us-ascii?Q?RlQ00PrM7+v+iDB7VlXKaz47Shvqt88m5VSLiFm7lwtiNWD+iN5H0ibPJbNU?=
 =?us-ascii?Q?wUklRXVjVSeZsJnYYKW6iTv2ck0cOTC7AxsuJU7um/9AS3NFiEqU0agVTRJs?=
 =?us-ascii?Q?qtmmMIBNiSPygD4ESCqlgDRfQrq5T8++Hs0quTOnGJofU3IsVGUOx0QjC/v/?=
 =?us-ascii?Q?ixq/pdrQkusGnb/vkC+iPWdhj8kwywQZGpYH58Sg/u1dWb04lEfqJChOEghQ?=
 =?us-ascii?Q?5F4KVyYyBycbxfuQBYsNR33tcCkz45U9lRndSXGDz7n5bR7AYASTvMY97RAF?=
 =?us-ascii?Q?VY8i2+nZK64iiAR1BF1LGsuL2ESiaMUszbxsxEDiPjzGzFXnjDzVsDdO5OpE?=
 =?us-ascii?Q?5371BcTMa7hT1KdgCaveXEmzvdkTh0wZLBugU1K7Nrri14Lqoz4fsSD3UvWU?=
 =?us-ascii?Q?+74psIm57pvTwrZRxbEiuTDlNKlmFP0B2MlhF6ou39DrWEWJq2oRRmy2yGry?=
 =?us-ascii?Q?x2ECAk60n1DHeCm9fjK2DkMH/AkLJizTPhhESStLH4Ogv85dHBAjoLtbcpVs?=
 =?us-ascii?Q?QsgNzWMa4IYZRcz+RhBYqfkQRFrQGZ6N5AniR9szfEd1I9wWblbsju1AYSYj?=
 =?us-ascii?Q?BD8g5+5NCLHqISJgDjASiHp3/5L//1EIIbu6rLJSckcSzeZq+Bx2epe8JH5p?=
 =?us-ascii?Q?lM3WiKGP9ttcbC/OeFdBRq9T1gd3n0U/9/itDe1gmJvkvBJimcR//u6ARo++?=
 =?us-ascii?Q?QYrjXsXV8jBNLD3/BX89LsEeIPwyMKwYkWwoJb2k9zZV+UV3lBfRuBCDhl++?=
 =?us-ascii?Q?pknwGOnWfMSXJlb9rJte3BNr5E97xNi9eyP8V9BY3/6ltGEAZ3cXhNCCdTym?=
 =?us-ascii?Q?B4rW/0SMq/c+kUkRhgnn3Q8R23Pc+49tW2wTKJfn0bdyDjmt9vVBJ5XuraCw?=
 =?us-ascii?Q?29429nSM81dVkFPdzY+HvjvZt14B0Sl8dvuPQr2PSRgxGA5mio/kUNcMwEKw?=
 =?us-ascii?Q?XaIR6sUzaJTJIffQaN6YHGvx5enWPZAhndjqRPj4jy6oND+UnIrePZ3nLaR/?=
 =?us-ascii?Q?ccmwsTbCs4Kv/i2ijugZzZU4atBAonfTXT/OH97VR5+q8vU9zEcMBKORg1yt?=
 =?us-ascii?Q?wgAGtmzGE3wXHdBGS8gJFST7gEMCE96UuisaiQLuQZlrFDuH1nNfLtCtwzq4?=
 =?us-ascii?Q?9DyhLNEGZ2JW+1ylQdi9Qn4H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ROcMhGNSH2cQ6pqO1XC0RuUV901exoWglGuyXWpMtsgpEqTLCcJ//UxrVQxH?=
 =?us-ascii?Q?UHlWIVnK0ghGfGMtN3oic+3fzOedSxeQ0QsEfWYHlUg4/nFCY8+GgPTbniAb?=
 =?us-ascii?Q?yHbne5+vqXGO48RjvaLfmGFfoGpX3BOxNJCgVd6Q926FAYPXvbbYN3MslwLo?=
 =?us-ascii?Q?MKlDoN/YEdFO2PWV+JfFBfCFnuZdfiNSwgh5M/Lr4Zlzas4pe1Ys1NbzovGd?=
 =?us-ascii?Q?ASCl7h5GXFAVdaNgEMkGQa+OcfdWHFH+Q5+kH/c0Ww918zelbW14CLO6rF0e?=
 =?us-ascii?Q?WUD1lkKXdKGbBIrhiJI5STDovkenIr68B/O0eS2pho9+58Z2jJugJZzF1yev?=
 =?us-ascii?Q?mhb5cMktLQuomKdU2oj79cxwdiEBwS3mkmU0MDU4bhZavZhiLH5ZR6KRd9Mp?=
 =?us-ascii?Q?bvQ/G9CQ2HLm4DrYHHKTRDx5LuDGqY+2lUqKAa1WJFpKI1Odojzj+t6mHl8G?=
 =?us-ascii?Q?nWKstzSoT/Ed7KY2/WoPTrubT5oA48jzEaTip7rTRyxDuQy/OIm9QXa9jGVv?=
 =?us-ascii?Q?Sv/zG38BiWzfPmURAupFsjo4BTYFqJefyAN1YTGbN4y6wncey5RtgC4y7+lu?=
 =?us-ascii?Q?DRMHJBrLqD8IUGGudhyfalM94uamAjEFDFs6fYfl2Gk34EVxZXlukc42tc5Y?=
 =?us-ascii?Q?GG5oE+Ko1iNyWeEN/R0iNVYbZR/dFIjl67Cd3koutuglSZmsixpS1fy+1Knn?=
 =?us-ascii?Q?nXvCFVG9IxCIFpKIfVosCbAulls4LH1FR6urnxmuOfTRkFtJlkDUyODw8O+p?=
 =?us-ascii?Q?/HqfCMQsMeP3209SftLIIV4xHRudNtqVt/AQ4NhKoRnS9dGRav4Q+2u87G4T?=
 =?us-ascii?Q?hj3O9u1+R7LDizIrXeRuJx2N9Y8xPKrKCvImKvGNW5Lj1EKKZcLdDK6nyGNG?=
 =?us-ascii?Q?oo2yV41NAYCO7mYkPHl18P8Ua6g1qgNDtqNcII+tNcECkFeg7X36++l1BzeH?=
 =?us-ascii?Q?Af21AUfOk8EIh1Ex+26uz6/NAJdzJma7a3Y+x7k/6upbLmou/pGLu/tjRCMN?=
 =?us-ascii?Q?364HnPbglbYJom2SRzgFkDT1J81nR51BOV41gKalS4SkTk1pKoi+cJel437U?=
 =?us-ascii?Q?y7nCFrtH3bK8sQzIluykPKgiZkr89uEJA/tsByQQwqLb9Iu2jrao1uT82H5v?=
 =?us-ascii?Q?67CsmMGJY07cIG6o/y6wnX8sMuxy3zeJVdwbgGGaTFrKUGGAOPjX2ilpY8xB?=
 =?us-ascii?Q?jZOYyIgqaTKpz+aZx2s2XWjamGJUGefEc+cS/OsQBy3Pr0J6TuI3nf8chaIz?=
 =?us-ascii?Q?RrKf3hsDGvzZBinCdvPZ5Gl89FYbR2Y3aZo1H30T7Akh9Ob8qJiiINHu8Gf+?=
 =?us-ascii?Q?lJQ0pmJEWnMSErcVQRyBetlNj9H2OtGVQqRvKbAyJRTeL6eyPaqq+ZfSJyGk?=
 =?us-ascii?Q?JHYKTGFWPI4XNwTGJV2Rt+TtX7Hjn2w8uXq73NedhivpwyuKLHNmcMz8k6aj?=
 =?us-ascii?Q?hoC6kCc1q+VheSnSSeujaTgK0nLqdSRtTpi7p4riVFjMfleKy4QEwiq5/NpD?=
 =?us-ascii?Q?cTZUBswjX05C3LHLm5bcrKDm1bnezpnnzvB6xkeUvMf2Am1sPay7V+VDovMv?=
 =?us-ascii?Q?GQdB9jgG3DKYhdZqYm2kNg774ndbX2sn8X99i2pC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e0MColZT2dYmtbeq5rUzqvZebRXxIXIXAJDDtTGOtss0gj0y1s1ap+HknUIlUHYIcoK4ij6tGqECgVJjO/iYaI3d8LmMoujnIextLMBwOkB58n8rNuR23gBRtMCvaOsMV0Aeg820BjZTnVQ+uhGkIYTWBY5ipywCzoxxNSggDfrtuwHP1zb6bA31OTXi1vwWSZIrRzJIC8dN9zmVOSFCjVvGCmJzShN+HqqOa8JZhmctJMJf6Tprll1LQXdWGGINl0pbVKST/fTuGIjh0EAMs1UqFlJiQkod/RWDwu8FUKRB9IewdqiODz7+sckhbIF5iHaEkaW7aWKC/vwyM5V2OWaouYMT26/0eomJHhaxWM5k5VxixACLEuMtqQyJfxzi83GKC4mvhyCysrUyMG2V+fTkeU+qOGuiigwMv03LmYlCbYuY6xB/YQAYQCYOMdAwMjkxndNTKorIHkY0agJ0ZfdV1DT/lm4XADDBYSQFPq6pkrC2w5rWEEiypjZ8TwWFdP9VYku0wWqSLz4pOteDonOJbBQ9DcocVvUnnMD9vUJlKIL1jUe4XQ00YdZP5PJaHdBH/tUzU11YFz1M73c591xqHVu9YP+3KsMuOU65/2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf016c1-9737-423e-58c4-08dd0b0846a6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 15:13:53.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKUaLXPrjJjqVVAVAUUV4nUitZYiupSOwkW0iuNLluRthHzLeR81ajtwpGRZaxn9BziC4vzlS65KHKu8AvKNFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_07,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220128
X-Proofpoint-GUID: ejatUO3xyMTmo5pcP-Ks7fSuHKAf1itz
X-Proofpoint-ORIG-GUID: ejatUO3xyMTmo5pcP-Ks7fSuHKAf1itz

* Suren Baghdasaryan <surenb@google.com> [241121 11:28]:
> Add raw_seqcount_try_begin() to opens a read critical section of the given
> seqcount_t if the counter is even. This enables eliding the critical
> section entirely if the counter is odd, instead of doing the speculation
> knowing it will fail.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
> Applies over Linus' ToT
> 
>  include/linux/seqlock.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 5298765d6ca4..22c2c48b4265 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -318,6 +318,28 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
>  	__seq;								\
>  })
>  
> +/**
> + * raw_seqcount_try_begin() - begin a seqcount_t read critical section
> + *                            w/o lockdep and w/o counter stabilization
> + * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
> + *
> + * Similar to raw_seqcount_begin(), except it enables eliding the critical
> + * section entirely if odd, instead of doing the speculation knowing it will
> + * fail.
> + *
> + * Useful when counter stabilization is more or less equivalent to taking
> + * the lock and there is a slowpath that does that.
> + *
> + * If true, start will be set to the (even) sequence count read.
> + *
> + * Return: true when a read critical section is started.
> + */
> +#define raw_seqcount_try_begin(s, start)				\
> +({									\
> +	start = raw_read_seqcount(s);					\
> +	!(start & 1);							\
> +})
> +
>  /**
>   * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
>   *                        lockdep and w/o counter stabilization
> 
> base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
> -- 
> 2.47.0.338.g60cca15819-goog
> 


Return-Path: <linux-kernel+bounces-280773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0494B94CEF9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2811C1C2170A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617441922F8;
	Fri,  9 Aug 2024 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cOPG2YX/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mm5MBRKZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068D17993
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200854; cv=fail; b=NNYQkChYE6GnWV2sWn05Q8vNvAczOq5h6i8JlIl77IE/lgh3Gm5pCNLWKQrTbEdKGY7rg6GBLB6b1rHNY0E9VX/cT1ZUuTJ5+f5r+MCSvZ20vVhSuVkMfprw5EK2lO9pZtQLIb1sjo0KPC/ZSdBdM0TNxOTtsBAy6ogsuFf6t2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200854; c=relaxed/simple;
	bh=JUyKDA4mWXmZgAsRNbOqQfuLHTG6WxGqFm7TF47u/5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D5g+uB+KC8PYPFe0oGpVpOxLrRsyZU4A0WWZElbTGcblRiB/kICr2Wme44Ib4SopLy/EYYIyob+tmke3Ktib/RKKLUjaACoFz5nycASPKl3TAKAkid/iee1wUG76tWNy/paREONsc5ncdCk+/1ktZ3veTkA3S3j+jTIDhKqeJM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cOPG2YX/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mm5MBRKZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4798fVsw004790;
	Fri, 9 Aug 2024 10:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=291NlDr868UDAXG
	tedU/NCnsqoFKjWpgNCZ2Y6vKyRY=; b=cOPG2YX/KvDeW6VurOKf3DOReYRR4MQ
	yyA9mL+fKknGIXllV6YLaQij8ZFaUXKXwK2S5AjJVFG9UJs7OLbsMqBrUVJNbA5n
	vF88JlTZ2D3GWV29lR6nAGX6WA819yTWp1QwHJ/6AM2Kuy8cLJxrUpS3sSwx1oFF
	NlpX1NSNFD4nEU6fNVzKsl+XwWjD5fVfvS2Gt3+H0cZtMr26+Kj1nYr4Zk3Hbl88
	C0dW7FuHUEcMtpUoKyf3buQAwJNtUwUIQkMMYMw5MvZhk9ZbEgcnlAlr1SnRw/u3
	N6wvM7ix8yd/mmiXsDdG5epJ04y+2VdfYGy/959maqiRhdpa0JS80Iw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51ksju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 10:53:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47991nS7027932;
	Fri, 9 Aug 2024 10:53:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0cdsbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 10:53:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwmcWquwL5eeDaXHxNFck4OQ3Rcs4nBBdmg3i9NZ7cSynzdoFYLljV5FBeaiutV/sXqria5WaUZNMo7czyhHSCthbTQbYyKefC6hKh6WHH0AjTPnQmBX+enuOWZ5w8EC6z40YauX9EcCzPHrMqxD3Lv47TlIJYJrltzFVYjNNR0cT10J1kfrb+Jogwrmw4g4LjwhRaF59XDHs98X9uXD+J4kbxzGQFslDh+jsMivI5KyaJDVTnVBhIoKHuYASkA8QJVf84y2ddFlFY0OdU0xcSgyO8/Oep5lztnAdkuB5Ew0XBM9qwZgQCz5G7vuqkvefjgWKdH2NAXrw8t4qgZC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=291NlDr868UDAXGtedU/NCnsqoFKjWpgNCZ2Y6vKyRY=;
 b=Lyz8A7kHVrIyOZu80o+R13rCj+PTVvdzeI+tqrWesgyhYaa6wc7Lk+XQyh3CJplciy0086Ie16oGJzhseZ6chUpmzAR8qgFeBk/oV7nW0XcCq8LT+aCwsOQvO/TXpDSrmDQCa95csxh0pusez9v1SnctJtkB0xdkI+0Q70rOKPGh+RKXvyK5Jp8d4SsBhC8jmHlT0ITVGnZAc52j3WCbslYKmsAqUIs1DrRLAMEBdb1LJWb0rZL08UIrt1F6cn8LN2oXHHypfCuWXFO3eJkOPDIYshupwZVxFUhRja0XE+EgDUY5IRRBtUqHsxvvClZW0FeFeuBkjhtNDwGGRcAIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=291NlDr868UDAXGtedU/NCnsqoFKjWpgNCZ2Y6vKyRY=;
 b=Mm5MBRKZgGGS+vbQcEy/YoFvaVCOGYb6yzHpt2fl7x8Je0UA3RVeHfE1vHywaeygXdoRuCDb46TStBVkzAhYV/mDS/zz1tPuIjljKgn3FDScBYKsbnfAbcgtZ+GFM+cI+fER4Tw0sT5NraF816tjAKMW8bsDbC9tQmKhPARMBGk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB6149.namprd10.prod.outlook.com (2603:10b6:8:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.9; Fri, 9 Aug
 2024 10:53:56 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 10:53:56 +0000
Date: Fri, 9 Aug 2024 11:53:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH 08/10] mm: introduce commit_merge(), abstracting merge
 operation
Message-ID: <289329d9-98f5-46e3-81c8-9e522b303028@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <3b04eb13b499df3ebf50ae3cde9a7ed5e76237fd.1722849860.git.lorenzo.stoakes@oracle.com>
 <1f446461-8858-429a-8a0e-cb6b24c6a0c8@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f446461-8858-429a-8a0e-cb6b24c6a0c8@suse.cz>
X-ClientProxiedBy: LO4P265CA0322.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c5146a-7b61-4876-1677-08dcb8619103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1kcYXtQkWh8bs3tAb4hW8aWWrfZGwAGceiD4kwtpNcKjeqPZrnP8pDNjNh0s?=
 =?us-ascii?Q?0i6nJwB7XWxoNUHS4DjGgHOpCIrLFPT/xzNgDuWcGKARufeU3zBRr52JnJfc?=
 =?us-ascii?Q?YOprWge7HAZN5sYBzQQNOQA3QfvquWdj+vKc9otDVM1vMkXFmKr2D6yiuqTp?=
 =?us-ascii?Q?O+1EPC4gZhx4MmTedeVVsS/ub+qggpCXh2648QnPVCCsA+MOTEjBfRf+KS9a?=
 =?us-ascii?Q?jXBXnNjWTLVIWM7pheNuL+OEK2d/Z0zyfNggt1TFiUBYnImpm2zo56H6QCgI?=
 =?us-ascii?Q?F2byuCJmW34E3JmlzVn2jU1xdhfLseUh15oSWu3DNSCE9fWbWJydYcG8+waa?=
 =?us-ascii?Q?I+NTbwntDRv1sue7GUIp/20G7q8hnAczy9q4QZYt2hlzYHqSEIupDZGrRfM5?=
 =?us-ascii?Q?K1tcBhjJiaHyPPDykWDkh0gwRAcJgrkAJnD0n1qpri9NRi6IKZVUmY01LKDe?=
 =?us-ascii?Q?K3U8xLf+sAaxvfRXWl4YrIxNeMT7iS2pvH6wqLr65p+1mmWIQDIhCMxxk4OS?=
 =?us-ascii?Q?tGtun3uaLh8QDweCo4ppKG7Sgd1r2lQBvbmvs5TOSgo0SXf4FAp0DkFZW5Xt?=
 =?us-ascii?Q?RTH2aj5sk483WfMMiDja9qUQmLGoNDNlNqiSk5dEvqwj6NgEvuOy85r1QqXZ?=
 =?us-ascii?Q?AzbFrXEb7s/wH2g7r1EYph5LtfaYUKcu3jaDiMMav9reLku59TjQIywGjwfp?=
 =?us-ascii?Q?6pYbZJ5DKvQuV8mnw3y16mGH3nEg8QobIrtkczdbXJCa/3UCcs+p5Xp0iL+A?=
 =?us-ascii?Q?Ow3w4mbbnsAcHr+PxLAJinHDYgBbX4bbiqvPUW1+jCNYYNQPK3rtg6eUYnsZ?=
 =?us-ascii?Q?ueCpuQNEEJYNmTCgCGk9Ntck+2y/w776likxiLLRcJv0dDTuwfXceqWpNb6w?=
 =?us-ascii?Q?Z83NEw59MfzDexkGUuhxXFN1frtFhQqSukR3KGd+3rF8Zc6gq0pGZojA4L7q?=
 =?us-ascii?Q?NZcfkwnP9y5/4wLjBnOkn1sRIupBhNYI2/q77hv3exYVYCQLGLKHZiq4hHyu?=
 =?us-ascii?Q?vsd6KwvP7p6+ldw8FwR8KaBAYHMJoovKFYOxsXIOwdrxhw2WkEx4JZf/PQru?=
 =?us-ascii?Q?AfrccgyEA+w92YALGYPr9lD6W69iBFQGVqMqj9HknD6Vgglvn5B76C1X3AE3?=
 =?us-ascii?Q?txV3lyHTubDecgMTe8Pe7sGp6LjEmf38g+Z46FDgbZbrk+8GsDFUttQAcez5?=
 =?us-ascii?Q?Ttgplkr8tKP5TLherxgVEZzQ1TKCzqBWGNxrEIcfKny6rnY0fIb26JuHe+PZ?=
 =?us-ascii?Q?PLu+M4rXKwGtrl4PMpIaIg4wC4znArrHh7p/k0FW2iYFg/nHmIvC5+2OrG+A?=
 =?us-ascii?Q?WKj5J5Hcr9GuprpiBVjeEQ9ltszMnEYU/GdUU/MdXgvh2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G+VBwZx0AHoGytZVCHP44c8KrHknExvJbTy5irRiRzZFd4KazYnYAcRGfEEL?=
 =?us-ascii?Q?11WYprOLfJHqSF0YMaz7GFKVTX1oTqykubYmEXsGtoXmI+UlcAW/8v1wu4A9?=
 =?us-ascii?Q?oALNJmKXWpWbA6US50Z9fDsuR5Zc6GKtELVb18eBprTz/Awf827o//ZgcsG3?=
 =?us-ascii?Q?td77v9MXl0qe6eMvvRpM3KbTmXzrWm9IPO++ZT4blsiYvVMI+o8ZOdgnnJlH?=
 =?us-ascii?Q?QZss+RhzROFxQVtQiJ8KjarunggtCKfxP0WEzKSbOwl6j3i/S1x/tHPZEFko?=
 =?us-ascii?Q?2g7YhIFNRh2tE7PKy8GGfKt2v0FCSC6UHl7hZ/T6YpQhtHi3FvC1RpCFjKFd?=
 =?us-ascii?Q?gf1tR3hKMcJC2jgxLvxijVZMqGCQdaYeDwwEKxPEYGvxgd3WlKiZ9soMyoVq?=
 =?us-ascii?Q?bQSazaQs9nN56KHH5IjPiWWYS/mMYF+lmNz8yLnYEwK0+pdSgg4oynlF11zS?=
 =?us-ascii?Q?6H3oKXNPipVODfmM10k1mGTOarGfpbc7ZCL0Xs+8MDIGKj1Mfd65avg91Vhx?=
 =?us-ascii?Q?5Hv9nk4JBGe/PFMXsbL8NTP0fl7rNJp64RHDL9/MCJ6tp5s8t4AAUNxll+Mf?=
 =?us-ascii?Q?2L0zsI0ui5KVt5sxJoJ2kdZA5YJT4J9v94P4jWeRxVyCf13wvUvtdJpO2L+M?=
 =?us-ascii?Q?sdF52O580J7DBaWU/0p8VPQwqaYgf5eQWsKfR/y2akqt67St8O6gALbtrjTO?=
 =?us-ascii?Q?UfoEiXK6lSaedegGu7dAPz+NoxJqnZBrVEGWYqaDKT8N1I/HVmz8WYK3Bkja?=
 =?us-ascii?Q?vaoX/zwRN2HrqV6U/T6/R/BgMHoyFYVS5U64K4VACFoUz4YzvGN16OZA6Xzr?=
 =?us-ascii?Q?wNqcZ5ViEgfn3zEGg1Ug0T85LHZW756AVetQie3UQCle7eKELLws+qqJpWDQ?=
 =?us-ascii?Q?Vxy8DUDnrNIfZMCX2clFknMro5RY8C092H+y40OW9/a+kRS+UVVy0tmgax0E?=
 =?us-ascii?Q?Wiqjs5VxQ7BNwUmJiQaX+8KbMiOXJKRzDcFO8KFYRB2Y6k8rhKa5XnREDGUa?=
 =?us-ascii?Q?LfkllEvr9PPjYCAkDyAvWEYreKgH/doZCZX0xgxZppBDUUi6ejgn8ePNMXYT?=
 =?us-ascii?Q?H1zTXzMOOIIwlTFfc2zison4+4yaRLX7hjA9aSI3q8HpXe7UHn3gbpF6VuOj?=
 =?us-ascii?Q?yY7eILVi0Q55FgrgY7NhOmnP3ZVv6zilAisBjpd8pVgLFn7fjH4Sh0l8ujot?=
 =?us-ascii?Q?yHSb0NRNbnrjX2sPa5P1LBNnlW5FFoege3VDW2RJir1Y7gDBPGSeMtJVdAmn?=
 =?us-ascii?Q?NychNd7L2IxX9TSJ6elpZqx2pn0nYKTkF7MDZf1A/y+1bSOqfkg5hmTw4mCn?=
 =?us-ascii?Q?NL45JJ03OZaUjRKviqR6vXP+zY1CzMB06ySZePf6hoegeQbF7ELQcDN4dKGi?=
 =?us-ascii?Q?ncBS7q6KgavrKxgk3cNun4fyKSnOxx07vOrK6Nv6lq6HZ+/jTr8mfZUQasDd?=
 =?us-ascii?Q?j4AFsHCaOLuU3qR4Q85fd6JIYdIme7M5VHy6lYcrLex5gvIHm1hUEA1S4Dd/?=
 =?us-ascii?Q?sXZk4c2O95+H7G0bbneC+Ao4n79D4HX5YVk8kbqrRRPNIIY73RMmKU2QDiPb?=
 =?us-ascii?Q?wd6L0iJmeYuXt925NO/SwifvgLqa4+UmtnCbuyOT+PJA/gtpdEgGxVLkPOOc?=
 =?us-ascii?Q?xfLiTTjIsJFJDtPr2gs2ppjTXKjePJhNA4KXQhQVqP/xP4fWM/8iwu6R+uXh?=
 =?us-ascii?Q?ZvGwEA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q9YqO72DGIlMchaPE4o9TJI8lQ2qUdZobNdaqRWBSaBYVYyL5TX3DZ3qjtWIcgYba4qVH+g2ALOFEtGkGGdxuaabmvsHw47wLidzR8OB6EUhHiYS08QR5DNQxSdJLc9mj11q0drN9MpnGNcyQQ/5+FAvvXt+iaKY23AtpAn2Skd/5cB7+CBLaztkGMoVL8+76fJzL6rDEfdm+vS8p04cKHn6zZYLz0YUFq1uXUu7frCEmB6ACTI9/QnGkY/wvmgGFZBoHGIK+T755h7hq6tLEUgnzo/uoaJ2k4PP6V2HQq9uvSulvBac8tYbWDnDgVvu/DT5vTvy5s2btl+2Iyx4oB2zbANF62eLXHkMmHC2ZC1NbyK8TNRaRD2qJMft4NeVE4R/KJoAlzVH8O+QglEnqSCNvkuwMxRbk7MURn9dBJOWOjg/9A+JXmfxEvXKO64p4xPXRbWOQ/7PHY+mnM/8SQW5biZ1ARwoe/GxedynPDncQz2cAnpeuwAlqbe/Yj0WfloTXXZIguOpa+8taHd4y8aq9Id+tAsv7eQK0SLNthZwxuosZAcu5ZYYCvVi6x2vyA/j44pym0YoPsnpT+h7+2ykzcpd53zp8roLGWxKhkk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c5146a-7b61-4876-1677-08dcb8619103
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 10:53:56.6475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwMzzlIXaYN5YuD4/lhcHvbgF1VZXv+ZdxYTHInn71zuNIVky7rsCr37WcZi+3bISpmRkP3igL84Adx7M1KzaUtDrBSl59EMpSav9YmYZrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_07,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408090079
X-Proofpoint-ORIG-GUID: WX980yEZKMUF9mbFBw3ny7xJN3Bp4jAN
X-Proofpoint-GUID: WX980yEZKMUF9mbFBw3ny7xJN3Bp4jAN

On Fri, Aug 09, 2024 at 12:15:24PM GMT, Vlastimil Babka wrote:
> On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > Pull this operation into its own function and have vma_expand() call
> > commit_merge() instead.
> >
> > This lays the groundwork for a subsequent patch which replaces vma_merge()
> > with a simpler function which can share the same code.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> In general,
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> If you consider the following suggestions, great:
>
> > ---
> >  mm/vma.c | 57 ++++++++++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 45 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index a404cf718f9e..b7e3c64d5d68 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -564,6 +564,49 @@ void validate_mm(struct mm_struct *mm)
> >  }
> >  #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
> >
> > +/* Actually perform the VMA merge operation. */
> > +static int commit_merge(struct vma_merge_struct *vmg,
> > +			struct vm_area_struct *adjust,
> > +			struct vm_area_struct *remove,
> > +			struct vm_area_struct *remove2,
> > +			long adj_start,
> > +			bool expanded)
>
> I've read the subthread with Petr. I understand it's hard to organize such
> big changes in self-contained units. But maybe it would still be possible to
> introduce this function now without the parameters, and as part of the the
> next patch add the two parameters and the code using them. Maybe it would
> even make git detect the added code as code move from where it's now, so it
> would be more obviousl.

Since both you and Petr make the same point (sorry Petr, I should have
perhaps been a little less resistant to this), I will do this.

As discussed on IRC my position on this is that we're introducing a _really
fundamental_ and important bit of the logic here, intentionally broken out
as a separate commit, and this is why I preferred to introduce it 'fully
formed'.

This function is absolutely fundamental to eliminating the duplication in
do_brk_flags() + mmap_region() and to maintain two separate new/modified
vma versions of vma_merge().

HOWEVER, I totally accept that this makes review much more of a pain in the
arse, and in practice almost certainly the only thing that matters is
reviewability here as to how I structure this.

So TL;DR: I'll do what you both ask and introduce new params only when we
use them.

>
> > +{
> > +	struct vma_prepare vp;
> > +
> > +	init_multi_vma_prep(&vp, vmg->vma, adjust, remove, remove2);
> > +
> > +	if (expanded) {
> > +		vma_iter_config(vmg->vmi, vmg->start, vmg->end);
>
> This originally had a comment
>
> /* Note: vma iterator must be pointing to 'start' */
>
> and now it's gone.

Will check and re-add if it makes sense. I mean we're now setting the iterator
to start anyway so I don't see that this has value? Maybe I'm missing something
and Liam has thoughts...

>
> > +	} else {
> > +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
> > +				adjust->vm_end);
>
> And this less obvious one has none either :(

I will add a comment.

>
> > +	}
> > +
> > +	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
> > +		return -ENOMEM;
> > +
> > +	vma_prepare(&vp);
> > +	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, adj_start);
> > +	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);
> > +
> > +	if (expanded)
> > +		vma_iter_store(vmg->vmi, vmg->vma);
> > +
> > +	if (adj_start) {
> > +		adjust->vm_start += adj_start;
> > +		adjust->vm_pgoff += PHYS_PFN(adj_start);
> > +		if (adj_start < 0) {
> > +			WARN_ON(expanded);
> > +			vma_iter_store(vmg->vmi, adjust);
> > +		}
> > +	}
> > +
> > +	vma_complete(&vp, vmg->vmi, vmg->vma->vm_mm);
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * vma_merge_new_vma - Attempt to merge a new VMA into address space
> >   *
> > @@ -700,7 +743,6 @@ int vma_expand(struct vma_merge_struct *vmg)
> >  	bool remove_next = false;
> >  	struct vm_area_struct *vma = vmg->vma;
> >  	struct vm_area_struct *next = vmg->next;
> > -	struct vma_prepare vp;
> >
> >  	vma_start_write(vma);
> >  	if (next && (vma != next) && (vmg->end == next->vm_end)) {
> > @@ -713,24 +755,15 @@ int vma_expand(struct vma_merge_struct *vmg)
> >  			return ret;
> >  	}
> >
> > -	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
> >  	/* Not merging but overwriting any part of next is not handled. */
> > -	VM_WARN_ON(next && !vp.remove &&
> > +	VM_WARN_ON(next && !remove_next &&
> >  		  next != vma && vmg->end > next->vm_start);
> >  	/* Only handles expanding */
> >  	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
> >
> > -	/* Note: vma iterator must be pointing to 'start' */
> > -	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
> > -	if (vma_iter_prealloc(vmg->vmi, vma))
> > +	if (commit_merge(vmg, NULL, remove_next ? next : NULL, NULL, 0, true))
> >  		goto nomem;
> >
> > -	vma_prepare(&vp);
> > -	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
> > -	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
> > -	vma_iter_store(vmg->vmi, vma);
> > -
> > -	vma_complete(&vp, vmg->vmi, vma->vm_mm);
> >  	return 0;
> >
> >  nomem:
>


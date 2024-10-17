Return-Path: <linux-kernel+bounces-370742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B429A317F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E87F1C22F79
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59F1D6195;
	Thu, 17 Oct 2024 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HgxsH3F+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BYKyS6o/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F5120E304
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729209227; cv=fail; b=jl5/T49XmmS51tYjZUb9HDFZrYJMH5S7DRBf24WH99kTU4L8xbbQXdSHB3RT0CC57EO6fCb6kqEBh4Lp8PS+XNPUYWcBXlP95EK87vnUuqoV1LrOccEdfZH4vuBhu5TPu6v37VTsSOQpKwTY97nZJPRwZzUKYzcqkalEN4ljWXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729209227; c=relaxed/simple;
	bh=h8oi7PDUxQlhCBjbdFFsQDOstLtz9qDiAoKaoBPatVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RSR6HB62qI1N1ryY0famsSR8IyPkg3+1y+Tox8DOxucTPtGWFkvjmsHc5T74+YBnkND3Xk0kNXoVK851nsTTFYw/9ej/7qnLQat8VzpyhO5UzPnbVKcMa4kaGGetv1WZiy8WD0X6jd/XUEtCOD5Y5H4njK4KRtcpJoaR0p/leRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HgxsH3F+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BYKyS6o/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HNnTWd012087;
	Thu, 17 Oct 2024 23:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/6IBwzFPTIWDjkWNJB
	Iu4uFv6zZff9TYLbNlqUbxWfg=; b=HgxsH3F+mG0SG0+E2Grgs47eXpQ5q18F6S
	8K9sZDO6NofZNbbe8eV8UOrhRDpr4AnwYiEn93Ftdd6IZGLjog4HORGJqdKAYorI
	2DPTQnTbzLW8qqXYfmjqJAKo7zJwK3nsuCE2NB3WV/ef4nR5Syf2hyYzM0XKycGm
	GhD181jf3vhfpSTVxMJbmPSMt1NnpVclfVHE+nXpjlF/7KbrSK0XSXIUzZSvsPAw
	YCH2PCLG5qV2o6pzBMTkKCdrDDdtYluk0lYg9O1v61xDk2gcvs6YEVgtGzicO6FU
	fRg3WCB8T4Ssq0p3ggEt54FduC2S96D94Qz10Y2IBWzvDArdZskA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1aqdn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 23:53:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HMKcBI011039;
	Thu, 17 Oct 2024 23:53:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjh9ctd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 23:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0Q0SQftC0BHT3k18Ba4Lj998MbWilMxT5KY1XtTzcRH1O2FGRsiH7G8kFWO+z3CafTHw7Hz7KGabvdkgAQ34nnIMlS6vO6YqGMTOu4rrZdPYA0Hk3Vfb48zJzP2E1ZgST8fTIqf4PtWfxZcFUKZdJuCMIocrI/pSOwM8LOtsbWO6jDA3mUjQow3kXGLWAPOzAKhpY6VOswcboFaOfPPjby1txw3t6/fXL+7RS7GXESUJm7ggsW7g4uT4fTaXDDs0AcPslKZ9aL86Glbt0S/MRRwfjGN+rwECUbsZ536B+d+Pwxoe7vi/wAN/MPNlt1xlTdaPIyx7xAtmUFs/p7ZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6IBwzFPTIWDjkWNJBIu4uFv6zZff9TYLbNlqUbxWfg=;
 b=KKv5UTHIBqvrsTdREThFwNrnK0ayzlJS4mudKkMFHEF+ifjC6eHM07GEWLuM4ohahKdkkuXTObPL4M4Y6BZtHrvJdZ9ZRCi9nbU4j3z9O8/N0/wP1c+I+NKiIogUXvUyKAaoRUT84E3a/VEGYWYEr40u4ozqi/Xv5FKF7JW+yFOYAmIqzW/LsmeLCPcrNnaOXXj2om4iX5abxjcKg+aVGwGXIUA5MqdxcQk/r/toAQ8aenr6tzuCdKT8B5bIBst4ghVI294eE6WV6hIqsCW7miX1oSXy2x7rzXvlVp7r3k6pIAWV0JOJZdlhgiXNedY6D9iZpJCST8/i044pPRBusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6IBwzFPTIWDjkWNJBIu4uFv6zZff9TYLbNlqUbxWfg=;
 b=BYKyS6o/ExeM8GGukHbh99fVnfBq1laA0aBKSaIzZ87TK0uX14/21oy/iEbWrqaCDv0jUBOUNXW98sdNi8zid14zQ37NHg33EskjtA5WIjeBtBn6bOuPX2oNY9ZBK8MXBHetTK8tU9JL0UjapoJnkOu7Q1U9Zf9VTxi34YqOzQA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW4PR10MB6632.namprd10.prod.outlook.com (2603:10b6:303:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 23:53:15 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 23:53:13 +0000
Date: Thu, 17 Oct 2024 19:53:10 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Xu <jeffxu@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Pedro Falcato <pedro.falcato@gmail.com>
Subject: Re: [PATCH 1/2] mm/mremap: Clean up vma_to_resize()
Message-ID: <hwz7y3jqi7ynxwtqzisrlo3zrdkdwlfb45nb4nixjcontpiry6@mdtki5al2no5>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>
References: <20241016201719.2449143-1-Liam.Howlett@oracle.com>
 <20241016201719.2449143-2-Liam.Howlett@oracle.com>
 <CABi2SkWhgY4amyT+EGTma7a9ymPs7ArnFLkAnm5ko556DpC_Cg@mail.gmail.com>
 <4izjonpaqhkx6p3csfyxcjicgqahbmj2k6gupazehb3l7xhnvi@twlvpx2wc6ce>
 <CABi2SkW1Au3WZ6Qem=FppOFBGRn3GDJo5+U3yXpk2brK9MR8NQ@mail.gmail.com>
 <20241017140813.fe555ec947b17dd035e4c0d7@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017140813.fe555ec947b17dd035e4c0d7@linux-foundation.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0337.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW4PR10MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0b3bef-4b21-4c72-cbcf-08dcef06dc5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oUVLpD7aY1W3ivDxjm85NDcCSihz3EMsVlLw3hxx+RE0M2/DbhPEY6y68SyD?=
 =?us-ascii?Q?LmY2mgZjgyHA6X/VZj4/06+p8NPVN/CUDjBvMvFZ2xy4/o+XZjQw44D8EdX3?=
 =?us-ascii?Q?7m9ASeSPK2O9sRa3DJXZWB45NmZGwjr+dSTlj4exwZnqIO7h5YdtYYs+Zs8w?=
 =?us-ascii?Q?ZvkRg4267T70WyVYay+Tf/cbeuiAZbC6KyceL9CHWdwh/mAwoYKB8jDSpZj2?=
 =?us-ascii?Q?+6uMiM3XDM30eQMzBK766TAEbtOaR/1USsPd3FdrkqQVZEUE9gTu+1oPXeps?=
 =?us-ascii?Q?eirewVwLMvGv1rQUfvQ2u4i735ywaGcAxYwUrjy5ggrrJvVik5+trQHH+z26?=
 =?us-ascii?Q?uRIvpYC8QtmgzA/KT+UYaiUtjNl5hilTEtrHbiuszcIemH2txFcxfuHgC7RB?=
 =?us-ascii?Q?Q179hwOBawZsFpjCfE57bqNsvVfqMg4nqKkoGPfPByCo45M3qynkgnfPDsSF?=
 =?us-ascii?Q?EZmzIwmQAZLAzsPCjytAhXkRElCNJ2nujHAQXZFXsjm+iY1YnOneJtEZKeDy?=
 =?us-ascii?Q?T0GA9h+LbI4qGdtWHEGiex1cpbM7oKqqWcr8vD0jAU5oPDOUvNtn7SNwAr5+?=
 =?us-ascii?Q?YxU+6qVuWfIk3mJhxXFsKGOnGn7ULkSI1NexgWfmzWd1Iw5CUG2YO5HCa6S5?=
 =?us-ascii?Q?yfuBNzxVpKaCDAT+cUW8iroLz89tebeCCAvKaFqsSTHKR77TdDxF8vLmcAIo?=
 =?us-ascii?Q?CmeqvOKWsoPmC85/11/Qbs28uASVAPhRoxnybAnkYCArUdOQllAWjFi8BzMM?=
 =?us-ascii?Q?CYFhnt/5tH0nEPjWwlKdy7gDwEu7MJ6BJiPJW8tEILxPY9lUBq/U7j4EaFDO?=
 =?us-ascii?Q?rJgoeyje2FQbqQipwQjqDU4I4bTjqJQzGQKaXIZqwuuBch2lUds+QLybT93s?=
 =?us-ascii?Q?4B7ye4UAoDQnhgQlEgNio+yiIMEl7V4p7UKaBC7JLlV2NbxJhh+2JSL0Tq0G?=
 =?us-ascii?Q?7aJTfmS24ou///Cmia8JlvhT3idLK81H4rd2IRXGUDX76Ap5ccSwom4RzHss?=
 =?us-ascii?Q?pXwj3ldzIbqHJAudpH61Gs2Wegbj/V2t+4y8Bq3qg0tKch69vC47zDL4mBoW?=
 =?us-ascii?Q?kiWDJLdAhmBj773JTGU2UFvuI8ogQZoU3xeMYhv6pSA2mR2yNIwwEsGsrKfr?=
 =?us-ascii?Q?rVNW9HlnoGReI1TCcRwisxU6TOglXgahRM33E0MF1Mxm1cwMcEJARigvfmL1?=
 =?us-ascii?Q?umRExJDHpvEfY2sBwmeKQJSM2LIm5EgXJcA4pAtqr1l8nQ2NHlt/Ijq2twUK?=
 =?us-ascii?Q?zfSOeQqWgEli7vQkpPEvKCWrc0E6l40Ig7z5JgiPL1rMbczebafasl4AQTuP?=
 =?us-ascii?Q?QNnZca71QJssznH5NLwkKj5d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?43lbmKgjZjNANIw+tHITPhPux9RHRwNR/t0IScRTvaGaH7qzgRADE5R+ZzGM?=
 =?us-ascii?Q?VwqZEaMsUjBZdFVfoNh34dKU/y49C53dz6Q1b7L15tY/ya0uny9mTY8l2waX?=
 =?us-ascii?Q?nVLeHRMj2talxQ7OZKthsNB0Y2L8++PHfE0OB4ukvGR2uNRkD6jxO4mwnEGf?=
 =?us-ascii?Q?SMcWEctq1vFz3iIFq3ViHdHI+eq3RIzBe9tdv7L7PWWCgJ98pft0sGRUH7o8?=
 =?us-ascii?Q?7MXbBXidRKvNGUvopI9f9x2YTizXm60LwRJD6OaGLANeq86I7HzsvQdKjJYe?=
 =?us-ascii?Q?9o142AJ9UvvbXng+2wCZIF0HWMshHaVC3ToCQpVF3kjxSR3JIIuFH9jOt5aF?=
 =?us-ascii?Q?wapfkh3f7FwD5a0qEJi8k+i6VO2X2ng7LLVKxTywG8bTUouV5YhQfOOK65Af?=
 =?us-ascii?Q?JaBwhnGNvxzwlfDok8z5ef/a4rfXP596vlvq7s3hBW+1+52G8PTQhpxDW7al?=
 =?us-ascii?Q?MxXrpDEfQc6y1Oee6CGo30HOWkb5k5ZDqv/ChrfUnuE7AD8JtOJIz77idoPA?=
 =?us-ascii?Q?Y9EPAPZ9t8d9/dVY1gpZbm8UBUThdHCeaoV+My+YEBBtfvxa7dabHOXcNX+x?=
 =?us-ascii?Q?q2NwcT07TlsHODkh452uq+J0JqMSQXlDw5ZL0Mb9XonTZWAYq2mI52KKBHTZ?=
 =?us-ascii?Q?vvGTwjOmMMP4o8I9n+xq8AYlTAzBkibZzuBb33GaJ6wfxPEIcEBiLl1WyFD8?=
 =?us-ascii?Q?ckGd0NppN9cCXBobgfrLjpZAuYcF+iyyQ4cDd1mkUxNtGbKqEfxdSANZ5v2J?=
 =?us-ascii?Q?lKEOwVlRcuSm4CcgFkq4wD7Mer6N9xUdw0zJuts+J5y/F6RQwImwYljql3ey?=
 =?us-ascii?Q?5ZpZ2TaG8eeMTXW/oyEgW5x3JOuYrxiY9wFUPcSQG8LbrDLn3r4AmMgPbx/A?=
 =?us-ascii?Q?QeIdwpQG5d52DgxlX0HojVWd12B8N8Du7keRa+rZpUvf+zOyMI0fwzH5wjdy?=
 =?us-ascii?Q?WcodtAf2MBoP2/OuWTz4Gsb1ybsSuxVXURIWTfl8R9mN8N1r9HtjEJtugkIV?=
 =?us-ascii?Q?W/UlwQjh+4ywQt6LkbSC1LfvL1wP1NH6qifnsrPpD7CWmfifwUI08mo1E8rY?=
 =?us-ascii?Q?dpivDao7ZeCsMmf/ShSYXba+F1RVa8Z6x2yt16MZBeDHyY0QL7mUsRmZ9xm9?=
 =?us-ascii?Q?9WJ2cWEmaM86VTMvKWiB9BncXycAIFPb4UCdWrP/VNBp1onXpfb3YiqRaOXV?=
 =?us-ascii?Q?xXP7dP37pYds9dsdfG+teNlfdkIQz4RB7OOOgExNG3KNkYKYDu+gYHpkT2Az?=
 =?us-ascii?Q?lMWUNCXii15iuQwrfcyMaGC9fTNR1H73ZZx7vmXZie5so63CR6PcSiPGiBn/?=
 =?us-ascii?Q?Kg9FYudGQTI4XRBTp7xJs9ImC+h+Ei1dBSIpgPKNPozASwTP/dhOHn8V9qnK?=
 =?us-ascii?Q?6X8uzQ4zDU/sOsKah7UNfWpeBPTQdjJw+NQg2F7EJ6od9oQ12tFmUwwF49u8?=
 =?us-ascii?Q?f2qN3hMu6YGuGxlxYZldOgTOS+eSQ6DlisxhmQChNlM/5d0CNe2Ijdzx0Yit?=
 =?us-ascii?Q?+uL6HpCUCN2VGyGQy5SXhh8rabFHtQn6yyd6isGdSb0ZJ4ILWsUzzusUT3oU?=
 =?us-ascii?Q?48Rx0jtfgHX1qcV3ZI9/YixliuUU6x/AEYmF2RNQxf7tGmCRvWd5FWfu51hr?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jRCXlfrDx4mudRpZVkCJQLTkds5wrRBmTTG/GYnzpP2fuQrR6EYwcsP/UazkVN53jYR0uk0HPADdv7A2CeKYBqwwV07E1/KFvljQyZzP/JWdKRh+iuMyUle9uDMjpm9jTfWj9ip2zgULN+5P+l77GhwzGgh9w7oybpstIMyJ0mTnqOhi5NCzJlQVwh6Rx+iNs7hP171anaA65RbYGE/HNNLpN0Y0GvwJb3JZ7cUgSc63ZR6l0843Uw7h8iM2PdRMVWkq+o6Ns2mLxc6fX4Cw0yeG+cqOBFP5O0oLljhKXm/sM3Aeespxp5JBwXpv3XwDp+TWqyyB0xTz9+5dRcqzwMPfNDgy46aU7NNSH2uy0yNKJHLtkIedv+5u/3jKXyVGBTRN6R5bUXyr9zSHRVt3NPNE0kDjd7dk6QGcEsNdIphZ4JWE35guccx/+nu1fypnbt3MzY15HTCAG7DmAZCm41L/OEPXtjwBAVKWioqyt8fXtaXN5ubNGseKJqFEJ64XJpTFqV3SC+9Oho4pigJk1bmk7KZpmitc9FRNXEx09E5ZG7HUfeqMyzkJ2H8Z4bDuRPaymSRrTxaLJZSWLaa1EPr8kMzDdBY48B/EhRe2qnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0b3bef-4b21-4c72-cbcf-08dcef06dc5c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 23:53:13.3839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtboM1yh5I7UT6tEOjBwVugN4K4Tk/u1ktfQVKu3n0AZbDax/cuPmX01MW/SXq7e69QuLbEGw+CFPPtfumLhCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_26,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170161
X-Proofpoint-GUID: QmNRXEJT2f2Syx6dDe26OEvrBX9rD13m
X-Proofpoint-ORIG-GUID: QmNRXEJT2f2Syx6dDe26OEvrBX9rD13m

* Andrew Morton <akpm@linux-foundation.org> [241017 17:08]:
> On Thu, 17 Oct 2024 11:15:20 -0700 Jeff Xu <jeffxu@chromium.org> wrote:
> 
> > > > > -static struct vm_area_struct *vma_to_resize(unsigned long addr,
> > > > > +static int mremap_vma_check(struct vm_area_struct *vma, unsigned long addr,
> > > > The original function is vma_to_resize, and mremap_vma_check is
> > > > missing this context.
> > > > Maybe mremap_vma_check_resize is a better name ?
> > >
> > > Good point.  That suggestion is long though.  Perhaps
> > > vma_check_resize(), since this is a static function in the mremap.c
> > > file, it is fine to drop mremap from the name.
> > >
> > I'm ok with that.
> 
> Any function with "check" in the name makes my teeth ache.  "check"
> what?  And the name doesn't carry any connotation of the return value's
> meaning.
> 
> eg, "check_the_cheese()" versus "cheese_is_fresh()".  The latter name
> tells you what is being checked and it tells you what a "true" return
> value means.

Fair enough, how about resize_is_valid()?

> 
> Also, the dang function isn't documented.

I'll add that, thanks.

> 
> Also, why is mremap_to() calling mremap_vma_check() without testing its
> return value?  mremap_vma_check() doesn't actually alter anything, does
> it?  If it does then it's misnamed.

That's an issue, I'll fix it.

Thanks,
Liam



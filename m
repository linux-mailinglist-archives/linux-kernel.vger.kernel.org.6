Return-Path: <linux-kernel+bounces-555092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DFFA5A554
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96814188D9FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93CA1E2307;
	Mon, 10 Mar 2025 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NclxpUOT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jm6CEn5+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDBA1E0DF5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639913; cv=fail; b=BRNoZHrBKvZSCEyatdO8VljPAmwfcmYj7kZTF3De1/lw0dHNgAan79R4YOwYTZlYPYNeDEMGTP6XBaO7ZI7WE5THhvaOkXYkKr4xtrVjBO5LK+yR5UdPRKeTL2GCTEi7uW7v23lSSGhqBUCYBz8nhQK3dJd1JaFpyYGmVBg5/5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639913; c=relaxed/simple;
	bh=LEszwJHzu/1U044LBxRELFyjXCxcn5EjmX2+wlDez3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxMMX4/90jFST/SMdkikuLGAp4b87Gbz4k2gcfGK9M5lu1bkN/CFB9BwtQhFXVwJTjxpEipfSTFsO1XylipVAiICl76l9womnAxf3lYBukVY5nhpdH7Hl2Q1vsruWRQ+YpYpOoJCyu1i1Zg5Z3slXqf9NvOfIVnUq/zyHMtaZx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NclxpUOT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jm6CEn5+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJthkk014325;
	Mon, 10 Mar 2025 20:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JPOo9icsVe9FPtrCOi5izqjFol1FmDVgMlGw/SXOrb8=; b=
	NclxpUOTKpXuqbIYbkBMu3gI5dAIzbPBVfAf5bGoqMQXnHT81w/ghE7tH0R3+E/k
	t0PYig37Rk1ekFpe/6tBUSycJgmDmOcXW4NqiIK0rwDmS+jm75OFogFBMl/hT1Im
	iOTaOKZJIqf+4jz4WynH5dR5SdmYaxNOXZdYQmHbIfnQqQE05xjOelIxNQ7P+oNn
	K1lfY4gret0aoeCMxJnIbyLR+SIlsf8GyvLL12Zhx/2ydCMwI18CMrM7sTXyDcXS
	5iSXKnYFhAYJSHYcaI2sGUow/XQ1/EjRuHzZhNwk7GZib0lxlB/F+z3V06wJaz7c
	LrAB2kFYYWv+TqUUvlbCSA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dxckj69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKPaFk030679;
	Mon, 10 Mar 2025 20:51:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcmgcvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBrgATb//mDbfKe2PRXIAM4xOS9m27P9vw70PxTdat/2rNl+wflQVKuy8QjJccnx0OR+sUbpxiWNIFl5ORdb/XZuHavZxSLKqM6j9dk1Ggva0oBgyhBJjNX7SkVNkAFA8PIornp/hFqBQWmYBzkkNZs4uiAXjmvH3w3KVRzmvmMKJ9QVEgz3fQhQlTJZRg1TrqgkaVcvV//+bz+moln9oSgQnKJ164qKVuNteYEz404UEB5+JZO1TIQzzG9FQzSicbmskMBCDYU2WNt7OZjfWVqPODiiQipgy+tuHjrK1/31gFeqtnDFkdsf88xIiyQG7f4qqq6ESNp6A7VbZyfw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPOo9icsVe9FPtrCOi5izqjFol1FmDVgMlGw/SXOrb8=;
 b=a8ldGpRKDZ9ONaef1Yzh7n74v1pH93xZG/86OuokWiOAj63ZlSuPAnizn4FMpKxQMf+kqesMP+0CFUK9WK1zSXPFd2JQuI0d3/ET3rZrAU7p1Mu3PEeHQL+XWcyr9osTns/Trf4SMh7k9I3KQB7t+hkowJveFnIMW6lNYNsJX/04iIA96UiqoK2q7MgHMpOlCz+PoLnb+AFXk99TG8SJnnWJprxz0OLr6N1PPSZkR9MJPT1Z28lclMobg0IXYxWXVa36dPl2S406y8UgL38NnT5P5GfOcy+R1UwGiwDpQCO4sATMfMmLhTs8MvA7voSXwrWrbJ/4jUzJAB+YfEuFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPOo9icsVe9FPtrCOi5izqjFol1FmDVgMlGw/SXOrb8=;
 b=jm6CEn5+Oj5/lkmRLcGYdGRXUYGNSQA8ZvVdXFUx+ed5sXL3RlnnOt4drdGErsA7GMhAzG6nb7cXt+DSmMGpwZnz6G815Xj+NUtItNMsr1RWObYghusAgdUQkR5tObA0+95HZZOczz59vBW5w2ulFqyhFx1nAR2Yso01mcmsR8U=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 20:51:36 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 20:51:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v3 6/7] mm/mremap: refactor move_page_tables(), abstracting state
Date: Mon, 10 Mar 2025 20:50:39 +0000
Message-ID: <e20180add9c8746184aa3f23a61fff69a06cdaa9.1741639347.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
References: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0281.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::13) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: b85fc2bd-f14b-4f90-88bf-08dd6015593f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YtNObvxi89U+OzjIld2qva33jH5751FhLBVU7rHcYRLga1r8pOVobV1JEcTN?=
 =?us-ascii?Q?mj4qOUVmq0uxFSmbv/NRrgTFHfRUNamU2sEzSjeVKJZJy7riMQz1hQGYkuA6?=
 =?us-ascii?Q?6QMm8+WqxCJc6M7Hu3r8VBeQZpktPfPat+qAcMoUh4YeaiPanEKidTz1Ii3o?=
 =?us-ascii?Q?h/XOQdaOPRV7X9bNgzZSDldLnxTrbShchwTOKS5CUqzguH+I4ngCguwqXKvI?=
 =?us-ascii?Q?9xeYRIvNPt1h7r8BGU4c7+JM9Sk0g0CQgar8Fr6iOba/bBBRn+1f0086NQDQ?=
 =?us-ascii?Q?QxAqgvj7LwWnUiGw6z4eH88QBtmtObUT6idGGnIZmSi3PERpWR59qXPXStEo?=
 =?us-ascii?Q?zOZznx+zE/HptC6xle8VddQJvzFrn2bfLwJReMtJFlJmvu6a6BDEikirjWMC?=
 =?us-ascii?Q?4TqpcLwpDbkpuOa9Lvz21ojzbklPGbquqxJAMF4aCCy3HN9Rk33SSGhWpgXE?=
 =?us-ascii?Q?XTtFzBTvZ8hDGjpd0LU6nlHFjpMj33EE1gZRkP0Hzl6obJbHl2BAh9cyHDKt?=
 =?us-ascii?Q?vbjOCNIzuAlH5AxgMkm21hbBzovcHRaSA3bvtAZ5j/RTcoc7bmYJEBawc5xa?=
 =?us-ascii?Q?d4EwDSl+8VuQfVDXfMbUbotkdeJfkPiN88lX1WSXyR2Mne+MwIId3TlHNh/7?=
 =?us-ascii?Q?1/1VKgbGiU74f2/LDYLf+r21ge/sRssN24RAu5+M6Vxqq5nNOS4IHE2QAc/0?=
 =?us-ascii?Q?n3c3sXKc9aP7jCUm6JaB1UrclXKHSRITExbgK8dml5+n8DKmgEQljdAx9DAg?=
 =?us-ascii?Q?VqcCpm7gxT+GFwkhRbeXZ+iUNhKIeArXsmRh/B7ERoHNSVKHbRQP4kanGhAi?=
 =?us-ascii?Q?mHyCdgv0KM3xwEXmQxBWdVs0s08OA/W6jhS5CDfN101fNqNI8CckxN8OkPhR?=
 =?us-ascii?Q?6pBKrJUFX7rjyo18TN1kw5lC80MeATtTyoqFQSNdUbu8qZKCYtDgQjyI6VdM?=
 =?us-ascii?Q?i6S0lB4m2f7YsrTnI2d0cifJpoA3P7VuDVQSpSbKKCkh0DlKa3zBkjd1csj9?=
 =?us-ascii?Q?M1zTccsmfj8AmGN1TWupWtPRAUPLRguD3zd76iJO3y3YjsHJdOlbiD/Blltv?=
 =?us-ascii?Q?06h6Tm66UM10qRiv8RT712SQSo33freVwTGEyNzXfX3bhb/tiSgOmgBc0wpI?=
 =?us-ascii?Q?jbAMul2Sm6h1Va6LwIeCNpRw7xrPTPv7UlByL/7arbxdrxPz/CHikoF38lkM?=
 =?us-ascii?Q?4PEXDo23spdMyQSl0YLHCuoszdEG7vplbLXymXPnhFGIJWSq4t3+vQi5N/v3?=
 =?us-ascii?Q?JXzZNSouEHCE28xtKab1yoSkqOjcLKOuVsf145wJ4BcPpqCC/WmRblH5HxNI?=
 =?us-ascii?Q?uGjvb9mhmloJMwiXmT5u7/drF0lTFzXWQw4LvNbBg74ng1RrR/llBhGZsdhB?=
 =?us-ascii?Q?ipF6pP7QhJpa5WVgkNkF0bGoinbS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QB04A5fL1za90S5NvfT20Tjp0zRUtQHr05oh5M6nhU3bbZwj6u/aVN0cfRSJ?=
 =?us-ascii?Q?YJkuIaVemB3WWgcpfCAicoQqblA1x22rjdMyE8FiFJGC3u6o6cCy5DcQqQuT?=
 =?us-ascii?Q?zgMF3PuHp3XxkJcpFhfDJCwGJusO3kyirxP4IVArtrKnXgAMzNtuSj4tYLE6?=
 =?us-ascii?Q?YxR8YwYTouI6ro9VwTCjVY6ZyfB/3MKgTNvsMfQUqbpUiDB9igQPfHey1+hp?=
 =?us-ascii?Q?trunzsCYLKB5lprChVKSW0O0H/h4u6juUJGJRb0XijL/TLagS7gYFC7PgeUt?=
 =?us-ascii?Q?RpNiCbNJUQFb3yrd05gdAEWJZ77Ekn7L8MOixBnAiXFSpUvRw8ATBW6naIRs?=
 =?us-ascii?Q?/Tl38Km5hrzwNLahZVG+LjGxajqU2tC7lI+Oeu4FcCuV4vlSoyU+vrHKqHwS?=
 =?us-ascii?Q?rEnTmnxGupAavxiXFMNRSAJp24jL/47ZVVLQ0befWHPQV/UX+96q4MRg+Mip?=
 =?us-ascii?Q?uO1hOYZHkkQZLXB/dxsq202swAg50puHK4OSEGmxsWSXP0mfVvJ4mRIXdY0p?=
 =?us-ascii?Q?C1eCaSQ1bJPaf3UEvFgIXpQyCePzC+Kf4OkYol3r0fv69ZDaG1nUvSnfP/5W?=
 =?us-ascii?Q?B8j2KbNg+aT7JxcNfgUVy9gICPEKPZwI4YKJPB3FMHAmXwmFWzYu27tGHk3V?=
 =?us-ascii?Q?W6GSAAOL6uQQqNWTb30oLHc5GmforcrNY2j5eQDmT4bG7Vcj2YvxfdTONfYi?=
 =?us-ascii?Q?sYPL0gPuycl5DlVkSw1HKlsRMzPSYV2ApsWy4He6Qhz855hHHZDiaRKUo3hQ?=
 =?us-ascii?Q?ebPZZv1Pa26DYCN8NTAbXRotjeq8RHItOiukaT6qv2rMz6BNLX6rxWyTXm8P?=
 =?us-ascii?Q?Q7JCHKfFKvGhnOI2NOWVelINZ/wQjHg36TsTfWVnaaSj5515nYQqB30B86Sa?=
 =?us-ascii?Q?po4ApKVSqrMQPdkDGugw/SatgN+HChCCdp1Z2hCHNkYgWDB8mXc9PNuMkgj+?=
 =?us-ascii?Q?ocijw6xQOHQopvY6FISzAeVsJHm4GVQQNIn6h6tUbD8ile5JZrHnksJQiVv7?=
 =?us-ascii?Q?enGjzHskpnTMhS3ApOLXCG5es5iVOXUuwYo40KWfjxCNpqDGnUZuteU7yoLs?=
 =?us-ascii?Q?4YOEDwCIyUIga0q2zyduexZzIhujTQyHZliE0FpGb5jJ5pV/4Cpn6AlMHpnf?=
 =?us-ascii?Q?A/0FPjKujPVBt6wO5lUfytT3BHb6ZNPMQ0jYfbitGP04Ilrg8UatNExZxUxU?=
 =?us-ascii?Q?bPrExGMGoMGnSYbIyRepXBILPzQ6PQmiD6E0PTvsO8Q2eiAUsj1UKNqcrZas?=
 =?us-ascii?Q?XWDlPqX1HcXGjkzk/i3TGbuY+tao+zb+gXmZaOoPdi8yPoXiK5H4HoBeo8uL?=
 =?us-ascii?Q?uNbB62RObCv+fXhmJCpFeHoJKUjOIBnWeVMiLpPx6jHyK7W97C1/Z1AN0F6a?=
 =?us-ascii?Q?tCMFKjDcPpYe4NaL1tmBfAchObtDD1G6YN0I8Mkkuwc/K4s1DsDYYf/YoAjx?=
 =?us-ascii?Q?7r2/jvTyimUrSV7zSlzVi0Zq6vu/HLQb03toJjfxPIuYlelu2sJBkKufJIoY?=
 =?us-ascii?Q?il0DeVZfBwTWUGgtSSm+lut6fEsastVeVWqHy6OkdXjgrKCLNK9f2Y0JagGd?=
 =?us-ascii?Q?rJ8DADaX8Wv/5TnodK5LYKxyOMGPUHPnzV6R6ArNq3UKpsMTVylHQXee/zcf?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YdvB/qhuSe6EK+adjvnWtRClzNgVDzas43ZlziIDAhKT44HVfzgFlV9jKwVglUyi4DM/nqDv/Hy4fI6hpEShV2QDjZxLAhes/cZTdIMK8nuE47WpfKCPuSegV/7uRsaJMBjrRukiUM2IMn5iu1WP7WDP7HmLYme6So5yfq3pjTu7jEScs2nYHo/wiwHezU+lj+juUug/qRE6JDF0V5VepjVR8aQxX5EPWrHIc/Zl3l+t4Pn2GWz3C1UzKLMprj1MuD2Q0qMqVr7ubvZnVBN5dahOVEUyp4WwT36x2bLFh//6CejbHkzdO3kK2Fp2hAZ7i3ClZxemckcCUEByMKbzLikKZa4GzfuxrqEgs0rheQOmw8kwUU7HPiDs6y/ttA60OKUQWbTiZaOoV3H/4CRd4aRlj0im6WD1h2Xz+9Kfa1wg6u09ntzD5uEcx6rNVvoyfrZvIRkzGfUF6J6uh0nxwnvd32hCTvQkaWsAL/QUOPC8mtVy/vOI30pe9kXraNdtK0HQnLbFgfxHTvHF7axceW/0MsAg6IAT5A5lczsfd6n8qbIxN12KXJa4D37xUFtgoJvD/tuzhJ6jUDcnnWVojlY57t+2zjvJoBKAyvH3DAQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85fc2bd-f14b-4f90-88bf-08dd6015593f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:51:36.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naIrZXzpguM9t4qZaJbE4fe/8MC1mRK76v1SpXVN8H0UVkfhGaTcoYRSmQ86ZbMN2Cp9f1PIda2K6SlPNtUN9ZpKT938BSnXQ1gGlTgC5n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100159
X-Proofpoint-ORIG-GUID: f_l22NFSamZdvVBI-lOHesr1BF3UVZLn
X-Proofpoint-GUID: f_l22NFSamZdvVBI-lOHesr1BF3UVZLn

A lot of state is threaded throughout the page table moving logic within
the mremap code, including boolean values which control behaviour
specifically in regard to whether rmap locks need be held over the
operation and whether the VMA belongs to a temporary stack being moved by
move_arg_pages() (and consequently, relocate_vma_down()).

As we already transmit state throughout this operation, it is neater and
more readable to maintain a small state object.  We do so in the form of
pagetable_move_control.

In addition, this allows us to update parameters within the state as we
manipulate things, for instance with regard to the page table realignment
logic.

In future I want to add additional functionality to the page table logic,
so this is an additional motivation for making it easier to do so.

This patch changes move_page_tables() to accept a pointer to a
pagetable_move_control struct, and performs changes at this level only.
Further page table logic will be updated in a subsequent patch.

We additionally also take the opportunity to add significant comments
describing the address realignment logic to make it abundantly clear what
is going on in this code.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/internal.h |  43 +++++++++++--
 mm/mmap.c     |   5 +-
 mm/mremap.c   | 172 ++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 168 insertions(+), 52 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b07550db2bfd..6c611ab8eee2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -24,6 +24,44 @@
 
 struct folio_batch;
 
+/*
+ * Maintains state across a page table move. The operation assumes both source
+ * and destination VMAs already exist and are specified by the user.
+ *
+ * Partial moves are permitted, but the old and new ranges must both reside
+ * within a VMA.
+ *
+ * mmap lock must be held in write and VMA write locks must be held on any VMA
+ * that is visible.
+ *
+ * Use the PAGETABLE_MOVE() macro to initialise this struct.
+ *
+ * NOTE: The page table move is affected by reading from [old_addr, old_end),
+ * and old_addr may be updated for better page table alignment, so len_in
+ * represents the length of the range being copied as specified by the user.
+ */
+struct pagetable_move_control {
+	struct vm_area_struct *old; /* Source VMA. */
+	struct vm_area_struct *new; /* Destination VMA. */
+	unsigned long old_addr; /* Address from which the move begins. */
+	unsigned long old_end; /* Exclusive address at which old range ends. */
+	unsigned long new_addr; /* Address to move page tables to. */
+	unsigned long len_in; /* Bytes to remap specified by user. */
+
+	bool need_rmap_locks; /* Do rmap locks need to be taken? */
+	bool for_stack; /* Is this an early temp stack being moved? */
+};
+
+#define PAGETABLE_MOVE(name, old_, new_, old_addr_, new_addr_, len_)	\
+	struct pagetable_move_control name = {				\
+		.old = old_,						\
+		.new = new_,						\
+		.old_addr = old_addr_,					\
+		.old_end = (old_addr_) + (len_),			\
+		.new_addr = new_addr_,					\
+		.len_in = len_,						\
+	}
+
 /*
  * The set of flags that only affect watermark checking and reclaim
  * behaviour. This is used by the MM to obey the caller constraints
@@ -1527,10 +1565,7 @@ extern struct list_lru shadow_nodes;
 } while (0)
 
 /* mremap.c */
-unsigned long move_page_tables(struct vm_area_struct *vma,
-	unsigned long old_addr, struct vm_area_struct *new_vma,
-	unsigned long new_addr, unsigned long len,
-	bool need_rmap_locks, bool for_stack);
+unsigned long move_page_tables(struct pagetable_move_control *pmc);
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 void accept_page(struct page *page);
diff --git a/mm/mmap.c b/mm/mmap.c
index 15d6cd7cc845..efcc4ca7500d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1694,6 +1694,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
 	struct vm_area_struct *next;
 	struct mmu_gather tlb;
+	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
 
 	BUG_ON(new_start > new_end);
 
@@ -1716,8 +1717,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	 * move the page tables downwards, on failure we rely on
 	 * process cleanup to remove whatever mess we made.
 	 */
-	if (length != move_page_tables(vma, old_start,
-				       vma, new_start, length, false, true))
+	pmc.for_stack = true;
+	if (length != move_page_tables(&pmc))
 		return -ENOMEM;
 
 	tlb_gather_mmu(&tlb, mm);
diff --git a/mm/mremap.c b/mm/mremap.c
index 7dc058d5d5e2..3a2ac167e876 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -580,8 +580,9 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
  * the VMA that is created to span the source and destination of the move,
  * so we make an exception for it.
  */
-static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
-			    unsigned long mask, bool for_stack)
+static bool can_align_down(struct pagetable_move_control *pmc,
+			   struct vm_area_struct *vma, unsigned long addr_to_align,
+			   unsigned long mask)
 {
 	unsigned long addr_masked = addr_to_align & mask;
 
@@ -590,11 +591,11 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
 	 * of the corresponding VMA, we can't align down or we will destroy part
 	 * of the current mapping.
 	 */
-	if (!for_stack && vma->vm_start != addr_to_align)
+	if (!pmc->for_stack && vma->vm_start != addr_to_align)
 		return false;
 
 	/* In the stack case we explicitly permit in-VMA alignment. */
-	if (for_stack && addr_masked >= vma->vm_start)
+	if (pmc->for_stack && addr_masked >= vma->vm_start)
 		return true;
 
 	/*
@@ -604,54 +605,131 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
 	return find_vma_intersection(vma->vm_mm, addr_masked, vma->vm_start) == NULL;
 }
 
-/* Opportunistically realign to specified boundary for faster copy. */
-static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
-			     unsigned long *new_addr, struct vm_area_struct *new_vma,
-			     unsigned long mask, bool for_stack)
+/*
+ * Determine if are in fact able to realign for efficiency to a higher page
+ * table boundary.
+ */
+static bool can_realign_addr(struct pagetable_move_control *pmc,
+			     unsigned long pagetable_mask)
 {
+	unsigned long align_mask = ~pagetable_mask;
+	unsigned long old_align = pmc->old_addr & align_mask;
+	unsigned long new_align = pmc->new_addr & align_mask;
+	unsigned long pagetable_size = align_mask + 1;
+	unsigned long old_align_next = pagetable_size - old_align;
+
+	/*
+	 * We don't want to have to go hunting for VMAs from the end of the old
+	 * VMA to the next page table boundary, also we want to make sure the
+	 * operation is wortwhile.
+	 *
+	 * So ensure that we only perform this realignment if the end of the
+	 * range being copied reaches or crosses the page table boundary.
+	 *
+	 * boundary                        boundary
+	 *    .<- old_align ->                .
+	 *    .              |----------------.-----------|
+	 *    .              |          vma   .           |
+	 *    .              |----------------.-----------|
+	 *    .              <----------------.----------->
+	 *    .                          len_in
+	 *    <------------------------------->
+	 *    .         pagetable_size        .
+	 *    .              <---------------->
+	 *    .                old_align_next .
+	 */
+	if (pmc->len_in < old_align_next)
+		return false;
+
 	/* Skip if the addresses are already aligned. */
-	if ((*old_addr & ~mask) == 0)
-		return;
+	if (old_align == 0)
+		return false;
 
 	/* Only realign if the new and old addresses are mutually aligned. */
-	if ((*old_addr & ~mask) != (*new_addr & ~mask))
-		return;
+	if (old_align != new_align)
+		return false;
 
 	/* Ensure realignment doesn't cause overlap with existing mappings. */
-	if (!can_align_down(old_vma, *old_addr, mask, for_stack) ||
-	    !can_align_down(new_vma, *new_addr, mask, for_stack))
+	if (!can_align_down(pmc, pmc->old, pmc->old_addr, pagetable_mask) ||
+	    !can_align_down(pmc, pmc->new, pmc->new_addr, pagetable_mask))
+		return false;
+
+	return true;
+}
+
+/*
+ * Opportunistically realign to specified boundary for faster copy.
+ *
+ * Consider an mremap() of a VMA with page table boundaries as below, and no
+ * preceding VMAs from the lower page table boundary to the start of the VMA,
+ * with the end of the range reaching or crossing the page table boundary.
+ *
+ *   boundary                        boundary
+ *      .              |----------------.-----------|
+ *      .              |          vma   .           |
+ *      .              |----------------.-----------|
+ *      .         pmc->old_addr         .      pmc->old_end
+ *      .              <---------------------------->
+ *      .                  move these page tables
+ *
+ * If we proceed with moving page tables in this scenario, we will have a lot of
+ * work to do traversing old page tables and establishing new ones in the
+ * destination across multiple lower level page tables.
+ *
+ * The idea here is simply to align pmc->old_addr, pmc->new_addr down to the
+ * page table boundary, so we can simply copy a single page table entry for the
+ * aligned portion of the VMA instead:
+ *
+ *   boundary                        boundary
+ *      .              |----------------.-----------|
+ *      .              |          vma   .           |
+ *      .              |----------------.-----------|
+ * pmc->old_addr                        .      pmc->old_end
+ *      <------------------------------------------->
+ *      .           move these page tables
+ */
+static void try_realign_addr(struct pagetable_move_control *pmc,
+			     unsigned long pagetable_mask)
+{
+
+	if (!can_realign_addr(pmc, pagetable_mask))
 		return;
 
-	*old_addr = *old_addr & mask;
-	*new_addr = *new_addr & mask;
+	/*
+	 * Simply align to page table boundaries. Note that we do NOT update the
+	 * pmc->old_end value, and since the move_page_tables() operation spans
+	 * from [old_addr, old_end) (offsetting new_addr as it is performed),
+	 * this simply changes the start of the copy, not the end.
+	 */
+	pmc->old_addr &= pagetable_mask;
+	pmc->new_addr &= pagetable_mask;
 }
 
-unsigned long move_page_tables(struct vm_area_struct *vma,
-		unsigned long old_addr, struct vm_area_struct *new_vma,
-		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks, bool for_stack)
+unsigned long move_page_tables(struct pagetable_move_control *pmc)
 {
 	unsigned long extent, old_end;
 	struct mmu_notifier_range range;
 	pmd_t *old_pmd, *new_pmd;
 	pud_t *old_pud, *new_pud;
+	unsigned long old_addr, new_addr;
+	struct vm_area_struct *vma = pmc->old;
 
-	if (!len)
+	if (!pmc->len_in)
 		return 0;
 
-	old_end = old_addr + len;
-
 	if (is_vm_hugetlb_page(vma))
-		return move_hugetlb_page_tables(vma, new_vma, old_addr,
-						new_addr, len);
+		return move_hugetlb_page_tables(pmc->old, pmc->new, pmc->old_addr,
+						pmc->new_addr, pmc->len_in);
 
+	old_end = pmc->old_end;
 	/*
 	 * If possible, realign addresses to PMD boundary for faster copy.
 	 * Only realign if the mremap copying hits a PMD boundary.
 	 */
-	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
-		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK,
-				 for_stack);
+	try_realign_addr(pmc, PMD_MASK);
+	/* These may have been changed. */
+	old_addr = pmc->old_addr;
+	new_addr = pmc->new_addr;
 
 	flush_cache_range(vma, old_addr, old_end);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
@@ -675,12 +753,11 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
 				move_pgt_entry(HPAGE_PUD, vma, old_addr, new_addr,
-					       old_pud, new_pud, need_rmap_locks);
+					       old_pud, new_pud, pmc->need_rmap_locks);
 				/* We ignore and continue on error? */
 				continue;
 			}
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent == PUD_SIZE) {
-
 			if (move_pgt_entry(NORMAL_PUD, vma, old_addr, new_addr,
 					   old_pud, new_pud, true))
 				continue;
@@ -698,7 +775,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		    pmd_devmap(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
-					   old_pmd, new_pmd, need_rmap_locks))
+					   old_pmd, new_pmd, pmc->need_rmap_locks))
 				continue;
 			split_huge_pmd(vma, old_pmd, old_addr);
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PMD) &&
@@ -713,10 +790,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		}
 		if (pmd_none(*old_pmd))
 			continue;
-		if (pte_alloc(new_vma->vm_mm, new_pmd))
+		if (pte_alloc(pmc->new->vm_mm, new_pmd))
 			break;
 		if (move_ptes(vma, old_pmd, old_addr, old_addr + extent,
-			      new_vma, new_pmd, new_addr, need_rmap_locks) < 0)
+			      pmc->new, new_pmd, new_addr, pmc->need_rmap_locks) < 0)
 			goto again;
 	}
 
@@ -726,10 +803,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	 * Prevent negative return values when {old,new}_addr was realigned
 	 * but we broke out of the above loop for the first PMD itself.
 	 */
-	if (old_addr < old_end - len)
+	if (old_addr < old_end - pmc->len_in)
 		return 0;
 
-	return len + old_addr - old_end;	/* how much done */
+	return pmc->len_in + old_addr - old_end;	/* how much done */
 }
 
 /* Set vrm->delta to the difference in VMA size specified by user. */
@@ -1040,37 +1117,40 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 	unsigned long internal_pgoff = internal_offset >> PAGE_SHIFT;
 	unsigned long new_pgoff = vrm->vma->vm_pgoff + internal_pgoff;
 	unsigned long moved_len;
-	bool need_rmap_locks;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma = vrm->vma;
 	struct vm_area_struct *new_vma;
 	int err = 0;
+	PAGETABLE_MOVE(pmc, NULL, NULL, vrm->addr, vrm->new_addr, vrm->old_len);
 
-	new_vma = copy_vma(&vrm->vma, vrm->new_addr, vrm->new_len, new_pgoff,
-			   &need_rmap_locks);
+	new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
+			   &pmc.need_rmap_locks);
 	if (!new_vma) {
 		vrm_uncharge(vrm);
 		*new_vma_ptr = NULL;
 		return -ENOMEM;
 	}
-	vma = vrm->vma;
+	vrm->vma = vma;
+	pmc.old = vma;
+	pmc.new = new_vma;
 
-	moved_len = move_page_tables(vma, vrm->addr, new_vma,
-				     vrm->new_addr, vrm->old_len,
-				     need_rmap_locks, /* for_stack= */false);
+	moved_len = move_page_tables(&pmc);
 	if (moved_len < vrm->old_len)
 		err = -ENOMEM;
 	else if (vma->vm_ops && vma->vm_ops->mremap)
 		err = vma->vm_ops->mremap(new_vma);
 
 	if (unlikely(err)) {
+		PAGETABLE_MOVE(pmc_revert, new_vma, vma, vrm->new_addr,
+			       vrm->addr, moved_len);
+
 		/*
 		 * On error, move entries back from new area to old,
 		 * which will succeed since page tables still there,
 		 * and then proceed to unmap new area instead of old.
 		 */
-		move_page_tables(new_vma, vrm->new_addr, vma, vrm->addr,
-				 moved_len, /* need_rmap_locks = */true,
-				 /* for_stack= */false);
+		pmc_revert.need_rmap_locks = true;
+		move_page_tables(&pmc_revert);
+
 		vrm->vma = new_vma;
 		vrm->old_len = vrm->new_len;
 		vrm->addr = vrm->new_addr;
-- 
2.48.1



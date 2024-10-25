Return-Path: <linux-kernel+bounces-381493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 863909AFFE7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D532843EB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BAE1DE3C8;
	Fri, 25 Oct 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M2OTJ0pl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CInouZ8c"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661141D967F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851589; cv=fail; b=U57AthMgnd09po6/qS+Rj+j9gsulQGkkBIGbabFwl6H2O0uiFq4WhmCRZqOHc7L0iAjT0g/d8PUgZN28IVYKxG6a0k18xjNTy0ICswb8WPalwJvDzQPN2+hzbt1w/8aVwzQEeBcpSrMrUQzFdspTUaYdk+yDiZBW2Fd2ItBq29s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851589; c=relaxed/simple;
	bh=Sd1pIf/M2y8yJ7CfHieYNS1wdnVVmf+kuttx2bpidSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OJmHnt/T0VYnInS8fgEixsMj4VGJC4a3CPLWxbkaBoPSsuvmi8V9M3ZUqnwuYzoUHOm/t8mwyJH5vcLbS5+8wawaUK4AuKngwBVlMu4iaWKLJc7oFC3rDt2NhTax1f0Spn2z5RtMGmtGpO25pXrW8tTY92uP248piNGkUxsfLLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M2OTJ0pl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CInouZ8c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8CIBj001897;
	Fri, 25 Oct 2024 10:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=hYVIIEREOl2ZUKWbVb
	5tN6pbshuCqQLkb0npXA6PtZo=; b=M2OTJ0pl+mZYgMQ4HSRS2OaAnw8z1upBr3
	8+IwqP15aiVu/pNtM7q9BUTl8faohPIs0loeYwMnegRSeyx7wkcwg4Fq4IXGGmkP
	GHZhWd+wRwyb4mtq+lQxbE6pbOQxKbbFzU7BpMGdm5hSsa9xow8rmMFhpGV7LirJ
	EZ7AThfrqEyKyAbmpFxuZG05cbpDZ9YPo7rukhFkAji0j2TAuKais4gnFPXeL29D
	jEbZfuCkg+gPLYW+f909OapLa9TLKt4AiHSSb7ve59Omo1fgTmaPyeYKNmTA+EJl
	4zZCFGdHVumnQK61vaDuJTyXlRxPqtnFuszW56iMgV5eJsnJ3B2g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr3w1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 10:19:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PA8Hxa025336;
	Fri, 25 Oct 2024 10:19:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emhc4866-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 10:19:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkKdDivZQzw7WPT7cXWCkXEeN1upzHvNBtfBRMDEiIdiPo0IiteFWuiKyzp7KGHsKCCo/HDKVW91iwSuYlR8DmS6es71THPHV+5jD8YRAPgRNcgavfZv/4/CcT0QGiPxlgHTE7NRPWhq9xHprCug/sdq+uz1cmR72YZj24wqeYr1iivrsttzoZ5ibkq00ovcBqIfMfLf35AJm2bRVWQ9GtwnZ5IEt79Oqgq5lZ45pt7SxX3IIray6a0iadra0aAmCzkWg1cKse93xjAVx6gq8Bza1/n8NFFbo7bBkge1mgjs5UyQLtf86fov/w8kIa8gGz6NGbdrSEJVnG1mVY0Y9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYVIIEREOl2ZUKWbVb5tN6pbshuCqQLkb0npXA6PtZo=;
 b=K3FG3f1DxhIBIKGAb/mOtOpd8SOsNGFHUo76cwHPR7cEFmnqU5UFzvVriIcH7mTvfX7bVl0atpBVH8dmPwoEEMUreJNjXFz2PaEyakO9oPV1pkA4vk0sHQH1v0SaxcTapHaMtjAq7iFIXHxIK6RgMq9BesWdqXOQYIhsXFhCnFXS+TghoFoZhlhKPL8dWtiZx07XHlduHHQ2FT5HcBvQfOFRvNhCiPUsTo/XgwKD4sHHmv553NjVvTyiLqP8I3Ui8KzZ0GGtAMSDiU2Ij6fKIfrexsJno1SOawbsnNLXxwEcgtYA0iMGTqbexdAAjkONQVTlBDG49G/Yhab954ENxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYVIIEREOl2ZUKWbVb5tN6pbshuCqQLkb0npXA6PtZo=;
 b=CInouZ8c/NIJX1/UZq1aFQvbWrXf6ag5/ZGLQkyfWvrrIM07aTbkjYYjmSuv1aG9n0yvCvU7VdmpQNjU8RrWfbNoUDZN/gtKu+QizDP/+J2YTbSN08CjLxCtZXgXyWbx1XiO0GH/ZxU8LYSRhlqfYoEmegn861tmokKrx3nZmWI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY8PR10MB6755.namprd10.prod.outlook.com (2603:10b6:930:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 10:19:33 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 10:19:33 +0000
Date: Fri, 25 Oct 2024 11:19:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 7/8] mm: refactor __mmap_region()
Message-ID: <990f7ab6-ba06-4564-8d4c-baa5a3f3d8b0@lucifer.local>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <0b1da31b49d47ccb930d36f509d50d04c0422b73.1729715266.git.lorenzo.stoakes@oracle.com>
 <ca8d603c-20b2-4f8d-879c-c0ed9503afdc@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8d603c-20b2-4f8d-879c-c0ed9503afdc@suse.cz>
X-ClientProxiedBy: LO3P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY8PR10MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6c28a5-c049-4cd2-f312-08dcf4de84f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1OiAbYnMuW+RznwezIbIee4JUyRRDQR6Gn5coFw04BcIuzoieRv6fIEfzEKs?=
 =?us-ascii?Q?PKp8N9Visbl6nGLVYjL+FZSLLk0KrxQ71Ees6O9L1xJDqVtrt+1x4QbexWok?=
 =?us-ascii?Q?YncxGmDDs76SelaH4BtLnGG0RjSf8LsbzzyZ/JF1C7C1Y3/k9hO5NA1aKXXt?=
 =?us-ascii?Q?FQZkQYdJrThCC0Zr2gXO2Eoa4P210ZoWz5/xdbS4sI9ynfeYSD9M7oH5ztAA?=
 =?us-ascii?Q?yEh87m8eaJvIM7ad0fo3PJzK952aXztuWErbTbJ6QjYKITL187GjAlx7dZ7K?=
 =?us-ascii?Q?R+IhQBub3Lmy5VjQAZlzoHrsCVbeR8sn7q2g0uB4hWqQzLoHCrz1NhVlZViz?=
 =?us-ascii?Q?71xKj95QQGr4i1JGF+UVKg0i3dMmSDW0jEakN0UYOyipH6RwhsKthsr4aOIM?=
 =?us-ascii?Q?5GkTm+US4Tl2XkMIkFQGhcbiv8nh5e/QoNj+PSd/ofpUhcEt6tmmxwCqFgM7?=
 =?us-ascii?Q?EN3DqciFspggzxePi814FvkrzcYGE5T2wWY3mF9MuN93TKZbpvKg+KGtgUEL?=
 =?us-ascii?Q?PJ9UL+ZJCWycJn8gUwJ6nkx72mWJr8ZorRYDgticoeg+VTimk1tRobmJO3QI?=
 =?us-ascii?Q?yo43NT9KUlmSqNO/IXhDy36os1wIzGyBCYTAMFtKOh1jvzNMmOeR6DiPCISM?=
 =?us-ascii?Q?otRAO5Q31s//c4U7hhvsgh6SnSaw143jhxptZzjy4gi7tOD4ZS8tnagocVug?=
 =?us-ascii?Q?yeYeyvSM76ipnSyQKsvXTF9hi+spIxQZMw1J3SxF3UwL3imzCB9AqUMSYr2y?=
 =?us-ascii?Q?w+vRF2t15ZC+LM+wa6RRX3Z0Zo87TlCoky+0QPOeNPZo0tpFzzTVuCHQInT1?=
 =?us-ascii?Q?6z+DkURtVUHTCysGExFGGZU0o0GUHfpAAZ8NQlsI9eJgJrwQuxIPg6p7DcTf?=
 =?us-ascii?Q?jGfNZFKxxckH8i5hyUaXrviv8LjvUtKVxF7zgUoQXALrdHuFsKZdAbTw1DaE?=
 =?us-ascii?Q?lpcGRMkP7yXvYcmHVVylCHZvEPqXy89tBf00AdEc1wvHMv1+oHenKP5fk9dm?=
 =?us-ascii?Q?WvNyU07d3NliSak15oxTd4rH7UFWVgQjC/Zq9z6rRSh15BxN8j4ZXnp0hOwH?=
 =?us-ascii?Q?4Ih/1uVJzc0ulzqLw1rTS6cL6nol4E0pHRNxzS/R5B8xqmc1tflykU4R4ZPY?=
 =?us-ascii?Q?W7/NJA10YvxXBv1sHlvxdVmNVjtt7YeyNQvmIboz5KP3Gij4VC0qQdil/fF2?=
 =?us-ascii?Q?9BVKS/k7t5YF6uoACAqBXAU2vQUk255Dg7o6uwgQm8seMlXwoj4KbByxN+UI?=
 =?us-ascii?Q?3ChsxNufjnH+8dQJ5YOmP4LjcMnA2DIUDAdPCaftSoqk5QlnmYbViwqHPhJx?=
 =?us-ascii?Q?8Ou7Jl/ZeKJE8PFmrYNZu6jJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ZJSf4pRJnUSRv4MtNDYAjpzSsQxIfxCgbDFtinGdFsMX+dD4Qt8WpIaMXq1?=
 =?us-ascii?Q?hDy5LWfYbzhKL5CFX/laO8A7HpGPf1xk22Q1ftFtBa6WI8VMj3+npyuSBMXG?=
 =?us-ascii?Q?bObrpQPeu6YUK6xin8YYfPqq8sxOx5Tolgvzh6uFpS/pn1fLsrBFo594FZzo?=
 =?us-ascii?Q?ZiXCe28HUkwZyn0KLsmEppz4glUWihd3Yji3OZTTVKWHqJDQyVlDDLR1T0o4?=
 =?us-ascii?Q?n1bmFDSNPhTZAMR9f7kGamnLbGpflAY60vyWWD6tJPZa2+3h5hUtm7CsSPp4?=
 =?us-ascii?Q?yJirxlty4UyfT98iO/OPSTvV5hS8Cze6hB8wzVHyfcqIeE+EyprRqYwa+0zj?=
 =?us-ascii?Q?yg5YSwHP0BDHgv9c7n9inH4YweQhByDIFFKZ92ab+yDxY8D+85osU6rCc76q?=
 =?us-ascii?Q?wRAwL9MKm0NIOhO/qXX0TeGQKkGswD6xoOl1IV5I5+60Js+RUbyatkZQ+T5M?=
 =?us-ascii?Q?gOsOD4cgZ3gIjsaFL3UFbptGDTWvlscae08B7WHHvEmbHXyrQJqgNdh7arV6?=
 =?us-ascii?Q?TtlMesI0VEBtFnx7mDrYC05CJdcLc248WQo8D0XO8kjlhlt3kCy94P0snH2w?=
 =?us-ascii?Q?01Q2GhBcEqFE1AwTEqNTQshHjU3wogZA4nfoh3d6kWMCDeFTwzpIsP9WeHBr?=
 =?us-ascii?Q?Mdt9zBeuNp3OoH93wW4vKyLBW2OmMzhR7iuAgsUFvPipwg9tlJoLb56dZriw?=
 =?us-ascii?Q?okkwZcMy96d24+4LrVTq8xzIfmAa2l3/+fnxGb9czT8mNkYJ7k4QeBqd6NZz?=
 =?us-ascii?Q?/FQXCM+gpitr7rvRP+vL+0dco5aHjre9YxHisYCL2Ap12hgL87YRQoIvRG+J?=
 =?us-ascii?Q?rWPuxNKZ14Ud0IBMjtvoddwYomtLmpbiczQ/b8hQWTTf02KPuA531Ofurdgi?=
 =?us-ascii?Q?VIWD5kgE60dLlm4j62dudadMTRMxNdUUufWRcaAXWhw7xjV5UKx97S2rQHo9?=
 =?us-ascii?Q?pIuAEMHS6IQbQaREhV48iBzykAuBUUaMcMD+fR/K1Jxtw6Ch6QFLWzshmp5D?=
 =?us-ascii?Q?O5xf9cLMPbcd0dbdYvAUBciwGjYeWzXmcd7I9+lgdpbFNtr7vU60tPc+Qd4X?=
 =?us-ascii?Q?QhqEY4m8MtFX+m3Nwy7Fl19PczlfqK0XmHWLSmdQ9Bh32e/bnT6zdLSWqAtU?=
 =?us-ascii?Q?JGbVOVtNZppdb90fdCFlb24xMCqDGKUj2je+yO3fBmMNhLBMBCeBOi/4aB/T?=
 =?us-ascii?Q?KTTW36bcDQeF8Ed/WwENKoOhavhiCUa9F75o1wTRhTDCNU0VVzYwDOpXEttD?=
 =?us-ascii?Q?F+d9XGGRLjMccLwDT/J7v7VLYWGiqaCt3uRGUt3BVy0Y3IRYf8wG34zvfJ4f?=
 =?us-ascii?Q?K4Spo4bUuX+PwtndKixbO1reYHMyo2/LB1khZLODYDuSWjGfBQU1WN1VuvZM?=
 =?us-ascii?Q?iyq3JSmtEJfPsc2EincXdjf1zt/T+wzahbGrYDjQ1FZ6JbK0yk5bx/iyz0aC?=
 =?us-ascii?Q?n6n79/AMo7RPnwWIrRZ4ar2AG8sMJZ8UFUjS43+b5VDTkdI+m0oRgR7XY+rm?=
 =?us-ascii?Q?WtEw2VE7cS1ycjGBXyHAKoIVspoSIE0QBkryDJXO4hZ9ltDTOaIOf97rpGmN?=
 =?us-ascii?Q?VD00H7IA2zHSopULr41uVgAqKh8dkZGlxdvoev/Hes8tXzqIfRNID1SmnBnz?=
 =?us-ascii?Q?QpRInheyM+5J+/949lTjtNQEh3e5HS13o7OBtanBcx9bS3xwWJb2RhjUrltI?=
 =?us-ascii?Q?KlUw1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/wGM6n/0PrXrWQE+S9qn9XxY0gzMBsUzTkULC3j59SLjNv0xCZq9LLKKEexMf6d1SV8YJw+vM51M3YWkiweZq4FPTnC7taBbWJkcURuVqZNHr95W6qQp/ud+bvof0fG046fLnK67sTE9cZXQ6//r6l/L75pB6UxFzS2QmbfnWKLrceJTxw0pDoIL0XOLJD8g5+dDKG264rBYXKXH2wzQC1RlArsetdWkub544MsMaxTqbxuKkzj7wzLjTeKfWlQq8QUeW//xmoSdoAgX/e2Eyfv3B6+qqqbVgEvDtt+LUFjcBMFL7y2vDRxKH3hO1sZNViCZpMi1tN55QaBHRrcNaHySMoZw8n1e7QTtq2HMDMySsq6zlh0uH5bGkQ4nrTjX8bfQjRkouEKApDxlPB9/1e2EJRnIznAIh3oyLTguvjy7xeItv3zY45u6C08yi8KXf+0AtMtcExGHfuDOTXqagZQ6X3DC/cNQs45rmluTgRUUZSIaJrqWOEYJpJ8pAF5B6yWgLswY0aWfeXGT0B7u4u86UZnv5sz/dwmW8sKkrYp2PHfWwHPlY8yq9h3o0E2q2idnwYZUCqKyzLKcF1rvTYiSIcOd4+93aif4WfC33sc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6c28a5-c049-4cd2-f312-08dcf4de84f6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:19:33.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgU3FjlO3QEn4Qi5/DrjmkAGPvjBwN4mGZMh/BitWWxrPn/ezuT59+KxMT4GWtEKWmvWx6cb3sOkNNaME4egtLqqhlnGzvu4opZBjL5qjnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_07,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250078
X-Proofpoint-GUID: hFmAMdVYOUjqZYaru-Wz0kZRRGGGYAIe
X-Proofpoint-ORIG-GUID: hFmAMdVYOUjqZYaru-Wz0kZRRGGGYAIe

On Fri, Oct 25, 2024 at 10:35:20AM +0200, Vlastimil Babka wrote:
> On 10/23/24 22:38, Lorenzo Stoakes wrote:
> > We have seen bugs and resource leaks arise from the complexity of the
> > __mmap_region() function. This, and the generally deeply fragile error
> > handling logic and complexity which makes understanding the function
> > difficult make it highly desirable to refactor it into something readable.
> >
> > Achieve this by separating the function into smaller logical parts which
> > are easier to understand and follow, and which importantly very
> > significantly simplify the error handling.
> >
> > Note that we now call vms_abort_munmap_vmas() in more error paths than we
> > used to, however in cases where no abort need occur, vms->nr_pages will be
> > equal to zero and we simply exit this function without doing more than we
> > would have done previously.
> >
> > Importantly, the invocation of the driver mmap hook via mmap_file() now has
> > very simple and obvious handling (this was previously the most problematic
> > part of the mmap() operation).
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Some nits:
>
> > +static int __mmap_prepare(struct mmap_state *map, struct vma_merge_struct *vmg,
> > +	struct list_head *uf)
> >  {
> > -	struct mm_struct *mm = current->mm;
> > -	struct vm_area_struct *vma = NULL;
> > -	pgoff_t pglen = PHYS_PFN(len);
> > -	unsigned long charged = 0;
> > -	struct vma_munmap_struct vms;
> > -	struct ma_state mas_detach;
> > -	struct maple_tree mt_detach;
> > -	unsigned long end = addr + len;
> >  	int error;
> > -	VMA_ITERATOR(vmi, mm, addr);
> > -	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> > -
> > -	vmg.file = file;
> > -	/* Find the first overlapping VMA */
> > -	vma = vma_find(&vmi, end);
> > -	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> > -	if (vma) {
> > -		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> > -		mt_on_stack(mt_detach);
> > -		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> > +	struct vma_iterator *vmi = map->vmi;
> > +	struct vma_munmap_struct *vms = &map->vms;
> > +
> > +	/* Find the first overlapping VMA and initialise unmap state. */
> > +	vms->vma = vma_find(vmi, map->end);
> > +	init_vma_munmap(vms, vmi, vms->vma, map->addr, map->end, uf,
> > +			/* unlock = */ false);
> > +
> > +	/* OK, we have overlapping VMAs - prepare to unmap them. */
> > +	if (vms->vma) {
> > +		mt_init_flags(&map->mt_detach,
> > +			      vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> > +		mt_on_stack(map->mt_detach);
> > +		mas_init(&map->mas_detach, &map->mt_detach, /* addr = */ 0);
> >  		/* Prepare to unmap any existing mapping in the area */
> > -		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> > -		if (error)
> > -			goto gather_failed;
> > +		error = vms_gather_munmap_vmas(vms, &map->mas_detach);
> > +		if (error) {
> > +			/* On error VMAs will already have been reattached. */
> > +			vms->nr_pages = 0;
> > +			return error;
> > +		}
> >
> > -		vmg.next = vms.next;
> > -		vmg.prev = vms.prev;
> > -		vma = NULL;
> > +		map->next = vms->next;
> > +		map->prev = vms->prev;
> >  	} else {
> > -		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
> > +		map->next = vma_iter_next_rewind(vmi, &map->prev);
> >  	}
> >
> > +	/* Set up vmg for merge attempt. */
> > +	vmg->file = map->file;
> > +	vmg->prev = map->prev;
> > +	vmg->next = map->next;
>
> It seems arbitrary to do this here. vmg->flags are set in __mmap_region().
> Why not all of this? We wouldn't need to pass vmg to __mmap_prepare() at
> all? Do any of the values chenge between here and returning and vmg needs to
> capture them as they are now? AFAICS not.

Yeah I sort of felt we are 'preparing' things.

This _was_ necessary before when we were ickily leaning on the vmg to store
state and not mutate it which is not ideal.

So yeah I think probably it's better to just put _all_ the merge stuff in
__mmap_region() rather than just some.

This aligns with the need to strip out the 'reset' logic from
vma_merge_new_range().

>
> > +
> >  	/* Check against address space limit. */
> > -	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
> > -		error = -ENOMEM;
> > -		goto abort_munmap;
> > -	}
> > +	if (!may_expand_vm(map->mm, map->flags, map->pglen - vms->nr_pages))
> > +		return -ENOMEM;
> >
> > -	/*
> > -	 * Private writable mapping: check memory availability
> > -	 */
> > -	if (accountable_mapping(file, vm_flags)) {
> > -		charged = pglen;
> > -		charged -= vms.nr_accounted;
> > -		if (charged) {
> > -			error = security_vm_enough_memory_mm(mm, charged);
> > +	/* Private writable mapping: check memory availability. */
> > +	if (accountable_mapping(map->file, map->flags)) {
> > +		map->charged = map->pglen;
> > +		map->charged -= vms->nr_accounted;
> > +		if (map->charged) {
> > +			error = security_vm_enough_memory_mm(map->mm, map->charged);
> >  			if (error)
> > -				goto abort_munmap;
> > +				return error;
> >  		}
> >
> > -		vms.nr_accounted = 0;
> > -		vm_flags |= VM_ACCOUNT;
> > -		vmg.flags = vm_flags;
> > +		vms->nr_accounted = 0;
> > +		map->flags |= VM_ACCOUNT;
> >  	}
> >
> >  	/*
> > -	 * clear PTEs while the vma is still in the tree so that rmap
> > +	 * Clear PTEs while the vma is still in the tree so that rmap
> >  	 * cannot race with the freeing later in the truncate scenario.
> >  	 * This is also needed for mmap_file(), which is why vm_ops
> >  	 * close function is called.
> >  	 */
> > -	vms_clean_up_area(&vms, &mas_detach);
> > -	vma = vma_merge_new_range(&vmg);
> > -	if (vma)
> > -		goto expanded;
> > +	vms_clean_up_area(vms, &map->mas_detach);
> > +
> > +	return 0;
> > +}
> > +
>
> <snip>
>
> > +static int __mmap_new_vma(struct mmap_state *map, struct vma_merge_struct *vmg,
> > +			  struct vm_area_struct **vmap)
> > +{
> > +	struct vma_iterator *vmi = map->vmi;
> > +	int error = 0;
> > +	bool merged = false;
> > +	struct vm_area_struct *vma;
> > +
> >  	/*
> >  	 * Determine the object being mapped and call the appropriate
> >  	 * specific mapper. the address has already been validated, but
> >  	 * not unmapped, but the maps are removed from the list.
> >  	 */
> > -	vma = vm_area_alloc(mm);
> > -	if (!vma) {
> > -		error = -ENOMEM;
> > -		goto unacct_error;
> > -	}
> > +	vma = vm_area_alloc(map->mm);
> > +	if (!vma)
> > +		return -ENOMEM;
> >
> > -	vma_iter_config(&vmi, addr, end);
> > -	vma_set_range(vma, addr, end, pgoff);
> > -	vm_flags_init(vma, vm_flags);
> > -	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> > +	vma_iter_config(vmi, map->addr, map->end);
> > +	vma_set_range(vma, map->addr, map->end, map->pgoff);
> > +	vm_flags_init(vma, map->flags);
> > +	vma->vm_page_prot = vm_get_page_prot(map->flags);
> >
> > -	if (vma_iter_prealloc(&vmi, vma)) {
> > +	if (vma_iter_prealloc(vmi, vma)) {
> >  		error = -ENOMEM;
> >  		goto free_vma;
> >  	}
> >
> > -	if (file) {
> > -		vma->vm_file = get_file(file);
> > -		error = mmap_file(file, vma);
> > -		if (error)
> > -			goto unmap_and_free_file_vma;
> > -
> > -		/* Drivers cannot alter the address of the VMA. */
> > -		WARN_ON_ONCE(addr != vma->vm_start);
> > -		/*
> > -		 * Drivers should not permit writability when previously it was
> > -		 * disallowed.
> > -		 */
> > -		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> > -				!(vm_flags & VM_MAYWRITE) &&
> > -				(vma->vm_flags & VM_MAYWRITE));
> > -
> > -		vma_iter_config(&vmi, addr, end);
> > -		/*
> > -		 * If vm_flags changed after mmap_file(), we should try merge
> > -		 * vma again as we may succeed this time.
> > -		 */
> > -		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> > -			struct vm_area_struct *merge;
> > -
> > -			vmg.flags = vma->vm_flags;
> > -			/* If this fails, state is reset ready for a reattempt. */
> > -			merge = vma_merge_new_range(&vmg);
> > -
> > -			if (merge) {
> > -				/*
> > -				 * ->mmap() can change vma->vm_file and fput
> > -				 * the original file. So fput the vma->vm_file
> > -				 * here or we would add an extra fput for file
> > -				 * and cause general protection fault
> > -				 * ultimately.
> > -				 */
> > -				fput(vma->vm_file);
> > -				vm_area_free(vma);
> > -				vma = merge;
> > -				/* Update vm_flags to pick up the change. */
> > -				vm_flags = vma->vm_flags;
> > -				goto file_expanded;
> > -			}
> > -			vma_iter_config(&vmi, addr, end);
> > -		}
> > -
> > -		vm_flags = vma->vm_flags;
> > -	} else if (vm_flags & VM_SHARED) {
> > +	if (map->file)
> > +		error = __mmap_new_file_vma(map, vmg, &vma, &merged);
> > +	else if (map->flags & VM_SHARED)
> >  		error = shmem_zero_setup(vma);
> > -		if (error)
> > -			goto free_iter_vma;
> > -	} else {
> > +	else
> >  		vma_set_anonymous(vma);
> > -	}
> > +
> > +	if (error)
> > +		goto free_iter_vma;
> > +
> > +	if (merged)
> > +		goto file_expanded;
> >
> >  #ifdef CONFIG_SPARC64
> >  	/* TODO: Fix SPARC ADI! */
> > -	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> > +	WARN_ON_ONCE(!arch_validate_flags(map->flags));
> >  #endif
> >
> >  	/* Lock the VMA since it is modified after insertion into VMA tree */
> >  	vma_start_write(vma);
> > -	vma_iter_store(&vmi, vma);
> > -	mm->map_count++;
> > +	vma_iter_store(vmi, vma);
> > +	map->mm->map_count++;
> >  	vma_link_file(vma);
> >
> >  	/*
> >  	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
> >  	 * call covers the non-merge case.
> >  	 */
> > -	khugepaged_enter_vma(vma, vma->vm_flags);
> > +	khugepaged_enter_vma(vma, map->flags);
> >
> >  file_expanded:
> > -	file = vma->vm_file;
> >  	ksm_add_vma(vma);
>
> I'm wondering if this could go to the "non file expanded" region above. If
> we expanded a vma, it was either in ksm and stays in ksm, or it was not
> eligible and that couldn't have changed by expanding?

We could change this, but the next commit removes the need for this :)

>
> > -expanded:
> > +	*vmap = vma;
> > +	return 0;
> > +
> > +free_iter_vma:
> > +	vma_iter_free(vmi);
> > +free_vma:
> > +	vm_area_free(vma);
> > +	return error;
> > +}
> > +


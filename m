Return-Path: <linux-kernel+bounces-249435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB2492EBA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FBAB22BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8AF16C684;
	Thu, 11 Jul 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="axMNDG5r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AXGunZGV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5052216B747
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711605; cv=fail; b=jdtCSdpQ+pjO7Nu0evhDedeYldd++mJ49Qt0wop8wUMdFbw1Znegm0gfXCOtEYcvPlCv8aVb11E6BcKzffB59kBzQ5XqFBqof7hxzh79Vay9DBpb7z/wS4f7Cf7acLQx5esNIOb4s/XLw635wONDRgu5wzk0CvrKjePn2fvNOLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711605; c=relaxed/simple;
	bh=Gqn3r/FqiPIWgst6TSPsvU+gte90Rn/r7jdaUCQTzvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KxQcIMkRf7W7TexyttFVoMJB0u3bLCDeJDHEG6lntw1cWXzFFrzJefv0kI9CDyjEe4e0AY+w6yZhSi+nGuRrAg86mRSckVlZyQpJjCEgEN4OG0AsQUu1/SehSEjFK+ar+IdKNfwlnduQTYzpnGzTWJGeLb6NI2EZ4yvJZtYnv20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=axMNDG5r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AXGunZGV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBZVE027108;
	Thu, 11 Jul 2024 15:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Z7+ugx0lGuX8Lg+
	V4Oa0HZ8JBVrcyNT3hLwoLPFKbw0=; b=axMNDG5ry0irwsfuQFJYwoSqyJ5eJWE
	v0oDhNL1LzhdMq0WAgnfbB8Y7ctWfiMmt848AuOz+na1SsuLHYL42aBvv9CHHybk
	CzHHLml1B9pIaxgqUd30b5ln/ETMOF7PicIIVM8PmPe2zSp2SEwIZtB5eRVm4ipu
	NkAaATe8bf+odNImUgpCi9XbBJ5+v+EuYzzioqmkrNY5G7diO61TWDqc7zvi7vdn
	Z97OZ+tgpLPNPDS3KGITXz77ydYyODzqbs4/BEVM9OoJM8qsh7T85un9AhgL9uX9
	PsSxdTSWZOTk/eCwB+hEK+eZSQe0CZzJJ+Ay0bocU+mpi4ZxdYmYwuw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq1xj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:25:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BEUeBt029998;
	Thu, 11 Jul 2024 15:25:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vvbdvum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:25:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtrgRmyoiewbXYddJQLbUh7rCIUh5K2Wn8lPPnHC/ErnNBATkHW+cShV1xzCTEbTGpwpSxofUxd4mQL0K2sHaDBKsXV10Emj7CMunI1qQec1Rs9YqkL1jPgV6nVdZvC0vJdDxXyubYOx0Tlm50JaxDnxxe0jvhgnJDInbyfBmVUltSK+/Vy3H2qw6gr0g6j8K/EhaFd37JpDgqFhm0/ruWrwWv731O0qMNG6E4tvcED7TuHfZIg7Om5BRiifGwcvucI5Ul+XKgNafwTNH3MoACBGDG5bl7rb8KT3mXWIhuu322AvA74wH1dg6V3rVklEI/t/83m78GBe0hpRGY25yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7+ugx0lGuX8Lg+V4Oa0HZ8JBVrcyNT3hLwoLPFKbw0=;
 b=SS3Q0IZVSW+zu4xszNg26zDGunuHiESoILHs3uLamWrdfEa8Y5B+KHozYnlX7pbr7byknbJQhBXG12HuhmjfJMuvYWQBbzNI00VVAS9A1+A7xcIV+da2ciKkEKFD9L5+o9xpLfGErsCGAkItO7AgxqBZNvZClaqIf/lDQghPn8+6oK8s+qlCQcBkefIjMOV/tdIWL4+Hxt9EHM7ZOsNttq7P1aqBuxKHRly37gMDqVOlLQOumVJXLvttrDWTMGV+ZfWt+64cY57D63aaPSuyUlYH9lukFRsMVkHAwX73LTI4btfKfErK8EzV8Tfy9HErCsvg8A7zukeCCnbrPtuU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7+ugx0lGuX8Lg+V4Oa0HZ8JBVrcyNT3hLwoLPFKbw0=;
 b=AXGunZGVRw/1OXmi29uy2BNS7WumB/CnRiOtYAiboXsquXiD0eGIHMkCTl6MTtYZVW6l41SS95WkL1PG1rPKe43JGQ9T0kQuECgryzy//rV7A+H3Q2X/q12I3icnwjnPMMlUfgeMXtqO6G5lELI2P/9D1ZglzRtaPj68V3A/r6Q=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB7677.namprd10.prod.outlook.com (2603:10b6:610:17a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 15:25:05 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 15:25:05 +0000
Date: Thu, 11 Jul 2024 16:25:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <6e29f050-89a1-4a7d-bba9-fc49c04292fb@lucifer.local>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
 <20240710192250.4114783-15-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710192250.4114783-15-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO2P265CA0109.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::25) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: fc32d53c-3c95-4ac2-a384-08dca1bda426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2l9nN2MMkVX3D1ri6x8D7EmpwCFtTm76StU7xmq8QMRzZroBxliMRpk8nQi9?=
 =?us-ascii?Q?cS1rNvimKfc/aFDuWmKjD5xDjh8SomT1uxzPHbyxAyoWPqJgr2Sd87+biywt?=
 =?us-ascii?Q?lPR1OLP9QXnlDQamdHKIhnUMtw3x0XHbnC4Zf8uigaaX06DqSnIz5woG/UOS?=
 =?us-ascii?Q?Gr1tmzJjfBqkVarKbcr+EiBaodw7x6MLHw4mCkzIyWcWPh4xZ7r20tcEnxR/?=
 =?us-ascii?Q?HDCarBbMc2KxjaPkvOfi7gmgaTvDwghpuygshGbGmmaW/7WA7ZW22ymiQa1X?=
 =?us-ascii?Q?xZDT0zyf6SoGpqU0gnqZl1oi24yMFQXcdBIkYwLz0eD3aa+pMwlIH6zOVtVS?=
 =?us-ascii?Q?X4OPAOdXCKKI600QcSHFw49bHYLJP7k7KmSIbtILX/M9winJ37V54WgADscj?=
 =?us-ascii?Q?mR0VmGzQCseIZvYC7lmuTC1ZnG9AjRM0FonsgLNE2mLVW8ltSsAXGlsUDk+R?=
 =?us-ascii?Q?S2m4SFBejRx0KkAkl/vphaYt3uY1qyoTzdXTuE1rmrV6pxtOQQ4P9vt7HFct?=
 =?us-ascii?Q?dkLLVVFh5xMvmHVcJ7G7bEZ20Ub4PmDtzjfwqLMfx5vOqqzQZiVsiEZgLtE+?=
 =?us-ascii?Q?EKU/PbTW5AwmthtG4U8zVL1IXgtvOISiPnqdhH0A9Jz1kbNzdJENks6IBRQC?=
 =?us-ascii?Q?oFuzW8Z479UA1YeLbA0ADq2Y0UqqN/PsftUDDIuCgC22RJYuS7gyDWNKn/uw?=
 =?us-ascii?Q?7iAZlxRy3hE2N7XWxXa+E9zGWR56NHcqUx9zb/y4EMN0cucLVszLY5dDahzw?=
 =?us-ascii?Q?jHeQ5Y/KLsKq/iEmzrHjvzJgztezxmpRN7jV/vYA0QlMLz0FpYCfx/RGTncd?=
 =?us-ascii?Q?SZqcmzuic9Hvo1L0JQEFlJg6OGAt+jHp37vOJYr8lJDs+WLnTbwVhAHTRouN?=
 =?us-ascii?Q?cmrrBoBVDTxCpE66AdMj4AmOtCTC1lMVpVedTUj0x9mgY00d0NX6mE6oL2x3?=
 =?us-ascii?Q?s+mZP8rsNr429+9WIisN1y0LiAPX3hD6BOF2KXv2Gq7rtA20xKTvUwnl0Hs0?=
 =?us-ascii?Q?NauKnwNUOugOnFkDjhNQMdGPjSvVX47cjz4Kw/wi9UmulvrDuDpTSTsWh/cO?=
 =?us-ascii?Q?5HDeOJl7nWBAnkedKmZVAeOcJyLyjaS37RzKjSkLSvM1tkRBp0mCtfxtIWeu?=
 =?us-ascii?Q?E/9dJDmZKKbImgqBiJ7Sl0SsRdhA4yYskffDLFK2pDJHYVZAb8eXXZL8RZbS?=
 =?us-ascii?Q?+gqEUQLcy+zFWfuv4XRiiemNcGTseB/UU99UXIZjDfZew6tkFT9sDXn1MGuB?=
 =?us-ascii?Q?KUlXSgN6Be+3RWwjgatBMU4Zlsc1PYJBc7nSxNCA2B2wqkDunkrHFVlijhQP?=
 =?us-ascii?Q?iKNJQZOxgnOwUJk4nPdtjO5pp4ENz14SSdoikyFOjsrHBg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tbe6yKKuAvDlnKIE++kPvA0nKiaUcerVY5q4Zt3YZsS0hEg0sctf3+Cfg3rM?=
 =?us-ascii?Q?3/Iviszm/gQj4zGIISJFqYkpcSjVX/kehCLgb1iRmsRwtEP15zzGkqSCo8/X?=
 =?us-ascii?Q?D53Oqk8ICFSgf71YXjvQBN/Em7AsluMDQ3O3K1W9Br03II0CtEuPMmVoGykC?=
 =?us-ascii?Q?9Vf3koGMH19jisvVMJeTcah596FwOFtpSBAvBTcvQe+c7bZIf0amwilQjAfv?=
 =?us-ascii?Q?CXrMKsz7qpivZrVHMUlOlOW2YTBOke+DrryOVRPwj+VxzASHHXtvW0UQm0R5?=
 =?us-ascii?Q?s7HwcKXkpI0drmj3stnSfKrc2nXtATOyMz8g/iQyaPyJqfQ/xXS+34V6PsNj?=
 =?us-ascii?Q?+me6lQZTVFDWNuLTiEOfEV1m9JUUUednEnZ3Jb1+cSnflC26QYpPkZCU2pxb?=
 =?us-ascii?Q?TSSIwvq7ChsHNjckQzd30LvxQM7v2c0UXM7SHvO/eXS0DNjn/azolynDIah+?=
 =?us-ascii?Q?mw3rgP26I79JDEMZrcH9SUMv/F/HWm1vZJ/eJjMV+rsH+IWyylIJw+wF5dpn?=
 =?us-ascii?Q?0Sqv/bIywAT/nIf/NBRsKNAGRPHRpeGhlNQP9mt9cxgEUwvkdVjGrISoVbMD?=
 =?us-ascii?Q?c8z1sH7aw+6nOEKlCpOicAika3d9gFHiRFwupK342TAeR5LBttuIVq+uKnlq?=
 =?us-ascii?Q?R8waAidvYiyXiizQZCjLyapDCBLilmBwFvjVRDxAb8NpzwJG2WO8WTCN1Swf?=
 =?us-ascii?Q?zS5hcr/9b9HNFw6aKvPlgCHoqfaYwd2djP/S5cSIqdresgEffT4H1CKgBSEU?=
 =?us-ascii?Q?zq3FQCUqSrH5XMdoo+ww6lIZwpZoHcJ5Cob+XfnXtX7sOS9oxIYUcqHy6MDS?=
 =?us-ascii?Q?R66Xre0wF/qVboY9jRRgYmV/nlqKxP0pPRzXCiLFs0sZnGPxyWTiaxAukdQq?=
 =?us-ascii?Q?40Y/+4VPAxFsCyznezIEdUfm5BRw9DibRXz+kbYP+Yx2ayMMSvdsIHXeEvUN?=
 =?us-ascii?Q?CQXTrtNYcL5o7JXz/WZvABQewgz1ye9bZtRzKen7Kb6h3dx8LE4lw4g8j904?=
 =?us-ascii?Q?Q8UpgWjOBZFQ7twyiHXrKC+Dnw3vTsevYWc4bil8NnfpsvgS7PDzRHq/cBS5?=
 =?us-ascii?Q?fM5xvGCRktuurKlwPDB+pXq9FqGoS3sC+AKnsc7N0cJyPQ3q+OWAy4E5N/ct?=
 =?us-ascii?Q?opSXeHsjyxtFKK2jFhpfrrDkPaAkit6MxNzefcQPe72UiyrmLWwjUAdy4IvC?=
 =?us-ascii?Q?GUNA+H8OuSLp1Um1t/JORhi/gU1xxjGE/oth5lFM/QTG+qGFiU7jJbaYbbwE?=
 =?us-ascii?Q?xggAndmTDV1bAXI1gjUhG0LegMPJTCQ/ttWAsx/YGQCThJwfJlXIx8mDdRB+?=
 =?us-ascii?Q?g7yEfiR4e037/CtzYh/Ckp7+unMYTBIakXxX9s2MH6UyJVkIUnbQzwYqwnoZ?=
 =?us-ascii?Q?/DVUhISDaHxowvB28oBK0VwTYZu5k2oaSxv/3uEzuxZbvOGIOLkg1hj3+agA?=
 =?us-ascii?Q?q324z4bIth4InzB0Ldca9mDesxUTt0hta8OKzJViQRmsdrUPdRZbJjT7qZxG?=
 =?us-ascii?Q?6pN4+9Zt4QYicwYBfKdzg+mawn+xfawMbek58larDe7zOoCbq7YB7k6amc/E?=
 =?us-ascii?Q?VUd94mHMsQhiqiuzyWeMKDgUPuRIHVlywCUrwYtlYHayfJmYYG/kTDPBZeX3?=
 =?us-ascii?Q?ImV1BkJa3s84h4x70SNNi2POWxqOzv4IiQRGtkoVQWzjG+7QUAcW0gmgx0bw?=
 =?us-ascii?Q?pFlNYw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lUHbmeWclbmSjFUfH3bgVBuByznw0HPXutPj2a25TXdF/o9h2YOTycWS5uuR5kor2rfpN1uG0q0hxEEeA+xdmK1D6W5JQHcrY67zhYCpAtEp+8RHgWOQF8NlkjYzz7pWDERCdlEJ4eT00OiF43duda5RbQGOxUI1iF+31pnY9xKbkJMbNUKmg4GcCXeAl0GJ4jrTw9O9MgM5okuesUIu4WHRxoyTxIb1D4wXkusIs4+vJR16kt3UgFSGx8M3CjI6ITRfOCTxCotsfaiuCbpBUfiIFHcD1mE8zJ2/5kmoiv2FqIqRlynSRqNoum79frvNQZlOaWCEa/A8mD9r1BnVMUn9PnFD8kcmx+IYuxq+/lKoGfNFmcVxH1ZQli4IvYBNR+4wd2DqFKT5EE9W/oRWUB6IkpmbB4sIl7QvkxGariMnohsy7zHi76Uxs2re+tYOYFAxqqxBqOGbUPds05c1qqS5t+CFjO6P6+2lCFk06ZARk8fEO0WywjW5Q1r67Gj06QQjDhoWixZLktKiyKdvqSHjJiq60w8jr+0UbyM/nyuei5kRl1FoDTnQjqwLrosIv29qOX4gXNKJ9g3j7I7RjISz7IJiSZ7iTKhoErSc8Sk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc32d53c-3c95-4ac2-a384-08dca1bda426
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 15:25:05.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vR2YShk1+wqEL/lgUzmWvTRUr1x6dsgqAvxf/n1qDv05usMB/IyztZAvqNUC/+bU52Y/BDpwfcvTTmj+AC7n1Q8V4ozhK1vAdIvvxKMJXyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110110
X-Proofpoint-ORIG-GUID: cE2BWtLwju6qattEfVQdsEHgkaKS3eHd
X-Proofpoint-GUID: cE2BWtLwju6qattEfVQdsEHgkaKS3eHd

On Wed, Jul 10, 2024 at 03:22:43PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Instead of zeroing the vma tree and then overwriting the area, let the
> area be overwritten and then clean up the gathered vmas using
> vms_complete_munmap_vmas().
>
> If a driver is mapping over an existing vma, then clear the ptes before
> the call_mmap() invocation.  This is done using the vms_clear_ptes()
> helper.
>
> Temporarily keep track of the number of pages that will be removed and
> reduce the charged amount.
>
> This also drops the validate_mm() call in the vma_expand() function.
> It is necessary to drop the validate as it would fail since the mm
> map_count would be incorrect during a vma expansion, prior to the
> cleanup from vms_complete_munmap_vmas().
>
> Clean up the error handing of the vms_gather_munmap_vmas() by calling
> the verification within the function.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/internal.h |  1 +
>  mm/mmap.c     | 80 +++++++++++++++++++++++++++------------------------
>  2 files changed, 44 insertions(+), 37 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 11e90c6e5a3e..dd4eede1be0f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1503,6 +1503,7 @@ struct vma_munmap_struct {
>  	unsigned long stack_vm;
>  	unsigned long data_vm;
>  	bool unlock;			/* Unlock after the munmap */
> +	bool clear_ptes;		/* If there are outstanding PTE to be cleared */
>  };
>
>  void __meminit __init_single_page(struct page *page, unsigned long pfn,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 870c2d04ad6b..58cf42e22bfe 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -401,17 +401,21 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
>  }
>
>  static unsigned long count_vma_pages_range(struct mm_struct *mm,
> -		unsigned long addr, unsigned long end)
> +		unsigned long addr, unsigned long end,
> +		unsigned long *nr_accounted)
>  {
>  	VMA_ITERATOR(vmi, mm, addr);
>  	struct vm_area_struct *vma;
>  	unsigned long nr_pages = 0;
>
> +	*nr_accounted = 0;
>  	for_each_vma_range(vmi, vma, end) {
>  		unsigned long vm_start = max(addr, vma->vm_start);
>  		unsigned long vm_end = min(end, vma->vm_end);
>
>  		nr_pages += PHYS_PFN(vm_end - vm_start);
> +		if (vma->vm_flags & VM_ACCOUNT)
> +			*nr_accounted += PHYS_PFN(vm_end - vm_start);
>  	}
>
>  	return nr_pages;
> @@ -524,6 +528,7 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
>  	vms->unmap_start = FIRST_USER_ADDRESS;
>  	vms->unmap_end = USER_PGTABLES_CEILING;
> +	vms->clear_ptes = false;	/* No PTEs to clear yet */
>  }
>
>  /*
> @@ -732,7 +737,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	vma_iter_store(vmi, vma);
>
>  	vma_complete(&vp, vmi, vma->vm_mm);
> -	validate_mm(vma->vm_mm);
>  	return 0;
>
>  nomem:
> @@ -2606,11 +2610,14 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
>  }
>
>
> -static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> +static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
>  		struct ma_state *mas_detach, bool mm_wr_locked)
>  {
>  	struct mmu_gather tlb;
>
> +	if (!vms->clear_ptes) /* Nothing to do */
> +		return;
> +
>  	/*
>  	 * We can free page tables without write-locking mmap_lock because VMAs
>  	 * were isolated before we downgraded mmap_lock.
> @@ -2624,6 +2631,7 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
>  	/* start and end may be different if there is no prev or next vma. */
>  	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
>  	tlb_finish_mmu(&tlb);
> +	vms->clear_ptes = false;
>  }
>
>  /*
> @@ -2647,7 +2655,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	if (vms->unlock)
>  		mmap_write_downgrade(mm);
>
> -	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
> +	vms_clear_ptes(vms, mas_detach, !vms->unlock);
>  	/* Update high watermark before we lower total_vm */
>  	update_hiwater_vm(mm);
>  	/* Stat accounting */
> @@ -2799,6 +2807,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  	while (vma_iter_addr(vms->vmi) > vms->start)
>  		vma_iter_prev_range(vms->vmi);
>
> +	/* There are now PTEs that need to be cleared */
> +	vms->clear_ptes = true;
> +
>  	return 0;
>
>  userfaultfd_error:
> @@ -2807,6 +2818,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  	abort_munmap_vmas(mas_detach);
>  start_split_failed:
>  map_count_exceeded:
> +	validate_mm(vms->mm);

I'm guessing here we know it's safe to validate?

>  	return error;
>  }
>
> @@ -2851,8 +2863,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>
>  clear_tree_failed:
>  	abort_munmap_vmas(&mas_detach);
> -gather_failed:
>  	validate_mm(mm);

Additionally I imagine the gathering failing results in the tree being unable to
be validated?

> +gather_failed:
>  	return error;
>  }
>
> @@ -2940,24 +2952,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	unsigned long merge_start = addr, merge_end = end;
>  	bool writable_file_mapping = false;
>  	pgoff_t vm_pgoff;
> -	int error;
> +	int error = -ENOMEM;
>  	VMA_ITERATOR(vmi, mm, addr);
> +	unsigned long nr_pages, nr_accounted;
>
> -	/* Check against address space limit. */
> -	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> -		unsigned long nr_pages;
> -
> -		/*
> -		 * MAP_FIXED may remove pages of mappings that intersects with
> -		 * requested mapping. Account for the pages it would unmap.
> -		 */
> -		nr_pages = count_vma_pages_range(mm, addr, end);
> -
> -		if (!may_expand_vm(mm, vm_flags,
> -					(len >> PAGE_SHIFT) - nr_pages))
> -			return -ENOMEM;
> -	}
> +	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
>
> +	/*
> +	 * Check against address space limit.
> +	 * MAP_FIXED may remove pages of mappings that intersects with requested
> +	 * mapping. Account for the pages it would unmap.
> +	 */
> +	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> +		return -ENOMEM;
>
>  	if (unlikely(!can_modify_mm(mm, addr, end)))
>  		return -EPERM;
> @@ -2974,18 +2981,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
>  		/* Prepare to unmap any existing mapping in the area */
>  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> -			goto gather_failed;
> -
> -		/* Remove any existing mappings from the vma tree */
> -		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
> -			goto clear_tree_failed;
> +			return -ENOMEM;
>
> -		/* Unmap any existing mapping in the area */
> -		vms_complete_munmap_vmas(&vms, &mas_detach);
>  		next = vms.next;
>  		prev = vms.prev;
>  		vma = NULL;
>  	} else {
> +		/* Minimal setup of vms */

Nit, but is this valid now we use the init function unconditionally?

>  		next = vma_next(&vmi);
>  		prev = vma_prev(&vmi);
>  		if (prev)
> @@ -2997,8 +2999,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 */
>  	if (accountable_mapping(file, vm_flags)) {
>  		charged = len >> PAGE_SHIFT;
> +		charged -= nr_accounted;
>  		if (security_vm_enough_memory_mm(mm, charged))
> -			return -ENOMEM;
> +			goto abort_munmap;
> +		vms.nr_accounted = 0;
>  		vm_flags |= VM_ACCOUNT;
>  	}
>
> @@ -3047,10 +3051,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 * not unmapped, but the maps are removed from the list.
>  	 */
>  	vma = vm_area_alloc(mm);
> -	if (!vma) {
> -		error = -ENOMEM;
> +	if (!vma)
>  		goto unacct_error;
> -	}
>
>  	vma_iter_config(&vmi, addr, end);
>  	vma_set_range(vma, addr, end, pgoff);
> @@ -3059,6 +3061,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  	if (file) {
>  		vma->vm_file = get_file(file);
> +		/* call_mmap() may map PTE, so ensure there are no existing PTEs */
> +		vms_clear_ptes(&vms, &mas_detach, true);
>  		error = call_mmap(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;
> @@ -3149,6 +3153,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  expanded:
>  	perf_event_mmap(vma);
>
> +	/* Unmap any existing mapping in the area */
> +	if (vms.nr_pages)
> +		vms_complete_munmap_vmas(&vms, &mas_detach);
> +
>  	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
>  	if (vm_flags & VM_LOCKED) {
>  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> @@ -3196,14 +3204,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  unacct_error:
>  	if (charged)
>  		vm_unacct_memory(charged);
> -	validate_mm(mm);
> -	return error;
>
> -clear_tree_failed:
> -	abort_munmap_vmas(&mas_detach);
> -gather_failed:
> +abort_munmap:
> +	if (vms.nr_pages)
> +		abort_munmap_vmas(&mas_detach);
>  	validate_mm(mm);
> -	return -ENOMEM;
> +	return error;
>  }
>
>  static int __vm_munmap(unsigned long start, size_t len, bool unlock)
> --
> 2.43.0
>

Other than nits/queries, LGTM:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>


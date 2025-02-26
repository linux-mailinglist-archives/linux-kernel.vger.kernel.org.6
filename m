Return-Path: <linux-kernel+bounces-534185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853FAA463ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD76188D985
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FDC222562;
	Wed, 26 Feb 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N2PVRqqm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ytX30v4L"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D62222CA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581994; cv=fail; b=oJpg7jM9SAeBGn3648Z2D4c3jyUGEmmAhjdnYnW1NViN3+Dvz8rv3ltGkZO8MYwNlEoj/t13dmujd3k/MstLGrABVC46FjmkMwmTqTlDDflGidPFcAv6UsvXHPmYllvGtr45cbWi/8tkO5a1CvfrRaC6pFxCd1NHKRcz0JKWJl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581994; c=relaxed/simple;
	bh=EesqA3LLVcZeh+wuVwmAW23nh+Knwtfc9Xc2yPyI3aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jmGUEEUjjrhWR2arqrXU+QxZlGmEY2sMCz/N+6ebdCe4CltLq0M4pTa/ZtgtPaMy6ENftDDm8Kgpr48W44zQe1VJquSsGCxvk98YCL6L66PpAYaBqo2vvjuI6sCV7tR0Oa8QY2Zwbf7ScNLfcjhXil7CEw7tWzTtgd+3yEznlZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N2PVRqqm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ytX30v4L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEtajQ002635;
	Wed, 26 Feb 2025 14:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7BqpkE/CAArBL25QcA
	3fPR5uLD7c1PPt4R5eIO3pXOc=; b=N2PVRqqm6OaXWQUhBmNmkNmS+f72/lDsly
	x9YdATNtK0YJ61KJ+tL8a6uGD8DEwuRVIVibOYXFECwrh7Glk14RibKRjNNOlA1v
	6h0owdKHuv8oCJYpfza1V4Eld1kyqyrrU9cqNn0OJ3AX3PbsE7lYUXSXJILvH76P
	JfdXkXvGJLZyMvTNZ5ue8Og8TZchrjLz8sjIm0uTtfX+2/YYg+/SrKlMa10YAwMW
	Y+h28gUEE9x8fk0Di2+zGCbbt/viPQp5gIYvBpJSoNdU/4mFs4PZ+9vdUdgnjhLw
	9MZqaRTseBrfBnBumUXfuvuesmjCzP5rQuNKTk4gb12vlvLHmCow==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psfs9dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 14:59:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QDJkmR002886;
	Wed, 26 Feb 2025 14:59:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51b0qb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 14:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZQmvHsD7i0XDK6Sr099ggP6JXvltYO6V2ewQ4rxjVgy2wTSy98R2Ol8BRcMOJrVzUz3QvbVggHeDwHmB0QYZBh+MnprdUptk/ZBVNEG9voUihdskYuNwwEhg67b7ffpWLVIjQw3pZIOJGJl48P+Tw6iFNEgcUkLmoxbGfJimZWg5sp+fCpHirbyQa1xHz2xq7vF4UhOqiLCf7ghirmls3ODsZ/svFFMoHkeJsYcIwqzlSi7GzTE/1eikUKZHc/3+ACblCT55Hyqa6d0ITa1XOQ4eff4ODotaV/ccYP0NGRp4swkQTLBUI+X9Tfnd/x8Uu52+OHGSBrhMew/e+AqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BqpkE/CAArBL25QcA3fPR5uLD7c1PPt4R5eIO3pXOc=;
 b=R7TguI9GU+goiGJPWBgHK+w/EiSAMSzjYIOnapznQgGyIk8BuiG5Otr86z9zcPY5EOm9vpDZsvAGNDd3g3cPvZw1SGyNWduuNQxdt6oZ979t9LG+o3GvY68puYb8g5A2zGPbjcgYSxOg/nNyBrVnzS8S3fqwGAqgInx4AjyZeWMTYAf8DxrHEbcwUpdiYo8OqJQLB1/68sQGg6rz9e861EKzfDIEyzI3H+Ntn5aEzygUD6IKpCMIRpgVFAxjwGQfFo0IIJvgWUUeAl6M0n8KAblUv5TTdL9FrP/iXhkJQyrHD5/EjwwFPXvtFEVfIpKuOkzpsmklTLErOdcGYL/w9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BqpkE/CAArBL25QcA3fPR5uLD7c1PPt4R5eIO3pXOc=;
 b=ytX30v4Ll4SPH6FjzcO2IqbFDeSvyWtJLkvmaZbqr8fOUAnVQKSKCJIG+Oo6rz6sw7rxPOvzy8sBiUHVjWEQF/P2l7VtYifmqAolOPtRwUcdBm87kiQbm5HT8GM2BqKNhoOU/cBc7irUNuERz6AX2VCi9HoNEstev5YZc0CnNUE=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH4PR10MB8025.namprd10.prod.outlook.com (2603:10b6:610:247::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 14:59:30 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 14:59:29 +0000
Date: Wed, 26 Feb 2025 09:59:26 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, lokeshgidra@google.com, aarcange@redhat.com,
        21cnbao@gmail.com, v-songbaohua@oppo.com, david@redhat.com,
        peterx@redhat.com, willy@infradead.org, lorenzo.stoakes@oracle.com,
        hughd@google.com, jannh@google.com, kaleshsingh@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] userfaultfd: do not block on locking a large folio
 with raised refcount
Message-ID: <hdcrjkqb4cevovpw5xprkh7ohykqay5ew27sbtpzg2k7vrm7mx@6ircmivkmkgv>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, lokeshgidra@google.com, 
	aarcange@redhat.com, 21cnbao@gmail.com, v-songbaohua@oppo.com, david@redhat.com, 
	peterx@redhat.com, willy@infradead.org, lorenzo.stoakes@oracle.com, 
	hughd@google.com, jannh@google.com, kaleshsingh@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20250225204613.2316092-1-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225204613.2316092-1-surenb@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0198.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::22) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH4PR10MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1b9683-8ec4-473f-33bb-08dd56762bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2p9RGtCjDtPf3LpEcQiGKFamoAQ2yOPPqORp7itMW4LCpm1+6imYcZZzXXDi?=
 =?us-ascii?Q?G47f1k7H68LL8CrP2rITsL/+T87M/4dC5+eM8udupat1qXEkH7UKWiKK5+JX?=
 =?us-ascii?Q?bxSDjia5H1cCQxziYkY9CtFZJJytl/W2+0ylxuf324EFIMXJ9ZYVkm39LiMe?=
 =?us-ascii?Q?NDHC7y93xC723WwdOVEpxcDyElrW0NgVAq1Osy41vivghlXoNZiUR/dz+kCP?=
 =?us-ascii?Q?ZdP5+vlDS8EK9aNATppuBuauF8tKh/Qu8PKwcwZf9nkWijoZCjnyUhHIYRU4?=
 =?us-ascii?Q?XSWAQ5bhU2SxWUkf4hKS/LrFZbbI58s9dNwnKoJ1V7D9t8Z1ymjSeL1NY9Sl?=
 =?us-ascii?Q?PtFtb38nmsC144eLeJdUWbYJUMDE9t/7fb1lHUz8qM7Q+IfY7DmXYLMHE0J7?=
 =?us-ascii?Q?I0InRQokDJDnB3FLaig0X0Ue84wa44c2O0gesj4HDy0jgLfR+W6PN/iLurWC?=
 =?us-ascii?Q?+lFoJ1XBmNDVzxG1NENS48GdxS2iMpeoFfYEET9Q2Y7yB7ZTbxEOSAtpW/+K?=
 =?us-ascii?Q?YVu0XP/8iJHLksimGgyqrng+glovyCgzNRu1vsEmR2ne3fcSnq6I0r9jkgjT?=
 =?us-ascii?Q?UTLNZURL2wEJcT6SPSyBb+kcy4PIYl8f6xbe8pbc0XLxuCGccC7G6Ofi/Ynd?=
 =?us-ascii?Q?nHLa1TrnPpj9UiGNIKi0JOZzrRWIz2BOAGp7dbWgSlsvFG4Mzs25YM6+IvV5?=
 =?us-ascii?Q?PutlUxs71aJfh6YbZugM9yeh86ax3xLn/jZAYcEbF2LJi/UJDh3tT2KK5/iv?=
 =?us-ascii?Q?+F2/cFsGbuaJs64BM3pTsvjh39ikVe3D26YwuMtr1yFkcRtkFI6ygAvgiBhm?=
 =?us-ascii?Q?4oHMI13uYT6VQBw+iO+yBuO41SX1jGe8Jpz1uHtsj1IsndgWUcvS+7VvMvlu?=
 =?us-ascii?Q?XSbm5/rW/fXUywUsbmT0TgQyyVYqo7XxHZXeCkMMMD0qUduShrtI0jL7WBYK?=
 =?us-ascii?Q?mOlphDlWvHqy0dO5fntaJ1c6flZWzE3ct8R/qT5dT1UZ7wByMlaH7evBgW94?=
 =?us-ascii?Q?DUUz7z+GZ10yDRZDfjrGD2f1gv3S8OHB6HMLwumbkREct108/0tGpDsKEk/j?=
 =?us-ascii?Q?RMxkfk4qvRpf+awb106XLwjMX7XI0U/i749TBUYV8QoGF15DI2XRnmuUBiRq?=
 =?us-ascii?Q?IOyWXF7/lPKZg8zybExRLSHFv9vmukykUveXZdfY40vAMCd1dlQ1vHkEwbdw?=
 =?us-ascii?Q?szTtg9w8a/7Sh3DvK8v0LehoPNjDaGjIPVVuwa5IZFgtodqqy3vr/oDKOFLr?=
 =?us-ascii?Q?6Odq4poWVFK4mqM/8s5WVvpXrqz8ZTl1FFJo/OSyOWiMvmlGtTgAEvlFaLYN?=
 =?us-ascii?Q?vHBh3gvLoHieIeTT159/bhKb34Fs0Z8+qZN+wDJxsl9MLXGo3nSf1yR5MDmo?=
 =?us-ascii?Q?cN6cIxy5WqpEmC+fX24wmwQE1LrS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qpBwYobKGHs0OmmJH5rF4BD8Yl74VljEYcNEyK+f00+DZB5uyUf/Z+nbgeDX?=
 =?us-ascii?Q?o+miThl4pPQby9d2OSSRg3Xpl0gLgnTXmh+LBgKAjqhue2WsBmSnOtf3MNHD?=
 =?us-ascii?Q?WxJ/BNdC7Dtkou3x9Z+ZckR3q9gw6vFs0O603pF1zY+SeGnvI7LnqIHxAc0F?=
 =?us-ascii?Q?TUJK4S+Yeeh/bvVTOyylGeFx33OiuM3U8THYCpnuJn3jNkDQTKOS/qPieHx3?=
 =?us-ascii?Q?px89qJ3JOwvqA2ekvGhI1zriurrpTzo6XIitXoUBox2wIRSp8xm+LB5ZXhdU?=
 =?us-ascii?Q?rs/ydTzaOKwcB0nH4UXJOIniFdFq4qPf2EqtXTGk26eluZX+zDw8FwlOVh7h?=
 =?us-ascii?Q?j1g13kbDYNuaSDLObC7nz96qwfhiCB1LxqqQTNj0j41U7Xc7HQCHFMqsuspI?=
 =?us-ascii?Q?fs7R2m/ls70YJbCxv3ls/n4pAk1URkk2KVePnCsiKzvj4B6Ju122CnqZ8MOZ?=
 =?us-ascii?Q?ULyAqc/4uAaXgQNmGuCcS/eymx7fblmzmCykdXvz2Jfpp7DaY0sZ3cQMCbIa?=
 =?us-ascii?Q?TkA3pQXnT6kAXTljuHwuH7Gv2jDq8QCdDz/szXqBmmPLHwZ/wJcQ86t/YgNJ?=
 =?us-ascii?Q?klnjg94Kha6GdHFAswYvOb2Vu97w4B6xB0g84S38B+/pFKrd7Ld0wlukiX3U?=
 =?us-ascii?Q?/YonVCmLem86k3Nuha34Vucq11C+AYD0Lgcr3uNq9mIgji5yJHZZzEIqQNfX?=
 =?us-ascii?Q?h+hQOuygtgdPOxLbc/ymE3METw9g/iekiM/bVSWeyqP3IbCDV0YvWkXMK9/d?=
 =?us-ascii?Q?aAexIl6RosTAUb8g/rKgr/B2dr5GDoKIHzu29QLgYzABWk5L/3ZTou0pDqx6?=
 =?us-ascii?Q?+KmCdtSLee267otTUPtoWogZUeRwq61a102chd7oeQjpNlwVP5jSF4U8wD41?=
 =?us-ascii?Q?pkdfa4/mIB2V9j9+iKcyIXo+ag0JztFX+EEE9hJx10d1NS9wn2vuotx4F5SD?=
 =?us-ascii?Q?G/G+R+i5D33kULxhzvTlYcCYvFslRrCNL8mdPdGRmBNhAbA3wV8OHAVFApY9?=
 =?us-ascii?Q?v79K+oeUcSaP/yP5HkaaBt2flwsY4nBlMaNmgVJevIGaIB8FJRQpPz98IfQb?=
 =?us-ascii?Q?/OOHaLHibJREzHUgVFGwZDfGFCRtRcLMzxmxMV+eBZcscBbqmpJTKVQ8hpaD?=
 =?us-ascii?Q?cGx9FGvOIZ8XFnoFxtevskLzqhJMV+tDpuMCRmgk/acd0ndAHyunSVCvddWS?=
 =?us-ascii?Q?X6A17vG2B8EVosvStnNiP6/KQhJsw/AzqDWMTXkF1H6fifp9YHKHzgSirmXP?=
 =?us-ascii?Q?in//y+bJ91Rox+jEiLA/RNz5xLaW1m0GKBSwRy4be7w4BppgUoceA9oaxDpE?=
 =?us-ascii?Q?G3lgzLNo2exEOlPoCf3zTTl5O9y/T/x7cpLuyn9eYfaYrcjGRMRCNoW1Ntub?=
 =?us-ascii?Q?IX98yTmoL9AtvaQF+imL3SiR4NzcyEcUvZ7NxSGuUVDu0TiIp0ybsz/1/FS9?=
 =?us-ascii?Q?bxtUWvo3lf3UQYKB8TVOaWmTzDYzUWOo1xeve/wSgTfj1vOdvSUSFlCoB8YX?=
 =?us-ascii?Q?dWOBvxkMnkkadC9QGVCL0Iv1ftn0UmXF8gNWrruksilkxC2mDKVzzyGDWz4c?=
 =?us-ascii?Q?eKgQf760xHd6TNRAcJRCnoGLa/LncGA3wRmt0SvE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	12uofEPqsOjlkZ/o/jEq13dfaLPwRh31PnDtQlBWHI6q16Xz3Wka0ttwVUTtXcTACk5AZKMZlCRLDfB3LL9TJvcDdJV8/2daxsHozz2LOeRJI/9o3OeIEUvrME95ESEjZDDxmBiZKHE64MDY4U0oKeB6KBqyzeG+p8sKuViR3OBTeZJgJn5x5rb9BqWIjFofyqut/rLpDo+qkDy5jFW/Z2nQZtg5bolKp0n4Zu1ezlBVtRHLhdLN/SJeMQ3Rt/foATAlMrt1H+BdijxowPwaQUsJO1jp+LMmFKksyoDfNAZoyqg11vuSLgBp06w1eXzuQROBsU5CVtM9/aeuKatodaWJ8oGwYVtvNWSpJCPdhrGzpaqInZgNRsnfoq4MJJNhQeSEqpSEUYgDTAvjX0FPk1UgFpx1eFiZdVmnDyzcM3vrlPhVNlbiTh2dkiAhJKjtJkiP9EoMyG8bEe52eDnytqvN7ZrLc7RIFoNVbnf2m38gEB057kwQJo/l7vngBGhzOoWXBS2bizlnbxXd45jgDrrlH34FJpxEsz1CwaFWQLKJ++83h1Ra2HpX/4i4AnOqhakMstIDgLUf3ByER4wXGOSl7CiFdhWnPUQyCC12bek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1b9683-8ec4-473f-33bb-08dd56762bab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:59:29.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWiuAeSm2/LqwmYTIm176kADtcDgEWMzD1/z2B8qFPOkfrfqJg3PmRJVJfvN2ci6+IfCrleaO2BJqIhSuV/oAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260119
X-Proofpoint-ORIG-GUID: MhoqB2Usl5sBUlVrAgnVYQfvJ6JwZ0Aa
X-Proofpoint-GUID: MhoqB2Usl5sBUlVrAgnVYQfvJ6JwZ0Aa

* Suren Baghdasaryan <surenb@google.com> [250225 15:46]:
> Lokesh recently raised an issue about UFFDIO_MOVE getting into a deadlock
> state when it goes into split_folio() with raised folio refcount.
> split_folio() expects the reference count to be exactly
> mapcount + num_pages_in_folio + 1 (see can_split_folio()) and fails with
> EAGAIN otherwise. If multiple processes are trying to move the same
> large folio, they raise the refcount (all tasks succeed in that) then
> one of them succeeds in locking the folio, while others will block in
> folio_lock() while keeping the refcount raised. The winner of this
> race will proceed with calling split_folio() and will fail returning
> EAGAIN to the caller and unlocking the folio. The next competing process
> will get the folio locked and will go through the same flow. In the
> meantime the original winner will be retried and will block in
> folio_lock(), getting into the queue of waiting processes only to repeat
> the same path. All this results in a livelock.
> An easy fix would be to avoid waiting for the folio lock while holding
> folio refcount, similar to madvise_free_huge_pmd() where folio lock is
> acquired before raising the folio refcount.
> Modify move_pages_pte() to try locking the folio first and if that fails
> and the folio is large then return EAGAIN without touching the folio
> refcount. If the folio is single-page then split_folio() is not called,
> so we don't have this issue.
> Lokesh has a reproducer [1] and I verified that this change fixes the
> issue.
> 
> [1] https://github.com/lokeshgidra/uffd_move_ioctl_deadlock
> 
> Reported-by: Lokesh Gidra <lokeshgidra@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/userfaultfd.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 867898c4e30b..f17f8290c523 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1236,6 +1236,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  		 */
>  		if (!src_folio) {
>  			struct folio *folio;
> +			bool locked;
>  
>  			/*
>  			 * Pin the page while holding the lock to be sure the
> @@ -1255,12 +1256,26 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  				goto out;
>  			}
>  
> +			locked = folio_trylock(folio);
> +			/*
> +			 * We avoid waiting for folio lock with a raised refcount
> +			 * for large folios because extra refcounts will result in
> +			 * split_folio() failing later and retrying. If multiple
> +			 * tasks are trying to move a large folio we can end
> +			 * livelocking.
> +			 */
> +			if (!locked && folio_test_large(folio)) {
> +				spin_unlock(src_ptl);
> +				err = -EAGAIN;
> +				goto out;
> +			}
> +

Reversing the locking/folio_get() is okay because of the src_ptl spin
lock, right?  It might be worth saying something about it in the
comment?

>  			folio_get(folio);
>  			src_folio = folio;
>  			src_folio_pte = orig_src_pte;
>  			spin_unlock(src_ptl);
>  
> -			if (!folio_trylock(src_folio)) {
> +			if (!locked) {
>  				pte_unmap(&orig_src_pte);
>  				pte_unmap(&orig_dst_pte);
>  				src_pte = dst_pte = NULL;
> 
> base-commit: 801d47bd96ce22acd43809bc09e004679f707c39
> -- 
> 2.48.1.658.g4767266eb4-goog
> 


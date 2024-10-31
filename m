Return-Path: <linux-kernel+bounces-390994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286329B80EF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58DD281C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8BA1BD515;
	Thu, 31 Oct 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HqAeEaAD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZwU2Q8ra"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71008197A6C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394833; cv=fail; b=lDocG3mRRov/XN4ZUIcWvIFBpvHbf+/ovWJp6+DuPRih0sg4SGjBXOUYNIjzM6a6r+0WC5Bcq3N9R91+jJ6SlEVn7Lw+Bg2/E4J3qwCE6WK3CkjJw+J3int0FCcYMBibUHPfC1jCONaYUEivvMc00yrc03cSPyTGehC8bCGE3UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394833; c=relaxed/simple;
	bh=qXnmKgzveg4F9mzHPgcIjL4P5rFItLLxSW3HLz3p30I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ThNkyHBghJ5PjZ+WDJdLfsfr9VjKE5e/lctX5jqYpQpG2PVzUHrQ/qGULp+TSkzbWQ9ZV6lM2ftN5829Q8vR3hbCEhpmPa7lK6sccpo3qiFJ16OIrTKvA4u1QW5XETfyNKjxgR190HzpZu/Cs2EoS2CAx9gjg517INWWIfEK4z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HqAeEaAD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZwU2Q8ra; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VH43tI022125;
	Thu, 31 Oct 2024 17:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=tcqtqr7/O6d9kX4fV8
	TK5DnlYfbb/kpVFWx4lcmu2yY=; b=HqAeEaADp2G+mF3PpWw6fjaQ+jJ2vCSW0X
	d1zRIHDzB6I1UR/bPY6t0rc6St5dafRrHQqJu5ium8PdQDMRkqI54f4ffIDmH+RM
	8uo15Cn5n1MQFCfp8f4jtY9YIG8QOCJru3TUEhhpwNgHDjIdXBA3q6k/US9x/tgy
	hP6u+H8/YnfQ8YkoLauylrdQqgDIWFFf2Yf0htbR2n30hM8tDngTt1i62LIukdWn
	zGjaNuIsJbFZWoDBxLyjnDeHi+bfsgrCzUelfmpPQJl2KTp7oQiL+66ySfnmfXlM
	PaWOzR9mSosy+6CCxYv8wr8ODdmp/AmlSuZFsnrNjqoTfRXycrEg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqjpxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 17:13:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49VG1poj004780;
	Thu, 31 Oct 2024 17:13:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2x6qrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 17:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvCxrfTLH+6dTnwLCNTlgExWj2Pk3tO6kHLWEhgCdrLfqdVlIFOuGpcVym5Qf0iujf0dr7QCre8+3zd87tvgNwm2h1CXZnfi9NP+5qmbb3DPV9QS+tqwkGvfa86Mu9h+ZcS/YkTw9eVQeRj66JaK5NrMnWKFb37nUzCgd3nePRsHADSmH+kTZHc1OkhLzYWulDRtpy0vs0VAnYnb0B7KHL+Sq9VQEJEkO1v2RXYybf8UNuKoeuOaXGDCmNV7KmPcKwbdiDmtSR8ryfUTiiJsftkyyRRey29xOamuOLwk1eQ0XbHHrkRNwE3NJiJjBvy0jWPGaiyC7iyyEeChMxMJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcqtqr7/O6d9kX4fV8TK5DnlYfbb/kpVFWx4lcmu2yY=;
 b=PMtybykOIvj9oHkiVwp/AHjjcE7G7wAlF0sFCaoVoAzwFQgjb5idBvpdJwfP3BaAKuCc7t29UVz447QaxpbsftqTOM5vIGOT6NrkHD6XFDq1rvLCResHdqw44ExC9Kdp/MIXloWw+Ev8cutDFs86m02Z2qY6+BWcicXQ2A43kK2eaieQv5Hvx6M8US/K2KEl2HKKr0MIJSGeXLKAvxpXELM9HdTtZ0C1NsMHT36Jb8jDdQlOFpcrGlWlZ9QCB3zvKhVA3+ecYYHN2sfQWoZEPKG310DQ7lDF1lK67Z38KvkxCFoGir0GBrqLzNIp8AVahH6oU+5RfrKQs36/ZymV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcqtqr7/O6d9kX4fV8TK5DnlYfbb/kpVFWx4lcmu2yY=;
 b=ZwU2Q8ranTnRtVo30HEfN12oorY1NuipdmZiLNsdGBe+bXIZruvAIF3vrCCSr6DHpuRQLFa/aGHOY42aDoC9phcOtXsmCG/hM7c/LafLwr1P7scTg58mso/NSrUMjjip16UmaYRKNiC3HXTqkGo4GgFbmludGGgITDOZfU5yCpk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB4973.namprd10.prod.outlook.com (2603:10b6:5:38d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 17:13:37 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 17:13:30 +0000
Date: Thu, 31 Oct 2024 13:13:28 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] vma: Detect infinite loop in vma tree
Message-ID: <2hwlqzr4zfqhv2lz5zn5jypzbdbnx6rsnwrupcnxmhkxit26x6@33b3fsjywjmq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>
References: <20241031170138.1935115-1-Liam.Howlett@oracle.com>
 <d0174131-1fc5-46d2-af87-a42a72a31487@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0174131-1fc5-46d2-af87-a42a72a31487@suse.cz>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a5c115-934f-41f3-b0ae-08dcf9cf57c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1rWDsnqg6OtJ8uLvhwG8vYgJPTyyrx22wtdEawRu/PT8lhRSraYRPVpsw5/b?=
 =?us-ascii?Q?DXNO0c9XgjkiSYzRVwWgL358J3RFJF235V6u2mKSwcJGeznWvFyAIs3L53+j?=
 =?us-ascii?Q?hIU8Wj5tSqQM/QPl5Vo5u5XsDtgqxknYorJLscDMr33+K3jd2TGoQFUNa30b?=
 =?us-ascii?Q?PtfS0YY+UknkJSrllCL3UHakdOwYgin89Ygj9QNuzyL+DLehJfmSG9O1WeLC?=
 =?us-ascii?Q?k/Zy/eFCr6IVymK7N+1ioaX/ljkF7e3ELA9ycMvBTZbrVErE0gJD4dZW5Cry?=
 =?us-ascii?Q?R49ryP1Wn/mHjiS5eu+CgNiGupv68cRL5Z4cxDJnUB68X4aAt/9bvWDMPXYH?=
 =?us-ascii?Q?Vdwm8E4W1y04pQUGooJ0GdrAIYWmXKysg2p5N5vaJfUaSmDei6yyi/4K9tIa?=
 =?us-ascii?Q?EwxF2JGYNA4CUwbJrdYKYfxsbPnxR2gQoSRKXOpBlI9+4NiMzrF+LfPMwLuw?=
 =?us-ascii?Q?jukbP9QJ4tl6dQ0gStgEhN0tn+2KOuYb6MVSoVTpEtncoe+9Js6IOTYCNbaK?=
 =?us-ascii?Q?nZM9R9zK4+Gt+lnXUI6syuXfGr5sG2n7E/QsY28P7G77pyAoq+ydXU+7JBTy?=
 =?us-ascii?Q?NsG3sENOpIroxDenXVRitbgON9B8vA5ICiR0NKpYMAbC75pTJpWBrAh6xsmd?=
 =?us-ascii?Q?uHBq4q5UolSKILGDM5NzZeeiU2HCuauwmRQe/u7mC1WH+RgZTLOePym/kCk5?=
 =?us-ascii?Q?MskIZkvJ4T1FXL21h8Kc7vX9b1Lrt9ycHTxqMvPYB8kjf8s/7ZIw3oyXwqQ0?=
 =?us-ascii?Q?Nbar2lK0MVYZ0ZSQ2scE1XAKJAuuICqqhwy4yLwYAnS17QwR+/MfmdWrPb7t?=
 =?us-ascii?Q?wN0Rx+zgrM8ivhTHgV2WStZ9V0VYKiwOWvdWrG3BM9OIxMCKUtHZUdHR5s77?=
 =?us-ascii?Q?Q84FzOo8vgoJuZ9Icm9RBUUKeyYGKHwCO80bJKk0PaPTqS0IZrjLPOnIbcvI?=
 =?us-ascii?Q?SxevlGA7k7ZlBVhlJ1TSKCkb+bHzE98JFn61jbF6CE2brnOrRGWAWn8PH0dF?=
 =?us-ascii?Q?TUZgnqxWD+zusgIGrn2anWXbXVTQ9hSaB56iVahvHEqy9XKDHspHRmPyYOsl?=
 =?us-ascii?Q?wbdU+BrQ3NUMbh10j3nToLp1SYGvlBxCQO0tZiaV/dxLHKTdG5sRoxQnMwCq?=
 =?us-ascii?Q?duKDJW+n5kGXPELqRV1KEifdv7S4+9q2YVhtj4WDpbUXN/m/cmlRBEG6IWd8?=
 =?us-ascii?Q?hpDfokC4EGB61oXtnsWdGxo1+n/Uz4s0G/5kAHHnArhzg+EGtTmgPtVTxSMI?=
 =?us-ascii?Q?TuRRic/LXMJ0UFdp35+BLHLbXmbzLWa465KmTXBWZXXSBJIDfDNx1Xw1AmKL?=
 =?us-ascii?Q?Qtn38fJq7Dzk5IQvk+eeh9Ie?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0i2n1U6w4eWW5xwn3FCfEo4Z+uEuPkgacDAnGDwNRiVxaEPv8ENLNtaLbuO?=
 =?us-ascii?Q?55zGeHQdNMMgkIPsnvKMixcDVssKtsuVDrkC3juqM31KnMfkeIM6WaswNydA?=
 =?us-ascii?Q?bCZdPvGf1aQgEgsuidH35rN+Lb8Jn0tV98oeXD8UXDgCeVQ4Hamr/JwC45bi?=
 =?us-ascii?Q?6d7RLXY60vSc7mpwwq3x0x9KypJq1EZHp0TC5Sf3i7+1rSSdz+AzxzoF+sVC?=
 =?us-ascii?Q?Bg7YwENEJ+hkmJXjcQKVf7KB5kK7KC2guBbormapFceLHxUsDHxi8p22lDTW?=
 =?us-ascii?Q?LUz5DkcTqZCjp2YgiM9Hjui42dn3Xknqe14F0ffO3S2Q9pWrxfcktH3H2uQa?=
 =?us-ascii?Q?S9YcxiioMw4c85kwVwMOCQc2tXeG6gG42rkcPpM1nEarUrR73BkqXSiJUvcy?=
 =?us-ascii?Q?nY4fv92mDSewtl4nVfGqmH6xsYsRODv4LplUowWmpT7zqd9Dlb0OHLmSoHGa?=
 =?us-ascii?Q?n9GizGDa3MQof8U7/a14Ryfxo5JivhsjSlTEH6MzzBKvy7i6Cs6K8k02XpcW?=
 =?us-ascii?Q?7Me1c10gV5zQ/V17W5R8fJGZ3N3GU6LAmibNp0Zfnmog6X6K8Pt0OUZwDgl8?=
 =?us-ascii?Q?L9a6pktOfCsoOt1ZCY3NZRmiA8iTLuMijO0Kza0BlOfEb6AQU7vwGbJCO5SQ?=
 =?us-ascii?Q?EQNk1q8KHjD8xwlkwIi6/JNH/RrKMPAP13ZrH6VkKyrdlAQ4yF2owtPYNJ8C?=
 =?us-ascii?Q?B0W2EHlAcwPeFo04IjKdjfTW2mMYtH+gRVVccXSfEuZ0Ci+puoBhPmb4BCSv?=
 =?us-ascii?Q?hFgv6dPkj5NffKN84RGO4gwfiY7/fu2aMXYOLCG8gsCOECDT+zulNpyLZLqh?=
 =?us-ascii?Q?FGFA3DilWdKxoDyqOmhGX23Q5mppClE2yI000oV7fhPrKKYuHtLys+l9VvWs?=
 =?us-ascii?Q?1BhP+fZBwi2nPXqB8md3S9QwwSE9cMT4SU2j5Cj1jHxs81P/4AknmFlriu3P?=
 =?us-ascii?Q?4ovXRPYFEI+UIAX5Vc5XklYXctu7EyzpTe93XMseHjdQF0r+bJ+0dTpLGghF?=
 =?us-ascii?Q?uZJ/mgjatYXS56XXjjr00nA+jfgjR1ByWDhDNiWXtNhSIhIX3p9vuqGc4xLj?=
 =?us-ascii?Q?2iztrUuwSDwk8ozQqvU0c5QlEOSBrQQXDPQR/LIvyCh0Oj8pSryELJk2cuoQ?=
 =?us-ascii?Q?JtadTBJ+2M446k7LNxYkVg5Ht+D+aY3Gy67IJLc6DQ5CAEZUVH35DuFRoPic?=
 =?us-ascii?Q?+xgKsEEmoGtSCZHkNekukPlW06rmXaq+ykv1Xr7moXP1HymmJWUFqdTE6As4?=
 =?us-ascii?Q?i5EdH324WC4jvggElNIPZFrEavJ90cyEC4Ncmp9s+9+mW3Juo55R4nfxG/aQ?=
 =?us-ascii?Q?wimKHMEXmHXcgxJ2XKKrejgBWPOwsGjYpBPdUi0lX/pW56XYYflQQT6iLY3Q?=
 =?us-ascii?Q?yFB/aK+mTHZjUQ+BDpxcjEaS8yE5HCxXlxl3qRqFmKgBPVDUV62NBxlupiXE?=
 =?us-ascii?Q?XSaNIlSmstXG3ICEV8ZNqIOCYvQYEhn7XvJ4IJ7XH0L0hUvzPZDSkS/GT5kk?=
 =?us-ascii?Q?ZJs0AXV3d1fpTnfhPDw8qJgwDRcXzdXh6BrhujZZ0dfYMzI8/lVGlhRzEenz?=
 =?us-ascii?Q?JYSfUQ7tro4W6TcP5b4xDsDtXrTDHpV13bLK+auG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QJA2MNtc1o/jt+aRsQ5CsvKRXa0nfz59KO/iZG4rOo7E3mvDl5YhBYEA4qPxDetbmucacuCXUBKk7XQjkFLTqjum2fpwA5TsYmx7StRbVZuEu9xK15/Mp/A36D9ULSfns788imTAgiob8EvODOX8YjtGkS5OaRavWk1xN4M/F4MreyPEAHrIBND1cwj+fdOlkv1WETWLABqFMnwZ+T1ypnSuAvAszuBbcQcJjUKRvQ+0alJUA47Rsg2RHtJruPIEOzL9gYA8MJOoEHeFn/ssX5Y/tfFCMz8/0ejw13JhwLuHEo1UNofDe629a0+iDphmj2l/UBCKpRpkZ5KaJfRElWhfvyU8fJI2cyhRXxE13qeMU/0+8T4Whwe3JeP+qMEI5rVUDbMJNP3bmu1Opym6MO2X0vuSkk56NjaJWNH1pnkkh3iTr5jopKoKgzLJu+wuPdUCjWhEE1Wjymfs3x42X2I/rqajjEgbcwx4RkJwLq3yIGl7WW+hy6RipJDDNxhjkisHrLVIHlFXaBzaZe4eB799TQBiVYVUQ6VpfZdfZqncrJB9VI8hLYwfVV7Ag3fApC562P/4sa9aH7ebvjrxBW2IIupvUhzJ/A/idPX3Dl0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a5c115-934f-41f3-b0ae-08dcf9cf57c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 17:13:30.7448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDMxmimpmxsyqpA1D6J+29YvXmd4d2jioosImAjbRwJJlqPXyvvKu7SewNuz0mWibGlwdvBH5dIvoONCWdVYpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-31_08,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=885 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410310130
X-Proofpoint-GUID: VHRPo1Pt-JmnXOvueJZzb2biSRBMH7eZ
X-Proofpoint-ORIG-GUID: VHRPo1Pt-JmnXOvueJZzb2biSRBMH7eZ

* Vlastimil Babka <vbabka@suse.cz> [241031 13:07]:
> On 10/31/24 18:01, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > 
> > There have been no reported infinite loops in the tree, but checking the
> > detection of an infinite loop during validation is simple enough.  Add
> > the detection to the validate_mm() function so that error reports are
> > clear and don't just report stalls.
> > 
> > This does not protect against internal maple tree issues, but it does
> > detect too many vmas being returned from the tree.
> > 
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Jann Horn <jannh@google.com>
> > ---
> >  mm/vma.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 68138e8c153e..60ed8cc187ad 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -615,7 +615,8 @@ void validate_mm(struct mm_struct *mm)
> >  			anon_vma_unlock_read(anon_vma);
> >  		}
> >  #endif
> > -		i++;
> > +		if (++i > mm->map_count)
> > +			break;
> 
> Would it make sense to allow some slack so that the error below can
> distinguish better between off-by-one/few error from a complete corruption?
> 
> And in that case assign some special value to "i" (-1?) to make it clear
> this was triggered?

Yes, probably.  10 would be plenty.  In recent memory I cannot think of
an example that we exceeded 7 munmap()'s in a single operation -
although it is easily possible to do.

I like the idea of -1 too, at least someone would come to inspect where
it came from at that point.

> 
> >  	}
> >  	if (i != mm->map_count) {
> >  		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
> 


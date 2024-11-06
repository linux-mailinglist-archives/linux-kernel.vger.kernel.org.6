Return-Path: <linux-kernel+bounces-398110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE389BE587
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4ED2826F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272B51DE886;
	Wed,  6 Nov 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JfjA6EaA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J+kSqQq+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58598646;
	Wed,  6 Nov 2024 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892531; cv=fail; b=DrcWdEyOQ74SD8fd8lbsNkUCnF31fpUZQCf5aVTsauW2WJfGHNgjHtXxa+h39OpGTwOv2GXCMpuJ4/X2qNmLQ+6VQP4tiYlQzy5YUTwm1Q70SA00BkN5gZhJVQDm0cJl/VpWGAHgUCDs7z16ilUNxFFuQe5Lk1juNIHGNIeb1RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892531; c=relaxed/simple;
	bh=ce7JBrwkdLV3B1ZXWDzkK8001K8hAfUPMFdA4+KskNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qG1Gezm+jAAczJ7J/VAbulxmZ1qY86dlVJRkv+dYOw5lkag0JAUWUdTyO5YvS8Hloh+FtimD6dL9Nxgvqg+XuLBlYhyGasq3pxPLuF/I7iLDfbaeRYLCel7GPGYRHYCIuDrzRYokdiNPSQTcePXwA1SRsQyln1VPgxmJRBDX8ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JfjA6EaA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J+kSqQq+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A69BbkW017394;
	Wed, 6 Nov 2024 11:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ce7JBrwkdLV3B1ZXWDzkK8001K8hAfUPMFdA4+KskNE=; b=
	JfjA6EaAqq+oU3YoQyV1qYGSeAy94Obf/f3Siq6MP9au+kSnYdEmoHQNU3GN6qZ1
	IzoblvwhTiE42aUieTa1cJFOeOlNf5/eHrH0fL9TM+ZvNUGPbagQ0e+vSqdDqn/g
	55xwQenYhavckzNtJS0VGDO8BgN4toVvoXnVXssWmzpS2sJsM7bPNlt30YU0ujRv
	o9tCzIQh3Rv0+6FHWmf84/fSkUS4qUMj8hGZ5lqen0e3iBZTk32m6RJjJBwDbrK6
	RK+cOTt/oAGCMgRJ9oR7OUzNrYWYrzDMqpyoRqxTcvpASdqf1CW80Ysnv4UWV6j3
	GRp7/k7q7M5+Tts7AfBZ2g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nb0cfk4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 11:28:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A69p5qQ037115;
	Wed, 6 Nov 2024 11:28:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42naheqngc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 11:28:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaoRl/2G/MSST8FWfAY8lQ4N7t6+X/Emg957bpjcJQUHjzPLaCUfBJUCf1LD5e6x+j1Cyd5RQnywdBb2UtK+0qvqQWxj6ECvKsjy2WldbataRjIj2riYAulx+YEdWE3BZPD0I6go4iqxB1UeMG49NVJvT8jqclVSZae0nwA5tGDmfxoX0w/pJ+2x3FKHGzux8bhqP1vFeGju/4D7xpXz6Crrsx0strD6O0vlqoZQc3I0FbuG1senQjUZk+wm5GviUOMlLa6vb0D7Y7/bpLtRcunrLz4cGUQdzu0KTrMMF+E3sjQByC/1xlSzqgjNRcRlvGk/TOzSj/XMU7F4pMkJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ce7JBrwkdLV3B1ZXWDzkK8001K8hAfUPMFdA4+KskNE=;
 b=AqwrDCJMmLSgMHqFnurjErpETh7o+kvW8UD5s3bD93wpRHd6D8Tx53LLnannLWX33bgKsDt1tJe7lJHdpw9NAxDf9uW8N+gxCwWlZMsntNkNXzgIUmv+vdPkCwmkER3jhlv1lN3oBJyUG2BgIl1GZ6wpwXRDXmgi911nrTgnX+keGg8J3bSomiqyQKb6Zb2aXvap7/emvrzvN6RWst3CuXlCcRI92OzDUDdkx0vRKc/vZHYufq1g5Ucvzm3QbcPH1GaCygODkDfJnxE5EFIDES385VXA9UazDLoahaWc+GZmobDVGRWCMPwKX+zJC9rVh/Cl6LA8FF/CyOZZ9Q7NzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ce7JBrwkdLV3B1ZXWDzkK8001K8hAfUPMFdA4+KskNE=;
 b=J+kSqQq+wc2mPoM5pMwjhTLduX3/9UqB5oHcfXNjlw5ZVAJNUgXa/Ih49iDCa7+ZIMwj/IQKiBGXCRYUatlIyq3VhzNWzMYA4KdALIE0KJYHuajr4rHeALBc1Sc0ITKvoWYbnkJcnnGrex7zew1XbvwTh4yx836F4x2KhNXw/kY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 11:28:14 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 11:28:14 +0000
Date: Wed, 6 Nov 2024 11:28:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <ad882462-0ae9-4ca7-bbf7-7728de71c422@lucifer.local>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAG48ez0qsAM-dkOUDetmNBSK4typ5t_FvMvtGiB7wQsP-G1jVg@mail.gmail.com>
 <2bf6329e-eb3b-4c5e-bd3a-b519eefffd63@lucifer.local>
 <5969f498-a515-4394-a2b6-5d3abe2872aa@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5969f498-a515-4394-a2b6-5d3abe2872aa@bytedance.com>
X-ClientProxiedBy: LO2P265CA0469.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::25) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BY5PR10MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5ccbb8-453a-4b5b-9af9-08dcfe561a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVBxekF4VWFuQTJJOExjWTI3eGlPdUV0UUxrS3hBcm5CbW1mNEVFYXhHYWpF?=
 =?utf-8?B?cmtSb3lDVjBBNVc5bkV3c20ybzRWK2toZW1GUUE1dmdjWDlTTFpURTg3Vk84?=
 =?utf-8?B?SXRFTXc0TDV3TDNtdzIrN1Bnc1QxMkRPQ25IVjVXc2pTbC9zSmtVNXh5clVo?=
 =?utf-8?B?dENoalBZS3VXRFdFdkh3MHRGTFpRREh6RTBSYUsrZVN6Z3RhM0pkUGFQQmE1?=
 =?utf-8?B?RUtmT0k3V1ZvZCs2U3JWWGE2OEpiYk82NHA1VVpTSjltNzRPRWhXclJod3RP?=
 =?utf-8?B?K3p2NEZoVTUzajlPanZwcmRuaUdGekt4SGZlQ0RrbGpQbUtvNGd2N1IyalVu?=
 =?utf-8?B?SVZHZncyYlQ0VGtnd2FsQktoZGgzd28vTytsTlhkZXJuUkl0OWJ1Y1VJUHlr?=
 =?utf-8?B?cmlwdmF2UXRIcFZmcHJCVmRFQjh4ZEgrT3ppNHJQaERiZmd4emFmU1hEVGhl?=
 =?utf-8?B?MHozNUROeDg1cDFrejVoVzdLK2hsenRZK0UxTUxpMzJua1dFU1lXVDJ3NlNx?=
 =?utf-8?B?NUhvem5yLytPMThzTkRIOW4yRnBjWWlFTERmT3FGaXJYWlpaN3BnL1VUdGRR?=
 =?utf-8?B?bFhLVE4xaTQ2VGdrYW4vU3V1TkRxTEt3eVJUY3VZT1p6LzVxYUhTRWJBYTZY?=
 =?utf-8?B?R3lvN0Q1elZ1MVdsN2pzT2JEdHN2VnhrQWVOUE9nQnQ4WStnNTBTb3UrditC?=
 =?utf-8?B?QzZLREEyQ1U4dUlWdjE1Qy9GSWxiQXhkZStZKzc2YW9vamtnY3Zmd0dXdzEz?=
 =?utf-8?B?anR4bVJBc000V2RpclJvWXRwQzlDaVlzMXVJSWhjdGRlWXZuekpRNmZZZ0hk?=
 =?utf-8?B?Mmx3SzhwZkZyYTZsa09RcEtxUndaUW5qQWZIZ0dvbmpMWjlHMXVxem1CWktx?=
 =?utf-8?B?dkE0SUNwQjMyV0NNZ21wUmZpSWY4WURVS2RLTzJ5eHVrSkJuNzg2UWY0TTdy?=
 =?utf-8?B?RGVsTjVtUFd1amd3OFMvZ1YydzdDL1U1MHNBSkV0aFJOZUc2bHcwY1FBeFVQ?=
 =?utf-8?B?Y3hKdE5nOGphbDBmZDdOQ2lkL2UwaS9zUHNMS0V5VVJ4R0hoUVJSbks4YVFi?=
 =?utf-8?B?THFOTkhFL0VlVU03YkpnTXhIT1hZclh6N2llRVN5RFcyTEFlK09qYXFNMmZK?=
 =?utf-8?B?aTUyUjgrL1dpSzJlWjFpZGMyUE9QbXdzUXlNMWdEUU9IUVEwWnlkTzRTL1Vh?=
 =?utf-8?B?V0pxVWV5REx3a3RhRGpmdTViUG5aT25leUFaS3FuZDhTMytheU5wd05udEla?=
 =?utf-8?B?NmdUYnI3eExtZkxKbW1XN28zY2JaUjdsQXJoUnJxNHlBeUJTblZFZ3hrVFZu?=
 =?utf-8?B?bDNNRU0zdUFMbTd0a1JrRWVlS09OVUwraENZdWZjcy95RGwvSmlxU01Jb3FP?=
 =?utf-8?B?NXYwL3FETDNqWHVYQVFMRlYyU2JXeGVCdm9ENUhwSEJCZTEvTUs5SDdRNVFj?=
 =?utf-8?B?aTFDQXVJaGwwR0daaTkzbU5HT1hzaitKbnpMOFM4VTFXR0g0dGwyNGhiWSt0?=
 =?utf-8?B?QnVsSmV4aktQaERiV1luUnBkYmw4OUVlb2d6WU5hdG40Rk5VRFl5STZWak5v?=
 =?utf-8?B?ZUk0WXlScEdhS1ZkVEhHbWtFN0VBc01ORFdNMnJXbnpPRmpScDMrRzJDVXZw?=
 =?utf-8?B?SWxIMHlXMWwvazczRklpWDBtSnRGZnNNeGVrWGxDVmZTTVA1Qk5ZaUFFQy9o?=
 =?utf-8?B?QXh2TXdDTFhkbHo1ek14NzZ2aXVibE8wVDBMUUI2OTY5WVkzYi9kYzVyRW1L?=
 =?utf-8?Q?8UwpqsLUlwIF9ZMoqS0wZqOA+jXZQ9UTF/psfAE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU92bU1WckgvdEc4aktmdUl2Vkw0QTZtTEV2Y25RSkp2eXBGQnBxUzluUGdj?=
 =?utf-8?B?MnRXUFoxSVl0cDN6dzJ5SDRMV3V5TWg0VmZDSlUzaFAyM3VjdkF5amRQejZY?=
 =?utf-8?B?RFNWcWRSZC85MjN1Z2g5RFljbll1SUhWaFFxZmxwZnMwcXJhSk1IMUxCWnpN?=
 =?utf-8?B?ZXNUWDFZVkpHeXJzaFJjbDlXQzVYWE14RXA4MnI1cDFPVVVyYXlxLzlLamp0?=
 =?utf-8?B?TnUyWUprL252Y1JySkZqYXViYkJMTDgzWFkvWEdsTFByZkttYzFMclBkZVgy?=
 =?utf-8?B?QWdSckN0UzJUWTBTUDAxYWhXaTZTYnJ2NVZrRk5CTExrSzVJN0x0ZGdUMUxC?=
 =?utf-8?B?c2hWb0x0Qjh3Nk5FVnZnVHJlVUt0VTNscmFmYzFqMGNPbWR0WTQxaHFJREtw?=
 =?utf-8?B?Rmk0MWNZbm1SejMwdXlHVjhacE9QMVA5R0dKS05HdW1wZ2ZXdWlBYm1NN3FY?=
 =?utf-8?B?L1RvZzQ0NzlMYXF5QkhiQ253V1lWdnR0emNuUjVxaGJQemQveFJGdjBHeVI1?=
 =?utf-8?B?R0NWVUhyYWJKdDhlVUVCaGNTVDFZa285Q0pvdHUzMmxRQUxlM081S3d2WW9V?=
 =?utf-8?B?Unc0UmthdTdxZTZBMlFGMUd4eG15YVNBdVJSTllEQzNxeitmTXk5OVhJWnpR?=
 =?utf-8?B?T3YwZ1Y4Z2hycXhESk9MWm9hNGRUTGhTZlkvVk9pTnVVQ2tpeHlZYURUbFZP?=
 =?utf-8?B?V29zdTlSTG43Zy92TXUzajl3aVVZZUJpRTd2OGhUL2dSOHhVeG1LVnZKL0dZ?=
 =?utf-8?B?Ri8rVXBaUnJId0VpZWt3Q0tUclkvTlpteHIySHR0NENuZi8zZmtVa3I4dlc1?=
 =?utf-8?B?NEpFY2JXbzFxNStXZWptbFEwUm9xTGV0Ty9mdE1MamNtSk9IeFlWWGRGUWJr?=
 =?utf-8?B?RzBSaTZINk0xN2NYL3dCZEo4UUdIN2pKdUhPTnZ2azJUK2FCU1lzMjlqbG01?=
 =?utf-8?B?MTArNTVSck1NZVJiQUgyOFhjck81M1k1MEdINGlzUWxsWWVJaXJSRkJSbHNJ?=
 =?utf-8?B?YjdJeExJdklVZEtpYUM5SStqbkY1eUR5RFdvek1lOTlNVElYWXdpMzJXRFM1?=
 =?utf-8?B?SEpwUjF0WithclZLNGJadUVjSDJlMnlDTE9uaTIwT2gyRkRCNWQ1dE1ublBa?=
 =?utf-8?B?Z0dwRkdyVFk5K1dyQ0Z0eko0S29CbThWemxQdzk0ODd6UG1IWjdUazhYZ2tN?=
 =?utf-8?B?RGpsaE1JWXFpNllNdFRoR1ZGa3EwTmNNMkhRdWw5YkFSQ0JUSUoyc3A2NHUz?=
 =?utf-8?B?OHdneWk3MG9CTFpJaFg0UVZoamRXU3R5SjJDRlp3dFlaNzdyWUE5UXZRS3pL?=
 =?utf-8?B?eVoweXpFTTBXbDJJQm1VS0NSZmpVZW9GZ0U0KzJvRzQzaW5Wa3ZhaWxTc3Nk?=
 =?utf-8?B?cWxwY1NUZnZlV1drVDdIN2VsTjRyOWtGVkhpRkw5Skh6VGVHcEVzeGJsTko1?=
 =?utf-8?B?dnFLQUIrckZ4RE1waTdqY2M2Z1VuMzFnb2k1VjRmUzB6bkZGalhxZjBoTDl5?=
 =?utf-8?B?YjV1aGhoN29jc09BZ0JiUmsvSVpVbnFsRTMxVFd2cFR2MVVQblBtQlppK0x6?=
 =?utf-8?B?MHBJdlplL21RNXIyU1hRNXlib01NT2lpRlhnUHFUMEFDM0w2RG9pQjlzd051?=
 =?utf-8?B?b3JIdmpEY0d0T3lUZ2ZVcVlpVUNvOVZKcGxaOGlJS2hpcmFSV1NWbmtDYnhI?=
 =?utf-8?B?Z1RjRXBvYnBtTVYxLzRlVnYySXFDQ1hkNjY3TEI4QjY2UG1LbWRxVkRwd25y?=
 =?utf-8?B?cmNPTVdaWnR1MVZhaFZ3a0Jad0pYRDlJSkx1L3IyT1VSSEJkY3NRdy9qemFK?=
 =?utf-8?B?WnJZaWFwVFRhWHpXMDFoM3F6cGRvUEw1ZDdWcnpKaGdCQkVobHQwaXM1eDY3?=
 =?utf-8?B?VHljUVBNNG9aazJrVlNnNVZzNkVaL1NFRGg5MDN2enJzWVVHc3gxck4yRlhP?=
 =?utf-8?B?ZjVmeGpxVXVQWjZuUmQ0M0RHdmp5RmtmaFF5UDdlYWJEY05DL3Q0MXFVVXBD?=
 =?utf-8?B?Rm1lSzNVVDFjSlJWUWxBVlZKU3c1K0dtVmJ0cXRVcU90Wk5DYnBTbFNiTzZ0?=
 =?utf-8?B?MGdEd3NpT1diOE5zZTE3Tlk3dVdGSEMyTzNucWhTZUoyUDBaWmNoay8xUjcw?=
 =?utf-8?B?ajVORlhZd0Q1bjhld0JDei8rMFNyNEV6M0xLeStFSDFCejFJWFJ5NDB2OWVx?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ibGNGWfxsDMORdywQ00eU6UnqJwMEv7IDqvZTdhbQKzKqfUQR3NivnuQF5JfuHzTKeT4cdqlEnjXDi6cHZWtmAj6MWc6YUa/KvQ3FQ0dsP5W27tGlKw+smCRdfQv931ZqGcPV51T9T2QvnuRLzshWlx9bLJu5MDNwK+iMsxMf6S+OxHMNKUgkSiW4q9EJfAStyfdUNasaABPLUeK96PyJVXg17+v7he9SmZ+710iLW9LrX4TT49b6BRIC23XP2FpAOSfiTtdi60QXDsenS7dFGiu/NeCB5pfXAY0maArsF+hpkUnf8TKzvt5VZ71evkl3SpEHG5/7knUblxtQtGEc7N7ChHUV4McQQx38C22X95BG3dj+TNGhdrru2hNvNKCFuSHUJaCkiLFFLGbGwqqEYB402P1fQeffD4BZuUHZGsvRulVb04rZtDR/r9bzTqh/LVjbsEye9HVcnGVUykRwhVDQUF3T2dY8Uq1WkfULJLmJiXVVG0CCJZ/fbYBHun095FDyKBaB5rMme7YVWmfe7OquZ3M2SXW8wB5kjnknhPuYPERfbP/lw3MWm9nMYwOM1z7fgUp93G8IsqRneMHJG1L+6I91zabiZeGSCecB9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5ccbb8-453a-4b5b-9af9-08dcfe561a0f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 11:28:14.5087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjikwKnJ9UDMCbfL1d6L3OlpZWb2u+aa90U25SaUOmAc3UsfFBFibg0EGBi22Hqjq5TIsbPx+/+njPcT/k880R8znJwXv5tGj1sDBZO7tVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_05,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=807 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411060094
X-Proofpoint-ORIG-GUID: rKU8HdcoWuVHR8sDlEXTd2ZiYHA9d5mU
X-Proofpoint-GUID: rKU8HdcoWuVHR8sDlEXTd2ZiYHA9d5mU

On Wed, Nov 06, 2024 at 10:56:29AM +0800, Qi Zheng wrote:
>
>
> On 2024/11/5 00:42, Lorenzo Stoakes wrote:
> > On Sat, Nov 02, 2024 at 02:45:35AM +0100, Jann Horn wrote:
> > > On Fri, Nov 1, 2024 at 7:50 PM Lorenzo Stoakes
>
> [...]
>
> > > > +
> > > > +Page table locks
> > > > +----------------
>
> Many thanks to Lorenzo for documenting page table locks! This is really
> needed. And at a glance, I agree with Jann's additions.

Thanks!

Will be respinning with all comments taken into account relatively soon.

>
> > >
> > > (except last-level page tables: khugepaged already deletes those for
> > > file mappings without using the mmap lock at all in
> > > retract_page_tables(), and there is a pending series that will do the
> > > same with page tables in other VMAs too, see
> > > <https://lore.kernel.org/all/cover.1729157502.git.zhengqi.arch@bytedance.com/>)
>
> Thanks to Jann for mentioning this series, I just updated it to v2
> recently:
>
> https://lore.kernel.org/lkml/cover.1730360798.git.zhengqi.arch@bytedance.com/

Yeah I need to read through a little bit as I was unaware of these paths (mm is
a big and sprawling subsystem more so than one might expect... :)

Could you cc- me on any respin, as at least an interested observer? Thanks!

>
> >
> > Ugh wut OK haha. Will look into this.
>
> Thanks!
>

:>)


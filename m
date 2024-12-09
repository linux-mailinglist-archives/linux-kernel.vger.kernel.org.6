Return-Path: <linux-kernel+bounces-437930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA6C9E9AA6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DB7285CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312C61BEF8E;
	Mon,  9 Dec 2024 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dJJWi7Y8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AjfUA6cT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95BA35954
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758454; cv=fail; b=GiRlhlvSerZxtwRxoulPOcb1ASSiv+0HJqKQbf/w/kHLPYwqm6Na3lPgZQKXg0zgFdBLZGobz8Sei0Qlpzm0yXIFrN46Jcnv2m7yVjAlH5ECwmRe/JsF/dDh/HcGX4mJAQIYnOhQwHdA9ugl+eKcZB0lnazDLrxusItaGQfTK1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758454; c=relaxed/simple;
	bh=+8tf+aOvVPWDnbY8it21FPfnysGldXKxT8NNn0vu8d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PA/KVSYxWGhTCzVddK0IkuSa+u4gZ1/MEe83kXipsMQHWFACUe54Vp4byElPsLA/lNQ/X5X+pKlLjl+f8a1nru+cKj0YCXcLWaCed4zBfOmLQlXVQJa9fO4oOTtUTqyUFm1OfYD/8ApUkyDxFxUnoxlFLChdL5TtlvI9/BLLvZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dJJWi7Y8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AjfUA6cT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99hDwm004408;
	Mon, 9 Dec 2024 15:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UhDY5ztOU8xXc6KQHIqL2uhGFtJZLWPtJavZ8th4FnA=; b=
	dJJWi7Y8gdMSUYSrVy0mdfDSZGfwSxFjWQ3wcN1z44HYkq+hvl1YJRq5PKIx/wYM
	1oHhh062tPtPv2gflIE2J4bi99e96a0fJ+G2JtUomCf0XnuIAv5hITquDvOr0nb2
	ljjIOWwY+oD/Es1D3GwEndlAyHyR21XWBnRmrR+mVk47cJotYZ5JMU2NDOwKQYsG
	2ITAaBOvdr7B2nB9LTcZURSp5Ua53uCmv1fx7+wHY8eA2rv05Ow3dPe7THyjWHTc
	z6nAJE6jN/GQ6vlMB3pYZ+eV4X65qwlSEJYuh7JS0E+byqgKstPFSG5YSM3r4xhy
	V4CYXFm94Vm8OVQCLkjxMw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s0ns8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 15:34:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Em2Sa037967;
	Mon, 9 Dec 2024 15:34:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctdk113-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 15:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbsaYCzUA++iDeVcSSEBtnryjAbT1nEh8kgzY4V4HFgcd7rIS9quUv3EnAwYceWNTyTXth9T0BlGpveameBo4jSc56BmVkXX6InKy6nGnwObbbe6DWaDJyVRknrLccaZs92JC9B6K+8PwysB8Tju9H7WAOVQHMRGmQHngYcLCU5j6AqZILesF8mSPttR67wyf+/nBTC1LUx8BHD5rSFUwWRSlAxLlNa4MmDI1pwHpfeWBsyEsgfnNuKqSAIsYybvclZmtAvHYGnkSCQZLfWKoMMZSorf9ca+S2h8WE4aRqJ9ryMLz2RoiIuX+dQMpGmSYbtHdptf9VjQ0q7GkLoJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhDY5ztOU8xXc6KQHIqL2uhGFtJZLWPtJavZ8th4FnA=;
 b=IzXBuPtz9zC4nTATK9K2j+F6WBelvVCL0r7Pf1DXx/Kk4x4Q9fAJBvZbNgeGtvrX4vfWUqxSSniZgk0BTv+KGwgzn/icgPo/ijv7pxemLRN4pK3YCm3R96A8rQb0L6rbi/0jBcjl22JviqEODD4qqr1NDWCOzYA80pSyMPRskfFWBh9sLxeD2ygNU1KtY7ZtY/mISNqifub8UsNHes4BpXekX+gYnmcRMY7YyS97d2gowfrWkgtvW0rv3qwldEaju8tzO/xMzKp1obVW8G5k7b+rgSOPnuB9mFW3gcAJ4dDz+52gXdtyn8Iy6BaoxQ/OdiXM61sepLHWYJA/gr7rYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhDY5ztOU8xXc6KQHIqL2uhGFtJZLWPtJavZ8th4FnA=;
 b=AjfUA6cT44pGzQHNeP53ETrMXvQvz6rXbPK8vIuHwT9557vcN/fStzi8OmqcXTJW8q1VM0Ard40BBf8+xNY3vP26Jark+u93i9nW9Y8/15ThCMNuHmwD4T0e6Dax8HWeNBgh728mV1jMGe69MgTUNA+RxCncizuQSF/aWe9mv7Q=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by CH4PR10MB8195.namprd10.prod.outlook.com (2603:10b6:610:243::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 15:33:59 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 15:33:59 +0000
Date: Mon, 9 Dec 2024 10:33:56 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>,
        syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in
 find_mergeable_anon_vma
Message-ID: <hzzshrolmkewwxa5bejqrcb5xpbe2upfpa7exvxmq6svdszwhl@wsqg4gksstne>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
	syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
References: <6756d273.050a0220.2477f.003d.GAE@google.com>
 <1b8b5d54-d667-4ca9-b831-bee4b4e74c40@lucifer.local>
 <CAG48ez1d60kH1W8uVvOh-+Vs8Jz5TX1a8LD+mh_O8_3HFHAx6w@mail.gmail.com>
 <e9b3987b-8cbf-48db-ae70-ff9e2c0954aa@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e9b3987b-8cbf-48db-ae70-ff9e2c0954aa@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::11) To MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|CH4PR10MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e3e2e7-50f5-4f68-ff65-08dd1866e67c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0kxU0E5VmhYYzZzQ0xrK2xPRkk5SG5LaWNITjJOejlxZmtlYWxpWGpBUmZz?=
 =?utf-8?B?cEJla3ZSNWZFa2M4VVRLT0R0WGU5V21ybCtJMTNoKzA1T2JDSU93YVF4M3Uy?=
 =?utf-8?B?MGRpbXFmZWRVTTNhKzBxVENGbHBKL1ZMbHVISXZYelhKMmt6Z3lHOEs0TzFI?=
 =?utf-8?B?VTVCVGwyTlVtSzNkRFMzeXpJd3ZLeURMd3pRZUgrMTl6K3ZpQzZEUmJYYmNi?=
 =?utf-8?B?VFpqbnlXNTFtdEhPU3BXMkc5b3hzajN3bGlrTGFIMkw4V01KWDB6cktzYkhN?=
 =?utf-8?B?S3VwdHU0SXIzL2l4eVFjTnRxcHB3dkkyWUVLSFpBZ212SDR4bVNrckpiTGNm?=
 =?utf-8?B?MWxNRCtOZHVsYTUveW9UZHhoS25ZaC9QVDFFSStwakcrRUNtT3BtQ1ZpWDRB?=
 =?utf-8?B?THBkdmttWCszbkJxRUZ3R0pkV0VhM1hPRDU5Wm85L1FxOXI0SHlyNVJhdXhI?=
 =?utf-8?B?ZjYrckpKQnhUc3ZudzhHeHNsdWwzZjJQTC9WQWFQNUlvd251SVpJRW5EVWRn?=
 =?utf-8?B?MWdSMW91L1JNQ3l5WW1aQ1ZEWTZtalFBc3p1ejhsRFhLeEp0U1FKcVpVc1RF?=
 =?utf-8?B?eloxWDRMeWhwUGZCSWgzWVliYmd4UFVvdHhlNlNEZk5yTnhtelJWclQwTjQ1?=
 =?utf-8?B?Y0RZaGNsTnlIVmplc0UyZGxURDR4b29xV2JzVitmMWxpTVRLc0tNSlBwT1pE?=
 =?utf-8?B?UTBJQjR2NS9DeW9pK3ozWnJCdWpkc2VjNjd3bGtKWnorMDQ1TkdwbVFIVXBw?=
 =?utf-8?B?b2VVTlB6SzFjd010bHZuRTZRem55THJ5Rk5TWnJFblNmRzZTdjFNNmVON2F5?=
 =?utf-8?B?NGFQNEQxblFNUFQ0UDkxOWIweTNka3lQTXRvUndlWHZxek1CTTBjSzlLSHVB?=
 =?utf-8?B?U2xhL3ZUTVp6bnFPaE5rZ1g5SEhmYXdwaFQzVmtqR05QdWtxQjBTazBCVGNz?=
 =?utf-8?B?ZTlnVmZtUVFOWXNNV0N2UHhYNFRoK1R1Q1BRaGxYcDZOR2tyYkZYNjNMdk5J?=
 =?utf-8?B?V3o4WmJ3N09YSUozWjBxa2xYbi9rbDE3cWhaZjNKaEUwYjEydWZYbEN4MUkv?=
 =?utf-8?B?c3ZiSVM1bnVzVWVoWm8vM001N1dKRzV4MEVkd1RLbFVLcjdFS0NVVWlYUVQ0?=
 =?utf-8?B?WlN2Z3JHWDl4QkFOWGpYQXlLVjNWaTNMMDYvdkl5NXRCbXIva3ZhTzNObFVr?=
 =?utf-8?B?UHhEYVZISnlZbjY3VXZ3QnpweTQ3dnA5OGVGK3lZQ0YwTExVWVprQ2pHMlFC?=
 =?utf-8?B?Q1lFUjRydEhEbU1ld3B4N0hlYThIOFZmZDFMZm5kWTNQaEZYWkZKRFU3K2ls?=
 =?utf-8?B?YkJXRnhCZE1LTHBTYmRtc2g4clBvY1ZGUUZzN0lIcjVCcTFjZDZ4aFFDUHh5?=
 =?utf-8?B?Z3c3aXRtY0k4a1ViUkpHQ2I3RGt0dEpXM21SMGlHQjFJSDlvSGJsczRtT1Q2?=
 =?utf-8?B?anZSQVFaQ1llTXBzWHIvZDlqZ0UrZHZGTHZJRE5DMHJHRXZUNkg4T3FxZUxt?=
 =?utf-8?B?VWhDWEFmbitwNlY2dkY0dkV0U2dlalNwL2NYMHJwL3hmU05WNGR3N0ttbWJD?=
 =?utf-8?B?dU9DaTN5U283UE54QlplcFU3enNwM2NmME83VkN0a0Jla0o1clJ2cGlBb3BI?=
 =?utf-8?B?S01kV1M5c21XUVhvSHhqTTRydUJXSmVkNjMrV0pXWUxad1VaQy9YRlFIdU9n?=
 =?utf-8?B?MXdFWmU4WE5SVHhvdGZmL0cwbjZqTG4xakZJNzJJVXU1RGtGaHJLZ2NWYkxp?=
 =?utf-8?Q?WQMedsKKSK/am172vg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmZicE1DYmExR2w2VUg0RzBHR1A3MmZReFY1QzltOWdXUmE4NmpvK29DdUtY?=
 =?utf-8?B?d3oySEFTN2ZkS3J5WVppbnR5bkQrSk1ZcXI1N3pEbnlQeUxLU2tocHBkZ0hY?=
 =?utf-8?B?VTdjMWlxZU5SQys4K2JaOGJUazVsbXp5SjU4WjhxZzlxRlpCNkRaTjVrQWFv?=
 =?utf-8?B?N1FmRkFYbU5FcWxzNTdIMnQ3a1dVdjZWQ3pyNTJjcUNJbEwyMERvQlRWMEpF?=
 =?utf-8?B?eGFuTklMR0RHcURoY3EySTRRUFRHVWJXUEkvVjhOS2N5UzBWNFc5Kzg3ZElJ?=
 =?utf-8?B?cVdDaDNsQlpIMlJ5UzBuck52c3Q3Qmx4YXB4OGZ2RU5WdThsemZobEpHeGRz?=
 =?utf-8?B?aHI5THkzRVg3MEN3dXJsSW5zaXNhVEt0MXRPY1lLRExibFlsdFhFS1d2Q1g1?=
 =?utf-8?B?cTRaYVh2UzlwbmdTOUVVMDkxbzc1czczQVdBYlZCd1pCa004bm0yNkNwYXZI?=
 =?utf-8?B?OTRKVytqOFhFcDEyQnB2NWM0L1NFNGZ3T3Fjd1pkRGcvMGNpWlZkODFVUTFn?=
 =?utf-8?B?QW1FSW1EbHpSemJuWExGNVNLVXdWZTlsSUN1RGVReVF6NEpCRFNvTkdkUjFy?=
 =?utf-8?B?U0Z3WlAxWWUxOS9FS3Z1cGhRZjBZKzBpb1Q0SnF3WjY0bi95N2pLM053NjEr?=
 =?utf-8?B?UDNzUEJBVlR2dXNXbjZNRTRheUw1elZVZWVoREk2ZmxtTmZMWVBnRjJmS2dj?=
 =?utf-8?B?bE1BUFlLWUxNQlJXWlQ0SjJqb3dPT2IrQTdVaE5QdnM5M05KeGVsa3pqbWJU?=
 =?utf-8?B?Mk1WS21rb2RDaVExdkJHSGk5ZWhZRFRuQ3hoeFFkSFNCU21GbXUwRERxaDZB?=
 =?utf-8?B?blQwbnVyOE96NEpxZWw1WjRJOXBLUHB2VVorb3ExZXhJS3VvQ1A3eUNJUU5q?=
 =?utf-8?B?d2FoY2ttTGZLVkhrYTNuYUhDdmR5eU1ZOElnZVZFcEo5OUE3bkdFMldsQkZU?=
 =?utf-8?B?YlBVUkFtWGdzV1pXa3V6MkNqMUVkN1hCZ3JzaGNOTTkyL0NjU2JqSUl4YkxC?=
 =?utf-8?B?RDBDcThIRlJXSjhnN25HZTlLaHlwU1htbE5sUGZZcWJCZi8zVFdxUGZLNmhP?=
 =?utf-8?B?dmcxNklYRTZNc2VnZXNOVkloQ2FUK0wzQ253VEpZR0xua1EvZUphNnk0cTJM?=
 =?utf-8?B?ZDc4TEJWZHU2bVhJQ2ZXVUdCVHdjaGp4LzBENHA3Yy9VbTNNUW5sM2V2Tzdl?=
 =?utf-8?B?bW9kMkc2VjBzaW4yZldFZEZuU0NCNG9neWEwRVR6NjhCcnpvclFDYTJQYi9s?=
 =?utf-8?B?T0lwQ3RuTkMwbWNaVEMvV000dXNHTVdHd1lVSWwzNFBjVGVTbitxVE9VNzlI?=
 =?utf-8?B?TXcvNWt2Z1lsWGpoVlJrTFVBVVpaQTFaclR1cHFkcHFuTytHRHZHVWtFWlda?=
 =?utf-8?B?ZHJyTU10RHNYcUtMcTJHQ3Eyb1pRbUdCVDZhNDBrUVRYbUFFZFpmaXRXNk0w?=
 =?utf-8?B?YUYzTWd4c204VDNaUkNYZTVMQjZ3WnF1azF0ZWxDYTEzMWtMRUR3cmdHU2lq?=
 =?utf-8?B?dnpLclBzTDJjTnA0R1I1VkxmUXJ5VlA5NGdrS1ltS211SUFtQnBud0xkcDJK?=
 =?utf-8?B?Vm1FNTNkODZBa0EwUGtZTVBrYVU3QzhIbW8vTmNsNkdtVlJUV0hRUDl0b2xS?=
 =?utf-8?B?REYwbW5jK3pnRzNmYXVDNEFCQ1ZucUNwNzZ3QXY2TmtaYWlSRlZlRE04eXU3?=
 =?utf-8?B?WHZ2amVIV1Q5UWpnTURhUVFmYVB1TnVML2p5MEpiOW10bHNwWFBYc2FQSUVj?=
 =?utf-8?B?UHpOd1gxcDZXY3p5b3pYRER6bFRjZlFzZlh2ZkJiZktxVHBzdDFGaGE3bzVm?=
 =?utf-8?B?SVN0bEtXYWVXQW9sMmNHNHJSME9XV3l5cmFXU1JidnBNNkszMDJ3WHI5aE9v?=
 =?utf-8?B?NjRlTmY5cStzYVZraGZDUUNxdSsyOWszMXdOMlhML1M4VGZsblVEbnBwckhZ?=
 =?utf-8?B?a0hsZlZsaWFzUnlSaUZ6K2k2Z2VDZDdqVlVYYTF1RjlaUlU0L2h1eUt2R1E4?=
 =?utf-8?B?Qlo0RnR3cjhqNDZFRzlqN2VaNVBGMnUvOXpkTGdmZmdXVHBabUhiam9Ba2Rq?=
 =?utf-8?B?NUVkbCtreEFNczk1VmpHMm9rUWp4L3B1TUt1YjYvYUVYNkl3WXNqOURBb0di?=
 =?utf-8?Q?ftK+zAuhYSXufUkHZPDNeXjWH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kaol9e9wC53Ku7Y8ZxZHdvFM6dAteagnkM2fZf9MmD3ma1XQ6Ek3aP5cJfpJQg9gjW0FD/OgmPz5RXk7Pgo9QHyd6+61c3UbhlacZUwGCkULQLyF2EaMHPW8gGHjkfrQXBlPfzjVrNRrwBjHDXdERgo+7J+F0+e32xMzBZ8Qbpe4fpO0R2bqcyFcvVcOl7pLPhapfPQM+xeo8FTejfg62xlmj8nao8wNKmbxY3beFnXN1Qp9UcH16/xTxlgqAehsTY1OvrLZVi0u6o2v2HxdwvgegEVOneer4ogG5JMzH4F+iedSsq0Ki3S9VDd5doqxQdEWpbdnG3l8t3qVEAaPRlB+htAK3Z1hX1g8ddJh0xAcfnMMlqbB0xyVGdWcVyd2qr012OzqUWVeXNpQoHx3DuzMD/MzmxvBdi1ZOPvtNr3mMBJ7FLu+jfLWTTkUopUCw9H2g0IHZDV0dvBOBT4qfxG1+pOKESSwn5VOosC4QBIsUNqyqdRoy9rSNqRe3mUvhuXVU53vtu4CKWNGJi1CsL2S9FUs3HNm2YiJdTSx4ukpgfvjEL3Y2NDaugEVJ3IMVBbyPDoKbdjFo0lZosr+HXUDZEnrZnIn/AMpMaeZzXU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e3e2e7-50f5-4f68-ff65-08dd1866e67c
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:33:59.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2dXhLhZj8X68iT8gflo8E6aB+kHYda6pKAG6hv9+mssZKoF5O8/VgRpUq16JOAp3CVk+L/tpBP3xs2zSaW/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_12,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090121
X-Proofpoint-ORIG-GUID: rQ6f5vcs_mCGKNt1qUa78zf3xELjUzBZ
X-Proofpoint-GUID: rQ6f5vcs_mCGKNt1qUa78zf3xELjUzBZ

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241209 08:58]:
> On Mon, Dec 09, 2024 at 02:52:17PM +0100, Jann Horn wrote:
> > On Mon, Dec 9, 2024 at 1:53=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Mon, Dec 09, 2024 at 03:20:19AM -0800, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://=
git.ker..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17f85fc=
0580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D50c7a61=
469ce77e7
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D2d788f4f7=
cb660dac4b7
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Points to this being racey.
> > >
> > > >
> > > > Downloadable assets:
> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-as=
sets/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/6135c7297e8e/=
vmlinux-feffde68.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/6c154fdc=
c9cb/bzImage-feffde68.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
> > > >
> > > > Oops: general protection fault, probably for non-canonical address =
0xdffffc0000000080: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > > KASAN: null-ptr-deref in range [0x0000000000000400-0x00000000000004=
07]
> > >
> > > This doesn't make a huge amount of sense to me, the VMA is not 0x400 =
(1,024)
> > > bytes in size... and the actual faulting offset seems to be 0xdffffc0=
000000080
> > > which is 0x80 off from some KASAN-specified value?
> > >
> > > This would be vma->vm_file. But that also doesn't really make any sen=
se.
> > >
> > > But I wonder...
> > >
> > > I see in the report at [0] that there's a failure injection in vm_are=
a_dup() on
> > > fork:
> > >
> > > [   73.842623][ T5318]  ? kmem_cache_alloc_noprof+0x48/0x380
> > > [   73.844725][ T5318]  ? __pfx___might_resched+0x10/0x10
> > > [   73.846687][ T5318]  should_fail_ex+0x3b0/0x4e0
> > > [   73.848496][ T5318]  should_failslab+0xac/0x100
> > > [   73.850232][ T5318]  ? vm_area_dup+0x27/0x290
> > > [   73.852017][ T5318]  kmem_cache_alloc_noprof+0x70/0x380
> > > [   73.854011][ T5318]  vm_area_dup+0x27/0x290
> > > [   73.855771][ T5318]  copy_mm+0xc1d/0x1f90
> > >
> > > I also see in the fork logic we have the following code on error path=
:
> > >
> > >         mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
> > >         mas_store(&vmi.mas, XA_ZERO_ENTRY);
> > >
> > > And XA_ZERO_ENTRY is 0x406.
> > >
> > > Now if _somehow_ the VMA was being looked up without XA_ZERO_ENTRY be=
ing
> > > properly accounted for, this might explain it, and why all the !vma l=
ogic would
> > > be bypassed.
> >
> > You fixed another issue in this area a month ago, right?
> > (https://project-zero.issues.chromium.org/373391951,
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Df64e67e5d3a45a4a04286c47afade4b518acd47b,
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D985da552a98e27096444508ce5d853244019111f)
>=20
> That's for ksm/uffd though, neither pertinent here.
>=20
> >
> > And we came to the conclusion that MMs whose VMAs have not been
> > completely copied and might have XA_ZERO_ENTRY entries left should
> > never become visible to anything other than the MM teardown code?
>=20
> Well if we came to that conclusion, it was wrong! :)
>=20
> Error paths at play again. I mean I think probably the slab allocation is=
 'too
> small to fail' _in reality_. But somebody will point out some horrendous =
way
> involving a fatal signal or what-not where we could hit this. Maybe.
>=20
> >
> > > > RIP: 0010:reusable_anon_vma mm/vma.c:1837 [inline]
> > > > RIP: 0010:find_mergeable_anon_vma+0x1e4/0x8f0 mm/vma.c:1863
> > > > Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 10 39 1=
0 00 4d 8b 37 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c=
 04 00 74 08 4c 89 ef e8 ed 38 10 00 49 8b 5d 00 4c 89 f7
> > > > RSP: 0018:ffffc9000d3df500 EFLAGS: 00010203
> > > > RAX: dffffc0000000000 RBX: ffffc9000d3df540 RCX: ffff88801cf80000
> > > > RDX: 0000000000000000 RSI: ffffffff900062a0 RDI: 0000000000000000
> > > > RBP: ffffc9000d3df610 R08: 0000000000000005 R09: ffffffff8bc6b642
> > > > R10: 0000000000000003 R11: ffff88801cf80000 R12: 0000000000000080
> > > > R13: 0000000000000406 R14: 0000000021000000 R15: ffff8880120d4ca0
> > > > FS:  00007f137f7e86c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000000020000140 CR3: 0000000040256000 CR4: 0000000000352ef0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  <TASK>
> > > >  __anon_vma_prepare+0xd9/0x4a0 mm/rmap.c:199
> > > >  anon_vma_prepare include/linux/rmap.h:164 [inline]
> > > >  uprobe_write_opcode+0x1a95/0x2d80 kernel/events/uprobes.c:516
> > >
> > > Here we find the VMA via:
> > >
> > >         old_page =3D get_user_page_vma_remote(mm, vaddr, gup_flags, &=
vma);
> > >
> > > Actually one unfortunate thing here is... ugh god.
> > >
> > > I think there might be a bug in get_user_page_vma_remote()...
> > >
> > > I will check in more detail but I don't see anything that will preven=
t the
> > > mmap lock from being dropped before we perform the
> > > vma_lookup()... FOLL_UNLOCKABLE will be set due to the &local_lock
> > > shenanigans in get_user_pages_remote(), and if we get a page after a
> > > dropped lock and try to vma_lookup() we could be racing... :/
> >
> > Hm, aren't we holding an mmap_write_lock() across the whole operation
> > in register_for_each_vma()? I don't think FOLL_UNLOCKABLE will be set,
> > the call from get_user_pages_remote() to is_valid_gup_args() passes
> > the caller's "locked" parameter, not &local_locked.
>=20
> Yeah I was just about to reply saying this, that code should be cleaned u=
p
> a bit to make clear... But yeah it's the bool *locked of the invoker, and
> can't be &local_locked.
>=20
> So yes this rules out get_user_page_vma_remote() as a problem, which is
> good, because I wrote that :P

The mm_struct isn't fully initialized at this point - and won't be once
the dup_mmap() fails.  How exactly are we getting to this point in the
first place?

I have some ideas on fixing this particular issue in the not fully
initialised mm structure, but we will still be using a
not-fully-initialised mm structure and that sounds wrong on a whole
other level.

Thanks,
Liam




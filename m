Return-Path: <linux-kernel+bounces-378537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5EC9AD208
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD931C25E92
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177371D9A58;
	Wed, 23 Oct 2024 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m6sNhATz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZV21HMR8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D821CF5E6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702592; cv=fail; b=T4yUt1dYqVCSrKc0T2l898UTE+Cgs7BMKfPC+L2z+rHxoL4dMoA+whe46hxs9zRoj1z5jWkIWCq/4pMky7eaNgkJKogRNaHtwAGNU5NMTHuGkezzjcIIyuLXGmUvum+TFqp6c8F6pD/MDdFb3PSGyxt2B2GBX8JPGaj3tEioGVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702592; c=relaxed/simple;
	bh=KSkDzEgd+dV7ZWdbaqYt7gcX8OaMiIWG9/WdpEA2j0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jrLVLZXzlFBeNBWKaBg0FnPH7cPcsAO89MXawNVVyEzEU6G48ctYhLIRdjW2Dgn3OsyE/MZqFD2vHP65A410R9IdAh4fi0g3F6r7B2qlL9jr1s25h1aEgpa5jTKNJ+rQEWLXQmJ403ZdFAjY7tmIo5quhKfgNmsFtARwm9RAQLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m6sNhATz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZV21HMR8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfdVA025347;
	Wed, 23 Oct 2024 16:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8LsMWgnST9mZpnmdBLHlYqaEgeZSWtuwvd7YFf8XjzU=; b=
	m6sNhATzxcoWbJzJEkc6rkPehl7Mu70aN+Az3W7vBT9mJhE4xVeEhz6kcrmVa0Vi
	jG5vwXBl2jISIEdOvbVOUs4MpHYXqMLLwm5Gk8lWKKuFsNUcFxrwgSrmzi/DLVRx
	NMX8KH7hrnR1+kRLYjwEjIEp6fat+yOn5lKW1m3YrHIBuOs/F1jKRLiRdCw9RRg+
	lGEZcbY4eUiV+w6QJFrn1FH/gQPj/rLrIG3fEZL3MgHG7Cewn1WqeHcy/vFbogOC
	Xb3haUBLvN4lxhKFaboVgnDD3eHDaYrHO721Ahut5BflTNmak5nz3mqDzfzI0Yjf
	XrBUtZ9RdRAmoOeVpFx1BQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asgmj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:56:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NG94Zg030915;
	Wed, 23 Oct 2024 16:56:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh1shj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:56:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJZnzs9mY8FE/QRXrc7Rq6FRcgXX6HJBf7hqvqb7IahHt3wT6wgVk6iuNF6e0s/+9319n0XZrnbnJbDDPxwjYipfgOBkYRY9RdNdtRrl1jRIfZRqhWAFzCJKBo2OmQjEilQgM0ncKIDtoL2NmpbTLPMpJDv7/7iONBEQ6OlrNL0VzI7GgDH/f0ZDTxTfQGRvSt3b094Of714G5HGcXWibBbYaF/zzWd4/+2kEEf7ypQ14tUG0dhNKlRplkBouATBf/54f3FCNSzfpAG3/ZNMT3lXSVXxOzv+239GvDpOPCCr590edpmJ7PQVKPtjn3O1JMrRpIglblkhPKHYTyc6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LsMWgnST9mZpnmdBLHlYqaEgeZSWtuwvd7YFf8XjzU=;
 b=eQpAS2cX9nSmhk6LJmPr6lKGsQy7xZ6Kbr4hZPB3PT2QaR81hbHC+ywtFI2yNUIjXhZCdH8gBs+DbrudkInuaX/uDJ+dc3vrFRlZDY2VE2ODz99C2/YiIESiny08ubvmUx4oAYWMLZlY3HaWN5GEZLT1g+pZ1zSfV7LKxIGgnp5ZJ1sA/yYF96EXSEN9sl8DIFIZoHi5uGzYkICVXyucyD9aW8J40OR6lNlh7ay3bNGoOyOoqlSzH00qjyB6jvwUyAyboxSqe/7nr/o5eCR0HbaPF0ADcBq3sUXzpvnDXhufqXd2Yri+ay2DHwLf9AYjERjjBJCAcPBUnjMkMwzFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LsMWgnST9mZpnmdBLHlYqaEgeZSWtuwvd7YFf8XjzU=;
 b=ZV21HMR8t0hhVsVu3VTyzH8eLuiokApprjHnL5jyRrXB0ex34qLkHZlCI1QDznQkxdV/nV6Of4mCpkzJSQMkmHlb3vPeO81MgZZmno5Fg4EFkVEhKGT1MeTZldn8kYld/mXAvoeojLXbmLvDhOR00airpBF1JiXMg+2CeqUmIAE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6727.namprd10.prod.outlook.com (2603:10b6:8:13a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 16:56:14 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 16:56:14 +0000
Date: Wed, 23 Oct 2024 17:56:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 1/8] mm: avoid unsafe VMA hook invocation
 when error arises on mmap hook
Message-ID: <854e4713-2579-43c4-8d57-04ed059f3250@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <ddc1e43edbb1e8717c2be7fde96b682d8a898836.1729628198.git.lorenzo.stoakes@oracle.com>
 <CAG48ez0opg3QVC5Gh28=Xox5ARHGLa=Kt_Lp2VivC1SzfThyLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0opg3QVC5Gh28=Xox5ARHGLa=Kt_Lp2VivC1SzfThyLQ@mail.gmail.com>
X-ClientProxiedBy: LO6P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: d693a4da-2510-46f0-8e8f-08dcf3839ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEZjbHVLd2ExTGZMMW9VZFdFN3VTRENMdDE5SEJqRXNibzlKQnB4eXZ4T0ZY?=
 =?utf-8?B?Q1E2YXY0WXdpTEc2NFRkN09NZWpjL21WUTFJa2F1VDVFaU0rWWlmMnRIM25L?=
 =?utf-8?B?M2haVjVKQ2xVR0N5MnR3K1hOMENueHVpOXdiVC9DQmFMcXlTeVZqVndmUDdE?=
 =?utf-8?B?bDZORE9ZcGtPM0VVZ0RjOER1ckhPMnozZ2M3OGIwRjZSSnhhS1FYaDlZNC9h?=
 =?utf-8?B?b1JWWWNLZXE5TDN1Mno4QlBnVUU5SXB4bStkdHd6cEpKUituZWdWNnFKS3Ur?=
 =?utf-8?B?RENZbnpOb0tPcTBheXJ3L2Z1YitBb3RoZjc0WFB2OVozdmQ2Q0Jpb3VMZGkx?=
 =?utf-8?B?dE81NXBxd0x3Y2FiSlMvbmxUQjM5RytNQXhUVFNVbjBDN0REcEdVQjI3WnE4?=
 =?utf-8?B?UlplWHdLQmhORUFzdEM0L3QxMWV6Q2M3TzdKb1R0bFFVTjlRZSt2YkIwNytn?=
 =?utf-8?B?dEtjdzhPMkx5aFVxeU4xeDBuRjQ0ZDYyWW5QRlJCRkdBL0sybVQ3ZWlyMkpD?=
 =?utf-8?B?OURIWVg1K1ZRL293akRMZFJJTG8wYVFPQ25jR3RiV0hWdzQ5eUNuSGo2a1N1?=
 =?utf-8?B?VEhKZ0J1RTdBcnl2VVdKOHRKYXdEVmdyOWFpTHJxdFRUMWlEYVZ1aGVqcmww?=
 =?utf-8?B?cHNZTkdwZ2RTOWxFaTZYbnU5K2M1Ty9PbTR4ZDl2VnpXemp6QStodUF1YWtH?=
 =?utf-8?B?cFViTXpzYTAzL2ZyNUhvREwyUFlQNHdiMlFJRGRXNnNNbjZlWDFubGwrQ2I4?=
 =?utf-8?B?US8wZlhYenpUYVlqdG1hMjRmREhMNXdzbEwvV3BNQ09nek5pTW5RQm1CYk4w?=
 =?utf-8?B?TVpvYWhKUTFOQkFYdmZwZm81VUlOTHVVUEI0d2dYRlFSQ3lyRUN6bzJjZm5Y?=
 =?utf-8?B?L01UeHV6eG1hcHA5Wkl6UzZLL0lWZmlWb09PM0pqSnNmc0FZVU9wY2xPcE00?=
 =?utf-8?B?V3BxTjhDc3RPb09jUFlCNTJxNHJLZU55WnRibFhKanVLb0ZkY1NtKzl1VC9L?=
 =?utf-8?B?eU1xbVZ3QWdyR1BaTG1NSnJqSlhvUXlEKytHM3EyVzlPRmUremtxUEdqN2ph?=
 =?utf-8?B?blhiRVYrU1gwbkNvR21xVThhY2NCZmtyZDM1ZDRJVTM2bytJWjVGRXZxUHI5?=
 =?utf-8?B?ZE1mZjZxUnp1ODhoV1JXMG1QbXlaMWEzVEI3c2x2WlVrOFJ1RS9mVVRGQSth?=
 =?utf-8?B?SDZpY3BTZThDZlV2YkZUcGF2TlBwQWhYemgyckpYdnJNRlE5RVIvdFZJdFBY?=
 =?utf-8?B?cytHQnZSOVVNOXR3aHk5endhV2Z4dU1tTFd3Q3hlM3NhTjNGZjFiTXZUVmw1?=
 =?utf-8?B?cmkxemJVdVJnaVFJWElqcDZ5ekJoVk5LMmorbnhTVndUZFllMjlZMkpKbVla?=
 =?utf-8?B?R3JkTGI4RUxUVlVyN01hREtVK1RHS1U2aGUxSktNcUwwWmNHaSswZWtNdWxF?=
 =?utf-8?B?dlNxV3ZzQ0U4VkRzL2JCY2d3NTBqTEhPN2JDRU5FRGROaG8rdGVadzBja2Ex?=
 =?utf-8?B?ODg0dUpoQ1ppVkdYazQ5T0dJR3dDdW8rSE81T1czS28wVGdSUEhXc2lsRTJy?=
 =?utf-8?B?ZSs0bFpUVVpYa05WWVB1RlBpeDh2NFBhLzU2WHp2LzBOMnI5QzhvOHl3TEN5?=
 =?utf-8?B?T2MweWVRK2ZadTUxdk5mVGpKYW5iRlJmMSt3TCtvcng3UlNPSmxvS1dqMndx?=
 =?utf-8?B?cGUzYTJtN3ovYkZoeGMycWt6N3IzS0sxYUIzNmNSdzdQRS9vTTJWNDA1eFRZ?=
 =?utf-8?Q?FqrdBpZWSdQVEvHCbFgBfRGUZAID0zmKeXoBZpu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlVkT0tvSHZWUjZDbTh1anVQeWdNTkFBVm5udzEyQ3RITG5qVXNOVnA0Tmlk?=
 =?utf-8?B?Q1dMbzROK0p3YmYyQUZkd3h4c0dMVFZ0OFFUZS9jS3VTUFFtaDduRlZaOHpE?=
 =?utf-8?B?dFlDeE0zU1RqWVhSaldReDdacWZLSlNtZ1cxSkRUbTNKMXowdURFeDFnMlZn?=
 =?utf-8?B?S2E4Q2I1NTBnSlBQM1N0TkozTnRqYnNZT0NCSVhlWWt1SzNlYUZqWEd4UC8y?=
 =?utf-8?B?ZEFwSE9HQUUwZ2p5UTRNODIwbC90Mk5xS0JrOXZSaURPTE10cmMrOTFHbk5x?=
 =?utf-8?B?cUlYQzdNT1hOOUZ1aFVvelAyNHk3OFZnNVVTa3VLd09yZ1lORFVMTkI3OHBt?=
 =?utf-8?B?N3F3UEQ3aUhpeENJbW03cVJTaXZHYjJZOUxxODB2bEFDdDVtTEdpR3VVbVJl?=
 =?utf-8?B?ckdyM1ZhWm9weVhZME1BS3NRR3V3czFwdUF0K0RuZElkeGM3TEtmeEIwdTlX?=
 =?utf-8?B?MHZNUmEralhraGEyaWpNTUlSSWNRUlRNRE1VQm1MZ0ZvYy9uMGZIZ2RxUThP?=
 =?utf-8?B?aGNFa1NFYXI2Wk1jWW50aS9aMHR6Nzk0S0tySm41MUo3d0RLWlo0TWhDWUlm?=
 =?utf-8?B?MEgxZ0xPNkNWc1ZyU0lOMVorUGtva1VIenY0MjFNakd3ZmhLNjZIaU4wS1RM?=
 =?utf-8?B?NHdGOE9CbUFtbTZxTy81cjA0QzdFd2pFMjJHMGVmcVhKaUM4c3lTMWxLekRr?=
 =?utf-8?B?bEEvQWFHeGVxWVErWWpTcXE3Yk10UEM4YXBNT0lCeTJXeWI4VHJwNE5Vcklm?=
 =?utf-8?B?aE5aYllicHk1OGJyODNoVThYbnBHOTVFY2Q5ZzFHSkRrcEdDbmQzaFUvRkJG?=
 =?utf-8?B?cVhPS3RvM2VQeW1wSXlOODVaQldXZXg1MU0xblJrdVlEQ1NaSmhGcUxmdVdK?=
 =?utf-8?B?V3FaU0NTR0NBTGwvaXlvNDZoSDlwc3pEOFB3Sk5yNEVnYUdMUEVaMkliY1A4?=
 =?utf-8?B?VWViYnluTVBGZWxHMGdFQVR3QWg3WEFqNXMrN0k4V016QVUrN0pYaVZ5bG8w?=
 =?utf-8?B?SWNyV0lQaFk5czJHaUZ1VCtnOVpWWTRTd05VOElIYW95bCswN0wvMkFDZy9i?=
 =?utf-8?B?Z0hhZU80Q0tCbXBJaVNHUHFZc1BIblRDR3JkSHliUm5KRzIzRGliYW1SVnhz?=
 =?utf-8?B?VEFFUUo1TkpHeUgvaDNwbTlPNnExOHhYZm4rakUwZ2dJUTBFRVZMRHN4a0Yw?=
 =?utf-8?B?eEdpdTNLbmhqTVNOTVd2MldNQ2FYNFl3SlV4Sy9sLzhDVGI5VEV2Q09qVC9k?=
 =?utf-8?B?UVJnMG9Id29lUnZUY1FHN3pObGZvYVhORS9EOWhld1RIYWVmbW5ZOTF4SGh1?=
 =?utf-8?B?THpOa2xZdnNCM3greVlaQjVseXl0L2FDcHNsTEJFN2FrSTl0TEs4MWFaa1RX?=
 =?utf-8?B?NzF3ZnE2YTFrSDJmSlRtTzg1S2hUNkFjRE1UYkZaUkpjcUF6cXByVE9nWUVl?=
 =?utf-8?B?UGRhRDcyTHNyeG4vZmZtR1AxVmI3RGJtSFBhejJMaWdQRmk4aXhadjJzNnRn?=
 =?utf-8?B?UEhEenZwWVNQVlJsVVlzWXJlc25GUnI4ck1TUUFrZlB6WHRzSzJkL3I1UWhT?=
 =?utf-8?B?UDhIVHVpZllaWGljaG5CNWJpT0xyenlnNGRnYVhFTysyMjY3aGM0dUg3RmJq?=
 =?utf-8?B?SnZFd2FXZ3VUWWQ5Rnp2Y3dPUmYxRFgvZE52ZWZ1OEROTTFzM3ZkSkVHbTVy?=
 =?utf-8?B?M1ZmV0h1dDhKeWpRS085UlhyQ2I2OVB0L2MwVGZWY1NwMUJSTDVlRnhIRW5O?=
 =?utf-8?B?MDFWeVdRU0xrZG9Zd3JUWDFmZmVqWEtndkp0K3oxVGlXY1JBMzhWU2xLTUNa?=
 =?utf-8?B?V0lFYW5CS0VyTGdKK0R1czJ3clNPQ28wbmJKL2RPYWM3YmkySC9FcEQyaWw2?=
 =?utf-8?B?a0xRcU14Wk5pMGI4UHVXT0tSalo3dnY5YjRxekRMc2ZYaklyanlZcnAxY0ht?=
 =?utf-8?B?SWd3dUxNVFQwTlVkNVJEM2MxMkpzL2syYWFST2NwRWFOZ0IrS3VGUDQ4UWxu?=
 =?utf-8?B?WXJOaS9Pc2ZzNXd0TU1Icm52bmZDNlg1bmlRY2Q1UnRTWUE5Vm1XNE5QYmRn?=
 =?utf-8?B?L0YxYUltbnNEUlZtRy9ab3ltbkw0QWtYSlprVFJLT0hnVUtndVhDVUc0YlBV?=
 =?utf-8?B?UHFaY2J3VC9NYWRuelExUFFKTERuQ0o0ZXFJVFYrUUg4MEM2Vmc5OWdkUVYx?=
 =?utf-8?B?STFMSCswL2JVYzQ4c24rNUt6bzFyRUltcFBtelk0Z0xwa1ZaTWdlN2pzSnd4?=
 =?utf-8?B?UXFJRFlZd2krTjhXejJWbytoWk93PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nG4pEt8Ol++XGBpL6IFHaZGT79hJeS/ZNV/Epig6snF/401H8svzBbLhi5J5D1Xh6h9nfEHPZx6/+rikCWzpYpcJYrXu1Wwqv0pNQMOVm9qrmdolaXLAcMPAfDJHlcUkJlv79EZmf6GD7EgjC6CrIDgbnX2cfA49vAMVFMSw6NwYHAO5noy/8W1Lu0N/6Di7lnV5bUZNIG2K53FCQ0aSCrPbelocSnC3xxL5F0077UP0oKAhaT03rFj6RcnGirznSK8GMH5XPFKa0J3Nn8Yt6C2M2RHbIsxK74IQGb5i81l+HdfH8IsNZS2RcjR8WtquBLJ+/zj8B46f39wDIzb7nOmXBDoNjkEAAfHePhfUspt4yP+/ytmYxuU5U1l+An++jIgIaECLnrvclIDdmL0DlWC7KEYzx2WTFhv1fOrswEMO/OUi+eIhtY4yrYcDI9axAsUEBDpB12cWG3nx1tmzKP6i8k1enQowyFk7vv1ejYG9RYFpxHGlTJkfXXHCE7bcJ9Fn6sYdR9kTYbbD3HG8kJ4c/aQJ5MA1cyWSmntlX12d/jDLPpfV86AhJwwbp7f0taSA3KDSzkOlYMExeBiIKyaI9z+WwuoMaoCBknk5Wdw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d693a4da-2510-46f0-8e8f-08dcf3839ad5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:56:14.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7E7r9Xkflym1Am1vFSM66CY7TbTxK5wmk8flEHbu2ZOG7HWgwOYJ7Fauhpz83eLnw1xQOa/Xo4nNnrH7Y9nLC3EVjAOPzpZs5cPOXtb8O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230105
X-Proofpoint-GUID: 9xqMOx9Jb-S7QIYABC2mtlksXWOgRoHI
X-Proofpoint-ORIG-GUID: 9xqMOx9Jb-S7QIYABC2mtlksXWOgRoHI

On Tue, Oct 22, 2024 at 11:14:58PM +0200, Jann Horn wrote:
> On Tue, Oct 22, 2024 at 10:41 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > After an attempted mmap() fails, we are no longer in a situation where we
> > can safely interact with VMA hooks. This is currently not enforced, meaning
> > that we need complicated handling to ensure we do not incorrectly call
> > these hooks.
> >
> > We can avoid the whole issue by treating the VMA as suspect the moment that
> > the file->f_ops->mmap() function reports an error by replacing whatever VMA
> > operations were installed with a dummy empty set of VMA operations.
> >
> > We do so through a new helper function internal to mm - mmap_file() - which
> > is both more logically named than the existing call_mmap() function and
> > correctly isolates handling of the vm_op reassignment to mm.
> >
> > All the existing invocations of call_mmap() outside of mm are ultimately
> > nested within the call_mmap() from mm, which we now replace.
> >
> > It is therefore safe to leave call_mmap() in place as a convenience
> > function (and to avoid churn). The invokers are:
> >
> >      ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
> >     coda_file_operations -> mmap -> coda_file_mmap()
> >      shm_file_operations -> shm_mmap()
> > shm_file_operations_huge -> shm_mmap()
> >             dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
> >                             -> i915_gem_dmabuf_mmap()
> >
> > None of these callers interact with vm_ops or mappings in a problematic way
> > on error, quickly exiting out.
> >
> > Reported-by: Jann Horn <jannh@google.com>
> > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
>
> (I guess the "Fixes" tag here is a little unconventional in that it
> doesn't actually point at the commit introducing the issue that this
> commit describes, but it does mark to where the fix should be
> backported, so I guess it makes sense and I don't have any better
> suggestion.)

Yeah it's unfortunate but I think the only thing we can do here.

>
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Jann Horn <jannh@google.com>

Thanks!


Return-Path: <linux-kernel+bounces-409908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B9A9C932C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F423B28800
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5046E1AB503;
	Thu, 14 Nov 2024 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hm12ye4Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i3bj9x3/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B718C930;
	Thu, 14 Nov 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615886; cv=fail; b=t5TisyXKayRp6oHHJGhc/1Ay4tFHcskNxHWte9JzVs2jPXPj15970+E3gHKfEZkH/uZAjjAOx13ft+cgwbiJ0nJMuuIp80bigdudgZ3qUmP43s5CUoInJ/g6gJzKwcnLmSuPvQ++N3PcgZj1ZszrEU2EdstHmXEgA0nb9nLHFqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615886; c=relaxed/simple;
	bh=wGYuTN9kgnxd+KMEiPx6I25FJ5nhETpuF+5mKJub72Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CJTb2lTksumPGvFL5zmX+k4ywkBqfAQcsxPhUiP1W1yVZl8mErVQ+IYKCyAWUYW37S5N8CgqGVg2rFQvsnxNBBmnDv+OFIGByG7Xc2gbsxhcAGm0g7RHfnIlzcYRvYOTxOWsH/B8ikFZX7ozMRbq2gRnhT9pHDMdL6mSQTXXSiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hm12ye4Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i3bj9x3/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEJgWb7009703;
	Thu, 14 Nov 2024 20:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RdnRdpDThHngQ787Ie/8TbQL/dY5vUUS8dwwtQsuVp0=; b=
	Hm12ye4Z7GVCG/bipxKYpZxA0CIF5XONFttbZqbawyGWARCa/v2pr9Z6PAUl4zzI
	xsgQp/g0cVns288JQyg94fd3JzR/2AKo/L7qShdBR5IShXnqU4LJ/zGADNRS2IIt
	f1Al4XzwxqZ6+rtmQJuREpZzgx2lS/7nxVAUXkmEuxdO24wDnBeX+Nx//n0it4eI
	aNFLiBP6gOhwWhQhetVywio2zg1uNiU40/URDsEmyU0p/Awd3c5D94Tweh1DMhh9
	JDFP/qRYrfuKPgnnsulNPQ3xpgevVjdscDlGkzWuJpEPdReEkvbkrH1VRgQVSOb9
	lp9vX3A13fUypGSlRzlAbg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc27nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 20:24:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEJU31N025888;
	Thu, 14 Nov 2024 20:24:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bbann-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 20:24:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAEPySPYBmXmlgQZVN6hhRsgqgHKJB/yyotOwMEFw2eVJwCaDaeSBKyl9zkO11M1rKLRCTez2FBdr3ThO7PATrkxvSQedplmtNmJuDVNDalouWLp7cro2Zqi0Rk7VyMDkJiEgKWDG4ZERXI7WrQ79fOaXR2dlm73dzGsxg0N15Y2QbsjPGd/ryJ16+OhSVav+Xk8p3DGOPlq56S8zpbtkWCMNOuORIOH6+j3kKK9N1z139W6pjKNkD+iaxmnWVLvohahbffKQnhq08fDsLKtYu24NHQnd4CuN5FQo4uxsb6QwOkNd4DwRXdPE19WVm6BSw1wljl275w6QYdmk02m7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdnRdpDThHngQ787Ie/8TbQL/dY5vUUS8dwwtQsuVp0=;
 b=qxTGxYG574Z6tifiaeNsz9FIDKbhRodgVLehbGBXA2E7R6EAop4gsNlPDAudcXAF1pa0wT2VODBNkHd06kNcUG/p8N+oYJlyohv4ruFREyIssIpNFojbPnW4LtQnSB9T0IQE969xPN8l6965sP4HliunYTm29tGk+LZUAYh5WwvQA4KxeqNouii0XOBxhHSb2rdKZWrB9KebQP2ZszW2EpTQicl2f5VRChAdA6jq0F5U1Dttt7yO5EaFKh3WvLZ1wnrHHPpHDFRHN/bFAe3mBagLKZTdyqEDcMM3lcAg7sb4hcv59c3AAW+xcrdSubBd5Lx3V0s3U9Z6O0xP+gVAMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdnRdpDThHngQ787Ie/8TbQL/dY5vUUS8dwwtQsuVp0=;
 b=i3bj9x3/HjVwTG4DE/JdAHJuEP637wJxDvqeJwX9D9YbNYDYySIGN320naXWCGlp3Yl26VBENatwel3gTe+FHVyvhuzDKlnTIdXU2sz47gtXwPo5RjQyAHb8r+HwsJZ8hotOrNPehajkdksAhiNWfdtqBrm6yMs/5fX7KCWL4dA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 20:23:56 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 20:23:56 +0000
Date: Thu, 14 Nov 2024 20:23:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] docs/mm: add VMA locks documentation
Message-ID: <d770b94d-eded-48a4-9d9f-063704e91139@lucifer.local>
References: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
 <CAG48ez2=oP15_X_MqtDG22P6TZYpTr07-TZBk3Z_DvuwB6nJFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2=oP15_X_MqtDG22P6TZYpTr07-TZBk3Z_DvuwB6nJFQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0431.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: b6af69d6-ed91-49ce-bcae-08dd04ea4352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzJyaFNpdnVFbUsxRkpDTWQzQk1NcFpJWm9oeU1ROTBDRC9YSEFBeXJOKy84?=
 =?utf-8?B?b0V6UHFNckRqRG82bVdRdE1iaWRTNUxJOUFGcElpU3V5c0xySGpsOFV2TDNO?=
 =?utf-8?B?dHhrZzVQNlpmTFQwcVhsRWh2aUtlOG1sSkhKek9BWEovMVlIOHU1ditIRnYz?=
 =?utf-8?B?ejAydjIvRXVScUgycWFxMm9VSFpFWHh0MFJMQ1VYZXhsOW91S2daNDNNdUty?=
 =?utf-8?B?elFZeHd2M0xhZHdWVkR1dnpXNXRRNTE4MnZGZHR1UDg1TG8yRStKeGJFUHFn?=
 =?utf-8?B?VmtHMVRFVnRMRUtiYmhXbERQWGxKcy93d1g4MzJhRDR0SzYvbjRRbDQzRHk5?=
 =?utf-8?B?cDBFU1loL0pRcURYaFNsUThhcU9zUU1odThLYVpMbVkrYXhTRWhkWENPNS96?=
 =?utf-8?B?Y0pQK3BuT21uV3ZpQkQyYmp4c2RoRStlbFBGZElTLzI2c1VBTXQ2QVQ2MTVW?=
 =?utf-8?B?NnY3YnJhcFIrQ0dFVVpyazBFaTMzdjdOUFlpT0k4UjllRDVQcmhBd0Y5NUhL?=
 =?utf-8?B?OTQvNHJpQjdHWXJza1EzaVRYVzB1dTR4ckpzMmlyak02ZTVXdEMwZmYweG1D?=
 =?utf-8?B?c0NZK0hCSWxwNW9Ya2NpKzhKU3Z4M3B1YjRkaWJuNWhxMDhRekRDQmVHM1hI?=
 =?utf-8?B?cGhCOWlQSmhUMDRVVWpNcnBuT0dZVUZJbnRFdGExTzFSMFNkZG5XYjJ1b2Uz?=
 =?utf-8?B?aXBqTjFwamtqZSt3Vm82VGhtbnBJK2hzNmg5WEMvNlErYWdSTzdidlhGUmpG?=
 =?utf-8?B?QytYd1ZIV3QxUnVWNmNBQm1TRWgxYzVINGpKWDhVWFc5RmplUUw0ekRHYi9V?=
 =?utf-8?B?dkIrK1dmZWpzOTkwdm9MUmg1dVozazZ0ZmU2a3VGSExaTUdWemhrdktlanlR?=
 =?utf-8?B?SndzYTE2MWJuUVpiVWd5SVFFUm1ZRjlzMThtdjVLeFFJTnVxaUJxeldhd0cw?=
 =?utf-8?B?V2g4eFVQR0RKYWlFTkRjdS9ucGltZjRVUitKWkFDKzkzamdDdURVc0dsMEg0?=
 =?utf-8?B?K0VGZkNGN3ZiWGp1a0lib1ltWDRzK2NyblFZa1RsRDc0T0Vncm5XczhMREQy?=
 =?utf-8?B?RjZOT3NQVWdNUVNoRWttMTNVRUVsTXdoZDY0K0NaQ21yZUVURWsxdERRNjUx?=
 =?utf-8?B?eFZDTm5KVkFtMkpCSGFCU0tXVEtQTzVpbmRGcFl5bTdyODNEZlBudkRVSUgx?=
 =?utf-8?B?T0t5MENYUjRaLzNFaTNIY1p6MjIrUGFtM3cyZGpma0VrdDF5Qzdmank4SGRq?=
 =?utf-8?B?OURWMTE5SWdibGw1TkZjdnkrQzNDMk9Dd2ovZWxqVktuZDdkbnY3UjR2eHJU?=
 =?utf-8?B?V0kwYzZtLzhHbkVlOFJsQ2FpdXRKZDdzSlpZRTJuSmwvTWpJbFowV1JFcmhl?=
 =?utf-8?B?VitJaW5TNVRyQ0NuNVBEUU9kYTRlcnRFSnpQMjZjYVNHcGN1Yis1UGsxYWZ6?=
 =?utf-8?B?OW0zTHNhaXpTMGd0ZlkzczYrRWpUV1dtTWxHdlpnQXdNQnlLc0xrT0pzNGl0?=
 =?utf-8?B?OW42cTB6MkRqcXBXNEw0M0l6VFpGclVPNnlxMk42WTN3bFQxcjNUWnZOUU9r?=
 =?utf-8?B?MEJZR0NjWWNuS1pRU2xtRnhjUTFVUnp0VjBXMlFYZUhvckRQbjFhR3dvSEpn?=
 =?utf-8?B?Rkt3VmdydG9LdkthVFZ4WkliVGszY0R0YlhXWEVZSTc1ZWZ2VXF3ZEM1NWlx?=
 =?utf-8?B?bG1uWlREcnVjbXNpSVF3cUhYcjZ2b2NuTVVXS0FmUCtNbVZERGxnOFcrWjg1?=
 =?utf-8?Q?0GPxfG9Q13AAIMl0Bc0hJ/EYK6VqJeOhwj/XkCQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MS9sTnQraDI3bzJsRkc0anFFcm9reE5SQytqKzFGNkZyRXpFWTZ3S3h3OTNn?=
 =?utf-8?B?NjRESVFBZ3czbzFqK1JtN0RuYVMvblJZMkNkU0I1OHc3RDY4WnIxMTBndC9N?=
 =?utf-8?B?aDNKcEZhR1JsbVQzSzBkYmp2TjRwT2ZZUnoyVGh1bXNTcjEzTGNVYTVRaTN0?=
 =?utf-8?B?ZFhRVnVuMlhFdDQzNCtCM29OOVM4dFpERFhIcC9BTzJmVmVrVkNwenRSZFo1?=
 =?utf-8?B?cjZtUGozbjBTZXAvamh5YTM3UE1Ea0VETkw1K0dxZWZoNVF5RUVMd0Q2Mldo?=
 =?utf-8?B?T0pVUURIUnJ4czJseitOVXkxc1RCWWdJSnFwall5K3V3WklLK3NkTnlhaDFX?=
 =?utf-8?B?RDhUYmxhZVFoaFBmL0dUajdWTS9MaEJkcEt1dDk0VXg0UUxmUVBKMnBkN25V?=
 =?utf-8?B?VmNLL0V5MlQvdXZwR0ZTc1Q0QVAwK1YrcFRBVEsxcHFZMVMyMDNYVWtHTFVP?=
 =?utf-8?B?eHp3c3lIUmVibUVXYTBLam1MMk1sbEoycHNVbFlxRjhHMVFYR0tZMHpPbkto?=
 =?utf-8?B?Y2tlV09DeWllRE1vYjgwUnYwT2VieXlGek9jSXE4eHZZclVFTFpOT21ySGk5?=
 =?utf-8?B?OWUxSUxPa1E5ZWtDeXNyQm1qMFVWM1RTeEJCajVvTXVvM3hWbzB2czI3S2lq?=
 =?utf-8?B?ZktRSWwvc2ZRYXlLTW9UeUFvU0VtZGZ4YjZiQm5Sa05qYjJRRC9tZDJKOEdS?=
 =?utf-8?B?aElNSVhlSGNnWE15Y3kzYzhkWkxXM3gwYVhaUDByVUFaL0hvT2I5R285NUNE?=
 =?utf-8?B?VHpoektvT3FUOUphckxFMER2S2VkYXJCQWMzVkQzRUFnWFZHUGdmTVU2Wm5J?=
 =?utf-8?B?ZWxXQXp4SVhZK2JYLzlVcUgrd3R2MTd6TkFLdCtRWVNtZnh2QThSQzR2UFVW?=
 =?utf-8?B?OXVZbDBkdW9RUEJZMXhBUEFUamdTV0h3SVNtWFJxQ1d5UXRqYWtRQlU3K0tu?=
 =?utf-8?B?bllnNGxRVkttREJobDNOb2wvZGtjS0pHcWkwK1F0d3YwUDdNVCtseWx1YkF0?=
 =?utf-8?B?dW5qZG54L2Nrc25tZGQ0QUxJa1BDRGZIcHZhQVMzbGt0MUwzeENRWGk1MHhr?=
 =?utf-8?B?TnZZR2VCTzNKVC9Zc0taK0tIOEJ2dVgzZHN3R05Mcm1ja3kvSmoxR1R6TEZt?=
 =?utf-8?B?NjNGVk1vWXZ0ZG1ubkgrajcyak9kK0ZIdHhPd0l5Y0hZV0NPM3VTUEdCb3NP?=
 =?utf-8?B?VkpITUR1MTM1NlF0YkpOZGVlWW03SGNlbG1GV2NoTWNObTdWaUtvblZsTGg5?=
 =?utf-8?B?NTIzeFAyMFgvMEhyRzUyMEowbE9WRmJiSm1abk5xZm53cUc5UkNPV3M1cFFw?=
 =?utf-8?B?czd6Z2hmbnVId01xM3EvOGl1MDZKVDUyZkUxMXlJNkNGOElDbCsyRE02SnZC?=
 =?utf-8?B?U1N4ZHdqbXdhK3pVU1VOQWdsVzFZQzk1U3BqYzZVYUlwQzQ2T0FEYlQ5Q3Nt?=
 =?utf-8?B?UW5rR3A5UTlIR3U2TFdCK0JmMXhscGplcnFyNlUrYkxzamQ5bkRKNkVNVXdo?=
 =?utf-8?B?ZVB0czNCMlhvV0p1WG1JZlBWdHdQcjVtMkRqWjdDKzZ6cXJYVVZ2VXFYMzMz?=
 =?utf-8?B?UjNwNzVxd2pqSHpDaGtrTXFjbi9LSGR3dU1sRTgvL1lsRnk2QlVsVUM5UDc4?=
 =?utf-8?B?SDBtL2hxeXFxcFRwNkswakh1dERtQXNrTU10Q3R6WUphTDF3VFVsVmpqWitw?=
 =?utf-8?B?a2RyY3RHWXNXck9OVlNpYjkzeXE1V0JMUGJSN3VHemI1aytYdjlFeklNbzk1?=
 =?utf-8?B?NW0xSHhXQ05KUFVLbVZrZ0lLNU5uc01Hbm5ZbnZFaC9IQnhycnVoU0FBWFlt?=
 =?utf-8?B?bVB1SXUrZUYrZnV4VTdIRFBCdnI3VVhrYnNTeXBFaXJWTFNLWEVkVWFUY2tk?=
 =?utf-8?B?dmNwU1l2d1dNbm9yK3ljK0tzaVEvdHNtaUhvSHRHejRQLzFrYlJreWN5aUhr?=
 =?utf-8?B?SVR4UWdmaEt2bFdGcW1sUVo1MG12Q0ZkbHhqbHdDWDNyblVlUjNHTDM4c1RN?=
 =?utf-8?B?QWlvZnhuM2R0dzhGbzFEOWRFSHJLeE0vcmdyQUZpb0FyeHc0MGQwN253ZXo4?=
 =?utf-8?B?akZaVi8xR0o1VHVJT2lVR0xoTW12Qm80MHhsT0RaNFpYb2luYkk1L1RFcFpG?=
 =?utf-8?B?dS8ybzVLem9jZ0VPVXJPeTdna2JnV2p1T3VzU2l0NkMvbzBoM2k1eDJKWHdG?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6VcBhGBG9dNM9h8fn0fQRRXEq0fZbNtjvHiB53WwdnbnsKem2Gd/l/1ilvBGD2y6v+rCtC1WQB2k5ROZoalzos8/iEdkmN8bIZsFfClrTy8+A+l77OWptqDg6MYNKkDGMZaXcqvZEkD/EhR1oEj/+IW/ASHFEOFa0XTIbtWmyOctGL+6JxktxqJbaNje5av+Pm7VsYybkXj7kVP6Bq3F8MMFwAJi2jEHXYS2U+3dGnR9BJk7j7AV0hFGUAiALx8Cli8KCdXdkvbFvqASpwl0OJY4oag7JMtlPz991t9kT3pToWEYVRHgYhmQ55LOoeKv0OlFVzJomVE4cvU4bA+12MFEFTwOiCz9glgBzg9fnPBYOPXmcz0pK1dViFXabU0Jq1nsQQUJwiY5pY0YdeRQVFjcrnChqcmXeUcf0xxd65N+6uqVcZ38vjxASieKKkuq9fV0AMYZA+Q7OL4PgGL0UL4tZAXD85jrMZUOo0f6yOf1RkAtFqwUAmFqEPDP594S4Ng4LOK9pTQG6pb1UzO5MASIaMwnpQYCsgT3+SYz5OM7XNsb2W+3WXs37Y0vg3D1OeoxrOc2vwHbaM1Z1s2TX6Bzpkqqbf/QbLhtWm+0KPE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6af69d6-ed91-49ce-bcae-08dd04ea4352
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 20:23:55.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyQPISMUVoXpNFhJqvnAAUY3y1uttjVK0SFft/ntI/1JTP7ONRZba86mp+/XJXu1W/7JGA6rxoALa2MmsTnlulN54SJCk9HlTplGb5+7Fks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140160
X-Proofpoint-GUID: sXlKLAMMxqW-WY3ZkuXgZEYBVtK5f_Hw
X-Proofpoint-ORIG-GUID: sXlKLAMMxqW-WY3ZkuXgZEYBVtK5f_Hw

On Wed, Nov 13, 2024 at 08:46:39PM +0100, Jann Horn wrote:
> On Fri, Nov 8, 2024 at 2:57 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > Locking around VMAs is complicated and confusing. While we have a number of
> > disparate comments scattered around the place, we seem to be reaching a
> > level of complexity that justifies a serious effort at clearly documenting
> > how locks are expected to be used when it comes to interacting with
> > mm_struct and vm_area_struct objects.
> >
> > This is especially pertinent as regards the efforts to find sensible
> > abstractions for these fundamental objects in kernel rust code whose
> > compiler strictly requires some means of expressing these rules (and
> > through this expression, self-document these requirements as well as
> > enforce them).
> >
> > The document limits scope to mmap and VMA locks and those that are
> > immediately adjacent and relevant to them - so additionally covers page
> > table locking as this is so very closely tied to VMA operations (and relies
> > upon us handling these correctly).
> >
> > The document tries to cover some of the nastier and more confusing edge
> > cases and concerns especially around lock ordering and page table teardown.
> >
> > The document is split between generally useful information for users of mm
> > interfaces, and separately a section intended for mm kernel developers
> > providing a discussion around internal implementation details.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Jann Horn <jannh@google.com>

Thanks! Will do a quick respin to fixup what you raised (+ pull in the fix-patch
there too obv.)

>
> except some typos and one inaccuracy:
>
> > +* **mmap locks** - Each MM has a read/write semaphore :c:member:`!mmap_lock`
> > +  which locks at a process address space granularity which can be acquired via
> > +  :c:func:`!mmap_read_lock`, :c:func:`!mmap_write_lock` and variants.
> > +* **VMA locks** - The VMA lock is at VMA granularity (of course) which behaves
> > +  as a read/write semaphore in practice. A VMA read lock is obtained via
> > +  :c:func:`!lock_vma_under_rcu` (and unlocked via :c:func:`!vma_end_read`) and a
> > +  write lock via :c:func:`!vma_start_write` (all VMA write locks are unlocked
> > +  automatically when the mmap write lock is released). To take a VMA write lock
> > +  you **must** have already acquired an :c:func:`!mmap_write_lock`.
> > +* **rmap locks** - When trying to access VMAs through the reverse mapping via a
> > +  :c:struct:`!struct address_space` or :c:struct:`!struct anon_vma` object
> > +  (reachable from a folio via :c:member:`!folio->mapping`) VMAs must be stabilised via
>
> missing dot between sentences?

Ack

>
> > +These fields describes the size, start and end of the VMA, and as such cannot be
> > +modified without first being hidden from the reverse mapping since these fields
> > +are used to locate VMAs within the reverse mapping interval trees.
>
> still a typo here, "these fields describes"

This is how we speak in Devon ;) will fix (the typo that is, not my
Devonshire dialect).

>
> > +.. note:: In instances where the architecture supports fewer page tables than
> > +         five the kernel cleverly 'folds' page table levels, that is stubbing
> > +         out functions related to the skipped levels. This allows us to
> > +         conceptually act is if there were always five levels, even if the
>
> typo: s/is if/as if/

Ack fixed.

>
> > +1. **Traversing** page tables - Simply reading page tables in order to traverse
> > +   them. This only requires that the VMA is kept stable, so a lock which
> > +   establishes this suffices for traversal (there are also lockless variants
> > +   which eliminate even this requirement, such as :c:func:`!gup_fast`).
> > +2. **Installing** page table mappings - Whether creating a new mapping or
> > +   modifying an existing one. This requires that the VMA is kept stable via an
> > +   mmap or VMA lock (explicitly not rmap locks).
>
> Arguably clearing A/D bits through the rmap, and switching PTEs
> between present entries and migration entries, counts as "modifying an
> existing one", but the locking for that is like for zapping/unmapping
> (both page_idle_clear_pte_refs and try_to_migrate go through the
> rmap). So "modifying an existing one" either needs more caveats or
> more likely should just be moved to point three.

Yeah I think this is a terminology thing, maybe better to say modifying which
changes _identity_.

I don't think it's right to classify these as zapping. Better to just put a
separate note underneath about this.

Hopefully that should suffice to keep things comprehensible here :)

>
> > +3. **Zapping/unmapping** page table entries - This is what the kernel calls
> > +   clearing page table mappings at the leaf level only, whilst leaving all page
> > +   tables in place. This is a very common operation in the kernel performed on
> > +   file truncation, the :c:macro:`!MADV_DONTNEED` operation via
> > +   :c:func:`!madvise`, and others. This is performed by a number of functions
> > +   including :c:func:`!unmap_mapping_range` and :c:func:`!unmap_mapping_pages`
> > +   among others. The VMA need only be kept stable for this operation.
> > +4. **Freeing** page tables - When finally the kernel removes page tables from a
> > +   userland process (typically via :c:func:`!free_pgtables`) extreme care must
> > +   be taken to ensure this is done safely, as this logic finally frees all page
> > +   tables in the specified range, ignoring existing leaf entries (it assumes the
> > +   caller has both zapped the range and prevented any further faults or
> > +   modifications within it).
> > +
> > +**Traversing** and **zapping** ranges can be performed holding any one of the
> > +locks described in the terminology section above - that is the mmap lock, the
> > +VMA lock or either of the reverse mapping locks.
> > +
> > +That is - as long as you keep the relevant VMA **stable** - you are good to go
> > +ahead and perform these operations on page tables (though internally, kernel
> > +operations that perform writes also acquire internal page table locks to
> > +serialise - see the page table implementation detail section for more details).
> > +
> > +When **installing** page table entries, the mmap or VMA lock mut be held to keep
>
> typo: "must be held"

Ack.

>
> > +When performing a page table traversal and keeping the VMA stable, whether a
> > +read must be performed once and only once or not depends on the architecture
> > +(for instance x86-64 does not require any special precautions).
>
> Nitpick: In theory that'd still be a data race with other threads
> concurrently installing page tables, though in practice compilers
> don't seem to do anything bad with stuff like that.

There's nothing to prevent anything at all... presumably there's some
characteristic of x86-64 that makes all this _somehow_ ok. Maybe somethinmg
to expand on in future.

>
> > +A typical pattern taken when traversing page table entries to install a new
> > +mapping is to optimistically determine whether the page table entry in the table
> > +above is empty, if so, only then acquiring the page table lock and checking
> > +again to see if it was allocated underneath is.
>
> s/ is// ?

s/is/us/ :>) fixed.

>
> > +This is why :c:func:`!__pte_offset_map_lock` locklessly retrieves the PMD entry
> > +for the PTE, carefully checking it is as expected, before acquiring the
> > +PTE-specific lock, and then *again* checking that the PMD lock is as expected.
>
> s/PMD lock is/PMD entry is/ ?

ack, fixed.

>
> > +In these instances, it is required that **all** locks are taken, that is
> > +the mmap lock, the VMA lock and the relevant rmap lock.
>
> s/rmap lock/rmap locks/

Hm... you mean ref: the MAP_PRIVATE weirdness meaning we might need
two. Sigh.

I _hate_ anon_vma's. I may do something about them.

But also ack, fixing.

>
> > +VMA read locking is entirely optimistic - if the lock is contended or a competing
> > +write has started, then we do not obtain a read lock.
> > +
> > +A VMA **read** lock is obtained by :c:func:`!lock_vma_under_rcu` function, which
>
> "is obtained by lock_vma_under_rcu function" sounds weird, maybe
> either "is obtained by lock_vma_under_rcu" or "is obtained by the
> lock_vma_under_rcu function"?

Ack agreed, will fix.


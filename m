Return-Path: <linux-kernel+bounces-354146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5D7993850
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCCEB22A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472B71DE4E1;
	Mon,  7 Oct 2024 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UV6fpSIE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r9/A0UMr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CA31D8E1F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333129; cv=fail; b=R/hoeQtMvrHoROzX8+s/rbQLTBKc1KiKyS+iaz+EjUtnhbUgAt94i96iZEfmWhte/tp5F29iMuc+83hAUx4wndub7/RXV5mLhdVHt19tmv/oKwgfl337gl/YNeIc9fRTw1MzKn77A9GsOX9lWPQS2KYcralVL7sBrrU/yWUxAJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333129; c=relaxed/simple;
	bh=+RYpv+5hTL0iqeJxWXf6weBQFdBC2EIXt9fIb6Daw7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BE+PscF7MUYZve/pFkpBHjQVb41DSCiEp3B3SrmlRLmZ1NuxSK6XCUCj4Gq8JOQY6ORQUmaCuzb0ihG7sA3JkkHkuA9MHhkzADz75nXop3qlnC99LGj4v/n7gxM0k6k5Ql8sA4eb3I1HvJ+/SVX5ZXntDOkLVOZWlvvAikmA+40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UV6fpSIE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r9/A0UMr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497K0aiI031796;
	Mon, 7 Oct 2024 20:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1eug25rFzkTJNt0YTu8eqTCv48DWIGkzSVvP0Z/NRME=; b=
	UV6fpSIEUeWV/xz0aEQ529WxQVclEle4VHOwxzPeskXOVCrM7zTGk4lhmOTw8wGw
	/OjN6sdPkB9S9vGwKSfK4oH8gjvP/+LGOQjLMf2QnWZQTcRFv6ux7B+cqnv9KYBP
	awK+dGe1Nbn/RjIWYlCZH1DPGMAXm6J8izQuK7VHZNlMLhcso7ps05G+eQ+oDAmQ
	4309SOHX+y6rT8ci0u0fCSSdT+HI5xyxjpljDaZ+qdMquvQWs9VfmfOhn9JljMbS
	TlJPMNZqQJXAfS8I5SAh3GZCS9YBWZDHvyc55etVrzFPNEU11+VgQSTumQyLws6h
	Q9mZeCeGUIdz+ebcPXzegg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306ecafh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 20:31:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497IfLNG012346;
	Mon, 7 Oct 2024 20:31:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw69xnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 20:31:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssJnr4EHpDdJG3NCXbLF/8cq/nQq4VnOkWc5HulSdZ8ObWJRi0jUNu2/oHLkFpGz5/zJm6oRsQaJUlZVV23t9g1834aNm183MUsym78/3V1Gj1HzpwtuZv85DQ8Snzo6Ahi7rdiHhdl/memq5T/ziFO+FnlpU9b8yz3Uns5PWJHMRO94lrnlfN5AmqoNLFd2Bz2nRCY0m2AVXIU87+vBapJrd+pKCyYGnuDphQ33oa0OCDe/dBgSU1Ny2vR1qQlGR+4bpBm9LWl6KO5CQBMNdAHRzzM5s5g5wYcDP4a2Z29BmieIchFJF2m4RBEA7FK9NJb9/Gm8JyvJLVfLGfjwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eug25rFzkTJNt0YTu8eqTCv48DWIGkzSVvP0Z/NRME=;
 b=psyMKng184AAu8cDjrVlSiUaICN1ynd2wy2MhH7P1Nt23eA9t3cSlYBySy/8ImEYqLqIvtrQS3br47zabS9UFbeVHRMDLXXw7xKRaxgYtSL5ojHeNyDT82hppjlYutyeiptU+DAnLt+i1FwvB5FU4ZLNYe+9QuYmUb5HmqwlDntP/hITQ3tc5yQmP0vyA5G3cfz+MqIiqNaNfFJhRBLuy0M56dFw9WcIIrFguuoab/AsUgcEdl96YN+54jn81DGOZvm/314l2teFUC/im2ZQ2zMHBemk21h360v+NMvectBgMenFKTLcwm8ylWenMrve0QlHEM8/+54Ae7UpPF0ZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eug25rFzkTJNt0YTu8eqTCv48DWIGkzSVvP0Z/NRME=;
 b=r9/A0UMrjLnZSWav0KdhZzAm5ds6H6FPUSuqnV4wyEZ2xnUYVuEs72Z3SpQd+9Nhc6QK3s5ak0uuaSQjkHmTM96O41Uzw0n3qYHqk+HM9LxUCOscJMt9tUZvmwAqQm/d0FrcdnVPqu4FnYddQXrllFNkZvbdN6CwOej31f/rQZA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4723.namprd10.prod.outlook.com (2603:10b6:303:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 20:31:33 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:31:33 +0000
Date: Mon, 7 Oct 2024 16:31:30 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>, Seth Jenkins <sethjenkins@google.com>
Subject: Re: [BUG] page table UAF, Re: [PATCH v8 14/21] mm/mmap: Avoid
 zeroing vma tree in mmap_region()
Message-ID: <wxvj55hptaogh2yxhhfftaomwzm6ifek5xu3uobbdsaabdmjll@t2ixdotfhaie>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Seth Jenkins <sethjenkins@google.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
 <20240830040101.822209-15-Liam.Howlett@oracle.com>
 <CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: bab7a2cb-31f5-4c7a-9163-08dce70f0838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1c5ZmtyTEYxWHVzOFV2Sm9Hc055YVJreTVCUkZYRUFDUndVREtQTHFKRXh3?=
 =?utf-8?B?ZWhKMTRMUUFKNXIwaG1sMmQzMTh3SG9UdkRlRGdaNUg1VHZUa3VOb1cxMnk0?=
 =?utf-8?B?cU1RV2pNdUd0b1FzSS9LY2R1ZjFPWEhWNDRGN3BkTmVEajZTUGRVQ0dHQ0RF?=
 =?utf-8?B?L0ZobWExaVdPbmREK2pKSEdEYzFPaHZzdU5PWW9TL1UvWVlVTmxsRmZJS01v?=
 =?utf-8?B?K2RMM1M1dmdOSWl0NGpEWlQ3bGNoZ0FzblFQZ2wxaXJiVWZEUlFIVGczaldN?=
 =?utf-8?B?ekxzRGRDRUdyVU4rdDFwRHdDNW9TN1ZOYUNaMkExU05tckxwYm1DdkRUWlhh?=
 =?utf-8?B?LzV0U1JqWXRNZ295NjlTRGgxdCtwcThUdlJ4bHcrYUpqRE56ZHpVajJwdmFa?=
 =?utf-8?B?QUtlNGhLWW5xalpRTkpKU0tZOHZmbXRmWkd1QytSNmpLSjd6ZkY3SjhmUDZn?=
 =?utf-8?B?ZXpMZUhuRGxFWWdXVktBc3VKYU1vQmJxNnRUUzJNVm1BZFpPMDIxQkhSeUpT?=
 =?utf-8?B?citJOVlCVzdhb0xMd3FhV2o5Vm5WUEc1REZVZHJWVk5ZV3pFYy9FTVk4MXBC?=
 =?utf-8?B?YVBZL2dRWTdESWQwRWhYUWxxbjRlbVNremNiY0dHYS9NN2RZVEFZcGczajdQ?=
 =?utf-8?B?Z29paTFaYVZEUFF3bFV1dUdVdVJaSkFSa0txVXNvSi9lN25rR1lSQjhiWnZ1?=
 =?utf-8?B?c296WGl1UXBYQVFKSU00QlpZbkZuU1NYRmRNeVdxVmVna1JJNHJRZFpOZFRm?=
 =?utf-8?B?c0lLSUVsYk5IUmhYVG4xYkdNWHBWaVMvdXVyV0w4NlNKeUM3a2FIWUY5QUV6?=
 =?utf-8?B?aFNRVHJ3R3RCWEd1UXRKRU5qa0dPL3VEWFZ2SHdnNE1YcEczMWRuOGg3SHhT?=
 =?utf-8?B?MXZLd2FqUmxKdE90aXU3dHZpMDluVGZGaS9kR3cwQ3l0TzgxQXZpZGhqY1Vi?=
 =?utf-8?B?Z1lSOCtWWTBTM0t2K0pYQXVIK0hPYlV4L0Z1eDYvVHZQRi9NUFRWaWtwM3hW?=
 =?utf-8?B?cU5EUStIZkMwTFpuWEx0VCtQYURUUTlEY3BsOGVTamFQenlZZjFIOTUyNTlw?=
 =?utf-8?B?aUFmZVB3aFVoMzVVcXZaZ2tFSXpLaUJ4M1lJSWJiZ0lkUXhIQzJ0SVE3bGRh?=
 =?utf-8?B?UEZHWmJ4bVpMSm53WURmbmFUb1ZubTlTODlqWWFZK290bDYyVTFpeDZ2MEli?=
 =?utf-8?B?eG9EcFhCbmNkaC9ReEp4cEFQVWRwYnE3b01SNHIzQUU1QStOYTB6bjNIT0k2?=
 =?utf-8?B?Z2tYdnZpZ2hwbVBmZzVtbnRxLzVsVEZCbXpjZ3NzajZ2NW4zVnZuTGxNbUV4?=
 =?utf-8?B?cllBdFAwZDFSUHlqN3hPNENOc3BCeTlMNlk1MEpXMkc3WmlOZDE3OTBXZ29h?=
 =?utf-8?B?b1llUUxtNG5jWFNPMWo2Mi9VbU8rWjNNZGs4UGJJREt1V2Y3Z25PVHRybnpV?=
 =?utf-8?B?STl3L1V1a1hCTHUwZ0dETlZTV2g5QVJmQ0pRM3JVVWhMMitDUmhROVVzTUFm?=
 =?utf-8?B?dWFHc0dCUW83akdkSzdhQ3h5WnZPSzM2OHdhK0lWTUNIU1czK3p4NUpjVS9G?=
 =?utf-8?B?bFNReXdUalRtOHRnUTcyOExnYnQ0N2FjMmloWkltejFRZEYxYW9BSWwwcXlP?=
 =?utf-8?B?aWZoam9XaHd1bnVRUC9JSDJqL3dsYnNKbjFxY093dnFYbTV0a1dCZTlXdmRD?=
 =?utf-8?B?enFSYk9Bb3YyUVZZR0xSVG5qM0VlcHJUUjR0dFRxejhmdkxJcGJBdHlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cCtGbHR1QTMvekZNY1JPdE9VOVozWSttelVvdzdkQVJCRlNXK3lCRG5PenI5?=
 =?utf-8?B?a0FNVXhuS2ZvOW9HTHpzVy9uK2lFbzlRN3dSdHJiTjNTbVhrOW9EeGhBU0Yr?=
 =?utf-8?B?SitzcWNpVXdndExZRWtDQTlCcGN2alZ2VTRKMkU4cmt2ZkhCNCt2ekliOUhZ?=
 =?utf-8?B?cmp4TjdaOWVySDBNZ0o3VHVFdFl5KzdRYkRRM1l3OVlsc1FFRFMxZ3RtbTNk?=
 =?utf-8?B?MzdRVy94UnoyS2g0aVUvVjV3a01GSkxCRHd5R2dZZVF3eWk1L2x2WVFJVmJY?=
 =?utf-8?B?YURWOWxmTXZUdUwyWThPQUR3MkoxNU1pZXBTc3g4cnliQUtseEsxckJTMHZU?=
 =?utf-8?B?Qk0zcFE1UFRoQkprdnVwRHFMK2FhK3NtRERYOTBjWHRMQ0FMM201eUJqRnFa?=
 =?utf-8?B?NElxcGJJVkoxUHUyQWVKUk5vUUpXSnZINnhyeWxxM05TODMrdStCU1VwU1pa?=
 =?utf-8?B?ZXhxaFpiV1k2Zm92SmRUV1VLT1o4ME5NaytZbDZUUko0eTNuQy9TZWVheUZp?=
 =?utf-8?B?amJnTmR5WTNEMGhoQktLMi9wMit4WmEvSVQwZ3hVN0ZGbUVOV0FTaWFDdkZt?=
 =?utf-8?B?bUFsUDdUUmdkbitBcWNxRVdwOWdBL0Q1ZGlEdEhRN29IVUs2MTB6THd4UEkr?=
 =?utf-8?B?M0l0RmlWNWZVcDRIZUxCeTNnQzdKb1Y2b283anFKZFRkbklHRjQ2c1JlMUNG?=
 =?utf-8?B?SDYvR205Zko1YWY5bEpTQ3R6aWZWRkh5RXI4cGdKbWlkSDBuazE0NU43dTd4?=
 =?utf-8?B?TlA4bHVYVGl2N1NKbzRRaG9SOVg5c01DTjlsb04yczU3QzNUTVNaMm40c2RG?=
 =?utf-8?B?bHMyVjlQSk9tcnppTm4yNEFOeXI4UlllV3BkNktmMCtyT2QwQVZQak9HNnJ6?=
 =?utf-8?B?b2dvKzNoZW1FdzVTdXdBaTFkSkJHVlRzU1hrWXdmRnRQYkVxYUUvbUw2T1hY?=
 =?utf-8?B?alFKa1l4Wi9ZQURkdE5QaW0zVTFOMGQ0Ly9OcGhHQmZwdVIzcmdTVm5yUnll?=
 =?utf-8?B?UVdMRVZRMFVrUG9EZ09TWURHQWJnUXNseGtaeTVoTFdHbzhjVGthMUlOUGpI?=
 =?utf-8?B?aXE0OEoydWxDRmNacWZtTGRmNzJ0WlJENEwxMTBrOVNaTXpTdlpJUUJmSGkx?=
 =?utf-8?B?OGIxQXJiYy9qQ2NuQUVWSjFNVGxheFN2dDh4OTVTa3FXc25rbHErTzhMZEQy?=
 =?utf-8?B?d1pjS2VwZnAvSHBYWllkSVp0ZTg0SlFpSUVHQ1NXRC91TEEzV0c5cnMvTS9D?=
 =?utf-8?B?Y2RWRFRrTHVGZ1g5VTE0blA5bFg0STl1dkxCK21NOXdFUnlydDh1UUtPV203?=
 =?utf-8?B?SWgxbXVhcjN2S2FSR3dBcnNhSUg5SUtMcjBsRHV1VzBRMnZLYXFtOThJSlJL?=
 =?utf-8?B?VmFadjNLamplRWhGUi9PVDdBSStkL1JNTzlSay9hRzdteWdDRE15Lzg5SUtq?=
 =?utf-8?B?NEl2NzNrWlVtTVB1cUw0WWVhWWJ0R0lvS243QVdxblFYZHlMNjVjeEJhZ29p?=
 =?utf-8?B?Uys3b0NWcThydDY1L3FBY1VhU2pnTHREdHFLdE5uR0ZQYTlBRlFNYTB5dEpw?=
 =?utf-8?B?cndjWG11UWtGRnlVTUZJWk1keUFJYk42a1BFQitFVTZlQ3FXdm0xbzhvMXVl?=
 =?utf-8?B?Rzh6VlhIRTNtMWU5Nmd2U2t2Uzk3UVd4SlN3bVUwNVlkYklubGZ3dEhzc1N2?=
 =?utf-8?B?ODg0amRJci9RUWFmV3ovSW1TQmtibEVWZHBTRnRqMmREY0I5K2N3ajBQOVE2?=
 =?utf-8?B?NEtDWHNLK3owQXFXbmdYeXRBZ2d6Y29NVlVSU09LMDZ2UjVXMjVzdk1ZdjQ5?=
 =?utf-8?B?UTgvN1JaaW14RThmZTIraXZ0MEZQeFNTak8vOXlVS3hURTdqdTlyVU53cWxT?=
 =?utf-8?B?OFpKWlRmNVNNZGJNYlo5NWJRZnZReSsyVG9CWXFGcjlqa0xxYnROaGhRWitr?=
 =?utf-8?B?a29MK2x2SlhHQm12N0Y1TjE2cDc2SnI2WFNSS2tXZTM3NFZwbEpUZFRtME0r?=
 =?utf-8?B?SVVPcEFSOUxVV0txMmtobzdsT0JGU1M2YXUrRTlGMk1LMmNQdWgrVERBRngv?=
 =?utf-8?B?YXBuNzlySitOWk9QS0hXSUZzNWJqQXdwUEVXMnVjeGplZ1JGbXlvbTg1bzJn?=
 =?utf-8?Q?wDGWOJ1Gf3T/1NFqRtr/0PxrE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cllxv22WoH3nsf2UTOe1qG+QqPh+knb6fJcSowgpE6Dg7FDro4/8jiZzMlRM8n4Wr1AYkKSGw/uvyOQMabttnxnmWJufMCLQ7zBq9m9vaaKwWXOn8FMFwjQz37feG5cD59Xr75K6ZZwj6q1D7WNffviAxzidRH00YQ/Kz9YHmlVbmLSjOvPv3NdNS+G3G0jybcomudP/qfSKUNcp5S4kwjfUwv5uLAk6CyuY7ROTBbmgLbVKPXsxtVUSe4MVVc23VcUiY5qcPxvU1YPfkwSmBO90gJ5mi5SPWY2Or5M705nN2fO+hGcd4hROy56CtM9HwH0J1+Y9n8/Q9xbCXcZvX4un+Nz7UPCuE86qL31ZZ8XXiw2TNNglDL3iQ7evA7UULaucHxgwHpLGYV3R1e7U0+8Kk6wxFilYjfdQTm3cj1uKUmEVNjqkDFtsFYxuNtTsraQn0kcPPgE6KNKNFPII3RwLbXVbD4gdwhFbFN7TOrNlcX6jZa/isGM8SBpb8IEYzIYJx5JjVccYHjU9nJZIowjL0SGRorfaU7p+bUVzNDPSnsWAmwW7SL0RGgZuuE7a+jFijsZt3ho/eUBf1nNLMuE9dDPG8u5pvbFmKz+Rk04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab7a2cb-31f5-4c7a-9163-08dce70f0838
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:31:33.0208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRG6lPmarBODj4IzHm5cDvGyX4BbjCyv0WYRtqQqiWRyoKHmCzMC0gBuaCf+UPv8rSwBnhZK5fbFxhlJFEAN/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_13,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=961 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070141
X-Proofpoint-GUID: m8TvFOBPI0rVM557z5D5jJbLn_IwMVyR
X-Proofpoint-ORIG-GUID: m8TvFOBPI0rVM557z5D5jJbLn_IwMVyR

* Jann Horn <jannh@google.com> [241007 15:06]:
> On Fri, Aug 30, 2024 at 6:00=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> > Instead of zeroing the vma tree and then overwriting the area, let the
> > area be overwritten and then clean up the gathered vmas using
> > vms_complete_munmap_vmas().
> >
> > To ensure locking is downgraded correctly, the mm is set regardless of
> > MAP_FIXED or not (NULL vma).
> >
> > If a driver is mapping over an existing vma, then clear the ptes before
> > the call_mmap() invocation.  This is done using the vms_clean_up_area()
> > helper.  If there is a close vm_ops, that must also be called to ensure
> > any cleanup is done before mapping over the area.  This also means that
> > calling open has been added to the abort of an unmap operation, for now=
.
>=20
> As currently implemented, this is not a valid optimization because it
> violates the (unwritten?) rule that you must not call free_pgd_range()
> on a region in the page tables which can concurrently be walked. A
> region in the page tables can be concurrently walked if it overlaps a
> VMA which is linked into rmaps which are not write-locked.

Just for clarity, this is the rmap write lock.

>=20
> On Linux 6.12-rc2, when you mmap(MAP_FIXED) over an existing VMA, and
> the new mapping is created by expanding an adjacent VMA, the following
> race with an ftruncate() is possible (because page tables for the old
> mapping are removed while the new VMA in the same location is already
> fully set up and linked into the rmap):
>=20
>=20
> task 1 (mmap, MAP_FIXED)     task 2 (ftruncate)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> mmap_region
>   vma_merge_new_range
>     vma_expand
>       commit_merge
>         vma_prepare
>           [take rmap locks]
>         vma_set_range
>           [expand adjacent mapping]
>         vma_complete
>           [drop rmap locks]
>   vms_complete_munmap_vmas
>     vms_clear_ptes
>       unmap_vmas
>         [removes ptes]
>       free_pgtables
>         [unlinks old vma from rmap]
>                              unmap_mapping_range
>                                unmap_mapping_pages
>                                  i_mmap_lock_read
>                                  unmap_mapping_range_tree
>                                    [loop]
>                                      unmap_mapping_range_vma
>                                        zap_page_range_single
>                                          unmap_single_vma
>                                            unmap_page_range
>                                              zap_p4d_range
>                                                zap_pud_range
>                                                  zap_pmd_range
>                                                    [looks up pmd entry]
>         free_pgd_range
>           [frees pmd]
>                                                    [UAF pmd entry access]
>=20
> To reproduce this, apply the attached mmap-vs-truncate-racewiden.diff
> to widen the race windows, then build and run the attached reproducer
> mmap-fixed-race.c.
>=20
> Under a kernel with KASAN, you should ideally get a KASAN splat like this=
:

Thanks for all the work you did finding the root cause here, I
appreciate it.

I think the correct fix is to take the rmap lock on free_pgtables, when
necessary.  There are a few code paths (error recovery) that are not
regularly run that will also need to change.

Regards,
Liam



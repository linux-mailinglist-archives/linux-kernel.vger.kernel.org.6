Return-Path: <linux-kernel+bounces-513781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9508AA34E98
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C80B16B980
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE12024A043;
	Thu, 13 Feb 2025 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jdu64WMY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WjZRaFAH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0511411DE;
	Thu, 13 Feb 2025 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476023; cv=fail; b=IFTYy1Gz1yhjeikb76Pp74kGcsJyrsFOgfyXvV4SC/Gy/srbdY1Xy7kfg0DN7co+K2AnvNsw/US9CVBGVFZC/ijPiTQS1ac9zzPMNfyYU7UnMvUZ+79vB1vZeXG5oWu5pypeRUP/QMbwevkkqMmja7aFShJk3VznsmqFGW5ij+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476023; c=relaxed/simple;
	bh=DSFky0CyO48k0y8xHg1tJWREz5yHK+mYAp6xxbkNSLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C2D2TK9pmFl2PuS7imRW7wuS5wfmO4jMxV34KQ6YzZMYafg7ZneORT/eeVW81+UiGfHZK1Io8rrog5MZswUeyHHhXjpgOQ5+k+Ua1bOa2UvhVBRI+kP63mYJ6zE3ELqFjWR2Pf2I9/qsxv4A/An3R0mmEalEj+A8nNwXHzktVzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jdu64WMY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WjZRaFAH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfa9j008227;
	Thu, 13 Feb 2025 19:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DvcP7qB1OFFPD1zaGguZO5ZhSMEA57xpzXMWDcbROeA=; b=
	Jdu64WMY4gYeHlJssHkShRLz2p9gV4pwmPiyMwrlN/5OYgbXnbTpeuZqCvtmGhQL
	mtQdPDLL8LzZQtcFFlljqxScQXsZ+aQYpVD4Ave9/nYOBOslfTsFodergG1dEiyw
	VN8Efqm3VBY0sgxVBkKa1/wixhYltwuCCFJRuCFIBQNpQo1KtasqcO2+vBtEX/fH
	m6/uikUVcP4MTwYF8pegr8MYbLTjiUI1Ys3gSpDznPp/F1ri35ROs5+ommmrErIR
	4IDK1U55kDuhsmVDQNJr4aMs9Z8h8p4ug04695FxHk2hX+IHvtdIJ4oDuKSZLGWD
	UeQXN8RnBBSIio/pUeeKDw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tnaad4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:46:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DImH15017607;
	Thu, 13 Feb 2025 19:46:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqjh6t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:46:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJQqGnf+0LX/BsMiEI29Uv3vBhdjHtFW80ynnsjgVIXwe0nzGYpqT38bNUqKrDraK9QAKkE2Sgknu2+8oYoeB3SbvCacxihEowTZ/+l0WFihzcSteK0RhCMWeW9QhlkrxuNS8Cb9DG93G5veP1dsM0oJSiYn0r6zkpnt9Hg6WoFaM6kWTVvZd6f9GKqmMoyi6oRWJuLkFVI20cxIpn3SARzsXBbZkqdtK+J4nFrzgqLbz1EjtEwlKTJptN8CHefz35fAMy6/DjCcuA5NTLfwFwJi09Ur90m6iQ3py86xeAQmLLs07NF7xxmpHBvs8p2IoDhjLi6wu4UG3qkIzF7kBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvcP7qB1OFFPD1zaGguZO5ZhSMEA57xpzXMWDcbROeA=;
 b=PAhKM8XOGd9jyN/v9oWHD4TjF3rXgxIZonJhdzgulHu1rrVtfguhHplGYaUFTg3NFs8s+vFTtS+4YgAwUC6Id94WFOTh7UPayoVSjsYlkUnjT70jhJLoJHpqfZkXeLyXet3nO+oTjGSq0MAONT6x2p5wbYtkJ4qirWCW7MZMw0xcl/dyFZ8qg+lFtUB2jRopzjrNTzFFtTIM5wF+cNS4ruuIxHVfudgpmlN+0zrBCrqlJwV4kszuLbcs14RNnCLI2Uw6NI9UXUxUlnvzKlz8yMg77+wloUR+ZhZIJN4lOnj8CjJg/R2k24dm07XuQC3WPKmbeIJU3Ome29jXZaiRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvcP7qB1OFFPD1zaGguZO5ZhSMEA57xpzXMWDcbROeA=;
 b=WjZRaFAHyxfQ7DNrY+7INn17Mo34kgOgBK+5oEgnXQ6DurFyLzPnPhetBa92CkiLDHYKK2/cLCltxuOI4Ejglv0KU857fvneS745ymSss+yY0CSCJTwFqzfa/gVP9RBLGv0xPZUP+gsy4A5OkJvaGtG8p1i3ReaQdKsRD+1LvVY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB6847.namprd10.prod.outlook.com (2603:10b6:8:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 19:46:27 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 19:46:27 +0000
Date: Thu, 13 Feb 2025 14:46:23 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Balbir Singh <balbirs@nvidia.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
Message-ID: <b6b5tnaw6vnuib7nzcm7ajszxiptqz3i2hex5yengzbsirztks@l3coijkqwtpb>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Balbir Singh <balbirs@nvidia.com>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
 <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
 <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
 <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
 <CANiq72mKyvoyk_tgbMKUdzs-sJOoyEH7f1M9ipiET+XYgwCqRw@mail.gmail.com>
 <2d132129-fdf7-404d-b1f1-8ee87b838dcf@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2d132129-fdf7-404d-b1f1-8ee87b838dcf@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0500.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: bf545b1c-f238-407e-69db-08dd4c671af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzJBKy94MmUyTVJiQS96NlF2dS9zS1dlQ2Z2WjBkcmx1bFNTOEl3YzFJY1Rl?=
 =?utf-8?B?Mm1oUG8wVS9rbUllanI2SU1PeDdHRDAwOXR3dzdlcTlwQ0p4VkpVMStFcFFa?=
 =?utf-8?B?ZUhpdVV3czJrczRIUmNtK3JPa25ZZVN5RWZ2TC9ldmJjbnJkWHR6NDNnMUIr?=
 =?utf-8?B?eFBYc1hLeWNMYjJYRFRIVjEyelExMVhUbjZ0S0ZxM0dES3ViSjkrMEZVS0U4?=
 =?utf-8?B?aFZVSDE4MEJGb2R2NG93cDBlbGZUMDVxcVpJbXE2a2xoM1RyRUpvM3lGSG1V?=
 =?utf-8?B?eGRVNCtqN0l2dE9NYWE1Q2NkVVNlOGUyeHRiYlNrWUYwZVZRZUZaWjFMbVFx?=
 =?utf-8?B?WGpUVVVQVHQ3djJXZlZRekZBWVUzRlZXdnN6VGJ4Wlg1MG04c2RoZWVyOWJV?=
 =?utf-8?B?WnUrdjdMaCt3M2VvYUZkMkpvNld6UVE1ZElUTFdSU3AwZzN4N1lLZTVGVnE1?=
 =?utf-8?B?YXJ3RzNDUVdzdzcyZHpVN2NNa0F4d0crWUJIT2JOa0dzZUlPOEZFQmlHaFBj?=
 =?utf-8?B?dVVUVWEwS0M2UTNJckhOWTVieDBoMHpQZ1VOUjBCZFJMUWFialZMclVUcFNT?=
 =?utf-8?B?VVhFa2dQaGRRTTRqellndnc3ZjZyZkVsdXBob1dJUVA1S2hsZlpReFlHUWRF?=
 =?utf-8?B?OFBGNVdiU2ZxVVZ6elFvbDBod1VSMngwVTArbTVxNTc0MGpySk5yRit6QmFv?=
 =?utf-8?B?QUw3LzQ5clJ5MitLNUpMSzlkS1p1VDVPc0Q2QUUxbWFOVVM1cUZ6STNuL2JH?=
 =?utf-8?B?aFRVNWFXeFJBVklhYjdtS0JpVnJ4UFZabG1QNjhFRDRQNlZzZnFHa0Z0YVJL?=
 =?utf-8?B?dGFNTVVPK0lJNE1EUnhsV0k4VVhzVVg1S3ZBeXBEbFAvWnQ5SjlzMWNwR3Ra?=
 =?utf-8?B?M1dFaUdLemcxYzc1MzVZWHZmejhJaUpUVktEcFN4MklKQ0dMNlNSMUtxdm94?=
 =?utf-8?B?UGNxdzMxdytkS1VMVDVrRnY2cExFdFRsa3hKcDFtT3N0ekx2SkN5RFdndzZ3?=
 =?utf-8?B?WU9wc2JvNXE4dGQ5dkNUUHNaeWVoc1ovdGtQMW4xWXRZbEtuZHpnQzkwVFRS?=
 =?utf-8?B?SjN6R1FBWWFUK25HTzUzYmJJTnI4bmlOVW1GdzlxNWFFVUg4WkYxQVRuUzhP?=
 =?utf-8?B?S0lKZkVXampHanQ5aE1VSStwWmJEeU9zditycUQ4L3VlL3NwUlJwN205WVh4?=
 =?utf-8?B?dkxOSDRCSEZZZGN6eHJWVWxGUjNyOUo0UDVvckpOK05xeElBZXFRUG5jWVNU?=
 =?utf-8?B?NEtsNW95ek1qcWhHR2Z4d2R0dmRkeUdwMW9ZV29Pclk0R3lkRGFmazYvYytG?=
 =?utf-8?B?UEZaVVdkZEpscDRqb3RUT2REWXlRSEVlY0FLNW5zaGxzZExpZUZpQW1HYjNX?=
 =?utf-8?B?UjA4ODFyMHI4amUzQUxOSEQ3VXRXYy9KNWFnODY2Y1A3SDYxUU1oNHlPb1Zl?=
 =?utf-8?B?Wk5OYjVuT1YrMUNtWFhlQkgwZnVHWmEyOTVySG40eXp5QnMxbDZRT0Jsb2Rk?=
 =?utf-8?B?MUlCUzFPMExzK3RpNG9mYWFYQy9ZWUVVWVZRYi9lWHhPLzZuemJacVpDd09J?=
 =?utf-8?B?TCs2L0thbkV2Q3Mway9UanBaU0MxVGU0THBXL2MwOVRGUy94UEZtZHJUZ1F3?=
 =?utf-8?B?RVBCNlZzOHkyN0huYWZiRlhVaHVucHFQR1FCeGFVVjE1OHdGMFJheWR4TDZP?=
 =?utf-8?B?dWtZTGNLNDRzSWI2R09zYzlLTEhsWXhZbHdJeksrMWdhUkttdm85VUNQWE5t?=
 =?utf-8?B?VmFEcUo0T3ZBMHI4RG5wcmNvSlR3SlNEdW9GTUZHeEZoYVkwRWptUHdGTmY0?=
 =?utf-8?B?a0VCOXpOMmltSGNlWUYwUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkxnM2pkT1V5a2Q0eW5Yazc3OE92bmk0MGZPMWFBNDhzWHEyUjgwaURnVlFO?=
 =?utf-8?B?Q0FQU05MMnJYbXFIcktBSktSL3JsS2JQLy9FWXlsVXI4dkVKamNTUEpkVTJP?=
 =?utf-8?B?QjQzMWtjY3BIN2tvWmEyeGhHWDZtTjY0emRjdHR1R0owK0dhdjcrMnhuV1lF?=
 =?utf-8?B?WGZmb290NTkwbytRT1VGZ04wWHFYdkJhMFpPK3JRSW9oUURJbDg0MnEveUlt?=
 =?utf-8?B?U3YwU3F5MlBNdHNKdTNiVmNiTGxmZy9ocWlZRCtpcDhId2hWS241K2NibEQw?=
 =?utf-8?B?Qm9GanM1NkFDSkt6ZUQ1OFVLVk9mRm81WGt2TW9hUmFqNFdoZ2cyWjZuMHJT?=
 =?utf-8?B?M0pWa3JJbFZEcURpNXJBUGprc21nWFUwL0pCVm5vNXhnS0gyTXlESDdvTFdk?=
 =?utf-8?B?NjFtZGc4RUFUcjVEMlYrOTRhbVJIMnhzdGhyZGtZdEIyZUNVMXlyOExDaGVR?=
 =?utf-8?B?YSs5RjhNbEdjSTE4T2hpVFlIUEZOcUt1STFUYjF3b3hGMTI2RUJIQVVSSHBK?=
 =?utf-8?B?QUFkSkkxclRIbTRlRUFiR1VxMmdLN21oQmFXZmI3UEJXcTcwblVNS0M0ZVZw?=
 =?utf-8?B?RnZha0V3RWxKdTJ5RERISWVJR1NGTE1vYi8xU2wzbG1pQ0JKTXRkUDZQckJt?=
 =?utf-8?B?cmFyRWV6eU1zWm1aZUpvSHlEVXJpWVhvcUF2L2lVQ0EwUFEvcGNXTEE3M0Nh?=
 =?utf-8?B?MW9VdWxmYmVxNk9wWTRtL0JwMGh4S3RhOWNOWFpTbVpxOFdEaDlyS2l6Q2FT?=
 =?utf-8?B?YUdkTkI5TXZQQmxXTkFMOE52OTB6V1hkamxqQjJSZWFGYUptVy8zeDNQTmNV?=
 =?utf-8?B?UVIyY1Nja29vZzI0aXdYSVA5akMxRUkxNERQTnlUdkhMMXhuWU0vT0JwK1Bo?=
 =?utf-8?B?M080Nzlhc2xVUm0xWm0rNEIzODhLYXczcFlGQlUwWFJmQ0ZIUjBXdk5HK1ZO?=
 =?utf-8?B?SHVpbVRtQ1BWWXZlVGl3RlpYNEJIMUVDeVlMbUJnMEpjRS9PUmpMVXpFUUxq?=
 =?utf-8?B?Nno1bVdlUy9mbzJ5S3lMb0pEOFdXckdETFpKYTMzRDB1NVBYcTdBZ1ZYMjlQ?=
 =?utf-8?B?R3pYek5Ia3RPNEJFbjQrTWk2WFdnZDI2K0RVa0VkcVJTVEZaZnB6YjJoM3Uw?=
 =?utf-8?B?WG12YUdCZkhPbzltM0hSWUlIb0tKdGtubWY1OXZULzI3d2lhRlJUdTNxY0dn?=
 =?utf-8?B?bXFyNEV4emZiNDV4YktFRDFDVUhpNWlmVmxibXdmRVJDMmlQTk1mcklGOWU4?=
 =?utf-8?B?U2lyMXMyRmtaaTRYZTZncnVqazJWZGlpOTgrOGY0NkVwTitIMzRvNGR5cDA2?=
 =?utf-8?B?ZndQRXR3SjB0bTNCZ2N0c2QwNFZpb2xtZE9adDdHRVVpVkJ5dTFzbitadHUv?=
 =?utf-8?B?Lzl6b1BTRklsSlFRLzVaczY2VklaTG5tZVBQeVZvd08reGt5dVBWbE9CWk8z?=
 =?utf-8?B?Zjdyc2VQYmZxQU9TNk1KVy9mY25JKzF4bmhHYVFxaDR4SmVyMDFqcTFIRDYr?=
 =?utf-8?B?ZW1sRnVIekd5cFp6cWF5bzhKVThaUXJVT0Uyd3d1QjZNM1VodDNuQWgzZ05a?=
 =?utf-8?B?RitjQkh3RkhLWGNPSGRxMXZYTkgyZXBjOFZDT3E4OGpMbytqRWRCVHlzWlZB?=
 =?utf-8?B?ZVdzWWk5dGdscjNTUkZsMTBBb0c0enZQcFkvNTNab29QUUxpK2V4STBIcUI3?=
 =?utf-8?B?MHZEczV3Yk1EZndDbTd5c1V0S0FZM3BFV1pmZmMzSXZTbG9hM0c4RzBMQmtW?=
 =?utf-8?B?RHRMOVl3Y3hLL1ZFSmxja1FBVVEwaS9zWXN0V3AvMjgrYS9TKzFqaFRTcC9V?=
 =?utf-8?B?bitsQ2ZuamFUbldUU0pycU9hK0NSSXd2dlphTU9kaUxRc1dRaVg0K2xCNklO?=
 =?utf-8?B?MndHbURNa1NvSWViTnJ4dEJpRVEwaEhpNG1aU2JjNzRRaXlleG1DbCs3Uit2?=
 =?utf-8?B?R0hWUitieTVxV3o0ZnB3YXh4cTB1MkNyQmxERmJnanQ3TlRXNjRWUk9hMU5C?=
 =?utf-8?B?Z0E2T0VnZS9WbXJqeXk1VTJnTERKSEhXWmRtMDlraHBkNVAzV2tNZTZhY0pH?=
 =?utf-8?B?U0FzcU5qZTUrTGswMWNqYlNWYXpSdy9sS016RnlBc2JMenRQSU1IOWxKZFVI?=
 =?utf-8?Q?6l3mt2vQ6ks1dbc0vd0m/rkLy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CYGWVGKt8scvJpGIRPy6AVxKg6MKtCmBvtU5YwVubzMPfNiQ+t3wP5tZ4Pc7p4aPk//iU2hnc2QNiRnkft2yF/FpftFXWqBG6HsZCC+/0kx5Xslevh6G7PgDopR8tuwEblqrDIH0iw/4Y+8mViAh6dSuwzuna1ikdiArJkr+GrAtUTEnLfRVxekbCxEv+EwZ5qWMrfQANeramYZPL6Rd3J2mGxn4uyvw+L+3P37RNUEygxNpqbxtbDCwEY+Fh8FET69yaSTx2QlGYgiOGjE+VcDmy5c1dMLsTeT8FkThx+7vZXCvpRidxUwff+dUoYgM3dk3GLedP/Ic4j9jS3KzI1OipdrXGXoAYTDEcs9PLEWrsdd4nOyMuzunZgIPaoiYg8vCB0QjQ5I3ZeAeZRamb1/pBurl33WBagABwYyr5dGR6X9sIlV6HAxWrpfCf4pY2gmRb/OxKUBG7qb1TP6fAMUOer+vi97+tcAisN0ZPk97qdszGJwfRgGgz+G6C9HhNU1dya8AQ5y93U41gm/ZM+zhSUzqhvr+gDpJGK5QJ5eI7AaiZxzmDwnVMWpEl94ABaHOUbRtS5Qoy2Q3FYym5vmNT/eyno/32vUKtlfSDEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf545b1c-f238-407e-69db-08dd4c671af1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 19:46:27.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bom+HXhIHyUCNQ8IOa5XGtsBWC5AyKOKg8QDOVm9MozuvFq0h7QMUAWDPtT2SUC1pevNSAKc79qEfcJRwlRojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130139
X-Proofpoint-GUID: ipWnv5sPzlAZGFNTUa0-OMqv1uh0VChL
X-Proofpoint-ORIG-GUID: ipWnv5sPzlAZGFNTUa0-OMqv1uh0VChL

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250213 07:16]:
> On Thu, Feb 13, 2025 at 01:03:04PM +0100, Miguel Ojeda wrote:
> > On Thu, Feb 13, 2025 at 12:50=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > Right, I don't mean the rust subsystem, I mean designated rust
> > > maintainers. The point being that this won't add workload to Andrew, =
nor
> > > require him nor other mm C people to understand rust.
> >
> > Sounds good, and apologies for being pedantic, but given the recent
> > discussions, I thought I should clarify just in case others read it
> > differently.
> >
> > In the same vein, one more quick thing (that you probably didn't mean
> > in this way, but still, I think it is better I add the note, sorry): I
> > don't think it is true that it will not add workload to Andrew or MM
> > in general. It always adds some workload, even if the maintainers
> > don't handle the patches at all, since they may still need to perform
> > a small change in something Rust related due to another change they
> > need to do, or perhaps at least contact the Rust sub-maintainer to do
> > it for them, etc.
> >
> >     https://rust-for-linux.com/rust-kernel-policy#didnt-you-promise-rus=
t-wouldnt-be-extra-work-for-maintainers
> >
> > Cheers,
> > Miguel
>=20
> Ack, for the record I'm happy to help with any work that might come up.

Ack, here too.

Without the drama, I'm not sure how we'd feel so alive :P

Can I be added to whatever list so I can be Cc'ed on the changes on your
side?

Thanks,
Liam



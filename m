Return-Path: <linux-kernel+bounces-429831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF3F9E272A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2437289245
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903A91F8938;
	Tue,  3 Dec 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="niDZhPZz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NIu/aVRZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6701AB6C9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242941; cv=fail; b=ZveS7HEzf9fMi1KCCRaXv5quBifI+oS7Y6Diyw+A4TMB3mQeDdg0nfOU/KoRAyWc7RQ6bvoNS++i2z6jWGRpv3y2bQ+pAmlCy3CzQpjqJ/r2RK+TG4bHYbsepbUYOtOBPc+WTNnSUK9IO/gvUhfhly2i1SYLaImWNAKlwTca3lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242941; c=relaxed/simple;
	bh=rH/5QeEzz+czxt3ZwJYkPrEnm9ArJvplA5Y+kuAol24=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7Zm8cMTgzMt23FaxOgMKV2XYpwNHry7aGzUOdZ/MRain9r0Ra3LED0o6p93LFaJIQyCtOKniUiwwt6wjUB5toCPl2bK3EOwuBZZLP3jVWDnviTlzDhdcdLpehFR/Ag/gkxOk1tqy77jVRy/0j/pWLjBoauF84a6ENRTXH2Ee74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=niDZhPZz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NIu/aVRZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3F6klH006178;
	Tue, 3 Dec 2024 16:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=u1y2dROs30XMwTAsnLO9Z30bu584m3XkrFeUsuZf5Hs=; b=
	niDZhPZzO8t+9I3v/rriJYYKUbDebUZpcpJGrYSiwjN6D0/RF+sQ7akoPaEDVM99
	x8GZWCUyWOBqowkvYK1uvV62k5FhHPRsDC+Eb2MdEIOIh6V7gz8bDVs/tIW6tOJB
	dA2MiNX7BCl+TENDzI1u9h+itQpHhHCLqgX9NLwzYaVf12AibbL6SyQqyy8MmQqi
	B/vHaPncp1dVlxtvWNmFgvd4y/3t6UzDEqZXkZSfSUu2du6U3iKavMSCcuDakjVq
	nycdEKTbQVnMhtZIj7WW7unsE5GlsXX19kKTZR1ljbCpqKChb0Twy3uKIpIMVCJG
	XlmaVlWLOCbqh/vazZ+lJA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbpgy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 16:22:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3GFAHw001943;
	Tue, 3 Dec 2024 16:22:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s583xpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 16:21:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg1Cyo9dpPPLUXkTQ8HVCNy4ZCwArY43/3yisvL5USGkNztC22Ao5HxpcdemUCh6qldrxDgI+RAzpjG9psSq/lcxprGCVAyqSqmsOkhLZpxPcwlHQQP9q4jMWqP3tehVlRWAGajOkF3JloZCUomc+EyHe/3db+uPy8MPQlemN+0qG9zVhzrLhscL/QWEOrD0b2Ns7rE2sa6VTWEMqsP7XdghoR/y+caSyzR90rXYNfU5+ASosMYHqzPrv2X6EXr8D/hAp3PxUY5m6Y6g2QlMYnAufwSxf+B7M4m2BderO4zaUqNn4pKa3B1vbo+D3oCWd3FIhCbQbezEWaVo/WiERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1y2dROs30XMwTAsnLO9Z30bu584m3XkrFeUsuZf5Hs=;
 b=OI2yRZntDxTEPNGY5OYo2kuOhDxqdtw9Nw9feVia838ji6QkXWgJMfbOUa/A7awVYqUgFX/LJvOexzkT3IMYJGG/D4gfUYbyhSlYEVQW7reIzUh6s0kMGmaSHxfw7FKNUx/UTbW5vv6cXRQnvAs6sOA3Ij3sdAUNK8iL3vDxCNBMvzVyNVUY47BDQJkNzRmEdC17Q7JOg1R5HS/fF8nzZ+HssZXHqFLiHyF49Ej+Mt1tCgfSocV2dPlfidChB3wDPf9PtBLLn4DUB9b7GLbTh0tBZtppvkSklww251RdRPzrTOYjxHrimOM4JdP6BGKI0lTAW1FcSGTzH9sQDfvwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1y2dROs30XMwTAsnLO9Z30bu584m3XkrFeUsuZf5Hs=;
 b=NIu/aVRZji42OVlQ5yRGK4AeIy5qzMkLjQGs0DwNq7hT8vtyF5BHgbT9LGLBpjcwO+n1npu/LoOhJNIR/MgsBZvOYhwJi8wa1xL692zsql7vjM6OeUNxfp0SV5q3OIg/1jDAigm8uNurRTo1l6TbS2aAMZbMLa6ysXTopD3quZs=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA1PR10MB6783.namprd10.prod.outlook.com (2603:10b6:208:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 16:21:57 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 16:21:56 +0000
Message-ID: <216be86b-cad3-4e12-bb5d-4911ad915fb5@oracle.com>
Date: Tue, 3 Dec 2024 16:21:51 +0000
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Frank van der Linden <fvdl@google.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Muchun Song <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20241202202058.3249628-1-fvdl@google.com>
 <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
 <CAPTztWbmkFisL7qnmAnre5hv=UD1E60P0hr_kXNyLoQFy9OoTA@mail.gmail.com>
 <Z070YE81kJ-OnSX8@tiehlicka>
 <d1f224fb-c0fb-47f9-bea8-3c33137be161@oracle.com>
 <CAGudoHGY_NEJe6Pp6rv91v8p--phSX32C5Pm55c6jpUAJFLKmA@mail.gmail.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <CAGudoHGY_NEJe6Pp6rv91v8p--phSX32C5Pm55c6jpUAJFLKmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0126.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::23) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA1PR10MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cb60b9-7968-449a-b92a-08dd13b69b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWcyTEU0SFJaUGVHeCtoYlppbzV1TGpTeE9kVlhKLzNpTGVLVjhrTHlPemtq?=
 =?utf-8?B?WVU5RnZ0NWNEL0FlRVRhdjFtSkhEZXU0aENveWprQlhDRTJ4RXEyMmVhYWZT?=
 =?utf-8?B?dmZHR09IcTVEZDNDWk5haHpTTEt0TXU4VUE3U01wbGVJeW5wbVo0TGNJUkR0?=
 =?utf-8?B?bGhKRmVLdmdUVFh2eUdnUmh2UzFhNEJBK1dHNklDSEQrN29ieUxYclVhK25x?=
 =?utf-8?B?MDhRRDl1UUZVdTdVa0RqajRzSzF6Y1Fqa1FuTEdSWExDN0tNcWlydVdueTZC?=
 =?utf-8?B?ZUVvWWhzUk4zaUt0eFhNWUQrZlhJMVc0NWNmeVE5dnc1c01zQy9jN3YzWEsw?=
 =?utf-8?B?UHBRZlQrcUowUXZYTmZVZmJLSVkxdTBqUWhhdEdWNTVBR0ltSnFLQ3dvNzZV?=
 =?utf-8?B?MTRyQmRrRDdKNkFobk9jclEwQ040MTk0QS80VWZrcTRjaWg2Vk00dklKOG1J?=
 =?utf-8?B?bEhVNzdBUXRIL1g4Y0x2TUFvb2dWSmY3QlNyU3FCa2ZsQ2tqVXpQTnlVclZa?=
 =?utf-8?B?SXlmVGdvTVNzUDJ6M2RySkNHWkdyTE5lYzBxYUhhbTBmV09BNkVNNVNFL1F3?=
 =?utf-8?B?c0cyL2pHYnVlb29vVnZHQUp2SW1ieDdmRXVxTnB0eXNGcVVPQ0xreTlPNC9M?=
 =?utf-8?B?U0FXWVZlV05ZWFpLbkpBSi9aTVRpVXR3SC9DK3c2WkxzV3J3V3BrRFlDK3Qx?=
 =?utf-8?B?dzMxN0xTOFdibUVFWDY1Y2FiQlpCblRWcjFoV294c0tGbDc1VERmOGtlckhm?=
 =?utf-8?B?bnlxckV0ZUF2RHM1Qng4N1kyNDNPQ01tdzhpQ3lpN1lDaUg2bURscUk2US9a?=
 =?utf-8?B?UVNaa0RKb3lJaXhpWXFpa3hidnNIejgzWG16Y3FtamVFOVpKTm1TRTJEOHND?=
 =?utf-8?B?Mnd2NzVnZnZCeEtXK2RONlZoSmZhb0tNeDRrRnkyTVFueU91Ni9DNXJBWlpC?=
 =?utf-8?B?bnA2MkNJWU83ODdIQVR6TGQyeWRoRG53QWRxck9WNnBWZnpSZTJoMWYzaEVY?=
 =?utf-8?B?d3hGTjV3aXlldkdONWttTEc0bkM4Y3NvcVd3dWh2SlBDUUNxU01sRG9RT2F6?=
 =?utf-8?B?b2pYazBRSEYzcnZWK2dFWUtHcDAvcEZGTWlHWVJWVk9lQlUzbnF3Zy8wVGNq?=
 =?utf-8?B?MVg5c3htWkVjandYYTRWTU1GYmdnRG9XU0RRQlZKa1BFMWk3RXVweG1vM0VJ?=
 =?utf-8?B?NHlRRDlHUW0yMTNuY3ZYQjhnYVh5ZzJqUzJvdVNHNWU4N2hadkZjV05FSWc2?=
 =?utf-8?B?NWpPSk9TeGVsT1NZWFNHc0dacWZhTGVqL1Y5NWVqQSsxa29sS2lzekVHSlpq?=
 =?utf-8?B?YzJxRE41Q1ptS2FVK2RBRlZRTXVGQkdJUkVhN3BFeHl1dUVKSG9IcGRxcnpD?=
 =?utf-8?B?Q1hzQkcxZndXYkRpZWdSbi9Qdkloak1OdWMwSUpPZ0JzZEtaeld2aVZ5d2VH?=
 =?utf-8?B?VEtqVTZuN0d6eThsK3JHSHk0Z3M4TExrME5tV2pIMXJHSXZxTmNnTlQwN3BW?=
 =?utf-8?B?NDFoQzJyV3o1VHRqNlFFajFwZlh6Nm02WE5pYXVPNEtpR3J3SnN2UUY3TjBw?=
 =?utf-8?B?ZXdLbG9OY2IwUkU0cFZJOUllRFBuUms5ekhLbVVxRERIVmxlVWxkd3BYemhp?=
 =?utf-8?B?QTltOWVvVXBEUGJQS2FLMzY4MUZGb0FubkgrUCtMNThONERYeHI1M0IvTkov?=
 =?utf-8?B?VE1jNHdza1VCb0RqdWs4N0cwMnptN2EvK3lJQ1NZMUdScXRKc3FMeEU4OUpX?=
 =?utf-8?B?MnYyWDNKOUwzTVNQZ2F2bTQ3a3c0UW15NEo0TmtWTmlTS2RsS3ZpdjhTM3F4?=
 =?utf-8?B?My9nZEgxd09aL0h6NXkydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THZBUmU5enJoTys2ZEViWnljVXN0Y0h0NU1JZG52Vkx6Sm5uZUlqWGphbXg4?=
 =?utf-8?B?dVIwUXU0Q2F1SkVWM0tIb3BUMngxbVZZdHBpMWR2V1ZiS3BjakIzb2dZL0U1?=
 =?utf-8?B?amhlRm5PWmNzeHJSWFRHNHl3SS96NW1FeWxXcFVTVlRRanhRUlVCbnJmSk9y?=
 =?utf-8?B?S2JNYU1ZM3UwemlSendJd1h4TVkzekxTam1IVDJPODJpYVZ5dkc2ZEpDWEdY?=
 =?utf-8?B?RVVwYmk0clhBSUZHTVJTZkNLejFIRGxCWHNWb1luUjB1VGdZd2tuZWFPZ3NN?=
 =?utf-8?B?aU5yWEJvODljQlNhSFUzZEdHcm45eU13dTA4c0lCYWVNTFFHQWU0SG5tRGta?=
 =?utf-8?B?WkwzL0NsTi9KQWp5czByMmU2eXo4amtIUFE5VTdjYXVpRVBNWEhyTnExZDVM?=
 =?utf-8?B?ZGp6KzFJZFJxYmZRdmdTRzJoVXk5T2RtVklVc3BMN0lpc0FJN3RsZFhNWEhE?=
 =?utf-8?B?QkN2eERNM0tiTDVRbEVQbzhJQ0t6ZytLUEhkOFVEWU9LbEZxM3VhK1Q5RzN3?=
 =?utf-8?B?OVBPSTUyMUdWS1BQNUYwUE9KYnpwZnZRYVNhSDJSVXg5SkpUYlFmOWJRMmdS?=
 =?utf-8?B?VC8wTUtObjV1ek1sZWlpWng2OTVKYVBuc0p3Mk1OYytHWXhDR2FCeEFkQzRs?=
 =?utf-8?B?RnY3LzRYRU9OdDJHUzJRbm42ZW5hb3hCUlBVNnQ3OHEwUi9sVUt4ZUZsYVRJ?=
 =?utf-8?B?WDRtT0lIbHg1aE5MU2E1cUdWcVlISVNEbThYV2pYNDkvcUwwakVlMUQydXln?=
 =?utf-8?B?L2NuRjI0UGQyZUVucGIrcTFsMFJ2MjgxN01aWTluSUVWMlp6VDl2a2hLYXc0?=
 =?utf-8?B?QTlETlQxR2NkQldHV2VvZnd6UjAvUjhRMUpoS3dwUEx1SWZBSENFR2FiTnhG?=
 =?utf-8?B?N01WR1JiVEFFVVFlb3BSVnBXQTZjb2NMVnlsbExablJHLzloSWRkT2hnRWNO?=
 =?utf-8?B?QlpwTW9pellUQllFU2RjQmdIQ2d4ZjhmTVd0cGYxZGVMQ25NdytFRTNwNWR5?=
 =?utf-8?B?Y2QxUlBkdERVT1VvaTZwaTF5TnlyL0xmMmVJZTZxRzYxblRadjFxbzZPTHVm?=
 =?utf-8?B?MnU4RU91bDk1aFdEbW5lVnNJY09IR1VVOWZFbXdCN2VXcFVxb1l4VnVrZ2ps?=
 =?utf-8?B?RWFSUU45WVExZ3UrNFJDcjVjWVU3L3E3cEhDaTBCMkh5M2Z0aWcxT0V6N0Iv?=
 =?utf-8?B?bUR0Y0VaQllEbjFBUWdLcDRycmt3dnRyemZ4QjhmNit6R3VqZHhQMml6d3k0?=
 =?utf-8?B?Q05NRGZNTk8yOUhFaHgydW9vb0pPcnFQcnlYdDgydmx1UHpsSDhEOEFDMCth?=
 =?utf-8?B?ZzhnZTRYZTZhcThGd3p4Vk5lRWpjdENpVThMVFo5akxCczJoOUpyNjQvQW9s?=
 =?utf-8?B?emQ3Z1lIQytzcGVjY1lXb1R6OVEwenVqS2pSV2VaVmVMWS9pV250c3dvbVRz?=
 =?utf-8?B?NUh5ek1ZamFubm53bHFuakRLNEpJQktCajhHMDZwdTlIOFEwUGV4WVlkeXBh?=
 =?utf-8?B?RmJRdGRiU0NlT1RWblhRaGpzNytrN3BicnNUSmxjNnVEakJDS2dZRlhtS3Np?=
 =?utf-8?B?SGxONXRuS0pZS2Z3Skpqd3UvTmx4eklhZU5oUlRHcm03QmNlNHh6WjZnWTlZ?=
 =?utf-8?B?bm1nSGtyN3pmRWxUdUh2M1dLTFlxSWRXM2VLWlIxOUUwWWx6dy9IRk1rNjNJ?=
 =?utf-8?B?b1JrVnBFOGtoS1EwR3JQdWVJN1o2aFh5SzRzR2Z0QlRyZTc3blZPNWtOWGRV?=
 =?utf-8?B?bXFBaWhaRmVnM3prNjUwZDdPZ1hJSXAzcUYrWEVBSGxOWDExb1ZzeEdGWVhG?=
 =?utf-8?B?Q1dwTHVoQm44REQ3aWFKa1p5RnFydnJPK3o3UGt4cE41dGFxSUtqYlF6Mnp5?=
 =?utf-8?B?TWNxbEIvUHVWK3lPUnVBcHhESnlwbnVOVEFlUzNja1ZSaVljUC9hOXJyeXJx?=
 =?utf-8?B?NktrZWlQYVlObHFUdVdNaS9ncUs1dGhMMmFHbHhrbE4zWTh0MlV3Y0R4ajk4?=
 =?utf-8?B?VG5XZ0YzOStRd00vSktlNHcxYnU2dWttdW92UlZSVU4wNEptWVlVcXZlc3Fr?=
 =?utf-8?B?M0ZNM0VqV01oYWdpY0g5VkFTcjhrd2lUMHJRK0xNTEl1SEI2Z0IvQytHK0Yv?=
 =?utf-8?B?UXZ3bk8ydnpNK0hkZWkwV1RFaWlTVU9aUkhtVmpBRE5CREIzOWNhdFRkRVh0?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U/Nd7TMipqBauITwFEK/MEGl6qsGn82dNxBKr8NSCeOAQIT+GtIukXQG3Oo93vCSQbvBhayKZBmx6Ef1S9rlnY2oPbjPm+0XxvWajRJXaUuhn8XKeBiq4GhmaugwnP6adEDufaw9aPm4KavlmsjWBKWYntdEdTjE9xWTgsCy+Aoahd5k9Y6s9rfgFBsp1vjmD8ViszEEMszYWA8l1qxjRH++l90BdN4vRxwsjjDXOUYwKu7dWsoAqx1BGPP3YLudEzPt1nLpctdBqeLR7NHJ7i7Ld/9a0Lsl473bqPUhEp+cLox3hQR0COpSSfpbztjGSMku8Ul4XvtREbu5gQma8P/O++OufizYequmkH72R8PYsd/K0YHhLVAgk2a0V0rN4kyuYaXO0AQof7vxai+hyQjpwErn8N1QKKRGxvvCO1Z+IqbJl0YjnCEZQXnPTtDScVfivlz9OB114555yz/Ljvm2LqW2FBZYgT9HNZTeyPjL903L1cwP9AQhzWluNBR7iXQLZrlW/Vi4KpzD8A2a6eivsKE5O7vwIe85Otg8J3tJiIBiCTYPy25p6RP6SxuI/0vQckr7sMd2KNZpbLcplCNI5dOTLadZ3tNTRZaZtFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cb60b9-7968-449a-b92a-08dd13b69b35
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 16:21:56.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: He7sh/U3uKNb7nXoEZqgFBdKyyQkYCjfalKaaOLffDZ8gfRPrO8izlAPatKS92iAe3IPRWEn7nm7yug7mHWS/leab/fUuAwTzk6f7VZsGvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_05,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412030137
X-Proofpoint-GUID: KNoD2jvPX36VvgdtaMZ3MdTwmFb_65D0
X-Proofpoint-ORIG-GUID: KNoD2jvPX36VvgdtaMZ3MdTwmFb_65D0

On 03/12/2024 15:57, Mateusz Guzik wrote:
> On Tue, Dec 3, 2024 at 3:26 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> On 03/12/2024 12:06, Michal Hocko wrote:
>>> If the startup latency is a real problem is there a way to workaround
>>> that in the userspace by preallocating hugetlb pages ahead of time
>>> before those VMs are launched and hand over already pre-allocated pages?
>>
>> It should be relatively simple to actually do this. Me and Mike had experimented
>> ourselves a couple years back but we never had the chance to send it over. IIRC
>> if we:
>>
>> - add the PageZeroed tracking bit when a page is zeroed
>> - clear it in the write (fixup/non-fixup) fault-path
>>
>> [somewhat similar to this series I suspect]
>>
>> Then what's left is to change the lookup of free hugetlb pages
>> (dequeue_hugetlb_folio_node_exact() I think) to search first for non-zeroed
>> pages. Provided we don't track its 'cleared' state, there's no UAPI change in
>> behaviour. A daemon can just allocate/mmap+touch/etc them with read-only and
>> free them back 'as zeroed' to implement a userspace scrubber. And in principle
>> existing apps should see no difference. The amount of changes is consequently
>> significantly smaller (or it looked as such in a quick PoC years back).
>>
>> Something extra on the top would perhaps be the ability so select a lookup
>> heuristic such that we can pick the search method of
>> non-zero-first/only-nonzero/zeroed pages behind ioctl() (or a better generic
>> UAPI) to allow a scrubber to easily coexist with hugepage user (e.g. a VMM, etc)
>> without too much of a dance.
>>
> 
> Ye after the qemu prefaulting got pointed out I started thinking about
> a userlevel daemon which would do the work proposed here.
> 
> Except I got stuck at a good way to do it. The mmap + load from the
> area + munmap triple does work but also entails more overhead than
> necessary, but I only have some handwaving how to not do it. :)
> 
What I was trying to suggest above is that it would be no different that how you
use hugetlb. I am not enterily sure I follow the triple work part on unmap.

> Suppose a daemon of the sort exists and there is a machine with 4 or
> more NUMA domains to deal with. Further suppose it spawns at least one
> thread per such domain and tasksets them accordingly.
> 
> Then perhaps an ioctl somewhere on hugetlbfs(?) could take a parameter
> indicating how many pages to zero out (or even just accept one page).
> This would avoid crap on munmap.
> 
> This would still need majority of the patch, but all the zeroing> policy would
be taken out. Key point being that whatever specific
> behavior one sees fit, they can implement it in userspace, preventing
> future kernel patches to add more tweaks.

Kernel should still ensure it tracks if it's cleared or not -- so what I said
above was just letting the allocation zero out the page or not (if it's not
zeroed already) and just tweak the dirtyness of pages it picks before installing
PTEs. A scrubber would pick only dirty pages (and maybe fail if there aren't
any), and a VMM would pick clean pages (taking advantage of the scrubber work).
An explicit zero sounds a somewhat limiting ... but hmm

What throws all this away (in primary MM) is the prefaulting with write as we
would clear the PageCleared bit all the time (I think that's what you mean 'crap
on unmap'?).

But there could be hope for systems with a secondary pagetables (with paging),
where the secondary faulting is the one in control of the cleared status. That
is because reads inside the VM ultimately trigger secondary-VM read-faults and
get fixed up later with write on writes.

Well, at least it would work given we don't prefault secondary page tables yet...


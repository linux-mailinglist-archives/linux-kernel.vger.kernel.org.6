Return-Path: <linux-kernel+bounces-572225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 599E2A6C803
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 08:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54A9462035
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D718A6CF;
	Sat, 22 Mar 2025 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WvNBGjqH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mS/pjnzr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993E347C7
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742627296; cv=fail; b=dVpdS2hNh0ebGX4OHwjeWPiY6EabxQGpPBArcc+dn9MhZW6InQCGa1SDkENw3wQDu9a7Is+OpgU5EFiHt1TrP0pRxgtIEMaKJ9M7N58iFJ6eHR2sIvKPjd1JlB1f8bCxNEVu5ZyUUoLKSfLZXck+UyPvmf4kWZNjRvsa87nOmWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742627296; c=relaxed/simple;
	bh=icGiDHs+wWPZhrhLlDvSY5qmX+2B6Iqx58/9LFD0CHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HpdoZUO9UxjnMpdrEfWP9BaBzhgHUsUi5p8P0sTXAiTRcuVgaMu6BfWQZnXMZR1VjD3B/2JQIhW4Hh5yMvTnYe71vqaltwAMi02ULwigKwYW6INzCctKPusMRfZtbbU6967wLoFpo28swilALv5p3DhhT8rq1crBu04Ebnhm6i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WvNBGjqH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mS/pjnzr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M5Cb2t021404;
	Sat, 22 Mar 2025 07:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0zkVToIIZDZxrxBI7R4UbD0dN9eWklbThLepUE4JZh8=; b=
	WvNBGjqHOT5zQfInwUmH9UAPahC2f9hK+F9y/FxtUEYX+t50y93p3iKpKzmsIj5l
	TatSDNUfVKA++enKBfCPM+F2pR3SX1C+JmHdEJRu4g/WiPHRCEacx2KBtrWbWMkh
	4OIv3EwP5wma921R1fDx/lhfzoa4gO4Fs8EJd7euafr8k3JeY3YCgp9Mn4TkEo+S
	tpZ16gn8T9Jlb/oRuH5jBo+sCO9+1jhrOtmgHmB1VbeOjG008vc3Y/sIqJSDy4Fg
	Xc3rpo4w1EqQPu071mesIdFI5t/hbE9usVmMChUs992QK5QC6AHfH38CJ3HxTol4
	UXXArTp2AWXXPWCk1WumUA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnrs82vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 07:07:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52M38xEg003268;
	Sat, 22 Mar 2025 07:07:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45hkn6cy7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 07:07:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+z9SrIfcTWDBX5bVWvMucw4n9qcBA7moGiUWGqIt3nXQNDIqfJy2qOzQM5eftG0Pqr3bEpSxuMyAKtiVZACrYXSgSiO2rlbJZ5n/7pgzjnkAacmRsGdty0h8etW5PwBoccM2lSTiGNxxwzwyOZmfPmg9NbdgA9x/vBLm4ZgGxqbzkj7VaTFLc6x55VmqykhM7hhNnCIj2j8xh3WLKRz/a9yvzTgHzHmCo48aJLkA5xnfmm+lxBlf79C31h93AoofpBKEtmy5/71d3xgCD1zk6woDqJPjg1u1mejC1vwiTbcM+0ThI6GFev7gvhDvFcZ0IOfPSPnBDtTTOdYBUrzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zkVToIIZDZxrxBI7R4UbD0dN9eWklbThLepUE4JZh8=;
 b=WKGnSi1jKMlJxUEiD43zhjSuyppjdLyOPbs59kHyBWThBB2382pNL8jSiw2xRn5oOzmav1folAgxS/anCnjqMFPjEeeRt7EX7XFBqh0C6YUX9Zu8kpMa7+Y4/T5VOznyQwic+r0PKPpzmwceUasgpww8J3LNZK6KqHaUbCX7IZ++CH5IzyTVPis3B09ZnYkxL6sRAC+DVMr0FM2B2wEXS2z2eyUCf3ktMH+VNPt8QFKilWYA68ltjTYwvxPWTNUynWzWASlbRIHZGSwWKTDdQTbeoq+7pNi1oOjBLosUyHAVnl0uiNqRcvoHrGyRI4cboy/RoHx51zM6FZyGzu7DZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zkVToIIZDZxrxBI7R4UbD0dN9eWklbThLepUE4JZh8=;
 b=mS/pjnzr5n+yHWRdKWzXz+JyPVXs0UhaWCSAedhUl8M8oicAsgzGRkN8/BhdTf+/2xj2XI4huBuR6xQ8kxrGZNVFw+mbbmGzX17ahqpmFjTEfcvN44sHBFsLGjwjubXSABHQGBcA6aUukJiXirvi30n9goGzcvO10hofkq3rTk0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB7711.namprd10.prod.outlook.com (2603:10b6:806:3ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Sat, 22 Mar
 2025 07:07:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 07:07:54 +0000
Date: Sat, 22 Mar 2025 07:07:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] mm/mremap: introduce more mergeable mremap via
 MREMAP_RELOCATE_ANON
Message-ID: <3f21bec7-5160-4a9e-be7c-8658d36c581c@lucifer.local>
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
 <d10037699391c42a4943f578c2a0bca890640f30.1742478846.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3CiRTUv4Qwy_UQzQuEDtUoPVVXnuPyiWoAhWVqkF3VTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3CiRTUv4Qwy_UQzQuEDtUoPVVXnuPyiWoAhWVqkF3VTA@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0151.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5fb308-a9de-4efe-f4eb-08dd69104464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXA2U2pMbmR2RVlzaFMrV0IwckRCWjBYejlxNTdFK1doQ3dhL1pPU1paejJo?=
 =?utf-8?B?N0kxb25uOU5RRHpzaDV0ck05b2JwQU5SeStOQ1l1TzJ3SEhFRGJKdFgzS3NV?=
 =?utf-8?B?ZUtSdEhvNFQ5U3RMelpKSFp1K0VkVm5hdG9IUlVzT0R0TWh0eWpJdlB6ekIx?=
 =?utf-8?B?OGFxQW5EUFF2bEFrTnQ5ME5rc0hKMlVSZ3ljd1VDZ1JsSkpCSzhuQytndS9O?=
 =?utf-8?B?R0NkcDdmMW1sOEIzdkhLZ2hSNmRMQ3d6cnhxMm0vVy90d0Y2bi9vT2o5b0xY?=
 =?utf-8?B?eUlCb1FobHk4LzIyYUxrK0prZzlYRkRVYzVyN2U1SUYrdG5Xdk1JZUc5QnY0?=
 =?utf-8?B?aEpEQTVmT3ViQ0c1Zm9PckxnUjk5OVJ1SjFLNFJqaWM4MlJNMzF1Rkp2dXhB?=
 =?utf-8?B?Wng4VmxCSnVONW1oNk1nQVhReDkxbE9xSU9PZXladnJXMW05SkoyU1g3bTNl?=
 =?utf-8?B?d0dkYitVYUdibjBjdGR0Ly90SDF1YTJIaExuYzNZejZJTE9LSXhYQmwwQXhB?=
 =?utf-8?B?a1F1NVliOXJhN1Jha1M5c2MyN3hOTjhQQWx6YWgrUGFpRzRmV3dqUEtMOXhn?=
 =?utf-8?B?RERJOFpMZkUvUTZDYytSN2lhZHVhc2kxWVAvODdiZXdJUFFEUmFPbThVeS9V?=
 =?utf-8?B?dnJaNFQxRk0vRzhaNXJYNGszeWlRWWt5Y1NCMjZhazFIakVBQkVWdlRFTnp3?=
 =?utf-8?B?Uk5MQnErMEZMTk9XTEhiMHU4SGN6S2FxdHlYK0FDRGp0RGFXbG9jNllRalZx?=
 =?utf-8?B?UHJFSldid0JXNWRaRzFsM21QVXZhUU1xanphTmZ5bVIwMENnenBZUGs4eE5M?=
 =?utf-8?B?MHpOem1ML2RXRVJIOEM1ZnVwUEgwdnZvcHdkR3o5WXI3TU5jWlViZVBiYjF3?=
 =?utf-8?B?VmNkODRoaVp0d08zQm9ESTMvZDJpWmFTNU5qZEFveTBHdm1vVU4yb2xxK3Vt?=
 =?utf-8?B?SlkwcW00MlhwQURDeHdvbitZVjVPOEhyL2dPTDNocTd0c3IycksyUkYydEpa?=
 =?utf-8?B?OVlZRGUreDZmbVorVzRnWllUYm82VHRNSzdweExiZ2RwQ055emRHb3Rzb0NO?=
 =?utf-8?B?QTVraUYxWHdselM2ZWVSRmNXczc1K1ZQVUlLME9sa2lHS2NhZi95YVFTcmM5?=
 =?utf-8?B?NUpETEdVY3hvdGQvRk9LSkdSQ3NIQmhNMVZFcDdMQU9rODVuclNLMG5LS1ha?=
 =?utf-8?B?Vk9vdFlwZ0JmRm02UW9pQWt5aE0yZkdFbTZXdkFtTndjbDF2bFdPR0pJTkhs?=
 =?utf-8?B?b0YraGJYMGVWMW5hN3FnY0w0WGxzSEp0c1FteS96Z25BOFFRbE1zcmpTSGdn?=
 =?utf-8?B?WVo1cEhDK3hWb3NUeUdXM2JpT3RqREFaY2kxeGVwb3pSOUc3Z0FYeFcxMmJY?=
 =?utf-8?B?Y3Y2MHpTVVEvTUc4WW5pV2h2a3A1RTV2WmVlWHIxWDljMmIyV0lYK0UwZ0xG?=
 =?utf-8?B?eGZBMllvWDgvbmJRY0F1RkVRUXEvbWJvV0tycGh2NnNEL3VCRklyNTF6NkYr?=
 =?utf-8?B?cTJIUlBKdzYvRTNWaDM1V3BPQSsxOTBWVFU2MWM3MmVkcGNYcFVsOVNEZVBZ?=
 =?utf-8?B?MjVjSnJBLzFrVGNGZTV3ekl5RFdjckRMUVdmaHRQTmZOSnphQmxxcUtMaU9B?=
 =?utf-8?B?T05DcG4zSVV4SnBCdjNRQ2IxOStVWUdFdlFLL0RzSFZSMmZvM2xFRmNYNGgx?=
 =?utf-8?B?NDc1clU1bWkvQTQ1Z0l2RWxwRHhCSUxvRzFxbTFTdkdWRHYzaC9Wa2Z1cFhu?=
 =?utf-8?B?eUpLeUhSMno3QzJmdG9xdlVIUlJrTEc2bmNESWF4UHBjRXlBVEVoMmZsaUk1?=
 =?utf-8?B?TXgzaG1SR01YcDhaV0VhUG5SbjNsYi96YXJDb2NkeXBDMHJQU0V6ZTlpSW9Z?=
 =?utf-8?Q?BeTkkCyyV2EQh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE1ObGZvbnFkZDk5M01pSW5CamRpVGxzaTFCUmVBNW4yR3BkNFU5YnllWURT?=
 =?utf-8?B?VlRGYWpIUURRNWRDUzlTeTJzRzRHLzh1L2FnR1dtTmwyVGVteEtlSGk2d09G?=
 =?utf-8?B?OWVkWGtBSDRjNnNrWStDNGxXeXdqVm5nTjBGYlF0M1FJS2RTSEcvblFNMEtZ?=
 =?utf-8?B?YjBkSWpJcjN2Nk11Mi91b3NzNG1yRGQvazJwRi92OTB4bzNpNWVocE9nVTFF?=
 =?utf-8?B?ZGJrRE5NRnh1Q0N4KzRuUGF3dm5zY3ZGVnEvOFBzaHNsMHB3WEpqR2VCaEZK?=
 =?utf-8?B?cjhSdlJadzc3eVVSK09tV3d1a3ZSdkVjZm1mZTRRTzh4Z25LOHZwcGZraDIv?=
 =?utf-8?B?WXFuNW1UMVFGTDBlTGNJcDl5bDhXbTYyeDRsUHU1aE81b1o4MUtmUGppemZV?=
 =?utf-8?B?VG5tVDQrY3pFeDZTT1FoVmpLNXJCM05pYWZwTXZaM2xqR0RsZ2kvQU9wU241?=
 =?utf-8?B?d3lxeDI1dU5JUkcwRDlVajNkNWlMeGVVdVI1MG1LdVJ2aUhxLzBOQm5Ucjkx?=
 =?utf-8?B?MTdUWHNjNFk3T1N4TGtOaXpSMkJmVW82T21pQkJLLzR1azZ4cnkyWW1kUWM3?=
 =?utf-8?B?WW0wNVVydjlWK0VtY2IvZVhyTW56UlVKSlNTc3YzSDd6MjdFa2VKbWhzMkhH?=
 =?utf-8?B?VzFDaWQyMTFkMFNnaHFMMHVhUjJlR3lTc1JBSWxqTENaZGpFZ1haS2JaZW1y?=
 =?utf-8?B?ZWIvWlc4R0h5dFdNcklvOUlWQUlFdGhUTU9pQjIwT29VTXZNYmVEbERnSUJj?=
 =?utf-8?B?QXB2U2hjOFZsQnZhUVcrUlp4c1JwM2Z0N0JVZWJxOVdBRWlubGRFQlF0ekEr?=
 =?utf-8?B?dmw4SVQwdVBTZWpkZ2hvcGJHNmRFTStJcnpIbTE3dmpvd05LeWFZbnRKa0Fq?=
 =?utf-8?B?WTJEaEwzcWdIVmFaVjZpWi9VejVJSVJGRGIwVG95Kzc5VDQ1UmdOMGJoVCty?=
 =?utf-8?B?ajZoTWk1WUFFRCtMQWZrQVd6UE9ad0FrMzNjUDNMZzMyU2paNXE4ZnN6Nnlp?=
 =?utf-8?B?SE1mNkdMMWRyaVNOZVFxSVRpTzJXYjdDRi9iT25ISEd0S3F2WjM0WHhYWHhI?=
 =?utf-8?B?Rk8vUVlOSWVSMzJHd2ptSUJOenRhV2dQMjIxZzFubE1sRTkrQTlwS1NoVkE5?=
 =?utf-8?B?UHNFK2VUQkkxZkJkQ3UrU1BrbG5PYXRiT2NjeVRsOTBVNVZuZnNqdkFvSUto?=
 =?utf-8?B?NWQ0eDF0akhBcEpCQkFBRWt0d0V0YVg5RUUvQXkveVIrSFBJdkZTZlRYb016?=
 =?utf-8?B?aUlySlgzS1UzaTFmcmswUVIyMmdqNW5MU0FqWkRiaEJFbWpoWUNlOEdCK2Z5?=
 =?utf-8?B?UjMvU3RoWVU1cTVsRVRLL1BzRVl0b1MwdTd0Q3cxRENhRFJYQ0c2cDkvZW1B?=
 =?utf-8?B?QlUyRFlPaGhDaGMrZ2JKNnhXV1dDQzRpMER0K0h3cmRCbHJQaWh2YTMrbXhW?=
 =?utf-8?B?NVFEQVkyYm9rcEcyWTVIUWtoQmh3UUJ6M3JnUmZCTmN6UHgxVDduK1lQSXdh?=
 =?utf-8?B?YkxnWTBUbnU3L3JIbUd3cExhTWcwSEFIQUpIM01ZSEJPalRtbCtEdXJmWmV1?=
 =?utf-8?B?NkhoN2R6WFF4cXVSb3Z5MzBTL2M0RzJDZDV1WGkwb2x4T2JTTmtxWHZoQWhi?=
 =?utf-8?B?Y2Fqc3NhK2pEKzhZRkE3NVlZeHU4bTJBN3VhOGVPR2g3Q1hpcFZiZndjYS9T?=
 =?utf-8?B?bFJzeWFDeXNiRkxLU3p5Q2NDM3gwZE1FRHBFYnU1SGQyblg1a0JCaThXMXV2?=
 =?utf-8?B?bmR1cmRBdERrUkUrMGxtak4wTDdOT3czMmFNVnVNdU9iV3Z1L2xKSzM1b3hN?=
 =?utf-8?B?QVhEcHlxU2NDL29Gbmx4NDc1bmFlcmJvSkVNRm5lMnFtY01JWHlIeWt2WUlT?=
 =?utf-8?B?K0RhVUtxY2NHcWh0NGpJY01Laktzb1pERjVCTVV4TkRiRW1kbWQ0Z3IzRFZL?=
 =?utf-8?B?KzZSOEFPYWpaajdlWWJtNndqdGgyMFhrVDdtOFZVUU1GZUpZOUJKK0k0V0dN?=
 =?utf-8?B?TFFqazhuTllZTjdUMC9XUDR2VExtZkh6VlRsdlU2VktqeU5aUkFMbm13OHJX?=
 =?utf-8?B?cEc3OW84ZGdQd3ZCS1ZuaWpOK1NTTE02VWszdzRtVDJ6b0phQzE1ZGowQzF5?=
 =?utf-8?B?ZVhnTG1wdHZvczZ5bXRRY1JWOTcwQ2RGQ1A2aVFRdWtZbDV1ekFPT0t0Szhj?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hw0sgBQk8nlbhNq1LJ8fwfIQQdVVqZUBs03bsiu2239CjfEtoLDXBFTqg5p6kiaqsZtUWw5CqTZd40HCujISOaTHmiVZMiWJCsJXwq6kLnUCkMC0kugu7BB6JY7i2fhi1tHMn5rjEBHGnIGo+GJzwr+hlIfzzasM8JpgFM/8KNS69Ce+6OTfP8jcgppKFYr65WkAGOKGbMy8eLvSdxlWT095REFclwoCrQS7L42205oBUvvKaUfJpmPEMV3eX7ggLQnrcFNLDFn+udmoPlZkSQkw30/wKJ28xmfmLPxMV2jJwpyvuxr91yYhtmQRH6h7flZFzBFwF+/Nu6hLdWvcZclRnPE7vSetM67BiMs+sMXyxtOWJt9SDGSy7MDoftuV2hZtOhrQbKooCWJir/ggOqYMZFYo9+6E4qYyyBPQDeFSVsL4sL/pM49SvUImU4XVGM+xt9s+F8SRrxTe9eOOyWvHWb/fFCKXbhUKV2fu2GXDf+cE+oS/kouEl9oqy60YTl2/m7BZ1zBzjTkl6KrykcmhT4Id1eHV8Aajn32xBF/A2CYPHZzGBYMDeaQc21oXELOINLhhB+7ZUvk6o1q4DDNAIIV7TFb/Ah39iKYIqW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5fb308-a9de-4efe-f4eb-08dd69104464
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 07:07:54.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAhLLI+YZ5c1ATGO8SVRUkR5q06liOwkyrpyfAwH0BipoJ4iGhL84v7gOvBpKc9VfYm2gSnuFmSAv9+MwlfZVuFZwj0/Nh+GKv5zOR9/JDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503220049
X-Proofpoint-GUID: 4Z7psamsM8odkIFJayotgEM4fqL5Nd9V
X-Proofpoint-ORIG-GUID: 4Z7psamsM8odkIFJayotgEM4fqL5Nd9V

Thanks for the early review :) I gather you're not coming to LSF? Which is
a huge pity, would have loved to see you there.

But this is much appreciated! :)

On Sat, Mar 22, 2025 at 01:14:39AM +0100, Jann Horn wrote:
> On Fri, Mar 21, 2025 at 10:54 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 0865387531ed..bb67562a0114 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> [...]
> > +/*
> > + * If the folio mapped at the specified pte entry can have its index and mapping
> > + * relocated, then do so.
> > + *
> > + * Returns the number of pages we have traversed, or 0 if the operation failed.
> > + */
> > +static unsigned long relocate_anon(struct pagetable_move_control *pmc,
> > +               unsigned long old_addr, unsigned long new_addr, pte_t pte,
> > +               bool undo)
> > +{
> > +       struct page *page;
> > +       struct folio *folio;
> > +       struct vm_area_struct *old, *new;
> > +       pgoff_t new_index;
> > +       unsigned long ret = 1;
> > +
> > +       old = pmc->old;
> > +       new = pmc->new;
> > +
> > +       /* Ensure we have truly got an anon folio. */
> > +       page = vm_normal_page(old, old_addr, pte);
> > +       if (!page)
> > +               return ret;
> > +       folio = page_folio(page);
> > +       folio_lock(folio);
> > +
> > +       /* no-op. */
> > +       if (!folio_test_anon(folio) || folio_test_ksm(folio))
> > +               goto out;
> > +
> > +       /*
> > +        * This should not happen as we explicitly disallow this, but check
> > +        * anyway.
> > +        */
> > +       if (folio_test_large(folio)) {
> > +               ret = 0;
> > +               goto out;
> > +       }
>
> Do I understand correctly that you assume here that the page is
> exclusively mapped? Maybe we could at least
> WARN_ON(folio_mapcount(folio) != 1) or something like that?

Ack and agreed, will add!

>
> (I was also wondering if the PageAnonExclusive bit is somehow
> relevant, but we should probably not look at or touch that here,
> unless we want to think about cases where we _used to_ have a child
> from which the page may have been GUP'd...)

Yeah I was thinking the same re: this flag, but given locks we hold this
should not be the case, however you later do note the point that I need to
check anon_vma->num_children == 1 (i.e. self-parented) to ensure that we
aren't looking at a mapping in a parent of a child which would imply a
folio that maybe isn't.

>
> > +       if (!undo)
> > +               new_index = linear_page_index(new, new_addr);
> > +       else
> > +               new_index = linear_page_index(old, old_addr);
> > +
> > +       /*
> > +        * The PTL should keep us safe from unmapping, and the fact the folio is
> > +        * a PTE keeps the folio referenced.
> > +        *
> > +        * The mmap/VMA locks should keep us safe from fork and other processes.
> > +        *
> > +        * The rmap locks should keep us safe from anything happening to the
> > +        * VMA/anon_vma.
>
> "The rmap locks"? I only see that we're holding the rmap lock on the
> new anon_vma; are we also holding a lock on the old anon_vma?

I should rephrase (this is partly because I kept changing how I did the
locking - hey I did warn in preamble this is early :P)

I don't believe we need to hold the _source_ rmap lock, because we
establish a folio lock prior to adjusting the folio so it shouldn't be
possible for an rmap walk to go terribly wrong here.

But do correct me if you feel this is an invalid assumption.

>
> > +        * The folio lock should keep us safe from reclaim, migration, etc.
> > +        */
> > +       folio_move_anon_rmap(folio, undo ? old : new);
> > +       WRITE_ONCE(folio->index, new_index);
> > +
> > +out:
> > +       folio_unlock(folio);
> > +       return ret;
> > +}
> [...]
> > +static bool relocate_anon_ptes(struct pagetable_move_control *pmc,
> > +               unsigned long extent, pmd_t *pmd, bool undo)
> > +{
> > +       struct mm_struct *mm = current->mm;
> > +       struct pte_state state = {
> > +               .old_addr = pmc->old_addr,
> > +               .new_addr = pmc->new_addr,
> > +               .old_end = pmc->old_addr + extent,
> > +       };
> > +       spinlock_t *ptl;
> > +       pte_t *ptep_start;
> > +       bool ret;
> > +       unsigned long nr_pages;
> > +
> > +       ptep_start = pte_offset_map_lock(mm, pmd, pmc->old_addr, &ptl);
> > +       /*
> > +        * We prevent faults with mmap write lock, hold the rmap lock and should
> > +        * not fail to obtain this lock. Just give up if we can't.
> > +        */
> > +       if (!ptep_start)
> > +               return false;
> > +
> > +       state.ptep = ptep_start;
> > +
> > +       for (; !pte_done(&state); pte_next(&state, nr_pages)) {
> > +               pte_t pte = ptep_get(state.ptep);
> > +
> > +               if (pte_none(pte) || !pte_present(pte)) {
> > +                       nr_pages = 1;
> > +                       continue;
> > +               }
> > +
> > +               nr_pages = relocate_anon(pmc, state.old_addr, state.new_addr, pte, undo);
> > +               if (!nr_pages) {
> > +                       ret = false;
> > +                       goto out;
> > +               }
> > +       }
> > +
> > +       ret = true;
> > +out:
> > +       pte_unmap_unlock(ptep_start, ptl);
> > +       return ret;
> > +}
>
> Just to make sure I understand correctly:
> This function is changing the ->pgoff and ->mapping of pages while
> they are still mapped in the old VMA, right? And if that fails midway
> through for whatever reason, we go and change all the already-changed
> ->pgoff and ->mapping values back?

Yup. Write lock is held on both VMAs, and rmap lock for new VMA.

>
> [...]
> > @@ -1132,6 +1347,42 @@ static void unmap_source_vma(struct vma_remap_struct *vrm)
> >         }
> >  }
> >
> > +/*
> > + * Should we attempt to relocate anonymous folios to the location that the VMA
> > + * is being moved to by updating index and mapping fields accordingly?
> > + */
> > +static bool should_relocate_anon(struct vma_remap_struct *vrm,
> > +       struct pagetable_move_control *pmc)
> > +{
> > +       struct vm_area_struct *old = vrm->vma;
> > +
> > +       /* Currently we only do this if requested. */
> > +       if (!(vrm->flags & MREMAP_RELOCATE_ANON))
> > +               return false;
> > +
> > +       /* We can't deal with special or hugetlb mappings. */
> > +       if (old->vm_flags & (VM_SPECIAL | VM_HUGETLB))
> > +               return false;
> > +
> > +       /* We only support anonymous mappings. */
> > +       if (!vma_is_anonymous(old))
> > +               return false;
> > +
> > +       /* If no folios are mapped, then no need to attempt this. */
> > +       if (!old->anon_vma)
> > +               return false;
> > +
> > +       /*
> > +        * If the old VMA is a child (i.e. has been forked), then the index
> > +        * references multiple VMAs, we have to bail.
> > +        */
> > +       if (!list_is_singular(&old->anon_vma_chain))
> > +               return false;
>
> I think this is wrong: list_is_singular(&old->anon_vma_chain) tells
> you whether pages in the VMA might be shared due to this mm_struct
> being forked from a parent mm_struct; but it won't tell you whether
> pages in the VMA might be shared due to this mm_struct being the
> parent of another mm_struct (other way around). I guess checking
> old->anon_vma->root->num_children could maybe work...

Yeah you're completely right, this is entirely an oversight on my part.

I don't think we need to be looking at old->anon_vma->root though? As for
anon_vma->root != anon_vma here we'd need to be a child, and we just
asserted we're not right? (could be an additional check though).

But definitely need an old->anon_vma->num_children check.

Holding old vma lock should prevent further forks, so we could just take
the rmap lock - lock - rmap unlock here?

>
> > +
> > +       /* Otherwise, we're good to go! */
> > +       return true;
> > +}
> > +
> >  /*
> >   * Copy vrm->vma over to vrm->new_addr possibly adjusting size as part of the
> >   * process. Additionally handle an error occurring on moving of page tables,
> > @@ -1151,9 +1402,11 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
> >         struct vm_area_struct *new_vma;
> >         int err = 0;
> >         PAGETABLE_MOVE(pmc, NULL, NULL, vrm->addr, vrm->new_addr, vrm->old_len);
> > +       bool relocate_anon = should_relocate_anon(vrm, &pmc);
> >
> > +again:
> >         new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
> > -                          &pmc.need_rmap_locks);
> > +                          &pmc.need_rmap_locks, &relocate_anon);
> >         if (!new_vma) {
> >                 vrm_uncharge(vrm);
> >                 *new_vma_ptr = NULL;
> > @@ -1163,12 +1416,66 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
> >         pmc.old = vma;
> >         pmc.new = new_vma;
> >
> > +       if (relocate_anon) {
> > +               /*
> > +                * We have a new VMA to reassign folios to. We take a lock on
> > +                * its anon_vma so reclaim doesn't fail to unmap mappings.
> > +                *
> > +                * We have acquired a VMA write lock by now (in vma_link()), so
> > +                * we do not have to worry about racing faults.
> > +                */
> > +               anon_vma_lock_write(new_vma->anon_vma);
> > +               pmc.relocate_locked = new_vma;
> > +
> > +               if (!relocate_anon_folios(&pmc, /* undo= */false)) {
> > +                       unsigned long start = new_vma->vm_start;
> > +                       unsigned long size = new_vma->vm_end - start;
> > +
> > +                       /* Undo if fails. */
> > +                       relocate_anon_folios(&pmc, /* undo= */true);
>
> This relocate_anon_folios() has to make sure to only operate on the
> subset of PTEs that we already edited successfully, right?

Assumption is that we'd hit the failure again at the end of the subset, we
always start from the beginning.

This may or may not be a safe one :)

>
> > +                       vrm_stat_account(vrm, vrm->new_len);
> > +
> > +                       anon_vma_unlock_write(new_vma->anon_vma);
> > +                       pmc.relocate_locked = NULL;
> > +
> > +                       do_munmap(current->mm, start, size, NULL);
> > +                       relocate_anon = false;
> > +                       goto again;
> > +               }
> > +       }
> [...]
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 5418eef3a852..09027448753f 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> [...]
> > @@ -1821,6 +1834,14 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> >                         new_vma->vm_ops->open(new_vma);
> >                 if (vma_link(mm, new_vma))
> >                         goto out_vma_link;
> > +               /*
> > +                * If we're attempting to relocate anonymous VMAs, we
> > +                * don't want to reuse an anon_vma as set by
> > +                * vm_area_dup(), or copy anon_vma_chain or anything
> > +                * like this.
> > +                */
> > +               if (*relocate_anon && __anon_vma_prepare(new_vma))
> > +                       goto out_vma_link;
>
> Is this bailout really okay? We go to the same label as if vma_link()
> failed, but we're in a very different state: For example, the VMA has
> already been inserted into the VMA tree with vma_iter_store() as part
> of vma_link() (unless that changed in one of the prerequisite
> patches).

Yeah I think you're right, this is an oversight (hey - error paths - fun
right??) - will correct.

>
> >                 *need_rmap_locks = false;
> >         }
> >         return new_vma;


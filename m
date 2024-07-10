Return-Path: <linux-kernel+bounces-248005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0886F92D753
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B281F28169B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02484194C6D;
	Wed, 10 Jul 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JaE/hpWc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r375YMa6"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07118FA02
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631905; cv=fail; b=W4cNjrbLA9T4dxWAMuC3xc06fmv2KfC+WuSto5BxHhCPPuWyjjhZnWonE7ZK1XB43BIFBT7Xbi0qa6gsSJHajRaQot8gBf1oIAvzMENOrFBj8pqCBvS028n1APxBzqY+UhMbeTqu9YmZLIWyfxM7jCo5pmHo2L7S3VVAF7dHCfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631905; c=relaxed/simple;
	bh=IHS4ibCqjD1PrkLy0ZcnN7UgGuWaTmZfr7tY3ppwYSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iU/6moa5N5t9tnNWjeyOpYjSlLBUva+Uyk7matOHULhSjn7OFbU26gU3oCc1NLhnmZB2lnXoaf5r3FLDl2RaLNz05zGdZlfpFN3GRV8XQ9wnHYvhjLXRD7PpG0lxOZloMrEiO/OcRhZf5Tr85eoSzuhUgw9q6YBnckL+eSE8xP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JaE/hpWc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r375YMa6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AG5RoM013754;
	Wed, 10 Jul 2024 17:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=Jke2cPjBtp7lshhqGRC/m13RPybvHGLr/k2JOc4pBr4=; b=
	JaE/hpWc0MN1F9PRqr1s1RHNRr9Z7eGNVLAzr9wzSCfhwUufWbLvp2ubwDwrEyFQ
	x2dSzDDQ9D5K9UwGTWLcUt4vSqPZyfx9XIK0l3kghFzjsLcta6bl1KhJerZXvTwG
	VSTu11RciMPHeAA2H6DksCT+xjkSfezFz5mhceuq5bOmdsNPKtF4cNue9IWuDcDU
	oNVAtjrBbTL5dIw+9OwAAg5EZs4VvV5F3OAHaqSe0nQU+N2+ctPCwNt4tMvku3KD
	z1w19MDQQBlbGCjV7LKwxD8cioTh1tJ3FSImm71a8W01eBD/JW4gnuaz8sChrPCQ
	qQm1kwUyIkhjzLe3BxIdYQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8fq69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 17:18:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AGvh9M010348;
	Wed, 10 Jul 2024 17:18:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4mn4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 17:18:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awE5WlnQoPPdgFGizLGr8g0ODOV7Zh5czQHbcDHS1elFseyIBgJiWOai9bgUffKjVm1FDfqGbxhMSoXIEPcTaEVF4PnQW0OcKTzPUShSDjmaornUflcao0qycZ/qaUC4fsrOimOjTXJVhxm2YD+uQskhmo6u+Uz11lz9agFRP45KlJyh3xS0KNT+/EcthSDdbHjf+cSeGmisMyIip7kbtmtzpVMSCKD2H5KgHox4XvRMdzfwkerIV6EeDN0FnXe/PWdhLNxdCFYTcUyWYz2ME0IAgqf8PLdd5ZLKc4GldoMVMptI8/LFiVCr/eQwnz5WH2c2TNBJfQnoUBBQRyUGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jke2cPjBtp7lshhqGRC/m13RPybvHGLr/k2JOc4pBr4=;
 b=bIa+DJI4XNFIVobQVWaL1T5zJ6+u71GbkhHH7fnfsW2s6UadGZ0cpeGCNBjzfLDMvPN781eB1Q2h7afESo/esiGgCjpCDygBxBHD9lidwKkJVAhTGUL0uFvK+8Hqi7VY4h0pkHYPxxiM7kLC28b0zFbqdKfu/ZJWUOdt3XjgQljqBDPEjckvT3KqE8aVd5EwS/y3nygsBZz+CggdmUcLOehDtHhmo0hl7suC9SRL/uogSgxy3dxNCcqqmpDNHEfXv1+q8i5ZsuZV6MkJG8STZb1qsZ9qc2EwJ9H+/CyU3NBeAaC6Xh8PHD5Wsc9ewEVz4yFNuaJJXfBGcpqZC7Ltkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jke2cPjBtp7lshhqGRC/m13RPybvHGLr/k2JOc4pBr4=;
 b=r375YMa6FahvBh2SonjW+zTPOriKXWNlM3cTHJ4owPuwubyXX6ceVV5UUmljkXmTjfjqPt7fRVtTtVr9wet4wnHKraB+SnDf0dL6zUSD3S1tNFCWZi1uJpBWEweCB7nqY6qPTDRR/byUt7/jl/WzDuPJhSIyipBXIpFmiOHpOjs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY8PR10MB6491.namprd10.prod.outlook.com (2603:10b6:930:5d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 17:18:04 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 17:18:04 +0000
Date: Wed, 10 Jul 2024 13:18:02 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 10/16] mm/mmap: Reposition vma iterator in
 mmap_region()
Message-ID: <ftfdjb5qindsjv7c5edvb5tadp35supeh5qnigel3qtwwkfhw7@smfi3f5y2fnj>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-11-Liam.Howlett@oracle.com>
 <CAJuCfpEqJi30kz7Q0ZAJqkDuQH4ng8Wa+x0sK10wVbtQ9wF6dA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpEqJi30kz7Q0ZAJqkDuQH4ng8Wa+x0sK10wVbtQ9wF6dA@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY8PR10MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: a991f472-00e7-49be-f5c9-08dca104427e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dk11TmRScks0emhieWwvTlZzd3NQUm5GR0JyQWM5bDNqZUxKTDZGTzI0NVpF?=
 =?utf-8?B?QVZTSGErNzh0QlN0WjNRendtaVZoUENpSWh4SDJsaC9oV09HUzJFTjJ5OEpX?=
 =?utf-8?B?ZzErWXNsUjkyTHRBSVRpaWlLKzRaaTJrNUNzam5GYkJ2M1o0ZUNrSmpJLzY2?=
 =?utf-8?B?dlFScjZocDdqaSs1bUxzODljQjA2bUljdm1YRkNDcVNNczIrUXcvQ0FJeEwx?=
 =?utf-8?B?V3FSTFlSZ1FQbDhhQlFIOE5JNElhSG44aHdyWmNFM00zellqNGZoTWZoZWYr?=
 =?utf-8?B?OStlMklBME42KysydFQ2WERhb0tFVHdvVWQzUDhOU2Z4MFZZb0RaWnNPVjU4?=
 =?utf-8?B?T2srMjFkL0pBZ3RvaWNITEN2TnhsWW0wWms3OHRwbHZ3SnV6TVMrcDNjUGhq?=
 =?utf-8?B?cFE2bWgvRmROTTR5aTRHRGZjblJTZDAyWWxZT0xTaXphbSt5LzFvc3Z6TDU1?=
 =?utf-8?B?eFRVNVl5NzlYd3RhdVRZdDd5ZGJxZ0tyUVVNSllxZnAyZzBHcXBIbW53Y0U0?=
 =?utf-8?B?RTdob292aDFSWDRDNVpzbjZKNW5HRS8xbmJNcHB6WmRSTUtNdVZYUU5ZdlpT?=
 =?utf-8?B?bHBnVW9IdWVPWXdmUTJJcHJCS2kwczBLR0wwek9BbXp1ejdPSW5xRDZLL0VV?=
 =?utf-8?B?NG9qbUpXMjlHTCtTcnU1Nm1rV3JWaXd3ZjE2OGtLNjhtN2U1YUVoSk1UdHBW?=
 =?utf-8?B?d3FFdHVPWXFjaTJpUDNkWkMvZnRQMnZjMjc1MGZkeVdxSmczVU1HZXMrMW1N?=
 =?utf-8?B?aTRjQ0VhMkUrOTFRdkV2VTRDNzVBNUhDaEFLQ3dzbmFPRnVoTS9FK3dEZHRI?=
 =?utf-8?B?VVczK0dleVBYeHJQVWhybnlmL3laYXdLSVp1Zm1abCtKazVWaE9XWnpTdVVF?=
 =?utf-8?B?bkVjemZDQ21tSjd0RUxwU1Q2V2szdUNmUW0wcnR0Q0FiSEdKbUlOWjV3QjdH?=
 =?utf-8?B?UDgxREJvOW5CVzBZbnc2aDBaVzBXVDNtNEZRaUxTTW41VHltQkQyek05OTBi?=
 =?utf-8?B?Wmtsd0FLUDM2NXlvN0lYU1hnVnlDY3g0L09rUStQUmtDU1ZWWVdOWHE4eCti?=
 =?utf-8?B?dW9yUnhUdTBHaW1KbkFCTUZnMjRsdm5ycS9STnpzc0NUTGlNZHJZdFNWdDhw?=
 =?utf-8?B?dklscFJpbGF2ejE2L3V3Rjk0N2RVOEo5UFZkSGswZXFtSzU5YWN0ZWt1S2dv?=
 =?utf-8?B?WDhCeFRFNytnZFg4WVRiMDU5bWlXdEhIMkcrTk1Bc2dYYlRYKzd0dmV6dGpi?=
 =?utf-8?B?VkRKcllsNkQzdkQzakpKaXU5TVB5ZkRsWlRXNDRDc3JkTm1JYXR2K0c4UmFS?=
 =?utf-8?B?NzkzRzU0Uy9hbWYyMHlhSzhJRzd3RTYxSm9oMmhxY2ZlYVo1N0thNm9kRllv?=
 =?utf-8?B?cVNqNG52SmZpSlVjcXY3Vk1zdnhOVG44ZTlqZm1UellKYzc1blA3cFdYUkgv?=
 =?utf-8?B?ZElYUDVHbFRhckVyNmJKKzM4dWcraEVkOGZEQTdGUnNDZCtaSU93QzRmWndZ?=
 =?utf-8?B?VmtNVFV0N0VGSkE0QU13bm9DUkJZdU4rS1R1dnJlRitwd29ybmcwazRLRUs5?=
 =?utf-8?B?ejhZSisra3VLQ2o3aURjRk4vRHJLNFRXUEcrUUgyTjdmcXRYUFRBUTRDODRR?=
 =?utf-8?B?MmZZVEhxUW9VT1hiZUx2ZmFOZkVVbXg2QTQ0Y2xXajd6eWNzZmg1V1lHdG1v?=
 =?utf-8?B?L0RHSmxnMCt0RUk0MzdYSXBVMHNDTGpyYXJSMnNXOGVsMjFab2hNRFZRRTNG?=
 =?utf-8?B?M1lDK1pkRy9mNlNrTUl4UU9nQnFLWnpzZ1hLZG9ZRWNncnJZQkIxNHZEdDZS?=
 =?utf-8?B?OVVzTlFoZUFLQ2R3VmRoUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZHFwNXNTU3M3T0l3bXM3NW1mSEgzS0dMdVJHTmNBNy9XSXZHTUZCWTV2V3o3?=
 =?utf-8?B?bTRGTmVGanlyQjYxR01aMU5IdTRaVlZKeWxDY1FyTEN5dWp5OHdyMlM0U0Ns?=
 =?utf-8?B?blB2WUhhMTRia2tRN0hud2JWRGJ4SEdicG9wc0tLcWxocS82Ynl3akRyT1hK?=
 =?utf-8?B?d21KRHdLbHUzcWJDRjZqdXltZG5LcHBrZzFFb2lNdk1SODhvTTN5NVlOM2sw?=
 =?utf-8?B?TTZySWwvQWF3RkdaUnVKaUJsS0xYNVBGeDlkZkpjVFpDUnI2YUZiUy8zdytn?=
 =?utf-8?B?UDZmdHdwby9rTWZGalBrM0V3bmZIbnFYTEJxR3VtUkI1azVsaGxhSFlYZ3RX?=
 =?utf-8?B?TmtaN0hUQWdNaDJ6SytYMWJpZ3B5ZzNLS2NXYlk0S1I5TlNrNXRYZDZOZlNH?=
 =?utf-8?B?bTF6dmtyTGdYTWhvV1MyZG5mOEM4UXV5WnBOcG5MajUxNVlEU25aSWo0cjV3?=
 =?utf-8?B?VUVxWWFPdDBJSU51Z2huMmVyV0FmSDB4M3pVNmwwcnM1bGI3aTRHTm9sNW9h?=
 =?utf-8?B?bTZJeUV5Q24xTEJrbG5YNEk5QnFrOXFZdEdkSUovYk03eTcvWTYrekpTNFZl?=
 =?utf-8?B?cG1WNWxHczYrcW5QWXBRUjlhZTZYanBoaHlEbnd1UzJYR0d1bFJBbVNYc0JK?=
 =?utf-8?B?a0ZSVEYrcU53V255dEhmMS9JUUIvbUJ5NVR1amlWWGt5bm1qcVBEYWVPU0Rm?=
 =?utf-8?B?QXdvNmhxSFcvNU8xVmUzekpqOXZHUStxL3R5eDVpRWh1eDlNNTh2ZjRTV1M3?=
 =?utf-8?B?MEl6alk4V2pQcmR2Ym1Vc3BmM0hoZzZXeVhKaWZVNkxKTHk2RnBUWHRzS0lq?=
 =?utf-8?B?UnpKTUdrNjlZckFTN1M5R0hNUkltTThSZ0dGMmVzTUNGNkQ1WkxmQmJiU0Js?=
 =?utf-8?B?SnJwc3ZzaXlnREdiNXV3d3l2TC9lVmJFdjBvNEJDQmFNSnJMaGZSNTJuWmpz?=
 =?utf-8?B?cFhTbFFqYlNMVE5CcmNCVGpmYmdBSnFSQzV6L0c3dy8vQWc5MVpiOG1QS0RI?=
 =?utf-8?B?VXRMeGFkZ2dDODRscTNGOXF1NTZyUzNudmprL3FZNkdyMkt1dW1Rb3lTVDNw?=
 =?utf-8?B?Njk1ZG9VWE8xYUljZEVES2wzR1FKNmhRaFpTZmNNTVFCblg0SUVmdlpiUlhF?=
 =?utf-8?B?Z3RxTG5ZT1Ewbml0QnF5TDExUTFNMkFldnppMXFnd0pwTUdMKzUvRjlzSk05?=
 =?utf-8?B?TUR3Rm9BWmpUdGtDbi9EeFQwT3VZalE0R3NWMWZrTEovVnZXbnB0alZWR0dx?=
 =?utf-8?B?V2tOSkVONUdDQ3drQ28wMFVLZmM4WllMWGJyTWxuNVYrek1mc0l3aExjU1BS?=
 =?utf-8?B?Zm10SWxuRmFaQzI1bWNGclBoZUh6R2Q3QytQWDNzb2h2R05oTmRVOXl0SlBi?=
 =?utf-8?B?UVN4aHRKVWp3MW1nMy9sTDR5NHhsakhMQWYvczYxSHJQZ2pWY3JMb0ZDWm1J?=
 =?utf-8?B?aW95MnBCQUp6SENJeXhkRDhMNHRXa0lhbmFuM0JkR3ZMK3V5cFhMQlBwVUtI?=
 =?utf-8?B?VmNPS3huN0JKb0RTYytQdFNZRThGeHpzUHdCSDAxcTFiUzVRRFM1VDRZRUdx?=
 =?utf-8?B?S1lxVk1XYVhocXVBdCtSTGg1QXNSNW45YXFuRmpVcVAxSFQ2akMzWGVqdEtl?=
 =?utf-8?B?bHJEbVNlLzlkM2Rrbkt1TUlUN2FrNEtka1lTblVoS2ErNjBQbTY2bS9QMVFp?=
 =?utf-8?B?bXBWVjNqdkVuVzlYR0tZUDR0N0tUWGsyNlRiTzdaUUtsd1V2cFVOYTIxUERS?=
 =?utf-8?B?d3V5VUlUVGYxTkpUdXdwL3owLzF0Vi9xcVg5TmFweUQzVk5xUzYvbTJnZ1dn?=
 =?utf-8?B?NVpwdXlwSS8vTFF3TmhjMGhmOGZDRVJzelJ2cEhwQzhpQ2dIWFp3azl3VUZY?=
 =?utf-8?B?WHVkN1FkT1hQR2M3Y01UOGxGYXpvQW1HNEc5QnBFMUhjc1dURWpVRGNyREtx?=
 =?utf-8?B?Q3EwaG5yRHJkbCtkelcxNXVBbjNBUnpyR001aWVONE1kLzlGa29La0pSZTFo?=
 =?utf-8?B?enYvSTFNN1hIcGlhekxsbmd3a2NXMXBhcEJacXNWSlpEdk5sZjNpcEpuVGov?=
 =?utf-8?B?YktXUjBKMlQ1SFBaSkJxWjdybGt5L2V3NzV4Y082T3FBNjVaQWNUUk9xcDdw?=
 =?utf-8?Q?kpZpP2CWcUkl8cTcOMt3IuB5g?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BfoLfDkrF+/OMdA0j9kDDDM5hNLWA8gSsHTBQC+koLiXvRWhNQLZW3KMz+9B+HHNp1vLk6yLyDm5c1dGxV2NCQXjNaCZVt4IgJxFpyL11ix/jZj0ofSS7jXu1tHpzxDVl21oqCahnIO6TKa2pqrcoS6KWTHY5TWvRo7bRpPaGPieKtKHvhPUvcWLl54o/1IUmFjItF3QhwNCRmEVl6OzqBUuU8DtfUpaQl94TyZYFzYtE5Qg8tr/5b6Yasd8Dfin5u0pVCtaNAAXCkmIvkWtoec8uSugZtB30XeT8mgEDALkaBdp8YHQJbujb34vkJBALAZmZYrejK2wo98Jfnat1O3F44faMIoiF6WUjYTbWFmNUYsZ+mbRHMqBVoWTHzGfllxb3frZ8M5pxLUktVd6t9aiVlHNIccHlkW25gWfU0ymsVtn81jOKX+QgvCZ/w8pp9CrH2L0QLcMFzRbzUKtUg0aEOvES/hbOXuKR4hzRlRRk7Bb2+kg8zDsOyrVXK22XfpQ8J7LclCewRJcGSx+OUPDer2sKe0fCPTTpnbEv+osHHeG0dulIKO9Ist9PMN1467FqcJFeMY0rlcJrZ5uNCq4R05TZIiVz5OD4oLoFO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a991f472-00e7-49be-f5c9-08dca104427e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 17:18:04.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X33DIg5lDXqg8t/FpNhNHxVb/Xdg0CsQkyhpZYv+Xm2xOUW2mGynMOpVZEUj3e2thlrbcEmljsK1lO/ShSxy1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_12,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100121
X-Proofpoint-GUID: FXZNDYxLM6-u7xLpkXg8dBR_YfYomvq1
X-Proofpoint-ORIG-GUID: FXZNDYxLM6-u7xLpkXg8dBR_YfYomvq1

* Suren Baghdasaryan <surenb@google.com> [240710 12:48]:
> On Thu, Jul 4, 2024 at 11:27=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Instead of moving (or leaving) the vma iterator pointing at the previou=
s
> > vma, leave it pointing at the insert location.  Pointing the vma
> > iterator at the insert location allows for a cleaner walk of the vma
> > tree for MAP_FIXED and the no expansion cases.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index f5b33de4e717..ecf55d32e804 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2963,11 +2963,12 @@ unsigned long mmap_region(struct file *file, un=
signed long addr,
> >                 vms_complete_munmap_vmas(&vms, &mas_detach);
> >                 next =3D vms.next;
> >                 prev =3D vms.prev;
> > -               vma_prev(&vmi);
> >                 vma =3D NULL;
> >         } else {
> >                 next =3D vma_next(&vmi);
> >                 prev =3D vma_prev(&vmi);
> > +               if (prev)
> > +                       vma_iter_next_range(&vmi);
> >         }
> >
> >         /*
> > @@ -2980,11 +2981,8 @@ unsigned long mmap_region(struct file *file, uns=
igned long addr,
> >                 vm_flags |=3D VM_ACCOUNT;
> >         }
> >
> > -       if (vm_flags & VM_SPECIAL) {
> > -               if (prev)
> > -                       vma_iter_next_range(&vmi);
> > +       if (vm_flags & VM_SPECIAL)
> >                 goto cannot_expand;
> > -       }
> >
> >         /* Attempt to expand an old mapping */
> >         /* Check next */
> > @@ -3005,19 +3003,21 @@ unsigned long mmap_region(struct file *file, un=
signed long addr,
> >                 merge_start =3D prev->vm_start;
> >                 vma =3D prev;
> >                 vm_pgoff =3D prev->vm_pgoff;
> > -       } else if (prev) {
> > -               vma_iter_next_range(&vmi);
> > +               vma_prev(&vmi);
> >         }
> >
> > -       /* Actually expand, if possible */
> > -       if (vma &&
> > -           !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, ne=
xt)) {
> > -               khugepaged_enter_vma(vma, vm_flags);
> > -               goto expanded;
> > +       if (vma) {
> > +               /* Actually expand, if possible */
> > +               if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_p=
goff, next)) {
> > +                       khugepaged_enter_vma(vma, vm_flags);
> > +                       goto expanded;
> > +               }
> > +
> > +               /* If the expand fails, then reposition the vma iterato=
r */
> > +               if (unlikely(vma =3D=3D prev))
> > +                       vma_iter_set(&vmi, addr);
> >         }
> >
> > -       if (vma =3D=3D prev)
> > -               vma_iter_set(&vmi, addr);
>=20
> Before this change we would reposition vmi if vma =3D=3D prev =3D=3D NULL=
.
> After this change we don't do that. Is this situation possible and if
> so, will vmi be correct?

vma =3D=3D NULL can happen if it is a MAP_FIXED or we cannot expand (no
prev/next that match the checks for expanding).  If there is no prev,
then we can have a case where vma =3D=3D prev =3D=3D NULL.  So the situatio=
n can
be reached.

In the MAP_FIXED situation, the vms_complete_munmap_vmas() call will
return with the iterator pointing at the range of addr, so this is fine.

In the other case, we cannot move the vma iterator to prev since there
isn't one and the vma iterator is left pointing at the first range in
the tree (0 to .. whatever) that includes the addr.

So yes it is possible and yes it is correctly positioned.

Thanks,
Liam


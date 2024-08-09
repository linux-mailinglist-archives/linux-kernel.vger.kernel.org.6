Return-Path: <linux-kernel+bounces-281478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C11C94D758
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E165928295B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7AE15D5A1;
	Fri,  9 Aug 2024 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HcqTscyu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dDhHCp0I"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483AA2F41
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232064; cv=fail; b=ThOfguGtX27/QI5T+vokphWsDopnvdkRX9eFXNiq9DhfZ/XKHdrKgVORUz91TWezckjjUEkez8peqCnBRLOTY9BW2G3u3p/BZBWbf3GIxFiN35yiB9EbJKjJOG6NoodFYLMZbpyyU7djpgFdBwE7+cwTLpFoGKql13luL+9jP2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232064; c=relaxed/simple;
	bh=qGSd3nUVqlK6NwVmaXOyunpIKYhIAthvURqVdPrxybk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r2bwxIr0EdGjhWHLNoEgtsKVHMoOE+mmblKjw+5b0HMF+9trMHl3GfmDEQRy4VCTgb7dzqrX9uSiG6MY+vSzg3JUSDl4VO1YfP5mhi/mH8twDNYvagYeg1M/k9ZJzXp/pzVsxl+ktLiDx1MCMp08l7dgeHn14S/cZblj5T3khLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HcqTscyu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dDhHCp0I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479HtWUv029543;
	Fri, 9 Aug 2024 19:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=hF8hyNQWTNS5CwSIiOVmfJluaG139Xy8etLFSo8Si5c=; b=
	HcqTscyu9HXDwj39rr8Vqa3hPBZ73Ke/ZCSmestMRoJqxN/vPFKaudxvmQn6WBeb
	O0OrkEctb2llL+NamZ9u7D6CRJ01Ob33YyFv8rI5xOhTTRQe/dgQ1FZC2csaWsA2
	h2dSp/WmkhaWQq2BJGG0qH4Cx6ZpNY6yCgK7AI5J78AjU4yBH8Lu/ySCVvp1f3Wk
	lyrkXiwPWnryKT+HwEBYFHjwhxHENhokPXfMWwD0R+NYdGFWZshOodR11DVUaox1
	eyMD8PG+YVovIIsGh0Vhgzbq2LQgvTHEfU7dgjV2ob9MU1uqUuOu6v1AiUaD5WrL
	EtZfeQi7l7t2lNTlY5axDg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sayech1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 19:34:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 479I4CZl021837;
	Fri, 9 Aug 2024 19:34:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0k98h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 19:34:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBZwob+nq8lFjRzBsC6FZcS4sZezD42C3Rx6HczfocXUm1ZBdlGMUvCIFc/uUiXBssYksdoDIETLMHkMKbLxOqDfqFAq0xTM+/3yAz+khrCQHmhCnW30H21+dsxkhmQNMy17wKBZdbsRcpu/llMvv/0j+LGnBW4TLLMSUyU4lPtIybWKMQs2dtTfTL5b62wft8/leMbrzY1UDnPg6RQejZMQ6Fw7+pA2FwhZ/BbZelLVeiKlukenOD6UqBv8iGb+5dN9RdJwKdNU8KA06ZuwYJxGKNBidDTf+mDMe2K7RDoi1CDWSFQOFsYTcemCxMNGXuORxmRXFFbc/7yKrkWHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF8hyNQWTNS5CwSIiOVmfJluaG139Xy8etLFSo8Si5c=;
 b=T4hnap3M+/snlSbUdvIewcwO4WP8qGpuR3mHyo8ysxCf+AMud+OtmfXsv6HcjnpztuMusqq/lDy4a9/hpD+CK+e52PhmIEMU0J0mS5cYSopOQwaxYlB0W+vcP7ydwwOfoF2eKVi5BVjQiBLXWQvxQjgd1kRP2XgJqFqgl9fs1ElF/qxkig58VfjGRig3AkgEufvHlTKprqgkCpeq3//k378J6z1R+k/Otg+SCTBlY7Txd6QwJgxhKgqdVZEQdEbLhnnSIMYBU6IXB9trAfJYaUDfchNGxZM44Hs9CeZEGf2y0XzpwrOQPpx9RVd66U5izFLrFlMymnoIvCorcSW+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF8hyNQWTNS5CwSIiOVmfJluaG139Xy8etLFSo8Si5c=;
 b=dDhHCp0I9Ce14E2fUqYX+STliCQCK0sfObOkzJ+VBFMjXQBz4UTJrwh3gBWOBAoNgOFa8L0qWUi9QgqijIYgQH0UnU3uB6d1JZfXtFUVB8WV+oFvUpI5uoD0u6w5h7UdOTv9NQkL3xSWBswpWDWZO+xRV+96Bj3cjjWuf7ComeY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 19:34:05 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 19:34:05 +0000
Date: Fri, 9 Aug 2024 15:34:02 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@google.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
Message-ID: <w5wa3pte6gy4z22jculy4236q5464sij3ndbwvmfmq7ssgovbj@hthui6davlv7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@google.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	oliver.sang@intel.com, torvalds@linux-foundation.org, 
	Michael Ellerman <mpe@ellerman.id.au>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240808161226.b853642c0ecf530b5cef2ecc@linux-foundation.org>
 <CAKbZUD0_BSv6KOgaRuqjLWGnttzcprcUu5WysSZeX8FXAvui5w@mail.gmail.com>
 <CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaATo+-8MuRJ-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaATo+-8MuRJ-g@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0229.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5821a8-8a0f-4e6c-703f-08dcb8aa3ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEk2cnFuYW5lbE5ZQzR0K0JNNkhHTGdJNUhObldyajNqTmZWQ1J4cUZZcmRG?=
 =?utf-8?B?Vmc3NUwyQXZoYTZ0b1hZR1lqRnVhb3RZK2hxUFZHSEdlOXYycjJIZEViZFBs?=
 =?utf-8?B?bFFFTEhTemV5c2RSSGFYM2tiazR3a2p3WitKcCs0cWo3QUh3ajBnamZrTHo1?=
 =?utf-8?B?RDhPWFJ6WThnWnBVNW5pUDdpeW5JUVllSjA1VmVTTXFkSVpLVUVoQ0ZlL0ww?=
 =?utf-8?B?SGRvVWN2QlgvUmV6ZHJKUndjeDRzQlpxYUF2eEVGSXJ6MXA5cVZDUkhWZGZx?=
 =?utf-8?B?YURlYW1Ydkc3Rmcxa3dIeSsxZ2RDa0hFVWVHVXlzajIxcTdzazhYdTVOeEMy?=
 =?utf-8?B?dS8zWmdvc050VFk2SWxnbDI3SGsrOUlnNm1MUlBNY1R6MGdsTmhYd0hpNVZH?=
 =?utf-8?B?M01Ydmd4WXAySnl2TkV0b2xiNVkvUkluY1YrR3NnbHdxQWdpK0szeU50ekl2?=
 =?utf-8?B?UnZwVEJ4STNVTTJPaW1xekpnSm12STdNMkdjWkJYSDBobFR2YlhNaWVwdTZ5?=
 =?utf-8?B?VUl4TUExOUFmM2xPcUF6bS9hbHVmdElHVHgwSHRXc1FoZi9KeFZQMDNjUXEw?=
 =?utf-8?B?YjM0YkRJcUt0VFlVUHRiVWZ0a0YyVElaWkNuWmNqcVNxaGQ3NU9DVVVidkgy?=
 =?utf-8?B?QjZPVXcxb00xY2pJSnBONVFCeU1Qa2NSOTV4RWFObDZ5ZlpUUmNFaE1IUmxv?=
 =?utf-8?B?eWFxMmwxTEUrdlpRZUxyUG9wSjlQNloyT3owL0lpNjFmbEZLcFRKM0ZtUS9I?=
 =?utf-8?B?OWN4aDhhRFhmb2xvWnlZVm9RMXo3S2l0NVJEbWF0S0VIZUYxbzJySm1mclRO?=
 =?utf-8?B?TEVKUjdjR2RUckVhenNXMWpMQ0tGOWJIZnZkNG80QTBIMUJNZ3FLaUNDYUZK?=
 =?utf-8?B?YUpBOTJGTHZvaWtBbTl5MG5KTjhnZVU2MWRKQ1MwTUQzWFhpaDlzVS9RWHli?=
 =?utf-8?B?dEx2YkdrUHRTMjlFMDVVNjNNdTN2cHlLZktPYXRVTklTejlIV1ByTk9XR1Az?=
 =?utf-8?B?Zkd1OG9nelFjb21QNzdyeWI0MEpSOGRkL2VHUXZQYkdBMmZwZVM1TG9iano5?=
 =?utf-8?B?aFN1bzJFTm9oNEdqQmM3TFFrRllxNkhyTkRCUVNnY3hlM2NBbmkrSEVENXpN?=
 =?utf-8?B?Y05UeHlFdVY4bFNUZm4rN1VFanhOZHVITm9jRXl0VC9ZZTNKdmZHaDdLRkFz?=
 =?utf-8?B?bXFnZ0pXVnZnbi9SUHVTenNPVmdpb3VMdW1xdlptdDZDRFVSQ045S2o5T09u?=
 =?utf-8?B?S1NUU2tnVlBFSThDRlhLQnRyUzRoLzJTMkp2QjAranVMZXJleVkrek1nTkVQ?=
 =?utf-8?B?NU5RUFY3VE4vN3ZoeFNrL3dwMnZXNGRvbDhhcDc4bFZQYTA4MGZaanpxUjlU?=
 =?utf-8?B?eWNaY2FnMmlVdUhWRXdJVG03bmVFQ3NhWWkraERtbk9HVlNqdGlBTVdUK1JS?=
 =?utf-8?B?V1hGM2MxOWxXdGFUZVNlZEYwRTN5bUNubGV4bG1Sa2dXTTI1QVgyRmpRUFlk?=
 =?utf-8?B?VmVsTnNwN2laRFlNU3BrUW9VRnlQWXFwb1UxbTIyQVdVTEtId0xXWTZFeHBx?=
 =?utf-8?B?TXh0b2FDWk1RR250cmZVczlSeUd2dXV6Y3lEUE02ZnZubGltcGRQemhYOVlK?=
 =?utf-8?B?S1FMVUpPeU1CWjVSY0hzK1BiVUJXNFlJOUxlajZ1ZUJMZDlkKy8yem5LejJw?=
 =?utf-8?B?ZldFQ2dVejZ1RHAvZmVTSDJOdm5nSm9JWm9SNWFhVXlBdkNaS1RtTXFFeVNG?=
 =?utf-8?B?M1BkZS9IcFVoaUpldkRSWnNFbm8rKzFoMFRDQnFOUFV0bCtwLzdieWNUTDZM?=
 =?utf-8?B?eVcrQjlpWi9GSTRDN1ptQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRwTFp3NExTclFma2FLWi84UEs1YXdYRkRwRlhJS1owZG5qTUZ5Z25zVENw?=
 =?utf-8?B?ZGNvYWZETzgrV0JPWDltcW4yeFpsWkxQZTdtZXZRQmFBZnlwQVRDcG5KekdD?=
 =?utf-8?B?dGxFbTRkYWcxWFpraEhBQnl6WC90VzEyTTJseXZYMVVzU2Q2T25LaUtyWHdr?=
 =?utf-8?B?Q3FmeS9pOUdMcXpxSEdsWEhtN0V3bHJybVd2S2RCYThKa0xEWVNlZ0VRbGNa?=
 =?utf-8?B?dHF4WXROU2ZRa3g3bUtzd1h4dng1YUVoTHIvMGpRQ1pRMGxhRVBVRHczVThI?=
 =?utf-8?B?dGRCQzgzaUQ3ckl2eUxyQmFxS1RGVTg2WkpHUVR6RnpLbmk0anF5U1F2SG9J?=
 =?utf-8?B?SnpSeXUrOHZUNk11Y0t1bzlwcTVBc2orb3JMS2p6aytkNzZDM0VpeThIRmtK?=
 =?utf-8?B?dU5uV2VUTW5oZi8rTFVSNy8zbkpBS2QzN1lISHB4RTFpa1VHVXRpR2xMd3Y3?=
 =?utf-8?B?ZU43SlhZZTFvc2lEMlVBaFp6bExjYUNRR2V0cG9xTTNGTThWMjU5Q2w2ejdv?=
 =?utf-8?B?SnNzZlVoM2ZYR1ZaUGJlcURyeFFPbzVoWnBXZ1Q4Y05ZM09VOXpaSEZ4MVdy?=
 =?utf-8?B?N0c1MWZKcDJUYitTbUU3NU1NUEpOckd6dmZUR3lRQmJ5Y2I0N21NbmZpVU8z?=
 =?utf-8?B?SVRTakVYK0M5VUJ1TXZadVB4ZEFZb0dTV2JNcWNFa0c2V2NpbURlaWlhNTJR?=
 =?utf-8?B?R0VIQkJETlRHYVVmcStDWjAxaFdxNWJmbGwwM0pnVjcvc29IcGpsWnVxR09Y?=
 =?utf-8?B?WVNkano0M0h4ajhGbkMvSXFOcXF0cDF2dlVOK0Q2OXFjcE1RNmxVemg2Yjlk?=
 =?utf-8?B?bThKZ05iRTZpSnF1R0dGV3QyVW9iN1R1UWhxcGpGM1ovY2pObnNRcmlXUXlj?=
 =?utf-8?B?bER0R1owekdSRVptK1dVdkhSckpLRmt5Qm40WlkwUVBBa3F5U0hRL0pObVg3?=
 =?utf-8?B?K2lzZURjMzUyazN0a3daQjUzYVZJeE1VSVJyVm1sSEhBa0tRVHdxSFdpNXA1?=
 =?utf-8?B?ditlU2pHb2s1N0lSeGZsbEZITHFtS3BrWTZXU2h2Q1g4eFhVM1RpTlBtTFR5?=
 =?utf-8?B?SmpSMkN3cFRyYkkzSWJvMStraXdmK3VqZ1B0amw0bFJpZ0xxK1F5MjlWcGhL?=
 =?utf-8?B?VDhVRm05S056WDJEYUVXZlFBVzhYS0JyN1pGS21Eb3ViUFlrcjlIZGJkNXdG?=
 =?utf-8?B?UDBEWlR6d1VPOXgrQTdzb2VxZnNyVGgxYXo1YkxnT08wVlZNVE1DclRjbGZr?=
 =?utf-8?B?alY2dDZieHlRK3FNdjJpSG94dW9RVGpZaHMzaUJQSDl0QkQyQ05MdDNUVWFD?=
 =?utf-8?B?d0NDakp2cXQ1bFFLTzJZSStNTEJBU1g1TFdKQTJGamR4QWRWQVJzSkRMRXlQ?=
 =?utf-8?B?NTZ2MVM3ZXI1M0Y4YXU3WmZ5M2EzNVJMdXpmQUY4bVBXbVpUWWdJOXZYOWdU?=
 =?utf-8?B?ZFZmSGtNNjQrNHJqNEdJT1I0VXRmelJTQ3hMVjlaTFFjeEFFQnI3ZXFmOGcv?=
 =?utf-8?B?eFJzWm55MGpCYUZUSmphV3JTMVVXZVVoQmhwa0YwdzcyM1c5eEIrZWgvc2Iy?=
 =?utf-8?B?VkFjQWkxdTNmZDQveTZyMU00S3NycHVSMjZ5bmZIR1M3aDRycGVtZGZxVUhm?=
 =?utf-8?B?eTlKVUkyNE5DV2w4U2FNUWVET3cxazdZOUJIMEF6MmptdzY2TU5yUDdjZGk4?=
 =?utf-8?B?SUh4dDJnSGVUZGNhMzJrQUpJYjQ4Sk1wOXJ1c1p6NTRteGM0Q3FMbk1TTnNS?=
 =?utf-8?B?cjB0NjBNa2JBSk03RGRIdFR0bURtZVFFeGV3UE5tbXpod2FHS01XTU4xUlZH?=
 =?utf-8?B?cjQxbklMYmJ4RXk3eVZrRnNiak16QWpqSXV1V2pEOU5XeHJyaFA2aE84TUV2?=
 =?utf-8?B?MzlsSEtjUU5pR3Z0cklBUCtzVllvbWliaS9OL1JZVlRvSE1XeE8wcVNqcyt4?=
 =?utf-8?B?bmlJR1dob0hoSGt4RHpjN0h0Uld6czF2eWhCK1dMUGROazZtK2oxOERINzFr?=
 =?utf-8?B?VzJOQUFIMnNIZGxTdFozNXAxNmdzbnFSUWdON0pRc3o2cnI4bFBhWUpYWWtm?=
 =?utf-8?B?LytLUFNHcVhrSXR1czIvQlkya3lpd2NNNEpkbktkK0NFdG9TT2l3NEgyMG80?=
 =?utf-8?Q?GoNekrl8J6lOjTGF9X7AByKnA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HxyGmZcLtKuotf0kJLk+hFM03G/VKVVv95DX4d0eahv8JM36E1opyI987DBHWqp0F0BfHg3dzoIYY9HW2LxwWoWF88k1gFptW3MXly2yVFrgrfX9bqxo3+fRY4cLjgd6vlrEcajoykZQaX70wIljqMdEMpPrklF2p1flVzRKHotxK3lWM7VeaVB2qo6dMX3ZCR3Nk7C1x2ou5vRSgttvKZBy+cuZ8lqsxAR0huCfed1dx45x40YIFGk/OD7yC+fZpn6q9ZajQv0NaBfXJJsmwod6HCo37Tr6NhVdsE0OnTUlKSCp11IOrNvH+Xh+veMv7Jd81MAOb7xWyo5t9R7MB6UxV0QRnTttqlL5o6zR7xpg/oRXQwLrahnoMl4/JMPsghCs8UKP/g2mhuUSExbMYbfONeZo7UvAQd+dQOPuITg2aSA8EzmRUpXF7K5bBqwVwV6gFEQ0CE/V2HWkEHchX3spk/nQk6e7E+A0/fcNIuDlBbUubx+Z2bgc3lpRVMGI8eVFWEDsDM9Bii0bYP9Mw8KGg4A7vUbWzgi+RxAMoEviK08Kqgbs93uxZylvt5bzg/wT1kmyQV6INpFyO/hCPbYC1k5IDgEUBG0s9vhn4bA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5821a8-8a0f-4e6c-703f-08dcb8aa3ae4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 19:34:05.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4p/P8IRLxTyBts22KlQQSAiXneZFghrZshPobNzlhtwjQdUao1vH0A/w0g6Lc9YXua6iq0yi75oryyhzJxpMZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_16,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=246
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090141
X-Proofpoint-ORIG-GUID: t7HHqFZ6ygMNClMp97LeEb1_yhbH_U9H
X-Proofpoint-GUID: t7HHqFZ6ygMNClMp97LeEb1_yhbH_U9H

* Jeff Xu <jeffxu@google.com> [240808 21:03]:
> On Thu, Aug 8, 2024 at 5:34=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
> >
> > On Fri, Aug 9, 2024 at 12:12=E2=80=AFAM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Wed,  7 Aug 2024 22:13:03 +0100 Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
> > >
> > > > This series also depends on (and will eventually very slightly conf=
lict with)
> > > > the powerpc series that removes arch_unmap[2].
> > >
> > > That's awkward.  Please describe the dependency?
> >
> > One of the transformations done in this patch series (patch 2) assumes
> > that arch_unmap either doesn't exist or does nothing.
> > PPC is the only architecture with an arch_unmap implementation, and
> > through the series I linked they're going to make it work via
> > ->close().
> >
> > What's the easiest way to deal with this? Can the PPC series go
> > through the mm tree?
> >
> This patch can't be merged until arch_unmap() is all removed (ppc change)

I would say that you should just leave the arch_unmap() call in place
for now.

Are we seriously worried that a powerpc user will try to unmap the VDSO
and then get an error that it was mseal'ed after setting the VDSO
pointer to NULL?  I'm more worried about the Perseid meteor shower
hitting me - aka the sky falling.

Note that we could already run into an error after setting the vdso
pointer to null today.

...

Thanks,
Liam


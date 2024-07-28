Return-Path: <linux-kernel+bounces-264830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F13F93E8E1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1291F216C8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C1E6A33B;
	Sun, 28 Jul 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wfjhk/Cc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BQQbmgEq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B552E859
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722192289; cv=fail; b=M6oaxkFgJtEESCvrOhzk2hfIuDIxiNbqq80d6RxuxavaQePiTNZfk/wd3OqNGwINZaHMA9JP6xbe06dSkZKw7lmivzTOq6DoGP6dz3Uh0tjG35XMH9E6dsriNQ9MUtrenPaIBwKH8XGQUzNOYVw/T5nJFIJXjT0leaTqYAT9MQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722192289; c=relaxed/simple;
	bh=/rCBL52shjU+hjCbAu5PagG3PoCZgZ8Zi8MqqIpfm6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RZ7DkRvdZAOHaYl7uob5vo5wfyCAqfaSObKcuLKZAVDVeylfUVFd+q1X6FkeK+4rkOhT/D8ZdFImZfI+Eye8nA8pl+sS8y4kWYSgdvgcbF94YVv2M+mQZ3EhOyrKwZKA7MMA2M6NLgMgTWJliAYBXqeemzU66kU/f855lEISByc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wfjhk/Cc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BQQbmgEq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46SIBPfB024746;
	Sun, 28 Jul 2024 18:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=N9NSZYfLI/MtVOiCaYx1a86mSUgLbg1ZBHaAWPEowQg=; b=
	Wfjhk/CcwYn/kCgfeydvwmIpFg6WczJh8dU7b/P9dm5p7poc2NS7a9wF5yqav3cx
	H65ekRKELp4ONTZ51k7wB3RIZqHZ96p+FhlrthDSaFOEqNSCw79V/GNyMASpuDBc
	3xV75vf6IbQUSGTvryHTYxBlIvmH+qsLqNzETzHy1Ce+1eFuTyo1upNeCyLgX+mD
	Dvkuqq7cjKWBdLK52O119g4MKRA9yxS9pzLjGym4TNFf2WaCL7PZJS9x+H4NO0xW
	JSishMb/djf5TJi4J/jBbU3wJLNBy7e48FYAOU1S8HUJhdMs+yxQM3hGQM63e+zU
	4fRnAwY9FqPwc1INWHpVMg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8h9jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jul 2024 18:44:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46SEtDVo013030;
	Sun, 28 Jul 2024 18:44:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nkh4f0jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jul 2024 18:44:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6nmtZRjk90MeX2merjf+0bmjeN6Ecp+2dNCWNYwBWzFe/5fv9F0hISL2A+Ign1P/4HiISMcRB+ELNkTWNZR/YK1VYfTwcLy6uDI+7mMjvulWhRfmHacDRrOFiIwXuj8679bVAilXCwmkiHvV8sl6ogH9loqZCf+mHcZIUa6XHN1Mj7AIcrM+r5XsNbIaOcKzqWAa8RSatMc93RIZHSp/mb+2sZjueu07NN0wdmXP2cXyUctEFvNbrmgX1XpRsVNFzR+UWXnutr8zpTBm1XNwwAbIFM6fvywF0MRfx8luMyQqBrspDzXrcvHoHA7JOOgY9RuqUx6WEQQfRLWWu6bDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9NSZYfLI/MtVOiCaYx1a86mSUgLbg1ZBHaAWPEowQg=;
 b=p/wGtpQwkC5wTbDEptn62ylSCU46342R/uXrjnzb4e5QohtbCn/c7zzJ62yPobZp6CC2vgD+BDV1i9SByx2iZRRL/tyyiB3tUgy6cTNc/hEUwTR7kDLwYRJzF8b53vItUiO9LqIGFGOGg6vv1ZyUtrrlKHupqo4z4XE4c5Pan3jNqpRsTBmxBC/Zey1eBTWQg5nPG/wNJ28kt+7Sntrk0kwb2rmMfFicFwHEjtnuf0NubLddsDMY2Ho+2Vzlx/qE0GxE3sTqfAeSc9e7Ft0M4jYqyPDxBD4w2iOI53LFU6aWHO9tGqQJd0ZKBdxaJFSNnTLKI7LcLNJsi/yz4be4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9NSZYfLI/MtVOiCaYx1a86mSUgLbg1ZBHaAWPEowQg=;
 b=BQQbmgEqJEaSODewoFq1NXeRvQFJLdMBQlpDJoNYpchrtREuNtCFwZff6evsb6Fe7OCNpNzqeAnMZGwO00UgBac4bs5Ov7jlL9O6zaIOXhA3EOziazQ07xiZ6N2+xl/t6xwCh/FOgh4gmDQR5VX5I+qxK0/nUudDzxNY2gGlYXM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB7315.namprd10.prod.outlook.com (2603:10b6:930:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Sun, 28 Jul
 2024 18:44:03 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Sun, 28 Jul 2024
 18:44:03 +0000
Date: Sun, 28 Jul 2024 19:43:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
Message-ID: <80eae60c-61f5-4992-a50f-e10d4287770b@lucifer.local>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <CAMuHMdXCuF4ikx7uR_fG=EAPOf+1T0JoHTMOyqfS6eUcvS-piw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXCuF4ikx7uR_fG=EAPOf+1T0JoHTMOyqfS6eUcvS-piw@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0361.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: bb633106-f835-4865-c2b9-08dcaf35406f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnB2VzE3bXRJL1JtNUxOWlNBZHlRU1k0bjMvWklmSVM2d3I1ZFVrdjdVd2w1?=
 =?utf-8?B?eUpNcFJwZFRnY3c4N0RUQ21lZDZNR092dDVPWFcrdFJnV2dhU0NVOS94OFZx?=
 =?utf-8?B?bVJ5ZFloTmVsYjEyaXV2VjVkMy9xTW0yTUxnK1lvWnpCcjNhQTMzVnp0b3JX?=
 =?utf-8?B?Q0hETEdWblVORmNOeUVMV1NsaFRxNDE4bCtFaGFwOURSWEtGbkw1OUNLNEJk?=
 =?utf-8?B?ZXlYVEo3eUljK1ZmeXI1ckh1MnFQNEQzK29Od2Z6VVdQSnlDV3FiOGtraUhX?=
 =?utf-8?B?VEVwTTZPK3JmbkNCYU85YkFjQ1RTOHpMM1VKUjExWGprM21qcjZHdkJYbzYr?=
 =?utf-8?B?MThUdGF5ZlErN0srd0FGdFVISStseFZDMmhiMk5YTjV6UmRLYXgybEMwd3Jn?=
 =?utf-8?B?L2xVWGRmcXdEMkdMWjZjN3ZGTFRTbmlkSHdQaXhVblZTd2F2TGU4YW9FQlln?=
 =?utf-8?B?MFA1Ym1ScnRoQ00yQnVORUlQMzFPQjhMNldzdmZsRWRkTWoveE9jR0dmWUhY?=
 =?utf-8?B?MlVGNXp0S3NuMFdRVUFRSktuK1FqMUtJZkRVSW05Ujh1cDd5SFBiTk5UclZZ?=
 =?utf-8?B?Sm8rVDE3UTN6YmZxVmE0OTkxcDNWY0RUdkVJNkNlcVVwQnpIcE9ZWXVzaFNq?=
 =?utf-8?B?cXdsWlI2VWg3WStLYTlaRXhuaHFtdjJBS1NwWlJKR2gwcVlMcnJhQmF2MDFP?=
 =?utf-8?B?OFpzWExPUzhPQUMrRXhEMURRV3kwUlFoMk1vSWxFSjF3citweXJKYit1N2ZO?=
 =?utf-8?B?cEtucTJodGhjdWMxMml0b1ZnY3FmYUk2SWRsbjFra2J0NlM1UmRiWlB1WUlF?=
 =?utf-8?B?NVdTejlJTmFXYWY0b1pkcHFvYlJGTVhrMy9LT1pYR3BabnZwTFB4UUNvTGds?=
 =?utf-8?B?YzhyTVNLZnBRSTlKRnNmOU5rcGJ6d1MvSU9tZDhXYnFoNEtMaUhTRTRuSFNO?=
 =?utf-8?B?aFBkK2dvZnFBWWZUcWR5bndhZGZnTmJocEN4NkJJMG00NXprVzhwcDg0SFlk?=
 =?utf-8?B?b1U3VVRQUHNkSDhRdG9pamVzVDZkQnlrTEhXSkl0ZFY1K2R0LzVnQ3pBcWh4?=
 =?utf-8?B?Z0N3WDR3NjErZkNqYzJoOTQ0b3FCNjVWcWVoc2RMRmtJUEtEZGZBREowazZx?=
 =?utf-8?B?dlVyaDBQOEJxK25KNHh4NVRrL3lVSFNIVTM0TUYrcXRJTFhuaHFpVFZQbWlj?=
 =?utf-8?B?R2t1bjRTeGtkREY4RE9wOHN3NUZFMEhJWDFqQitjWk1KYkk3SmE4NjJxNUF4?=
 =?utf-8?B?ajB0dS9ueW1FRVdUWmdUNWV3Mk1yOGgrUnlYMDJnNERZaDBqTVVsTnZreXpP?=
 =?utf-8?B?UmNkZDBsWHpRTk1WNUhXZGZrS05oa2YzMk82V1U3Sk1ZdG1IamRXS0VaQ3gv?=
 =?utf-8?B?NHY3a2V2MHQ0K1JBZldUQkFXcEcrWTlkd1djN3R0K2VESzVQd1hPY3A2MDlj?=
 =?utf-8?B?TGlkdmNHQVBweFR5ZGdVOTU3UVR0ZWM0UUZncndWeEoxYkhuaFlKNGxPRUNY?=
 =?utf-8?B?ZFhMOTB6T0tTT3l4T2FMQ2k4MmdPVG1kUHJXcy8rQjNGM0FKOStqNENoRXRr?=
 =?utf-8?B?TUtSNTltKzYyaHFvd0dmWUN0VWFRR2lLcmI3R1lDZWxtTGhoNFFYUnpVQ1Ar?=
 =?utf-8?B?S2Z0SVp0ZDI4S0ovZnVxLy95VGFXL2w4MXlEQzVSS2F4L1gyVko4UDFUN3ov?=
 =?utf-8?B?RnJ2OWJod253ZHA0YkwrWUhtTXVKMGZqNkVWZ0ExUzVucHh0VTdhcTVGMUIw?=
 =?utf-8?B?b1V2OHN3RnZDN2I5T3BFZW1rV0NzdDJiNnl5bGZnOU1HTW5uN2lFaWw4WW94?=
 =?utf-8?B?K0tEWmZRNmJpTkdML0VrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWZKSnpyY0c5NG9pZDladERMWWJ6blFSa2RNQi9hem41WHFxdlVSQzVBTFA3?=
 =?utf-8?B?L3hnZTlDTjZ2MFRtclpUZTVZZ0lQUGFUVyswYjA0RGRIeDdBMWdvRzlqVENW?=
 =?utf-8?B?aFI4MU9nenFnNlluQTd0emNxeFlwTXZJVEwrTEdjWEh0Rmc2WmF2dVZmQkwz?=
 =?utf-8?B?NCtveDlremFFMG9xaWV4bU42RmRrLzV1YzJDcVJTRkxJZFhwb1BKbWp3NlQy?=
 =?utf-8?B?bU1NK2R5Q2MvSWxpWlI2UlN6RmcwT1ZibjZFUHBEQ0I2b2xiRW4vZ2xLRTZS?=
 =?utf-8?B?aENXcjd2SVQwRFBEem5WdWFhMkRxTmh4R3UzTG1acXk2b2V6OFo2cEE4VjZq?=
 =?utf-8?B?aUthMVd0VzZMUFE5U25CYVphY3dINlNSODFUVm1oRnliV1MwUnVDcXRSTitM?=
 =?utf-8?B?dmFoSHBvSEZHL2Y3TFZJNmVWa3VEWjBBQTRUdFMzZUd1d2h4VS83NGhlRkk5?=
 =?utf-8?B?WW1xM1VJTW9TSXhHMTlneE9aWVRhODR6U0d1bm5ZNUdvdzdiUXVSRDZ2TUh1?=
 =?utf-8?B?UGxlNzRXaDhlWk5Vdm1yQWR3SERNZVNBVlVvY0xkMjFPWUw5cWhleFZaZFNZ?=
 =?utf-8?B?QzYrdWNzOWoyMDhCTEVBejZyV1Z5UnZ0dlpCNWVuOUZzOVd0OFJJdHJaQ1U1?=
 =?utf-8?B?cGM3MVFkWEZZWTJTM0tjbG5HNUM2TnZSVFBjcjFhVmJTSER3OUNOcXVLbFVE?=
 =?utf-8?B?UllYbU9QS2JaL0VLMnpFd2Q2V2RNbisrWHhNTEFhTkIwK1Q0Qld3bnFkZlBL?=
 =?utf-8?B?cmdxYWRrR1VhL2Nsb3QwNzF2MG52TzMvZ3Z1dkxtSlcrZHdhU01uOEUyU0hu?=
 =?utf-8?B?RVN3dHNPTXRoYk42U01QYzNFRkwya3JUR3RZcUpXc0hPckNmZjdyNHN1TGcy?=
 =?utf-8?B?NFZPOHZHRlN0TkVUNjZDZ0NiM1I5YjlFUUlvcU1UQWtFREh0cHhVb1lGN0Vl?=
 =?utf-8?B?RHYxM3M2ejFoVjRwNytLYTlTRjBtRWNZamFnU290TEF2b01QZW55dUZqWHg1?=
 =?utf-8?B?bkt5MDgwWktHSWRyNTQzdjhsWkZWSW1Ud3M5VVk3cG5PQ0trdU9DeFZtK0lj?=
 =?utf-8?B?V2xvV01qMnB6cjVFei81QnBVWmZjczU2UmthSjU3NEMzMDBNV3orVXhWc2du?=
 =?utf-8?B?R1JDUHpwa1lZM2hhYjBwZzdGVTNkUStwMlQvc05wUzhiV0xONCtBcnhVS1lT?=
 =?utf-8?B?MVFyNEVWNnJtRVZ2U0VSVkRYTUF5UW4xamExbEZJYjczZit4YVcwa3R4Skp4?=
 =?utf-8?B?Mzg1WGdralBuR3pFNGxtekdXSCt6US9KT0hTdXh2b1Bldysxckx4Q2x5eXFY?=
 =?utf-8?B?LzY3dytrL2ZveVZ0WW1WU25TOHZ5NmhQd3NNbVN0dTdxUmJTSXpoN3Jpa2k2?=
 =?utf-8?B?YnptNWhXTXlKQURFNHF4Nk5zU1VwaklGelZ3NWk3RkhLVkNVSjNMMlZtMFdW?=
 =?utf-8?B?bWpNWVRHcGEyOCtFaUNPTlNlZlVweDA4K2hXOEVjREpEYyszN3duejVzdDlv?=
 =?utf-8?B?V3NGMHczcDVKdXFvdDdtcHlmN2h5QjkyZEtqRUpUekQ4UjZZZDFoS3BlTkJF?=
 =?utf-8?B?cUw0REdJS3lsNWZudWpPNktNdDNZT2x1ZEloaXVSaGtlQXlHQjllUVdoZkI2?=
 =?utf-8?B?TkNabHNQOVpPam5kcEQrV2JablBaQjU1dG5yQVBxVUYyaWljZzFzVHhleDhC?=
 =?utf-8?B?NHgyekVCcktRVUZReEo1d3FGZytSRlFyVmpYYnpTYnZwaTJmMXlPUTh2cGs1?=
 =?utf-8?B?RnJvQ25kcVZ0RjlicGxiTmRKVG1mMkIvdFEwTU82b0lvdHJCM29VOUVFUmZ1?=
 =?utf-8?B?TW9VQVcxWWJ2a2J2dWdqa1QzMHJmaHUrMm8yVnZKTXJNME5tYzlPc2ZROWJF?=
 =?utf-8?B?QWNSYVlhalVlZWtzeHpQTk84cFFILzZ4ZGtMMUpkdlQ3MzNod1BXaUVza3hU?=
 =?utf-8?B?c3pCcUdGVkNaU2lMd3hrbnlTa1FWclhCTllCN2MwTFg0Vm8zTDZLa0laS3lQ?=
 =?utf-8?B?anEvRlFqREtkWm5JKzdFK2JCbTVtRzFNaEJhSndmR1o2UjBOK3BFT0UzZ3dU?=
 =?utf-8?B?NWJ2eHlCRCtyTUlZaXRWOEFNOU5Pd0NZYnRzUzZ2c3U4Nm1YbEpmUUZrZ3JK?=
 =?utf-8?B?RUw4TGVvT3Z4b0h4N25NOTdDTEQ3OUVhbnQvdG8xOXQvVzczS0paOXZNQVFS?=
 =?utf-8?B?OVJXaXE0LzRjek92bzUrTXVVSTlQYlo3NFJ3ZXk2dytCejdzTCtFMXY1dk0z?=
 =?utf-8?B?M3psSEo1c2U5dVhIdC9pRDhNZXBRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J8YIAUaEJmzbqqhgFN9ussDaX4HhiwQBE4JEVVjChqvt013+ZVpSy30FenB8PjYHtWhFCg8Nm4YT2J203U9Sth8AzTGsi9eS4D/7wJ8EsSKfXcGKemlYlMvyb9mXD1mkCDziy9GM/i7X7cZ/YLXaSCya1STnZ1AmEED6xq3DDqnGM5J6q6x+qskGM94ez+yC0S6bHtTBW/9LSXaRhW7Vz3k94JO6lBDr/jnRzKE20d6wGMUzFZlK9Aeo5t5h8913YStHx2y5+B2LFVA4XGI7TdJL2sNAItdaMj1zYQw/AjsWdEyPlT6GOCxVLKjPUrsLf3VOpdhbNAdMnulxeV87jsI56PD156Tew8AaV5ODMfKMJDp5Eb/qcYbwT2X5jWerkKsNHXpVAaum7kdqr0pwOuJeN4tobSkWHDxEVx/t4KQuajKfZBLwQf2+cIMSKu/JUp/TIA8RgjB8qTgVJ9wgsYuZ2MBWvMPSjZIeCcEbX256rHeXUOt7Ryc/mx8rXQig2Z/znjSZ3OiMeeRU+0FsP8WAParUVBXIqTu2CnWHe3a291iaTUDMfmwKl2jjbzM3Ed0yxZBqnNuS+2ZkbMoHjlkxCDMY3VY63J+YherKt8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb633106-f835-4865-c2b9-08dcaf35406f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 18:44:02.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoQXNUlpE+wWWlyTbn6fZPfwFZlL/4hVgYmZxffyiytRpep7iDdaOSTX77y5lA1UbRvgnFh3CiVOSWcug35fGIhGCIg5ki4Gdok62xGJzVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-28_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407280136
X-Proofpoint-GUID: s9GoD09nEixexkWhP_Iw6OdFJyYByM0q
X-Proofpoint-ORIG-GUID: s9GoD09nEixexkWhP_Iw6OdFJyYByM0q

On Sun, Jul 28, 2024 at 07:57:11PM GMT, Geert Uytterhoeven wrote:
> Hi Lorenzo,
>
> On Fri, Jul 26, 2024 at 8:57 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Fri, Jul 26, 2024 at 11:24:09AM GMT, Linus Torvalds wrote:
> > > On Fri, 26 Jul 2024 at 11:13, Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > 5,447,539       ./arch/x86/xen/setup.o.pre
> > >
> > > Can you perhaps do some kind of "max expansion" on all the
> > > preprocessor files (you seem to have done it by changing the ".c.o"
> > > rule to just spit it out as "o.pre", which sounds fine).
> >
> > Yeah I simply hacked in a gcc -E, ugly but effective, e.g. prepending
> > cmd_cc_o_c in scripts/Makefile.build with:
> >
> > cmd_cc_o_c = $(CC) $(c_flags) -E $< > $@.pre; \
>
> Kbuild already knows how to build a preprocessed file (.i),
> so making any .o depend on its .i should work, too?
>
> Or am I missing something?

Yup I'm sure putting something in like that would work, I wasn't aware of
the whole .i thing when I did this and I just hacked something in quick +
dirty to get the data.

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


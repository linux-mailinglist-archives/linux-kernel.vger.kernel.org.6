Return-Path: <linux-kernel+bounces-437806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD419E98E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C6F1886143
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540BF1B4249;
	Mon,  9 Dec 2024 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O1e1LbDx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zXnLVsln"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04F1BEF65
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754526; cv=fail; b=kPFP3pDQvHOKnilE0o9JHWk+H71sLgBjOU0MAkc3tacGHYpk2G/8ClY52klP9qsnWjr+jHfKd9a8WTppuMzVEDD8wKdUsjLzZUD9IFK82wH1CFI1oyW+3awrmNlCv8Q87cN/S4yq+OJ5RfPEXYCer+6qJl3BdbyiXN1W1pp184I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754526; c=relaxed/simple;
	bh=rVvPlVIul8pbGJpR8coTEGdOm9XhsIjdtC6bP0ULLNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a7bujLQ4kvik7fyqhB+Ac250d6E1NZMN5yGXC7a8y3riF65r1kP0Mwnc8tH84u7VS22y1GihF5/4jGOA0QYlJtRc95f5JIqE/weZE8EJpCHA2n3j5xIDlQN4mNqquQDuJ66XTTDjCGSyJelcnRFAu+Rt2gvgvkoqQiUgu+v2TLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O1e1LbDx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zXnLVsln; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98g0Mp000418;
	Mon, 9 Dec 2024 14:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=xqpYZ3Lj4bf4qOmWus
	NpVQRe0keoOEu6mTUDp++qY2Q=; b=O1e1LbDx9AYX00NlErZejkemKpx9NiK8sA
	kQnU2ygh4/ddM5tk/rFvuqipi3gnRbDk0UXVwwiJFsL/zS8w6IBQab0bBcqAB1tA
	dDNCU+9Aw8QM0oMkEwikd7s1OuwZpIZQj+SkYGPmNuxvoctXYSv+wRk4gvdClXeL
	JAcA62lWbsi47vsnRwbYNl9GY2RrxlPbGeD6BTj4k4f34klQgyUh51KVfUiv9nNb
	N2exEG4VyhiKwdJWD9eRgzmb3H1rteQOKauyeL8PIqBTVqU9LrkM1DYBIIX6sQL6
	kQ9LXRTdNmWQu8Cpngk/UOyc070mzWkLftksFdj609V7/rTGZ5Gw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9akcq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 14:28:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9DNHxk019280;
	Mon, 9 Dec 2024 14:28:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct7aqq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 14:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQ2gRU23br6CIm9gSjaLrV91YVKxWNEXwykORFhJBssTwiJtWXXU5x0+e7GfTFZz+KoSWktiTxPFTa1x0+k9dC3vZoc6u2y8GF1cDsJD1x7p2BPMloqT7HYjMBt04ghGvLWOumFml7WnCYINLRK98HWiWAnKFOPSgRAKnzTL+aHEPyegeKE6B72WNX9UV3SOF3rl/s1KVjGhfOcTZdqj3wuQ7Ers5bqp8l64rzaLD4eG+y6EK/OwZETebxcNQYjF0XMg8Of+OJGMD8vqtm/TCJiPaXvfLs9eGyoSuel0Yen5H+3qbwX7rpX5wZ67viMYZNZT2vHzDIvXzAHyqcAqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqpYZ3Lj4bf4qOmWusNpVQRe0keoOEu6mTUDp++qY2Q=;
 b=EOX4MPqhw3PxUZFiJUpEjlhZ/V/wefUt4WtHw9SkBJ5fxqssvuS8YHyNnDQiJszhEGoo0wFJRgXr5y7v4u6miWHzwbpkQMhbJQvSUerJDKkh7kLEWXw0NLEgKI0wLpFl1o/o6OkjR+U+tW0+eY/TYIDKsan64PjNbbdAZAqakVxjKpfwSEJjJ/GqLtOsqS3/5o2GBvfZ4/E+EvbKMJ1dT+hSSitpv51ZuqP91BZ9v5vzKE0sg9+GvChqFr8RziSgsIF9xAU83rayaX5x/B7BTW81L/vSmBWGSOmuxzzthW29we8B85mKVAjV13U/nFtbRGU2CkuDHGb3o78mChxeew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqpYZ3Lj4bf4qOmWusNpVQRe0keoOEu6mTUDp++qY2Q=;
 b=zXnLVslnwDARuX/wzZ1Q07uLQy3LAo4TjsN4ZK9qoJDwr4gVfp0xWwp8q8XnI349F3awjz7yjSnODhng1MoOTyneV6M7vhSmHp4GSqrmReE8Z5JOPWq2SHHpgBa1D7e+yv83urESTZoLB3kfKwjtndzHWM0C5slwQSv4HQkldpU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW5PR10MB5808.namprd10.prod.outlook.com (2603:10b6:303:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 14:28:24 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 14:28:24 +0000
Date: Mon, 9 Dec 2024 14:28:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Message-ID: <9fb4761d-db28-4271-afb7-9e3cafa89438@lucifer.local>
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
 <d9df6f73-9e6c-4f8b-b2c0-5534725d1b18@lucifer.local>
 <c53c8f59-1e5d-40d5-97df-7200c21c43fe@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c53c8f59-1e5d-40d5-97df-7200c21c43fe@redhat.com>
X-ClientProxiedBy: LO3P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW5PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d4bf01-4868-4e3f-5684-08dd185dbcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/syzx0RFcoRinKT9UwasYXqkD0awlyOHepwTxZCM7xJrHKa3hz0XKY2KuZf?=
 =?us-ascii?Q?+OOOEEmMRQQ1EOTSiv2UexwmIKif0ruJS9jswJdZEpWDtz2mtSIcGX7QM0dJ?=
 =?us-ascii?Q?vzf3hqngirtUuqc897NyRCWNbPsFLsKpgi6jzSEinQ7O7hq5FUhQeqg3Jsur?=
 =?us-ascii?Q?/aht8dp5n9NSgnPGTkFMtKwyC5xxlG3opBml+gfrXXZvZju4FwZkv792e/Yl?=
 =?us-ascii?Q?+c2CrPRKz60Ima8MPzzVGKnlFWEcomaNAb20cdyezyA9xODIchCoMk73mp/x?=
 =?us-ascii?Q?eluX3eOx1jsrNv7b1UgdUchlhiOsrbU8s71+QetYQzCqcBrI1pId8K2wZibf?=
 =?us-ascii?Q?DeihMJFxiX2sSovl0SQcJawCQUq10LXx6Jh2COCiHGHv2WNfdZHKA6JWpCRV?=
 =?us-ascii?Q?Z1gEh0iBrSR/3uZ903eTrUp6Qb2ZUEgA6NVwNzVLQ+W5KHNRtRVcKGuJRacX?=
 =?us-ascii?Q?0rWCNeKuSdTZ+zo1Kpzc/V7Kwa2jDKZCDOTfIysN0PfeOhTITqfi8O8KUQKY?=
 =?us-ascii?Q?/R/CW6LNrNKWypdMuD3m002nr2ImHvyYuvXmDEkru78p2EcJM5P9/RFub1xo?=
 =?us-ascii?Q?ySYO5DqtppQJiB8fftK1FfRFIJ8Ft9b3zPy+LfRecFO0EjRFfaeaigODylkE?=
 =?us-ascii?Q?wDehSWkv4XZi5oQj/bBO1ovTmn60Ur4NyyuXOej094976V5WEPutSLTLAcQV?=
 =?us-ascii?Q?9PeNzxACBszWt1G9CT7uKYJNY5swKdua6w3nBIkYyvJWjJFFkeo9IpX0GxFW?=
 =?us-ascii?Q?NOOqu/NcYAwImDWjCMvGMAc7cjKtseyjTHm3QNQ0cM/12l4DENY0nxEl8DTv?=
 =?us-ascii?Q?U7b+I559VCs9O5vJiVSZqOY7NxpJZXtn9BmwgnMmtHHL1Pxw68a9sCjUhlSB?=
 =?us-ascii?Q?qSyMgMh8RHpc49EQruhoU5seV9nz/dy5CFiNjZAI5jSeTspOelkooboPfZMG?=
 =?us-ascii?Q?zN3rtWl7W3bjYQI2RLsEB3vPEKtmzj/0V1st7EPrqbKDq4QAa8ieJwTWzUbZ?=
 =?us-ascii?Q?ZWE6bateop49fnoFeFU7SeZ17hHOcWptoQPWHKNSagbLjiZBWfoorgTQCBQS?=
 =?us-ascii?Q?7LwLlKm/fDGct//5qohS6fczr7pSrkc0L7XMjjqk/3Kkuiuh3d4VEgD8j9Pc?=
 =?us-ascii?Q?C4LIMXpyKo+wsU4wwhZVxhNOEWPEF72yo964KdgPsPHa3TKadXURE+dwmWm9?=
 =?us-ascii?Q?ss5mJfpoigxJ1H3RO2jIvQWB2Ruu91QyIUeOUk00sBKLldbvGv1aw8rO+wQJ?=
 =?us-ascii?Q?5GzHuI0JD2IEW1E9Vk/Y/ZonPqF4ABmSJc/XsX8vY7gK+PuNBsSvRQnY1JUP?=
 =?us-ascii?Q?Yig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p0awCMZTEgqEvR3fxGoPIsic2xp4GqgvnDJ12kf7bvZ8BNzSTGlW5s/PTg6i?=
 =?us-ascii?Q?aj5cvHnXtXusnu6QoGkTjYCcpS5DRcxouHgMHuY5hpUEGDj/hhYnR3mnUh2c?=
 =?us-ascii?Q?/KG2oh4q8xGuqJzGB1z7/S7eB98kTSqeRWumpsgUBtMlgXAAn2G6L+3x097X?=
 =?us-ascii?Q?+n1749JSpUpgb+I49pcpvgfjKZPtK7vlm9CCcZBGNPXw39GYm9YZwdFXHkgt?=
 =?us-ascii?Q?4LwI0l27GhDqO9VRKsRC6ssQIJ4wBEijCE7cb7p48o02IQIPJzsuPT/j3pr5?=
 =?us-ascii?Q?FvEQ4x0GkXpCkWqiMI9z4SnIdfkwpXi10TwTbeHjPbeJdEcMLj5vfdSkGW3L?=
 =?us-ascii?Q?uXmdO8nvhJd4xGrVQItiY4NuVwDy2hMdjNg51+9ISSv18I58EKLYMvN+f5Q6?=
 =?us-ascii?Q?VlCbJgqwr8Bd1m+dqvtvDK8kLEBPbLEREuyM2i2Y0Vy+5Ur5g50UlymY+Ifs?=
 =?us-ascii?Q?3iW7g+3tr1yjdhxIsctuuC+VFDCtvaiyG9pNxQ0rZ2Xa69jVLLE0AnDLC82h?=
 =?us-ascii?Q?soDNDeMGmlIcF2GhdOvTmpv9oJDqGL7yP/2SuSpt5vR0X+4MIp11iX+KZ6Vm?=
 =?us-ascii?Q?OSOyWKo4J/RwxDKMoRhSoA5wHhaD/+vtk/e8YE/ae6M0g4AOtLExoWlmXT2h?=
 =?us-ascii?Q?MpkJ4Yig4db17icAMmTUiHJddgPd4UukH+ryQyBzxoMY3khu/5kBue/P1lG1?=
 =?us-ascii?Q?GdYPlDYbHq5EbfDTSSM5W1vQn9NY19v8suV+1pMEHdFHiNSc/WAyGEBIoBr5?=
 =?us-ascii?Q?IZ/AHLvIYo43WAsCkrxK3j4KkHRBw/7rSefnWEblMVrAxW6X/rT66OK0dDXU?=
 =?us-ascii?Q?7KtMpkoV76hp7D+P/EltI8BtNHibPsXpKm9O5pK/hp1Pe6ZuOHZlvR6gbbUT?=
 =?us-ascii?Q?13SJu0R08RNuDuKKO42MWpr+quy5pHQNePO5RFITuz3vsZqIFAGjAhMUnMgy?=
 =?us-ascii?Q?1ir/ufX6XhmGEkA4qhMHBdw6pFBgBjoYo14uRrGQOuS0R/7XtsCrQPEU4SwZ?=
 =?us-ascii?Q?wBjy3jczTVdiNsp5h3NF33E/Y5yf8xybH3hoCFsRY0Eo8sIfkSoDHm4M7XWu?=
 =?us-ascii?Q?UNGMKPEsumOi6MKvKui1w9sOfL1xfQ09Rx6Dk/Mj1eCfAIPk2Mk9+hmMEK5c?=
 =?us-ascii?Q?mgOn4kmVWIPmMmbieVcEB7M++iZT7ILZkXIlTc8mRrSheNf6zvlfCBx5O70J?=
 =?us-ascii?Q?dxrnWvR9UXyYWKB6Z3S8lFHLgTMDokehNZtaCzBu91eNaHVL5sFAphqMVYsQ?=
 =?us-ascii?Q?nbHY2OtuBkqDU57KLTGEL6I5mdJcYosIRlQ61K3Q0fU6S7atclVpfJcLpxcx?=
 =?us-ascii?Q?+PdkHqGGniguyHBsKlDV5HURhzetVFeFVFfb5nEJBkoPQ5M4+CgViofCiHes?=
 =?us-ascii?Q?NIEahkDuLpoGv84aEVzRiaILiGSRKg0RASJfXleywBVkD8iPW7hiSLOlcc1K?=
 =?us-ascii?Q?2XegDnC73LptFDxwi1DJ3Yns1HsToH2q9piCz44AxAB3UUv80GOhJY5OQbF3?=
 =?us-ascii?Q?W4bxaJjUxJBR82ZzGJ423THuVApFSMeWjVYeX6EOggs50RqyhHUK2aEFQ854?=
 =?us-ascii?Q?IPJRSYPOWgsEuuDfyZEBTBRDukihDcI5Ll7QuKRrcBS6FhFaHWXMwISaZCdk?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7URz4tpG5a9sDkWMkuC1CbSgfIgLya65qFHXLYIcdJbH5uY5ak1LKjibc4gbSARTKC4lKuWPtnDgUrYACnziGnGUzKCCMnFHx4YB1pjpG7UIy2oJANLHPxVGu5y/QBBOuVjR2VAxOz/qGu2CSpqVBNJAPQuEHjxrXRXaHDG2tOxEct4/0sg+6jayhjcr76EimXJLAXIsoXoX5391G7Mf27G+o6EqpsNtDZ4UucF61kQdoGK61Tf/sdtZWmVmYnogYZqTMpuUxiTH/uKxFT4QDomHAqgtN5QaD/x2S6Ienjlkp2OiJsy4+tIQYDXqfGOz4SmimoxRaIT613ysA38hhxn+p3Imy9Ai6dvPNEiC557V30kOnV6zjYMokSR4llj7jiUHFky3eEuO9oDLf9WQnh2TrJ5cs20l8UJKTMHVwErkDnQ2MDeyyk8vBQDD+iWJUxjyULQfT+CvTRxUtnQ1+NnZY4o+Ys/1ZtswKrOhPI6RRMNizaak+8mFP6bH534fqmIdS5eYtTT+ARa34iIEscqB0qPz4xeoFHP9cbjaRagO8TSdx0eArF0KZMqc06qQsXmKqg8ddsI1u8nWRlm0gtMvqxN1TC1eLaR6vDKtNIc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d4bf01-4868-4e3f-5684-08dd185dbcfc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 14:28:24.0443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GspS3GTGiaYjt+lFv1j3wT4eeuyWidY3VQsHWptGcQGGwyZQmaeC4nOTt1Soy95eLd+HwpLjNCc1UrUJYA0g8MD/6Ule/wMkHV8EmTN1Quc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_11,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412090114
X-Proofpoint-GUID: g-JAcryb29YwU4iBhvMwSb_-gRxTKic5
X-Proofpoint-ORIG-GUID: g-JAcryb29YwU4iBhvMwSb_-gRxTKic5

On Mon, Dec 09, 2024 at 03:09:26PM +0100, David Hildenbrand wrote:
> On 09.12.24 11:06, Lorenzo Stoakes wrote:
> > On Mon, Dec 09, 2024 at 10:16:21AM +0100, David Hildenbrand wrote:
> > > On 06.12.24 20:16, Lorenzo Stoakes wrote:
> > > > There are a number of means of interacting with VMA operations within mm,
> > > > and we have on occasion not been made aware of impactful changes due to
> > > > these sitting in different files, most recently in [0].
> > > >
> > > > Correct this by bringing all VMA operations under the same section in
> > > > MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
> > > > with VMA as there needn't be two entries as they amount to the same thing.
> > > >
> > > > [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >    MAINTAINERS | 19 +++++++------------
> > > >    1 file changed, 7 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 1e930c7a58b1..95db20c26f5f 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -15060,18 +15060,6 @@ F:	tools/mm/
> > > >    F:	tools/testing/selftests/mm/
> > > >    N:	include/linux/page[-_]*
> > > >
> > > > -MEMORY MAPPING
> > > > -M:	Andrew Morton <akpm@linux-foundation.org>
> > > > -M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > -M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > -R:	Vlastimil Babka <vbabka@suse.cz>
> > > > -R:	Jann Horn <jannh@google.com>
> > > > -L:	linux-mm@kvack.org
> > > > -S:	Maintained
> > > > -W:	http://www.linux-mm.org
> > > > -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > -F:	mm/mmap.c
> > > > -
> > > >    MEMORY TECHNOLOGY DEVICES (MTD)
> > > >    M:	Miquel Raynal <miquel.raynal@bootlin.com>
> > > >    M:	Richard Weinberger <richard@nod.at>
> > > > @@ -25028,6 +25016,13 @@ L:	linux-mm@kvack.org
> > > >    S:	Maintained
> > > >    W:	https://www.linux-mm.org
> > > >    T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > +F:	mm/madvise.c
> > > > +F:	mm/mlock.c
> > > > +F:	mm/mmap.c
> > > > +F:	mm/mprotect.c
> > > > +F:	mm/mremap.c
> > > > +F:	mm/mseal.c
> > > > +F:	mm/msync.c
> > >
> > > Not sure about mprotect.c, mlock.c and madvise.c, though. I'd claim that the
> > > real "magic" they perform is in page table handling and not primarily VMA
> > > handling (yes, both do VMA changes, but they are the "easy" part ;) ).
> >
> > And large parts of the VMA logic interface with page tables, see - the entire
> > 6.12 cycle - around recent changes in mmap() MAP_FIXED - which... the VMA
> > maintainers fixed :)
> >
> > And then there were the issues around VMA and mm locking relating to page
> > table work which... oh right yeah we had to fix again... :>)
> >
> > I mean you can make this argument about probably all of these files (mremap
> > has -tons- of page table-specific stuff), and then we get back to not being
> > notified about key changes that interface with memory mapping/VMA which we
> > end up having to deal with anyway.
> >
> > A lot of the reason we have 'magic' in these files anyway is because we
> > don't have a decent generic page table handler. Not sure I'd actually use
> > the word 'magic' for that though.
> >
> > I am planning to make significant changes to mprotect/mlock soon, which
> > have some terribly duplicated horrible handling logic, and both are key
> > considerations in VMA logic as a whole.
> >
> > Anyway, as far as I'm concerned page table manipulation after the point of
> > faulting is completely within the purvue of VMA manipulation and a side
> > product of it.
> >
> > However, can concede mm/madvise.c if you feel strongly about that as that's
> > a bit blurry, but of course contains a whole bunch of VMA and... page table
> > manipulation :) I mean it still to me seems very pertinent.
> >
>
> And then we have mprotect.c being heavily used by uffd-wp and NUMA hinting,
> which don't perform any VMA modification.
>
> That's why I don't think the change proposed here is really the right step.
>
> >>>> They have much more in common with memory.c, which I wouldn't want to
> see in
> > > here either. Hm.
> >
> > No, memory.c is really dedicated to fault handling. This is really
> > different from manipulating page tables in specific cases in my opinion.
>
> And fork and such stuff. And if you look into huge_memory.c, we actually
> moved all of the THP logic for mprotect()/madvise()/... in there.
>
> Not sure if something similar should have been done for memory.c, or if the
> THP stuff should actually also have gone into the respective files.
>
> To me it sounds wrong to have VMA maintainers maintain a lot of the code in
> these files code because these files somehow modify VMAs, sorry.

This isn't what I said, I said that de facto we (that is the MEMORY MAPPING
maintainers as well as VMA) were dealing with a great many issues around
page tables and page table manipulation which are rather inseparable from
one another.

I even went to the lengths of writing a detailed set of documentation on
locking behaviour in and around page table manipulation and solved
security-sensitive issues in relation to page table teardown over the 6.12
rc cycle.

To me, the idea that mprotect() and mlock(), operations that are explicitly
about manipulating VMAs (_and of course consqeuent page table
manipulation_), are somehow separate is really bizarre to me, but I respect
your opinion even if I disagree.

But unfortunately your arguments apply equally as well to mremap.c (more
than half of which is dedicated to page table manipulation), so I will have
to drop the whole patch then.

If issues arise there in future, I guess others will have to deal with them
if we don't notice them (luckily Jann did and pinged this time, hopefully
will in future).

>
> --
> Cheers,
>
> David / dhildenb
>

To be clear, I made this change in the interests of the community and
contributing. It seems to me that within mm has far too little sharing of
the maintainership burden and I only wanted to help with that and make
explicit what I work on day-to-day.

I am glad you at least don't object to my doing so with respect to at least
some parts of the VMA logic.


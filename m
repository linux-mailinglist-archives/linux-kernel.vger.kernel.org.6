Return-Path: <linux-kernel+bounces-279525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9794BE7D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B73B25FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337FE18CC13;
	Thu,  8 Aug 2024 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xlnlf3Dr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xH+u+wOS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E34A33
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123461; cv=fail; b=tBVg2dZb4wzOQfAJfaVmCUvi4zU+dboHdiSZKLdwUzmbsKWPC86FZAsTMUZwWsqM3VDMu2rd4BMpNKlsOVlgA5bdMPWzW+v5rcADk+CrCrAAjaWmwWp9zSJoXRDwljEUwD0u7kT22GQ3reIr4HuYmTqs283159nN78Oy17Cg+Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123461; c=relaxed/simple;
	bh=j2inpOvR0nz2Zt0KocmUj9ECCkb1SAsdwwN3XKreiSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xou9U40eZcH8IXneJc1ize/odk2Rgkg7n/Y8nZtNj5bWH5jqfJu646HR7giIWY1/mJT1EAgzTi+9L0BUaMiBSuDDc7Vevz8zKF9lMTOZx7owEwWjHvd8yobnm0BIWFyBxEeWbA3iiDUPDB9ydmkXcAI6jm/msTH0foDb6ksVcOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xlnlf3Dr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xH+u+wOS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478ANJkG002791;
	Thu, 8 Aug 2024 13:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=PiorWAMPfj0vF1JW4+rSk0wrSXc7qT1bhkdZYCUmdV0=; b=
	Xlnlf3DrCJzNQtMRoSFADjejYAT6rp1ve/tbMHR2CkHnxw3tTus0A3Tf/l0JjiW6
	nPtuL9wLjzPR+YFqzXdRy1XoGDqQIayeV3hMsYSSkcmvCq+F8kWYjDnL61Jswn3m
	kOPF/J49GY2nERbzutk+pUeWFUMqL6Bwj0FPFInhXGuo2KcMH9zXIRDPm9uA6SiQ
	oy26khCAqR49X8EHbyH+NcOcBCvx3yqrPIcjnOtZJbC07qF/+8HiDqLy+14aDRxL
	c57uEHPwW4dfM2p6TLJlRjEv9hWrnRUtcNcuqadO1PkYtcj7xusE4UYShJXSMFb5
	4sB/b4iMHi7sSXF49uuUwA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51hu3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 13:24:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478D1skD022006;
	Thu, 8 Aug 2024 13:24:02 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0hm92v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 13:24:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eS7imUYQrfP4+A8XomcRSNTIbIsSKlcWwtCLTJpQl9vrILDuMyWcz6jK64rcnz5G+o1C9bWc8ETf+XUiGU9irF0okhoILF/dcaOdjOghLmGGVl68y7Yd+VmutGrHb7+3beOhFEGr97HVcIoNa7Uxt4BXcqrPQa0fo5db5cka4zxvqwxU1UMNTDNM+LWhF1lGzBUb9pjL1gMpZMshAJdrgBA0vYUeJYreaj+gTOtO3xvO5TC7MZsm6YmqcK+Q7q6tKYwfrcZedtyiwuHzDYI/zp9eTrk13pQRfZQTjW2FncEc2S/Sj3wOUVyFFC7KXlP6SEiVlPAK6jg7Yt97FhhFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiorWAMPfj0vF1JW4+rSk0wrSXc7qT1bhkdZYCUmdV0=;
 b=eVDFQahm87ETBsnjF7rq5XZS8gEpbgvLJFxOUzNCasaN5bobOH8Urc3fK5Fl8LgaQSO0zVbhO6zELujn5kGSM6OtFUEOCUL2vXrWvQqkRB8kQJn8N8B8//TdHrrsRa9SYUbMKKJMkHQEG69Ffjjc18RZ3r0epEy9W9ZwNxYf5AIiNj9lEq8Xt2o+uY8KE3ybK1t7xLGmb6q5HS9av9gKFAZtP3Z1ZIoOHpF9POudJbn+XeS6fQcNIDH3/xQCA2Ohy/nriANAcFZiQpJhG9Jrx/7/EHZcUwc3Lh3mg4pn3y9yX5aVr/Es0kQx0WGaKFljeqBlXBR8GyRWoUMcngoM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiorWAMPfj0vF1JW4+rSk0wrSXc7qT1bhkdZYCUmdV0=;
 b=xH+u+wOSs3PCkGD6dSqXU8KWkDLw+WJUKAawz+rDA68FQP0uzok4wi9KLdOojTmFB96dvYFRAQibP0YOa9b09IcLfQxbk7trrNMRBQZw4/hxgELDZ3hlqdQiDxrPdNFo0BrXooIxGT03ipifNUC5YMH62iw+t4KBPXP1QqVGpyA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB6058.namprd10.prod.outlook.com (2603:10b6:510:1fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 13:23:59 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 13:23:57 +0000
Date: Thu, 8 Aug 2024 14:23:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 05/10] mm: abstract vma_merge_new_vma() to use
 vma_merge_struct
Message-ID: <6e74bd4c-395a-4f8e-8c1c-8a0a23466599@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <f4f4b5d441379b22f92d7cd188c2095198cdbc86.1722849859.git.lorenzo.stoakes@oracle.com>
 <20240808150208.372bed7d@mordecai.tesarici.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808150208.372bed7d@mordecai.tesarici.cz>
X-ClientProxiedBy: LO4P265CA0204.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: c482a03c-539d-4f72-bd84-08dcb7ad5b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1o1SzcvVWFPZ28yVXh6Mkk0WmpBOE8rY05jOEx3dHpaZ2tad29xWFdSVUVG?=
 =?utf-8?B?Nk1KYjc2VThBNWlVSE5GWlcxTE9BT0czbEtwRUNmZkowN1FKMmJyaitXZER0?=
 =?utf-8?B?NVM5WWlDZUhqV3ZzN0I0ZGhXOHZCa1pZTVZzMWtRSi9Qd1BiaDhxMVdvWEdh?=
 =?utf-8?B?R2VSU3ZpQVlPRmxMU2NGbkFZQUhWcXhkNmZaQzEwNXMvdm1WcFpGeVdZL21J?=
 =?utf-8?B?bktKYlIxamhWTnNYRThLVmw4SFhCMDh0Qnh4UjNoTXFhUUFwOHJ2UU5DR2tQ?=
 =?utf-8?B?TVl5WWtSUUM3Z1R0QTdQT3FueGtDdWFjNnB5VTVBUW8rbWlVN0ZncUdnY3lz?=
 =?utf-8?B?VndHY2NEOWMzTFZXc2h6VmY5K0YrY1dFWXJGcWpJWGdyb3BEL1Fna08vMm9j?=
 =?utf-8?B?SzlONDl6WVNQSEg0U1VuUGpLNC9nak5LWDlEQU9GSGE4Mlc1eTNqeGpLRWxt?=
 =?utf-8?B?b1JUYk5zRWdSclRtc1VrUmRvaE9hYzBpZjFldzl6SHp5YmFtV2lINVFlVGpP?=
 =?utf-8?B?dWg3bFh1NDYxR3dLQ2VHdWw5eEdpWDNlZWQwRG9sOHBSNEJhWnE0dHZkMlB3?=
 =?utf-8?B?MXFoajlTeEZCVUF4eXdjQ1prbTM5ZHdrVVZoYzBPaXhsY2VjM2EybkxFcmc3?=
 =?utf-8?B?blExNkx0a2dYWGo0eXlsdjQ1SVdFRlJnTVNSWHN4ZmRHT3VhRVdwSThLbHBn?=
 =?utf-8?B?YzhPNnlDK3BFazBvRDM2YWtDK1F3MnJzbGZjb2pITEpacGRQUUFIc1RHdDNB?=
 =?utf-8?B?ZDhFSWl4NXFIT2k1a00ycWl1T2MwSVJzS0dCbmJoMWZyVkNyR2plWUw0cU5T?=
 =?utf-8?B?a0pmcGk1NXhpbVBadFI5SDQrM3BpK05BdlFTTDArYnhVT3BCM0MrRkF4QzdU?=
 =?utf-8?B?RXZUN0tiRjJXcy9ZcVdneXNDYTZDNWFaemtpbUM0OWUxRHBUTkpPVjlOMmJ1?=
 =?utf-8?B?QzdCM2JPc2JyMnNzM0xSOGNMdVg3c3UxZkhyajB5RXk4UlBzU1VRUGdNbStl?=
 =?utf-8?B?c1dLamFTWkZwYVU5OFNNVFVLOUhybUlIdE1NNVM1aktlWDhnZlFEejNsekpY?=
 =?utf-8?B?cHNTWFZhLzZEbDcxL0pHMVRXQktrRzlCNzlTS0dNekRXazdDRzVFc3c1QzA5?=
 =?utf-8?B?WTBUSXFKQ3Z2aDc1bFg5djY1YVJpYkdWMkNTQ0cwM0NqZlVHdzdQVjYzR0xq?=
 =?utf-8?B?YlB2N3diaTVOcEZReW1uVHc4cm40WUFROStuK3M5RkdPRTJ0bjM1VnRvVGli?=
 =?utf-8?B?NDFoMUNqOVR6MkxZSkwvekhUT1pkeFN4TmR4NERyNGJyR1NtWVdDRFhkTHhU?=
 =?utf-8?B?c291ajNIbGhNblZSWUMvRkVUMG1sRG9IRHhDZ3VOQjQ1RDB0MFltRkRwV1VT?=
 =?utf-8?B?OExlV21XcWdxdmxXUmlQKzlOWmxiMkRYRzY0ZjJNekkweGNnNkoxWmVCVVls?=
 =?utf-8?B?UXN5M2NGM1lmNjFCbVlaWFRCRGdQTlhseXU5VU1sdEtBcTBkWGZ3NUVYVy9T?=
 =?utf-8?B?ZWdLcVJLM0RJTTYwNEdsUjQ3bHZFckJ5RVFHQ2c2eis0aGpvb2oxczY0OTRy?=
 =?utf-8?B?eHhUelpOV3ZWWDlSa2dnSHNEcmplM0lIQXE3VEJwblhjZkZsSi9MNmxsZEVs?=
 =?utf-8?B?LzZaTFU3c0g2ekpYUkVwa0VPdC9xcjlLVjlzamp4dkVXN013dlVKRExnakhy?=
 =?utf-8?B?WEFmVVV2Rm81VlgxbXU3UmRTdDJFWUZHYndOVTgweGhPN3RnVEhjVHU4R2dS?=
 =?utf-8?B?ZkhlUWp1SDdmeU9lT3NrTDZDc2l1elJtZDlGOENxNG1oMHZud2RjcHlwMDFN?=
 =?utf-8?B?b0d4cW1PRit0Q0Z5U1Z0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGljUXVEMXEvdlRLS2RudjllNVc4K2t5b3czVDBSaUlzWk11bUdCY09rZjkw?=
 =?utf-8?B?TUliSkpCeDc0Q1EyNXBRLzVVUEplTGFWaTl5czB1MUcvSXNZWkNTQTlkeURl?=
 =?utf-8?B?UUJyTHJyOUV1ZE1RZzdveERlZElaVTc2L0gwT1liMXhDY3NnbHdiTFZGL3Bs?=
 =?utf-8?B?NjJYbUl5d01rMGIxeG5rMUppb0tmTUh3UmF5NTQyQ0Vla1hnTEYvcjU1ZCtu?=
 =?utf-8?B?eklkMHBoOEF4eTFqeXFacjNpa2pRdlE0L3FhOXpSeW83VTZzY3dPVVZVSEwy?=
 =?utf-8?B?MFNXaEJyTUJsSWY4MWV6akhRNG1wb2JOWktWSnRyR3pBdXprdG0zR0RqTEx0?=
 =?utf-8?B?Tlpib0VnUmxYYVRpTnZ3VUJ5QVd3VUZaUXRsOGNjai9qa1BpcVRLWmVQUy9Q?=
 =?utf-8?B?NDltUGVUaDRTUGpSclpyNUovVDdzV2JBNGRMeFZGY1VGeG5xT3lQQmVoYVdG?=
 =?utf-8?B?Rm5LU0V5UWpwYlhGL1dSeUZTSUsvOURyY0p4ZFBmeWZkQkU4U3lBS2RDb0N1?=
 =?utf-8?B?RWtQUUlNYnpKVG5POEhOeTJ0N1d1MDVoYWw5Tllwd0pmQ3I2UjZGTGg5dEhM?=
 =?utf-8?B?cmhaelNyY1F3SS84UVBMdkNTd2xUU3VrRmNFeTNXaWRILzhuUnhiSU5ZaGQr?=
 =?utf-8?B?VjJnUTBCTm5jUGVTdXhNa3F5RkpDUmhXRWxqMlJUYkRLTk04VWFna0tpTENT?=
 =?utf-8?B?dUNqL2doNWlGTFd3ekQ3SFZTUlQrK2h0d083ZFh5S05OZDhtSVFWTll2OTZa?=
 =?utf-8?B?MlVRbEN3YytueHpXdmFrcWRhK0NnZUViMFVoSlc2a0t0RjYyaFkwWUd3TjdS?=
 =?utf-8?B?RERVVWxmdVlmRHpDVGQzUXp3cDhrVmpkWmJ2Nys1eUZtQkJmakhtek1tOW9Z?=
 =?utf-8?B?eWJSaGRxZm9uVDFBNElCRWFaSmpsT25lV2RBYTcwNDUyV2RzS2VzSzJSSUR4?=
 =?utf-8?B?Y0Q2NUZmd2FVVzBYR3lZSjlOSFFnLzh6QjNvNFhLeVZDV1dZWDV3YlVqMWJZ?=
 =?utf-8?B?UXBrZUVka1VZSkk1elhNV1U2UkltVFk2SFlIdVZITHRPa09udW1Xa2xFSkNT?=
 =?utf-8?B?OFZVOS9BMGxkSCtGQWU0VzNBRDdEaXpxZzFybTlocnAreDhmdGxjRDJtSHpI?=
 =?utf-8?B?T3dNOW45YlNLZE5iTjBIQTdRd2VvbkdjbUNNTW1xV01hZjdJN1JMUTFCTTBE?=
 =?utf-8?B?VHNLQVlva3Bhbm1LNDFvN2ZKQytuVEhWclBYRkFMNm91ZVNoSzIyWnFVVHdv?=
 =?utf-8?B?WWVVSDRoK0xFeHlrR2xNWk52cUF5ek1rOGwrQXAvZTVyVGovTFlnSHpiajl5?=
 =?utf-8?B?RzhBNEYzZ3FGN2NZQzNnM0RKVmdrSll5YVZkSU03bkc3NzRvMXNETm92Mld3?=
 =?utf-8?B?aUJRTU1UVE9ORk8xbkhMTlV1bVRvVDBKVjdxZnVlOEdTeGJkZlB3ODQ5aWxV?=
 =?utf-8?B?RFBpdTFrQnJlclB5Q3lER2JTbzdwTGJ4SGRzNjU4Y3NDUC94aVJ4TTFVMkRL?=
 =?utf-8?B?c0RreEh1cG1pUTNLNS9sNTI5RjhYTTU4Ym16TTFUVmlzRSs1SCtZSWJXWm9S?=
 =?utf-8?B?YlJWY2FOTDhzZTFHelF1NFZhdFJMb2NoYUtPRmttajZiZHVTVTVaRFdBUmZr?=
 =?utf-8?B?LzhEcE9ZZTNVNFNMVXZHL280YkNSY09XSjBnRlRFTGFZbjRYbk5yelU5b2pF?=
 =?utf-8?B?OTh4cjBIbE9zUXpFRkd2WEJGdlhnNHFTSlVXYVhYVWR1R3prRWZmMGRqSTZB?=
 =?utf-8?B?ckpMenhHM1FrcER6WUUrYmxxYTlRcDYzU215cG96dW1LdDlFaE1ZZHQ5U2pt?=
 =?utf-8?B?Q2xmbXdzWnVza1Y4TzJLc3oxSU91NlBRS3Y3aE1xdkthTFg2a1BNcHIyMS81?=
 =?utf-8?B?bHFwa2tsQUl0bVFPbmFHSmNwNkU1RGxqY0xHbmVkb0NyUE8wUmdCYkFYSjY4?=
 =?utf-8?B?QnE4VEt3c1lyaFQ0R0NGZS82Z0p5V2ord0ZOdk5lN2hsWjI4bFl0U3FkKzda?=
 =?utf-8?B?VXpZY3RhUnBxNytTcjlNb292d0VXMVJPeHZPL2xzc2RnYjF3VFlPMkJWSFha?=
 =?utf-8?B?dWc1VC9uMHl0SSt0bVlCRS9NNFNNQ1FPR2lWeDZvSFNnaWU0Skd5Z0lqMjA0?=
 =?utf-8?B?VWh1LzNHaUFESk1iMHVscSttN25rMHlsZ1IxU1dBTDZsZ2NJQzhzK3lOQllO?=
 =?utf-8?B?QTZyZ0g0anF5V3cwSDNQL0pNcW9OTUc3bDJONXptVzZiaGhHcitDYm1Ecm5M?=
 =?utf-8?B?QkdxeUViVjlPbDh1Q2NBNGVHTXFRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WzjPs3Yzsbu4omEpATgGPU7vweid4IJmO7J9GGbRicedMIacYNkjaUxA456Qcq2ZL2gVAZ/Owh559/82v7zUvyLVefbVMzhXbU6SktNzsWzeUkNN9Quxett7378+YqQF2rqJUq5vXkZrmKwC+RoiatejvIhF3HzCOguqmjLfItlAYJRs+nvfpQR7+/4yh7Vt7oByrOQNvhK+uVZvudZV1J4Fz3cExOix18KiGyo9JBxCH8hTjI7S1EbdgQ8JIDSzoruk985PJRsYVP3v+4nFFO3PdAaBJLwty056qUgaAwkHCMlEHFf5h+PpALTnCKK4Z6lItx+L+TeHuPzGiX2yItz4Fm0f94K3lcwybRtg1+HwjvuKsq9C83i9zog9Pl+wRuZwoM8ZLHBaqFIM9myd3JHNsL7k11spw7PC2/TGM7Kq38efgzHIrBujARcA425IDNla5+Ik99PCmpUN1E150I70KmXUwamx4XoRpe9wP3vgTk2tWCqA4yBBVVrU2uDy/VpVXoMK6afbQpS0Aux2Bz/ztTYofkIyO5mmCtnUbr6j2AylsH2pEhyvSO3pTVKrYztcJgHBq0DGb8ZOMysaVrtiS9/8LOGvL1VJsSktMy0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c482a03c-539d-4f72-bd84-08dcb7ad5b56
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 13:23:57.0760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlQaXMAYZlRMOHobxY2x6XwOTDW5mnv1jdyuNH3Yel8wTHVxBdbF/MDcO2vbptKCjLZKKgXB9auocyARjtqaqZzX+UUwl6+322QcceCw0F4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_13,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=885
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080095
X-Proofpoint-ORIG-GUID: WX85mt-9i2AHv8PM-igbelRmr215SDrF
X-Proofpoint-GUID: WX85mt-9i2AHv8PM-igbelRmr215SDrF

On Thu, Aug 08, 2024 at 03:02:08PM GMT, Petr Tesařík wrote:
> On Mon,  5 Aug 2024 13:13:52 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Abstract this function to so we can write tests which use the newly
> > abstracted interface and maintain a stable interface for tests before/after
> > refactoring.
> >
> > We introduce a temporary wrapper vma_merge_new_vma_wrapper() to minimise
> > the code changes, in a subsequent commit we will entirely refactor this
> > function.
> >
> > We also introduce a temporary implementation of vma_merge_modified() for
> > the same reason - maintaining a common interface to the tests, this will be
> > removed when vma_merge_modified() is correctly implemented in a subsequent
> > commit.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/mmap.c               |  6 +++---
> >  mm/vma.c                | 33 ++++++++++++---------------------
> >  mm/vma.h                | 33 ++++++++++++++++++++++++++++++---
> >  tools/testing/vma/vma.c | 12 ++++++++----
> >  4 files changed, 53 insertions(+), 31 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 04145347c245..f6593a81f73d 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1494,9 +1494,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		 * vma again as we may succeed this time.
> >  		 */
> >  		if (unlikely(vm_flags != vma->vm_flags && prev)) {
> > -			merge = vma_merge_new_vma(&vmi, prev, vma,
> > -						  vma->vm_start, vma->vm_end,
> > -						  vma->vm_pgoff);
> > +			merge = vma_merge_new_vma_wrapper(&vmi, prev, vma,
> > +							  vma->vm_start, vma->vm_end,
> > +							  vma->vm_pgoff);
> >  			if (merge) {
> >  				/*
> >  				 * ->mmap() can change vma->vm_file and fput
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 3d6ce04f1b9c..55615392e8d2 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -1106,6 +1106,11 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
> >  	return NULL;
> >  }
> >
> > +struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> > +{
> > +	return vma_merge(vmg);
> > +}
> > +
> >  /*
> >   * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
> >   * context and anonymous VMA name within the range [start, end).
> > @@ -1260,27 +1265,14 @@ struct vm_area_struct
> >   * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
> >   * must ensure that [start, end) does not overlap any existing VMA.
> >   */
> > -struct vm_area_struct
> > -*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
> > -		   struct vm_area_struct *vma, unsigned long start,
> > -		   unsigned long end, pgoff_t pgoff)
> > +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> >  {
> > -	struct vma_merge_struct vmg = {
> > -		.vmi = vmi,
> > -		.prev = prev,
> > -		.vma = vma,
> > -		.start = start,
> > -		.end = end,
> > -		.flags = vma->vm_flags,
> > -		.file = vma->vm_file,
> > -		.anon_vma = vma->anon_vma,
> > -		.pgoff = pgoff,
> > -		.policy = vma_policy(vma),
> > -		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > -		.anon_name = anon_vma_name(vma),
> > -	};
> > +	if (!vmg->prev) {
> > +		vmg->prev = vma_prev(vmg->vmi);
> > +		vma_iter_set(vmg->vmi, vmg->start);
> > +	}
> >
> > -	return vma_merge(&vmg);
> > +	return vma_merge(vmg);
> >  }
> >
> >  /*
> > @@ -1295,7 +1287,6 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> >  	struct vma_merge_struct vmg = {
> >  		.vmi = vmi,
> >  		.prev = vma,
> > -		.vma = vma,
>
> Yes, this member is not used later by vma_merge(), so it need not be
> initialized. What about not adding this line in PATCH 02/10 of this
> series? AFAICS vmg->vma was never used by vma_merge(). The net result
> is the same, but it would make it easier to understand that this patch
> in the series does not change the use of vmg->vma by vma_merge_extend().
>

Yup fine. This is again not hugely important so I'll tackle it if a respin
on something more substantial comes up.

This is because previously the vma was used to reference mm, but I changed
how that worked to help testability.

> Petr T


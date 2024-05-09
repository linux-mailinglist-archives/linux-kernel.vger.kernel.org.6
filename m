Return-Path: <linux-kernel+bounces-174699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3FC8C1329
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAB32828FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18F66AD7;
	Thu,  9 May 2024 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FH0pXHtm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Av4uBoLr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4517F5
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272852; cv=fail; b=rIgAwwlT2osopv7RNiG/Ub+N47kw1cFwd7Cb/DkKGJBl3baLpRX+MUkzjok6ZRAzRpPiWxmrrVfbzJ5BSC9Ey3zlG62r4Yr2vCktI1NyGJ8GpWIxLKTtqjBaFUBXHl2kINSmoeeZ+fNLfGOT71WJwEar9R4zyib3an6PvrHk+UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272852; c=relaxed/simple;
	bh=wXoYZ+GYkfvSOXSnFc+VEz2Z99kkBf7Tfb3T7DekOdY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iiMRLCUl3TjdTzQ0pSMH+zEcY7kQZVzMlgDysy73FvJDIiKxQwMgYYT2bKfeup3HX+vexTPk751mjq15R5NEomCpbgLGpeMzF2stZTru/gIpARb5Tnbw+bgedxOjlJV9aHherZ4GghEYzFomBFAKkXvxx30hrbfxOD+ikD3wTgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FH0pXHtm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Av4uBoLr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 449GcH2l020578;
	Thu, 9 May 2024 16:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=C2JJiSPfwl5xnGMvzW9Bi/ChRjF4AbKFg21ZmY5AO6U=;
 b=FH0pXHtmDgiiFNk6PolBealwCkgErj7jN+lU+M0chDZR/zRqkOvnm+UCjUgq/n6Gpe/h
 D+PUiXoOcyqETOxIdUi8cIWVW9irV7qZAZNRLR46yx/ITvJ/+eOysoGZfZ+YdDWf5oD1
 4k2u7xhGmiXH6VdUlSt8QucPYSsGELYMFIjdp1jwJ9Bioo0MgeJXx65uSkevO2WyDSiO
 46CC13R1rc81NhiAVXpo4QMCVQuJ31Kj/rd5hN7eVZTxsnZnyLCdoSwWlI2t+OCEqTx3
 5PW5rKaHAHPhGItJ+kx3FhaMxuPnk6G030MYZkoc+FAwlcxkG1gz9NWpJFCm5pQvq4xY Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1265004w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 16:40:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 449GWxBs019108;
	Thu, 9 May 2024 16:40:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfndr95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 16:40:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wzjh+sImUOZ51pyQIxVilxAeNdfyvhFqL/eZplpEyugDsXtOW09UMxSDejwLb3keHfm2B7DMVWpO/JlZeyUb/BOTlIydUI7h8quRCu+7fS8XAwjU36Oxm0nlaUHiKzPE+W+bYo07NPWgsJR3uO3dhVJUFWWzcttsbRvfDtv53+BnHw7/V7v27GqkAKUyXpLb5HSwLlhxBVl2c11bthsWmLPjK1t+4Dv2G1LKYAxpRzol0EVyshO4PiVB8zeD4tSTGzCT17vXcvQ90qaNA1kzf8Ckv8XBN2EnvInuBeUHLO6WuWr+IWSZSbjUyPnXwKNdILPwsMzArtFZ3+JWRzPO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2JJiSPfwl5xnGMvzW9Bi/ChRjF4AbKFg21ZmY5AO6U=;
 b=k1MWBKnF3Qwy5E7eku7QZ3P5GWsrlI5cTNsOjpPK1BMA2InqBApE/UrSmrSy5dwvkPZtiE58MYu21/EfcoGzywctXoGQQ/oqMLiNfWA2vPATtk1fKkaFlkMYcBx4+73Qd7Hx0BvsJrJZe8YAB9WvvllV0/vOA2JyjW53/X94U+6rEutpqInQPVMMcHqDyuuyd8Nmcp3s/L6nrdHSdhX7blgxvvn5E4sj7JD21k0cSau84YHygDW/yh92UsafV9F2iPu559bCYtTeo6eHZsXOiDeKCNO1ZQFRWrGdq8KHbcRZ29vrE1Gf7vGfI/g6+AHwOtdOOitr1PnnR0860oG67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2JJiSPfwl5xnGMvzW9Bi/ChRjF4AbKFg21ZmY5AO6U=;
 b=Av4uBoLrIYORvKsFrjOkQy4JrkylxOasTS99wqkGev1XdiusWLkCvxo2ZgiSeo5WqcW9DUN412zHKDhfqLdRfm/LaDjvj4+MBWayJnlnsrIo2WXQUiRWeup9ZZKzr40TbwKrCXiSufUVqsofstowoGTVgmFhmpxyh3KTAztHR+E=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH7PR10MB7852.namprd10.prod.outlook.com (2603:10b6:510:2fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 16:40:34 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 16:40:34 +0000
Message-ID: <fdb287c4-1db9-425e-84fc-013ef539cf72@oracle.com>
Date: Thu, 9 May 2024 09:40:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/memory-failure: try to send SIGBUS even if unmap
 failed
To: Miaohe Lin <linmiaohe@huawei.com>, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-2-jane.chu@oracle.com>
 <d5dc761e-3f66-99a3-5325-dd2f161235cf@huawei.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <d5dc761e-3f66-99a3-5325-dd2f161235cf@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::17) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|PH7PR10MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d39adc-07bd-48f7-4f6a-08dc7046bfb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L2pXaEc3OXdWQWI3OWVnaWFCbG5wKzc0WlArWklGYTM0QnN2UzNvMFpIY2Rn?=
 =?utf-8?B?ZWJZMGwycVpxMDBHck0yQU5MZ21KS2VGVi9Kek9LSnVIWnB3MkZHaHo0bmIy?=
 =?utf-8?B?dzYrMnBkNHVvQWVPOU5vNmZLcFM2OE1PY1lUT3c0SmJaNWxPQnRIL21yOVh3?=
 =?utf-8?B?N25wekt2UEhiTXZEL21naVVhTzlTQzdaL0pXK3dUUUQ0Ync4TVp4OCtjUS9k?=
 =?utf-8?B?M09YcWlqSThveEUyWStaK1FEWDZFVWNzQWtZZWJ4M1NHbEtBdEYrOFpqSUtJ?=
 =?utf-8?B?MnplTVo1OXZDdVVxdEhjYjFjaDdWQkllc1BQMll2OFJVdTAweWRGS096WWlN?=
 =?utf-8?B?YTZNTEp5eXRHdGU2endLK0kzTy9XZFl2MnRvMm9ML3J5b3pydUhERFBWcHRM?=
 =?utf-8?B?TWMyRUdHMWlnSldXSUNmTkkreWZQSkhsYnRJbkhVV0FEV1ROZ0VxNE1PeC9s?=
 =?utf-8?B?dm5NblFBQ0owQzdJRG95dFBhVzVpZHhDay91dDJ1VmlsMFZRSVQrZnBNM0dL?=
 =?utf-8?B?NkRLUGlXUGszcVNMZFRaT3lqeVhobXIyYTRBNnpubkcreTdwYVhhZE5Va0Rk?=
 =?utf-8?B?TUJsRjNvMURoSUJzL2dja1o0bkE4RGpZWkt6UlJKdnpHQXFVVGtKVFZxQk80?=
 =?utf-8?B?ZFVOUWlKTmZ3aitsNFJlTkdnSjd6Myt4Q1lmcy9PeFZpN1U3dTBPU29aQ0Qr?=
 =?utf-8?B?RjBsWjZrWVd2eHRjcVNVRmYrL0w2dVIzUldQcE81NTNLMEs2NDVZTTZ2aWo4?=
 =?utf-8?B?Q0hwWmRUZ2UzSE5LRUJSNmgyR3ZBZ1RYaTIweHVDQTNzZDJ6am5UamU2UkMr?=
 =?utf-8?B?SU1zSkhYRHZuRDJ2Vng2Y2NRdTZIWklpWnRlZmpYeWRNc2s5aUNtVnpMYjZD?=
 =?utf-8?B?VzdnckdRYVlJdFg0R09tLzJ1aGwvbGtId05vTE9sb0U0RGY1WkNaWVI2bzFa?=
 =?utf-8?B?ZlBxMTZ5MmNrbW03Z2NmVlo1ZUwrc2pCeTgyRDR2Yi85T2MyTmJxSjVmcGJu?=
 =?utf-8?B?QjB3ZUNSdVgzWXZNY1hKMmRUQ0l2cHJpampTak9CbmJUZ2QrODBYZzgxenlD?=
 =?utf-8?B?SnZPWXg5eSsxdWdQb01GcDFrRW9LLzVsTVFJVXgrbnpvNEsyUTRweDcxZTRW?=
 =?utf-8?B?d0hvdFJaUVhwMlRKMVFEelBsVUluNVVXMVJIN2Q1TWFoS285clN2ZlBuV2Rp?=
 =?utf-8?B?VjQybnNBODBkNG1XdnZzUGJQS1lWb3F2WlpQY1BINmJoUXFLY3BmS1dPbGM2?=
 =?utf-8?B?MmVYYlhPbGVPRmFGNkw2T1IwUm1PeFJzb0hZWG5JYnJXWWRnRE1oUHFiZmxH?=
 =?utf-8?B?cEYxaWRjRmZIZThxc0pxdUoyMnhIeUh2cjR3WWhCOTJTOVJxcXAwTXNDTXE1?=
 =?utf-8?B?Y1dWY2cxZmt1bkFqaWtzcElyNGcrWENCR0tHL2MzOWV5bFFCMkNESmVFd2RT?=
 =?utf-8?B?U2s1bEVYTzFjUDNacWZPSzd6YmlvVGVXUGhnNXdqZy9tY2VhOW1wUDRQVDJh?=
 =?utf-8?B?RDZxMkRHYzhIVW4xT2xvYWNCYVhHS1ExZDQ3VVlXSzRNNnlNeGk3S3RRYVpU?=
 =?utf-8?B?NVhiS2M0a2dZYU9wRkMwYXBLLzJQZG5LbU11czFFRHVlRHc0VWlva2FmTDB5?=
 =?utf-8?B?SGZwR1RXT1d0d2N4T1ZBSTFNUXN6alBUVlhqeFgxMzRaZzd2YUdRTTcyMzA5?=
 =?utf-8?B?OUcrV3NxcmlobG12Z3lNMmM0Zmd6TEl5Q3ZybmF4MTJHdVg4Vk9CbzVnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WlhlTjQ4QlNIT1FFTDVFQlBvZ2xWV0YwaFlWemVGNGVvT29OanFISW0zWDRT?=
 =?utf-8?B?Z0NTV0RxNVJqdWVXREhWOTJHWjVMVjNWaTQ5clpvTVZxMmUzcVlBSUpiVUli?=
 =?utf-8?B?VUZwQ0twWnZkckI1UW1seUxROHIxby9xSk9FQTB5NVFjU3QzSVJMZWZwOXdL?=
 =?utf-8?B?UDFPc0NoV2pqYkE0cnlmMnRidERZYnVyR3JqZ3Z4SmtMeGp3RUd1aExyVi82?=
 =?utf-8?B?anUvbEZZaGhQOFZzVTFzaXBEc2pYNmo2czZiZEJRaGhnQ1hWQWM0SlhWS25I?=
 =?utf-8?B?M0h3V1c1eDJuL2RITXZhY09CL0F0aVB3TmdnZXQwS2trWDllSlczZFpSVHIx?=
 =?utf-8?B?VHM5Z2p4V3F0ZTdyL00vT3hNVm1mUE1wcnVZQkZZRC9IQkh2MjhwZzdvaEU0?=
 =?utf-8?B?Y0Y4SWpOWS9INmpWdnIxRzI5S3h2QTQwanVCTi9ySGdBd3dyb2IwSTZqaW50?=
 =?utf-8?B?MGpOZ05lbEZveDlqV2s5NWtQWnpNblVGdUxlbVo4Z0grQWZOQjAzSkJmL1Vm?=
 =?utf-8?B?ZWFSY0QrSzZBVVBzWmhOejlnRys5c1l4QThocXllZUYrMnZCdTVaZWs2Y0sw?=
 =?utf-8?B?eEJnUWVyVStmSjNjYzNxQmlGNForNTlrN2pwRnFMNVIxOEdBTHo4Z1FjQlNP?=
 =?utf-8?B?R3N0TEt0OU84eGpzbXNHc2R0Rzg2d1Fma2JJREdFc240bldlUkJkbUdVdmps?=
 =?utf-8?B?OFl6M3BpM3RiM1NrcW93d21UVXhRbEhsWEU1SjlzSnlJbDlOZlpNWjRCUWZs?=
 =?utf-8?B?L3cxMjR5NWpNTUtIV1VxNHdTUGc2YlYvaHV6Zit4ckw5SEF0UHNiWHZ1NVg2?=
 =?utf-8?B?WS80RUVscW9xZFg1UDlXY3pqWVJqcWJKVUgyaFBpVW1wR244R0NQdW1tVEhS?=
 =?utf-8?B?cEtvbURySHlMM0VTeHkrY29ucFAyQktpREVMQnc4SkU2VUhmT2hWWExKenB4?=
 =?utf-8?B?STJpZkZ2cWFSMFBHQjlFNkdNaTdJQ2V5N2xNbUE4ZXdBdDdwd3BmUFUwZUdH?=
 =?utf-8?B?ZURPWjZXQlR6amF4VUtMcGRqS3picy9zTVpnWVZnMlZJakcvK2JKM0ExWmVl?=
 =?utf-8?B?alVwOTZWVjBFUHpwWkVNek5KdjhiTEVpT3o2YnA5VVdlS1RwOXNUbkZqbHN5?=
 =?utf-8?B?ZUxEVm16K2lEUjVTN0RXZndIaGlSNHk5WEx1Z2lDRWhZT1N4V1g0VittaGdG?=
 =?utf-8?B?a3ZxR0RtSXpsMzlmV28yZmViTjRHcTVXeDJGSUNZc0hwbUpjMXMrakJRN09P?=
 =?utf-8?B?emtkUDJ1QkZiVmJCdEU0b0pqcC9Ld21pd0tLdXdVbjhpTENtUHBVTitLeG13?=
 =?utf-8?B?YkoyYzVLSlBnSk9heWhaUS9mTFRIdW9pOVJhNDNldm9hcDg5Rk5SWXF6YWNR?=
 =?utf-8?B?Sk1hc0RqM3I2V1lLb1QwMXlwRGU3WUk3VjlOa045S0I0ZUIzYUt4Qm9RL3lD?=
 =?utf-8?B?ZXkvSThoemNmT043eXQxUlJlZUcxbnZDcDZsOEpOMW5NR3U3dUNsM1JnZVhn?=
 =?utf-8?B?YVJvb05YRmJGenhXNXMwUTJ1UXlNVStObThyTTZyU1k1YXZwMWlhQ1JLNjMz?=
 =?utf-8?B?RWJBQ1NIbGYydVdubWpSdlp2UTZUQ2FUN3FCdU1tZmI5K3Ywb2dHSmdsT3VN?=
 =?utf-8?B?cDc3K1JPc2NzU0pKcVZWTGxhakxXUnFnMGFLOE9VeE5DN0ZHdDBhSGx5aFZX?=
 =?utf-8?B?VlFNN3E5Rk9FOFNFd3NYeGtPZFBPV1JJeXVzMWZuYy9Ba2oyNURjVHlRd21l?=
 =?utf-8?B?SFdwaHU2c2hRMHc0dGYyakt2TGlKUlVLUXl2M1VCK0pFRTdvSDdVcnRVblgv?=
 =?utf-8?B?eDZHQmx3aFV6SUJDNVovTzdlVkdKd3Jrai9JbUFGSEROVE9QL21rRllPejZn?=
 =?utf-8?B?WnZLRS9wMGtybzgwUU1DRUpKNjBtL0tlc1N2cTdicE1nMTlMRVkydEVzaVpI?=
 =?utf-8?B?ZTJxc25OOUdwT0xBOTVDQ1RSTkJiTjBKS3JnY3VPbnR0L3FzTE9PVm5NMUUz?=
 =?utf-8?B?ai9Kc1l4dFkwK0RUS0NtVlIzdmtSRStTdWpjVzNXYlhBb0VpSDBFcG95a0M3?=
 =?utf-8?B?ZG9yS2pqZHAveE44OHYyUk0vblNucFNPd2I3RWtTWkE4M3JXNm9NeTdTNVlY?=
 =?utf-8?Q?J4Au2fVWvjwPeHXx6RotS3t2x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bnTjpZR9spZQ+K0rauxPdauv1vHoyn0WEF462tUOw52b2fksAyuxfItE28lLiJBBKMYsyBgQYLMTvDx+6KDvL7xjyUcADifIPjhHN4Ui1+9K7uLpKQvmQ0aP7+/arY9JLtAc9pHYFvA4v7oh/CdKXO2J9FlNIbDDxKz3GP8brtXAcLyA1fRW2kvt26cjykkVsMQx+ovhJbTGmXxvrxdGq7ZxukewBAraQ0Vwv9IB5GfxlQWrQUh62bCo9d8yBJ3NSezn/yhu6pFaGMLpKW1EquOMLEBLP4QI9MIKHw+UKl3/bo8WcOnUE3MvUtpNPqFopIzGees0P0Vn5CMEUyx33u0KXJlDBMepiPg/M4cCcTpXqmlxGRoxK+YzsTiDHChC9rQoZT5MpaG/CkT06XxEyEys7O2w3IAMANtBPP41n0fWcydc2cSv4jru4DNJGkycjuQkyp2iBqbGNtZipr9fzkZJEREgU0DGMxGAZH4aiVqQVYFD+PHkp6OSXk2U3XdL3wXkj2wgyv7yzUMKy5FHN7HZsum8ADGu3Cvzb1Z1ebYAwWEkHxMRRTlAuNilYLUuJnDAg4hzguNlm/CBQBZOA5mzQo2ShNXQ2MiuCKJEQqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d39adc-07bd-48f7-4f6a-08dc7046bfb5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:40:34.7318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1gu4cxH/6fv7mQkTODhkZf0Go9MH83e4Kf34r3EoxlikH3NgEcHLq7Zw0pkfW6nEKl/VXwOesojoQBygssXXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_08,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405090114
X-Proofpoint-GUID: ui_I6HkRp1tKVVdVklFCXJzZdY7a1Lg8
X-Proofpoint-ORIG-GUID: ui_I6HkRp1tKVVdVklFCXJzZdY7a1Lg8

On 5/8/2024 7:54 PM, Miaohe Lin wrote:

> On 2024/5/2 7:24, Jane Chu wrote:
>> For years when it comes down to kill a process due to hwpoison,
>> a SIGBUS is delivered only if unmap has been successful.
>> Otherwise, a SIGKILL is delivered. And the reason for that is
>> to prevent the involved process from accessing the hwpoisoned
>> page again.
>>
>> Since then a lot has changed, a hwpoisoned page is marked and
>> upon being re-accessed, the process will be killed immediately.
>> So let's take out the '!unmap_success' factor and try to deliver
>> SIGBUS if possible.
>>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> ---
>>   mm/memory-failure.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 9e62a00b46dd..7fcf182abb96 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -519,19 +519,14 @@ void add_to_kill_ksm(struct task_struct *tsk, struct page *p,
>>    * Also when FAIL is set do a force kill because something went
>>    * wrong earlier.
>>    */
>> -static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
>> +static void kill_procs(struct list_head *to_kill, int forcekill,
>>   		unsigned long pfn, int flags)
>>   {
>>   	struct to_kill *tk, *next;
>>   
>>   	list_for_each_entry_safe(tk, next, to_kill, nd) {
>>   		if (forcekill) {
>> -			/*
>> -			 * In case something went wrong with munmapping
>> -			 * make sure the process doesn't catch the
>> -			 * signal and then access the memory. Just kill it.
>> -			 */
>> -			if (fail || tk->addr == -EFAULT) {
>> +			if (tk->addr == -EFAULT) {
>>   				pr_err("%#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
>>   				       pfn, tk->tsk->comm, tk->tsk->pid);
>>   				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
>> @@ -1666,7 +1661,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>>   	 */
> There is comment above the forcekill saying:
>
>      When there was a problem unmapping earlier use a more force-full
> uncatchable kill to prevent any accesses to the poisoned memory.
>
> This might need to be changed too.

Yes, will do.

thanks!

-jane

> Thanks.
> .
>
>>   	forcekill = PageDirty(hpage) || (flags & MF_MUST_KILL) ||
>>   		    !unmap_success;
>> -	kill_procs(&tokill, forcekill, !unmap_success, pfn, flags);
>> +	kill_procs(&tokill, forcekill, pfn, flags);
>>   
>>   	return unmap_success;
>>   }
>> @@ -1730,7 +1725,7 @@ static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
>>   		unmap_mapping_range(mapping, start, size, 0);
>>   	}
>>   
>> -	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
>> +	kill_procs(to_kill, flags & MF_MUST_KILL, pfn, flags);
>>   }
>>   
>>   /*
>>
>


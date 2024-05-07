Return-Path: <linux-kernel+bounces-171968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1788BEB53
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10EDB29502
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54016E885;
	Tue,  7 May 2024 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MeAMfNt+"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDFE16D33C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105470; cv=fail; b=CM1mwb/c3rqqe7Lbi3NS3Cm//oRAhXupszcmpDrp4+Z1wTu2my1k5fnt6HFt3GzwxrTpGL5B2+hBO0/4fQ8kmLTxS1kMEL8eBBWswAxeM6Q5unFvM2xv/l45n2CUiOs0LlKZzeESFK+46DqX5T9/rkuCiD9wh/8Kqvx/Z0737Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105470; c=relaxed/simple;
	bh=spYcSfqs/jLTkXGaxCv8j4UeuMuyZU42DU0hyqY8nAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o5byAwSNvaKZK27TWHzXDFC6coQLb54qt8PRC4XI/ucFSoVlt7MALS3Cka21x8fMXoUQgG9aAD8rVoWMbtqEc90r2/ldWTzFljTC8mvTYrm4YRFe9s1fUslvlxBEFcSn99yHyZ5Zh0aOTRveEObYt7LBT0m4SZlh7/2MJM8yBj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MeAMfNt+; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cx3UUj96dVMxKyGp3eWLqWk/YsKM3g0WQlOIKwWMkA5MnJa9zTrLE330QRJDtMEB2r5LovtP+4oUlwcXMHgQP3roXPyu9WSTUPuh53Um8hlag/uQfDcBD0pPOBwjr8CmDVsYDBW/zaOn8xn3k6KAC2WsvaTJSvJZghbeBs4APTyycWyip6dts47mpIaTGrQGInvLKE9nl9TvUyRB/wJVVtQICfb8f7n3eg+HRQfRaYDU8LwLbXv681koo8QrL7chi88R2IO3zYVgbreKbcvK7+X4hFqJ//5JjaURwR5I5E4NH8Iio7WqHbQ/lPaCs54qUGR8BPTzoKt44A1Yb77H/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KyADvQdieWZEqDmlCZRqk9l5W02GHlHl9EYjQrCO0g=;
 b=LXjlz2XIojYlpSvRBFpjON7wO6AKLxOc5WntBY82NHX8u0eloSqH+Zsj8KuJ+XBhxsM1dX5bEs4QYusVQCSoNuPWv+bHPxmLi1XLyFywVgNYUXSrX4bwYlRMjg/rOcZ5HUwGgaa/+HA7m2uttDemF1NNbkquLXQRlEwngs8kLCUk+D3DcWVPe0jwwUjTBIrJzgqq+lQoIxh/roRlvDtKWxV2EKuu4mIuNBIz4BWE7AUzlveKzZJS3dodQGqxQBMlVxdzk0MxRyJG2LIB8H0oUrodKx31yieOdUlw6rsu5U5QGdE8C+Q1lXPZ63puvG0NTf7HPOXlofqkKYmPIYrjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KyADvQdieWZEqDmlCZRqk9l5W02GHlHl9EYjQrCO0g=;
 b=MeAMfNt+N2iwnDsntVNywN9ruB7Q1sV+VCip4/uBlxPJCn+sRSS0kGeIhNoR84G2KZ3ca9zBcoDnHs8ZUHMlWc4Ra2s3PkThTK7+5EoWl3HTZ+S0klk5gaF+6Tl+Z59ymZ9Xh+HBva1bms9gK5W47pGOqyEoSQuoBusfupZHjr9JUV+Ne4/2flDgw9yZbNMt/QSk6Igf8Dkx/Q7b+opRHJTEvQ6V9UkY/5U63r+KvgAXqyg6rkItzjVAcokPzggyb0NUyIIaMD0QoNF1dT6ZJnf12nwWTpLeZyORYG+/jjO+ATz1mx1Qe6rEcKNV7dAVI1bsnLSjwrrToK52nyiZiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 18:11:06 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:11:05 +0000
Message-ID: <cf7eaed2-6331-45cc-a66e-76abb5448afe@nvidia.com>
Date: Tue, 7 May 2024 11:10:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fault: speed up uffd-unit-test by 10x: rate-limit
 "MCE: Killing" logs
To: Axel Rasmussen <axelrasmussen@google.com>,
 David Hildenbrand <david@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>
References: <20240507022939.236896-1-jhubbard@nvidia.com>
 <016d8cff-efc3-4ef1-9aff-7c21c48f2d69@redhat.com>
 <302d50ac-45ff-470e-90a0-b349821706a6@nvidia.com>
 <21d88422-7378-4a63-8fbf-f70889f309c1@redhat.com>
 <CAJHvVcgYsZJ3Hm1Hpc1pifH49uVniAedL-YxUpS8q7=Y8veZ5g@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJHvVcgYsZJ3Hm1Hpc1pifH49uVniAedL-YxUpS8q7=Y8veZ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::15) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 77140ea8-8379-47cc-7f3e-08dc6ec11013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alg4bmtSREIzajBUUlg4MWVNRjMrZ0VJSFBSNFhtOVZYWHhYdG5QalUxdVBT?=
 =?utf-8?B?V0RZUTJiSDhsM0pELzVXUVRSQnRqMVZkckFwTHNmaXhMZEhXdUN1QW5uMU9B?=
 =?utf-8?B?ZE9RcnVtSzZVblhlS1QwUDdzRGY5c1dRZFNXUkV6OEpwaG1KWXJFT01wc2N5?=
 =?utf-8?B?cWR2WEI2S3gzeHJTK00zbzlRMEdJQ1lwazFRU25UQ3lFU3pxOFBwaVhlbnZ4?=
 =?utf-8?B?VGd0VUNMTkdkcXp2ZElyMy91Z2hBTFptanpqdXBNYjQrWjB1QkhXaC8vRTM2?=
 =?utf-8?B?UWtDVEw5bDR0dUdDYWNQbnd2ZzZybHo0S2RoMHNkWDRocWgzaTQyVFIrd0pE?=
 =?utf-8?B?OVZBbjk5SUdrNVltZFNGQUxDZFg1QXpiQ0VzNVlpcFFtK0tnS1Q0RkkycmxF?=
 =?utf-8?B?dzNPQyszbWxmblQwcjh4aXh0YXhpUG93djd4eXlrMS9mMVJZeUNlaTdoUzlj?=
 =?utf-8?B?Y2o0dmlnMS9MMzdoam9QdVYxdWlQelh4Z25UTW5CVVc2bWgxOGUwRTVWcWFS?=
 =?utf-8?B?cTFHK0pDd21BT3I5UTBrK05JdFMwaWFmbHZPN2lBRTlnYkFGb3E4TTRIZ0xB?=
 =?utf-8?B?UkNocHZhR2N5Y1dRT0xoUW1QTmpMYlFuMWQxbUlMWjNwb3FhMDFwYmhuUHVo?=
 =?utf-8?B?b2R2OVhtSDJKL3k3OXlOYXdGUm1CaE4ycHJONkMySGxzV3VmaGRZeWhhMVV0?=
 =?utf-8?B?dUl1alB1NDB4TkUzWjR4ZHk0MnN4eERIakgwenBnNzZXUnNIRFdHUEN5SWpx?=
 =?utf-8?B?R0dvZUt4NnZEdEViVlNNT3crdUFjVUxnSDhSdUNSRDNOZmg0S0ZiOTQ0ekVU?=
 =?utf-8?B?dWVNQXJUUXEvekhVeEVlbE4vckZ3S2tjZVlpUlNSUExOUVowY3Vpc0wwMjR4?=
 =?utf-8?B?UXJFYWQ5SngzcTVjTlg3K1V5bmxoZE91WDRoSDFISnJyVWFFdHNpZGxxSnVG?=
 =?utf-8?B?MjFpd1lxdWwzMWxLenU3R0JBY25Lc01hQ2llelJ3d1RNTzhLOXJDMzE5Nmpo?=
 =?utf-8?B?ZVJ3ckRnY05KSWRCNi9uTU5UcDlRMndEdG1yUDlKRzhJN2JKQUVKeDRzdGpi?=
 =?utf-8?B?NU56YXhMaUFLaS9nYUZWVGI2Uk1QY2dtTEhZOERxd1EyTmFVVVBIUExLbGlx?=
 =?utf-8?B?R0dSRkZDbVdaMUJKVTM3d285LzE3MzVGSXJ5MllhMDlnK3dLR1pmRWtPNWM3?=
 =?utf-8?B?N2hGczR5U0lReitHa1ZwV090N3ZaQzJVS1EyMzNJWXZsS1I5S3U3UXpxMnN6?=
 =?utf-8?B?ZVNqZUFSNlFETVhUekRZVUdxdDNPSDZmVEhOL3YzMUMzVzZVYXV6SEY3ZmZE?=
 =?utf-8?B?T3dtTmJJNWxDSzBrd3NvdTliNVkwWkg1Wk1odzgyYUNJN3ZpenJPMmxxM1Rw?=
 =?utf-8?B?TllqMHhYaEtnVFFubDhoMSt3MkJMSDl1UHZjSk04bThZUmdJNi8vWlRnMVRw?=
 =?utf-8?B?TFp1TTZ3Z2ZncE5iQ1FPWnlFelR6ejB0N29QUjBtMzZLTElMdEVFNWZSL3hO?=
 =?utf-8?B?bEZjOE81SzVaZEdETnFiLzNyRng5MmlzL2tSbmwwL3d5MnlwWmo5YW5SeVR2?=
 =?utf-8?B?MkRJcjlDZ1BYTUozRVp4emVzK2lQREhIS2JUeGJTUkFEcjVEN1lXR3RpdCs1?=
 =?utf-8?B?ME9LWmhWNmF4d1hSMytnUDg0d05sQWNzZmU5WVdwNThZdkJ4aWZGZXlkQ3RR?=
 =?utf-8?B?WXBrU0tHL2dnbWtJYlQ5bzZVbXlsWUUrdEJnMTZ2NUVMdm5OVlYya1lRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFdMV0o0OFFtQ0ljc21LekZPU0ZkRktxK1ZwSWFVaGVJTVQrSUZhc1M2YzFR?=
 =?utf-8?B?N3dJWk4wQTd2d3B4bjUzVkg3S2RrVXlYOGxMSmFFY25YODA3bHJnQzYxS295?=
 =?utf-8?B?ZmdzNzVJUFp4VUNDU0JMY25KS3JVd3VIaU5pQjZaMTkwY2VDTUt1ZithOTA3?=
 =?utf-8?B?WVpDZWZ0SVRCbzZRZnNkWW1kd0FicG9hblMzd3ZkdVdUZGZMZTZoaTFjdnBC?=
 =?utf-8?B?ZGhjUEpKUTNuQ0ZiVWJZYzRTcVVUTWJmNVdHY1duSndzejErOFN0UDBpTkow?=
 =?utf-8?B?Z0lPd21WcmJXeis3ZUdEeldPVGdiQTMrcmZCNFFiZ2dGRzlkNWZDUWN4WXRM?=
 =?utf-8?B?OTgwUnVIc1J1Vk9BSGJLenpKbE9DaWVnSHRMbGt1Z3BOVUhCYXJyTzlXZlR1?=
 =?utf-8?B?aVBGTXZOQUx2azBLVklUa0JUbmhJUnBkTnlrdmNvOEZoUGd0ZnljMlkvbWE0?=
 =?utf-8?B?R29UZGlEVHVpZWhwaGl2YXk3VkxUd1NLT3AxT0lJVkdXSWt3OC9jREhVeVlM?=
 =?utf-8?B?cEJ1ejd0TENsK0I1dUFXTTZ3U3ZqRmh4Q3EzWFRocHNUb2NkOWV4TWtPSnFW?=
 =?utf-8?B?UUJyRm5adkpRN0lGd3hFdkVUVmR2NEpHK1JBa0k0RFQySEdnOTNtajEydTNG?=
 =?utf-8?B?OWpEdjhEdDdvR2xUQ1M3bnNQazNERlZFUGJqdzFwN1RTVEtpZlVZVXQ0bVNo?=
 =?utf-8?B?UkFxandZV3FlU3ZSaFp0cHgwZVdKdHNTU0ZBZmI1Yk1QUmhNSWw3a0cybXhk?=
 =?utf-8?B?UjZ0ZVBNWlc0SDllVFdIREhDYjhhUitITzVyTmFyOEZZUnBlcVk3ejhjUkcz?=
 =?utf-8?B?bTF4Q21YeFpXSXluczczY3R0c0tQNUZLVysxV2lLMVhhV21vUVFZWXo5RnZh?=
 =?utf-8?B?M2FtV0Y4eUgxSWozdGFTbnBrbUxqRXRvYnI0a21VVTF2d2xma3lpakk2cE02?=
 =?utf-8?B?Um1SS0J1SW9QemdoQ2MvaHRWbWhpeHVHT1ppVm1XUFVMa3lyWG5IcFIwTTRT?=
 =?utf-8?B?d1daZk1KTkQrVDhRbVEwM3ZLSVFERnV2N3J5UG5tYmVQVGRhNHVmVS9VZmZ0?=
 =?utf-8?B?ME14RkFiOURLT2xNS043SzJxbkxob1UyblIwa0VGSWFOSVZRby9DUnVkcU9l?=
 =?utf-8?B?M1I0YzhLTDZyQmNaYUptejdBYmJWVjM5NTdIODhZT2Z4Tkg1NTgzUzZETUxT?=
 =?utf-8?B?N2JCOVhTWE5hc29talkxdEJsNHNlSVM3ZnlJa2ltRE5lQUNoUkZhdkRlcEQ1?=
 =?utf-8?B?aTRCREdjVmVVUDAwZXlvWkh2d0hJa1M5dmcvYXUxRE9ja0djeE52Y2hqdGlF?=
 =?utf-8?B?d05vWTQyS0h2d0gwWS9FMy9RZVRwWmFCdkwzZzdXdWxueHZpb2VndDJDdWpK?=
 =?utf-8?B?bkdqOW1yWURhQkx4OUpKSWRObmVhUGlqeGF4cXpRdFBiSUVxK1FxM3QrbWVp?=
 =?utf-8?B?RjRqSUwxOVh4SmJMb05xUmx3Ynp0Sy9lYlRMTlhheEJtdnNUdE1mSGxLTW1h?=
 =?utf-8?B?YlFjSzZMcUwvM1A0d200L1FlNmZvU1NJclNhcG9yRE8xU2wybzhqRzlhZkpU?=
 =?utf-8?B?NU5YMnRtNDFYQTEvVkx6cXRkNzZWYi9iV3NyRVF0YTVPbmxTNm8xd0pBQzll?=
 =?utf-8?B?YzJ3OXk4Nm5vNk9ZVFVmdW8wOGxnUUl0RHRFbnlYNjUwSmxwc1RGS2c2dzFF?=
 =?utf-8?B?VG9maVlBYzlXc1hPZVFjY2JpTTE0WS94S0tQTW9FVXk1TGpYaGFQdHM3NWhu?=
 =?utf-8?B?ZC9FS0V1RlN1bi9wRVBvdU0yQzAzM2xSME1rWmZUbzFxVW4ya0RTVGFiL21a?=
 =?utf-8?B?YUY4aGViL1lqN0UrU2krTHVDN1JhWnhQeVc1Sjk5R1dvSWZVZDg5Y2JvTTla?=
 =?utf-8?B?MVcxdExoVnhIRHI0cFRuN29GcFROdlI2Nm1xRkg0cC9GdHlTTW1QT0V4ZXFQ?=
 =?utf-8?B?OXUybTRoN1lyNjJyeWh6ZTFhRFJiQzJXMFdTT1kxZS9MYWNuR0d1UnQyNTJT?=
 =?utf-8?B?bzJUUjQ5RGRuQjZ1YmN6WTJMR1NoTWxHdHkxUjhrM3J1WDBoVVB5Z09hMkQy?=
 =?utf-8?B?VE9LU1NMa285My9ldW9LWjFYbm85aWdHRGxpMi9ONjRoZDhCM1pHTjJRMFM4?=
 =?utf-8?B?T3BwSk9UQjhDZ0RGMEVhRXVKVkxXYUE4Mzh3dGdPRmxSWWw4dlJqUHdXbTJJ?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77140ea8-8379-47cc-7f3e-08dc6ec11013
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:11:05.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ww5MrhgA0vaVr2CXNx9qucBMnuZcUJPNyzcOYpdLG4KGZTM6pWgSU94/0yR65bDP+9dIDyLYXtO1secGk5fgIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464

On 5/7/24 11:08 AM, Axel Rasmussen wrote:
> On Tue, May 7, 2024 at 9:43 AM David Hildenbrand <david@redhat.com> wrote:
..
>>> That thread seems to have stalled.
>>
>> Yes, there was no follow-up.
> 
> Apologies, I had completely forgotten about this. I blame the weekend. :)
> 
> No objections from me to the simple rate limiting proposed here, if
> useful you can take:
> 
> Acked-by: Axel Rasmussen <axelrasmussen@google.com>
> 
> But, it seems to me the earlier proposal may still be useful.
> Specifically, don't print at all for "synthetic" poisons from
> UFFDIO_POISON or similar mechanisms. This way, "real" errors aren't
> gobbled up by the ratelimit due to spam from "synthetic" errors. If
> folks agree, I can *actually* send a patch this time. :)
> 

That sounds good to me. (Should it also rate limit, though? I'm leaning
toward yes.)


thanks,
-- 
John Hubbard
NVIDIA



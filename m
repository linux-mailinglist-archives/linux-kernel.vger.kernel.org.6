Return-Path: <linux-kernel+bounces-272639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1631D945F46
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399B71C21165
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8951E4873;
	Fri,  2 Aug 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ke/dkkRF"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1B1C2322;
	Fri,  2 Aug 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608342; cv=fail; b=ePcDbdwFcxxk8Haxt+BRhzfybeenzxZN2SNkXrpZrrvBMlNzyxGiO18FKZ6lw1AidNngCLv5SJsabi9TYx9kNmTV7pO1nL1Wf80/Ot9lDcvblW/HW/ReD0jui/43hBQFuB9/tmvBE2GLo07JcreUZTacLEMCrG+UBaU8jyrHHck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608342; c=relaxed/simple;
	bh=ilL7pn1n+K1UYuI0nfJE5SVyKahynTcSINbrLEEoJHg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p4xoLIqfl264MQgHSTqHf43k02Riny3C+N4eLLNuymneSNFkPWGteqWQ9Bz1f/aZLFrKlsdGr2eHAF7ZIaTad9f8fFb8GCNKTu43xOwPjy9cSz+YK3QTK4ry2n1vBmmGbyDHtLpy81VVN2qGGP6zaSG/9OiUPPdthijKkAbAAH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ke/dkkRF; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqDtxL8y+56ksKpBJIIK965QHWsEUTsaMaIyjBXV8TrbdFuKxLffAckoNwYuwVqUHwxRxCTmLdCbmCwsptRcdwusnyK/fLHevtRb4xgRF5BaZCTM8KxQJG0bLztsHWH9nN3gjJ6aEqyTEl+ZlvHovY1WI+HIXx3JvAFhkfvQWxU0l5YgjIW29VgRjvs2gmE5aC4qFjqV/50QK80AZbaiVMlzZT0QIF+19hVKiXxPe6eCGQlboyQbpdV50xc4jthEC6RcoBbrkmoD2leQi8wdSN97mtI4uKlB7z+a210EQexadoufUSQU7laeSsbd6s5f5nwHnkIJVRNMYVGrwXMbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5o6EibDPldKb8gnvzfxfIEm39Rwloa9FnnxGHxYBDs=;
 b=cCJruOa73aLpA2jVyXkNjdhVvbjC+WNpJfh6X2sC3qT42TgkQ7KjaFgDaQi2suc2wSLU2VQWd4WHBCpNyI/ZUMdtX6KVcJa7kSJXdNRU13t7V6IfD2wLgeUcjMuRxTitx/MkuTcoxuZjW94SD6qF1VQDGjbpElzRoyuTdFaasRYSV/R5O8olp/nPbwDaMNcZYPd2HI1QVLbbGqhsBnANp+dEPIosqBi+RqYwKv/bXBLabILkJtmp39GxOdxR1YUHcZF3+L/hvSUMxxoyaqCo8YVnjLXzGJRW4l3efJkAulYmZX8dzCKqQvBW51GQt7WsQ3X72lpzeQl3PSK6iKp8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5o6EibDPldKb8gnvzfxfIEm39Rwloa9FnnxGHxYBDs=;
 b=ke/dkkRFRN4eKAxRa869YqpxpQV5GRPmP5Q1ChJSAXtw0+jOMfIshKycPIvF5sa/yjM8v6OBdXNKlq8TV8m9Znsa0cKLoplXJ12tHcbfTIYmrKxwFtWUQSzs+j0TrL6VZmxwMMRhpbBN+ZsP9AFLzIBikcN3hwuHFmOgk75kAdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 14:18:58 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 14:18:58 +0000
Message-ID: <3fbb647c-7a39-372e-c85a-a59e6a652b1a@amd.com>
Date: Fri, 2 Aug 2024 09:19:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] x86 KVM:SVM: Provide "nosnp" boot option for sev
 kernel command line
Content-Language: en-US
To: Pavan Kumar Paluri <papaluri@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Eric Van Tassell <Eric.VanTassell@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 Brijesh Singh <brijesh.singh@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240801205638.6603-1-papaluri@amd.com>
 <20240801205638.6603-3-papaluri@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240801205638.6603-3-papaluri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0040.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::8) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 02df8c94-075f-4c61-6f90-08dcb2fe0c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFN0dmVTeW9XYnpJeFNkTTJiTFVJNlFkaVp0Q1pJQmdkaFRYZTY0UHpkVzNX?=
 =?utf-8?B?cWJodUJjUGNwN1c4Ym01a0xOb09zdFI3Rm5nNjZ3MGtBV3MrTUJLL1ZKcDF0?=
 =?utf-8?B?Rnl6cVppWHpYMWVLRW5vOFNqczM2NldIakN2NmptWWlGYWlRVjBPMmovc0Jh?=
 =?utf-8?B?WDdCazhKQ0JFQlpWaUNvditaVHZHUjhvNDMrSm1vTXE0QTMvK215d3JIc1Vi?=
 =?utf-8?B?WWo0eHpzbXhtWk9TaStPMHJjbWNhRFFueGhmeXhHaEo1VkN6RHBsWU16K2Z4?=
 =?utf-8?B?VDlGdmJybTdBMm5vL3pZSk1qVThTUVhqbmVDSkdtZTlUMHE3NlduVkZzKy9P?=
 =?utf-8?B?Q2tmTEEwdFFzam9SeTlQVVJiOUZ2TEtteXo1S2R0VUdyRnU5K3hqTE44QkRa?=
 =?utf-8?B?VHdaWTdzcENMczhGUlFFL2NNV2pGSnZ3aTBMektGQUhnQzlxVGdQTm5XeFZK?=
 =?utf-8?B?Z3JzdlZHL1R1cjNWREVBeFRjQjVrL25ZM0VGODNkU3R0aEo4ck9nMzBObWxO?=
 =?utf-8?B?N1hiMGREb09obEtlZnVNcGNIUzRFUHhQaUZHZVJKSkVXQUYwbVo4dnBQOTMw?=
 =?utf-8?B?ek1CZVJQbmJpNmNSQ3lJQjcrZ0NVREo1Z2N4N3ZNVTUzY3M1OTJEdm9aQ2gz?=
 =?utf-8?B?OGg2V1RsTmkzOUdGU2JpVzRjaVpnTkhVT0F0TmRhRE9WTlU2T2hnLzlUS3ZY?=
 =?utf-8?B?S3pQTXlIUzNCOWFlMUVidWw3ODZqcS9laVp6SHdLWHY1REZNcC9vQWwwS3RJ?=
 =?utf-8?B?Rjcvd25CRlY0Vi9YekdzdzZEMlMwTjY5cDZCd0d0VVk4bzFvN2pRVW9oeFNZ?=
 =?utf-8?B?d1kxOVFBWHZtQlR4d3JNcVRiMlc1bGNCbUJ2c0dVN2t5YU9NNk1TejBVcUJx?=
 =?utf-8?B?K0pIVENpOXdnL1l5UVYydDNBWnAvWHIwK3BGQmxWRzZXVDNZSHRWSWt3VjJt?=
 =?utf-8?B?QXh2OGtFS3ZTOUVSanFZMTQ3RWluT2ZBNitnQVMwSUk1UHN2cTFoWnNabnJY?=
 =?utf-8?B?d2d6MlJ5TUJ2YjNUa2JtM0ZnWDhwYU52QjBJTSsxWHFSdThWSGZJcWovQ0lH?=
 =?utf-8?B?ZVRZSTdUOEVLMWtJY1JwNWxNbmt1S0xWYlc2N1RHVS91SlRhWUhtL2lmL2U2?=
 =?utf-8?B?V3JYd25kWjhQY2dSU0oyT1hobkRHSDR2SWVFREtLSlYyRWJTQkRPTUx6MXlS?=
 =?utf-8?B?WEgyZWluWUZsTGtVdTVNUTZoMVZ1UTFJNnAreU1nemJMMUlXVWFTMnNURlJN?=
 =?utf-8?B?VVRKOGhVTllsaXZ5bms3QjJlUUJEbXN4M25FYnZjS0N6RWhIQnBxWnhxSm9y?=
 =?utf-8?B?bDZYblVXWWJKYUlDTUFzaENVNU9hVWdUTk5KMGtWQkQvckFINlhnMUZRTGRG?=
 =?utf-8?B?akQ3WUlRamtQNDdVejYwMTZVSnVRUUM1OUovQXdQWnFSQzlqeXQrTWpxMEt4?=
 =?utf-8?B?YXZHby82RVFIamRZRVpzWm4xWWxQai94UVNickQxK3dqS3pBRHM2UFBpOG1Z?=
 =?utf-8?B?SnJDVDBHQjIyOTVIa0xqRUlMeW9vZzZtNlBEdjdMdnduNWJqUWo4a1I5TDkz?=
 =?utf-8?B?SUsvMVQ1Z2pxdGZBLzBKbEEvMUFCbUhXVlhWQnJxWnRvdkowZ3lJNW9zRlZC?=
 =?utf-8?B?bXZFVGJJOSs1bDk1c3V0Tkk5WlRlaENBSE50b1NZMis2WERlbi8wbGJPNWov?=
 =?utf-8?B?ZnV0ZVJUMU1KTDhxTjZ3d0RRRk9kNnFzbVkzVDMwU1BjT0NsMWVUc2gxK1V6?=
 =?utf-8?B?eDFSbDJYNjFSRjZIT3JxYzB4R0lXUlczNGdOMU1xNmFoM3BYclE1MHpXclRO?=
 =?utf-8?B?NGE3NGlmWHpaUEJobkFRZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjlITi9MVlFyU1Qxak9HT0Z4UUxuQ2l3RHVtbWRKbG1lQ2lYTnMyeXNNTzk5?=
 =?utf-8?B?MUk3UVR3MUxuQVRaZFVvZk1pa21pbzVXTk1OQ0lKNWN4TFdoMmpUanFJblk3?=
 =?utf-8?B?cmlWTnFsVHU3M0t2V0c5YjYyTlBvc05wbEFlV1kvSlVzKzY0anpaL2R5dkFS?=
 =?utf-8?B?MU13cmgxK0xLUGRJeC9za3FvR0U4Y1ZLT1Y1YVhncWZJQzI1QlY3UlpBWEt2?=
 =?utf-8?B?Y09ya1VHci9reklZQUNHZk1VQXdpUUN4QkpnVFdaVi9Cb3dZMkY4ZE5yVlJZ?=
 =?utf-8?B?a0I2dDZMNUVmeFN0MFlWeisyenJqY1RvcDRxL2FDRVRlTzFGaXkxaTNsUGg2?=
 =?utf-8?B?OE9NNTBHUHk0RmROTm8raXhhZWsxVUVmQmZrMForQkF6VFVkYWJuTDlPSFdE?=
 =?utf-8?B?bVR2ODIrM2dTNW9DOERSSzZYcXV5cEI2Z1lVUTR6VnJVUlpWNmE2N1FOZFA3?=
 =?utf-8?B?QlhJTTVCNFFvWlhEMk16VzFGWHVleVRBTjkyVmZvQ01OeDdaSHJhNjY2NzAv?=
 =?utf-8?B?KzkzK1FaV2xCSzVNSlVINEEvNGVhS3BubVZoSUpQQW5wLzlPdjB1OVA1aXFw?=
 =?utf-8?B?MUhNYy9BbFN4NlBjeEdBYjJiRVEyMmdiVm9CMTNFaVJzQ2J4Sm1zMW1xSUVG?=
 =?utf-8?B?Q3BrSUQ4bC9OS0t4a2dwM0E4MitrNTFnMmJQeCt4alJaQldVMWZUc29pQ01E?=
 =?utf-8?B?c28vNWxEc2NFM2RHSUlGaTNvWnJId2xERGJOM2ZYbUd6R0FzbDE3RHMxeTZQ?=
 =?utf-8?B?K0s2cUpmTDRjdytCa3MxNjZHdFo5VzVoOGVuRVozaWFKcGRDRVNoSmNBcmx3?=
 =?utf-8?B?WndiY3U4QVhNQkFyRVBvSVFPOUhJQnV6dnowUkxVTElyY2xiRkNLMHk0bkRV?=
 =?utf-8?B?WGVkT3hwRXJiYmhBY1ZRdThJOG9zY3p3MnVkTVdJUEFsLzMzSll6Sytpcisv?=
 =?utf-8?B?YjlNUU44ZzIzV0gxWVlNUjd4V3FEbXhDc0JoUlp1cVc1M1grWHNOWlFBRW5K?=
 =?utf-8?B?RUI2WjZET1JFZzFmUE9qZDk1aW1ZTHR0R1VscW14QzNqZ0VWQU1uNmIzckNj?=
 =?utf-8?B?bk9STjl4M2dGRHU0Um9kNVg1THVrUGNVakl1d3hpWDVRS2hWWWx3V3I3cGFP?=
 =?utf-8?B?UmdjNXVjcE5aU0NNdEZHRkh4a3NSV09yWGY3TmF4Z01hOHdEeGJqYmZSc3Q2?=
 =?utf-8?B?cS95SGRKNmIycHNEemlub2xHMEVlZjlMdEhmSFZmTzBDbDZoQXBzOFBZN3pV?=
 =?utf-8?B?MklVMFNoVzlja3hzdE9POGFzcWFCazc2eE9QaTB6MzUrcDBJb2ZhUE14UEVZ?=
 =?utf-8?B?Umdxb2FFM0Fvei9XaWlBSks2c25ldXAvVTlYZmtmN0dOMHhPYmp4U0xPMUl2?=
 =?utf-8?B?ZGoxTkR3M0VER2phRXhhcktJbnNIdjdrTWM2U1ZiSmlabHNZRm51TFNSNXdT?=
 =?utf-8?B?djVmR29oNjN0eGp0Q04rcHk4bGNOK1FoM2tHc1ZYeVNJZ1owQnFhK3h4cDU0?=
 =?utf-8?B?cXE5SE5mTnYxMVdXMGhnZ0lHVkNxbFFtTmJBNVRrbmN2dkhDZlZ6b3NWOWIw?=
 =?utf-8?B?S21DMFVGNStNKzJDUjVEOUF1TFJWczVFZzhESHRMUmxqOE5vd1pVUmhUWXRV?=
 =?utf-8?B?b0Fhdi9BSk5jQUNGbVVvcWNaRkd6TkNuYWhoVnRZeS9sSEJpUmFiakUzUjdG?=
 =?utf-8?B?SGx5aC9CbkxHeXNCamNxODB1L1VlSGtwWmV4eHJ6RTZ5VnZXTzZVWHoxR0xk?=
 =?utf-8?B?ZTFCMWFvY2xtdVBhcVU3S3U0K0t4ZVByOXpRZjE3bW9iNitDK0Q1dHZhZVUr?=
 =?utf-8?B?N1JmWGtSWnI4bWZvam4vcFFWMnFneitMYk9GSkJvSDdGcmlpV240UzJGWVk0?=
 =?utf-8?B?RjVrNkVLYTZ0emQyWEg0OEJ5NmVVL2h0U0xxZWh0czNHQ21UdlJjYWFtcm90?=
 =?utf-8?B?Z2pyN2ZCRm5TV24vMFBHUlgzZCtMTUdob0Q2TEJnNGhyVnBwRGhzQ0dWZWVq?=
 =?utf-8?B?R2FWay9zb0RldCsyV2hLYTV1ck5paTllRW91VFYyMVV3QXhVbW5ob1BDbU5O?=
 =?utf-8?B?dkZXb0dCU0xXdUlVR3NFN2NtWUh2ZUZpMmpLN1JidVUvUVRacGhHRnRZK1Zo?=
 =?utf-8?Q?4vy2doPZRUtruE4KuYRZjCCVO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02df8c94-075f-4c61-6f90-08dcb2fe0c91
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 14:18:58.3238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBVMI3n926ACEHIkBINXOxT4TaKc3gIFmin/7acoSu1X5FODhNAZUJYuV6DK74bKCCo0+Nt4UUs3G/bS/dvdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432

On 8/1/24 15:56, Pavan Kumar Paluri wrote:
> Provide a "nosnp" kernel command line option to prevent enabling of the
> RMP and SEV-SNP features in the host/hypervisor. Not initializing the
> RMP removes system overhead associated with RMP checks.
> 
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  Documentation/arch/x86/x86_64/boot-options.rst | 3 +++
>  arch/x86/virt/svm/cmdline.c                    | 6 ++++++
>  2 files changed, 9 insertions(+)


Return-Path: <linux-kernel+bounces-575349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914BDA700DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1F73B8475
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A2625BAC9;
	Tue, 25 Mar 2025 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rX6bDCrd"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248926A0B7;
	Tue, 25 Mar 2025 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906152; cv=fail; b=Zq75iSHCI1XikW/sU+XcSdE/pnszHzQGRRQppuAXQjyY9HgdDqsedjq41nJGZ6bGgMIF2nFgF0NdEGzAU4YmSi9zyGFYmtaMgV03gKaGJxk4Oe+86uDAnN/s6LFlq806uCYDFQEC8DkOgJGM30jaGJcv52XQ3d6vKIx5SxIdJyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906152; c=relaxed/simple;
	bh=8NXZ3UGKJ69RlJZlQpaiIl69hQjIHWdXlHPW3Hq4byM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tei0yFd6CEHky13/epmNZGlh08GuxcBUl5Uux2e+U8DXtv0zl5heefgwTtmGLQHYfZEpx2xVatEIQrPGQHxZsV596EDznkz/L87lPxM/jwC2K+IePySggD3nQt5XNqlvYEim7NVgTTMu+Gtxzw0yWKSXF6PeX9/hd2wo+c6Wiis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rX6bDCrd; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3ycAo5wMbYHzYjZdKpM//m28oCQTTzUuhe+4XmeY+S8OWe9qRbs8d2xwXR9+EVeB0ZDO5oCACJSwHjSjD6gueEAYlC7iq8eh1Bgh/sHiuta3fYAaz2TsnEKCmlcF8C/Q+caHqp8pMNawOr1Yi8Gp/0Yvs7LXxbBW42E8V7A4z1/ae+dJIlSJifKvhMnpwZIpjwk9c+wXYNvN8N8M71wKyJeeBmTnFPR5RGbB3/iin1oIgqtX/s6Mcx77n4BmZmxx4z1boDIWA7Dde3fdDQ5QWXAdhSN8UXZxoKl+ajcOWVb0VlZqM2RBc/jPZ+aA03csq/KLws1wXGsfKgwgoRUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zl8YtmL/dRJbnXwp0jqS4rtiZs+zu50qM3qHFzDmNY=;
 b=l96e7Kb0pdkmU35iFKX/8BgJKttBZiLkp1YuVi58o+C7huzuRswrCGkQG2Qo7HzncvwEfOuZrPO5yblIN11eqDjgIPTsIBh06HJF+kmMfX1xpZuYHzgj/qRxuDXW4Jjl4iWN52AIznW7ngB/3fRmiTc+ttKL5iLYogCyz7IgxAoWFqKsFxMlykNLjEoprjUy2hKatdz8yy8t0x+zGiXpWfZPCOUMLvtd7e05ouItZa30nEbui0euLj2/q2bBBiqXXlLkFBtLVrIqITGAPuTWTYroE2U8ljeRb+3XlJKgFg+bkZgoLK37N9GX/lb0vm2ayVInpICrIiRK3zzQBq9M2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zl8YtmL/dRJbnXwp0jqS4rtiZs+zu50qM3qHFzDmNY=;
 b=rX6bDCrdEeA8hYn6jwgDm8Ti5oMMEzSMjbVKbjzKdqzwAziHlo10exT4/0y/2Zmi9FAMv9Nin5JQhNz/UDAj+eIht1zSE4nKIxyO3AnBa7c/bGzL1SGbX+/HHKIlJ8GTvGgsAKfyYKnUWeC9Vtl7qllPXhvtZPo3fTJhSzNxvMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 12:35:49 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 12:35:49 +0000
Message-ID: <c4410c12-c3ca-4298-8dc2-7484bd7f3b68@amd.com>
Date: Tue, 25 Mar 2025 18:05:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/11] misc: amd-sbi: Add support for mailbox error
 codes
To: Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, shyam-sundar.s-k@amd.com,
 gautham.shenoy@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 naveenkrishna.chatradhi@amd.com, anand.umarji@amd.com
References: <20250324145815.1026314-1-akshay.gupta@amd.com>
 <20250324145815.1026314-8-akshay.gupta@amd.com>
 <d05242e6-4706-4abd-973f-230d143137e8@app.fastmail.com>
Content-Language: en-US
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <d05242e6-4706-4abd-973f-230d143137e8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::11) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 14aa8ff7-7271-4032-c4c2-08dd6b999270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1g5ZGZiWTVxcUVOQWNvd2R2YS9Wdnp2MnpXQXVwY1drZFZIeTVJOWFQZG94?=
 =?utf-8?B?MGVaSThWVElLYTJnTHNpT2NHeFZVeGJ5U0xjMDJIRndBYzhHakx2UW9wMHpP?=
 =?utf-8?B?VzUzWFdtWG1NVWg2RHMwaGFiUE1SUDIxUGIyWTBzQkRMSDdCaGdGRVlDUDFC?=
 =?utf-8?B?ZHVGdk41RWpBYWJqby90ckpGTjA3Nlh6MVE1ZmUycjVhRUR6RWdRU095dVVX?=
 =?utf-8?B?Q1ZQT2JYdi82ckxwRWZuQ3hTcFJiNSszR2tIWDJpRDdURzJWeE8raXlYOG56?=
 =?utf-8?B?czd1Ym5rdzBheFJ1WWRnVjlmVFFNQlk0OUpISENZR0R1RVlnYXVzekhKdDU5?=
 =?utf-8?B?ZlVwUEg1MnF1aFNZbFlvdFhIZlc0cmE4ZFgxT0FoWDZKTmhIdG5ybVhuR1RY?=
 =?utf-8?B?Tlpvak1yOC85SG5CTlo1dytteTFiUHlwaVlrZ241RGNHMkwzNmZlZkRLUWc5?=
 =?utf-8?B?bmorM1pYNm1LMVpUcG11bzY1Um91bXY5WkJ3bnRTV09oN3Q5RGlhMmtTTmc0?=
 =?utf-8?B?V3BPa0JvVGVNOTFsYVdqY2xKSkdWQThKNlNVa0pPWDcrK2w5SDhIT0VDcXNq?=
 =?utf-8?B?Q1ppb0ZFd1E0ZnlDc2ROaHE1aThpRUVDOTZiR1k5ZnBZWThoN3hzbTdwV29x?=
 =?utf-8?B?S0ZVblAwa2ZDelZhOWZiNnJOVTNrdklyOUtRcGJEcyt2SWZZY2Y0cWFoeWhu?=
 =?utf-8?B?R0R4ZllPWkloa3VxN2x1U01weDM0ekJySHpyMFRoa3hTekkrNFFVMmF6TlJR?=
 =?utf-8?B?L2RVcGcyL1pGYWR6U3JIancvaDlqRkpHUjlZdE9NVTBzQjRMeGZGVW5XWm1J?=
 =?utf-8?B?d2V2TUZzVnBJaXlOUnZFd2pHWDczT0Vsa1RCcG9yOW5uNTJKMnViclNPczBu?=
 =?utf-8?B?WmpUYTZueDRMOWpCb01kZnE1eFZRMmtwNjhhVTBuSGNDY1gvZXhUeEQvRkZD?=
 =?utf-8?B?dDNENFZlVUV3c0gvNWYzbW5aWmlPZzhvaEZyaDdGSFFybTNaelhFMy9UM1Nm?=
 =?utf-8?B?TGxmaTFkc0laZ09MMEZ1Nmw5TjNIVHBGbTZXSmFDR3RjV0lhOUNkdGZ4aStn?=
 =?utf-8?B?WDZNWGVRenpUZnR1ODJqcFlxRmFxbGNGY2hMZ0lsc2l2U3ZlZmxYVnRrMVBl?=
 =?utf-8?B?bVJMN09jcXBSSkRoRG9BMSt4enNBdjBpMldUQVlIVU56NUN1OHVtNFIwL0Rl?=
 =?utf-8?B?eXp3NWpoTThyM2tMd2JaT1ZSL0YxV0c1YTVaRlgxK2VmV2lGVDI0NmQ4cE83?=
 =?utf-8?B?N0RwVWE1V1NucHF4a0Vhb0wzZk9kanhDS1ZyaXZkYVNxSDZzQm80YzRIUnNY?=
 =?utf-8?B?MDVmZXA1RHJ6S1ZLcWJOUHB2eVI0dUkrdHdma1hBZUxxMlJiUkV4Kzk0czNP?=
 =?utf-8?B?RkdoeWgzMThQT01ZQ01MUHJIbktvMnBPbmNmbk5qdFdyYSt3amdtN2JiN2dQ?=
 =?utf-8?B?M1dBZWdZSm1raVFYeTBuL3ZvSG9xeElxeis2WDRkZHh2N096bmlyZGZ3YVZs?=
 =?utf-8?B?VWx2TnhqWEUyQ0c0Wm5IdE1vUXlzMy9LUlZKQUI3aGp6dVRVTzg4Y3FlN2Zu?=
 =?utf-8?B?N3RnenY3eXgvaUdWOHNqNldXK0xsQVdTWlFBQ0drc1pqcFducHA1YnIyOUNI?=
 =?utf-8?B?L2VDZzV1U3c2ck9Ha1o3cWNiSW9yVXRiQVFuZWFITWtrMkxnWFgrd3B6aW1P?=
 =?utf-8?B?UE41QUFVTHRtdXdvNVRNNjVMTUZrVkxSVVhlMy82NHJSUGIrV3d0cTlBUExZ?=
 =?utf-8?B?VTV1S244cnN1VEJJczdFbmFNZjBPSTV2NkgyNU1EZHg3VlZsTENTQ3VKTzh2?=
 =?utf-8?B?T2V5Q2ZQL1pYU0w4eXJnWGpsRmZQaFlLc2hRcW9ubUJ1Q0JPVm9LV1I2THRQ?=
 =?utf-8?Q?RoiGeF/0bJIKH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wnl5ekw2Q3lrZEN4Z1AwYVZCajJ1VDhieEZZZjJITllnTWE2Qkg3bklzQS90?=
 =?utf-8?B?T00wNGVCRGF5TkQ3Tyt6VlNEMnRaSDVHdFZwMG5rK2o3WEQvVU15clViMDZr?=
 =?utf-8?B?eDhnRENGNGNaQTl1SzNLMkdJWlovUWFnRHpaL1lvRExaT1F4UGw3b3FaYitK?=
 =?utf-8?B?S2M4Ulp1eVp5QXlmNkpsUjUyUmVJejgxMUZKZklJMHNudnp6M2I0ZUVjaDkw?=
 =?utf-8?B?Um9BOXZnMmM3cG81MDMzcTYvbmRKOXVKeTllaWNKcEZsQ09VR0tHcUFuZThQ?=
 =?utf-8?B?Q0ZzWmozMVlITnNpUmxyeEFML09USVlMZk9uSzdITDhmY1hBSHR4bXNCT2Jp?=
 =?utf-8?B?VFJmQTBoMi9GYldXUHNWZ3VyVVVjUVFXVUNYTlBHOU9qVDc3Nk5tbE5JaTRw?=
 =?utf-8?B?MDhCbFpvclY0OE5LZm1jSXFUTy9oSksxUVFoV2owNUxvRFRmNkdLVnNGeFQ2?=
 =?utf-8?B?N2ptb1IzdVBjc2tiTEp5RE9lUGF2bG5ReW02RGJiMnZOalU3QmU4TlA4L2Jm?=
 =?utf-8?B?ZUpVSE9waGtzSjNWT1dudnk3ZWY5RU1oaGQzK1FzbnNwbllCY1U1NWFkendE?=
 =?utf-8?B?OHM3cjh4UnU1ZnJzNlBPR1ViS0FVdlAyTHpZK2d2YTI4bWlCckhwVFEwWWVh?=
 =?utf-8?B?cmlCV1FnNTIyRytQYU4xMHZOQThXODhFbXpRbk1XelIwakd1by82ZFBUWERE?=
 =?utf-8?B?WkVOcnMrWlRyVXBoaUY1ZjRMUnBJU3FEOStZU3Rrd1NScmtpOTNlSWpMRERv?=
 =?utf-8?B?WkkxOGRDYlZHTTR4VGwzTWxFK3dWdVczc1p1WlNVRCswdzhQSFJLY3p5ZUk0?=
 =?utf-8?B?L3BZcEtrWjE2Z2thS1lXajR4eCtLRk0zb2pZUytxZk5YcUNJb1dtYUovSEp0?=
 =?utf-8?B?OWV2cGM4MlUwSkdyRTdDa2RBcnR3aGg1K2xpN3JEN0cwWHg2ajNrVzhuTHMz?=
 =?utf-8?B?dy96Tm9jL2h1VWpJcGZaTy9PWlhWRlJQWS95RzZ4QW5LMFY5R3E4L2lFN2t5?=
 =?utf-8?B?dkZIVnBUaGZENkhtR0lBU3lCYWZMblJ5ajJ5Y21iQ3pmTUwrT2R0aTFvT1p3?=
 =?utf-8?B?QkJYZGJidG92UC9kVGRiS3VXQmJnT0ZyajdlUndKeTUybW9scFNxOERCMVo1?=
 =?utf-8?B?TzdaQzdnUWU4bCtBS1BnZ1BBYWY4eldHUHZmS2g3b1JudEpZVlBNWURzQ09D?=
 =?utf-8?B?RmtlVkoxQkNGNFVGRUNjVmlOOG1BMnBwS2h4bWpSclk3MEppUm5TYnY0N1FR?=
 =?utf-8?B?Ym9HRjRUbWJRZ3dFRGlHZ2taV2VyRjlGc205VGcxdkNKbys5ZHNmSlNGVm1L?=
 =?utf-8?B?a3Z4anBWZTJYdGJCanpINjhTN0hLdEFQWTZwQndxRDhTUEdhTGZCYk4xQkp0?=
 =?utf-8?B?dllhR3QvakVqdnpiRFg1REVtc2d4Z2creDF0VHBjaEZkU3l2U29ZUzNyTDE5?=
 =?utf-8?B?Y0cyaTI0Q1RCSmhFN0RTelhjdUlQenoyaFA0SjVCTXJweTNrZmhldkppVDA3?=
 =?utf-8?B?WlhmQUNVMG1uQmlhVHNOKytoelNTdmVRTnVTSTdhcVYzNzcwcklZU3BneEJr?=
 =?utf-8?B?K2FJU1NzQzN1VEJ3eG9lSzRLYVZjcmJkbks1ajJ4YTcvcUhNYUFRRzZEdTNs?=
 =?utf-8?B?NmpMUGpYRUs0cmQ1WnRSVjlscml0MnZPVllKemJIN0dsNldEaVBuVDMxSU5W?=
 =?utf-8?B?dmFmdXhDc3JNa3I5cDBoOE9MaXBUMFhmaVVETkJGS3pTSnJ2MmcyMVNuRWhK?=
 =?utf-8?B?Vzc2dnc5VzNwWVRkZGNpT0hZWVVPKzg2YnlhYVNQbUY2SC9oL3plMXpnZHJx?=
 =?utf-8?B?UW1pNUUxUlZ4aklBMnNtRzd5MHJGcFBVVnZaSGtweFBpWHBydTlMbWxKYTd3?=
 =?utf-8?B?ZU5VdkRteWtyWkFBUmdoVVRmZi8rVnlkVzRhNlVpOGp4UmsrUUNTbGdHSUZr?=
 =?utf-8?B?V0FQQURBZUgyVHFjWTRGZjFUeElBWk1GKzZKR29XVE1CZU9RZlVSay9XcVVV?=
 =?utf-8?B?Nk85R00ycFd2Q2JHK0gyL3FyaXJkTjl2b3NnOEprWHdDRUdHREVRVURxbXBa?=
 =?utf-8?B?S2tWUzVsZWh4OGZhUFVmc255ZVNrdGtqY3VpSWlOaElNS3l6c3RmYUJFQ0p3?=
 =?utf-8?Q?WvefNuz/G3iWg9X2TKLeURkyI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14aa8ff7-7271-4032-c4c2-08dd6b999270
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 12:35:49.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBeD8qrL7stovNsZGLhyyJ5hL17tlSoi54qh1UA62wUujnZSvAzhLYajwcqSYZo4dh8d6GA3mW1Vw9C6Hp7M6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446


On 3/24/2025 8:56 PM, Arnd Bergmann wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Mon, Mar 24, 2025, at 15:58, Akshay Gupta wrote:
>> APML mailbox protocol returns additional error codes written by
>> SMU firmware in the out-bound register 0x37. These errors include,
>> invalid core, message not supported over platform and
>> others. This additional error codes can be used to provide more
>> details to user space.
>>
>> Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
>> Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
> This is an incompatible change to the uapi definition, which you
> should never do. Just merge it into the previous patch that
> adds the api in the first place.
>
>        Arnd
Thank you, will squash in previous patch.


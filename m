Return-Path: <linux-kernel+bounces-260669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E136993ACBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E471C22BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 06:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6150284;
	Wed, 24 Jul 2024 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="lRx4N1T/"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020079.outbound.protection.outlook.com [52.101.193.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF1017C67
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803134; cv=fail; b=O9JxEnsQYNx0+QT+w44FrkARy71kHjWj81hYRd+a8lzgvnbJfRfhYaFt2BHZOc5OhQFUtVoBiuIaH8vDEopYvEe+xkR5SIkZ3IpqDWFNvfbGi6WYVXeEn+QXaQWGLhYWFS0YrdUa3kHcTFkTrDE+cuJeuRJXPxU11eKvO9z2jWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803134; c=relaxed/simple;
	bh=+MZHIoRTDgFcdpJgSPL8b4yHGsvTNvd18emfI9NWR4Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JoUBGzFzZPIO7BG4bjMWgWZ9dDlG2YKogsuW/kdJmlvwCKpR71Uy8YC6VPW2+mXDKSMCjDMrgSVfAaRpGr5iLdxDV+os+PqPLiM1k9lFXkBEc6RnxpYZvn/E2DU29ucf15WmXUI7ERRJmvV9/ibHmfxhlpCIBXwJtLApz0Vk7GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=lRx4N1T/; arc=fail smtp.client-ip=52.101.193.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLRQyteXmWZbcHuq02EMM3+BW4t7RQjzCGfz9otY0rk3yITGAzHXUv6YQCE+dSimH5ZSblrM9ntuzAhUM3qtBDRnmLSfVbp1Bs0yIsWf9CoYa7FUmwENSyttHYQFzuwpJZyvCHzgBDVFd7PguIeQuoJEIVvCCRKgE7RYLvjhaUqbZXLVWc5pV+fYMeqN52g9Z9DVOCjfoqu+SNLjWD5DLdd94ilMnUCaIFLU5+0HOiEhrx7kUUxFfE8dNBsy4iWDv/f2xg35kEtcyBJitKkTFX25Cnj8uqlEGIo5iBBaSNHLLb9ROo3GJa3nzqu2lbGppoAcdwdREF0aM5m3C07WXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4Jgfdy2oT52j08joLl56Yy/mADXdl+/Ytb2rymPcXs=;
 b=llqDPf3oxRlXFUi6t1B9tMBaDw7XqVNyGk3E95SlLN1k4NOqTi7q4tg2TEGb90Jxuz3iZ9tf160XL7ftSErNgPepa4LQ+Hsn6/z76VVI2ct0k6SeodyVk7d2ZW8Q1LJ5LjmAmW/6Y3nqxx5DjBCsl9S4cE63cbop3MSilQ6F87jXdMwq1S0qHJ5mcPwGAN/xOAl4IpzazSPSzjZRF8ECDLbcaEPxHiOyj3FGT1tJQdFkohdqK4aZH3NRsLqIPR6iaJQu9kU23Ptz5XYViHFDcoUxSmTjCUWk5+6pPYAsFpsFFRcVM7I1CUwi/AbraoPRlw4zDu9186yWpcAABLmhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4Jgfdy2oT52j08joLl56Yy/mADXdl+/Ytb2rymPcXs=;
 b=lRx4N1T/ZvxvVzNx4eLLGRtr2Oc4FHF8XDNfew9r42ftX13X3reFzWMEBFCd0mQXffTSZDfPDnk7mNpVxuKlRJcJ395LglFTLMLd8i/MUgAjf15iMeqHId3yBYHsP1wKQ6pXJA2AvFMOKe7H0feRwh4WV/uBDlvJ6C7tIsD8Xh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SA0PR01MB6234.prod.exchangelabs.com (2603:10b6:806:da::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Wed, 24 Jul 2024 06:38:48 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 06:38:48 +0000
Message-ID: <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
Date: Wed, 24 Jul 2024 12:08:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 james.clark@arm.com, mike.leach@linaro.org, suzuki.poulose@arm.com,
 Leo Yan <leo.yan@arm.com>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
 <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SA0PR01MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 91360509-c5a6-4b3b-72dd-08dcabab45c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTdGSGtkTE91SVNEUTlZOW5MZ0UzUDFDV3pFZTVkZ3pKb2RzSHBqMFBlNDdX?=
 =?utf-8?B?ZUloYTdFUUNpVnJGTUZ4T3M0VGRyaktCVTllZ2VtOGRCS0RtWFZ5ZFNkYmU1?=
 =?utf-8?B?NnEzaXR2U2NLNzZFSnNVcUFEMnBzTlMrWmc3TkZUNGJRQ1BNRUJhUXVIVW1J?=
 =?utf-8?B?ZGJPbWdmYzVaeU1ndEo0V2NmV0RnRjF4clRnakpuby9CTHZDT3R2d2c1c1c4?=
 =?utf-8?B?R2wvM0U1UDczRHg3OExJRWxnZWdwY0grMVB2L0FXU2c4djVCTUkrcUJOdFVN?=
 =?utf-8?B?NUxrbWlKbll3NHdOWHBNWlFZbElJbmhTTUF1VkoveGJ2c3Z0b0ExcWZzTm9x?=
 =?utf-8?B?SnhZbVlUVlRqWGhONDdtVjRPUzJLem90dHRDaFVQT1NjNW1ZR1Z3ZVlXQm16?=
 =?utf-8?B?RGJ1eEZhdEtzOXJidXMzcjk3VVBsekJLNksvOGpRR3Q0N2ZMcFp6bTRIZnNV?=
 =?utf-8?B?L1R2V2drY1ZIMFk5eSs2dDlUd1BhZlkwQnNMWW9NaW00ZHErc0crS01zSEQw?=
 =?utf-8?B?VXc4Z0lwNlJMQTVuQ3R1UTRuY2xvVmJReGRFOU9kYTVNd2hsOHhYQ0tzUXU0?=
 =?utf-8?B?V2ludVBlaXVLS0c4amdUQUFMZUFPZmtQczdtVVpOc2hwRFNXZzBTb2ZvV2hK?=
 =?utf-8?B?KzJTWmpGSksrUFQvR1BLSHFMNDByMnBDYjRlZXlJQWV3L0c3U2ZZa3IrZlB0?=
 =?utf-8?B?WWhudTJsek91dk1Od29YeEM4ZlJjdHNZM0Nrdkt2YWkyMlBRUmxhY1hoSG1H?=
 =?utf-8?B?UU53RWJNUHJHcGQrdlQyZENmUFNIcUFqS2VOSjkrMGFPOXVpOGNHKzYwUzJQ?=
 =?utf-8?B?bUZYNm9VY2RxRUphc2YwYVVrbmY2MEF0YUVEZ3JUdURtdWpyY1Bnc0R4aWVK?=
 =?utf-8?B?UFhsRnVuNHJVS1hRMUtqTjlyMTM5VFQ5ZnNSa05hN1k4bnVUNGFrSDVPRWxq?=
 =?utf-8?B?ZEpyYktBNUVjQURFSjZIOXpUM1JwbUxkWWtJR1Uxd01RODcyUWlmYUFuRmNu?=
 =?utf-8?B?VkZOZzc3WmEvcWpXNnB6d2lpSjJxQVJ3a3RMR0dsemxWdnA4TFZqUHNFUk1E?=
 =?utf-8?B?eDZsVm9laFpDODR2WlE5VitpNU1DM21NNXJFbVlnVjdaTU9BQUU1OVJzZGY3?=
 =?utf-8?B?UlZaMkNHRU5rOWlXUzYrSVRXWHUxQ01JWDY4NFlBVm15a3F1aUNmQUZINGx0?=
 =?utf-8?B?V3FkWGw0aXJwUHQ5dWt0bkl2VndJMXBKL2RtQVNldDBMeVQvK2pkTE1jemh6?=
 =?utf-8?B?MEtGL1JOYkpRUWlTcjNOSSthMzFxN2xWR1BrZ0ZkQnBHbmwyQW9COVVPbC9C?=
 =?utf-8?B?dnZ6elViNzVoWUZ5aEhycWpUSTBKS2lCbHNIc3loQUhZd1Z6U1E4ekdjR2p2?=
 =?utf-8?B?S0U3Sm1VTjVRajBFTlJwdk1hZGJRb1dEL0JKUkpFSnNvTmdSdm5KRC9mUE5o?=
 =?utf-8?B?VVA4V1VZZnpFczQxelJTRnNkdWhwcnZyakc5Um1BeVE1VU4yQ2xhcXZuYjBk?=
 =?utf-8?B?bDJ4OS9DWEhFbkEvYmRNNkh2NDk2a3VWMDhnMDFHM0JLM05zUDVTdjhvMXJu?=
 =?utf-8?B?NDlFOW1hVlZiY3V1U3FBdk9EclBNT3ByN25DbWJmcVhwK1FUeHhPTlhKRjFK?=
 =?utf-8?B?OUhpVFVMd2tkLytqdGVjaVRSQXR6c0VqNUpCbWMyM0l5L25RQjN3ZE9HaVd2?=
 =?utf-8?B?SDg4OHB3S0kzMlhOL1NVMlVhTytoelFBeXdHU0hYMEZuVW05eE9nVmE1YWFa?=
 =?utf-8?B?a3l5K0NZS2RFb05rVm5ydWVReXJRU1ZwTnZjVURRekViWkxweEVSaFlMU0Rl?=
 =?utf-8?B?dlFHRXorVkVsaGdsbkMrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVlOZTVMS3EvbGRIdzdkdlg2UmVFcUsyU1dJcTJISWkvTkVXeWtxTWFBYlRE?=
 =?utf-8?B?RGR5ekM3elJmUmI2bnlreU1BcW5ZSkdxM3V2S2lLdU5sOTNZSFAvdVM4cHEr?=
 =?utf-8?B?REZNODIxV3lKOTVHbXNjZklMVEJPNWRCWmZBSHgwZjc2eDdMUVhDQ3BvbEFv?=
 =?utf-8?B?QVJnVVNIc2M5MG0yZlNLZU1iOUszSlRSNHpIT1d4WlpVN1hsdktBZThyNEdk?=
 =?utf-8?B?bHV6bmpzelZha1NXd2pUd1I0OTJvOW9xS3pnT000dHNldnJJN2NnbWN0RCt1?=
 =?utf-8?B?RzBmdW1hMERkMUJqQjdPR25qNEx1b29VUTNVT0lNcndUeVI5Y0VuRUdCUlZr?=
 =?utf-8?B?RnNTaGpJNzRvZ3ZTY0lwZ1hSWHFnRGxuNnFuVWZKZGFVYzdwNm9hZ3RaeEZq?=
 =?utf-8?B?VGtIdkx3d3lCNkI4OVZIdEZ0MjhzZGRHeUswTDN3VGJnTExRYm54VHhWalNO?=
 =?utf-8?B?amN5aXEwT281cGJTZ2N6VG9vVzYySWRSRmJWY0k1ejFYay81dTBrbzhWMzJp?=
 =?utf-8?B?SDFKcFJYdDB3SHR3OXZsT3ZhNkkza1dvREhydlBiNlJpUUtFYmk3NkFOaW1O?=
 =?utf-8?B?V29nTmk2K1VMTk5uZjU2dzdvNHNZdDkyazBnTzhqeW9uVDhBUjVRRFBQR2F5?=
 =?utf-8?B?ZUNGSGRSLzFKRlAvR3VEZEoxbTJxK3B2emhGQ3p4SU1UbGsxQWlmRW5rRUgx?=
 =?utf-8?B?czlBWm5uTHZya1RCVHJxZm4yWi8rQzZqcklqY3BUcnJhb2lLMWZNNzR0Wmdn?=
 =?utf-8?B?TTFxR2JpSmFPUHZzZTkyVW4rNW1PeWdLbS8zaXpNUEtKTEV2YzRyd0crTUhJ?=
 =?utf-8?B?eGF1cjhwT0tqelRremFpZzVqTmdieFhOMWxydFRIQi9uT1VBQ1IrVUNvV1JE?=
 =?utf-8?B?N3R6WWFOVlJZRjV1UGpiSkdUSEF0dnY0cis5eGFCR251NXgzUEczZmdsYXI0?=
 =?utf-8?B?RTM0ZkwvdjNyd1VZNTlSaU55Z0dzVnorLzdKZzZubFhJQ3ZDVkRnQ3lSWjQ2?=
 =?utf-8?B?bzZmdEdrdDFMdHFkV0dJak5ZTDc3VEhMNnVhVVJnay9xS2tmUDRRUzdGSjgw?=
 =?utf-8?B?ZXpUK1NiUlJoVmREbFY5UytMdU5VdXYzSDU4MkVmNmY4UVI1SlIzamZ0Q2Yv?=
 =?utf-8?B?eURReWdmYVMwRjJxazRpZEJoa3JEeEhybElXUy81RmJyNlB6Uk94Z3IyTHg0?=
 =?utf-8?B?QVcva2JpbjVtYzRTcDBvM1RpRUxtVnZTQWhFY20xbVI0eDhIKzFzWDYvbGdK?=
 =?utf-8?B?bzU3TzJPdmhiMHo3MFd3d2RpMlJkTjNvRm9renF5T3JOaEFFclR4QndSZzVM?=
 =?utf-8?B?cHhFY0M0Vi9VM2JlZG9hbm9UU3BIei91c0Ryc0NTSlZROXhuRUc3eXBRbUxz?=
 =?utf-8?B?YXNONlVlOFVkSEp4SzdMYzdhak1JYml4K0UyOFZ3NnljUHg1YnRTWGlRRHB5?=
 =?utf-8?B?RFQ4MWpjMStrNTNwMVp1Yk1yMSt0cHhzRWt5NnhValdxWERtZEdjUUZDVHVJ?=
 =?utf-8?B?MTcxdVRkaUxDdlhtUzlFcXpkSVpkanczYkVZTzA3RFk2UmtVY0VBMXBQY2xL?=
 =?utf-8?B?TndJYklteSs4NDdpcGJzVXJERGpYZE5hU3hsZGxnRkVpL0Izckw2R3oyWk5V?=
 =?utf-8?B?S08wTXZ2VDBJMDMzSklvbFJIU1U2dXJTTFMxRkFiWmNvRkNsMFdYUXc1Q2pO?=
 =?utf-8?B?SUI1azBYVFdLVXd1c1lhc2pTbjQwamJLSXZuaHlNcno5V2U4NUtJcURzcGN6?=
 =?utf-8?B?SERXb1BHbVQxRU5qSy9UQ05JaUsrZHVMZlR3U2tNWkVabS96eUFlZ25CazRn?=
 =?utf-8?B?R3lZa01GRWNmOFQ5VFVqSlFtQTJnZmpLTjBEVk1WUlFiOExDeTZpNDVMVWRP?=
 =?utf-8?B?dll4VWcvV2N3clZCOThnSFhkUjlzZ3hob1pwT25yeXdGeGFZL3FLRDdtT29M?=
 =?utf-8?B?NTNtS1Y3cDJVN1hoY2Jqejk5em5MeXVhQWR4Y1pqOCtJWURzWTkva25TUlJN?=
 =?utf-8?B?b3J0djBuWXl3c1p6ekNLalBKeWx5OWFpNi9SQmhZZWZjUk1sZEkwOTlOdjNE?=
 =?utf-8?B?OUxQaEdTVUNBZkc0bkU0WkI5eTYvOHU2RlBFSXVHRTdSUnFrUHd6WG1sMmdq?=
 =?utf-8?B?UnZFaUJtRHVhaEo5U1kwenhkeVhVMnRQUGcvV0Q5ZDRmWXNFaGNXRERQMm1s?=
 =?utf-8?Q?o9zJEgZeYTI50vEMbHaAizG0sxa7Tn0n2KizSUtf6Kig?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91360509-c5a6-4b3b-72dd-08dcabab45c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 06:38:47.9310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4PsFZc8wrRUN5RKBbBDQplQngnxGTz+/7tj2U/zxIGJ5GfHGGtEoy3R1yZ8lkZMfipjUjK3JSySYpqKtCPBw5UrmDzcGwc8AXzpBynrZd01cxLM2XPJ/GVZPPlHKUy9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6234



On 23-07-2024 09:16 pm, James Clark wrote:
> 
> 
> On 23/07/2024 4:26 pm, Ganapatrao Kulkarni wrote:
>>
>>
>> On 23-07-2024 06:40 pm, James Clark wrote:
>>>
>>>
>>> On 22/07/2024 11:02 am, Ganapatrao Kulkarni wrote:
>>>>
>>>> Hi James,
>>>>
>>>> On 19-07-2024 08:09 pm, James Clark wrote:
>>>>>
>>>>>
>>>>> On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
>>>>>> To generate the instruction tracing, script uses 2 contiguous packets
>>>>>> address range. If there a continuity brake due to discontiguous 
>>>>>> branch
>>>>>> address, it is required to reset the tracing and start tracing 
>>>>>> with the
>>>>>> new set of contiguous packets.
>>>>>>
>>>>>> Adding change to identify the break and complete the remaining 
>>>>>> tracing
>>>>>> of current packets and restart tracing from new set of packets, if
>>>>>> continuity is established.
>>>>>>
>>>>>
>>>>> Hi Ganapatrao,
>>>>>
>>>>> Can you add a before and after example of what's changed to the 
>>>>> commit message? It wasn't immediately obvious to me if this is 
>>>>> adding missing output, or it was correcting the tail end of the 
>>>>> output that was previously wrong.
>>>>
>>>> It is adding tail end of the trace as well avoiding the segfault of 
>>>> the perf application. With out this change the perf segfaults with 
>>>> as below log
>>>>
>>>>
>>>> ./perf script 
>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d 
>>>> objdump -k ../../vmlinux -v $* > dump
>>>> objdump: error: the stop address should be after the start address
>>>> Traceback (most recent call last):
>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 271, in 
>>>> process_event
>>>>      print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 105, in 
>>>> print_disam
>>>>      for line in read_disam(dso_fname, dso_start, start_addr, 
>>>> stop_addr):
>>>>                  
>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 99, in 
>>>> read_disam
>>>>      disasm_output = check_output(disasm).decode('utf-8').split('\n')
>>>>                      ^^^^^^^^^^^^^^^^^^^^
>>>>    File "/usr/lib64/python3.12/subprocess.py", line 466, in 
>>>> check_output
>>>>      return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
>>>>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>    File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>>>      raise CalledProcessError(retcode, process.args,
>>>> subprocess.CalledProcessError: Command '['objdump', '-d', '-z', 
>>>> '--start-address=0xffff80008125b758', 
>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']' returned 
>>>> non-zero exit status 1.
>>>> Fatal Python error: handler_call_die: problem in Python trace event 
>>>> handler
>>>> Python runtime state: initialized
>>>>
>>>> Current thread 0x0000ffffb05054e0 (most recent call first):
>>>>    <no Python frame>
>>>>
>>>> Extension modules: perf_trace_context, systemd._journal, 
>>>> systemd._reader, systemd.id128, report._py3report, _dbus_bindings, 
>>>> problem._py3abrt (total: 7)
>>>> Aborted (core dumped)
>>>>
>>>>>
>>>>>> Signed-off-by: Ganapatrao Kulkarni 
>>>>>> <gankulkarni@os.amperecomputing.com>
>>>>>> ---
>>>>>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 10 ++++++++++
>>>>>>   1 file changed, 10 insertions(+)
>>>>>>
>>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>> index d973c2baed1c..ad10cee2c35e 100755
>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>> @@ -198,6 +198,10 @@ def process_event(param_dict):
>>>>>>           cpu_data[str(cpu) + 'addr'] = addr
>>>>>>           return
>>>>>> +    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>> +        cpu_data[str(cpu) + 'ip'] = ip
>>>>>> +
>>>>>
>>>>> Do you need to write into the global cpu_data here? Doesn't it get 
>>>>> overwritten after you load it back into 'prev_ip'
>>>>
>>>> No, the logic is same as holding the addr of previous packet.
>>>> Saving the previous packet saved ip in to prev_ip before overwriting 
>>>> with the current packet.
>>>
>>> It's not exactly the same logic as holding the addr of the previous 
>>> sample. For addr, we return on the first None, with your change we 
>>> now "pretend" that the second one is also the previous one:
>>>
>>>    if (cpu_data.get(str(cpu) + 'addr') == None):
>>>      cpu_data[str(cpu) + 'addr'] = addr
>>>      return  <----------------------------sample 0 return
>>>
>>>    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>        cpu_data[str(cpu) + 'ip'] = ip <---- sample 1 save but no return
>>>
>>> Then for sample 1 'prev_ip' is actually now the 'current' IP:
>>
>> Yes, it is dummy for first packet. Added anticipating that we wont hit 
>> the discontinuity for the first packet itself.
>>
>> Can this be changed to more intuitive like below?
>>
>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> index d973c2baed1c..d49f5090059f 100755
>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> @@ -198,6 +198,8 @@ def process_event(param_dict):
>>                  cpu_data[str(cpu) + 'addr'] = addr
>>                  return
>>
>> +       if (cpu_data.get(str(cpu) + 'ip') != None):
>> +               prev_ip = cpu_data[str(cpu) + 'ip']
>>
>>          if (options.verbose == True):
>>                  print("Event type: %s" % name)
>> @@ -243,12 +245,18 @@ def process_event(param_dict):
>>
>>          # Record for previous sample packet
>>          cpu_data[str(cpu) + 'addr'] = addr
>> +       cpu_data[str(cpu) + 'ip'] = stop_addr
>>
>>          # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
>>          if (start_addr == 0 and stop_addr == 4):
>>                  print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
>>                  return
>>
>> +       if (stop_addr < start_addr and prev_ip != 0):
>> +               # Continuity of the Packets broken, set start_addr to 
>> previous
>> +               # packet ip to complete the remaining tracing of the 
>> address range.
>> +               start_addr = prev_ip
>> +
>>          if (start_addr < int(dso_start) or start_addr > int(dso_end)):
>>                  print("Start address 0x%x is out of range [ 0x%x .. 
>> 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>>                  return
>>
>> Without this patch below is the failure log(with segfault) for reference.
>>
>> [root@sut01sys-r214 perf]# timeout 4s ./perf record -e cs_etm// -C 1 
>> dd if=/dev/zero of=/dev/null
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 1.087 MB perf.data ]
>> [root@sut01sys-r214 perf]# ./perf script 
>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d objdump 
>> -k ../../vmlinux -v $* > dump
>> objdump: error: the stop address should be after the start address
>> Traceback (most recent call last):
>>    File "./scripts/python/arm-cs-trace-disasm.py", line 271, in 
>> process_event
>>      print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>>    File "./scripts/python/arm-cs-trace-disasm.py", line 105, in 
>> print_disam
>>      for line in read_disam(dso_fname, dso_start, start_addr, stop_addr):
>>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>    File "./scripts/python/arm-cs-trace-disasm.py", line 99, in read_disam
>>      disasm_output = check_output(disasm).decode('utf-8').split('\n')
>>                      ^^^^^^^^^^^^^^^^^^^^
>>    File "/usr/lib64/python3.12/subprocess.py", line 466, in check_output
>>      return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
>>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>    File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>      raise CalledProcessError(retcode, process.args,
>> subprocess.CalledProcessError: Command '['objdump', '-d', '-z', 
>> '--start-address=0xffff80008125b758', 
>> '--stop-address=0xffff80008125a934', '../../vmlinux']' returned 
>> non-zero exit status 1.
>> Fatal Python error: handler_call_die: problem in Python trace event 
>> handler
>> Python runtime state: initialized
>>
>> Current thread 0x0000ffffb90d54e0 (most recent call first):
>>    <no Python frame>
>>
>> Extension modules: perf_trace_context, systemd._journal, 
>> systemd._reader, systemd.id128, report._py3report, _dbus_bindings, 
>> problem._py3abrt (total: 7)
>> Aborted (core dumped)
>>
>>
>> dump snippet:
>> ============
>> Event type: branches
>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr: 
>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid: 12720 
>> period: 1 time: 5986372298040 }
>>          ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>          ffff800080313f04:       36100094        tbz     w20, #2, 
>> ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>          ffff800080313f08:       f941e6a0        ldr     x0, [x21, #968]
>>          ffff800080313f0c:       d63f0000        blr     x0
>>              perf 12720/12720 [0001]      5986.372298040 
>> __perf_event_header__init_id+0x54 
>> .../coresight/linux/kernel/events/core.c  586         return 
>> event->clock();
>> Event type: branches
>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr: 
>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid: 12720 
>> period: 1 time: 5986372298040 }
>>          ffff80008030cb00 <local_clock>:
>>          ffff80008030cb00:       d503233f        paciasp
>>          ffff80008030cb04:       a9bf7bfd        stp     x29, x30, 
>> [sp, #-16]!
>>          ffff80008030cb08:       910003fd        mov     x29, sp
>>          ffff80008030cb0c:       97faba67        bl ffff8000801bb4a8 
>> <sched_clock>
>>              perf 12720/12720 [0001]      5986.372298040 
>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64         
>> return sched_clock();
>> Event type: branches
>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr: 
>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid: 12720 
>> period: 1 time: 5986372298040 }
>>          ffff8000801bb4a8 <sched_clock>:
>>          ffff8000801bb4a8:       d503233f        paciasp
>>          ffff8000801bb4ac:       a9be7bfd        stp     x29, x30, 
>> [sp, #-32]!
>>          ffff8000801bb4b0:       910003fd        mov     x29, sp
>>          ffff8000801bb4b4:       a90153f3        stp     x19, x20, 
>> [sp, #16]
>>          ffff8000801bb4b8:       d5384113        mrs     x19, sp_el0
>>          ffff8000801bb4bc:       b9401260        ldr     w0, [x19, #16]
>>          ffff8000801bb4c0:       11000400        add     w0, w0, #0x1
>>          ffff8000801bb4c4:       b9001260        str     w0, [x19, #16]
>>          ffff8000801bb4c8:       94427cf8        bl ffff80008125a8a8 
>> <sched_clock_noinstr>
>>              perf 12720/12720 [0001]      5986.372298040 
>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105 ns = 
>> sched_clock_noinstr();
>> Event type: branches
>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr: 
>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid: 12720 
>> period: 1 time: 5986372298040 }
>>          ffff80008125a8a8 <sched_clock_noinstr>:
>>          ffff80008125a8a8:       d503233f        paciasp
>>          ffff80008125a8ac:       a9bc7bfd        stp     x29, x30, 
>> [sp, #-64]!
>>          ffff80008125a8b0:       910003fd        mov     x29, sp
>>          ffff80008125a8b4:       a90153f3        stp     x19, x20, 
>> [sp, #16]
>>          ffff80008125a8b8:       b000e354        adrp    x20, 
>> ffff800082ec3000 <tick_bc_dev+0x140>
>>          ffff80008125a8bc:       910d0294        add     x20, x20, #0x340
>>          ffff80008125a8c0:       a90363f7        stp     x23, x24, 
>> [sp, #48]
>>          ffff80008125a8c4:       91002297        add     x23, x20, #0x8
>>          ffff80008125a8c8:       52800518        mov     w24, #0x28 
>>                  // #40
>>          ffff80008125a8cc:       a9025bf5        stp     x21, x22, 
>> [sp, #32]
>>          ffff80008125a8d0:       b9400296        ldr     w22, [x20]
>>          ffff80008125a8d4:       120002d5        and     w21, w22, #0x1
>>          ffff80008125a8d8:       9bb87eb5        umull   x21, w21, w24
>>          ffff80008125a8dc:       8b1502f3        add     x19, x23, x21
>>          ffff80008125a8e0:       f9400e60        ldr     x0, [x19, #24]
>>          ffff80008125a8e4:       d63f0000        blr     x0
>>              perf 12720/12720 [0001]      5986.372298040 
>> sched_clock_noinstr+0x3c ...sight/linux/kernel/time/sched_clock.c 
>> 93                 cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>> Event type: branches
>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr: 
>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid: 12720 
>> period: 1 time: 5986372298040 }
>>
>>
>> With fix:
>> =========
>>
>> Event type: branches
>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr: 
>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid: 12720 
>> period: 1 time: 5986372298040 }
>>          ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>          ffff800080313f04:       36100094        tbz     w20, #2, 
>> ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>          ffff800080313f08:       f941e6a0        ldr     x0, [x21, #968]
>>          ffff800080313f0c:       d63f0000        blr     x0
>>              perf 12720/12720 [0001]      5986.372298040 
>> __perf_event_header__init_id+0x54 
>> .../coresight/linux/kernel/events/core.c  586         return 
>> event->clock();
>> Event type: branches
>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr: 
>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid: 12720 
>> period: 1 time: 5986372298040 }
>>          ffff80008030cb00 <local_clock>:
>>          ffff80008030cb00:       d503233f        paciasp
>>          ffff80008030cb04:       a9bf7bfd        stp     x29, x30, 
>> [sp, #-16]!
>>          ffff80008030cb08:       910003fd        mov     x29, sp
>>          ffff80008030cb0c:       97faba67        bl ffff8000801bb4a8 
>> <sched_clock>
>>              perf 12720/12720 [0001]      5986.372298040 
>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64         
>> return sched_clock();
>> Event type: branches
>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr: 
>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid: 12720 
>> period: 1 time: 5986372298040 }
>>          ffff8000801bb4a8 <sched_clock>:
>>          ffff8000801bb4a8:       d503233f        paciasp
>>          ffff8000801bb4ac:       a9be7bfd        stp     x29, x30, 
>> [sp, #-32]!
>>          ffff8000801bb4b0:       910003fd        mov     x29, sp
>>          ffff8000801bb4b4:       a90153f3        stp     x19, x20, 
>> [sp, #16]
>>          ffff8000801bb4b8:       d5384113        mrs     x19, sp_el0
>>          ffff8000801bb4bc:       b9401260        ldr     w0, [x19, #16]
>>          ffff8000801bb4c0:       11000400        add     w0, w0, #0x1
>>          ffff8000801bb4c4:       b9001260        str     w0, [x19, #16]
>>          ffff8000801bb4c8:       94427cf8        bl ffff80008125a8a8 
>> <sched_clock_noinstr>
>>              perf 12720/12720 [0001]      5986.372298040 
>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105 ns = 
>> sched_clock_noinstr();
>> Event type: branches
>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr: 
>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid: 12720 
>> period: 1 time: 5986372298040 }
>>          ffff80008125a8a8 <sched_clock_noinstr>:
>>          ffff80008125a8a8:       d503233f        paciasp
>>          ffff80008125a8ac:       a9bc7bfd        stp     x29, x30, 
>> [sp, #-64]!
>>          ffff80008125a8b0:       910003fd        mov     x29, sp
>>          ffff80008125a8b4:       a90153f3        stp     x19, x20, 
>> [sp, #16]
>>          ffff80008125a8b8:       b000e354        adrp    x20, 
>> ffff800082ec3000 <tick_bc_dev+0x140>
>>          ffff80008125a8bc:       910d0294        add     x20, x20, #0x340
>>          ffff80008125a8c0:       a90363f7        stp     x23, x24, 
>> [sp, #48]
>>          ffff80008125a8c4:       91002297        add     x23, x20, #0x8
>>          ffff80008125a8c8:       52800518        mov     w24, #0x28 
>>                  // #40
>>          ffff80008125a8cc:       a9025bf5        stp     x21, x22, 
>> [sp, #32]
>>          ffff80008125a8d0:       b9400296        ldr     w22, [x20]
>>          ffff80008125a8d4:       120002d5        and     w21, w22, #0x1
>>          ffff80008125a8d8:       9bb87eb5        umull   x21, w21, w24
>>          ffff80008125a8dc:       8b1502f3        add     x19, x23, x21
>>          ffff80008125a8e0:       f9400e60        ldr     x0, [x19, #24]
>>          ffff80008125a8e4:       d63f0000        blr     x0
> 
> It looks like the disassembly now assumes this BLR wasn't taken. We go 
> from ffff80008125a8e4 straight through to ...
> 
>>              perf 12720/12720 [0001]      5986.372298040 
>> sched_clock_noinstr+0x3c ...sight/linux/kernel/time/sched_clock.c 
>> 93                 cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>> Event type: branches
>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr: 
>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid: 12720 
>> period: 1 time: 5986372298040 }
>>          ffff80008125a8e8 <sched_clock_noinstr+0x40>:
>>          ffff80008125a8e8:       f8756ae3        ldr     x3, [x23, x21]
> 
> ffff80008125a8e4 which is just the previous one +4. Isn't your issue 
> actually a decode issue in Perf itself? Why is there a discontinuity 
> without branch samples being generated where either the source or 
> destination address is 0?
> 
> What are your record options to create this issue? As I mentioned in the 
> previous reply I haven't been able to reproduce it.

I am using below perf record command.

timeout 4s ./perf record -e cs_etm// -C 1 dd if=/dev/zero of=/dev/null

> 

Thanks,
Ganapat


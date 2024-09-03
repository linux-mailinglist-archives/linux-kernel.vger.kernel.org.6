Return-Path: <linux-kernel+bounces-313384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A1D96A4C6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB312814B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996366F315;
	Tue,  3 Sep 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mIJ0yOYE"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022102.outbound.protection.outlook.com [40.93.195.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261311E492
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381994; cv=fail; b=oPDkmEZVtBHELtPTzq0lhLB7JKUdHaluLwDHK/Hwyww8Gs89BHvjVo5g8tU2vaGZQo5kDapHdm5jHRgche87dFw1QJ8HBNogK7sHPp9B1Ck80wQ2gRGEG8DQpmngZWnRVNbFw+P3lum4T3HVeKBcIDfLXiTV9JvdM4auXQ2Sflg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381994; c=relaxed/simple;
	bh=hRIia0Vr/GPEdQit16SpkYu+Nw2HQdXEBC+L35BiyWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cIs95NWeWj7IAnIb+txw0IX2hyJNZylEHjqx5F7Z/vEwCm4w3IZdLLLLLk4wYQWd5DEwE9FSPsGpIq6gkLabtY7mRlyj4k37UE35VZpJ+vG6mpkP60fkcEETT5rnZJBYZYIcEvFIe10lWG2OBK+irffuS8mTxsbf2NmqJGIJiZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=mIJ0yOYE; arc=fail smtp.client-ip=40.93.195.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+7kWMP+dGOp2uonNLJWX5AjAsPFFz/54zw9TqkFQYtXvoIl8fXE9McMFtvWL0NGqrYNfzLKVgDl4ZnJQpGlpb5EsdonpWYMNEJbs+t03Y8N1HMvbXVPm8s6hVVy93MIPn19rNxGZpVSOCej7acuZPPebH9XBe6n/Fx36zSMlRakQoxw2ZSw9TP97h2n/lG4015Rsm54mc+KeNN6Ox8oc47qcABXRVpZUftPpQYtZs6cyCh9plmMovuR99kR2+rl/AgUBJ1uRRt0ZedZz089MURVfc4AkUM5/OWOGiVnRkU7a+nklvCAGQpq8rvIo46Z3053uf+Ly/PueC6W2wrGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpA+P1RG2jxCgzCm+1g423NYJ1t2Sv6wxT6wiQCvJJU=;
 b=u6KTlU9HlOS5v3osp5ePAV7mfbtdp36OIiAChItz9gqWvi+YoGFuZBEyBnasbUjJdTSZp0i6sywX873O35z6l1bvzW6FVhfPgSo7WBiXilLBZi8Qx4da7PjgUc3UIM9Ul3wywyHUmH+V7jvIwH4dmnGuMyDpfiB+7rdQlMrFc3cfaq3eY7lrT4M+t9E5PM1nc0oPTEK+XX+DfMkCV8ZgtQiQlhY7yH2gwN5KpS7tVL8pce6o6YGHF5Pd2KdEbmR3nMqOf9nEQktSFjkRwl812FUUTctjDamxZHs7zaPWS1HSfwT5EKVBdR5Xvjn2sYwOUHP91ayfb/+Q0g93j9pe1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpA+P1RG2jxCgzCm+1g423NYJ1t2Sv6wxT6wiQCvJJU=;
 b=mIJ0yOYEf5t3rDJ7XZEdnXzxGSSNXqmDizOWfrDMzXp3U2f9Wh0aE1a2pqFQGoiUSTrVrHKc/KANPwCGbEe4bSiJR7afLJyLhAFbyxVrP9ocO6xOTsnaA0nnVqEh1Nov36vKnbdxTzAnpHznEAdZ09OQcDZ3gdMxsUzCpQjYwaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB7341.prod.exchangelabs.com (2603:10b6:806:1f4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 3 Sep 2024 16:46:30 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 16:46:30 +0000
Message-ID: <fee7218b-19c6-48d6-aa35-bd76e3473047@os.amperecomputing.com>
Date: Tue, 3 Sep 2024 09:46:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 1/2] hugetlb: arm64: add mte support
To: David Hildenbrand <david@redhat.com>, catalin.marinas@arm.com,
 will@kernel.org, muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240821184752.3535276-1-yang@os.amperecomputing.com>
 <034f3269-7290-4599-8f12-72b63bf75195@redhat.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <034f3269-7290-4599-8f12-72b63bf75195@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:610:118::31) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e882f02-6ac7-4a2c-2f0e-08dccc37f5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGs3bG9GK05CdnZHT0V2SDJpN0VMT000WVp1LzNmb2VjK3ErSUVmVXVrR0JV?=
 =?utf-8?B?L0gyMFBxZUFjUXRiYWc4Zkk5ekkxeTV4QW9RS0UvWFNDNkdXZXI0ejVHdllE?=
 =?utf-8?B?N1NSZjFPZkJubU02TmFuK1pVVDJvWTNDZzBUa3ZXUDhhaUtrNmN4MnRCL3Fm?=
 =?utf-8?B?RzlwSzRvOHQvbWFVV3NScTgrK3ZkWHFOYzZLcTR5U2I2U2VaWGtPZVg0ZXlW?=
 =?utf-8?B?S3pSMndMWkFtd20xaTVzN3E1UXFNR3dEWjFIZTBxQ2ljL0cyYmxUVFNrOFp6?=
 =?utf-8?B?VXRsbzRYTUxnS1d2cVNkUm5yQ21KNDlBSkdOQUc5aUxlaVhsOGZHUkRqZXdN?=
 =?utf-8?B?WXM1TjZkN2J3SXhKWi9jaTd5TVZzb0dyamdaeWU2L1plb3lmdittZnFMRHZF?=
 =?utf-8?B?dXVzbVhsbXZlRUZBVzNEWmJoY3Q3T2R5dG5Hd213S1duaHZKR0s5MmQrUTNP?=
 =?utf-8?B?Sms4UzZFbXV4bTV6RWtoLzkxUzk2Rzl3MlRYNHlyM1dYUW8vMU9rZFNLbDJD?=
 =?utf-8?B?UTM2WlRZdjU4THFoRTR2ZmdOWGt1TmxJQVJLem5aSW52YjQ1WDY4VGIwVlZT?=
 =?utf-8?B?Q2FDNmNxSGhER3B6NkJIcFlWMlNIUkNUOWRKT0hMSGs2Mjh6enk5SEl4WFBP?=
 =?utf-8?B?UTFsY0Q5YXhvb09JMDloSHlIZ1E1dDhRbk9hK3IvcXRVdEt5S1NyeHdBbWEr?=
 =?utf-8?B?MmRDWGc1V0xtUTQ2cm5VNks4ckkyYkVVOWRLYjBaSzZFNllUMWdXdVY5dkU2?=
 =?utf-8?B?WFFBQldyNEtxVVVLTk5tTUMyZmZncFhEdWw5UUtVZmlrWk4yMklGL1ZwWU5r?=
 =?utf-8?B?cG0vUHB1VVByNjRUcnlBZGVidFloSjVDSjFGZTFsWlMwK0N2U3o4Nnl0UVZR?=
 =?utf-8?B?VDFTYzIzZjdXU1FGaC9UbVRpNXp1QVJ1ZjJab01EUC92aCtqZ0QyWk1VckRz?=
 =?utf-8?B?TjZ0V2JqSmcxa3k3UjVKZy9kTlFKdGFwZjhQRXhobHNLaHlrN0IzM0FCQkdW?=
 =?utf-8?B?Z1ZXYmVlU01uTGptZG1LZVFhVzN4MWsyWkpQbXNBM2wzQ0Q0M256K0QrcSs3?=
 =?utf-8?B?Y29pMWNNbmRHeXlCZWFDeUNCbU9BWnlidnVnQnBxWVlndzNFN0NEa3R5VkU4?=
 =?utf-8?B?eFZiWXpQRGxJd0loWUNKcVlET0x0MUtPeFBVampsS2x6ejl1eUFBSVBOTi9h?=
 =?utf-8?B?SFYvSDhYMHhTNy9waFlkSWlhdTBvQ1VORkg0L3hvemd0b01PMXhUL1pUMVlu?=
 =?utf-8?B?c2ZZWE1SYnZ1dm9aRUltTnUvOHVqWGhVOWt0T0NEVWFLcGg2aEZaczZvUlZ6?=
 =?utf-8?B?Wnk4Rlk4WnExZ1NiWXJGUXMrbndTTFducnlWMEJvejNWdU1XeExNbXdOZnQ5?=
 =?utf-8?B?djhRd0w3Wnd5OGpwOXF4YzhNem15bE8yRm52VzJCdVFrSDhJcjhSenlzNTJq?=
 =?utf-8?B?ZURsUlJ0YTFHNTNYdjNUVlBnMWZUdi83N3AxRzJScEpockdTMHB5R3RZeFJN?=
 =?utf-8?B?R05yRXBuREpJVVVsYUE1eTlOazh0b1BrR2lvY2laYmFtY2pLUWVIdXk0SE0x?=
 =?utf-8?B?KzV6V2ZjcnpOLzBYSW1neWxMZDFuclBabjN6aGdGT0N4QmxETG9QaWdyWFZp?=
 =?utf-8?B?MDU2Y0NhZnJLdHc1RGJnNmVKUDBmcklwbnIxUkZ4MWEya0NUUEd5WGRSQktN?=
 =?utf-8?B?ZEx5MllYQ0NoeFI0S2I5clpCQmd4TEFnZno3S2ZiMEhYeUVtUlQ4eXF6dk5r?=
 =?utf-8?B?cTZlUnc2clB4dDlMVEl1eU50UnhoRTU4azhjTXNpWnNaVFlybUJNcmFjaDhL?=
 =?utf-8?B?SHVWRGgxNzFTdVpHekVKdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk5YQ2w2dG12UnRnN2lFdWRYUkJRUWJMczNDN291VkR2L1dRdWc3Ym5taGJh?=
 =?utf-8?B?Yzd5cTM2d0VVdXc2S0puZDhhMXFYTktIc3hxNU9MTm1rT1RNTVVjeUhxTFZM?=
 =?utf-8?B?T3pTSE9HVUw1aXpLV2VxMStEdzVoTFlzdDZqRkY5WEtQNElzb21TUTZ6M3Ja?=
 =?utf-8?B?ZGwwOFVwVS9HNjQreWozRlhEQ08wK2ZCelJLbmFXV29Tb29mOUdBVmFpQXh2?=
 =?utf-8?B?UkIwSEFWSndGeE5objlNTjJFaUZ2YVQrTGQ5TCszNlZ1VTRISlJkY3pBY1ZF?=
 =?utf-8?B?RTlnTkIzeFJZVGIrZ20zc1RBeU9oV01DZm5yMEdFdUxmZlJjOVhYejBWaWUw?=
 =?utf-8?B?YUdjTXM0SVhVQUNsUjNwSCs5YkZNc2pqTWh1cjI5b2NBTytYWDczc09rR05W?=
 =?utf-8?B?Yjl3VW5ESDY0Qm9RNjlHUEFaUkhhamxPdkVzRlNOU2xPKzUzckp3Q3FwZlZX?=
 =?utf-8?B?a2RncmwxUEdhTEZlRlluckdabVhIRUptckFxVXNRRVVKL1l6eDF0Q0xYOEZu?=
 =?utf-8?B?QS9uQ3JRMDFaeDFyREovTktEQXYwYitPbnQvYUFMb2hZRXFnTkI0NjY4a2pB?=
 =?utf-8?B?WlZGVENXM2JSbEcrSTBDcjhBQ2NiK292NEFmT2Q5TTNMeEFZTWVpeHZSTUhw?=
 =?utf-8?B?TnFUNGxmRlBEUkllVVo4UXlJVEZwUWtKQ1I3Sm93NVB4bEFrRWo0NHN4OUpi?=
 =?utf-8?B?QkZxRlBsUHBWVXJjVzhpTlZjZ2xkME81Nmh5UFJ3Z1pDSCtIMjFrbFVHWnBG?=
 =?utf-8?B?R3VNbS9lVUxqblZLOWlBRTk3L2tLTmg0aGRGZUt5UWd5OURpVDJaR2U0RXhL?=
 =?utf-8?B?WU1WMk5mL3h6LytjTVZIRUJjQmgxaTUxT1NxaHN4RHpHa2x3d2tlaGhvNzQ4?=
 =?utf-8?B?MEswMDY2VHdsbmo3OFNqR1d6TVhyZXRCQVVTSE51WU1TU01mZ1V3YUQ5SXpj?=
 =?utf-8?B?QTFSdGJ6QzZuRVRUNUQ5ZElmSEJSQUErd0JmOC9NOFM0S2ZOWmJWYm5Ma2py?=
 =?utf-8?B?dklTdzJXNDBsSDZoaXk3WkxoaVp0b3NFa3cya01Xc1E4SFNIWXB6RmM2Z2lC?=
 =?utf-8?B?SEhsVGxvZ1JpWjZLT0Q1dy8wNW9iNVRJbEtBcS9HN3V5bzVZZGYxR3NnaHFa?=
 =?utf-8?B?ckduN29FTERFTTY1cC9BRmVrb3ViamhNN25ydXBDWXN4emN6NmpvbGF4UUVs?=
 =?utf-8?B?UEJCR1owaXRZRnpJcUhoUG9lRjNWeGhDdFZPZGVjdk5lNW41Y0t6aDR6d1Jj?=
 =?utf-8?B?N2MyS1pnU0FEZGtiQndLUFJUUG95N1ZYNHhxTmVkUkZRZzd4WE9ySUptVmRD?=
 =?utf-8?B?d01keWNtcENrR3J5Zjc2bzVIa0NQUzJhRzI2bDkreEdheEpFVTN6UURZdlB2?=
 =?utf-8?B?RTJuQ3VXRmE0K2ZDUHpnVVgxc2VIR3ExSVc2MzliSm9yZ0JnbEdYcklNcTNn?=
 =?utf-8?B?Qm92b0luYUdHaDhpYTFiQXdUUjFwcmRrUlIvQU1NVUtqTk8xK05QUHpLTit2?=
 =?utf-8?B?ZnRaVXpuZHdwUndhbzZFNTMzOGI3SDNINnowVVBCU0VkU3ptTTFOS3FyQ0JS?=
 =?utf-8?B?cjlSRXN3aFB4QzV1MTNReFVJUVpZVlZhVDFUNHBYMjVoSlpaN2ZHZzgrR0pj?=
 =?utf-8?B?ODU3Z3dXazdmbXZELzFPRVBMVkIzbHptdEt3eG05cWZ2VlZMTUttcTBFbkdL?=
 =?utf-8?B?T0lTOWpwNFRxVlN3YjF6UFZrdnpNSnNFM3ZpblJSdnNWOTV4VmJDMjlDZU1k?=
 =?utf-8?B?QWRjaTBER1hweWI2MkhZMDkzTDg4V1Fvc0VLb2wyd0Z2MC9FYTlrTEd4cEZq?=
 =?utf-8?B?SHE1TlNsZnVTbk5vMWFNM0szbm9HN2NwMHd0UlNmdlVwNUhqdHJmd0NVb2pD?=
 =?utf-8?B?Ym9jeW1TU1ZNcmxFSldIdHJhVzJCSFBZcmZIUytRMGJFWVZRdmh6MUhlSkVG?=
 =?utf-8?B?OGZhTERYRDNzQUxzNGRRb3J5Kzc0akNQUWJOYkg3cXhOSTk5V25PRnZmbE04?=
 =?utf-8?B?TG1mc3U4bEZSZFhKbDlVWm9iVlJXM2tnekR3c2xFWHJ1aGZVeURXc0NYNlJ4?=
 =?utf-8?B?VGd1UjdEdlF1MUNWbEw1L2U5a29zbXV6Zi94VEJobUxkSHR4ejdCck5OVktX?=
 =?utf-8?B?WjlqbWVJTDVyNkFqZ3p1M0MweXI1WEdGTDJFOCsvWk1zVVZFSjhMYVRVSDQ2?=
 =?utf-8?Q?PV3qRCa/04Xuhjhe+tHENtw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e882f02-6ac7-4a2c-2f0e-08dccc37f5f9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 16:46:30.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMGGZove25n54nw4ChrLtvHVYL8wnuOqphgjiOAmI0Yv7nyb12lSyXMGvrAG7GsSmWH9XszYJOJ4xUw3qB7Osoy3T9lkE8LHxX2VK6i0ooo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7341



On 9/2/24 7:33 AM, David Hildenbrand wrote:
> On 21.08.24 20:47, Yang Shi wrote:
>> Enable MTE support for hugetlb.
>>
>> The MTE page flags will be set on the head page only.  When copying
>> hugetlb folio, the tags for all tail pages will be copied when copying
>> head page.
>>
>> When freeing hugetlb folio, the MTE flags will be cleared.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/include/asm/hugetlb.h | 11 ++++++++++-
>>   arch/arm64/include/asm/mman.h    |  3 ++-
>>   arch/arm64/kernel/hibernate.c    |  7 +++++++
>>   arch/arm64/kernel/mte.c          | 25 +++++++++++++++++++++++--
>>   arch/arm64/kvm/guest.c           | 16 +++++++++++++---
>>   arch/arm64/kvm/mmu.c             | 11 +++++++++++
>>   arch/arm64/mm/copypage.c         | 25 +++++++++++++++++++++++--
>>   fs/hugetlbfs/inode.c             |  2 +-
>>   8 files changed, 90 insertions(+), 10 deletions(-)
>>
>> v2: * Reimplemented the patch to fix the comments from Catalin.
>>      * Added test cases (patch #2) per Catalin.
>>
>> diff --git a/arch/arm64/include/asm/hugetlb.h 
>> b/arch/arm64/include/asm/hugetlb.h
>> index 293f880865e8..00a1f75d40ee 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
>> @@ -11,6 +11,7 @@
>>   #define __ASM_HUGETLB_H
>>     #include <asm/cacheflush.h>
>> +#include <asm/mte.h>
>>   #include <asm/page.h>
>>     #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>> @@ -20,7 +21,15 @@ extern bool 
>> arch_hugetlb_migration_supported(struct hstate *h);
>>     static inline void arch_clear_hugetlb_flags(struct folio *folio)
>>   {
>> -    clear_bit(PG_dcache_clean, &folio->flags);
>> +    const unsigned long clear_flags = BIT(PG_dcache_clean) |
>> +        BIT(PG_mte_tagged) | BIT(PG_mte_lock);
>> +
>> +    if (!system_supports_mte()) {
>> +        clear_bit(PG_dcache_clean, &folio->flags);
>> +        return;
>> +    }
>> +
>> +    folio->flags &= ~clear_flags;
>>   }
>>   #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>>   diff --git a/arch/arm64/include/asm/mman.h 
>> b/arch/arm64/include/asm/mman.h
>> index 5966ee4a6154..304dfc499e68 100644
>> --- a/arch/arm64/include/asm/mman.h
>> +++ b/arch/arm64/include/asm/mman.h
>> @@ -28,7 +28,8 @@ static inline unsigned long 
>> arch_calc_vm_flag_bits(unsigned long flags)
>>        * backed by tags-capable memory. The vm_flags may be 
>> overridden by a
>>        * filesystem supporting MTE (RAM-based).
>>        */
>> -    if (system_supports_mte() && (flags & MAP_ANONYMOUS))
>> +    if (system_supports_mte() &&
>> +        (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
>>           return VM_MTE_ALLOWED;
>>         return 0;
>> diff --git a/arch/arm64/kernel/hibernate.c 
>> b/arch/arm64/kernel/hibernate.c
>> index 02870beb271e..722e76f29141 100644
>> --- a/arch/arm64/kernel/hibernate.c
>> +++ b/arch/arm64/kernel/hibernate.c
>> @@ -266,10 +266,17 @@ static int swsusp_mte_save_tags(void)
>>           max_zone_pfn = zone_end_pfn(zone);
>>           for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
>>               struct page *page = pfn_to_online_page(pfn);
>> +            struct folio *folio;
>>                 if (!page)
>>                   continue;
>>   +            folio = page_folio(page);
>> +
>> +            if (folio_test_hugetlb(folio) &&
>> +                !page_mte_tagged(&folio->page))
>> +                continue;
>
> Can we have folio_test_mte_tagged() whereby you make sure that only 
> folio_test_hugetlb() uses it for now (VM_WARN_ON_ONCE) and then make 
> sure that nobody uses page_mte_tagged() on hugetlb folios 
> (VM_WARN_ON_ONCE)?


IIUC, you mean something like the below?

bool folio_test_mte_tagged(struct folio *folio)
{
     VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));

     return test_bit(PG_mte_tagged, &folio->page->flags);
}

bool page_mte_tagged(struct page *page)
{
     struct folio *folio = page_folio(page);

     VM_WARN_ON_ONCE(folio_test_hugetlb(folio));

     return test_bit(PG_mte_tagged, &pge->flags);
}

>
> Same for folio_set_mte_tagged() and other functions. We could slap a 
> "hugetlb" into the function names, but maybe in the future we'll be 
> able to use a single flag per folio (I know, it's complicated ...).

A single flag per folio should be the future direction, but I haven't 
done the research so can't tell how complicated it will be.



Return-Path: <linux-kernel+bounces-413107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B1B9D13AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DA8283AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384851A9B51;
	Mon, 18 Nov 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q4LnMU2K"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF8186E2F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941591; cv=fail; b=TpeK01HTT4Vitc+a9qlGCsXTpkjo/KUFZX+s86hoFZLpucBTyD6yDTFzXMOER1lsZGNt3XKB2MFTJScgaaGUn38/j3M7tw6PVsIDv63UmsvLoCWNKraBnpaF5267kRZCQkclDk1+PabF3VBvuV/vwi5ii+pu8RVAi2bacjz/ZlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941591; c=relaxed/simple;
	bh=v8vUPHbLLnpcIrCOlaKdkmAjEbYiYD6p0nvOXPhZ+F8=;
	h=Message-ID:Date:From:To:Cc:References:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=IxWaThfoN2MJPhN7nSWBBGjUuEgheB18vknZYfhTkbWb9SAfD3gJwdRjdmQ9gNFrJFljZ8t+Omzd7TWI1T4YYz1squNkFNjrNJKS7CELxCl9lc+yl76vzuFZ7ucCe+DyffKwtFJJ6KCPDRZhQ8AWYXJ30qkvH9i0LBVoquxyLN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q4LnMU2K; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4Rn8UZG6/0HCpvLvf4sOl78VhWtxTt0hw1NeKRnFdz45gSAgKgeotdbJVegK4eARft9HpSeggf+9uzcOZr2Mk2ptOCvLTT9vp5o/QdEQzZKwzjc8Xzv47rd6HIg2nHYdTTLuxkDU3BTXzLAUCr6re5//ckoS1us8VcNaGbWNvkHxvIqhwUt9BH9kD5KqQyi2wwjP2KXKW5DGqZUemjpMzuO1xt8P4XGrBLCkY7pXIdFLODQXKktewA4J/QQTtv4Jvgl10HMZjEeOVfNJ2q+UYof3n2px7jky3WytPA3V1Rb5afMXMx/oNlXtqHVPRVf0SWVIaLY/j0ORo0mxiUWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGkt67Dk1cZss3DZXSoPF+yuz6DGgXuXWwgy9AACtJ4=;
 b=MXNXwm288MojEaf8nnBNlNM0JQT/WUNQTWqHvAG9PQMIIPEIfObWBYcGtriXqDYRg2cYnhI/4EmZ9ZEUjkipeJMcE3koBYIlnTL36boVXC1iJZn+syMtkjAsgbdOMF56u5czjHhyqEL0rpE68/uzpc0M4ZOueoofEPTqoHruORwf4ESrKbx9+7ORY+ochUYB4kdaCLhOCamQvutWcpvRU/i5ifga/QoqCX4Es4s2mNEQ9AdpxRr46x9NDPDGhWNCGNQGR94tFG/IffpoqQFpjRUSBPMNiyok2lbwZ41BoB25xgqEjFY+qg4xxXIusCXak2NLs85xYCH4HEUiE+QUfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGkt67Dk1cZss3DZXSoPF+yuz6DGgXuXWwgy9AACtJ4=;
 b=q4LnMU2Kn9QRon1x/EAvADU9M8pIAj2lzM0kl8AwGfmQytofUTCqZQSghOedXQPquniJ/guPZYi460PWI039kTsEzAV90vukHudXwR8vQx3gcsoBFeH4shurdy9vw8nzX8sYR4WyBIE06bRbNi1hM/qMZS8zUx1Wt+ukrMS3qps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Mon, 18 Nov
 2024 14:53:06 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 14:53:06 +0000
Message-ID: <30558bc8-c22c-1ce1-f59a-66c057fdd06f@amd.com>
Date: Mon, 18 Nov 2024 08:53:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Ard Biesheuvel <ardb@kernel.org>,
 "Ragavendra B.N." <ragavendra.bn@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 ashish.kalra@amd.com, tzimmermann@suse.de, bhelgaas@google.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20241115003505.9492-2-ragavendra.bn@gmail.com>
 <Zzcp75p3KTFRfW5O@gmail.com>
 <CAMj1kXHK4NxgWCieaQY7tT6BquSBv6Db10K8-V_8qFeZKv=BZA@mail.gmail.com>
 <ZzemwFBfEIgFhrD-@desktop>
 <CAMj1kXHPut9qv7dT9Xv=xhbS6AP3HRP0dikk-G690AKfLuNLGA@mail.gmail.com>
 <c7a9748e-aead-b252-dd29-48dd0d2da9be@amd.com>
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
In-Reply-To: <c7a9748e-aead-b252-dd29-48dd0d2da9be@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::31) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: eb80d748-fe51-44d8-8672-08dd07e0b5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXJzZVNickxaVW43UVp5WFRxQ0F3dngvV0dzTTYvZStKbkJxam9ETWFpcWRi?=
 =?utf-8?B?RFAxd29HaTVxSGNFeXNyYmFPSDIwOEZVS25rTjd4alhaZVRaQW50Nnlva1BL?=
 =?utf-8?B?bmo1TFJlTWF6TXd4TjhYSGtIMXkyUkZhMDUrczNPU3ZsWjRYSWZzS0dHczJK?=
 =?utf-8?B?T3hyVmk4TUR1cmpoaDlteXdLLzIwUlFtUFV4MnBDQVptSERmZGZEODNUYWRM?=
 =?utf-8?B?d2p3NUo5ZkUva3h5K1E5RUt6YXRVMXUzR1B0RW1MeE5CQ1RkRFRsdzAxUGlR?=
 =?utf-8?B?Y3dRZmZhNVJnbUhuU1JrNTNZU3BGN2VOQmdlbDRzSUgvRVlSYmE4eVU5OEFi?=
 =?utf-8?B?dktaQlJJUFBKbVorTExNcnJNWjJxRHFGOERHa28rWUN2RWQ0NEt4YjVsbXdB?=
 =?utf-8?B?QWRtVEFlMDBIMUZtdStzRmV6dEJFVGphV2NOZlNLQ0Fwam5Rd2ZVN2dISGhm?=
 =?utf-8?B?aTdmaG9MOWxyUzZNclJ1NUk4WUdBb1JvV2ZnbkpxRjE0REdzeXVUSWpoN2c2?=
 =?utf-8?B?dTdSMlRkWW1VbVYrcmpFblgyT21HOElob0xHUi9BUFFSaTRRckhZc3RlR1M3?=
 =?utf-8?B?ejJGK3ArZlRqb21WTHVCcWdFQ3o1L0dRc1p1UmU2SmNXdEpjYTlvYkgzWVJv?=
 =?utf-8?B?anVrb0VNbm5VZDZ5L2ZZUWJndXZsUnA4ajJLbGNiRzUzWUR0MUp1VmdUamNQ?=
 =?utf-8?B?MU1wMjRicC96eHZDVUtDejF0R2FVWUlHY0RnNnZrSTRnQm1FN3B2T3VTVlN4?=
 =?utf-8?B?czNKQ3YyZGpzR0xhTi84Z25UVmVzU3N6NjhWNWNxTDFGTVR0VkJNT1h5UDdH?=
 =?utf-8?B?dDNUVkl3KytUYUlyQ0NBQStkMndvME1sV1I2azl5bFdsUjZyRUlPVGxxVVho?=
 =?utf-8?B?ZU5wRmgvclVSSkw2S3liczdPNWw4cTlyUm5aVlV6cEZCdjU4STM0b0tNZ1JS?=
 =?utf-8?B?L2ZONnE0WVVkMTNoeWhnSXhJQnB1ZkZHOTlSelZNR29CMHV5MENlQVZOUjE4?=
 =?utf-8?B?Sm1sVlBGS3BHN2pSdzVjb1hCd1dyNEIwN1Z1QlVKQnEvSzc5eU1SM1c5ak5J?=
 =?utf-8?B?RTdBa2Fjc1dDUGY3bVJmSy9UTHRZb1Q3dmlSZUZUTW5HVnFNYmZSVTdYaWJN?=
 =?utf-8?B?dUhueVlUVHdyNW5aMFZ3NU9TYSt2My9Na0d6cEtVM0l1WTJDRE5HNm5icURV?=
 =?utf-8?B?NkRGeFdNazNubkxPNko4MjY1TDRBVGtmZGZCeVpzMzdvd0Y5UERrek1Lc2NK?=
 =?utf-8?B?ODFlV256N1BTM2ZGU3VHUkpOdWZwWEtqaHBjTmM4K2JnL3N4R0YvVnRBTmgx?=
 =?utf-8?B?Y1FMVUZUN0hEOHdZbVA0ZlYyZGZjTElmUElqZ3NvSHpUUWN5M29WaVRjbnNX?=
 =?utf-8?B?MGJTVk5JUDIwanZpUFRkc3QwYmg4YjFKMVZ2ZmF5YVpiUXBrNytJUkdWeDJq?=
 =?utf-8?B?QjlpZUxYa3hjM05qOGFkODR0ZnI4alQ1Y0JUb1BFT1NYQ0NVSEZHMGViUHBX?=
 =?utf-8?B?dFVCTitFSVo5Y0R4NnByT1VuMFQvc1lxdExvM2FTQlhxTG0rWEZMbmpSSEs0?=
 =?utf-8?B?L2ZUVEdDTFpoYVNEbVpERjNWUnhSd0V3dFFHMnUrSTV2UDBnQ2EyN0x6V3pD?=
 =?utf-8?B?MlEzY2h2c3ZMQVBBQzZFaS9LOS9pMjZiQnA3Q3J4czJuMjNlaUVDbDZZUVpq?=
 =?utf-8?B?bkJ2MUZIYmxmRjVFWlZMNDl5UXVoNzFka2F3S3V6R0wrNEtQYjE1SEs1TTFS?=
 =?utf-8?Q?gYCfCT11KXQLaHYo/dPzWLaTOWl7oi47UXg9j3Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3RqQ0lkR1pjSmpZb1B5c1c3ZFhxSkVxRDNWQXoxL2VVOVpGc2N6TkFmL05s?=
 =?utf-8?B?Q3RBeHZ6eXpRRFQ2ZE9NV1Ntb3djU2RWc3NPQldzRnB0WU9wdHlqOFdscnha?=
 =?utf-8?B?MVBrMFVKakJPMDZpRzBSR3lEcVd0VSs0elpYUTk2SXg2ZlJVUHZaNXRqeXpG?=
 =?utf-8?B?K2M4dWczV3RtRXpONkdoWWlZTnI4MXk3MzhKOUlCbDNDZEtXVzNrTGVKK1V6?=
 =?utf-8?B?K0VtNGFZN043eVd5dVhIVGJrYTlveVRSdE5kVUltMVJ5MmNCcVJmL2hSSjli?=
 =?utf-8?B?eXozQWwzcGh3SWRXVDIvM3F0RjFLLzYwT0FIVkdpczhCU0FmbUswVEU2a1Zx?=
 =?utf-8?B?VjlXVXI5dkpXbXNTZTNWTXU3eXZXZmJjVHRuMjRMR2NuUllzcUxQbWdVOG5L?=
 =?utf-8?B?cm5qNWJqdUp6WWZMVUszT2I4ZHlxQjMyK2J1WHpEbkc5NUhMZUhKaFpSak05?=
 =?utf-8?B?S3hMQmErQ0xnMEVPMWVjRnFYeDhSZUkyZWpudUIyU0tDcHBzR3M2YVBSQmMw?=
 =?utf-8?B?QlAycDREQXVLZmRUUWpIdHZGL3hzS0M5TEs3QkFmOFFJQVNQRDRXa3Y1VFFs?=
 =?utf-8?B?bVdHWjhFdEp1OVhIbzgrKytVUytYb0lORGFNWGpWU3Q2aXRucXAxSUtMa0pn?=
 =?utf-8?B?STMyR1VDaHBrWHRIMlVNZGgzY29rbklkMzFLczJ6Zmxlclc5dUxkNWxkNHNl?=
 =?utf-8?B?bW15Vm9BUlA5MHkyNmRrUWtwUnhxdTIxNE1ITTNUTS9sZGhLWHVkdUxVeVZa?=
 =?utf-8?B?OXFmMzhmMzFDMkszYjhqRGF1OFJiMkswbjg4WlB0NUpCbjRjVlV2ZlQzUzFU?=
 =?utf-8?B?eG9XOGJkOGRxeEVlclh1d0VkK0YramRDbW5rMWRDaVNSRGR6SG9XMVVqME0y?=
 =?utf-8?B?VWlSekFiNEppNmhMdldpWDVnZUdDVFAxMzJpMUlsVXBDRXA5SUZJajM0NE9o?=
 =?utf-8?B?aUVKY3FkWllyT3pDV29aWDNBMUdCQWtzaDJSVm5PSnJMaWpTYVZnMTJoU0U0?=
 =?utf-8?B?a0htR1ptTk5YZnlsTXREVndQOTIvdSswcTJVcHZ4cTZQb3dNTGR2REI1ODQv?=
 =?utf-8?B?ZjhlamZ6dllsVmZXRjZjMzFzYXd4UWNESnNiUGs2Y0g4NUZrYnJFTytCMm5m?=
 =?utf-8?B?NXBDbVFsWWR1YlhJeFBYalFsYjdOT2E4cHFxbUgwSDR5RDBvWWNOeVl6SUps?=
 =?utf-8?B?Mkd5aHBrQTRQZjREcTEzNnREVkJTczUxMDZFQjNiK3dETlNBdmJPR2c5ZkZx?=
 =?utf-8?B?YzFuNERpQ3Jtejk3QmptdnBOVFQydWdQSExTeVEvN3FKdjk1ZHhUQSt6dTR4?=
 =?utf-8?B?RVVUVUxQTlNOTForbUo4SkFUeXNVSnArSGJCdWlEeXBZK1cxdU1ZWTlCbHBa?=
 =?utf-8?B?QloxekhmL2NCdmhPZ1lRcGNIY2pVVnA5SC9BT1Z1c1psM3c2ZTJUeXhHODZY?=
 =?utf-8?B?NjBQcDJGeW81VTlwUklucjVpNUVQU29QalRLcGUxRlFydkd1ZzRMS0h5dFpm?=
 =?utf-8?B?akxmWHNRUmRsRnMwOEE2M3E5ZUNrNzZ4NWxyMEdnWERNTFkwbGM1QVM1Wmhr?=
 =?utf-8?B?WUxPYkh6YjJBNUR0MUN4NTZVRXNMWDN0WThmWFNRdThPdGptVlEzcjNQck9j?=
 =?utf-8?B?ODRWbVFWVFkvOTZJZkx3OUttd3krRWR0VTlIaFRtVU9tenYwN2M2NmROcVhD?=
 =?utf-8?B?TGxUV2p4cDREc2lYWFhObGs3T1JMMmJjKzQ3OWJQWGNhVDJaVVBGaEFQa3J0?=
 =?utf-8?B?SjdMVWs4TUdKdXJyMkpTckNsNEZwNUUrME1Ia3pGVGVvT21kcm1tQ2VIZlgw?=
 =?utf-8?B?REppVWxpTTEzblJEMVJGWllRZjdOelNOYzh4MHNLWmFBUVZ6TGFSa3VWNlB6?=
 =?utf-8?B?d05TeTBGTC9OUmxBYktsRXJpWkRvVzdJL1p6aUdWTmlvbkRBVXc2Q1BzV0ZH?=
 =?utf-8?B?ZlRFM2VYbFVBUCs5eko4YXhOT0c2YWtXUGpJQy9PamVhVXI0OHBiUEMyRnAw?=
 =?utf-8?B?a0JhMVBidWsvSHA2WDl2anRVLzdINFRUaGR3eWJZZjlDNFl4eXB1ek1RbVJU?=
 =?utf-8?B?aTlxRzlLOFJwcXgyeVJLTDIzYU9mVmtWUVUvWHJyamw2Zi8wSFVMMVAzZHBZ?=
 =?utf-8?Q?yPO8SbvaWd1LkkecfTX/ga0or?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb80d748-fe51-44d8-8672-08dd07e0b5d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 14:53:06.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CklUpTjuLPjk7fpbZFEymId5LSPBSfCv5MzewKc2CbSXMgc/Dyq/6vVARo9LSEzdS8UeJrhugo1jrK6PaWtMsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162

On 11/18/24 08:44, Tom Lendacky wrote:
> On 11/15/24 16:55, Ard Biesheuvel wrote:
>> On Fri, 15 Nov 2024 at 20:53, Ragavendra B.N. <ragavendra.bn@gmail.com> wrote:
>>>
>>> On Fri, Nov 15, 2024 at 12:02:27PM +0100, Ard Biesheuvel wrote:
>>>> On Fri, 15 Nov 2024 at 12:01, Ingo Molnar <mingo@kernel.org> wrote:
>>>>>
>>>>>
>>>>> * Ragavendra <ragavendra.bn@gmail.com> wrote:
>>>>>
>>>>>> Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
>>>>>> it was not initialized.
>>>>>>
>>>>>> Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>>>>>
>>>>> This 'Fixes' tag looks bogus.
>>>>>
>>>>
>>>> So does the patch itself - 'struct es_em_ctxt ctxt' is not a pointer.
>>> Thank you very much for your response. I am relatively new to kernel development.
>>>
>>> I know we can use kmalloc for memory allocation. Please advice.
>>>
>>> struct es_em_ctxt ctxt = kmalloc(sizeof(struct es_em_ctxt), GFP_KERNEL);
>>>
>>> I am thinking to update like above, but like you mentioned, ctxt is not a pointer. I can update this to be a pointer if needed.
>>>
>>
>> The code is fine as is. Let's end this thread here, shall we?
> 
> I was assuming he got some kind of warning from some compiler options or
> a static checker. Is that the case Ragavendra?
> 
> When I look at the code, it is possible for ctxt->fi.error_code to be
> left uninitialized. The simple fix is to just initialize ctxt as:
> 
> 	struct es_em_ctxt ctxt = {};

Although to cover all cases now and going forwared, the es_em_ctxt fi
member should just be zeroed in verify_exception_info() when
ES_EXCEPTION is going to be returned.

Thanks,
Tom

> 
> Thanks,
> Tom


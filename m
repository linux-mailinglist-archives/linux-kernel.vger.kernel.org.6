Return-Path: <linux-kernel+bounces-301664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9D895F3C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055C32812AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779F3145B07;
	Mon, 26 Aug 2024 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fRvEvAS0"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA56188A09
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682260; cv=fail; b=pzS/aYoLXNatJRE9IrJPQvpDK5FbN43L6ccx/NrcbJt2n+nmplKVvEwtd0Fx6Ar6ZimWkZxHlibgty7ARk+YmPC5ZTsq34rNHGqLW0ONNA3m9+PKgpmplplIpaCM4XjxwXeY3UXFI3WcZzqzal54sO9SDR3Wfmljr73TcTfWEFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682260; c=relaxed/simple;
	bh=r2dZsW+0y2WOT0ZgPoMT/X782YHx+alQqNnqHMbGPnE=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=L+jFxDr125KM3Flz4lR7EwbTBsPldV42NylHUE4wRXzndbG8zx+ztJoIGLXEuvceQLCcKzb2e/RwkFPHo0VMb/eMu4giPnFTdsLXDXyb4RMNmLhTK/frOEbr6+DpCbh228ScvgfwlQV77n9GTqBRaaEvVDDVJ/vytvE8/CU0FwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fRvEvAS0; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8UyKFI9rHVjAJlVTC4n/B5vJeUniBuLY1eJkNzKKamvE9frluLhs9HzSXPZBkPkgK2LuZwqwAVlaEbEacbsDaO+DG8C5ENsB5+a9/ZUzI0ZVGA/9sDN8SdOTMzgmM5Nrgr2gIPxb4BvCr8fVarJQcB6fO17D5uOcUzELPvdTwxK8bzyP+F6uMZ1kLFww+6exnzZCLauT8d7f1Jx7JRxpq78DObsq/fwKH7Nk3gXAlzLvH/1jdLcjOv+F/ak6sa30MFAw9sWBqbcRPm0yI66xuh6WUle35vBA7SW1p88p39NOepliYKqNDMYYC1CqeTCt3AnzTGNoGSwCdp/S4xYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWLetO0P33D0Gxys2gBwlG2SbDKf5Z+THrB96kpo/Yg=;
 b=EkUG3ED0cmPLiaLtlQIHe+KuDeN/ghH+41SgNBNxSQfVWgs21v2LBS96MdU5OBHqksns8jVq0IrQPy7B9Ff9PznIitGdjZH9XajxnZjaB/G8ieBwDA4LyP2EXLI2uJyTGJnjbvzKeYc+7PFj35SZLLnStvIf6K0ONcsWFjvg78EaNkOUeyUg3vI2Ral1ef58eCdpuryaPfa4OHZwy0zllM0LE1IwlyB64x6CquvG2s8xRZ1lzE2xERYugSVW3GkJo13SyAyBzWZVTUggAyAmOVLHtBW2JKDIsDjIWJYTsqOWbxGlOtU2na+DvMs5aET6qqe803LmxDySk29lf0i+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWLetO0P33D0Gxys2gBwlG2SbDKf5Z+THrB96kpo/Yg=;
 b=fRvEvAS0fn3LB64b4L8Ba4Za6YBlg1PxuPJIWsxdK0svF0TrTqrkHGWmkJqUO6qGKShhyeC3qBrBt25csWIyV7/ugmeAu2a2J0sXIjclaeVhgvUOeBwwCkJYvV3zjvUszpT7gFVATny7aqxlTJtf1fWp3lg5BHzhzsWiJnXa25o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 14:24:15 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 14:24:13 +0000
Message-ID: <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
Date: Mon, 26 Aug 2024 09:24:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: noodles@fb.com, x86@kernel.org, lijiang@redhat.com, dyoung@redhat.com,
 kexec@lists.infradead.org
References: <20240826024457.22423-1-bhe@redhat.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system
 when CONFIG_IMA_KEXEC=y
In-Reply-To: <20240826024457.22423-1-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0139.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::25) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad0224a-270a-43c1-fedc-08dcc5dac213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWE1T2hGTUhsQ0xzRmlRU1J0dytQVWdmaFh2dzhFblMwWnhLYTUvVlZjY0oz?=
 =?utf-8?B?ZEFPeE50Y0JvM1l1dyt3UEVaTHlteXJoU1ozeXgrTjROdW9yeUFPSVcwVDdW?=
 =?utf-8?B?NVJ3NEZZT1lCcVdZaHpmaDNmWk9tU0YrSHVGQzBFblB2TDdmeWM4bzFBbFRY?=
 =?utf-8?B?V1dSYkdIQXY3K2xQSHNJZ09DTkREc2o5TmNZTWZobzJJZXVpOWR4cHRhd0dZ?=
 =?utf-8?B?TFJMbU9zVzIrbEorcTZqS0NOUjZvdUNleDFLdVR3TGxNRzgzbTNxcmIwdlN4?=
 =?utf-8?B?RUxtcjJ3RUNFSHh2Nk9DaDUrSVZpbHRRNEZuWVJlV1ZhNjdaSm5uWm56MXBm?=
 =?utf-8?B?dTg2OTd4NEpJYVhIR1JQTmNrWFVuS2dWTjlYSm55SXRubVAxZHlxRDVRN2lR?=
 =?utf-8?B?ejhiWkdrVWdNY1JQMHZpZ0padmNzUXpIUWpjSDZBT2Fxb01aN3ZEOFBtM1B5?=
 =?utf-8?B?TDBIUHlaa1Z6YVlxMzk2N2U0dng0UWVXM2YrWkpFakk2RFBnY1RydkVSVitz?=
 =?utf-8?B?aWE4cnV6WFNrQ3p2bWV0N2NWd1dmM1BtbGE1Snp2MjEzS0ZKdk9uZTk2N0Z1?=
 =?utf-8?B?anJsT0l1ZFYvNU9nU3dqYnpWZGhVVUlMenRuZmUzUmlTSnB5elE5ZlBoVkw0?=
 =?utf-8?B?bzJwcW1rU0llbmt2cGd1YVA1RThYcVdFaUpBTnFScXNCaHFpR2VnWGVFelBP?=
 =?utf-8?B?Kzk5dVFJRUxpajdaUW1tbnpNRHB4Q2FveDg4YS8xcHV3aUQzdTVSb3VtelNQ?=
 =?utf-8?B?RDN4Z0JsMEhPU05INFpGeDA1d0docW53R1hEWFhXODdpMHJNUGk0KzdsVmhU?=
 =?utf-8?B?ako3eWdKUzJiMzRxL25xYnE4RFkza25WUkF1U1YyUXMvM0pqaUxnWHV1b2Za?=
 =?utf-8?B?WXhDNmc3VndHdlJ4dnRmRFU2bmNadWNGS2hIL25TUm45Qk9Jc2ZpZUdvaTNH?=
 =?utf-8?B?RjJvWUdNNEdQK3A4bU1iQ2RPc25VbUpxcDlmSTBSNmQzNzhjSEtuaVVtekM4?=
 =?utf-8?B?V25IcE1GellOUW1ncWZ0cTdNci9kRm5lT24raGE0WXg5ZlZjSE55YytPdkJw?=
 =?utf-8?B?akJuL1VwNkQxNnZTYUY3MVFCOXhldkE3SnI5ZnpvTWVhdUtYUHJzUWhRejRs?=
 =?utf-8?B?TlJVdVF3QXpqTWduRVlldjRwZEtyY2N1VmkzMFEzYXRnOWl4V0NmWkVJdFp0?=
 =?utf-8?B?cmhoNmFlbWVFWllhUXdZK2VpbmloTytleHo2SjJUK0RNU3QwOGR5YVN5RXJS?=
 =?utf-8?B?bzlUNExZOFBSRkY1b091U2M2ci9hYVNHSElabGFtOTRVZVl4QjRrbXRIWFlZ?=
 =?utf-8?B?QVFaaHBIcE1tbVBIYW1DRG9Eczg4bnpwRHdKL0Q1cWtBMmhURVJUNURva3p2?=
 =?utf-8?B?TXMyRjdJNjh1bHA2V0ZUN1FES1JhbmNNTjh3djR2ck85dWZwQWh3cXRiS1M0?=
 =?utf-8?B?dkU4RW1WdjFlMlMrN0x3dThOeXlXSGUzVTFxaVplL0xPZVN1a1BDT1Y4dVFy?=
 =?utf-8?B?VGRTT2JpblRWV29qd3lWY0FBVGpBVHA0OHhMdW95TmkvUXk5eTFodXAyZldi?=
 =?utf-8?B?VU1abTlKbUdLRG9hcXZoM3MzUXJkTUlBanUwN0lDUVhaekFoVnpBcEtYektO?=
 =?utf-8?B?bDBtenRxLzRpenh0ZDdKZ0U4aEgvWEs1bTNsRUZ2d1NLb2pOYUNCNXMxWTZj?=
 =?utf-8?B?UDc3R0FRcmNXeFBxUm1ES1dqeW5lS0NpQTRQRWdZVVRzWjU4VmQ3YkR3VG15?=
 =?utf-8?B?WDhmM0U4WWRUV1FmYkhZRy80anNKTTdLdUdCdWZTU2x2RU0zVXQwVTlQRGs5?=
 =?utf-8?B?YUdabnlZamNZdldqcmp2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckkvY3RpTk5VY2V3cGJQZlVSdzB4TXVkbjhDMlFucis5RHFhWjBPdWVyZjJX?=
 =?utf-8?B?RW5YYjRsYktUT0RkUWNSMUVXelhtekVGMm8wQitIelc1NndEOTRrQTRBWExq?=
 =?utf-8?B?SDFpaStZZVJoWkJ5a2F1NTZzYk5mU09zeFFrWFJWbjgrOStkWTJUZTUvSUE3?=
 =?utf-8?B?TDVETWgxQnpYcEt3Y2tMNGZKdnIvTUxTT1pWYmZKK3NzRlpnd3NHSHoraTBw?=
 =?utf-8?B?OXcxdWZmeEc1NkltWjQ4WUU4ZG1nMTR0TzVVMmVjb1pBMFphc0dlcmFxRkJi?=
 =?utf-8?B?b09NVHFuc2k0dURITUkya0hQektPRkVEcWhmZHlvTmEvTVRZVXRMd2RkR2lR?=
 =?utf-8?B?S3o5bE1nTkprSURXbGFWMkt0bXA1QVlVbXF5MWY1OWhBSGRWQVo3T1FuT0Ny?=
 =?utf-8?B?ZVpmVENqZm1oY3gwTnJpU2tqcjNLRHZMTmtVL0tvSjZXNy80WG9TcUVCaXVm?=
 =?utf-8?B?Tlo3djZNZzdNSUFWS1BzeHRJRUhWbU9rUlJxMWxnaUxKdVJOZkVicTlMZ0x1?=
 =?utf-8?B?QTl0QUI5TkNCNzV6QzduRmJxcE82Tk1OeUpMcmxMa1FsMmhZWDEvSFplWVNt?=
 =?utf-8?B?SW1jOXhzQjBsQmFuQWdUaDlQN2FpTnVrL2ZSVVd3L0F4NUU2cFlFa2ovSFZH?=
 =?utf-8?B?Q1RIa0RyWDFjVUJLMWhiVDZtSFdiZDEvcE80M1kyaVBKOEhIZVdBRkNqcWJn?=
 =?utf-8?B?SUhPWlM3VVgwbG1Bd0MrZU42OVNCT09mY3puUmJTM3RyUm5DZVV5MVVvSzZY?=
 =?utf-8?B?d0VlOU5iSTU4Y0l5azNpbGFJSW1LaGs2VXJIbWJ0QTZEajlRS1Q3Rk5uUnlT?=
 =?utf-8?B?cDRadGNxOC9BRVF1NUJxakpQM3FVbkZTSGNsck9LYUxDREJ6LzNQY3JiMXlp?=
 =?utf-8?B?dzdCVWkwU3NIVm1Rb3B3dDliMjdDL3NVSm1IUVVoYzNmUTdITVVydzRZREdz?=
 =?utf-8?B?elJvZjU0NmxWRFM4SHBUV3dtZjhjYnlRNkVnemMybjN6b1ZLN1NNM3FLNWF4?=
 =?utf-8?B?aDZTQ0diblYxRGkydTRyNHFKY2RIUDFzVEoyeUtZUmxCc0FRWUhxTk1Zdzg1?=
 =?utf-8?B?Sko4TGE3OTUweEZ5Y2c1U0MrblZodHBIYURRTTUrSEpNb3RmOWh5eHA4RFA5?=
 =?utf-8?B?c0Z1Q3ZOWk8yNUlrdkEvMFFwUk85eVlOZDJMMTNKOURPM1p0SUtoamFyT3hJ?=
 =?utf-8?B?U0VnRjdGNVE2ODkyWUFxM1p6c2oxd0kvQmhtdy9SWjE3UjErMGFEY1luRGVF?=
 =?utf-8?B?czdpNnhIYVU4Ti9OSEdaaExPaXV0UFU1WDZ2aEVwZVFUVFdMaE5rQXJlQnZa?=
 =?utf-8?B?dUFGVFcvdGpFckgwSzYzNStxUVd4anZySGRlZjRBWDhaVThTKzhaQ3JHUnBh?=
 =?utf-8?B?NEZPbDhGaGFjUkpsTFY0ZHUzNXZ3cENGSVh6c1AzdXN5WVFTWmpDMk9GTXhv?=
 =?utf-8?B?YVVuT1hyVmxBZm1Hc0QxQ2RIN250N09QSHpvS3JNWGs5Sys0Z0IrVTRLN1A1?=
 =?utf-8?B?SjF3eHdTK2tkZUxWV0FRVkZ4bnFDUFRiSlJPTzVEUGhPcCtjZlFBT3RsNlB5?=
 =?utf-8?B?WFptZkQzZ1hYV2NIaUt0QThRNmwxbGJPUVdnY1ltSkxYVDhaQlJmRm5hMVZU?=
 =?utf-8?B?YlhmRVFib1ZiU2N1MWR2YVVUbjJwQ3BuMVRsUXZDTW5LS3g4b1ZicllPc2Vk?=
 =?utf-8?B?bEt5dS81cE1wSGxKL3pQZjRQdE5KQUpBYmw4dFNVZUFiM3BGTWw5VHZzQVFm?=
 =?utf-8?B?c1FZdGhDTnVuRndIQzI3MVp2alBKcFp6cmJBRTVmaC92Sy9uWDBVVkYwL0RH?=
 =?utf-8?B?LzlBaFJYOEFROXp3Z09LbjJRVEgvNUd1YnQrZ3cvUFBCNllVRXZFbDlXNDNL?=
 =?utf-8?B?NzRsMW9oKzdNb3l4VjR6NkVwOG5Cc3NHaWxLWk9KdGI0R01nN3ZnR001V2Nv?=
 =?utf-8?B?bUVwUXZocjMxU3NjdVdCSDZNK0pSaER1SExVY0Mza3Q2N2VpSGVRSnBkMWJ1?=
 =?utf-8?B?eDFubklLejdwa0FzekZBano1UVNIYW5HM1BMKzlNZklyWnpKWGowR3hoZTJz?=
 =?utf-8?B?WnkzV0I1dzlTRXlYd3pLYkh5OTdDWllRbDVTV21KYWVLUlBwYWpRdUVQWS9H?=
 =?utf-8?Q?iybwygIe+9o5HU+hqC6kodK3Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad0224a-270a-43c1-fedc-08dcc5dac213
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 14:24:13.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpWdHoOa1Rm6NjqsCOYlFlv0rROvKmNYubEjUq3Es8QUX3DvQwQjkZ3Ib7FxMdXGZiQfi1YQz8x/79bYyRtu5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923

On 8/25/24 21:44, Baoquan He wrote:
> Recently, it's reported that kdump kernel is broken during bootup on
> SME system when CONFIG_IMA_KEXEC=y. When debugging, I noticed this
> can be traced back to commit ("b69a2afd5afc x86/kexec: Carry forward
> IMA measurement log on kexec"). Just nobody ever tested it on SME
> system when enabling CONFIG_IMA_KEXEC.
> 
> --------------------------------------------------
>  ima: No TPM chip found, activating TPM-bypass!
>  Loading compiled-in module X.509 certificates
>  Loaded X.509 cert 'Build time autogenerated kernel key: 18ae0bc7e79b64700122bb1d6a904b070fef2656'
>  ima: Allocated hash algorithm: sha256
>  Oops: general protection fault, probably for non-canonical address 0xcfacfdfe6660003e: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc2+ #14
>  Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.20.0 05/03/2023
>  RIP: 0010:ima_restore_measurement_list+0xdc/0x420
>  Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
>  RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
>  RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
>  RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
>  RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
>  R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
>  R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
>  FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
>  Call Trace:
>   <TASK>
>   ? show_trace_log_lvl+0x1b0/0x2f0
>   ? show_trace_log_lvl+0x1b0/0x2f0
>   ? ima_load_kexec_buffer+0x6e/0xf0
>   ? __die_body.cold+0x8/0x12
>   ? die_addr+0x3c/0x60
>   ? exc_general_protection+0x178/0x410
>   ? asm_exc_general_protection+0x26/0x30
>   ? ima_restore_measurement_list+0xdc/0x420
>   ? vprintk_emit+0x1f0/0x270
>   ? ima_load_kexec_buffer+0x6e/0xf0
>   ima_load_kexec_buffer+0x6e/0xf0
>   ima_init+0x52/0xb0
>   ? __pfx_init_ima+0x10/0x10
>   init_ima+0x26/0xc0
>   ? __pfx_init_ima+0x10/0x10
>   do_one_initcall+0x5b/0x300
>   do_initcalls+0xdf/0x100
>   ? __pfx_kernel_init+0x10/0x10
>   kernel_init_freeable+0x147/0x1a0
>   kernel_init+0x1a/0x140
>   ret_from_fork+0x34/0x50
>   ? __pfx_kernel_init+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Modules linked in:
>  ---[ end trace 0000000000000000 ]---
>  RIP: 0010:ima_restore_measurement_list+0xdc/0x420
>  Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
>  RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
>  RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
>  RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
>  RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
>  R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
>  R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
>  FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
>  Kernel panic - not syncing: Fatal exception
>  Kernel Offset: disabled
>  Rebooting in 10 seconds..
> 
> From debugging printing, the stored addr and size of ima_kexec buffer
> are not decrypted correctly like:
>  ------
>  ima: ima_load_kexec_buffer, buffer:0xcfacfdfe6660003e, size:0xe48066052d5df359
>  ------
> 
> There are three pieces of setup_data info passed to kexec/kdump kernel:
> SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED. However, among them, only
> ima_kexec buffer suffered from the incorrect decryption. After
> debugging, it's because of the code bug in early_memremap_is_setup_data()
> where checking the embedded content inside setup_data takes wrong range
> calculation.
> 
> The length of efi data, rng_seed and ima_kexec are 0x70, 0x20, 0x10,
> and the length of setup_data is 0x10. When checking if data is inside
> the embedded conent of setup_data, the starting address of efi data and
> rng_seed happened to land in the wrong calculated range. While the
> ima_kexec's starting address unluckily doesn't pass the checking, then
> error occurred.
> 
> Here fix the code bug to make kexec/kdump kernel boot up successfully.
> 
> Fixes: 8f716c9b5feb ("x86/mm: Add support to access boot related data in the clear")

The check that was modified was added by:
	b3c72fc9a78e ("x86/boot: Introduce setup_indirect")

The SETUP_INDIRECT patches seem to be the issue here.

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/ioremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index aa7d279321ea..7953c4a1d28d 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -717,7 +717,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>  		paddr_next = data->next;
>  		len = data->len;
>  
> -		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> +		if ((phys_addr > paddr) && (phys_addr < (paddr + size + len))) {

I don't think this is correct. You are adding the requested size to the
length of the setup data element. The length is the true length of the
setup data and should not be increased.

It looks like there were some major changes to this function to support
SETUP_INDIRECT. Is the IMA log setup data marked SETUP_INDIRECT?

It might be helpful to instrument the code to see exactly what is
happening during the execution of that function for the IMA log address.

Thanks,
Tom

>  			early_memunmap(data, sizeof(*data));
>  			return true;
>  		}


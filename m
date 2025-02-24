Return-Path: <linux-kernel+bounces-530045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C14CA42E16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88428189D15B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E070D25B680;
	Mon, 24 Feb 2025 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LqxwaZma"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020123.outbound.protection.outlook.com [52.101.191.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7F264A8C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429568; cv=fail; b=QsQP5Y/YoXit1/tiFAKJnU3T9UIrLTQIKkI0AbrIxMEE3QIv5/xLMlSguPj1DuSrKQuicu12zysyws9X81qh/1S8INwUVHSrNVPvG9STKj/PdBlbCGRtsYYRHiqIrx3SV7hNCLDBhxxRBMXA6GThtdWDMcaoS/ShXqR/dqG7HmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429568; c=relaxed/simple;
	bh=ew91dOw3/F4x7a0b5WNltv3iFtvo5lMXxJgGVEZt6h8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QqUukmDv0rd+Dq3MuIFQfMh97+4KsdnrVOjwnra72IRHXO6rlUrUXeKtp5xWQJw4iBF9zVNW/UplbX25Jl8DQCHP3rWcos40De282SPp6mbTgYUaHf+laoIasbEJgdD08/WN/6EwRg2tT5m08zu7vJmMFPelBogoBPqQtOcbB+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LqxwaZma; arc=fail smtp.client-ip=52.101.191.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOGvaRdVEomCa1BeNUWsIn1J02w2060g7o3mJcWe/e0BDcSf0WdUKPIFIfMZKJyxYz+PUAiPtMoxxqs80sWvHkPOZC1TmPKdYaiFTBHQEOg/YgTNgeFAb1siwJeVXqNS9v3fTXimvj0vR9dPAWl1wIagRiAqJE/+96btcgp/3qm1gj95SLoY5yL3ZIXtQdbXDY8HMPOhe9R7IcTfkBbMmGaJb1B28h7lOrPUecKxQogxLXSJDtiuT3yZ8no9QJCgDY2oOLpcQmvWYzkriqgc9da1rwT4uMLNiIDrI7SDkATYWGvjHm77FFFru+fPRzINddfApsfUeiCPJHJO110WDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuBnMWBuWodES9EhntUCVA2FxVctFMXcdMlNGd438U8=;
 b=iPGP7zltYzjmh57wWecBMg715fjWYhFgd1uN+KNRhFEoHHl40KPxCSYJJCLI09QQMbRhGIQ8pKoSBuBHuXfhGLNl/LgrIOVUtLvBWodo97siEz53jkAr900tOXiYXQmbQYlCxoRPOSS0O9mK1v7FsLQqlkaKA+SyEgZ1swFhP/yTg/DYAF8l4LP1cLuQ2rPRWPGdym1gVtE0l2pI1szG1P8Hax9O25Zh1NZduuhVjd9WW1doRLNRKtwKzFMN1ZbWI/jtdj3M/vNuN3IJ/ERgO55ed/7ZqfeKApST6mD8u8Um9oQI8kubuWKzgl5Wm/ZJRu4DajIDxh5Kl0SMYYug5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuBnMWBuWodES9EhntUCVA2FxVctFMXcdMlNGd438U8=;
 b=LqxwaZmaee558TAre+UBwu7TAyf53GH7YWOphJEAevpaHuGja8m+uS5SMA1nQiov45Ua5ecJBkv0zEqEBdtwfI+6A2x1bcsihjo6zzqBlRZ8eS1E3QjP/7AlUvvk9y/BCCDFF6biudXnhbuDPVopW17Ez+yhNiTpTlU1qgTI47h/kHHQTwctXFES7Ypd6P8jLgFcHQJh4ak6KZl5one70AXncsWn/71RIKmZ5jRiTx98oySNrSrE4Ock+9IJZX10cWrFGlSQN05+oaNVjRm5hvMm5f6zD0BFReY8SO+4M+Q9gNSLLsuLzkXvf6Ut9579T4t4upA5HVrmCiFOLwFaIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5468.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 20:39:24 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:39:24 +0000
Message-ID: <08b48d52-fb1e-4d8f-8586-06280a798331@efficios.com>
Date: Mon, 24 Feb 2025 15:39:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] sched: Add prev_sum_exec_runtime support for RT,
 DL and SCX classes
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20250224132836.383041-1-gmonaco@redhat.com>
 <20250224132836.383041-2-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250224132836.383041-2-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0259.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c0cf82-a77e-416b-5702-08dd551352e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0hrakkvbHZ5QTdxRjlLK3lBL3djNVY4Z2lDRUxBcVhwaFc5NHFOQzNBVHhJ?=
 =?utf-8?B?Y2I4T0RYR1kzWm56OWZ3NFBseDJpd0FiQzVJbnBCVmpxbzRRM0lOQXFZOEM0?=
 =?utf-8?B?QTZDa3kxZ3lydHpVQWRuQTdNMXBVRFNnMXVUN3Qza2pZVytyOUxONGNRaWNB?=
 =?utf-8?B?MStoN1h5SHRtVjJsU3gzeWh1cGtxK1FTOTAyRkU0R2lYQ1ovaDB3cGU1VS8w?=
 =?utf-8?B?OHlCZzR1L1VjZEhjT09US2pIbzhNNXlsemdKUTJsdStOM2RNQWZwSzVFdlJj?=
 =?utf-8?B?alcxYjNLT1FsOXpvOStnempybFhPNjhSVXJQNzYwRS80YUhpOG9qTmNYRDlI?=
 =?utf-8?B?WlB0Y1ZGMkRIOEpmVjZJMW1hYXNocnJIeHRERVQ5dSs3M082R0p3RGlqWkor?=
 =?utf-8?B?WjBpYzFqNEVZK21HK0hPYjNFQUZTZTc0WEJSZlBYMVM5K3dWUHU5eGpobmRS?=
 =?utf-8?B?TmZlajdYdjFYZS9Yd3lvWEorVWNQOVpBMERHQmxPV0J2cHRienVmQXZIcnla?=
 =?utf-8?B?RUd0OFBPdzk4N1h2RVU5L2ttOVdrYkRwUXhwdG1rWXdycGdKdGJrVzBoZlUy?=
 =?utf-8?B?T2FEbDIvK091UGRERDlVUVFmUTA2elM2MzZZQ2U5aWgzQWVLZ1ExeERSRmJR?=
 =?utf-8?B?SGVRaXBTYVNoMTF2MXJzWWJ2TmFPQ2o4SjZaSlVrTjhvZko1VTAxc1RLMmQ2?=
 =?utf-8?B?ZHFvSVdTOENoemc0YWxsdjdmUGx5bkR3d3lUMEdrQXNudlR2Z2wzRjMzZWZ2?=
 =?utf-8?B?WWRRTHRueHY3elFXelpvNDBNZXVJSFkxWEZNakJSMFZhVzE0QUQwb1hmN2s3?=
 =?utf-8?B?UHJNOGprU3g2dXU4elQvazJaU2JQbERxZmJFdEF5dUM2UTNFVDNtYTI2QzV0?=
 =?utf-8?B?cE1EdUhNTWtyMEo3bm16T1pEa0F2aDRld1lNN05JbWh5YUZKQTFBS1ZvMzJv?=
 =?utf-8?B?MllSbS9oeldZR1d6aU5aUkRra1B0YXFmZ2lNQjBpTHMyeXU2eUZpcEhmZkVK?=
 =?utf-8?B?VlFLSFV2VW9zWG9aTjMvck5iN0Y4cmdOUk9XNlRHaTliT3orakNaVlRGdWFt?=
 =?utf-8?B?cjN4byt4aGRNVGhGQWY2Zm56NUlveGtBYmlpSHBYNnNYajFWVGhIQld2NUJv?=
 =?utf-8?B?cDR6WlFiUTBUcDN1OVlGM2FqcUFYZUk1NDlCNXVBcGRiQzVQL3hCSTIwSity?=
 =?utf-8?B?cktxQ2F2MWNVTFZDTWM4SmNmUHE4dXIvNkhKcGRIclF5R3hjaTVJK2FQRW1i?=
 =?utf-8?B?SlUzMWFua0xyTjdESWJEbkNKeUZyS2lNTU4zNWE5dmFHMCsvYm5nWUdVMEdC?=
 =?utf-8?B?MUorTXZ5blNOcEFNWThBYkZaVE5iYllCQWlVcEdpcHZ2dTE0UVZuZ1pMUFNG?=
 =?utf-8?B?ckdzT2YrOFZRcGNQVzVmZUdsWmlDUHVST2VoTWFNRDVJb09sY3UrenoxN2Zq?=
 =?utf-8?B?ckpkVG5tVmo2cXp6M1JqRTFLUHBaYkw1Zy9uem5YSjNrVUEwQWdiWVZWUG9l?=
 =?utf-8?B?QkprUEJmZlVnd2hBZC83K1hhT0dMM1FGTkIxYXNqdkxRdWpyemRIaTI2bEND?=
 =?utf-8?B?a3BHZ2FFL1BqTC9MVEFGTHd2S0NpSjQrOWhpMDhwU2xLdW82NWtlalNCTWhn?=
 =?utf-8?B?ZldML1ZYWVg0WGY1QzdGWUpHaWVUN05VRUUzWEd4VkdnRWRPSzlFb2h5NnRB?=
 =?utf-8?B?bUxuZ2tDRGVYbkxNbEczOGNKa3haVHNRcmV4MGhUMDVDeC84d0lKcEU0Y0FK?=
 =?utf-8?B?NjZPVkdtVkN5RGo4SGFWVC90YW9uMFRyNFMraXdNdWNuSk1hK3RNS05vMnEr?=
 =?utf-8?B?Ny9BWUFMaGd1Nk1BVnhLQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjlITHB1a0xicjJlY3k2a3puSDNTUVM5MWNRV1RZeFZtYUNuV0psZ2lIWDdK?=
 =?utf-8?B?WDc1VE1NMHVudnBvWFRXMFJtb3pyeUNKZkVvY2tVMjlKekEvdExHTlB4d3lM?=
 =?utf-8?B?Uy9BQVZabFFQaFNlR1ptVklhRFpKMmVlcVFocGhNUFBxV0Q2cGVMRE5rVkR1?=
 =?utf-8?B?V2UvQ1oyTlJKYkFiVW8wRXR6UWwrb3FvdmJSNEVJakxtZnhDUWhQbGNGZ3lT?=
 =?utf-8?B?Y1RNRnhEVnRmWG5oTlp5dldLQW9yQmllVDlzU3pOeGpFb1pWbEtMMUlPaks3?=
 =?utf-8?B?VlVFZ2lhNlFnMFd4ZlBiZ3hldkNaQkNOMzRTRXF4VDBqY0I1ZkhrUFNLSk5t?=
 =?utf-8?B?NTg5ajAwaGdlTTA4K3BFcDdmRmFuV0Y2Q2NQL3JqSGNlK2NGS0RxdGpmeEw3?=
 =?utf-8?B?cUJ0RTRKNUMwbHd6YUFvcU15b0JoU29Idkl2MGNIb0dVWVllSkpHQjZRT0Fw?=
 =?utf-8?B?UmRlVEE0UmwzdE41MHlSSSs4REptWXRZS2dtblIyazlaMnQ5S0NqbUl4d0Ev?=
 =?utf-8?B?dkNYNkhmOXBzeEZ1RlJMSHUzYXJDT1RDbFZ0dmI2SXkrYTlXRjl0YTdLaWIx?=
 =?utf-8?B?c0NtUDZRU3ZpcTE3dGNtQ0ltQnZvUVgyN0NyQzJpUkxLSnIrOVhSZko5eTlw?=
 =?utf-8?B?bWJDR0c3WHFuVEwwdzJ3b3RBdHJsazNMcUkyYTBFeThQQzdlbEFGUTNsMFAz?=
 =?utf-8?B?eEhrNkQwOHI0bXEyUW5wV25YRVYyKzkvMGx5U0loTitEVGlUUVJmM05tck5q?=
 =?utf-8?B?bXB5cU02bHpsSlFJZ0kwTVg4N2Fkay9UYmtRZjdBL3dPblFWOEtYdDJrc25C?=
 =?utf-8?B?clZ6RTRCaGRuR2VBK2xaelVKaTRlTzNZR2QvS2swRU03T2sxeU5na1lJenBI?=
 =?utf-8?B?ekI2d21RN3ByQkJxdnpFdzRRQjhYS3lWRVRCNGNrWG02R1U3ZSszMVFzQjJJ?=
 =?utf-8?B?NUFPc2NFcm14Q3doS1lISlhvRGRIMEd4cFhMeEdVdWRxL1hOamhkY3IrNDY1?=
 =?utf-8?B?T1FEcGFUVVJaMVpKSDh3ZVFaK2lrQUltWkUvT2ZTdlY2a0pmcHR1aDV1UFIw?=
 =?utf-8?B?REE3QUZGOU5IekQyUkE1eTJ6RmF1N2lPWHVXN0NmdkR4VDk1Mk9hLy9jUmtG?=
 =?utf-8?B?YWFEWXkwUmQwazlvYTIvLzNhZXZGTnpQYjduU3RiUi9PTnZKR0xxeGxUbmN2?=
 =?utf-8?B?UUlTZzlLeC9iNHF1UHBER2t6WkFrQXFhb2JwSGd0MGFzdU9aS3lPa3BpVk9h?=
 =?utf-8?B?L0F0emg4dUlzOVN0bTd6eVgzRkhhd1dTdklwNVhpZVNZQ3p2TjdzYWFBaGVK?=
 =?utf-8?B?b3g2cS9rWitTMC9pV2pvT0hjNkRjVm04RmZMd0lkU3NXNjRMSzZIUExaem1n?=
 =?utf-8?B?L0tPMzlQcGpMZXFuMEp0VUh1ZHJvSzF2Zkc0WFg3cmVrNlo1VHlMelRldGE0?=
 =?utf-8?B?TjZtTEJ1d1BnVFY2d0ZyZm5TNEo3cG80L1ZCVTJma0JMczN2ei8rRTk3UHhi?=
 =?utf-8?B?MWRzWlRjYjYyV25JYzc5U0NhbUoyVEVlOGFpZkt3RWkrMjB4M0RPdlR2aTNz?=
 =?utf-8?B?aGFaZVozK003cFdoS0dOK2NrMEMrTWlkdlFiczVxWXBhdTNlaU1rRHFXdW0v?=
 =?utf-8?B?RllxaGlwVXI5RE1sZGZrRk91WWxYTDRZZnpBOG9JWHZUOFRLYlpIK1AxTTZ3?=
 =?utf-8?B?Zm40UVdveEZ5Z0JZUHQ1RCtITXhBMFdFbEpUTUNrSUJNZFEzRDFIcldhVHZT?=
 =?utf-8?B?QUxxUjQzSWdjUnA0OS96ZWJoZjRTa2FuTFpROWs1ZS82b2FUZnlsbXdJQWpR?=
 =?utf-8?B?V1Z2Mmh2REFZdXVyVUdJR1BERTFqaEkzUnpldFUvNWxCNWhHVngvbS8zVnJN?=
 =?utf-8?B?dWtFejJ6b1haMGRuNEdTRzlJZkZjdjh6WlVkdkRNZUpwakZDRkd6STF0MERp?=
 =?utf-8?B?ekpQb3M5VVZxMEJVT3hOMk5LY2o2V1gxNVRocldVYWRHOGFhOUt0a3REbkFp?=
 =?utf-8?B?Qnc2QmlnNENmMkVpM2RwV0VlRWdOUFk5cDVPVVdrdEFhTm9QWVlqQjBydzN4?=
 =?utf-8?B?Vkp3cndJUjJQazlBRHBNWjFmTEx3WUQzOEg0K2llUnV1ZFVEb3RuL0RKOUJB?=
 =?utf-8?B?YW9EU3l5RnVSaFR3M0h4TktKYkg5TVpqZURBL1pJUjVIUmwreU9nVTEyQU9P?=
 =?utf-8?Q?GwxCIqTND2dxBRAX3wCeJsc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c0cf82-a77e-416b-5702-08dd551352e9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:39:24.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgHPoJgS3XlhsGic+E7on2nY0FBz1j+6wpe5Un8ZfJ/Nv/o5ITC+5LDHP+XYsrUSH2xtOweD394Lw2QqJaOS/eKQYyZ6lFgr2gIn4/rgYvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5468

On 2025-02-24 08:28, Gabriele Monaco wrote:
> The fair scheduling class relies on prev_sum_exec_runtime to compute the
> duration of the task's runtime since it was last scheduled. This value
> is currently not required by other scheduling classes but can be useful
> to understand long running tasks and take certain actions (e.g. during a
> scheduler tick).
> 
> Add support for prev_sum_exec_runtime to the RT, deadline and sched_ext
> classes by simply assigning the sum_exec_runtime at each set_next_task.
> 
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   kernel/sched/deadline.c | 1 +
>   kernel/sched/ext.c      | 1 +
>   kernel/sched/rt.c       | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 38e4537790af7..438b3a953d6c7 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2391,6 +2391,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
>   	p->se.exec_start = rq_clock_task(rq);
>   	if (on_dl_rq(&p->dl))
>   		update_stats_wait_end_dl(dl_rq, dl_se);
> +	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
>   
>   	/* You can't push away the running task */
>   	dequeue_pushable_dl_task(rq, p);
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5a81d9a1e31f2..feaed0459eb92 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2974,6 +2974,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
>   	}
>   
>   	p->se.exec_start = rq_clock_task(rq);
> +	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
>   
>   	/* see dequeue_task_scx() on why we skip when !QUEUED */
>   	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4b8e33c615b12..1ea272e4dae71 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1684,6 +1684,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
>   	p->se.exec_start = rq_clock_task(rq);
>   	if (on_rt_rq(&p->rt))
>   		update_stats_wait_end_rt(rt_rq, rt_se);
> +	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
>   
>   	/* The running task is never eligible for pushing */
>   	dequeue_pushable_task(rq, p);


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


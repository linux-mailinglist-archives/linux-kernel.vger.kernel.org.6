Return-Path: <linux-kernel+bounces-565541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF53BA66A56
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4795A177162
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7765E1B85D1;
	Tue, 18 Mar 2025 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rpjoCHzZ"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011030.outbound.protection.outlook.com [52.103.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1492B42A83
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278867; cv=fail; b=cwmNvkQnhT7Cd5+aF2zP1ipoh9CBG9vwtEofqiEckUcrzmnOOEXxt5FhPXw1Aon0rLI4AOu/1JE/9X0biwW/eqpMISQoywMy+FXt8Ovh0kVARo5lsyPh/NVdXqjIoFcezxZIo0DefMPjbnXvZgds2SknGxH73gl8Pi+CZEOSIQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278867; c=relaxed/simple;
	bh=ZCpgUqFOj1uIxxpc3D/qFKnCUOfkX02Svr33KST7xp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tVar/HLi6m7GvCvWZMjwsLTH0Y2ODZ8p+9hTymTDdIHCyyc342bPwA9jDMosUsb3+FZU4AaVLdyQn0auuZBwA9TupLHSKBDahFeA77HsYpKK4hskNxdm8Va5DwOJr1+hnjnD8se7/4RxrgcEPdVrFfG51IPjsL2lBMFbxnXo4Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rpjoCHzZ; arc=fail smtp.client-ip=52.103.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AF259S0e6L2omsGHkcmS5E4hGcFY4DwUTd+OCUEwZKk9qVQKAJfbiezLmz4yNWfl1W51rlO6yOe4kzOi//wU9ZMJX1ZrZqo+373lvfPt6Pc/9t+9dt2ap95XrL/DZ3rCkRGB4BkuOwljcs/Ep3EndnLcMEUtWUm+t11cxJpWc6JF+IxGaO9mA4e2LIlaRJDijIJ+4gsW4xZdGj/1LMELy0efQ+aa4ZOB+aay3DpgcjFaRpH/CoKz/TSuZdjl8IGeCoaK68Cxfw8kmhAGPTxdKsFnGSR6Vt3cLbrLIKDq743tdtIlwybipOYcK/OSHjHc/g0/7VvEIvTgS8kKCi2MPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50/YX89ovKaGnHP0nKC5MmIqd/3CjUYaAHM2MzLi23c=;
 b=LHNmjBcAqU+zcRS6lAaHY1pPVWL2e0WffB28IBo5acyi00eFpTyHUv2P1gs5PC/ZmFrsZhk1CRgdRqHa+ja5LMiajKGbUCHZw7i9bQbpnMgGnmNCZMxJ82XTv9HGE0CIHBVpB5bONUsDGDN5uXFy61ivdc5JVAF0puOyeTveFHhP0Ct2F0IRr0t0TZTQODRN3kQd4mEAMUuzr3y4HcrSbrRb6uf3NaMNC0K/dHDhCfBqFOxhZHrTl/DU555K76cXEayh9xPhSP+SsRX2aKgar630lzceRfF3sA18NRPGY53lZC9wblT18jky/gyXHL8Q65GypgFAO2doG9iZOrbSxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50/YX89ovKaGnHP0nKC5MmIqd/3CjUYaAHM2MzLi23c=;
 b=rpjoCHzZOmn/vdmSUzbwflHXDAlzqln1rmDz0Mmhgkh2f4uMkjNeoHwGG5DfGbUYrZuOqFMadPf5RXkKzqAI3x39ke7CCaW1xJwWOc3ewJwB16QK3t0vZd7PLsZc2LeZG0YunHVVWBhmpay0xLcQ83pCshGORITNO7CHgM2UOEXO6EP6bJX2nWcm0Uvj75Ig5doaHdGZ8u/KzwbGdaU4QoY7o2NrelxwbpNAwWtFC91Dppm+f17OC/4BfMth7OHDFuPFh1vY9hdRcZjjKALSHxr/JIOJ0FafmBK/loa2noT6VakllmDj3L7JPdCQGHq3CtZnxCVcEvtJFFz709ioMg==
Received: from TY1PR01MB1708.jpnprd01.prod.outlook.com (2603:1096:403:5::18)
 by OS0PR01MB5825.jpnprd01.prod.outlook.com (2603:1096:604:bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 18 Mar
 2025 06:21:00 +0000
Received: from TY1PR01MB1708.jpnprd01.prod.outlook.com
 ([fe80::2f18:9f56:8f28:24be]) by TY1PR01MB1708.jpnprd01.prod.outlook.com
 ([fe80::2f18:9f56:8f28:24be%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 06:21:00 +0000
Message-ID:
 <TY1PR01MB1708354E1C2886F0E7989B5DCFDE2@TY1PR01MB1708.jpnprd01.prod.outlook.com>
Date: Tue, 18 Mar 2025 14:20:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 3/3] samples: add hung_task detector semaphore
 blocking sample
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org,
 mingo@redhat.com, longman@redhat.com, anna.schumaker@oracle.com,
 boqun.feng@gmail.com, joel.granados@kernel.org, kent.overstreet@linux.dev,
 leonylgao@tencent.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 senozhatsky@chromium.org, tfiga@chromium.org
References: <20250314144300.32542-1-ioworker0@gmail.com>
 <20250314144300.32542-4-ioworker0@gmail.com>
 <20250318103615.bce4a3291786c2bd525f0f02@kernel.org>
Content-Language: en-US
From: Amaindex <amaindex@outlook.com>
In-Reply-To: <20250318103615.bce4a3291786c2bd525f0f02@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0102.apcprd02.prod.outlook.com
 (2603:1096:4:92::18) To TY1PR01MB1708.jpnprd01.prod.outlook.com
 (2603:1096:403:5::18)
X-Microsoft-Original-Message-ID:
 <1358e0c4-2234-467f-a96f-9b315e107790@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PR01MB1708:EE_|OS0PR01MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df51dd6-61f9-4202-c83b-08dd65e50d3c
X-MS-Exchange-SLBlob-MailProps:
	EgT5Wr3QDKyfA/kqhNtxhLoDzMvzACCowRiyIl0/6WMtEefYHPobUsret4Pme+5vC3PVA4UXmPVoTK52MxNCeyMgLEOa++NHxvRwjvFLVM/e6OLOe3Ax5UjPIUsDH8d99S8BUscVQrKhtC1ViWiLuM1UorakixF8b9j0Ho9PThyoY2lTLiQy3B3XyIBcM62Xvzzk9r8UjS+Nx0O5Omb1R5HWl0C4ZLSFDalcX4joHH7v80QQwPbzn4V8migcGiY6+u1m+BLEZC+HJ6ylqcBsvT4m1qYJIepHJ4RkJPqDyOXQpmEf5gSjfUOlYEGStqC54rIAPqY5jWR7Qof1hEu/DLPNuA97+lyIWjireAmCKzsUunaiTzbwAE/NwsKYBML9cLdQQCVTdSVqefVM9YY59eBqivihAtrriXZrtaBDXI/QUG+hMuxkCeOtanQp1Bc8eRLmKydtYt3bv9/u6eQILYMgbPpWgKlDjQ0l7DtiMI4rsiCHl2xFPpzQACCd8bQ1Ovg6+B25PDnSxoKqBbiifLIi0fTSTXysNUyMGUAQi3nSYw/3DQ71Ulh0dWaDxOiMtAKZclHMn2ro9+m5EHyfB9foFjvFIhD4fqU2H4FJgQilQAPcvLvuhmtjZG9meRtcBR/tzmaPYmpE5mO/7Ug+gQ/eWCIJCUN3RcByG6L44G4LE3OjLFK5Clvotq4O2jvKuF4tm0drVNR4cWQ/FF3JK5OCmU5UsRPpz+9X3GP6hFY=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|7092599003|461199028|5072599009|6090799003|19110799003|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVlvWS91d0Z1ekhxYXcrTk1lRFVDY3BpM0JPeHVuWFRVTTY1MEc4b3RvazdM?=
 =?utf-8?B?c1kwWFVyVHliNEIwRzl2R0xubzRZeXdzdnlxeGU4T1YwQUxPMlJhSHh6RThG?=
 =?utf-8?B?LytVWWEzbS8rVis2cThmOG1tR04yWWszMHlOZ2hkN3R2SG1od0h4K1g3anZn?=
 =?utf-8?B?NGRrWlBvenlwWTNKVTdOTUJJZWZmMnQ5L0tnMGw1VUtncktXTnBzQ2daVVdH?=
 =?utf-8?B?T1lzU2N0dzZRNWxyWDJwL3BHSm9lU1dPK2RzdEU1a1ZDYU5BVEYrN2tqdnhE?=
 =?utf-8?B?RktrenZTdjZBZXdXTm9RNitGdHlWNVNFMWsvampyY3Nqc2RsU214WXFuZHRk?=
 =?utf-8?B?dXVjZGVqTldSYzNHVnZVNjVFdDJIYmVpM2FuK2dKUS9wT1VKaVplMHpPUnBr?=
 =?utf-8?B?N2tHSWNteVhxRjlTTVVMTDhTMW5ESzRYYWZwdUNlMGQ0cG56Q0x3YUlDaGdZ?=
 =?utf-8?B?WDFDaEUyMDJzVUdTeWFBRUhYREtPUXFwNlFWOEw0eWlRSTRqcDBhUDk4aTBu?=
 =?utf-8?B?TjE0Z2tXTDkwdmpOSjFCRitPOEFBVVVXQVh6ZlBnSUl2WU9OcVhpUm9tTytp?=
 =?utf-8?B?aWhvSW9LY0ZJK2VNc2VrWU96eDhJdmp5NG5aZmpDQ0xzVmIzQ2FPVGM4R2lm?=
 =?utf-8?B?cCs5Ymcxck1DbnVRbDRRUjQyaTVRd0FmV1EvakE1WlF6cGpHMkhFbWRxMXpU?=
 =?utf-8?B?WE41S1NSdnlsTENXbVJnVTRldVRqL3ZCR0Rmd3pSakgrd2FoNkZlcGYzZFdO?=
 =?utf-8?B?NkgrU3NoV3VxZ3VOcE5EeG5Zd2UvT2lhK1dsbHZHYSs0Y1lha3pkb25xSE02?=
 =?utf-8?B?bnRRYk00TFMwTVF4dUYwazlCSys1R1NpOWNhNXcraVFTenRXZVFOT1lZb1BP?=
 =?utf-8?B?QTk4Q0xoVmxiejA1R0E1Vld2VVNzSGs2YmgxenhPektRR2xOaFYzbDk0eGNB?=
 =?utf-8?B?TndKUnRBRnlKZlE3M0JnRTV3NGx1TXFrYmlQOHRDRmNCVEhpMUlwZkMzMC8z?=
 =?utf-8?B?aXd3ODBMVnF5YlF4RTZwWE5yZ1NYeHFPK29WSi9FMkh1ZEpRaXJGYmZHMG1I?=
 =?utf-8?B?d21iMmg0c2MyMlIrS3o3OGxQVWF2dDVRTGI1Tng1N0VCb0hOZWhwcXpjNy9M?=
 =?utf-8?B?cU84WHBlYU5JeGdYZEdxcGdLci9ja0JPK1dmUXp1UlVza2NUWTgralNXMi9Z?=
 =?utf-8?B?QUJyVXJNWUxHY290c3NNdHFGT0ZMV2VnbjB4b1dxcEtLakdwTm5UUnlxYzNN?=
 =?utf-8?B?NE9RS3g2M1BlYmlRdjVEeVRlOW9pcE9iRG1FaEZLSVY2UnlhZFRqaDNTdUpB?=
 =?utf-8?B?Mm5abUFkK200SmpuNXRFL1NNazRPbEU5Wk81ZEliNzc5UGFKMWJtUzhLdzlE?=
 =?utf-8?B?Szk0d3NaR1M3OUdxakRzSEVKSVRWVExWN1h0NlpuMXlxMTF4OFdCb3UwVS9E?=
 =?utf-8?B?a3YyUnpJWWNENkNJeVZxdW1UV05tMm84WU1JTnVtNlZmOEhwT092L2g1cW9G?=
 =?utf-8?B?S1dXcGpkY09weVdVZ21LUE92K2t0cjN1R0FQMWZVWTM3bXI2amJCTktzTTJ6?=
 =?utf-8?Q?/xAObwyErk5Io2+ECdz72Sv2U=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGp2clo3Nm1TbHRQaWlQOHgvUTlhcDNib0ljUkpwUmVaUzBpdWNMRlExeHNB?=
 =?utf-8?B?enlvRjI3QjdtZWE0TmQ0L0RvOXFWbHp2Ky9Zb0UzU1NldzhYeE9TenBjOFpF?=
 =?utf-8?B?ellFQmcrSmMrWVZHZ0xKOVZML2NJYnNzMkd2NzQwUGtma3hPTE55SHZQYnZ1?=
 =?utf-8?B?SmtSR2lVQjBscEl5aTArS1JNLy9GWGg5N2tnQ240eXJWTUNQR3ZTUDlZRHYw?=
 =?utf-8?B?Y2E3aUpRVCtPak1rRG51VjU0SkJqOXppZTc4ZFRwa2dYR1BkQm8vd3pYNE5u?=
 =?utf-8?B?czYyVjFETzJVWHZ1VFNVQ1ZQeDFlbGQva3pYSFhuWG5oZjlSbHhNeU5OOXRj?=
 =?utf-8?B?eUpRQ2FTL3h6SGcvOW1HNklPVytzck4xeC9pdktSWEtldTU5eHM0ZElJN3pP?=
 =?utf-8?B?dkYwdjhjMVg2UFlQbFUzZzBuWGtnMW0rellaUXY4OGpDa2ZsTE56STJqMHlT?=
 =?utf-8?B?RTRNRkdVQVZaYWZMOUVtS3pwbGNIR3VLRHkrTUJWYStCTm5kZ05OL1JjTVdS?=
 =?utf-8?B?MUcrRmdqNm12ZkFGOU54TUo5NjI4djQzSXkwR00vS0ZBcC91cjZuZEJlT3JQ?=
 =?utf-8?B?cEltNjNUK1liVlVlNFRKeDR2V294Z3I4Wk1FR1ZTSDJGSklaaTJVSndtK1JD?=
 =?utf-8?B?R0V3L29RZlRDSTRKeW9KUWYvcS90QXN3MHBFYkNmWlVQZThiRHRFU3RaTW9V?=
 =?utf-8?B?WkF1cU1MSC9qUnYyTVY3bHlraU5jcjBuaFk1d3NwLzVTUStyVUdmenIyS3pP?=
 =?utf-8?B?c1hvWnI2MVNCR28xMy8wdVZnZjRxOXNOR2pWU1RIeTVqOEFsSHE1RDdKTDdV?=
 =?utf-8?B?RDJqcGFBNzhhRzJ4TTZOcy9XdFBSMCs5UnIrRXhmKzg3Y3Jzbm00UDZ3aUtq?=
 =?utf-8?B?Z0NXVk8wc1FvVVNNVkR4UFZXL0EvVjVxMTdxUnN6aFUzdzNadmZzSG9aVy8r?=
 =?utf-8?B?MmVRNEZJdlZKQjhCaHhaV05temI4amw0M1EwSEJXNXNvRXU0SUZudVZBdTNO?=
 =?utf-8?B?Z0FmRC9xbjVqbS8wd1UyQjdRUnFIZmhDQWxYWVQ1MjhwTSswWkJQYVl6S2ZZ?=
 =?utf-8?B?WFc5VVhId1dzYi9ibzRXaGNreVlQQzdUQ28rRGs3SzdrNllTWVlhaDNrNldN?=
 =?utf-8?B?cUphOGI1ZWVnbU9ScGppcm9EQjVXeGxXQXhzcjNYUVZoQ0RpNkRqNHhoTTZy?=
 =?utf-8?B?aWJ1YUpIRm9oUnNTMWg5cGdIOXVMVmVUU0xlU1FrNzIwb1BqWGRiL3JpUU9O?=
 =?utf-8?B?UHgrcFBtOHdzNVYrdnFUSDBaenVwV0hGdW14Z3Q3STdRWkFZZlp3RVdGKzFa?=
 =?utf-8?B?STEwY3lma0NwVHk3d1BGR1NZUEZoU1hBVFFkU2hhbnBKeVFHSGQyTHZzcmF4?=
 =?utf-8?B?R09Ib3NMd3UxRVQxRW5zMjlvTENHVFk3WnR6L01NYlBpMnRUdGNLNCtNNjBG?=
 =?utf-8?B?Y3JqYTZsOFA1bnozbDFNUkhTVFo0VGhzNHpPcjZLSUZUd1dtakkrRkpHU1h6?=
 =?utf-8?B?UTRvOVZJOVZLSlJUM081am5kL1BJRW1rbmhiZjVQTjhrRURpdU9XUEorNzZy?=
 =?utf-8?B?VkM0YmRod0QrU2lWa0VLVzdMVTVrTWVSczlPK3ZJdDdwYS8yaTBnMFBvSkxn?=
 =?utf-8?Q?P86sxy4iDwxrApdlJUwjpDClDLtkrzK4Qu9hCOLpUA0s=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df51dd6-61f9-4202-c83b-08dd65e50d3c
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1708.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 06:21:00.2997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5825

Hi Masami,


On 3/18/25 9:36 AM, Masami Hiramatsu (Google) wrote:
> On Fri, 14 Mar 2025 22:43:00 +0800
> Lance Yang <ioworker0@gmail.com> wrote:
>
>> From: Zi Li <amaindex@outlook.com>
>>
>> Add a hung_task detector semaphore blocking test sample code.
>>
>> This module will create a dummy file on the debugfs. That file will cause
>> the read process to sleep for a sufficiently long time (256 seconds)
>> while holding a semaphore. As a result, the second process will wait on
>> the semaphore for a prolonged duration and be detected by the hung_task
>> detector.
>>
>> Usage is;
>>
>>   > cd /sys/kernel/debug/hung_task
>>   > cat semaphore & cat semaphore
>>
>> and wait for hung_task message.
> Thanks for updating the sample code. BTW, do we need to have almost same
> 2 samples? I think we can unify it (one module provides both "mutex" and
> "semaphre" test files.) to "hung_task_tests.c"
>
> That will help us to extend it for other types easier (and less code).
>
> Thank you,

Thanks for your suggestion!

Yeah, I agree that keeping two separate samples is redundant. So let's
combine them into a single 'hung_task_tests.c', which can handle both
mutex and semaphore cases. This will make the sample simpler and easier to
extend.

Cheers,
Zi

>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>> Signed-off-by: Zi Li <amaindex@outlook.com>
>> ---
>>   samples/Kconfig                         | 11 ++--
>>   samples/hung_task/Makefile              |  3 +-
>>   samples/hung_task/hung_task_mutex.c     | 20 ++++---
>>   samples/hung_task/hung_task_semaphore.c | 74 +++++++++++++++++++++++++
>>   4 files changed, 96 insertions(+), 12 deletions(-)
>>   create mode 100644 samples/hung_task/hung_task_semaphore.c
>>
>> diff --git a/samples/Kconfig b/samples/Kconfig
>> index 09011be2391a..3a073d6b848b 100644
>> --- a/samples/Kconfig
>> +++ b/samples/Kconfig
>> @@ -304,10 +304,13 @@ config SAMPLE_HUNG_TASK
>>   	tristate "Hung task detector test code"
>>   	depends on DETECT_HUNG_TASK && DEBUG_FS
>>   	help
>> -	  Build a module which provide a simple debugfs file. If user reads
>> -	  the file, it will sleep long time (256 seconds) with holding a
>> -	  mutex. Thus if there are 2 or more processes read this file, it
>> -	  will be detected by the hung_task watchdog.
>> +	  Build multiple modules to test the hung task detector. Each module
>> +	  provides a simple debugfs file corresponding to a specific
>> +	  synchronization primitive (e.g., mutex, semaphore, etc.). When the
>> +	  file is read, the module will sleep for a long time (256 seconds)
>> +	  while holding the respective synchronizer. If multiple processes
>> +	  attempt to read these files concurrently, the hung_task watchdog
>> +	  can detect potential hangs or deadlocks.
>>   
>>   source "samples/rust/Kconfig"
>>   
>> diff --git a/samples/hung_task/Makefile b/samples/hung_task/Makefile
>> index fe9dde799880..7483c2c0a0ef 100644
>> --- a/samples/hung_task/Makefile
>> +++ b/samples/hung_task/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> -obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_mutex.o
>> \ No newline at end of file
>> +obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_mutex.o
>> +obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_semaphore.o
>> \ No newline at end of file
>> diff --git a/samples/hung_task/hung_task_mutex.c b/samples/hung_task/hung_task_mutex.c
>> index 7a29f2246d22..e4d1d69618b8 100644
>> --- a/samples/hung_task/hung_task_mutex.c
>> +++ b/samples/hung_task/hung_task_mutex.c
>> @@ -22,7 +22,7 @@
>>   
>>   static const char dummy_string[] = "This is a dummy string.";
>>   static DEFINE_MUTEX(dummy_mutex);
>> -struct dentry *hung_task_dir;
>> +static struct dentry *hung_task_dir;
>>   
>>   static ssize_t read_dummy(struct file *file, char __user *user_buf,
>>   			  size_t count, loff_t *ppos)
>> @@ -43,19 +43,25 @@ static const struct file_operations hung_task_fops = {
>>   
>>   static int __init hung_task_sample_init(void)
>>   {
>> -	hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
>> -	if (IS_ERR(hung_task_dir))
>> -		return PTR_ERR(hung_task_dir);
>> +	hung_task_dir = debugfs_lookup(HUNG_TASK_DIR, NULL);
>> +	if (!hung_task_dir) {
>> +		hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
>> +		if (IS_ERR(hung_task_dir))
>> +			return PTR_ERR(hung_task_dir);
>> +	}
>>   
>> -	debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir,
>> -			    NULL, &hung_task_fops);
>> +	debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir, NULL,
>> +			    &hung_task_fops);
>>   
>>   	return 0;
>>   }
>>   
>>   static void __exit hung_task_sample_exit(void)
>>   {
>> -	debugfs_remove_recursive(hung_task_dir);
>> +	debugfs_lookup_and_remove(HUNG_TASK_FILE, hung_task_dir);
>> +
>> +	if (simple_empty(hung_task_dir))
>> +		debugfs_remove(hung_task_dir);
>>   }
>>   
>>   module_init(hung_task_sample_init);
>> diff --git a/samples/hung_task/hung_task_semaphore.c b/samples/hung_task/hung_task_semaphore.c
>> new file mode 100644
>> index 000000000000..a5814971bfb8
>> --- /dev/null
>> +++ b/samples/hung_task/hung_task_semaphore.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * hung_task_semaphore.c - Sample code which causes hung task by semaphore
>> + *
>> + * Usage: load this module and read `<debugfs>/hung_task/semaphore`
>> + *        by 2 or more processes.
>> + *
>> + * This is for testing kernel hung_task error message.
>> + * Note that this will make your system freeze and maybe
>> + * cause panic. So do not use this except for the test.
>> + */
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/delay.h>
>> +#include <linux/fs.h>
>> +#include <linux/module.h>
>> +#include <linux/semaphore.h>
>> +
>> +#define HUNG_TASK_DIR   "hung_task"
>> +#define HUNG_TASK_FILE  "semaphore"
>> +#define SLEEP_SECOND 256
>> +
>> +static const char dummy_string[] = "This is a dummy string.";
>> +static DEFINE_SEMAPHORE(dummy_sem, 1);
>> +static struct dentry *hung_task_dir;
>> +
>> +static ssize_t read_dummy(struct file *file, char __user *user_buf,
>> +			  size_t count, loff_t *ppos)
>> +{
>> +	/* If the second task waits on the semaphore, it is uninterruptible sleep. */
>> +	down(&dummy_sem);
>> +
>> +	/* When the first task sleep here, it is interruptible. */
>> +	msleep_interruptible(SLEEP_SECOND * 1000);
>> +
>> +	up(&dummy_sem);
>> +
>> +	return simple_read_from_buffer(user_buf, count, ppos, dummy_string,
>> +				       sizeof(dummy_string));
>> +}
>> +
>> +static const struct file_operations hung_task_fops = {
>> +	.read = read_dummy,
>> +};
>> +
>> +static int __init hung_task_sample_init(void)
>> +{
>> +	hung_task_dir = debugfs_lookup(HUNG_TASK_DIR, NULL);
>> +	if (!hung_task_dir) {
>> +		hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
>> +		if (IS_ERR(hung_task_dir))
>> +			return PTR_ERR(hung_task_dir);
>> +	}
>> +
>> +	debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir, NULL,
>> +			    &hung_task_fops);
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit hung_task_sample_exit(void)
>> +{
>> +	debugfs_lookup_and_remove(HUNG_TASK_FILE, hung_task_dir);
>> +
>> +	if (simple_empty(hung_task_dir))
>> +		debugfs_remove(hung_task_dir);
>> +}
>> +
>> +module_init(hung_task_sample_init);
>> +module_exit(hung_task_sample_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Zi Li");
>> +MODULE_DESCRIPTION("Simple sleep under semaphore file for testing hung task");
>> -- 
>> 2.45.2
>>
>


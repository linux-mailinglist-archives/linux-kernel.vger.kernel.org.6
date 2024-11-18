Return-Path: <linux-kernel+bounces-413100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C02A9D137A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FBD1F2339A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261BE191F79;
	Mon, 18 Nov 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WqIPS3Wb"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C923A1A9B56
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941101; cv=fail; b=IILrmnbxYdgcbi/qXmmJAhJLlDd3KwYqQlsr7CILCJIJ60IbBDSDR9+bhy1yM/eFqirblyN7+0/UiDWJCMG70hjxSWWv4Sfy4vgp40yjna1MgN1d4w4IodUIuBTVGNTQ1DZ8+VLzTqTMvC0cehMvuUfn0lVOAv30fRIxuhnTQE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941101; c=relaxed/simple;
	bh=F5988DEj6lYtQ9z8sLufwjD+N5piLDmdXc8AH0g+6gw=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=GZqLst8WgTS01VShrnNS4LO0hq+iLETzJHMmqbgnaP9Kr67C+cjP5xDY0+d/WQax2YzbUoeV+DkTmbiHLYMlkodEPwJ9nh/Xs6tBbcDe2btZHEz8Afm7gDG6BYT1J9Rz+wP3Pai+T+AoOW/p/HvQoASu1kLp0Xw1RM3gjg3g8AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WqIPS3Wb; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dpb9PC98HGUr2bBomGCkJhZfP2NqEQGPyKJ4L4Aj3KxzeQiN81w4XfQXaFdDe5kMX7Vv2A5ZANj/yiY3sa0JeSfAx6i0ckV5oS/QTBmBPZnCLIaVgYwLsJJhZNqioK12YuVDViCGFCdg45xd5cmYJ2pCXQNqw+blEyPeNXwAl9FzxF839/1TXpEpFpJE19P39qVHS5z96R1dPhSm6Niom0xy55T3EXYPy+aC/VAETjnmiVgEyqpsaND0d3vd49G/P++9ZGM2vFYoVsK8gVQPfZjhqN3yIuodWdteNzY6d6qLrDTQlrOAQ5hzjDXCYHmmher4KjDdpOkKRd0M5ui6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf12X/OC0EbS+MDZYeJP6TUAICwa+cT8jrRyUgbeCHI=;
 b=Oo0aLa1ygll9FAnXqojxpzqzX3kxdNYBMLNvQcdwNTPfBa5UWjLym3rfdg0NDPkI1/u7CaTJCi0RA5ZHgO8xldcDCPvcx33gpzu31uoz1ettu9Qw9RpHMn4gzV9WVQffZOmDzSfoLjlNmkhRV20s8hSO2yrH/9qD5H6d7QR63ef7n0vrGAUku54DcPCB3IlN+xQEcFfJBqnwhM7MGVaEncd7JaOgvzYwsJzeATky+9WpKaYNPGIqqYNq8EwIEz2nRex/4ufxWiZENW3tyQzgizBltQKTHIk2d06jNBnT+s2h6GrA4uLBjumLKkF37XoIagd2dEOe3BIf6ab+fx80Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf12X/OC0EbS+MDZYeJP6TUAICwa+cT8jrRyUgbeCHI=;
 b=WqIPS3WbqiprymoLy4ZP5XchP3L23H2++DNzNH4NrPfIjegOQF9w3V3Gt0RtRFtwDBq9CeJhv0NJb3iTfGtoELmfEwqFFgqea9xsdwTflMdJ0JShFAeSxQz7dw/x0e+dKPD/KK+cE3hHnWfk7WXOXveB6EXp1FUbG4pP4kdXF+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 14:44:56 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 14:44:56 +0000
Message-ID: <c7a9748e-aead-b252-dd29-48dd0d2da9be@amd.com>
Date: Mon, 18 Nov 2024 08:44:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
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
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
In-Reply-To: <CAMj1kXHPut9qv7dT9Xv=xhbS6AP3HRP0dikk-G690AKfLuNLGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:806:125::10) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 882a3b74-4385-4f13-42be-08dd07df91e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG1yZjlOalJyRDBUQVgwRFhKOHkwZkZ5VWFjV2xZdWhIR3NkVHlvclRHQWdh?=
 =?utf-8?B?dnY4dFlyL1pwMXZWVC9iS1UvVXl6VWowOEltbTFrOStIMHJjOW9wNHZac0c1?=
 =?utf-8?B?TFV3MW1xdUJadjhWeWEvekpVOFF5UjNpYXFDcW9HeS9RSUdLTzM4KzA5Zm9N?=
 =?utf-8?B?UThPeE52UHRHOWhVVVk5TUg2SEtiL2pPemQ4WnJYY1JhSUxyWnhNOWt0ZTRj?=
 =?utf-8?B?K3JyUDZlckpnWGl5dUx2YzBia2VkeGlHRW1nbmZsbWs3T1plL2tXdTI5em9z?=
 =?utf-8?B?MmF1b0xDd0RBZjdGZDV0ZmRHa1V6bCtJaVV6dUFaeURLVXVoMEVNUVJuQU80?=
 =?utf-8?B?RVFmWWxYMDlCRFMvdVUrdDVlNFplbEhRNExjc2I2Q0JROGY0NVA3cnRqZEl5?=
 =?utf-8?B?K3dkTW9iM2c1ZkNhcWQ5R3dXckFOcXJqQk85ZWFxc0YrYjZiTlBlcW9McmEw?=
 =?utf-8?B?TGk3OHI3czhqYXNSU0tQSmtwQmxmcC83ZmJNNDlYV3JadVdyQ0NkUTdBNDVa?=
 =?utf-8?B?QlFrTXR1bGhPMEJkWHE4Ymxpb1JORUUrWWNZTUhtMSsySXREZ2t6dEVxWTZa?=
 =?utf-8?B?UzFEQ0pVdkNOVlFUWkNIdC85WVR3VFF1YWhzZlhrb1dmMXJ0OUlyNHlQZlJM?=
 =?utf-8?B?ZCt0S3BIQUVuMEdIaytuRzFRVHdYMlN6eENiT2p3dG9pa3Bpc0pMWlhHekwx?=
 =?utf-8?B?NnZYTHZqZ2xEbi9Da09DeGN4L0M1ZVNNR0l2dGhNY1lDWS9NQzNEVnB0SGV0?=
 =?utf-8?B?MEZlOVcybTBhU2Y0SFRNc29QK1Jtd2luRUxuOUdlRzlqWksxcCtaWnphekxw?=
 =?utf-8?B?S2NINE9CNGxlRWtyWHdiaGlrcFROVmR3bUJkcVlOOWd1Wi9vN2xzMjl6Sk5v?=
 =?utf-8?B?WWpxNmVJckx0WXpmTFo4TE1ET0ltcEVpYzBMMjRqazR6aG9ocWhoVzF6YTQy?=
 =?utf-8?B?Z0kzNjJhSXFYRnZabU9INE4yNXE1T1RmS25NQnIrSXVjVUlPWUo0MkluMVIx?=
 =?utf-8?B?M2RYRExyQlFuR296ZXdzaHVNNDlnTzJoVlVtaUF5aDZJOG1ISHVaVm5mQWJP?=
 =?utf-8?B?YSsvSVY3a0ZYc1pvTk1uOWJTZmc1VmxEOEtXV2todGpraGxHVjFldm9IbnRF?=
 =?utf-8?B?Z3BaMk5VQUNZbklOeHB4ZVAvZ3BGcUZrdjVTeStMYTRlWkZHVFJRZi9CczNY?=
 =?utf-8?B?RUtxVDJxbmFjTHdQcWZZaW9Jbkl4dEVZd3dpS01aNWE1d2xJMldnU3g2WXR4?=
 =?utf-8?B?SXdtOUJmUjFTUThCV0t1dmNEOWFIQk9PNjFydXFpaFBMWGM0eEcxck1VbDVs?=
 =?utf-8?B?YnliWjJVMFFmM2VJU2tjZzNvVnpLaEdWQXE0bWJXazlKTVEvVUl0WllwcUVm?=
 =?utf-8?B?SVA2dm1HNktFaFUvQ2hmdnhaSks3OEdtYW10VEVPWE1qaW9qTnpRc3VhSHJp?=
 =?utf-8?B?MmdtYTd1bmRUVTNHTDVFTnZ5cWJsWnlwR3ArYjhyN3A5SzVjdjRLUnFneG4v?=
 =?utf-8?B?YzdGNVlNMDFXUDV4ek1saTQ5UXpBdm1GWWJ1ak9lbmVTV0JreGVhOWYzREor?=
 =?utf-8?B?VEY3NmQvQSs2bEZ2NGVEWHAva0g0RWJTcVBIM1h3dU45VUdndWo4SmZacDRC?=
 =?utf-8?B?UzJVM2FsN24rZGpiejRkeFJWRzFPdUN4WU9Oc2pKSEpIbnN3eDFZa0J3LzBk?=
 =?utf-8?B?NUxSUk1tNGh2YzhRUEx5NTZ4SEhWM1ZmMFB6SzQ5d0xnRTBFelhlakxqcTNO?=
 =?utf-8?Q?mM5qhNdBPw/EfQgFjEvaAusetnupNxJCbNGN9UT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1dFcDNhM1ZnMjBnZ1NmRU9jZWozaC9pV0hXKzdJRGlBOXpSNllnVWplSWdl?=
 =?utf-8?B?bURWRG92Sy94em9jNlc1d1NKY2VQb0Y3VVNWbHQxWjNCa0VJdjdXRitsNUZ0?=
 =?utf-8?B?ZWtjVkFlNHc1QkJiRy9HdC9MVWxxdE45TlZWNWRTVmo5emRHcy9vSEllZmFB?=
 =?utf-8?B?V05iUVR5ajJVY25GK0ltMVpXVGl0RUw3ZWRtQ1VxTm5yM2NEYTJTQWVMdnpK?=
 =?utf-8?B?eHZzc2JBYkRWTmZuV2hyMTR6UkRCbnVUa2hrcnAzZmJGWHBuUDhVa1hvaGFL?=
 =?utf-8?B?Y2JadGFYRDlxNGZhekYrN1hzQllweGU1YlI3THgwVjR5cFpDQjcvOG1RelNK?=
 =?utf-8?B?MUV5RzAzMVlleEsrREdNU2FMUkNJWFpacXhIMTRBSmprLzdIYVpNaUROdzla?=
 =?utf-8?B?Rm9JTzA4YUpuU05neHlBR0UvUVR1UHowenVNTFhYV0VRQ1NMTHpxa0d2S2hO?=
 =?utf-8?B?ZjFZWlVwSW9iUGNYR0xkM3NCa2tOcThvMGI5RXI1QzAwNm44bEIvejUyZ2Vl?=
 =?utf-8?B?OElhOUZkZzZOOGFJR1VGbDBaVVdLdm1BaGhJeEdwbFZvVG1hYUtoQjFOS0Mz?=
 =?utf-8?B?WTB0bk1wMGpWc3RGclRWRE5IdXFxNzFqeXVtaTdiYlkwNmZoKzJIT0QzQWxB?=
 =?utf-8?B?dlJKSGpJWkRwdkVhWU9KSTRVRDBONjBwRFFpWXlLc2lNSFZ0UE00M0Y4Z3li?=
 =?utf-8?B?QXpIVVQyZWZDNXFXNjlPaThESnJFS0JoeHlMRFRrM3pWdGZid1RFSWd4KzZZ?=
 =?utf-8?B?VEx1WDRPT2U5ZHkveFU3TUJ5T0d6cXJTdmlJc2FVY2xuOEpESVVyYTE2M2FJ?=
 =?utf-8?B?Zi9taU80QVZ1LzVYYm1RNlFkYTN6c1RpYlQ0OTBIb0I4OENyREkxanVrZnVW?=
 =?utf-8?B?UnlwZUVRRGpsZWFtcTZtaFBzOHVGYzhBTVFscFQ5S2JvemxoNmZqVEtHcS9O?=
 =?utf-8?B?WHJCUVM3QzdxYmU0SzRCLzQ5dGdoTUx2OEY1Mkk0cFpkNGVjY0tNZXhaZXlZ?=
 =?utf-8?B?cWcyb2JQWFRsV2Q4eDBzdzJIeXlrZ1lxVG05NkJ2YmwyOE5vR21wMVRsdGFD?=
 =?utf-8?B?ZHYvN1R0NWlnTkx5U1pTTk9WUmhsQnRJWjM4cjdMWEZiZ2xtTjNiMHlhL09X?=
 =?utf-8?B?bXRLU25OKzRaTm9wMkFqMFFMTzhPWkFoaW4yZmJvRW05ay90SHFlQisya0hi?=
 =?utf-8?B?MS9zOHY5eG5zQ2JPVytHd000dEdrQkNRZk00TEtBOWxLRWJIMkt4bEU0Z013?=
 =?utf-8?B?cWdEa25CbXR3U0RSYUpDT2lqSi9CS0J1S3NpYUlnZzNFRTcwTmQ4cEwyWEpl?=
 =?utf-8?B?QmM4VG00Vi9vN3N2L3dBczlCMk9rWTMzZ0xOSzB3VDZqRHZjMnB3VlJtMDlm?=
 =?utf-8?B?alM3cGhPWVZ3L0ZxNW12NUxQRHBRL09GSis4ZnBtaEZ3ZEFPUUxlSkJVWitD?=
 =?utf-8?B?TWFrSEZpWmp0L0F4SzYrc0hibktvMEhWM0k5YmRNdXY3TmtNVzJlbkV1ZE5B?=
 =?utf-8?B?MEZ6cEJkT2Nrb0FURmJzcW1zZ1drSlJHMklJRmJHSGhOdnJlSHY2dDVUbXcy?=
 =?utf-8?B?N2tuSis1MFJYRmNUYUM4WUpJT3BCL085Sm5hU2ZqYW05OEZ6OHkvK1p0azk0?=
 =?utf-8?B?eGVoeW5zUWNMdGltbTJVeGNycmpITk9OWlpMSXhWbldVakprWnFRN1JOTjVE?=
 =?utf-8?B?WmxzMW5VMFlRNXBJTkU0dTAvbzk5SU5WVWxCdHY2eWo2UUl3a1duQmJIc2Fq?=
 =?utf-8?B?QTJkTnJsSHNyQUw4ZlJiSFZXSnJRRXhxMzg3bEVDYTc0dWQ4ZnAyNThDQjl0?=
 =?utf-8?B?dlJES1pxVmpoYW1kZDNhQXF3Z0lHL0ZxRWFlb3VtZG5DTFpzU1gzaUQrWEpL?=
 =?utf-8?B?SDRKUFdBZmVOWlAwaExwbGJBU2hlRS9jNDcydEdvTGFnY2FkRzV2aEppSUhC?=
 =?utf-8?B?azZrRytHWDVJTnZnZUltbDVBQmRnMDNndUp2K3RydG1wU0QyOUQwUFZ2S01G?=
 =?utf-8?B?VENmdGZDWHBmUnBPSUtEeEM2ZitBZCtMQXFRanZENG02d1ljUWs2Y3JGVUZ0?=
 =?utf-8?B?Qm02SWU0bDVQd2VEdW4wVnBmWHNWMm1QUWNFWXdzUXpTMUQzdHhaRTJNK3ZY?=
 =?utf-8?Q?6BuV4/+ABWSWCZemH75PhbRda?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882a3b74-4385-4f13-42be-08dd07df91e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 14:44:56.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YhXk0giuVY17h/iTp410bMgzFhV9jWCdXiI32hXFAb+4RGjD8HEcVuFUgEvthXoRF4ezkEihHhx5J9QtQey4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458

On 11/15/24 16:55, Ard Biesheuvel wrote:
> On Fri, 15 Nov 2024 at 20:53, Ragavendra B.N. <ragavendra.bn@gmail.com> wrote:
>>
>> On Fri, Nov 15, 2024 at 12:02:27PM +0100, Ard Biesheuvel wrote:
>>> On Fri, 15 Nov 2024 at 12:01, Ingo Molnar <mingo@kernel.org> wrote:
>>>>
>>>>
>>>> * Ragavendra <ragavendra.bn@gmail.com> wrote:
>>>>
>>>>> Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
>>>>> it was not initialized.
>>>>>
>>>>> Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>>>>
>>>> This 'Fixes' tag looks bogus.
>>>>
>>>
>>> So does the patch itself - 'struct es_em_ctxt ctxt' is not a pointer.
>> Thank you very much for your response. I am relatively new to kernel development.
>>
>> I know we can use kmalloc for memory allocation. Please advice.
>>
>> struct es_em_ctxt ctxt = kmalloc(sizeof(struct es_em_ctxt), GFP_KERNEL);
>>
>> I am thinking to update like above, but like you mentioned, ctxt is not a pointer. I can update this to be a pointer if needed.
>>
> 
> The code is fine as is. Let's end this thread here, shall we?

I was assuming he got some kind of warning from some compiler options or
a static checker. Is that the case Ragavendra?

When I look at the code, it is possible for ctxt->fi.error_code to be
left uninitialized. The simple fix is to just initialize ctxt as:

	struct es_em_ctxt ctxt = {};

Thanks,
Tom


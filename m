Return-Path: <linux-kernel+bounces-531690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28143A443A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17390171E95
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BD221ABBE;
	Tue, 25 Feb 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QrFXu9HV"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022125.outbound.protection.outlook.com [40.107.193.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72521ABC3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495237; cv=fail; b=amfRVjqk9JHWLAP8KdEetJygBEEuFGWRSeGKob7omoi2+9aSJl2mHLqlu/K28EKz2qIiZMmIJBIzAL8G8dOBZZ9vZ7heAD1LDZ2Jw9IkgUEnzIhfi/T/3lLVCbTWFk3OxAxB14TfqXrowMmyHgxMwlYBm9gFy65QjjYvKzvKUc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495237; c=relaxed/simple;
	bh=wKCLK6Qas56CDlbojaIZQiDxx6ZN/pJjXxkkxL8bZOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uuQ8LfHmWIuyWgjiUsATwKlh+3wvNf/aBc/ZzkCqL5AXCfWev+U2LS6nkNBVlp6jZU2zZrgbRF0FtlrwRbQz6dPhm9BHN/NdIfXtC5j/14V59V9XJxQtssZU7oyLK8XksVlvqwfYYUElhFbr+MMX809gMuNYx9aKRs/sdwetY0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=QrFXu9HV; arc=fail smtp.client-ip=40.107.193.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg5ljRsXDXc22FoIDRib3CvTP5MWbWF/x2FY2ZP4VtddWmJqNHe/+DJudKD9tLT3ctr0nkwZfBNq9Mo0GYm6KF38odwldk05trhHkwwo7/Pd0iWyWqwNRWKstT0YdA9HENaxhXsxqfBcv2fc1xOZMP9rzYpsc7GixyTjXV71WuWbsL2rnejeO2sXSfI4c8gkN9aDXM8FDfgyvdpjfFkpsD3bwuKg/aHJvqGi9ISNUJL0RCApaGMPj+6mH7QBk8reXV5UoponH/SSdk1fIo6HSuFLcDNBHuvBzoQBkPqnBvp93U6/XTPB8Rln0YcxrkSgZUiXLJ/d73IgyvrV0JHZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfdDrfgb4Q2hmQLJEFe+1y1el2mb6jDFlwYBMGuXIN4=;
 b=BQuz3BOekbq/5fav3Dy1vz+ZCucI37mpeveqnqW1npOgVOEvN9AP/gvotc3tEI3zynOng218AoYM2GyyEiwA2e2dhPTEvN2qaUo5OpASa7KN6d1EPjNP8aj/Ta0zDpb4reQEKzrX0QJf77h8F4dvmdclZomSnbtWbS0rhLWANIIBju2zyOgL5ETg9lJ54q8M1+5+6XJOxBCftR6uQdjpWFaoZ3sSC6vD4wMVrrqbGT4dwEdSHPfUbQc+KzJ8MHeAK54aFCKUCjPbUC2TVfIzhfb8igVsAxNMKWDvqR7AkAlOnpIZ92OK8ON1t7b4BpH7urL63FrJ3Pv/ynivWicKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfdDrfgb4Q2hmQLJEFe+1y1el2mb6jDFlwYBMGuXIN4=;
 b=QrFXu9HVB4DqB0ZpssAakMZHebqxrgKMqPBNqyqbBIWz6mF2gIZTIZs65Q3vVGbi78KvyM2WuS2OSpn8jQNkdldbVgYxfmHuHO3vBEAImeWYEfkOLn4kDGSbGr85vlbsjtYzhjC+b0PMdi3ho+50zG3KbM6NDF+lB5Syt9h6oA2pRraM2ezScA4L3Z4koBnc//303/1U8TphhRCE3uJgg+iRjkaWNcvtq8HlO+p7BeUZdmHaQrJfQrMuPaUZ60QL0kQYXCvMaYNeucHPnqAFoWFQfpNMl0YPTLawVO4MynAuwIRTBugq4o/z8wQoHQQ1jqzlWQ1eVDvYA5WWATHYRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9233.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Tue, 25 Feb
 2025 14:53:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 14:53:52 +0000
Message-ID: <47797927-4d87-4101-9834-eac84d814114@efficios.com>
Date: Tue, 25 Feb 2025 09:53:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] rseq: Make rseq work with protection keys
To: Dmitry Vyukov <dvyukov@google.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1740403209.git.dvyukov@google.com>
 <4e93f7da6dfa450d488fafa3599306349e6e34e8.1740403209.git.dvyukov@google.com>
 <b18e6478-ef4b-42b3-8cc4-42467b3a0a7f@efficios.com>
 <CACT4Y+YxmkW6opFVJFOOFd=c73gz7yFvwBBCnjMndj-jffjBCw@mail.gmail.com>
 <b42dc8d7-2f2e-466f-bdca-0d532a0d5928@efficios.com>
 <CACT4Y+Y9RodZO7T2RSJGohwjAdgBktgySCvCZ9xaPdVJafYzJw@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CACT4Y+Y9RodZO7T2RSJGohwjAdgBktgySCvCZ9xaPdVJafYzJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 379e3c8b-524b-4266-c393-08dd55ac37fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWZSZ2tKdklmdmo0WDFVZWxiNEYyYk4zL21pckl3TWsvdzlSZ01OeDFxa0FB?=
 =?utf-8?B?OWswSmdmWVNuSmlLKzVCSDZmSG4wRDB3aVJRMTA4OUxNQkVYWjhhd2hhV1hq?=
 =?utf-8?B?eTZ6Nm96b1BqT2gwSnROWXFEeDlpNnNSM2YzWWhIU054UjFHK3ZUU2VUdGtP?=
 =?utf-8?B?OFpDVFFleVFIWFFtSjNXMnQrWk9GVHVnSmI2dUZzWnZBQ21nN2NsdEd5MGdL?=
 =?utf-8?B?YTlCaStXOFVqVGoyaDQwS3k0dENvZmVYYUpBOEx1ajNVYjM1VnAxY1BEaFBU?=
 =?utf-8?B?bVVLRW5UV050OGI5SlpZa1VHc25SVCtDTUFNcGRjYVVIMkFlNTVWTm9DbmVB?=
 =?utf-8?B?Vkh5QUIwd0xFcVAzeGxvNnpPUnE0Nmtpc1FSbDdBMlpuWTVmOFN1alBhK1hZ?=
 =?utf-8?B?NGxHbFFvSVBXYkFVdm9kU2FqdnQ5NFVlMjJsY2FwSTFEVllLVW0rZW5oTlpU?=
 =?utf-8?B?d0c2SnM3aW5sWWcyN1pxRnltMmx6SzRaWXg3ZWUyQTRUamJoS0xKQWN4L0hM?=
 =?utf-8?B?RVI5WWVSQzRrK0RuMWs1S1lYNm5Qb1NRMU54V2dBQjNvdWhJcG1CNWxDSzBS?=
 =?utf-8?B?QmI5a1Z4c1kxazh2ZGNXNGR1MWc2bmxkYm9TcmIzQkMzdERzRXE1OGxrRWVG?=
 =?utf-8?B?Q2FxcldJWmtDdktDL3RUT0RnRzlQMjk1L084MGdXdlA4akVFTWlaQTFmRWRm?=
 =?utf-8?B?UUlSNXRjNGg0cU1Ic0l3c3FsZEJER0JFakh4eHdVS1FvbnUwY01HUXh0UWRk?=
 =?utf-8?B?NStya3NOSVluUjRURmJtaWowaHc5TDk3RTZFSDVabDlLWW16K2FJdUY4bkk5?=
 =?utf-8?B?QW00RWZBOGdIM2FMVkd2cU1IRmtnR2FqaXlwRnhsT2prRyt3eFB3M1U0aDRW?=
 =?utf-8?B?NnVvZktsM2hEWElUbTNjTllhTlV5TEQxdVBLLzdRa1JsWTRWMzJFWVZQa3RS?=
 =?utf-8?B?cVhKd3FKd1RNZ3NIY1dHbmgyQ1lSOFFlQVlSMFNZaVcvN3pGUzZ1VTNvZkFO?=
 =?utf-8?B?MUVEZlpGaW5XNmJ2TWFOWXA1VXdLa3RpTitYekFDakJOb053czYzWmN0US85?=
 =?utf-8?B?T2RidTU2NHZNQ00rL3BGL0U1VytzbzdFOVNwajBFRFRtRkdENGowVEpiYVp3?=
 =?utf-8?B?T1ZsQXJ6cnVRd2htZytqM1ZFZ0dlUkRjYmw5a3VvQmlpSjVEazc3cW9PNUZE?=
 =?utf-8?B?UldScUV5dGovc1FmVzFOTE5FVkZtSmxLUnpxOUFKYlZwMytLc01WSVlTVVNm?=
 =?utf-8?B?U3Z3bGRSN3Frb3BRV1hzOXU0c0dNdGhicGdLQ0dHOVNISlVuSTlYaVFQY1dR?=
 =?utf-8?B?Vks3TEUyd01CbFJlUFR5WVg3VU00TG9TbG1DTHpLcWh2V1BPTnVUbWVPdHIx?=
 =?utf-8?B?MFFOMXJiQ0VoTDBiMEpmWU9jaTFFZkQvd2RrdE5mVXdWUlhlcVpKaThSY3Jl?=
 =?utf-8?B?a0pBeHhFcStHN0g1a0Z6RmJLdXlJRkVKdlJvR3ZCRWtGb0lyQzdOTnY4Q3VN?=
 =?utf-8?B?UWdtc0wrVmt1QUNDZHdPSFhrdFoyQ3JqbThHWTNTdGJmWWZZYVArUzFmYTVS?=
 =?utf-8?B?cHNucHlXVG1ldkl4WkxSRmlWU0phV3F2bno0eHhjc3RDVWpaUEw4aTBhVU5r?=
 =?utf-8?B?UlZZSkNLbFZxQ2VkVEVEZzhXSWVmeGk1Y1NMZnlDajFLRHdLT1JlTUR0WXJa?=
 =?utf-8?B?RVR5VElOc3JBMFJZSGJYZy93eWNMeGFIcGxaSThhRE1wYWVFMXRycWRETFRs?=
 =?utf-8?B?c1hZMEZTYVFzaTlQRFdOQXlJa3VMd0Q0SVdZRHp1TmZ1L2pYdGs4Y2t1Mm92?=
 =?utf-8?B?SE5JeUN0c1B2YjZoa09QUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3hyUHpyV2lWM1FkSkhOYlhuYXZVK2wxMlA5eVlQekNDNVcwSWYyUFRwdnor?=
 =?utf-8?B?WTZRWlRpU0lQck4vd0N6RnVQdHVsQVQwMEFSajd2MDJhQU1tNzY2Q2l3ZVh1?=
 =?utf-8?B?R2E0Zkx5TkJhVTZrZWhuQVRxaFIzUDNLYXg0WW9rQmlhNzBFMnVXS0x4azRR?=
 =?utf-8?B?ZWxGVWdod2NLeUQxWnp5Y2xKVTY5Ujk2cTVqMHZiY1BIYU5hcXVDV2N0eTR3?=
 =?utf-8?B?L0YzY0VwcVJlZHY5ZTNRaGdBa3NYUUJQY25CejJ4WnJZUk5Sby9nNUtOQisv?=
 =?utf-8?B?QWZDN0xEaDlnMEZBL3ZmRFB4WEo2YUJzUjdOVFpoYnZ3OTdVQVZseDloRUxq?=
 =?utf-8?B?T0trOEpPazRmRWtCem45aE1uM291a1pJQ0tkKzBsSEV2blcwWVF2RXJjSGZh?=
 =?utf-8?B?M1YrcWQ1RUJEN1FCYVcvdGM4NnE3SVFOdDE4WTFoUHdFd1RhZk5aZDloT2pw?=
 =?utf-8?B?NDhxVU9jVGltWi93RGp4cjZCcWlXNGF5ZHhLNkEySHpwYld1NW5oRnFoR0pM?=
 =?utf-8?B?K25RM1VVclltQTAxTGNSYVVIWWpuOENlN01FT0Q5dVc5cmFOVkJhclF3cjBF?=
 =?utf-8?B?QWp4SG9UZDQ2TXUxaXdHRnNQYlNoaXVjOERJV1VKbWU3dyttK0huZXN3K2hF?=
 =?utf-8?B?S1BTUmRLQXNMd2tLWUwzeHVYcmYzRnQzTFhwSVFtd3Y2TEFQSDl0d3JxaU5C?=
 =?utf-8?B?TldDWWN2L2dYUDk4TWtCdFBQcjVZbk40T2NZNCtSRmcvZ3B4R0NPRmRkbEt3?=
 =?utf-8?B?cGxXQ1JDb282YjRMWFJKSmc4bC85ME9BZDFSNDJ6L2cwSjhvYXVqQ0ZBT2lk?=
 =?utf-8?B?L2NtRmxRQmFEZlFVdklLVnY5em4yYVR3c1B5cGEraXFUM1dORk9YU2xEZXJw?=
 =?utf-8?B?czZhSzJsMlN4VVAzcVJPQ3FFZ29uNzhaNWRSdXVYUm80d1U5Um53QzZCU05v?=
 =?utf-8?B?UDJZQ01yV3lJVUJla1JkWjgyMTJrYUxLNGFXbUszZ2VNTE1tMm5OT1RVR2o0?=
 =?utf-8?B?amRYQVpiNHRmcDB6ZWpid3pDUGlidHY3OGtqWmhaT2ZlVDJNbEF2aU9JRVE1?=
 =?utf-8?B?MnVZT2pscGxKK3ZjdDk5ak9UOGsxbE01aFhsZnNiT2oyUkg0bFlLL25mSTc2?=
 =?utf-8?B?bDA2dzhCZzZnMWFqUE5uTFByRkhmSWVaRWpjR2lSaXVPRnBjWkFpTy8wMWts?=
 =?utf-8?B?OXFSUVNtR0ZxY1JjL0RVWDFzYXlFWjdiNVBuc2hSWFpGVFk0MGN5UHphZSsx?=
 =?utf-8?B?WjlzNldJNkQ2WmwyYmlzM1FnZ1NxeDRpM2N4UEp1N2c4K0tSMW9QaTcrenZH?=
 =?utf-8?B?aG1jL3prWVNhOURzMVVSVlpqa3poYUs1N3BZbnFJcXpGVXp2SVBXeE5WM2NH?=
 =?utf-8?B?NUY3bWhqUTNPajhvMU5MZ04wMWJrUjloWUFqVzNkWlE2dDdLSENKY2xIanBi?=
 =?utf-8?B?OXRUSUU5Ulo4ZXhEbmRNVFB5VGtuQU9Ma0FOVy9jamEzK2pwbmFSbm1QUnp6?=
 =?utf-8?B?ZTVRREVPaFhENERtUWg2SGpGMlFqTWtBcjhkYkNIOWtqcjVCYnc1a0ZBYm0w?=
 =?utf-8?B?QVQxRW9hTUNrSkVDT3cydmpKaGpGcnlaNEhNc2hHalZOQjRHRW0wN0lTN2Mx?=
 =?utf-8?B?dVZQZlFycXBKdDVtK09DNlVuTjluQUtyK2VWbm1jaXRzdmd3Q0xsVEFmSGZz?=
 =?utf-8?B?KytvS0owYktsenZyZ1hHWEYrOUNQQ3V1cmxJdjR1QXBqUUR5WlhDS2xic3BX?=
 =?utf-8?B?TUM3THp3eDljcFZQaXBPZEhweXNYOVFISE51WEg1L3g1Z3BGZDN6SWY4QjV0?=
 =?utf-8?B?N2xUSGRZVE5xOGczeDltWXl3N2lHQzdOeTVlU1RzdTAvTE1tT3RycnBtN05a?=
 =?utf-8?B?N0FQOHN6UFVRV3BPY2JBUHBrV285WGw4K2wwRGV1a1pMMDNLbnJ6U1dNWkp1?=
 =?utf-8?B?cDVtQW1UT2c3WXJPZk8xc282NmRGMHJxYTR3ZUgyYlN0ck11VW50M3YyelQ3?=
 =?utf-8?B?NjFlVk54bU5zV1ByMVhxbkIzMDJTWjh2WnNqTkpMZFQvNVFid1lneHhaUXNq?=
 =?utf-8?B?aHFuYmo3dHlJTEEyQVdXQmVRaDhtckhORGFYR3BnNlN2ZXZxSzZpT3NmVXRp?=
 =?utf-8?B?Qy9rRU5seG5sQmpWOXg2c05aeEFsMEtTVnBEYVRYNDE1NEw1cFJaVmtrdmVn?=
 =?utf-8?Q?RxN6LvIIUqAlF5OWc7IFvOA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379e3c8b-524b-4266-c393-08dd55ac37fd
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 14:53:51.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czz0RsNol93AuzUZqXcqSqHrMpkweG0DsD0PnCaltDoFwXL9ZRuX6GTjfre/mXny+CO3GIi1rNIhR7fRbIV4usRB6Cxk9J3tuPKZOK4T5oI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9233

On 2025-02-25 09:51, Dmitry Vyukov wrote:
> On Tue, 25 Feb 2025 at 15:28, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2025-02-25 09:07, Dmitry Vyukov wrote:
>>> On Mon, 24 Feb 2025 at 20:18, Mathieu Desnoyers
>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>
>>>> On 2025-02-24 08:20, Dmitry Vyukov wrote:
>>>>> If an application registers rseq, and ever switches to another pkey
>>>>> protection (such that the rseq becomes inaccessible), then any
>>>>> context switch will cause failure in __rseq_handle_notify_resume()
>>>>> attempting to read/write struct rseq and/or rseq_cs. Since context
>>>>> switches are asynchronous and are outside of the application control
>>>>> (not part of the restricted code scope), temporarily switch to
>>>>> pkey value that allows access to the 0 (default) PKEY.
>>>>
>>>> This is a good start, but the plan Dave and I discussed went further
>>>> than this. Those additions are needed:
>>>>
>>>> 1) Add validation at rseq registration that the struct rseq is indeed
>>>>       pkey-0 memory (return failure if not).
>>>
>>> I don't think this is worth it for multiple reasons:
>>>    - a program may first register it and then assign a key, which means
>>> we also need to check in pkey_mprotect
>>>    - pkey_mprotect may be applied to rseq of another thread, so ensuring
>>> that will require complex code with non-trivial synchronization and
>>> will add considerable overhead to pkey_mprotect call
>>>    - a program may assign non-0 pkey but have it always accessible, such
>>> programs will break by the new check
>>>    - the misuse is already detected by rseq code, and UNIX errno-based
>>> reporting is not very informative and does not add much value on top
>>> of existing reporting
>>>    - this is not different from registering rseq and then unmap'ing the
>>> memory, checking that does not look like a good idea, and checking
>>> only subset of misuses is inconsistent
>>>
>>> Based on my experience with rseq, what would be useful is reporting a
>>> meaningful siginfo for access errors (address/unique code) and fixing
>>> signal delivery. That would solve all of the above problems, and
>>> provide useful info for the user (not just confusing EINVAL from
>>> mprotect/munmap).
>>>
>>> But I would prefer to not mix these unrelated usability improvements
>>> and bug fixes with this change. That's not related to this change.
>>
>> I agree with your arguments. If Dave is OK with it, I'd be fine with
>> leaving out the pkey-0 validation on rseq registration, and eventually
>> bring meaningful siginfo access errors as future improvements.
>>
>> So the new behavior would be that both rseq and rseq_cs are required
>> to be pkey-0. If they are not and their pkey is not accessible in the
>> current context, it would trigger a segmentation fault. Ideally we'd
>> want to document this somewhere in the UAPI header.
> 
> Makes sense. I will wait for Dave comments/ack before sending v6. But
> to save a round-trip, does this look reasonable?
> 
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -58,6 +58,10 @@ struct rseq_cs {
>    * contained within a single cache-line.
>    *
>    * A single struct rseq per thread is allowed.
> + *
> + * If struct rseq or struct rseq_cs is used with Memory Protection Keys,
> + * then the assigned pkey should either be accessible whenever these structs
> + * are registered/installed, or they should be protected with pkey 0.

The wording is OK with me.

Thanks,

Mathieu

>    */
>   struct rseq {
> 
> 
> 
>>>> 2) The pkey-0 requirement is only for struct rseq, which we can check
>>>>       for at rseq registration, and happens to be the fast path. For struct
>>>>       rseq_cs, this is not the same tradeoff: we cannot easily check its
>>>>       associated pkey because the rseq_cs pointer is updated by userspace
>>>>       when entering a critical section. But the good news is that reading
>>>>       the content of struct rseq_cs is *not* a fast-path: it's only done
>>>>       when preempting/delivering a signal over a thread which has a
>>>>       non-NULL rseq_cs pointer.
>>>
>>> rseq_cs is usually accessed on a hot path since rseq_cs pointer is not
>>> cleared on critical section exit (at least that's what we do).
>>
>> Fair point.
>>
>>>
>>>>       Therefore reading the struct rseq_cs content should be done with
>>>>       write_permissive_pkey_val(), giving access to all pkeys.
>>>
>>> You just asked me to redo the code to simplify it, won't this
>>> complicate it back again? ;)
>>
>> I'm fine with the pkey-0 approach for both rseq and rseq_cs if Dave is
>> also OK with it.
> 
> It should work for my current use case, at least how I currently see
> it. Ways people use pkeys are pretty unique, so it's hard to
> extrapolate. But there is one more possibility: when a program
> switches PKEYs, it may also clear stale rseq_cs pointer from rseq.
> This way rseq_cs may have non-0 keys assigned, but they are always
> accessible while installed.
> 
> 
> 
>> Thanks,
>>
>> Mathieu
>>
>>>
>>>
>>>> Thanks,
>>>>
>>>> Mathieu
>>>>
>>>>>
>>>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>>>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>>> Cc: Borislav Petkov <bp@alien8.de>
>>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>>>> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
>>>>> Cc: x86@kernel.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
>>>>>
>>>>> ---
>>>>> Changes in v4:
>>>>>     - Added Fixes tag
>>>>>
>>>>> Changes in v3:
>>>>>     - simplify control flow to always enable access to 0 pkey
>>>>>
>>>>> Changes in v2:
>>>>>     - fixed typos and reworded the comment
>>>>> ---
>>>>>     kernel/rseq.c | 11 +++++++++++
>>>>>     1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>>>>> index 2cb16091ec0ae..9d9c976d3b78c 100644
>>>>> --- a/kernel/rseq.c
>>>>> +++ b/kernel/rseq.c
>>>>> @@ -10,6 +10,7 @@
>>>>>
>>>>>     #include <linux/sched.h>
>>>>>     #include <linux/uaccess.h>
>>>>> +#include <linux/pkeys.h>
>>>>>     #include <linux/syscalls.h>
>>>>>     #include <linux/rseq.h>
>>>>>     #include <linux/types.h>
>>>>> @@ -402,11 +403,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
>>>>>     void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>>>>>     {
>>>>>         struct task_struct *t = current;
>>>>> +     pkey_reg_t saved_pkey;
>>>>>         int ret, sig;
>>>>>
>>>>>         if (unlikely(t->flags & PF_EXITING))
>>>>>                 return;
>>>>>
>>>>> +     /*
>>>>> +      * Enable access to the default (0) pkey in case the thread has
>>>>> +      * currently disabled access to it and struct rseq/rseq_cs has
>>>>> +      * 0 pkey assigned (the only supported value for now).
>>>>> +      */
>>>>> +     saved_pkey = enable_zero_pkey_val();
>>>>> +
>>>>>         /*
>>>>>          * regs is NULL if and only if the caller is in a syscall path.  Skip
>>>>>          * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
>>>>> @@ -419,9 +428,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>>>>>         }
>>>>>         if (unlikely(rseq_update_cpu_node_id(t)))
>>>>>                 goto error;
>>>>> +     write_pkey_val(saved_pkey);
>>>>>         return;
>>>>>
>>>>>     error:
>>>>> +     write_pkey_val(saved_pkey);
>>>>>         sig = ksig ? ksig->sig : 0;
>>>>>         force_sigsegv(sig);
>>>>>     }


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


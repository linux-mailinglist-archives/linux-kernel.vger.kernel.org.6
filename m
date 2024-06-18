Return-Path: <linux-kernel+bounces-220198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D635990DDF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB021C21840
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA47176AB0;
	Tue, 18 Jun 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QFwg5tQN"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668C1741D4;
	Tue, 18 Jun 2024 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744697; cv=fail; b=JdFmd8UdXVE5QZwRx3WGZ37EdbW+jW1WZKE/d2ghRhUeXZx/Pgk12MSPpG0vJcTsQx92zePGjRuqz/QDZko7omTdY3itvqVlrfKM8Awn1GXfNJogkFRXH8CMJuOBy4QCsxffAi+eqI+bFD1odXqcrB2JI2IGmZo/ylPSL2CFWIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744697; c=relaxed/simple;
	bh=xFf1KKyViViscPkXZTxU49Uk9jEg+sBSWEgT/vsIep0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AORmXg3Sw8NpMA7/44/OC/Arfb6tu0zMOHY5DUIkNyTcT1y4otYXALm1Zh1DlQpMPmQxxDuV0DdzhNS1oL2PJSEnozg/EuB9pAYOnkqwPDX2ZROOK1XjJyOW1BmMxP3+V7vt6nCpC+u609DmfKsm9fk/KtHi5z6DrWFsNCdeVzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QFwg5tQN; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGUWMR7T/+rErx4V/0dQ31nsnsOTuNVsZXKWfitHRvrcAgoYZcZ0DxxDtTmYlhlmZIu/u8Cw/9JQCaSyEFcQHLV5f6wQrOT+88TapIXnjcHagzqncGb7szg36eeW8ZJWeA6dc6JwUHMx+V5AUgSof0SxL6Cf4bZzc0VYS8jdWFhFwrBKCcitaAmueqzAF1oVCSb05141oTnOBcdsz4MAjJZFWjtkX2gS8LfmLwvaKDFCUNtV/DzW1+SKzr+dGtYTrD8aa6X+M+RuiPMg0mncAS4eYXpX0ZpKkXGcUDgPcYmxojJTLG5ZRrClL1W74y7ZFjzMgCzjlhGQuEU3gsrabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P5EnYvlHNWyOLrUozkZAUf2EmqH4TlTy7fcSLbHApU=;
 b=b66SYIEbn2yJuNnira3JBZtgE3iW9jhR00Q+mKYTqVVDU3eaK+gM0fLwsl5N6GaWyNWCh6UN6Urw9rhIZ3T7zdgMmjf4AZOCm6/YOF60UYLQ6TosJAwab1QCzuFn3ivzIhs9kcTItCbHqnWhOVYLDLvDYCaycVoICTwsrxGvLqDjy0KJymI8zfwyTpHcuQkrrAVOc+Y/pJL7WzetXb2LAhtF2GkT2bxk9AzgFDV5VTXnIHMIj7YYpasRVgcqOkkzVQo6Mu8QTzaJYtALYNHhCGjonOzXLJduzHZDpB6EZzrw9GjTLmiZrBD+SqDBbvOdW+33WzTje5lQ1pzHKxFASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P5EnYvlHNWyOLrUozkZAUf2EmqH4TlTy7fcSLbHApU=;
 b=QFwg5tQNWTxnt9V73WXZTNnh6WBy4DmpvxCg9XLCFAPC/mxCG5Jjdd2qrRxh/BmCODreywWP2/+/Bi2qC7wSD50kLbXuBR1kJnUUob67utjy7JILOqx4SLtsdXAe8K+biTIgx8aI0o+KyCMH6g4/aHKWS+pg/Si6jhi0hDVqYts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 21:04:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 21:04:52 +0000
Message-ID: <6030f4b8-6576-6ae9-ba8a-9f1e42dfe7d5@amd.com>
Date: Tue, 18 Jun 2024 16:04:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v4 06/19] x86/resctrl: Introduce interface to display
 number of ABMC counters
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1716552602.git.babu.moger@amd.com>
 <6fdb1c3df8960a9d634a7a904421c63406b1a4b7.1716552602.git.babu.moger@amd.com>
 <23aa42c1-6b55-4d29-8995-29fbddf98ed4@intel.com>
Content-Language: en-US
In-Reply-To: <23aa42c1-6b55-4d29-8995-29fbddf98ed4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d43c35-c4b8-4053-b8d7-08dc8fda4c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVVWcUdnbG5FaFVmUUEwTHh2azhmZjJoWEREMlVBRE0rZDgrUVU2N2NpUnFF?=
 =?utf-8?B?Ty9lajJhUzhic1FHY1ROZEpFVFdCZ2ZLcndoUGxGbEoyZGQ0SzNxNktINjZr?=
 =?utf-8?B?dUJTNmRsL3F4aE9zWExRRVZrNE9pYkpCRzQxWWVGOTZsWkpQalZrNENDQ1Ju?=
 =?utf-8?B?Z0VuMU91TXptQnBIZHhiY0lPNmQ4ZGJ3dmtWSGg0KzdoS1BCNEZrNWFhcXdj?=
 =?utf-8?B?aXBvRFlxbVU0dEI0U1NSTnJsdWVpRFgxNHptNFJLVHFKcjAwNlkyZWU4SnY3?=
 =?utf-8?B?eldzN1ZrMTYrSnZYTmZWRFhmZS8yNCtnRTdKQ29iWVVBcXREbkRCTzB3ejVa?=
 =?utf-8?B?UkVERUYwZENFRHVrVXZSU2V1aWFjdGg1aWRGNjJpYzJqU2pQSDE0WVIwVGZx?=
 =?utf-8?B?RTh3UllUVzhIbWpJU05BTlh2cnZuTzVwbWhZaXFkWnJqUXV5U0ViWnB4OW9v?=
 =?utf-8?B?eGwwWE80VXFkdlpTdEl3WXJmOUh0MGZCc3RmT3hHcThXVGNhdHhvNklpTjV0?=
 =?utf-8?B?N0xDZlQ0Sk9oWHc2R0Y4M3lWQ1NSbElKTXlnUmMxY2lhZThwUnNVelRhQy92?=
 =?utf-8?B?OHdSL1c5RFYyOVB4Si9LZ1NHMEwxNGo4MVVCLy90OXJQTFhVelFSMlF4c1Jr?=
 =?utf-8?B?Q2JJUEtOTldlT3ZZMlY1QkNkQTNtNjFocHFqYjltM0E5amxkb2hiRU5lQXBI?=
 =?utf-8?B?dnZ5Um9XMmgxVTB0ekM0UnArNU1kNUZmTllhMUNxdDkvZFBmMkRhaGFWVE5T?=
 =?utf-8?B?WCt5cEczOE1JRzkzcGtmbDM3bnhpaDNxaDVrSkR4djZzcEkvbDVBOHBTSGMw?=
 =?utf-8?B?YnhCL2tOU3IxeFJsZ1BaNkEvSmxLMHZ1RGY1azBUbmNaQjZCS3c4V1k1SFZI?=
 =?utf-8?B?L0FDLzgwVWljeFlRSEZOajFFT3pKdzBMYysxYnlkeGFibG9xbFFIbDB0Uk9i?=
 =?utf-8?B?NGVHdHkyN2ZKTExJRzdua2E0R1FwRmhxbEp4YTAzMDEwTTRoWDVQRW4vQVhy?=
 =?utf-8?B?THdHRk5CRFN2TVRyY05XM0Y1azhEQjQzTWdaaG5NREJXYTdidTJ5U0Y0Mllo?=
 =?utf-8?B?NllqaXRHb3RHWThSSUVSd1dGRUJoTURXTnVsazBHRGFnNXdudCs1dHBMYklH?=
 =?utf-8?B?UUE5ekNWeWdUNUJ2RjdIOEtaSFFXWFd3Yjl4c3dQRGFUK2F2UkdUeGtmVkhv?=
 =?utf-8?B?NVErTGY2bVFlSUY3TUZha1JrOW12am8xLzBzWWtua2owR3Fpd0JsQWNFWFM3?=
 =?utf-8?B?UHJnNlQ5S3NqdFJub052eEZoSFZScTdBUkpvSDFqZXMxY3V4WmtySS9QMGVG?=
 =?utf-8?B?MmZkd1VWcFEzTkF6NXM0QkJoUnFCVjlLdDNFRkJEdCtZR2tERkpvNERscSt6?=
 =?utf-8?B?elhIL0FDOHIwVEFGMXJUYUJEcWJaVEdIR1hoblRCN2tmdXZ4cFJRdzJHOE5O?=
 =?utf-8?B?SU9jVnFpVUtRaHRNb2R4amxxL3VlZzlFNUdwbG5tNFJoWlYwdDFtR2ptOTZ0?=
 =?utf-8?B?Qm52UFYrSmRZWktuTlZFVkpFY1V2ZElqdEg3cHpYaU1JUEExSHRZa3gvc3I3?=
 =?utf-8?B?M1dydWxYUTVxQTJGOTBPNFRkL3N2a2JreFRwUmhuM01mWWUzWHZmSTQ1M3By?=
 =?utf-8?B?aWVOWVgveE9kVmZXZDNucVNNUUxXSGRXRDhnSE9Wdi9FemRudDdUZ0hSWU5H?=
 =?utf-8?B?c2dVS2dIS21XSVNjVlAyTnRpR0F4SEMzY1lLMll2Wmc2b3N3eTdnZ2JlbmlJ?=
 =?utf-8?Q?lacnq6ogUesJnevj/xKmg3aet1El/KC1csJ+EVC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDBlUkcwMUFzTFhDUnh5VC8rcUJxWGdNR2V2NjBzWUFmZjJadDBjUlVhZnVF?=
 =?utf-8?B?SUlBUkJlNi8rNTU2T0pvWEtWa3ozbFZJZ1pCZXA4YndNUGh3dUNBeHpPWC9Q?=
 =?utf-8?B?Z2hJR2dVTFNMZ3NKdnBLR3BvSVgxbkVGbC9NcmxzY0RqeFErdk9ISTZoM3lP?=
 =?utf-8?B?WGNyYWVlYm1McEtDRUNIT01Qa1VhSWRPSzgzblpRem94V3pUL3lHV2ZlZUhQ?=
 =?utf-8?B?dkVWS0V3Q0JzYnFqS0ttelZmK1ZYQm1qRUhmcUNMMUk4UUU3SlZiSXZDNjBm?=
 =?utf-8?B?U2ZjTzQ0MENrTXg0RlpoNytyTXBSREl6NHdxQS9FWGpueXlFdXRhb0hwOTF3?=
 =?utf-8?B?a1g1Umt5bXJMOGtzUVhTejE1enRUYUNraklNRGpQZGdFWVBwTFNEa293WWds?=
 =?utf-8?B?cXN6Z3Q5SUE4bUtBSVJCM3BNZnVLaXQ2ZGlQS016RlR0VjZhaWlKYzNQRWZB?=
 =?utf-8?B?WlhuQlB6Smd4VjdDNW9sMm5vaW0xbDZzK2pOay9mSFVYdDJjYjl1c0xpZmhS?=
 =?utf-8?B?cTRTNUhJbjgvMVBxaHk0dURiUnVvRVVvWjFkN1BXdFZTbVJMTTI4SFFtVm43?=
 =?utf-8?B?TDFCMDRzZFhSUzFQcVpycG9FT1lOclNzWk9YUlNsZEFVR3U0R1h5cG5GNzZt?=
 =?utf-8?B?ekRSVmlrbWtVeTQzcitkUHZzZnY3QzlndU52OW12bjUxNUZMVk8xSkFndkhC?=
 =?utf-8?B?ejVyck8zMU5SQ0Z5UjVlNnJMNGd6c3VJZnBNai96NTQwb2l3akxXbzU5Ly9x?=
 =?utf-8?B?am9VZEhHWFdCRlF5bU9lWUgyeEU5ZElRbVV3SmNKakROVG1zUUpQaS9abEEr?=
 =?utf-8?B?WUxUVVJHcXlvZ1RGdWxYRUROWmNTbEpTejVDcXV1amRxNVIzQ0NqOXBaNDRx?=
 =?utf-8?B?dGM4UE41SUVxL2lqL3VWUmFpT2V2VStDcDlYNUF4dzJYZlBJSFhhZTlsd28x?=
 =?utf-8?B?OFd1ZWw1U0M4UnRLT2RKQlFhMzAwcEd4dDlEeTJYVkJzZGdURmxoUXhRcFd5?=
 =?utf-8?B?NzhoWHRkeWtISnVXUWgrZFBaWnlSVGlWWjl3NzE3REhQWU1JMENianR0WXpS?=
 =?utf-8?B?MlRYSHBxcGxBbjkzUWJRRDJ1bGowTU81QVNxdHRTd09HbUVobDNEV0tWNGNG?=
 =?utf-8?B?ZUVGNkNzVEROTlVHdm1ZM3NsSC9MdlQwZnViY3BHSlBROU1XUzl0Sll4TEFq?=
 =?utf-8?B?ODRXL1Y4aWhUMldpa21lTEsrWmZUdzFSTzA3VjJxc1ZZRElrZ1JkaG1GSUl5?=
 =?utf-8?B?SDg0U1ZpcXAxSWJnZndLZEJnV2lGZkxRV2pKRDlHVkJOaExZODBkZ0RHeUxy?=
 =?utf-8?B?Rkpkb0dja2U0TWN6d3k5QklGUkdRYlRzamFEc2dML3oyNGZIbHZrTTRXaHBz?=
 =?utf-8?B?dlhYNzR3WFlZcVpnSy9SalBCajdLRm9vY3REaFBrNGZ3aFJFSWpNTmlTVHRu?=
 =?utf-8?B?SUhCOVQzTzZPaUdBNW1tNTV6UW1pbUZENk9JN2RNR1FFVmRGWGMwMDBoWCtO?=
 =?utf-8?B?Q1dESEZBT004UFJFUVdEeDd2d1N3S1ZzSjJUNnJKMHpqenhzVURtTUErdFV5?=
 =?utf-8?B?S3JUcVQyWCtvd01pbEJTU21tWEVaaUlCT3lWSlovandyTUs3ZmpDK2hNT2FD?=
 =?utf-8?B?eGVrMnlRK3R6eVdJdkVML0ZLNHVpY29IdTBTNnEzbTQrbzFqTEFXMnFiUWtk?=
 =?utf-8?B?Z3RmK1lXMHhIeDRpS2VKaklVYkJMem5DNEFYcVF1Yk1Ya21ZaGVKbmNtczhB?=
 =?utf-8?B?ck93dGlSQTYxQlFqUHQyMTJEaGlGeEFVSnZLYUJ1bkJxZm9sSTZIY0EyMmhx?=
 =?utf-8?B?c1dNZi9vVmN6akpFMTJFVU9vd01Vemx1QVBLSnErazNSeDNrc29NU0FJc1h5?=
 =?utf-8?B?SWFtcCt3OUs0ZDZ5NFFhV2ExY0xpS0pWYVNsbGZLQU56U05DeW0xWlZQWE9w?=
 =?utf-8?B?VjZyWHdLTitLR29mVlVvTHdYdk42cTA2Y0hMcjQvbHVvVzBONXc1OUxWL0pC?=
 =?utf-8?B?S0lkWVNtL05PbzRCRnAvU1hZMjJsbWdORG9rMStnck5vbGJQblVvQStEMnll?=
 =?utf-8?B?NHZiL3E5Z0pmUkgxNlZnM0tBOUxsOU9oQ3Zyd0dVSVBVUWMxcDc4cVAvVTFo?=
 =?utf-8?B?eDFFSm1XYW5Gcmd3RmUxQVlxQVhvakphYlJVQTVXTlhFdVoyZkxpazgwY3RO?=
 =?utf-8?Q?+HNGkOyRWEBRdyW7VANin0R3jn1qPlGXiaPnxFh9uQ0m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d43c35-c4b8-4053-b8d7-08dc8fda4c1a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:04:52.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zx4zWD+GGALhW2NUlqvWdEwY9DbpBcTTF4hcVaWeTdaRnY+T+vZCuSuAnPWKQV6z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

Hi Reinette,

On 6/13/24 19:57, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID and monitor the bandwidth as long as the counter
>> is assigned. Number of assignments depend on number of ABMC counters
>> available.
> 
> Take care that this interface will not just be used by ABMC. I assumed that
> when the user switches to "soft-RMID" then the value of "num_cntrs" will
> change?

It can be used by both ABMC and "soft-RMID". Will update the information
to be bit generic.

> 
>>
>> Provide the interface to display the number of ABMC counters supported.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v4: Changed the counter name to num_cntrs. And few text changes.
>>
>> v3: Changed the field name to mbm_assign_cntrs.
>>
>> v2: Changed the field name to mbm_assignable_counters from abmc_counters.
>> ---
>>   Documentation/arch/x86/resctrl.rst     |  4 ++++
>>   arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
>>   3 files changed, 21 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst
>> b/Documentation/arch/x86/resctrl.rst
>> index 02790efaabcc..7ab8172ef208 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -257,6 +257,10 @@ with the following files:
>>           # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>>           0=0x30;1=0x30;3=0x15;4=0x15
>>   +"num_cntrs":
>> +    Available when ABMC feature is supported. The number of ABMC counters
>> +    available for configuration.
> 
> This can only be understood by folks already familiar with AMD's ABMC
> feature. There is
> no information about what "ABMC feature" is, what an "ABMC counter" is and
> what
> "configuration" can be done with it.

I can move this patch after 8/19. I will add details on ABMC feature in
Patch 8/19. Also, keep the details bit generic.

> 
> Do you think this num_cntrs will only be used by ABMC? What will happen
> when user
> enables "soft-RMID" or some other mode?

This can be used by both the features. But we don't know how soft-RMID
will be implemented. But, I can make this explanation bit more generic.
> 
> Reinette
> 

-- 
Thanks
Babu Moger


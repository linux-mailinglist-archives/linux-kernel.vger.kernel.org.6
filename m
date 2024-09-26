Return-Path: <linux-kernel+bounces-340963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F0E987994
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39031F23C63
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3597E16088F;
	Thu, 26 Sep 2024 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uYlzTy/W"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE581D5AD0;
	Thu, 26 Sep 2024 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727378226; cv=fail; b=niI7E+6ilCxSyKFdY1Jf6daNPBlFlgiLWC8z9Ndw8eDBg5+LZNAnCJFCITzCoADCe9QA5c3JLh4MzjIwtWaZwhA+lXjC7TQ9U+JbhWQ1vrDDJTjYMaApd39AtTRBJs2TefVzaD91ignOmkY1fD2YvmEXvkJZrug0/1WLmbpZvy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727378226; c=relaxed/simple;
	bh=o5ZzdetOYU3G7B/efAbfs8vVaL3mGsZGqhOfMAOpve8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=unS4VIFv9/PnPO8pFw1xk+3D8oj2sVgj78bwtEsZtssY/qekwOXkofYFxeJ35ABXcDixHq32yoXIIaS665jRlwUK/dzIEXghOX2OFolnularQmHMq6RR6VDPa9+BRusjq5CvqISy54GLl/0LTF/7s4Hf/NMgNOIGM5FvnACLU5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uYlzTy/W; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9V2IS2hM0EdJsZ6DL9slVLRspnDm5A0qunQZ6zT68UJvLKVCBDdJQMAizi059g+3xkdeAzO+NgWrIpFms4srtLQtRIbN7CdVs0zhw4BtFjePC9eRfP2+cHM2x+Dm20236BAFKDE1MEwK+vEFpcyFfBKGZmI9s2l5b0d8TrZke4h1zNEBvtZxm2yxME5jyWPXyDVqKeSdQEFJReQYXuSgkGOjJiQ7BM16bnRRFwDFUkWb7wsWcnqRy6JGV7RIR4JZ+bKq6Bb0Lv7RainuQEjhhL0Kd7ffEKXKDagEgaVupd01g/GclAAGVvPJHpeXCNnbLcXFudwzoBCy7l0bXRfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjeY+rkGRSwUT1Q9egh/hzXrzIWDJmEF+P0saM504XA=;
 b=KDxpWEmRyY/9bVY0qMOIq8Ehek2Xm9q6ml9RUWCkmN9qgktcX6nAiueJYbQwKEFoHo1mH8iWitLYMwYRIJiabO61tS4npXM5BPNCSSrzTQUgZxqitg90YNH947JkDXlE5VDmXl/RqjjnHce+q+9hKlccVFe8cPzULkIzWKODUE0Rbm2go1Zg6EeFqeU0lp3yzmjaPJP7bmKj2e1Bmptky/d8JqWT+RONgBASDNQDtM9fVRZrkhCW0lIGReTS+1cB0/1/OBhz0zX9QQw33JGVMPDSgk5AaDQRnSAw9g5wb/Ynros0LaWafOIgyrD3R9kcyDp0sGNjc7omBtNMcS/YYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjeY+rkGRSwUT1Q9egh/hzXrzIWDJmEF+P0saM504XA=;
 b=uYlzTy/WFpW4q5WlK2uCx/nccGy+dIWyUwsLOLQeT9CSlWviAyvOpCydqP7M/0t6hkH1x0oMcgPDbr6zATn3vp+yH/XNw6sF9wa6feNhN7R/+enPwZjHvacMhUlDmp6xJwefBizE2H/CQBTNFQ7XYavJ/qwcqyfIJwVS6tInNbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Thu, 26 Sep
 2024 19:16:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8005.020; Thu, 26 Sep 2024
 19:16:59 +0000
Message-ID: <3734ee4d-f0ab-41b1-8f5d-42642760da8c@amd.com>
Date: Thu, 26 Sep 2024 14:16:55 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 19/24] x86/resctrl: Report "Unassigned" for MBM events
 in mbm_cntr_assign mode
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <1c5b054d8fbc3f7ad22c686d0d5e21e6573187bd.1725488488.git.babu.moger@amd.com>
 <f5f61804-3743-42ef-83ed-6c198c4eef74@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f5f61804-3743-42ef-83ed-6c198c4eef74@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:806:121::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 1564d4a7-698b-45aa-a8c3-08dcde5fcb51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkFrcW4yZ0k2OW05NHJUOW1OK3NJWmUrOUtmMW5KWXBraWtpMHZYYnhCa1Zn?=
 =?utf-8?B?cktIQ3JzaVJJaGZJcGMyOTlNaTUvV3lZcmZyUnRjTDBNYWZQdkpNV1BvOUlM?=
 =?utf-8?B?UTRQZ0xYYkQ2bFp2aDRGSi9lL3Q2RDN4VzZLeGo0dURBdnN3MUtaam5kbXZ3?=
 =?utf-8?B?b0trS2N0UEltZGNhZk55ZWQzbUdRQXpiaWV5RlEwYlBGZS9qUjdVUHNqWFFz?=
 =?utf-8?B?dHhnVzI4WHVjbXlyTDBhL25CaEZ5SWVuNXIvdWp1Z0MrT0xxRDZ1UEtMbXlE?=
 =?utf-8?B?ejNUTnBXaXJkenRKc3I1bmNhQ1VZMkUxR3JPQWhoT0RmSkhGTUhpVkVlL3Rm?=
 =?utf-8?B?UjlWWXk5TUZCVHp3cEZOWWVka1J0QUFocEJKcmtUT3JlTXdnTnpaTWNnNlpL?=
 =?utf-8?B?c3BxZVVOaGVoSE9saVZBcVJPU3lJd3hEMjIvcnpJR3lUYlBYM25DalpxZGRK?=
 =?utf-8?B?UitoTlFrYitwUnY1dGpmVmJyTVlEQVlXSzVVaitYNXd6TUFrQ0dNQStTQ3RM?=
 =?utf-8?B?UWdmTVBIMHNHV2ZiK1llNnJZVC9SYzZHYjRsNkpRM1I3RU9hYmJuSnV2R0Ex?=
 =?utf-8?B?VEl5U1VFMGFEMjlNaEN3RytaSmtNZ2k5M05FdysrdjVUUzVxaCtHTXpCZHVR?=
 =?utf-8?B?aUk3NkpNWExlaXN0b3FSdEs5Y2R5R0FIUUp1cHduTjRKN25IQmdjbWpPU0FZ?=
 =?utf-8?B?QVBqZ2ZZVUJlWWdqb1RYR2E3UFh0aU4vdTFzank2cTBmWFN1YXY2S01FQjZi?=
 =?utf-8?B?Wlp1TDZ3SVdwOFRUTnNSSUk1TlcrRzRxVE42RHJUN05xREc0Q2Mwc1gvd3hi?=
 =?utf-8?B?ZGVxQmF5VFNOVUk1M0gxVVU4NW5IemZFMjMxMTR0cHd1cUhvYjc1QkkrMEpl?=
 =?utf-8?B?dHMvcDZ5RHF1TXMySmZRN2hxUE9QT3hhSXBpWDhqYWFiSjY0M3g5QUg2eTRT?=
 =?utf-8?B?bmlkT1VETTFiU0wyMTM3a01OZXcwbEljUmpFZDRuTEZ1KzFraWwwRlYxcFhO?=
 =?utf-8?B?WTlBL2l4ZHJlWHlXeXdxYVRWcUdsUFo2RTBONFdjR1pKOVNHbG5KMXBUOWRO?=
 =?utf-8?B?VTN4TXBTdThZYitTcUdUTUxHb1cwd2hmeEJkWDdsU3liUk5Ca2xJd0VIRDRV?=
 =?utf-8?B?TGVNQk8wN2d1Q1RuNitZNWcreFNkNXh5YUNYZExpWWl6ZTN2dk5jWG9DYytM?=
 =?utf-8?B?bkxIWFYvalNLdXFlcEpsSEVpTG8rNkNjdnFNYTJTN2pYQ1dDWkZFQzZzdWx3?=
 =?utf-8?B?THlwWlVkUzRNTjZJT1JkMHAwOFhKeXYwSmlHV2IreTAyWC9BRDh6S3pvOGdQ?=
 =?utf-8?B?dmdEWmRsMnRDSytFdlZMOFZNRWtvQXRGZWVwTkRTdWtZVG14anRiN1RmUzZV?=
 =?utf-8?B?UUN5Y2lleXN4b1AxdTkyQ3NadUVEcVJOenVuREJ4aGNhd0F2VHhqeXBlY0Nh?=
 =?utf-8?B?ZWVuM0RBS3hha1RlZUJIalo0TkNhM2pkb3JlSlBIL0hlOHdaR1ZKTWt3Q2Rm?=
 =?utf-8?B?Rk9BM2xaMTlua1FmL3FyNjBxWVhKWE1wOTc0T29JeUtUZ0ZFVWVnZDd2MXFa?=
 =?utf-8?B?VDZxZjMzNnBabVVlb3N2OGhBWnhlVEpFbFZLNi9pUUtwVDdtZjBrd0RXaXRR?=
 =?utf-8?B?MEhwSURiUG96ZjF6S0NqV2lWTTZxRnNicHRkbS81U2JmOFoxR2cvdk42UDBs?=
 =?utf-8?B?NUxOOTd6RUk4TXdDUlU1Y3ljeGtqNWlKaytid2dQc3JsYnRYQUlqN2F3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWptOUFJM3hpQTN3SDllZmpHVWRWeUxTdDVTajVmTGVmUzJaVlZTdHZEcU5Q?=
 =?utf-8?B?WCtrSkU2bDBtRFVDM3BWbUt2YUx2K1RsdWdhVzdDRTc2NTB1MWhDZ0VwV3pv?=
 =?utf-8?B?TWtGWmt0SEVLbko1amNtU3I1TDFqQmh1U0JBTm5rVDFCOEpGVUJHNDkyVExl?=
 =?utf-8?B?eDRlMlpBbUM4RmNQTDNhWjNCVUFlLzFPSUhFUnBnZ092eFd6NEFqTnpCWWJ5?=
 =?utf-8?B?VXJWeFdxS3BHZ1kzemJmdFVoMHI4MGEvK1VRSGQweXhkY0tTd0wvL0pJY2pW?=
 =?utf-8?B?aEJMQVhTUkFvdEFLNVZRQkR3RTVBOGF4dXcvT2JRT0NQVjF3OVNBVDFSQTlI?=
 =?utf-8?B?RVczUmlRdmZHeDA0UHYrUklDT0o2L25nRlRoN2tNRGxtSE5QVzYwWTF1bURR?=
 =?utf-8?B?VWJ5MUFRYUE2SzRsY3lrTXVXMld2V0M5VlZVbngyL0lIQ2Z1TVpTWkdXWUN2?=
 =?utf-8?B?bXRCdmYxMWRaVHJkclpreVM1Q0JZRldLRkh1dm9iQlcrWVdZSEs4bDEwZmJx?=
 =?utf-8?B?SXlCUVlqTkQwbTlYb3dDUzEyNkNCMXUydDJsRE1oSkhoUUR1ZzlTdlVjR2Jm?=
 =?utf-8?B?aG1vV1pLOXJZaFA3YkRqODZ6TFFSdEVDakFENXY1c0VYd2VJTnM2akVsRUVv?=
 =?utf-8?B?aUlQcGNVKzlnYXc4RW1tMUxuSmZqVUZTZWFMQldtbjZYNlB4a3FDWXVOY3VU?=
 =?utf-8?B?ajFFWS9vMWtEWXNMTC9HM0p0cC84WW11SHVOTGVic0hTWlduNUxYSkxwSjJB?=
 =?utf-8?B?cmI4aXJjRHBtSDkva0dRVXNFKzlhM2M2bnV2bHF4ZjBQaXgrdGkrZGxUamJI?=
 =?utf-8?B?NFlRMnFlcitNMzB6SE9yNnBaeWtzWWNCV3dwRGVQQ0t3UDB0QlNRQTlONWNl?=
 =?utf-8?B?VEtraFF4Rzd0WUg4WmxhS29NRVQyT3FDUk9NVTNwN0JsYTBwRFRKWHZ5dDVo?=
 =?utf-8?B?b2c4a3NreHFxWDZQRlVvNEpzaG0wZEh3d2lDQlg5YnJKMWNtUU9YNTJFYWFW?=
 =?utf-8?B?TE5YcGk1VVZFdTA3TzY5SDI5S0syVVZLSklLWXNlcEh0dExFWk9GeXRheWhB?=
 =?utf-8?B?MlRMUHlNRStKeTJLWUxNUkROaWxCRVJKSndxNHk0UGVOYnQ4R1NYOHZVaWdI?=
 =?utf-8?B?WUJSVzVpUGJPUlZDeEE2cnNHRjlJQmp5REZVeWI4RExobXFQUHJPeCsvZ3E0?=
 =?utf-8?B?UXJBeW5ONkNiRkJOaVZCMDNrVHp6bzY1Zjc5bnh6QnRIWXlIZEpOZlhsMG44?=
 =?utf-8?B?bDRncUZuajNSeVVCQldjLzdTQ282TS9pUVZXOTBvb0tYWmdtL3dLNWg5Mnhq?=
 =?utf-8?B?bUJhSXhndHBpdnJZcGVFNE0xazQzUWUyUTYyL0dxbCsyN21LQjFPTnVPVEZm?=
 =?utf-8?B?VW0rVHhnWDV0d1JuVHpQT1JlMW1mZ3NscU8zNUNSVndkK0xUdWg4SUF1NlIv?=
 =?utf-8?B?R1A4d3pwMjI1OEdaRXRQQ2d6LzNiZ2d3aGRwWHoxcnQ5azM0bFNEWjNIR2Iv?=
 =?utf-8?B?dGtkTllKdXROcEE1TDhlODRTY3M1UitDU0hTZ0NpbWhScjhTZklQbzFSMzRv?=
 =?utf-8?B?QWVialltbjVyaVdRaEZjeDc0ZkpTTmtsQ0Yrckt1NW1KTUZyaFA4WjVBODc1?=
 =?utf-8?B?MHkydXpuTUJGL1VIcFdZV0RFTndydis0Z1dYR0h3UVp3SFB5dzNIWk9CMXN0?=
 =?utf-8?B?RjRmT0FqaW1kM05SdnRNUHkrVTd2SFdGMGJtcjdqWUhvYUNsVWxZdmNiMXVW?=
 =?utf-8?B?SmQ3WitKV3V4YS9KRUl3VVFCWnVpUmhoeDBUVHNUOGY2RDZQeW9UTno2d0RK?=
 =?utf-8?B?UFNhODdSR0JIK2NSM3FWaXFFRkF3dVpueUlTczFmUmdoc1A4U2ZWSzlZZXZm?=
 =?utf-8?B?NVgrMU9jd2RKUUFTOTFTZnA5UnlkY25xTk05UHVETGhRcnNDaGxNT3ZmS0s0?=
 =?utf-8?B?YzBGSkxiMHhxY0NvTmtieFpKU0RxZkFsYlFuSzVLRzZ5Um1pVnRKaHpFVkRr?=
 =?utf-8?B?NnRNV1plYkVHN21EL1FVcnYyYVdlSEJUcEhsdmF0dWd5cXRtMk5yeDcxU1A5?=
 =?utf-8?B?amlKWEtldmdxcGMzUFVrVmxyTE1iMWYxMC84eVdvQ1ZWaVJQdFhNQmNIOEZU?=
 =?utf-8?Q?zBxs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1564d4a7-698b-45aa-a8c3-08dcde5fcb51
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:16:59.5666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q82GeNhSQj/2y4wRt5jUXVazonv+yuwU4z6XhC6LAiRfjlK+KKCCV/14pxbgRd2b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750

Hi Reinette,


On 9/19/24 12:31, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> In mbm_cntr_assign mode, the hardware counter should be assigned to read
>> the MBM events.
>>
>> Report "Unassigned" in case the user attempts to read the events without
>> assigning the counter.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v7: Moved the documentation under "mon_data".
>>     Updated the text little bit.
>>
>> v6: Added more explaination in the resctrl.rst
>>     Added checks to detect "Unassigned" before reading RMID.
>>
>> v5: New patch.
>> ---
>>  Documentation/arch/x86/resctrl.rst        | 10 ++++++++++
>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++++++-
>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 3e9302971faf..ff5397d19704 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -417,6 +417,16 @@ When monitoring is enabled all MON groups will also contain:
>>  	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>>  	where "YY" is the node number.
>>  
>> +	The mbm_cntr_assign mode allows users to assign a hardware counter
>> +	to an RMID-event pair, enabling bandwidth monitoring for as long
>> +	as the counter remains assigned. The hardware will continue tracking
>> +	the assigned RMID until the user manually unassigns it, ensuring
>> +	that counters are not reset during this period. With a limited number
>> +	of counters, the system may run out of assignable resources. In
>> +	mbm_cntr_assign mode, MBM event counters will return "Unassigned"
>> +	if the counter is not allocated to the event when read. Users must
>> +	manually assign a counter to read the events.
>> +
> 
> Please consider how this text could also be relevant to soft-ABMC.

It mostly applies to soft-ABMC also. Minor tweaking may be required.
How about?

"When supported the 'mbm_cntr_assign' mode allows users to assign a
hardware counter to RMID, event pair, enabling bandwidth monitoring for as
long as the counter remains assigned. The hardware will continue tracking
the assigned RMID until the user manually unassigns it, ensuring
that counters are not reset during this period. With a limited number
of counters, the system may run out of assignable counters at some point.
In that case, MBM event counters will return "Unassigned" when the event
when read. Users must manually assign a counter to read the events."


> 
>>  "mon_hw_id":
>>  	Available only with debug option. The identifier used by hardware
>>  	for the monitor group. On x86 this is the RMID.
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 50fa1fe9a073..fc19b1d131b2 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -562,7 +562,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>>  	struct rdtgroup *rdtgrp;
>>  	struct rdt_resource *r;
>>  	union mon_data_bits md;
>> -	int ret = 0;
>> +	int ret = 0, index;
>>  
>>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>  	if (!rdtgrp) {
>> @@ -576,6 +576,15 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>>  	evtid = md.u.evtid;
>>  	r = &rdt_resources_all[resid].r_resctrl;
>>  
>> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) && evtid != QOS_L3_OCCUP_EVENT_ID) {
>> +		index = mon_event_config_index_get(evtid);
> 
> This should use MBM_EVENT_ARRAY_INDEX, not the arch index.

Sure.

> 
>> +		if (index != INVALID_CONFIG_INDEX &&
>> +		    rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET) {
>> +			rr.err = -ENOENT;
>> +			goto checkresult;
>> +		}
>> +	}
>> +
>>  	if (md.u.sum) {
>>  		/*
>>  		 * This file requires summing across all domains that share
>> @@ -613,6 +622,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>>  		seq_puts(m, "Error\n");
>>  	else if (rr.err == -EINVAL)
>>  		seq_puts(m, "Unavailable\n");
>> +	else if (rr.err == -ENOENT)
>> +		seq_puts(m, "Unassigned\n");
>>  	else
>>  		seq_printf(m, "%llu\n", rr.val);
>>  
> 
> Reinette
> 

-- 
Thanks
Babu Moger


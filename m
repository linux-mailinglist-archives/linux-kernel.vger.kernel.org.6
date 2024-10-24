Return-Path: <linux-kernel+bounces-379176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E619ADB15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3807D1C217D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85A116FF4E;
	Thu, 24 Oct 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kkcre+xg"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE459155308
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729745018; cv=fail; b=O5shRgb0bHDVRylvyqevOq79UT5xZwYzNDqmpi3nqSakAT3MVqcn9cWxGLMwXJkE3FII0hR6OngrqFEBbRpF2o7J3cepn9SmcNWiMj17gdSDkkMOT+Xb4zRepl3/c9rWLnHA210RjmK4c2vHVYHsfMH18mzBCq2u3Mv5imdhhes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729745018; c=relaxed/simple;
	bh=mOt7WCvmVjVn3EBU2uQGlsk8oy48IZN8KtG7hAoCaHQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HLVxO7cicldZYfh/douCJpHVPyIe3NewrVTwaXA7oBu485hg6i1N0Em3HBulA/40PZAzaTdyX1gwH26YqhPvlmqhV0MnXClMBeHp5JBCNfQ9ceiqER73aZmK+oERkRaIAP4yC7RtLD1PqrUecM5vGBJq3MlzCsn8ob8+XWPeIHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kkcre+xg; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1hx7VZIeFIBp4NVNq+YPBljhztKovstlSZeLcvVVWWbW2m5F0H8MBvNolrhjaOgW6x0d8k6jG4SyEShAeKzLNj/2srpYXl0qHnjv9b2SxWx+MU+l/YtQB35bYXGwiL/5OXHRdoeWcJKmLjpFU7oc3dVdUuUpKJnahbJrMgWOcriNGAWYpzKjnj7y1OgtiqGKoQUzqHA+9GNnBfW6Fgc9mwArBHmopbUU2psn7h/35E9VQA/1W9vbsk/R2OTQSDWbASS0hkvwn1JZ/lGwwcNIVpHvVogbWGdc5cpJxBl3DqiHqz41JohN5mutFENVvlfIdnDF6/3D7lOvAuQGGaE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVYspT7PEug5iQKHcLev9UH1571eITi0MQcHjkVRjjE=;
 b=uTXivke9S4xrquGkZerCv9+jZWz5HDlq+c9JR5+4jeZ80xTxstNjPNymke7dag2QqMmFlpv5U2j0W7j9pkjhLD4QwPIA7/WMrMWOibITnmp8eHNJISf1p2TJMTK+dhGCCPQyRdUWmYuW/9p3Ls0hnKeFRudOz0SFtwtNQLU4h/fW226ulCIS0qQN8ZJ0zlHP6wPMUl0EA+B86my0Fxvh6YtGzXU0Zr/VpyX0sCVmf1N3e9ZIBxqedgsZjE8YIoE4FcJuYqOpz5D64X1PfU8jNxIT63kAiys7ATGkeq0Ph74uqnwrU2U2sf9h+jazQMrLniry8kxSk+td5SB7WeDnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVYspT7PEug5iQKHcLev9UH1571eITi0MQcHjkVRjjE=;
 b=Kkcre+xgs1xo/n4z5Ahxuyd90dRAMI7iAyUDvpdntQ9wtXpXkX6gGZKwhB5pJVcXsFAnJL2St4U3C3nT/UqWvUqi3NlHw8h9LTqCT/jhu2RsLr5Z7Ydi5y8CbZdGqvFNVzsy/cmu/dU18rOzIW7fJWJtj+USaRwFB6lp7mnuYg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 04:43:34 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 04:43:33 +0000
Message-ID: <9da44581-9a87-4ee8-9d45-ccd74283bdf7@amd.com>
Date: Thu, 24 Oct 2024 10:13:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] perf/core: Add PERF_FORMAT_DROPPED
To: Namhyung Kim <namhyung@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241023000928.957077-1-namhyung@kernel.org>
 <20241023000928.957077-2-namhyung@kernel.org> <87ed472i6b.fsf@mail.lhotse>
 <ZxlA2ZXbzg5dlKhM@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZxlA2ZXbzg5dlKhM@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::22) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: b23d6dfd-24e4-4ea7-de7c-08dcf3e66a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWhsK0NGbVJtWFRvRnFNbVorOHlaU01MTTVIcUwzWVJBMGtSWWczWlZKcVhk?=
 =?utf-8?B?dFdZRDhTeWlYMDJVRGw5YkRBY3AwNmpNMmpycStycUxzRXAvTFExYzhTMVIy?=
 =?utf-8?B?MTBDZDlyNk9xQUQwSUkyZ3NSZTBUVE5iZTlzOHU3d2VuTkp3UDJnTm9meG5S?=
 =?utf-8?B?SkVBaEtrbnJzeDl5ZXhSQUNoK1BrSzFPYXZHa2NNRy9RQkE2d3NGZUx5RkNk?=
 =?utf-8?B?ejdaVEQxZ2NyVzRNOHgwU0NpSEsyV2gyRi9HTEtJZWduaklmb2k1YWRBR3Rn?=
 =?utf-8?B?bW03cHpydmxYaWRDYkRieUJhRDNYMks1amR0MEo0RGk4NU95RXN5NkJ1NDBw?=
 =?utf-8?B?YjFrblVDTG80TjdORUFWdlAzTUh3ZVBMZmZ5Sm9xZVZNTTNRbEdOZXFtclJT?=
 =?utf-8?B?TGV6dXkyTC9FclQxQ2ZGaGRxdEVuVHdWako5SFFHMGFrZGxidVlvWjI3NHNS?=
 =?utf-8?B?bjc1dGUvemdaOVRoK25od0t4Zm1oUGFnOStBeThnRFdPaVpQbU9FOXBUVmVJ?=
 =?utf-8?B?Nm9MNG1SU1ZaYWllUWdsZDNWNEl0dmZ4Qnp2ZXdBdnVubDRBazVzcDk0NTBa?=
 =?utf-8?B?NGovYWQwS0hpNWQrVVBYeFJ2THVZMEZlUStpZ290UTJaNWxUNHYwZjhIUnZx?=
 =?utf-8?B?c2U2WDRoZW5Pc2FoOXQ5dER6VU1DenpIRGUzRzdnL1AxUXRHdzNkTnpySTY5?=
 =?utf-8?B?MGNBakJCa2FuV01CRm0wR1dBUW5iUXhjQWo4MzhSR2tlMWZGMzI5RnlJUkpX?=
 =?utf-8?B?VzJXNENMT0RDOHBjY3dhNUtiVFBRcm5VbnNCYjI0bjJsNU9LaGwrNFVMK2Z4?=
 =?utf-8?B?K0txWkZDU2EwdGhkR01OZWYvRDVOWDFXNDhac25aNDBjS1QwVmpuWDVvUkxV?=
 =?utf-8?B?d2paVVJ0b1Rtdm9heVIvbXBpWTA1dGJ6ZkdDTTdyL2pzTVBwZFpEeEJUT3cx?=
 =?utf-8?B?WThvNzNBa1g0VWhCOFBTdmJwRVd6OUx5OWFNaTBpcnVPa3ZhdWp6eWhveDhz?=
 =?utf-8?B?bS9qdXN4ZzlPZnNoY1dnSE1nNGFGZ0tIYVhWcThqNXgyODlIeWhZYUVuMjVi?=
 =?utf-8?B?ck9lWDNScDVtQzNMbkZuSnVxdDNJTDF5Z1NnNTQ0UnVMbXA4NWZFRTNSejZI?=
 =?utf-8?B?NjZ5SzhwRUt2SWtCVGYxbzlCSmliNDQ0WG9DdndjTlh3anQ5VmR3dkN6KytW?=
 =?utf-8?B?ckg3MWU1Y1JFdnM1TjBrYXFsN0R5VnBiTElBWEtwcm0yODVlQ2RQdHhpdlBh?=
 =?utf-8?B?azdVS2dlWVlDMkxreXlyN2lRVGZQQngyZFdiWm1xem11d0RPdWdiMXRFOVVN?=
 =?utf-8?B?K2c5UTZkeVZxVEcwb2pHd1llSWNYZG5iS3FTd01MdTl6dmdKUXU4b1NsMGI5?=
 =?utf-8?B?TWtwOHNrNTM0NnRuVkluajRVdlI4Z01ZUDNTWFNXNWRwVll5Y080cmh3NDFY?=
 =?utf-8?B?eXRIQlhQQU5vZFZpVnR4citjWnY1Q05PbkxVQ2htQkJCZEJ3c083dVgrZWN0?=
 =?utf-8?B?ZzMxTmhBV24wTlgyTFdUNG11RWFwUzVMZUJMK2krK1BPQ1NMVXlIWGlWTDFt?=
 =?utf-8?B?MUN4S3p0bUhOM1QyL3luM0hlSm9UbS8wUmNiNHU4T3FmaWh4SG9aak1jYm9u?=
 =?utf-8?B?ckgrazUvRzk3cVh1NGRPYm9ma2RvbHlSNENiaUZwckxGUkpLM05Xa24ydHZB?=
 =?utf-8?B?Y3hrQ1B4OU1UejB4REdTN2h5U01Cc3RpMTJVVEk3em0wN09obVVSVHlHVk1U?=
 =?utf-8?Q?97Im8tlQr/RRxOcYNdFNZhMuihtb4UrYNm5sZsU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGdyZXBwdnVEVUxwell2OUVWdVBaQUdmNDQzUEhFNlRoSkg3cFVWblQrUEJI?=
 =?utf-8?B?Z0xKNVcvdW9WV05QTVRFbUZmM0dIU1g1U2g4em00d05vSlR6YmlzMVlaMHBt?=
 =?utf-8?B?NHlpOG01QysyRDBOY3NLNXQ3eEl4d01iSitaSFczMWU5bk81cGxxOTBtYUVE?=
 =?utf-8?B?YXlYWDZxUjFMUVdtaXNEWlJlWm1tVVp2RDdqQyt6azlqTi8vbW00WmVzUXFV?=
 =?utf-8?B?NzhOcEVsbHZiUGhCeXlmbUtCMGxuVHU0aEduLzExaUJLeCtSTEJKSHlBY2Qy?=
 =?utf-8?B?eWpMeEdhQnBqWkpQd0lyaUFoeXo0S09VS01pWTFOclY1c2xlRXlvRGdublZy?=
 =?utf-8?B?TlArNGJrMzk4V2pxOW5oNEhoaTF6R0Q0Z1V1a0c2SnR0czBUU0trdjRlTFgw?=
 =?utf-8?B?RVQreFUycmViZU9VakV3TER2K3ZtZXQzNVoyR1YycnBIUW4wQVMyby9KTDg3?=
 =?utf-8?B?NzgxMzhaUlUyekZQTklNYjAxT09BV2pBQWZmeVhLam1LZitxUzdkV01DNWo3?=
 =?utf-8?B?NnlaM2xqWEFOQ256MmYxU2swUy9EYnlodUxaRmhlZVlmM3FnR21PUFNUV1JT?=
 =?utf-8?B?ekt0L0RLbmtvWkRWVzRIVDJQNVo2cS9wL21QYVk5UDZPVEFSTU5lalpoVFpp?=
 =?utf-8?B?WXVYU2tsQmpnM1JTMlJyUS9vT0xtYW1OVW9xQ0tFUGxZd0pQU0I3YkhSckJl?=
 =?utf-8?B?MFMvQ0M0QVVWdHRjeUI2ejRkNGtIOXdzR1Z5b3ZkT25xZGVkVHdva2JqaHMy?=
 =?utf-8?B?TTIyajZtV1hRT1dsbkEvSTRQNUJJWnZ6dVFaWjZIZCt4YmhnbXhkTkdSM0xP?=
 =?utf-8?B?d1BEeW0xTkFVMWY0akVXS1BIWlU3NUdEUFZWL0gwNGU1TmxLTjRjNE1oOTZ2?=
 =?utf-8?B?d3RudEpMZm5vRU1RcGlCbWpCbDhLUk9aUE52aVd6YjZWSE5lalQxcERpWFl4?=
 =?utf-8?B?K0IyS08vektMWkU3ZHAwSW50TUFwNjJkS3RpdDVaQnB3UFpNSFRSMGNsZnkw?=
 =?utf-8?B?d0FQMXZqQTdSUG9MYnFiN01JMUE0bUo4dHZnN3lhaVI1eUFqZTJBNURBMjhm?=
 =?utf-8?B?VXN0ZlhUWGd3cUt5aUVWOUN5ZmsxMFdiQld5QkYzSU5yN2k5TUFRQTRra3lK?=
 =?utf-8?B?QU8rL3pybFdkVkRnZjJuN0d6MnhTVGIzRkJvd3EybHA1VVJxd3dMRmRqWjdG?=
 =?utf-8?B?bGdkdXNZa1Y2UFdRdGZOSjgrQlBxNWZRaDg3elY3NDRUWGlxSmxkMTJxMjd4?=
 =?utf-8?B?MHUzY3hheTNMWDRFUFlCNWlIbVlVME5JSXBEcDdFanRsTjQzNGdQVlh2Vkxs?=
 =?utf-8?B?STNZa1k0OWZzREp2NnVqYVNjUm9hOE5ZZU8vUi91U1UzUnRydVZUMUxJbHBY?=
 =?utf-8?B?NHVWVDh2UndaQmxkZGUvczFhaTRsVzZBM2hwMTQyeVdoRUdMUEFHL2s5M0Ra?=
 =?utf-8?B?M0ZITEFJV0pmZWJZeFczM2MyQlIzaTVINXRSd2JBWDNGcjE3dHBXMnFKVVVY?=
 =?utf-8?B?TmR3dzBqemRvMEpJRkdFSEFncGhzOG9SYXJrQlptYkhVTU9Ld3lyQmdTRXJn?=
 =?utf-8?B?UlFZTktKNmNtellLMDhkdzFIRUFLU1V3eUZTendFWHlJbm00NkpQd1libHVN?=
 =?utf-8?B?Zys1UjhKbCtYLzVnSkJqNHN3N2RUSC94TldMNzFxaEdlZDZHa1JVdmxkcDRC?=
 =?utf-8?B?T2wwK2xSa3QxL3ArTnMyTTRXZ0loRXNWRHA1eFB6bzBMMGNiYTFtVThGQjda?=
 =?utf-8?B?Ym5rZkN3U2tRWjhaZlRabnFQOG1rQnNDNmVWNHdMYVdZYWRIQ1I0ajlQak9p?=
 =?utf-8?B?WEhkdUJ4Q1JlTnBFTXE5NGNVYmNidjJtQVFjcVJSc0RtWlJvUzYza1RLVTFS?=
 =?utf-8?B?V0I0S1FPNEVDZ0FnL1RzNWM1THMraHhnUHVwT3daSHduRUVVeHlDa1RFUERz?=
 =?utf-8?B?SVpFNENlbUJMNGpCMW04R1pQL0RJeHlXR2N4VnZCMlNFTGw0RDhJMU9BL0tW?=
 =?utf-8?B?ZWUxKzA0ZVE1dlJSd2g0ZTgySTV3M1A4c2RMQUVQUEZDOFJkdGJjU0ZyMUlV?=
 =?utf-8?B?QldsaS9EdDVTSmdTQnZrRVpPbDZ5dGFRUWVsWEhIM3lidC9IMUpCYVE3eGtp?=
 =?utf-8?Q?NtV76QzG35kVBtsOK9qhrET9F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23d6dfd-24e4-4ea7-de7c-08dcf3e66a89
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 04:43:33.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HX6M/7LBUyQO2QATOtcMwdMErfbYItlxjD9hv7/Uqy0lbRhgdXSwXqu3qiodVlRBPivoZIYBOx6BeZjrNijzkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699

>>> When a perf_event is dropped due to some kind of (SW-based) filter, it
>>> won't generate sample data.  For example, software events drops samples
>>> when it doesn't match to privilege from exclude_{user,kernel}.
>>>
>>> In order to account such dropped samples, add a new counter in the
>>> perf_event, and let users can read(2) the number with the new
>>> PERF_FORMAT_DROPPED like the lost sample count.
>>
>> Are we sure there's no scenario where exposing the dropped event count
>> gives an unprivileged user a way to probe what's happening in the
>> kernel, which is supposed to be prevented by exclude_kernel?
>>
>> Clearly it provides an attacker with some information, ie. the event
>> fired in the kernel and was dropped.
>>
>> For most events that's not very interesting, but for some maybe it could
>> be a useful signal?
> 
> Hmm.. good point.  It'd give some information to users.  I'm not sure
> how much impact it'd have, but there are some folks who want to know
> exact number of samples including dropped ones to reconstruct total
> period for the monitoring session.

Can we restrict PERF_FORMAT_DROPPED to perfmon_capable() if it's a
genuine problem? Or would it defeat the whole purpose of _DROPPED
count?

Thanks,
Ravi


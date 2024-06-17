Return-Path: <linux-kernel+bounces-216749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF42A90A605
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786BE285D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C79186294;
	Mon, 17 Jun 2024 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s5cFrF5B"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369079D3;
	Mon, 17 Jun 2024 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718606203; cv=fail; b=hnSXc29lDsjRHZSa7RjKnnZFr3StlKxWMiMH7WU5l63mlfhC3PSwtaOo5+g7EvxjQBHsNnu2PKgeMhrfARLnu3LGQGyanq/8HnLBaA5BnTQxNT+sN4EzsWXK6dexGrYe7gpiz5SkC6T0yjhBEgwqMUR/mDUsHXnWeYaNj6cs3dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718606203; c=relaxed/simple;
	bh=5NEG8HudCLyy/W91E28UmEZEUA8vUrJO2fIvXCQKths=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lBufoWt4ZXNVWZCgia1Qtq6A0CCvOd9V9SXvR3ecDH5RAO5k0V6jZcVJFTTgdSqVpFCnPpklLbnozvlr9OTZyIMUXqy2HJ4XxDTuv1Qf4pzAthRGGQTo7CbRk++P2Gz5+h5Fh/dqy1WNTVv+XBxcaeyJrWBy3H+2mtBEkg1fPig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s5cFrF5B; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlnksCqutNm5ceqavl4cicxsOAJiKwfB5h2iSswNHcI3yx+LEF3/S/dcrYAF4EeNYgSWIrSxRmu09Goa/WqWoggNwadnixykvLQ34jZXVTJ2ZHaaMbMIlH7snH7ShdoMzxbVsmGyHv/2VG/teitNrirKzqBNbwICXZFV6G1YzBiz7DK4veVcx1nfCafPvvKyrhqirkv/DyCcU82MxIchRjby36TP/wcfVC8ENXyFgxFF28lB1m0XtHBYdBxWMmQO/djppz8q9tFsbDR8Dc21Z5ONUcA01ieCR6nBicoU0VsR4HOfOvY3oSPX7toHyLRiU308e/ddR+Bt/E47s+71zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VDv9o99RY9oSCbFyXqrs6+Jk9SELelI6KcNYYlkVYc=;
 b=D1nLHAOqIFL1KmncdEehbUnMq25E12YpmN790clIdS3hI/xKutupdLPXvz/XEWiA+cgtA+xgFoDJynl9NILd3hXENBX8X3ES7ab8Rlx7YrITRa4onfAXOtpUKWdQ0HvSKwG3K2PBUdl3CzPetyShaU+dQGk1FoWiStsv/mrugmOu4tWq42NO5D/sKO+IDd3K61rU8EmSdaoqovFGXb8xG2BMZcPhHx2YLqaLBqyEUIP8QI23df/P/+aPC1r4p8uWKmCpmer5/teB58YfGvPiD3LFJUZ6dx9Lsx5BYoBSYxg+qtblh+uPsVjUqyGmjb7FNA2eLE0Nb9rCGceoBAgM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VDv9o99RY9oSCbFyXqrs6+Jk9SELelI6KcNYYlkVYc=;
 b=s5cFrF5BDylCAfD6iiEP6iZtRVB0jCUhlIG13u3Du0o5N5CEa7TsxCxQS7EmWFhn/6+sdI16sKxEze2F4JxzpTYmGykuPWwGL/x9LNiv2yjX8W/LiPdj+TrfbQfA+qEDGRoE1U5qRa5ZlZ2Wy47dSa8rFvtnBx226cyS4JHiPsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 06:36:39 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 06:36:39 +0000
Message-ID: <adda874b-73b9-4684-aae7-7c9856f22f84@amd.com>
Date: Mon, 17 Jun 2024 08:36:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] arm64: zynqmp: Update description for Kria
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <cover.1716802450.git.michal.simek@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c495c29-467b-4764-6b3e-08dc8e97d7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjRNUVpxY1dPd0NKdVBKRUFkTWsvcDd4bFpIZ3ZCRnRyOEVseHBaMjd1RHVP?=
 =?utf-8?B?U2lQdXFNaUZRcXZ3enVKUmhpL0tJb3RtdEtheU1kUWlmZnc4KzFRYlJDZm5V?=
 =?utf-8?B?U3c0RmV3TkozQ0VWT1hPUGxGbFB6L1VFemRNV3dEY3Q1UTJoWXVKang4cG9P?=
 =?utf-8?B?VW5GQTFCWThrRnBCTENmeHg2N3ZWSVNyOEhxbzBzalpPNDQ2aHFvRHVYTFlO?=
 =?utf-8?B?RG0xb1czT0dEejBINnBVWVh6UzFCOFZKQlg1ZnB1V1VUTTR2dWkyRGlONDVY?=
 =?utf-8?B?YjhBMmZoeFJ0cjVlMlZGKys2Q2FlTkJKSHpPK0gyUHg2ZG83Tnk0b0ZMcWFZ?=
 =?utf-8?B?UTZGRm52QXZ6bHBkQXphNzg3YVBsQkhsMlVJMHhMTVAzODlHbEZnQjJPdnlN?=
 =?utf-8?B?bFlXU00xTEhEZ3NYSitnTjFBUDlFOXI1RXJuM0JSYkJRaTJVWnl1WTFkMHpG?=
 =?utf-8?B?NURGKzlnWnJZWnQzSGt4aytqcUhCSUtEM0dtUnFNOVFvSnUvM05PaDJ5NWk3?=
 =?utf-8?B?TEhDU1FycTdPSGdvbE92ZVZVK2I4N3g3WTc1Q0k3YVNtRTVEMklXTWY2Q3Jw?=
 =?utf-8?B?WmR3bWJudDM5dE5QSUtpMS9jMVFJaG01WlUzSVpxcmhTa1V4enRReWF0eDh1?=
 =?utf-8?B?dlY5YzRZUC9XUjI0ZFhWaDQ5WnFQZkV1QmpZL2ZVSXd6dTFtYUxnUGgra25C?=
 =?utf-8?B?STBFS25TK2RWZVRkcGRJVmlveUMzUmlxTUFKeVMvWFpNaEp2REkxK0xDdkRv?=
 =?utf-8?B?em01TUFFWS9INjdWL2JGTnYyWnNXUThybzI3ZWl1a1E0RERKUDFNNEFDMk95?=
 =?utf-8?B?TG5Bb3ZiZUpYUlp2TVFvQmxIMVgrR3RaaTVmMWE5OS9PRVhuY25pQVo2Ui9R?=
 =?utf-8?B?V2JMbU9JZ0NxekpkcklKNGpNUnpweFk0RUxLaUk4Vmdjc1VoRUYwKy9kUGJ0?=
 =?utf-8?B?LzV1TTU1azc4SldWRGowRlpYZjlCRkM0VmJLa3BIcUUzQzdUMm9ZZFNMUEZJ?=
 =?utf-8?B?SjBDaUZiYkxxU2RkTi8xS1JuY3p2RFpuNGs5bjRUbzNwWDFqajRibDNnVThq?=
 =?utf-8?B?emtqQ2FNVnhkaThLTEk2WEFoejhTTzUwWFdZVE84blUvY1EvQzBOSEVWQ2J5?=
 =?utf-8?B?a3RUYUdPM25VS0tCUXg2alZpS212QUR6Yk9Ma0huMGYzRnZqb2VjNU1LUUF3?=
 =?utf-8?B?empHd3lUZ1pUZUVIVjZHaVZuUzdiSk9VWWRLZFY4RmkyTUp2M0ZrOFA5dTJQ?=
 =?utf-8?B?UGdOY09LZTlsazZaR3pYRUNCc2xjUytzU1JhbmNrWHBIOHlKQUtSejRTNmNi?=
 =?utf-8?B?MWlTUnlJbXpTVnVxY3A4RGh6RVdsZ2k4QjRsTGJQdU1vSmtKRkR5MDdscVgw?=
 =?utf-8?B?Y2s2bnIzVS8wSUVLMkpxN3pSY25iWWZTRXpwcnZYdG9BZ1k0aFVYUlp0WCtm?=
 =?utf-8?B?bkRocmh3YndtRGhFbUJZbStaWFAvL2V2OVlBWjNGdWNaaUhZdU9RWWVvcU5z?=
 =?utf-8?B?aDRtTVBnbVk1dFhFZUVDQnhwUHpmZE1vbGZ2cFg2OER6cHB5UDFvc0pFNjVo?=
 =?utf-8?B?SDB6TGJrOURieUJKUjByc3lBTnl4UDlVS1NnTjcyOExucmxRcVZUWEVIZ1dR?=
 =?utf-8?B?anhZTWNuK1lTZUQ2bWl0UG5sRGZvdjNhUHJoajN3WVYxOUc2UFY1YjdDczJC?=
 =?utf-8?B?R1dpa3hxQW00NDhCRjNMRGFpRHNBM0ZXTzZmK052LytrY29abk9mMDN0QVhL?=
 =?utf-8?Q?WsemkBj6dzrWkDwtI+YKpL46xafALRGBk+mpxvu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmdEdGE5YzliYjFLQkU0OStrTW42eWcwRDJtNm1MK0FwajA1MmRhZnFNbTBG?=
 =?utf-8?B?NUxGNXlDSmFXenRVUUNIakhFMU1mUFlES0dQbnFRR2xYS2RvdmE3R3dabjN4?=
 =?utf-8?B?UTR6eVZZNTBNMVBJQUV6dkRrcEFrQUFleVJkZDRuR0NmOUUxQlR6ZmxueXBS?=
 =?utf-8?B?NkJRNmE2KzFSWFlFRU1KWVY0aG51Qm9PWWJZZGhqL3l3TzVjdllUR3h2WEVI?=
 =?utf-8?B?VCtLQmtIQXFPSkVMWW4yZVk2OU53NHNjREVFb2p5Y3NmMkQxVFJrMlRlaHh0?=
 =?utf-8?B?elQwemRlSjZhazFBa09ZRTZwdEt1QWVIVGdDdkdaQTRIc1NQTng5VVhRdENj?=
 =?utf-8?B?eGl5VFZKeGVhNXlPN3h4VGZITFBKMGIyc1dnZVRXWkdxLy84UlMxOWF5MnFw?=
 =?utf-8?B?b0J1RldSUkwxWmorREpMQVhJdXhIU1VlMndOUWt1dmY3RUNOVjNjTEVwZ25a?=
 =?utf-8?B?ZHpZbGxOek5KUmlPWWtobFNuTVlGc0hzOG5PRUc4UzB1aXZTVE9XcjNaUmdX?=
 =?utf-8?B?MzZDMG1KNzZmOVh1NWdDUlB5VGxaRFN5OWVhSm5HcXYwSjZCaUNHTytFQkZp?=
 =?utf-8?B?UUU1cTF6SDlkWGV6QzBPVEdiODVYZDM1Vm42b2g0N2xRKzFUQkxyUGlneGxE?=
 =?utf-8?B?a1pUV0dadHllb1M4UGlxc1hGdW9YZG92em1vcUNjSUtER1ZCNmk4SWZoblhk?=
 =?utf-8?B?U2o0bE0xNHZhaGVBR3BCSlN5S2VDSDlFZ2YrTEFjaVNmcHZHR0lDV3UwZWxK?=
 =?utf-8?B?NmJMdjJuMGx4c05PQUt2QzlKdDNqMmkwdmVMNlNvbThLMUxFaG1OdS8xMzVr?=
 =?utf-8?B?RlJ2UVRmaHdwQjBmZXlEMXZzREN4dDIxd3pldEVxUjJkSmczQ2Q5SW9tWDBP?=
 =?utf-8?B?RTZuL2RYNC9oaFg5Y21OblU1eTlsN05pN29nT3duSDQxM2tUc21MTUo0TlRv?=
 =?utf-8?B?TnVtL29aN3BlNHJOWEs3L0NlNTNMSTE0WnVFNW10YUdEbFV5bndyZCtIOTNM?=
 =?utf-8?B?eURQWkJOYWptVndPaDdqbHZZTFhYcE5EbXpkMFJQc3NGTEpuQUhuT2ZYaUdN?=
 =?utf-8?B?S1VveWtuMVk0TFJhcmtIaDZLUVhGL0s1OGRqL3RkTVhxcHBSV0M3cCtObDd0?=
 =?utf-8?B?S0FMOGNsejhaVDFJaitGOVBXTHVINEE2OGIyWXNCVG43UnVmWllsb1cyczU4?=
 =?utf-8?B?UEhBS1ltZXdjbk1lSTdDLzB6RVRVVjk4ZDRWV0p2d0w1eXFmU1dPY0FvUTJW?=
 =?utf-8?B?NDQxaUpPenRVVy9tdlhEc0trNHRXTXhBKzJoWnc2VDU2eTdLN3M1S3dwUll6?=
 =?utf-8?B?K2plWDdySDVia05PZlFQWkg4ZGw2L1Y2b0ZKUjZlYlgva1pZUmo3Q2psMXdE?=
 =?utf-8?B?SHE0TlZJakg5VkpUZjNYbFE1Z3hKUnpNUHpNcGFtVDRjdmRTY2UvTlZSbWxj?=
 =?utf-8?B?NjV0ZG9XRUptbGptZEcxcTRMRmJ5Tmo0MkdJYjBMc0RSc21pZXVYN2xNMStY?=
 =?utf-8?B?MDI4Y29HbnR3OTZhTGl1ejZGb3ZQdDlNdzZOZXI1QWtKcmM1NWdzMzZJRm4y?=
 =?utf-8?B?OFFXWFhOa0JOaUczYWNiNnFvMEZIN2xSbG5BakczYmZVQ0RlSFNGa1VKTHRS?=
 =?utf-8?B?L2pyTnYxSUc1T2FTWVdsamM5TDFEOXhqN2w2QjZYVGtITWRlVEtIcTEyMUNS?=
 =?utf-8?B?TjFjY2FibXJiaHJDL0ZMZi9DNElITlVQNS96SGxKK2N2cDJrL2k2c2NrbnJJ?=
 =?utf-8?B?RXgxSzFNdFZvUnJlSFI1RDlYWlRkN3Izb3JjQjNkWmNRZGlxNmU2a2dyUXZn?=
 =?utf-8?B?UTV4NWtzai9iSmhQSDVvUVVLRC9zS0lCZ243UWh5ZkZETDIzTXBacG1Fc1RM?=
 =?utf-8?B?WURQZzdsemdNTEl0K003WXd6N3hQVHhucXNLZDhOUyt2bCs3NE5IR3Z0SmZa?=
 =?utf-8?B?RTk1NUV1MDVxRGxwRW12NzNWTTMvK2NWUWFCcjNqdm9VRVhQbEVnZWh6OFhu?=
 =?utf-8?B?cXB3Q2xxaVhiMjY3U0hkYVdnWGVVREZ3Y2U3SkFxVkVlbzlsbUxGSnRiTFVp?=
 =?utf-8?B?M25RcTFBd0Uvbi9rNUtjT1gwS2JhZ24rZXFHWXNsb2ZmVG5NbllSTjVCM1ZI?=
 =?utf-8?Q?CeMNM19whScwkP+dalyGirG+N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c495c29-467b-4764-6b3e-08dc8e97d7b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 06:36:39.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTcjNoAR+/oYT/va3+IkxybmcFsXUphd+cJUAhtvWX1mMJGVys9HMsEwwqQtt/xd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091



On 5/27/24 11:34, Michal Simek wrote:
> Hi,
> 
> over last couple of months dt bindings have been updated but dtbs didn't
> reflect it that's why I have created this series to match description used
> in U-Boot to be able to switch to OF_UPSTREAM for ZynqMP platforms.
> There are still small missing part regarding usb peer hub and MTD layouts
> for other boards.
> The rest should be in sync already.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (9):
>    arm64: zynqmp: Align nvmem node with dt schema
>    arm64: zynqmp: Use fpga-region as node name
>    arm64: zynqmp: Add missing description for efuses
>    arm64: zynqmp: Describe USB wakeup interrupt
>    arm64: zynqmp: Describe OCM controller
>    arm64: zynqmp: Remove address/size-cells from ams node
>    arm64: zynqmp: Add compatible string for kv260
>    arm64: zynqmp: Add description for ina260 on kv260
>    arm64: zynqmp: Add support for K26 rev2 boards
> 
> Tejas Bhumkar (1):
>    arm64: zynqmp: Disable Tri-state for SDIO
> 
> Vishal Patel (1):
>    arm64: zynqmp: Add pwm-fan node and fix ttc0 pwm-cells property
> 
> Vishal Sagar (1):
>    arm64: zynqmp: Describe DisplayPort connector for Kria
> 
>   .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 19 +++-
>   .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 41 ++++++++-
>   .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 19 +++-
>   .../boot/dts/xilinx/zynqmp-smk-k26-revA.dts   |  8 +-
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 91 ++++++++++++++++---
>   5 files changed, 156 insertions(+), 22 deletions(-)
> 


Applied.
M


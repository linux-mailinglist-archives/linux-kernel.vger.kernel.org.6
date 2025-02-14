Return-Path: <linux-kernel+bounces-514316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F00A35572
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E559188FCC5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0761519A9;
	Fri, 14 Feb 2025 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o/t4myaO"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B17386334
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739505446; cv=fail; b=kjnlsv9L7+k00mpQUxCzfcYMwFMmRdHtrejnO8dT0yeuxkGXBrMPgQ9b1/VLzUXBoyLNW1x6eg0Y7zsK7ECJgaAE/1IOlgpvjgvXEVASuho8dpPWIfKEVkfwnnYqXt5Y21MZD4NLDC96bebqio0d7x1aRjPqzbOV+Sh7kJ98AKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739505446; c=relaxed/simple;
	bh=6E3IwOi81gL7MrHBgSNEPDQylvvroUzkpgx037YDnxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e2nj+EDpO2F8j/gIL7OBnA8hvej6FPN7nif3nkYkZRyEFXyDJ6geFzPPuC+0XHYSis4yE0kgZJ3D4DrKyZoXefEIoUK5mj4rab2+nrV3DHJwTxeTNaCtHagGXVs+5I/2PZGL3PfakKcEHfFBfzb1tAZC5fNx6e6onzpfT+uxnhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o/t4myaO; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9VnQ1Wa1Ejp43Q+sqcxb9ohGNpCM62RonI0SNCrjn9MhBUVr+O+YTibqVp4t7VfzuDxZI956JZGhqDw5yJwKpNA+UwkjqxkJz/nv7RXAjdw5qqwZ6istxIbGfRTnq9wAewb1Yesn9wgOPjL5i4PfbGNgz+GDuOsqno91xeB/LMGZKEhqoEMVIz4NqlUqGNZ0XsOMuW3PTyBJocUrz7vKZr5hFsjBdnx0R7bEloZr254HPdKOtGOvE9Eu+Z4b//tZpNedllbAikBAT5Iho+TRNLI04uPOYHldbARja+15JUCB/HMyYJsU0PxqJmu0Hw91PCQKYCueYLndqSd1XsyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW/FhBMcbevOtRpYNV9Lwr2VWM6GrTv3HqKxVQV/+CU=;
 b=x+dBaEzBjboecrdui/DTwo6YK6Hzs+nP1jbwCGxxIOj7Oa4BnPoMkAvT0kNg94qukzCNxhRnnFBavuSgNm5bm7AXP42U4x2++HgySjG4iEIZh63wyrfCdADjrNOBuqozlM6OgaX5eTkygThU8wRmq2JdMjbizVip53x7HDOjrEm+r4nQNtPNWAVMH6YgKEcHpDE80vD2oK0dgiRSy5QxLDSr6yPq9wdmgta0oModF1M2HuciQweWLqHPYQhMOE7uDUgY8FiiXlDhrRK+mzc17kIBFNWccbRq6a/rymm5IwLExqOnOYMUAPyBsXRaZME+WZChMgB2uVoVkCGzHtB+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW/FhBMcbevOtRpYNV9Lwr2VWM6GrTv3HqKxVQV/+CU=;
 b=o/t4myaOnxfaLpTrewJ83AiuIgufEO3H+EECQeKp4sdOF6Toni41VMNfE9UTqtnvk86b4xnCiwLeu+vaZNG51X07rMfVAcoBpMObfgYn3yhBmSOyxMJr6HTKolxMIpq1oq+rz3kVvtuZfRNt13kusYcbsPSTdTZB4qedipysqWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Fri, 14 Feb
 2025 03:57:21 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 03:57:21 +0000
Message-ID: <2cf234bc-de9b-4017-a671-710a55e5a35e@amd.com>
Date: Fri, 14 Feb 2025 09:27:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/24] perf: Make perf_pmu_unregister() useable
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.888979808@infradead.org>
 <1f4e4bb1-ba5e-4e5f-b6e3-e7603e3d6b0e@amd.com>
 <20250212124945.GH19118@noisy.programming.kicks-ass.net>
 <57fa247d-9c85-4f20-9723-d568272651f9@amd.com>
 <20250213130833.GH28068@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250213130833.GH28068@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::12) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b09ff1-521b-406b-149b-08dd4cabaebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0dYc2x2TU9ESzZMYWQ0WDc0ZWpXOG9FU2NIRXJsZkVFRzBaeXZTVUtESGpS?=
 =?utf-8?B?N3NSTk02aFd6VG9lak1kR2s0SjI0aGZaWll6S2ZzbWpMWEpVTkxvV3ZxSXM4?=
 =?utf-8?B?RFNBNkFXS1dMR21DWTBkaDMyRytSQ09TZGJMRkNLcm9EaVJIMEpUdnZUeGdr?=
 =?utf-8?B?R3pHOHZBM012anI3RTZBUzlhU056bG82bjVJbXdUbmxnVDk0S2JsK3QzbHFx?=
 =?utf-8?B?MStzRStQNkVuZjNaYXcvWjJFak9EamRjKzJYMFZydUk3czlBRytNY0JsYUlO?=
 =?utf-8?B?ZHJuZkd5L0lnK3FScTQrN0tKcWg3eXNlTVNPQ2N0aHN1cXdFWjNDMmg3U3lz?=
 =?utf-8?B?bThMZ3RKNmtLMDIrTkhMeGJTdW0xUkFMQUVSQzI3bmpESDRoYUE0VXg0d24z?=
 =?utf-8?B?eURFc1ZrZG5KQnRndkhKRmMzYnlrL2pMMFVENjU4Tm9ObEZSanA0ekVhdFA5?=
 =?utf-8?B?VGE1emZpVDJzMXY5bjVqcUo4K1poRzF6NjB2WVNqd0RDRXFNb2ZJc2pMSFVm?=
 =?utf-8?B?aFlUbFBsMXVuSmJYbzlHc2xCYWx2NFRWVVB2VnZjdlcyeHZoYzJ4Z0RBVHBQ?=
 =?utf-8?B?K1RkNFF0c2VqWGpVazVoUFU4TS9wVGttSGxrSGgrTjltbDcySjVzNXFmdmhy?=
 =?utf-8?B?bUpwVFQzMTdQTmRzNHMzaTBKbW0zYzFRL2tLSEdDbGl3VktxTzFMVStmK1lJ?=
 =?utf-8?B?NVZ1RGhObE5NR0xaRnV5dmxMdTREQ2lRRjV6OStPaWdPQkJsa1VNVmJES3dN?=
 =?utf-8?B?WlRQdXVPYnp2bGY3ZWthNjdWRGpSWnduSndoM3hTd3lrOC9HMVY1OVdDR0kr?=
 =?utf-8?B?SE1hWUx6RFlFc0x0YnBxckR1OFlKV0gzVDRiS3VrRDE0bm1McWxBYXU5bkxV?=
 =?utf-8?B?cG1BU2Iyd2Yyc2hqUGp0cFFXNlkwYWltbkhmQ2hCSkJ1V04zbVA2WVFsZnIx?=
 =?utf-8?B?cE5Zb241K1drc0NzV2dETHNIUEFzUTFJNmMvc203SFFrWUpJNllxMjZUdWJP?=
 =?utf-8?B?SHhvWVRldjFPL3ZDUkM3ZXZBRkU5YUJaMFcwR01BVS9TNzNGaktpcmdyZjBu?=
 =?utf-8?B?ajJ2NzVCRDlPbmhOUjJaZWNURm1uTkVkTjN4bkx3TTM1MXZ5MUtkRGhvd25h?=
 =?utf-8?B?d3NHUFlLUkdWdnJhMklHNmJsbGJDMWtoWDBtMDY3aWZCMXhnc2doaUF0aFYv?=
 =?utf-8?B?ZHR2SFJqVW4xZDdYd3pZNzZCUDR0bmRMQmVlajBIWVdwSGlZSmZKN3YrV0Y1?=
 =?utf-8?B?cytBbmY1VEFERjJWbU16MEQrNVdoWlRMYldmYytZd0JrTndGR2JES3FReWpG?=
 =?utf-8?B?eFBnZ212K204YkJzbW9QTlZ4WU1XR3kvYWdUNnkwb0dGSkg2S0FpVTB3NnU2?=
 =?utf-8?B?eDd0NGVnRUw5Mnp0U0w0a28xVlBUZ2JjWGNLcHpVMytiQUFiUHI0ZTJjODVH?=
 =?utf-8?B?Q0FudkNTSXNzdVZvNThpKzhlTkdvYnZjdEEydnhVelg0cE9RN21qYWZ5QU4w?=
 =?utf-8?B?Z01WSTAwTzhHcEN6QkhpVEdJclhEZUpvTVh1UEl6STgybTFpU0cvRHYrK1BP?=
 =?utf-8?B?QXJ6VkdNYkoxOGpxL1JNMEtENWI4c3lDMTZaWm1sQjVlSUsyOHYvREx0Vm0y?=
 =?utf-8?B?bm5BaHc5WTBzeXJHeEs4d3REQ1BmU29nZXJEbnZFR3c1Sm9RNUttb0EraHUy?=
 =?utf-8?B?bGpkdVcxY0hUZ1NJT0kwbUpHejRCazYreko4VnpHVTZKVmNUWmFhMExrcDJH?=
 =?utf-8?B?ZHNjNTN2ODBjamFrNkhWQlM4aHpUc04wUnhzSlpxNW9Fbk9pUThNc2JpNkw4?=
 =?utf-8?B?ZkRBZWc3LytKcGVpR3hIaUhhZVVlME9RZHRmRmpxZWUxZnNCSXQ5VVhwVnBS?=
 =?utf-8?Q?d/7L4uXOFqAqr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1d1bEEwMTYzNWhtbDYyZ2UxRlZMYTEwMDB2TkpieXVkSkRNUjBQYnd0YkN6?=
 =?utf-8?B?V28wMVdlSXNaWmE2SFRVU0JYaFpsU1c2NGthV0ZDS2pldi9tcFF3Vjg4MmpL?=
 =?utf-8?B?a0Z0c3lJZmtQRURpOEZJZ3loNWN1TmhWd2piaXBkWThIRTZLMm0yT1V1Y2tR?=
 =?utf-8?B?UTRmVkJOVTFZMHFMTmZJbHVBOVFpU2ZIQWJoUnRXK2hVeGtvQUxic25DZXlB?=
 =?utf-8?B?R3A4bHZuV3JVQzBMT01QdHpCV0w0aHpaMHNpL3pDdC9uOXZoclo1K2t5U1Jl?=
 =?utf-8?B?WkVBNHV6QUM0ckh0MkdBa2NXTVgzSFVNNWRtak1wTkFSTWtEeksyQzFoY3JQ?=
 =?utf-8?B?cXFOSDBocVA2WlJZQWY2MUlLNGJpaUFVb0lsSDNuay9zSUtHdFgvRWpZYzcv?=
 =?utf-8?B?SldjYzVHRU1EbVphOXo1aVRGSm04RUtIV04xQ2NkVzlNOVRRZVlFNU0xT2p3?=
 =?utf-8?B?bXpFTmpUdHljUUY2WGx0amRCM3ROK25ZRnY0RlRjOFdEd2U3dXBxVzlPZ2px?=
 =?utf-8?B?dG55cDZxVzdyVlU2emF4K2dHYk1La0VMM21ySU0xM2NCQVdBTStvUVlNRVJT?=
 =?utf-8?B?U1ZxQ0pGRVp1Skw3RnFBakpHeitHVDJQMWg1REJXVEJ3bHMwakhjVkJhN3lY?=
 =?utf-8?B?WXBYVjVOTUFQZjhHekdIWm9OUkhLeW5PSmhiTWpINE1nUTZvSzlrMkE0M1A5?=
 =?utf-8?B?WEFBSzJ5ZUU2ZFhEdXBNNVRKbEdwRDc2WVV2ZElLR2h1Zk1QVXhUc1hNWjIx?=
 =?utf-8?B?dzE1ZjU0UWl1R0NCM2pMbWJ3eks2L2tlN3dmREJzbzFJWXc5L0hYK0xQdFhl?=
 =?utf-8?B?aWU5TzRvNGxPS1lGMzJBNWt4RVAyLzRXVU1RY0NrRlZRNG1yOWtxWFhhOWR2?=
 =?utf-8?B?NjU0ck5zWmVDRGZPVWMrak9tSjl4dXM2VXl5MVl3MnlPK2dWQUxkOVljdU1O?=
 =?utf-8?B?MjBmUjh6TWJkVnJvcWpQYnE2bkwrUHVxVVRtQUZwU0NTc3BkVTAxUVlGVXU1?=
 =?utf-8?B?YlBaNFcwNEFBYW14cWVEUE5tYmxqNThuajFmR1hYQnRIOVVmc2p4VlByNGE0?=
 =?utf-8?B?dk9UYWdhS3FaZmwxTG1YcGRpcjNaV2MyMlJ6RUxncnpERGFINWRlUi9Zc3Yv?=
 =?utf-8?B?TWZBdzh0c1ArK1NtQnpCZWdMZkluUEFqVHQ5c0R5dmQ0TnQxV3Y3eWwyUXM1?=
 =?utf-8?B?T2JPSDZpQi9IUWlmQ0l0bEhNK25nZjEzdWRUN014QkMyN3FtTFgwb0NOT2lE?=
 =?utf-8?B?VjZPUDZ4eEJrSnZJamVnbEk3cDNkNTlpbWJ1dHVhTGVzQ2ZUalgvQTBuV2NP?=
 =?utf-8?B?S0ZHK1BLNUdOTUErajE4K2JJWHpxUXR6VWFzb3NwOGNTWlAzam1MR0g0TlpN?=
 =?utf-8?B?UVEzR1NhaFgyRElScEsrTGF3cUtsRFByZmg1a1o0ZUk2M2d5Vi9kQTc1UGlI?=
 =?utf-8?B?UGdIdS9TOFRTK0hiMmUyOEc5aVdBMStxZDhGV2tQdC95cjQyS1E3V0NFa2xD?=
 =?utf-8?B?RGpYdjFnVEhqREdyd01kaDhJTkN4K3NyakoycDNUL1o2QTRxRXBUdElkSWFN?=
 =?utf-8?B?ZlBxTE9DRFFCeWt3WVFkZUJxdHJYOGc4eTVGUWVNbncxUHNCNld4WnRGNUh4?=
 =?utf-8?B?VVJ3TG5kamVrYlV5Q243cVM5WDNYNWh4TktPOVlrN0IzWmVzOWJ2c3RnYU9n?=
 =?utf-8?B?U1JCWHNrbEZ4SGM1MDJreTUwOTZkQW9TenFwNUtSaTIvMnNUNDkweGI5SGdk?=
 =?utf-8?B?RjlUdUN4N1ZIR3NtVkh0Mk9ZT3NNdFZsdjJnUDFYTG0zUEoxZzJ3RGlGYjJJ?=
 =?utf-8?B?SzBuZHFkRmZUeTd5SHpXanFuSkF1bEFuQ2IyVnJLckZLclpKc2JyV0Q0LzlR?=
 =?utf-8?B?UVR0ZXprWDhweWZhRFo1VHh6Mm1WNVNqSjN6clFSdU1RYnpWbHRrSTIzcUt2?=
 =?utf-8?B?ZGNZOXZtbXhJY2JkSmVSd2FvTE10QlBHOHJQZWp1MXhZTzkzcEt2WVVSZ04v?=
 =?utf-8?B?LzBXaE5oSVVWcHpxakFmaHBkNHUrb3hzbi9MQXRIZ05qc3pVTHVrMnZTNTl1?=
 =?utf-8?B?Wk1LeTFMd0JjR2RxUEY2di9jendhcDRXblg0dFlkcVZpV200TStzWFB1Q2NT?=
 =?utf-8?Q?IQpnaaaFGP43004ylBjR3/QC5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b09ff1-521b-406b-149b-08dd4cabaebc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 03:57:21.5642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KG8VfyRkg2VX+tlDkWYxBAHY0Dlw8pz5cGdYPesMpK1oa/lTtpnGtfzzRcIdxFg7tDd+UgUnsoyFAzGC86RTSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870

On 13-Feb-25 6:38 PM, Peter Zijlstra wrote:
> On Thu, Feb 13, 2025 at 01:22:55PM +0530, Ravi Bangoria wrote:
>>> Does this work?
>>>
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -2303,6 +2303,7 @@ static void perf_child_detach(struct per
>>>  
>>>  	sync_child_event(event);
>>>  	list_del_init(&event->child_list);
>>> +	event->parent = NULL;
>>>  }
>>>  
>>>  static bool is_orphaned_event(struct perf_event *event)
>>
>> Apparently not, it ends up with:
>>
>>   ------------[ cut here ]------------
>>   WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:281 event_function+0xd2/0xf0
> 
> Durr, do you have an updated test case?

This one triggered with just perf_fuzzer run (without my tinypmu test).

But in general, to test the whole series, I ran perf_fuzzer simultaneously
with my tinypmu tests:

  term1~$ echo -1 | sudo tee /proc/sys/kernel/perf_event_paranoid; while true; do ./perf_fuzzer; done
  term2~$ cd ~/tinypmu; make clean; make; while true; do sudo bash tinypmu-u.sh; done

Thanks,
Ravi


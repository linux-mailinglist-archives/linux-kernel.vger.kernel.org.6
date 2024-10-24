Return-Path: <linux-kernel+bounces-379227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9287A9ADBB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2128E1F225C9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C011C171E5A;
	Thu, 24 Oct 2024 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IaUJsn/7"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0617BD3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729749915; cv=fail; b=W4uTykcjavAUHS95sMB8bS4O5ypjrSCpwXRRnVU7Gtcp9IMADzh6r0UQ448O4qlGhthY/nIH3aG3A0rp9Sn5UnRhADDiFltf2jhdWZKilAwVgEwG2Usulw0HGNf3rqjPzV+H/Y82ohJq8ngAnI9lfoPkmOGegrJfaGWhCMP7sgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729749915; c=relaxed/simple;
	bh=rk6XWXPy5XsW/sAQkFTUNHInEko2v0wJX00OBbyLArE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FloRPnPFZHDf4RU5ktRYG69NhTfCXIHU1oHBRuy45+ONaXIosXdoseBWU4Zz/GHqbFj+2Yq+BblYH1qOqXnfGGbyA5egtELPdqtUu9+3R79eafGesmAqUW909kzvsIWwOGVwVRtPBUY6lQ+PRO4uwjT1xu3jw94wxjdjIonBYns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IaUJsn/7; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uwrf53X+9ioMN5lhVVjZrikrfkqZ+gZjwFJCWxjOHhiwnFUu0zbjGmCxam5whwrBJ1cbcC0L++4ov7GgoIOooNbhfJncfar0dH9h6AbDULhLEXgvVe4f0NYz8zwQYuL1D2tGxO38zHY93nM1pxOPq94wseGNFEwPheJzlWUWBitNaJCK1FcnKJuAESLNs4gCwslOcTdoq/8kKYLMqYrExZ3h+7HL5d76YGlSEHH5esyG7FOxTM9inQAtqTDJDIqiewbUDs1p1MFTfy6x9Jeek7k7tzBZNZezNoAx+K9s7l+oWBszVIuiPy6UxkZz+iAuH5FXZrVYPllYqJlomLOoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgNZFGCyBOuK6ohICL22tt+0iMfP8KYqvAVfAEAtcoc=;
 b=UqfyXW5Q8IOf0ALJ2fqHXEaNMYF/X3D6/YC4XuOlWrotsdt5dA9I3uQ05QrS+qzat64b/0hUC5ROWIbV2ie2+vjre25V5xaDTMNWbe/SpIsPIlbqZlq5DTumOcOmtlByjVGDwX9D/BECEzZQI14lnhQdcQVB345QsQOgFYskS1XI7rHAlISvIS64hFym6hVDhrKLV1gcYWEmn2cB6mVcWJg8M5V/WUWgBuys6T6QftNVRTZCgaBJxkZTW/lJFP1kKqDehIPmxrSmeArGZheuL6PNrykkuQAOZLI9+LMPoMnWS/w3ZW4w85xADbwQ5veasnLfmjFGytxOXg62u1FShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgNZFGCyBOuK6ohICL22tt+0iMfP8KYqvAVfAEAtcoc=;
 b=IaUJsn/7No440JCvdD/eZFx6p6J8TlurCuXNPzukVvJpzp40Aan5yCZX/YyxiuYudkA3svLqF2QENwzR+/SznhKy5dwJQM4X6vE6KVTrpbN2O9cePCcIapCE92x/jMpgtTSYmp4ylJ/vx2vhOC51F21kMcDY2K0M8rtWHmof/FE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 24 Oct
 2024 06:05:09 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 06:05:09 +0000
Message-ID: <3cbcf862-0608-4174-a286-dc73a9b9fc7c@amd.com>
Date: Thu, 24 Oct 2024 11:35:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] perf: Relax privilege restriction on AMD IBS
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>, Mark Rutland
 <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Namhyung Kim <namhyung@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241023000928.957077-1-namhyung@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20241023000928.957077-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4d) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: f1968ebc-21e3-4c51-7e38-08dcf3f1d0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0JpRTJyZW02Qmp1RWNJdVpkUEE5bWZmYlE1cDVad0pXMnkwOE1SSEs5aFBH?=
 =?utf-8?B?dU40OVhCc1Y0RGRKRWF0RGVpSHA5cStFaHh3QlZaUFh1enc5V29rWktBTUk5?=
 =?utf-8?B?eCsyR3pXcGRwTFpzVm8vRmVLQVRzajZvZ2hTaGx6Yk1xMCt0ZzhvV2pRYXg0?=
 =?utf-8?B?cWw1WHF5aVJPbTZ5QkFZRFVTV2xGTTN5NFdQWFdzZThIU3NRUFFSWTcrQ2pD?=
 =?utf-8?B?T3dQTjJSSDlJQjQ5SkhiT2M2cUtNL0xtcHR3OTFlR3BYcTVZUlEvNzd3NURs?=
 =?utf-8?B?eGdKSHJGczJSTG82RDNIajk5RXpPWlNYWWlmaWdtMlNLZEgzWVBtaFQyYUlD?=
 =?utf-8?B?WWlKVDB2N1o5d3lKMzNjSmp6aE9KeTVvVEh4TEtnT3dieUlrQVdnM1E2d3hh?=
 =?utf-8?B?a29SN244dHZtTlU1QlhSQnROcTZNV2xmMWdqcVhmOGdObWRtSlRzUjdRRWVQ?=
 =?utf-8?B?U2VYdzg4QVdJdXI1dENwS1NJcXhnVytYSXQ0VGZUcG5KRzJZRkcrVW13eUlN?=
 =?utf-8?B?cTdmenMrZlZaWFNoUkhnMEdZekM4YmZ4MmRXT2FmdFRyYUQwcW84NC81WWxs?=
 =?utf-8?B?NUdPajhUa2FxVEEyREczdUpIdUtuNElIMlVScjR0VjBiKzN6NFE4WjFMdWEr?=
 =?utf-8?B?dzh2MTE2bEZLM2g5dVJyb2ZoeE1BdkF2VlE3Z1I0OS9pOU5odWRKalhYaHRS?=
 =?utf-8?B?cHBZV1ZLWXE2VG1mZjRpdU5zT1lIMDlaN2kyTHVEUnJCT1RTZ1pKZ081UWYr?=
 =?utf-8?B?WjlRZmwzbk9UYks4UWNxRnArZHpYSFNBalVBK1dsTUFRNXNXc3ZSd0NnS3h3?=
 =?utf-8?B?SUlpelBqUmNRcGczNUJ3Qzh0enU1d0tOUkZKcHdESytyNEdYcUpwSFRqeUJZ?=
 =?utf-8?B?Tjk4ejRvNzhJU2xkNTFob2hzOUZ4YlNxVGpZZDlvUEtmOVpha0pYbzNKOVNx?=
 =?utf-8?B?QmhzYjhMc0twWjROdEtlMitKS2JJZE83cC9XOTRKNGNWUEN1SEVGSTBUN0c1?=
 =?utf-8?B?eXRFOVlrd1Q3UTExYlhPaHhmbjJTSEx3WTlZT0tRbjFnUDNnV3lHcVlDZ3Bw?=
 =?utf-8?B?SGRyWHJ2U3VOOWJCWEZVV0Q1S3BaazE2cnBLR1VZUW82WFhiN2FMMG5PNnRs?=
 =?utf-8?B?bG9mRmdUOHB3L3EwOTU4ckFIL245SzJJS0tpNXJZT2R0ai9wN2dVMUIydklJ?=
 =?utf-8?B?c3ozU3ZHelhQcm84Q1h6TWJjZWx1UHg2MnJhWlRRQTBaS1dKbldNU3MxRi8z?=
 =?utf-8?B?Q2s0TnBwemdFOWtTTHhBRWNoOUxaT25rMGduVTJFa25FYkI2dmU5N3c1WkJu?=
 =?utf-8?B?d2tlRjFNYVNpRjEvN1J0NXZkQUVpb1BMMDFCOTVzRDZVZk81T0xjWEFwTmxL?=
 =?utf-8?B?T1NBOWdHOVNiQ29WeXFDM3E3cEZSTlZEUm0zcVU5YXI1K3o5bDFya01GSHFi?=
 =?utf-8?B?amdhby9MVExvaitBbHJSUk4xRFZQN3Q3OEVWOGRSVFd0YThpcjV6Nzg0Z0Ey?=
 =?utf-8?B?UUt3MytWNWtXZ2MwSDQybVpBTFFtUHNsajkzaFhhVm1ndVFXakE4UnJyRzNP?=
 =?utf-8?B?ZlVvVjlTOUNxRFB2V1FzQllrQ1VlMmgwd2lzVHNKNEp5bGlqZlBOSUpJbGpM?=
 =?utf-8?B?WnZoVmRKT1p1Z0o4aU1CNjdFeDIxVkpZMmRCM2tDclFoZzNXWVJLdThDakpI?=
 =?utf-8?B?bnd0L1FNcE11NmNNQUlpOUNBbEE0M2V6SWgyRWpoaVk4L2VJTEk0UUJwVGZ2?=
 =?utf-8?Q?O8yzlj8j5d/njC+p1uASOfz4Cr/KHlVdu7PLKg/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG8zVFBaNnpZSVUzY3R5UENpOW5wbjMvM0dGdUU1UVN4VVpsNHVuL1NicDRC?=
 =?utf-8?B?ZjBpM0ZCbzRlVElqNlRkTUJIdVBqQmhQQ2J1aVhWWjNiSm8zNXhWcm9zYzJu?=
 =?utf-8?B?R0tyMVZYU0hoY3ExMFdoamozdEU5djRmdUZSNnJtN3IxZXltZXdpQTJaODlQ?=
 =?utf-8?B?anYyeGFwUXZFbjFvYk00S3pRbEhBSlk5aFBEbmZvazB5cndoL0VxeEYzc3JP?=
 =?utf-8?B?SEtCOGM1YVU0S1ZoelFuQlRKTjUwdUhvbGg0STc1MCs4dFltcHBLamxXRjNh?=
 =?utf-8?B?WCsrWFBxTENsUzFwN3NDelBzUGRDOXh5ZDhNZHlPa1hxMlVGUWhXS3B3ZnFt?=
 =?utf-8?B?U2psRGlTK2EzWXpNaUlZbFhoS0NUaDBzWXBrWDZNZnNjc1VVOHp3SmRSMnp0?=
 =?utf-8?B?ZjUvdS9QL0pMNWVzNW02dVo5b3RNWkM4ZXcvRnFuaWZIN2kvTitVb2dqUVZm?=
 =?utf-8?B?cmVMTUZiZE5hajRZbjhsMXk1OU9UK2FQdWEzN0txa3NkZ0NFY1gvcEtXZ3NR?=
 =?utf-8?B?VTFMWXhZS3lTSkE4TERKOW4vNUU5djZvVDdMRGtZSllZS1A1Vk9TcmxadnV3?=
 =?utf-8?B?MjNwc0IxYVFzSWJ5a1FkY3Q4RFM2VlB3UFdmQjRVYXVzWDIvRDhvRVZ4ZzY0?=
 =?utf-8?B?dVJCM2FqdXcwWjkwWUt5NmRkREZ6YnFrU3g1YkpHeUVTckVsbm9IbzNTbGps?=
 =?utf-8?B?NnUzL2N3MW5QVDdscDlGUUxUWjFVNnhRR3R6anpjcGtBNjNlU2lMOE01U0hq?=
 =?utf-8?B?Z2x4Y2xNQVJYdHNIOXNQUFNreGlKM2p1TjhGZ011OERMeXNKMTdrQzY0M0hB?=
 =?utf-8?B?OUpDUC9XMmN1dlljSjJad3NaelB0ZE42STlEZVhxdThIbXRUK2cweUR3R1hl?=
 =?utf-8?B?cWt5QjZKallFdENXVllqMTFoUlhiUTVubERTMmo3RW1XdGNwWmI1a3lVbFVC?=
 =?utf-8?B?Q0dXNDlBam1xTE1WdWl1d1c2MVRrUCtySGtJeDdYdElTN2hTMCtPdS84b0JN?=
 =?utf-8?B?K3FxWlUvQmdVa2VCN1R2MDhQOFNCaHdlS2hUb1JLYlJhREVFRDJwaEp2YWFG?=
 =?utf-8?B?SCt0VS9XTWUzRVphVUhoaGhwY1BXTmVTK1ArK2lLV29USi85VkhtSDhlMTVz?=
 =?utf-8?B?OWRyNFkvY042bzlFMmxPZWlPaDlrLzU0WlVHSHAvVHJqcXR4cDFCTEhTbElp?=
 =?utf-8?B?aFhpeEdGajYzdDF2SkN6NEQ5WVFxbjZ3MGFzbVV5V0xmcXBQZ2gxTmtRME5S?=
 =?utf-8?B?NW9Ycy90VWo2K25EazFSazF5MDA2Qy9FZFhOdjdPSnA5VkFKQkpqcmVpYlVm?=
 =?utf-8?B?K3AyYUE5enRxSGRTVjhDbHRPM1grK0FJSVFXWkgyTHFWVncyS1hFM3MxTlNs?=
 =?utf-8?B?SXFWbEZSZnUvYlFwOGFQc1lsSjBWeHhkQkxYZVQ2d1hlVnlFdjJwYm16NEZ1?=
 =?utf-8?B?Z1NtN0tMRnBHQnlHMzh4bkptYXRhTDFjRWxVeUw1QUdHdmZXMHZ6N2tXdHBM?=
 =?utf-8?B?M28vN2hJQXNCanVRNWU4Ky80VkJjT1Q2d1dobkZPeTkzZWZ2QkJRdUZOY3Nq?=
 =?utf-8?B?V1JhbjkxZDRhc2Eya0FnUitNV1RIK1JOQWY2aG9XTXkxRlYvVHJhcXBNZUZk?=
 =?utf-8?B?Z0t0SFBwZ3NqOE90WjVMNVA2Rm5ySkt0aUg5VHVpUjAwOU1nN2Q2UVg5V3RW?=
 =?utf-8?B?L0lGT2Jnc1BhRzJMK3dIeXkrVTFuT1dQYW92bXdLc2diRkRRWitCd3hPWWwv?=
 =?utf-8?B?OXBsNGZWSnlhbm5SWm11ZHNZQUovZmUyd3JwK1B2cE9NN0hSdWRBQk9GRWJ4?=
 =?utf-8?B?aU9vUzZzT2VlK1RPam5WdTNXdjdZY2ZYQTBhRXhwZlRZSjRSbHI3NWNzSTBr?=
 =?utf-8?B?b0lhRXdUNWtzVnkvQkJ4RGRwcURYdEEyR3pYVWVVSkJhSnZTdkJaVExPWWZW?=
 =?utf-8?B?OHg3MmthVCtQeDhkcnBSbjdFc2F4SU5WOTRkdFRER241WSthM2ptczFjQnZs?=
 =?utf-8?B?K1M5RDJCaEtVVzk0OHk0L2hoK2hnN3hMeHJIVlNCTkdjT1hOU2hkUk54ZWpl?=
 =?utf-8?B?TnlQbUdQTmtUOUFUOWRhN3ZUdVlCRG92T2VWeWhDakNLbW1JaWpGOXAvbkl6?=
 =?utf-8?Q?a5uaZYbmnCr+EDejgwCnvE26P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1968ebc-21e3-4c51-7e38-08dcf3f1d0aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 06:05:09.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+/R+BW6v7JEH1XGuNHPuKK7aSogxtSIopdP1ivQwjdt/sxeM2IIvD6iuakJ05UaxelKAbj9d7Kg9VbhK7ycbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

> This is RFC v3 to allow AMD IBS to regular users on the default settings
> where kernel-level profiling is disabled (perf_event_paranoid=2).
> Currently AMD IBS doesn't allow any kind of exclusion in the event
> attribute.  But users needs to set attr.exclude_kernel to open an event
> on such an environment.

FWIW, IBS code had few issues with sample period computation which can
lead to SW programing unsupported values to IBS MSRs. Since this series
expose IBS to unprivileged users, below series is a logical dependency:

https://lore.kernel.org/r/20241007034810.754-1-ravi.bangoria@amd.com

Thanks,
Ravi


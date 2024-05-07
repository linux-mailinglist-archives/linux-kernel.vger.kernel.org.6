Return-Path: <linux-kernel+bounces-172123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBDB8BEDD1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAAF1C2386A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12762170827;
	Tue,  7 May 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VGH2pOsC"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE614B964;
	Tue,  7 May 2024 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112216; cv=fail; b=ebhxMnYdCaGpbyPZoTqGZEeXPLLX3hR+5981BWiX4zt4OyhECtHWPDY1M7siUuS9zOuxEXuXtTcL/uKHuBGC9KqhhtI2n8ZnWIxJS1pHlb4lebpwPIanGlWT6rYUO+hRH7z1kFf51VDSTqxgrIssvtVCMkVE78rusZyhA8cXRTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112216; c=relaxed/simple;
	bh=QwoTZStXdkBVBkhNuDpl++Hzrodkht1xkG+dqGxybbU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Drq704ogdH9hTkuq57RBoK8avQKhjkusYc3Dvag51B0yh2v0cBVZOewxzR0+BRZQud33DTwSMLIvYNnrUPNnGNlqE8tAnWZiS12T/jDUlwf+OVSg9Tw4m8v6lw/0gXn++6drFpKbkqMeEOmCBmzTFkdyh/+e4PXkBqTrtIMUfRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VGH2pOsC; arc=fail smtp.client-ip=40.107.101.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTllCNTOBK3pxQQ2XN2fXKTrD7WGMxi0s5xK8JS07Lq1U8SXieTCD+ddyhEIQe/1rPQxP4AiLWvGMmsQFIGmpDrpQ9Y4xYuY3F9f7CJTgCDwpsO9prCinq0o2C+FJu7LsqJDxYjqGr9h1YQy07tmNm+sumYwzLOMQ2AiMLqakNqLwY+ZbL6nrns3O37R9hKuE9poN2k0DO1OUzeIiO6gtJqiLWtFYMn3B3N2AiYagbKevvQlE004fPhql38g/+WS9C/kxkPqb4JJOWvyEK/JfDaHeHwrhZsk8UvItrw2iE7XCLp5NlDY4oaf8bkImfRngTIkGMhFuNIv4JiGsBf6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4ndVPotJTVXbxdc+CLwXvLt9EoWRTqn5eAFeE9UQro=;
 b=F2sm17n9GDNvTLa23F6nllatCQN78TVf8oK3Ba+YfUTyKa4aL90gJlBPnJ9UaUllZzSnFOLde23AsAKX5kdL4DmPjf+PFJ0Fv0y0zJYiD/q7PjrfIhnfANqwXXJ0YtjAj3NZIrPBmYic1VCXGjCBWEZf2nMGI/OL3RVQBNkHCfi+yYgHzTQruIo1A0cj3PGahv3sHrn2h3HDM1irYYErg0SPhnXpWcE3sms31yaA6E2UIeurcqCBjODyunvei/w8GpxYzkADOhbVGzpMwwALSZPl2fcTDAbfcUKJkYlvWBwLkD/CsyZZT6UP03Ar+RcygWsZ5CERTO/BhJSsl+l87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4ndVPotJTVXbxdc+CLwXvLt9EoWRTqn5eAFeE9UQro=;
 b=VGH2pOsCRlLfGvLlc38AWZInPvDqpKjW1FRqg//XMdhRm8J3GolM2388We4qxc0SlVbmv98P/xrtNMBzJXpEI3ZgLqBv6FFEx2ant540TqyhTfKjoeUDZFBsSfxjgRFY0hdWUgPRwaXSM/xkZRQlHA0+4oyT6s2WkugGp2uXeCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 20:03:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 20:03:30 +0000
Message-ID: <b247fb17-7234-4b7d-9906-f23689dd5b50@amd.com>
Date: Tue, 7 May 2024 15:03:26 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 08/17] x86/resctrl: Initialize assignable counters
 bitmap
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <d9fe6638d901791dfdec26caed034179c636e17b.1711674410.git.babu.moger@amd.com>
 <aec3fdfa-ad57-402b-9c21-555b5ddc85f9@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <aec3fdfa-ad57-402b-9c21-555b5ddc85f9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:5:337::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 4739163e-bd27-4e3e-96b8-08dc6ed0c46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGd1TUVVbCtpcEhLQzgzSUFoaGZiOGRJUUN4NmFxMmFURmdZRDRxcjV5c1ZH?=
 =?utf-8?B?b3ZDeTJTY2ZmV01jRzJGZ0J2SElHUGtheVFsVG1MbUlPclNpL21QZnJoY0Va?=
 =?utf-8?B?S3JmK1VxL0N4dmM4TmhPOEF1NUw5cUpIdmRhYStVRkVxenNiMmFkYlcxQkt6?=
 =?utf-8?B?OG9vaS9BZjEwUEpGM1A0eWZQZERISTM2aWFkSjIwVVd1REZaRmovM005Y2sz?=
 =?utf-8?B?NEEycmNUOXQzMTlkcklTYlluMmJZVFQveG43OXFGdzZUdFJCZ2Q3aWVwNWlO?=
 =?utf-8?B?YU9TdXBTRmNWbjJvYXJKM0ZrUllOdmFpR2dvT1VUUzl4WW5hLzNvSEM5eEhB?=
 =?utf-8?B?YXVHZTVXQjNpQ21mQ25yUlpjNVVyTzlKUEl6WFFvaFRibVNCbFhnOFJ6a210?=
 =?utf-8?B?ZnVjQkhuQ1VsRFRTeU05dHZ5WVNCZzg0Zmc1eW5ydngvTGtvWnF6N3JOQmIx?=
 =?utf-8?B?aDBsSTJpV1NIZ3JDYURhUER5TkF6bW1ieHIwZ3VTWXQxZUlnY3YxTjBSU00w?=
 =?utf-8?B?R0g2cGZwekROcmFqRFlXSGZsdU1FNE9uTUZUSjgvaSs4SVVTZlZEMFIvaGgy?=
 =?utf-8?B?K0NqbVVVRkRBelY3VjVHbkR5M0xPMmxETENXQTlkMTFMaUozQnkrSEdBQ2di?=
 =?utf-8?B?UGtzK1BSNTZFMlJRakVPYXRGTDdRSCtiWjNNdXc5eDl1eDdHMjRCNDRQa09P?=
 =?utf-8?B?eEFyUG9FZ2RPYThPa0Y1OGFPV1E1OTBtL2lTbEEvbXpBNG1pOVdkK2k4WktD?=
 =?utf-8?B?N0hwbU1hQUVOdmkxUVllSHhSTjRVb084YmdpODhaOGJsS0o4MHg0SHlRVGNt?=
 =?utf-8?B?c1pZTzZxR1lLQ1N5NWZkKzVxYkhTMjNYbDM2citWZTAvZkpKVnYrZFhQMkh1?=
 =?utf-8?B?UjhTVWl1VnR3L241d0FaY2lOL09La20vRjNUbFhBT3NhMkp6dXpOVmpNaFNi?=
 =?utf-8?B?OWgxVUx4aXhLYUhoUmxGRUVYT1hPOVdhWHVSRFIzcVB6dzJoeGFPdkJ1OWpC?=
 =?utf-8?B?QnRiclkwTzh5NXhrbFJwYUF4ZTJpS2JCanRpQTN6dnVVaUJJWGE0S3NSY2Nt?=
 =?utf-8?B?akZ0OHZNK2ZXQ1ZEN3d2MHJyM3dqZEN6eitJQkVuSS9HQmJhRVgrcFFvZ1pQ?=
 =?utf-8?B?VlAvYUhqZStvK1g0Z0dSbnp4bjZ4RzlsZ1F4b3EzT3lrUk9xNSs5Y0NSUVBW?=
 =?utf-8?B?UDBISzlMRDBRcnRIa2FMamU2d1hhaDM5SDRKaXh1RUhzNU5LNG5MeS9nRjdt?=
 =?utf-8?B?UjBwdnQ1T0pPS09CT2JJZkR0Y01CMzdFRWdOL2U0U3FZZkNJSFVhZzd1R3FW?=
 =?utf-8?B?SVpXZVZKWWROa3NSMWhnLytHbmg2VWg0UFkyYW45M095bHVmcDRDZ0Y0bWd6?=
 =?utf-8?B?dGVIdkd0aVJiaDhHVkh5UU1hb05SOWZ1RFA4S0gydG5FMy83aUNXL0RFMGxG?=
 =?utf-8?B?aTVsTnpOZDV1S1pjOTIrSUtHRVg3S3J2akl5VndwSklrWjhCYWxqbmIvQzAw?=
 =?utf-8?B?c0NrVklXYnNBV0t3Tk9KRmZ2dUhLaXdTVCtSSUJFaExrUmhOQndQejFZOUQ2?=
 =?utf-8?B?VDh4bVM1UmtkMlVEZnhBdHZDcG43RS9FbXE4czB6eW1ta3ZlSWo1SUVScDd4?=
 =?utf-8?B?RkFnSjRpdmFHK1dqTHVlZzVKL0RUaFFFYTJGRGxNS3YrUkxObDVPQWlZUW1o?=
 =?utf-8?B?cjdaYS94Wm5LWlZRT0V3dnlpWVpRTFRBNE1CVmpmc3lkcUswVnV5Qk5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXRLa0pBYlhJZ0VoNjJFWk9JQlRIQzdGU05JVkZoenJONHVTbjF6UUlNaysr?=
 =?utf-8?B?bGNpemJEd2d4RHh6N3dHcmVTU1BsbG1XNnFlSGNEa0xKMWlXMjg5RDREdmlM?=
 =?utf-8?B?bTRRVms3eHNLUHlTbzZSMnZDejhMNWZZUXVjem94N2M5QURkbm1wREZQWE5a?=
 =?utf-8?B?R29JQTFmdzZLRXVQUW9sa3hUYXRFSTRsUVJIdnNkaXJqcXAvdTlIdFMzTk9Y?=
 =?utf-8?B?WFc4TE12MkROU1djOURkTStHUzdDYUpxWjNCVkRCczd3c05ET2Q1UWRIWFRZ?=
 =?utf-8?B?SDBHeXN5Wk95ZCs1bzNpZ2dDZHlGc3BNcUlmUXRhbDVCUDArNmZyaTRPNEZN?=
 =?utf-8?B?bVBpUEhzaHFXVHJFaGErZWpWUFJlTnllMTgrSllubEdLeFNCTUF6OFArK083?=
 =?utf-8?B?UXV3enNKUHlVUTY3RkVQRkQwWnF5cThXT05jeEVtVUlSN3BON05INndZNzVQ?=
 =?utf-8?B?cE9xaE1hM0VPU2dFNTYraXBVV0hmUmNoNzBDenJSQlNvenFNR0xLS2RSbThu?=
 =?utf-8?B?cDF0VnFPQTJ1UTFIU2crRkNyQUl4NEhWaitqazZzUWRIbkNyWUFEM0sxVEE0?=
 =?utf-8?B?dEZLenRIZFcvNnFENmRDVDBDMGVKaElCNnlCN0l3WS8vNENOWEVmb2MrclEw?=
 =?utf-8?B?eEZ5eVlWVW15ZXh3R0ZxblBCT2xaMVoyN21JTUxqYWNrNEVwTWtUTEo2Tm5u?=
 =?utf-8?B?Zm5lQm1lTzhlODJzaG5FOXp1aStVaHY4eUdnNG9TZWptd3kvQkx0TjZxTDg5?=
 =?utf-8?B?UnNiNkdkaWlNeTlZY0RDaExjQ1hNMEZRYnNRaEdpQXZ0OURUMjdja0JoZzN6?=
 =?utf-8?B?UGhWM3gyRk9GL2hRVTVrSzBVaUNMcTU1bURPOVdXN1VsdHpYT0UvMWFFY0Vi?=
 =?utf-8?B?WFhBRnBnalM2OGJCdGJXdlRUNU5LYi8yVjVGbFZUMm1KMGdibnRWbFljUnpv?=
 =?utf-8?B?TDkrSEtUemF0N012S2Q3ZmI3MUdYaFk0VlZBT28zbVQ2QnFkWnViYTRwTVdC?=
 =?utf-8?B?WWpGaDVsNjFKNE9PYjhoQWNWb2ZmV2hzQjE0eVlJeW0rN2dSOEFwejRnZStE?=
 =?utf-8?B?azgwZ2pmZGt6azE3bjZDbW5DWnBjL1ZpZnEyYmNwRG1Vd3ZCT2VpUGZBMmZ2?=
 =?utf-8?B?Rk02Ykc4TmR4RGVtRTIyWnAxWUMrQ3JuU0hNOGoya1Q5TlM1cURVK3pTRnBY?=
 =?utf-8?B?b2FxbGxCclhNdlp6V3ViQnUvOGJ0Ulk0RVkyZkVwOU83UVdjODVYRFV0aXhF?=
 =?utf-8?B?MEkrZnVpckluWTZ1TkZKZElQSW5HSkhmczVlNXJsYVAyUUUzWnpOTURoRG55?=
 =?utf-8?B?aXFnRVJIalQ1b1V2Q2FkOW9tOFBidXoxeDFjY0ZVSWpmUHpDcm9qcmpQdFQw?=
 =?utf-8?B?aTZUS1FUdmJmRG9TSzBtOTRHUlI1VU1NZzg0Mm5hNll1MUFRemU3U2dkTmVa?=
 =?utf-8?B?NVlzODRUWWU3a2xBVHBYZVlOYlcwaVJLVktZb0tBNGtnbTZBQVJaWDVPbnBO?=
 =?utf-8?B?cER0a1JyQmdWbzJZQnlSZ3ZaZjNLaFA1dzhNRzBacC81bDFGZGFrTHYzYWg0?=
 =?utf-8?B?RWN0Mjc2cFlrTXhsYzRIUit6TzRya2U4amZGVU4vY2JpY1pmdkZwNEo0c2Ir?=
 =?utf-8?B?dG5mUDZqbXVnMDBJRjJsdVFnb01tU1Q0Um1jRGt1cDNJVTVsQk1FbnlUc1Vn?=
 =?utf-8?B?c0JrMktad1Z1WTg0MFBjaXBJZ25Wb3dUSmJ6cU1nNU44azQzZWRWU0FlSXVa?=
 =?utf-8?B?OXlkV2c3NTB6U3ZmT2NHUDU4NGRyNnR3RDhFNXdiT2t2N1M0dFdKM3hYUGda?=
 =?utf-8?B?NzJ1SW5icjQrV3A0cWJRU3ltSXF0VTE2UWFpeFZmSm9Beis4N1FJUGc5VEFl?=
 =?utf-8?B?MTdUWGlQUE90djBKeE54RXRmWkZjbkd6VjJNVEJrY3pxYmw5KzVPSk9VM3Nm?=
 =?utf-8?B?Z04xRTN5SFg2WDNqb0R6ak1pV0s2dmlNaWo0UTZ2dVNpRHIvdXEzbVMrY0Y2?=
 =?utf-8?B?bXRXY0tuOVFBSTFIVmxzUy9rY1UzTnAzckU5NzNOVWgwNmtkZFR3OFZ2Mnk3?=
 =?utf-8?B?WUt4eld1UDh5ZisrNEpYYUFmSWFLU2NxYnJkdTRGOU9GWUgvTmJWZ1RMckV1?=
 =?utf-8?Q?85vY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4739163e-bd27-4e3e-96b8-08dc6ed0c46e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:03:30.8991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXEqs1AgKBRzoSnw1syowPcGsJqISlh6Q/+4xTcxAnUWrAI6KPP7Vl8pqwIsrtSK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801

Hi Reinette,

On 5/3/24 18:31, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/28/2024 6:06 PM, Babu Moger wrote:
>> AMD Hardware provides a set of counters when the ABMC feature is supported.
>> These counters are used for assigning events to the resctrl group.
>>
>> Introduce the bitmap assign_cntrs_free_map to allocate and free the
>> counters.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>
>> ---
>> v3: Changed the bitmap name to assign_cntrs_free_map. Removed abmc
>>     from the name.
>>
>> v2: Changed the bitmap name to assignable_counter_free_map from
>>     abmc_counter_free_map.
>> ---
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index f49073c86884..2c7583e7b541 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -186,6 +186,22 @@ bool closid_allocated(unsigned int closid)
>>  	return !test_bit(closid, &closid_free_map);
>>  }
>>  
>> +static u64 assign_cntrs_free_map;
>> +static u32 assign_cntrs_free_map_len;
> 
> Please provide summary in comments about what these globals are and how they
> are used.
> 

Sure.

>> +
>> +static void assign_cntrs_init(void)
>> +{
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +
>> +	if (r->mbm_assign_cntrs > 64) {
>> +		r->mbm_assign_cntrs = 64;
>> +		WARN(1, "Cannot support more than 64 Assignable counters\n");
> 
> I am a bit confused here. The configuration registers are introduced in patch #10
> and if I counted right there are 5 bits for the counter id. It thus seems to me
> as though there needs to be some checking during enumeration time to ensure
> that all counters enumerated can be configured.

Ok. I will remove this check here and move it to enumeration time in
rdt_get_mon_l3_config.

> 
>> +	}
>> +
>> +	assign_cntrs_free_map = BIT_MASK(r->mbm_assign_cntrs) - 1;
> 
> Please use bitmap API. For example, bitmap_fill()

Ok. Sure.

> 
>> +	assign_cntrs_free_map_len = r->mbm_assign_cntrs;
>> +}
>> +
>>  /**
>>   * rdtgroup_mode_by_closid - Return mode of resource group with closid
>>   * @closid: closid if the resource group
>> @@ -2459,6 +2475,9 @@ static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
>>  	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
>>  	struct rdt_domain *d;
>>  
>> +	/* Reset the counters bitmap */
>> +	assign_cntrs_init();
>> +
> 
> (At this point it is unclear when resctrl_abmc_setup() is called to understand
> if reset of bitmap may be appropriate. Please do expand all changelogs to help
> readers along with how this implementation is intended to work.)

resctrl_abmc_setup() is called either while enabling or disabling the ABMC
feature. In both these cases the bitmap assign_cntrs_free_map needs to be
reset.

Will add comments here,


> 
>>  	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
>>  	list_for_each_entry(d, &r->domains, list) {
>>  		on_each_cpu_mask(&d->cpu_mask, resctrl_abmc_msrwrite, &enable, 1);
> 
> Reinette
> 

-- 
Thanks
Babu Moger


Return-Path: <linux-kernel+bounces-557845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18D7A5DE81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B80B3BB8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423F1DE4F3;
	Wed, 12 Mar 2025 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SO2zrd1c"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458224503F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787886; cv=fail; b=a7vxo8oT0d/VmYuzxRqm4E+BoemDOrQBmn6eKzmHCduMvu82XqIyYlIv5+HIVPWqodcBl8kkXbmvg5rd0u9galKjKMd1hVkiAB4RBJK/yPfQfAnMy4/iyJR1O93PcLm+LK1P5n2iT31JT6BzOCdq4Fafteg42uUIMsBXYI2l/U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787886; c=relaxed/simple;
	bh=CGfKwtDIyL3Aith1o94j7fkrBSQabnNfh68zB0KFcJQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uJ7F5TG65sj18DMuwJk+bXhfiYDuae1s1BGepAUcDwKDJIsHBL/qFMul+kF+Vok8fCeuFIeYcxkiWNBVr8obSnVx+h4FtU4o1ToxGC+NixW7PfTvuJDaksR882jdfImTazATkvUcG42cXFjh2EwryV7mDsTEaGGwy4NMUZcnD70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SO2zrd1c; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJ8BycR4lPYL2vRzSLkwDjFr49ADeF2XprhEC18vTCcelgjs7Gwnfw+3BIZQnT/4cV5YOnSMK2SiY/VzzE5gXzpNGtkHW2kk9AyVMj4HYwwAK9cpXlloYnR9wpsx8hnCCivIo3TKwbYjcKaBLFWzj56LFPBzRlYkMaIm08PraQpYKq2VNy5G2kDzF+AOGofnbG8gJkOhbdAuyGolZVFDD6sPv30EUkZdYwUhR2WIqlYXzLjs/MrBe9to+tIluBP8DUbNnlkPqg2Vtmp0VIW7IlVdht67rWYaBgQyIlUOLjEqgyaVU7q2uYg/t1zN5AczFqJyOQ9pMuk3M5JWsm0cgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tGrMkXFeAp8Jo1BU/U3azVZZheIE5fk9sPV7lQzLWE=;
 b=x8OYjpjUuiYrwNqgbLFfzB4eBQZshFLUFcvYrm+iZiVp312uVQyal6OvF7NHjW0Jfc5/BHSu8QaabLUV0b3pG55wwLsw8R1xighMpUaPQGRgpLT+ODnHpPs9gMEB31ux+nj/0GSO0LSy3jKHMnMu97LeKDhaeNcNZSVD4wWXPpOp3Pcgh2ICaxOCo1Nq/Wtfq5BM5Fsd/QCq1ClSMJhLBC1Hcdvq6n2L6eGcQp2flel4myvhEI7OUnBFXxIOIF/McyOJ2mgpKsC7r5S9zKLRDPuEMn4bnuqwMRx9xwSPMH3YgHZMebOxecHYvWN5sDnANRxTyE3OPPuVS+2CAGjq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tGrMkXFeAp8Jo1BU/U3azVZZheIE5fk9sPV7lQzLWE=;
 b=SO2zrd1c/se/stdc9KQEIQ8bXDLtR64j3jkba35DgOhIXAbq1J+U8Am42M1vEcoc6bXwrbA3/85lZyUVEmJWZ+S6yMyn+sQBAqqcCELuPYMPTHXq0zevzqvJu1fQrLePF6iyFzN9ZyeopCRT7945Rtf+IMU1GGk5MXM6wFsDO4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 13:58:02 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 13:58:02 +0000
Message-ID: <6ef68a41-c820-4566-b5b4-721bb616592c@amd.com>
Date: Wed, 12 Mar 2025 19:27:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] perf: Make perf_pmu_unregister() useable
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.525402029@infradead.org>
 <05e39b53-8e2f-4e21-8106-028fe54c37a0@amd.com>
 <20250312125753.GL19424@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250312125753.GL19424@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: bb560582-9238-495b-cc37-08dd616de740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkhmL3JwOTFCdWNkUFZRRHJla283RFVsOXh1RXlFR2ovV2MwVFMreDBuUUh6?=
 =?utf-8?B?TU54NStFdGUreVdFL1g3cEdtL0lINkdnM1pzSnRYY0NUd1NnUE1kWUJTTnA4?=
 =?utf-8?B?NXMvc0p5QStvVjhVYm1jUTJTWForZlZ3SlZxTUI0ak5hWEE1bnh5ZXVPSWJ5?=
 =?utf-8?B?QmxTV3ZYVVh6RjR6YWNPNXBrYnZBNkV4aHBDai9rcUR2bVJDRVJETjJsYlgv?=
 =?utf-8?B?UmgzSjZtVk1EK3k3RFB4dnRoSFRpZU9NVjNwbGlhYThVekNZemNPaFltSTNh?=
 =?utf-8?B?a0I2NlZtdDQvdzljRkw5LzRBc3BCR2hiOGhGci9ZRjdYbjNqOE9NUFJkdS8r?=
 =?utf-8?B?K0VmUjNRb3kyV2g3d1VTRFQ5Y1VNVHdybkd2NGhXUUVJNXpuTC96cTdCSGpV?=
 =?utf-8?B?RDdoUGVRcjd4TFNSSFNyOHI3ZnBFS05mcnhtVHZZZmxrSkVhTEU2ZUhxcGJC?=
 =?utf-8?B?ZW15NHgzbHpsYnRHMGN5dGVvN0hpdnBZbk1QYkJSYWNIRU9vcUFtNnN5bXNk?=
 =?utf-8?B?SjVuQ2JQVWsrbGNzY3EwWENjUExaNGVZc1ZYdUxCZmNRSUllSFdVbTJpckFF?=
 =?utf-8?B?cEZrRytDYjV5YVJqY0s0RFA3Mzg2dGtRRkRtaU1aKzlvN2dScDkwaDJ3cGdo?=
 =?utf-8?B?b2RtODJkWFBpaHdHU3lMRW5rTUllTWJSNkpVNDZ0SmRiMXZPMFM5c3NUQ3Q2?=
 =?utf-8?B?UHJ2YkE4Vzd4UFh1TkRmNGZFdloyWllNWVVNN0tuSG40b3pZZE1kN0FOSVdT?=
 =?utf-8?B?bWJVZmlZT3pTVW8xQnpFNlRFWGxZUytQMHJlUmoxR2ZPQitpaEkvOU5RRmxB?=
 =?utf-8?B?VGFBekN1UEtMVjlTZ3doTmg2OVlLaTFLaXRJNGZyWS9sT3pnMktEMDNmODNO?=
 =?utf-8?B?clg5THpYOWswbDdIMzJWaVQ0ZXQxVFdwamJmOEdMc1BoaFRaaWttT09TMVBq?=
 =?utf-8?B?OUxzVkowRVR5YUZIeCtJbFJETlJjcUJpZ3Z5SDk0YWtWV0RhYWppcVFNWHhH?=
 =?utf-8?B?a2RqTTBUY2ZXYzFxTkRNa0N3dTJKdi92Z204ZklvN05STWNYcEtReVlPNmgy?=
 =?utf-8?B?eEhpQmliaG9hcHBGNkxlci9DT0crS1Q0MS9tUmtBWUZvOHB0bkp6eHZ5UktW?=
 =?utf-8?B?RFNSdjcvZUhoUkN3aTc5YzlpZisxQ0F3NkE2ajh6R29PbzBaamNmdkhrUm9W?=
 =?utf-8?B?aDJYK08vcjlRTXoyRUE3Z0dwUGtocU84aXpCRUt3cENuUGsrOFd0RVlMZDY0?=
 =?utf-8?B?ZHphOGZ3dzZ4emlFOHpEZWtOdlR0TlgzdWExY2twem0wVUorLzVCeGJzVUEx?=
 =?utf-8?B?Ym5IYUh2OWpPWk9oYjhZM3ZaWm4vbXJaY1pGV0VqLzV5MXNZYW1ZZnFPdGF2?=
 =?utf-8?B?Z0dJUk1HRU9OeE4xems5dkdZNzNxbzB1cFRWUVlBSDRlZDF1WDBZVnpuMXlX?=
 =?utf-8?B?N2w4T0h1ejNrRGZtRUZ6V2crUGNWeHFXeGxJQVVqaitnVm1WVXRxeXRRZnJ0?=
 =?utf-8?B?ZlZOSmgzS0liMzMzZEpjbkcycll6L1FNY3dWUEJ3UWd2d3p0bThWeVhzbjlB?=
 =?utf-8?B?Nk9YdnpuRTF1eFA3bkpOTG83TWo4aHBxcm14eDRBSURQQmx2c0o3SXBHa3ZH?=
 =?utf-8?B?aGpLM040clhJMlkxRlBmZ2xnRE5lV0kzQVFUcmZzVUdONFlxNUk4V0k5d2J5?=
 =?utf-8?B?OEFpVXVkWmpIaWMrMHAwN21HVkx5K1dPWW1ob0RrdGRPd3NveTJvZHZ4NlV2?=
 =?utf-8?B?SXgySXZSa0RpN3d0dWlnYWxOa1FyZUJUTzJZNG9tMTFJMnNENlR6TGRlNkFa?=
 =?utf-8?B?L0RTTXVZRE9oVm1GQ3JPa0JLOE9YQXdVb3FadDFNOEdIZUdSRHh3WkJrdHhp?=
 =?utf-8?Q?hCfm73cxizoRe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUQ2NHdoUXdzOFdUblVxbDRZNDVRRWdzOThSYTRGT3NCNFdiYWswRmJuMkNM?=
 =?utf-8?B?NHI4Y2NjQU9SQ1ZzREJaRm55S1luWTlMcndMUERGSHJObGh4QXJwMlJXOWow?=
 =?utf-8?B?ZEphc2tQR0s4U0ZhZ2N6dTNaekU4WEJ1WDBkUCsxTzBmekJZa3BhWkNLeXU0?=
 =?utf-8?B?cU4xcHRFZTM3eTBYYW8vSFJob0JGZDlpV3paZmhqUHAvQTNycXh0YWZzVmVx?=
 =?utf-8?B?RjZYOTQ2TFBlQkt4L00wQUZib0xoRkpZWEFZNE5HZmV4SXBZMlNPYjQzdlBk?=
 =?utf-8?B?T29LQ0RyZ1Vna20xWXdrK3VYdWQyLytxTUNKNkE3MjBBREUwMllJdHh1VzVE?=
 =?utf-8?B?Y0hBazkvNGxLdVF2NVQxMEkwVXFhY0V0c2hTeHgzUTlIdi9VeGM2YmdXUVlB?=
 =?utf-8?B?RGw2dEhzK3BNVWN2SHNTS3RITWVodUZhc1RyTSt3cUErZU1MOFFSU3FzK0d6?=
 =?utf-8?B?K1BsdU1yWFFXOWVRWFJveG1mbmFhalJ4eUd6dTU4N1NEY2pKSnd2ZmY1cEpU?=
 =?utf-8?B?KzYreHowamg5RGtlY0MzZTg0RzJCOTVLclIrOVVMYXVXSWYySFpTYkE5eE9S?=
 =?utf-8?B?YWxIVTdCNTZMektMZ0dqdVZIMEExUTZPY08rWmU3Mk53Zk1mWHFxTUQzUGFZ?=
 =?utf-8?B?WUw1WkYwb0NlNGVzTHN0c0M3U3pZZnlBUjcrZzV2RVhrN1h1VGF1b2F5WHI5?=
 =?utf-8?B?M0o2YzFnd2NCNmcxRW10TU5zamlFWkd4RUZMQ1FMR3BlTEpnZEVzbTV1R1N3?=
 =?utf-8?B?emFGRHozR0JTdGRka0tqNnZxc1lOQ1JvQjc1TkdRU3Z1UFdHODVVM0U0V1dR?=
 =?utf-8?B?a0M1Q2JXdDFGMkRadTRnWE92VFM0NmZKbFlDSUFoMUYvNjNseWk4OFhieHp3?=
 =?utf-8?B?ZFpDYWVXU1g1cFd4dGpRd3VNN0hwV0gvdmFpRzlmUG5RMEhpUEhJT2FBd21l?=
 =?utf-8?B?QXRQZUFHblFIQUdLYjBGNUlJZnpYWWM5WWdlZmtRcGlEZ3IwWXljOGRCY0Vz?=
 =?utf-8?B?MHZISWthMWdzbE1KSlFqcmpQcUgwM3FpcXdtZDZJc21kcnFYeHRrNHVNTFZX?=
 =?utf-8?B?THhaNndaYU9kVEVub01iZklGMDFHWUI5Rml1dkJQRkp2UGE3SVYzZ1JmeHpP?=
 =?utf-8?B?bmcwRmhHVXE3K0xEOUJLNkpBY0NpNzNlOFE0RzZxejIwTmtLK3lYZ2hvUnNz?=
 =?utf-8?B?SGsvYmVFdklCSnhrSHBuUXN5UFpRK2M1aEo0TDd0UE53RXNENU5aUDJiVHQ4?=
 =?utf-8?B?Z215S2d3akgrNzZ5aWZUUy9IN2J1bUpCOEs0TTM5dXlGdjZDRDU1ZTh5Um96?=
 =?utf-8?B?NlhYQUNmd3RCYi8wblMwN1dpSnJqdHIrTUdoNFpMeDI5V3Y3dkdHMFJoeC9l?=
 =?utf-8?B?eUY3SWdXZFd0QTFCN0FYMEQ4b0VEcytGWWFCbVo4cHROUzRIYTdMY2tvcXNs?=
 =?utf-8?B?ZnhMMXZRTzRiN25IN2Yzb28rTkxwNXcxcFVPT2VtNXVlRGNJTjJzb1lWM0lE?=
 =?utf-8?B?VzZIcEVGRUZ3VWNueVNzYTJHMjE4dkIzQXREcUw4M2pTRmNRQUs1a0o1VmFJ?=
 =?utf-8?B?b3JKLzArbVhIUlk5dVFpUHk3MnF6VEhPY242L2VpTVNSK0hSSENtT2s3dy9M?=
 =?utf-8?B?Sld0MHBIUzc5UE1pdDB1T1BqK2tQK0E0MEJVL3paUlNVNDZOU0s2THhEWllX?=
 =?utf-8?B?ekg2TVFhYURhL2JFSnZueUNpRjQrZC9VWC8wUEZVSVZEeFdsZWsvSzRUNjB0?=
 =?utf-8?B?SklSaFNaNHp4QXovOGlKbXRuTkYwdHlyZUJBdzNuQWYrTkhPbElPVTlNdkJZ?=
 =?utf-8?B?czlMN1cyTlJmelFBRUxiTXFZMGViWi9MN1cyZUdSd0w0VGozSnVuNkFNcTk0?=
 =?utf-8?B?SFl0dG41dExRWnhtbE9KYU5YU1plSm1SRzN4aDhkbnNDYVZZUDFxK2poUmZw?=
 =?utf-8?B?N0QrWkdkelRId0NXSlV6U0VybWhaS21GMVdaejFlM3hkR0JDckJsaTY5cmp5?=
 =?utf-8?B?L05ZUitHaWxKczBoc2pzcndGNVovb293TCtFOElrMGQwZFN5VVBoYW1mVXIr?=
 =?utf-8?B?N3k2cXhxUkxzRnlKcGQ3RDV1Q1M3d1J4c0s4eWZ2Qm9mcTJhVWNzYnNYZUpT?=
 =?utf-8?Q?SYc8rh8tKviQrXRkyZhnCDsD3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb560582-9238-495b-cc37-08dd616de740
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 13:58:01.9847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRnKF0NmPpGtJUIIhDY5JASpC7/DWr66zU4LvmwYZVYU80G7wTBceV1uW6Rd4L3lk0r4k2blCdl28u45GtdCWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

Peter,

On 12-Mar-25 6:27 PM, Peter Zijlstra wrote:
> On Mon, Mar 10, 2025 at 10:16:09PM +0530, Ravi Bangoria wrote:
>> On 08-Mar-25 1:03 AM, Peter Zijlstra wrote:
>>> Previously it was only safe to call perf_pmu_unregister() if there
>>> were no active events of that pmu around -- which was impossible to
>>> guarantee since it races all sorts against perf_init_event().
>>>
>>> Rework the whole thing by:
>>>
>>>  - keeping track of all events for a given pmu
>>>
>>>  - 'hiding' the pmu from perf_init_event()
>>>
>>>  - waiting for the appropriate (s)rcu grace periods such that all
>>>    prior references to the PMU will be completed
>>>
>>>  - detaching all still existing events of that pmu (see first point)
>>>    and moving them to a new REVOKED state.
>>>
>>>  - actually freeing the pmu data.
>>>
>>> Where notably the new REVOKED state must inhibit all event actions
>>> from reaching code that wants to use event->pmu.
>>
>> I think perf_event_init_task() failure path can still race with
>> perf_pmu_unregister() and trigger a WARN():
>>
>>         CPU 1                                          CPU 2
>>
>>   perf_event_init_task()
>>     perf_event_free_task()
>>       perf_free_event(event1)
>>       /* event1->refcount is 1 */
>>                                                   perf_pmu_unregister()
>>                                                     pmu_detach_events()
>>                                                       pmu_get_event(pmu) /* Picks event1 */
>>                                                         atomic_long_inc_not_zero(&event1->refcount) /* event1 */
>>       /* event1->refcount became 2 (by CPU 2) */
>>         free_event(event1)
>>           WARN()
>>

Please ignore this.

I missed to realize that you have already replaced perf_free_event() with
perf_event_exit_event() and also replaced free_event() with put_event()
in perf_event_exit_event().

Thanks,
Ravi


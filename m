Return-Path: <linux-kernel+bounces-420432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC949D7AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 05:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDF4B21625
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 04:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5387C2AD17;
	Mon, 25 Nov 2024 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="da9zYsBG"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C8BE4E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732507845; cv=fail; b=bkmE7dQly275+X0b0s/2cRbYD+iYWlxpPBl3ERlaxdGugSTxiyxzQWeOK2WXEczE8fLQ47PKtAMPzCmGEvhoqs1Ez1f87Cfrcx/4MybAzfZPZe8GYvBTGO/WTCxdtWAcX31MPi1KQ3KvGaxc4lmQAChsZd2tPxU1Oc84/CSzOIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732507845; c=relaxed/simple;
	bh=zFZI2kKulhB+hdWVmPuagXgmqvhVC9lSc5W1PBIukRs=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=er6UgnpRnpowcKMAWuMCqhc8iP8UfyUFKs17Z7NeHzS+idcaNxGCLC//N8CZwXJGL7hgGbMsweRYq8bZHoiROSt1WelFecna673UGuCf0uNlk22GKYV4FgJ8vbpV3hmsPFAS97fpFjZt6r/3fu9FVALZqFKMCUtIOXdt2nnxTLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=da9zYsBG; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IonnLtVQEjaCWo5fCH7/QZDBADN6gdwCG/+PzV3lpnEpdVWvVobvB0NAgJJfRpc8YjbPXnKVmss3UW8GzgcqBckgchQ/0bknYwrSOQ9deXk4ot93LGxu6QLOxmrgo8VgTwENsRUKGbIbnJ+sEXlPgIZXnATX9+umWlaU34taEnfbEDhMbNBcmOoPnBn+sFvZ6+STQ2Xi6mwVUT5HXvb6Nf42jNPOE7BzEUFUjZ5FPwY4W2F2ahHprM670zSrd7wwZQwxrOsrWbQUmugu6U3dWeyEA/jp6WqtsGCZmQAuqC9KK8zSKSKqYrUdx/5xXWOOzVQP1t4cVVgKICeMAJ6syA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HxWSL8fWqb5ZRLNKOkBG/ZJhxSdAq9npXkQRmKeRPk=;
 b=JaEoUd0lvyg230+Otw/yfQeGhB8fwgXiM5HSdVlfIdZSjMHY/gwJxHlYDCnrZh8hSTJFKBIA+sk/PEycPVfkb5tB0e6fUoLKBjLNZ458vgHCWXGJD9+4ILeJy3mOerN19awLcWqbMbfxTd2Suqy5ZWiov8fwG7Fc5M74U7b8fe2fBDTheBCBcFIyJx1ckDs19R/ExCiWN2pKgf1+RZHvDXxAk/ElDxMppc5XaCGfrdsAeGfRQTNfBRrKDs3sSeFTFygO6iZxAD46TlFekek1dre3V+7W45j7WwaqBoVZWHnQjLg7Yw77FrgMGyrMFOmSZIh9wARPvxdqvxUrzxFDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HxWSL8fWqb5ZRLNKOkBG/ZJhxSdAq9npXkQRmKeRPk=;
 b=da9zYsBG0FhsBVKdMYSrbDuuRbaPmeyphRBL66ac4bfhvI7WmCS7Uy2LVPVGtMTSDPLaH7v2AYQrrcYNm0KyywoCoGWs2oTcWo2Tcq0cS7rcKD7YEFfkoSEG90yYw6hploW7CU49phAxOqF+Z279i7o1+aqe5yjRbNN9qPNZ3Jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.30; Mon, 25 Nov
 2024 04:10:38 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 04:10:37 +0000
Message-ID: <ae1f9492-dae0-4ce8-aa6b-f1890faf67e7@amd.com>
Date: Mon, 25 Nov 2024 09:40:28 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 19/19] perf: Make perf_pmu_unregister() useable
To: Peter Zijlstra <peterz@infradead.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>,
 "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "acme@kernel.org" <acme@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "irogers@google.com" <irogers@google.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "Bangoria, Ravikumar" <ravi.bangoria@amd.com>
References: <20241104133909.669111662@infradead.org>
 <20241104135519.715883982@infradead.org>
Content-Language: en-US
In-Reply-To: <20241104135519.715883982@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e85c09-1992-4b9b-907b-08dd0d071dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm4rZFhzRUp6cmtSanRlS2c0MDRXTU5MN1FxY2hlTmFacXV4d2hZL0ZJV2Rk?=
 =?utf-8?B?SE5ScUsrR1REaXlKalc1eG9Gd3pOanczUldETlVwY3hwK0J0MTZacjlGek9M?=
 =?utf-8?B?clFLZzdGeWFvbzcxUVN4c0x0d0VTYWlGYkVqZFpSQ21DNFJNNlF4YjNJOGgz?=
 =?utf-8?B?VWFCZzlGMFRVaFVJb01tOVRFVlQ4aklnZVh4aVNlMFhiaG1BakwvUFhnLy9u?=
 =?utf-8?B?bTVpQ3VmL1RWbTY2YzJNSkFqK2QxVHJwbm1kT0I3Qmc1QWY4OG9JY0RJMEFm?=
 =?utf-8?B?cFk5NlRUdG91Qk80UlB5OHhXSnpVTlAvNFJjUDI4NWZzeERuTDdpMzVkY3JC?=
 =?utf-8?B?OC9SOVIveXN3aTI1TGlIbGFqQ0xFb0VtZ2ZOQjgyL0l3dUtEWTV3SkJRYjhz?=
 =?utf-8?B?b1lwa0xjRDhzZW9RUjZKMS9nbnFBN3gxVERJaGlDWkordFd6SmZBbWxPWWhD?=
 =?utf-8?B?RW85RU5XSDF1U1A5QjZBbHJ3T1p0cWRUZ2doQ3h1ZkxSZmNvT1Y1Wm9TQks4?=
 =?utf-8?B?eHZUZzJOY1QyaHc3RFlLSkU1V043dVhHbWx1Tm1ZNGZOWUdxMTZaQ1d5SHk4?=
 =?utf-8?B?M2hKWnljOVVlQ2hERnB1QUgxNE9xQU1iNUlSTiswMUxLSW5Jc3NoL0N1cXAw?=
 =?utf-8?B?MzdYdVk2ZVJIZy9xZk5ydjUzMXd0WFl6RDVYMTY2SzdxUWRjbUg5cFhuNXI0?=
 =?utf-8?B?OHdpdGd5amZkUUpEY0xsOE1mUHJSbmVmTlBwTWtVMjJBcmlUMmZHU0EvbDJC?=
 =?utf-8?B?aDNNZEZuTEZZYktxeFhaaFFkOE9UYnk3cFArUnBPMmtick1GZldCT2pyR0FJ?=
 =?utf-8?B?MmNMa0RoODFwR0lmaFFwbzFDWmFIUlllMmlJanBKOWhqNmNVZDd2MGhaeXVE?=
 =?utf-8?B?NDBtYmpNcmNBditPMUI0d2FEL3FpcXZYQ2JzbDRjNjdDUUwwSTVZOXZpVmVV?=
 =?utf-8?B?c2ZZb2x6eGVrbFlUS3dtWEIwTFQ2Y1pKeVRSSmdlNzRYZ3Y4RklESTFLT1BZ?=
 =?utf-8?B?YUdScDdPM1lKZzhCRU5UNGluZTlVUGErZGJOUkttSTRCWHVQWmxBLzV4L0lO?=
 =?utf-8?B?dFRqeUpLSkMyMGdaY2w5NndrTURHTS94TWZZNS9RRk96Q29na2thTnFGcmEw?=
 =?utf-8?B?N29Zb28vVWRmdE9jOTlDd0Nqc3B0cnR5Tks3d3RMTU1rZS9mZEpLOHladm1N?=
 =?utf-8?B?Z1U3T2lmZU1jTm5QdnhrYzJEdUtUcUl1cTdjcVVpV3JuWk52OTduemJJRXNO?=
 =?utf-8?B?ZHlVZDRSanBjYnlCejQrTWNYbktwMjRBS09ieWM2enZua20wT1hYYXpLNWd2?=
 =?utf-8?B?NnpCQktvUG4vQWZLYVpPUittRFFhb3dnajMwRVgzYWJhNnVDUTNMU21XZ0s0?=
 =?utf-8?B?d0MvNEZOMVdWSktPRUVwS21nTllPYSt3T2dXblE4NnFHM1hQbTcyNEE4b3cw?=
 =?utf-8?B?aTJCNlBtSDlUQzdDdXMvUU95ZGErcUoyNGJCcnRFbnNZeW5zck9NaHlXTTBj?=
 =?utf-8?B?NTE2Nkg5elg5VllMZ0hlRk9yUmJJZmRoV3A0SGJNMHJNazh1Q0EvYlZCbElR?=
 =?utf-8?B?R251b2l2elJNZkowekF2K0x3OUxRaE0vRmg2MGxKTjExaHI1elV6dnpSa2VI?=
 =?utf-8?B?dVZYQncwemkwdTVDY2FObjJVRDNWZmsxU3dwRWEvZEZ5ZWFORkF0cTlva3dO?=
 =?utf-8?B?dzNmRDVOWTN6Tnhua2JlSFAveFppVWZZNXg4VlB5VG80cnFkdE4wWUVyaWty?=
 =?utf-8?B?UU5DN01tQkdMcjNGV3JROFFxWEYxNXk0RXVRZnlHa3hvbFhrenZLYUw5UVJD?=
 =?utf-8?B?bnpsWjJxc2hKWm5JTzdLdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFA2NXhiUXlnd0lKV0I2T1R1Y3ZrQnBNT0pWdjdzaXJWcVpnUVNheDBVZnFt?=
 =?utf-8?B?cUd1T0dyanBvczJteHFwMUdNMXR2azIvT3NaTnpYU0VvMUNWOHRldGNXSXJz?=
 =?utf-8?B?WTVPWlRyTjl2T1FBZ3ErVERvMjRJaVg3S2J6Z1hUU3QwT0Yrb2JmLzVxbWtE?=
 =?utf-8?B?N3NSbzIrcE1BNm9PRlR4WWNnUTlUa0pkQXBwUHhmdnVVSWlYMWJrNXA3VTJo?=
 =?utf-8?B?RWdZWllPcjZ3dVhXYzBaalI1MXRwUmljNkVGamdsTWxONXpvQmloOHZiTEtE?=
 =?utf-8?B?ejFQTmdRTk5MaHZDQjBqV241ZUU0KzlGOWhVTU13T08yNmk0Q0FCOUVaQ0FS?=
 =?utf-8?B?dXI1SXdRQzFtSTE1di9lS0h0dDlCYjVxZDd4WkpYTHlZWHAyRTRDUHk1WnRy?=
 =?utf-8?B?V2xaZ2hHWWt0Y3NDV0hPTFN4UzcvWURJUC9lbkgvMjZBeU1XdGp1dUFuSGZ0?=
 =?utf-8?B?d09LcklKaWw2L1F2c25RNVJ6NEhiVElCNy8wZUZjeU5BNHZHbEVVbVJ4RDd4?=
 =?utf-8?B?dnkxTUd5YUxlM0NnL0VIS1djUFI3VzQvQkNjN3JOSGU4d09TR1RGMkFKcDJ6?=
 =?utf-8?B?d3VBY0FrQnRvOFNoQ3VocERGVUF1R045TDlDWnVIQ0lGZTNLOWFmeU1idzRR?=
 =?utf-8?B?eEx4NVhJL0hKaEVkUDBBdUgrelN4WlFTekhIdHBvRVFMOHdNOXRGRHRIV3VQ?=
 =?utf-8?B?WXloUUtjaFVySUtCSlJvL1lBeTBXSkowLzBOa0cySCtNUlZYdWpxRThPU3pz?=
 =?utf-8?B?UldpM3d0VS9DZk42TU4xSnlLeDNiYllnWWlMdHo3VzIrM0lSRWdCNnRFaTRJ?=
 =?utf-8?B?Ky9sQThNTGloK0RsRGFNT0JBb0gzWFBPUjlQWDJDUHJoS0lnTkt3aWhuNTRC?=
 =?utf-8?B?VU04dE9uR24xR2lWTEIyb291UUpOeWFGVEZMTUtQQnh3ZmpIZmRoRGFuY2x5?=
 =?utf-8?B?UGVWOW9FeFFWeE0rQUZyTDdLbW1YK0NFZStqS0xzTExzOHdyRVd3c3lycDN6?=
 =?utf-8?B?NFVMVkNaQ2tnbWxVbXpyWXU5MnpXdXdLZ1VEN0h1alk5cEdMeEFrZDdYUytu?=
 =?utf-8?B?TjJBZVVFNElBcnZoc1hNSmNaWUhRdVpucFJWbWU2UEoxOUE0R3A3ekppYXZn?=
 =?utf-8?B?NzhmNHJoYjdESDJZQVE1eElQV1RJV3V2cU5hNm5raWp6L3luUE1WTU5aRExs?=
 =?utf-8?B?SjhOWFJ2QlNzMTRzSWloZGZDNnQ5YXZWSWJtandya0wwQXBYSE15OHB4Uytl?=
 =?utf-8?B?OGtBNmFNd3RhS1NETGNRaU1ySzArNGlGMVRPUG9MOEQ4TVNMUjJkc3Nibi9o?=
 =?utf-8?B?OXZXVjZQQnlSMVZXZ01HaE1RVmtyRVkwTlVQb1doaHZ4WU1jczFVT3ZWZ2JV?=
 =?utf-8?B?dmxyNXNBSEYreU5FYWMzamRGTVk2MXpCS1lmRFg3YlVKSnA4U0M0UU4zWlpH?=
 =?utf-8?B?eXkwMXNkbHpwaHZDNTIrbWxyZ29hWmlIQTNiMDBzcDlvVTJ3TEdCY0lObXFn?=
 =?utf-8?B?OTZpZFBDMmhiVEF2QUcxdWVRSC9JNXZQVTliNlRaTmVNUkkybEtBWW05Zkxt?=
 =?utf-8?B?MHBGRWlrUmlVMVVkcm1lSm4vSEdxNjMweE1lMkVmQkRhUzZEdlVVcExyVys2?=
 =?utf-8?B?Ti9DbGlVcjUyNXVTQjgvOCtRU0MwQ0lhb2tMTDZQZG1KTXlJRTdXNlJmVUtZ?=
 =?utf-8?B?NEdpc2pZTnBQenhWbTI5NUpjQzlIak1VZ21hUXMramQ2TWpNdEl1NWdQMTZ5?=
 =?utf-8?B?WTJjcHhqaEFhbE0vcW1tOTFwQWFUejFiTXNQZzhKZzA0TU90QkV6dkVXTmFJ?=
 =?utf-8?B?cWFjRkp4Q3k3YVdBdUpJclcvVUR0YndTV3pBVGowMitzS1V0MWZmblhOcFlV?=
 =?utf-8?B?c1BYbVJVc09sUzhvOXFISXZzbEU5WWUrZGJ2OUZ6WUlJVUJmcnRtYndSaFVp?=
 =?utf-8?B?MER1ZWhqSStBc1M3aHdUQ0tIRFdMZ0V1Y0lLK056eG0xSFVnZngvWXIrZ2xS?=
 =?utf-8?B?VGI4VlZQZUNCTE1Bc29KVldaQy9ab3pqQWYxNEpBeHNzRHlEL0xGVzREU2lp?=
 =?utf-8?B?cUUxNVRqTDd0VFF3TVNBNmhSVUZtL0IraWFqYmJVOUhpZzZjdVVHWERBYXVr?=
 =?utf-8?Q?dAQSNCaLrTUghpKmHPoLiwIJ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e85c09-1992-4b9b-907b-08dd0d071dd6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 04:10:37.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAGL38wZGx0zyovSfV7hfuNEK6YMToyLCQigYA8oHJEUTddRfIwaD6Az7ZgIoVmN5BT23bRJbH0g5iPeCKqFpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216

Hi Peter,

> @@ -6507,6 +6540,7 @@ static void perf_mmap_close(struct vm_ar
>  	unsigned long size = perf_data_size(rb);
>  	bool detach_rest = false;
>  
> +	/* FIXIES vs perf_pmu_unregister() */
>  	if (event->pmu->event_unmapped)
>  		event->pmu->event_unmapped(event, vma->vm_mm);

I assume you are already aware of the race between __pmu_detach_event()
and perf_mmap_close() since you have put that comment. In any case, below
sequence of operations triggers a splat when perf_mmap_close() tries to
access event->rb, event->pmu etc. which were already freed by
__pmu_detach_event().

Sequence:

    Kernel                       Userspace
    ------                       ---------
    perf_pmu_register()
                                fd = perf_event_open()
                                p = mmap(fd)
    perf_pmu_unregister()
                                munmap(p)
                                close(fd)

Splat:

    BUG: kernel NULL pointer dereference, address: 0000000000000088
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 105f90067 P4D 105f90067 PUD 11a94a067 PMD 0
    Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
    CPU: 49 UID: 0 PID: 3456 Comm: perf-event-mmap Tainted: G           OE      6.12.0-vanilla-dirty #273
    Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
    Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 2.7.3 03/31/2022
    RIP: 0010:perf_mmap_close+0x69/0x316
    Code: [...]
    RSP: 0018:ffffc90003773970 EFLAGS: 00010246
    RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
    RDX: ffff888125c2d400 RSI: ffff88bf7c8a1900 RDI: ffff888125c2d400
    RBP: ffff888103ccaf40 R08: 0000000000000000 R09: 0000000000000000
    R10: 3030303030303030 R11: 3030303030303030 R12: ffff88811f58d080
    R13: ffffc90003773a70 R14: ffffc90003773a28 R15: 00007fcc1df1d000
    FS:  00007fcc1e72e6c0(0000) GS:ffff88bf7c880000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000000088 CR3: 000000010396c003 CR4: 0000000000f70ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     ? __die_body.cold+0x19/0x27
     ? page_fault_oops+0x15a/0x2f0
     ? exc_page_fault+0x7e/0x180
     ? asm_exc_page_fault+0x26/0x30
     ? perf_mmap_close+0x69/0x316
     remove_vma+0x2f/0x70
     vms_complete_munmap_vmas+0xdc/0x190
     do_vmi_align_munmap+0x1d7/0x250
     do_vmi_munmap+0xd0/0x180
     __vm_munmap+0xa2/0x170
     ? hrtimer_start_range_ns+0x26f/0x3b0
     __x64_sys_munmap+0x1b/0x30
     do_syscall_64+0x82/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? tty_insert_flip_string_and_push_buffer+0x8d/0xc0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? remove_wait_queue+0x24/0x60
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? n_tty_write+0x36f/0x520
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __wake_up+0x44/0x60
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? file_tty_write.isra.0+0x20c/0x2c0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? vfs_write+0x290/0x450
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? syscall_exit_to_user_mode+0x10/0x210
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? do_syscall_64+0x8e/0x160
     ? __rseq_handle_notify_resume+0xa6/0x4e0
     ? __pfx_hrtimer_wakeup+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? syscall_exit_to_user_mode+0x1d5/0x210
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? do_syscall_64+0x8e/0x160
     ? exc_page_fault+0x7e/0x180
     entry_SYSCALL_64_after_hwframe+0x76/0x7e
    RIP: 0033:0x7fcc1e849eab
    Code: [...]
    RSP: 002b:00007fcc1e72de08 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
    RAX: ffffffffffffffda RBX: 00007fcc1e72ecdc RCX: 00007fcc1e849eab
    RDX: 0000000000011000 RSI: 0000000000011000 RDI: 00007fcc1df1d000
    RBP: 00007fcc1e72dec0 R08: 0000000000000000 R09: 00000000ffffffff
    R10: 0000000000000000 R11: 0000000000000202 R12: 00007fcc1e72e6c0
    R13: ffffffffffffff88 R14: 0000000000000000 R15: 00007ffd1a4ce000
     </TASK>


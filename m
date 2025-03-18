Return-Path: <linux-kernel+bounces-565939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B76A67155
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168BC3A7BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25542063EA;
	Tue, 18 Mar 2025 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OT7wfx+Y"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC783133987
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293954; cv=fail; b=k6lWAwluSCFDXa17K9iwjpLOaLyHm41NwNnqZjDSScWqQaTrshYbd1f2aKQxVF7SFcN3WpIovkRMBW9ysOyqCBALy4RNvcb+Y2+bnTBtEHZ9ta6ikxon5TvfiNsZ4eamHOGS0CaNC4WuTjj8D7VfbkHI3hrqa/JUrQmUKQeP9ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293954; c=relaxed/simple;
	bh=UMAC+8ZNvumXF13rNjnemBQhTkZC063hxaU3dE+qRTQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X2Uav6mo84PX3Ff1vbTcn5S6z8qsGaIqbpmJfYVI/h81G1PCE9WeBpmkKYHGO1DgS7Yxy8zHPt//2/zbYV7VyBjvsisTtJBQZqY1WIs1xgJlt4ob7TV58a+JtGBLTLQdxcMuEUGimQlRoCMsnNfWtpNZvFASoImd6YFO8KK2iJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OT7wfx+Y; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKyHZOUXJhBhbIC1FVrv6Y/6/RGAv+cuRWIEKEOtROGVYArW1mWsFU6d/xiogczVSWsZHX6leOZjxw7Ml7V4UyWh7SdyafgeBJLfrd593swklJn4n5xGmvwg9RUFYs0q2HiNK6SvuVC+F2v9M+03PCcTKLVQbOwA1/79Q1/vxTf2WlMxV5GHytaZgM7AaMTmIW5UcBqIZa47kI4raIXJdGApwMGLxch08e+u6T1rkpgeHi69p16k/z1WDBkr3uzahN7seDLKclF42E6m0bHzaquAbe7h1mNQslySVak2zS/PDgCl8kW5PG/zSbw17kJmlONyYVINOjpClP5mfA6fBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ii7KbwLIC4emrupp8SgsckrDs1q8hnK4oZfHnePe1Oc=;
 b=lp+gdf874ZkZDonqK+EQqDNfqA0VDOarmRIpevUDdJl5Gnx2DjfxEXN0pXkT6A1d6gh2uWLGkZHc3L2xrHh5r0uVZ6gXHTargq31774E8xPajsbX5eCIrvvWOnQeHUuiAVqGPlIXavZsWHakCyszrVJnVbRL/EGO8+BOdBAX1qmvmnopCrXrmKVH6ipNSgL4Es2ZUQBvNcdqTOwmLyy6BJrRQgdRPtKuz0A0rDd7+dNbj9ksquagfJ/EXWxEHziWE/9HQkAJCntTsqCqaKmmqE4KyuOmIyGuWJON2oy8rWxNbHWkuMMitBUh4Pvb1cy5XzkB7E6Q3FNHHJP4+mVZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ii7KbwLIC4emrupp8SgsckrDs1q8hnK4oZfHnePe1Oc=;
 b=OT7wfx+YYsZatWtdW31bXWnCXJwJS00vm+5MTCGGxQf7CVubiUnG2TPpwfVc8xzVRJj99fKjQTnKFs1haS5aTIlsHqcDOjMX/xZ8tyJpBj4ejPE3bbALVJM9kqbi1+BeGnAtufQfqgJa4/Gv/o01myGFMKiJ0AYuLgrSGazhQ7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 10:32:29 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 10:32:29 +0000
Message-ID: <0eb55fa1-3b03-4550-bdd7-c7c50294dcbe@amd.com>
Date: Tue, 18 Mar 2025 16:02:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/x86: Check data address for IBS software filter
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Matteo Rizzo <matteorizzo@google.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250317163755.1842589-1-namhyung@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250317163755.1842589-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::10) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 67396fbf-ffce-46f8-c3c5-08dd66082ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aW1GNUtRS3VFcStWWnZJREh3Ty85QUxVakorR3l2UU9xTFNXcEV3WkRFaDZm?=
 =?utf-8?B?RHhLb3JGZ2MwRk80dEs2Z3JwWDgzVm5PbnlzU1orV1pzS2Joc2N1dnY1RUJk?=
 =?utf-8?B?YnBteTZRODNmZU1YQTVYWEdHRHRmQWhXcGxQdzR0enBFU0Jhb2JDWDlQREYx?=
 =?utf-8?B?MmV6T0YzbzluK0E4Q3JTdmlWU3lZYXBsaG1haFRDYnZLR2dEWVQzSnYvdm5O?=
 =?utf-8?B?K1B5bmhvdFlPdXBGRDVBUFZPMXJOamoyakF5MS9jUlJBa0Z3TEx6YkdrL2do?=
 =?utf-8?B?dTlTQ0JmWlRuZVhWWFJpMitIM2hTejU3OE9SZmt0c29vbjYwbzhYQWJMNHVZ?=
 =?utf-8?B?aThtY1VENUFOdE9waHp2WEp6OFI4ckxqbXJaeG0wZlJ1RmZtRmR1eUNpOFdT?=
 =?utf-8?B?dW5kMjUzZ3VxdEQ4TldpeTZUeHNIcVhNK3B1UkZiM2pQS2l1dGZKRitweDNN?=
 =?utf-8?B?Y1lDSHJTNkNxNEZxc2JQRE82akRxaVJxdDIrR3BvWWpEL2ZhZXRkZ1RwZEJw?=
 =?utf-8?B?aDdpazhOUTNlWWdzT21Bc3QzdFlsMEl2V3hJekkxQ3ZkWXNUWnhKWWJsUElM?=
 =?utf-8?B?YzFHNWdESlh1U09RYWFqUlpJZTRDaEYrNzdGN2NDaFVySDBKUGRRRHZUSzUv?=
 =?utf-8?B?cHpjSjRhMkY2VEVHa2hxQ3doN1hvSmNXN091Q2N1NG9ROWgvd2RiWUJkL3pK?=
 =?utf-8?B?bXA0VTN2Y1B2eGZuRERSMzM3YjhuR1Rna1ZxcjJ0SExsTmM0RGkyL0NYU21E?=
 =?utf-8?B?WHMrRFJPT05WVTQ4WmdOaHpndTQzcWorSGM3MFJoQnljQjByOXoyZGpKa24v?=
 =?utf-8?B?c2EyM1M4N0N5UXFiSE5wUisxc1hsMmhPWkcyU2Y2b2R6Ykl5VjZsOGJiVHo4?=
 =?utf-8?B?V2Ria21JckkzcWdKSldEYis5NHBuY2JNalExRzB2RVcyU0swRmE0OUFDZi91?=
 =?utf-8?B?c0xzdW5mUFRPakpON2NyZG1yLzFTN3pWd2tVTmV2QmhzV21ZSVdkSVBydWVn?=
 =?utf-8?B?ampWZy96T3pjTytLZHYxemQ2VHpwbHlQVHpmYnJ4aGtwaUt1eXVmaGprS1NK?=
 =?utf-8?B?WlJaR2lacno0SlpyY3RyaE44VGl5WUZjV1o2QlF4bnEzU0htRWxRRGlZK21X?=
 =?utf-8?B?Q3I1a3hUVS9JdlNORjR1Rm1wblMzMWd1WXNUeE53L1pyOHVteXRHRHd4NUYy?=
 =?utf-8?B?Zklpb1RtcHNlQjJ2K21LbmtQNWtZbXluTEk1Z0dQRTJjcWtCQ0tVR01mWm1l?=
 =?utf-8?B?ZTlNb2NxNlo4VThDbTZCZGpNY0JUaFcxdzVJbzZ1T0VMRkJsaXNtd3BSWFVE?=
 =?utf-8?B?eEt4Y3dRVUxZWkNxS0hidkREUTY2WHRwVnFENUQ0UmFvU2xvcGdHMm9GQjVP?=
 =?utf-8?B?ZmsyeGw0Z0Q2STVvYmxWN1NZQWVnVGpMdmFLdTNZQ2tSb0hTOEY4RE5qdXJm?=
 =?utf-8?B?SE5LczlFWUFTaXBBaExmQ3E1ajgzcUZHM3FHRFQ2Qlpxa2EvQVpRM2wxaVUw?=
 =?utf-8?B?RVFWd293UjZmUXdOeFJFWngxejNEa0tjQ3lqT2lnemdVOG9vRFBLd0UwSUhp?=
 =?utf-8?B?UnZvZXBNSGc0cTJNZVVEZVRpNDkwLzQzczVBcnZpU20xazkxV1pSSHlMV3Nt?=
 =?utf-8?B?eHRvUUc4NEx6cXhHek5uZC9yVVJlVS9haFZTMUR3ZllvMHVva25HZUswZHlk?=
 =?utf-8?B?Tm5ZbGpvQjZxMGMxNXJKMWtYY2VQUVFFdDI2MzNrdjlHVTF0d0JUcmxQczR1?=
 =?utf-8?B?V1UwRjVrbUorUEJxcndQV3dMbjc0ZmorQXdmOVk0KytxTE9zZTFYeDlVcHVu?=
 =?utf-8?B?U1pqd1UxVUFFWUYraXphVmFsZU8rUUhjUCtGc21yNHdtSmxQc05CUHdTSHZ0?=
 =?utf-8?Q?MpQNpm13iudFr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uko3R0dHUHUxSGl1L0luV3RNakJ5YmVwYnk3N1BTamQ3cncwZjVTTVBsZXRu?=
 =?utf-8?B?RzMyaHhPd2hTY2h2MUViMEVZK0t1U2QrckJDVFBqQkRQcVZjWTN3SVoxanlB?=
 =?utf-8?B?ZVczN0pJejJKWFNmSWRWWWY2b3NkaXhNK0gyd2VET2hnNHh3dXVva2h4MnZG?=
 =?utf-8?B?ODJMdnJ5eUJsc3dVTHJzUmlwOWRsMUxHcStsR1pXaXhuTGJFQnIyNFpCY29o?=
 =?utf-8?B?WWlXcC9mUUpZRXhpWmlnOTdXRngzajExVGk0NlFIczhkYjFuSzRaajJHN3lx?=
 =?utf-8?B?ZkJEZmZEMWN2MThJUm5hN2FMY0tZYXRMc3o0d1Q3TFV5bjd5cjBwUVR2TnVC?=
 =?utf-8?B?L1VTZVZzRDlleDRvQVg1SGVrUG80OWhqN2VtSW9mNENNRllPdElCbHRHTTN6?=
 =?utf-8?B?RXVoV1ZtMzJFOVZMYnVrSWlZVVRuL1hXL0Vuc1UyWjE0SWpzZzZZWE5rc2Ra?=
 =?utf-8?B?Vmx3RXkvclJvOW9kRk5MRUFNVDNEKzBkS2dyejB6SXB1WXJaUEdjamp3c1du?=
 =?utf-8?B?R1ZkYzM2cXRjR1V2VDM5UGJUZ1pDaDFueG92aEt2RHdyY3c2UkxvMllucGdX?=
 =?utf-8?B?Y2JBZHVYazJHT3JqelZROCsvSUVBZDVBTDRML0RQcWpGdVZ4UWdCbTlhaHdP?=
 =?utf-8?B?MlV3UHYxTmJqaE9KME12SVBhVU9NRVhmUzFrdjdlYVlxRFBNV1lZZDNIbG5z?=
 =?utf-8?B?VzJLeG5EZWF4enZwNDlyd3pyQm16cW1tOFZBVlM4STZrMU5jZ09YR1FnZ29L?=
 =?utf-8?B?eVMvdjlJS3hhKzJhdk9MMDNMay9Hd0dDQkFLUWkzQ1dDSkVUcHVBODJxNS95?=
 =?utf-8?B?MGpUVzNlMklQeDBOeUl4OGFndzVtS1RwMjA2TmxVQTBnbmRyQWJpSWRwR1g1?=
 =?utf-8?B?M0laellib0ZoL2pvV3doTk5EOW5GSGpQUUN1QkZzYVZDK1QrQTNNVmxhMUlj?=
 =?utf-8?B?Wnl1RXhNT2ozcFRUUFpnUURxYkIvOHQ3bUVqdzdCR1p1L0k2Mm5vSkdBVFlW?=
 =?utf-8?B?bjVHNUFLT2NJRnNkVzg4NFJNSkZRYzJQelZQWTJ3MlpUdmdOK1lwaFFZMWtv?=
 =?utf-8?B?WkdsZHRKbk5OUTVuZUdQQ0dSYXNuc05JcTNlSzk3UVFGdDBJbXZUaENUc0VB?=
 =?utf-8?B?Y0tQOXppc1BSMHlXekxJZWZhNll3NkFKcVRvL3lETk1QcGcxRXZ4Z0Mxc0p6?=
 =?utf-8?B?a3k4MitwQUpDNVNGOUtvSldtdGUxVzdiTGo5eUx4MTZDanQ4OEc1TVJsTGZ2?=
 =?utf-8?B?cjhaZkNCNElNWGlOYmNHR1h3dm5aNldhdnVBRjkxcjBnN3lBbDlmTGR1M1hp?=
 =?utf-8?B?Q3NaYUFIVTJuWjgxdndqcG1jZmZ1UVdDc2hiakgvK0JWanZBS0NHNy9VWjBo?=
 =?utf-8?B?Q1RORGJFSVhnTUFIRWJONDZoSU14SE4xdzkxaHd4SDVuMDlCNVQveERZSnh4?=
 =?utf-8?B?UEo1dkJLUFRkUnltWlBLMkpJQ0dGdy82eVFXdklwSGFwY2JPWjU1STlpRlpl?=
 =?utf-8?B?QW1scWN3bFE2M1FvdzhNMU9UYXRSNCtrYkd4Z2VFdkYwam5CMjV1dlhWbW04?=
 =?utf-8?B?UTQzT29zNXZTbms5eGx5TmNXWGhzKzBLNDZZeTFTR2pZVUdZSWJCWFV6M2RO?=
 =?utf-8?B?TDNYd25ydFJKTDNjcVFXQ3BqanpNTFRxQ2tiMGYxRmFNN0p6RTVXWkRLZ1Q3?=
 =?utf-8?B?MHVhOFNDeHV0YTVldGVnNlRqT2JNZHlraUhEVXFwUXA5ZUMwRmV6eE1hSTdx?=
 =?utf-8?B?RENabnBLUERBU1JkSEt2V0Q5enJIMml6SUJzYW1ISE5Ta2xqS2hPV2ZWNWhr?=
 =?utf-8?B?cGttY21wL092dkp2cXd0UHRtdlBBRUZ4eUdENGFuRUppT1c2YTNNMjE2RE9N?=
 =?utf-8?B?VmExVTZhd1piSjhBTUU2dWIwV0JEK1g2R1F5NUo3Skd0cUlLMGt6VWY0WUFC?=
 =?utf-8?B?elNvQ0xDQWxiakN4TFV1WDZDTkZYdHA5a3gwdzExanFUTVdvTkhwaGx0dmti?=
 =?utf-8?B?cGkybm1la0NUdTFUV3N6dk5wWlYwQmlxZ05NaDFVZjVPUzJpbzM0Z0hYZkd5?=
 =?utf-8?B?M1lyMWw0YzZmMit3cEFMd3RLdlI2bFpQMTNYNmN1ZHF1cVY2L05HVkp2OUV6?=
 =?utf-8?Q?Rir+5HNXHCJrkc40ywUQc9Of8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67396fbf-ffce-46f8-c3c5-08dd66082ed0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 10:32:29.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tx7gEGEQXY3fH8iexidbpp72oPK6QwfNMsPJkeFDOveIRzRtR6l1JkhMeLAGXgKVgMNGZVpEnfYtnP0BJCS5uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949

Hi Namhyung,

On 17-Mar-25 10:07 PM, Namhyung Kim wrote:
> IBS software filter was to filter kernel samples for regular users in
> PMI handler.  It checks the instruction address in the IBS register to
> determine if it was in the kernel more or not.
> 
> But it turns out that it's possible to report a kernel data address even
> if the instruction address belongs to the user space.  Matteo Rizzo
> found that when an instruction raises an exception, IBS can report some
> kernel data address like IDT while holding the faulting instruction's
> RIP.  To prevent an information leak, it should double check if the data
> address in PERF_SAMPLE_DATA is in the kernel space as well.

PERF_SAMPLE_RAW can also leak kernel data address. How about:

--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1159,6 +1159,25 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs,
 	return 1;
 }
 
+static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_event *event,
+				    struct pt_regs *regs, struct perf_ibs_data *ibs_data)
+{
+	union ibs_op_data3 op_data3;
+
+	if (perf_exclude_event(event, regs))
+		return true;
+
+	if (perf_ibs != &perf_ibs_op || !event->attr.exclude_kernel)
+		return false;
+
+	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+
+	/* Prevent leaking kernel 'data' addresses to unprivileged users. */
+	return unlikely(event->attr.sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_RAW) &&
+			op_data3.dc_lin_addr_valid &&
+			kernel_ip(ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)]));
+}
+
 static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 {
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
@@ -1268,7 +1287,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	}
 
 	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    perf_exclude_event(event, &regs)) {
+	    perf_ibs_swfilt_discard(perf_ibs, event, &regs, &ibs_data)) {
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
-- 

Thanks,
Ravi


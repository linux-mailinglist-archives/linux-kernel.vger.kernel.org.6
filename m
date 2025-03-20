Return-Path: <linux-kernel+bounces-570418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E9BA6B01E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BF93BB4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A2227EA1;
	Thu, 20 Mar 2025 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H36SI8NI"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025EF22A818;
	Thu, 20 Mar 2025 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507164; cv=fail; b=V6ygG7r/eS2H/CzzUlsxj2zsKAdMw8Md6Y6PWaIb70SJ174QJboNEAY4TQL6GO4q0f7S/qZ+cMwHeI+QDJtNtd3PAodJsnxyg/bRY2A/4sMACJQPYZ4oI11R19LImHEVEQcVhyky9MIOtEbe4Ul0C9hvH/dA5Z9podbm7WFMXQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507164; c=relaxed/simple;
	bh=xPcrP4XK9/dl267tIgOh6zl+pIZuA6JYbJxuvAu9h9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eEsm2SqQO6CPlWk+xx4dFNtS1Kj839BDGTGuPyktXHd9dabVGKPxp4C5f1INHOULOU6OOR8SCcf6ifh7OIOI6ChKkNnuO8/GUVqwKIzsddq/X6kLHYraa8q2ajzngWKGW34Jwy+IJbxSq6LH9WzhP8mLigrNBhZFP54GS8X8SHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H36SI8NI; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0+4gU69EPQVzTegQCQMKMuQ/nFa5jF0HTtQuJ4F6b8XbMuIfdx7xN7g7ntdRH+x5XVdzkGHW/OkdDjdKWpVB0ofKuk6XxHcdWuSbuEsgaOa7iexg3DhY15RqqVBB+xpGKMFDe0RvV+XH2xSp4pLdZUKzc3smwHJ8rFNoHpruZzzhWPbLW7klesiJpItyM6EzhGcqgzqLwRCkpisQUE6zYEqCWGYwfG2C3v8yQBY9BV2poPZzoR05NDjWrtz1QU/4qQ23YD/mpUKvx/fyOxsIjJcFyFZGm4RyvLYtfp0vN3DT2Py4mazoL2wY87WlQfHiYNRLb9VK69BTMOb7OqLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VmlMQWN11Sg5ZGbG0Fp/4+EPK+x6YtFF6nHkOb5+r4=;
 b=zJjSz9EsPe0bF+LjGC/4mCY0qPOBFectMSLGKYpVywOZdFs/lw3fEFAstmIl1i3awCdTkrrTDy9CVFoEQ5u1RrBAtpu8DfMnYhUTmQUsfSgl3Hs40TjIt9+trJd/GIiLFCQKHfGlUIBmau3MotJD3F30xpI7mI8rb2XzXRSuDCdwBKCJOixwz6sARcB5dj7onpPFJayggr20bN2eoNbGy/3SssVbmNcnyBs30n5ctIo+fnLrqE5DaAeHbRDC9Pui3x7RQQfLlUfqy8yS5c4880nSYe/JvgPvuFK/W6kBVwcEMVPpvhwKt+8fDqF99QGZVm1Mno3TFkMsrW2Fg9ENpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VmlMQWN11Sg5ZGbG0Fp/4+EPK+x6YtFF6nHkOb5+r4=;
 b=H36SI8NI3pS4xGWXD+TWWWIc0gN+Hx+3d+9m/cHWP6xdJDWaKoJi51V8pacLB6dKDXeeA3yfnWm094LdDnW6YrK8Be6aa42gFiSTiCBh+ZDVRJuTCoAgfsxQ2SauVHjxdlvx4xOW6fs3PO8n/jLh23HypqJ4+KhJ2h8rUbUSSsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 21:45:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 21:45:57 +0000
Message-ID: <50887dc8-7fed-46ee-be63-dc83f9999969@amd.com>
Date: Thu, 20 Mar 2025 16:45:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] platform/x86: asus-armoury: add ppt_* and nv_*
 tuning knobs
To: Luke Jones <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org
References: <20250319065827.53478-1-luke@ljones.dev>
 <20250319065827.53478-9-luke@ljones.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250319065827.53478-9-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0060.namprd05.prod.outlook.com
 (2603:10b6:803:41::37) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c097547-5481-47e2-dd0d-08dd67f898d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEdNZ242MzgybnhHR01Mb0NEVjlsUDBoK0dkY0x3ZnVHcFQxc0dTSG1yRXBj?=
 =?utf-8?B?aHR0eTYvUkxKbjE4OEdsNGswVDZoOGhsQ0ZIaC9rZ1RrQzhKcENBL1NKbE1j?=
 =?utf-8?B?WWV1OUgwRVBlZXc5TE1PN3Z3NTBZN1dTQkFQbzliZU5UdCtaaDZ3QXVnT01w?=
 =?utf-8?B?TFpDZ0wvaVFLL05IS2tkbDEvNG9ZamNYQi9TWGMyVlZaakxhRldjZFFLa1RU?=
 =?utf-8?B?R094WExjVEdDMjBYekZiQ0FaUlZYUHY4MDRrYldpQmR1UTFUZ3pJM1ZXZ3oy?=
 =?utf-8?B?My9rSVNsQmdTeU9aNTR3YVhMOG91N0pySGUxUzF2Z1RhR0Q5dEwxUStEYWZJ?=
 =?utf-8?B?SVhubjRhRnRrZ1Y0dVpTRlp5VTQwQS9wbHFWVEhTSmp0VFYzOEdhTzczWkxp?=
 =?utf-8?B?Y0ZqbVNMNE1FeHQxTzBYYUs4R0tPcEpzU3NPOStSbnV2a1Q4eC9jYlNpKytq?=
 =?utf-8?B?VHVSTTZsdHpIdkpTTXZWK0dUUlcxVjNLSmVnc1YrN2VUM1NvUFhHTDhXRVpu?=
 =?utf-8?B?VWtIU2VyUnN3NmxrQnN2Y0FGYmpVcUlKbHJzR0tUaXlGL1ZicFoxcGJPcXVp?=
 =?utf-8?B?ZFRUV0NYek9PVDZHZ0dkdmZVaHN0Q2g3Y1NOM05wUVVLZmJ2QnBYTFp6Slgz?=
 =?utf-8?B?amdyUmQrdkxXS29RWDBReFVBT3AwNXFyMS9oTFRRa0dXQ2hPUk9yS2ZBb2gz?=
 =?utf-8?B?aitkOXhBUURTU1VwcS82L3Vmd2o3ZVUwTHhuSEhqMytsd2doeVd2UjUwaVdZ?=
 =?utf-8?B?REt6S3lmaVA5bWxjQkpwNm44NEJyUTQ3ZEhwSUxiVzNXeXFVdlN4VmQ2M0ZZ?=
 =?utf-8?B?RkJhM09vYmloYVdCTTBwTjlkemxHQ3BRbGFTaDMyVWh3NGRWcWpSMCtBSXIw?=
 =?utf-8?B?ZS9pUjBwRlJnN2JQaGhRTW9XZFVvMEVlVytpSGRaR2NZSjNWYjU3dnJHSEVC?=
 =?utf-8?B?bmJwUmxaTTNjNEFxb1hDT0xhbHdLcXphRFhKYTVyaEdZWFJGc2wwQTNhY3VS?=
 =?utf-8?B?S1F2K0VzZ3lEVi9nZ01sYStHRUlQVkhvaDNRTWV6dXcvdGFrNERDNkdkMXhU?=
 =?utf-8?B?MUU1bkljNDYzb3BzelN1RDd6UXdjUTdaUXhWcDNLZ3dZTmdXSU9md2huWTVU?=
 =?utf-8?B?Yzc4WWlicWE4UE1sSHpNSGgvY0NqNUhJeW9GVEJXQ3lQS2lEOGNJZXdjMmhj?=
 =?utf-8?B?NkRuN1dTY2JRT1hxTHJubTNJSDVWbStPOVVDaVBQK1l3N3AwUFFiTlpZbXBH?=
 =?utf-8?B?cFhoaC95eEQ3aGxGRXBwb3BXeEsxTGszM2hMRUhEdWZtOGFsNnhMMGtOTURW?=
 =?utf-8?B?RXJCZitkVEpHS0FKeTl3OEJJZGdKb3NrVi9MQUVuNU9aWGNoaXhxbzd4d0Jm?=
 =?utf-8?B?T0ZWajYrTzdXVWw5VWJUUTNoeEF4ZmROSVpZbHovZUQvZnQrOTE4ZDJKQnlN?=
 =?utf-8?B?bW1tb3kxZmN3a0ltVUFYQVJxMEl3dmprcFA5VDJmVlhPY0RoTkZlNyttUml6?=
 =?utf-8?B?am9pVW8xcFRxcUx5b2RRUFhQbUxic013YjlMSyt6Q1Z3VlVZbTlXVmcydDZJ?=
 =?utf-8?B?VUlPdWgyL01Wb2h3STBqTUx6ZUYxSmh3ZThtMHJTSXZzT1VlY0wvbW5maksw?=
 =?utf-8?B?VHNacjRyczBLWGNuWmo1VHg1UmFtVVdmSWEyKzZDOWV1VEZzQ1loNzJEelNW?=
 =?utf-8?B?ZDZNaS9PcEV2MEdtRndQdVd1SU55U01hdU8rdWt1Y2pIZHNVSmVWM3RwaTdH?=
 =?utf-8?B?L2RtSTNjSy9IYzIwWC9zRWpoT1p2eDVQU0pINWJ6RG1IN2dhcmN4ZTZYUkp1?=
 =?utf-8?B?RmxrNGdhN3FxMklmNjQrOUQxQWswY3F0eGtqNkdIRHRlTkRXc1lHQVNFQmds?=
 =?utf-8?Q?XC+6qusyaAs1R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVpUTmkxL0MxM3hTbFF0ZkJoSnE3am1UbzZGNzdYcmxDWTFmcTViZ1EvbVdV?=
 =?utf-8?B?ZzFPOFZaNHRITDFBN3dkU2MxYTArQlNDTWNwVERIZkFucmMrUE9wdVNpbXFi?=
 =?utf-8?B?N25MVEhUU0p3aVZmMWg1VytUVlRoOWhiTHdyOU1QY3hwaVMveVhLMVJDYXQz?=
 =?utf-8?B?KzY2WlYxTExpZFpKN242M1FHemlYbzJydjIvUlRwMUMyZ0t3aG5qSzZYNVNi?=
 =?utf-8?B?aW5VOFpIS0VTVHpHeGZpWlgzbVlvT3d3VitiOEhsaHMyNFlvSlYxaDI2SEtR?=
 =?utf-8?B?KzBZVS93eUJiK2IyWnlHeUxTZVdnMlZ4L1A0RTAyMUtmL3p1c1hJYS8yM0xB?=
 =?utf-8?B?Si83YkVNSi82ZUY3VzVKZW9rNGdaS0Z1MmRzVXVKYWl2NWR6dERmWHRWL2h1?=
 =?utf-8?B?ak5vKytmSkQrR2tqVjRGQXRkcXREQmVBaXdRMmdlaEQ3YUhUU3NtRzUzNVNn?=
 =?utf-8?B?NGxlVlFYR3VVZld5cXVVRm90cjFCNEJjdER4S1p0MzFJNEpuSG02QlVhbnJU?=
 =?utf-8?B?bTgrK2FiSFR1Z0hHNm4xWCtsaVpKdFhCN1VENlA0eGlST01vbDZNcGd2RG56?=
 =?utf-8?B?QWg4bnNidEk4Q3B5VWt6Z2JlQjBrWHYvNVZpM1lKcWZRMDFDRi9ZYWc4dDk3?=
 =?utf-8?B?VDZ5VjhQakRKSnU5aXhXVkZKMmNqZWt1QzZtaW5jWnY4REt0L29oM1VFSVRU?=
 =?utf-8?B?QkhOa09FZzNhTWpqdWNTMmd0U1VIZHhXT0ExTjFiTTdFQjRGUkJoWWZyV1Rw?=
 =?utf-8?B?OUR4QmlrUS94Q1dQVDBNd3VGZW1LZjFPVnd6cjgyeUZzb2QwWVVVVTNHTU1Z?=
 =?utf-8?B?UTEwNGorUEh4VmNuTUpTbElyNFU4Wk9XYzcrdm4rdSt2MjQ4NTVWdWRlaFlX?=
 =?utf-8?B?TExpN0FvZU5SWHlvMEszdmpuWUVON0ZCa2hDWjZ4ajJSSUhTYVVTRkNrRTV3?=
 =?utf-8?B?dVRZUjJ2V0dKYjRqOWxCZEV2SjRrZk43UVVUU2xzaHU5cnBFbmdtdkpYZVFV?=
 =?utf-8?B?aUZPSndTQnlTVnVVai84bllsc0ZQTXR5WHVuRERjMkJ1T0MvVm9pQWJTYlRW?=
 =?utf-8?B?RThsSGtIK0hmNUhvQUF1MzJYenRzdFF3ZWV4VU83VzhUR3d2SFBNbjliTVBo?=
 =?utf-8?B?Vi9PZnMwQ0l2SWxWbm43RFZzZWkwTHQ0b3lqUlZRVDJpbmZxVnhxRGxNeWRV?=
 =?utf-8?B?N3Q4cVFyUHFhejBOdEc2a1JwZjlFYUFSRzRPeFhza0hldXR2d3FhdHhGWTFP?=
 =?utf-8?B?TU0yWWJXdDhlVUk1U0tTSFZ4blhNczUxNUYwbXd4TitrRkdxSUZOanFxaHlF?=
 =?utf-8?B?WTE0ZkR0VmtzdVRoTzlGbW52anJpTmVlbGpBbi9YK2dwVnJjbG45QzhXRi9U?=
 =?utf-8?B?c05ydW5EU2VSakZVUEUxN2NvYUd1ZTBXMWNzUkpheTl2L2VUQU15ZUtrbzZn?=
 =?utf-8?B?Y2lZb3laZHlZYy96eTk5eE93YjdnRnR0aU5qZFJIeVhiUjQrMkhocGE5cGZp?=
 =?utf-8?B?cVQrVEFDNFhkdWpsRGY4K0tWL3BzNW1iaU55MjNMSXVIdkJadzFyNDhwT3Ry?=
 =?utf-8?B?ckdSejBJM292WVd0WFo3UjNRQ1FNRDdIdjBPOGsyL0tqV3hUUWdITnlNc2Ni?=
 =?utf-8?B?RGovL1Q2NVhpYUtTaWVkOWtXMy9FK2VLWStJVDVDNk4rRWc4OGFyRjZjU2h1?=
 =?utf-8?B?eGNuVTMzTlloWTgwSUdVYUFRd1Yvc2RLcGhGRHVheUdmYTJhREJxcjI5Nk1M?=
 =?utf-8?B?dlVBbTM2SmF5NVBGTzNydUJUSXFoU0V3YnVoZXJIT1hNNHhrdTN1dnhnWHZW?=
 =?utf-8?B?UUMxODIvenFSdEI5Q3Vqb2dmQTJvRHhFVU5ZbFIwczhaSVl5YWZIckZhZEtt?=
 =?utf-8?B?S2xKQ2N6M2QvZ1E3SjF5N25ock1YY1NmTVNHMHREeDBDL3lHSFFjYTg3cTlK?=
 =?utf-8?B?Rm1Fa01uYXZtREM3Y3p4RDlmUDlvM1JISHRUTHFNb0NKT0NibGNmTUwzUis2?=
 =?utf-8?B?R1RydzlzVGk0cXY2eVVpSm13Vi9kRXAra1huK1ZXalF1dHFuWmwrUzhuM0Jj?=
 =?utf-8?B?Y25WQjVuVTNsVm1BQU1wMTZDMGlJUmhtM2R2Q2xtLzJka2VVY2tid1Fjb01E?=
 =?utf-8?Q?U7lasOhpGzxOxU7hAQZDNpxmH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c097547-5481-47e2-dd0d-08dd67f898d7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 21:45:57.3640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVx7ex4drLg60s/FA3D5lHbdk3pw5UwF47Fchqr0EwzZvP2VxPAV6XIi1DQvAlqYjWOl3e7cJh3bdtN5Bb7Aug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

On 3/19/2025 01:58, Luke Jones wrote:
> From: "Luke D. Jones" <luke@ljones.dev>
> 
> Adds the ppt_* and nv_* tuning knobs that are available via WMI methods
> and adds proper min/max levels plus defaults.
> 
> The min/max are defined by ASUS and typically gained by looking at what
> they allow in the ASUS Armoury Crate application - ASUS does not share
> the values outside of this. It could also be possible to gain the AMD
> values by use of ryzenadj and testing for the minimum stable value.
> 
> The general rule of thumb for adding to the match table is that if the
> model range has a single CPU used throughout, then the DMI match can
> omit the last letter of the model number as this is the GPU model.
> 
> If a min or max value is not provided it is assumed that the particular
> setting is not supported. for example ppt_pl2_sppt_min/max is not set.
> If a <ppt_setting>_def is not set then the default is assumed to be
> <ppt_setting>_max
> 
> It is assumed that at least AC settings are available so that the
> firmware attributes will be created - if no DC table is available
> and power is on DC, then reading the attributes is -ENODEV.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/platform/x86/asus-armoury.c        |  299 +++++-
>   drivers/platform/x86/asus-armoury.h        | 1087 +++++++++++++++++++-
>   include/linux/platform_data/x86/asus-wmi.h |    3 +
>   3 files changed, 1382 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index 802c304e2ebc..84abc92bd365 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -21,6 +21,7 @@
>   #include <linux/module.h>
>   #include <linux/mutex.h>
>   #include <linux/platform_data/x86/asus-wmi.h>
> +#include <linux/power_supply.h>
>   #include <linux/types.h>
>   
>   #include "asus-armoury.h"
> @@ -39,6 +40,17 @@
>   #define ASUS_MINI_LED_2024_STRONG 0x01
>   #define ASUS_MINI_LED_2024_OFF    0x02
>   
> +/* Power tunable attribute name defines */
> +#define ATTR_PPT_PL1_SPL        "ppt_pl1_spl"
> +#define ATTR_PPT_PL2_SPPT       "ppt_pl2_sppt"
> +#define ATTR_PPT_PL3_FPPT       "ppt_pl3_fppt"
> +#define ATTR_PPT_APU_SPPT       "ppt_apu_sppt"
> +#define ATTR_PPT_PLATFORM_SPPT  "ppt_platform_sppt"
> +#define ATTR_NV_DYNAMIC_BOOST   "nv_dynamic_boost"
> +#define ATTR_NV_TEMP_TARGET     "nv_temp_target"
> +#define ATTR_NV_BASE_TGP        "nv_base_tgp"
> +#define ATTR_NV_TGP             "nv_tgp"
> +
>   #define ASUS_POWER_CORE_MASK GENMASK(15, 8)
>   #define ASUS_PERF_CORE_MASK GENMASK(7, 0)
>   
> @@ -67,11 +79,26 @@ struct cpu_cores {
>   	u32 max_power_cores;
>   };
>   
> +struct rog_tunables {
> +	const struct power_limits *power_limits;
> +	u32 ppt_pl1_spl; // cpu
> +	u32 ppt_pl2_sppt; // cpu
> +	u32 ppt_pl3_fppt; // cpu
> +	u32 ppt_apu_sppt; // plat
> +	u32 ppt_platform_sppt; // plat
> +
> +	u32 nv_dynamic_boost;
> +	u32 nv_temp_target;
> +	u32 nv_tgp;
> +};
> +
>   static struct asus_armoury_priv {
>   	struct device *fw_attr_dev;
>   	struct kset *fw_attr_kset;
>   
>   	struct cpu_cores *cpu_cores;
> +	/* Index 0 for DC, 1 for AC */
> +	struct rog_tunables *rog_tunables[2];
>   	u32 mini_led_dev_id;
>   	u32 gpu_mux_dev_id;
>   	/*
> @@ -740,7 +767,34 @@ static ssize_t cores_efficiency_current_value_store(struct kobject *kobj,
>   ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency",
>   		    "Set the max available efficiency cores");
>   
> +/* Define helper to access the current power mode tunable values */
> +static inline struct rog_tunables *get_current_tunables(void)
> +{
> +	return asus_armoury
> +		.rog_tunables[power_supply_is_system_supplied() ? 1 : 0];
> +}
> +
>   /* Simple attribute creation */
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, ATTR_PPT_PL1_SPL, ASUS_WMI_DEVID_PPT_PL1_SPL,
> +		       "Set the CPU slow package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, ATTR_PPT_PL2_SPPT, ASUS_WMI_DEVID_PPT_PL2_SPPT,
> +		       "Set the CPU fast package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl3_fppt, ATTR_PPT_PL3_FPPT, ASUS_WMI_DEVID_PPT_FPPT,
> +		       "Set the CPU fastest package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_apu_sppt, ATTR_PPT_APU_SPPT, ASUS_WMI_DEVID_PPT_APU_SPPT,
> +		       "Set the APU package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_platform_sppt, ATTR_PPT_PLATFORM_SPPT, ASUS_WMI_DEVID_PPT_PLAT_SPPT,
> +		       "Set the platform package limit");
> +ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, ATTR_NV_DYNAMIC_BOOST, ASUS_WMI_DEVID_NV_DYN_BOOST,
> +		       "Set the Nvidia dynamic boost limit");
> +ATTR_GROUP_ROG_TUNABLE(nv_temp_target, ATTR_NV_TEMP_TARGET, ASUS_WMI_DEVID_NV_THERM_TARGET,
> +		       "Set the Nvidia max thermal limit");
> +ATTR_GROUP_ROG_TUNABLE(nv_tgp, "nv_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP,
> +		       "Set the additional TGP on top of the base TGP");
> +ATTR_GROUP_INT_VALUE_ONLY_RO(nv_base_tgp, ATTR_NV_BASE_TGP, ASUS_WMI_DEVID_DGPU_BASE_TGP,
> +			     "Read the base TGP value");
> +
> +
>   ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
>   		       "Show the current mode of charging");
>   
> @@ -767,6 +821,16 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>   	{ &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>   	{ &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>   
> +	{ &ppt_pl1_spl_attr_group, ASUS_WMI_DEVID_PPT_PL1_SPL },
> +	{ &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_PPT_PL2_SPPT },
> +	{ &ppt_pl3_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
> +	{ &ppt_apu_sppt_attr_group, ASUS_WMI_DEVID_PPT_APU_SPPT },
> +	{ &ppt_platform_sppt_attr_group, ASUS_WMI_DEVID_PPT_PLAT_SPPT },
> +	{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
> +	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
> +	{ &nv_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
> +	{ &nv_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
> +
>   	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>   	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
>   	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
> @@ -774,8 +838,75 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>   	{ &panel_hd_mode_attr_group, ASUS_WMI_DEVID_PANEL_HD },
>   };
>   
> +/**
> + * is_power_tunable_attr - Determines if an attribute is a power-related tunable
> + * @name: The name of the attribute to check
> + *
> + * This function checks if the given attribute name is related to power tuning.
> + *
> + * Return: true if the attribute is a power-related tunable, false otherwise
> + */
> +static bool is_power_tunable_attr(const char *name)
> +{
> +	static const char * const power_tunable_attrs[] = {
> +		ATTR_PPT_PL1_SPL,	ATTR_PPT_PL2_SPPT,
> +		ATTR_PPT_PL3_FPPT,	ATTR_PPT_APU_SPPT,
> +		ATTR_PPT_PLATFORM_SPPT, ATTR_NV_DYNAMIC_BOOST,
> +		ATTR_NV_TEMP_TARGET,	ATTR_NV_BASE_TGP,
> +		ATTR_NV_TGP
> +	};
> +
> +	for (int i = 0; i < ARRAY_SIZE(power_tunable_attrs); i++) {
> +		if (!strcmp(name, power_tunable_attrs[i]))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * has_valid_limit - Checks if a power-related attribute has a valid limit value
> + * @name: The name of the attribute to check
> + * @limits: Pointer to the power_limits structure containing limit values
> + *
> + * This function checks if a power-related attribute has a valid limit value.
> + * It returns false if limits is NULL or if the corresponding limit value is zero.
> + *
> + * Return: true if the attribute has a valid limit value, false otherwise
> + */
> +static bool has_valid_limit(const char *name, const struct power_limits *limits)
> +{
> +	u32 limit_value = 0;
> +
> +	if (!limits)
> +		return false;
> +
> +	if (!strcmp(name, ATTR_PPT_PL1_SPL))
> +		limit_value = limits->ppt_pl1_spl_max;
> +	else if (!strcmp(name, ATTR_PPT_PL2_SPPT))
> +		limit_value = limits->ppt_pl2_sppt_max;
> +	else if (!strcmp(name, ATTR_PPT_PL3_FPPT))
> +		limit_value = limits->ppt_pl3_fppt_max;
> +	else if (!strcmp(name, ATTR_PPT_APU_SPPT))
> +		limit_value = limits->ppt_apu_sppt_max;
> +	else if (!strcmp(name, ATTR_PPT_PLATFORM_SPPT))
> +		limit_value = limits->ppt_platform_sppt_max;
> +	else if (!strcmp(name, ATTR_NV_DYNAMIC_BOOST))
> +		limit_value = limits->nv_dynamic_boost_max;
> +	else if (!strcmp(name, ATTR_NV_TEMP_TARGET))
> +		limit_value = limits->nv_temp_target_max;
> +	else if (!strcmp(name, ATTR_NV_BASE_TGP) ||
> +		 !strcmp(name, ATTR_NV_TGP))
> +		limit_value = limits->nv_tgp_max;
> +
> +	return limit_value > 0;
> +}
> +
>   static int asus_fw_attr_add(void)
>   {
> +	const struct power_limits *limits;
> +	bool should_create;
> +	const char *name;
>   	int err, i;
>   
>   	asus_armoury.fw_attr_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
> @@ -832,12 +963,33 @@ static int asus_fw_attr_add(void)
>   		if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
>   			continue;
>   
> -		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> -					 armoury_attr_groups[i].attr_group);
> -		if (err) {
> -			pr_err("Failed to create sysfs-group for %s\n",
> -			       armoury_attr_groups[i].attr_group->name);
> -			goto err_remove_groups;
> +		/* Always create by default, unless PPT is not present */
> +		should_create = true;
> +		name = armoury_attr_groups[i].attr_group->name;
> +
> +		/* Check if this is a power-related tunable requiring limits */
> +		if (asus_armoury.rog_tunables[1] && asus_armoury.rog_tunables[1]->power_limits &&
> +			is_power_tunable_attr(name)) {
> +			limits = asus_armoury.rog_tunables[1]->power_limits;
> +			/* Check only AC, if DC is not present then AC won't be either */
> +			should_create = has_valid_limit(name, limits);
> +			if (!should_create) {
> +				pr_debug(
> +					"Missing max value on %s for tunable: %s\n",
> +					dmi_get_system_info(DMI_BOARD_NAME),
> +					name);
> +			}
> +		}
> +
> +		if (should_create) {
> +			err = sysfs_create_group(
> +				&asus_armoury.fw_attr_kset->kobj,
> +				armoury_attr_groups[i].attr_group);
> +			if (err) {
> +				pr_err("Failed to create sysfs-group for %s\n",
> +				       armoury_attr_groups[i].attr_group->name);
> +				goto err_remove_groups;
> +			}
>   		}
>   	}
>   
> @@ -866,6 +1018,135 @@ static int asus_fw_attr_add(void)
>   
>   /* Init / exit ****************************************************************/
>   
> +/* Set up the min/max and defaults for ROG tunables */
> +static void init_rog_tunables(void)
> +{
> +	const struct power_limits *ac_limits, *dc_limits;
> +	const struct power_data *power_data;
> +	const struct dmi_system_id *dmi_id;
> +	bool ac_initialized = false, dc_initialized = false;
> +
> +	/* Match the system against the power_limits table */
> +	dmi_id = dmi_first_match(power_limits);
> +	if (!dmi_id) {
> +		pr_warn("No matching power limits found for this system\n");
> +		return;
> +	}
> +
> +	/* Get the power data for this system */
> +	power_data = dmi_id->driver_data;
> +	if (!power_data) {
> +		pr_info("No power data available for this system\n");
> +		return;
> +	}
> +
> +	/* Initialize AC power tunables */
> +	ac_limits = power_data->ac_data;
> +	if (ac_limits) {
> +		asus_armoury.rog_tunables[1] =
> +			kzalloc(sizeof(struct rog_tunables), GFP_KERNEL);
> +		if (!asus_armoury.rog_tunables[1])
> +			goto err_nomem;
> +
> +		asus_armoury.rog_tunables[1]->power_limits = ac_limits;
> +
> +		/* Set initial AC values */
> +		asus_armoury.rog_tunables[1]->ppt_pl1_spl =
> +			ac_limits->ppt_pl1_spl_def ?
> +				ac_limits->ppt_pl1_spl_def :
> +				ac_limits->ppt_pl1_spl_max;
> +
> +		asus_armoury.rog_tunables[1]->ppt_pl2_sppt =
> +			ac_limits->ppt_pl2_sppt_def ?
> +				ac_limits->ppt_pl2_sppt_def :
> +				ac_limits->ppt_pl2_sppt_max;
> +
> +		asus_armoury.rog_tunables[1]->ppt_pl3_fppt =
> +			ac_limits->ppt_pl3_fppt_def ?
> +				ac_limits->ppt_pl3_fppt_def :
> +				ac_limits->ppt_pl3_fppt_max;
> +
> +		asus_armoury.rog_tunables[1]->ppt_apu_sppt =
> +			ac_limits->ppt_apu_sppt_def ?
> +				ac_limits->ppt_apu_sppt_def :
> +				ac_limits->ppt_apu_sppt_max;
> +
> +		asus_armoury.rog_tunables[1]->ppt_platform_sppt =
> +			ac_limits->ppt_platform_sppt_def ?
> +				ac_limits->ppt_platform_sppt_def :
> +				ac_limits->ppt_platform_sppt_max;
> +
> +		asus_armoury.rog_tunables[1]->nv_dynamic_boost =
> +			ac_limits->nv_dynamic_boost_max;
> +		asus_armoury.rog_tunables[1]->nv_temp_target =
> +			ac_limits->nv_temp_target_max;
> +		asus_armoury.rog_tunables[1]->nv_tgp = ac_limits->nv_tgp_max;
> +
> +		ac_initialized = true;
> +		pr_debug("AC power limits initialized for %s\n", dmi_id->matches[0].substr);
> +	}
> +
> +	/* Initialize DC power tunables */
> +	dc_limits = power_data->dc_data;
> +	if (dc_limits) {
> +		asus_armoury.rog_tunables[0] =
> +			kzalloc(sizeof(struct rog_tunables), GFP_KERNEL);
> +		if (!asus_armoury.rog_tunables[0]) {
> +			if (ac_initialized)
> +				kfree(asus_armoury.rog_tunables[1]);
> +			goto err_nomem;
> +		}
> +
> +		asus_armoury.rog_tunables[0]->power_limits = dc_limits;
> +
> +		/* Set initial DC values */
> +		asus_armoury.rog_tunables[0]->ppt_pl1_spl =
> +			dc_limits->ppt_pl1_spl_def ?
> +				dc_limits->ppt_pl1_spl_def :
> +				dc_limits->ppt_pl1_spl_max;
> +
> +		asus_armoury.rog_tunables[0]->ppt_pl2_sppt =
> +			dc_limits->ppt_pl2_sppt_def ?
> +				dc_limits->ppt_pl2_sppt_def :
> +				dc_limits->ppt_pl2_sppt_max;
> +
> +		asus_armoury.rog_tunables[0]->ppt_pl3_fppt =
> +			dc_limits->ppt_pl3_fppt_def ?
> +				dc_limits->ppt_pl3_fppt_def :
> +				dc_limits->ppt_pl3_fppt_max;
> +
> +		asus_armoury.rog_tunables[0]->ppt_apu_sppt =
> +			dc_limits->ppt_apu_sppt_def ?
> +				dc_limits->ppt_apu_sppt_def :
> +				dc_limits->ppt_apu_sppt_max;
> +
> +		asus_armoury.rog_tunables[0]->ppt_platform_sppt =
> +			dc_limits->ppt_platform_sppt_def ?
> +				dc_limits->ppt_platform_sppt_def :
> +				dc_limits->ppt_platform_sppt_max;
> +
> +		asus_armoury.rog_tunables[0]->nv_dynamic_boost =
> +			dc_limits->nv_dynamic_boost_max;
> +		asus_armoury.rog_tunables[0]->nv_temp_target =
> +			dc_limits->nv_temp_target_max;
> +		asus_armoury.rog_tunables[0]->nv_tgp = dc_limits->nv_tgp_max;
> +
> +		dc_initialized = true;
> +		pr_debug("DC power limits initialized for %s\n", dmi_id->matches[0].substr);
> +	}
> +
> +	if (!ac_initialized)
> +		pr_debug("No AC PPT limits defined\n");
> +
> +	if (!dc_initialized)
> +		pr_debug("No DC PPT limits defined\n");
> +
> +	return;
> +
> +err_nomem:
> +	pr_err("Failed to allocate memory for tunables\n");
> +}
> +
>   static int __init asus_fw_init(void)
>   {
>   	char *wmi_uid;
> @@ -895,6 +1176,9 @@ static int __init asus_fw_init(void)
>   		}
>   	}
>   
> +	init_rog_tunables();
> +
> +	/* Must always be last step to ensure data is available */
>   	return asus_fw_attr_add();
>   }
>   
> @@ -903,6 +1187,9 @@ static void __exit asus_fw_exit(void)
>   	sysfs_remove_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.attr);
>   	kset_unregister(asus_armoury.fw_attr_kset);
>   	device_destroy(&firmware_attributes_class, MKDEV(0, 0));
> +
> +	kfree(asus_armoury.rog_tunables[0]);
> +	kfree(asus_armoury.rog_tunables[1]);
>   }
>   
>   module_init(asus_fw_init);
> diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
> index 584a75df113d..438768ea14cc 100644
> --- a/drivers/platform/x86/asus-armoury.h
> +++ b/drivers/platform/x86/asus-armoury.h
> @@ -8,6 +8,7 @@
>   #ifndef _ASUS_ARMOURY_H_
>   #define _ASUS_ARMOURY_H_
>   
> +#include <linux/dmi.h>
>   #include <linux/types.h>
>   #include <linux/platform_device.h>
>   
> @@ -63,7 +64,6 @@
>   	static struct kobj_attribute attr_##_attrname##_##_prop =		\
>   		__ASUS_ATTR_RO(_attrname, _prop)
>   
> -
>   #define __ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _dispname)\
>   	WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);			\
>   	static struct kobj_attribute attr_##_attrname##_current_value =		\
> @@ -190,4 +190,1089 @@
>   		.name = _fsname, .attrs = _attrname##_attrs		\
>   	}
>   
> +#define ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname)	\
> +	WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);			\
> +	static struct kobj_attribute attr_##_attrname##_current_value =		\
> +		__ASUS_ATTR_RO(_attrname, current_value);			\
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
> +	static struct kobj_attribute attr_##_attrname##_type =			\
> +		__ASUS_ATTR_RO_AS(type, int_type_show);				\
> +	static struct attribute *_attrname##_attrs[] = {			\
> +		&attr_##_attrname##_current_value.attr,				\
> +		&attr_##_attrname##_display_name.attr,				\
> +		&attr_##_attrname##_type.attr, NULL				\
> +	};									\
> +	static const struct attribute_group _attrname##_attr_group = {		\
> +		.name = _fsname, .attrs = _attrname##_attrs			\
> +	}
> +
> +/*
> + * ROG PPT attributes need a little different in setup as they
> + * require rog_tunables members.
> + */
> +
> +#define __ROG_TUNABLE_SHOW(_prop, _attrname, _val)				\
> +	static ssize_t _attrname##_##_prop##_show(				\
> +		struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
> +	{									\
> +		struct rog_tunables *tunables = get_current_tunables();		\
> +										\
> +		if (!tunables || !tunables->power_limits)			\
> +			return -ENODEV;						\
> +										\
> +		return sysfs_emit(buf, "%d\n", tunables->power_limits->_val);	\
> +	}									\
> +	static struct kobj_attribute attr_##_attrname##_##_prop =		\
> +		__ASUS_ATTR_RO(_attrname, _prop)
> +
> +#define __ROG_TUNABLE_SHOW_DEFAULT(_attrname)					\
> +	static ssize_t _attrname##_default_value_show(				\
> +		struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
> +	{									\
> +		struct rog_tunables *tunables = get_current_tunables();		\
> +										\
> +		if (!tunables || !tunables->power_limits)			\
> +			return -ENODEV;						\
> +										\
> +		return sysfs_emit(						\
> +			buf, "%d\n",						\
> +			tunables->power_limits->_attrname##_def ?		\
> +				tunables->power_limits->_attrname##_def :	\
> +				tunables->power_limits->_attrname##_max);	\
> +	}									\
> +	static struct kobj_attribute attr_##_attrname##_default_value =		\
> +		__ASUS_ATTR_RO(_attrname, default_value)
> +
> +#define __ROG_TUNABLE_RW(_attr, _wmi)						\
> +	static ssize_t _attr##_current_value_store(				\
> +		struct kobject *kobj, struct kobj_attribute *attr,		\
> +		const char *buf, size_t count)					\
> +	{									\
> +		struct rog_tunables *tunables = get_current_tunables();		\
> +										\
> +		if (!tunables || !tunables->power_limits)			\
> +			return -ENODEV;						\
> +										\
> +		return attr_uint_store(kobj, attr, buf, count,			\
> +				       tunables->power_limits->_attr##_min,	\
> +				       tunables->power_limits->_attr##_max,	\
> +				       &tunables->_attr, _wmi);			\
> +	}									\
> +	static ssize_t _attr##_current_value_show(				\
> +		struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
> +	{									\
> +		struct rog_tunables *tunables = get_current_tunables();		\
> +										\
> +		if (!tunables)							\
> +			return -ENODEV;						\
> +										\
> +		return sysfs_emit(buf, "%u\n", tunables->_attr);		\
> +	}									\
> +	static struct kobj_attribute attr_##_attr##_current_value =		\
> +		__ASUS_ATTR_RW(_attr, current_value)
> +
> +#define ATTR_GROUP_ROG_TUNABLE(_attrname, _fsname, _wmi, _dispname)	\
> +	__ROG_TUNABLE_RW(_attrname, _wmi);				\
> +	__ROG_TUNABLE_SHOW_DEFAULT(_attrname);				\
> +	__ROG_TUNABLE_SHOW(min_value, _attrname, _attrname##_min);	\
> +	__ROG_TUNABLE_SHOW(max_value, _attrname, _attrname##_max);	\
> +	__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", 1);	\
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
> +	static struct kobj_attribute attr_##_attrname##_type =		\
> +		__ASUS_ATTR_RO_AS(type, int_type_show);			\
> +	static struct attribute *_attrname##_attrs[] = {		\
> +		&attr_##_attrname##_current_value.attr,			\
> +		&attr_##_attrname##_default_value.attr,			\
> +		&attr_##_attrname##_min_value.attr,			\
> +		&attr_##_attrname##_max_value.attr,			\
> +		&attr_##_attrname##_scalar_increment.attr,		\
> +		&attr_##_attrname##_display_name.attr,			\
> +		&attr_##_attrname##_type.attr,				\
> +		NULL							\
> +	};								\
> +	static const struct attribute_group _attrname##_attr_group = {	\
> +		.name = _fsname, .attrs = _attrname##_attrs		\
> +	}
> +
> +/* Default is always the maximum value unless *_def is specified */
> +struct power_limits {
> +	u8 ppt_pl1_spl_min;
> +	u8 ppt_pl1_spl_def;
> +	u8 ppt_pl1_spl_max;
> +	u8 ppt_pl2_sppt_min;
> +	u8 ppt_pl2_sppt_def;
> +	u8 ppt_pl2_sppt_max;
> +	u8 ppt_pl3_fppt_min;
> +	u8 ppt_pl3_fppt_def;
> +	u8 ppt_pl3_fppt_max;
> +	u8 ppt_apu_sppt_min;
> +	u8 ppt_apu_sppt_def;
> +	u8 ppt_apu_sppt_max;
> +	u8 ppt_platform_sppt_min;
> +	u8 ppt_platform_sppt_def;
> +	u8 ppt_platform_sppt_max;
> +	/* Nvidia GPU specific, default is always max */
> +	u8 nv_dynamic_boost_def; // unused. exists for macro
> +	u8 nv_dynamic_boost_min;
> +	u8 nv_dynamic_boost_max;
> +	u8 nv_temp_target_def; // unused. exists for macro
> +	u8 nv_temp_target_min;
> +	u8 nv_temp_target_max;
> +	u8 nv_tgp_def; // unused. exists for macro
> +	u8 nv_tgp_min;
> +	u8 nv_tgp_max;
> +};
> +
> +struct power_data {
> +		const struct power_limits *ac_data;
> +		const struct power_limits *dc_data;
> +		bool requires_fan_curve;
> +};
> +
> +/*
> + * For each avilable attribute there must be a min and a max.
> + * _def is not required and will be assumed to be default == max if missing.
> + */
> +static const struct dmi_system_id power_limits[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA401W"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 75,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 30,
> +				.ppt_pl2_sppt_min = 31,
> +				.ppt_pl2_sppt_max = 44,
> +				.ppt_pl3_fppt_min = 45,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA507N"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 45,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 54,
> +				.ppt_pl2_sppt_max = 65,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA507R"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80
> +			},
> +			.dc_data = NULL
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA507X"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 85,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 45,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 54,
> +				.ppt_pl2_sppt_max = 65,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA507Z"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 105,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 15,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 85,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 45,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 60,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA607P"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 30,
> +				.ppt_pl1_spl_def = 100,
> +				.ppt_pl1_spl_max = 135,
> +				.ppt_pl2_sppt_min = 30,
> +				.ppt_pl2_sppt_def = 115,
> +				.ppt_pl2_sppt_max = 135,
> +				.ppt_pl3_fppt_min = 30,
> +				.ppt_pl3_fppt_max = 135,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 115,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_def = 45,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_def = 60,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 25,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA617NS"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 15,
> +				.ppt_apu_sppt_max = 80,
> +				.ppt_platform_sppt_min = 30,
> +				.ppt_platform_sppt_max = 120
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 25,
> +				.ppt_apu_sppt_max = 35,
> +				.ppt_platform_sppt_min = 45,
> +				.ppt_platform_sppt_max = 100
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA617NT"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 15,
> +				.ppt_apu_sppt_max = 80,
> +				.ppt_platform_sppt_min = 30,
> +				.ppt_platform_sppt_max = 115
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 15,
> +				.ppt_apu_sppt_max = 45,
> +				.ppt_platform_sppt_min = 30,
> +				.ppt_platform_sppt_max = 50
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FA617XS"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 15,
> +				.ppt_apu_sppt_max = 80,
> +				.ppt_platform_sppt_min = 30,
> +				.ppt_platform_sppt_max = 120,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 25,
> +				.ppt_apu_sppt_max = 35,
> +				.ppt_platform_sppt_min = 45,
> +				.ppt_platform_sppt_max = 100,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "FX507Z"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 90,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 135,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 15,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 45,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 60,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GA401Q"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_max = 80,
> +			},
> +			.dc_data = NULL
> +		},
> +	},
> +	{
> +		.matches = {
> +			// This model is full AMD. No Nvidia dGPU.
> +			DMI_MATCH(DMI_BOARD_NAME, "GA402R"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 15,
> +				.ppt_apu_sppt_max = 80,
> +				.ppt_platform_sppt_min = 30,
> +				.ppt_platform_sppt_max = 115,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_apu_sppt_min = 25,
> +				.ppt_apu_sppt_def = 30,
> +				.ppt_apu_sppt_max = 45,
> +				.ppt_platform_sppt_min = 40,
> +				.ppt_platform_sppt_max = 60,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GA402X"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 35,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_def = 65,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 35,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GA403U"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 65,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 35,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GA503R"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 35,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 65,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 25,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 54,
> +				.ppt_pl2_sppt_max = 60,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GA605W"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 85,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 31,
> +				.ppt_pl2_sppt_max = 44,
> +				.ppt_pl3_fppt_min = 45,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GU603Z"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 60,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 135,
> +				/* Only allowed in AC mode */
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 40,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 40,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GU604V"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 65,
> +				.ppt_pl1_spl_max = 120,
> +				.ppt_pl2_sppt_min = 65,
> +				.ppt_pl2_sppt_max = 150,
> +				/* Only allowed in AC mode */
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 40,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 40,
> +				.ppt_pl2_sppt_max = 60,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GU605M"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 90,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 135,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 38,
> +				.ppt_pl2_sppt_max = 53,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GV301Q"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 45,
> +				.ppt_pl2_sppt_min = 65,
> +				.ppt_pl2_sppt_max = 80,
> +			},
> +			.dc_data = NULL
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GV301R"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 45,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 54,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 35,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GV601R"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 35,
> +				.ppt_pl1_spl_max = 90,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 54,
> +				.ppt_pl2_sppt_max = 100,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_def = 80,
> +				.ppt_pl3_fppt_max = 125,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 28,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 54,
> +				.ppt_pl2_sppt_def = 40,
> +				.ppt_pl2_sppt_max = 60,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_def = 80,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GV601V"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_def = 100,
> +				.ppt_pl1_spl_max = 110,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 135,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 40,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 40,
> +				.ppt_pl2_sppt_max = 60,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GX650P"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 110,
> +				.ppt_pl1_spl_max = 130,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 125,
> +				.ppt_pl2_sppt_max = 130,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_def = 125,
> +				.ppt_pl3_fppt_max = 135,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_def = 25,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_def = 35,
> +				.ppt_pl2_sppt_max = 65,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_def = 42,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G513I"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				/* Yes this laptop is very limited */
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_max = 80,
> +			},
> +			.dc_data = NULL,
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G513QM"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				/* Yes this laptop is very limited */
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 100,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_max = 190,
> +			},
> +			.dc_data = NULL,
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G513R"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 35,
> +				.ppt_pl1_spl_max = 90,
> +				.ppt_pl2_sppt_min = 54,
> +				.ppt_pl2_sppt_max = 100,
> +				.ppt_pl3_fppt_min = 54,
> +				.ppt_pl3_fppt_max = 125,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 50,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 50,
> +				.ppt_pl3_fppt_min = 28,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G614J"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 140,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 175,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 55,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 70,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G634J"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 140,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 175,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 55,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 70,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G733C"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 170,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 175,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 35,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G733P"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 30,
> +				.ppt_pl1_spl_def = 100,
> +				.ppt_pl1_spl_max = 130,
> +				.ppt_pl2_sppt_min = 65,
> +				.ppt_pl2_sppt_def = 125,
> +				.ppt_pl2_sppt_max = 130,
> +				.ppt_pl3_fppt_min = 65,
> +				.ppt_pl3_fppt_def = 125,
> +				.ppt_pl3_fppt_max = 130,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 65,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 65,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 75,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G814J"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 140,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 140,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 55,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 70,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "G834J"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 28,
> +				.ppt_pl1_spl_max = 140,
> +				.ppt_pl2_sppt_min = 28,
> +				.ppt_pl2_sppt_max = 175,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 25,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 55,
> +				.ppt_pl2_sppt_min = 25,
> +				.ppt_pl2_sppt_max = 70,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			},
> +			.requires_fan_curve = true,
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "H7606W"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 15,
> +				.ppt_pl1_spl_max = 80,
> +				.ppt_pl2_sppt_min = 35,
> +				.ppt_pl2_sppt_max = 80,
> +				.ppt_pl3_fppt_min = 35,
> +				.ppt_pl3_fppt_max = 80,
> +				.nv_dynamic_boost_min = 5,
> +				.nv_dynamic_boost_max = 20,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +				.nv_tgp_min = 55,
> +				.nv_tgp_max = 85,
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 25,
> +				.ppt_pl1_spl_max = 35,
> +				.ppt_pl2_sppt_min = 31,
> +				.ppt_pl2_sppt_max = 44,
> +				.ppt_pl3_fppt_min = 45,
> +				.ppt_pl3_fppt_max = 65,
> +				.nv_temp_target_min = 75,
> +				.nv_temp_target_max = 87,
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "RC71"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 7,
> +				.ppt_pl1_spl_max = 30,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_max = 43,
> +				.ppt_pl3_fppt_min = 15,
> +				.ppt_pl3_fppt_max = 53
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 7,
> +				.ppt_pl1_spl_def = 15,
> +				.ppt_pl1_spl_max = 25,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_def = 20,
> +				.ppt_pl2_sppt_max = 30,
> +				.ppt_pl3_fppt_min = 15,
> +				.ppt_pl3_fppt_def = 25,
> +				.ppt_pl3_fppt_max = 35
> +			}
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "RC72"),
> +		},
> +		.driver_data = &(struct power_data) {
> +			.ac_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 7,
> +				.ppt_pl1_spl_max = 30,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_max = 43,
> +				.ppt_pl3_fppt_min = 15,
> +				.ppt_pl3_fppt_max = 53
> +			},
> +			.dc_data = &(struct power_limits) {
> +				.ppt_pl1_spl_min = 7,
> +				.ppt_pl1_spl_def = 17,
> +				.ppt_pl1_spl_max = 25,
> +				.ppt_pl2_sppt_min = 15,
> +				.ppt_pl2_sppt_def = 24,
> +				.ppt_pl2_sppt_max = 30,
> +				.ppt_pl3_fppt_min = 15,
> +				.ppt_pl3_fppt_def = 30,
> +				.ppt_pl3_fppt_max = 35
> +			}
> +		},
> +	},
> +	{}
> +};
> +
>   #endif /* _ASUS_ARMOURY_H_ */
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 92fea0710ada..bf53592e2a2f 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -145,6 +145,9 @@
>   
>   #define ASUS_WMI_DEVID_APU_MEM		0x000600C1
>   
> +#define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
> +#define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
> +
>   /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>   #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
>   #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026



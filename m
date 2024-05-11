Return-Path: <linux-kernel+bounces-176598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD298C320E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4656B1F21339
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8385645D;
	Sat, 11 May 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1k6nZzhX"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42A1758B;
	Sat, 11 May 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715440410; cv=fail; b=kT4lWjF98oumfZDVnCh/B3DfUsjtbACBH/QA4cD0UORUJ+TLsuA5c8ucVJAwSP5dpaKqQjHBPN9o7rEMLBoMTAAUswfb9eORUIgXFs0KtmHPjl49VUzK/4YUiSC5CTqSPhiedG1tUCEaXWW80FfpPHxXvBjdQp/k0UGmwWzEV4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715440410; c=relaxed/simple;
	bh=Ztx+sovcez7HUAi0L0JMAd/0Zcj8OiCzinjm5gJrwkI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D+6zW/yWPIPar5AXeHam9+WfczKG4u2Ek51AjgFKMVxDdc+/K3TonVnNH6DfeqOCQkHAmSNGefx7aoSJ5cGaATx6kTbaXEEoOYzgHB6YSz5zNQgmRaUlbxJ5lOWY2hLhyjIHN8W8r9uY3jvWEH9ZQgipixko+yCzkbricZGVBeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1k6nZzhX; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsqKBEovG1rulv+OlwN7DQ2E8+bhqo3F/ZE/ZIOehat49w1Q1rafB9dPMDYDxyF3CZNSNY+HJRboSS9fCG/8VnSx/skEduI1DhfvsVW23cCLD95ie60W6HbIdnsIct6LR2++eFoN4rkTo32x+Eh4U8JnhyrLHoDfgu474IdfhPGeabMHU/15vMcmZDqVBz3HdPmbS5nl9tt0fG25TDKp1lUPs8YWJh/27Mc8ZgjCl+xGmLcDCtjR4/lu/p7URa7laxC4akxqTbGWRxcqW5K1Rql/wt5Fe3wxYkculVAEfr5xQsCIxwxxXWA2J+OQZ94/tzopJIIoJxx19Y983L0hgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOt3ZiUwIYw+83x216K7+ElJR0UP50XeqMkS3qXSswM=;
 b=Y1qaB18nCCw9OYWyc7E/CfHvOclRcqTIvb32ypmVWHGKdDNAoVUbrRNpQmZLUhoa8jBB+m2p5KXY6cu7KC6FUOYEFif1Rl2QDo9UQ68MBma4dIxsqG0na6BD6hGBZFMLQ1Zcj1fBQ3z1HLshwksa9GFBuCTJ5vkiqnIY9YuxV7okAErwDAizyBepEL0UV6+QfGPdB9zIxMAF7A0JPBAoGoWtVYOILlfy0ZESlvRjT3Wd1437iqPxXNeP7Bzo8kOL+25INbyRwGbT5Gm7Hk4tdNJipw42BzR2iV29LeRDZ1dYvS88Ji8CLtlS7Ag+usAklsNq9V3hYbFKmimDjk3bzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOt3ZiUwIYw+83x216K7+ElJR0UP50XeqMkS3qXSswM=;
 b=1k6nZzhXI5lqvjizD+5GKF9GDBYNKFLPr2gGgvpzKJKps71kF1R+tU5NWcdCO1E8LtPDS1qUmzIaazX0BOybn1UTZ3hFMFXCOpArGXD61gMEFFU6kvW4csEieUsoENKLQDc07vX9l2zi/QhMRwGML2ROsvlIYMgFo8xDGXaz1nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sat, 11 May
 2024 15:13:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 15:13:25 +0000
Message-ID: <5ac2d604-465f-4d33-9d3a-7cd8e4a41246@amd.com>
Date: Sat, 11 May 2024 10:13:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] platform/x86: dell-smbios: Add helper for checking
 supported commands
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: pali@kernel.org, W_Armin@gmx.de, srinivas.pandruvada@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, lkp@intel.com, hdegoede@redhat.com,
 Yijun.Shen@dell.com, Matthew Garrett <mjg59@srcf.ucam.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Randy Dunlap
 <rdunlap@infradead.org>, Vegard Nossum <vegard.nossum@oracle.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240511023726.7408-3-lsanche@lyndeno.ca>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20240511023726.7408-3-lsanche@lyndeno.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:610:b3::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d7ecc3-caf2-42a8-ec53-08dc71cce7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2NCVVFEYWMyMnpYeEVsQktqMWdaWWpPRFVXQVltZjNxekFzbDVGdmtNcmlR?=
 =?utf-8?B?M3ZoVmUvb2xyTk1mL0hZaUZ2TUxpbjVvamNmS0wrcnNDZXVDSDFPZTU2YWli?=
 =?utf-8?B?eVZWeDZsVEw4dzQ4RzY0NGxxcWJDSDI4TVVYK0d3YXZqbExnS0FmdmtpMjRS?=
 =?utf-8?B?Q1p3OStVd0pxdy9YdUVtQ1ZyYS9BT2NVWElxaFV6V0hVSTZENm11ems2SFlS?=
 =?utf-8?B?TXRkd25YODl3WDdBOFd3ZytMOHk0VUhEV3dYK2l3VExmMTNDSW1YbmVwSFlO?=
 =?utf-8?B?Z2tkbmxXVDJlc3p1V1FUM1pqSHRKcEVoeU5uQ1MvS3IwcjMrQ1ZvalNFNHRk?=
 =?utf-8?B?cHZLUDJzMmR5TTRjT1NtQW9EeW9QQzh0YWpwTmhaWlh3SEY5RkEyejNlb3dz?=
 =?utf-8?B?LzNjT1h3Qm5QZElrenJmd1FIbXB6RUJvZWxGWHdsd0tIb0NNNk9aZ0tXVmNy?=
 =?utf-8?B?aFpqQTJEZHRuSXFHL0hUYUFiUnZlMG8vVzVGbjlObTNTL2ZScHBMZjJmVlhx?=
 =?utf-8?B?OFhONlp4TWJCTkdGMWFxUWNCZXN4YXl0aDY0RGtYcjViWGJleG54aGNlUytP?=
 =?utf-8?B?bmJxRmw0dVZvQitJOFlyOCtXVUw4N3Q0SnE0cWlnb2lENHdycXQrenYvL3FD?=
 =?utf-8?B?d2NleWJoVEFDcjhYSXdqZGFxUHNOdWFraG9UZTNsTlB2M013WWZFNzdHUzgw?=
 =?utf-8?B?a1NHay9qclBnNVhEZVBhc3MwQkpoNVBDUlRvRlV4MkJBY3lLR1ZmK3p6WFdh?=
 =?utf-8?B?Nys4UUczdlU0SEpWWDFRS3BwR3lNVUkrQTFRN1FrbkFXYnBndlR3OC9vNkk2?=
 =?utf-8?B?MU9tbXNoQWUzNFI1SWltQVlCalkxVUFyMngrWU1EUFd2c3FTSWg0R2FRcDdk?=
 =?utf-8?B?dmNaek1FOUlsOUttcDBVYjhQaVhvTExKaWlUMDhzVEh4bWpsQm1qcmxJYXp5?=
 =?utf-8?B?RWVuVFowWU1EMlF3c0VNK2FGTW1tV09wS0ZHenhoeSs4dmtPZEhGd0J4bnRw?=
 =?utf-8?B?Rm9EQnVHazRKeGZ6Und4NEtKd28vak1vci9rK0E5UzBWMHZpVHMvdzJFU250?=
 =?utf-8?B?UFpvUU41QzNSYlBkTlVYdldpNHdleVlsR2tMcldmNHhZeURDM1FTUTUrQ1di?=
 =?utf-8?B?TmpBdmJ5ZzBBTVoybktFZXIyNU8yVDA0Vzh4UFJmUk1TazY3YjNlcTF6Vzl1?=
 =?utf-8?B?Y2tZNHpyeWl6dTI5TEhzOUdYRjN3RmZ1NklhMDl2R3JneVhYM3J3d0pJNzVB?=
 =?utf-8?B?QWhnNHdvdlZvRnhhbEdPQm5sWFFpcXQzS21LMTlSd2c4dTFXS3Y3MEhZUHgw?=
 =?utf-8?B?VGF5NVUxcUlJbmI1SzI0aHB1Ykg1MXJ3SHNsVmV0UXFCOTZlVHFjVnNsVEFS?=
 =?utf-8?B?WDIwOFZ2cFBBeXVKVWo2TWgvSWR6YWFIYzZRVkQ4MGZwS2FValZhZUtZZDBu?=
 =?utf-8?B?bDJGYmh4aHZXRzB3UEZ2MmRPSW1WS29mZ2kzSXFiNU1WUFBqY3orekMzTUx4?=
 =?utf-8?B?YkFYMk9WbVZ3QzhpbGdyR1o5MXdWbXVXTGdPNWtFeVNVMU1mZ0F3OTNtK05U?=
 =?utf-8?B?akl1UjRkamlWWVZGZlBpdVRQbjhjSE5PbG5ocVpWcGFzMCsrZFEwcE9JMmJr?=
 =?utf-8?B?cG1LdUxxS21jVmFGSDFyZ0NpV2h6eGl6OE9ydFRDd2FaUlNTa2VJOExFUi9v?=
 =?utf-8?B?QjFMTGIrMVB2RG9QdFJQeXRmckVmckE4Y1hJaDFGQ3ZUcFFicXJoay93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak9yN0tMSCtHcWg4Rk45SmNBZnhQcjIwbTVTT1FHWjNBUlBTY0ZGVHBQTDBy?=
 =?utf-8?B?US8xR3UzTkRCT091ZktpQko1ZjRhOXdKRkppeWYzR2krWXhzYzhwZnhHNlhG?=
 =?utf-8?B?cjhsQmNDYmlDWlQvRHBqanNjZ0dneWhTbnlQU1JpcVltcEo2ZWN6RjMvOTd3?=
 =?utf-8?B?d1o3UDNFaGZXeFoyMzNWVFVnWm0rQlNvd20ya1pUTnpGN3RZdUp2QTRnQXg3?=
 =?utf-8?B?akxNeXkwWFRnNUlteitQVEwyNmpkTWo4OFBkNDVRQktNRjh0c2ozcGNxaUF4?=
 =?utf-8?B?VndsVklSUUNTNW9aUWZJTWREbnJlVTBTUmEvMmlpZTJzRDlhZnRmbmFnUzBU?=
 =?utf-8?B?c29Lb2xZTENlNHk2bXhHWlpVY0xhMmtSM3ZGUTVDZTB6Zjh5aHppZng4Qm9S?=
 =?utf-8?B?VVd0a1VDWFYyTG8wZm1yQ0xSYmRSU01ZaWY1NGVQZ0pXdk1lWVU4c3czamow?=
 =?utf-8?B?Y1RtR2ZOR2hpQ0lZMDkzcFVMTENuMXVQT0R6NjQ1dE5nWU8vQVlOVHJ6OTRK?=
 =?utf-8?B?amFrVmVNaDBqT3FsdGtvVWZLNjV4dnNyWUROb21zQTNmZXU4ZG5aYUlOMyt0?=
 =?utf-8?B?QmpCSExPekxjOXdXMGtJcXVJd1lkWjRiNTlKSC9UdHZtRWMyYVQyOWFEQ3lC?=
 =?utf-8?B?RlNHN2ZxeFhxVVJNemQwWTA5NXdFcEtwdWNIUzVQT0E1VjNiN2dncGpTcHNw?=
 =?utf-8?B?TGpJb3F5enBhSVZrWVpZNFRJVmdzZzdnRXdSWDJjT3g3UlNQODF4Yk80RUcv?=
 =?utf-8?B?SmRyakdVam8yZTVzUm1WREtjN2ZoQThGSC9lbS9acU0vT254WlpNLzRkaGgy?=
 =?utf-8?B?cGJNZCtHOHl6RC9XQitzd1pjWGd2ZWZab3FhYmFENHgrYkM1YjFqRjRXTk8z?=
 =?utf-8?B?N1I4amcrbGtQeEljM0RkaTVjclZSYzNKdDdnQk96ZUxSeFhnbW52YVhzQVFE?=
 =?utf-8?B?NnpkNzdYL0hVMFpDdDJNR0FzTnlLK3ZOcFdaeTJrcTNEVDR6dzgzK1FJWiti?=
 =?utf-8?B?K2ZwVkt6Rm5UNGxBMFR2SktZUnRMZ2RIRFVEL1BoTTlCQ3A2dG8wL0Y5cWdP?=
 =?utf-8?B?ZkRSRTNBUWtLY0RZclhYbHlpS3JwOXl0ZGxHUWNVZEplVkJ3RHZsaC9oVUJD?=
 =?utf-8?B?bWR3anNOcXhoaFVldmdFVlE2azRvNGFxWXM5MWZnMlRacFJGTS9RM0RvRlZj?=
 =?utf-8?B?c1NxSGlnaWJ0cDRXK3U4R05nQXpUdDVNOGRVcm80UVBhNndSc3ZDZTg2UUtn?=
 =?utf-8?B?VmRtVENrTHgwVzNSR1dkOWpiT3V2QTlrR1FPcXRxSzlIdWVxY3ZUcGtkOVcv?=
 =?utf-8?B?dkdaT2RiZlc4UW1iT0FuYVhPRHFuLzlGcklRUll2K2JONVFTQ3QzWWRXNlE3?=
 =?utf-8?B?WWNuR01zeCtpT1JFOWgwTDcyaFFLQnp4NEhJUjZKTTJxZDI0VzBhL2RkNFFV?=
 =?utf-8?B?OHdhSi9YZVJMenQ3OHY1emxqRmZhY2EvSkZKSExtbnZpa3NIV1dhbFo4SXVM?=
 =?utf-8?B?UnU5NnZ5UEJjaVNzOFpTL3VhblVuMUxOOEFmMHExMCtqQUw4dXFRalRFQVhW?=
 =?utf-8?B?cTV5S0hTZGY1elZDaFpJUW9wY0FoNDVMeHl1VklHSThxa2lUdSt0SG5pZHlo?=
 =?utf-8?B?TXNGVXMzdTBMSTRFZ3VuYzNCNzQra09Pa0VJTDhNQkxnZk1VT3NxYjBqTWlN?=
 =?utf-8?B?dGp1VlFoQk5pNHhQdThGbUJnWFoyamNaMWljeitOQ29LclpkUFZHMEI0ekRN?=
 =?utf-8?B?VlZ4SmNFOTVDZUUxMGQzMk9kRnFWR2xwb0JUME5yb2hzSFVWREJLNGh5WUQv?=
 =?utf-8?B?dHoyWDhVVnpZZUx1WHF1eVk3cGUrTzZ6SkFJZVVSbGk3U0VjRWRyVVlqS3BK?=
 =?utf-8?B?bFNOODE2YlIrZjRWVGVLMlMwamliOVpNY0RpaXdzZURSSVFvOWE2a3k5eFhu?=
 =?utf-8?B?ZFNrRC95N3B6cDlISzBkVU1LTzR5TVBqYzdhREhDM0ZTU3NJSnBrUjZaM2pn?=
 =?utf-8?B?VGJVSXBTSzVPTDJpUzZ2L05TQjc5aEtDNWtNZW1Dd2c5Si9paWUyUk1UR3cy?=
 =?utf-8?B?QmVtRHJkaGE5cTU1eEdoNklEbU1OMm1ScTBIUjlUQ3JuSU44ckhLa0RlY09G?=
 =?utf-8?Q?hTBt8GJ8/KiUPJJXZM+nDKkmu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d7ecc3-caf2-42a8-ec53-08dc71cce7ec
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 15:13:25.9018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRBK1B7r2u9rierSdKqEgC3ihZefJCSxv2sFP8YvCXykXTC/mYLM8aGv29P3dMrwNDuB768EBznKajKbdjhz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706



On 5/10/2024 9:36 PM, Lyndon Sanche wrote:
> Add symbol to check if a specific class of smbios command is supported.
> 
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/dell/dell-smbios-base.c | 6 ++++++
>   drivers/platform/x86/dell/dell-smbios.h      | 1 +
>   2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> index e61bfaf8b5c4..6ae09d7f76fb 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -350,6 +350,12 @@ void dell_laptop_call_notifier(unsigned long action, void *data)
>   }
>   EXPORT_SYMBOL_GPL(dell_laptop_call_notifier);
>   
> +bool dell_laptop_check_supported_cmds(u16 class)
> +{
> +	return da_supported_commands & (1 << class);
> +}
> +EXPORT_SYMBOL_GPL(dell_laptop_check_supported_cmds);
> +
>   static void __init parse_da_table(const struct dmi_header *dm)
>   {
>   	/* Final token is a terminator, so we don't want to copy it */
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
> index eb341bf000c6..63116671eada 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -73,6 +73,7 @@ enum dell_laptop_notifier_actions {
>   int dell_laptop_register_notifier(struct notifier_block *nb);
>   int dell_laptop_unregister_notifier(struct notifier_block *nb);
>   void dell_laptop_call_notifier(unsigned long action, void *data);
> +bool dell_laptop_check_supported_cmds(u16 class);
>   
>   /* for the supported backends */
>   #ifdef CONFIG_DELL_SMBIOS_WMI


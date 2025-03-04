Return-Path: <linux-kernel+bounces-545169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BC0A4EB74
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459BB881924
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA5E2C1521;
	Tue,  4 Mar 2025 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iN2dI3iM"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67A202F8C;
	Tue,  4 Mar 2025 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108934; cv=fail; b=gCGTd2KlpA061hP9Tp2gUY6Xaq3U0wcntp3kzVBi9+EQe8H4JKxSXYp9EwW3x5YW38u/9tXaGURprM5DD3ElE/A7p+LWS4cZLnWHSjo5h4QML1OFq/n9F9sQHWXE4flz4Cq6Rob6bOStSSx0OXPdCWyzOiY1WuVuSKFu9btNkLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108934; c=relaxed/simple;
	bh=4hvXPzSnbD+Bz9CTq3hS0fJQeHyMOVwigAWmi/Ba2qo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hgF/NHqSDNu6d2ZIpUCwcSIk76SLBGe7Odgt+lzpkwY29v+Tv0SA83OdxTpSDtpBI3VD143xtGPhvJ/HKGYk0QP+hhEWW//3Hurr+j6WOWPQ7B9tLTYl0FHAngeuP63QBpAauDPCQ4RqHryksKB+IieB0pE+lnwMxXoDsV51zkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iN2dI3iM; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygXZpO0ClDABQ9x6ux1v04peiqHHvD1N8yZacV6+bMfbXxsfsuw8V74+mAEgEsRi6hkF9ZytREv60KlJCQGLqtZZeR/oGClLLKVz0ZNz8ZxQ4OHy54Mc8HKhD/P5hAu8zZBb/T064calQ6VZfTS8BqMinTEbU2Tk9Fc5J2CslPsdr2fbVhjMPCCQEx6bQ0kJK+yHfa26zavbn8C+4AXVJn6DEjGpRjG9DvLwLC9ynhTno3eKXbot1EWXxItaLG/BVMOhwMLRZHAOeZbWzqYBdGIIpQ561ZY4ZhBxWy1Mz+caeo0LYxdxKK947WBzXD5DPQKr6jXFHlKZxgOw39+ZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7s7XglUzE5AHA626ZHOr/D3C+uhWjkfBhSmZR5j28NM=;
 b=xjMLsv5ihjE+lvmD2UmUBwSW2iW6ZB+/0UnNjiXcNkfGgmXqnQaOZnKbVS6+k1ldIKmYh6FJQLu1dh2bFp4nfUTR0VxrPE1ICozV9p0QInYAgjWgMCbb2VssGrnPUxR1QmDwYbWuidQP5xTregEo0umidHzHG2X8xz7gAKZm7JYV/RGTYMi1k/z2iJK6JbXqUkzoefT2BZxScvH/lgtoWuadqDFwU2TRR6h5UzxXBiKRQabJoPP5hd6EIR9FGyHoCDUKEekeKN3JaVEJ7B1AeHQ1eWC6kzF4e9Z3obzX36UQp5UlXjHOTzYXbk6AqN6bdjJG5JKQoN9drf7pA7YyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s7XglUzE5AHA626ZHOr/D3C+uhWjkfBhSmZR5j28NM=;
 b=iN2dI3iMYx0JpJPflf2meaR/6yb4jijCjaJAJTJOpKFwvPd8WIWg6eo14rMfugX0pvFuNoTZNT51blvMsevdFXPyyagDa7wiQ99LGzEmH+qhn7vgokxKx32ZY9vgNtDNe1Dz3lDeuecaPRJ9ziBuXZOQzJ5stmpOxkdDbLCrOSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 17:22:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 17:22:09 +0000
Message-ID: <39360526-f56e-4fdc-b631-2381f10a58d2@amd.com>
Date: Tue, 4 Mar 2025 11:22:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86: dell-uart-backlight: Make
 dell_uart_bl_serdev_driver static
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250304160639.4295-1-ilpo.jarvinen@linux.intel.com>
 <20250304160639.4295-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250304160639.4295-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0027.namprd05.prod.outlook.com
 (2603:10b6:803:40::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: cc23d4dc-16b6-4b9c-5652-08dd5b4117f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTlZK0ZMVHRsZHZLcDlCeUl4TDJnRVVIMERLeTVOOFcvS3JaSnNVcjI2T3No?=
 =?utf-8?B?TkZFZDI5d0IyYUFwSUJkWDVMbzV1YlBjSmVXWjNGbFRqK3pFaW9wbkMzMmpr?=
 =?utf-8?B?WkU3WE1hVlNuc05BTDR3djlNL21abnNPenNUWFg4Njl5TVh5cys3cUdwWUFP?=
 =?utf-8?B?N0NPbU5ON0MwbDlCVDNvTGtBRHhJY01RWVpUUmdwclF3M3BENlQ5cFVlMzZo?=
 =?utf-8?B?VVBnVDlnUS9VRWNVdUpHTkJpcEl1Z0RJY0NVU0tlYURiOHh2OThnUDY2azdi?=
 =?utf-8?B?ekRNLzl0aGpWTW5rUzE2MFhKYUJNcWVyYWdxWnkybnFDdG1kT1NCamQxWjB2?=
 =?utf-8?B?Z0Z3bW5SNzhjZmFBK084MjJia3c0MWhCWXFGZ2lLYlBlazhaYzZJMFZaelVj?=
 =?utf-8?B?cjNudE5obExqdTZUWnVueWF1WlhGT1p2dUVWUmNXZ2NERi9Ta3RZWFNrSHFS?=
 =?utf-8?B?emhHR05kRUs3QU1sS1pMOUVIREw0NlBUem1ZV2ExZ1ArV0F0WmhQdTRGb25i?=
 =?utf-8?B?S25JaUJya01uL3M4SEpZYVdUZDJVMldFY21nRnpTUUZFNVAvY1NBUkJ4YWpk?=
 =?utf-8?B?emVMMitwVm1IcnlFUUdzN05Kbk5ZOXZwTE1WUkowazB6RFQyUlRDNG45Z0xC?=
 =?utf-8?B?SDVUYTIxblhSQXVCbGZZYmpLakJYL0dTYzFIclJ2V09MdUppaXRJV0tNNjJl?=
 =?utf-8?B?T1hYRnV3SGV0V3dOWTNHbURUR0I0T05CTTVWdnFlbmdYb2FYQ3hCZlNVamVk?=
 =?utf-8?B?d3VCVllUUkRVdkkyeVY0NXFlbnpCWTZHQ3M2Z0ZSQ1NqeFdjZW5KZXVMYU9O?=
 =?utf-8?B?ZHFHcnlnK1ZCMTJwSlBWVTdub1Y4amRxbEsycXU0VGordmtjbzQ1d1VhZnNC?=
 =?utf-8?B?TnUvcTd3NVIxQ2YyZTV3N0ptZXhNMTJndUtFeFZvaVdvbEhHdU1uREZwWEcr?=
 =?utf-8?B?YWRsWWhMblJYS3h4TE1ONUs4MElwNFJiWGxsSVRWQ29yWEJVZ1NHWTNkamls?=
 =?utf-8?B?Uk5LSEFkdEZQTDhmY3V4aWhBRkhPQlhpc3IvVm5SS3ZDTGN6MjgrQlV3ZW1B?=
 =?utf-8?B?QTJIZTkyZlBiWU1ST1FDVTZSMHlyaHl4SFVIa3k2NS90RVM4NSsrbStBc1JJ?=
 =?utf-8?B?NTdTMWc1dkhSd2tJMDBMU3ErcnR1OUU0WTk1aG0yMzhoTytQNU1QcXo3VzRN?=
 =?utf-8?B?M25FQ3RhNjV1YUp0QlVpUnh5NzNiZ2pweHZWMnFCcTNNelMrcnRiMng4QStt?=
 =?utf-8?B?Q1FXWlV0TzI4N2FyTmxnNXBibmZWeXdPSjAxRjZOa0ZxUjRCbHQzS2ZFTVpn?=
 =?utf-8?B?aU5nM3dVZW80VnRidFp6NHN2YTlHajhaVWxrVlE3c25kenBzZ3dBYjUzV1Ex?=
 =?utf-8?B?YmlUTXE5aXVMVWxNaWpvWDhtUDRQaUdDZW0vbGx2Y2k4RTl1bUZiYVp6UkNh?=
 =?utf-8?B?N1lQWXZ2SHJ2dlFWV00wNXVQRDhZSXE0UkNLdmsrcXZOU0VVcFZENXYrdFU3?=
 =?utf-8?B?Zjd5OXhuRFk5TlFHUEZUNnNDZFM3U0g4YXZJQjJDUHJpVTc1Mjg5a3FvWlFy?=
 =?utf-8?B?TFRLTmdpYVNnOGQwNUpiU3RNU1JLQ0pydm5sWVlydlRLMm5LWFlWdit0ZkNM?=
 =?utf-8?B?SkN1Z251RXdFQVE2bjE3a0xpbzhVc25XdFhPYnRJcXhHZmNkK2xWS0hQcEJw?=
 =?utf-8?B?YW8xNjRBeGNPNmM2OHBabGljc0x1OThWTTlLZ2dhYWZ1cVdXNHdqdTNSVTlU?=
 =?utf-8?B?c0gwTnh2YVV2OU1qYjB0dFY4WVhtaXNMWThHRnJjR1F5bWh3YlI4M05VZHR1?=
 =?utf-8?B?RU4rY3BYTDFSMFhSQytiSGhtWFpwaHh6bXB5eFVndFNwZ1kwTXNodWtneTcz?=
 =?utf-8?Q?hO6mX/onepidC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGtlemhJSzdPQUFNd3YyUmRzT0lmTkZTMmgrS2dFZ3pLSkdIWUFzTmpxRXhJ?=
 =?utf-8?B?UHlMWUNJUytERUhuZUtydWJ6alhFV0ZmMkFlRU1vS0RwOG9pd2hHQmJLcUJ0?=
 =?utf-8?B?V3dnSkRacDVCZHFIRTJZTGZ2b2VQYllGd3kvZGlCekMwMUsvUG4yQ2swZUFs?=
 =?utf-8?B?S3RseEdzZDJ2ekEwKzE2YlhxeWRjakxiVXo5TC9SYW1kOTc1ZFVVZFhEL04y?=
 =?utf-8?B?NWIwT1o0YTJsUm1wSXVDcUFEcHo1RWwyaGdlR3VyQ01RbnhnYlh2Wm1SbVd4?=
 =?utf-8?B?WVlOdVlmRjBoeERDZHR3TDcwR24ydVRVNXY1cVNyWHlxWjRpMzd5VG5HVW1y?=
 =?utf-8?B?bnlJbUNXa3dUL2FCaWpReEdGMmp3elVIYkVoR1Juak5lWG9SajFUVmhUcjFu?=
 =?utf-8?B?TFY4aTdZcjZHekJFZmM0M3krTS9MdWdEWEw3N3hOVGpCME1KVVhmRnhsV0kv?=
 =?utf-8?B?V1dQWUh1czV2RnNPTHRNMlhvK3V6OGczdnp3K1FBQi9XaTJzcE5pajF4ckFx?=
 =?utf-8?B?ZE03YmxMTlNMTFhyOVF4SzJiVEx5WldVSDcwOWx2bGFMVHZDaVcraVhwbVBY?=
 =?utf-8?B?eHhYTDZDRGlUa25NK0wxaVVJMTVwOEpRSmVrSWxqeFU0WUQzYXFINGprQlhH?=
 =?utf-8?B?enJDYktielJ3VVhob1duU3RCNzNicEdYd1RWZ3NZb0k4ZkpSZE4xY2NkVWZ4?=
 =?utf-8?B?ekQ1QlVybEt5azZGM09WRDNGU2dLOGRmVjh1cEFzalA4ZTBPVXVacU12azNH?=
 =?utf-8?B?Nnh1UHVWSndROVJrYkczRVBDcW15WjNTWDgvTnM4SDRSWmNuSDBJS3doVzQ5?=
 =?utf-8?B?ZkRHMzhRc0tNVytWcVNqdlU0N2RmR0tKSTR6cVIxSGlhY0JLTzFvQkZ1Y1Vk?=
 =?utf-8?B?UnFwalI4ZksvczBCQ04wMFc4QktINjdQcVU2VTN4YXI2RHJkaFJGWnliNlIw?=
 =?utf-8?B?UGRPVkNldlBYcVg2aHVUWGl2NTNwTDhXaXJiOWlUUHRrZWVNdkw3Z1ZmUk5k?=
 =?utf-8?B?RlRDL2NYbVBtSnpWTUU3clZkOGZocStVN0ZaUXhCM3FLMWZjdncvV3FlbUxX?=
 =?utf-8?B?VVlYbXEyV2FIQTh4ZXhlMWZ2aVU4NXREUWZnRUo4anJqNUxwWFZFZk1BYzBw?=
 =?utf-8?B?NmR5UmY1MytTREErTlBxZmloTHpwOTd1Z3pVcGsyUFo3ZFNmSjVDNmNadDNF?=
 =?utf-8?B?ZlFRVlFjc3B1Rm82K04veDJ5M0IzZlRRZXl5eW1VRGFyazh2bzJTaVBoMGpF?=
 =?utf-8?B?Y2VtclUzNVg2aEVrLzIzOW4vR2JEdjAyM1R6NmJ3Vzk5d2M2d20vWkNoZTZy?=
 =?utf-8?B?RTE0S2dLRmw1TktnWmNWekxnNjVwWVFGbUxFZGxjUHFpYVcrTnh5NzYxUzFl?=
 =?utf-8?B?S0hsOGJPeTRyWWZleUpKWHJQdnI3LzlMVHl4d2FwcUowOUFwOGRFWnQzMWFF?=
 =?utf-8?B?d1MxN0FIbk1zbTFja0pHWjJRQTQ1cW9RWVk4Z2RQU2JaSnBTMVYyV1Rxam5v?=
 =?utf-8?B?R3lLLzJKMTRtcVg0ZStQYnlSdWllT1Rpa04vM0Z1MDFDRTJoM3FyVVlyK0JJ?=
 =?utf-8?B?ak13cU9vUFRzR2FadDVhT3ZaTERtK2F4czBnSVRsbXBIOUU4cG5DSFdCQnZi?=
 =?utf-8?B?MCtQeFVMWE1zczFYNHUwYU1xM1pJMm55UytpRTBId0IrNGFaclZybXd5Qm5m?=
 =?utf-8?B?WVdwQVIxeEJPYzkwTnUrNDRVazVVTXNFd0YwRUQ1ckw1bFJxc2JlWVZJNWRk?=
 =?utf-8?B?b3lib2g2a0JoaWlDdUVMQVNLdE4zeXJodjdFbXpPQ0F0akZoSUw0UDlaY2ty?=
 =?utf-8?B?VDBDc2JCVm4vSFR4M05JY3dzSDlsRGF4ZXdiaktnU1ViczZZVFZjaVlFNUtZ?=
 =?utf-8?B?K2NYZHBPalR6UFZRdEtEVVkxMENnMjRNRlRtZHNYQ1BscC9ORzZYQ0ZHZTFM?=
 =?utf-8?B?NEZBenZTUjN1bDJTZys1WHdBa3lBaERKZFBDQVBBV0owanBIME8vMjFKWG1V?=
 =?utf-8?B?RVpmSy9rRyt3Q0xwd3Rva3NFLzB6RVBEMmRseUFUV1pBQlVUTE43OE0wdTNj?=
 =?utf-8?B?cVhOMEdrRm52Y0M0RlBaOVpORG9laXFPZ0NqcWxYZzEwWUt6eVBPYXZYQkZQ?=
 =?utf-8?Q?NpdjaLrvNrwKMd7aE+WpZs7P8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc23d4dc-16b6-4b9c-5652-08dd5b4117f6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:22:09.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8sHgkJt+moDzKtBUUoF+tvqGYcMZdpEjA6TQD13T6pq9zqxlfMhAc7HJle+Vu2cD4tKLsbZl4nsCF9P1DgdLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417

On 3/4/2025 10:06, Ilpo Järvinen wrote:
> Sparse reports:
> 
> dell-uart-backlight.c:328:29: warning: symbol
> 'dell_uart_bl_serdev_driver' was not declared. Should it be static?
> 
> Fix it by making the symbol static.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Fixes: 484bae9e4d6ac ("platform/x86: Add new Dell UART backlight driver")
Reviewed-by: Mario Limonciello <maroi.limonciello@amd.com>

> ---
>   drivers/platform/x86/dell/dell-uart-backlight.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
> index 50002ef13d5d..8f868f845350 100644
> --- a/drivers/platform/x86/dell/dell-uart-backlight.c
> +++ b/drivers/platform/x86/dell/dell-uart-backlight.c
> @@ -325,7 +325,7 @@ static int dell_uart_bl_serdev_probe(struct serdev_device *serdev)
>   	return PTR_ERR_OR_ZERO(dell_bl->bl);
>   }
>   
> -struct serdev_device_driver dell_uart_bl_serdev_driver = {
> +static struct serdev_device_driver dell_uart_bl_serdev_driver = {
>   	.probe = dell_uart_bl_serdev_probe,
>   	.driver = {
>   		.name = KBUILD_MODNAME,



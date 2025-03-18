Return-Path: <linux-kernel+bounces-566578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0EDA679FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA561893ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FFC211481;
	Tue, 18 Mar 2025 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UY3873Rd"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74120E6F9;
	Tue, 18 Mar 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316284; cv=fail; b=aGO3M9hhmkPpdv77+CTgW4c/pa0FQpRCAHQhtVjPiAvz550QfOjpwioenAzSjIphaZqHHM2HOAPzOMCSmBOVtM8l1MeptSvmxzKNtGrEL2Xt9NDdVYMKLjvVaxgCUT9A3cGOV+QjjxkHLG+Hc64HMreDPNz0c5H67Wb76rGZJRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316284; c=relaxed/simple;
	bh=1XJTQ2hDYkU7RjsHKFLKfjcKTUJZgi4JSxCmHjlqU6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lF84hX9pj3ne9nw2ci4ctuCKjzaMQB/TSGY9ueV4iNckqEgmozFXrXbsuETrIosJmfLRx+0YYK1ELYQw6AJofAdOU7bn/RGNwxEQfUhc+M7pps0cqSv4Zj2ulZc6UjzrbbQB1HrNHi0SqloQdIt2VdHm1vaNfzZGshZ+7Cuu9UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UY3873Rd; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKuTYIFEfQDNuGOYC1NOJBidv2XJWuyCCD94raPqFrbbtivpl1Xsv7QHb/1E2zkz7TuscuWUHnZNPm85pMZbNNzs15Vb91ctQfTpaiiOkxBTolIp7JRrG8ks2tqQVVKAsQ3kfLB1Qs1zWUIqWb7Ew4P47huJVCpDq0+R/6ZsMBTUd2nx4zYAN35vsNmpxFBcJvAX50ZcTD6cfuD10kOIaYMFL07/Lclfc8fpjZzdUMtwn/cZmUmYyXZA/6ypkakifBa7KCkHS0magWoWAqxShRkUQSBnTQi8YKFZxn2pgyRVssKPBv4Ro8h2PaI0V+JaBs4g/lDzfMm0cQPGtRRIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWnB8YehQZx0jFJQDeZjsh0+5xxyYyTF70NSzr9Sg3g=;
 b=V99yvO3YAkXTUcclzA+xgQ5cc0lWEKZxUUyc+aR5ntIn74JNr3VJzmUtlpvxRs/iALuQI363Il21nUmszQGsweuptRg2JUYgbIwXDuzvQnm0piKEnB/7RUi7B2VUlfbAaBBgq6egf58T2Ir3IA1Pn6n5NR3gbGlu0CCkxTNS3Gtw3RlxCYKvkO9Y2lXPkGPIkdZwmOlH7Up9S9mFYgeF3prPdnxZfRPgiRUB6gD+zL23+3oeM8cqzSuwKYEK531bkRr5Y0fLAWGzx+yAR4246Ubzfb2EH2jHAP8QhTybfe+KXvYgG1rec/uyGev6vpZlC8g7BhzrZIaU1aS36Qjm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWnB8YehQZx0jFJQDeZjsh0+5xxyYyTF70NSzr9Sg3g=;
 b=UY3873RdUShT2lS7CJAL9qi87LAtiYZq/v2DgVcWSSXYrawUBT2RRT5oQwDIkL1NLGqlp9RNVkusXnhuTIJ4by635fG4bgq1X+8tF979a/AI2vFNsBvJ5KUI6t1n5EbxcGg524TNx7DJ8DdznXYfI1CbjzW3OzoWVua7LavYkB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) by
 DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 16:44:36 +0000
Received: from DS7PR12MB6285.namprd12.prod.outlook.com
 ([fe80::6acf:b37d:a152:409e]) by DS7PR12MB6285.namprd12.prod.outlook.com
 ([fe80::6acf:b37d:a152:409e%3]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 16:44:36 +0000
Message-ID: <cfdbfe7e-5cf4-47a7-af5f-b220cad6f7e4@amd.com>
Date: Tue, 18 Mar 2025 22:14:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Supreeth Venkatesh <supreeth.venkatesh@amd.com>
References: <20250318041224.1693323-1-Rajaganesh.Rathinasabapathi@amd.com>
 <20250318041224.1693323-2-Rajaganesh.Rathinasabapathi@amd.com>
 <20250318-imaginary-peccary-of-argument-ab6b39@krzk-bin>
Content-Language: en-US
From: Rajaganesh Rathinasabapathi <rrathina@amd.com>
In-Reply-To: <20250318-imaginary-peccary-of-argument-ab6b39@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6285:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: c10b3414-eb0e-4431-2644-08dd663c2ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmlHV0c5NHhJV1BydTJxWmdpM1lyTFRIR1kvb0tVSlZta0NOM0luMmRMdGZT?=
 =?utf-8?B?Qm1ySUhVMHpDMHVYd2tXci9WdEh5NDg5c0ZIb0tJUzM3eTVGM2ViaTBKejdw?=
 =?utf-8?B?VUhDOHl6dkxkb245NVVlSHE0UkVuTUFpTW9UVU5sYUhKZm9kOVdmZGVSY0tk?=
 =?utf-8?B?RDNwVTRLdENzaWNpY2orcjBoQTB3b2t1ZDFVRjkxRTJkOVBIM0lZRkdjQlov?=
 =?utf-8?B?VE5TZFdsOElDdktBMVJVT1p5Qlc5WkhNd0E1QWNJdHVpeFNGcFUzK0s1eVlP?=
 =?utf-8?B?TktpUnJwYjI1bit4Nlh1NGtvQTJKSVVSZklOTi9nK2VoWE5RMjAzN01DclBm?=
 =?utf-8?B?ZkRmTTh0YUpob2xNa21vSitmUmtqSnBIWmlYTUFVbzZqTWRrQllEQ2lva3lB?=
 =?utf-8?B?bUxrMVdRbmtNU05EamxjSXhLNGtLSnVOc0lmczk5Z0I0dTd1b0lWNVhxL2ZO?=
 =?utf-8?B?UFQ1RXRodi9JNDVwNUIxM09xOFk0Y2hHbW4wR3V6d2VEdE42cWxtSktaWWIy?=
 =?utf-8?B?ejVSU3R6TWZBZ1I2N2FBcThtTGdhMERFR2dHODNaNmdUV08xWjhlOVVpQU1l?=
 =?utf-8?B?ditSNjJTdWJiYUVNZGlmb3pjNGlER2tzbnVJdkNHdVljcll2TDUzVDJESU52?=
 =?utf-8?B?YXVjR09weWh3cUQ0ME9hT1dXS00wR2orOWhwc1d5R3dyanhvMjlyaGtManN4?=
 =?utf-8?B?MWtQVFRhVHhPYmZ0eTJZUjR5VGwvZzEvbGNMSjdPMlRBQTRFWWx6MU5ib1hq?=
 =?utf-8?B?b1dNQytmUnVSdS9wWFVxTVJYWWtSNXEvUHR4MDdyRUpDVlhFRGYyMHl5Szcx?=
 =?utf-8?B?YnNKanJOMGd5dWJ1Y2kvekJwSjI3aVlIbWNlNnlncnBHQjVwRTJiU2l6ZE9C?=
 =?utf-8?B?bDBCUGdBa0pwSzlmSUNIMm9PcTZtWG0rdjZGY0FsenpGT0NCdE54aWFiWHlS?=
 =?utf-8?B?aHFyekJMMEU4dGFOeldlNmZHcXFzUmJNL1p3RlBjZjdYUTU2YlAvOU5HbU9m?=
 =?utf-8?B?c1hMT1RIbVdvTDZnbno1WVA3VncybHlPdVJmbUIycCs5TEdZNzRjWVc5QlI4?=
 =?utf-8?B?QnFTcmtveFZZaVVCMkVobTdlY09zZ1J2NDEwQzZmOTBHQStRMTdmcjZFbnJm?=
 =?utf-8?B?QkJYcEFucDFkTkdQYVM5V3U0SStUY3lvNnplRGFhWXNpS1VRTldPazl0bFdV?=
 =?utf-8?B?TUU3bVA1YVRCV205MWhVNjI4TkRLUlVsYmZQWitvK1NCek1GZnBIR2JEdy9k?=
 =?utf-8?B?TWlNNUtzVDJyTisydkU3aW1TSStiTFppdzRheEhvZmhRSk9BenV2MFREUThT?=
 =?utf-8?B?MnMzS0orUFo3UUcvU0xTZWl0U1phK2tBQURlZXFZaGZPbVJtSGZpUFVYc0tn?=
 =?utf-8?B?NlRoL25aOXJGTEExd0Nnc09qWEx3TWtuWldwb3o1dXRwVjBUMXc5NExtdktG?=
 =?utf-8?B?UEZHWnFoS0dNNFAraEtqOXVXbEI0UXZoc3FobWErRXA0Ymg4d0srVVJvdzJV?=
 =?utf-8?B?Wkl4UXpYR295eWFFWHpsL05CMExmdXNSYlcyZU5UM1NjMWxaMnR1ZjFiN05i?=
 =?utf-8?B?UGFyRUNvUmlvV05WZ0lhVzJVREFqdkh0L2NCZ3MyWHRNQ3pOckRmNGJlWFRH?=
 =?utf-8?B?ejVMZVJPTlRsaHBrY0J1Q01ZQnhSdmdSUE1CYlB2N0JWVlJsd1E2bmlTK0Va?=
 =?utf-8?B?L3hEM3BzU1hSQlBCVjVMMkhscU5mOTVyTS9HaS9MV3JwaGhaZUZheUVPSnZx?=
 =?utf-8?B?VlBwV01rYThsZDl3VmVkaU92SlZYY1hObldmeHJEVkJBVk8wTk5Zb2N3RmtG?=
 =?utf-8?B?ankySTBzSGlTZnM4Q1lKeE9va2ZiVmE1Qm9pVXVaQWFOQmcxN1FiVERBK0t2?=
 =?utf-8?Q?htjKuobnJOvxu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6285.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0o1NkZWWTFkTkFtdkVUSFM0OWtYQVRvaW1WRXJCV3F6bExHOGE5MjYySmZC?=
 =?utf-8?B?K1BJblQwN0xnM1BHZGF2Ui9vOXFvODNNV1pqemVxTlhjTFk5VVBlSXBQRjJj?=
 =?utf-8?B?c2ZGRXVqc05rbjU0aGMrVHdEcmk0cCtXNzB4c3dSd1F2cTl1d1FLL0tuOStP?=
 =?utf-8?B?ZXh5aThQVEJHRXZoOVM4MW5xcUM0cTB2c3czR2t6YmRnWVZCQUxrbTJWWEpx?=
 =?utf-8?B?OEtiTzRydUVuTk9lcHpzakxQeVM0Z0lBSkxJQSt1amlQZHllL3U0azBaRG9X?=
 =?utf-8?B?dmJFUENLOVFqaTJ2NHJqVDJxeGhSUVR2S21xQ1RIZTBoRGExcy9MWkZ1UHdu?=
 =?utf-8?B?NlB2b3hBVFltZDhjNFAzTTMxQXduSStQNmErdk02bkMwejJ0c0pCNGFSYTZD?=
 =?utf-8?B?dUc1U3VHUHNHbGNhVi8yR0VON0cyQVBUS2RLc00wR0NKZVV3WDA2SUVGTkRt?=
 =?utf-8?B?Q1NGUlBLanZDcU9KdmdMZnVyc21CRWRlKzRocUpBLzdiUnVIOWc4bTVJN21k?=
 =?utf-8?B?YVkwODJTb0ZNM1hPYi84R01qOUVRMi8rYStkNS9JVUJndnNPSGhnQXFTN0JN?=
 =?utf-8?B?YmNtMFJsOC9wb09zVVgwdzJxd1NLV1VmU0luc3RZWnQzOUdGTjBSMEhyUmNN?=
 =?utf-8?B?OE9maEc3QnVmVlJvTThHRGtEQzJvdXpFcU9EY2d0MTNlK0NpWHBJcDFBWVc1?=
 =?utf-8?B?cm9FWi9MNmYvbk9rWTBlZCtqUTEzemtkd3o1bFAxbmpWNk52Y2xsTGRRdlZi?=
 =?utf-8?B?a2o4dlNxQ1NVd25WQWpCV2FiN2xUQmtWelRVQmRUZm96KzVzVWZLQWJMczVw?=
 =?utf-8?B?QnJVYkFscXV0dlB0cC9WbzVYd3l2eGhHbjM5dDI4VUFHNi9GbDVCMmpjb1dX?=
 =?utf-8?B?ZW1WdWxHRnMvSW5uSk5MZ1hMWkYwditUYkxXazdrZmdVMUFyVlUrVVNqeXRp?=
 =?utf-8?B?eWxyYlczMVM0VTlXSStwM2tHRUNzcmR2dGRpNTFDUlVTdXZmOXFkaHJHdHFS?=
 =?utf-8?B?b1haeGdIa3F3aUdLQkU2NFNld3RXZStZVVN6TXAvVXZkRFRzcWVGaG9MM2p0?=
 =?utf-8?B?VWsycHFQRVpoVGtNL29vUm5SWHpvYUZYQUN3emFiS2xUZ29KTUZnMktyRksz?=
 =?utf-8?B?VnRIK2o3dWRtTnZRZnIwNUgyMFYwVkJ1Vm9Ya0JsTFY4eTlpQWV5WUpYVFJp?=
 =?utf-8?B?bmxaWGpCUlhYN1F5NTZsbFMrdGp4WGRXa2xMKzlvVEFjNXNFOFJnNlFXNzNO?=
 =?utf-8?B?RlAyZGpjdEg0ZExyZnF4VXl3ZXIvMDVHU01SUi9sOGpYbjBjOFNlRENlbU9N?=
 =?utf-8?B?T1JJUDJldVJtU25aZXNxbENvM3p4WXF1TUlWcjBsVGJLcDNlSjVLdzJtL1RS?=
 =?utf-8?B?eTIrUTd1TlNXbS9kc0o2MkkrWFZ2SFUvaVN6MTdneXh2ZlFYR2Rna2RncGJT?=
 =?utf-8?B?STJLQVpRd29yazZOVHNUbmxBMXY3UUx4T3JsUG9YMklaRnZhcGVrS2NOZ2Jh?=
 =?utf-8?B?dGNGTElWbWV2bllyajR1SG5uNW1TeTN2QTBWL1N4Z0t2b1poTzltTm1sUmY5?=
 =?utf-8?B?VXFnVjhnT2x3aDM0UUpJWVdJSTArT24zcTVUUEdyT2FOczlyMEw4Uk1UZU94?=
 =?utf-8?B?MVRtalpReURIWFppMy9yUzZIYjhVWW5QdHJFb1NsWE5xYy9taVJzd3c2YjQ4?=
 =?utf-8?B?UlppdEN1L0syUjl4Y2pRNDduOFZ4NEtYa1BkL0lmUVcrc25IV2lTRENKQjFZ?=
 =?utf-8?B?WTRqYjd1T1pMYUxJcHplN2MvZVpranowSGMyaW05dzd2WWUyaHFGbkoyVTd4?=
 =?utf-8?B?REtYWFlzaWhTdDkzTTBFQnRXV2pST3pxb015N2dESG9WMlRGaGtDak11YWRu?=
 =?utf-8?B?OGkreDlyRnBYMkNEWm1LRmpDejhNZkxXeTcvM2dCRktjSFBIOUVmeFlNNTVK?=
 =?utf-8?B?ZjZCU01yN2tTOW1HL2J4cEc2SUNZcGFFWkdnR3FXM2J6ZVN4VEN6NEFsbXln?=
 =?utf-8?B?RnRzVUQzZGZ3MlpTNTRpNTJGdGQ3SGNPTW10YUdFUkc1aDArdE4vcHZzUTk0?=
 =?utf-8?B?eU91Q2pZRkc2dGZkbEd5SVlUM3V1aDI1R0xLVzBwWG9xUmNrNDdhYmY5dzZQ?=
 =?utf-8?Q?iDsWeSmC1ydnFaDjxDfDEsol9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10b3414-eb0e-4431-2644-08dd663c2ae6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6285.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 16:44:36.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HqU2nl2MGmpB3vZNUJP45rTbLpphwF9nx07BzoDbxFPT0Smj82RdddH3lk+PtJsFy6rDDswSooQXTLdf4i9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616

On 3/18/25 14:15, Krzysztof Kozlowski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, Mar 17, 2025 at 11:12:24PM -0500, Rajaganesh Rathinasabapathi wrote:
>> +/ {
>> +     model = "AMD Onyx BMC";
>> +     compatible = "amd,onyx-bmc", "aspeed,ast2600";
>> +
>> +     aliases {
>> +             serial0 = &uart1;
>> +             serial4 = &uart5;
>> +     };
>> +
>> +     chosen {
>> +             stdout-path = serial4:115200n8;
>> +     };
>> +
>> +     memory@80000000 {
>> +             device_type = "memory";
>> +             reg = <0x80000000 0x80000000>;
>> +     };
>> +
>> +};
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
> 
> Thank you.
> </form letter>
> 
> Best regards,
> Krzysztof
> 

There were two comments. One was to remove bootargs, this is addressed in v3.
Another comment was to add compatibles for amd,onyx-bmc, it part of earlier commit (patch v3 1/2).

Thanks,
Raja


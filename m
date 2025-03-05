Return-Path: <linux-kernel+bounces-547167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDF8A503B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07960188D866
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176A12505B4;
	Wed,  5 Mar 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iJZHudY1"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1DC1465AD;
	Wed,  5 Mar 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189365; cv=fail; b=J5cIlbJ6+dMW9aG7k1gVxmF3dQd+UjD6Qy1MkjREipRoZbuRMtKHpdx9P63QWwgbEyoTbI/3wOSy5fUFXjB6yKwC27NRE8zJOWhDe43qtz7ju5/5mpp0VvmA+IBxq4bsEjFDNfOrhsts5oiMU4lCT6tCkB1yRHJIqlH6Watm6RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189365; c=relaxed/simple;
	bh=Hzl9MlbiyTfoifeqOpCj+Tfg28IX/KwpdqfF426i+Eg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xlx25y5pFis20oAt0xBYSNh7Snn3R5/cgmXg2INRqKElKy2DIUh4+/CaC0A+es0UeL45YTuqcPwwKY+UeVvfxd/rCI/9TbOK3oA1r7RB9YezpRtgsaJ2DTQlvJOV82AppYqJ3tCkxeJT0BynqFCUHG96Hp0g622IEY0HyXW+7uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iJZHudY1; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kr195OcSOALFgRH6ksaWr6gyX5Snmohv51dOQZMBeM2fop3Jx8TF6jK7lq9RsXXUe0dYGUs/SOmFvWsLXOIxXLb8OM3yAVYRwBuzweNrs8QGgqnS8X1xwQzMhN4n9cWVSrLqH4vMLzhqdZgnURtPSGGT1y+jh7YFVopGZiR9/62dGvrmmta4aNyjszkpIOoorva5EfAPkaCT7zsnzpv+jCd62qFczehjMYpnVG5/vLxiBEBcuvrg7wlTlhreWKxwEyEenGVeJ2TjDlQ4Km+M8kAZSa2MPFtmdPSJF0HxWdIugYjJ5xf+FWfieystg+R8tbfSc6XQ71smObeODz/EQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXIj+JvqkeadKdaT9xKCqViRfT70IVylhVoRxUCCCGo=;
 b=lvnh5bRySbKwIVtx9NcLof5QBYNIvJyej2CBbmqAJz3rr85hEo03hrc7XIluFqmUJLVK3Iw+J8303ytjZDCAg5rW/8UnR/gievc0FQpn+kpOds+ICrmhGzYyjNKtDcGPkHdi6cnDp30/sJD9w9o/6B4MhtMnZUcWGRA3HCzawTdlJ01D5Y88qzGOsGNgx7LXVox3tq8ym05X43TEXT0HrGi6NKghfEVTP2y4s43SEA0yinZ0J+auY1XW/IQDHmNQK9r7xLS/pTdaA50doPjx2MuIjXxrH7hMZRR4nAdrTaQXfFO62Px5GlcPLQRY1Dm6bsk8TnbhIfB/iTVwZCPLDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXIj+JvqkeadKdaT9xKCqViRfT70IVylhVoRxUCCCGo=;
 b=iJZHudY1rzDwPpGr/H0ezpj56AdLIV+l6dSmyLyLi+Ikb2tpcGfgKOnjLwL/3ACX7PgquF7vmgGNebIIuVwUhmcg2wzB7SiSzLxcW60z5IJm4IDx6YFx2N4j263JenD4YvkHW/aQEjGuOLzrXC2Ra5zZj+W3PRxecoeo8B86C1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 15:42:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 15:42:39 +0000
Message-ID: <5909d7b0-8cb2-4aa9-b717-9b85a1b2a96e@amd.com>
Date: Wed, 5 Mar 2025 09:42:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: amd: Add ISP platform info
To: Hans de Goede <hdegoede@redhat.com>, "Nirujogi, Pratap"
 <pnirujog@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 benjamin.chan@amd.com, bin.du@amd.com, king.li@amd.com,
 gjorgji.rosikopulos@amd.com, dominic.antony@amd.com
References: <20250228170238.3484860-1-pratap.nirujogi@amd.com>
 <cd25d131-bead-4a38-98dc-1011c2843286@redhat.com>
 <3d57b624-7753-4a4d-9051-0a55cbdff1ec@amd.com>
 <9b8c9eb7-c8d5-4c12-9ce5-c4b4df3b4223@redhat.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <9b8c9eb7-c8d5-4c12-9ce5-c4b4df3b4223@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0123.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: aceae501-b2ab-480b-3c8e-08dd5bfc5c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE5ldmRIaTZKL2J5TmQzZnEwV1JjMzlrV0JsSWpSR2dQaEVSaGdvQWJRQkNS?=
 =?utf-8?B?SlowNThPRFMxdGt5dG02Q3JVd0hva1NNZHFTVzhZVTlFcHpoY29ud2FiaG5n?=
 =?utf-8?B?MHF4d0FGQ056bm5sRGhmbmN2S3RiaThYckJpdm81cXVDUU9URUNzUWp5VjRv?=
 =?utf-8?B?RXdBR3h0UHkxMFNsRGlRQjBUTGtXcndFb0tFeUltQ0d6d0xqZ3B0Y3RpS21D?=
 =?utf-8?B?WW1OdE5yUXhaN1k1Y2lnbEE1MVl4enZFRGxOQWcwbUxyNTAxdWxNZmQrVFJt?=
 =?utf-8?B?Q2E3eTVNOG5xNXVqczJMT2kvRDd0a1V5TzJxK1VKUjZsenE5WkR2UWxZalZJ?=
 =?utf-8?B?T3phR2RWdllObXN5dDViZElFOTdUcm13TlE3UGxpQStzQjRpVHdMQVIxQ3lC?=
 =?utf-8?B?ZUFDNG03SytGOXlyR1JFU2lsU0xBbC9ocFdXYUNWN1pVdDBrQWd2YU1xdkc3?=
 =?utf-8?B?U1pKa25ZMXFZUzJ4ZllHRGFoajlQWkFwRzltMUgzYUhDcm1WMWNzWVpaVUM0?=
 =?utf-8?B?d3ROakRpN3o4dWJ6dzJZeUJmV01UVTBoaFlOaVZ2V3g0aWtnRWlkUlhZRFk5?=
 =?utf-8?B?MDlOUEp6VWg3OCtXaXNLNDJkTTZkSVRkc1JQRWg2cEJyWW9PWVJUeTZjM1c3?=
 =?utf-8?B?SEV6T2ErblVKc1pEOTJPZGhmTkpmVjJMYnVsbzViQXdOZTZjUWg1bTBBWloy?=
 =?utf-8?B?UEMvNzM3aU80NjFOcGY4V05OMTdZdENBMWQrNGVkYUpWc1VEUW9TQVhxYVRS?=
 =?utf-8?B?bE9tdG9raEEwSm50d1RtRW93UTFua0k5dC95N0N1NTFXMFk2Z3llNnN2TmxL?=
 =?utf-8?B?TVVENG01dDdkS0ptNXlpOHNqKy9rRGVXSVhPMGV1MDRqQWNFRFl4ZjBRc3lG?=
 =?utf-8?B?NUszRjhRREV6Tm9ZMU1sVkJZd3JvMTRkUHB3bWVWTnQ3WTlFZ01XY0hYajJI?=
 =?utf-8?B?N2xoUWNJMG5ORU03bHplUFpFWmtGOFN5YTZpZm1FNHdzU2l0MXU0bko3aTgy?=
 =?utf-8?B?Z0RxR0Jub1JiL21EazA1MklEYmVQSHpBQmZ1TEtuMk4rejZobUo0VzY5ZG9X?=
 =?utf-8?B?c1lEbGdiRFVidms4aTRvZ1dGY1NsUWttZjh0eldXQmVqTnoxekU5dXU2YWR5?=
 =?utf-8?B?SWNmQXhGQmNHblY4VHlSM1kyczVWYUdMdTVVTnVvc0FVUlVIMDhKS1FBNTRZ?=
 =?utf-8?B?S3JzKytZRnk3cUk0dXV2WVc1RFBkOFhFdzM5NTFFQ0J3RVNySVlwU2prK3d2?=
 =?utf-8?B?dlBKN0lQeUxSYlFib2FUcldNYXNwb05WblovZFlVcGVFYUFqOFNxa215ZHk3?=
 =?utf-8?B?VC9pNHBiQXBPTnNxYWxVUHlPRlB6ZWswWjVBd3l4L0I5a2lTUUFsZDRBdUlq?=
 =?utf-8?B?K1B3amxBakxFdDdwWG41TSt5TEl5L055bWE1WmMwaThvVkFGcjhsdTFxUFcr?=
 =?utf-8?B?QW4xUDBSMHV2Ylp6TWk0d0tJS3lNVEswUmdidTZpZXNJRUFsaUR6SEN4djhV?=
 =?utf-8?B?MnRGRzEzSVpUZWRRY2VPUUtYMzN0RXNXSUZyVmN1Zi9sd3VmeTlZRSthbFpU?=
 =?utf-8?B?WVk1b1cvUytwZllwSzc4MWk4QTNjMVpQTURmaXBzUG16KzVEa0thanh0dE5q?=
 =?utf-8?B?S1hPZ3hQVllldHEyVWRnS1czQzBPeVlXS3gvWVZPOVo1bGtHaGlKNzQ5b2dp?=
 =?utf-8?B?dU56RjJJVkwyZXd0Z1JtZ0g0cUlEODRhL2Y0TGplMExLMWY1Z2gyVTJMem9i?=
 =?utf-8?B?ZHdKekg5SXdieXVpWE14RElhcUkySmJ0OE5MOVNFZktJWFd1dHJQdkZBbkI0?=
 =?utf-8?B?L24zRTJ6bzFLM3UvTXNIZXlEY1BMdS91S1JDZXM2M0NjS21qRCtsdGdES2xt?=
 =?utf-8?Q?85CqydqU7XDzg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlRpY0puNkJMYTNBRkxVQm1nV01wNzNpSHRpT2tlU2dxM2pGTStZQ3hIMUMr?=
 =?utf-8?B?ZkEwbUhwMUlKOFJYWFBDZHBoQ25YbDVkMUZOUDQwU1hkUXpzYXJqU3A2d1dS?=
 =?utf-8?B?K0E5bE1GSy9vN3Q1V0RvS3JtRTkzbmxqK0pOMktkSzdLOVA1VmhxWERRcE5M?=
 =?utf-8?B?akxhTjUzNGxHODJpdk4rdHlLc1N3TFhMQUlOekhxUWROLzFxNTIrdmg5eEVs?=
 =?utf-8?B?VE9Udm0zN3J2YStnMVRINy94RVlsWkowd3p1MnVFZmVieGxrbHEyWEFNd0xt?=
 =?utf-8?B?VUxKK2twWXRRTVc5RzhNb1N0OEk0dXFyQm1mOWJtMUJJTWpGUWdsaTZabm1k?=
 =?utf-8?B?aVZpNVhPamIzN0RjVGtDQ2ZuenhGbVJmc0Y1WGlKVVpSRGZvbEpsS0x4WkRv?=
 =?utf-8?B?eFpxVzhZVUFIRlcxQWJMZC9rQVFSRHFTdSs3TmhxODg1SmRTeDNJODJmUGRo?=
 =?utf-8?B?K3NweTFCUGhYNEhEZUtCZmZkbWZjUXh2YllTbUhQU01CMC91QzlkSnJrdkZT?=
 =?utf-8?B?bzM4Wk5tQkY1QStrekgxRG5KdHc4d0NiWFZPQkozWDBuOEVONkl0VTRIUzFP?=
 =?utf-8?B?Vy96dWh1cG4rVnQwUHhSdzdXalFuZDFZNjdUaGtlRGtENDZIdlZwZDQyN0Zv?=
 =?utf-8?B?R0xGMytXTXdRWGJEK3JqNjFnWDUrb2J4MHN5MmlMT09GenM1andaV0Q0UFY1?=
 =?utf-8?B?UmpUWTRQMkM2ZFE1SlY4RlZ6U2EybUlJLzlpVlpjOHBJankxL20zR3IvS0o1?=
 =?utf-8?B?YTQzeDk5N25GWlJIVHl2SFlIYnJlNU9oUGdnRGJraVkxdUpnMVh2WUZyVHAz?=
 =?utf-8?B?emViY0tMZDhMOXNBNEMxY2c1OTNqM0FTY2dabUhhL2FvK2VybjNYOUtxeG1z?=
 =?utf-8?B?aGRMN013T3crS09IZG5XbVFyc2VTelZITWlTUUlUOHRsSHVxN1NhVlpSajdO?=
 =?utf-8?B?U2tndDZ1NU9aaktpYTYxTlh5eVlyVG9PeWplcGRiWFY1RGFCeFQrRTBlN29J?=
 =?utf-8?B?L1BTMUpGVUdFSUJyVkFiQkFBVTIwRkVOVGo2VXROUmJCNndHczh5bGloZlRh?=
 =?utf-8?B?TGhld3JHYk1mME9nVFRuRkxTVERSSlJzd21Tdlh5cytqT0YvZjAvalBCeUl6?=
 =?utf-8?B?TjMwSlpxME9SVkN5RVE5TUpkYXBicnIrdXpIWlAyaG9aempUbFZ2N2RHanU0?=
 =?utf-8?B?clBHeE10cXVlK1ZxZVd5Z1JibzZ6QURJV1lyQXNhdWRpeTA0b1FEanBwWHNn?=
 =?utf-8?B?T1FzUWxKaFJ6cUY2UlZHc3JHUThGRnpPNFNlcmZYQkE0ODNFR3FDM1h4b2ZO?=
 =?utf-8?B?SmMrNEVFVFhQTTJqTk40d0pISnlGSFdtTkp5QnJlVkNwaEhzbHJhaU1YRnUx?=
 =?utf-8?B?YW1Wd3ErRHhuNFo5SkpVd2tiZ3JEZlM0Q1NLNE51UVFTZEViTmxvamMyUm96?=
 =?utf-8?B?aGhERkpUWGhKSXpHSUNGRlpLWEM0N2lLRWEzTWk1dUNqaHdmRUw5NTNIaDFL?=
 =?utf-8?B?MHVjcE02d3hab21TWXU1VEVyL2dPb29xc1dUT3BwZzZGYlJuUkZ1TnB2dXNq?=
 =?utf-8?B?a3VOa1R5MFFhNk92djZjamJUcm5Vak5BNDliemhzYVVCOU10emNKeWEyVVpI?=
 =?utf-8?B?MSt0Myt2TjFqM1NFMnYzNmJJbjQxYnVhOUpyQWRPTGhPbzZodHRZOHpoU3Ir?=
 =?utf-8?B?aVkzUlo0Z2xuMDF2KzhPRHpidXdzSWExc09HUVVGSmtoMjVsaFNMQXpGbjh3?=
 =?utf-8?B?OCtUMVpkamttRHlLMkNJSThyc3BmQ3kxMXUwdGZyQk9aWnpwNVJ5bWZtMVBv?=
 =?utf-8?B?NVVTcHk2cUJpNnpqV3NSOFprYUJzKy9leThKd3g5WGl1Y0ZtRXY0NXZ2N1pT?=
 =?utf-8?B?V25FZDdPdnVGUGs3L0g5SEdTUHE0M25Xc0hZREZCS3o0dWZCWnAwcnF1M3BF?=
 =?utf-8?B?VGpEajhXSExjS3RoenFvb280YlIrQVV3eFhqb3ZYVFFJSWl0amUrL3NSZHBS?=
 =?utf-8?B?dWRjY3RIWGppZ2tFU040enRJUUNPQkk0UmlzUU4yTmdmdnpVOTBjL2dwMVJh?=
 =?utf-8?B?QXhxWFRVaWw4d0UwelhkWDRPRE1xZDdQZCtiZUhDVkpQdmFQYzRaMFpSL1VI?=
 =?utf-8?Q?mRG0GZQDEGiy4SPHCIuFDI2/l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aceae501-b2ab-480b-3c8e-08dd5bfc5c25
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 15:42:39.4270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: os/z/CMhklaz6lRNLENGmZc2PZE4Il352XecWgt0GN20bmO9jab2xWn5fEUFWZh4Sf8z8aWbH7AmmdDsgcLd1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875

On 3/5/2025 09:26, Hans de Goede wrote:
> Hi Pratap,
> 
> On 4-Mar-25 12:14 AM, Nirujogi, Pratap wrote:
>> Hi Hans,
>>
>> Thanks for your review. Please see the inline comments and let us know your insights.
>>
>> Thanks,
>> Pratap
>>
>>
>> On 3/3/2025 8:41 AM, Hans de Goede wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> Hi Pratap,
>>>
>>> Thank you for your patch.
>>>
>>> On 28-Feb-25 18:02, Pratap Nirujogi wrote:
>>>> Add ov05c i2c boardinfo and GPIO pin info for AMD ISP platform.
>>>>
>>>> Details of the resources added:
>>>>
>>>> - Added i2c bus number for AMD ISP platform is 99.
>>>> - Added GPIO 85 to allow ISP driver to enable and disable ISP access.
>>>> - Added GPIO 0 to allow sensor driver to enable and disable sensor module.
>>>>
>>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>>> ---
>>>>    drivers/platform/x86/amd/Kconfig   | 11 +++++
>>>>    drivers/platform/x86/amd/Makefile  |  1 +
>>>>    drivers/platform/x86/amd/amd_isp.c | 72 ++++++++++++++++++++++++++++++
>>>>    3 files changed, 84 insertions(+)
>>>>    create mode 100644 drivers/platform/x86/amd/amd_isp.c
>>>>
>>>> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
>>>> index c3e086ea64fc..4b373edd750d 100644
>>>> --- a/drivers/platform/x86/amd/Kconfig
>>>> +++ b/drivers/platform/x86/amd/Kconfig
>>>> @@ -32,3 +32,14 @@ config AMD_WBRF
>>>>
>>>>           This mechanism will only be activated on platforms that advertise a
>>>>           need for it.
>>>> +
>>>> +config AMD_ISP_PLATFORM
>>>> +     bool "AMD platform with ISP4 that supports Camera sensor device"
>>>> +     depends on I2C && X86_64 && AMD_ISP4
>>>> +     help
>>>> +       For AMD platform that support Image signal processor generation 4, it
>>>> +       is necessary to add platform specific camera sensor module board info
>>>> +       which includes the sensor driver device id and the i2c address.
>>>> +
>>>> +       If you have a AMD platform that support ISP4 and with a sensor
>>>> +       connected to it, say Y here
>>>> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
>>>> index 56f62fc9c97b..0d89e2d4f7e6 100644
>>>> --- a/drivers/platform/x86/amd/Makefile
>>>> +++ b/drivers/platform/x86/amd/Makefile
>>>> @@ -10,3 +10,4 @@ obj-$(CONFIG_AMD_PMC)               += pmc/
>>>>    obj-$(CONFIG_AMD_HSMP)               += hsmp/
>>>>    obj-$(CONFIG_AMD_PMF)                += pmf/
>>>>    obj-$(CONFIG_AMD_WBRF)               += wbrf.o
>>>> +obj-$(CONFIG_AMD_ISP_PLATFORM)       += amd_isp.o
>>>> diff --git a/drivers/platform/x86/amd/amd_isp.c b/drivers/platform/x86/amd/amd_isp.c
>>>> new file mode 100644
>>>> index 000000000000..751f209e9509
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/amd/amd_isp.c
>>>> @@ -0,0 +1,72 @@
>>>> +/* SPDX-License-Identifier: MIT */
>>>> +/*
>>>> + * Copyright 2025 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>>> + * copy of this software and associated documentation files (the "Software"),
>>>> + * to deal in the Software without restriction, including without limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>>> + * Software is furnished to do so, subject to the following conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + */
>>>> +
>>>> +#include <linux/init.h>
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/gpio/machine.h>
>>>> +
>>>> +#define AMDISP_I2C_BUS               99
>>>
>>> I'm not a fan of using static i2c-bus numbers for this. static bus numbers are
>>> something of the past and we typically do not use these on x86 anymore.
>>>
>>> Using this static number + i2c_register_board_info() also requires this code
>>> to be builtin rather then modular which is also undesirable.
>>>
>>> For a more dynamic way of manually adding i2c-devices see:
>>>
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/dell/dell-lis3lv02d.c
>>>
>>> But a better question here is why instantiate the sensor i2c device
>>> manually at all.
>>>
>>> ACPI has a standardized way to describe I2C-clients which tyically
>>> is used for all I2C devices on ACPI platforms like I2C touchscreens /
>>> touchpads / audio-codecs / accelerometers / etc.
>>> I don't see why the camera sensor on AMD platforms is so special that
>>> it could not be described in ACPI using an ACPI child-device of the
>>> i2c-controller with a ACPI resource (_CRS entry) of the I2cSerialBusV2()
>>> type.
>>>
>>> Likewise the sensor enable GPIO should also be described in the ACPI
>>> table as a Gpio type resource in the same _CRS table.
>>>
>>
>> We have to take this approach because ISP is a child to GFX PCI device in AMD HW architectures, and since it is not an independent device, its device specific configuration (gpio pin ids, i2c-bus number etc.) is not registered in ACPI.
> 
> The ISP still could and really should be an ACPI child device of
> the GFX PCI device in this case with its own _CRS for for example
> the enable ISP GPIO.
> 
>>> Can you run acpidump -o acpidump.txt on a laptop with this camera
>>> sensor and send me the acpidupm.txt offlist ? Please run this
>>> on a production hardware laptop model using production firmware.
>>>
>>
>> Please refer the attached acpidump.txt
> 
> Thanks.
> 
> So looking at this there are ACPI devices for the sensors, which
> unfortunately lack a _CRS with an I2CSerialBusV2 resource pointing
> to the ISP childdevice as bus-controller. So that i2c-client
> instantiating would be instant.
> 
> +Cc Mario
> 
> Mario any chance that for the next (or the next-next) generation of
> AMD devices we can get the ACPI tables fixed to properly describe
> the sensors as having an I2cSerialBusV2 resource, just like how e.g.
> I2C touchpads / touchscreens have this ?  I suspect this will benefit
> Windows too. Likewise any enable GPIOs for the sensor really also
> should be proper ACPi Gpio resources in the ACPI device describing
> the sensor.

Due to the architecture of how the ISP is accessed "through" the GPU, 
I'm not sure it's viable and furthermore if it actually changes anything 
for Windows.  But the ISP team and BIOS team can certainly discuss it 
for future designs.

> 
> Ok, back to the current generation devices. So there is an ACPI
> device for the sensor there. This should lead to a:
> /dev/bus/platform/devices/OMNI5C10:00 device getting created
> (please check this).
> 
> So this driver for adding the sensor GPIO lookup + creating
> the i2c_client should be rewritten to be a platform_driver
> binding to that device and it should be a module rather then
> being builtin using module_platform_driver():
> 
> - Binding using a struct acpi_device_id table to match the ACPI HID of
>    OMNI5C10 + using MODULE_DEVICE_TABLE(acpi, table_name) for auto module
>    loading.
>    The driver_data of the acpi_device_id should point to i2c_board_info to
>    use for that HID to future proof the driver for adding support for other
>    sensor models
> 
> - Loading as module means this can be loaded after the i2c adapter driver,
>    so instead of registering board-info it should use the mechanism used
>    in drivers/platform/x86/dell/dell-lis3lv02d.c combined with a unique
>    adapter name, then the module load ordering does not matter and it is
>    also unnecessary to have a magic fixed i2c bus-number of 99
> 
> - probe() should copy the const i2c_board_info info from
>    acpi_device_id.driver_data and then set the fwnode so that the sensor
>    driver can e.g. get to the _PLD info to determine sensor location
>    (e.g. front vs back)
> 
> - The GPIO sensor lookup for the ISP enable should be registered by
>    the ISP driver itself. Also this seems to be something which might be
>    board specific so maybe this needs DMI matching?
> 
> I'm looking forward to see a new version implementing the above approach
> which would be a big improvement IMHO.
> 
> Regards,
> 
> Hans
> 
> 



Return-Path: <linux-kernel+bounces-413834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5079D1F50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 05:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE7DB24072
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4424614D70F;
	Tue, 19 Nov 2024 04:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tNi1h478"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA42148857;
	Tue, 19 Nov 2024 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990970; cv=fail; b=gwr0e5iymoXvmvNS+r1Tv9oVufmoxeTPguCTaXNsTM+AQRkyyZAsel/qWEfd+6P+iWWtSk+Y/xHKNcOyLxGaGdqnNCLGvclwbC3uNzRF7oYt90KCtSuVYU0JgFVGOMSSb6x/9r4taCS4vlsgH4rxDczMSSAXOK87HskWetL6XOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990970; c=relaxed/simple;
	bh=vzInalRPznA90X0prXMV+rfF6SnnIzXoaKYgSmZd+Ac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uO2S+L2U3otDKzqkelLe2WB4hVDqgLRaDEP2ouWj4DK5O1gDxBSsfroRFqIwJBMLibye2V40P8/v59ZRQvPLM3jz0XLPJFNNxZrfJ0zVL6SOANidYtp+UNpcrV77O/sXN68N9n4pvE0BvS5GVq0/6Thcc4EF63qqlBTzAxpohqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tNi1h478; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTQH4MIeJMWXydaQZhLje5aT6/TwSGXlCi9iUtaIp6hXza2ZK0gl+v3JNfX7+eQ95q8jPa/AkXJaiA/0u/HG2/NtNhSIb1Zlb/OfG8oVhmhtdJ9875vVyk1vSfJvZsqbCaMME12QjoK+O+HclxhXPmGM1AyX+jtsVrJQB+KCHDCrLhtM4W6X/fKULfIE8tz8AB2caFGgHNoCMWLofW8UENh3+U4M/XtRf7MTILLbTQsCb+RwbuIli7A9YcIC0tgavs/QHWGV+9WwazzjPCtdx++QsmUHNZhoZkDYR20cYsZqB9h1LY1sctPLRZwz4MqSKtcZ1t3ao+9UX5A4yTFFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKTSmg4GGB+mPhpFsD+/qF+B3Ixjuw3Wz8NeDPeuzTA=;
 b=QNqrJ987NzsrLwtYl23XglLGtnpvAnboR5iULmfWvGkouIZLJzIgB5hwBlnv9ygfQUmZ1ABpgPTltgOtELloNJkIJrYV9ltwQfKnaz7buN1OAVccI1bH5zXfZkpzgKP0I1KKQUq2watK1RPFKE7ZIhZD//npwjKME4SJ4nssIYyO+vhPsv2uOmumb3+wZ1SiRpbGpCKO7Qwe6nBxqfjbIWYwNo5oUHDfYFsYW/Ic4XWs8cSngjtRLwYfRRkHqDIz2lqJqB/AtesmT+qFNfp2gDDBs/5UtysBOMXqkqkJwi7tD9qktq0PnKqlAwjbNSnAhzMzIRZYeESKYUOyl7mLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKTSmg4GGB+mPhpFsD+/qF+B3Ixjuw3Wz8NeDPeuzTA=;
 b=tNi1h478R71zHkvVZ+iqLGQIkFdTcijdlit4YijseU/MV8IheQs7i1DdlhpYgb4OQ4FlG3NpNSEVvI53YDFMwK8dZT0+WmWqq13P0W4cJJHB2D19Of0UsZN9Ccaafbh/rkzDPanFv/yzZilLnpczlHPnD3Z1m8vP2u2QFRfi3+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Tue, 19 Nov
 2024 04:36:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 04:36:04 +0000
Message-ID: <66c669f5-ea49-40dd-846f-c5ecbc75380d@amd.com>
Date: Mon, 18 Nov 2024 22:36:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] alienware-wmi: Simplify platform device creation
To: Kurt Borja <kuurtb@gmail.com>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, w_armin@gmx.de
References: <20241119043429.25538-1-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241119043429.25538-1-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcf0497-7e76-4398-c2f0-08dd0853ad76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlhXQnQrd1dWLzlxWXB6NmRPUXFaOHRGdGp1MWZUVFM0Vmx1TUNpTVdUdUVk?=
 =?utf-8?B?SU9MVHN2d1RjdFkrckRBY1dBdFdoK3oxckVCRkxRTkJIM3c0RjhUV2dMOEpI?=
 =?utf-8?B?M0Y0OTU4RFVKT2pPRjY0eHFFZHRndWd5NHV6MGs0TkNPenpnV3JIOGlUU0Vr?=
 =?utf-8?B?eHpkOVNtTDNqZEgwRUNoaTlFaGJIT2hHWGpmTC8vMklHRzF1bTcrZ3pOa20y?=
 =?utf-8?B?TFRiQmtXS2RzWmtGNW9TRGRLYVAvK1VmNTQzNko4SGZXUk85RzBISERGamRn?=
 =?utf-8?B?bENLek8wZk5KcWFrd2owckFsdjArQ01pK3hUNjE4QUZDR21lTStPWEVSSXgw?=
 =?utf-8?B?dk00M2Ezb09iQTBoQmxyV2ZiWmhlYzQyNElmYU5VKzBGZmczSFk4U0xiVVZt?=
 =?utf-8?B?UERHQmRkNi80WnFkQkZtaXp4YVB3MHk2U2xCbk5qSmp1TWNQekpBMjE1Vlp3?=
 =?utf-8?B?ck10OCtCLzVWb0htRHl6cERDR2t6a3YrV29xbFczZGRNd3hkU0FjdHhpcWZH?=
 =?utf-8?B?eFVXUG5Vemo4OXdodFdKTk1hcW1aTDRLN0tadGVVWXhtd3RPcVpHdVEyL0xw?=
 =?utf-8?B?WEtUU1JNL0l4bHBEVVhoUDRTcHBUSlFpTTRPcGRmbFNFQmtEaFN4clpVL0p5?=
 =?utf-8?B?V0VkVnlEdHhTZThOd2xIRjdFa2FGTlZoelJuRjBMa1JzV1ZIUXFLbkVpT01P?=
 =?utf-8?B?NExPanJxYTZQYVRJa1NvSnpuKzExMU1sdkZ3dHM5ZlVIamRUWkxRWjVnVkJl?=
 =?utf-8?B?NkU1Y1NOU0dxZ1NCQk5RTWpiVjVLUXJWbjlSaGNmU2E3Qzl5QlJMblNjQ1ZZ?=
 =?utf-8?B?NHlxMUVLZkQxWEp4RFc0ZHBONHNCMXFNaFRXbWRVU3VRUDRMQVdVaHJFTTZz?=
 =?utf-8?B?WXlmRlUrZmZYcUVkeXB1akt1TFJ6Q0xielBWSzZuZmoySk1FRjBkWFBqWkNO?=
 =?utf-8?B?TkgvWVlabmRVMWdIbUZiVUVDRERmY1RGQjJVa1VXRDRmNkNqSXVnenpnUi9a?=
 =?utf-8?B?U1Q4ZnlMSVJ1bUVLRG9yU1U1eVRLditDb0pNMk55SUUvTElYQWZGMkVERlpI?=
 =?utf-8?B?NlY4V1pBZzVyeW1kcGE1ZVFGQktnNUpBOXREeVA4bmcwWmhpMkV1ZjlPVkRj?=
 =?utf-8?B?SFB6WDMwSVFia3BwSHlrUEFoWlU0RXlzV1BzNk94anRvR2UyYkFvZ0hrSkFL?=
 =?utf-8?B?NW9GN1d6WkJlMUxlcnlmSitFdUNNbFJVN2haTFNURXgzUEVqWGZWU0J3YWNO?=
 =?utf-8?B?MVBXdDlQalNvM01yaFQrNWk0dS9vcklVMllQMERLb29Scmk4RnNpSWRIUGFF?=
 =?utf-8?B?Uk4yVEQrY3dyQnBSOFBFWWlyMnI4QkxvTkdQZVVyclVsdit2VU51TzhQWkhR?=
 =?utf-8?B?bFRPTFhkMTF0b1QxeU9qaUlQNEZwYjZDQVE4Um0yTjF4NDdXZ1dGUVpKWllW?=
 =?utf-8?B?WmFTSDlRbnY1L3FoSE13TFVZc1J1aWNzRUN5OFg2N2FmdnNlbVJZb0NZdzdi?=
 =?utf-8?B?bEFUcnkwQXdJQ21STCswQ0ZxNUdEN3E1Uko4SDRXbm1oaVBnam94b1Ntckcz?=
 =?utf-8?B?MWZNaFlJdC9EbjNwWjYwMmplKzZJWm9mQ2lzajNza0x1dS9BaExhMWRVZThS?=
 =?utf-8?B?S05Sam9Bd3o1aHFaYlVNbzFwMU9YZ2ZZV1Y4M0tYVk5ES1RIL3dSMURJQkxl?=
 =?utf-8?B?emZlR0ZHRXltM1laRSsvQmRnUk9hMWJkMlVoR1FLYXlEUVhBbXVCR1ZNZDdl?=
 =?utf-8?Q?9horxNAjNRFOWJVPGgHK7U3QjsEjJ43/fDFu+Sh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1NvNCtZczlTWmUyaFF0MGNoblNzUC9EWHNsS3NxdE04b1lSUjR6aUZTMDlR?=
 =?utf-8?B?YzFxM0VRRHdjUk5sWGh3S0V1WlpHcS9SY1p6WGNCdUtCc29xdTF4MXp5Ykx2?=
 =?utf-8?B?WTNzSkpqYWR2TmFtdjIrOVhvQmFQSGh0MVRKZUoyTS9SUEFyaUsvTXhQMllN?=
 =?utf-8?B?YU55N3B2NFVnSDZQWk9POXUwRjBQSE9aeXVSWk5NbVNLM00yVzZGc0pzNHpv?=
 =?utf-8?B?azNNazFOQmxaZTFjNjFaVjZacHlsSkgyMDZiRHU2YUVlQnUwa2FqWSs5Vitr?=
 =?utf-8?B?VjFjWnZXOUw1dTdhS3A3WEYwQTZLVW1jRWtMY1BWQ0FHVm5Hdnp4SHo5UEw1?=
 =?utf-8?B?MHhhZkJtOUlHTVNjTUpLVkFNVGtkU0JWdmZUdmJ0TWpnU1NCbVpkZkZ1N0tJ?=
 =?utf-8?B?cGRJb2g3NTQwMTJBcHR1eE5zMCtzaXJxRzNUN2I2REhjOXJpei9DZU80SmE5?=
 =?utf-8?B?UGIxcDhQcURxbFpSUFVQSXY0d3J4MlUrZGo5T1NZZEtIdXR1U1NWSklCdFFi?=
 =?utf-8?B?TnZ6bGg2V085YWlMei9DVFduRnlETzkrdDdaR2NkZW9qcE9MR0Jmb29CanRZ?=
 =?utf-8?B?QlUwc0FycGZ1WFl4SlBpOWRRUTRFanlQdmZUZHBRb0xUcVRvekxiOUtTbjJk?=
 =?utf-8?B?aFo5cmp1eFh1eFFzYzlpTStGNFIyaHN2TDk4Q3F2QUxVNlJYaGJRRThFLzFv?=
 =?utf-8?B?akQzK1grNHNOc3JqS2s2UmFNUUtaSVlNRU0vMG4rOTdoLzhWeENXaDJNQ05h?=
 =?utf-8?B?UDBVSFhvQUI0WTd4cTJjcG1YUWZHTG9BcUNpT0M0ZG5uOUhmQkQrZjFRVE1S?=
 =?utf-8?B?cjQxVjl2dGVEd0gvL0RTTTFNbFA4alhaVWdnTVFPU0ExNjJnM2FFRUNzQzVj?=
 =?utf-8?B?UElESXFRWUp5c3pkcUFFQ3orcFMvMXppYWtnL1NLZW9FS00xa1l0UThVNVhp?=
 =?utf-8?B?ZW9BRHBSZm0xdkZVTVFpMk5jaFB1bGdzdG5KNTRCbzdpNVFRYThoNE0zVEl2?=
 =?utf-8?B?WVBsNG1NbEZFQzFaNmxvNWZGS21zQWNFVk1JOHk2WkJxbzdTRjE2SFR5bVgv?=
 =?utf-8?B?M3JuOFBMOWFodCtKdy8zbXVtcnhJenR5b1NVWUhGZTlJSDRTdW5PQy95bElQ?=
 =?utf-8?B?dTNsZlhLcENwRXdRb0NlaU5yczhBWjViczY3RzdsbVFNNkh4eEd5S29WZVFV?=
 =?utf-8?B?UkNDRnZzaW0vRUg4UGpCWmtJVWNyS090dThCZ0NPeXpYT1J6QTZZaWVtTUNl?=
 =?utf-8?B?bnNxaUU1L1B4SU9pVklmWGlwcVplelNSWXU0V2hBZ1BpV1pnRTd4UjFnSCtm?=
 =?utf-8?B?TzgrYUNocWN2a3FpZEZDVStqNFJGZ2NVSm9HdzhodWJ2Z1UreUxsb3BEZUJR?=
 =?utf-8?B?RWpQVGUxd0loUTRwSHJJb2UrNkRXaTRMaFhpeUFXSWdRNER3NUdrcUNEendi?=
 =?utf-8?B?ZWZXMnl4dUlrSXhwSUhwVHF4VS9oMUJib0RJSWFzSzJxMnk2UHJLTFRWeE9V?=
 =?utf-8?B?V2FINUxCU3p6RHllSzNnNU9iZFc5cDZ2STZGeTVjUUJaQmdkTURyTXdpWkdh?=
 =?utf-8?B?Z0t5WEs0bmVWWHd5SDVBR3ZDT2dSYmpFamN4YkVkVDU0cFZSSVpKN2ZzZzhs?=
 =?utf-8?B?aGdOamJCR3pVT0l5R1ZDeVRSN0pEQnJrbDVqSXNjMzhFRE5GVVA5WmJlVWVF?=
 =?utf-8?B?KzJjNXdPMzRDaEUwR3Q5b0lKMEFydExSY2Q4WFF0U3QyQllvV2JxNy80MWsr?=
 =?utf-8?B?Vk95QlJ1L09ta3VFVEo1THVLaHBTNEFQRWxrdjIxNGNZbmtabGFLK1pxUGhO?=
 =?utf-8?B?cFE4WXNSY0RaVXN0WjRLd2JiUkdROFlLSEJna0ZJNnl1U1BXSE8zdkVzQ0xY?=
 =?utf-8?B?MWNpNnQ5TEdqbmVPZzdjMWdqcjhlNVFpZzZMN2pvS01lSzZLWlVxYm4vdDJV?=
 =?utf-8?B?K29RNlhFZ2NJRGdwSkFuQ1hZREYxVENsS2VkNzZuMXVaNStKNlBJSUFZNyt2?=
 =?utf-8?B?MExCeHJ3L3ZQT2tLbml6NkpmQ2l5Z0dUcmVMeFF5U2NXOTZJTzZRbkR6S0o2?=
 =?utf-8?B?b1Q2MHQwdjJtNG5TZjF1S1BLR2dvMzhrMms5b1VNejJKQ0k4L1doVk9lV2hk?=
 =?utf-8?Q?1T9BI0lKz8Scjd9RVWsGSb6ob?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcf0497-7e76-4398-c2f0-08dd0853ad76
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 04:36:04.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pav2BpN8sJTyAYXScivQueyj59tlECQPAP5kNUvu9+O+Okj6zgU31TaLOPitx0YL8+Iws1oJ/E2Kc/tnw5/dHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667

On 11/18/2024 22:34, Kurt Borja wrote:
> Simplfy platform device creation by using

Typo

s/Simplfy/Simplify/

> platform_device_register_simple().
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Minor typo in commit message.  LGTM otherwise.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/platform/x86/dell/alienware-wmi.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 77465ed9b449..742fe79f13dc 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1196,14 +1196,13 @@ static int __init alienware_wmi_init(void)
>   	ret = platform_driver_register(&platform_driver);
>   	if (ret)
>   		goto fail_platform_driver;
> -	platform_device = platform_device_alloc("alienware-wmi", PLATFORM_DEVID_NONE);
> -	if (!platform_device) {
> -		ret = -ENOMEM;
> +
> +	platform_device = platform_device_register_simple("alienware-wmi",
> +							  PLATFORM_DEVID_NONE, NULL, 0);
> +	if (IS_ERR(platform_device)) {
> +		ret = PTR_ERR(platform_device);
>   		goto fail_platform_device1;
>   	}
> -	ret = platform_device_add(platform_device);
> -	if (ret)
> -		goto fail_platform_device2;
>   
>   	if (quirks->hdmi_mux > 0) {
>   		ret = create_hdmi(platform_device);
> @@ -1242,9 +1241,7 @@ static int __init alienware_wmi_init(void)
>   fail_prep_deepsleep:
>   fail_prep_amplifier:
>   fail_prep_hdmi:
> -	platform_device_del(platform_device);
> -fail_platform_device2:
> -	platform_device_put(platform_device);
> +	platform_device_unregister(platform_device);
>   fail_platform_device1:
>   	platform_driver_unregister(&platform_driver);
>   fail_platform_driver:



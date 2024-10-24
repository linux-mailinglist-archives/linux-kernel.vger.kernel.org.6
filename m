Return-Path: <linux-kernel+bounces-380529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3399AF051
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A539280A95
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02923216A28;
	Thu, 24 Oct 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usask.ca header.i=@usask.ca header.b="MNPHQesH"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020116.outbound.protection.outlook.com [52.101.191.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AF216A24
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796652; cv=fail; b=JaguuixD8g1h2o4v3JJybSVC2ZYMmQRCXmkXXVLSziwD0q7OE85nM8Pp4rULdjztpj+MpzZsxTGc4IlI8QRyaQYAs7S7wFEt78qVMyiyO+2qvKGc8taU1gxrgmFcc27lNJkWfaWFJE9IyaUjBox0mllz8kyCvEm+diNMG5IugZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796652; c=relaxed/simple;
	bh=ERU1gV1r2bzE4qsdUIWiRnDL5Q3vlRNZ0oJrZXssPYo=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=B0yoLPXeR92bsQC1OPYsNoGFnGeinMA9T3KfNGuqZrE4VoikKiTKc1F6ESKF4FzFyWIRJ/w63wmcH4Gawp70oZsgoQ2n4JzMZoTI/vpDKIH3FYFZLNR4nANI0eJNW/OBle2R2DsaYMbd65Fgkc5VpEQEfyKFuCyRPUzdGojq7Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usask.ca; spf=pass smtp.mailfrom=mail.usask.ca; dkim=pass (2048-bit key) header.d=usask.ca header.i=@usask.ca header.b=MNPHQesH; arc=fail smtp.client-ip=52.101.191.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usask.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.usask.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hd6FepeDYv1zO+m3XOvz/hJPINK6kesfAFlIWbTfpG+j1o/7HNtKhe3PmroILwBuK1uqAHW8xJpNuoYomBxqiI8UomKD3DZnIx/wTJQWE8qw1Iqmz5KkjlkotLeKTUI1SAKJoBWWeFrzky6+Z+ziUN1287jCbOwQVkBtbKQCkJ6R58ybfWkwILa1yhHlcspu3G66WZ5pEP9u7qpLKpYmMgnMndjFa6mc54nUqvJ3fhq3lzTSnlppA5CM2tSePbog5nk6SskbazJ35ynJGsGqEzjJswIZo1sSXjtk/flyLVb07BokUEXrizOx80pwL5xHl5GCP5awqUPHkLC92gIw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SbULqqbPL7UfaYIjugC24RC1P8ek4QLHFrodjzi+Ak=;
 b=hIzVqlrL4O8uhmb+UiC5d/UMopdMySdMhhdQiu5XYKuMqvJc90ew0HT6vdXn0EHNKadVTXAwHLuaBRU6yruOritjlwHA+O2VQ41PIdA9GEHXBcA3gKwuVrVpKjlvmlUepV81HP4wjwpRdcBo+u26+QqKUDwhUY8VNcqZqq1uFEb3WdrE4O0BPG9SD6B8z+lXyilzB2P9kivU60RELZPOzRSr++apBG8WvwIlietY7Uvj3heku/HxCtdgiGkaSQYDpjrhYNxnjjckw7BYQ7DU1EMllXWDer5Ico6WvgKJF33H1S7xKvp7kPiBuTFwFB+qG7+WDivAbTbEk8fFdWy77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.usask.ca; dmarc=pass action=none header.from=usask.ca;
 dkim=pass header.d=usask.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usask.ca; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SbULqqbPL7UfaYIjugC24RC1P8ek4QLHFrodjzi+Ak=;
 b=MNPHQesHRD12yJ+5H/AWpUO90aXHaCMi14rE9K2gxORaAUHvD9I8uE7+bsotI2OnA2opba1WKS1yOrNMr2DBM8BnYmr1kUGh1pGnRB+NvgZdnomqNpp+JT0EMrAnBesxhsc+QxkRlYlonrSI3dBN5nkrO1pHk/APyOiZCWlEBfHrEMsuznpY3UQDaXcQ+qz28o/V3Lpr2lFxrWUsLjQy+2A1mTdHCq74H3PO44RB2a0EZUBQ13R4QwdKKgTdWYgogC9858b6VHWqVHGVb+Xe2XL/oMKJWSCMqOYpCnE0SkUILFLGs1YoPCfrXHYFVZ968FMLk5XTczqk1TZ88PJb2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=usask.ca;
Received: from YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:38::6)
 by YT2PR01MB11307.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 19:04:07 +0000
Received: from YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94df:38df:6872:f321]) by YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::94df:38df:6872:f321%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 19:04:07 +0000
Message-ID: <a6a073ef-e208-44cb-b41f-85c29c42ee9c@usask.ca>
Date: Thu, 24 Oct 2024 13:04:04 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
From: Chris Friesen <cbf123@usask.ca>
Subject: is there any dynamic equivalent to the "isolcpus=managed_irq" boot
 arg?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:408:94::36) To YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:38::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6200:EE_|YT2PR01MB11307:EE_
X-MS-Office365-Filtering-Correlation-Id: 36810495-babd-4d3b-55d8-08dcf45ea288
X-UofS-Origin: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1VCaldhMU1VNEZLTVdGclVXYks4ZTZZMkVZMUYrQlJISkV1a3pqd0ZRYnZU?=
 =?utf-8?B?ZUc1eHhqRG8zdjdQaERYTzJXUEc1Yk1iMmxraWs1c1U2R3RlbzMxbFpGUFFY?=
 =?utf-8?B?ODNPS2hPVCtqRFh5L2NIUDBTR3F3cndlMUZPOTROUmdkYlZ4UThreFVWZENE?=
 =?utf-8?B?KytFN0ZmSkdYQTVDaElLQk5uakl6aWl4R0dULzk4VWRleGRtTmtKSmVHRm5Y?=
 =?utf-8?B?akp5RkZRc2g5Q3Q4eVZ3VDhJVDFJQWN3bE1xeU5iZm9wT1ByZFpxU1VxL1pU?=
 =?utf-8?B?cjVneEVEOXc1L0ZSUWdGRlVxYUlYTVJHeDZySHI4TFk0RGRScjVxZWo0aWVH?=
 =?utf-8?B?eG9rckpRNlF3cXJoTnNMU1I5VHM4bHJzUys4bDhLM24xNTVDaVFJT0VRR0tk?=
 =?utf-8?B?ZVhuQjRWNzdZbjgvNU93aEN2MjA5SUduN1E4M1FobWNXenhSOWNWSHFLRmRk?=
 =?utf-8?B?S3UveGtMVmk3anZrblJ5bXBTUUJZUXpWZ0FoMk94OWNJb3F3S2tWZFdWNEdX?=
 =?utf-8?B?YjJUZWgwY3Z1NWFFUUVVNHN1ZmljWHlIWGVBeXhlU0F4bkI4MDZKQTFYUXgx?=
 =?utf-8?B?YTRRenVUbGVkdE1QUzF3bmoyMkhEREM5K3BKamZpVTVEYzZoN28vQVZaNVR5?=
 =?utf-8?B?UXVjc1FaUHFJQWx6cm5LRDVZcjRQY052TEVnQXhFVk9KeDM3R2F6MDZETDBZ?=
 =?utf-8?B?VkZONkJERnhhS1grNFVqTGJ4Y2REVENVZzM2dFpSajN1R1VPalVDMmNCNlNi?=
 =?utf-8?B?YU9YRHpKenBuRUJoZmoxWGhZVGpLWGt1bUo1b0dubUVkRVEyOUx1cEs5NC94?=
 =?utf-8?B?ekdYblRuMXpGd0QvNnFZdEgyUWlyNnc4ZGNHVE16djg4dk5USmdzTkwza0lZ?=
 =?utf-8?B?ZkFvanY4Z0Nqc1pYUmRPaG85dzBHK2VtMU10cUloZHF1VGcxYlc4TndML2Y3?=
 =?utf-8?B?cVFRSzliWjFSTmlxWXNJRURzOFJ2dFdna1RXckFyOTFLcnBXL2YrSUxDN1lJ?=
 =?utf-8?B?eE1oQ3ppYitPM0ZYc1I5bDlsb3IvaEMvamdoVnBxR28yT0VQTTZvVUNiVVZW?=
 =?utf-8?B?eXcwYTlNdEZrRU9vUjF2WGNNL1lGVmpsL3ExWFpNeUlFbjNmZ1NqWW5nOVk5?=
 =?utf-8?B?UXllSXpFaS9QTHFSUFZSUElzMUYvUUlmYktnZThNUHpOTU14V3I4ZStjQTZ3?=
 =?utf-8?B?K1dXZ1h0Q2RPbFVBVmVENWE3TW9pUDhSbnVpVjgybkRQaW9weUFJTzVPMkUw?=
 =?utf-8?B?VnNKRkZkcGtxQkhBTThnNEc4ZFJLTWtTTzk5VW85SFhTNEh6SVIxNHRhYm9L?=
 =?utf-8?B?YzFXWDZTVzErbEFCaGt2VWptRVhwVER4amNKN0pHRmwzdnkrcFNWdGgrNlR0?=
 =?utf-8?B?M3g1QWlxUGg4VHZ6QTNQczYyQ0dpWG13NVUrc21IbXJuRnloSVQvMlN6K242?=
 =?utf-8?B?V3FFNzQ3RXRFWlRIdkNuaHlhYlZYeDNQQjFwUisvdXAzK3F0ZVFZRldGRVZa?=
 =?utf-8?B?UUdWNk4yMzJpbmNQMDhWT2NWNVlseWMyYlVXaTRaVmJRNlk1aEJudm5wWDl3?=
 =?utf-8?B?a3Z6azg2NldrKzR2U2d3aDZ3Wml1eXZUbEZ6M0VpTjY4YUYyaVBNWnVSSWZO?=
 =?utf-8?B?M3luMU4rclNReG5Dc0hPaWZCWFFKMHhuRk1YdDNSZER3aEVwbXY2OVU2TVVH?=
 =?utf-8?B?Tm9NVElnZFFTTjh0MTVSV3FNRmlwb001N3FDeXF3Q01peHE4Vkx0ekVZQ2Vh?=
 =?utf-8?Q?mTikQW5+iI3Wn9Z0njCnipMrrhKkfJ4XViXUal2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG0wMDJvcXk0c2h1RU1LQ0swRzlrRW4wOVJ0ekdjdkZoMjFHRDQ1UjR1eE0y?=
 =?utf-8?B?YjRzd3FYMjJpVkIvUk5adGJEbTBTOXdiMHRUSVJ3QXl5Lzl1THBudTdnUzdL?=
 =?utf-8?B?S2FkaUpkTnErdGhEQVAyemlPdkovTXVNbFVabjR0dXQ3RFpSRmwrN3pNNDd0?=
 =?utf-8?B?SGhDb0RzMzkzNHZPTzJpcUpSbG44bDdLd0FlZW5BTm16cC9LK3VMTERxaGpy?=
 =?utf-8?B?c0ZiRmU3YXNlbDZvUnVGYXZ4U1ZNN1NLZjRwbFYvdm1DSENJUGl6QTZ5UEZM?=
 =?utf-8?B?NXF6OUZvanRJdGJOcFJ6WGN5Q3lEZGU0Rys4S1Q0SXpXQmFRNnFUZWxaNU00?=
 =?utf-8?B?My9jKzNTbk5xbG5yUDRLYWM4WU9uSGpHOXo5bXl1dWN0QjBZeVZabkxWWkta?=
 =?utf-8?B?MkxaTTFXYy9kUTRCSmwyV2duL0lJTWdDYnRpTkoyZmtwVmJCdGtraCtKNGI5?=
 =?utf-8?B?MHVZSWhZa1RwNU1vZ29mMWlhb21ONGp1QkU4UVZyelZ0aTNncEVtYTM1VWFP?=
 =?utf-8?B?T1lEZkdhWHlPTW02dWhLM0xtbW5RU1B4WUhMOWxBd0tVYmNGeUdvV0R4Tmtl?=
 =?utf-8?B?elVsREZiRDB0QmViWklSdUZTU2tQQjlaNGs2L2kxUS9BVTA4YlY0ZkNPZDhi?=
 =?utf-8?B?ZGQ2dnVSQzZDMU5DQjA5SnVRZ0lJeUdmRVdWT2hFcHpiMk1SSmRJOUJ1elBI?=
 =?utf-8?B?MDlWR0Vjc0RoMm9VVXowUllxUTFkMUVOc2NVMlBtOVhJT0NrU2IzWkE4elR5?=
 =?utf-8?B?WnMyeDVBZkRjWW9kbmUzNXRYTFlCLzRCcUZWQXVMZHl3VXNCb254Q0ZqaHpM?=
 =?utf-8?B?Ti9tQXhWeUhVOGwzRVh6QzlHVWhlN04yTjA3MHFGTHJDUUthVDh0UUhyVDA5?=
 =?utf-8?B?MEI5cnRIZGxtd3lmTFluNkFNa2c5ckVOeHc0a1NudmFuZ1BlWW10Ry9taksx?=
 =?utf-8?B?SWNCOHJpa1dPZU1LQlB4MG5VdzVMenN5MmJNdlVEcHc2bWlXbzJGcC83TFhx?=
 =?utf-8?B?VVRVR21WVUd0Y0xvcUJqNDJ4MzNCRndiOENBdGkrbGV4VHVTMHE3akpCSTJN?=
 =?utf-8?B?RXVLMHR2cVVtNUlLbWo1bjAzN1FZYUdCZDdVblVoOHVwSzFJTERiVjFWRHAx?=
 =?utf-8?B?SEdDQzUwdVMzeFA5WVRjNVlOaElaQ3dWU3lWNkRpbG5laUR0RUpGanVvQ3FV?=
 =?utf-8?B?Q01XbmJ4NmV6Q1dVdFBhRlVwei84UFo3SG5IM3RiOVdiV0pnUmlzUXE2eHBo?=
 =?utf-8?B?SDFYbi9XNnIxbHZjTFdwL3hQZTltajVqaHp6dUdvT29jbnJJQUFnN3B1QUYz?=
 =?utf-8?B?SXArQ3I0WlphN3F0d3dMdlBCNVFVWjNpZGM1RFhqeXh5TUNYRFZjNkxxQ24y?=
 =?utf-8?B?OUIxeGZpZjBJSWM5U0o5MXVmR0RSSlpqQ0xzdGl5Z0htd2xDRllMcFJkdjRp?=
 =?utf-8?B?ejNFdW9MSm9TVElTYTdNeDJDZkhMRTVDZUVqM2h4K3lSVWFMeFIzLzFHOW5r?=
 =?utf-8?B?eWEvZ3BaVTliUHlEc2diUm54dDRKM1Ara3FtQXNHRVVoZ3QwRzZDb0xQZkFF?=
 =?utf-8?B?Qlk1czc3QTk2a2dJK3FyT0JRWjQ3aHJsejUwMyswVU85SzJEUDFkZ3lBSURE?=
 =?utf-8?B?YVdzQlo4UjFGREs1UG1JQ0ZXTnAvRTRLSXpwWVJsVi9ZamtwZGhtaGU2WU5K?=
 =?utf-8?B?UE1wamx0M2syZUZZZFJQUXBMOEdxaHZrdTlxd0JzWW9jcHNHY0p0bWxpUCtZ?=
 =?utf-8?B?QkdvRC9GVnlaZG9JVlBRNnBTd3MvbnowcjYzeXh6ZERjT241N1hUVmVvS2hT?=
 =?utf-8?B?Rmx5anhvWkxkQlg3N3JkdXZXaVFlaFRVcS9QT3ZCS0V1QmNPSllYeDVPb0Ns?=
 =?utf-8?B?Nms5Q0hoQ0JNZmZqTFJ4R1piMlFuNjQrZnZXUU1xWWkrbjBTemd5amZTRGNW?=
 =?utf-8?B?MWVsa2RVY3pvMExUL0pCNlJobzNtNkxlWm1nUkJ6Y1laYjVnQ3hQendlYmU1?=
 =?utf-8?B?OGdGMTZEMUovMjNON0ttVUlBR09vTEhGQW0wQjYrMnp6VnhZY3VKSVAya01n?=
 =?utf-8?B?QTN5MEpWV2U4RndJY0ROL1NvK3FJcGFOTXFZVXkvdk9zSWpzSGZ6TTVYa0Jv?=
 =?utf-8?Q?e7ofaxRufKf5zsZBXqucSOvmY?=
X-OriginatorOrg: usask.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 36810495-babd-4d3b-55d8-08dcf45ea288
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6200.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 19:04:07.2775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24ab6cd0-487e-4722-9bc3-da9c4232776c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2BR5ZJFxABvgTdJwwqYuYHif5S++LCWu5S32kB7X5ZZKJhjwp9RNvxtTFQ6G3Ap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11307

Hi all,

In the kernel boot args we can specify something like 
"isolcpus=managed_irq,nohz,domain,<cpu-list>" to tell the kernel to 
isolate a given set of CPUs and *also* prevent them from being targeted 
by managed interrupts.

The boot-time isolcpus mechanism is deprecated, so is there a runtime 
equivalent to tell the kernel to avoid certain CPUs for managed 
interrupts?   I just stumbled over https://lkml.org/lkml/2024/9/16/563 
which makes me think the answer might be that no such mechanism exists 
currently.

I'm not subscribed to the list so please CC me on replies.

Thanks,
Chris Friesen




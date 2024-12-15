Return-Path: <linux-kernel+bounces-446470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DF9F24B8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 17:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391E218854C5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D17B1917C2;
	Sun, 15 Dec 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="a42n1UiG"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A72189912
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734278795; cv=fail; b=crFsLJrAsUyYyxQYGMcFlxdL+LwI9OySvkoGnqeiYQOO/JuPTVkQSeBKCJfoUOEdzzrCeU7Rc1dpVJqGCfNW/i+1MAFcOMitEt4BCIIzw8wYUzn5xey6CEx1CyUniSRCENHC8mwqO+RneycxxmGF3mBTomboH6b+tdRy0fHKa3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734278795; c=relaxed/simple;
	bh=VRlfYKdaNT9jw8liovufASBwQORrDWJJjtAH7SJ0r9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pl1gHVInuWuf7QXOkeMHlRK9+iD0b4bvAk1IL4AYpk1Tzb/iT9lwuEGNcD0opM19QECIgH37QOBRLkj0u0ONPayPPSzOv051s8cRuH3D2A25YooPWYu6XDHnBAhgPKl79MD37u/u7AEWjrdi49SzxX1PbQKTFgM5wBBM4SIEqas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=a42n1UiG; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9jHsQFz1okmZiITj0zVS4TFsthfHa28v398Q7QYZlMJfdmEdat1zNLFMX/zhW5kFdtrHP93/hUC6AiS/V1gA/FdT7s5zL3v0x1JCJ4y5WpxHznWGsAWklVIfVW3FetuWNJWcBAEGBslvUtDqzCFOjQu27+i0uqeqxuholHNL1iG8YlLwdBOsNBMMyOAvJM/I8+Oo0XrTUCdJolHU26zu6mjCLQS5tgr0Go0DPOHUscksGUYShrjhi+lyp6qvh1fxs+17IaetM491naOKnGkcsAqjfCXOKfEACFXEu+Q44e367YnxT56y8CaARo3wLjFFrkUbo8nNWoFAAFEr23bag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghPZ9mdS3x5sreIhLP6yMTEwx4au47nbQCIupbQBJVU=;
 b=g1prKd4VXgH5B3BRPrNI18UkcPICs4KAurxYvyvfAWhaIdD0v5SfAhwp2IGK2TstdY7KmtAkmLfWWza6ybgGhCfzLMfWmAKaPe4XQdQ/lC0O9V3lC+MPE952H6kvrkmS7KjKbRYX9g5Um3HFGR4sZnZcwtoL2sfVUkBFBcwVV1P2rK1lhymlB0lv6gZSoHd5wRenmDLdaXsyb/3z54Y1FD06RO0SIL4h5iXi2abCUw8M+hwG5QYqCgs5tLOkzRDWvcb0A5eC+RIuiUWBE5NY45ZpIj19Lhpfo2xZlMw83kLkjWD9XNR05OG16NcmgcuRxgLSHuk6DNWqCLnLf0YDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghPZ9mdS3x5sreIhLP6yMTEwx4au47nbQCIupbQBJVU=;
 b=a42n1UiGFVt4UMCy0BXO3+YX0SMrxPE6mNzSYrkVlOkLm5Y4ci3bHaHPO4KWnLtCgdkknjTxuLW8goGqEx+kS/dKScMJit42SQB61dhn1/So1814pJOgC6NXMO6JFjYsR5TML4/6VcPzmztWRkY9EYXoyn/gI/S5kzHR8zo1FkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com (2603:10a6:20b:5a5::16)
 by PAXPR02MB7912.eurprd02.prod.outlook.com (2603:10a6:102:28d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 16:06:29 +0000
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::8927:53fe:9d2:cc22]) by AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::8927:53fe:9d2:cc22%4]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 16:06:29 +0000
Message-ID: <e157669a-0ffa-4d43-b282-e14651c269b9@axis.com>
Date: Sun, 15 Dec 2024 17:05:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ubi: Revert "ubi: wl: Close down wear-leveling before
 nand is suspended"
To: Zhihao Cheng <chengzhihao1@huawei.com>, richard@nod.at,
 dennis.lamerice@gmail.com, vigneshr@ti.com, marten.lindahl@axis.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com
References: <20241214110153.684919-1-chengzhihao1@huawei.com>
Content-Language: en-US
From: Marten Lindahl <martenli@axis.com>
In-Reply-To: <20241214110153.684919-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0099.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::12) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|PAXPR02MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a92f28-5ac5-4875-6127-08dd1d226f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXpsL2p2MDJJQllJeER1Z3cycWxqWU41ZDFxMFJzaEVrZHRSYnVOd1RYbFJu?=
 =?utf-8?B?bll4Q3c1U2Nic1huSlBuUmxaaXR3Z2p4K3pOU2N1YmZDVXNJVWU4YzJQeU1y?=
 =?utf-8?B?Yk50aG1KQkkxM0JCam9NeUxKVHVHQ2RlREIyZUpxWGdvYnNQYXFNQUpKZjNa?=
 =?utf-8?B?T251d1dueHZPQUppbS9HcjAwVUJjaFNKNldSUjBVS1l6eHFRNVIxald2MUUx?=
 =?utf-8?B?a1dhNW5LRzRJcHpyZUtCUXlkVFluZTQ5eGdZR3ZUOUhyL0pqWm5tcnV5WWlO?=
 =?utf-8?B?ZUh4OGFRTWh6NlEzaEFkNi9JV01YeG5scys1b2dIMmxLRzZrMktUYTJRcStw?=
 =?utf-8?B?ZTRXc21pdno3SU13VU5NNEN6T1hPdEovd1EyVExLWHJ3K3hZRExlUlQyaTg1?=
 =?utf-8?B?c3JLUTNta0R1TUV6UlJVYXpIZXRjYUNEVVVic2Z4SnRhTTdlYWZoVnF1R3lH?=
 =?utf-8?B?d2tyNEoyU3E2U0xVM244K0tlZnBXdjhTU052Z0RTcjVrUklHaGpnZExRUUNl?=
 =?utf-8?B?WGtzZzZXc0NUL0JoUjJUQzFBSVVkMnVBcDkwcldEZUN5dFc0V2lZN0VZa1Fn?=
 =?utf-8?B?a05Lc0RYWitIQmpQRFpxYVM2bGJGT3FRc1NFU05tYnJwSkwvRmdKbW53MEE5?=
 =?utf-8?B?ZGJKNUl2SXZRaEM3U3JHbXNtcU1peUg1UkQyU0QyMWUxUFp1bVFFUDRyZ3lm?=
 =?utf-8?B?MUc2ODV4dUk0K1p5aHJ0Mlh0WWk3UEdrYU8wNHh2MUNmZURmUVl1NDdScTRO?=
 =?utf-8?B?NGpncjcxU2p4bWRjOWxVbUNHVGR6NFM1ZFpPYkRUUjI4eEIyREhFbjNQTm9q?=
 =?utf-8?B?cG5aVHFuVEduU1RYRE9IMXVJZlBCVk5DaTU1MmhpeWEraHF2UXRUV2Y2dzE1?=
 =?utf-8?B?MDdSbjNxblh0MTNmdmIza1ZycHF6ZTJsODRZTVd4MkxtbXNBTG5CU1o5L1dZ?=
 =?utf-8?B?QWw1ZFdaSU1CamZiL2JwYzFPcE05RENjMjQzVllHU1VkSDh4dmk5M05qdTVH?=
 =?utf-8?B?SEhOeU1BdTI2RHl5MkR1TXUwcjFVWGxlblBDeHExSWtnVExXNE1hOG5YQm5J?=
 =?utf-8?B?bHBTeDJXUlVKNDhoT3dRUHh4SHptaDZuSVprMk0zdUlyaThhUUhMSFR4ejYr?=
 =?utf-8?B?OENISWpRY2FDRVNPMSsrRWt3V0twb051S0dmdjV4Yk12QkE1WUpLdVI2TFZu?=
 =?utf-8?B?ZlBrY3UyMjZYMHYwUW1lV25TZ2NXd3R6K3VIK0N5VnR6RVFvN0ExZVF3S2hH?=
 =?utf-8?B?bjZ1UzI2aEs1VXRaSEMvenIzbUdUTWlzSWhIemhzRWo2MngvSmVGQXBBaUNK?=
 =?utf-8?B?SHJmMWxmTDZ3cVpwc1ZOQnY3bUw2ZHhVU1VMU0YxamNVZW9lZC85UVNWTEtj?=
 =?utf-8?B?aldJbTZySWRVMm5yNnJEcnZ1MEtMRXc0ZFNqT2dERDBlV2VQSDlML1dJdG04?=
 =?utf-8?B?V2o5UHlQaUZLaFdHMnd6ZnhCSkNhaVMrRFJDaXNWK3htK2h2R3M3NE9jdmpG?=
 =?utf-8?B?YmpBcXY4VFp4NkFyS3ZrMXl3U2FhWWVpVG1VL0hIalNEZmtaT3U4ancrY3A5?=
 =?utf-8?B?b3M3MzhxV01hM2xTaFJsdDMyK2M0NG5QZkMzQVZONjRVMkJBYVBBRjJ0clJI?=
 =?utf-8?B?cmtJblB6bE1SSElISSs0ZEFBVEhERTVMNzhTU2V2SDRFZkk3NWNRTktRdUtC?=
 =?utf-8?B?ZDNqSXlNcGZpWG1nQlNHNFUydXcrMFJSazk5TGo4MUU2aXlENG9IRUxmNTZs?=
 =?utf-8?B?R1Z1R01Wa1h6bE1JSTlmTVluY0hNcm9SSlNtdUFMbmZaMFFjM3E1QXgwVlB4?=
 =?utf-8?B?QkY0K1Blck1QeUVNUEVRdmIvbjhUSDZORFp2OFAyMW04alJkTGpzYzVmUFpS?=
 =?utf-8?Q?2pyCbDEf/VZlR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlQ2MFNBaDZkTTZBVHlaZjJkeVpXQzFvWGJrcHFSZnBjdmRqV0Q4cEFvNHE4?=
 =?utf-8?B?T2tQUE9WSVlYL3hnV0NYMThPakdlT3BSeTJ2U1BJdy9SU2JQVzZPZ0YxRlhL?=
 =?utf-8?B?VzVQMWZBd0N6Y3d5U0phZi9BcWFSTENxYS9NT25vYmVkWmdaaHFJMjNaZXQ3?=
 =?utf-8?B?dHorOWF4ZFl6VkI2Z3ZUVGhUWUM1U3hqMlZ5VFJzdjdWUnFRWVlpVE9XZFph?=
 =?utf-8?B?dnlpMG9UVEhhampTRWRIREw4eEZVcXEvUHVqL1loczRScmN5S2hQYjlUL2VW?=
 =?utf-8?B?ZWl6cXZ6aXlMeExxdEFJM1o5blV5eVA3R3QyNUZsa3U5VHp5NDlXakcyd2Ns?=
 =?utf-8?B?Mkx3SU93cm9wRVdiRHRoejhibW4vZWN4ZXM4SzRFc1VRZzVQRTJmTnVERVpL?=
 =?utf-8?B?WmtYeHRKUmhzT0pWL0p0TUJUZDZJOWtnWXFLTEljMTljc21JczY3OEpZbVJM?=
 =?utf-8?B?bUlxYm54TkdoZDg1Skc5ZXh6ZWVZWml2RWpHZmtkK0lqbStncktOM1U2ZC9P?=
 =?utf-8?B?aHl4UzBWNFN2dGVCSy9oejFsRUN5M25Fa05vc1kvY1JDRk9WU0hFa2RKcEFO?=
 =?utf-8?B?RXFVeVdsRlhRZG1nYzdoMzFjaUhqT3JzOUw5UjNCK1UyejR3TU5pS2Q3VUwx?=
 =?utf-8?B?cU1HaW1LbkNjRFQ3eGtNclJOdTIrT2I3WG9zSk5acTM1NmVwczZvcEp4Y1NY?=
 =?utf-8?B?UWhITUhXTndjZWxmb0QrZ1I0Y0VWZWNmZHJrZHFZZUl2OERqdE5nOFJpdVJF?=
 =?utf-8?B?bFBrYTJTMlFFaVZhc3Z2c2x3OVdqam1WSnVZR3pMOTY2aFFHOFYzL2JYUkti?=
 =?utf-8?B?VjJmTG5RdjBvd2xXRzZLRFlpc2hCYitaQjNDcWNvRHhxVXVrdUZhdjQ0a3k5?=
 =?utf-8?B?a0VpWjdEQjA1WFc0Wjc0Y3d6OGlEcEJjWHUwNWo5WG5kQnlYZ2wrK0ZPenpI?=
 =?utf-8?B?Nlh1ejd3aDJNSzBMejBodlpTMUdhRnpzUytIK2p6T0tTaE9ta0tFU3Q0UndY?=
 =?utf-8?B?Vk1mSThiVEQxMmo2cVhuVjVoVXpMY1B3SW1lK0ZoZXI5Qklybm9LeXJvNXdS?=
 =?utf-8?B?UEdRWjBZZU4wRkNzTzExNFpROEhUYkp2TTYyZnp3clVhSTFTTm4vWVcyZ3hC?=
 =?utf-8?B?U3lyOXJKdnU0VmpuTnppT29wSENSc0pQQzBRR1dEeS8vYmRXcVdERTZYaXFQ?=
 =?utf-8?B?bmxyUTJEdzBxNEJzWmptSjV6UFVoRCtVcStZQjNsTXNLMWhPMDRwQUxqemNz?=
 =?utf-8?B?RFNGMTlpdkJna0luWXo2alZHa2V0RDFCa053N2Q4SkRRT0Y1YUxpQ2VkTUUz?=
 =?utf-8?B?aUxMejFFL0lWNzVZU1c2N0NkQ3gzVVJhMjVjdS9QeWhacFhKaWx5b2FWeHFs?=
 =?utf-8?B?by9wbnJ2THZMOCtUR2VJUUdLVW5IU3dQUzlsTFdrY05uYlZaUU4zOU9MTG5F?=
 =?utf-8?B?R0h4Q1ZBS0FlOU5vV21JSVB6dTFnaW5OeFdtM0RFZVVaaThIK1d6V1RCVWJQ?=
 =?utf-8?B?N09xQmdRcEFvRytIZWZpckNOUmplK3pQZU9ldkFVQnJJcUpCQjIrTXJiaEZp?=
 =?utf-8?B?ZnNOVjAwMXhnalBuc1hNaUZNYUFuRUYySGFIN3Q0TVByaXNzWUFoYWc5Sm05?=
 =?utf-8?B?UjVER051dzJFMUYwbkRGTFU4ekU4VWdvOUpSL1orM1gvTURKd3QyYkZQOFQx?=
 =?utf-8?B?RkMveUVERDM5bDlOT2Nqd3ZyVHo4VVF3T0tjTEZITlVHQWlhVEJPYk9icG5i?=
 =?utf-8?B?bkk2elcxaitGRXdVcGxaU0dNK0xFWmE3S1VuRDBaQnBDMXBCeGdmMm5mQjRp?=
 =?utf-8?B?ZDZUYjJlRTlpN2dYcEhIaEFSRzFEN2p4dEpUQmFyKzVibERkc1dsdDNCNjF6?=
 =?utf-8?B?R0hLYmU5Qm10eGprSEo4ZUpMNlFVazdiZVVQYytTajRuQjJwN08yME9waWxL?=
 =?utf-8?B?TzBXa1hUVy9neTRIMUNxMTVxSVdoY1JRdG5yeWJaUUVKMm0yWFdzTEdxWXRP?=
 =?utf-8?B?QVo2M1ZUOC9JdjIyeUVFbDNWeXFKaWFkU2FjRzVuVnptNE1POHNOeEtNR29X?=
 =?utf-8?B?ZDhpRDNIUTlzV0JxaTNIcWh5OWwxdndVR3l1RXNrNDUwRlEzaEFQQ2xZa0xl?=
 =?utf-8?B?RW5aaUtlYUxtTkZvTXZhaTk5ZjN0aklvU3lwZXlwNFhaVkhrc3g5emoyM21U?=
 =?utf-8?Q?JGGXdsyyxsdfILsGv6vr/YPqStfGMZq45m4bWNKYAQrm?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a92f28-5ac5-4875-6127-08dd1d226f5c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 16:06:29.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZZx+h0xGdgKGHXKNO1BU3h9u0UWfge3u3whNv96FEOCzfmux7DlqvANSxNhX9lANSQ8O7aOHXcgLZPCvbmRSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7912

Hi Zhihao Cheng!

Yes, we discussed this issue in [2], and I thought 5580cdae05ae ("ubi: 
wl: Close down wear-leveling before nand is suspended") was dropped, but 
I see now it got merged.

I agree it should be reverted.

Acked-by: Mårten Lindahl <marten.lindahl@axis.com>

Kind regards

Mårten

On 12/14/24 12:01, Zhihao Cheng wrote:
> Commit 5580cdae05ae ("ubi: wl: Close down wear-leveling before nand is
> suspended") added a reboot notification in UBI layer to shutdown the
> wear-leveling subsystem, which imported an UAF problem[1]. Besides that,
> the method also brings other potential UAF problems, for example:
>         reboot             kworker
>   ubi_wl_reboot_notifier
>    ubi_wl_close
>     ubi_fastmap_close
>      kfree(ubi->fm)
>                       update_fastmap_work_fn
> 		      ubi_update_fastmap
> 		       old_fm = ubi->fm
> 		       if (old_fm && old_fm->e[i]) // UAF!
>
> Actually, the problem fixed by commit 5580cdae05ae ("ubi: wl: Close down
> wear-leveling before nand is suspended") has been solved by commit
> 8cba323437a4 ("mtd: rawnand: protect access to rawnand devices while in
> suspend"), which was discussed in [2]. So we can revert the commit
> 5580cdae05ae ("ubi: wl: Close down wear-leveling before nand is
> suspended") directly.
>
> [1] https://lore.kernel.org/linux-mtd/20241208175211.9406-2-dennis.lamerice@gmail.com/
> [2] https://lore.kernel.org/all/9bf76f5d-12a4-46ff-90d4-4a7f0f47c381@axis.com/
>
> Fixes: 5580cdae05ae ("ubi: wl: Close down wear-leveling before nand is suspended")
> Reported-by: Dennis Lam <dennis.lamerice@gmail.com>
> Closes: https://lore.kernel.org/linux-mtd/20241208175211.9406-2-dennis.lamerice@gmail.com/
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>   drivers/mtd/ubi/ubi.h |  2 --
>   drivers/mtd/ubi/wl.c  | 21 ---------------------
>   2 files changed, 23 deletions(-)
>
> diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> index 26cc53ad34ec..c792b9bcab9b 100644
> --- a/drivers/mtd/ubi/ubi.h
> +++ b/drivers/mtd/ubi/ubi.h
> @@ -549,7 +549,6 @@ struct ubi_debug_info {
>    * @peb_buf: a buffer of PEB size used for different purposes
>    * @buf_mutex: protects @peb_buf
>    * @ckvol_mutex: serializes static volume checking when opening
> - * @wl_reboot_notifier: close all wear-leveling work before reboot
>    *
>    * @dbg: debugging information for this UBI device
>    */
> @@ -652,7 +651,6 @@ struct ubi_device {
>   	void *peb_buf;
>   	struct mutex buf_mutex;
>   	struct mutex ckvol_mutex;
> -	struct notifier_block wl_reboot_notifier;
>   
>   	struct ubi_debug_info dbg;
>   };
> diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
> index 4f6f339d8fb8..fbd399cf6503 100644
> --- a/drivers/mtd/ubi/wl.c
> +++ b/drivers/mtd/ubi/wl.c
> @@ -89,7 +89,6 @@
>   #include <linux/crc32.h>
>   #include <linux/freezer.h>
>   #include <linux/kthread.h>
> -#include <linux/reboot.h>
>   #include "ubi.h"
>   #include "wl.h"
>   
> @@ -128,8 +127,6 @@ static int self_check_in_wl_tree(const struct ubi_device *ubi,
>   				 struct ubi_wl_entry *e, struct rb_root *root);
>   static int self_check_in_pq(const struct ubi_device *ubi,
>   			    struct ubi_wl_entry *e);
> -static int ubi_wl_reboot_notifier(struct notifier_block *n,
> -				  unsigned long state, void *cmd);
>   
>   /**
>    * wl_tree_add - add a wear-leveling entry to a WL RB-tree.
> @@ -1953,13 +1950,6 @@ int ubi_wl_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
>   	if (!ubi->ro_mode && !ubi->fm_disabled)
>   		ubi_ensure_anchor_pebs(ubi);
>   #endif
> -
> -	if (!ubi->wl_reboot_notifier.notifier_call) {
> -		ubi->wl_reboot_notifier.notifier_call = ubi_wl_reboot_notifier;
> -		ubi->wl_reboot_notifier.priority = 1; /* Higher than MTD */
> -		register_reboot_notifier(&ubi->wl_reboot_notifier);
> -	}
> -
>   	return 0;
>   
>   out_free:
> @@ -2005,17 +1995,6 @@ void ubi_wl_close(struct ubi_device *ubi)
>   	kfree(ubi->lookuptbl);
>   }
>   
> -static int ubi_wl_reboot_notifier(struct notifier_block *n,
> -				  unsigned long state, void *cmd)
> -{
> -	struct ubi_device *ubi;
> -
> -	ubi = container_of(n, struct ubi_device, wl_reboot_notifier);
> -	ubi_wl_close(ubi);
> -
> -	return NOTIFY_DONE;
> -}
> -
>   /**
>    * self_check_ec - make sure that the erase counter of a PEB is correct.
>    * @ubi: UBI device description object


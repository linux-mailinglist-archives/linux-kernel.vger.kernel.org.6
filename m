Return-Path: <linux-kernel+bounces-244195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E92E92A09D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5212E1C20FFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AD378C9A;
	Mon,  8 Jul 2024 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="FFqSryk2"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2096.outbound.protection.outlook.com [40.107.104.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D475277F2F;
	Mon,  8 Jul 2024 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720436336; cv=fail; b=VyD+9wvjR7ZV7mRZA3OJZHgVssIwoJh0L+nXOiGr1hzf5sHe1Yc+/dNUAma+R61Lznd6JeoPBb3QiHg43aGRD0cXl62IawXtI90Y73SwGnbWvobeHISFhJXIYjqj4IG5vGq/tLZwV/IGxHNTYSAcMtTHREovxmn82FXadFQqog8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720436336; c=relaxed/simple;
	bh=GdmL7Cnwp6PnPmSzVeu366TQ3i46mtLg0ysyZyFpcR0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rLUm6Pq3gr48qe0K35+FscdQGcjcHoDr65fl8BSbm5RS01U3LmKiv+lnNn1QczempSoZZfufViZ5F9VVSsSPjWW10E6Ov1PkK7mlV0EBeX0X8Z2OwBveMH1mays2AOhYjtOhcxFYFP5c4Tobb+EKTdt0NnZ6oUVViIrPfrl41bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=FFqSryk2; arc=fail smtp.client-ip=40.107.104.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQR9yMj8lfXvWy6C41NhRaRcq3qyUyzYf+2j8kZkrBqKng0X1fB5nd6ytXjofV8jwolHihzc2w2kBzb99zxGNHUyCPJl4Tp5nWuYKaZ4yepOFPP3UXE3RCZ+26Lvb2zi3/PuwSiq0P0yWcbU2oenkvX1L+BOjWNqWOeaO0z9BciicZ3vLaPD7nR3gn9Mm9GK7HHuPvjpRSyJyUoKOkKcjWGPHjl2muR/I7NqjkITCSIMOBCdzvfI0TqMy/VTnSBwyz3mfFd+oclVpM7svBsNhlmWWHE4tzdFxZtRWRr4hZA0xL4zb9f0s4dzwN5LQx8lvqSxqDBaaOrwGXL78GdCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcN1IxctsL/Rej3v8To5q9tb3zt/1XGyw9WFQflYqYo=;
 b=e49TS84rrGFzjaRoTJ6jilG1yFHPX6mQ8mEwuWcPbUk19LkfZt5obUCduzldC/fvXtVjpZdLW9yh5C5jiByUAC4/YujZZs7Z6SgE+4RDZBynM7LS1Z/ooHFl0qeOV+sXwBhQ58MEtRlPPMKXg8TOelulmQKqP6E47VqEM3ijtmknD3Fp6kGP5zWOGgXZVO7fgBcoMtpFLhrbcCWzrRBtcKLUI4iOVtf80SdhPK8ywiXOEr3MRn4l5NBDjbh1lSsCeUuMe631nyxhrUMx8LiL8ZKUNleIMjV1zoAT9znusLVr0gcDlVScuLdjE8lmW0mrKGMJucoEcLatNOe5Hr5OKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcN1IxctsL/Rej3v8To5q9tb3zt/1XGyw9WFQflYqYo=;
 b=FFqSryk2juwXBYUz2q01ZFejJ/l3h31mbWE84A09aY3YdFZCKSuTnkwdn9JybAvOGj7TYJvTZd+r4BC7kuN6gXlJFuOgS97ovMh20wI0P/QijuBWpgoofnwx/avlEyRsYviI8xGCdAhC4AfRbXWOmdu/T8HUcaC4OzKVDPhejfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10217.eurprd04.prod.outlook.com (2603:10a6:800:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 10:58:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 10:58:47 +0000
Message-ID: <e38ceaf9-c904-41f1-a32d-14a150c92f30@cherry.de>
Date: Mon, 8 Jul 2024 12:58:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] hwmon: (amc6821) Convert to use regmap
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240705213547.1155690-1-linux@roeck-us.net>
 <20240705213547.1155690-10-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240705213547.1155690-10-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0042.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10217:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b917a7-082c-49aa-bc6c-08dc9f3cf170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dC9WbkQxS2lISGVDWEp3cXJoZmpJRG9VVXdyRmVYejF0SEpIaS9PVGNJN2hH?=
 =?utf-8?B?d2VoM0h1QTRzUm90aFZYa21ZVFFsb1M0enk4b0g0TjZmV2lWVGhyb0E3Smxq?=
 =?utf-8?B?Z0J6L3NjaWRYVmZzWEVocmVaMXVQV1JKL1Evb2dpWGw2QVdmWGdMK2JEbmhZ?=
 =?utf-8?B?WWVycllPY1BMbW1TU0tlZUt5SFBPbndUWVVvZmwwL3VPaHZBRmNFM3hqK0NE?=
 =?utf-8?B?Qm9iaWNFSXR2Mm10SXBDQUU3MEZ3eGV5R2N4bC9ZYkxzRkw4ZDJhMnFDQXdr?=
 =?utf-8?B?U0tRRjM5NHlSdkdKNzFHT0U4RGhxUmVBa3MwdlFJTG53eE5Jc1k5aFF6WCtL?=
 =?utf-8?B?TjRTMmI5V3dFQW9Mc3BSbDZqbmExNitUcXErUytpWFBXSlFTUFpzV2VOTG1M?=
 =?utf-8?B?b0dONHdad3RrdFJxaHpPRjdnVnBEQlprKy8wN3BJam9GWWk1U2ZXazdUMDNR?=
 =?utf-8?B?RGFYQlB6UkNrak9pTmFjdmRCU0l1TGxVYm1YRDJjRFUxRG5rck9LMm1lOUIy?=
 =?utf-8?B?b1hoUlBHMW0vSnJIbnhoS0Z5UXZmSnRQTWZxeWh1TkYrNW1DN0UyWkRqYkVh?=
 =?utf-8?B?MHVUQmhVcWRTZjdnZDdtd2thNzczcGlSd1ljWGtvY3pNRVFCakJGSDg2MjNU?=
 =?utf-8?B?Zm1Dam9hWE1HUDF0dFV5QzUrY01Wc002QWErWUd6cGVQQUdFc1BmYStxRUdK?=
 =?utf-8?B?dktHeUg2dkNoZERlZStjMUk3M0xOQlJxUXF3ZTVoczdFNFY3QVNESGVCdEFG?=
 =?utf-8?B?ampycVNlQ3pJZXQ4ZzhZM24wK3RVV2RnZlY2NFhpaHdnR0xTeWxWOUN2cFhV?=
 =?utf-8?B?MmpVVGkxSFZUcEhaaDhFZ0ZReFdlOGpiT0wvNUhjVHNQRnhVS2xVVkR6NEhV?=
 =?utf-8?B?ZUhGOEFCMU1FYXFMa0l6TWpqbHVvdVA3MndQeWwvZnZidFZ6TjVkTEhVVTBr?=
 =?utf-8?B?Z2tyVTNrcDhtQmdGc1EvNzhWNnZDVjg1TWdsMmZPZlViektHWVRWRkhjekdt?=
 =?utf-8?B?VUJRMUVFT1lybHlyRTRwekppWTQ5U00xaTV3N01PUnMwVnJqRXhrZnVuUnd4?=
 =?utf-8?B?ZGliTlJEVURrMTZ0VSswcVRCbjN5UkNWbEk3YmtIdmVaY3NKbDdrZ2E3SVlo?=
 =?utf-8?B?YWdkbHI4aVlUNHV4cW5uOFNLcG16TWtXMVpBK25aY3ZGT3pva29DK0N4dVVM?=
 =?utf-8?B?bGdsZmY2V2FPS0xGUFNwOGp1bWVIUmVUZ3ZQRG5yRTNDV2o1eVFVSDlUN08y?=
 =?utf-8?B?TDkwdFdRZ0V4Vkd5ZVA3U2Y1UWdqbk1DVnFFcFJJSmg3cnAwQkQ4SWtIWWZC?=
 =?utf-8?B?RTJNc0FGOGxuTysvaUFodHhXSk1kdVpZM04ySGlmRVFsclZkSnkyNy8yS2xk?=
 =?utf-8?B?WlZuYWFjVnFJdUZkcDNjSVNJLysveW81Rm8rT0t3K0dyb1VxSFFBTEwzblRX?=
 =?utf-8?B?Nzg2ZlFhWkIzU3BpaGlRMzZWUzhHLzVHaDJUR0YxWDRudEh5OU84MnAwMk1i?=
 =?utf-8?B?bjhQbUdpVU9KRmFwaHpUZE5HRkJIcjBneVNYNkx5c1F5eTUxcUc5Q21jMHdT?=
 =?utf-8?B?NVdHQ0x3SGtJVks3ZEVYcG9RUlpBVVVMV1RTNGZMUkJiU1JqSXRxSUpHdTVi?=
 =?utf-8?B?QzZ5WGpvUUVXaUFXaUgvaVBldUFQb2xoNG81dHZSWXRYVkZkY0FFdzJabWxl?=
 =?utf-8?B?a2RIbFlKb1k4YlVpMW1CaDd0cjAzZHF2R0FiSUxjMzR3UDVJMERKUXNudGFR?=
 =?utf-8?B?Wk8xQ2hIeWVhbGppVHR3REIrSDN0d1NSQ1h3bnA1dHZ3T05hQkc1cWN1aTNF?=
 =?utf-8?B?TnNCNE1WNGQ0MXlyUzc3QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW9rbmRmT0FudDFkL1BSbHZyTklYbVlMUnEwRy9IUVVjVzNDZStra2hNRUhx?=
 =?utf-8?B?UjNGdy8rZmYyT3pzUHNwVmRiRFhZRUhGTithZlJ3SlovMkxuZ3YyMFhSMFJa?=
 =?utf-8?B?T0xSbVJ5WVV3S3hwdWFlbE5tYUR4cU9PQXFSU3RCazRhM1R3RzlCV0U1TTZs?=
 =?utf-8?B?NEhHdWJJYS9pQ1RTM0xvU3FpU05HOGF0YklTSVdCN1Z0aGJKWUQvdFFSSnRW?=
 =?utf-8?B?dWZ6ZlRjeitpOEFtRmtqbnErTUdzTHpsK3Jad0lvNmMyS0tVMFZxdEk5SEp2?=
 =?utf-8?B?QjVBQlhpYmtOMVI1aGMvYThSMVdqa001VjM4L2JjU05YSDBkZ3RUeFcwYjB6?=
 =?utf-8?B?NU9ralNwTDZJOVhiTzIyb2J6amxKbjdNOFZyU0JvcTdTamc2YUZLYmRkMnpC?=
 =?utf-8?B?LzZvdEFnc1pLODR1cE5mYld0dm9VZVhkbXFnc2NlR0VjcjhzWHV2OVpaN1h6?=
 =?utf-8?B?ZThIbnBncmF1cEN4cDJ3SHJCb1phSlF1YzBuKzMrUVRzOTk1aXI5MzFxWnlN?=
 =?utf-8?B?S0syNXlMY09kb2FpbnoycjhkcklwbDhvbDIwWFVKR05XcTBhS05sSFdYZlZY?=
 =?utf-8?B?TytRZzVzSENkMWorSUVQcFNyeVVXR0lzNU52ZjdGSG05cnNva09UU1NxSEIw?=
 =?utf-8?B?N1hZWGdmYm94b09pbmV4UmVWQVRGYVp4aks0NW9GZ0dBRkl5eDRraEtPQ1Ey?=
 =?utf-8?B?Uk93WC9hVnpFV2J5bFFBK0JFWm1LdnVBbzMxSG9uWXQyc0hiOFp5UkdCWVNw?=
 =?utf-8?B?bHNmcnk2SkFnLzlLYzRwUFVoZXVNMzJRRm1QUHQ3NFNHeEQwR0FEeDE4RFR0?=
 =?utf-8?B?bHNnSWozWWVUaWcxd2xUWnhQc2g4NFBzNHI3TGRmZUZVMGJsaTU5eng1M0pE?=
 =?utf-8?B?alViRy9XWVMza3lZaUhlV0FKWnVkQTR3SFl5Nk5JbjJaSC80ZTJyVWJQWnhQ?=
 =?utf-8?B?Y2pjdDFtREJDanhHOFYyc2hwZWdsQ0VPOXdJZUVLZE1wbTlYSjkzMUdnWE96?=
 =?utf-8?B?Y1Z3ak1rN3R1SjBRQTUrTmxocDAxdXNSK0czWU1BZEhGVGNiUEphZUFscTZy?=
 =?utf-8?B?aTN3Mk9SN3g1RUpQTW9KeWl0ZFhjbjV3dGlnNjBwMndlakNtbmFTN3k4TE9a?=
 =?utf-8?B?OC90YmhTVmV5MmNBRkY3ZWd1MkNRWXVkNVNwZUIzZElmdEt2aVRmTmZUSGQ5?=
 =?utf-8?B?M3d6djVYTjlqdzFmdVd1NGlXWElwSmwyZ2M1amIydVc3a1hrUC9hUWlyeUNa?=
 =?utf-8?B?QWRySGh4dHZuQi9vdFd6U09ObkY1K0hKQXV3RVFYV2JtdXJYaVlhOUVjVCtZ?=
 =?utf-8?B?NmdtQkpEaVZMVlRueUE2eGRlQUUrNUoxaHUrdkVOTUVPbnZQSktoN0dFL00y?=
 =?utf-8?B?bUQyQTRPSHg0SG9yTVkwMy9Wb1J1STAwOHNFZFI2MEkxRHZoT3dwK1h4d2xO?=
 =?utf-8?B?VDJCR1hxMkZXMUI5YUFUdFpYc0hJWUF3S0hBSnNnVVFDN2h0ZXlYd0ZocVEx?=
 =?utf-8?B?OUREbWhTL1BiS2dZNWI3ZlEwOWo0NGFTYXdXTFA3UG9QQVFacDdiZXdxajZL?=
 =?utf-8?B?alZvMEtpbkhJdEJYOU9HNFFRV0NHTEdxbzFrZmExY09iQ21VeXN6VGg0Z3px?=
 =?utf-8?B?NWoyVXFtQm9CZnZqcmtCQ3VZY1JPeXQwbENNMVNoYzg3Mkh6ZzJyTEtSNFRE?=
 =?utf-8?B?TnlGaHZIQ1JuaGlKY1NYWkN0L2RKTDI2endEQ05jMjRMZXN5Zmx2VGJRR2lq?=
 =?utf-8?B?VmtBYnFxR3hZT2k2K2VzWUFpeGJaOXQza0NXMVpuOTlvUnkzeUdFRFdQaWF4?=
 =?utf-8?B?Q1RIVGhHcStoS2FWUWNueE04cWYxbmp6YXRTUzcvNjZpN1c1d21hNjlKWkoy?=
 =?utf-8?B?L2ErUWhnMUM2d2JKV3BGSk9IYklHVitNc1hzMVcvaDBOM3VWNTBKVkV6NVNI?=
 =?utf-8?B?dnhNNGVjUEhzTVdyYU1Ya1dodWhCeWRWVWttSzRTNmo4dXRqQnpYZk9YSllI?=
 =?utf-8?B?L1NSYzFiVHZWSXFrVzNGWVhhek9RMzZ0VmUvTGg5WnVRUHJPdE9nb1YzSXh3?=
 =?utf-8?B?c09UVnROTE9rNlhFcjdXMWYyT09FcWhRQ25LcTZjUGQzQkNaL0ttYnJZeDZo?=
 =?utf-8?B?VHRHRlVQdU1qcEhjdERUTkNSQXROYlAzNDFzNkJVdzRDZHlVUXJFbWUvV3lM?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b917a7-082c-49aa-bc6c-08dc9f3cf170
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 10:58:47.8282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoBv/78tZoqXOw0XZx0lHlD4+yWvRUSO3JyLWxLKvckbZnHB6voGs84Gjfa1Ar9W2padJUYQUoc5iZwQK3tVBG9G3jwnNNSFfb+ZazY7KWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10217

Hi Guenter,

On 7/5/24 11:35 PM, Guenter Roeck wrote:
> Use regmap for register accesses and caching.
> 
> While at it, use sysfs_emit() instead of sprintf() to write sysfs
> attribute data, and remove spurious debug messages which would only
> be seen as result of a bug in the code. Also make sure that error
> codes are propagated and not replaced with -EIO.
> 
> While at it, introduce rounding of written temperature values and for
> internal calculations to reduce deviation from written values and as
> much as possible.
> 
> No functional change intended except for differences introduced by
> rounding.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v4: Improve function comments
>      Better use of BIT(), FIELD_GET(), and FIELD_PREP()
>      Use min() instead of clamp_val() in fan_store() since it is already
>      known that the value is > 0
>      In pwm1_auto_point_pwm_store(), use '0' for unlimited to match
>      the original code
>      In set_slope_register(), set both temperature limit and
>      slope to avoid an extra register write operation when setting the
>      limit
>      In temp_auto_point_temp_store(), only read the other set of
>      temperature registers when writing the PSV temperature
> 
> v3: Add more details to patch description
>      Cache all attributes
>      Introduce rounding when writing attributes and for some calculations
>      Always return error codes from regmap operations; never replace with
>      -EIO
> 
> v2: Drop another spurious debug message in this patch instead of patch 10
>      Add missing "select REGMAP_I2C" to Kconfig
>      Change misleading variable name from 'mask' to 'mode'.
>      Use sysfs_emit instead of sprintf everywhere
> 
>   drivers/hwmon/Kconfig   |   1 +
>   drivers/hwmon/amc6821.c | 822 +++++++++++++++++++---------------------
>   2 files changed, 381 insertions(+), 442 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e14ae18a973b..a8fa87a96e8f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2127,6 +2127,7 @@ config SENSORS_ADS7871
>   config SENSORS_AMC6821
>   	tristate "Texas Instruments AMC6821"
>   	depends on I2C
> +	select REGMAP_I2C
>   	help
>   	  If you say yes here you get support for the Texas Instruments
>   	  AMC6821 hardware monitoring chips.
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 295a9148779d..90efd6a0dfd3 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -8,15 +8,18 @@
>    * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
>    */
>   
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
>   #include <linux/bits.h>
>   #include <linux/err.h>
>   #include <linux/hwmon.h>
>   #include <linux/hwmon-sysfs.h>
>   #include <linux/i2c.h>
>   #include <linux/init.h>
> -#include <linux/jiffies.h>
> +#include <linux/minmax.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/regmap.h>
>   #include <linux/slab.h>
>   
>   /*
> @@ -44,6 +47,7 @@ module_param(init, int, 0444);
>   #define AMC6821_REG_CONF4		0x04
>   #define AMC6821_REG_STAT1		0x02
>   #define AMC6821_REG_STAT2		0x03
> +#define AMC6821_REG_TEMP_LO		0x06
>   #define AMC6821_REG_TDATA_LOW		0x08
>   #define AMC6821_REG_TDATA_HI		0x09
>   #define AMC6821_REG_LTEMP_HI		0x0A
> @@ -61,11 +65,8 @@ module_param(init, int, 0444);
>   #define AMC6821_REG_DCY_LOW_TEMP	0x21
>   
>   #define AMC6821_REG_TACH_LLIMITL	0x10
> -#define AMC6821_REG_TACH_LLIMITH	0x11
>   #define AMC6821_REG_TACH_HLIMITL	0x12
> -#define AMC6821_REG_TACH_HLIMITH	0x13
>   #define AMC6821_REG_TACH_SETTINGL	0x1e
> -#define AMC6821_REG_TACH_SETTINGH	0x1f
>   
>   #define AMC6821_CONF1_START		BIT(0)
>   #define AMC6821_CONF1_FAN_INT_EN	BIT(1)
> @@ -108,6 +109,9 @@ module_param(init, int, 0444);
>   #define AMC6821_STAT2_L_THERM		BIT(6)
>   #define AMC6821_STAT2_THERM_IN		BIT(7)
>   
> +#define AMC6821_TEMP_SLOPE_MASK		GENMASK(2, 0)
> +#define AMC6821_TEMP_LIMIT_MASK		GENMASK(7, 3)
> +
>   enum {IDX_TEMP1_INPUT = 0, IDX_TEMP1_MIN, IDX_TEMP1_MAX,
>   	IDX_TEMP1_CRIT, IDX_TEMP2_INPUT, IDX_TEMP2_MIN,
>   	IDX_TEMP2_MAX, IDX_TEMP2_CRIT,
> @@ -130,224 +134,158 @@ static const u8 fan_reg_low[] = {AMC6821_REG_TDATA_LOW,
>   			AMC6821_REG_TACH_HLIMITL,
>   			AMC6821_REG_TACH_SETTINGL, };
>   
> -static const u8 fan_reg_hi[] = {AMC6821_REG_TDATA_HI,
> -			AMC6821_REG_TACH_LLIMITH,
> -			AMC6821_REG_TACH_HLIMITH,
> -			AMC6821_REG_TACH_SETTINGH, };
> -
>   /*
>    * Client data (each client gets its own)
>    */
>   
>   struct amc6821_data {
> -	struct i2c_client *client;
> +	struct regmap *regmap;
>   	struct mutex update_lock;
> -	bool valid; /* false until following fields are valid */
> -	unsigned long last_updated; /* in jiffies */
> -
> -	/* register values */
> -	int temp[TEMP_IDX_LEN];
> -
> -	u16 fan[FAN1_IDX_LEN];
> -	u8 fan1_pulses;
> -
> -	u8 pwm1;
> -	u8 temp1_auto_point_temp[3];
> -	u8 temp2_auto_point_temp[3];
> -	u8 pwm1_auto_point_pwm[3];
> -	u8 pwm1_enable;
> -	u8 pwm1_auto_channels_temp;
> -
> -	u8 stat1;
> -	u8 stat2;
>   };
>   
> -static struct amc6821_data *amc6821_update_device(struct device *dev)
> +/*
> + * Return 0 on success or negative error code.
> + *
> + * temps returns set of three temperatures, in °C:
> + * temps[0]: Passive cooling temperature, applies to both channels
> + * temps[1]: Low temperature, start slope calculations
> + * temps[2]: High temperature
> + *
> + * Channel 0: local, channel 1: remote.
> + */
> +static int amc6821_get_auto_point_temps(struct regmap *regmap, int channel, u8 *temps)
>   {
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	int timeout = HZ;
> -	u8 reg;
> -	int i;
> +	u32 pwm, regval;
> +	int err;
>   
> -	mutex_lock(&data->update_lock);
> +	err = regmap_read(regmap, AMC6821_REG_DCY_LOW_TEMP, &pwm);
> +	if (err)
> +		return err;
>   
> -	if (time_after(jiffies, data->last_updated + timeout) ||
> -			!data->valid) {
> +	err = regmap_read(regmap, AMC6821_REG_PSV_TEMP, &regval);
> +	if (err)
> +		return err;
> +	temps[0] = regval;
>   
> -		for (i = 0; i < TEMP_IDX_LEN; i++)
> -			data->temp[i] = (int8_t)i2c_smbus_read_byte_data(
> -				client, temp_reg[i]);
> +	err = regmap_read(regmap,
> +			  channel ? AMC6821_REG_RTEMP_FAN_CTRL : AMC6821_REG_LTEMP_FAN_CTRL,
> +			  &regval);
> +	if (err)
> +		return err;
> +	temps[1] = FIELD_GET(AMC6821_TEMP_LIMIT_MASK, regval) * 4;
>   
> -		data->stat1 = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_STAT1);
> -		data->stat2 = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_STAT2);
> +	regval = BIT(5) >> FIELD_GET(AMC6821_TEMP_SLOPE_MASK, regval);

BIT(5) doesn't have real meaning in the datasheet, what is in the 
datasheet though is that the slope is 32 / L-SLP[2:0] (well, you can 
more easily guess it from the datasheet than 0x20 or BIT(5) IMO).

[...]

> +static inline int set_slope_register(struct regmap *regmap, int channel, u8 *temps)
>   {
> -	int dt;
> -	u8 tmp;
> +	u8 regval = FIELD_PREP(AMC6821_TEMP_LIMIT_MASK, temps[1] / 4);
> +	u8 tmp, dpwm;
> +	int err, dt;
> +	u32 pwm;
>   
> -	dt = ptemp[2]-ptemp[1];
> +	err = regmap_read(regmap, AMC6821_REG_DCY_LOW_TEMP, &pwm);
> +	if (err)
> +		return err;
> +
> +	dpwm = 255 - pwm;
> +
> +	dt = temps[2] - temps[1];
>   	for (tmp = 4; tmp > 0; tmp--) {
> -		if (dt * (0x20 >> tmp) >= dpwm)
> +		if (dt * (BIT(5) >> tmp) >= dpwm)

Ditto I think?

>   			break;
>   	}
> -	tmp |= (ptemp[1] & 0x7C) << 1;
> -	if (i2c_smbus_write_byte_data(client,
> -			reg, tmp)) {
> -		dev_err(&client->dev, "Register write error, aborting.\n");
> -		return -EIO;
> -	}
> -	return 0;
> +	regval |= FIELD_PREP(AMC6821_TEMP_SLOPE_MASK, tmp);
> +
> +	return regmap_write(regmap,
> +			    channel ? AMC6821_REG_RTEMP_FAN_CTRL : AMC6821_REG_LTEMP_FAN_CTRL,
> +			    regval);
>   }
>   
>   static ssize_t temp_auto_point_temp_store(struct device *dev,
>   					  struct device_attribute *attr,
>   					  const char *buf, size_t count)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	struct i2c_client *client = data->client;
> +	struct amc6821_data *data = dev_get_drvdata(dev);
>   	int ix = to_sensor_dev_attr_2(attr)->index;
>   	int nr = to_sensor_dev_attr_2(attr)->nr;
> -	u8 *ptemp;
> -	u8 reg;
> -	int dpwm;
> +	struct regmap *regmap = data->regmap;
> +	u8 temps[3], otemps[3];
>   	long val;
> -	int ret = kstrtol(buf, 10, &val);
> +	int ret;
> +
> +	ret = kstrtol(buf, 10, &val);
>   	if (ret)
>   		return ret;
>   
> -	switch (nr) {
> -	case 1:
> -		ptemp = data->temp1_auto_point_temp;
> -		reg = AMC6821_REG_LTEMP_FAN_CTRL;
> -		break;
> -	case 2:
> -		ptemp = data->temp2_auto_point_temp;
> -		reg = AMC6821_REG_RTEMP_FAN_CTRL;
> -		break;
> -	default:
> -		dev_dbg(dev, "Unknown attr->nr (%d).\n", nr);
> -		return -EINVAL;
> -	}
> -
>   	mutex_lock(&data->update_lock);
> -	data->valid = false;
> +
> +	ret = amc6821_get_auto_point_temps(data->regmap, nr, temps);
> +	if (ret)
> +		goto unlock;
>   
>   	switch (ix) {
>   	case 0:
> -		ptemp[0] = clamp_val(val / 1000, 0,
> -				     data->temp1_auto_point_temp[1]);
> -		ptemp[0] = clamp_val(ptemp[0], 0,
> -				     data->temp2_auto_point_temp[1]);
> -		ptemp[0] = clamp_val(ptemp[0], 0, 63);
> -		if (i2c_smbus_write_byte_data(
> -					client,
> -					AMC6821_REG_PSV_TEMP,
> -					ptemp[0])) {
> -				dev_err(&client->dev,
> -					"Register write error, aborting.\n");
> -				count = -EIO;
> -		}
> -		goto EXIT;
> +		/*
> +		 * Passive cooling temperature. Range limit against low limit
> +		 * of both channels.
> +		 */
> +		ret = amc6821_get_auto_point_temps(data->regmap, 1 - nr, otemps);

I would have been more comfortable with
nr ? 0 : 1

Only nitpicks, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks for making it easier for us to add some patches on top of AMC6821 
soon, really appreciate it.

Quentin


Return-Path: <linux-kernel+bounces-443173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4429EE857
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04F5167E74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C72147E5;
	Thu, 12 Dec 2024 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bxc5O3cB"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020084.outbound.protection.outlook.com [52.101.189.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC02135BA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012383; cv=fail; b=HNBsYDixTwAChoY8Zm6tQRpmANPcaWJGnkevVhwyzdbKoxCnu1YMYeguAxJy7no3VzF7JUrOH7f4iENjINnYYmW6mmzRi/Av++aL9gMed8+LyshaumdpTigkF0XT6dlaZr4e+s6ZRGE0s0g9d2XeNZ+0L4vDmZ9+i1TVfDd2rlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012383; c=relaxed/simple;
	bh=VuMun1BWKcnnuecK8MhnFypkykLZXsCZxy+hh3XHEbA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ja8IFXkMdC+WaKvVBJI8OrV7Hs5OUhpnldMq9FzeBNE7Q2YOwov6WuX+BO5WTKn/kEinbwDzInesA4Ssn/J5RwIByoZtiVFPjdJbdq32Diq3igqdTo2VeP90H1FFGBeat8HsJfj49IIUtSdylG6DSqDyH8JTm52Ly5MMcEoPFAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bxc5O3cB; arc=fail smtp.client-ip=52.101.189.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSYwVhso/xrdxF4UCRkih53FPP3yiAnvOkR7Vu1SiqfsclcExIXDONzt4QVr/B5kNjxsBuDOl8gtxeqA93+iXOVrHFRPva+NPe+GNOlR/FOcChq+3I6cp87dj3gzMQ+Ai8uXe7NWmrm7l1YwQr1C8ingQ6wrWiWbHGmwewtSl6sqC8xiBhlgNVmynYEolzu8bRarMDAaUqo8pWU360OvDBMiuZOM73PzBViJhI5TDoNMiXu1QSCZi9awd8ovYa4GBaR0Acoyt6ajwkJCgzOw+UGjBZInTws/Wvx2WYXbnWTV37eO5SmBJfzZsQ6bHRr6zCChImfinCsXneN2+WheBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAwvFj+qCxH6pTOYnmEflphz/zzKPoqZTUehhuYgkJw=;
 b=BZXA4BVGN8PM5W9GGLncQ0GUeD4pdFY7zNb2qJUdTAzpcu4Y+SeU6eZnaP0ydwNACvv+Gd8TEjR9/PgIihrLspRLC2ASwtonQZK/qLXnsGrIscng+UI5cy1OU1j0b3kYm0NYhOAqNTt6kmVZmZ7X5uAUC+QXbvZPW5tGS/9SXYcQsdMGycEu8SXh9mGDmM+OCSKN1Il3h04jWEYazSfjuyg6WPtZzw+zJxZ4IIAhyZkuwMXDariK7qUL7oYKE3v19T0EV9Y9DXS5zdUYC4mrCUlsuE6HL44jikSIx7lUHnh+BqWk/vKK4ueQq1jCtxjNCm7OCZLpOR2UCc3Upjis4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAwvFj+qCxH6pTOYnmEflphz/zzKPoqZTUehhuYgkJw=;
 b=bxc5O3cBYEBcE7mUNx+zGCOLhnlDhNvuOIRHo1uPsOn7SVbIJ3aj3JeuGYnx/fWqV2r5uPDbsG1IkGcPD0+4L4kK6S+Cj1oQLK2+jK3ngxRXDADTeWdiEFXsMIjK5jgk+s3hb7nXCTKAjuHT6biUmHYAEYK2Fgdip0I+FEYD4G+gM6u3rnlDWSwAON6Q4jhoX7sH7rzqbuecFKsgd352yFp0dvTCypu0RTF1pZKyjnvEKXj4Noem17SB5hRuxt0RdRYX0PSNwgVHSMHiYQ0d9EoCZdg6iZDmzCwNFvJ8V/1ip9oTV3H/gXXug7buGoavr4M+p5rsphlyewROGr59zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 14:06:13 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 14:06:13 +0000
Message-ID: <4b0956f1-2b81-468c-b162-0f8013d60761@efficios.com>
Date: Thu, 12 Dec 2024 09:06:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Move task_mm_cid_work to mm delayed work
To: Gabriele Monaco <gmonaco@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>
References: <20241205083110.180134-2-gmonaco@redhat.com>
 <4c067b75e06aadd34eff5b60fc7c59967aa30809.camel@redhat.com>
 <5ba975e2-06b9-4b98-bece-d601b19a06db@efficios.com>
 <ead55d690448cbf23677bcc1b4c1a5c129240c90.camel@redhat.com>
 <445b4203-940d-4817-bd45-9da757f22450@efficios.com>
 <481a7b7716cf4eb2d592b08558d297d343d9aa25.camel@redhat.com>
 <cbc0a3c5-2ae5-439e-ae5d-7fb68ea49aec@efficios.com>
 <1f4a8928-8450-48e2-bf40-e75967240d79@efficios.com>
 <7c4d0c6800a4bd7a5cf4928e28d59fb469c944b9.camel@redhat.com>
 <eee21fae-dc64-40bf-90ac-c7228ae7ef48@efficios.com>
 <7e9082361b5b98f1824301c92cde929725db0db6.camel@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <7e9082361b5b98f1824301c92cde929725db0db6.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0278.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0bcc90-2eb2-4ff3-05cc-08dd1ab622ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnJqTk9HYk82UjExN3hKSVRtejRhcUd3K0drT0FoOUlwY3Z5SUFQbGg0Y3NI?=
 =?utf-8?B?Skpnd21PSUVDOGJ5RE0rOHZza1dodDg4Tmt3QzNHU2J6TFRhQjlpbDVvSDU1?=
 =?utf-8?B?TkQ5QmRESHRzam9NZW45WCt0SmJRYTZDamYxdVVOMVdtS1MwYmJYZUZJVUcw?=
 =?utf-8?B?ZElKcDVqZzRBYXRkcExUU2dQVUNTd2pOeTBVUlpRSnhFRGFrN1Yxcjd0ckpL?=
 =?utf-8?B?MzU0MkpqbGh2TUJIdTFBZjZlUnl1K05VR09RMG44QTdDRUM2Z3BrNTFiTk5F?=
 =?utf-8?B?YlE2NnFTaVdscHhHMHlVY2pkaE43VE1LWnlpRW44cFJzeTZFMlVhNE1pUHJ6?=
 =?utf-8?B?Y25rRS9HWmJBOFNlT3hDa3FqM1V2UVhuVGdWRXV3NWUxMzJHTFA1Nldpd2h6?=
 =?utf-8?B?WE9lWlFaNjZQYll5b05FK3ZMa1dPaDhTK2hNYXM3Wm5LWE9kc3lLQWZkMDcy?=
 =?utf-8?B?VVh3NlQ0TjZBOTVFRGsxYm9abkxrOU95U1p5Yi9SMW9kSy8yTmFMbitZZ3Mz?=
 =?utf-8?B?V3dsMlFRTzFlazV5OW04SUhhZVJBaDhIeVFkbmgvMmVXN0hhS0VKNXZVTFhQ?=
 =?utf-8?B?eWZsdzl6TFhEb1lrc29uL3JTRURBSFFuY2xUdDBQS1d3c3hjeHVCMFJJdFhS?=
 =?utf-8?B?dG0xYjlkVVJvQ3B1dk9ySDVYQm9TR0tGRWdGT05WLzgvQmhteW5SNXJOamdV?=
 =?utf-8?B?bVRxS2NMcks3eElwNVNQQWdSRWcyZFlabjl4YTg4SWUxb3RUTkx4QWNzZEtH?=
 =?utf-8?B?SEdpa2VNYU1MZjFxMk05YWxLT1RSMm1FeGxRZjBuZjVoMVFTL0Q1TXIyNDl1?=
 =?utf-8?B?NkRnTTZhRWtjMlNGK2psWmxRV2pVTlJKVGJxeklOZ2dTdFlXdEpBTWVPTDl1?=
 =?utf-8?B?U0oyVWNwQWtlYWRLQU9DL2VEelVaMDZSekwyTXpMUU1YWjBPTTdSUnhYQ1dq?=
 =?utf-8?B?d2tLREhncm1CUEJMa1gybWlodE95WmxPS2IvSUFQckthbFRDZEVERE9IS2JD?=
 =?utf-8?B?ZVMvYy85Z01VSmRhcDZHdHBqa2FzTThnWWFpaXlQemtZM1dRMk9CTUcrYlU2?=
 =?utf-8?B?enNNVUlvakNSRnZ4djdNNFIwdTVmNlBZQkxrOW15NnhIUDA0L0gwRVZLbU1T?=
 =?utf-8?B?MS9vTHY3NmswQWtsNWM5OHU2TW5GM0JPdlc0R01QQ2lSN2FMQURZMDJUWWhl?=
 =?utf-8?B?SzlneWw3Lzh5WnJGb1JNMFpYRnJsaGF1RHVXdGdhVjBCeXB5d0ZOOThYRCs4?=
 =?utf-8?B?VTJsUDl6R2dHSmk4b0FGZWdMREFqMEExdlQrV24xREEzNTBUb2NhN0VhNUlU?=
 =?utf-8?B?ZFpIeS9oTFRwb1g3NWhqY3dHZVZ2WEV3dFF1K3B6UnRXMElyeHdWZE44MlRh?=
 =?utf-8?B?YlFmaHoybWdvcFBuTEtwQ28xZWViREtmaHdOTmQ0czUzbWo1YTY4SWhyMnRK?=
 =?utf-8?B?cHJIMmxtWE1PTUdKV2VMLzIrdWR0RkdyRmZnbjEwZUlGd2thMGpTaTFUNnpj?=
 =?utf-8?B?WisybzR0RlVzaG9oVVJnNHdsTEJJRGVGZ3R1aGxwbGQ4M2FFdURmWGpLQTND?=
 =?utf-8?B?NUhJL3Fab01yKzJUQU9QclRWVlZpMVZSc2dveDErNDlMbmlvcnRkeEx1S0ZT?=
 =?utf-8?B?ckd2Ymc2cVhZZFY0TmorTEYvbHhnNCtWbkdVNnBpc2lxUTN6ZG5UaGw1VUVP?=
 =?utf-8?B?bE52K2tJeEROTEJ1VDlIbVFtVlRKSkQzL1hMRU5UN085N1VJdnFwQ1loaWVF?=
 =?utf-8?Q?V4qrcEl0ZBrQcvimjc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1pGaHM5MnFjUkZ4d21VcVhOcnlOTmN4Yno3RFFCMVpYYTBLRlQxUmZGOUhu?=
 =?utf-8?B?amxhOVN4V3FYL2ExQWhrZTlMWjlNc0RQSTVtNTFEakFFRTVBU0VWUG95a1hN?=
 =?utf-8?B?ZVNJN0JlS0wralBDVlRROUp4WWNiK092ci9kdS96WjFkbnRHVlp5Nkx2TzhQ?=
 =?utf-8?B?L1Zmb1lsR1V0MUlYUFhMaTJ5OVBLejUvSnFHQjRWT1hRSS9xSEJ6dWxLeElR?=
 =?utf-8?B?NnJldlRPM2o4bUJ5bFNXZHlpeWNQcEVWcS94M3lzRUhvKzB2elRCSHlrTWlB?=
 =?utf-8?B?T1BmRXVUWE9WK2tiTUN3dEljSTJHdE5vWGxZRkJwb3djR0E5aHV4b2tNcVNM?=
 =?utf-8?B?Yk54UHEyeWVSQWd0b1d0QjJkQ3VIMWpMKzhSTStMQmRTb1lSVnpnZCtQZ3Zv?=
 =?utf-8?B?OEVoV1VvaTRaQm44NEs1dGhzVG5ETlRYQmU4L2UyaGpva0x4b01WcnpPdU0y?=
 =?utf-8?B?bWN2bE1PYVRYdG5ERjF5S1BnZFV5em9pWnFyUW53anV1SXU2NSs0TUJzcExT?=
 =?utf-8?B?Q29CUHRlRlNUUDBobzIvNUI3OFVvVU5iaDNNQW5wQmVjZDFTcEs0NzVHZUEx?=
 =?utf-8?B?MksxVStFclk5c2U5eENwZ0xweWx4dDllWDc4amQwOG9KMG1EQnNKeWVlb09q?=
 =?utf-8?B?b1VkeUJqOFVINUtkYmsxMjZlc1lXZGJ4ZDV6c2tPbGRIYUorS0lBUVNpc09O?=
 =?utf-8?B?M2dlL1dYSFh6MXUwOE1wbllBanFwRDM4Nk0vdnZFY0xkOHd3bllHamdkVy9B?=
 =?utf-8?B?WDVlTW9aR2xjQmhDa1ZIRWhGcFlqWDk5dGRUbUorS080Nkw2TEFQUm5neVll?=
 =?utf-8?B?NCtrVjNnclhQdWpsM2dTVnF0ZFkvemFwU0RUZlJPWE5LeFh0b290N2hmVDl4?=
 =?utf-8?B?d2pKUHZrK1pPdnlodDdJbTNXcG94eHJBVEtKcXhRTWVjMW9Vd3BwdFUxWGtI?=
 =?utf-8?B?bmc5TlpxK0tTaXFTNUowNjd2bUxWOERNakNxQmExek1lV1N5MXdId04wVkoz?=
 =?utf-8?B?YUdKdXUvdy9jWldmTXUvSTN5K1RNYTl4N0Q3VU9TUC9KSlovSjJ6ejhQN2VB?=
 =?utf-8?B?cGxzOTNhYkJxNkgvQWxUdHk4clpvTlZkVnJTaXd0R0wxV1p1Y09uMEVpVnp0?=
 =?utf-8?B?Q2xpT3I4NTBZSWxVWjQyZnpsVmtoNFhLUEtuUlE2R2d2dm02LzJSTTQ5UHNt?=
 =?utf-8?B?d2wxUTZiTkc2RjVPazhDbTNTdzBuak0xUDYxamVYQTIyazU5KzFzMHpkbS9k?=
 =?utf-8?B?N0ZZY1gwSlM4dUltRXJ5bURvdnpXT1VERmFTMjh4aHo3UzV0ajd2cU5MRlJq?=
 =?utf-8?B?WjZWSTJRaTI5R1lhSXQ0RUFHUEFPd3JGZjlmaytzRG5KV2ppTjQ0YTRlMEVx?=
 =?utf-8?B?aVpNS0pUOVNPQWRKT2dkQ3c1RW9XR25wcSt0R2hINThPaTBBck4rL1ZLNEFo?=
 =?utf-8?B?cEJRQ1lmb3hwU1dFamFwRVE3VWlaVDRxeTJYcnh4L0RzVkhtR1o3UEZHVVpx?=
 =?utf-8?B?NGY0ZktBWnA0cGk3MXJQUzg1RDlTUm5RVVhRNGtOZGhabHZnNmd2bzhPYVhX?=
 =?utf-8?B?SFUxZkxOL1I1ZnlJREFiUHFQS2pVOXhSWXRKYWcweGZXNkV6MUJSVkVMUGF2?=
 =?utf-8?B?VFE5cXp5eis0NENIWFJRcjMxbHFoaFNWdVJGU296OWJzVStEa2VielBUTVJF?=
 =?utf-8?B?NDRKd0FpSC9PUFNXVldPRDhtdGU4QU14MXdRWlZrcDVhWUIvL1gzTzVlalVx?=
 =?utf-8?B?eCt3MVE2TDFLbzgwWTVER2FJRk85MmRWaHhsUjA1Yzh4c3lYdXp4YUVlL2Ji?=
 =?utf-8?B?TG9GMTF5YURlbG5JdmNKTEpJcmZIRUU0dUM4VURIaURBS2JGU1RBSmxNTGxz?=
 =?utf-8?B?c1NvYWFSR0dQMENJYWprcHg0UHJSSFBuMExrZVpYbTNpRnZlUGY0VndLd0o0?=
 =?utf-8?B?TEtJaGYvZ0FyeEw4NmF1dXl2WEZKUjU1QXRZWDh0ZlBFY3JYeGFKZWZVeDJl?=
 =?utf-8?B?cFV3VzB0dFNDVkE2Q3lTbU1kMTBnY3VSZUxhYi9RNVhndmFqY2Iyczg0NGpY?=
 =?utf-8?B?bzAwRmcrWGpIdUdmU2tiNHR4NjJYcEJZbndTRGUzRld2bnhXYklSUWxVR2Rq?=
 =?utf-8?B?R2ZpTjVRVE1GMTFBTnE2YmUvaWVPMmdud3hZZTJFdy9XbXpWVmlFK3VvNGoy?=
 =?utf-8?Q?MYYtDmMQKy7TeEiwNY4lHUs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0bcc90-2eb2-4ff3-05cc-08dd1ab622ff
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:06:13.1125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9u3EaVHBAd/Z4z+pUSe3Yv40cyiy0bdoO0f6ArnEx/kpBOyyRZQ/5eJK7kfCw+0d2o/yT1U0pKMFlbhFC/JcK+9xD4yp9sh+HnQuB7d5m70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6085

On 2024-12-12 06:09, Gabriele Monaco wrote:
> 
> On Wed, 2024-12-11 at 12:07 -0500, Mathieu Desnoyers wrote:
>>> Here's where I'm in doubt, is a compact map more desirable than
>>> reusing
>>> the same mm_cids for cache locality?
>>
>> This is a tradeoff between:
>>
>> A) Preserving cache locality after a transition from many threads to
>> few
>>      threads, or after reducing the hamming weight of the allowed cpu
>> mask.
>>
>> B) Making the mm_cid guarantees wrt nr threads and allowed cpu mask
>> easy
>>      to document and understand.
>>
>> C) Allowing applications to eventually react to mm_cid compaction
>> after
>>      reduction of the nr threads or allowed cpu mask, making the
>> tracking
>>      of mm_cid compaction easier by shrinking it back towards 0 or
>> not.
>>
>> D) Making sure applications that periodically reduce and then
>> increase
>>      again the nr threads or allowed cpu mask still benefit from good
>>      cache locality with mm_cid.
>>
>>
>>> If not, should we perhaps ignore the recent_cid if it's larger than
>>> the
>>> map weight?
>>> It seems the only way the recent_cid is unset is with migrations,
>>> but
>>> I'm not sure if forcing one would make the test vain as the cid
>>> could
>>> be dropped outside of task_mm_cid_work.
>>>
>>> What do you think?
>>
>> Can you try this patch ? (compile-tested only)
>>
>> commit 500649e03c5c28443f431829732c580750657326
>> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Date:   Wed Dec 11 11:53:01 2024 -0500
>>
>>       sched: shrink mm_cid allocation with nr thread/affinity
>>
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 76f5f53a645f..b92e79770a93 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -3657,10 +3657,24 @@ static inline int __mm_cid_try_get(struct
>> task_struct *t, struct mm_struct *mm)
>>    {
>>     struct cpumask *cidmask = mm_cidmask(mm);
>>     struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
>> - int cid = __this_cpu_read(pcpu_cid->recent_cid);
>> + int cid, max_nr_cid, allowed_max_nr_cid;
>>    
>> + /*
>> + * After shrinking the number of threads or reducing the number
>> + * of allowed cpus, reduce the value of max_nr_cid so expansion
>> + * of cid allocation will preserve cache locality if the number
>> + * of threads or allowed cpus increase again.
>> + */
>> + max_nr_cid = atomic_read(&mm->max_nr_cid);
>> + while ((allowed_max_nr_cid = min_t(int, READ_ONCE(mm-
>>> nr_cpus_allowed), atomic_read(&mm->mm_users))),
>> + max_nr_cid > allowed_max_nr_cid) {
>> + if (atomic_try_cmpxchg(&mm->max_nr_cid, &max_nr_cid,
>> allowed_max_nr_cid))
>> + break;
>> + }
>>     /* Try to re-use recent cid. This improves cache locality. */
>> - if (!mm_cid_is_unset(cid) && !cpumask_test_and_set_cpu(cid,
>> cidmask))
>> + cid = __this_cpu_read(pcpu_cid->recent_cid);
>> + if (!mm_cid_is_unset(cid) && cid < max_nr_cid &&
>> +     !cpumask_test_and_set_cpu(cid, cidmask))
>>     return cid;
>>     /*
>>     * Expand cid allocation if the maximum number of concurrency
>> @@ -3668,12 +3682,11 @@ static inline int __mm_cid_try_get(struct
>> task_struct *t, struct mm_struct *mm)
>>     * and number of threads. Expanding cid allocation as much as
>>     * possible improves cache locality.
>>     */
>> - cid = atomic_read(&mm->max_nr_cid);
>> - while (cid < READ_ONCE(mm->nr_cpus_allowed) && cid <
>> atomic_read(&mm->mm_users)) {
>> - if (!atomic_try_cmpxchg(&mm->max_nr_cid, &cid, cid + 1))
>> + while (max_nr_cid < allowed_max_nr_cid) {
>> + if (!atomic_try_cmpxchg(&mm->max_nr_cid, &max_nr_cid, max_nr_cid +
>> 1))
>>     continue;
>> - if (!cpumask_test_and_set_cpu(cid, cidmask))
>> - return cid;
>> + if (!cpumask_test_and_set_cpu(max_nr_cid, cidmask))
>> + return max_nr_cid;
>>     }
>>     /*
>>     * Find the first available concurrency id.
> 
> Thanks for the patch, it seems much more robust than my simple
> condition on the weight. It passes the test (both versions) we
> previously discussed and doesn't seem to interfere with the general
> rseq functionality as checked by the other selftests.

Great!

> I'm not sure if I should run more tests on this one.

The other thing I'd be interested in is to see if those
patches introduce any performance regression (e.g. the
will-it-scale tests).

If you have spare cycles to try this out, that would be good,
else we can let the test bots complain.

> I will come up with a V2 shortly and attach some performance
> evaluations.

OK

> 
> Do you want to keep your patch separate or do I submit it together with
> V2?

Let me prepare a proper patch with commit message, and then feel
free to add it into your series, so it benefits from your testing.

Thanks,

Mathieu

> 
> Thanks,
> Gabriele
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com



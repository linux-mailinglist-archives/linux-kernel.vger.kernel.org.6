Return-Path: <linux-kernel+bounces-554604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47314A59A62
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96BA3AAB33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2403022F164;
	Mon, 10 Mar 2025 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jc0Jcr0P"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021110.outbound.protection.outlook.com [40.107.192.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6388B1B3934
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621832; cv=fail; b=pBMk8/GZQGDIPdddNwjtFPOsTbXKMY90Cbon39m0gnO+NLHiV3qt1ruz+PKZ6vy8oZAx4ZKrng3umZ158APeVF5bNG3PUTBCE5/iY+PYDbe7f8RAuDxctU6ULDNqSeUPilhhwMjmcWRkgfaVq56yXJR0ExJMpLj2+r1vhyvQK9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621832; c=relaxed/simple;
	bh=BNUV2mS6eUgJ3rGyn8taxIdmRUaIXTUb1V0Kj1jQ37A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WXdc70T4ENGvK7qtQ2VDh6w8H+/enlaLTlC1+JUeYNZ+bvq2V99zBbc3LLtQdLzja54boa+ubGRQC4CEeXXavL5gimqj+HjMCKrvIWVk6Ukgaa9/M4Qn6qcwwXJxkItaqvi+BnCJhyhp6rJuH21CDRlBhdH70UbniqKMQaOOtfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jc0Jcr0P; arc=fail smtp.client-ip=40.107.192.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmDkbAJq7TluAu8jBAZvWHrGFsgZ0wSI9X0IeatizetTDgZTE1+UFvJAgjzXcSvwnNRwgDdfgeIHwJqkMMKG1jHsYiws4ocaKLA9gCFfkQ5t5B39ZDZQlUCFdGzfGNtpWZoqVmYIrJepM2YIJNqjacCPRtXxS9S4y0Ik4/Dl314jFwHOcWeFDxV00i36BuGAB4I45Iyzh3VX8wrmkxPmbyQRmEIz+JIkCZdT2OtKBfOpxq5vuDOvbIfQ3/c+y53v94UEzgQ5KFydwsE1+Si7fAc4uXIlEe7LBywQpfzG4ZcfaZnnU4ZaXyW7/9RRphbN6s93ZX9CRou4bGheo88pfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yecAxySxOFswYBGnQ7/NvUNugZ9cvm5Xvj9fSooe/9A=;
 b=k8DXadeO7HmvPvm3yt5jJQgMcdKQ+THUUYEhRHOEAif7cduQGz8xA3IKifqq9IQdHVueIQ9bYZER93dSpDCHxLOOl74TjXWz8cLvJPJcXPSC4w9x+dF6o4WHstDp7UauVcQ3WaqNrTLGKFxKj7Ml/93DRl8ZDvUJMj0MKEQ77oBjZHS/Q2a1rbL+zidNgT4yqAt5wjF82nPz3gnzbhq8m0V3jgmxEAuO4hoFHGNllPZgchyEaxVAPAU80XGPR1oKl/AMuXITcT8gEoFkEJJYqWMwNtOKVItrtq1tYkGRjb9++wwatw99LY1hGvSUEazUDFUfF/5wTr36ylkDFrOBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yecAxySxOFswYBGnQ7/NvUNugZ9cvm5Xvj9fSooe/9A=;
 b=jc0Jcr0PKA3ncW1zxiBl37naQxyYK+gs6SYK4SrIcuBrGalA+e4FmXdTttMC+C8VcR9C4g19VN+sP++N3R6f+VXpNMVqFrTwXXW/l01Wm3U2oPSqG33d93jOMvYGMb2JlYhbhegjI7iO3X+b6SBokEZHdK0N2cxYt3DBdk4CwKBrnOOfOxFhMyuRf7klpNHyIU2ch5NhVulyhm8gKh7MVYeO7lLDD6YT+OCTKwG/s2l68M9jQ8gX0SF3RplVHgLbF/t/kRXfPj8a6DusrHa5cXeUf5qZ9koEYfG4Whf701w8o+sPbWQZin/vxETClMJgt3+mciw2+wVe4aR7vneSfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT3PR01MB9978.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 15:50:25 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 15:50:24 +0000
Message-ID: <31fa089d-1f55-4bc7-9323-389fda4cadfa@efficios.com>
Date: Mon, 10 Mar 2025 11:50:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] sched: Move task_mm_cid_work to mm work_struct
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Ingo Molnar <mingo@redhat.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-mm@kvack.org
References: <20250227153329.672079-1-gmonaco@redhat.com>
 <20250227153329.672079-3-gmonaco@redhat.com>
 <1c161066bcbc916ae9d97e7d1753ee12511da085.camel@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <1c161066bcbc916ae9d97e7d1753ee12511da085.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0040.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::24) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT3PR01MB9978:EE_
X-MS-Office365-Filtering-Correlation-Id: 112b7110-1cd3-4ed2-8f2a-08dd5feb45ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGZSSCtKUzJzYWZHNVhYa1BpaXExZklLeWRBZDUycUxDZE84VW5oVVVzN0Ir?=
 =?utf-8?B?OWwvejcvMldKRzgzdTJ0K29qcnluVDUyVEpKSk82YzZMdk5CSXh1dDhYSnZM?=
 =?utf-8?B?aW1hM0ZnS0o3R211R3gwdEltVzErcnNyL0pZZ2NUZmR4THVlUklPWVEzRWRz?=
 =?utf-8?B?NmJXTURhOTY2TFdPbVlMamwrQzJpV1B6WmpqWEtNdDFWYkdDcFZyL0M5K1pC?=
 =?utf-8?B?MWY1em9LdHFZYndRRy94T2REdGwyUG94M05LLzNZWHlMY2tsK1RzbUVvWk52?=
 =?utf-8?B?UnluTXVIMXRTNW52UElLbXhMYlFHZW9WNldoM0FnV25nZkFjZEZQL25uempt?=
 =?utf-8?B?MG1ONjJGNTJwMmgyTXh2L0pFR0NpOExqRVVzV2gzbm9Gc0NsRU1MbHNJNTVx?=
 =?utf-8?B?NExzc0puK1U4RTc4UFd6RkxOOWExRzA2SWI2RmExK0tObU1uKzFVc2FneVcy?=
 =?utf-8?B?YUVWWGpXWXhOYmpzWEZ1YnpDTXZWYnBTdEZFSGFHbVQ5cHNtZ2tsbTZGOVN4?=
 =?utf-8?B?eFB0MVJ4ZGtmRlhPb0dMYnNZVGt1dVd0UUl4MW83VmZxeFhCKzNjRityRitX?=
 =?utf-8?B?YnVUeXRBNFhBSk9paWhiQkZMY1U1Nk9udlVaUkRnMW1rM09LTkFsLzlFcVlq?=
 =?utf-8?B?Q2piWDNCNU9wajlRVUZnbEthMzhjWDRsaFJVVUtBczBzcDVwUTN3RVI4anR2?=
 =?utf-8?B?eE9rS3dQZENVQld2WGdSbS9QRFhqSWJUZmc4aVJ3dlg4bjVTalJPeE1ubmd3?=
 =?utf-8?B?R0NERTc3TmdEOCtJY3RyN3NHTmM3ZUJKalVvMmpIZEpGZWR5L2pwL2RUMVQr?=
 =?utf-8?B?dkhvUGtESDBlM2d2Q3hQMFdrc3Z2UHhPeEhQSzAwNWRCOG10SUlueEhMcjRB?=
 =?utf-8?B?a1J6TzIzUXh3UTZFVGp2ZkNDYm9abmZMbUZuTUVZb09iNUxzbHJVaGRxWUpM?=
 =?utf-8?B?VVV0SEpmV2RhOVg5REptY3k0SXBJMVdVRy85cjk2bzJCWXdTWTFNbVlZdE00?=
 =?utf-8?B?M2QvYXk1TDJhYk1qUkMwWFJMcGlNdHE3MWtmT0Mxb0x1YXppQkZFTUE0eHZZ?=
 =?utf-8?B?b2RZRkUvazlTSnFNQys1UFAwblVRRmhTQVdkckJVZEhNR2M0WmUzU0F2RGpR?=
 =?utf-8?B?cC8rNythcjZoVjdTMDhsejVzQnFTVUpmMVkvcDlCZ2RzT3RFb05CY3AyZm1u?=
 =?utf-8?B?dkVuUDBkWVVXUzRsNWc0MVhjNE1FRmlwK292Z1B0RlFJd3VzaXJmbTI1disy?=
 =?utf-8?B?NVdPU2JRbWFEU3YzUlJ6K0ZHVGIyL2hiaUJsbXFNbUt6QUtQMHQ0SXRQZFpP?=
 =?utf-8?B?TmkxR044dHVmZnNZVU5qWmJRVGRKdFcwNEdrUjZCYVJnS3ExVTI2aWRwak1B?=
 =?utf-8?B?aHhZbEJqblZ5bUhNSTcwaEtWZVJJeHhTdkZNRnFXbVYyek02eVRvR1BFWTk1?=
 =?utf-8?B?Z3ovck1KR0QrR0svS1FEK0c5cnM5RDhlN1A4WlFNOXN5Uk82bm5XSitUd3BM?=
 =?utf-8?B?ZE83SjgySFcvUGxZOVBueE9uaEZmbHlicmkvSVFEQ0lNVkxQYmx3b1pOT1RF?=
 =?utf-8?B?SjlkMFFLQkt3M04yeWZQYVNCTUJKTkR4RlNFMjhvSE1HWjIzOHo3NFl4SVJT?=
 =?utf-8?B?anM4Nmp6Z2tCZUpFY1NSRWtybzRyNzQ5K2pUQUxKU1diWnc4aUhJVzRGTldq?=
 =?utf-8?B?ZUJNRlZDd0trMEpla01yOCtQMkUwd2YyTTZwV28zdG95c1d6YUY4TzV6V3Zm?=
 =?utf-8?Q?NMXwJdk6NloOaln6Kx5GpvpeACISS6X8eev24t9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V25SVlkrK0RuZDFEN3V5WkluSXZxL0JOQXpVcVpGUVFDNWR6Sk9UczZTa3or?=
 =?utf-8?B?MWNoWGEzbmRLMENQcW10RHJtMUo0NWdLcytlV2w5ZVorMnZkYk9HRWphWHZi?=
 =?utf-8?B?MDFPcXJjRWZSRkJpcFZBUVRQNktDNE55KzJ1MXdNemt1WkRxQmlreldBWEcr?=
 =?utf-8?B?WTh5UGZCazZRVFI5VkJQbFJXWk9xakxEMTNyWjFjT3FNZXFYTW9idHhyc3BS?=
 =?utf-8?B?OHozdW9RK2lKczJ0OE4zd3ZEeXVmdnVoVnZTNnB2M0pIdTFVVkNwQklrd2V1?=
 =?utf-8?B?N2I0N0J0OHZPS1NxU2JZeGNWSU9pZml2UXRzbjdQTUU3NlptSStXdTVOdkNF?=
 =?utf-8?B?bkZWQjBjUHhOd1g0Y1B4N3dFc05WdVRkaU5JVjNqMDlSeXUvZjRkUktGalFY?=
 =?utf-8?B?WWUzZDFOZmVGY2VWdk9WSTlkRm5aSHRhQ2NvcWE4ZDRVMmpobk5FWDcyK0d2?=
 =?utf-8?B?cjVWVkhFL2Z2dXN5WVZkbHRsOGpObUtCT1V1aCs2T2hMSzlNSnFZSHhxeUhC?=
 =?utf-8?B?VUJCalNCalVrUXZaS3gvT21uaU1QWnVYQUM5N0ZwVXdWQmMyM1NPK2JhelpJ?=
 =?utf-8?B?S0tneHBqT2k0RmpTaUlKQmRXNU1ROThTK1RNeGZ0K1VlU2MxZVR3cEVSZVR4?=
 =?utf-8?B?blIvekZlcEJxaDhDNTFDMm8xNktCWGYxQWNVWmNMSnpCcVk1bXBIVG91eEdZ?=
 =?utf-8?B?SU9aa0IxTGczQkVPUFBpVFlwU2JCZGFERjBsaFJzcUFmdmIyZFoyMlo1NjBm?=
 =?utf-8?B?MVVNWTdPRXMxUjYyQmRvMzRJNnZTSEdLZzZ6Nndhd2tlclh3M0RpcnZrYmpw?=
 =?utf-8?B?c0dSeVF3Z1NQK2JVdmk2aEJzYXVDWmZEc1lhMFd3Zjd3SFpXRUJNNkhIZFIw?=
 =?utf-8?B?Nm1kbkhtN0ZkakRlZGVuNWpqeExoQ25reWFMelFJYWJ4MWEvRDhZQ3VLdnpQ?=
 =?utf-8?B?RnJxb3ZxVHFKRmpDVjhoaGpwcEhiaTFwWFJ2T0VjT0tLWFFOYStoYkJVdkw5?=
 =?utf-8?B?Q3pPL20vRlFTcjFRbjA1clhOY0N5ODRKL2hURDVxZ1FONGVtRDZtR1EwdExu?=
 =?utf-8?B?TVQzUHJPRjBYSnFTandITDFsbE9mbTNjcGp4cW52aGh4L3lFS0pKVjc1ZVBx?=
 =?utf-8?B?ZlRXeUZ0ald4WU05QURnQTRGb0YwRUg2bDhEUmExdmJvelJpTndLRWJidEcv?=
 =?utf-8?B?dGtMUDRqTTkyWXBoVWRIRFB1eklMS05UTUR2ejZDNmdpQ2g4KzlucWNjbmpa?=
 =?utf-8?B?WUM5R3hMSXNkRERncXA2UVFIT1NSZVM5MlE2U0pBY1Bja2NQYW9HNWVEdEpL?=
 =?utf-8?B?ZGIwcTRxOGhSQWVRZGRWSmVrTHloOFNyNlpmVEQ5SDJmV25Yem1oVmNuRWNk?=
 =?utf-8?B?M0laUzNUc1RkL2YrekRTNno4UWRHUzR5aE9qQkpMMEc5a21oOFpIZ2YyQ1Rr?=
 =?utf-8?B?bVRYOHJFZHIva0tJaDJvdy9Sb2Y1N3ByRnNEZGRpcTFKZHlWN0RNcnVPVmNJ?=
 =?utf-8?B?enJjM3VqSituek55eTByK2RUTGw2ek5nMU9Ka1IydHhoN2JPL2hpZStTRnE4?=
 =?utf-8?B?QVJzWHNaU0VDMUR6b1RoVUUvYnNsRVdYemd1bC8yWUxwdlI2OHp4alVsaFVB?=
 =?utf-8?B?TGJMbGZhcWd5cEVNdkdFWTZCVkJUaVY1TmY4VjRkWWJVVGdrZTd2akU2ZmJE?=
 =?utf-8?B?Nmt3ZCtudWNvMGNTZUJiRFRnMEQ0WWxrUHBQNlU0MHBXTkxIYy90ZjZvWGRC?=
 =?utf-8?B?cDRGbEsyTGI0dGtIR0FPcXUxU29DOUs0bXNZQS9KbHIrSUpuTnA1WG40Rmp4?=
 =?utf-8?B?aXZNSzRLWlVoODA1NWZQVWpaZy9lTEcycStPYkVCOFVlN3pCZW15RFZ2b2Uw?=
 =?utf-8?B?YkFTcUpnU2drdThxeklZQWFyVXBNVkVzOVJqMUlNdWhOU2RsME9JbHpZQy80?=
 =?utf-8?B?dGNaTmtOTDBZeXFrVk8xK3NHajVtWk5Zc3dpei9pRDFrL2FuYVQxSnlkWlpq?=
 =?utf-8?B?RGs5V09FYnh2Vi9ySDNEdEg0d3pWck5jM1dEU0YwUHUreGlaVXN6OEZLZnp5?=
 =?utf-8?B?YXduR0dyeWFtNTBUK2RYb2lOQXYyajF0czJZZW9DeDNXNDV1bnlObDIyTzRa?=
 =?utf-8?B?cEh0eUtzN0w0bFl6VXZnT2FCeFcwbWNLcmhBR1FjMHNoYmVNY2xQMDFneHJL?=
 =?utf-8?Q?6TKe3E+raeWOYNUDJFD8oAE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112b7110-1cd3-4ed2-8f2a-08dd5feb45ae
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:50:24.8936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QICBlkH+PqCF4WDfjppbQzGzAYgptRaz0qSjOAp3M94AH0/cv7GpF85aZ+4rnYswNRYWcMRn02pIuEYvtYbblUuKZXSszN6da81I5xeNcFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9978

On 2025-03-10 10:46, Gabriele Monaco wrote:
> On Thu, 2025-02-27 at 16:33 +0100, Gabriele Monaco wrote:
>> Currently, the task_mm_cid_work function is called in a task work
>> triggered by a scheduler tick to frequently compact the mm_cids of
>> each
>> process. This can delay the execution of the corresponding thread for
>> the entire duration of the function, negatively affecting the
>> response
>> in case of real time tasks. In practice, we observe task_mm_cid_work
>> increasing the latency of 30-35us on a 128 cores system, this order
>> of
>> magnitude is meaningful under PREEMPT_RT.
>>
>> Run the task_mm_cid_work in a new work_struct connected to the
>> mm_struct rather than in the task context before returning to
>> userspace.
>>
>> This work_struct is initialised with the mm and disabled before
>> freeing
>> it. The queuing of the work happens while returning to userspace in
>> __rseq_handle_notify_resume, maintaining the checks to avoid running
>> more frequently than MM_CID_SCAN_DELAY.
>> To make sure this happens predictably also on long running tasks, we
>> trigger a call to __rseq_handle_notify_resume also from the scheduler
>> tick if the runtime exceeded a 100ms threshold.
>> [...]
>>
>> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by
>> mm_cid")
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> Is this patch missing anything?
> 
> I refactored a bit to have it build in configurations without RSEQ
> and/or MM_CID (which was failing v10)

Found a small nit. Please fix and resend with my reviewed-by, and
that version will be ready for inclusion.

Thanks!

Mathieu


> 
> Thanks,
> Gabriele
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


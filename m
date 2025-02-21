Return-Path: <linux-kernel+bounces-526694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA921A40213
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B754D19E0C04
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F2725291B;
	Fri, 21 Feb 2025 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gU1QzXhd"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020076.outbound.protection.outlook.com [52.101.189.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F010202F79
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173786; cv=fail; b=uauvBXQ84+nHHaHf7mZ5+FqyirBI2jaPTvcTL+lcJ4DSsFvSB68T/cayBFfaUGdiNJo/K+5hPfHFqf/dJyNlHBQjf9rg0lA3MGS1CGNM+BnvFdcutRmz66eDQXDuaog53RDiim1dSCyNwM/f5Ux1sWUzjzWmeg5meGLYekE+FjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173786; c=relaxed/simple;
	bh=X1swAR6qnyDf0iCEKnNPI+ECe/l3iGUEGB3GqWGgl0w=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q1OjZwM8ut1yK4aSFHdy6rhpi9XmfE5lhJN3kbWm98iWituPh7sNQjCeBcBkh43NVwmVmcTfMZKo1M3wublWE0PEWqo0U5r2wAt5ImggOyXMOd1F1xaa0WknfRhZ9KJwUlr3Tf2hZl3wffu/+XckNt2+vVH8MCNApZ2mZ+J0iBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=gU1QzXhd; arc=fail smtp.client-ip=52.101.189.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4ud50NHsnYBWNr53RpVQI4CIqTKTkHb9kKFkxut0mKU80ghbdHVOnuEABJETNoQxr0CXa7ttv0KPFREbGZ5v10dFvsLYoqx8OQj6wi5rEwxez9dBtM1WYCFT1QyDFW1BgJgtOaj+kXMQFTXiWwW1YOSncHfwTSpzNw6Vm+m1vGqbkWAdegkw3DL4FdlyAyKSCx98G2wJ32p8nFdbeDNi4q9ulAehS96VKfe1IMro5ZSBbTZWoxoEftuGxQINZWHFYLqsnjuimMeF4dug05euDbyHPlWYbZpf0ePlzPkAPXZDl+2FCPSLA3ZMJmzV78Xe2FXOKXlWItl4NwYsVNHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SALpkj8S2D9VXdv+YQLCHfw8x8zwTIX8h8PIHpd/cgg=;
 b=NDdN6otP2hNeYjwHYeWr1fEI71xdmiOZdhbphSx6VjEo+KIYbDU1t3+I60arjBpcvI3IikvwCz3oAtpKC2qcQyJlMcIJaAe+wa89eV+guZZ5Zlr4F7HtX9fdUzelL/QKZNH++DO/C0nsJngCCpbWu+ESyGlvEunyvDruOznxLyPvOH27LNeYRz0MHz6iPpZrEEQ183eHEXzeg8tiD828y5iJNhT+GvRYjrg/3JhcfCA6YHgRURlassvDVUoFDkCv5E38Xgw/gQupap89XV8P1DHxZZTZ/Ndl9wzQ1TNPpHQPRXnBasDz5ogu5VMCh6TFgBdWBTQPWx8c/dWabcgMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SALpkj8S2D9VXdv+YQLCHfw8x8zwTIX8h8PIHpd/cgg=;
 b=gU1QzXhdrSphkIhWOeY3WWfaKO74hYymc7MsmdNEM4VX32jP/SOQKqDB5/UnmdB/eHBs6qih0fgewhtNArJXfNJpRuIDrehnjNdRUQpfGUqkN7TS3dSXcLf1qWdeG9ssQnXlC+K4q+g6w2Kebj5E2n9HSUFMptsWI1AqrBRueEtzVYjVkWo98eUWPMwvRx283KHTlXtqh/oJj7BpPHJroud2WhHjuzhUNHSA4bVVKjhAh6IHGQBzGy6J5HE4dBRYmOjxTaBOcvWSzcNKYoMsFFBG5l78tuGpodLHBVV0MbjXt7jpTX2AxDrG+2JtA6IzjAPsWB5Ece8WhO0RnxdZlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:52::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 21:36:16 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 21:36:16 +0000
Message-ID: <470ee918-59fb-4af8-b5c7-93077963b437@efficios.com>
Date: Fri, 21 Feb 2025 16:36:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dave Hansen <dave.hansen@intel.com>, Dmitry Vyukov <dvyukov@google.com>,
 peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <81d94ec3-16af-45a7-87c6-ef76570953f8@intel.com>
 <6ada635e-973d-4e32-ab47-1fda12ee7ce7@efficios.com>
 <90a36a64-8ea5-4ea1-965f-bcec604c7d5b@intel.com>
 <6ad30642-c3b5-4ab8-9ed6-1fa8c56a8995@efficios.com>
 <c793e1d0-e508-4cf5-a18b-29d30d5e401f@intel.com>
 <eb087edd-4ff5-40f8-afcb-e4d94fb2a7ba@efficios.com>
Content-Language: en-US
In-Reply-To: <eb087edd-4ff5-40f8-afcb-e4d94fb2a7ba@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0209.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c9b81d-061b-46a1-c069-08dd52bfc58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2h1ZWtwK3hsL0lsYTFQaHpFdzFqdTZPVVF3LzBFZStvVTdqa2JKVkRzWDZ3?=
 =?utf-8?B?RHgzVjVaaVk4Tm9HeHNBb0Vzb3JMQlMxV29KOEdpQUZnYU9ub0JMbHpyVDJw?=
 =?utf-8?B?TEdTYTVMZlI1aDNIMnVIQk42aHN4WFM2Q3BHUS9lR0FkTzdDbEtBcEJDMzZG?=
 =?utf-8?B?YVgzc09jd2Vsa1pvVm9yeUlDUkVBblF6c3lBYUg1SnV1eVBocVoyN3lqVkV3?=
 =?utf-8?B?eENMSCsyZCtmL1hXREhza0tCMXVhT3JSU20vK1FaVU5oWGtvSGR2ZExaTkN6?=
 =?utf-8?B?RkNZdTJTdGZmYm4xbzRvNjB4TXdDRmxRSHRRMkdJYnEzUUZFVlpKZmIyNERT?=
 =?utf-8?B?Q0wwK1Jtek15MEdCSk5SeEphZWlCZTNOWHZEZkMraUw2SjBZTklhKysxb0JV?=
 =?utf-8?B?OUtnN1dRdy94NXc5UFQ1emo1YkZUR042SW55MUJNV0x6NHZvR055blIxSXJP?=
 =?utf-8?B?Q2JuYk8zbHQvelJVQ2FCT3Y0TWxaZ2ZUVyt0OVQ0V2QwZmJrbSt3aTZWb25D?=
 =?utf-8?B?VUY5WlZ6OC83aExUQ1VaeTlEdEJLQmRQckQrbHFXVU9ITFQvN2RwMU1qVURM?=
 =?utf-8?B?dTExQ204bXRKTm42akZHWXIvMmRWeGFnbld2aG1nL1l4NE1TT3Q1K09lTzRJ?=
 =?utf-8?B?Qy9zV0xtWUY1YytzaUNrdHUwRTA5Z0wwZFUva0s0VlU0ZWtBTVFVVnNES3FH?=
 =?utf-8?B?SXBOK1d6MjRKMnlMZStoMjUvWmtXaExqV3VIS1dtc2d6MUwyQy9jWGZIeUU3?=
 =?utf-8?B?NEIzWE1sMTRTdksvZHZ3VDlseU95REVQVnFOeEd3clNZREE3RXk4MFk4clUv?=
 =?utf-8?B?bGJzbWZtTG5yLzFwL1BuOHlFNEZWSkVodThsbFNSL3kzN2FVZDg5NlYrOFZF?=
 =?utf-8?B?L0g0TngrWVF4cElndHBwQ2JUYm42QjhtSzVGUjZCMUdveTVNZStIYVZHRG4y?=
 =?utf-8?B?V01VM0FUREp5UWRwMm9jUEhUK3RYdmVjdld1NWc3Z1h2SlNtam0wLzhqNktV?=
 =?utf-8?B?bThoeExjUU5nSEVTRmNZaENKZmt6L29RaklyRy9OY3NBMGErR1g3REduL04z?=
 =?utf-8?B?bmNNYW9LSEQ1U2c1aHpTYUsrYkVwZ3RBeG9VN1dHVXNXQTJEUVNicW9ucnEy?=
 =?utf-8?B?cWoydUlFSXlVVlNtdWhGUzNNTythckE5cWJXdGJzMHJ6Nk03UGFxaWdKZVlJ?=
 =?utf-8?B?OUdrMGh1MUlNWndJRk82WWRtUWNubGorMW5mc1RhV1V3TDRvUWlXVWNlSWVX?=
 =?utf-8?B?TVhkR0J2Z1RGaWZCUUFnYUUxeWcwMVFrbHhwaTRVWlFBYVB3RzVCSEtpNy9F?=
 =?utf-8?B?KzhHWXJaenFTS0JNeFhKQnprTlRWSTVrWTlST1hVeGtZQ1YvQ1o0MGJFL1FJ?=
 =?utf-8?B?ZlhoYTAwVjZ2MGJ3V25MdDQ4dGlFQUdwQnFncytZUjhacUZ4czFWQnA4aGpF?=
 =?utf-8?B?clBTSGtMakszMmJQa2JNKzdVQXh1Q0NJaUJyV1N6YjlQeUJrekFLdm5DT3JY?=
 =?utf-8?B?VmZKWnRpZ2VCaDNsWndrZDQwQjhHdVdKWmd2VWkrT25aZ0phODU1WExIYkQ0?=
 =?utf-8?B?VjFNZnBlN3VtSlNPS0FqY3RWdXIxdDEvU0xXWVIwUTFkdUVBemNQQ3NaSzY0?=
 =?utf-8?B?YkFqUUhFamlBcERkZ2VBVW4zNGRyZzMyMUZJN3JkZTBNd0FWZUpqalAwZDBH?=
 =?utf-8?B?L0s0dHh6MmFUQXVrVkc2VnArS3RYM1lVcDVPbDZkR1B6UUE2aTZDS1BiL01y?=
 =?utf-8?B?WDJFbkRvN3drUk96UzlhY1gvUGpJcEZPTkw1Z2dxdExxc2c5WGlEaVZhNzhR?=
 =?utf-8?B?WUt1d3R1ekRhOHM4bmE0NU92UlgzV2p4bFpKdmJJZ3E1VWZZS0toaGVlcXYw?=
 =?utf-8?Q?/rAyTqcTJ9pLD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3loWUIyYVVicWlMVjY3VEY0QmVDQmd1SDM2cFFNV0FRcm9oUFFPL0hrR2dC?=
 =?utf-8?B?cXg5b2NUbmFTeHhhcUVKRllCcVZEVlhYaldMNUdwTnNGY1BCek5tbDZCZUVF?=
 =?utf-8?B?dWdhZEdBR3hac20wbmJvTWdwOCtVYVIwNVcrdW1DWmNOcVFkNy9kR3FXbTJK?=
 =?utf-8?B?ZVlhUmNaT1VmOVh0TU4wSXlRZUJ6NUpUU3dpcVJrUGY5ZHI3Qnlra0xiNHhD?=
 =?utf-8?B?cmNjcHh4NkVLL2EzS1prRHNtdmNIeEpNeWl5TUthMjVIOUJkTzJLaGlFVFR0?=
 =?utf-8?B?SWZVWmRVUVlWVm4xZzk4NjdMQmg5cERXQmxHc0twV1lqQStaQmUxQ2s0T2Nw?=
 =?utf-8?B?T3FUMjVGZjk1RWRQOGozTzMvSEVBMDY4eEE2UlhmNnlkY3BFdzc3aWNKa1M2?=
 =?utf-8?B?ZjRXc1VBRHdLaEYxamRwL25BNnJmWFBSMjNLMXlyUDNLZ1ZBaElUeUVGTHpU?=
 =?utf-8?B?SStWSWFLNnNsT2Njck1vVXVRT0tEYUdFZFJvZ1FieHdIdlpualRGelhJdXgr?=
 =?utf-8?B?YXBLY3VTdHlrcnJJQXQzbldTaHVpYTRicTBMejVKbmpkOUlLejRkREFzVFVn?=
 =?utf-8?B?cStranc3VFdBYngxMFBaVkhsZWMxMnpWTDdsNUhLaHhYVkxZUDQ5M0Y1NnFF?=
 =?utf-8?B?aTZ4ZXZJSVJCL2xFeTR6ZEJ2a1JraHd5Wm5tRzJuU3NoK3NubS9rdXJvTlhJ?=
 =?utf-8?B?MDBpWE9jTUlKVzdLOU11VjlncFh0dnpMcTIrQkpHQkdtdDlkZlUyYjZlZVNq?=
 =?utf-8?B?ekZvdnk1WVYxcy80L0xsTjc0UXgrM3BPbWkvc2MxTXFZS0FMNWxEdVRzTFdy?=
 =?utf-8?B?aUQ1emZHMTY2WGpTVzNEcmNHZGQ5YXUzUWdDWVBmdDZqZ3VvbnhvNmpFeHFM?=
 =?utf-8?B?SlJWVmIyTDlPQkFtQWVDS2swY1RUbUJLU2Nacmhnem5pbEVlZTNTMEpvcUZk?=
 =?utf-8?B?YnJ1VlRLK1RJbkYzdTJCOUJMQnhQV3JHVFY1K3VvV1Q3WFlvYjljalVwY1Ex?=
 =?utf-8?B?bjNBd0xUcERnaVlQQlZTd2dQeEtEdHlOWXlYTEMzV1lSL3V1RWZmQTZiMyts?=
 =?utf-8?B?OHlzMExtNDN5bVN5SUtEVFlnYWlyVHdzRHc1dkR1c1p2OG9vUng0L3Z3V3dV?=
 =?utf-8?B?U0hSOFllak9URGN4ZmJxTUxFeXBQSlNoYUZDTnNZaElGMlNNWlIzNnhvSWsx?=
 =?utf-8?B?QVdvcmduNG4rT3BUSDN0dHpoZWNZOVJ1QUZqMUV6bXpsa1NVZ09aeEdPUlMx?=
 =?utf-8?B?M3FtckRGdnFGOWtyS0xWbUZpTDFudmI0LzJlSkFGQlFZSkkxSmlKdnl6NE82?=
 =?utf-8?B?bHNTMm9kT3hYVko4cVJsd0NSczJYaFJEeUU0NDBML3BUWUtGdUw2Y25KYVlU?=
 =?utf-8?B?MWdQcUZheXRJdDJLTTNpYk0xWFcrU0dZVjhsZ1hEc3VhZ1R1Q2x3T0JZb3JF?=
 =?utf-8?B?cDU5VkRGWGZ4S2FibTZ4SUxocU1SL3poa3plY2RJSjRRa045enhSWWIxK2Vj?=
 =?utf-8?B?TGVteS9LcHllRVROU3FnOGtvcE9HeVlsbjJkYjRDeHhPVkxqZHJISmJDbSta?=
 =?utf-8?B?ZE9ZZXBpc3l4QXZIdXdDNk42VWVmSlhOakNRTlppbDlOZTVPNGhPcVFOVFNw?=
 =?utf-8?B?ZUUrK2ZkalVwZTBid2ZwS0xMRU5ISGlsMXR0aEhVeGk1UFkwOEE4VTcyWWI0?=
 =?utf-8?B?c0NBek5BY3ZjcXc2RGc0emFhYkJnQzM3bnZvZkd0NjZNN2lCOFh5dGs1bWZL?=
 =?utf-8?B?LzMvbGJYVHBCR0o1V080QkhmdjZEdHRMVFI5RGVQSmxVKzdQLzM4cFFndmxx?=
 =?utf-8?B?dHFGQTlTT1c2YmJ4Y05Kb3VMS2ZPelQ3NTVON1cwQWlyOGJ1MllOT091WDJI?=
 =?utf-8?B?UW9wTWxnMHlmT2Z4RjkzaXpkWXZDNU9IZ2M5QTZteVNGVDNKN1FSWWlOS1Zp?=
 =?utf-8?B?dlBSZlNldUp4d3dGRC91SkptUlpVcWpWR1Q3eTRvbEdGSVpjMGV5QUFiQi9J?=
 =?utf-8?B?aDRNTEdsdlRyZnFBdlQwT29JOFI4VzU3TkJoRWZyZlAzbkdMQjA4eE9IT3M2?=
 =?utf-8?B?NjJSWXV0UUdqRnhnckg0UTNlSmR2L2lRMVl0UzVMeVUzbmNqL2JXYXgrYjBM?=
 =?utf-8?B?Z1N3RVAydm8wK1FETW1VZXN1b2l6eUlXQXlDWGF4OGxqaFh0dFlBRHduSXcx?=
 =?utf-8?Q?ONwVaQ7fZCuaJGUvekRMXaA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c9b81d-061b-46a1-c069-08dd52bfc58d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:36:16.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRcwpAdxCFLcda73KN00xiOwtoK7v9eelSojtedRUmk3A4qMwSRXo480hehyJ30AsAEedcL2iUeuCJoX+frcCl72GDYGVzor2kkpyrbMA9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8175

On 2025-02-21 16:11, Mathieu Desnoyers wrote:
> On 2025-02-21 15:50, Dave Hansen wrote:
>> On 2/21/25 12:05, Mathieu Desnoyers wrote:
>>> On 2025-02-21 14:48, Dave Hansen wrote:
>>>> On 2/21/25 11:38, Mathieu Desnoyers wrote:
>>>>> I agree that switching to permissive key in the fast path would be
>>>>> simpler. AFAIU, the switch_to_permissive_pkey_reg() is only a pkey
>>>>> read when the key is already permissive.
>>>>
>>>> Unfortunately, on x86, PKRU is almost never in its permissive state. We
>>>> chose a policy (stored in the global init_pkru_value variable) that
>>>> allows R/W access to pkey 0, but disables access to everything else.
>>>> It's 0xfffffff5, IIRC.
>>>>
>>>> This ensures deny-by-default behavior and ensures that threads cloned
>>>> off long ago don't have a dangerous PKRU value for newly-allocated and
>>>> pkey-protected memory.
>>>>
>>>> If I had a time machine, it'd be interesting to go back and try to make
>>>> PKRU's default value be all 0's and also represent the logically most
>>>> restrictive value.
>>>
>>> Can we assume (or require) that struct rseq and struct rseq_cs reside in
>>> pkey-0 memory ?
>>
>> Maybe. Signal stacks are _practically_ only able to use pkey-0. You can
>> technically protect them with anything you want and then WRPKRU as the
>> first instruction once you hop into the signal handler (since
>> instruction fetches aren't affected by x86 pkeys), but I seriously doubt
>> anybody would go to the trouble.
> 
> And that would not work on arm64, AFAIU arm64 POR_EL0 also applies to
> instruction fetches, which somewhat prevents what can be done for signal
> handlers if the code intends to be portable.
> 
>>
>>> In that case, we could add something to the pkey API that switches to a
>>> permissive state only if pkey 0 cannot be accessed.
>>>
>>> Therefore it would only trigger a pkey read in the common case, and
>>> issue a pkey write only if pkey 0 is not accessible.
>> I think that's a sane policy. An rseq access can happen at any time
>> (from the app's perspective) so the access would theoretically be done
>> with a random PKRU value from a random point in the thread's lifetime.
>>
>> But it is a different policy that we've chosen with signals and "remote"
>> accesses, which is to just ignore pkeys entirely.
>>
>> I don't have a strong opinion. It's hard to balance performance and
>> consistency with the other ABI here.
> 
> Because the rseq return to userspace handler is called on every return
> to userspace after a task is scheduled back after preemption, I am
> concerned about the overhead that would be added by a WRPKRU on the
> fast-path, given that it acts as as barrier against speculation. Issuing
> WRPKRU only after checking that pkey-0 is not accessible appears to be
> moving the overhead to a much less common case.

Actually, we should distinguish between two accesses here:

A) loads/stores from/to struct rseq

B) loads from struct rseq_cs (only happens on rseq abort)

(A) is a fast-path executed on return to userspace after a preemption.
In order to make it fast, we could require that struct rseq is pkey-0
and typically skip any WRPKRU for this access when pkey-0 is already
accessible. We can add a check on rseq registration to make sure that
struct rseq is indeed pkey-0, and reject it with an error if not. This
should help make the ABI robust and less error-prone.

Now for (B), it's a slow path. When we observe that rseq->rseq_cs is
not NULL, we can simply override with a permissive pkey to make sure
the rseq_cs access will work.

Thoughts ?

Thanks,

Mathieu

> 
> And perhaps if we end up observing that for some reasons either the
> sigframe and/or "remote" pkey accesses really must use pkey-0 as well
> to work in real-life, then we could make them require pkey-0. That's
> of course assuming it would cause no observable ABI breakage.
> Once advantage here would be to speed up signal handler delivery.
> 
> I have no clue what a "remote" pkey access is. Is this the io_uring
> use-case ?
> 
> Thanks,
> 
> Mathieu
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


Return-Path: <linux-kernel+bounces-529901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C21D1A42C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5941893644
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4071F4164;
	Mon, 24 Feb 2025 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EJF8cdow"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022121.outbound.protection.outlook.com [40.107.193.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53CC1EDA0F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423878; cv=fail; b=W6XEN4NG+YXqGPJccFxypM7W5qlHlaAh9yoTR41X1JWJaT6E+ogkheuJO0pb8mS/1VpdAvuPAhIpj4CMB8hg+8zB4r6kJNzgNQseFaygVtjcxctFhmx39j2TEplK6O8EWMAhhAFZzEM8nR2QLwJ5c4C2Dd9zGnG5UrBRf5IOn1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423878; c=relaxed/simple;
	bh=0DMVhijYr55PcNEi8tm8PQx7ZjQxzURlUNIXyRcrCW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pnK2gmP+ZTpGER4ewB6iYzYcEp5nMuqox7y76RyaQzzh6sV7dGkhbC/RDw92oXWV6DZmkCgFjUcQ77Edz/bJxHCrUgxEP3lsDG5g0YMkESAb8UWNe7I9J1sQJ4s7EQyhcg2JQ1IJbaQjPBBkND8tudx6NuS+RR4WX46c+XimvF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EJF8cdow; arc=fail smtp.client-ip=40.107.193.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHkfucpHANAIo4X10iFp1/b3Ki7AubPMSMga367A59ERhQ05N/MJII16l7e8Uf2+JKE5mI8vlCND4jnubVtvnR5MrRFmQfpBlURjriOT2KkpzL9FN4JQV0l10Ofxcg5GHVq250LeU1LOqG7IK+dOC/fWG4e77KuQvvMPy1lDZK/2rwllP/j5o7e8VwXbD5dfzmGbG2xkKHPq3yeueRE/ybLQx271sive7kxeE0pj4WO+dSpZD82u5GuknLVb5kfWqCkHSE2HkkEOmp9o9KobH9wO5C5zcSpmuqR9c5n2ZShFkkq0If8aL7Y22YkXc8Q7nnItvQEGhyqxLqXSvtT6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzScGkjAhi2ulpFZ6EBSailepENBO2Ho6dpk95bUufo=;
 b=gLikp9W86K7I8d52F7HY6ozzAmtdInld1jQ1I8mQjDOQEYtGoNLyUAiBN4UT978hovCTxNpXGXW2rwMV/pZqzO6u9V41u6JYqGs2Q5CjicNVEnleG66x/gpPAhAwwwxINWkN+KmUvjgmOBPEy9cd6DhpXHJxzBayA9A2lmuoiDZTBM/AeqF31usUxwzVdrVwxOAR6Hy0qRZB6fPm7TMNf8C7E9FCEUBH2p+52tqMC6V/kCYEF7aRr44U20PcDFmIpu+KXA26CXpjNDiZAC8k7MSktSsme6kjQNf+/eXkyS5X5WaccrNU0DDHHabtIIuXcR+ZMPqXflx9Wq3pPIobRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzScGkjAhi2ulpFZ6EBSailepENBO2Ho6dpk95bUufo=;
 b=EJF8cdowjQObTABzZD3J3SW2RU2fnNhNSmAkR17LjkC+1iSI7dsU0Kn8QydpTX3ckh3NEZKbDzxrOr/Jo5l7RHyuiHZ8Nppa9eZKUE+Sm4TgXnbgTLuHEgT1tHTm9SzyLhWhsYmS4/uyu7l8znuN4m7NMiR5Px3Q2IYwC3c140HIWX8iynyS8Pae2hVZLixsYpXzAsuHVF1PCDNwGg4eArhhv47z+9YQsf89zELXVWGOpX0dWx29PYub7JuPHygZZ93oDwZf2BU0BCYLqZA1Rdva3cCKB1zEYtNagT/VccYNEnvjd3t/MP/p9HOy2q2jY4aSzfBW9MdAzjbYyZmf4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8759.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 19:04:32 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:04:32 +0000
Message-ID: <c13c626d-344f-4d4b-a495-5006613f9bad@efficios.com>
Date: Mon, 24 Feb 2025 14:04:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] pkeys: add API to switch to permissive/zero pkey
 register
To: Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1740403209.git.dvyukov@google.com>
 <68427864e0ca38af06482c96728216c3e0973418.1740403209.git.dvyukov@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <68427864e0ca38af06482c96728216c3e0973418.1740403209.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::35) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: c86d1229-99d2-4695-4e12-08dd55061222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1pkS25HRjVWa1EwWVFISVl3cDBDdE54d0o4NE0xdXlLOEt3bjk3bS8yVVlp?=
 =?utf-8?B?eisyRTE5SlJyNWR6TXJlUzBWSU1sejM5OEt3ck5FWXhWRDBubnRYOHB2MS9Y?=
 =?utf-8?B?RlpJMmM4ZHJvRkhQY1JLdEE4bDNjNlQyMjhTRFdrRkRWRDNOcTJWck8xT21o?=
 =?utf-8?B?OUtLaC9vYi90RDJEUVJHYWhKczFUc0hFUnBNMGVqYmMxVUVCTFBkM2tjWEVZ?=
 =?utf-8?B?WlBsQjNreXNocVBsS3pqZUYyZlZoTS9aU1J3b0taM09adDFiUVNjc1JkcXBJ?=
 =?utf-8?B?UFFzLzRoTEZaamZ3WmU1RWFEa3kwdlU3SmVFZUVQWlhlSU5zZy9BMTZzeDBU?=
 =?utf-8?B?ZFUvQzdKYU1IbHIzL1ZSYUxHRng4QnpzdWhaSTVLMG54bHFHQTdXeUVtNTA1?=
 =?utf-8?B?SjZhTTN5Ymx5ZWtyNXVtK29aMStiWXdzajFmT1d1TVZRelF1bzZxczFDd1Rw?=
 =?utf-8?B?eG5rYy8xYWlTN3dpaUI5TkNaQjR3V21EOXdNV2lPUlZKTXdtMDVRdmtYUXJP?=
 =?utf-8?B?YnJOTVlsalNPRUZnb28yREJja3FmUGxCNEQzbU13VzErcHZpRnE2U3M5NXd4?=
 =?utf-8?B?aU1xS0ZwakhzOEN0RWhNQkc2aXE3SWpVVWowdzZ1MUVPaWIvRlp2a3dLL3Zl?=
 =?utf-8?B?YzN3RUFJWGhrNlNCL2MzdllvVEQrbGc1d0hrUXBJTzIrbXJ0b0U1RmIxdFEx?=
 =?utf-8?B?TDR5dnVkRWo0dlZMVDdUMFlndy9oWWhWV1k3RnZOampyNFZnbHl6RDdVWm1N?=
 =?utf-8?B?ZGhiczZDcERyRjhYK1ZSNGowUWw2NHgzaStUdXh0d3A1V1J5VTFaWndIbmpO?=
 =?utf-8?B?QmFMeWxpTTlkMytrTmIxZC8wQ1N2QlNQUUxpT0t3SEpON0pUam9uWXV3MjU5?=
 =?utf-8?B?aUFKWHZlbW45ajFpWHZKVENmK1I0MDlwWG8xbkJSeTN1QU9zVXhab2RGTFpz?=
 =?utf-8?B?NWRHbTI1K01lK2JPQmRLK0ZNV1hleE5RWDY5WDBQMW02am5QczVydlE3OG9W?=
 =?utf-8?B?bUt1V01nUXZjbDBhMEd6S2tSbjRqZHlFNWJuWGR4VEVwd0NLaUJUZkYvOU5O?=
 =?utf-8?B?L2NuWU16b0MwNXF0anlobmVOYWowUlY1bnA0Y2lpbEtDQ0xyTUtMVVhMSWQz?=
 =?utf-8?B?N2lQV3pCdE90Z2xFYnlRN1J3cjJNVmhmRGd2ZFBJamFMQXFrdnRWdm9LSXQv?=
 =?utf-8?B?L3p5MThEMjFCUFlNUFlVSEoxUlIvVDBCS3FRVy9lQ1oyUENpUzlic3JmV2ZC?=
 =?utf-8?B?K0kzWEIzU0VUK1VHdXRPNVpyVzR2TmplZWdMZkdMM25sZzR1WkIvQytFUzhj?=
 =?utf-8?B?OUNOY0lNdTBxVWtaZE9ZanNSU1g1U0pyMjFZMnVGc3I4QklQNzdZK1BSV3Zo?=
 =?utf-8?B?RjZYb1FpOHFRait5WFRsM1dKRkRhaXZUaktPcmxETHZoMnNkQktVVEZHOGtM?=
 =?utf-8?B?bWFOZ1ExS3Q2Y2ZhZHIvSnM4czFxdVhpc1RNMVViRTgzVXNGcUNKcG0wdjA1?=
 =?utf-8?B?RDM0dUdxejZHakxlejljUkJUc0RqaS9ETlNndDFnbFNJVHRrOUxKZnFUUHMy?=
 =?utf-8?B?QmR1ekZLNHQ5SldSWnpvbnRjNEJLQ0JSTS9pY29mK2p6V3I1WCtSb0NRWXA0?=
 =?utf-8?B?eXVhVjlaaVB3dGkyakg4VlR1NVdPOFhVbXE2VnhIamtxRUZWbzFaUUFZM3Nw?=
 =?utf-8?B?NC9ZZWhES2tkVkFDQ3piYjZqeUJEb2Rrc3FqbFpoaGtvcDMzWEd1WWhBZXBZ?=
 =?utf-8?B?MWh0WVFxZnkxWDlVT2wzRUhuYk1jc0ZIR1RyK1llLzdPN3FJL05EdllHZ1FH?=
 =?utf-8?B?YzJqRVVXR3l0cDNEMWp0UkE3NG00MlVaQ2FZbzlJNjkySHlPaWtCTXhzNXc1?=
 =?utf-8?Q?AIJSH4hxdw9rf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1cxYmtJWkVTZmJnQjduMkgyKzlvdUxqVzVBeXowN0R2amZFU1VvTy9zeVZq?=
 =?utf-8?B?K2RpcW5BWksyZ2pwVTVFNk1HRjhQYjlqZ3ZwOXc3K2NodUQwdk41bXVSenNo?=
 =?utf-8?B?UVhZMTY1Qmp1NzVacy9WVUg3ejhkY1NvTFQ1SFBDYzNFOGMwNlhmL0FFUk9z?=
 =?utf-8?B?b2dnb05pYnlwSUZ3SG1CKzJCQmlZYWE4cG1NNGljdnk4SktXZDN2akl5UGZM?=
 =?utf-8?B?QjVzMVdGbnkwTXp5Z2YveDZZb2p5NW1QdWhzRmNJR3NrRDIzWC8vdk8vb2Fu?=
 =?utf-8?B?RU9PTFRTcU5VczN5dkZzRnF5QTJSTEtOdmlqZTV0dVY3WEtCYjJHaHRTbCtR?=
 =?utf-8?B?Z2RUa3Y2WGhiNy9ueEVhRUtoQmlwTzdlbjNUdTgzVUUxV2pKRjZFYmhMaDJE?=
 =?utf-8?B?bCtwaG4wb2RzQllsSkRtSXdBekpLTi9GVlB1TmgwdC9yaGRqQW1mdmZTcFhJ?=
 =?utf-8?B?QWZ1VTlqSEc1RXJjWFc5b25yUEdaVzUwd1puTlE5eEUvR05FR29GdldzeWtR?=
 =?utf-8?B?VG1EaTRmWThyN3VHaTJnYnJGTmtuK2I5clliM2tCdjVVR2kreTBQTHJTdVpT?=
 =?utf-8?B?bC9LallkWFBrekpIZ0paMFRFN21XTlpRclRrcHpMbUdsVmpoeWVsbXRXNnBR?=
 =?utf-8?B?bE1rYi9CRldpTU5NSWdMM2JIM3gzSW92cVcrWHZRSWkrd01WK1YvbVlYckI3?=
 =?utf-8?B?RS84YVRFV1NmRjgxYi83amd4TUxCTGRUS21pZmxSR1FRNHNpZHdwMGVhcjB5?=
 =?utf-8?B?STJkK21MakE4UUR3Z2RYT3pRNXZoOW1YWjZ0eTh3c1ZFMkZUK0ZCd1hoU1lL?=
 =?utf-8?B?T1B3aGRzREdTVVQyZUpwdDlVUXBhTk9IMUJHNEtEc3ZZQW9VdndSSFBuVEJJ?=
 =?utf-8?B?MGJIYlV2THpZNkp5MlArUXRJeFlpaW82L0lzSTdJVGhUR2hRc0h2Z0NaOUJK?=
 =?utf-8?B?UG1iYkRGYTRSR1FmNlZPMHNXYkdpTjdyVWNRQ053eWVSQzYzbnVrdUhlR3d5?=
 =?utf-8?B?bE82MzNrYXh6NmdsVitnbVE3K3Q5YnJmVlRnSnJoUjlCWUhHaUV2TW5UWXJQ?=
 =?utf-8?B?TWRBVjN2U3pzUE1oWkNFbi9vZC90b0ZPM0NobVBZWjRrTytRTkpMeWFzVDc2?=
 =?utf-8?B?YUYzSHlBKzZTUVNkc0pMa292OWZ0TjIzR3p5czhySyszaU1DYzZ4ZXhjK0Vo?=
 =?utf-8?B?RVN6MVU2aU1md0ErQ012YjhRNVN1d3JZU0Zodmg0cEhkaUdZMnBsblpWcmpk?=
 =?utf-8?B?VFVsSUZpUWxXYzlUaENkY2ZNbk8xeUpPNWJJZEFVZjJPSzBnU29jblJxRzEr?=
 =?utf-8?B?UFRuV0craWhTNFl6SXhvVFNveStKMS9YY3B0OW9udzB6ZU9rMnk5cmFkMGlr?=
 =?utf-8?B?MmcyckpDQWVXM282aDZSNkxzK2NrdFVZa3lEVHlMWVlOVkVrbTNmYmZjV1ZI?=
 =?utf-8?B?cnE1eHJXMTd0R0xlTTVXUWtEOUFpV0F3eEppNEIxOFVkVWdqb0p6Y1hBS3RL?=
 =?utf-8?B?QVlqaTJoSE41UUw4OERvcEQzeHZaSGF0bnF3V2lXS0RTVnliSWhaN0p5UVQ3?=
 =?utf-8?B?NmtwVnZpdlR0eEQ1RC8rNUYrVWU5amdDMTZaMWxyZ1dkaDJwTnZ2TVdPMDV3?=
 =?utf-8?B?Rnk2ZjVQcUM0QXIza2NVNUVFZUp0WVR0QnZBQVZpdlZNMWV6M1BYVHFQQWR5?=
 =?utf-8?B?SUZma2ttWVpKaUFqK28wa1ZFQlJDcnQvdW5CS3NiZnl5YnNqUjZTRmlqNUt2?=
 =?utf-8?B?RlRUTzJ1U3FWWDNUSjJ3RDM5Y0tHbm13a0lBcVU2TkRpZ1pFUXZ3VGpLeVF0?=
 =?utf-8?B?bmd6M1czZkcxclVDTHFNWEtLUW95bm8ydU01UGV4Z0dhUEZiZE9udmZXTU93?=
 =?utf-8?B?bjBETFJzelVOOU1rWkZtT2FiZFJWRFVzOEFLdlg2UlJnSkV6aUp5eEFFekJN?=
 =?utf-8?B?L1JneGlnL2dEREVackhxSllLai8xTE40K2h2czlxZTNPcnF0VXFkeDNGNEx5?=
 =?utf-8?B?a2trcFJER0xwNTBETWdKOXJnN0F0Mjh1eXVzRGpnRUd5QmRUSXJDc2FsMCtj?=
 =?utf-8?B?enRUakRQdDBJeEFyN2FwdmJJQU1xOUptSWtoY1hHM3FRVVB5K3M4Y3N2UVov?=
 =?utf-8?B?YmJpcVRsVXV0amhaWEVjRFFub2JwUzJ4ZUFOZXFLRTZGRkJCZmkvV0JGb2Jp?=
 =?utf-8?Q?tSEGJObjAYE6Uq9T2ZZqfwE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86d1229-99d2-4695-4e12-08dd55061222
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:04:32.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+2xTa6y6owHP0gwiqy2euNaFOQwMd/G/NDMGAIedHUNkN5uJN4u8h2GcACApawS5i0rEp2KxJAl+FcNDqItYI1cBGHenE8lUfZOpTy5bq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8759

On 2025-02-24 08:20, Dmitry Vyukov wrote:
> The API allows to switch to permissive pkey register that allows accesses
> to all PKEYs, and to a value that allows acccess to the 0 (default) PKEY.
> This functionality is already used in x86 signal delivery, and will be
> needed for rseq.

AFAIU the signal delivery uses the "allow access to all PKEYs"
approach only, not the "allow access to 0-pkey". It would be
good to clarify this in the commit message.

> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> 
> ---
> Changes in v4:
>   - Added Fixes tag
> 
> Changes in v3:
>   - Renamed API functions to write_permissive_pkey_val/write_pkey_val
>   - Added enable_zero_pkey_val for rseq
>   - Added Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Changes in v2:
>   - Fixed typo in commit description
> ---
>   arch/x86/Kconfig             |  1 +
>   arch/x86/include/asm/pkeys.h | 33 +++++++++++++++++++++++++++++++++
>   arch/x86/include/asm/pkru.h  | 10 +++++++---
>   include/linux/pkeys.h        | 31 +++++++++++++++++++++++++++++++
>   mm/Kconfig                   |  2 ++
>   5 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index be2c311f5118d..43af2840d098f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1881,6 +1881,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
>   	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
>   	select ARCH_USES_HIGH_VMA_FLAGS
>   	select ARCH_HAS_PKEYS
> +	select ARCH_HAS_PERMISSIVE_PKEY
>   	help
>   	  Memory Protection Keys provides a mechanism for enforcing
>   	  page-based protections, but without requiring modification of the
> diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
> index 2e6c04d8a45b4..d6e35ab5c3d22 100644
> --- a/arch/x86/include/asm/pkeys.h
> +++ b/arch/x86/include/asm/pkeys.h
> @@ -2,6 +2,8 @@
>   #ifndef _ASM_X86_PKEYS_H
>   #define _ASM_X86_PKEYS_H
>   
> +#include "pkru.h"
> +
>   /*
>    * If more than 16 keys are ever supported, a thorough audit
>    * will be necessary to ensure that the types that store key
> @@ -123,4 +125,35 @@ static inline int vma_pkey(struct vm_area_struct *vma)
>   	return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
>   }
>   
> +typedef u32 pkey_reg_t;
> +
> +static inline pkey_reg_t write_permissive_pkey_val(void)
> +{
> +	return write_pkru(0);
> +}
> +
> +static inline pkey_reg_t enable_zero_pkey_val(void)
> +{
> +	u32 pkru;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
> +		return 0;
> +	/*
> +	 * WRPKRU is relatively expensive compared to RDPKRU,
> +	 * avoid it if possible.
> +	 */
> +	pkru = rdpkru();
> +	if ((pkru & (PKRU_AD_BIT|PKRU_WD_BIT)) != 0)
> +		wrpkru(pkru & ~(PKRU_AD_BIT|PKRU_WD_BIT));
> +	return pkru;
> +
> +
> +	return write_pkru(0);

This is dead code. What I am missing ?

With those fixed, please keep my reviewed-by :)

Thanks,

Mathieu

> +}
> +
> +static inline void write_pkey_val(pkey_reg_t val)
> +{
> +	write_pkru(val);
> +}
> +
>   #endif /*_ASM_X86_PKEYS_H */
> diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
> index 74f0a2d34ffdd..b9bf9b7f2753b 100644
> --- a/arch/x86/include/asm/pkru.h
> +++ b/arch/x86/include/asm/pkru.h
> @@ -39,16 +39,20 @@ static inline u32 read_pkru(void)
>   	return 0;
>   }
>   
> -static inline void write_pkru(u32 pkru)
> +static inline u32 write_pkru(u32 pkru)
>   {
> +	u32 old_pkru;
> +
>   	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
> -		return;
> +		return 0;
>   	/*
>   	 * WRPKRU is relatively expensive compared to RDPKRU.
>   	 * Avoid WRPKRU when it would not change the value.
>   	 */
> -	if (pkru != rdpkru())
> +	old_pkru = rdpkru();
> +	if (pkru != old_pkru)
>   		wrpkru(pkru);
> +	return old_pkru;
>   }
>   
>   static inline void pkru_write_default(void)
> diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> index 86be8bf27b41b..262d60f6a15f8 100644
> --- a/include/linux/pkeys.h
> +++ b/include/linux/pkeys.h
> @@ -48,4 +48,35 @@ static inline bool arch_pkeys_enabled(void)
>   
>   #endif /* ! CONFIG_ARCH_HAS_PKEYS */
>   
> +#ifndef CONFIG_ARCH_HAS_PERMISSIVE_PKEY
> +
> +/*
> + * Common name for value of the register that controls access to PKEYs
> + * (called differently on different arches: PKRU, POR, AMR).
> + */
> +typedef char pkey_reg_t;
> +
> +/*
> + * Sets PKEY access register to the most permissive value that allows
> + * accesses to all PKEYs. Returns the current value of PKEY register.
> + * Code should generally arrange switching back to the old value
> + * using write_pkey_val(old_value).
> + */
> +static inline pkey_reg_t write_permissive_pkey_val(void)
> +{
> +	return 0;
> +}
> +
> +/*
> + * Sets PKEY access register to a value that allows access to the 0 (default)
> + * PKEY. Returns the current value of PKEY register.
> + */
> +static inline pkey_reg_t enable_zero_pkey_val(void)
> +{
> +	return 0;
> +}
> +
> +static inline void write_pkey_val(pkey_reg_t val) {}
> +#endif /* ! CONFIG_ARCH_HAS_PERMISSIVE_PKEY */
> +
>   #endif /* _LINUX_PKEYS_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 1b501db064172..9e874f7713a2b 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1147,6 +1147,8 @@ config ARCH_USES_HIGH_VMA_FLAGS
>   	bool
>   config ARCH_HAS_PKEYS
>   	bool
> +config ARCH_HAS_PERMISSIVE_PKEY
> +	bool
>   
>   config ARCH_USES_PG_ARCH_2
>   	bool


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


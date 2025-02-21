Return-Path: <linux-kernel+bounces-526529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C4A3FFE4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6296317FB63
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2442512FE;
	Fri, 21 Feb 2025 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="El9VbEzS"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020125.outbound.protection.outlook.com [52.101.189.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6E1FBC93
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166716; cv=fail; b=ETEaOruftSsmboISWqxXHYVwS/1MsjuB9Nd96YPxeAIu8ADMF2c9LxYEXDnClxVI51wW/UKzfX/REjSnKw/3P3c/LIAIK4Qm3VMFeqAJBNIDxQhHll3xVd5Na152bBK0O5ykVm0pmtGMwD8k6Pejdn/+5y035ViN00/2KZyAeBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166716; c=relaxed/simple;
	bh=ZsMNOFgts6n7ani4m7HHoOQQO3u4uNboYiZdG56Fi5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I7+39qAmtgO6TYMcKaXRP7teXWxSpffUHY2NX1S1OyRB0TZIMfIhko2m4idTYQYyyW7IIVjh3+N/UhVMxUaXXtYRwMnB77G3a3/9VrBvVmq5ss/dLm2VMgvcv19jXSBLhU3LXiGMFbXLz9YVkBJ2Bxaas2S/U7GQ2YXMRvKJ/jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=El9VbEzS; arc=fail smtp.client-ip=52.101.189.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbxddmVFeyXd5RWgA0pc+drafWD/kja2V/AO+ehcWR3i1NdY8u3pkNOBraQle+hiTWFZFf5t1tAtkirxMvPSBLywDugfcQPaheCYlCZmZBhXeYuEhLDfhYTxvUO03i2z0DbI4+hWHrbUpYHROl2YmwAn4roh52tvsWP2WQ7KcIAtHKd7h1bbxtOliU4b/tJ9nikqTQwyMrk1s690AqP48ctwD4No/0RIMaLWrlA2NkTFUSaE0OVHwc0DSEKvWmG494F7SRHYMXCJqbSu+nNYciCmcj+vEN4O/8JI4zI89fxsNv0GTZS9ruJDLPskkatiidQXHXwj4l2+v6xiUhx9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AliiehwxuadUWDaKu5NGhK94GLdHlyZeu8xZ+2s3/g=;
 b=cYH5Z0sVgyyXhbSBQ6btGE6ES5u32msosFq3EOuptB3Yhvz0zH+WGmkhJ7VjROsEmqCjjXB6mbylevE4p58IlfVE7+UKYmYPzW4eV0gDFQfnuNHNyxSta7SzQMrSTrwgqnzOjEdKqxMsu95xEWdpsFQsyXeJIPzpraieW/vzZzRgboh7gGWj/m2IYGrhvvGLOVH2djIATcfSUWzV4dyt3GEKmWCsujy+NN7pG+qRXLapcG0K+HDKKePhezL/PILJrYkcOBhhEKbsLaTmoL7lLX8CQvN5+/CMO7+1JWia/5vyOXm20MGK9US30DIouFBh88CYWVq6TvHVSegcUa+/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AliiehwxuadUWDaKu5NGhK94GLdHlyZeu8xZ+2s3/g=;
 b=El9VbEzSBJW5Oulg2zhtCIIRbtFVudBrFAhgx4QJN66mlj84c0UbVfzl/A4ywD5L2iMFs11gJKe6mhWj5G5oUmykWem4HeBHq80iXdkx88K5CXc3F5NYJUqP+pq19vH+l2cm03WYuc4Axil9gMOjJSaH0UbFb1I1n1Qb/1eAMNBwgETlL/vnB7kZdO45Jb8CV3FVrHdWPklhjIRWxYCWKes4K4yn3ncF6nI4zSYHu38siQeuQ5+Z3uPqk29W+WBcgW4ilioS8Leq43RX6wmYdJr2t8YH97oZWABMJpkmXMlqfpVbxVFw5OcKztxQqyVy0m2E8jJYDM9jynacf0aKxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB11084.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:140::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 19:38:31 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 19:38:31 +0000
Message-ID: <6ada635e-973d-4e32-ab47-1fda12ee7ce7@efficios.com>
Date: Fri, 21 Feb 2025 14:38:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Dave Hansen <dave.hansen@intel.com>, Dmitry Vyukov <dvyukov@google.com>,
 peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <81d94ec3-16af-45a7-87c6-ef76570953f8@intel.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <81d94ec3-16af-45a7-87c6-ef76570953f8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB11084:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c1d101-ee80-49ad-f9f0-08dd52af52b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFBld3c3MHpRQXl4TlVMRzhaY2R1Zk9sYVRzL3QvZW1nTFhWSTdma0ZJNWVX?=
 =?utf-8?B?WlVmMGlkUHR1ejNwbzNVRm9pY3FNeWU0WTJhVmdpVGlNdGVZUDRCalRUYnZS?=
 =?utf-8?B?ZUoxcDYrVElma0MxK080dEpxSkV6SmFYNGNSTjZXbGg4Tkg4TlFGYzZGWXpW?=
 =?utf-8?B?QzBUby9NVUwzWjJlZ1JiVjg4TkRmQnQwWnhBSXVOWDc0TUxOL1V1ZUkxam5w?=
 =?utf-8?B?WkdrUjd4UnZoQ3JIYmxSbXVZc0kzaDJmc2Y0NWd5dHhSTmswbEtrZ3pkLy84?=
 =?utf-8?B?V2V3NE5iTFY3MHdSeElBWUNZMGY5K000VFNyVzdYa05tanFnNWxkd1lhVmcz?=
 =?utf-8?B?dFNqbTF3NENtanRjcUc4OXZSQWk4SXk4b0I3NDk0RXNJOUhUM0NaY20vcTFQ?=
 =?utf-8?B?SkpXc0ttWXRSbWFBTE9hMWphU0Z4aUl2eHJvV1ZQZ3pWOG5NWGh5UHArNEgw?=
 =?utf-8?B?QmhkdXdNUUUwN25tcUcxelFQMHM1MHZoRHg4cUVxc1A1Y2J4REJYTGlwTHdB?=
 =?utf-8?B?dHBmbm10Z25kK0ZBVkZHQUZsaVhhb09GU0JodTRCaWhQQW5rNjd0WTBCY0dW?=
 =?utf-8?B?WGprUGpsR2w4TEJ4N1VOOGRLVlk2a3U5R2RKYmlXNW1CcWtxemZ3ZGhuSjZu?=
 =?utf-8?B?UUVsbW5tYWxtTndQdjZFRWRUMnhjR2hVbjcvTlBhbGF5QU0yY2ZJVGZOT3Mz?=
 =?utf-8?B?Vlc3K1FWK2l0Y0tPZ3RZTU9jenJwVldGdG5HeTNhT3V1UFo2SFBqbXkyMmor?=
 =?utf-8?B?WGFZbzYrQW5YeUVLYmpZekV5UHFoVUZlYk9WQUZuTm9QMUR2M3g0eGlUWmk1?=
 =?utf-8?B?SlliZWs4aUFBSVM1dUhiT05SRXVPK3RDbUcyUlBWeU5wdzF0ZitUQldML09X?=
 =?utf-8?B?c005SWhmTWl3MjVYS1RFMFZBOGU0eURxeHlhVFhJODZBZ0oyRFZJcnBZQ1Yz?=
 =?utf-8?B?VitUditjRjM5V0E3WS96WUxCUUdJd2RoTGNNdmVTM1VpMUZUellGUXl0bnBp?=
 =?utf-8?B?SmNacVgvSEJwVlNRUythQnZTK2FReUl3dkJTV0k5MmlDM01xeTJDT01GeDhp?=
 =?utf-8?B?b0NmMWhrMDdaRmlzcklYK2dzRFIvVFRUVnVnUkV1d3lGVnExejRYVTBKK0Y1?=
 =?utf-8?B?TDNScXI0Z3Ruc1ppV3VzdVY1dlNGK1BWSVhod0RwcWxjMWpLczEySDBnVXVY?=
 =?utf-8?B?Uk9pUnB3MitwcDhZOEhCV3NXbDQwWnRQWGVnZmNRKzJBK1BOdnpOMTd1L3Z1?=
 =?utf-8?B?VFpFSkhIV0RoUXJBdWxVWVQwNTJ3ZVdiSzdZU241Y2FEVHpwUWMydmhlRzBV?=
 =?utf-8?B?dytQSU5VMXEyNW1CTjhIays4UjVxZDNWT3Vsb0pHeWhCVC82V08vWUZNazZu?=
 =?utf-8?B?Q0RmaDZnRTRnejdJTFJ2ZGRpdUxjMnhpbkhyVjVKUW1wV2FHQUdkWVRLY29K?=
 =?utf-8?B?dUlmUC8xZi8xaTNFQkZGamdURUlFSk1jZUhSdXBzcHNXbUFMN05qM1gzaUxM?=
 =?utf-8?B?NE1WZ1U4dXFYUHRUbmMySlpyWXJVaGw5SDg3c1AyTVE5TXl3M3RJNnFseTdJ?=
 =?utf-8?B?ODMyZXhYSklobzdtUnR5UkQxN2FqTDRnVnMxeGJtajVkU1RBcDhzUTd1bmxT?=
 =?utf-8?B?MUR3TndvWHNTTW9RekZBU2tQcnkyRXloUTJTMTJGK3BYNWhPZlR6WjhoWXFs?=
 =?utf-8?B?QXNYSEU4bVFEaDhNUDJwR3BsR29WNU5OOWdEOFFMVC9WNCtNZ01rOHZQcnVQ?=
 =?utf-8?B?aG9qN0VvR0U5RlN0N0NCT2dOYnd4Y2R0SExLOUIrblZFZmc0K1RzNzQxMFNz?=
 =?utf-8?B?aWZEYUR2a0NndFEzTlhBa2JYKy9Tbk5FRmxGNDY1MEY0bjdvYks0b3NzZGFn?=
 =?utf-8?Q?xKTipNdhPjUZH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUx2NS9PNFNDUWk3Uy9yWlVjQjB5U0p4OUpZN3I0TFgrWjc1Mk9JNHZTcHV3?=
 =?utf-8?B?RjBaZy9uT21YdXJ0S3Z6aXNtcGRGQUM1eERxMnQwMjkyQmVBSGJRUCtDTlRN?=
 =?utf-8?B?L1Bxei82bm1sc1BRVzdBbnQvUXFLbjRnNkhBUlczVzFTNkRZQnBjcDdQeS80?=
 =?utf-8?B?WEVObEl2LzlSNm9JTDBCTit2M1pEb2RHZFVuSUVMU1lSZEpuSXNBKzR6SWJo?=
 =?utf-8?B?WWZMVWJBRitpYi9aVytJSFl4Ykt6b1ZkY0h1NmRDWXpFQnZTSThueDBWSjV4?=
 =?utf-8?B?Y05Bb2xINDl5aThOb0cxZTJCaUl5RWJ4aVVlSmpwNSt2Z1J3eG5mUlV2eE5r?=
 =?utf-8?B?dW1PZ0RJVEtYT1djOVBtdnBBblBYZThodElhbkRVNmpPODVvVGVKL2xVUDVj?=
 =?utf-8?B?WndaNndpK1VNV3RONTIxT0tNQndNbDlLTW1ITE1iTHo1OERHenRSejdQa0hG?=
 =?utf-8?B?dXphNXBzUVRCY01NaDlOd3Y1eHg5RTlYdzduMFB4L1lubGo5OFNTN3NtQ25i?=
 =?utf-8?B?YkZQVHJnZ0YvMExHTDRFbTA3Y2VjdWNCLzh3RlZLbTNkZWRLalVhRmZJYXZC?=
 =?utf-8?B?STliU1BzeU0yRjZESVdlWTdyVnp0cTJNZTFmRUNTUUdabDgxUE5vZjYvRUVt?=
 =?utf-8?B?NHFIKzIvTjBWRTg4TWR3MkdHbjNoL0ZrM09LaytnOG5tbTgvcFUrTUtKQ2ZR?=
 =?utf-8?B?a3l5bnhPbDdwT0dWeWlxK1RPWExRR3VHQ2FyN29ycUxWM2pHazNxUk1MRGgv?=
 =?utf-8?B?eUF5Y1R5ZFhQN1lRQXl4anM2Nk9mMXg4eG5iOUhhVXZpZUNTR1pJMTJtVVJG?=
 =?utf-8?B?L3l5ZUxZZ21lWmpaVGtrU3JJZWlOSWpzK2pqdy9sM0RTcWk4R2ZDSlJ6djRK?=
 =?utf-8?B?QVgxeHkxMlltcndLTFdHRnc2MlZwcVQ3V3YzRk84WUl6TG5EdXpRR0ZCek1X?=
 =?utf-8?B?ZCs0cSsxMWNxWkNabkRiaE5oK3dMc3NqS3VOZWpYWlBpeVFzQ25Fa3p3eGhI?=
 =?utf-8?B?Z01oMkU2SlFxRUx3UnRMdzBXZHNQcUtseXB4WjMxNEY5UTRLMXNVb0p0VnA3?=
 =?utf-8?B?N1Vjek5PV0VRUkVHVXFCeHlFUFFXZEZFeHNRQWJWUXFVdUIzSno2N3k0a1NE?=
 =?utf-8?B?RURYOXRzdkxpNGNibndIczlsQVVDRWx4Z1B3MEJIMWt5Y2I4bnJaR0Fxd0to?=
 =?utf-8?B?ZHRCYnRmaVczRjFqc3hDQmw2U25DVlFzRzJTdHY0TmdjUGRrUWErMHZ5OTQv?=
 =?utf-8?B?VkxwakxXZ2s4dDRGcmYvb0lkUGdoc3IwU0xlaDNkNTJIdDl1V3NzN2VSamtt?=
 =?utf-8?B?OStZQzcxNlhvdjlEUjF5aHA4RU5GeVdtcWtqOThOYlNUUnhlVXR6aGQ2bUlW?=
 =?utf-8?B?TEl0dE5CaXRDaHdRZzdTaXRvL0tNOUdjUzg4UzlVZWV5TXJCSXl6eUk5WXB5?=
 =?utf-8?B?eVlHbDVabUdzamdVUW9BVnRkcG81anNGNEFnRld2ZmNhMXRrQWdKUmNTU1hE?=
 =?utf-8?B?SEN2T0xnNVgvWG1pZjVFYTB4eVNpMUZtM2lGT1Jqdkh6TDVtaUlaYU9zOHc2?=
 =?utf-8?B?M0dLRUY4SUNvdDIzVm9BN1ZJMEhtZThXV1NRZjZzMWlvZFVpSGp1Ni82NnI2?=
 =?utf-8?B?b2JKQTc2ekxudnVzNEx4Z2QzSU5jS1UwcDFlZ3FyVGM1VUJZZnVSeHdSSGpS?=
 =?utf-8?B?MHV4b21wQUVkUkZ5dG0rUjlJYldrL0lzNXl1S2dMUlBSUE81OFlPa0QwZEQ2?=
 =?utf-8?B?cFFiQVVwWlhvZ0ZwVjI2U2phWUtjTWtXcnFvN1c1NDlUVk1hcjdMS3c4YVFM?=
 =?utf-8?B?L3ZzQ09FdGxzMldXVW9xM1VDc3FJMGxLbTErdTJueVlURWFjOTcvRm9INU8w?=
 =?utf-8?B?Yk0vRHloSUp3eU0xdWhrMnAzRHNlNFZ4eEh5RFVJK2ljckxPdjlxSlZ0TytL?=
 =?utf-8?B?Q3RLOGw4WVJpcU1UeUVCcTdyd3VaMnZqL2RhZDNZTEIwaUVBOGpSTHk0VFl3?=
 =?utf-8?B?TmRuYmJROWpoVXZCckJuVWI5SWc0RDk2dnVXbWtGdjZ4c3lubE45MVNFNHhF?=
 =?utf-8?B?SndjNU5pdjBWRGwvcVJMMHJScm5ycVBjWktMMFF0MzZwbzVxWnA5NW1MUnFU?=
 =?utf-8?B?N1dEeXNnTGVVR3c4bDkvMnRlelFpWWZPbXgzZ2U4QUdHSkhNUUV1TldFbk00?=
 =?utf-8?Q?FvkEGY9KqtaHiA7VOgIAQ64=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c1d101-ee80-49ad-f9f0-08dd52af52b0
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 19:38:31.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3t0N01MZXqDbWmpfcEkgDie4RQM04TqMWA0LGcLFn+JswuBsmxkBnG3Eki8Vw7SwnUE1XhXFEeAWV3gEv/vCqiNhmI7gJUo39MAvIAZkndY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11084

On 2025-02-21 12:17, Dave Hansen wrote:
> On 2/17/25 03:07, Dmitry Vyukov wrote:
[...]
> This code flow is a bit hard to follow with the retry and all.
> 
> I think the assumption here is that overwriting the pkey register is too
> slow for the fast path. Instead, in the slow error path, there is a
> one-time operation to make the register permissive and retry.
> 
> I guess it's your rseq code. But I'd probably just put the
> switch_to_permissive_pkey_reg()/write_pkey_reg() in the fast/common path
> for simplicity unless I knew it was causing a measurable performance
> problem.

I agree that switching to permissive key in the fast path would be
simpler. AFAIU, the switch_to_permissive_pkey_reg() is only a pkey
read when the key is already permissive.

I'd favor the simpler approach unless performance end up being an
issue.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


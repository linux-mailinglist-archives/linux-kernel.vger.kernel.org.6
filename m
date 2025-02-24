Return-Path: <linux-kernel+bounces-529911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F67A42C69
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A6AA7A709E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246801EDA0C;
	Mon, 24 Feb 2025 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BMh4Ak5R"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021080.outbound.protection.outlook.com [40.107.192.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6E155CB3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424274; cv=fail; b=MXS+dXqVQHjdz1KHusdQ0JziH2e8nolbqCOmhn9C2EyXIiJCYY8By+b6vCui1XEWMSqHmqusX1LScnT2//T1kU9EG0s9FB5617F8qiKQosxKwWEP6MOv1RfMzSguEOa2jlA/XW9Czkki5h1mccwLPaFFV6YDhH33KQjKFogKucg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424274; c=relaxed/simple;
	bh=iFGZA4LFzAOG4MaRxpnVD+GsKnUnfrvhTt/8KT0mnik=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aojnbhnKtAIymqeWawHwk66AYHmgvT24yAQBUCuUReLDbMv5+GWi0aKv4+jXEMrHcFImyRki3OFeesAYOJymUVPDQV+NTHnZgm6qF4BSxdib5a99SGEEgixNIrgzDWbRwtrkMnq9B+eSZhOVeIDFUAqbjsOxnMPpydUWIzAdERs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BMh4Ak5R; arc=fail smtp.client-ip=40.107.192.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bU5xJeiTUn0eEZn4AMbRCPmP8b1Uc2MV6R9FK9bgiuxdUpEzTuR4woVaRCJVQuwIX58gukmK/9U4GKo+hnw8rOK6gTbsiHQ3dWGaDJ0vd4ktBJQKRpKV+bHNDsVKrir1aqvna13idq/EpcGlKu4MPmiJf/4zymqclFWSwHhquJEYR196uL6kIeXGoXUiavY5kfQhhkCCCBWcJyTbBLiJt3PmfGUmpxpXzxBip53730h7p27OQLIXpFFnaFgvjEkdUwJTZ5Wbc+LMSKtkmTlhSiur8s+8R7UH60W7/SpM+9liY0b3POAtmEzNl69SHF9L4segxy6EtyjMn3wO6DOwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pItmACMCL8Z5AFFgQ9eryRfsRXHhxF/pmFAJprGYmMk=;
 b=Qe8ZkfOvoXqI7d4iDPefUkaERKldJy3Ups7Hd+yq46XXMvbudS/kr+I3dVfLwV3NogAj5/2OGtWHWUjI00eOwgoUGj/J9YQAdmxyqc9P0jUzhPCGOBxM3k0U6VV7qgqG2ODK7v6RoTeshmZpKmzP01UTFMmAE9benEd8u3es1CmcYhJ4wbpYsCnkTkJdGMSEuj2v8f0DJLM6m8Mfo1oyV4L/96mtxBvwX2uOX329+3LeJjHmygRZU17aAuqWw57oUAcUzhCIPJS+XCZlmVcbp+WPMDGtW5ZuTByXdZfAqjIMg65t7uAHax1yWSDzaXlkP4NqIUyCChhlIeQtYuw+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pItmACMCL8Z5AFFgQ9eryRfsRXHhxF/pmFAJprGYmMk=;
 b=BMh4Ak5RQ0qI5ubesP2pguncbMF2b+kiS8Fl5DCK00/WSNCnflT5Ma9WIOO2mBmMN4l9Gi9/D3zdSPR2NqdxZbo/srFBCxubMf5bg12NWdlRnScNDAuFP4NBdSPVsFhbRk5x8kvqMIeT5YhDYOtf4aezozltWkb5Kx+2I5M+9f/3XgbPg13CmQ73FLoCYxxWfCP3lSlPHD3qT+A9oJUrZOvl23xVXhWL+zzIp3y7keIBlYderGsMJNiN34c/gDVRlu0QRFuX8EeXX10V2dCr1KXqR+DcCwdic5tJLvFDjjX6fQSDXMrX33OjdjW/J2fOVYdRp4bWKdlxnFeETfLuug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11271.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 19:11:09 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:11:09 +0000
Message-ID: <9bc9896a-b0a3-41f4-9a51-dc0b0eb49f5c@efficios.com>
Date: Mon, 24 Feb 2025 14:11:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] x86/signal: Use write_permissive_pkey_val() helper
To: Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1740403209.git.dvyukov@google.com>
 <85372b646f6d316e38578632cb4678f8ce724b95.1740403209.git.dvyukov@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <85372b646f6d316e38578632cb4678f8ce724b95.1740403209.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0331.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11271:EE_
X-MS-Office365-Filtering-Correlation-Id: f5252baf-8b23-44c8-3ad1-08dd5506ff3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFF3U3JDNkdFVHR4RUxhOVYvY3BOdlBqNkh5OURBaFN2ajB3d0c1SUN1V1dl?=
 =?utf-8?B?bmpOaC9PamoyY3BsdGgxR2Nnb3RBN3ZHYUo0VzMxZnBRZjNEKy92VmszWXNt?=
 =?utf-8?B?NG9yUDNTZERjMnRZbkJsd090K01iYjBOT2FFa3dXVy82djJnaWxpSTFRcXRs?=
 =?utf-8?B?dDRvU3NyZy8rU1NvQ3lZWjkxbkZCRjFBcUJlWC9JZ2ZOWGlpZ0JTNGJBREFI?=
 =?utf-8?B?UEtmTnFqbnpBeXJVMjMvQ3dTd0J1VFJTbVNyNUh5bEIxV0hlY0VIVzczQ3BV?=
 =?utf-8?B?TmFXbCtSaFFDVEpBOFhuNjgza0pPNm5iVnBSYzRlSHRnNXF3NStJSEIybE4x?=
 =?utf-8?B?N3U4bHQwa0V2SGR6d0plcmQyeFR5WTAzR3dNUXIxM01iZEFURTBXZTBsdCty?=
 =?utf-8?B?WVdXUmpUeFg2OHh2bndTWGY1R2NJVmttalh4Rmp5bm9HVnpjNU5MUEdVWk5L?=
 =?utf-8?B?Y2FzbkR5MFl6aVYwRmdvbFRyVDZOZk9QU0pOS3dSdjdHVTVVVWY3MG5DdTVk?=
 =?utf-8?B?RXJvejdvMUJVNWRHK0dQR1ZZSHhjSy93Z1ZpVDNYMjQ4ajVPayttTTQzNERR?=
 =?utf-8?B?aXI1bWEweFJXUXE0NkthK0ZPeUoxQS91M0IxTlI5SS9BWkI2TlhaQXhFTTFa?=
 =?utf-8?B?UUxWTzZlVVhFUHpaOWFoWnV1WTI3Vk5vTk9yb0QxdzZOeWhzWE5nQmdnV0xR?=
 =?utf-8?B?a045cVpMaVI1UU5VTVBQWWxFZFJwYW5ya2J3ZG5pbzJNSDlrNitzMHlIVjF2?=
 =?utf-8?B?ampySGlBM2JDd3ZuZkRoQlE4bVhnLzZwdDMySUtGalkxOUZJeUM4dWJNQk9r?=
 =?utf-8?B?Y3NMYThseGRKTWZobSt2dUUya0NJRndwSGluU1IvTGpEbFN5Q2dEZWh5V1Fr?=
 =?utf-8?B?dnNEdDJrWG9IZWtYQU1HN2kwMC8rRVo2ZDdOcjZDeDJ5T1VaZjYwd3M1UnJU?=
 =?utf-8?B?dTFlaCtFZEpuSlRoeG9rRnJtNGg1OGNveHl6dTU2R3ZTVGFLZDdqN2ExdVZS?=
 =?utf-8?B?amFNRVM0RUgvS0cxODU4MGhPRWExVEVwQmV5WGNjbFcwRzd3eHJKNklFS21I?=
 =?utf-8?B?aC9ETk05L1FjL2RYbHBGTDhJV3gxVjBuRU9GSTM1Y0V4SEVyYUpmU2hVMGNt?=
 =?utf-8?B?aTcxeXVLYWhBakZhcS84TWJkcnR3a3JuR2ViQTlLMGhrcFpEUUY4bS9yZzFH?=
 =?utf-8?B?cGN6NERmTTczZUp0QmZ4NVByL2F5aFIvM1pUemFzZTM5VTJmRnhKcXJ0azJS?=
 =?utf-8?B?d1RzWU5MK0JlWmRJb2Z2ZG4xSE1nOGxaSVRVemVHNlVod2R3Q1R5K1BMNndC?=
 =?utf-8?B?aHJ3RlFpQkJDMitaWVBwVUh4TEpsT2dzR3lMcG0zTUtFa3FUd1Yva3czZHZC?=
 =?utf-8?B?VktEZSt0Y1Z2NG04UWU3QkQ3Z2d6aStrM3g1RzJVVS8vcmVXSzdSWUNwN2xJ?=
 =?utf-8?B?bEhpTHlRMWdvYkpXTEdpLzFjT2Y3eFJIMC9YL0llWUFyVU4yT2RmZnJVNmp6?=
 =?utf-8?B?OElabGlUNWZmNWRCU3dzRGlyWjhWbmdVc0NvL3YxRDZMalBMZnN5cDhQenh6?=
 =?utf-8?B?U2RvemdabWdGWFduK1RzQ2hvc09zcXJOYVl2a04rVzFJRjZWcDA3MEZibTNo?=
 =?utf-8?B?aGw4aGNJdDlpQVJCU3VOYThBSjUyd01EdElZVTRNaWZOdWJJT3dGNmptcVBw?=
 =?utf-8?B?aXR0Wnp2VDAzNlpybHdVKzZvL3E5OEFYWVJUR2pQMGZFUVFRY2dxWGpZcTV2?=
 =?utf-8?B?R2plOGI0Umt3Rnl0QmxKWjdMZmZxNkllMXlsV0tTaHRhUVJRMllRNE1KOFBD?=
 =?utf-8?B?a2E5c1dHamFJdWdMYXJ1cFRJN2dUZy9HaWxQR2RNVW5IdnptU0FPVmMyVE01?=
 =?utf-8?Q?R9/zyf0zWJD7s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1JUckN4V2p0aGwyY0wyajVqRWFSY0d1SlJhNzBoWmZ6bHp5ZkJEQzUzbi93?=
 =?utf-8?B?V3M4Um9pTVVldExZRUo1UEYvYWJjdEc0RzBVSkVCeXVWanovM0w2SFY2WExw?=
 =?utf-8?B?a2kwc0gxQVN4UWpYcjFtdGltRmNPY1doQlphdjNORVdSNFFPR1pxUERmYXRi?=
 =?utf-8?B?cHMzYVNyeVBqNkxiMzJtdDBmRW14SkZRTjlPSC91RlZqeHZiSU03Y0xRdDZs?=
 =?utf-8?B?NWN6R3p6amI5emJTK0tEWE9ycjZ5MDV1ai9VUHdvazY4eXp3cENkVTNJdWNL?=
 =?utf-8?B?S3Bwc251TW5GQ3FVbXA2OWdQTUVVcG5GY21pSWV0eXpQc1JObFdvQ0NaamVo?=
 =?utf-8?B?UnZ5Y0JNQlJxUm8xVHpLdzgrY3V3NlVyTmE3L2tOalZZRUNjUVVrd0w0ZWpS?=
 =?utf-8?B?L0NlVmxmYmd5VVZwZk16ZmZIcWttL0VySi9NZVA1eFVDaHBJekFEbE5ya1ZK?=
 =?utf-8?B?MDFwWmU2Z0dDN0pVV0l1WDA4T00rTk1LdFdadytCZkxWQjhXYWhaQkJjQVR4?=
 =?utf-8?B?bGpoeURReHZCQ1hSZ2RhS3FwRTNnVFVtcHZoVEszS01GWDd5QlBXdWd0TFdG?=
 =?utf-8?B?RS9ON3VFbEc3ZFVBQ3d0azFnTVUyYjlGQU94MUxnQWdDeVhQRm4xdVN2UFlt?=
 =?utf-8?B?LzlqVjRMN2ZyUllZTytWbFM2N1lXK1FySzdIbkw1ZmhlR3FZOTg0aC9NOXUw?=
 =?utf-8?B?NzRiejVPaDZ1S1RXSkwwa29nV0NsTEdjWHNzQjRrb2trSXBSREQ5ZGN6czNq?=
 =?utf-8?B?RUNBNHdlVUZFMGtwN0MyQkp0bFRVaG1WVjc3VFZtNHN6Y2hWblhIN0xxM2w2?=
 =?utf-8?B?RmF0SE1XU28zRnFJNlJsQXJNQ3NPYmExOE5MbDM0N2lFcS9XVEhwcklmaE15?=
 =?utf-8?B?VnJnTFR3QTVvanVMeHd3RlZKMGJ5R01BK0xGUEk0ZVlGK2EwcXF5UVB6NXdi?=
 =?utf-8?B?V0tUalZTS1d2a0FHYzVnRjVCWm1yb3NrYWZWemlsUy9BU20rZUxqV2ZZWW9K?=
 =?utf-8?B?ZjU4a1dnalZkSDlNTmJhYnlObEo0cEdOMFlpQzZwT2pqQW1tUmo2T0lJUWNu?=
 =?utf-8?B?Yk1nRFl2VVNuSWN5enQ1NWFONFA3V0VNK3VPczVkRFJYSlBDcFVjc2xWYndL?=
 =?utf-8?B?QjRXQnEvVlRFR0hyUmp2eC9Jb2JWZXMwSTZvMHNnZUtZSGFVVTZiU1BlUU9E?=
 =?utf-8?B?Y21wcHFlYytnelhsUTNZZG1yUk5kdk5LNUI0ODZpYmEzVnNrY2FqeXBzakxa?=
 =?utf-8?B?V01KbHVQblloczNtVXUzeXFrenloZmw0UXAzVmlZcEcrU0l4a0ZlbGdmb2Fl?=
 =?utf-8?B?YUNwQ1E1M1dQRDZsQUp3WGVyYzdLSDBiUk9aN21RZncwL0ZFa3RoZi9RU3VN?=
 =?utf-8?B?UG5jK0Erd3IzQ0hOa0JsNnVCZmxtbEdVM3RvVGVLY3ZaZHUrRTlSTXR4Tms1?=
 =?utf-8?B?UkRsU0JPL0paNzhTTEtzbVdHU3FTZDN3Um81SXBUaFJXNnc1enRLU0RUb1ZV?=
 =?utf-8?B?NzUzQVZJTEdpMkxHd1MrcFYzSUp6TXVQcjRyUWFpK2w2U01ucitORU5yQUhk?=
 =?utf-8?B?Slk3R2hFcjdETm80NFJYbHpzZjhISUpDRXVBSHp4ZnF4bW1mR0lNRHMrc1pF?=
 =?utf-8?B?UjJmS0xTM1RhcGJaR1FuaVJJWHk1MDZkb3BoNERZVnRValh5MlYybzJZVEdz?=
 =?utf-8?B?ZXRmNllTWmdRS2IzSS9zOG9rL0FTRzlIdE9UVUhTRXFRTjNxL2xIQzBTUXYx?=
 =?utf-8?B?YWVrZVJ3UytseUVZUktBamhnYmlSdFFNcXRrVXY5TlBiZzRod3ZOVlJNQTln?=
 =?utf-8?B?YXlvdjEzUW16T285Y29IQUVqT2FGNk5jWG5BL0czNDVPc1BaMFZWaHpvWmlz?=
 =?utf-8?B?cmhtblQzeXFKWVJUYWJKczdBcU1wQnVXcXRZTzFGaENadk9RYWxUVlBaeVlm?=
 =?utf-8?B?ZHZZWnZxZDdENWgvTk11L284SnZnZ3lCWGNaemlwb3NWdUowODQzV1ZDQlZO?=
 =?utf-8?B?WWduU1EvU2dya2t6UkJ1TXhKbytoRWRmRnk3V2IwY2hJTTNvMkJUeUo1L1Uv?=
 =?utf-8?B?eTRKUWR2amhpdUpPaGx2Q1BHaFlSQWpIMktXNnBaTzljeFFwdUFYRS9WYmZj?=
 =?utf-8?B?TmJ5c2lJQ1pIaFEza0FlTndxWnVucG8vT3Z4cU9VZ1RrU1B5Ry9OcFU0THJN?=
 =?utf-8?Q?l/1jaWxfPR8Q6tcVmHrWoyY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5252baf-8b23-44c8-3ad1-08dd5506ff3c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:11:09.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRRnku+8KLjySjgFRSmdF5gzMNRLuoz/APIF5i5HtUL6ORK/ApwI/gUg2K70k3z0uwIyfgMjXmjHeIjJ4KQjk88xS1ZuEr1yFLViMuKnpD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11271

On 2025-02-24 08:20, Dmitry Vyukov wrote:
> Use the new switch_to_permissive_pkey_reg() helper instead of the
> custom code. No functional changes intended.
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
> 
> ---
> Changes in v3:
>   - restore sig_prepare_pkru with the large comment and
>     make it call the new write_permissive_pkey_val
> ---
>   arch/x86/kernel/signal.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 5f441039b5725..27a66a0697dd2 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -28,6 +28,7 @@
>   #include <linux/entry-common.h>
>   #include <linux/syscalls.h>
>   #include <linux/rseq.h>
> +#include <linux/pkeys.h>
>   
>   #include <asm/processor.h>
>   #include <asm/ucontext.h>
> @@ -72,10 +73,7 @@ static inline int is_x32_frame(struct ksignal *ksig)
>    */
>   static inline u32 sig_prepare_pkru(void)
>   {
> -	u32 orig_pkru = read_pkru();
> -
> -	write_pkru(0);
> -	return orig_pkru;
> +	return write_permissive_pkey_val();

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Note that I would be curious to see if we could get away with changing
this to enable_zero_pkey_val() without breaking any real-life user.
AFAIU this would remove a WRPKRU from signal delivery, but would require
the signal frames to be pkey-0, which is technically be a new ABI
constraint never expressed before.

Thanks,

Mathieu


>   }
>   
>   /*


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


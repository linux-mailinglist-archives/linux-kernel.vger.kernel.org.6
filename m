Return-Path: <linux-kernel+bounces-524727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7C6A3E65F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7485142345B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707C2641E3;
	Thu, 20 Feb 2025 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oON7N5pi"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020100.outbound.protection.outlook.com [52.101.189.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC291DF735
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085849; cv=fail; b=WjepuipA7IwppFEkKKvW/WLWTixXe1/saac4o46WTXOZCwE7wjM4Hf8iygY7v6idawQVxHcWJvvQUetkt1jGwPkX6hzdHLDEBU0lucjyN35fVRSuZrRqMgKNRNgcKljKszz5G4jy+XufZB49YNHMuqW/M7q5VAxUp5mrfG9OqGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085849; c=relaxed/simple;
	bh=l3KSwvq7Ajh51kJ6DOyVg0uuCJnegphVZcnnWOSREAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VtXQnt/mjCmseWooA60PxYlUfiwJHYv4cppMwjQ8L29pai0RPho++NdGovnkU5KjzSLh9dqIIWy3E/AmiXsshhvCw5VZ+WUHtpCs0Ljh3v+n/rVgx26y7x529FsGLnQRLb/SYeoAOZSJ2/RjY/r4fVa6p2aF+PLdrQcA+iaEIJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=oON7N5pi; arc=fail smtp.client-ip=52.101.189.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajGT1+gG1R40745iB5wYaQ0Z06MkF1hfbOy8OI6BX7z9CjiOPj2WqtKRwNiyIbgn2eUwbwIHG+H8tudOQAu2xLDE8830adhN7CBf+vzsm63LUu5xb09sofvBjLh5YWo2jSwP75ZineuatYTj5xhRXMKRKnn3eixGP8WFBHKGaGM4to3O/F0pBCQ3baOeV2CY2lqAK7WgCF3PBDRVZI/T4GS1CuMsjRZL28hL6h+bvc8eD68gR7fED9DIpf3f/Q5EmBUhKVmdWe73Az+N6JwbYNgv6NO+CsjNFeehijrEmaVJA+a94SLOq8eg57ZgtYMtNALFOPw9e1ZdS8JszEiGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9KlA5jiHfjmA2t3f1vg5qemuTUw5uEPYvbUtvC7TD0=;
 b=Dcyjp0CeU3r+YuJmHEa9I2BoaAjZ5JWEi2owIxJUfLSEp3WgEEtXt+yolOh9MUuobSF9t8rguqEcztS7aNIZLEdkaSdpH91hUcmDTbDnmIkLe7VXqUaLyIgmLcca5ibKj5SnhBbFoNYFN74jX8SNHZEpUuErwN7ul6cf694IYily8JF1J7Qu6iB731dvHD8uxIig0ywo0nCqhs+a2tS0C+Tyux+5Za3EaKdqVu+Qm7EvHzi67nuFS2WIHyW/z8cdMmUAREX7KYZp8KAkWHnUdo9V2Pog7/G1SeT/muiSmEEDom9yJRrsEvh3LqG1ZU6qXGKfQ75/erw9zrDDtffkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9KlA5jiHfjmA2t3f1vg5qemuTUw5uEPYvbUtvC7TD0=;
 b=oON7N5piyyF1M0gGzuvNZtZ/3f45Yc7817OLXw7ko7PbYGEO+MClg3C8SlgsrbCMxfxNbnOJjJLDNI7PHMpAGX9jhzRq0x39FxebLSsfqOMEIJ+3Xd1eVoogtcxiOMqGv1ouPJ6tTXcjJUeD5JdkgDuk27K5mpeEjrbsqMv0Wr7EKHm2oX28bGC6Xc+nw7casuNBdqepx/6HBTbuoSUe7YlR3W8CkRrKvp8D+arkHh2cK56N4Eja8uNsM2F+HVj6hG7AERNkGp1QnEbzL1fbkn3iRYMJhGB+8b83SNYoDrcxUeXhrKM6YCWPRF+SgyK/i6Gyu4rSF+aQkWUMbI4sOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPFA592641BD.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::571) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Thu, 20 Feb
 2025 21:10:44 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 21:10:44 +0000
Message-ID: <33c3b258-89e7-4238-965a-15248e997074@efficios.com>
Date: Thu, 20 Feb 2025 16:10:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] sched: Move task_mm_cid_work to mm work_struct
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-mm@kvack.org,
 Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20250220102639.141314-1-gmonaco@redhat.com>
 <20250220102639.141314-2-gmonaco@redhat.com>
 <c9026605-da1b-4631-b0dd-68ae0700ec87@efficios.com>
 <ebc70e9e9ad4a7055286d0db93085536ed070a6f.camel@redhat.com>
 <6b542d40-8163-4156-93af-b3f26c397010@efficios.com>
 <f76f6c3a-a1c1-4bdc-bc0b-f419446cac9b@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <f76f6c3a-a1c1-4bdc-bc0b-f419446cac9b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::34)
 To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPFA592641BD:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a77116-e863-404d-c966-08dd51f309ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajYzNHgzc21tVzAxejZ6aGF6MXBMWGZ5SGx2QS9BUUdJL3NIcFFzZ2xKSVB6?=
 =?utf-8?B?djZCbXBwNWZUOENsS1EvU05BbENxbytoazlyZjNVSDlSZWNVdlREbWRvRnFG?=
 =?utf-8?B?czg2YUpxNzNNWDkxMTVyY2hSeHJKdFpRZDRXVFZoTDlkN1FNWGc1T3NnVFB5?=
 =?utf-8?B?d2lyQnhWU2daUTlFc1lzbEdQblRSZXFETWdudGwwQlBvRS9rdW14dUFwZHZJ?=
 =?utf-8?B?MDNqWTBPQTVRRTRac0NmcTRFbGZSaDNoaU94RkRuYW5uRU8xS3RTakpsYXNj?=
 =?utf-8?B?TFkxNGI0d0ZHTENnVjlQSzZzVmdwMW5ZaEoyY0ZJUER1VmwvRnU5T3RSWnNH?=
 =?utf-8?B?TUszbDJienR6VlR5dWJISUZWOC8xOTgyOHdWa1JOMW13ZFZhcUVoUkhhY0E5?=
 =?utf-8?B?SG5Cdmk4TUtkTjdYS3k1UmhucDFYYkYrK2RwNE93ZUdxM3lOTUg1TWMrb3l0?=
 =?utf-8?B?ZEN1Zlc4MzFBWXRDRk9WQUMrNFM4UThRbmpEZDROcmFZZmN6VWtZNFI0Yi93?=
 =?utf-8?B?d2NzT29xczE1YktxajBMb2FrUUo5bC9SWFpNR2RKYjZESmV1WGN0V056ZFNP?=
 =?utf-8?B?Mmd1Yld2WE5MMXh5dmNVTE1lMExBUnJDcEQzUG11aitlWkpZQVFMZS92TnFP?=
 =?utf-8?B?MXN0WFRSU3ZwOFFTYm1CZCtiM21ZMWlRc3NYSWxDYnYzU2h3R2ViUDgyeTA5?=
 =?utf-8?B?VFZTbmVFSjR6YXNvRDZmMzdLN0ZYcEc2RURlNmNQUW1XT0Y2UHVJOXowM3Aw?=
 =?utf-8?B?ZnpQb205bzJoSFEvVHNOanNFbE1jVWYrQjEwZFJYTzJZT0tFenFiWnpzMU0z?=
 =?utf-8?B?ZHpWZDN1bGw1MXJHSXI5QkE2VWl0U2tnMWpUcWh2bFZlQjdJQjJpZnhCcGVm?=
 =?utf-8?B?RmZJcWJzM3lZRTVZSXVxMFFPSWNJU1JtSHB3ams4YlBuQzAvTjlnWCswZmpm?=
 =?utf-8?B?MkxzN041TnZuN0dkbzV0TjlLOVA2S0FSWXNxK0xqbkpmZ0NTY1NpNlQrbzd3?=
 =?utf-8?B?eGFCV2UxaGM0RlVKbFJjT1FCMlZKWFVMMC9CZ21vN1RCcGlVOFQ4dGxDZmlH?=
 =?utf-8?B?cy85NitnWm5BMDhSMFBOYTMyN09iQmg2ajYrbzhYeXJUYzlpdG9IbTBqZlN4?=
 =?utf-8?B?b2E2MzF6Tm9SWkdJTm1Ba2tOUXlGQThjZHlkeFpLelUwdElIb0tGemVMY0tV?=
 =?utf-8?B?bXZPQjZJYUVaMVRrV3h2dlpXY250b2VpbmVkYStCOTFOd2lFc3hMVmJwMXdX?=
 =?utf-8?B?MExPa2h0RUowWGlNT2VqSFBqZjZmK20wd0RvdU95cmFNRVJsTUJ2cENrbEU2?=
 =?utf-8?B?RTY4alg0a3lFTTJFTTBCYUE3dE14L2RHZlF4ZXhGVmFLTmJic0hoVTBvSXFD?=
 =?utf-8?B?V3RuUXJ0Vm5SNEIwVlNXY3ZyYzdaeWZoTXdWVzA1SFk5M3ZSQnptOUszcTJu?=
 =?utf-8?B?eDdtYVNOWndYQjZCSTBkaG1wUzN2U3poanVXS09ESEMzdS9FMEJlUnQ5TUpL?=
 =?utf-8?B?TlNqdVZVeS9pZHR0VG1Gc0tOTDVTay9qMU81VHREVHhUajNLSXlWeXhKNjVq?=
 =?utf-8?B?WnFNWnQyL3V5cWNVQVpiS1BUVFJTNHNXaWxxOXpHRVFpb3ZsMTlyU2luSnZl?=
 =?utf-8?B?ZktyaXgxb2R5NDBnVHU0UEI2RmZFT1gzZzl1VnN6UEJwM1ZUQnZBUUlrU3dy?=
 =?utf-8?B?ejVXUXpBMTlXcVVrMFVrdURFKzlzTHkrWjN6Z2lFNWdsMGxSQmJMUGVtK2FZ?=
 =?utf-8?Q?TRmhU7o/AKO1gXmHjePNktY6IZq472lwlHMDgdz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW14dW81ZmhwTkd5dUwxTXJBNHZMNi9QZnZJZWk3RDlTU3FySHREQmZHcTVH?=
 =?utf-8?B?WStnR0ppdlBMb29TMUcrNnpORTBhZkgyZjAxRW5RMHhUTWd2bmdMN2RhUkNR?=
 =?utf-8?B?V2I4dmNjNXgyWGRoYUNjNEZYQW94RG5JbWdmanVpOTBPODZwYkl4TTdWVTJC?=
 =?utf-8?B?RG9HOHBLV013dGVOWE5ycjNzTUZRYUcvaitvUHFuYjVvNlJTNjZIdGl4WllE?=
 =?utf-8?B?cVpCaThXZjFGUlhxM1dZRjdKUjA2VTl6NkdZaFg5RVdZYzFTV0RUaVVVWGlm?=
 =?utf-8?B?bU5QZ2tOQStuR1BkQzMvNHkxT3VNVTBQaCtkSHJmYlM0cHlWMXVlV1JyQkxP?=
 =?utf-8?B?Z3IrTE5wVEFlWEFRK01sYUpvaWloUjcyYXhkb3UvVmNCdkF3Z25OM3o0Wm9a?=
 =?utf-8?B?SitCZXNNblgrbVprYjNRb09oYVBqWEJCWmZPVzA3YXpvQmRSelJVY1F6ZjhP?=
 =?utf-8?B?bXNqdlpIRmoyQ2VKSVFkQ1MrL3diZVlINGdwOFZrNmhuamwrRVhZNFF3OHVB?=
 =?utf-8?B?NkNIT1pldjhiNEZkbm1iZE1hdlJGNDcwbkNvekRSS3cyNVQ1MmY3UVVXME9D?=
 =?utf-8?B?dFg1aVA4eGFYa1hrWVdLQ2VBUjVlekJQdDJ1K3ZPZExPRjV6SHIzdmRrbGdQ?=
 =?utf-8?B?WENjRXQ5T3lNbG1yWnBCUFFHalZGQ2tPNm4vdlZPYnVGWEl1UGgvOENqWThk?=
 =?utf-8?B?WitQazFjV0IvZndvaVRaNUV5WEtEOXg4RmplK1A5Tkw0UDFRcFVYajkza0ZE?=
 =?utf-8?B?bU1XK3BtTnNIaEtaYzhLRDJPaXVWWXk2RUwxZ3kzMG0rNTEzTlhPR05raVhJ?=
 =?utf-8?B?NXdqTE1GZmhJeHRCbzhkaU11U2pCWUhxNVRtQXhiZGZ5c0UzckYvQ3A1VGxl?=
 =?utf-8?B?RTA3VmJMUzRhTk92S09jMDhUTXhaeFNsUTBZQ3J5Sll2NEJvMmdRajVHVk03?=
 =?utf-8?B?WDhZMmsranRxZkJFdkJCdlE5b3V4Q2xQM3hPdGN5d08vZlgveVlSYzlBYzZt?=
 =?utf-8?B?eEdxNWJST1lYeVQ5WVptK045Q0hQWjgzQUppaUJzMVRza2YyRENBeWRoeS9O?=
 =?utf-8?B?WHNGcHBQMkczaWRjS2xyZjdVaXh5dU1MbnFqUStxYjdHL1pncVFmalNucjNi?=
 =?utf-8?B?SFRhRW85cXZneVpaWlNxK3djeERBa3ljb05jL3BZMTNYb2xhd1c2Z0lkbUVC?=
 =?utf-8?B?M1ZXcXhuNS9Sb3lmZEQ2eTh5OWxnOWdoTnhrK21jMDVuQjg1U015aU1EeUJm?=
 =?utf-8?B?algvamJWaUdlREtjUW5iYnpSam4wV3Q0ekNudGZrNzgyOGxxaVVXcmxqdzhz?=
 =?utf-8?B?dWNtcnJMN3ZqZ09XYWptazdoNkdQRTVWQm1RN3Rjck9wWlhTMHorMmRzOFZq?=
 =?utf-8?B?aGVVMWp1cmlVNkVqOG5HaStLQWE2bnltTE11bzFzTURFTEdOOVVIYmhVeXpE?=
 =?utf-8?B?a3Y1bXdyOHhHVXVHR3ExSjZxa3Nlejk1U1cvZ2E1NzNyeDJhV2xCWW5PcnJl?=
 =?utf-8?B?MVFYcUlCYUZpU0lyZ3Z5UVJFV2NkS3NsZG9VWHNCOTdkSk5kcDEydFBLY1lu?=
 =?utf-8?B?T1JOc0Yrd3FyMDlFcUZkNmhneDRuMDBEdDlTVmFOcnlYYXRkdHZZc0JkcTFF?=
 =?utf-8?B?b0llRnJoWGpWNTZ2REp1OGJRcUcyZWdVNXc1Z3Jza3Fmdmo4RkhETDgzbThM?=
 =?utf-8?B?S3ZUbkhtVmZiWnZ1alZJSjlyaGZyREFZS1pybHBJbzIxaDZLZFBoS2RBVkd1?=
 =?utf-8?B?MUpzUzRiNm53SzJGakc3aUpsWUx0NUVOVkdGTHBza3lSY1VkQmV3TDdTeEN4?=
 =?utf-8?B?dWs0WTNwbSt5Z3N6czkwbEQwWE1IOEVscDJpV2lFZUJtcTNqWWRLKzVTMTNC?=
 =?utf-8?B?NHlpQ3doazdjbVhKeGprV1YvMC92OHJ1dFdUV2V5bGdKb2xUcCs2VURrMlNi?=
 =?utf-8?B?bGIwekFoNG5rQ0lycGZxTEgvM0R0Q084aDdybzY2Z2ZxcUs3WUdMZGhFa3da?=
 =?utf-8?B?NEc4clA5bTYrdnBiWGx1QVdsNmQ0djM5dFlBTkU5eGZIRzBaWGdpTFdTY2dv?=
 =?utf-8?B?azdPdzZRY0txOXVWMTI3Wmg5bCs1MkNrOXNtNXh1SG1ZZ1liWGFiMDVXd3lF?=
 =?utf-8?B?dzZRK3ZqYmJyNVNETDB6OHdvb081MEZETENLMVJScXltQzdnd1ZJcGJ1Q1M0?=
 =?utf-8?Q?R4htWYATgLhAivc/P8uL95k=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a77116-e863-404d-c966-08dd51f309ef
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:10:44.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2dUhMULAcLDL9HuwVyt85e/WrR1d6ZKo6lgOd1q26vBVbBHPiPtVGJOVQ01iIFa4S5XMwNaTb2nUP+Neib3/pBZSFikryGo6VkvyLQqs6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPFA592641BD

On 2025-02-20 12:31, Gabriele Monaco wrote:
> 2025-02-20T15:47:26Z Mathieu Desnoyers <mathieu.desnoyers@efficios.com>:
> 
>> On 2025-02-20 10:30, Gabriele Monaco wrote:
>>>
>>> On Thu, 2025-02-20 at 09:42 -0500, Mathieu Desnoyers wrote:
>>>> On 2025-02-20 05:26, Gabriele Monaco wrote:
>>>>> Currently, the task_mm_cid_work function is called in a task work
>>>>> triggered by a scheduler tick to frequently compact the mm_cids of
>>>>> each
>>>>> process. This can delay the execution of the corresponding thread
>>>>> for
>>>>> the entire duration of the function, negatively affecting the
>>>>> response
>>>>> in case of real time tasks. In practice, we observe
>>>>> task_mm_cid_work
>>>>> increasing the latency of 30-35us on a 128 cores system, this order
>>>>> of
>>>>> magnitude is meaningful under PREEMPT_RT.
>>>>>
>>>>> Run the task_mm_cid_work in a new work_struct connected to the
>>>>> mm_struct rather than in the task context before returning to
>>>>> userspace.
>>>>>
>>>>> This work_struct is initialised with the mm and disabled before
>>>>> freeing
>>>>> it. The queuing of the work happens while returning to userspace in
>>>>> __rseq_handle_notify_resume, maintaining the checks to avoid
>>>>> running
>>>>> more frequently than MM_CID_SCAN_DELAY.
>>>>> To make sure this happens predictably also on long running tasks,
>>>>> we
>>>>> trigger a call to __rseq_handle_notify_resume also from the
>>>>> scheduler
>>>>> tick (which in turn will also schedule the work item).
>>>>>
>>>>> The main advantage of this change is that the function can be
>>>>> offloaded
>>>>> to a different CPU and even preempted by RT tasks.
>>>>>
>>>>> Moreover, this new behaviour is more predictable with periodic
>>>>> tasks
>>>>> with short runtime, which may rarely run during a scheduler tick.
>>>>> Now, the work is always scheduled when the task returns to
>>>>> userspace.
>>>>>
>>>>> The work is disabled during mmdrop, since the function cannot sleep
>>>>> in
>>>>> all kernel configurations, we cannot wait for possibly running work
>>>>> items to terminate. We make sure the mm is valid in case the task
>>>>> is
>>>>> terminating by reserving it with mmgrab/mmdrop, returning
>>>>> prematurely if
>>>>> we are really the last user while the work gets to run.
>>>>> This situation is unlikely since we don't schedule the work for
>>>>> exiting
>>>>> tasks, but we cannot rule it out.
>>>>>
>>>>> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced
>>>>> by mm_cid")
>>>>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>>>>> ---
>>>> [...]
>>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>>> index 9aecd914ac691..363e51dd25175 100644
>>>>> --- a/kernel/sched/core.c
>>>>> +++ b/kernel/sched/core.c
>>>>> @@ -5663,7 +5663,7 @@ void sched_tick(void)
>>>>>         resched_latency = cpu_resched_latency(rq);
>>>>>     calc_global_load_tick(rq);
>>>>>     sched_core_tick(rq);
>>>>> -   task_tick_mm_cid(rq, donor);
>>>>> +   rseq_preempt(donor);
>>>>>     scx_tick(rq);
>>>>>          rq_unlock(rq, &rf);
>>>>
>>>> There is one tiny important detail worth discussing here: I wonder if
>>>> executing a __rseq_handle_notify_resume() on return to userspace on
>>>> every scheduler tick will cause noticeable performance degradation ?
>>>>
>>>> I think we can mitigate the impact if we can quickly compute the
>>>> amount
>>>> of contiguous unpreempted runtime since last preemption, then we
>>>> could
>>>> use this as a way to only issue rseq_preempt() when there has been a
>>>> minimum amount of contiguous unpreempted execution. Otherwise the
>>>> rseq_preempt() already issued by preemption is enough.
>>>>
>>>> I'm not entirely sure how to compute this "unpreempted contiguous
>>>> runtime" value within sched_tick() though, any ideas ?
>>> I was a bit concerned but, at least from the latency perspective, I
>>> didn't see any noticeable difference. This may also depend on the
>>> system under test, though.
>>
>> I see this as an issue for performance-related workloads, not
>> specifically for latency: we'd be adding additional rseq notifiers
>> triggered by the tick in workloads that are CPU-heavy and would
>> otherwise not run it after tick. And we'd be adding this overhead
>> even in scenarios where there are relatively frequent preemptions
>> happening, because every tick would end up issuing rseq_preempt().
>>
>>> We may not need to do that, what we are doing here is improperly
>>> calling rseq_preempt. What if we call an rseq_tick which sets a
>>> different bit in rseq_event_mask and take that into consideration while
>>> running __rseq_handle_notify_resume?
>>
>> I'm not sure how much it would help. It may reduce the amount of
>> work to do, but we'd still be doing additional work at every tick.
>>
>> See my other email about using
>>
>>     se->sum_exec_runtime - se->prev_sum_exec_runtime
>>
>> to only do rseq_preempt() when the last preemption was a certain amount
>> of consecutive runtime long ago. This is a better alternative I think.
>>
>>> We could follow the periodicity of the mm_cid compaction and, if the
>>> rseq event is a tick, only continue if it is time to compact (and we
>>> can return this value from task_queue_mm_cid to avoid checking twice).
>>
>> Note that the mm_cid compaction delay is per-mm, and the fact that we
>> want to run __rseq_handle_notify_resume periodically to update the
>> mm_cid fields applies to all threads. Therefore, I don't think we can
>> use the mm_cid compaction delay (per-mm) for this.
>>
> 
> Alright, didn't think of that, I can explore your suggestion. Looks like most of it is already implemented.
> What would be a good value to consider the notify waited enough? 100ms or even less?
> I don't think this would deserve a config.

I'd go with 100ms initially, and adjust if need be.

> 
>>> We would be off by one period (commit the rseq happens before we
>>> schedule the next compaction), but it should be acceptable:
>>>       __rseq_handle_notify_resume()
>>>       {
>>>           should_queue = task_queue_mm_cid();
>>
>>> Another doubt about this case, here we are worrying about this
>>> hypothetical long-running task, I'm assuming this can happen only for:
>>> 1. isolated cpus with nohz_full and 1 task (the approach wouldn't work)
>>
>> The prev_sum_exec_runtime approach would work for this case.
>>
> 
> I mean in that case nohz_full and isolation would ensure nothing else runs on the core, not even the tick (or perhaps that's also nohz=on). I don't think there's much we can do in such a case is there? (On that core/context at least)

In case of nohz_full without tick, the goal is to have pretty much no
kernel involved. So if userspace depends on the kernel for updating its
rseq mm_cid fields and it does not happen, well, too bad, userspace gets
what it asked for. Having less-compact mm_cid values than should be in
that corner-case is not an issue I think we need to deal with.

E.g. it's similar to missing scheduler stats bookkeeping with tick
disabled. I don't think userspace should expect precise stats in that
nohz_full without tick scenario.

> 
>>>     or
>>> 2. tasks with RT priority mostly starving the cpu
>>
>> Likewise.
>>
>>> In 1. I'm not sure the user would really need rseq in the first place,
>>
>> Not sure, but I'd prefer to keep this option available unless we have a
>> strong reason for not being able to support this.
>>
>>> in 2., assuming nothing like stalld/sched rt throttling is in place, we
>>> will probably also never run the kworker doing mm_cid compaction (I'm
>>> using the system_wq), for this reason it's probably wiser to use the
>>> system_unbound_wq, which as far as I could understand is the only one
>>> that would allow the work to run on any other CPU.
>>> I might be missing something trivial here, what do you think though?
>>
>> Good point. I suspect using the system_unbound_wq would be preferable
>> here, especially given that we're iterating over possible CPUs anyway,
>> so I don't expect much gain from running in a system_wq over
>> system_unbound_wq. Or am I missing something ?
> 
> I don't think so, I just picked it as it was easier, but it's probably best to switch.

OK,

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


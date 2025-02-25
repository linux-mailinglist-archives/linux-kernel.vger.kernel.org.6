Return-Path: <linux-kernel+bounces-531620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 540F5A442D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03510175CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E983D269AE6;
	Tue, 25 Feb 2025 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kvppJQ8x"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021091.outbound.protection.outlook.com [40.107.192.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1F42A97
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493730; cv=fail; b=rbKSUpPjp835CU98tKhg4hxrMcZpN/Oy6amPRGRf7F7NbGmwD8yiWm1annFq3euX5nmTdWVDon4pO3oTccyr9t1jYi800+2jxGHHivtORceRlb+ce46xTeFavElway2QsOJKeSK2LXGspIOstVI7rLxRFybdaWWsjZvqaI141ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493730; c=relaxed/simple;
	bh=NLedShEBoy3jg1RSEM42r/YtzgMSjV/n5Qd9aQEw6SI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CCL/bu1ygutpqEfTZz4e5n1bvg1BbEDG8IcMdjgsyGtE0PDw6kSm6JIsXNooerpxzian0VhbMN3PdXkFJhKupPYkiWBX9ZnJgLXYVTFg20i7m7Xh4O8eleTE6PDSEPgqyw6FUDUdD+Tol+/5Xwx7u3Ux47Oe9Z/sDhKFWH5wXTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kvppJQ8x; arc=fail smtp.client-ip=40.107.192.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+MqiUp/hVXmkOdxHg+MVs80CLpRhptcG1jEKahIji+Xy2QrFNoPMtJ6b171kat4kDvXI6eVKOzS6coBEKWW/dCLPY7HdFtuJzp/CeZ5iPDtdpg4E6LjH/FYUxskCDWqIbt95WL5cgipEIjYWvqZ361XURqXddmvwfct4hPPkSph9jDX2mwP1fEstqF1vGHUMMmdEdN7YpcGzg2iNwjawvR/HbU2tRd0xa0ZzBTKqN5qRIl1ox8XqTKq+CmW1rM8AcbT8GyS+UnR4DsLeTFGrRCX6qyw01qtKJb4zY1EOd5lcIIGRjWf+imN0IbyWD1VyMW8lpD+Mdd5L7hdbGhEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi8XVGJqjhfzH7N7iXaxqbYwM6drSz0HybH7nD2Tc94=;
 b=EKIkqZinqZV34+jiPsJ0BMbURiqm0yeGU60jQId4Qxia6RjTgZKaUTGX2VYVh1w+QwKea1+3QSf1FOkZ4uG/DAJVVOOMWSHmCltCp9m8aqlBZ00QD87hxMDs1SiNmDvf+s8Bu2MmD7uV+7hsZ3j9RJNyGyEvVJ2tsDOZmj6JkdOcL3HJ7DCHYb6hWdib4OvxrgWkj0R5p5/OMkQ4anw65LEUo/c+4XB3TMKL715cDWxr3tNT/GqfV7Aojp3DevCc1kFPUHJRGSWAD+ZZWmo4kj77OxArZtWLNBN9SW4aNeBwzjGADV+tTZ7CTb/keaYVaLVvnMYb8dVBdI46uzM2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi8XVGJqjhfzH7N7iXaxqbYwM6drSz0HybH7nD2Tc94=;
 b=kvppJQ8xKaZaRQiI7jY1csrLisw0U4789LZlS4USYPaWHvbXISeRNRDlqXn1OnmeJLRCSC+nTSZ+0cGm90nHuhr1fyvexXIR5pDrCT0+eOR1mbo86yg1sbMMMXsdFcjp9uLVE5LBRixg0ZYfe7qbaJj6vBvmMx2qNmpLKHFLXNzVQZLtS0d6w+0BxXeH4sWjOXtx70AkV3pesFzxRpgNPEKWi4c9tBEiNMBIYl1mkb2VzzRMbXgEvfk9p7U3rgLfzGE4+ym+Zc6iTDhnx1mlMKvgQYnkVXdQ5QJlfDce8cskMHwvngN5oNV8e24N0TTPGoNYWLfDuKnESh+M90cCZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5920.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 14:28:46 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 14:28:46 +0000
Message-ID: <b42dc8d7-2f2e-466f-bdca-0d532a0d5928@efficios.com>
Date: Tue, 25 Feb 2025 09:28:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] rseq: Make rseq work with protection keys
To: Dmitry Vyukov <dvyukov@google.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1740403209.git.dvyukov@google.com>
 <4e93f7da6dfa450d488fafa3599306349e6e34e8.1740403209.git.dvyukov@google.com>
 <b18e6478-ef4b-42b3-8cc4-42467b3a0a7f@efficios.com>
 <CACT4Y+YxmkW6opFVJFOOFd=c73gz7yFvwBBCnjMndj-jffjBCw@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CACT4Y+YxmkW6opFVJFOOFd=c73gz7yFvwBBCnjMndj-jffjBCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca0b132-400d-4d1b-d787-08dd55a8b67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGs3a09PNFdXTkFJanhKOVF4cGxFYXM5YXA5c1NKUnFaTDZUNjBCb3RCVEo4?=
 =?utf-8?B?Q1VyU1RQbXBTYjZUVFFSQ1RGcGFiRGFGam5iM2I5bmlyTDIwOFl3ZDdRaUxP?=
 =?utf-8?B?QUZ4V2wxVEpocmF1b3pMdHpZQmFGSHJiR2lOL1daZ0Q2eTRBVDVxWkdZYS9E?=
 =?utf-8?B?NGlkUUU0ajZtYXVSTmZEL1NNOFA4OE1jM09OVWIyV3NhMk5lY1lvS2ZEQkpM?=
 =?utf-8?B?Z1VBY3ZmNGh4UC9ZNVVtWnk0SERmRGpNaHk1Wk96Wk5VL0hNcUpESnYvNjdr?=
 =?utf-8?B?bGlWS2p4VU04U29pMjF4aVpVc3poY1RXcDRzRk9Qcy9RMmtCSlh0amljeDdz?=
 =?utf-8?B?R1hSZGhKYVlaTE45UkRjRndiVGk4YVNqL1poeEpUYXo1WTRpcElPNEZVdm9s?=
 =?utf-8?B?YkswYjN4YW10ZHpCWWJyeHZZb0RXNUs3Qm9uTG9XS3RDUU42N0lnWlRxQSs5?=
 =?utf-8?B?aUpNWVEvMDBTaDFhcWp4bXFuYmJjQ1haOGEzNVJHK08yLzdnS3BubGozV082?=
 =?utf-8?B?eEpxU09yRTlabks1alNUNVp1K3lSSUd2S2dMZlY2WlFrNlZUcml4bit6TWpN?=
 =?utf-8?B?MThmSnVTU1REa2hjMlgza0xkZ3F0OFFCMWgrMys4RUZESDNqT3J0T0dheEVp?=
 =?utf-8?B?WlJma1BPeFBZNmhSK1c1K01FbERta2lnQ1dadlh4QSt2N3Jxdm41WGN4dTIx?=
 =?utf-8?B?djliZ0pMMzQ1UkhLNktTbm9BZVVlc0lEZERxbWFDdWc0VVQwd1JqQjBVUW1E?=
 =?utf-8?B?MDAwb3NJTzgrVm5tNVZSVDZMTWI0c2R3V0RsQXNPMWlscHdjZVNxUWRDQlBv?=
 =?utf-8?B?QlJVYmFvdUJLMVNtd3lqaTl1V1lqRDR0SUJobm41N3ViRmdsai9taGhadlhQ?=
 =?utf-8?B?cllvQU43Zi9Bc29nNUs4MG9nYUZoSnRBWnlOSGhCRWtXN0FHYVZiNEFVbG03?=
 =?utf-8?B?dE01UEZwNDdBTTJRcWJtanZHb1Y0K1U4ZmVSeUZBeVRMZEhpaUlhZkd6MHF1?=
 =?utf-8?B?YjJSNDFaa2pwcGN0UC9ERHZrNTNJQTRrUlZaakhkNnFnOW1NSXJnbzNCTis2?=
 =?utf-8?B?Z2M2c2hEbWFoaVg4OU40dHh3bVFCN05HR1RVTDV5eGFDQ2RkMjFwUlJLN0Fh?=
 =?utf-8?B?dGEveGhnZjRpL3lPc2I1SldaNm00OWZCOFV4ZTZyQ1FBRVNHWWZ0SGp3NFVq?=
 =?utf-8?B?dUJHdkxxUE1MTU5VS3pNZ2w4SEZDNnc2QjJETDMxZnJRRHhtMFRXYUVLdmU0?=
 =?utf-8?B?ZHpJTVJVZTVnZ3ZWNlF6MXpWTTc1V3EwVG9MUHlqZzhwcWZSakZwTEdVTy80?=
 =?utf-8?B?VEFrRUplblFtRmZQRXBKd1QrSlMwcktnTHdZMU8yUHV5U1pRQmFQWW5mRWd3?=
 =?utf-8?B?c0NMT2RCWGVvOGhZRTNNUGMxYmVGV2pVbFFzL0JYN3V1eGs1b1FqaU5RS3pB?=
 =?utf-8?B?NW5QeUNWK3E0ZXVvQWU3WlkySjA0elU0Nm1DdGdQZ1JBd3JDaTlXOG9yTVM0?=
 =?utf-8?B?K1M4OGIra2ZiSUpNL3l4aFpUa05JQldyNFNFditscGRxNG1JQ3h2dVZrd1NI?=
 =?utf-8?B?UDcxajVDdmljMFZyMVpaYlZnVU9jbEFqMjdLSU9CRnNFWThEWGRYK0doM0s3?=
 =?utf-8?B?NTRQcVIweFgyRnJFeFIrK3VKc2owT3dTQzYzOVBMeTdNYVc2cDQ0dW1WekxH?=
 =?utf-8?B?TmRPMmtzdHFDTUIvVTAyaktWaXhRc0w0Nkg4K091QmNodXhocmk4UkROTzdp?=
 =?utf-8?B?VEs2UllGWFB4dkdRc2hENDhOa1FEdURNV0RXdld2UFg4SmJvSjFOYjNOc3Yv?=
 =?utf-8?B?cm90cE9DbVEwOWFEalIzZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW9WRVhlUThEc0FPNVVIY3dWdmFkSGlIY0hwdUN0Z3RBZU9xek5NeTBEVnZI?=
 =?utf-8?B?YW9jMXQ3dWFjSlhhMzY0TGMyUVJYZGl1UVpWUXVQSzhJWDAwRDlxMVkrNlBB?=
 =?utf-8?B?U3BuSjBRR3B0Sm9BZHZSN1VWWnhsSHBoRGRreDFpSlZ5cGlvSXg3UU1RT3Fm?=
 =?utf-8?B?VFdjUEpNeVV4eXVzUVpnMkxCSHJsd0J1emhxOU95ZU9qV0FLSkM1S3JsS0pk?=
 =?utf-8?B?bmJodk85R1NSbW1PazNrV3g3OGtnUkdSMGRNdlRNTTRFZ29udVRLZ0tWQ0Y2?=
 =?utf-8?B?Mm5DVGNQL25ZSkJWa0xlanpHSEEwM0tzK3k3Tm5kOERNWk9CeXFVRGtKV2Vr?=
 =?utf-8?B?eXJwejF5b1RYelVEVnRzNmI2MkZ4ZXlCaHRjWmNQcERYRHdKNWV1RjJHTWI1?=
 =?utf-8?B?eEFGRElYUm9BNFNTTHY1RzNMc3VFL2E1RjUreGZSOUlPUmIyUHNtZzZPWEV4?=
 =?utf-8?B?R2xzVXNNTHZiVkZFdmdRQzFMUW1YSTNLYVczWnZhNU0zU0tZRGVNZEpzT2ps?=
 =?utf-8?B?dkllQmVxUEkycUVHMmdvcXZLN202ZUc3SlVsZHVnL1FtcytGa1ZHNXdzRDlw?=
 =?utf-8?B?V1ZPSzBFRXNZMnJLdzJxaXJRM0h0dkEyMkIyOEIyeHpoR2prdkJrbjR4YlFs?=
 =?utf-8?B?dFJ6WVczN3NIMVhqVHN1UE9NN2JVdjF0dnFIQ3d2NndrTjV6M3VEUVRNRE51?=
 =?utf-8?B?RHdzd0hQWG53bnl2NWJWU2xkTCtLUUw4ZTFGZ0VPemVtemNvMlR4M2UwQjd1?=
 =?utf-8?B?bUNwSVdJYmFFaTVCdWpqeFMzVklGMjJoY3ErM2wwZU1odFBzQStTWUh1Ujhw?=
 =?utf-8?B?SDVIUm5tOFV1MFlzajduZjBpaVNKamtlRnlyenV6QVhORDF4SjE3ZkFVQThI?=
 =?utf-8?B?aHdUcG1lUUMyQWMvK0NLNFJrRXVnQ1FjNHlreHpjajJZUzgyQ28rdWpCWFoy?=
 =?utf-8?B?WnBrSXgwalFYL0dwaHJwMjQ2M000RmVIRERLWmliNlFiZXlSMUtnc2kwd2RM?=
 =?utf-8?B?M2NTMEF4alJjalprV2xiUFJ4SDBINXFjZU5aRCt0S0hJdG92ZHpVWk00NVpI?=
 =?utf-8?B?TDNUakNMd1M5ak0yejAyd28zWk44QUJVMTJ4UWRwZ2NDVHNmTTdqenNEejJo?=
 =?utf-8?B?c040Y3ZzT2ZDNTRTM2N0TXdnSnhGMi9BWnk2QWJReXdHcUlxYnBqY0cwdWhW?=
 =?utf-8?B?OTVkdHU5SzNPU0xkUjU0NmhOYVFCZ3ZYTWJQN0J0UDYxTG1rb0FHSUNWR2Nj?=
 =?utf-8?B?OWVMRjBuV0VLQnhGam5jUXQreEQ3WE1Cb3R4bDhPS0RJU0EvUGFnazZRSHlT?=
 =?utf-8?B?anZjaVpXTDlyd28yelFoT3lTclE2ZmZHOEFtd2RrM0ZNMjdyNGJQWXRaeUFl?=
 =?utf-8?B?d09rRjFKTk5JMHA4UHR3aUdPVWs3WElHMWFTdmprVjE4dVZNS00wRFJsc0Ry?=
 =?utf-8?B?SXZmRzJwdVdtbGJZUWMxbjQyTDlNMGl0VW8wanp2UlJNSHcvT2xhN1dzMzlB?=
 =?utf-8?B?MXFCcVNacTEzYmpGQnpjc0FTNzg5NVJqcWVSZUlrVVhJSC9FSnRYRVM1Sjlp?=
 =?utf-8?B?QTRaVkdxME5xOVZXY05LVG51NGlEQklvQk9USXlXVmp6elJndUYzbWxObGtj?=
 =?utf-8?B?am81bHpkbVZTNlB5WlA3QTRUc05CN2JrK0Q3L01UeE4xOU1PcDdkaG5VWWIy?=
 =?utf-8?B?bndqNHFCVXJqdm5DdW9ScktCMkFhd0hRZmR3aWxndGh2RnJkWEtaUjNVQzc0?=
 =?utf-8?B?Z2ZhNkN6YUtJTWpZUHBUeFNyM2ZuTVd1QmNaMWhPNjJMUmErZGFsR2x4cTAr?=
 =?utf-8?B?Sld5WWc0UEdBM080SjFMT2djMTRZMDN2V2JuTEhDYzFyWnk2WW5YeGNLdDQz?=
 =?utf-8?B?ZWpmYUR4dzdrMkZNUm52cE5xbUtvdDNlbGY1QlBlOXE3THFNZjBkd0VyNVJC?=
 =?utf-8?B?bHdNU2lJZDBKSENUKzc4WnFDdkRCSlZOSkdMYUt5RDV5WFR4R3FGam5GZi9I?=
 =?utf-8?B?UDBlNm1jQW85RHRyTmtsYlZ0TU5aOVF1ckhCdDJoY2JZb2JVWmpRVWYxZ01M?=
 =?utf-8?B?UmZqT3ZQMm53OVJBblJuTjBPOWRKcStJbzlvTGhwZklzUUZLWDVRU1BWaTBX?=
 =?utf-8?B?amZBVDRTNkJNeGU1azNQZE1kUmRhcXFEaVZIclh1TnBxWk56Y0h3TkgwVU04?=
 =?utf-8?Q?oNe/kD0211J9J1ZzMVj51vc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca0b132-400d-4d1b-d787-08dd55a8b67e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 14:28:46.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5Dw9elqfAu+OponCA32umsGhZXqVgI/52xoKfSQhELxGAdJvjZnLcwWSM+JewYBvCMroIx7Wq5nMjx2mYXuQfwFHlIlvC/U0Ic/bxlPZ8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5920

On 2025-02-25 09:07, Dmitry Vyukov wrote:
> On Mon, 24 Feb 2025 at 20:18, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2025-02-24 08:20, Dmitry Vyukov wrote:
>>> If an application registers rseq, and ever switches to another pkey
>>> protection (such that the rseq becomes inaccessible), then any
>>> context switch will cause failure in __rseq_handle_notify_resume()
>>> attempting to read/write struct rseq and/or rseq_cs. Since context
>>> switches are asynchronous and are outside of the application control
>>> (not part of the restricted code scope), temporarily switch to
>>> pkey value that allows access to the 0 (default) PKEY.
>>
>> This is a good start, but the plan Dave and I discussed went further
>> than this. Those additions are needed:
>>
>> 1) Add validation at rseq registration that the struct rseq is indeed
>>      pkey-0 memory (return failure if not).
> 
> I don't think this is worth it for multiple reasons:
>   - a program may first register it and then assign a key, which means
> we also need to check in pkey_mprotect
>   - pkey_mprotect may be applied to rseq of another thread, so ensuring
> that will require complex code with non-trivial synchronization and
> will add considerable overhead to pkey_mprotect call
>   - a program may assign non-0 pkey but have it always accessible, such
> programs will break by the new check
>   - the misuse is already detected by rseq code, and UNIX errno-based
> reporting is not very informative and does not add much value on top
> of existing reporting
>   - this is not different from registering rseq and then unmap'ing the
> memory, checking that does not look like a good idea, and checking
> only subset of misuses is inconsistent
> 
> Based on my experience with rseq, what would be useful is reporting a
> meaningful siginfo for access errors (address/unique code) and fixing
> signal delivery. That would solve all of the above problems, and
> provide useful info for the user (not just confusing EINVAL from
> mprotect/munmap).
> 
> But I would prefer to not mix these unrelated usability improvements
> and bug fixes with this change. That's not related to this change.

I agree with your arguments. If Dave is OK with it, I'd be fine with
leaving out the pkey-0 validation on rseq registration, and eventually
bring meaningful siginfo access errors as future improvements.

So the new behavior would be that both rseq and rseq_cs are required
to be pkey-0. If they are not and their pkey is not accessible in the
current context, it would trigger a segmentation fault. Ideally we'd
want to document this somewhere in the UAPI header.

> 
> 
>> 2) The pkey-0 requirement is only for struct rseq, which we can check
>>      for at rseq registration, and happens to be the fast path. For struct
>>      rseq_cs, this is not the same tradeoff: we cannot easily check its
>>      associated pkey because the rseq_cs pointer is updated by userspace
>>      when entering a critical section. But the good news is that reading
>>      the content of struct rseq_cs is *not* a fast-path: it's only done
>>      when preempting/delivering a signal over a thread which has a
>>      non-NULL rseq_cs pointer.
> 
> rseq_cs is usually accessed on a hot path since rseq_cs pointer is not
> cleared on critical section exit (at least that's what we do).

Fair point.

> 
>>      Therefore reading the struct rseq_cs content should be done with
>>      write_permissive_pkey_val(), giving access to all pkeys.
> 
> You just asked me to redo the code to simplify it, won't this
> complicate it back again? ;)

I'm fine with the pkey-0 approach for both rseq and rseq_cs if Dave is
also OK with it.

Thanks,

Mathieu

> 
> 
>> Thanks,
>>
>> Mathieu
>>
>>>
>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
>>> Cc: x86@kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
>>>
>>> ---
>>> Changes in v4:
>>>    - Added Fixes tag
>>>
>>> Changes in v3:
>>>    - simplify control flow to always enable access to 0 pkey
>>>
>>> Changes in v2:
>>>    - fixed typos and reworded the comment
>>> ---
>>>    kernel/rseq.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>>> index 2cb16091ec0ae..9d9c976d3b78c 100644
>>> --- a/kernel/rseq.c
>>> +++ b/kernel/rseq.c
>>> @@ -10,6 +10,7 @@
>>>
>>>    #include <linux/sched.h>
>>>    #include <linux/uaccess.h>
>>> +#include <linux/pkeys.h>
>>>    #include <linux/syscalls.h>
>>>    #include <linux/rseq.h>
>>>    #include <linux/types.h>
>>> @@ -402,11 +403,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
>>>    void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>>>    {
>>>        struct task_struct *t = current;
>>> +     pkey_reg_t saved_pkey;
>>>        int ret, sig;
>>>
>>>        if (unlikely(t->flags & PF_EXITING))
>>>                return;
>>>
>>> +     /*
>>> +      * Enable access to the default (0) pkey in case the thread has
>>> +      * currently disabled access to it and struct rseq/rseq_cs has
>>> +      * 0 pkey assigned (the only supported value for now).
>>> +      */
>>> +     saved_pkey = enable_zero_pkey_val();
>>> +
>>>        /*
>>>         * regs is NULL if and only if the caller is in a syscall path.  Skip
>>>         * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
>>> @@ -419,9 +428,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>>>        }
>>>        if (unlikely(rseq_update_cpu_node_id(t)))
>>>                goto error;
>>> +     write_pkey_val(saved_pkey);
>>>        return;
>>>
>>>    error:
>>> +     write_pkey_val(saved_pkey);
>>>        sig = ksig ? ksig->sig : 0;
>>>        force_sigsegv(sig);
>>>    }
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


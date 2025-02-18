Return-Path: <linux-kernel+bounces-519678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76AA3A09B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC5F67A2B15
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E79F21A453;
	Tue, 18 Feb 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="B9WqJVAr"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021078.outbound.protection.outlook.com [40.107.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFBC286A1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890673; cv=fail; b=qy3LoEm6wJWyoTkwhCjSmfPwGkiakxy+PdiLJmt09p1n0fbo57ZBhxUB0Orv6+2t2qnQxWrxK3QUq6EM7hNuc8nX3OOGsLPRjqx1LKU/SY4Uh8KOuXk0fP2lQpISTKfiW5WU9oqruId3DDJj9C0HSCGWhW92pLSnekz73dqPnQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890673; c=relaxed/simple;
	bh=7tfdS6AMwVkKQgk2gwJbsnnSYB+1dRsvAdZERatFiEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bv0NaCwdUNd2TT05NEeUsU51w159dGNoAWxpAUR4jU3S1UDvpQsHsnq5K2/yohd8qE99nr2oO0voTniSxjpWljIXsmO9ojipub9naNlHqMj2VW26IkCrT1ATLkZAynPYMx+S+pOm1/GkWc8NQNg40a5YBnXY8qCpu1h/WuVtLfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=B9WqJVAr; arc=fail smtp.client-ip=40.107.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TueTmrAd1WlhCjpdCiTyGX+t0O4TDZM/axS8lrHIkV98Ulfj48UCnfmW6ey/sKSoLCNqyTzYdCI1/KJvrjaHScVUVHfykpirxlZoTeEcaq0iamxvVzkvmE2TvvlG0pBCRPJ8GqkMdpLqe5jnyy9ooJc3H6ouTC6lOld+tMmJ1VSsaOrtEQIlDo6+oruVuWoy/U3V7ZjxeX/92SkQj19SR+aPqPfbWTYhpAvKXmE7JMLtTlnmZ/OlwFAgN8O6IRDS48y0nsvc6WV7OmXNgQ01BxkjHbNrZ0hjdmfX1OqZzOvyJuLT24gtL2v4E0gOMnc224R2o9BIvwnv6Hku5/kvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhrpq5U5C063rBcrfUFbUHSsj65KR5YUdmFHhK/tDAg=;
 b=J5tsrYuMN0GrvGN+0Jw2KUJmheMe2t7XG4Gyyl++GASXw9eUqRiwjikZZIiT8uIw803bjwbEu0OnKAmSdlvFZ+Fg2K0yz77Mcc86xj8RSD9dft/dbDFrzzOTMzh41aU5Dq+QjDYhTMIzfW8eguVyAnIPYIKkwUjR62oyybsIG4i+mEgvIFgMmvt7dbdFF1cDciNrOj3Dyd9gvPBcUlU4RCfoAzkoCgQp6k6P4az1gf09ZpgUEop2pE6nUKS9jOhy6VlPzJL/pCSwuYzI18BmJYzw7/3DhkZGPRWqrqS1/5g14CVnl9pKyjE9urj+hZF3rm0rZUEZqpvauT+nF8a6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhrpq5U5C063rBcrfUFbUHSsj65KR5YUdmFHhK/tDAg=;
 b=B9WqJVArcvTFdBfxG6gkiORv3ZzyqACFl5XNrUEUCM0rhifWpNfLYWfezbCIbZVGbfJ3mFJcyzjeDEYy5eoGtqjHisEBDHOKgsRgHpsq+V7+VEc4SqAHYA/0PBjlKDPIeTR6jhB6ofA6bOQkqMnArQnoExlSM2eU0eXFjcwneU3LNExgFekN0vokMQhZaqETguqYfFyBqO5ps+PUbMSW6+jIp9gGgWXJuMOco/zPdZsO8P0VhgY7L3pd1ES6tv7NESHd27MJh7r/VqzwpQpMSJYQ6oiNLVejEj+sGfdZJ9x+VhrqiUaGk6Y8tjaWbYPakVtjBJOPilGhR8nyRkZsBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8899.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 14:57:48 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 14:57:47 +0000
Message-ID: <cf7af2a8-c004-481b-ad2e-6aa991aacb67@efficios.com>
Date: Tue, 18 Feb 2025 09:57:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Dmitry Vyukov <dvyukov@google.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <f68741e0-0cc8-4faa-8144-e1786b9591f1@efficios.com>
 <CACT4Y+Ym7=9mLS8b=Rq6cyHMgyboMqh15nqkRfgru-qFVTx_0A@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CACT4Y+Ym7=9mLS8b=Rq6cyHMgyboMqh15nqkRfgru-qFVTx_0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0280.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 009cdbf4-4484-4e11-dd6e-08dd502c9ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjE0YVNWUm5hSlJqdlE3TmJTQzVpZXI0RkFIRko0VXQyM2M0aHA0N2RoT29C?=
 =?utf-8?B?VmZ4QTF6bW5rSzdGZ2J2RnQ5Wkc3eEk0ODlKYXVXdk44cEduSFd3SFZZUFNh?=
 =?utf-8?B?OHkvYko3d3lmbXBjcmw4WXlBMXlpUHRGTVE1VUtkNkdRd3F0ekpwSW9TVk0r?=
 =?utf-8?B?cXZOaEVZcXJ6cWlLUGdMa0I1R2FxaHVzMnZ1SC9TMm1mbTlSL2FkazgxVGlC?=
 =?utf-8?B?OUl6aTR1QkR6K0xJdW11NG1kckZjZW9Ic0xUSVFnTGRpUnVSWG9ZZGM4aEh1?=
 =?utf-8?B?T0pGTnJlWkIwNDd3SEtvczVCTG1kSndzOTNuMTFPdmdYNnZNQWt2akIycncv?=
 =?utf-8?B?N1ppbXFqdUE4eWZIQVJ2ODBXQ21NOGttT2krY0tEZ3pUSFpldnBlUUY5blBz?=
 =?utf-8?B?aGhla2V3OW43WU5ZMnZva1hGVTI1eVBObXc4TDNENzhoOXNhNDVyRUtVczZN?=
 =?utf-8?B?NmVvbDVSWWoyWlAvTW93WDFzMGJMenhhRU9QaFdrMXpiUGV6NHg4N1VMODBZ?=
 =?utf-8?B?UjlvbGJkUHlpUWJSRjc3eDI4Z3lBaFA1N0FwNXdSakNXZFFsaCtEd3ljTzJ2?=
 =?utf-8?B?dVd1WDZxR0NBRDgvd1hHVk9neDIzUW5pYmFHd3k1emh4TWxBRkEzd0YwSEw3?=
 =?utf-8?B?NWQwMFAxc3dMNUNQeVUwdVN5QTBkNk04THU1VE5YYzhSMXBRNmtGUHN0WUht?=
 =?utf-8?B?WDZhdTlJaTc1Z1ZkZ1oxdHBXNTJSMG1vY05sMzVXRElFMU11TmZRSXpNNXRk?=
 =?utf-8?B?UG9SSWMreXpOM09zcmVlNUsxdVppMDRWelhlN0RFa2FnOXo0VGtGMC8zNVNw?=
 =?utf-8?B?ZS9kY2lEdEN6c1dXQ2pqVkJ6S0VSWXk1Z1JIOHZTT2lEMU1Yckw4RkNDZi9S?=
 =?utf-8?B?STVqeGluZ0xsNGNlc21iTWJLMUVHT1NQRm5saUVhVm1RY3Z0bllXT1VlWDBn?=
 =?utf-8?B?ZW9vNVZiVThMbllUa0UraTJHYkthTlhZeVI5cTU5N3JEWkNZUTNRRWNMblBG?=
 =?utf-8?B?OWNEWlNoR09zY1cvdzZiUGlob0hXa00yK2JVK3RVTEFnV2JMWTQ2b3h5ZEdt?=
 =?utf-8?B?M0hFV3Z5L1NqcVJVdXJHQWU4Rmw4Wm14NFh3TGFlR25LdnR3TW1FakJkbnE1?=
 =?utf-8?B?N1E5SFJpekU0b0x3RGsrYkNLZG9IMzhTNERHQmU1b09SbW14eVphN2g3MWdr?=
 =?utf-8?B?RXhCNEdhcnlkSDVBUlZzVEVnajlib0hkcDRGOFA5VUZiNkNzMTliOU1JYlVv?=
 =?utf-8?B?UXJLcHVtYVNKQ1dPa0lwRnFsVzhXbk9qN1o5VkVhR3BSRW9udE5lb1ZXUkpl?=
 =?utf-8?B?ODRjdkIrcnZYWU9jbjdyV1I1Yy9tNXNkWUVXeS9vaWRaK0lUSkF1VDdsbnhm?=
 =?utf-8?B?ZjI1SFovdW4rQ29ZVW13cTRLMWNobE1xaHJpckVtVzd3R0VjeWhCaHFSK09Q?=
 =?utf-8?B?UjJjM04wM0Y1eFEyL2N6OXVkUWIvOFlrdDVldmJwNkt1dEVEOGpNSUpJUmJ4?=
 =?utf-8?B?cUJ6elNndklxZkhtQkd1TXBQOGI0bVZBU2ZqKzFyWHVpQkd1U0pHcU11RE1P?=
 =?utf-8?B?RVV0OXlWbUxHSHZSbUZXMGVnNkViT293dGE2WlBCVDR5bXZkb0x3TmY4aVlx?=
 =?utf-8?B?Zm80SHJuck9yWi9mek05TFAzSTJMU0Z0cVVKR3lNZWR2N0xoZW5KRUV0ME5r?=
 =?utf-8?B?TTZDUjAyMEtaVUVSYytJVFh2cUExSTdHK09rWkRYaXpHWjFrNStpa2JKd2tn?=
 =?utf-8?Q?w+77zzndLBTsZZ8B6/4paXDlVo7SBVxV5HX27H4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlNRM3ZQSWVkazY2UzRJTTJXRkpuaEdlbVlYcDNEY2R6NVdXRFVWVUl2c0NY?=
 =?utf-8?B?VnI1VHBieTkwWVhKOTEvSjJGWlB5SzlWWGJaOWdyeVFEcDROZFJmRzhqbWVO?=
 =?utf-8?B?aFQySHNvQllSWmc1UEplVzg2VEJZeUNXblZHYTdTNE5nS1RBNEFpRkh0cGFH?=
 =?utf-8?B?SElaeEFWTW83elZERmUwZFVIZHN1eXVuNXJHTVhha2JHOWU2dzJFLzMzVStj?=
 =?utf-8?B?ZjZWcmZaVWJYaStQN3AvSGlLc20yU2Npd3Q3b2pqTTloK1NSOElOUC9ROTlO?=
 =?utf-8?B?dW9panBVRTVvWEV6cHY0U0ZKVmVEdE4vYW9aOVFFeG5uTFlMcDJ1Mzljbzg0?=
 =?utf-8?B?MzF2eEZyNDhYRi9zbFRqVS9tajVMVHZOQmowL3dJaWc2Sko5cjlQK3JManAw?=
 =?utf-8?B?dHAzbUp3VVdSOHIyS0R6Q1RaczVtbTlwcDBDV2JUdERvZjJSbzFNelVkalNK?=
 =?utf-8?B?MmN4dmZhTFBBYzNob1RrbnVZeFczVUs1ampkYnUwK2NDLzRGMGVwSHNvYjRi?=
 =?utf-8?B?Vml0QURwdyt2S0hDWHZlVXVySWxnUDh4bTJrZ0xHYzd2Y1dDRHVhM1F2S3hN?=
 =?utf-8?B?NmFsVkFscU1GRWhjV1FFMm81cDFLT2t1TTgzaDRBOW91cjE2L2piQjFDZlho?=
 =?utf-8?B?VGVlVlB1V28xZVVEaGEyT1h0RldvV05lMkFGMjNzeno4OVpub3U4cFc1QTRt?=
 =?utf-8?B?ZUV3MnpjRlJKUDgzTklDZE9uVjBpaUxVRzcxbXdKYjNSeUVieitwTUZCaHdI?=
 =?utf-8?B?S1BsUG9pL3JqUkpsbFZkQzBtYTV6UUdnU2RPSTFyY0xSZmY3WGhIT2I5Tk5a?=
 =?utf-8?B?VDFtMUFqKys5TUFiRnpPODhTSisreFdrQ2h1UnJ5SmdmM0R1aGtiYjk4NWl6?=
 =?utf-8?B?MklXS2s0dnU1My9SMTZOUm4vL2UvNno3ZEZzSjh1WGtNQzJNYTR5SUd2WDVi?=
 =?utf-8?B?OEtpSDQwaFgwYjRwbWxFQkxhVmk0WGorRTAzUm9LMlhJbTc1b0ZQbm5QUno4?=
 =?utf-8?B?bGRpMmJ6YkpuTTJ1Q2pwRDlXK2hzd3NrMDVMYjQ3TVo5Lzlwb2Y3ZE9MVm9h?=
 =?utf-8?B?bnVHT1FDSWlBUEVmVzFDUkZyalZWUGh3SHdETlgzejNiTWdtQW50Mks2Qlhr?=
 =?utf-8?B?MTBIUDd2cW54YjRtVXFuRGlCQlVFTEJkbXdRVnVNSEVSWDRCdmk2VytmbGMv?=
 =?utf-8?B?U3R3aW1IQWdNRGVaQ25iSEZyckd4QU1DM1VvOS9sSDRFYUJKZ1VlamFkcmhP?=
 =?utf-8?B?U0dVWW9NajR1MWw0SWV3V3BqRCs5QVZCSjBOYXczMTdFcEtEcHBIT3IxVFo3?=
 =?utf-8?B?M2h4WmQ1RVVhVldTZnhUSlNDWlFMbzVhc1paQ0FWOUdBY0pzeTBiaDcvWDJt?=
 =?utf-8?B?d2I0cVVyOFh2K1dtZCthVy9ZYXFFaUJFaVZmUG9QSGJMUTlXM25KM3BSM05Q?=
 =?utf-8?B?Ym54L1JrRUsvNGZPcHkrdW5TbFgvOS9QNlhNR0VGYjBHOWRTNkNDUlVnVzFy?=
 =?utf-8?B?U1U0cVRodWtOTlVwZmE2RCt4MUZ1bmJtelE2QnRkSENxQVYycjJFVGJMTm1w?=
 =?utf-8?B?QkFYcGRkbTI3Q2NjZW9sOEpqVmJJNnprRE0zSGUxWE1tbi94VGtOS0lZNlNE?=
 =?utf-8?B?MHFkdHZMZ1BZRkM2NVRLaHVid3cvaDcyRXU4cjhJditiSlgyV0dQdkdjUEpt?=
 =?utf-8?B?ODhQWDhCNW5lUzNzTVF5S3lmNmJUaExmbklxTGJrT04zTVd4YW14dEZMWWtT?=
 =?utf-8?B?M3dJU3BCM0tkWm5PSEk3U2ZidFphdnFsZjRUTyt1VC84ODZ0Q25KZGx5ckZ0?=
 =?utf-8?B?L3ZNYkViT3dxc3AvQjdnT2tFYmFrYTB0VU92bGF3YUFrN1RWbkk3dXo0blMv?=
 =?utf-8?B?eVY3WXFwTkdEMW5vVFN5cWNTZ25vc3pOMzMvRi9OY0tTdFJ1SGhpemc2MWZL?=
 =?utf-8?B?Qy9kWkduVEhLQUIwemU1dUcxei8yRkt6c2l6RFVZd1lJN2ZjTWx6NlJ3anJ4?=
 =?utf-8?B?cklvQ0xsU3ZDcy9pMjVVbWlyQS9ReGxTVUVicWtZbjg5MGt1RFMzKzZaOCtm?=
 =?utf-8?B?OEdEZWdxZVlHNmJyamJZZzBhQUhUTmpRZTQ2RzJiWEY4ZW0ra2FBRWdUeXpN?=
 =?utf-8?B?SjRCREw2TVBBTG9lWkFSemZVRnVpaTBhUkdwYWlOUVdkQm5KR1h0T2RjcjNW?=
 =?utf-8?Q?W+ss/3l8K1YHn5vvKNwz/Y0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009cdbf4-4484-4e11-dd6e-08dd502c9ba8
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 14:57:47.8343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWSOa4xcnV2rp09o01nRI7OZbfW9OCHQVENfHmr8wB1zymXT7QkEFzHH0zoqG03Ki9AExRBLmhoKTsEnsKIQirlTB1FAomtSebSYX1yYnhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8899

On 2025-02-18 02:55, Dmitry Vyukov wrote:
> On Mon, 17 Feb 2025 at 21:21, Mathieu Desnoyers
[...]
>>
>>    we still let this function read the rseq_cs.
>>> +      * It's unclear what benefits the resticted code gets by doing this
>>
>> restricted
>>
>>> +      * (it probably already hijacked control flow at this point), and
>>> +      * presumably any sane sandbox should prohibit restricted code
>>> +      * from accessing struct rseq, and this is still better than
>>> +      * terminating the app unconditionally (it always has a choice
>>> +      * of not using rseq and pkeys together).
>>
>> Note that because userspace can complete an rseq critical section
>> without clearing the rseq_cs pointer, this could happen simply because
>> the kernel is preempting the task after it has:
>>
>> 1) completed an rseq critical section, without clearing rseq_cs,
>> 2) changed pkey.
>>
>> So allowing this is important, and I would remove the comment about
>> hijacked control flow and such. This can happen with normal use of the
>> ABI.
> 
> Thanks for the review!
> 
> I've addressed all comments in the series in v2.
> 
> I've reworded this paragraph to simplify sentences, but I still kept
> the note aboud malicious rseq_cs.
> 
> If we would not be circumventing normal protection, then, yes, these
> cases would be the same. But since we are circumventing protection
> that otherwise exists, I think it's important to think about
> potentially malicious cases. In this context inaccessible rseq_cs
> values that resulted from normal execution are very different from
> malicious onces. Normal ones will point to a fixed set of real
> well-formed rseq_cs objects, while malicious ones may point to
> god-knows-where in an attempt of an attacker to do things we can't
> even imagine right now (e.g. rseq_cs overlapping with protected crypto
> keys).
> 
> It's as if a particular instance of copy_to_user would allow
> user-space to write arbitrary kernel memory, and memory of other
> processes circumventing all normal protections. In that context we
> would need to be very careful regarding what we actually allow.

I'm considering that we should clear the rseq_cs pointer whenever
userspace issues pkey_mprotect.

This would ensure that no legitimate scenario can trigger a load
from a rseq_cs area which has the wrong pkey, and therefore we
could accept read/write from/to a struct rseq which has the wrong
pkey, but kill the process if trying to read/write from a
struct rseq_cs with the wrong key. This would prevent userspace
from making the kernel read/write from/to memory with the wrong
pkey through a pointer it controls (rseq_cs pointer).

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


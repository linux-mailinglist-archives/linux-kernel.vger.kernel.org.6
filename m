Return-Path: <linux-kernel+bounces-542194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24269A4C6FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C6E7A49C1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C7523C39A;
	Mon,  3 Mar 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="O5OlGHuP"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D962459FF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018321; cv=fail; b=SqiUCiSJLfmj0DysOPOYM9ZoNrCVUt2VBHktARJ7MnXy+g+u98JP6O3tTvAW/ee221HOl8frU1tHEIUcNDlE/+QImDQ6t+j6Kt4x+MqpeqIT2JacDjKfIzdS2I+hF0RYba0RSRUH6RZ5KVi7UheQ6lYRokZThdj0JgsEa6vqLEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018321; c=relaxed/simple;
	bh=CHE3f1gfSzU/Km1vxXwtXBMpcXlLIKq2QP36teTUq5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=imbNqpabStCXXVUphNoXYqX51LHumMPZChb2gm4Cs9hHJUC/rHJ9U3vqPabzjaOVCRYIu45PdOJ/4NuBgKI0Jm7mQ1x1X51kD95QLPSNfS/gJeAfFDGuQ9+QPpd/GsTAT6I8v/GAGY0Ro9jmuKOPHh3HkjnTlTubdeu9qziEWBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=O5OlGHuP; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlnTwvL1Atbka3wWAh0ODM/o0Jt3dKRiQ8og0wumrlGNfqPQbiXzA/Qs+NKT5fi0/GFcjC3g+GTrkU1j1HRTWop0+nCVjEQ546f0IiWKzxxDoFhDxBrRO1e12AKf1VH38Mhp5GKeT+CAaHGdCrz/AEUNsl8M5ji+94uE+odJeGHk0LFjue7AzrWj9sLSLb2JnQ0DhIbOwU7bWk/5a6sGNSTMhgDYO79ViFKTPWhfo/IkuiuaapmmWFWZGn9SdI+4kapYnjbqVgnbkvQyvHumC+kBh3SHHduGhdT02EFkPN9gUmAPVNyz0nH8W77rl4Udh1mnnMC2ydHB5/QeYs1a8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouHRAumFx0mH5rBTE3RjlTszOxscOV2ebWubtD34ong=;
 b=jqQDvnkvAeUGqiKdNRfQXAVSQXxKGZqHv7RNgvKunDRrBsKVrYusSTPwr+ZAIb3hOQaQw1p711ziDOdTeuezWEXY+8TwxfoC0o7elQNimYAEz/7QY1RWlvSCoB69hTesYdEDFhk5Q1mIEKCNZYZSoxk1Eh0pyu6BQBM0icgQnmVr1rloS6ISuRw0OYaZ7SNRx2YFaAlh24tkjmWHaMvMfI1I2AQlftHujSVVzBSPFHq2IfWrKKVwxdi6ytaKLOoHtEFgNI44iSVllkGtxP72Msvqx0x3BiPrC5OAxKy6ukuJl2G0L9yTklU97BsRdDbX67U/WHWUhw8co+MZJ8Cuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouHRAumFx0mH5rBTE3RjlTszOxscOV2ebWubtD34ong=;
 b=O5OlGHuPYH+GzIS9OPTdIR3kiLQyi2p+ZLJFy5/q5Kl5oGT0SClyn/Oh17ptm8zJc2ZS8hFbW3Ch6bMsSYS/Y3JYOi0LWNvBt/cNwSNsHYxi+nSCQIpewirD8B29wlUr1Juz+dIyGhibHDkTSNliFoZ9CiJ/3/l2epghw6aC18VF+euX8i3KFndqi9Hb+EgFsNJPYr/5d7SmotHXTvys9B9uPjUftDUuYwQxOIxej0Ej7alEu0ZNFu3tLNQc6LVeiMK+N5/u3DxNQdZmBJ5tKc2OpR56ooTXxG1bvrXKo/hWz1GlDWP+CmZVzQxqidUq0MI9g4R5dDWBSxNxVkkP1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5639.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 16:11:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:11:55 +0000
Message-ID: <044407f2-583b-41f3-9ec0-ede74477cb3d@siemens.com>
Date: Mon, 3 Mar 2025 17:11:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/gdb/symbols: Determine KASLR offset on s390
To: Ilya Leoshkevich <iii@linux.ibm.com>, Kieran Bingham
 <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Andrew Donnellan <ajd@linux.ibm.com>
References: <20250303110437.79070-1-iii@linux.ibm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250303110437.79070-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdb3eb7-0fdd-40d2-9b99-08dd5a6e1e10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2ZUdVZxQlNzYjJNanJOc2ZLeVQ0N21wK1hKZXhmc0swMnVLd1lSQU90SzZl?=
 =?utf-8?B?dGw0NTg5N012TDFwTE1OVHd5cmZpemtMdnhjcis0RktaS3R3ams3Q3lESzky?=
 =?utf-8?B?RHViTVdIc1dyNmd3Uk1Fa3I2WDBlM0cxMlJSWEZYd0wrYWxkY080YVl4eDR1?=
 =?utf-8?B?bnQxNlRrY3M3c1JlT2thT2huWmtFNjlSUzdWa2tZTTdTaStvTFJVNCtJcGRs?=
 =?utf-8?B?cG4vUzZlOU1DVWhCMStaNUZ1OUllUjdLNmp2eERuWThBd0drR0h5aGxnZmhu?=
 =?utf-8?B?RnZEOFRtM1FkTlY0Tkg1ZjYxMGpGMlErWWNKWVlSQ2h4dGtFakFSNFdtQW5D?=
 =?utf-8?B?L0ZyOGhFNnBpb1YwYVdxMEh1LzcrckhNN1hLeVNDWU5BdUhoam9qNGQvVVhs?=
 =?utf-8?B?SEUzdlRIL2I2TXlTNDVPSHhqTWswUHlHaFE3ZjVHZkxVc2NiazMrQ21tdWhw?=
 =?utf-8?B?U1pEMGRqODZxc0xNcmJkSWR6MUdJNjNnT3pVQzdYR0M5YndrT3VUa0VHV3Q5?=
 =?utf-8?B?SmtBKzdObzNTdkRvZmVpQ01FYWxrNTBXYmVlMGZKYU5nWWhCVlNoMmE5QVNa?=
 =?utf-8?B?QXZueDlHSWxvbFJLb0V0aHAycVQ2ZkpURHYzb2VER3Z5RDFjZ2VkWVBJRlZx?=
 =?utf-8?B?TE1lS0FXUHJNZCtPdmh5Nlg0ZTZpVi8vU2FvOEdtR0UzWDRoNTBSVE1oUHZS?=
 =?utf-8?B?OTlvaFY0eVZzeHh2UktiOWxDOCtqNitUYmpKKytRd2R0Q1l0U2dudGIydE1r?=
 =?utf-8?B?dnMwNU5LOWEva2RUWHN6UTBJMklXOVFVQytSdlRsOUpsZlhJUmMwcm5EOGFK?=
 =?utf-8?B?b25rSGFDNlJsQk9yUUFNY1hmNk5xM1k5a2QrYUcxMUMrdm8vaXFxMmN0anVq?=
 =?utf-8?B?STB2VWlnaS9UNDA3MzVObVVIWkxaVndKY0tZZzhaVEtMb0MrcVZsM1hIWWQx?=
 =?utf-8?B?cVJCTUNXVWxXbkRxdDNHMjV1a2RGUW5oTWNXOFFlczNKWmdaQ2VNbmQ1bzYx?=
 =?utf-8?B?Nnp6M012OGN1RVRzN0R5c3lWelVKY3RuRDBMcnRrdlRwM1NjVmpDT0tCYjgv?=
 =?utf-8?B?Z05ML2JqbnJnYlluS2pkMTFWcjRQRVVIakdXMFFsSEtFdVBQZytjYnptdWQ1?=
 =?utf-8?B?bmxvQm8ySWZiWit4MEpnemNyUmc0MU1odHQrT1V3TGNIWllYVnVrV25rcE1a?=
 =?utf-8?B?SWt5cllsRVBvcE83dEhBeTNuZnI2MUJVU3VZdTlZYkJYNVNON3Z6VWRVMnZ0?=
 =?utf-8?B?YjFWZmZkT215bWhMbHZhNUpnd1BFOFl2TXRmYzRSN1pDWVlyc2cvZFNvTkhT?=
 =?utf-8?B?Mml5am1vV3lZeFhDeHIxWHJLWGYwTHZzMDI4YUlsYzRuWjk1Z09YcjRRa3A2?=
 =?utf-8?B?VG5oYmJYY1NLdmx1aFI4ZW85WEdUUnA2VlJvYTMveVV0VTNnOWV3dGh2WWMv?=
 =?utf-8?B?NDdUY0lCVlhnRXJNRlpOM0dyUGdNelBGUGFQbms4NlVDamxrY3k5aUxQb000?=
 =?utf-8?B?VjF5bnJmZzN4UEhxTFlPSkVXc2tpenRTeVhweTNxZDdhUkRJdGVqTEVqV3o5?=
 =?utf-8?B?SjU2Q2JQa1luVmcwYVlsVTNBRDdWWTMwb1hNcFdRVzVURERicUh5bDQ1eW9t?=
 =?utf-8?B?bkpqeVRUMkl5V1ExRnVNVy9UaDM4dWFDUjB0aDZYRk0rZ3dIbFBYRjJweXZW?=
 =?utf-8?B?UVhqanZ0UkZQY1ZoQ1RFUm56a1FwRHNwNG1lMlZZZ2JPejkrTE4yOVFGeXZq?=
 =?utf-8?B?Z1RzYnh4Zm1VZVdxeE9VYzBMRUJHMDdaZVNqN0V1WmRCaTlCRExuWWV2aTM2?=
 =?utf-8?B?djVBOEZFbWpTTDl1S2RRdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0luWkVYS3d3Zm9RMFUxSm1HSGp5QndjY1NrTk5aeDdBL3k3RDdWYmxyaUNY?=
 =?utf-8?B?MnB3b2tsZ0xxNUZUZ01mcHlDN21ZYjZsL1hTbWFvbkx6M0FzNURaK1RUOXpU?=
 =?utf-8?B?bXh4VVVhZmo1cGM4dFBGYm91SVpsbXhhSEk4TVpYVWl5c1RudUVvZnoxM3E2?=
 =?utf-8?B?Vk1SbEQ4eUU0LzNtWGNOMjNTblhqUElhSG43T0JkeGI5WnpWZlBjdkJaYWw5?=
 =?utf-8?B?MkN5akw5RXVraFNHUldITEExaXVyY3B2Y2NSMjI1bHVaMURZWlFoMDZPQmFt?=
 =?utf-8?B?MTUvQWk5K1dhWmJKOWxuR0luM1NKbGh4dnhEcHRZcHlkalU5UmhocHl4NUVq?=
 =?utf-8?B?V1ZRTmFqdHd5ZkVuRC90Q2xTVklxRjRJekhhUmFqTFJUaTRYNHhhdjFWRHZy?=
 =?utf-8?B?Q0I0M3NLeERsNDVDajRqQTY4RHdZZ0JTcnFZTEJIWHd6MzdxK2RtR0lxMjVH?=
 =?utf-8?B?cFM4TWdTYjNNc3RyZXpkK3cyUGhTQmNyQ08xMExmMDBJQTJwazBNM0RPTzVM?=
 =?utf-8?B?L2FzUzBUdWNpL3MxdEwyaTkydXJDcFNlaktRSHVRS0grYmlkaEhpZXkxMGtz?=
 =?utf-8?B?enk5amp4L3B0M280ZHBZT3JhWEcwZ0wxTWp2TktQS3FKVk9wQ3A5Slg0eFNF?=
 =?utf-8?B?UWJEUlduVzZqZGY0cklRczEwS1luQUhuMC9RMEw5ZFBnWHpOSHZPN3E2bDJ2?=
 =?utf-8?B?UGlDMTRVT2RhSTBXZHIxREdhcHYwc0NyRko0WlR2cENoekNjbVBOQXV4Y1dC?=
 =?utf-8?B?L0loZ1pWODF3U2ptcEd1dVhGYThaWEN0OHRyRkpGeU5TdFpxeGpaQ3d6THJa?=
 =?utf-8?B?RVVBWDdYNUk5RzVBWGNsbzVjZ2QrMDVUWGRBZHNKWVEyMzVxbnBMQjM1YjBm?=
 =?utf-8?B?VTBwblJrMkd6bVVIMXBaQnZPVkR6bnhRUGcycXJweU1TTEF6NGtwVXBqTU44?=
 =?utf-8?B?Q1F0NnFNbGJmZkxXMm9HaUlHRXVzVVh2eWlkSjVDd1lKbzRqVVRnMVdCSyto?=
 =?utf-8?B?emorRVhvaUpXRUd2YlZuOFpuYmhPYlZxTTV1dXA3S1NoMkVlYXg4Yk1CNENh?=
 =?utf-8?B?enFMS0xHaU40UFVobURmcnBNcXlLZC8vSUlaTE95ZVVPWlk0dkNMSm16QUdE?=
 =?utf-8?B?bkdZaFpRRzAwV2tYMjIwbloxdjV6SkVtODN2WVNNeklCaXZWM3ZkZC93WGN6?=
 =?utf-8?B?QXNsdGtCd0JvOU1iZ2E2WmhnRE1LQlltaTJ0Y0RsbEhTNkYyQThrMjdDU3Yy?=
 =?utf-8?B?a3AvR3IxS2U2SWMxU3BjUHZzeUVqZ25LbnVNcExYbmJxVXRzRmVBb0J1c3Ji?=
 =?utf-8?B?QjU1WWF6dkN2b1MwV2RnWE0xTmYzTHlOaDczV3V5TmpvTUVTMUx2U0xUVkZq?=
 =?utf-8?B?M2pzNk5Ndk5LeHc4OWN0NmJmV3Fjb1ZDcG53Wm5PaUFySE5aM0cveVVIT3ky?=
 =?utf-8?B?SG15SjE1VDlwc1RBbCtLeUJSa0pTbFpnRG5IVkV3L2w0V1k1N1BTcnZGaU5v?=
 =?utf-8?B?NGlJazlSRHh5V1pYbEJiVGtIdnF1WDBYeVhZWWlneHYyVHcyaVloNGRLdEdP?=
 =?utf-8?B?anFZMTlvVjVUc2NYZWdKR2dkTEhMTm8xS201TmxqYkFJRHRQSCtabGFwd1Ba?=
 =?utf-8?B?NCtmeE1aSHZZeHFYSzVPWGtxbEppbXgxeFFCNG13Rm1YV1pSV2R2eVdhVE80?=
 =?utf-8?B?OEIyWnVVQzR1Tlp5c0x0emd5Zkg0U0Zsc00rNUg0OXNFVlRsN1BaQk9MWmNu?=
 =?utf-8?B?MnFtMjA3OVgralRGam9OWW9TTGFwWjdqd3g3YUtTR1BqZlhRWVhpTk94dkF4?=
 =?utf-8?B?L1poWm9WREI1ejdlUUQ0cUMwcXNmV2s2SVl5K1c0NzA3WGVGS0RBcGRTWC9V?=
 =?utf-8?B?cFkrK0NlOUhmRlpjV0I4L0FpQTZGZndGakRHeEhaSXd6dllYYkNOVkx1RUQ5?=
 =?utf-8?B?N2I0QTZ3bDJvQ05iYml3blpURGJHU1QwczA0RHROZGNsN1QvSDUzeTFldW9n?=
 =?utf-8?B?VUsvRzNVczBaNkdsK04rNzdhL0NoVzlzbXJpcnR3Y0pFMzh1ZlBIU3pVK1E4?=
 =?utf-8?B?YS83K0dRNllML3hCeE5sejdTblZEY084dVNsT2F3eUVDWElkWTNiZ2NsaVJR?=
 =?utf-8?Q?SSMvPr2kP7ux22KGdcpLzM0Ia?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdb3eb7-0fdd-40d2-9b99-08dd5a6e1e10
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:11:55.5290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56qv9alKJZFus9mM/Y4QgdWGlEON1zCMI6Xd2tSV/wOSuum/JTnArSYAVuQZp5o7Uo9EaolEiSsve/Ptz6H9rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5639

On 03.03.25 12:03, Ilya Leoshkevich wrote:
> Use QEMU's qemu.PhyMemMode [1] functionality to read vmcore from the
> physical memory the same way the existing dump tooling does this.
> Gracefully handle non-QEMU targets, early boot, and memory corruptions;
> print a warning if such situation is detected.
> 
> [1] https://qemu-project.gitlab.io/qemu/system/gdb.html#examining-physical-memory
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  scripts/gdb/linux/symbols.py | 31 ++++++++++++++++++++++++++++++-
>  scripts/gdb/linux/utils.py   | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index f6c1b063775a..3126329c7f26 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -14,6 +14,7 @@
>  import gdb
>  import os
>  import re
> +import struct
>  
>  from linux import modules, utils, constants
>  
> @@ -53,6 +54,29 @@ if hasattr(gdb, 'Breakpoint'):
>              return False
>  
>  
> +def get_vmcore_s390():
> +    with utils.qemu_phy_mem_mode():
> +        vmcore_info = 0x0e0c
> +        paddr_vmcoreinfo_note = gdb.parse_and_eval("*(unsigned long long *)" +
> +                                                   hex(vmcore_info))
> +        inferior = gdb.selected_inferior()
> +        elf_note = inferior.read_memory(paddr_vmcoreinfo_note, 12)
> +        n_namesz, n_descsz, n_type = struct.unpack(">III", elf_note)
> +        desc_paddr = paddr_vmcoreinfo_note + len(elf_note) + n_namesz + 1
> +        return gdb.parse_and_eval("(char *)" + hex(desc_paddr)).string()
> +
> +
> +def get_kerneloffset():
> +    if utils.is_target_arch('s390'):
> +        try:
> +            vmcore_str = get_vmcore_s390()
> +        except gdb.error as e:
> +            gdb.write("{}\n".format(e))
> +            return None
> +        return utils.parse_vmcore(vmcore_str).kerneloffset
> +    return None
> +
> +
>  class LxSymbols(gdb.Command):
>      """(Re-)load symbols of Linux kernel and currently loaded modules.
>  
> @@ -155,7 +179,12 @@ lx-symbols command."""
>                  obj.filename.endswith('vmlinux.debug')):
>                  orig_vmlinux = obj.filename
>          gdb.execute("symbol-file", to_string=True)
> -        gdb.execute("symbol-file {0}".format(orig_vmlinux))
> +        kerneloffset = get_kerneloffset()
> +        if kerneloffset is None:
> +            offset_arg = ""
> +        else:
> +            offset_arg = " -o " + hex(kerneloffset)
> +        gdb.execute("symbol-file {0}{1}".format(orig_vmlinux, offset_arg))
>  
>          self.loaded_modules = []
>          module_list = modules.module_list()
> diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
> index 245ab297ea84..03ebdccf5f69 100644
> --- a/scripts/gdb/linux/utils.py
> +++ b/scripts/gdb/linux/utils.py
> @@ -11,6 +11,11 @@
>  # This work is licensed under the terms of the GNU GPL version 2.
>  #
>  
> +import contextlib
> +import dataclasses
> +import re
> +import typing
> +
>  import gdb
>  
>  
> @@ -216,3 +221,33 @@ def gdb_eval_or_none(expresssion):
>          return gdb.parse_and_eval(expresssion)
>      except gdb.error:
>          return None
> +
> +
> +@contextlib.contextmanager
> +def qemu_phy_mem_mode():
> +    connection = gdb.selected_inferior().connection
> +    orig = connection.send_packet("qqemu.PhyMemMode")
> +    if orig not in b"01":
> +        raise gdb.error("Unexpected qemu.PhyMemMode")
> +    orig = orig.decode()
> +    if connection.send_packet("Qqemu.PhyMemMode:1") != b"OK":
> +        raise gdb.error("Failed to set qemu.PhyMemMode")
> +    try:
> +        yield
> +    finally:
> +        if connection.send_packet("Qqemu.PhyMemMode:" + orig) != b"OK":
> +            raise gdb.error("Failed to restore qemu.PhyMemMode")
> +
> +
> +@dataclasses.dataclass
> +class VmCore:
> +    kerneloffset: typing.Optional[int]
> +
> +
> +def parse_vmcore(s):
> +    match = re.search(r"KERNELOFFSET=([0-9a-f]+)", s)
> +    if match is None:
> +        kerneloffset = None
> +    else:
> +        kerneloffset = int(match.group(1), 16)
> +    return VmCore(kerneloffset=kerneloffset)

Nice trick with qemu. Can't comment on the s390-specifics in this, but
the rest looks fine to me. Just wish there was something similar for
other the archs.

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


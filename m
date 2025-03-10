Return-Path: <linux-kernel+bounces-554429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23447A59798
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8313AA902
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B23E17A2E3;
	Mon, 10 Mar 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XvZPsISO"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022116.outbound.protection.outlook.com [40.107.193.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B9E573
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617040; cv=fail; b=siG5B65Q1SXfH/48K8R2Ugy0yyUAcG5nLESQ/H3Xje8NMtjfhsNz9hZaL+q//j+Lvh0eIPbolBsYB4+QLtM61nfC39K5s5YwS+/E89rq7+kuxKI+ckrxwueIoU+XQc2Ai9tcTv/2fEMnJRpfWz81gtBpOEyRBFN4uDq7IRhhpJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617040; c=relaxed/simple;
	bh=PNK8kVb8sJUAvrjefb2nnE/H33ecdYI1AiZdKjY87d4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qx7iTYqZ9L5rzwLDeM6jprAyMs7geO9s2X8WHq3EVg2TLQoml/9p4O7uQIvu5FoWd3Z0BsrNfv0BL2YvrrSMjBaNfztJtD2jad9+TIHZ0rN3INDx42yUpT4rfY5T3z6jlTRs2rhnho3WAP0HFHgS38sDuG/yPyY+wxwtwj98q9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XvZPsISO; arc=fail smtp.client-ip=40.107.193.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tawrx/cBRuW+McDZ4FDlsPqSGFXj3nuGW8+tKNB7y2GiGvpU9LrYQwP84MDwiDJ8dy9cHcFjj8aVYhRVpoPsY4ziL5BUhMrPgdHkOcqGNS9UrotL1BBh66AYDc3qCOAnqnMyr8FH5TLhdaDHeo7jNZa0SP0hrxgwLyOMfhAXniA9I9CKV2bQjHc5DLyfOodqY0fjfIlZdzPDLAp6SKYlyIlZn8QngvcsvJ9qrXVAQinTCqxEVA3cmJvzjkZfg4VwvFjdwRxUj0zQZ19ga+hh+256X6oUb5pPCgm3r0Av39Y/AN6SBBmYtxVTB69VeIQVPdL8744X5uSHblYSNWjBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik6GKoGaAidKlSQze29tRZ8gY8LXit7XGZaGIFKp8N4=;
 b=gkaJVZhQpiniV4ff2gDl8MVWgrjf0QGRnZjOHKwr/ApAoJvDO+FzllMQ5qyw4o7qmasYZwjSxAr79gYWUfM9uk9BQVgNxr0Z9OPQnSpFkkwBLMZxRpVJwicCbJvPsCLqGlpiPcZUbALtvQP7zyVYdwohx0xZCVzR8OPvcCNBTfHjzU9GyQ1x79s76r/nY2OQTn6pZkGKDOwi7VBjY4gJfPeSMo9wAb4F1mMzfG3MQqQDWDDlAGnO/N79b5E4VhjiUNoB44QDwdXkg9ZPqChsMGz//TwFbXMO2aLqgPPGB0G3f09wAJTFqNS7EB5tB0lru24rLzpIe6NRa6/zsh7F6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik6GKoGaAidKlSQze29tRZ8gY8LXit7XGZaGIFKp8N4=;
 b=XvZPsISOSkY8plpX5h7Hyz3BKL/SlB7hxwg1oCS0ixcGYd5Jer++Cmg5RulMBKVghxCPARCKHNqf4Yre4neDDMa76wwl7lquThbqY0SRgy6t2v0ZwJvAcgUZsojVrRr6/6NxeodHzvyC+8rSCBr3QqAQUZdsKkn9JC2qr8+aBJKb3JHPWljQtnmhcK7oZ7ffr3sjqagxUFujVBTD1lSc2xaZ92/yFz5qvWUu3DoDv8WXzWtqRc/95xOAx3oNveT/I/EnKnKTRc6gZYu1vKaxBkQjTiZ2iHWvPSLWCeuODBhaeO8njMJQOO8Y+FLnXhrOwOsiFmeUCpuSTX5INEroKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YQBPR0101MB9983.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:7b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:30:35 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:30:35 +0000
Message-ID: <26b779d4-0478-4926-ba5c-e71449e92020@efficios.com>
Date: Mon, 10 Mar 2025 10:30:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] selftests/rseq: Add test for rseq+pkeys
To: Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1740664852.git.dvyukov@google.com>
 <9a98ed5d655e9a0d66027779c75c3ba67601e1bf.1740664852.git.dvyukov@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <9a98ed5d655e9a0d66027779c75c3ba67601e1bf.1740664852.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::31) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YQBPR0101MB9983:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d99b8d-75d9-4014-002b-08dd5fe01e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ems0WWJmNmNMT0lQdThmTHJmd1FJZ1lGVjZkVk5WRG9BbHZxUzdNT05nSHRq?=
 =?utf-8?B?U2JzdEYzdGpNVEZreEdUb25KSUE5azZxTG43TlBzTXZlOVdSaXVrRlBpNTdT?=
 =?utf-8?B?SDI2OGUzeXNnbHhjajNGcjFobG12Q25RS3NpNXpVMFkyRytzK2tOZHZxblR3?=
 =?utf-8?B?bXJYNnFkYlU4YjBJSXJkcTdWenBqUVdncGpQSVpXYmVtQ2pPM3dxUzZPdkRv?=
 =?utf-8?B?dnIxMGtNYVZvT3FROFo2NkphUDRzWUx2TzRrTjd3RmM5U1RPRmpPaG1oekVv?=
 =?utf-8?B?SGRqVUJsa2JDTENBcGx4WmFGS1NEZ0NKUVREZFJuR21nc2lKTW5rREUvZm1S?=
 =?utf-8?B?RzZOZzkzR1JzdENvNzcyaEhjN3hiRjR4TEFHbWcyb2JyWDhGanIyT29NOUxk?=
 =?utf-8?B?NEhXR3lZdHMvYW9SNGNWY09ITXQ1ck9SV0xVS0xvM1ZPbGVUSDVsbVlmZHBt?=
 =?utf-8?B?a1V4ZVpiUzVpdDByRHlPWDdid04zdjFtaWhlcjhLblRMa0FGTjJGNmpJdEJa?=
 =?utf-8?B?Y3NVQXZ2bFhwaWZtNWEvbkdETit2WTNOZVFISGV2SE1jOWtPaVZLQjlwRllm?=
 =?utf-8?B?cEY1QTd5azlwM1htRUpFYys5blpFNklvaHV3eDR4OXAvc0txeHN6Y3lROS9X?=
 =?utf-8?B?Yk9xWVBvbWhLd0c0NWUvcDFUVTlwcUt6TEZMdE9NYUJFNElFQkZxaWtYbjQw?=
 =?utf-8?B?U2tMcGxTc2tQazRFR3M3RTRHOGgrdFFTdVYvWm9nSjJnZTFjeVcwVTVMV3Er?=
 =?utf-8?B?SWVlSGlaZzBJYmhOYnVpQllKdGVYa2x4K1VIVkthd2Z5bXhVeGl1bzAydFVU?=
 =?utf-8?B?MHUvWXdnZDRTY01jMDJvSzlZeldWVFVwSytqT1lCRGRCSGZlbkJ1L0ludjZw?=
 =?utf-8?B?T2xjMXpvSnFJWFN3Z1NPeUFNQVpuZWtMdTdyKzVWUEVNRFltRmhZOG9FTzFB?=
 =?utf-8?B?U2NyMWF2TEFZcEhLWU1Qc3pXV2RLY0pmUVlsNEc1YWh1dEM5bFl1OFJocnEy?=
 =?utf-8?B?YjJrT2xPaGExWXBhcHhURVBOMUJFQ2xyb2VFVytUTXB0SVZOQXFPM0pMeU5O?=
 =?utf-8?B?ZHFVQ0FkT2x5WEJZZTRuNlhHOU1CYUJCb3FoT0RqTy94bC8wRGhPWkd1ZHVx?=
 =?utf-8?B?dXo2aWhDRzlyT2w3ajNEZkNCb1E1TTlFaGRjRGs0UTB2RVRoNjJQSUR1SGQ0?=
 =?utf-8?B?UzZEOCtDWm14eFBNOVZPc1J4R0JrTjFWMWRnMXk3RjBLNHhRT2V0dk96Nkt0?=
 =?utf-8?B?ZkpEZE9tUUNIR1hsemJiZTRucldHZk5MVmNXTzl3bUcxaFNEZ1F4OW5ieDh4?=
 =?utf-8?B?RWNRSkxtb294OUduNnpodi9LakJOU2pIOHJCNWYxSjZ5TjNXWWQvN1FPV21h?=
 =?utf-8?B?YXNLUHhVYXd0WnVnbzlWd2tQTmRUUHcxdmNYTTlVSGRZVklzemhuYkhJN0d5?=
 =?utf-8?B?Ym1tblZzVVZycmkvOVFkWm5BYUtCMXVDZVQxbTkyZW5xcFdJc0xvNGd1L2No?=
 =?utf-8?B?MDlvM0lUTVppMGFxNFU0MXIxamxFM0xOcktrU2l3d25KMlcyUDZ1MTVqMUs4?=
 =?utf-8?B?eld2M3AzdHpKRWMxb3FrSDQrWGtDU3NZMUZ3Y2d2eTBSV0E1MjY5UGdjUWQ5?=
 =?utf-8?B?czZvMC8rOTlpQVcvMGVOWlpmZ2cvVGJYK0JaWW5RREticUU3YWs2M2pSazJR?=
 =?utf-8?B?K0E3UmZTQUMybzBOWm1mNHdGMDYrZ0tSMVUxOVJJeUoxcnQ2UWNwV0lGQVM4?=
 =?utf-8?B?WitIaFBlN0ZUTXJYV09rSHlJeEVjdmY2cTdzWTJZNTRRR3ZneDliK0s5T2Vl?=
 =?utf-8?B?ZFVjYS80VjZQVmZnYTUydnAwRE9SajF6MGRGcCtrTzRwVTZBcXkrS09TaTYw?=
 =?utf-8?Q?6zsqrLFOO376F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEJUM0J6bS9RVGZHR0pPaXhzejVSNlI4RTQ3RTdHUkRMOVIrbDdzUzFPWWVt?=
 =?utf-8?B?U2t3NmZxUzBLVXU0YTQ3TzlxSnphNy8xTi9UK0VrdGJCVU4zenhsVDEwbDNq?=
 =?utf-8?B?U291VWtXY0Zqc01COFFmdk1YRnFPQVpQU1NuT0crbW9ubjREOENhU0Nvamk4?=
 =?utf-8?B?VFQ1TmVBV1RqSEMrSU9EWUhoYlNWOFRiVjhMU2s4cGpsTFRVVDNKcHR5Njcz?=
 =?utf-8?B?T1RpeW5LN3JoSGRTcFQydk1HZGoyM0ZLc3E2NkNMdkVtUDhkS1A3RjV4SlBP?=
 =?utf-8?B?L2szangyVkJuN0RFZDF3UldZbENwVVJRMmVXNXg2NzVvd2NBR3JBV2R3K2pT?=
 =?utf-8?B?RDdkSS9MNklhOUt2a1ZyMWpraVRvOUd2eDdYSDlMcVFoalNtaGcwYlMxOU4x?=
 =?utf-8?B?T1RGaVlWRm9CRXBrbTdScVp2U2x6RUNsOXBVWFV6dUE2RGs2ZXpvWWJqenps?=
 =?utf-8?B?Z0ZjbzVuRStQaDBLZU9jdFBKVWpDM2dUTHVLOEdFY05PR3BkTkVkYVAzOVgx?=
 =?utf-8?B?eHZKY005azl2cVovdnNhaVlOZmdReUVrZXBvL0s5Y3Y3RFBHdUVVbmlwZzdP?=
 =?utf-8?B?czU0SEhRK04zQXlZeVUyMjVDMmhjazZXdW9Ib0NJVVRJd3ZvOEZQK2wzcFQx?=
 =?utf-8?B?RTZ5TkNPNDhmdzNBdDljaTF3ejNJejZ4ejJ3VG93ckVzeWtMTnZRRC9YcDQz?=
 =?utf-8?B?Q05wQjFhclhMbmNsQldyalZtallrVGpSOCtvNWFlT3dXcXJTSnV0ZEFMVk5r?=
 =?utf-8?B?eFNoS0JRM0k1azF3eWptTnBaTmV2SHhTVWw1ZmpMSWYwK3VCYlJWUnJ0S0xI?=
 =?utf-8?B?Uk9FR1FOejk0a25rMW9EQ0NnSSswb05UN3RTM0k5dUg4R3dWWDlvSVUvWjlJ?=
 =?utf-8?B?SWZIUFFDMkkvVWd1UTMyZGM3Qlg2aWpMNE1ONnhRVzl1WDZxRG05Wlpud3Rp?=
 =?utf-8?B?biswa3Y2QjBlNXBTTWd6RU9sdU5yRXNhOGF2QytnRklNY0hvUG56eUNVL3Nz?=
 =?utf-8?B?WlVkS2dPSnlWT0duZ2xETW9jeXJGenJ5QVlYcmxrSzBGanJFV3k0YThBQmww?=
 =?utf-8?B?c3dKYUNXUlV1WFlvbTErZ1ZWM2wrVXdCL0dqRHo2NzA0N1p4cjQyR1c2NVE1?=
 =?utf-8?B?cjRaSzJodFdiemxQbmVMdG13UVJpL1g4VzBoY3U1dWZWZ284NGpYU21PTTZ0?=
 =?utf-8?B?bFJIMS9jYWlZUHVGT1RScG5ta01KOHhac1Z4dUU1OTA2ZWFERFBKZDlNMjVE?=
 =?utf-8?B?alZVUnJTa3pGMjFoTkp4OFhoK2RoVENrQzkvam9KYnpXQWJEaEUxMEY5Tk1p?=
 =?utf-8?B?VlY4cnd4WUJOUGlJRjlIL2NnK016bEdEaTJqREFrUnBVQzFKS0c0OWFiK1ZT?=
 =?utf-8?B?T1FaQ3MxK0lMUG9QUjFGSUEyb0kxNVBnbXVuUkpENzZVc3VndXpXM016STRI?=
 =?utf-8?B?akFDQnRLdEFaZDVrL0pldVJFanF5RDgrdnFxU2d6RkVEeXpzL1MyN3BKdm5u?=
 =?utf-8?B?U1dBc3Fzb2h0SGlqQVFRem1tdllwY0NwZ2IrYVhtQjBabHNVcXBUbHp0TXM2?=
 =?utf-8?B?NHlFb0xDMEtKMzc0UUhiandpbmFGMHBPZVVVRDZNK2ZKNTNQemhoVUpOdHZx?=
 =?utf-8?B?L1VwRzdvOUI3emVHL3NBdWl3ekpyajJIbTRQdDIyVTFLVmxlWFZlb05Mc1RK?=
 =?utf-8?B?c1NOU0RFY0I3WG9sLzZLQkZjb0syNU9nY2Y5YUNSNjNqNW84T3k3dHpyZnk0?=
 =?utf-8?B?ekZxYVNRWUZvSTVyUWN0aldqaE5oSU0vZndZWWt4bkJMeG9YM0xGbU5vL0Zk?=
 =?utf-8?B?ZnVpWkhlYVd0RDFta2NZMnJjUWpmTDR0djVjM21NenRiUTJZU202NFltY0NK?=
 =?utf-8?B?Q29oRGtjbWp2TWNrVnFiOTUxMW5mY0FCeFdWcTZmSzdLc0YzMGVLTG9nQVkx?=
 =?utf-8?B?YTdWajd1QkE0TkJNTmNFS1NOR25PN29DelliSllyV1JTQURaOVJyQ3J5LzZ3?=
 =?utf-8?B?RG4xaW9uczgvcExwVzQyYndRV2Nzd2JuWHN3dzlNOVB2UWE0cDl0VFpHcG5P?=
 =?utf-8?B?SGMrdVdPeE9ZZGUxUWV5akV4Q1dYS3dka3hOV1gvYURZMEZlVkszaG84T2Ny?=
 =?utf-8?B?ZTV4QTdtS2RzRkFlcUN1SUxKSXZZcTV2MysxaFVpV1pTSFNLaXQyNHA0S3BW?=
 =?utf-8?Q?6j2oBS6Jp77+vQQLTUoedCI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d99b8d-75d9-4014-002b-08dd5fe01e91
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:30:34.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N39KcPQ6ujZGhPOIqIanC0AyMOVGzyi4LuIxBQNGerj+gNxRujUefNwjkp7j5NNV8wBZaKafL2hJgt2/XxEp/SZG05LmF50M2ItSIo0hmsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9983

On 2025-02-27 09:03, Dmitry Vyukov wrote:
> Add a test that ensures that PKEY-protected struct rseq_cs
> works and does not lead to process kills.
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
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> 
> ---
> Changes in v5:
>   - Use static for variables/functions
>   - Use RSEQ_READ/WRITE_ONCE instead of volatile
> 
> Changes in v4:
>   - Added Fixes tag
> 
> Changes in v3:
>   - added Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>   - rework the test to work when only pkey 0 is supported for rseq
> 
> Changes in v2:
>   - change test to install protected rseq_cs instead of rseq
> ---
>   tools/testing/selftests/rseq/Makefile    |  2 +-
>   tools/testing/selftests/rseq/pkey_test.c | 98 ++++++++++++++++++++++++
>   tools/testing/selftests/rseq/rseq.h      |  1 +
>   3 files changed, 100 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index 5a3432fceb586..9111d25fea3af 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
>   
>   TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
>   		param_test_benchmark param_test_compare_twice param_test_mm_cid \
> -		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
> +		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice pkey_test
>   
>   TEST_GEN_PROGS_EXTENDED = librseq.so
>   
> diff --git a/tools/testing/selftests/rseq/pkey_test.c b/tools/testing/selftests/rseq/pkey_test.c
> new file mode 100644
> index 0000000000000..cc4dd98190942
> --- /dev/null
> +++ b/tools/testing/selftests/rseq/pkey_test.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: LGPL-2.1
> +/*
> + * Ensure that rseq works when rseq data is inaccessible due to PKEYs.
> + */
> +
> +#define _GNU_SOURCE
> +#include <err.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <ucontext.h>
> +#include <unistd.h>
> +
> +#include "rseq.h"
> +#include "rseq-abi.h"
> +
> +static int pkey;
> +static ucontext_t ucp0, ucp1;
> +
> +static void coroutine(void)
> +{
> +	int i, orig_pk0, old_pk0, old_pk1, pk0, pk1;
> +	/*
> +	 * When we disable access to pkey 0, globals and TLS become
> +	 * inaccessible too, so we need to tread carefully.
> +	 * Pkey is global so we need to copy it onto the stack.
> +	 */
> +	int pk = RSEQ_READ_ONCE(pkey);
> +	struct timespec ts;
> +
> +	orig_pk0 = pkey_get(0);
> +	if (pkey_set(0, PKEY_DISABLE_ACCESS))
> +		err(1, "pkey_set failed");
> +	old_pk0 = pkey_get(0);
> +	old_pk1 = pkey_get(pk);
> +
> +	/*
> +	 * Prevent compiler from initializing it by loading a 16-global.
> +	 */
> +	RSEQ_WRITE_ONCE(ts.tv_sec, 0);
> +	RSEQ_WRITE_ONCE(ts.tv_nsec, 10 * 1000);
> +	/*
> +	 * If the kernel misbehaves, context switches in the following loop
> +	 * will terminate the process with SIGSEGV.
> +	 * Trigger preemption w/o accessing TLS.
> +	 * Note that glibc's usleep touches errno always.
> +	 */
> +	for (i = 0; i < 10; i++)
> +		syscall(SYS_clock_nanosleep, CLOCK_MONOTONIC, 0, &ts, NULL);
> +
> +	pk0 = pkey_get(0);
> +	pk1 = pkey_get(pk);
> +	if (pkey_set(0, orig_pk0))
> +		err(1, "pkey_set failed");
> +
> +	/*
> +	 * Ensure that the kernel has restored the previous value of pkeys
> +	 * register after changing them.
> +	 */
> +	if (old_pk0 != pk0)
> +		errx(1, "pkey 0 changed %d->%d", old_pk0, pk0);
> +	if (old_pk1 != pk1)
> +		errx(1, "pkey 1 changed %d->%d", old_pk1, pk1);
> +
> +	swapcontext(&ucp1, &ucp0);
> +	abort();
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	pkey = pkey_alloc(0, 0);
> +	if (pkey == -1) {
> +		printf("[SKIP]\tKernel does not support PKEYs: %s\n",
> +			strerror(errno));
> +		return 0;
> +	}
> +
> +	if (rseq_register_current_thread())
> +		err(1, "rseq_register_current_thread failed");
> +
> +	if (getcontext(&ucp1))
> +		err(1, "getcontext failed");
> +	ucp1.uc_stack.ss_size = getpagesize() * 4;
> +	ucp1.uc_stack.ss_sp = mmap(NULL, ucp1.uc_stack.ss_size,
> +		PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
> +	if (ucp1.uc_stack.ss_sp == MAP_FAILED)
> +		err(1, "mmap failed");
> +	if (pkey_mprotect(ucp1.uc_stack.ss_sp, ucp1.uc_stack.ss_size,
> +			PROT_READ | PROT_WRITE, pkey))
> +		err(1, "pkey_mprotect failed");
> +	makecontext(&ucp1, coroutine, 0);
> +	if (swapcontext(&ucp0, &ucp1))
> +		err(1, "swapcontext failed");

Should the rseq register be paired with a rseq unregister here ?

Thanks,

Mathieu

> +	return 0;
> +}
> diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
> index ba424ce80a719..65da4a727c550 100644
> --- a/tools/testing/selftests/rseq/rseq.h
> +++ b/tools/testing/selftests/rseq/rseq.h
> @@ -8,6 +8,7 @@
>   #ifndef RSEQ_H
>   #define RSEQ_H
>   
> +#include <assert.h>
>   #include <stdint.h>
>   #include <stdbool.h>
>   #include <pthread.h>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


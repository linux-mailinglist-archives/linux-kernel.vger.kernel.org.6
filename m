Return-Path: <linux-kernel+bounces-513227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE6CA344AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160073AFB36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD12D2222BF;
	Thu, 13 Feb 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Y0DOI1JN"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022079.outbound.protection.outlook.com [40.107.193.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62403211468
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458583; cv=fail; b=NqM7vPLBInpttAM2k3rOaNWj4gJeEaus7RJbY7M6IAfeuM4Wfj9aHLGR4aeCcTFIrNnwt2uAfTfjE1ESqHAMsnGrZzcOTlE9M3nJu/sHqWbTLqHiXs7MMmOJa+2bUITP0Js3NeYyvLkKbRNqTUF8XvNp5F4KMB2wS+cHVT6t9aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458583; c=relaxed/simple;
	bh=tggQ2YW53g+j+coss7wDr9+9GsnV3LakNXxvzmhobk0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FcMSPUyJvJT/MMMZ5nL5iKTk3zCONlxTkrcGu1boOiaaBAeKXQfUEGlbnEWoQXS4zhAuCPJ72DNiZNn1ZrljVH9/IOf+cFngjMsgcJkh2Pap+2f7a8bc7lA9FEknQd/GGagTFi/hnEEhlxG5WDW7YLrCShFkj/slE2Xvsk3VT/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Y0DOI1JN; arc=fail smtp.client-ip=40.107.193.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hk2n0ViymKqtczUyY0ltXnf2Iq7PK1vGM9jhpxQxjLRsJ2urYbdA3L0WUqLBcDAjFQfPEuovTxe8LYGJN9XpoMWG8xk9+wYlJUqzUsJOsa+YUzrtyKE9t7uuQfSA+je/WeJZdN9INM4ARx+HpIunUqLgMitKloJFYM4qtXNHFlGfrIsmkoTfgsZlcp0zvU5ViKrjPNhYkLQCTwrmWxMvTdUbfoINUa+/fnA0+vwxm4GlpPu5XNJNQv4uQn1FFO8KDfAYRZHRFJUAHn/aNfpqNClYhvYOcrituE/MRcGhUz1MC/rMQ6HV5vbdWxHnOud/BVu1PmmP8I3JuegzcMAhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=becoX/I1Sh9hEJmJRSTMPq9kBBDFyxYJrhHvMb9VgqE=;
 b=Wf1ZKWTKhr3apgYEyI20o7x73iTiN9NLdhjuAMzN0ZYIUvbY8lPAwz+o1pV9vKgm98/6lLtNilIgYA4bXX4oAlBJ5gvNti5af7mKiYqgl+2OJ+tVA6UHWXYQ3A6NOkSPWduoT+GjX3MpfTelAlGV0CoM/ud1zTrOGj5ZQ4QobySAMplud/gvi+hI5JRVjBN1FUpFx/g0dfMO9Fpp451YAbKfiw5sQ43mQX4+/dNZTsiM5LHQ/BILsxiL0ELcGHSaJ6rXVoW7GtO38RPufBO56s0BCVKiihAQjTGEvfz6d/hw7AXxRX8faM/nfzJJ34ox9cGqx8fgXCfGtmCIBKlwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=becoX/I1Sh9hEJmJRSTMPq9kBBDFyxYJrhHvMb9VgqE=;
 b=Y0DOI1JNgqppyf8dzZ8e8YU7sl+hVvdz7BaVD/tDUhl7uxulPh3aiUdCyY6Vt7cxjHYa+993hni3NQAkS4KUReCmzzA7JktetN9G7Aqjk9Vhc49UAGqdnx2AXps7GbnJNoDitstIYNcKbqNeq8fYEBYhQMET94AjFrmRf9CmxAGFrQFPqSKN5l4+z+BJxkCSVxUlAs1dQ3UN4AcHU8cCJTSKwhvPGj6h0rXR7GNcRtuyRt3mCKAEw6KX0TzJthh8SXBamwKkt+PsHyM650ghNxalHbYCrJknpk5cW8t0+ruaL0c3OdfNoVCdqDlsqfKgpTVpYO7qFGl5yTTBbrIxNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by TO1PPF385483FC3.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::632) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 14:56:19 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.016; Thu, 13 Feb 2025
 14:56:19 +0000
Message-ID: <fe1858c9-0cbd-4f76-aa2a-b30b2a3f3cbd@efficios.com>
Date: Thu, 13 Feb 2025 09:56:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] sched: Compact RSEQ concurrency IDs with reduced
 threads and affinity
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org
Cc: Marco Elver <elver@google.com>, Ingo Molnar <mingo@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20250210153253.460471-1-gmonaco@redhat.com>
 <20250210153253.460471-2-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250210153253.460471-2-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0222.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::33) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|TO1PPF385483FC3:EE_
X-MS-Office365-Filtering-Correlation-Id: 70472ec4-d645-4a95-39a9-08dd4c3e92a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzEwdjZtb2x2OUdoYkhhL1BONGhUUlZ6N1h6YXRCeGR0eG1PRmJNN1RuRVpt?=
 =?utf-8?B?WUVlUTZjSWNqdzZ6dFRId1h6M1hKY3dBRnJqY0FRVmxZSTRaMHEwd0ZNdUJ3?=
 =?utf-8?B?d2lZUm5UL0djdTRGaEIraGxxK2paalViVHV3anFwZDNaaFhGTUthYUhJNy9n?=
 =?utf-8?B?U0ovVExWTnFERzVodExzNkR0V0FlU08rYWVtU2pjOUFaM29PTlBBYVMrbDlN?=
 =?utf-8?B?VldMUEZpNjBmZnBRdnplcDJnenVUc3ptZ0cvSE9xdEdNdjd6U0h3aWNid3Bj?=
 =?utf-8?B?WEx2c1pLb0hRdE9Od1dhbVBEYmtxZCtRbFZQVXZUTjdqMG5idWRZa1ZDdFdH?=
 =?utf-8?B?QXd0MnliNUY0cXQ4WmpRdWNkcTFpUUVBcUR2WEt6S3FIdEFqVHdKTGU3NmpC?=
 =?utf-8?B?SFMxelRjeTlYZGxuWHJJUURTOEpaQnoreWUzT3pGQXRGNEhQMGNXQUNaQVRi?=
 =?utf-8?B?NkNuRi9hUTZCY2xwb3U0azJObDcxdG9GVHNSaytQSG91bmR5WmpCNmFzQmpD?=
 =?utf-8?B?VWtxMW5GbTVIdjc2cmhKZWFtejV4MWo4Uk1jWFpIeDlEM25NT1JmNmozRkhi?=
 =?utf-8?B?NUZoK3hrVTNvR3RDbDNGNldEaEFIOTRLalJkZEhWYTBDMThIbVQ1K2pNU0h2?=
 =?utf-8?B?T0l5dVZqOEEzblRHQkxOYS9XOGlwd09GSm5yMXA4ckIxeHJ2aUhkZUp0eWh6?=
 =?utf-8?B?bllRbE9yS1d1VDNSczZqMzROdGtxWFluakFTczA3bEFBRFZvQUtjb1ZvNGxN?=
 =?utf-8?B?SFJmRUR4cit5UFhhbTN1S2JSU05nNy9HOHk2L1ZqZnR0OFFYM1dSTkEzZWMy?=
 =?utf-8?B?RXVkbjFqSGd3SkNwc1JaZHh3MVZjWXNwSDlVU0lsSW9mNVF5UStZWXFGTUw0?=
 =?utf-8?B?aStNYVAxUXJqSmNUbVR0aW5kYWxOTWJKVmQ3MFZkN1VkdTlBb05SRWt5eWc5?=
 =?utf-8?B?LzBQdEdkRU1vRWhIeXZ4a0F0UG0xdzhQNHIrNEU5dmVPVVEzcENkZUlHSjNQ?=
 =?utf-8?B?U3VYMnlpYit1R0FER3IvdFBOMXRJYXdkd1REeHVZcXhzTTk1aFliTkhwTjRn?=
 =?utf-8?B?NzBmRDkrZHFTOXl1UlFuOG9hYXR1OWh3dko5ckczbUJhTXdSRG9Yai9WcldH?=
 =?utf-8?B?MEk3S2hIcVI4anA5bzhFK1U3WnFpOXV3M3pBMHhGa1pZK3ZGMDJQdjB0bkpp?=
 =?utf-8?B?aWhkcUZFcTFzOFBZd09YMnNITHppS290RW9rdW5JbmhnV3pDMElxMGI0elN3?=
 =?utf-8?B?b05ESHdPSVhLQ1E3eWc0czFuRDNtU0JUZXpnMlpFY2M2SHVVYUhOM3VvQ3Bn?=
 =?utf-8?B?Vm9lUU1hcU1razQvTFVWeXN4M0FVSkZpcjFRZm5IbmVNcW5samF4QU02WWhT?=
 =?utf-8?B?YkJmbkIzMU9YV0ZTeW0zUHBiWVpvM2hkUW56UWFEQk81a1N5cUE0TzZpTXVN?=
 =?utf-8?B?YkhXd0FscDdCSlZvYlRaT3RhQmovTHcyemtoUm51U3BZdkc0WmxsYUVCSFBj?=
 =?utf-8?B?Q2w2NU5odHp2cXRJbTRnYk9KMW5VS0hGY2wrVmNGTHpLS2QzSnZZWThtUUZ1?=
 =?utf-8?B?NjUvYWVQNUZHdldpSVFuQXdyK1M1Y1Vxd3FJU0pWTGhZTFgzSzhiaXduakRo?=
 =?utf-8?B?SWdPaFZtQzMvcGZDcHZwZUJ1Yzd2WFFzaWl4M3pwenk4Q1U1SEZHajhtZGU0?=
 =?utf-8?B?NEhHVEtTeCt3S01XYjFxMTN3dDl4MXpnRm1kdTl4ZzhTdDlsSk1TYmNwZkVh?=
 =?utf-8?Q?GV6XyNBfhlMZoPrJQsN7fmpKa03Ii87efdMOJz2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3RxbURibEtHRytvR2lTQWljcVNUNkhSUG5iQ3NWeFJXeTQrRUhxR2pEbzJU?=
 =?utf-8?B?TWJPd3RpTk5CSkltWUZla0x4RDNKQ3BGSVF4ZVl5U2dQVWpxMVA3N05GRmdT?=
 =?utf-8?B?ajROL2pKVkZxRSsybytuYkJUODdJUnB2V1dqNXJ5cFBnNzJMK010Tk81R0Ez?=
 =?utf-8?B?Um9uZlhwdXNydTlWVUloUFZqTmVtb0N3UUhnUWtMVmJhRCtpUnZpNkNvanQx?=
 =?utf-8?B?bHpwUkMvWEM1RDhxc1lpbTJRSTlwczIvSm1ZTGZNZDRacXB5RWRTTjh4QWhR?=
 =?utf-8?B?a1NWbVNJUHpQYS9CZ3RqU3RaQVR4U2F0cUdxNitmeGNDVXcvblNPdGxuY3JS?=
 =?utf-8?B?UC9KNnlTNWgzZ3pzM2ZqQ2lJWEJtVEdreXdUdmVpMGxmSU1ZRHVGVG9IeU5s?=
 =?utf-8?B?dlVBWEtMTWRIRDhFZEx0eU01RjJSWFZ2cFF1b0lrcnRaaTluWEpBNnpKQ1lo?=
 =?utf-8?B?VUR1UkNTeGlpRUZrRS9BLzVmNCtnY3hyM2RvR0xwMDdUUWJqNm5rUUZUQ0RL?=
 =?utf-8?B?OWpDcTZ3R0VJVy9BOXVlU25aZ2hVbUwxMGpaOXpUK3haTGtzWmllVHRRQVFr?=
 =?utf-8?B?c1JwMHluSERGbkMyaENmNXhsYXR1TUozR0NPeXExRytmR0FyOE5WS1grM24y?=
 =?utf-8?B?S0ZwNWtCSHQxTE45Vkd2ajkvT281dy9hTVROaGhyT0pIN2xsbWVYVFZWZmZV?=
 =?utf-8?B?a1Q0Z2lURE04STBjTVY1cWFIbUZKS3VKTHBIM0t3VXE3RGUzYnNnRFNFdHEw?=
 =?utf-8?B?ZFpDaVBaOUlWMUcwSThyVTh5a2loT1pBWDJsbFZYbzRxUWNBVlBVaUxLbXl6?=
 =?utf-8?B?WU1KYjhaZm9CUjRFbEFBN0doMmxtd2JBL2lHYmxtZWN0dXJpNVFGMm83SE5X?=
 =?utf-8?B?YlArS25pSEN1RWJPc01tZlU0bWJMMVRxWlh2bXRDanJ5S2NVaUt2UGk0eDFP?=
 =?utf-8?B?a0hqUWJ1RzJPV3NGK0VWT1dnWnR6SmpKaXlZZmZyRjlZZDdGMlJPdFNuMkdx?=
 =?utf-8?B?TUVNY0s2b21uWGc0eTBEQVZFZnNJNC9pWHQ0NWQwWEtZWGpKOHZqRzkvd3Ew?=
 =?utf-8?B?M3hTTkxLQ2dLaDJuandHaUQ0MVZGczRBRG5ienlQcW1qY09CUFdjMDBCaXZt?=
 =?utf-8?B?NDB1ZHdKWlE1MEhTb0sxVVZBVmdVb3hkZ0NIMk91bStwbjFEbGZnNjVlYXEr?=
 =?utf-8?B?SE1teFF2Qk03RDBlVUUxcFcvd2hkVlNxNmZJeGdFbHRHbGJtM3Uva1ZMNnZj?=
 =?utf-8?B?dUt2aE5HVlJSSWhHa1cxSjdsVm8zcnVORUR5T2V3M3krQTA3dWFXcGYzQ1FQ?=
 =?utf-8?B?dUkrdVFKcmFwRHp5TDRDcDJyVkpXOXlVckdFMHJ2YS9ZanZGZGc5U2xmbG9O?=
 =?utf-8?B?YlU5QTZiTGpvd1p0QmV6M0NkRm9FSXdVQjUrVFZlMHhSSEVJVHhhTVRWTWRJ?=
 =?utf-8?B?L24vLzBvWVQwdDJDckNzK050SDJSNVBBcTI4MXgyVVFucTVnZmxydHo2NUtS?=
 =?utf-8?B?UXhncHR4K2JNajlnWTduM2t2WVFWMnRveGlEazRsNWtHdHpVMWprakRqZktH?=
 =?utf-8?B?MVQ5NTVjSFNQeTQyOVk4N0Y4Z0Z0RS9kTnVNdU8vWG9WNUFCZjF6VkRHZzFQ?=
 =?utf-8?B?eFNzVDBSTzhkTnk3MHJtamtxZG4vajdsNjZSZVNzZ1hxQkt5NHozZnQwcnhk?=
 =?utf-8?B?cGI3aGxYYjQ2VnZacGlQOEozWVp1S0MzcUxoK0ZDRk9GWnlVcy9CZ3pJcnBE?=
 =?utf-8?B?THhhd2FPUkJlSlVGd29ISXlUM2ZTSmhDNXRjR1UrNER3aDliM2p1ZWpOMUdN?=
 =?utf-8?B?QUd0MVpCT0NVZ1JtZWNQSTcwNjVHYjdHZWZhb0tGMzRXcXVyNVZiakhlVWhr?=
 =?utf-8?B?dHZJM09jYWwzTWpFc3hFS3QwblpxbW5zUzBlZmdaNlg5SzRIekhXZ1BVbU5E?=
 =?utf-8?B?MWlic1o2ZW9kb0pyNktab09XeTF2T1pTcnhKbStDa2RId1BONm92ak56OWFl?=
 =?utf-8?B?TWUzV1lsSUN1RUFTdkNKVHJVQldoMGRkczJ3T2ptLzR1Rk0rcTJCMVM4TVlz?=
 =?utf-8?B?cW54Y000TFMwTThyRU5KRURSU0J2alBOU2hyN2VNVnQ0bExKSUlZY3k1RGpn?=
 =?utf-8?B?MWkxMXVHWGF6NThQbmZsOVQzL0pmNmp2MUxiQ3hPUFcyRFRMaXNiYTJ1TEht?=
 =?utf-8?B?UkJ2NVplcU1tcG9wZXg0ekpTQnFNd1FFb3RrZ3hRZVYyTElhYjNjcEdoUWpt?=
 =?utf-8?Q?l6yPfqBO3FUtRKP6xDj4TA7+iX1DNmvThNY/6tswPI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70472ec4-d645-4a95-39a9-08dd4c3e92a6
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 14:56:18.9790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uj6kZGdxadNjlNMEsj0T8mFk0p2GQeaf77UwcG27BmqoFjISzzzf4qIfnvGkLsNcAnnW0C19wL7QnW3ob4tFOKV7+3EVBKb+pIGMkQKClnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPF385483FC3

On 2025-02-10 10:32, Gabriele Monaco wrote:
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 

Peter, Ingo, this patch has been ready for inclusion for a while. The
rest of this series does not seem to be quite ready yet, but can we at
least merge this patch into tip ?

Thanks,

Mathieu

> When a process reduces its number of threads or clears bits in its CPU
> affinity mask, the mm_cid allocation should eventually converge towards
> smaller values.
> 
> However, the change introduced by:
> 
> commit 7e019dcc470f ("sched: Improve cache locality of RSEQ concurrency
> IDs for intermittent workloads")
> 
> adds a per-mm/CPU recent_cid which is never unset unless a thread
> migrates.
> 
> This is a tradeoff between:
> 
> A) Preserving cache locality after a transition from many threads to few
>     threads, or after reducing the hamming weight of the allowed CPU mask.
> 
> B) Making the mm_cid upper bounds wrt nr threads and allowed CPU mask
>     easy to document and understand.
> 
> C) Allowing applications to eventually react to mm_cid compaction after
>     reduction of the nr threads or allowed CPU mask, making the tracking
>     of mm_cid compaction easier by shrinking it back towards 0 or not.
> 
> D) Making sure applications that periodically reduce and then increase
>     again the nr threads or allowed CPU mask still benefit from good
>     cache locality with mm_cid.
> 
> Introduce the following changes:
> 
> * After shrinking the number of threads or reducing the number of
>    allowed CPUs, reduce the value of max_nr_cid so expansion of CID
>    allocation will preserve cache locality if the number of threads or
>    allowed CPUs increase again.
> 
> * Only re-use a recent_cid if it is within the max_nr_cid upper bound,
>    else find the first available CID.
> 
> Fixes: 7e019dcc470f ("sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads")
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Tested-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/linux/mm_types.h |  7 ++++---
>   kernel/sched/sched.h     | 25 ++++++++++++++++++++++---
>   2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6b27db7f94963..0234f14f2aa6b 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -875,10 +875,11 @@ struct mm_struct {
>   		 */
>   		unsigned int nr_cpus_allowed;
>   		/**
> -		 * @max_nr_cid: Maximum number of concurrency IDs allocated.
> +		 * @max_nr_cid: Maximum number of allowed concurrency
> +		 *              IDs allocated.
>   		 *
> -		 * Track the highest number of concurrency IDs allocated for the
> -		 * mm.
> +		 * Track the highest number of allowed concurrency IDs
> +		 * allocated for the mm.
>   		 */
>   		atomic_t max_nr_cid;
>   		/**
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 38e0e323dda26..606c96b74ebfa 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3698,10 +3698,28 @@ static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
>   {
>   	struct cpumask *cidmask = mm_cidmask(mm);
>   	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
> -	int cid = __this_cpu_read(pcpu_cid->recent_cid);
> +	int cid, max_nr_cid, allowed_max_nr_cid;
>   
> +	/*
> +	 * After shrinking the number of threads or reducing the number
> +	 * of allowed cpus, reduce the value of max_nr_cid so expansion
> +	 * of cid allocation will preserve cache locality if the number
> +	 * of threads or allowed cpus increase again.
> +	 */
> +	max_nr_cid = atomic_read(&mm->max_nr_cid);
> +	while ((allowed_max_nr_cid = min_t(int, READ_ONCE(mm->nr_cpus_allowed),
> +					   atomic_read(&mm->mm_users))),
> +	       max_nr_cid > allowed_max_nr_cid) {
> +		/* atomic_try_cmpxchg loads previous mm->max_nr_cid into max_nr_cid. */
> +		if (atomic_try_cmpxchg(&mm->max_nr_cid, &max_nr_cid, allowed_max_nr_cid)) {
> +			max_nr_cid = allowed_max_nr_cid;
> +			break;
> +		}
> +	}
>   	/* Try to re-use recent cid. This improves cache locality. */
> -	if (!mm_cid_is_unset(cid) && !cpumask_test_and_set_cpu(cid, cidmask))
> +	cid = __this_cpu_read(pcpu_cid->recent_cid);
> +	if (!mm_cid_is_unset(cid) && cid < max_nr_cid &&
> +	    !cpumask_test_and_set_cpu(cid, cidmask))
>   		return cid;
>   	/*
>   	 * Expand cid allocation if the maximum number of concurrency
> @@ -3709,8 +3727,9 @@ static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
>   	 * and number of threads. Expanding cid allocation as much as
>   	 * possible improves cache locality.
>   	 */
> -	cid = atomic_read(&mm->max_nr_cid);
> +	cid = max_nr_cid;
>   	while (cid < READ_ONCE(mm->nr_cpus_allowed) && cid < atomic_read(&mm->mm_users)) {
> +		/* atomic_try_cmpxchg loads previous mm->max_nr_cid into cid. */
>   		if (!atomic_try_cmpxchg(&mm->max_nr_cid, &cid, cid + 1))
>   			continue;
>   		if (!cpumask_test_and_set_cpu(cid, cidmask))


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


Return-Path: <linux-kernel+bounces-565151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62574A661CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FC13AA182
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECCA1EB5F0;
	Mon, 17 Mar 2025 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hl8JXzyF"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F35156F4A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251184; cv=fail; b=sbchzWFWR/M7zfTR38UjFtgbEM8wAY2g6JlaWUhDekT4N0W8jVn85lzEdmeSwL8Z/dLZpPGdAtusE8gZqSsbB0k2dYaYcAwvlOFCNYoPb6lYmaYiTfmQ2UAwUeOCckJRFFgmwaWzEZ8gSY6yjc8bhQTzKWvCRBQPuJhPqdbTASo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251184; c=relaxed/simple;
	bh=ff/M9k1gYjzrQBFCPuXUWWQjp/zSfE3O/24bWN9INsg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hD+kdK+4KXmOL2AgeqiBIk5OUatpRrzWVOoPCuRfVhfYmNzjEJ89gbJdwckFWB33CpL5Dxsd5QxvMRRK/IyQSiHrcNihTibrYcby6XrhqA1sflyPvTj7FPYPdUp2ZsOqI8raecy2GciVfIRz28PsIAayIz4ZdSxu4X1TE8Sx4PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hl8JXzyF; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAJzoz6ZfQFuRNXMwtGl/A3+hhUFKSQip30g63VjOlYAhMobUHE1xrAzJVBbgSGFBXtFTEE/N5T9Z5DoNY+mFnCp3kBiHMdHZCDItFzQBMw9HeYJnM7QGNsjBLqDeFjqsG6I6Y/cjj4Y9ukMMdvwMYOB1oPjYP1prnPpLZCZN6aibTGqyNa23nn6Ow2jfROQoTZd+kB98cL1UUYQKQX6NHXwv/4YD252nn2T+t2LlzgfOe44VcF0GFPWJnEHHeyGaBSaycfhDNGps3Wx4fHX4Sgn3MTDfdeklrFL/H5Hnb1WbhpkPYlVIWCUK51QA+PdToLtegDhF3DoMgVCJdAV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41SSVjI6MQJzZZzgFDyS+fZwnBcF5TU7a7AFwbtglKs=;
 b=fkDpRRXq2mvDp5SbN3uNw3eokme3gtq+jLG4YAdRho07cd0BZdQoXPFsMbwm+3/HCz8ZqaN1dlUx6Bj8N2tR1dJ+f/h/ughuD56pqUDnKv6+hmiLm4aLSfLgtPwR5nceRbZr8EmYjVCXge5B9zWwPGETLaCCP+VUeIIL4bdrkQXsmYCqVwgOVkn9v1ovESH8QvpibBirCVFwA9cbObvYSqxFwwXNQqKnEs+zhuN5k9m/mmU1w6r44UnJlvD/H58EpmxmEhl5jsCpytNglM04SEZTUOSOLHDag5EeUXx5TFt6W0GekBPh43oLGT85zsmTutggu5EN8154XaoJDxNxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41SSVjI6MQJzZZzgFDyS+fZwnBcF5TU7a7AFwbtglKs=;
 b=Hl8JXzyFGAb7aX9lj4y8/soeTreGnAjmsMzSUtwRisyReosRBMr5LXoepRn5Rr6o6VOPnU1kDwXS1W2Zrd5vlmZp/iEY8Ld1ePYBrz62d9ts0N8WbSAUcEH9U/o0FCy69ZShjWOrol4cyhAZ8/j8m02J7gpDM+wX2WGwreUwXLORPG71eyNsARB1KJB1dxMVDzGoznuvRZ5Tw1JwjFfqlPaHBoUexwPxLD4DP7CNtZZCQLhGKp7RphLPC5N1cYmGJDWMdjlbTvETDpDVIjAj7adOUehzh/uGwjYX+4o/xHHgrNRM9j6qehFWpu/fE0kRTGM76S517qn697Q95+DXYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 22:39:38 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:39:38 +0000
Message-ID: <4b8a25f7-c7c8-467f-8d03-6e590712ffbd@nvidia.com>
Date: Mon, 17 Mar 2025 23:39:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/8] sched/ext: Add a DL server for sched_ext tasks
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 Luigi De Matteis <ldematteis123@gmail.com>, paulmck@kernel.org,
 boqun.feng@gmail.com
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
 <20250315022158.2354454-4-joelagnelf@nvidia.com>
 <20250315072225.GG36322@noisy.programming.kicks-ass.net>
 <3b244939-6d55-4d86-8b77-a9a7629f8239@nvidia.com>
 <20250317103101.GC34541@noisy.programming.kicks-ass.net>
 <Z9hUby9e1JYaE6iC@slm.duckdns.org>
 <20250317170602.GE6888@noisy.programming.kicks-ass.net>
 <8d9e6300-113e-4a89-8fc3-2ae895c77794@nvidia.com>
 <Z9ifV3UcLPNvBttF@slm.duckdns.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z9ifV3UcLPNvBttF@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0126.namprd02.prod.outlook.com
 (2603:10b6:208:35::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 993e3660-d841-4fa2-12e9-08dd65a49985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXNKRDlnTFA0OGNQL3o4dENENXozMm5oN09zWEZqRndCZTczbHZObmpRSDY5?=
 =?utf-8?B?WkRCOHFlTEtCZ2JreUYwQloyV2FjNDAyVzlNV1lBZi9pK2w4NHZKTC9tS2ZQ?=
 =?utf-8?B?U3JpNmZ0UTRmUFQvOXhGNXgyUEZVVmlFVHZ4QkdzeXczY3NFaFZsMjg0ZldM?=
 =?utf-8?B?dEUyeG5sbGtNVHlnTnh4ZzRYMjUwMUdtV21VdDlUMUlkZDJENnpDdDc2RGRM?=
 =?utf-8?B?b1BGZ1pHbHpHMzVXQi83aHp6MGpjRHBHL25UNzZSanNNaldaUTVtUWJGc2t5?=
 =?utf-8?B?UXkyZFBiWjRXSGdRZmNacjFRY0pkelA1TTlIK3FlQXR3Q0EvbWdrdmV6a3dG?=
 =?utf-8?B?QkxYdWc2R2crNzVnVzdrSjZEd1Fzckw5c21wMjZrVW9HT25temwrMzg4eUhr?=
 =?utf-8?B?cGZvb0U1cUlJZkZMTjVGWHZMaGtmbGNxNHRjYzRKRGVwejhSYStlejd0aERj?=
 =?utf-8?B?akM3UkRkUy9SWTJRcVIya3hmekpYMnlJM2xMYlBCalVWRklCb2IrUklTaTJj?=
 =?utf-8?B?eHpaUFV2ZjVscXNuM0hPdlZUVUdhcHpERGU5b3hBT2NYeXh2RVd0NGZaTk1w?=
 =?utf-8?B?eE1rL0JNV0RNOXpyUnI1WWloekdZcVFoL1VwMk1xcW1YU0RucUZMQ3RuZzFU?=
 =?utf-8?B?QTBNaWt5R3hGR1owQnhjT1R5Zm56Tit2NzM2aDNtZTlZWUZoNWk1RzNWM25T?=
 =?utf-8?B?SW1kVHFhWldQVTUvcHJkNndHTGRzSmhDaS9IQUYrWnM3T0M1WnRWVjNTcmdX?=
 =?utf-8?B?MXZZSmlKWDQxMmxIY0E4eGsyZGFiNzRpT0JOQlBkMVp1QTlIaVJTL0JmSXpn?=
 =?utf-8?B?eGFiMStzMVVwTkdJREhnWHF0SDhTWU1Rc1ZRUFltcUhyd2g4dzhCWUNHdXMv?=
 =?utf-8?B?TDcyZkY5UG9mbXhrUUFDNm5Wd0JrU1krLzlYbTJDc1BhUjVYbEpzbForR2lJ?=
 =?utf-8?B?eEtSN01IQWo5Tll3N0V5N3JyNmREMUh3L0VVNDNEQ0NYaUFmYU0zUFd0aUxz?=
 =?utf-8?B?WHVZRjdPaEhBZ3dNYWRMZld2OFAyVjJnajMzR2tqY3lGNkM0R25pb1pkSm1D?=
 =?utf-8?B?YmtyS1htb3JEWkVqSGQxaldNUThSN01Qc3BUemFMVEdHakd5MlFnVHhjcXNR?=
 =?utf-8?B?RE9QQXo5aVBLSjczTWN2UGl0SUJtVGxiWVJFMVZXeEgyRGFDUkh0ZWJBYnU5?=
 =?utf-8?B?ejYzRExPNmZYeUt5RjRwb0l2NjlKdUFpYlpqZU1NOTNxZVZ4b3ZEWnpTV2NZ?=
 =?utf-8?B?TlZFQWpGcFc1UTRxdXhDLzhrRWlyN2NicWw0Z3Z5azdRbW1zUlFnMFNFcjVu?=
 =?utf-8?B?cUEzUFVSUWNoY3ZPcnVwN0t2dFpVdU9zMWovYjFQNVpZY2lsQ2NVVW03RVh6?=
 =?utf-8?B?b0VDVFpyOEp2aG1ZWDExR1p2cVU3SlFobXpEQW0yaTlTUEdGUjk3bmtwcFVN?=
 =?utf-8?B?R3UydEg4WC95ek9oRlpPQjMvZHFBaEo0Zjd0NlBoanZEaU9xd3FNSnJ1Zlpl?=
 =?utf-8?B?cWtCK2JSV1VhZnVDejUwK2lYei9WaDJVTFpPUE1JNHNXNjB4RWFvTm51MGFW?=
 =?utf-8?B?YzFFQ29ia3QvdHV1aUNWaU9UQjRLcXFlMmN0TlRjNmJXSnVkSE80MG9yWGVu?=
 =?utf-8?B?d3Z5VWFWeU9VNEF5M0wyUWMrUWtXSFFZSG41WnFzMU9wYXhWTkFJcE9kY25V?=
 =?utf-8?B?dTg3TGdzYkNpc0c3dXc1bFg2bVQ3OGxINjdVMXNxUjBoTUxEWGlwWW40Sms3?=
 =?utf-8?B?UnZ0Mmp1SCsxRE9Ma2FNeHFmcFVFU0IrSGEyblFXYVdyZ1F0amJia3l4d0JU?=
 =?utf-8?B?ZzM3QU9CaFlVRkdTMWkxL3ZrczNMUDdtamZ6RWxPYVFaRThvUklRNVZReDJr?=
 =?utf-8?Q?CAy9+LmharWyK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlhiajIrV21QQ3ZtNEdsc2V2T05QSmt0REpFdXNRSll1Y29LNlpjUVZlVWEx?=
 =?utf-8?B?VllNRWw0WnNjcmU4OFFFb0I3VjFTWEt1elF5dGdUaEVjdlNrNWVEUk0zcVlq?=
 =?utf-8?B?MVA1QW1zUjZnN1JvUk95K1BkYUhLMVZON0RJaHpzSFZ3K1NmdzBiaUw1WjZ5?=
 =?utf-8?B?Y0hnV1NwVjl0RmNtQkpzV1BXZk9sWjRnL2JxREowT2YxSVh6VTZOWVBuaGRt?=
 =?utf-8?B?czVaZ2VkU2VmcXFTLzdYYVZBREhCUWhucTY5eHlQUXdTNFI5Y1R4NlQwY2ZT?=
 =?utf-8?B?M3NTRlcya2N3OHdneTdBUnZiemFBeVNlcHNsakIxYVU1TFNhWWh6QVRyNHVZ?=
 =?utf-8?B?TVVmM2tDc1pBSk1wM1IzRTlKMjM4U1VIaHNXTFFQSnIva2ZxR2NMVWc3dVNs?=
 =?utf-8?B?NDFmZityVkxwaVY5MWpwVEhxdVJ1S1Bhb3lCYkNkODhhUkpnaFZmWHVSdEox?=
 =?utf-8?B?alZRWFlOdkdjRWpwczN3aVdBTWt2dC8vTnZSNi93eU1wR282eWhza1NQT0Zl?=
 =?utf-8?B?MnROalBFUTA1bm5LVG9SV3JkK0pjai9EbkpWZzNlV2RvdDNCcGtwWGdkWUJX?=
 =?utf-8?B?ME0vRDVDZUNNby9heGhyNXlRTzdJOHpUZTkwa3FLNTZMaFg2cWtZUlZHcmg2?=
 =?utf-8?B?dGx3QUV2T1FrWlZVaEROdlpMMW5ZekRQbVRJYVFvd0puc28zd25PaG12Y0Z2?=
 =?utf-8?B?Qmk0VVhDN0hUZHZySVVnZGR2NWtlc0VFNDFjQVh5Uk5nMWFiV2dPTWpjSTM4?=
 =?utf-8?B?aUtLU0dQQUV1eXQrU0hMUG02YTN0RzNrb1RNazhmN05lYW9EcFJqeloxVEwy?=
 =?utf-8?B?cWNseWdDWXMrVmRuK0lNcTVvMzlJR2NTV1h4L2pubHNRaVpNbVBnWEFKQVYx?=
 =?utf-8?B?TERwUFltcGIycDV5ek5BaG9Tcmh3Y2g3WVpENk1FTk1CMy92OStYR1cwSU5r?=
 =?utf-8?B?NVJoamozZ1BDdGZoK1hkdEtsMHVSMmxyR05EMVVDd1Z2WE5PWmllMDRXbGxJ?=
 =?utf-8?B?dk9Fa3dFZE8xVnNoUWw5RUdiL0R5NlZRdmVBRk83RWp6OXZyZUlvVExETHE2?=
 =?utf-8?B?T1NUT1psVkZyREc1VjhMUFRTdGlYWmVWZ014b2J6cWU0eEd5dko3YUdrRnU4?=
 =?utf-8?B?cEg4cUJWSkwxaUJzMjJvSjdXOTRIcStkS2xFdHExOTNUOGhVTVVkdHNrYVpF?=
 =?utf-8?B?U3RaMThXcjI0RUdwS2xlRGtVTjlhK0V2SkJPQ09sS2hyZ21mNytlSWEzcUp3?=
 =?utf-8?B?OTMwYk93QU04SDdIUWJ0b29jUU5rN1E4d2VPQXozdUNQL2pPZG5zRFBxc2pD?=
 =?utf-8?B?OFhkUUc4RzlIcWUvdW5qbXZJcHFkdk9SbUl5VVRMbHplRzhoVUlWa1dmYkpY?=
 =?utf-8?B?SVRkRnJMWndYek44THhXMHVDT3JwTDY2S2RKRDQ3N0ViRmh3VEFCYTRWYkZz?=
 =?utf-8?B?UEQ5cXFqQ1ZaNkZwaWMraXh0QmpKTjF6YUsraXp1ZmJKMU5URUlMVE11bFkr?=
 =?utf-8?B?NEZsS3dJZkswZU0yZzkzV2c0Y2RzMlU3ZG5FdlNZV3ZmQlZqdnAvbnhrUDZz?=
 =?utf-8?B?T1NCQVN6cmRXYmtiZDNKbkRRTXZiU0hDTUN3OXBiT1dMY1hwcVVwT0k4ZE0r?=
 =?utf-8?B?UDl6VTk2dkdIZkdEdlJ4QnBjWkJBVFNmbGFGSmxWK21hTXpoa2VRaW1mazNa?=
 =?utf-8?B?ZW5lOExMMjBPcFJhemZBRE1KQndYTWR6TGwzeGVmQllsTjl2TDdVaytJaHZn?=
 =?utf-8?B?QjEzUWQ0N0VtT2FaVStTT0lBT0JDNE10QTdZaWZKQXloY21SRzZ6cDhCcjRl?=
 =?utf-8?B?WjR6QmdmWTcwVjF1U0Q4eS8vTGwzNkNzTm1KUGREc1NTWUZqK0pCcWlyZVJV?=
 =?utf-8?B?Y2VkQTBPSEZGbHFzTkFVS21HMlEzMkdCbnFIdFgxM05UbjQ2eEpQaFF5NGZi?=
 =?utf-8?B?M093NUxIbUFKQkREaFMwZ3R1cWZ5Z1ptMjdqQ0J2ZVArS0xDSkkxdHNLM0hV?=
 =?utf-8?B?RTJHTmwybWdKTnFJeWFKS1VTc3F0alUrNVVxSE9FWi9sWDJmRDZWWWM2NnFv?=
 =?utf-8?B?MmhPRUw1SUdXV3c5NmZlc0hBYTFsYkw3d01qSVhjQjRSK2FmS1pjWG8yNFNy?=
 =?utf-8?Q?tFVUM43HAwOLH9vtnFog7tBXq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993e3660-d841-4fa2-12e9-08dd65a49985
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 22:39:38.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABWS9J+8uquAyiyaTsAaj5npXFlGRMXGF4IPdMKvLrwf3HMvDRAdDSBYWHtVd3v74LdR5VmXeSL1PG0BimjkMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076



On 3/17/2025 11:16 PM, Tejun Heo wrote:
> Hello,
> 
> On Mon, Mar 17, 2025 at 10:48:16PM +0100, Joel Fernandes wrote:
> ...
>> Just to clarify, Tejun is suggesting that in mixed mode, we boost EXT
>> independent of FAIR. And in normal mode, we we boost both FAIR+EXT, because well
>> - nothing would be running as fair anyway.
>>
>> But what is the point of doing that, if we have boost EXT independent of FAIR
>> anyway? We need that code _anyway_ due to mixed mode so it would not simplify
>> anything.
>>
>> Or did Tejun mean something else about "toggle the reservations"?
> 
> My understanding is that if we have both FAIR and EXT's DL servers reserving
> execution time all the time, we'd be reserving execution time for something
> which can't be active, so the only change necessary I think is just
> retracting FAIR's or EXT's reservation whent we know they are not active
> (ie. if EXT is not loaded or EXT is loaded in full-sys mode).
> 
Ah, I see what you mean. We already have a 'toggle' like that though because if
FAIR or EXT is not running (due to whatever reason), we would have already
called 'dl_server_stop()' or would never have called 'dl_server_start()'.

On the other hand, even if full-sys-mode, we need the EXT server to boost it to
above RT if EXT is running, so we need its server initialized and ready to go.

Let me know if I missed anything though, thanks,

 - Joel





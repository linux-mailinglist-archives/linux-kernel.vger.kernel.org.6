Return-Path: <linux-kernel+bounces-345877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69698BC57
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F8BB23E79
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4F71C4612;
	Tue,  1 Oct 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="kJuXebIS"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688381C2451;
	Tue,  1 Oct 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786306; cv=fail; b=lbCpeNiRtXR9YpqW6/cMArb3XwqD6Z8BQAKtbMiIgcotb0jhGsveauamXQy1c/jSZnRGXxycpQCszELt6cg/pmk55FSPjfxrIdZOg7gcMG3reOIzUokkw9H4Z5vue7GmWIyAznOKndL2tzThVFp0HqJzkFmSrtXHqBSH2rV67XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786306; c=relaxed/simple;
	bh=8iYVd/t6H9GPfS8rBuZKo8Mu8Vj+1FASIlNGbmZcRfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wax6OoCQVnSIElvc6leB7Ts4vWxis4GJeDBTVPA9fMIkU96y+hGQsb2DecoZ68eMn6tgnIOiaCS3GKTnyz0sFY69Idp4n3tEsB8FTjtTloMfDkr+AqDjNuNK2bWAOKNkpzh6Rts7SS+BBjcq92MCHin+/FwrX/XDO9etQQmtZJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=kJuXebIS; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNsAteULga92FtZ1oXSKT24/KzuInkaGhu/YSq/gf+l8RoM5j5jSKcuPO4cbaHLhaKZekfoRtSQTuXQLjibumhwvLSnLE5PNh1eRBe/TGt5F/DWBRO6B0vPGIQqnIunzP3zsgip6ivKgL9mTP8HEIPGhnjzqc8d/TOMXnvUtDIomdzzzRoYL7IDVD0DjBMM3r06hsHciRpni9R7BSSYOaD0f9lyZBT7HciAQzCZcUPD+MQzTQ988I7v8Iv8za0ojLB6esEskYQ4PHcha9k7/K66Q1spnOeEFoyV0IBKWBvAWOcTcQzrkEAP04VlHWgS8xZKqRUt6KPiMjNS4cxESXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLC93D5o6KUegYPXxUNBflUipw/Ponofcu5EpQsi9yI=;
 b=dkaW891Nq9xBcMRvIFeUwdvmnyKwuAXMm+83rdKovrguXPx1ZMAO5khGusFzlTi8JJV5jSQf80rU3uZW++izZH35xU/lIGqgoFCyqq7KxZ2hX089ZFNzUEePNS3zdBhs9ySWs4HGDnSY9X7VBQ1gDxcdvSwmOo80Tf7spfxl1yl2Hde3WVWkAU+ohz3yNGBBo2BW4rEPizE0I+jcccytUmtm42EmT7SHGujY2PdDZPeiovj2S1wZ92TPuucJUIJ7Oc19sykWlcYDxIDdl1JjSPjgYATHaqHVMIbDlF4x3LxY2vcA9kXft/js3Fh4IUU50m4PgRn2Dx66fkS21XkJng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLC93D5o6KUegYPXxUNBflUipw/Ponofcu5EpQsi9yI=;
 b=kJuXebISBB14Wsa3Drrb8bRUs1ItU5zXvC9p4uMhPGukjCc4U4UEbWq5DlTk9wl7y95ZqmKJNHJzDFzafCqk6nrJR5iQF5QWDm556KDuYdl9wHHX/hqQujhkp5H8uWKYHh2nHZJyIVWwD7sQQL5DDTPSjrKqBbFjK1gn5rJpgLCQSzgaq7cNH3uHG09kHJCw/4gCC1pSCJ+orXPhvvimpp3hO7/BizIU16S26jjUsMIpqM4LogLVWMjBNAoc+j5yiSsSmRD12hFTo8J66P0ytgqZmIdtyvifI7FuMFi74Y69MrW+6PUf1NTbox6FijcjENxqoo4js0ztW+hZCWkIyA==
Received: from AS4P195CA0004.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::19)
 by PAVPR10MB7140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 12:38:18 +0000
Received: from AM4PEPF00027A6B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::ab) by AS4P195CA0004.outlook.office365.com
 (2603:10a6:20b:5e2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 12:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM4PEPF00027A6B.mail.protection.outlook.com (10.167.16.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 12:38:18 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Oct
 2024 14:38:01 +0200
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2000.de.bosch.com
 (10.139.217.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Oct
 2024 14:38:00 +0200
Message-ID: <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
Date: Tue, 1 Oct 2024 14:37:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] hrtimer Rust API
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Anna-Maria Behnsen
	<anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>
CC: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6B:EE_|PAVPR10MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 6986bf9e-567e-45bc-c27d-08dce215ed5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVdaVHhkTFB2SGJ3RGp2WjRuWW9rNjJ5RTNoZDRrRWxCSDlLNHZmOWFzN0E4?=
 =?utf-8?B?VXQwWERCdjFWS2JLNjNlODlSV2I1cS9aYTJRWklPd0VOcGRWR2VqRnEyYW1w?=
 =?utf-8?B?amN6bDZnN3djVS9ZVWdTYXo5clh6RitwN29pejB2MkRKREJHZzRKUEVRd0dk?=
 =?utf-8?B?NHcxdUYxc1NlbENobXAvVmlJZklOTTFWajN0ekpwdkxFUDNPa0VzZ3hxMksy?=
 =?utf-8?B?WVhmUGZRaC9pL0ZkaEI5Q0hTb3ZpMUlDWERIaDQvT25aUHVOWVEyLysyd25E?=
 =?utf-8?B?V1E4bS9jc3J0SWVORlBYS0lGQ1lOK3ZTRmxRWTJDTXRTR215VktkSjNKZkZx?=
 =?utf-8?B?eWhsTTREQ2FaZVpqTmFZcmRQVVhrbGh6b3loa1RjdWFUeXg4MEZCcm1FN05J?=
 =?utf-8?B?RHVFdUNYNjRhN0pZaGlQWUNQU3luSWZ6a2Ewb3BoaEw5V05zeURORnY5dUl5?=
 =?utf-8?B?WExCV1J5bGZlNmNFOG0wOE1hM2NSbyt5Vy9CSzUyQUdnU3Y0UTVkNnRBdkhY?=
 =?utf-8?B?TGRiVW90MFYzbVoxTkRMbW80cHZzQ1VmZ25MakxzRmV4Z2dYV1prd2g5ckly?=
 =?utf-8?B?dnVGRVQ3TE5hcmNYejgxRmpQdWo2TGNuT3dLcEpJWTg2RWNxdTY3bWlvZmNS?=
 =?utf-8?B?b2k3T1R4ekZSYnJpZlBPeWt6OFdoU01xbHgwNVJveTVVQ1hMcEVOUHA0cTgx?=
 =?utf-8?B?VlFmcm1UU3pqQzN4YmVtZWNxVklrNzl4cjlMNzdGMEpaU1BwV2F0enFoemk3?=
 =?utf-8?B?V1dKNnh1U1lWMDA4bDIrUHd5Y1BjbEpVSkM3RVJFcmlCL0t3YkRocnZKL2JE?=
 =?utf-8?B?cnNhTDNPeXVadUJwZFg1RHU5Y2ZQbzZWYWptbXQ5NDdaMWQ5UzIvYWVUVXZN?=
 =?utf-8?B?MlgxTyswNjlVYTFUZVo3U1Bta25yOFhWV2UwZEJrdTBrZmtRWXUwb1R3TWY3?=
 =?utf-8?B?K2pvdXdVVGtJRnhNbnljbGNQTWRkZ0tCYmpLQmtSNVBtRjR4elV1QUtRRndS?=
 =?utf-8?B?VzNHZG1JK2N5TVBhcEFrd1lrQWNhckNsaEthVk9HbUhzNTJZejllY0c2cTRE?=
 =?utf-8?B?U2lOTWpLWEFKMXZsWEhrcU9JNlN5U1BWVEFDSzlYVVFDTFRscHM2QUFlRTV5?=
 =?utf-8?B?YUtVbWpUOUF3Z0VoU3V1V3pNcnZkSGZTTkdOWlpwU25POTExeEZlVlZjcXZV?=
 =?utf-8?B?bW16ZVJvb2I1U1BXVXdwclRuVmlJajgvSlZWNDVxZmxTbHVDNE4wcklhVEFn?=
 =?utf-8?B?aEFRZVpOQmVDbE5FTkM5R0lTbjYwazZEa2hNS0lEZ2gwZ25FSDB2Q2xDbTIr?=
 =?utf-8?B?T0RUQkFOMnEwYWl6ZzJ2dkxIR2Z3RWoyaHl3UjIzMUlEck1oa1B0dFZHclFv?=
 =?utf-8?B?NzdXMjFzOWF0Uk8yOXpCb1EvczUwOVFHdklObmhuVFBYMUNaai95WUk0Qkxw?=
 =?utf-8?B?V0ZxdkJ2bEFBSGVBKzZhMDhoTDMrYXN1c2JFZ1VJemJoZTJSa0FQMVpReXN6?=
 =?utf-8?B?VWwrOHI3ZmVBNHFQcktDb1JSWUFRQnVWU2dEYzBsWHg1OW1TaC9wWjRQRHVO?=
 =?utf-8?B?VkQ5M2d2QnJxbndOeG1sNldMcWErdXR4OENZc2pqRU85MzM0eGdzRFFaTzZG?=
 =?utf-8?B?NG9oaXEwQTkreDZuNzdMRm9yZzlJeGdiMk1obE9FOGIvQ0JJaWNYdmluQytx?=
 =?utf-8?B?MUgyVTJYemFudmpOdXNMWHFTaTB5VjRZZ1FJREhvQUhPNm13alZXejdIVGJh?=
 =?utf-8?B?VkNIcWRuaWxkWmljQWNmWGh5djhsR0V1ZGdwL3VvR0xoMk5wRmZBR09rUHFE?=
 =?utf-8?B?QndoTEdwaTdmK0dnKzhBS0U1ZU1PUU15aWtwK05XTHhEVGtTWTl5b0lsYTJt?=
 =?utf-8?Q?c8rC9wc92rd0/?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:38:18.3184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6986bf9e-567e-45bc-c27d-08dce215ed5f
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7140

On 18.09.2024 00:27, Andreas Hindborg wrote:
> Hi!
> 
> This series adds support for using the `hrtimer` subsystem from Rust code.
> 
> I tried breaking up the code in some smaller patches, hopefully that will
> ease the review process a bit.

Just fyi, having all 14 patches applied I get [1] on the first (doctest) 
Example from hrtimer.rs.

This is from lockdep:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785

Having just a quick look I'm not sure what the root cause is. Maybe 
mutex in interrupt context? Or a more subtle one?

Best regards

Dirk

[1]

     # rust_doctest_kernel_hrtimer_rs_0.location: rust/kernel/hrtimer.rs:10
rust_doctests_kernel: Timer called

=============================
[ BUG: Invalid wait context ]
6.11.0-rc1-arm64 #28 Tainted: G                 N
-----------------------------
swapper/5/0 is trying to lock:
ffff0004409ab900 (rust/doctests_kernel_generated.rs:1238){+.+.}-{3:3}, 
at: rust_helper_mutex_lock+0x10/0x18
other info that might help us debug this:
context-{2:2}
no locks held by swapper/5/0.
stack backtrace:
CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Tainted: G N 6.11.0-rc1-arm64 #28
Tainted: [N]=TEST
Hardware name: ARM64 based board (DT)
Call trace:
  $x.11+0x98/0xb4
  show_stack+0x14/0x1c
  $x.3+0x3c/0x94
  dump_stack+0x14/0x1c
  $x.205+0x538/0x594
  $x.179+0xd0/0x18c
  __mutex_lock+0xa0/0xa4
  mutex_lock_nested+0x20/0x28
  rust_helper_mutex_lock+0x10/0x18
 
_RNvXs_NvNvNvCslTRHJHclVGW_25doctests_kernel_generated32rust_doctest_kernel_hrtimer_rs_04main41__doctest_main_rust_kernel_hrtimer_rs_10_0NtB4_17ArcIntrusiveTimerNtNtCsclYTRz49wqv_6kernel7hrtimer13TimerCallback3run+0x5c/0xd0
 
_RNvXs1_NtNtCsclYTRz49wqv_6kernel7hrtimer3arcINtNtNtB9_4sync3arc3ArcNtNvNvNvCslTRHJHclVGW_25doctests_kernel_generated32rust_doctest_kernel_hrtimer_rs_04main41__doctest_main_rust_kernel_hrtimer_rs_10_017ArcIntrusiveTimerENtB7_16RawTimerCallback3runB1b_+0x20/0x2c
  $x.90+0x64/0x70
  hrtimer_interrupt+0x1d4/0x2ac
  arch_timer_handler_phys+0x34/0x40
  $x.62+0x50/0x54
  generic_handle_domain_irq+0x28/0x40
  $x.154+0x58/0x6c
  $x.471+0x10/0x20
  el1_interrupt+0x70/0x94
  el1h_64_irq_handler+0x14/0x1c
  el1h_64_irq+0x64/0x68
  arch_local_irq_enable+0x4/0x8
  cpuidle_enter+0x34/0x48
  $x.37+0x58/0xe4
  cpu_startup_entry+0x30/0x34
  $x.2+0xf8/0x118
  $x.13+0x0/0x4
rust_doctests_kernel: Timer called
rust_doctests_kernel: Timer called
rust_doctests_kernel: Timer called
rust_doctests_kernel: Timer called
rust_doctests_kernel: Counted to 5
     ok 22 rust_doctest_kernel_hrtimer_rs_0
     # rust_doctest_kernel_hrtimer_rs_1.location: rust/kernel/hrtimer.rs:137
rust_doctests_kernel: Hello from the future
rust_doctests_kernel: Flag raised
     ok 23 rust_doctest_kernel_hrtimer_rs_1
     # rust_doctest_kernel_hrtimer_rs_2.location: rust/kernel/hrtimer.rs:76
rust_doctests_kernel: Timer called
rust_doctests_kernel: Flag raised
     ok 24 rust_doctest_kernel_hrtimer_rs_2


Return-Path: <linux-kernel+bounces-511601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DBBA32D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15AE161932
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0D5213232;
	Wed, 12 Feb 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="NQrVQr0S"
Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46A250C1A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380386; cv=pass; b=V7j6fJyYV0wMfvJJWwIYa5lfpD3GJjp/G9nEeRY7mnKKB1mbmprwsTKL/J40WA7fc7GSKXWv1CrspokqfWFE5nX0b+glWIEs4A+qFHeSqQPjv7R6TCFdFnFn3cARspoE399gQItBIKle+0CjPN/3OGTwIDdiVBxjMm1hcOKRt0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380386; c=relaxed/simple;
	bh=BINOaAtuARGQA3WgpBEy2+PrSGh7d+oXhbyEU6vFV1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5Ckg2iicdXBoTR2y00XhRFFr5jYZ3OEtaK2cwLOl1/QBQgeIb19R6n6+TgG9iCozi5M0JaHVTl14pp1R6TQyIpEbirPo+LI4+PLIEw+4XZ8tKzW6EAhlY4TG4d8VTeIq51mYF3UGYNkpsRiJ4co+xORlPOGgKgOfrHfxaQumCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=NQrVQr0S; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0068E84391;
	Wed, 12 Feb 2025 17:02:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a201.dreamhost.com (100-122-220-145.trex-nlb.outbound.svc.cluster.local [100.122.220.145])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3A06D8340D;
	Wed, 12 Feb 2025 17:02:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739379737; a=rsa-sha256;
	cv=none;
	b=EUw7XLTp+RuAd3nunzoixF+g/nD65Reu/x9aIc8zjRhyeYqBk40OIdTRvcMnsSbV29Gwcj
	FshDjzTBXUdq1frs0Y8UGmKwVo7l0GmT8G6Tr7Oh59JnyrADwiSYdrqA1Apzr41cevNc68
	JbwVHXb1R2bK5XgWs3ScwDfBzgpiW9sUghrpP9iUqRB7ZhFsQLPa5ivb7jfxlLkchY8Sd0
	hy6evbiypIjReYO2G9wOG1ujHY1yU2x66bHrUkW0L9MMLaFrY1JkCik7ns7tpoMfz1M4IL
	3884N7IB3auSUVbPq+WWuuqkgMh2ZI8e+592lxtIa4E56W6iDfxclZXEqDP61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739379737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EBzRTmDn9RGkKaDCxFY4rdfvgu3ROy2TO3tpi8O0p14=;
	b=oR8QP+XzSLMzzN0foqSowV66dZKzjDGNv2ixRZ1PSqIrpTlkoKtU4jvEvzV/hiH++M1i3G
	edrOFHp6rzg8m5hq/3n3uSCv90+B2AUO0SmFjNyCLfU3xZFB06xpbhhiJpagrSsnSrAUvB
	UvPX62pqc76vZeyEd8DFxw5C5W0mw2z13H6NimEJXGMyFbAMmdkzU23CBuqzxCTUzYkv5B
	Qb89Kh9a/KdOg6xo2xla9WO/wGwmXxVXI4iDgCH4Nq4t841yDbp71VmZ2r0CuYKcFtMcWi
	iI/HbWsofDKkPdHxcECsnROIV6xN7a1XxWz99z7wHn1fYxr8HgqI0dVh8RZ3cQ==
ARC-Authentication-Results: i=1;
	rspamd-85897f8565-7nq87;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Madly-Language: 4f2c550c4a5244c8_1739379737734_2344064167
X-MC-Loop-Signature: 1739379737734:1008128835
X-MC-Ingress-Time: 1739379737734
Received: from pdx1-sub0-mail-a201.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.220.145 (trex/7.0.2);
	Wed, 12 Feb 2025 17:02:17 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a201.dreamhost.com (Postfix) with ESMTPSA id 4YtPkH4JB5zGy;
	Wed, 12 Feb 2025 09:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739379737;
	bh=EBzRTmDn9RGkKaDCxFY4rdfvgu3ROy2TO3tpi8O0p14=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=NQrVQr0S/AmkFzSOVrM1Zy9gYPnUGcgzM+26l9JvxJ+jRFHVMxsIVU8zQD8qKlx7G
	 vcYIq+bsREQb1yBnJ/CIL7zKl8lr65H5FMdXCre9vDEc7q/LFuc4J01ybodITETinz
	 MPmaLFtez1V8+/FF51bFxQM74IWj7ihI/deXmAtHr2l+b+NtNNkLTlVtAh0Kn8yTLa
	 A5VQ4U3s8uPO8gaNsjr57Hay17mJNMaH1zJMei5WD2Fd+oybyaACBBrgR5o+j6QKDO
	 C+No67zLJ/8Ik3Tc25PPUYwfDkAeyxLtbw1Xh5v4XVPC2OkRGGzpRET5uipms1KvXe
	 zsPUMDZXIXv0g==
Date: Wed, 12 Feb 2025 09:02:12 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, gourry@gourry.net,
	nehagholkar@meta.com, abhishekd@meta.com, david@redhat.com,
	ying.huang@intel.com, nphamcs@gmail.com, akpm@linux-foundation.org,
	hannes@cmpxchg.org, feng.tang@intel.com, kbusch@meta.com,
	bharata@amd.com, Hasan.Maruf@amd.com, sj@kernel.org,
	willy@infradead.org, kirill.shutemov@linux.intel.com,
	mgorman@techsingularity.net, vbabka@suse.cz, hughd@google.com,
	rientjes@google.com, shy828301@gmail.com, Liam.Howlett@Oracle.com,
	peterz@infradead.org, mingo@redhat.com
Subject: Re: [RFC PATCH V0 0/10] mm: slowtier page promotion based on PTE A
 bit
Message-ID: <20250212170212.f5coa462p75fuqj6@offworld>
Mail-Followup-To: Raghavendra K T <raghavendra.kt@amd.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gourry@gourry.net,
	nehagholkar@meta.com, abhishekd@meta.com, david@redhat.com,
	ying.huang@intel.com, nphamcs@gmail.com, akpm@linux-foundation.org,
	hannes@cmpxchg.org, feng.tang@intel.com, kbusch@meta.com,
	bharata@amd.com, Hasan.Maruf@amd.com, sj@kernel.org,
	willy@infradead.org, kirill.shutemov@linux.intel.com,
	mgorman@techsingularity.net, vbabka@suse.cz, hughd@google.com,
	rientjes@google.com, shy828301@gmail.com, Liam.Howlett@Oracle.com,
	peterz@infradead.org, mingo@redhat.com
References: <20241201153818.2633616-1-raghavendra.kt@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241201153818.2633616-1-raghavendra.kt@amd.com>
User-Agent: NeoMutt/20220429

On Sun, 01 Dec 2024, Raghavendra K T wrote:

>6. Holding PTE lock before migration.

fyi I tried testing this series with 'perf-bench numa mem' and got a soft lockup,
unable to take the PTL (and lost the machine to debug further atm), ie:

[ 3852.217675] CPU: 127 UID: 0 PID: 12537 Comm: watch-numa-sche Tainted: G      D      L     6.14.0-rc2-kmmscand-v1+ #3
[ 3852.217677] Tainted: [D]=DIE, [L]=SOFTLOCKUP
[ 3852.217678] RIP: 0010:native_queued_spin_lock_slowpath+0x64/0x290
[ 3852.217683] Code: 77 7b f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4 09 d0 3d ff 00 00 00 77 57 85 c0 74 10 0f b6 03 84 c0 74 09 f3 90 <0f> b6 03 84 c0 75 f7 b8 01 00 00 00 66 89 03 5b 5d 41 5c 41 5d c3
[ 3852.217684] RSP: 0018:ff274259b3c9f988 EFLAGS: 00000202
[ 3852.217685] RAX: 0000000000000001 RBX: ffbd2efd8c08c9a8 RCX: 000ffffffffff000
[ 3852.217686] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffbd2efd8c08c9a8
[ 3852.217687] RBP: ff161328422c1328 R08: ff274259b3c9fb90 R09: ff161328422c1000
[ 3852.217688] R10: 00000000ffffffff R11: 0000000000000004 R12: 00007f52cca00000
[ 3852.217688] R13: ff274259b3c9fa00 R14: ff16132842326000 R15: ff161328422c1328
[ 3852.217689] FS:  00007f32b6f92b80(0000) GS:ff161423bfd80000(0000) knlGS:0000000000000000
[ 3852.217691] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3852.217692] CR2: 0000564ddbf68008 CR3: 00000080a81cc005 CR4: 0000000000773ef0
[ 3852.217693] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3852.217694] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 3852.217694] PKRU: 55555554
[ 3852.217695] Call Trace:
[ 3852.217696]  <IRQ>
[ 3852.217697]  ? watchdog_timer_fn+0x21b/0x2a0
[ 3852.217699]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 3852.217702]  ? __hrtimer_run_queues+0x10f/0x2a0
[ 3852.217704]  ? hrtimer_interrupt+0xfb/0x240
[ 3852.217706]  ? __sysvec_apic_timer_interrupt+0x4e/0x110
[ 3852.217709]  ? sysvec_apic_timer_interrupt+0x68/0x90
[ 3852.217712]  </IRQ>
[ 3852.217712]  <TASK>
[ 3852.217713]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[ 3852.217717]  ? native_queued_spin_lock_slowpath+0x64/0x290
[ 3852.217720]  _raw_spin_lock+0x25/0x30
[ 3852.217723]  __pte_offset_map_lock+0x9a/0x110
[ 3852.217726]  gather_pte_stats+0x1e3/0x2c0
[ 3852.217730]  walk_pgd_range+0x528/0xbb0
[ 3852.217733]  __walk_page_range+0x71/0x1d0
[ 3852.217736]  walk_page_vma+0x98/0xf0
[ 3852.217738]  show_numa_map+0x11a/0x3a0
[ 3852.217741]  seq_read_iter+0x2a6/0x470
[ 3852.217745]  seq_read+0x12b/0x170
[ 3852.217748]  vfs_read+0xe0/0x370
[ 3852.217751]  ? syscall_exit_to_user_mode+0x49/0x210
[ 3852.217755]  ? do_syscall_64+0x8a/0x190
[ 3852.217758]  ksys_read+0x6a/0xe0
[ 3852.217762]  do_syscall_64+0x7e/0x190
[ 3852.217765]  ? __memcg_slab_free_hook+0xd4/0x120
[ 3852.217768]  ? __x64_sys_close+0x38/0x80
[ 3852.217771]  ? kmem_cache_free+0x3bf/0x3e0
[ 3852.217774]  ? syscall_exit_to_user_mode+0x49/0x210
[ 3852.217777]  ? do_syscall_64+0x8a/0x190
[ 3852.217780]  ? do_syscall_64+0x8a/0x190
[ 3852.217783]  ? __irq_exit_rcu+0x3e/0xe0
[ 3852.217785]  entry_SYSCALL_64_after_hwframe+0x76/0x7e


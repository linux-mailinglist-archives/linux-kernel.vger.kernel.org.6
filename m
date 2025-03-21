Return-Path: <linux-kernel+bounces-572057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E5A6C5FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FCE3BDC6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AFD224B1C;
	Fri, 21 Mar 2025 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="kspR0a8N"
Received: from hedgehog.birch.relay.mailchannels.net (hedgehog.birch.relay.mailchannels.net [23.83.209.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DF15D5B6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742596311; cv=pass; b=PU4r2oMBPpUTTIF3lGqiHc/oVFN1EDvgtCcBxjQGVK3Qejf7dySK/cfN6CpYiMhLetHQ/mqHtkhjnvQvN2R+h8SZDHINgo083OWKZvaqdmx2htMBeguLFK+jqOs0XTtjaJ/tFfINOy1lffOnGS8twi8qUPsn/dEuuNU660O2hcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742596311; c=relaxed/simple;
	bh=3GMemDzCk9gCgWhtCQVQL5LGUYbfc9HlvaOFhx71Yf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjho4oKiWJwCXmlL7wWB2l2XQkGYPusOXDMf8N1p0fF88uiRfs4Mp8UFJCrCHlYAQ0y3sbUoY1yN6zPwXFywsxyUtMXPfOGYYW3Y4+8Ov9ssZc3c1EClY5RmUpdIovTRTE6O7RMGHZKkz8AiMcLetEvMRFIa7lN4Uvn/g1VRNOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=kspR0a8N; arc=pass smtp.client-ip=23.83.209.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 303841C3340;
	Fri, 21 Mar 2025 20:36:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a201.dreamhost.com (100-114-55-179.trex-nlb.outbound.svc.cluster.local [100.114.55.179])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 657701C3EEA;
	Fri, 21 Mar 2025 20:36:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1742589361; a=rsa-sha256;
	cv=none;
	b=Mp5i05P3zyZAEtXoSt0LDQbhZHXXJu47GjU/Lrp6iGJkqwPwzpPrm/SetmyaVf/qOGGjmu
	7eDo5BjbzZ0T1oiLv3fZZrRoqi/s5uOBMr9nwvTqLv0Rl321KNahugIwHUwphCNMHy1wT2
	oPe3A2WE1ZFmbR8TQvfCP/vMD8n7eVCh9H3O2x+gOfeCwKp+4YDZWfs+OlXTo/55mbp6XH
	yMe7F3/5TmVVbmKGFXqrY63ky6Xny+lu+ai9I9UzKToPB1jA/wSKQH/Y87Gc3zWc0k8txe
	PXDUGYicYCCQoChfNVj025/eaVEULon2osnr57FMADWGWd4EtGJDLZvgYrd1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1742589361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=x+j+G57vRdNmya3RSMG6eYh/qXdRckMAPuNhrWyEnas=;
	b=N3tnGxDnDNq2PB4I/G9GmguKkHrKIj/Su2RbEsusUXgEEY8w1tjm04ewFuYyVu3kpiqG8n
	ZloelrvU/5MmRfh01AGci+5BVGlxm2NaHm4aYZ8wKW5+/SY6AAuefh8L+DfYad7aPIxkID
	Qx4G5WtLLNVqiIGheI44+OOvbFXFwexaASZwoJ9SMK+6FNfQTqVFEsopbbGZTRuNEzFpA1
	3/iyT1i3/7Q9ssd/e3ej3EKY0+11vx/q7dlBvd7jDqcjqM0TeQ82lCrtdzzWP2MQdj2I9p
	o6GP9Uqot926eFQmqRvN4SlFMxWfJwKJxEj/aZOAMHxerzbHjd7Xw+cFNNtIRA==
ARC-Authentication-Results: i=1;
	rspamd-57868978c-pz9bk;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Dime-Abaft: 19088877483e627f_1742589362038_3101943224
X-MC-Loop-Signature: 1742589362038:1940855794
X-MC-Ingress-Time: 1742589362038
Received: from pdx1-sub0-mail-a201.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.55.179 (trex/7.0.2);
	Fri, 21 Mar 2025 20:36:02 +0000
Received: from offworld (unknown [104.36.25.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a201.dreamhost.com (Postfix) with ESMTPSA id 4ZKDjq037tzHY;
	Fri, 21 Mar 2025 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1742589361;
	bh=x+j+G57vRdNmya3RSMG6eYh/qXdRckMAPuNhrWyEnas=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=kspR0a8NL6IcwEMK+I7cU9i284aLmvyFL9MtpVrTVQ/OKo+mt/ICgqpd8HR/to4xy
	 3ZRD5KYOmGGg0Ma3L8L/zNN9ikMtavaYJPB9E0FR9AIJle1qNlum07NEjnCBUskfJI
	 FChe05nb+5ns3oursoPGRCH3gSGxEWZjojeAekeyENPo9xQgenWd2lFsEDXz85adgL
	 gV7oLYtIkSEUqCcvRAbG/PHbCd3yFdKjYo1K1rwOwgc5o60ku4oyZn1FyNqicJNOTd
	 ihycpB3g4QmQ6DArU122nwCYIfUgPSTaTRS426l50SiOqxFyjMtOVoVZks+k+Iynmb
	 cqoP/Iqbrd45g==
Date: Fri, 21 Mar 2025 13:35:55 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
	Michael.Day@amd.com, akpm@linux-foundation.org, bharata@amd.com,
	dave.hansen@intel.com, david@redhat.com,
	dongjoo.linux.dev@gmail.com, feng.tang@intel.com, gourry@gourry.net,
	hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
	jhubbard@nvidia.com, jon.grimm@amd.com, k.shutemov@gmail.com,
	kbusch@meta.com, kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com,
	leillc@google.com, liam.howlett@oracle.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
	nphamcs@gmail.com, peterz@infradead.org, riel@surriel.com,
	rientjes@google.com, rppt@kernel.org, santosh.shukla@amd.com,
	shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com,
	Jonathan.Cameron@huawei.com, alok.rathore@samsung.com
Subject: Re: [RFC PATCH V1 00/13] mm: slowtier page promotion based on PTE A
 bit
Message-ID: <20250321203555.4n6byk6vmnkmpewi@offworld>
Mail-Followup-To: Raghavendra K T <raghavendra.kt@amd.com>,
	AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
	Michael.Day@amd.com, akpm@linux-foundation.org, bharata@amd.com,
	dave.hansen@intel.com, david@redhat.com,
	dongjoo.linux.dev@gmail.com, feng.tang@intel.com, gourry@gourry.net,
	hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
	jhubbard@nvidia.com, jon.grimm@amd.com, k.shutemov@gmail.com,
	kbusch@meta.com, kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com,
	leillc@google.com, liam.howlett@oracle.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
	nphamcs@gmail.com, peterz@infradead.org, riel@surriel.com,
	rientjes@google.com, rppt@kernel.org, santosh.shukla@amd.com,
	shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com,
	Jonathan.Cameron@huawei.com, alok.rathore@samsung.com
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
 <20250319230015.bewglxf3hrf2mx3f@offworld>
 <52b2c1dd-2f4a-42fa-8a40-bd3664e7c56a@amd.com>
 <d0aedf71-047b-4ee4-9175-a67708a389de@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d0aedf71-047b-4ee4-9175-a67708a389de@amd.com>
User-Agent: NeoMutt/20220429

On Fri, 21 Mar 2025, Raghavendra K T wrote:

>>But a longer running/ more memory workload may make more difference.
>>I will comeback with that number.
>
>                 base NUMAB=2   Patched NUMAB=0
>                 time in sec    time in sec
>===================================================
>8G:              134.33 (0.19)   119.88 ( 0.25)
>16G:             292.24 (0.60)   325.06 (11.11)
>32G:             585.06 (0.24)   546.15 ( 0.50)
>64G:            1278.98 (0.27)  1221.41 ( 1.54)
>
>We can see that numbers have not changed much between NUMAB=1 NUMAB=0 in
>patched case.

Thanks. Since this might vary across workloads, another important metric
here is numa hit/misses statistics.

fyi I have also been trying this series to get some numbers as well, but
noticed overnight things went south (so no chance before LSFMM):

[  464.026917] watchdog: BUG: soft lockup - CPU#108 stuck for 52s! [kmmscand:934]
[  464.026924] Modules linked in: ...
[  464.027098] CPU: 108 UID: 0 PID: 934 Comm: kmmscand Tainted: G             L     6.14.0-rc6-kmmscand+ #4
[  464.027105] Tainted: [L]=SOFTLOCKUP
[  464.027107] Hardware name: Supermicro SSG-121E-NE3X12R/X13DSF-A, BIOS 2.1 01/29/2024
[  464.027109] RIP: 0010:pmd_off+	0x58/0xd0
[  464.027124] Code: 83 e9 01 48 21 f1 48 c1 e1 03 48 89 f8 0f 1f 00 48 23 05 fb c7 fd 00 48 03 0d 0c b9 fb 00 48 25 00 f0 ff ff 48 01 c8 48 8b 38 <48> 89 f8 0f 1f 00 48 8b 0d db c7 fd 00 48 21 c1 48 89 d0 48 c1 e8
[  464.027128] RSP: 0018:ff71a0dc1b05bbc8 EFLAGS: 00000286
[  464.027133] RAX: ff3b028e421c17f0 RBX: ffc90cb8322e5e00 RCX: ff3b020d400007f0
[  464.027136] RDX: 00007f1393978000 RSI: 00000000000000fe RDI: 000000b9726b0067
[  464.027139] RBP: ff3b02f5d05babc0 R08: 00007f9c5653f000 R09: ffc90cb8322e0001
[  464.027141] R10: 0000000000000000 R11: ff3b028dd339420c R12: 00007f1393978000
[  464.027144] R13: ff3b028dded9cbb0 R14: ffc90cb8322e0000 R15: ffffffffb9a0a4c0
[  464.027146] FS:  0000000000000000(0000) GS:ff3b030bbf400000(0000) knlGS:0000000000000000
[  464.027150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  464.027153] CR2: 0000564713088f19 CR3: 000000fb40822006 CR4: 0000000000773ef0
[  464.027157] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  464.027159] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[  464.027162] PKRU: 55555554
[  464.027163] Call Trace:
[  464.027166]  <IRQ>
[  464.027170]  ? watchdog_timer_fn+0x21b/0x2a0
[  464.027180]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  464.027186]  ? __hrtimer_run_queues+0x10f/0x2a0
[  464.027193]  ? hrtimer_interrupt+0xfb/0x240
[  464.027199]  ? __sysvec_apic_timer_interrupt+0x4e/0x110
[  464.027208]  ? sysvec_apic_timer_interrupt+0x68/0x90
[  464.027219]  </IRQ>
[  464.027221]  <TASK>
[  464.027222]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[  464.027236]  ? pmd_off+0x58/0xd0
[  464.027243]  hot_vma_idle_pte_entry+0x151/0x500
[  464.027253]  walk_pte_range_inner+0xbe/0x100
[  464.027260]  ? __pte_offset_map_lock+0x9a/0x110
[  464.027267]  walk_pgd_range+0x8f0/0xbb0
[  464.027271]  ? __pfx_hot_vma_idle_pte_entry+0x10/0x10
[  464.027282]  __walk_page_range+0x71/0x1d0
[  464.027287]  ? prepare_to_wait_event+0x53/0x180
[  464.027294]  walk_page_vma+0x98/0xf0
[  464.027300]  kmmscand+0x2aa/0x8d0
[  464.027310]  ? __pfx_kmmscand+0x10/0x10
[  464.027318]  kthread+0xea/0x230
[  464.027326]  ? finish_task_switch.isra.0+0x88/0x2d0
[  464.027335]  ? __pfx_kthread+0x10/0x10
[  464.027341]  ret_from_fork+0x2d/0x50
[  464.027350]  ? __pfx_kthread+0x10/0x10
[  464.027355]  ret_from_fork_asm+0x1a/0x30
[  464.027365]  </TASK>


Return-Path: <linux-kernel+bounces-407341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6989C6C27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCA61F21043
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4AD1F8934;
	Wed, 13 Nov 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y/ml5BAd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54F1F81A8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491778; cv=none; b=NRWR1zLpWypzfjlzTCxm4Y7jFHREDM4BK7yP8KMLfPbqKILpayPKBCSv7R6tRoiOmI3FDmtX1Dpg8O6PLWrcBquCVURtxo4idDX9ThHRasNnVGH5GjHhlWKTZvkH9n1HZbO1eOCREygOdDvnvewKuUGF3zUP6rPPbuFH3xhray0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491778; c=relaxed/simple;
	bh=qWwhPP+zP86baMvlNduuneQ/A/cguA7SbpChPIuo9a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAFDkt3Q3aeoEDwh/IfV0vXpbdDw3vlvZWV/hucZTNNgSU0xB3SQzSuamxvzDcPBRBgVITmAhqjBDhTpMpAitZzNLFe8OE+LLn9kmDeNCpdnm8bS7omYbPZROGCxy/hjzG1x0AosV+TzpOmOTtNgJeG695xfM95rS18DGldRC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Y/ml5BAd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6B5F440E0286;
	Wed, 13 Nov 2024 09:56:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AL6G30NJHyeP; Wed, 13 Nov 2024 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731491766; bh=eeFKEpp83y5urtvxXpaEhJddEahmtDywhuU7sb6Xrcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/ml5BAd2D2dpsxPX9kwhepBL64pWcufU0XKs8WIYN4S1EiZ8eE9wfuV7ddaxSTOe
	 32CcUZpvtb8ZE6uoJY6L5Dueo69BR8b5D6+lkIZyt7wZ8Ac+v7KfJ3MZjJOtrpZoE2
	 9iNIYuiAi8VDW6dqS88wr2aGARC8CJ8wtS1jF3Zx08x9ZFXIYCSZnArd0g0ghOmXbq
	 l2WuSo50bnwRmGk7VROToZKwpHHdly+25Gk4eks6zO8txB8LJaCWvKye8Ylxhl1ACm
	 42LLwUQO73OCRdLyxC1d7xE0ngkU5w2xQGia1DxdFd4Ui27Ooa1EfUYfO9H8Js8O3R
	 BkGJ7oyhQ66ryAJYoZgpX1pY2hGdR1+bupScQ3EeFe2uAAx7uXfTEZMxkfSG2sdBfF
	 2VhrCyi5NH1Smjt1qAp1LZ414Ckzv5IChU9eCpdD8rakmEMrvTNC1j6mJlZDHG+DvG
	 zIDjG07n91gT/ziZa/IXvhpOARtMJr77TyjhJ1ungJvm0gkZNq0Oo0S1i5y171oEj8
	 ixbyxxmyHyLQa6BQGocjHmupkTSZ1zi2gZnwaDf9DQ1Qd5b6ZQa1bVD0b9v77eUprl
	 vDivp0lxoGc8ugul0hoFpQQosP7XNEeAhBLWiPzpBdft7ozQB2IaAx3mvpe3qg1jkw
	 f7dfkrpLYbL7M3LiAEaSA7Ko=
Received: from zn.tnic (p200300ea973a3157329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:3157:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ADFD840E015F;
	Wed, 13 Nov 2024 09:55:56 +0000 (UTC)
Date: Wed, 13 Nov 2024 10:55:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, x86@kernel.org, kernel-team@meta.com,
	hpa@zytor.com
Subject: Re: [PATCh 0/3] x86,tlb: context switch optimizations
Message-ID: <20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local>
References: <20241109003727.3958374-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241109003727.3958374-1-riel@surriel.com>

On Fri, Nov 08, 2024 at 07:27:47PM -0500, Rik van Riel wrote:
> While profiling switch_mm_irqs_off with several workloads,
> it appears there are two hot spots that probably don't need
> to be there.

One of those three is causing the below here, zapping them from tip.

[    3.050931] smpboot: x86: Booting SMP configuration:
[    3.054476] .... node  #0, CPUs:          #1   #2   #3   #4   #5   #6   #7   #8   #9  #10  #11  #12  #13  #14  #15  #16  #17  #18  #19  #20
[    3.166533] Callback from call_rcu_tasks() invoked.
[    3.178695]   #21  #22  #23  #24  #25  #26  #27  #28  #29  #30  #31
[    3.186469] ------------[ cut here ]------------
[    3.186469] WARNING: CPU: 16 PID: 97 at kernel/smp.c:807 smp_call_function_many_cond+0x188/0x720
[    3.186469] Modules linked in:
[    3.186469] CPU: 16 UID: 0 PID: 97 Comm: cpuhp/16 Not tainted 6.12.0-rc7+ #1
[    3.186469] Hardware name: Supermicro Super Server/H12SSL-i, BIOS 2.5 09/08/2022
[    3.186469] RIP: 0010:smp_call_function_many_cond+0x188/0x720
[    3.186469] Code: 96 54 91 01 85 d2 0f 84 f7 fe ff ff 65 8b 05 37 8c e3 7e 85 c0 0f 85 e8 fe ff ff 65 8b 05 0c 89 e3 7e 85 c0 0f 85 d9 fe ff ff <0f> 0b e9 d2 fe ff ff 65 f7 05 4e c5 e4 7e ff ff ff 7f 0f 85 a6 fe
[    3.186469] RSP: 0018:ffffc90000dbfbe8 EFLAGS: 00010046
[    3.186469] RAX: 0000000000000000 RBX: ffffffff8109eeb0 RCX: 0000000000000000
[    3.186469] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffff824908dd
[    3.186469] RBP: ffff889003235380 R08: ffffffff8109eeb0 R09: 0000000000000006
[    3.186469] R10: 0000000000000013 R11: 0000000000000005 R12: 0000000000000010
[    3.186469] R13: ffff88810006a480 R14: ffff889003235380 R15: 0000000000000010
[    3.186469] FS:  0000000000000000(0000) GS:ffff889003200000(0000) knlGS:0000000000000000
[    3.186469] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.186469] CR2: 0000000000000000 CR3: 0000000002a3a001 CR4: 0000000000770ef0
[    3.186469] PKRU: 55555554
[    3.186469] Call Trace:
[    3.186469]  <TASK>
[    3.186469]  ? __warn+0xa1/0x1c0
[    3.186469]  ? smp_call_function_many_cond+0x188/0x720
[    3.186469]  ? report_bug+0x1b5/0x1e0
[    3.186469]  ? handle_bug+0x58/0x90
[    3.186469]  ? exc_invalid_op+0x17/0x70
[    3.186469]  ? asm_exc_invalid_op+0x16/0x20
[    3.186469]  ? __pfx_tlb_is_not_lazy+0x10/0x10
[    3.186469]  ? __pfx_tlb_is_not_lazy+0x10/0x10
[    3.186469]  ? smp_call_function_many_cond+0x188/0x720
[    3.186469]  ? smp_call_function_many_cond+0x2a/0x720
[    3.186469]  ? __pte_offset_map_lock+0xa4/0x190
[    3.186469]  ? __pfx_flush_tlb_func+0x10/0x10
[    3.186469]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.186469]  ? lock_acquire+0x11a/0x350
[    3.186469]  ? __pfx_flush_tlb_func+0x10/0x10
[    3.186469]  ? __pfx_tlb_is_not_lazy+0x10/0x10
[    3.186469]  on_each_cpu_cond_mask+0x50/0x90
[    3.186469]  flush_tlb_mm_range+0x1a8/0x1f0
[    3.186469]  ? cpu_bugs_smt_update+0x14/0x1f0
[    3.186469]  __text_poke+0x366/0x5d0
[    3.186469]  ? __pfx_text_poke_memcpy+0x10/0x10
[    3.186469]  ? cpu_bugs_smt_update+0x14/0x1f0
[    3.186469]  text_poke_bp_batch+0xa1/0x3d0
[    3.186469]  ? mptcp_pm_get_add_addr_signal_max+0x10/0x30
[    3.186469]  ? arch_jump_label_transform_queue+0x55/0x80
[    3.186469]  ? __pfx_sched_cpu_activate+0x10/0x10
[    3.186469]  text_poke_finish+0x1b/0x30
[    3.186469]  arch_jump_label_transform_apply+0x18/0x30
[    3.186469]  static_key_slow_inc_cpuslocked+0x55/0xa0
[    3.186469]  ? srso_alias_return_thunk+0x5/0xfbef5
[    3.186469]  sched_cpu_activate+0x45/0x190
[    3.186469]  ? __pfx_sched_cpu_activate+0x10/0x10
[    3.186469]  cpuhp_invoke_callback+0x159/0x6b0
[    3.186469]  ? cpuhp_thread_fun+0x81/0x290
[    3.186469]  cpuhp_thread_fun+0x203/0x290
[    3.186469]  ? cpuhp_thread_fun+0x81/0x290
[    3.186469]  ? smpboot_thread_fn+0x2b/0x260
[    3.186469]  smpboot_thread_fn+0x1ae/0x260
[    3.186469]  ? __pfx_smpboot_thread_fn+0x10/0x10
[    3.186469]  kthread+0xee/0x120
[    3.186469]  ? __pfx_kthread+0x10/0x10
[    3.186469]  ret_from_fork+0x4c/0x60
[    3.186469]  ? __pfx_kthread+0x10/0x10
[    3.186469]  ret_from_fork_asm+0x1a/0x30
[    3.186469]  </TASK>
[    3.186469] irq event stamp: 122
[    3.186469] hardirqs last  enabled at (121): [<ffffffff81106ff7>] balance_push_set+0xe7/0x110
[    3.186469] hardirqs last disabled at (122): [<ffffffff81048129>] __text_poke+0x489/0x5d0
[    3.186469] softirqs last  enabled at (0): [<ffffffff810b1ae5>] copy_process+0x9f5/0x2a70
[    3.186469] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    3.186469] ---[ end trace 0000000000000000 ]---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


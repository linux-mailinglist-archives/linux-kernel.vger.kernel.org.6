Return-Path: <linux-kernel+bounces-442267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1109EDA07
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3548416663A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB33204685;
	Wed, 11 Dec 2024 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUls12FN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562EB1F2C38
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956363; cv=none; b=KnhJ5T2IRYlhK5yQ8fKeZt0GldcsznLVZ279cMiowkOz/lACHujv9vQyMGJ04/Z02SkrhiXTVWuXjYLCBfkAGatw8Ms2nvvkqkF5/rB9OKNesZEavNxJWGRGmehiuYRe+9mcJCquXAJiaZOLPvhc5ePtN3CWmINU3HhqCYIiOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956363; c=relaxed/simple;
	bh=GMbLNjHYQHlthnl6X6B/C2qmZ1gVTWtoeCUN4jAlGyY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cAtW7DdyGIh3I/vghhhVOrM1LSuOyQ+KlorxQpH42zocEsaE2076kOHJjGJoSxNikyzmhMXDy/Nue6QFT83fJ4F9Ol4C3bLuEmQMWDynXA/CCCwIVP1GiLQmboJu5tDkvsX5cshqbmzl2RfTQl00/TR809kC3QPnrd0ho3vzbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUls12FN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1B8C4CED3;
	Wed, 11 Dec 2024 22:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956363;
	bh=GMbLNjHYQHlthnl6X6B/C2qmZ1gVTWtoeCUN4jAlGyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NUls12FN3SQfGL8gNK0d3XSvq5CEiEoBT0Ehc8gHs8vKLhadFUTVdxehhaZMTOSfB
	 f2e9DjeYYF1SkZnSTzd4uZufNPwFwjWtYC1x/Ov0fvC67pZf2wQfU5IEkbeJODoOic
	 KzRqnHqM8BWrBkSH2CjHQTWKQdGWoK3U9I/+ektGFuY1bRJfnU0XycCGiYafnhoOXR
	 lcfKvFhCrKGvU5q1V3Rilz2MblwKNvE/EAstR6gJK/qLApWx6qdtkPEj61hhT+hlF4
	 bpKqTLmNAnakfjPdfpD2hdUpckTdASV6NPZoPChM3qk95/u/XxfX96NEp3V43X26Lw
	 ndySRzbs7YFxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70A87380A965;
	Wed, 11 Dec 2024 22:33:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Fix IPIs usage in kfence_protect_page()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395637899.1729195.4700524807900643783.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:58 +0000
References: <20241209074125.52322-1-alexghiti@rivosinc.com>
In-Reply-To: <20241209074125.52322-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, glider@google.com, elver@google.com,
 dvyukov@google.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, liushixin2@huawei.com, wangkefeng.wang@huawei.com,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  9 Dec 2024 08:41:25 +0100 you wrote:
> flush_tlb_kernel_range() may use IPIs to flush the TLBs of all the
> cores, which triggers the following warning when the irqs are disabled:
> 
> [    3.455330] WARNING: CPU: 1 PID: 0 at kernel/smp.c:815 smp_call_function_many_cond+0x452/0x520
> [    3.456647] Modules linked in:
> [    3.457218] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.12.0-rc7-00010-g91d3de7240b8 #1
> [    3.457416] Hardware name: QEMU QEMU Virtual Machine, BIOS
> [    3.457633] epc : smp_call_function_many_cond+0x452/0x520
> [    3.457736]  ra : on_each_cpu_cond_mask+0x1e/0x30
> [    3.457786] epc : ffffffff800b669a ra : ffffffff800b67c2 sp : ff2000000000bb50
> [    3.457824]  gp : ffffffff815212b8 tp : ff6000008014f080 t0 : 000000000000003f
> [    3.457859]  t1 : ffffffff815221e0 t2 : 000000000000000f s0 : ff2000000000bc10
> [    3.457920]  s1 : 0000000000000040 a0 : ffffffff815221e0 a1 : 0000000000000001
> [    3.457953]  a2 : 0000000000010000 a3 : 0000000000000003 a4 : 0000000000000000
> [    3.458006]  a5 : 0000000000000000 a6 : ffffffffffffffff a7 : 0000000000000000
> [    3.458042]  s2 : ffffffff815223be s3 : 00fffffffffff000 s4 : ff600001ffe38fc0
> [    3.458076]  s5 : ff600001ff950d00 s6 : 0000000200000120 s7 : 0000000000000001
> [    3.458109]  s8 : 0000000000000001 s9 : ff60000080841ef0 s10: 0000000000000001
> [    3.458141]  s11: ffffffff81524812 t3 : 0000000000000001 t4 : ff60000080092bc0
> [    3.458172]  t5 : 0000000000000000 t6 : ff200000000236d0
> [    3.458203] status: 0000000200000100 badaddr: ffffffff800b669a cause: 0000000000000003
> [    3.458373] [<ffffffff800b669a>] smp_call_function_many_cond+0x452/0x520
> [    3.458593] [<ffffffff800b67c2>] on_each_cpu_cond_mask+0x1e/0x30
> [    3.458625] [<ffffffff8000e4ca>] __flush_tlb_range+0x118/0x1ca
> [    3.458656] [<ffffffff8000e6b2>] flush_tlb_kernel_range+0x1e/0x26
> [    3.458683] [<ffffffff801ea56a>] kfence_protect+0xc0/0xce
> [    3.458717] [<ffffffff801e9456>] kfence_guarded_free+0xc6/0x1c0
> [    3.458742] [<ffffffff801e9d6c>] __kfence_free+0x62/0xc6
> [    3.458764] [<ffffffff801c57d8>] kfree+0x106/0x32c
> [    3.458786] [<ffffffff80588cf2>] detach_buf_split+0x188/0x1a8
> [    3.458816] [<ffffffff8058708c>] virtqueue_get_buf_ctx+0xb6/0x1f6
> [    3.458839] [<ffffffff805871da>] virtqueue_get_buf+0xe/0x16
> [    3.458880] [<ffffffff80613d6a>] virtblk_done+0x5c/0xe2
> [    3.458908] [<ffffffff8058766e>] vring_interrupt+0x6a/0x74
> [    3.458930] [<ffffffff800747d8>] __handle_irq_event_percpu+0x7c/0xe2
> [    3.458956] [<ffffffff800748f0>] handle_irq_event+0x3c/0x86
> [    3.458978] [<ffffffff800786cc>] handle_simple_irq+0x9e/0xbe
> [    3.459004] [<ffffffff80073934>] generic_handle_domain_irq+0x1c/0x2a
> [    3.459027] [<ffffffff804bf87c>] imsic_handle_irq+0xba/0x120
> [    3.459056] [<ffffffff80073934>] generic_handle_domain_irq+0x1c/0x2a
> [    3.459080] [<ffffffff804bdb76>] riscv_intc_aia_irq+0x24/0x34
> [    3.459103] [<ffffffff809d0452>] handle_riscv_irq+0x2e/0x4c
> [    3.459133] [<ffffffff809d923e>] call_on_irq_stack+0x32/0x40
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Fix IPIs usage in kfence_protect_page()
    https://git.kernel.org/riscv/c/b3431a8bb336

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




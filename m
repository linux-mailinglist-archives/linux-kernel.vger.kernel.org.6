Return-Path: <linux-kernel+bounces-325264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B95975726
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193D81F24033
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7A01A3A85;
	Wed, 11 Sep 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUsM7+SE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB431E498
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068632; cv=none; b=bN5srVAjV61mQGgGsWsYJkqeOaJ6u3lGJhQ+H6AmTvbjsJq9hbxKRWDLrJF+21RNzJw1EUXNkzsdlj17Ga2iL9RHT4KIVa7UC0nBLjY8GJuefLs44Nwjt6HYe5nu0v3YEbmV4p8+cD9FAONpYlZGInkcFpj6U+u0thuHKFv8+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068632; c=relaxed/simple;
	bh=ttP3w3JurC1S7zqICMQrZiemEwxVlGcX4Z9wPYi6/Zw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BK+uKUU+7+r0TgPvodw+Ck+M+G49DmJxdtbpJn4hTuBNIzGmeK+9nFrLKxLCGnvYKgpHVIHEnSwpAn/tnWhwDmZVjuZ+qscQfe6ziSIqhxwjCXGEXHDN3ShSNrhbEO7tLqKBZgrg7WG4s+EIQZAwx4EC2dvuS4GF7lIVzxhGLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUsM7+SE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9F1C4CEC0;
	Wed, 11 Sep 2024 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726068631;
	bh=ttP3w3JurC1S7zqICMQrZiemEwxVlGcX4Z9wPYi6/Zw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JUsM7+SELIMCFdrnxwKS1xdZEHeDcOnOvoPXIdF/hAdT/Ah1TqrFjE7falGp2RtxZ
	 hIptkfamIXKzIMcXk5pipxMSFnOMXOqS1adV7Yz/Jbue33/i6/KrtqG1KsLTCBHgwy
	 5SAQ14eVEjgm16hE/6BZqtdc9fo0KUm5FNunaDAjzou716i41/KRcMGefD4VvSkYDx
	 qeSHUZXWk7IYB7fnU1xqS5v2+cwtBh8ZMxAOraX3wjdxB7VvNggoAk2mx6S0VE17NM
	 /CR6TRldIa7HCTfHv36Qmuso9Ia0APgCKy7kLZ8WRYiZTZfCxQKdtnt0PFjzWF1Q0X
	 E6tlD0R7eHgwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340083806656;
	Wed, 11 Sep 2024 15:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] riscv: Fix race conditions in
 PR_RISCV_SET_ICACHE_FLUSH_CTX
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172606863202.959689.8576514936896750298.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 15:30:32 +0000
References: <20240813-fix_fencei_optimization-v1-0-2aadc2cdde95@rivosinc.com>
In-Reply-To: <20240813-fix_fencei_optimization-v1-0-2aadc2cdde95@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
 atishp@rivosinc.com, samuel.holland@sifive.com, parri.andrea@gmail.com,
 palmer@rivosinc.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 13 Aug 2024 16:02:16 -0700 you wrote:
> There are two race conditions possible with
> PR_RISCV_SET_ICACHE_FLUSH_CTX. The first one can be seen by enabling
> DEBUG_PREEMPT and using this prctl which will warn with BUG: using
> smp_processor_id() in preemptible. This can be fixed by disabling
> preemption during this prctl handling. Another race condition is present
> when the mm->context.icache_stale_mask is changed by a thread while a
> different thread in the same mm context is between switch_mm() and
> switch_to() during a context switch.
> 
> [...]

Here is the summary with links:
  - [1/2] riscv: Disable preemption while handling PR_RISCV_CTX_SW_FENCEI_OFF
    https://git.kernel.org/riscv/c/7c1e5b9690b0
  - [2/2] riscv: Eagerly flush in flush_icache_deferred()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




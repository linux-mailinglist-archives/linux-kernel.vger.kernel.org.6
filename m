Return-Path: <linux-kernel+bounces-442280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835AA9EDA2C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2961887413
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B6220E00F;
	Wed, 11 Dec 2024 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdkpMxZl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B771F37CD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956388; cv=none; b=Z69lFM741xYZWy89vBiXkASZdbjZSf5GRPyDE8tJbHelqklBRpVv6rst8K1WLJ/GcTmJ45jwBnMhEtuYP9bJIcdPx0SRzXBs5eQjOKwSXwLrlZV5ZVzjuJCgGZLqAjhebmr81D/9B1UJ12ELUVbIsi/OGMe7e5k5JWWq4Ohd3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956388; c=relaxed/simple;
	bh=mVgKdv1VYB3F4YDKiICqJP62JryObnh1WV8uO4vtcEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c+ZSjPJSwsKmmgxzYTKj5+G8wJoKjcoJs1UgnnSh2NDIh44PZtGaJRNKibpT1G5rUAOf4BWTxQ7C2z2ZkzsGGwNPb3BJ/92zQyvBHH9g9rJcptdO8h702qnA/A4RcqZaKx5clTgykkJ5Lnz7eoO7ybmQK5gKTfZmB9c8DuV1Log=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdkpMxZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66660C4CED2;
	Wed, 11 Dec 2024 22:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956388;
	bh=mVgKdv1VYB3F4YDKiICqJP62JryObnh1WV8uO4vtcEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KdkpMxZlloN6e++uDsfgbjZ4497egu+EYtsR31yrXLHEpg63wzm1PmT2Zx9g/cjaV
	 hcbOrAG1WNXX7pcdUqsoCGZ0IpgKaPUM7hMu9Eb0WaQC/r16JmBQvUX6/pFlSGcQrk
	 IwjigmMmXHn/5+GIC0UBKp3tVe+c563y93qnIqK7cVjx1rblGwdnBcrv2Vc8MmaSAF
	 DBy/Mduxe8v2GRtFayqEjbY3WLGaHaAM9kGddYpeN6BCsgQfsB63ZbUe8m2GnzhcCk
	 YF5LoSnoh+3jrqKuyt4kIbY9E2KI4zWg2uMxl29fcwaiocNdyM7HC/5Wso2tQ7EXeW
	 TzMVywECB/LaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBA0380A965;
	Wed, 11 Dec 2024 22:33:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH] riscv: Fixup boot failure when
 CONFIG_DEBUG_RT_MUTEXES=y
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395640424.1729195.252270245008728818.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:24 +0000
References: <20241130153310.3349484-1-guoren@kernel.org>
In-Reply-To: <20241130153310.3349484-1-guoren@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, bjorn@rivosinc.com, conor@kernel.org, leobras@redhat.com,
 peterz@infradead.org, parri.andrea@gmail.com, will@kernel.org,
 longman@redhat.com, boqun.feng@gmail.com, arnd@arndb.de,
 alexghiti@rivosinc.com, linux-kernel@vger.kernel.org,
 guoren@linux.alibaba.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 30 Nov 2024 10:33:10 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When CONFIG_DEBUG_RT_MUTEXES=y, mutex_lock->rt_mutex_try_acquire
> would change from rt_mutex_cmpxchg_acquire to
> rt_mutex_slowtrylock():
> 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
> 	ret = __rt_mutex_slowtrylock(lock);
> 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
> 
> [...]

Here is the summary with links:
  - [RESEND] riscv: Fixup boot failure when CONFIG_DEBUG_RT_MUTEXES=y
    https://git.kernel.org/riscv/c/b3134b8c1a1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




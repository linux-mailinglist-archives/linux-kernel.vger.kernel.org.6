Return-Path: <linux-kernel+bounces-271635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82F19450F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE7E1F2A56F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EE61BC9E1;
	Thu,  1 Aug 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKD5nmEz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109091BB688
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530438; cv=none; b=abXJDp34uFk2gF7N3ZroDIcpPfigm8EqCRNdZ+FlmZoKXQlCcpefI7eF9IKmCMbaj6MP7+Pq1tRIpdGyXuLetCI/dWZIyKFJ4VsHENmQCWA7EN1ubwz2x5q7LENiBZKrKFafglnrTd5Qu/2iI86XYHiTXngG0L56u6dRioa/7wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530438; c=relaxed/simple;
	bh=Wg/sSVB+q4Vs3M9ZwTnV2Nl82PQDfuPe2NbknvxxqFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fzyXNjy11+t9r2HApl71BNi53xzpUPl2ML7CvyBAsKDpdJ3wsqy7a4KIHCKLZZfaBGkQt8yoVJuwKXE0tiytRpXZLPQUp0cD3Qt4g7jOjoPqXNAJzwwVg12CQ9VTLITekQijKPXnfS60NC6D/iehqDGdw33hNASFaqPppuy71QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKD5nmEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A82D6C4AF0C;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722530437;
	bh=Wg/sSVB+q4Vs3M9ZwTnV2Nl82PQDfuPe2NbknvxxqFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XKD5nmEzDc+YShR3bTsO1yhTYLyJ9aL4ySdXODR5cxp826p5Dwlk4ZQZmZtWKF58V
	 emgzDIFOfFjP1Lkb8veVd2dBc7gKvnOyvLloe1AWVTs5J8Aah7cIEtTvWWjpcWSrIb
	 lZAeZK3nky2azSSU82wmm8KnTWmYnyEosANylhRD6M9xMx7VRvvWmzEi8kglHVAgbp
	 E6mFq65lZMvZq98mkqmbmFD5wobfPTU5NNBaQzJqz2a6CRF3ROhfvlW4d1yrVKz35O
	 2iGxTs20RZ15krsroBMsfFCtYLHZrLcoW/gIY/3NGne2BnSvgq6ZO+j0/qop8a3UyY
	 x0WhCc6ByqV6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9229EC3274E;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Re-introduce global icache flush in
 patch_text_XXX()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172253043759.13740.13799521388186985058.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 16:40:37 +0000
References: <20240730135921.156508-1-alexghiti@rivosinc.com>
In-Reply-To: <20240730135921.156508-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
 linux-kernel@vger.kernel.org, samuel.holland@sifive.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 30 Jul 2024 15:59:21 +0200 you wrote:
> commit edf2d546bfd6 ("riscv: patch: Flush the icache right after
> patching to avoid illegal insns") mistakenly removed the global icache
> flush in patch_text_nosync() and patch_text_set_nosync() functions, so
> reintroduce them.
> 
> Fixes: edf2d546bfd6 ("riscv: patch: Flush the icache right after patching to avoid illegal insns")
> Reported-by: Samuel Holland <samuel.holland@sifive.com>
> Closes: https://lore.kernel.org/linux-riscv/CAHVXubh8Adb4=-vN4cSh0FrZ16TeOKJbLj4AF09QC241bRk1Jg@mail.gmail.com/T/#m800757c26f72a1d45c240cb815650430166c82ea
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Re-introduce global icache flush in patch_text_XXX()
    https://git.kernel.org/riscv/c/e298a843bcfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




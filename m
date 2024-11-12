Return-Path: <linux-kernel+bounces-406817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 047439C6486
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD081F25C96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F80E21B435;
	Tue, 12 Nov 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qs2uub72"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB6B219E5C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451980; cv=none; b=tfvfIOLd2c/q7lStvNi9Q/JfcFt/uDzbCR7ApDEcXaSCNOrX118amZzSixcwftQl6y+djyNAkhQRv1hic4gUSyr0ANCL8OWqc2U0iQsDEpD1fogyO9RXp3LTQGoEGgmkqgO1tJkv2Cjveexnonb1vlBnSXgF62nRvOaYBflx0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451980; c=relaxed/simple;
	bh=sYaUEV3H1VTX7CowzyJ4T2l9DFFG2LL8+sAb7eAQO/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i3v6gnwB61Okurlo70kX+PCVCXC6bh0pUow+IBmfNDQgnFKOTZP7hI3ccnYrJ9Zj6rpCtAx7cVW2grd2ubyMtQP68LFIHlhIuuQXucujM3w1gEYaNKGgDey3J6yz6gQjp+NTeJKI9SCWLy2U+tGkW0WTb8EOOY7a9rX71h2OihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qs2uub72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD5BC4CECD;
	Tue, 12 Nov 2024 22:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731451979;
	bh=sYaUEV3H1VTX7CowzyJ4T2l9DFFG2LL8+sAb7eAQO/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qs2uub72yqFPNWjy5n3myGlvtouRTlXqnBl/a/WEGH1HUgjIqViDXTVkezWkDXZ4z
	 zLKkZxzq4rSER3qmT+NhX3wc+ECWK7esjBR2SmF0MIOgebXauGfrcktPhHS9xFMF4g
	 MzdYdg5WeUURgIf/blV8rJOtmHY8Sh/ggQ11ftCVHhuPrwJjFZ6BZOw0gSMOc+YQCi
	 tBMmZDlU/lp+Xl7upsI0GBy0lTuBZHB8/CGBx6bihhluTN0lPOFpyLJ0vy3eeHGCNQ
	 cdUHkDMoRBCGB4+dORhZ8nvfWyLyAfObI/oWOOnIkNPTex54x5mD9+YRRAl1w4qHeL
	 i07OSYdlUQtAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE153809A80;
	Tue, 12 Nov 2024 22:53:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] drivers: perf: Fix wrong put_cpu() placement
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173145198951.701548.549721495064478963.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 22:53:09 +0000
References: <20241112113422.617954-1-alexghiti@rivosinc.com>
In-Reply-To: <20241112113422.617954-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, atishp@atishpatra.org,
 anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 atishp@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Nov 2024 12:34:22 +0100 you wrote:
> Unfortunately, the wrong patch version was merged which places the
> put_cpu() after enabling a static key, which is not safe as pointed by
> Will [1], so move put_cpu() before to avoid this.
> 
> Fixes: 2840dadf0dde ("drivers: perf: Fix smp_processor_id() use in preemptible code")
> Reported-by: Atish Patra <atishp@rivosinc.com>
> Link: https://lore.kernel.org/all/20240827125335.GD4772@willie-the-truck/ [1]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [-fixes] drivers: perf: Fix wrong put_cpu() placement
    https://git.kernel.org/riscv/c/57f7c7dc78cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-313569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EDC96A721
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BB21C2127A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D440A1D5CCC;
	Tue,  3 Sep 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byQd17iM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8741D5CC3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390633; cv=none; b=MmXUwD9Pl1IlrN/O9ujmq2BeaX9SLSyCz9Ov1l02VPaign/KBzlrltFxkmu21SrB5WTBAvwFmrUakZqRdQJbr0QvXxwfuGeM3vrf6/hvcuxeo/J1H3K+m7ZdIX5v9jUzQNrjwLn22fXRRA+1mQ113J/Xz9nzo/6E6bU7l+2swuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390633; c=relaxed/simple;
	bh=cWXGR4w2Vj6v4BISy6xoOQ0UL0iDK6UFZuzaOXitMS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dXfDK+Q0kO5oEBHA6+ejnv2QszlYuzXKmj6EuJiqJ5M5ex/1u1h6USZDhgd4QnituB9fnZBO+qbnOI9x1u2NfW9DEW//xwWWQjOTRdn7EFLiXRDpGlgE/m2Wz+omAHzc+AaEhWmpGEwxaO2efcKxWHg6VrK9AdoR3g/CCYFXU68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byQd17iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97E1C4CEC4;
	Tue,  3 Sep 2024 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725390631;
	bh=cWXGR4w2Vj6v4BISy6xoOQ0UL0iDK6UFZuzaOXitMS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=byQd17iMj6Es28rAatIJPs77TIhIDYpKeZCcubxC6nx5XTvtbZBKVOk7rt3tcQjh6
	 GCPtFuE+U6gKIrbfP2R3ZWWuVnDSD6BVfhBB36PLrU4UlbeV7PCbIrzRMttxq5+lOh
	 /xcHYPL0RMkwRx6wky9VdNt7+yhQp1TG6lABz4Lxgsv+yp2NNDoNzVTPSuA90ko5XN
	 77ZV/c7tMvYqw4jpvlDn2Wwyoaxlrr4aEjMWGFtXcM3O5ROg6PaHnLcydeXuh5UZGO
	 xAKODkmqIY1X/AuJLS5nzWgoOPFYNh3hERBKYADxItvalEHhYwqfFTymiZOXJTNQeV
	 PrSvbcEf8t74A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AFE9B3822D69;
	Tue,  3 Sep 2024 19:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Do not restrict memory size because of linear
 mapping on nommu
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172539063224.409367.11306153899728878438.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 19:10:32 +0000
References: <20240827065230.145021-1-alexghiti@rivosinc.com>
In-Reply-To: <20240827065230.145021-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, david.mckay@codasip.com,
 stuart.menefy@codasip.com, linux-kernel@vger.kernel.org, geert@linux-m68k.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 27 Aug 2024 08:52:30 +0200 you wrote:
> It makes no sense to restrict physical memory size because of linear
> mapping size constraints when there is no linear mapping, so only do
> that when mmu is enabled.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/linux-riscv/CAMuHMdW0bnJt5GMRtOZGkTiM7GK4UaLJCDMF_Ouq++fnDKi3_A@mail.gmail.com/
> Fixes: 3b6564427aea ("riscv: Fix linear mapping checks for non-contiguous memory regions")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Do not restrict memory size because of linear mapping on nommu
    https://git.kernel.org/riscv/c/5f771088a2b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




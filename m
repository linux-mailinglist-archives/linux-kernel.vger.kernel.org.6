Return-Path: <linux-kernel+bounces-230922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F999183CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F911C215E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818DF1850A6;
	Wed, 26 Jun 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD3Q1kBA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38D18508E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411679; cv=none; b=Hkpgq91a5s8wWrJ3aHzNphxGEz0sNVPty1lfmapRjirDQxgoDMQ9oeKM7crpFCFtP0rWRWqPVaiK4+tv04zk46NEZ4Nyw0EESXeX+C6OJWUR/s+fqadR3k/RHs4reTDyuaQ/2+bIUhr1ZeoIMPs796pu1KUvLdkvhDa59Kw1h5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411679; c=relaxed/simple;
	bh=n97Tfmv3TRG+hLeRDxVF/bzuaO9CUob3CYbgQye2sLM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ah5SDZaCnLhGx08EOAi74MLSqD04IAP5ShhR7EGWET//VpjfM2+AyVXuGLZhuaNs91g0fPyD9EekoNDrq2iR6hiMcjxTC9JOkfsOVq3iYtvPRgJgwn98pKRX0QkC9gbZpdncc137pnDeADHsggle2MthHZO0/BtWvONq/8lG8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD3Q1kBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A9F5C32782;
	Wed, 26 Jun 2024 14:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719411679;
	bh=n97Tfmv3TRG+hLeRDxVF/bzuaO9CUob3CYbgQye2sLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FD3Q1kBAdibjhTBurKw2vzJAfw2/5fhdXqjiP/H02J/7Yl7QU1bbpsfXIAKeEkyNh
	 /EIMzjX/1Hhx0bsOniTzDOoCeKo8WLlwcuMB9ep2kkOuGnlVVrFNAt+So1H6W+AkFY
	 +3DATKu8MWhbwLBSDTbxJKAfggRsc22oq58d6yNWXRZ8USdf9o0NcOVPVs10MeH+vw
	 7Or9cPCLAbl8qIt6VBgJ15zy4BQhGP6z+TBA/SysW+SLniwJwRYf7aG8+fQuxPecvu
	 Gu/a9E7lDD6ZBAr/ZdXXwUu645E8Ajviq88AN66U/YmGiI5cyWYD0tIN7JSy7YVFft
	 urcuSKwGJQ3sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36102DE8DF4;
	Wed, 26 Jun 2024 14:21:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: fix vector insn load/store width mask
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171941167921.28907.4527273499430176135.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 14:21:19 +0000
References: <20240606182800.415831-1-jesse@rivosinc.com>
In-Reply-To: <20240606182800.415831-1-jesse@rivosinc.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, conor.dooley@microchip.com,
 namcaov@gmail.com, samitolvanen@google.com, charlie@rivosinc.com,
 andy.chiu@sifive.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  6 Jun 2024 14:28:00 -0400 you wrote:
> RVFDQ_FL_FS_WIDTH_MASK should be 3 bits [14-12], shifted down by 12 bits.
> Replace GENMASK(3, 0) with GENMASK(2, 0).
> 
> Fixes: cd054837243b ("riscv: Allocate user's vector context in the first-use trap")
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  arch/riscv/include/asm/insn.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - RISC-V: fix vector insn load/store width mask
    https://git.kernel.org/riscv/c/04a2aef59cfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




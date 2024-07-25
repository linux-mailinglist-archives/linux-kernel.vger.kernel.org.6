Return-Path: <linux-kernel+bounces-262231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDB193C2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A995E1F2154A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6413619B5B6;
	Thu, 25 Jul 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCTiKvkM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6619ADB9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913639; cv=none; b=AJsN0rdWtmkMKCULUptCWzYhEZOZs1KMCFhq6uj/ChgAstIXeGH19xSqjagX5PT2kYQlKJr+ce/f7QOauSHlTCW52NwQT6YZtBUBoBCPROL4h6Ph19V57FQcObnbJszqn5O55G3Mcxb8+gicFxYtlEVruFDz9lbVwwXksnHhXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913639; c=relaxed/simple;
	bh=pFdXkjdGSDh8zJd7wdWGLRV6jOx/WG05Mm/gHD8rTs8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=flXSH8gX4arb4KSA6Hk/sEZrnnjwAWIna9AYJa5kDic6HOJCYKlwEiSAagD3bOheW6Xrn/WKFiSaNnhODk859kauTA3anMkPxA/PaYkcxJl3AZrDBimfszu591CnZGzUTq9P2FYHhZpGlm/ySWJYmZ3aWtPtp+9593kePsisW7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCTiKvkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39002C4AF0E;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721913639;
	bh=pFdXkjdGSDh8zJd7wdWGLRV6jOx/WG05Mm/gHD8rTs8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PCTiKvkMrxorbBHJyOMPP3nbCO8C0QvST4F8LSkAlfPRPxyRlWCGcucGMHi3QcF5K
	 nwqnFej+PfHTsencpYTdZ0EUBU4swYfTxwWrB4QjyaZto5EUu9iA+6317ICEr/1AWd
	 ceE/NN2GzcQqEcSSpzXP1xHTFNcQeA9yWXr1IOsgwHhVnBbr3iVYIWwZ/9oXkVrnDH
	 nf18rr08iHrfqZNfSeyYrfmWP+lbMIIFlyqZFoVoDjJFSQc7wYFvNN9MXlWg2iHe88
	 vdN3a1oJQflhcV44wwySOjj+4aDbUF7L39sIKZELlmGbMak9INugucwaWNmZOJzPwo
	 EFc0FBU2CJVGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2633CC4332C;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: signal: Remove unlikely() from WARN_ON() condition
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172191363915.6240.3728973029853294759.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 13:20:39 +0000
References: <20240620033434.3778156-1-quic_zhonhan@quicinc.com>
In-Reply-To: <20240620033434.3778156-1-quic_zhonhan@quicinc.com>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
 conor.dooley@microchip.com, ancientmodern4@gmail.com,
 ben.dooks@codethink.co.uk, bjorn@rivosinc.com, quic_bjorande@quicinc.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 20 Jun 2024 11:34:34 +0800 you wrote:
> "WARN_ON(unlikely(x))" is excessive. WARN_ON() already uses unlikely()
> internally.
> 
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/riscv/kernel/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - riscv: signal: Remove unlikely() from WARN_ON() condition
    https://git.kernel.org/riscv/c/e1d96a07ba4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-513714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2B5A34DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D2B3A5CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F18324A06C;
	Thu, 13 Feb 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk8V7IBP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729B24A05D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471413; cv=none; b=rDjsV3102uM94v0/1HDFRL2ivgzdylzPWLjlvr598B7YO0UlOG3L73Yqq0DbV4lVDI+r+XKXAsYDAIVuAU2w0WsHrZJWv6muMt4TjW0zJkaJHoOZm0mjy9tMEtva2A0l7DVN4XtcTtNrZHllDR3Hj3xjbAEI5hgvmcegYJfibz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471413; c=relaxed/simple;
	bh=wdaD0rz6iZsX1Rx+Et/KNnZ3uQO95gynUs5f1KOEN4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZG3J7lwiMx//3bLH3IBSfDHDXIerScGoDr1RxL0h4yZGC68fA5HIWR38caStYXcnL62X/wO6u3x9Bs6ktsaeB7bfozuWfVuLrGT+CeaUb5Leyh21WAOhFvB97e6ycN0eH766Nskk4kTr+vvcZE49CjqV0DMR9JZzHafxSwMU94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk8V7IBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75327C4CED1;
	Thu, 13 Feb 2025 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739471412;
	bh=wdaD0rz6iZsX1Rx+Et/KNnZ3uQO95gynUs5f1KOEN4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hk8V7IBPqJPHjhm1PwjLeaVUEeDwB5ioCZu4oJj1BPz6bJRKtZMQ0GLB4QQ1pMsKQ
	 prAUP5hmMYzBt4FRpGhgjrRh+fDp1SiSfZ2EZAhi8O7NQZP20RwDTi9QNxk8MJxO+O
	 pse+lMj8EOB13N8NW4W10WWQRMxviqZ+n0NHqA2YND1K7Lcb5iM9m5adC1hlyPuQo7
	 5isujOZeSJZHV0hxQyzXJ2gZuj39IxFWmL5O0WHgz3FhZag2EaY+g7Hlmwva61vvhJ
	 TIjFfVQH9NyLpsSuKw5gDinBOZW32ErlgS8tZs7MyOCzLMgvNC+mq5r3Lt2A9/xRjB
	 lrIPMmhCOUscA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1EF380CEEF;
	Thu, 13 Feb 2025 18:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv/futex: sign extend compare value in atomic cmpxchg
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173947144178.1330575.8179936961826705707.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 18:30:41 +0000
References: <mvmfrkv2vhz.fsf@suse.de>
In-Reply-To: <mvmfrkv2vhz.fsf@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 03 Feb 2025 11:06:00 +0100 you wrote:
> Make sure the compare value in the lr/sc loop is sign extended to match
> what lr.w does.  Fortunately, due to the compiler keeping the register
> contents sign extended anyway the lack of the explicit extension didn't
> result in wrong code so far, but this cannot be relied upon.
> 
> Fixes: b90edb33010b ("RISC-V: Add futex support.")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> 
> [...]

Here is the summary with links:
  - riscv/futex: sign extend compare value in atomic cmpxchg
    https://git.kernel.org/riscv/c/5c238584bce5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




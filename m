Return-Path: <linux-kernel+bounces-271637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4869450F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6685A28A548
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007631BC9E8;
	Thu,  1 Aug 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cG0R6guX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349001BBBFE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530438; cv=none; b=UaxtS3P8l96dzAGy+zoDl8MdD4A5hPZi7sc9yEyraHnO8fKWcXIkLYJUgO5gKiJBuJ8kGPTCqxhMEnpKfLkbE3dS98ODf0s2cDt/aboHCq2wNRTsTrG1iIbQIdzh6+rF1z9UecSvYpBZs3z4oNs/AUMCmhuLj4nvqPMOUdhoMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530438; c=relaxed/simple;
	bh=c2FO/XwZs3Khz94ER4bhUWQv+QFkKk0f7Rg9kF93AO4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OfnWhO4l0qhbqXK2zA35WbF/Flvpzy0rB/hTKvEDoSN9fUoRA2E1WLlp4FoXtbR+W+Hzyz+rGOYL6KmRVE1l073mldT2S1YB6w7koU8yxOxm4BKNVqNePbV9TQAvV8nuYwjz/v1Ww85Lby7VgsgJkjlR8uDIlri46zAqiZ3cP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG0R6guX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8548C4AF14;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722530437;
	bh=c2FO/XwZs3Khz94ER4bhUWQv+QFkKk0f7Rg9kF93AO4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cG0R6guXz6WO3xwIFGUTP5Fj3oWN7D9oJnkbelpgpsjJBCblesZe4Cf/swTrJ3w1o
	 1i0uZ48Mw6+5GpCoF1gtF3Hnd0baiP0IrmrOvrBcDor7kIYG45vA7K/bUUA/P7v/GU
	 aUGzzClFr0Y2Ifq0P/sFaH5W6+2va7KQICSuJoZqT6wlrW5KtVmBksBBlv3Btioy/c
	 XNdW9oYS2h4nAjj85X3CT8Z9GNfX5PPJmN23rYZLBA5LT15PgPnNFwG2HaBFg361S6
	 lnhbr/c8huwb+A6Kb7E1877NBNCaFvBTtKVaqio68HBkl0QqeKnkDOAGE+heLL9M7D
	 4BUJyB/0Sdb5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B30CEE8877D;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] perf: riscv: Fix selecting counters in legacy mode
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172253043772.13740.4519514649255072983.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 16:40:37 +0000
References: <20240729125858.630653-1-dmitry.shifrin@syntacore.com>
In-Reply-To: <20240729125858.630653-1-dmitry.shifrin@syntacore.com>
To: Dmitry Shifrin <dmitry.shifrin@syntacore.com>
Cc: linux-riscv@lists.infradead.org, atishp@atishpatra.org,
 anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexghiti@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 29 Jul 2024 15:58:58 +0300 you wrote:
> It is required to check event type before checking event config.
> Events with the different types can have the same config.
> This check is missed for legacy mode code
> 
> For such perf usage:
>     sysctl -w kernel.perf_user_access=2
>     perf stat -e cycles,L1-dcache-loads --
> driver will try to force both events to CYCLE counter.
> 
> [...]

Here is the summary with links:
  - perf: riscv: Fix selecting counters in legacy mode
    https://git.kernel.org/riscv/c/941a8e9b7a86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




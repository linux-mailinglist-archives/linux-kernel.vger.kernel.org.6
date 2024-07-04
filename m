Return-Path: <linux-kernel+bounces-241085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131619276E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44ED91C222FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AE21AED4D;
	Thu,  4 Jul 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InBIbUHd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A91A3BDA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098657; cv=none; b=ZeTq1JXYZU1gp1GUfvBvnKGwyC81Elm4F9f7gM37FcXsAtHN3iW7ilnp+bQ82aJoHyXeQ4Y44UxNdAw7VbWB0rSEojlg/N0bUUhHtjxvBA5pqJJI1alseEEknZ4pNArLjLFWUnBVavcpBpuumx7dXhJTx4kxWZVa9YRJlc8sx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098657; c=relaxed/simple;
	bh=dlHwO2nGfEIPQRND3XuHL5U3U23kIOrurw+F13qm/ZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ncdRpk93FR75FPN50PnVOTFCNFSwNwzzo/pEh7ZjgEf73TnXyvc6cnwwEICO0aeNuWa1+6YGp267edKHo7aWn2i4McGTMjRmym1oTPcC1drpfBgevsQohZBq61yfJDBSo1jGbEZ7K1tYEY0ab5BkeKfogGI0K9/WxK5gv/F63HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InBIbUHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0D5FC4AF0B;
	Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720098656;
	bh=dlHwO2nGfEIPQRND3XuHL5U3U23kIOrurw+F13qm/ZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=InBIbUHdpMnMo7f1ektkDLglWqxh9mBUdbKu9I8TEsJvLdwk1i5Boy8crJvO30KXJ
	 b7LxBNJTKdxW6HEb0Wm3eGokL6O8gDR/fnw7iraRCRofIXZP93T5FJ1kipm67ktLkb
	 pFMTBZk9ZoAowQ7AcjjfFupZwW3nN5qqzFXIbcJtLLCdN86pmls3mRsblbUqRHDivD
	 mAbTQLzqSmAmP4WYyZ1DXo2CYtdtIXitJdFeXmiYaNRJqH5rff0YtQr4Lo87EpwVRa
	 HeqWLQvqYHmOIqgsJrPG05Bo0ARM9a36Uz0n2prZJzBn1Ie/TehuDgn05k6Fjvify+
	 pkyZbQVJNcfZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B246CC43612;
	Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: stacktrace: fix usage of ftrace_graph_ret_addr()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172009865672.17306.10078143988695346844.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 13:10:56 +0000
References: <20240618145820.62112-1-puranjay@kernel.org>
In-Reply-To: <20240618145820.62112-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, samuel.holland@sifive.com,
 dev.mbstr@gmail.com, linux-kernel@vger.kernel.org, puranjay12@gmail.com,
 rostedt@goodmis.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 18 Jun 2024 14:58:20 +0000 you wrote:
> ftrace_graph_ret_addr() takes an `idx` integer pointer that is used to
> optimize the stack unwinding. Pass it a valid pointer to utilize the
> optimizations that might be available in the future.
> 
> The commit is making riscv's usage of ftrace_graph_ret_addr() match
> x86_64.
> 
> [...]

Here is the summary with links:
  - riscv: stacktrace: fix usage of ftrace_graph_ret_addr()
    https://git.kernel.org/riscv/c/393da6cbb2ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




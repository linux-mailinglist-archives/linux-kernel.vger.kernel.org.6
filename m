Return-Path: <linux-kernel+bounces-331921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FFE97B2FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16E3283C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48508188A23;
	Tue, 17 Sep 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNU0I6nM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A461E185B66
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590634; cv=none; b=AoVFDfDhOoybPK4ACVP2nsPY65mTV0uYj0xkmaZ3zwbnTLr9fEx25Wy74pYUNIGyXmy9ooUsgwppUMzGXaf/YagxledXpZLkj388MNr1iWBDEIKmohHxDvRn0UHhIUnhlARkdEzK8Awwd5t7TY+QJ81P+XC4BxSRFdQJHhbJqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590634; c=relaxed/simple;
	bh=n8dn2bjcElj/LDkfC5Nleu23VSK9RpWWAwKQKheaEcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KeRuyLNUGBCfppF+BcjzlMlpnPBVx4NDxbS7f2pvht58h+vKzNwf6LfOcY2QHdkYrBW7DxxvZVp2aOFJZUVL0vfsDdbG9hklrOcdq/90dIVMhJqe6HTXgSDJRgx9SaTjmZeQ7lMmS9Z3e9+l7uf8G/jPW1EWZNXfCqqh7BbALhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNU0I6nM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C6CC4CEC7;
	Tue, 17 Sep 2024 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726590634;
	bh=n8dn2bjcElj/LDkfC5Nleu23VSK9RpWWAwKQKheaEcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tNU0I6nM0REJ/0pj8JLbG9OcfLFwoHAAeqcqpqEqhnMO0LDaxpPuN8Slpx7+YNCqd
	 38wCkkkkxwiwxVyOS/jkCXz4BzdRWdKWZiEqfT9eFcypQOC4gtoKQT0SLgSZ6LiUIC
	 iztcbochOTtG+2qd2tuKzRZWVMJLJbT0BNC8PvIICtzksjWmsO+gjmoB465gmajX+5
	 mLR2Z5buTGx6TPPxKPnAIT4pFXX5CjRu096WiYTEHIFpSXNWpIZXoej/N2OhNhZgw6
	 aanhNIZnWRDz3NZ23ZJi4DQIbvKTXjRuDEaKLXUlg0BzN2LfV600cTZGQ15KEDsLFK
	 Oeccd4OVCNhxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE373809A80;
	Tue, 17 Sep 2024 16:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Randomize lower bits of stack address
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172659063576.214459.13320691016694584543.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 16:30:35 +0000
References: <20240625030502.68988-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240625030502.68988-1-cuiyunhui@bytedance.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
 alexghiti@rivosinc.com, conor.dooley@microchip.com, bjorn@rivosinc.com,
 sorear@fastmail.com, cleger@rivosinc.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 25 Jun 2024 11:05:02 +0800 you wrote:
> Implement arch_align_stack() to randomize the lower bits
> of the stack address.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/include/asm/exec.h | 8 ++++++++
>  arch/riscv/kernel/process.c   | 9 +++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100644 arch/riscv/include/asm/exec.h

Here is the summary with links:
  - riscv: Randomize lower bits of stack address
    https://git.kernel.org/riscv/c/048e2906d4ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




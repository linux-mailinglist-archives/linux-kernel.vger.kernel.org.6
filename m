Return-Path: <linux-kernel+bounces-195921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2718D5458
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0865E284414
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF28847A5D;
	Thu, 30 May 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfLL8MoL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1318399D
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103431; cv=none; b=hMotD0reTvrM6DXCLCT4biQ62gE5QXXzUAzZvoyjPWQjc3xskseIFtGb5oXIKf2T2mfG9zlQ1yLtECdTE5iWFdP/Td9RaPRdnEEnKxaNr5bWYe/4dTgSQyN3mLLIi9d/e1f/uOC1BtU7gh6ZrDr9pTh6VCDLxOk+QUD87L7R4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103431; c=relaxed/simple;
	bh=4HJqKtgGK39M+z3ADW4pz+yh2a4Pysk28/17uInmge4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QqYYBr9ax4JwBlHJ7TWXcdx6VVkBoZNGOLqyjmhJlmPo4rbvWrbaHkuj8L99/hrS0qOCXKM7G6Y8mqTIR55Mfg0QwUeaqblSIl2euschxOxUk6VZvDYWkgZSV+W65uyAd80a4E3IsliTHBQq7LKRfMLIsoLIpiWwTA2J0W26t/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfLL8MoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6457C4AF07;
	Thu, 30 May 2024 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717103430;
	bh=4HJqKtgGK39M+z3ADW4pz+yh2a4Pysk28/17uInmge4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AfLL8MoLRhhgfMujWXaqTYfcWLJwJGZTGMInrmH58Ws/D5ODITYVwKOpJcGlsLdF6
	 w0nbAi/VIZvb1rYa+cviSGpGmVDw8D0lfyrfI89aZ1km0g+8S2vNhfT5QcC7dptSY5
	 /Pp+JSxvqVG/8sHdHao7zgZCwilspIrTn/I7daQUsDAWT7tglf0PJUSbjruv9s+Y6A
	 zQO69omm7TdYgTsji/VX5CJFmnmWrZwVu3MDpfu1tv0NBA9AWJsppW72QZTNUEaqJk
	 OINbk8GQNBeCKF9vz2PTGf6B4tI1D7pDY03B5s3nWITFoePytiG9PlwxBNqUaHlidb
	 rJpJxdsxOnrOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7E06D84BD0;
	Thu, 30 May 2024 21:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes v2] riscv: Fix fully ordered LR/SC xchg[8|16]()
 implementations
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171710343068.6624.13466290859953012929.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 21:10:30 +0000
References: <20240530145546.394248-1-alexghiti@rivosinc.com>
In-Reply-To: <20240530145546.394248-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, leobras@redhat.com,
 linux-kernel@vger.kernel.org, parri.andrea@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 30 May 2024 16:55:46 +0200 you wrote:
> The fully ordered versions of xchg[8|16]() using LR/SC lack the
> necessary memory barriers to guarantee the order.
> 
> Fix this by matching what is already implemented in the fully ordered
> versions of cmpxchg() using LR/SC.
> 
> Suggested-by: Andrea Parri <parri.andrea@gmail.com>
> Reported-by: Andrea Parri <parri.andrea@gmail.com>
> Closes: https://lore.kernel.org/linux-riscv/ZlYbupL5XgzgA0MX@andrea/T/#u
> Fixes: a8ed2b7a2c13 ("riscv/cmpxchg: Implement xchg for variables of size 1 and 2")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [-fixes,v2] riscv: Fix fully ordered LR/SC xchg[8|16]() implementations
    https://git.kernel.org/riscv/c/1d84afaf0252

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




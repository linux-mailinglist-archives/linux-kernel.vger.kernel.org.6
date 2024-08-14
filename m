Return-Path: <linux-kernel+bounces-286579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE89C951CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D7E1C24952
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59311B3F3F;
	Wed, 14 Aug 2024 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7uswLlw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789E1B3F28
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644636; cv=none; b=g4b221OfYBYH2kBL+24/ecLCaW2ZgwFfDxIj/RABIxJReZB1o30fN3OCDDmAH8j7KtQ1NmLCzrb0ztUhv0sKvJK4U+oswQzVHoeE+f9rTNKi9oI+p1qUkd8BD1rS10MxBwv1ZP4UAdFYQS8zqEEorlOdy+0JDv7cL/1ZFDlFx0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644636; c=relaxed/simple;
	bh=4Trc9cKH0+hfthZTt1kzAJCq/T3A8YA1Frl1jUvaClw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pk1R1xXZBeAcoOYzjcME0w7ymO0H8MyMjkRg2ZGRV/I4O2gK16eF8hxk+Jse8kfoAhg+x3iZY3jz2se62m4sGbBps5tZNtsLOeFtpxVuWrRm/OQ+blZZvKSL1Vz3fiKKZ+h8J0MN5QKnAIsnbLNkbdkmEdRUO45EST+tKLUh5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7uswLlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7960C4AF09;
	Wed, 14 Aug 2024 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723644635;
	bh=4Trc9cKH0+hfthZTt1kzAJCq/T3A8YA1Frl1jUvaClw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j7uswLlwb36kFUHgwH29C3zVPjw7WrCaKZCJRmmfzDtTNpHAvjxlqhW/Z7JKglJgd
	 wXZtcsrCbNNQLaAe1hK4ivvtmOATrJxFunuv5UAAAxEw5naadKlkqD5TbjLsnKP14H
	 zO/9bq3xyDDs54t13nXRdtp9PpIXNipsjBqgTArvnSnDB3UQek025yVZ9+3xSCoeM1
	 HM9g7mle8TML8v0J+WB0iY0ydQfMboTsDMvDKy7t4cN1HCIcnwLc/YeK/+o43WqaGd
	 /R0S9q2NlwAkOwwI6qhs1EXL6HTkizOe0Gw9NhPp42a+X9EwhrlgOuih8ACZMcfW8W
	 2+z9cFirDGh+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8938232A8;
	Wed, 14 Aug 2024 14:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] RISC-V: Enable IPI CPU Backtrace
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172364463499.2278280.12370674777574036166.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 14:10:34 +0000
References: <20240718093659.158912-1-takakura@valinux.co.jp>
In-Reply-To: <20240718093659.158912-1-takakura@valinux.co.jp>
To: None <takakura@valinux.co.jp>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com, bjorn@kernel.org,
 paul.walmsley@sifive.com, akpm@linux-foundation.org, aou@eecs.berkeley.edu,
 apatel@ventanamicro.com, arnd@arndb.de, atishp@rivosinc.com,
 bmeng.cn@gmail.com, conor.dooley@microchip.com, daniel.thompson@linaro.org,
 samuel.holland@sifive.com, sfr@canb.auug.org.au,
 linux-kernel@vger.kernel.org, taka@valinux.co.jp

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 18 Jul 2024 18:36:59 +0900 you wrote:
> From: Ryo Takakura <takakura@valinux.co.jp>
> 
> Add arch_trigger_cpumask_backtrace() which is a generic infrastructure
> for sampling other CPUs' backtrace using IPI.
> 
> The feature is used when lockups are detected or in case of oops/panic
> if parameters are set accordingly.
> 
> [...]

Here is the summary with links:
  - [v2] RISC-V: Enable IPI CPU Backtrace
    https://git.kernel.org/riscv/c/f15c21a3de1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




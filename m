Return-Path: <linux-kernel+bounces-195922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9778D5459
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2D21F21F75
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2D1186289;
	Thu, 30 May 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8qVyjrL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259B9183994
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103431; cv=none; b=tKSU+RCLF8uC8K1s3balsbLoPHPW3RGXRapooeETtVpX+Xw+KOWuPh5kH4OwnGPBLly9eWPDjOd7W6mKiHfhXhTW4R/AXa2g4TeNvyohSxIV5uehhuNCu3V9ZuJyDLPYfDNggtzIVIOT+NYsoUoRR47872GF8VsxYBJ3bWdKrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103431; c=relaxed/simple;
	bh=WDI7R5NJdDXyrncOhY5G4sEPOR0dtgD/wFPdOrwQ2Jc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tlE4yJXX4AhtYixtgLGzZybF8Jitc9FZ4DKzC9W1FmI1qxHetz2ze7aZHpKiVOQAjTEFp7gShGRAypqh2v8T/xZp09xso0DiV2WB+aR6xF2N3O9WJ6RKd/PJhZcDVAqFJquiCJ2mfZC+O1hTHytzYU/yHo04vnH6Byp1abT/PN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8qVyjrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABA7EC32789;
	Thu, 30 May 2024 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717103430;
	bh=WDI7R5NJdDXyrncOhY5G4sEPOR0dtgD/wFPdOrwQ2Jc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J8qVyjrLdh8Q1jInXVtPiyhTcwYtv2jp8pMeZcJRddTeZoag1o4PUdAqrei0JnHfI
	 sVgJqhQ3GlSBDPeZeuSyPTtILhJc/U1aSK48BasZVCWSs8gzyTWFBd9U1EhbcRFSeL
	 otjVa4AjMy5eVh1dLKH0FRQu+jMt8NvjMfwuIT7qiZARwiQ2l7kqkhpBoy2ADhDnFe
	 urw1brJJXf0GM+/KUsfFWvJbCM2yG3Z+6kCteGT0JF3Rg6DZK6ZnwOpQ+aAryeJcKM
	 xZtp13xXQW7o9EXG/H90f6SHVuENtWMsaaCx8OWaQs96+mGlHXdsnWbfDsO76N5RN1
	 7U2y/M3Ib0oCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94B38D84BCD;
	Thu, 30 May 2024 21:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: prevent pt_regs corruption for secondary idle
 threads
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171710343060.6624.5427985016791432886.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 21:10:30 +0000
References: <20240523084327.2013211-1-geomatsi@gmail.com>
In-Reply-To: <20240523084327.2013211-1-geomatsi@gmail.com>
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 anup@brainfault.org, atishp@rivosinc.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, aou@eecs.berkeley.edu, samuel.holland@sifive.com,
 alexghiti@rivosinc.com, conor.dooley@microchip.com,
 sergey.matyukevich@syntacore.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 23 May 2024 11:43:23 +0300 you wrote:
> From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> 
> Top of the kernel thread stack should be reserved for pt_regs. However
> this is not the case for the idle threads of the secondary boot harts.
> Their stacks overlap with their pt_regs, so both may get corrupted.
> 
> Similar issue has been fixed for the primary hart, see c7cdd96eca28
> ("riscv: prevent stack corruption by reserving task_pt_regs(p) early").
> However that fix was not propagated to the secondary harts. The problem
> has been noticed in some CPU hotplug tests with V enabled. The function
> smp_callin stored several registers on stack, corrupting top of pt_regs
> structure including status field. As a result, kernel attempted to save
> or restore inexistent V context.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: prevent pt_regs corruption for secondary idle threads
    https://git.kernel.org/riscv/c/a638b0461b58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




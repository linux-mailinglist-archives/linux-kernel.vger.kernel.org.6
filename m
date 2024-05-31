Return-Path: <linux-kernel+bounces-197102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7292C8D662F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C6B1C23A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2B21509AF;
	Fri, 31 May 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usSwkHvU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724E033DF
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171237; cv=none; b=WT7Tju37JFKaIl7Ryw8FsdyX7ntfiDn8pKvWM2rwKoqTzjr8NmP5ymX+JreiOHDUyVxYI3Qn3GS3AKy9+uSMwFnL67ficWVtLcDcTxFPUXfEkOT1UNUQBxcw/lRvQsrBmN9cbXIeSOiH3jMozdfXW5pYOand66EihoGYi+HB6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171237; c=relaxed/simple;
	bh=ue49JlCpjRBuJwkDVBPStXgNI/crZ5RD6wSv46b3h3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fJnKa+VO9Ww9VkTa0uuCo3JtkN/G9Vc2cjRez9AbxrEKym+th47Qr3JkzAUVA/HdVwlr0hScm4y0hjrCVzaqmy+NqjIO7ewOIF9R/N8qlquGIXlR7EL7g/KYwFAkcjbzWQcjqwG3geiSpxP1FenDExeH18HL4ZGh+Zlot14MXPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usSwkHvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D985CC32786;
	Fri, 31 May 2024 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717171236;
	bh=ue49JlCpjRBuJwkDVBPStXgNI/crZ5RD6wSv46b3h3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=usSwkHvUVsf7/ZNRXUCMNsqvZHcyzc4kvc1SZOpeCW1uFaQUIFbpOGhzBT2P8HIT6
	 Ylx8eTuBrpw8Lyr4nYYEJK6e1Q25nq4Ka9CY2eppnCYnLPWvO4cbvP1AQW7YnnR1KX
	 0sNg4uAHyi12kch59Mq8IgHaGiSVF18tLoxoVSqs9Y1fNHtgQrrcbvw3ukuLaiF49w
	 DLYw5PNShkR1l4Cukkj8SBUNxSAsj3hnAeA/zHR3lgAIsFR/JCmlR/PP+93UjHHcju
	 ijgGiem5Q4cxWXUjBwiSR4DHNakUzcCGXiY/9hCfzIlQE7/L+tWn7Yl1Vo8Y4VqJ/c
	 cCP+ptG9j7/Kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4528DEA710;
	Fri, 31 May 2024 16:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "riscv: mm: accelerate pagefault when badaccess"
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171717123679.27814.3225238698035039427.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 16:00:36 +0000
References: <20240530164451.21336-1-palmer@rivosinc.com>
In-Reply-To: <20240530164451.21336-1-palmer@rivosinc.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, surenb@google.com,
 akpm@linux-foundation.org, alexghiti@rivosinc.com,
 wangkefeng.wang@huawei.com, jszhang@kernel.org, ben@decadent.org.uk,
 bjorn@rivosinc.com, willy@infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 30 May 2024 09:44:51 -0700 you wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> I accidentally picked up an earlier version of this patch, which had
> already landed via mm.  The patch  I picked up contains a bug, which I
> kept as I thought it was a fix.  So let's just revert it.
> 
> This reverts commit 4c6c0020427a4547845a83f7e4d6085e16c3e24f.
> 
> [...]

Here is the summary with links:
  - Revert "riscv: mm: accelerate pagefault when badaccess"
    https://git.kernel.org/riscv/c/7932b172ac7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




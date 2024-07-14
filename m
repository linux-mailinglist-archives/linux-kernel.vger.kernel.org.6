Return-Path: <linux-kernel+bounces-251917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AF9930B9F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1881C21207
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 20:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB13413D502;
	Sun, 14 Jul 2024 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHRY2LK3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C0136E37
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720989034; cv=none; b=Dj7C2zRR9pxD8PdEFRFb6X38DlGl1geyD5JgMPJvpe2TdSxuthxcdlQXN+zjf6jEjkk0FUx+svAy2lGLQrP8c4iH3iw49r6He652lLdkTKeb3riNJh8G/iviMzcwhWGTlEuEX4omcxpZpW7+EjEeRyqnOweuaF2y18jEY4UxQTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720989034; c=relaxed/simple;
	bh=Ce7pl2KxrRRF4NFenOes3MKbZmcZhLGXZ+zIHmI4KJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kt96ht17hFGrrxM0Uq+Lnoyy0kLpB3TgJVH7bMopVV/iYIKzKruHMciDWQIQICthkt+fIbPDJ+oE9ytH1E9Vfo+qOCA6JTc1kiPpYJXY36bGAk1Fxf6JAE8prgt7+vV2L5h5nDDyCG8Y1mE2J2yN3znGLoEOTSO+y45Vwr+EfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHRY2LK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4DFBC4AF09;
	Sun, 14 Jul 2024 20:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720989033;
	bh=Ce7pl2KxrRRF4NFenOes3MKbZmcZhLGXZ+zIHmI4KJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fHRY2LK3T1u4Nn8x2OOdVAi4ogeTKqJPZvT9xOwfKpFKNdhbRsii6tFD82nEBgxdz
	 rRwV1S1eYPAQd864zFcREoSyrEiKJf80Ui0WzUTASHjJey+pnlcvKSp7B12iHX7TeW
	 amVUwlVUpKCNgYagFT5211c/QdouF0lZQCnrXuyyWROlMF7Rms4OkN7wC4izCvbeIh
	 KuiU0rU/nCag+pWOXu4+FS5rQpF5s9x9q9ja8YNe1F0YzP/Kt7m407tzmMn4HD4Ya0
	 HZUZe5KM/o+Qf4fWJSDgDOuiY5n4R9FXlB6WILm6eZWXYtMrFCv5NCMi2KmMmCnvvM
	 2ItVSvSzMA25Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4CDADAE940;
	Sun, 14 Jul 2024 20:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3] riscv: set trap vector earlier
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172098903367.7439.15717595350937923936.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jul 2024 20:30:33 +0000
References: <20240508022445.6131-1-gaoshanliukou@163.com>
In-Reply-To: <20240508022445.6131-1-gaoshanliukou@163.com>
To: yang.zhang <gaoshanliukou@163.com>
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-kernel@vger.kernel.org, yang.zhang@hexintek.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  8 May 2024 10:24:45 +0800 you wrote:
> From: "yang.zhang" <yang.zhang@hexintek.com>
> 
> The exception vector of the booting hart is not set before enabling
> the mmu and then still points to the value of the previous firmware,
> typically _start. That makes it hard to debug setup_vm() when bad
> things happen. So fix that by setting the exception vector earlier.
> 
> [...]

Here is the summary with links:
  - [V3] riscv: set trap vector earlier
    https://git.kernel.org/riscv/c/6ad8735994b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-288381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFCD953978
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E11B1F2457A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E877EEFD;
	Thu, 15 Aug 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chxMhja6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E60C78685
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744241; cv=none; b=XohTvUoNBFHVBkkZDKgh2gQMhr9nh7e+7V5ZE7XKtVktIumBp58l+xmqGcK2UhBmvBbOq/eCLe7cHy2u4VUWvt+V7F3vGzbN8gKG5jnW4KH7WtWre0UfKcG9ELnWXiBWV/xeZ8FyR3MrqX/4L2xOXfP3bN0os86XOPlNupIY+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744241; c=relaxed/simple;
	bh=zAxfP5/czEKKMzAKvyihgPXxRvPBFRr7sKK/n0cERzA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=or1amc8tR1rsEog7W78X8l3UU0fr7QZUeH3Fo4tswvS5jumiukRvRnfi/dhytJMEkau+pswy1/S/SqdPQZx4GMkIDagbxdwlnxhxgPbz6SvE2MFEOQHJgibl9Pa6gIxDMMtlXtc0cXvdW9z9RFTQci1Zkl7LvaRALfPfn4ID5Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chxMhja6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54805C4AF0D;
	Thu, 15 Aug 2024 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723744241;
	bh=zAxfP5/czEKKMzAKvyihgPXxRvPBFRr7sKK/n0cERzA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=chxMhja65j84IpXDszL6AXblCnXwHnVZUr6DFDxeUuXuDyBDQVadzFcCzIYNedpb4
	 hrY0tvWGZtYUOmQsnvP5r8oOevwymqARWuZiHl91mh7GvtWTqKqWttLYO3D20Hyde9
	 B6N3SoIqrcytnRFWa6mGj7LFy2+blYyv8W7/Qafq/pzV0IAkg3O354wn3YdCZoLhz9
	 l9ryAqUEUGRRIUaTqjiqI2xsU9M/CtxET9UG6jOEgc3dXS4nMqK9pvbYW4c5jToz9n
	 5xQsSKunB7DE/XQr7vdBzjf8VpYrxUCAAYtOcBO7UqxcxDhXIByhsyYbkJ2m+sVAO+
	 QurCGkkCfct3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BC4C8382327A;
	Thu, 15 Aug 2024 17:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: change XIP's kernel_map.size to be size of the entire
 kernel
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172374424043.2967007.9731794002045827088.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 17:50:40 +0000
References: <20240508191917.2892064-1-namcao@linutronix.de>
In-Reply-To: <20240508191917.2892064-1-namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  8 May 2024 21:19:17 +0200 you wrote:
> With XIP kernel, kernel_map.size is set to be only the size of data part of
> the kernel. This is inconsistent with "normal" kernel, who sets it to be
> the size of the entire kernel.
> 
> More importantly, XIP kernel fails to boot if CONFIG_DEBUG_VIRTUAL is
> enabled, because there are checks on virtual addresses with the assumption
> that kernel_map.size is the size of the entire kernel (these checks are in
> arch/riscv/mm/physaddr.c).
> 
> [...]

Here is the summary with links:
  - riscv: change XIP's kernel_map.size to be size of the entire kernel
    https://git.kernel.org/riscv/c/57d76bc51fd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




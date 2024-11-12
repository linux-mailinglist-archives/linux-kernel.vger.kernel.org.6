Return-Path: <linux-kernel+bounces-406819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BA89C648A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B063285733
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C366021CF84;
	Tue, 12 Nov 2024 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFy+FHMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FA21C185
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451983; cv=none; b=XWjug8Pkd2lVOsUfprd1rp8aorUhyfc6gF8Dq4K4ocyw+UKtT8k3CrHUbvCo2BZfgTn4k1kdtxLApwoYRpEaHPMu9pvX6Q5xXmtPeN6TUisrNqHQ/5LwplVjXpWFKi2E0QS49FFW85/xcpns4sU9iV4Sz2BfNPJzIFWkpYkAMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451983; c=relaxed/simple;
	bh=gM2fD9GKvbDRwedhwlgxqJL8AUErzeS2hOc00WVUabA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H+nqYhJ712YMweyEw8DeeCt6wTzydARBlOQXwIZOH2Gt9m5ioDChzRSmTwh++EyUaV8hMxslhY5zugHuSdMVbQN/38TDdWXVcwQIg7ZdwwGhnTGJofteDJiHFRZdMqhzbY/LkIl3pMaNm4nbFJW1vJYb3mzL1s2IcHKdQikFDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFy+FHMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA32AC4CECD;
	Tue, 12 Nov 2024 22:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731451982;
	bh=gM2fD9GKvbDRwedhwlgxqJL8AUErzeS2hOc00WVUabA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LFy+FHMFW6LdVtTsrqkuD9RI0sDFVIbBYGK2GONCqeFgY2wxRp531N6g0/fz9SQqr
	 CvIlxXQWjpRfsBedTEpDT8Czv/KaElBxKJwIbsCrkq7+pWtOn1rpy0XBWOzd4rnPbf
	 NC2/74M+LXAsnYFiy3909PAyZgitL8RnOQiVHq7OD+L4OORloAkjmwoymRYaOiLmSr
	 3XzclU356FU+uQFVs3ODaDAhQXfmOguWzNRF6XlufbFZKzrXm297wunUADLZ8c0f8u
	 PUP49+DCmEjBZJS4jzoNQD2tYNQiCZ26tD8/VQaXR9zUsvKY0uMyJDAlkMGBDNnZtH
	 Ory/FhVzi6s6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DFA3809A80;
	Tue, 12 Nov 2024 22:53:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] irqchip/sifive-plic: Fix error codes
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173145199270.701548.8713115624337765162.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 22:53:12 +0000
References: <20240903-correct_error_codes_sifive_plic-v1-1-d929b79663a2@rivosinc.com>
In-Reply-To: <20240903-correct_error_codes_sifive_plic-v1-1-d929b79663a2@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, tglx@linutronix.de,
 paul.walmsley@sifive.com, samuel.holland@sifive.com,
 dan.carpenter@linaro.org, apatel@ventanamicro.com,
 linux-kernel@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Thomas Gleixner <tglx@linutronix.de>:

On Tue, 03 Sep 2024 16:36:19 -0700 you wrote:
> Set error to -ENOMEM if kcalloc() fails or if irq_domain_add_linear()
> fails inside of plic_probe().
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202409031122.yBh8HrxA-lkp@intel.com/
> 
> [...]

Here is the summary with links:
  - irqchip/sifive-plic: Fix error codes
    https://git.kernel.org/riscv/c/6eabf656048d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




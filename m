Return-Path: <linux-kernel+bounces-442281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C09EDA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0799A188A366
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3471F37D3;
	Wed, 11 Dec 2024 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjCRwsVY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955320E01B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956390; cv=none; b=DRX2hWZ6x4+o8/O/T3STq89b9T+a1JhwgZUH6l9Gk5MbsovYpnPkyvs9SkLclTiCGiH6tf+ROLcTAEnBRWsvb6Mma5k0eCMceG/pHCjYbSALxSRSZQiAr16fnA8Vsn3UXtZOv5tPhDDFUon9aKC5Aiuj5berIJ9/Le27me4sV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956390; c=relaxed/simple;
	bh=rziuN3RXTNb4asfxHKmfuF1OD4uzOzCzxCR0NbNYJbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YwFPYZEBCV24FgPYo/do2njh1+8Itz+BwSwYEJcQO1+ldB7cx/K843Gz++L3lePprjmEPu8PsM8lxFpy6WZw7xDj5mtRf/HptdEtfWULEfeR2N7ePJ+Yf+km/qOOL73o3JUDSuuV/r4CSU3Rr7FU+WACXY/jvlbdXEMl+LB1edg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjCRwsVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0511C4CED2;
	Wed, 11 Dec 2024 22:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956389;
	bh=rziuN3RXTNb4asfxHKmfuF1OD4uzOzCzxCR0NbNYJbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HjCRwsVY/9VT2iX5FTXa5PhLKybNvSrKCwt5s7RhSzyhnUxmw6iB+sLJeMZ75QLFL
	 TiI44RsJG0ThJvtEwTJJyDRxf7rMu7qdSJYfNhLKnQGaDzaI/f0CVShF/0UFeO9Z8R
	 K8iAVjjnrLu9k8nNR0boZZKuT/BBhxJupk+NSqJ8vcH2B4/kAzz8c0ztLrOhOE5JFV
	 GxlOtFug4+VsW3KEmgl0yGR19Haaw9RWvfChhL0QVGwm12s1a3ku6xBE6ZkzHbPeqO
	 9IJhqAY/pvtJzZQp8M9u5kSctPMt3rzzIiPyIwS/gf/gETsNkipHN4eV8pITk007Az
	 ptHGEaZoLXKcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3435A380A965;
	Wed, 11 Dec 2024 22:33:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] irqchip/riscv-aplic: Fix crash when MSI domain is missing
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395640574.1729195.6519858091833497915.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:25 +0000
References: <20241114200133.3069460-1-samuel.holland@sifive.com>
In-Reply-To: <20241114200133.3069460-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org, tglx@linutronix.de,
 aou@eecs.berkeley.edu, bjorn@rivosinc.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Thomas Gleixner <tglx@linutronix.de>:

On Thu, 14 Nov 2024 12:01:30 -0800 you wrote:
> If the APLIC driver is probed before the IMSIC driver, the parent MSI
> domain will be missing, which causes a NULL pointer dereference in
> msi_create_device_irq_domain(). Avoid this by deferring probe until the
> parent MSI domain is available. Use dev_err_probe() to avoid printing an
> error message when returning -EPROBE_DEFER.
> 
> Fixes: ca8df97fe679 ("irqchip/riscv-aplic: Add support for MSI-mode")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> [...]

Here is the summary with links:
  - irqchip/riscv-aplic: Fix crash when MSI domain is missing
    https://git.kernel.org/riscv/c/1f181d1cda56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




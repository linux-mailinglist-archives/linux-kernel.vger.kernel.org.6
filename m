Return-Path: <linux-kernel+bounces-370163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6747D9A28D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F50D1C21160
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CB71DF26F;
	Thu, 17 Oct 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vipj3Th0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B311DED74
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182628; cv=none; b=LcQP0wL/BbEXjs/T0OVjpBdgI4g/yo1P68wMwT5F/YBVJjdELz0rMlfSu/0RyODt3QiyQc2MvTuHIHqrlPoR7E51akT9A3u0fCtCvEQvvqx5iufVvMlR4diBBG0ska/odOhshoKEIEyyjfuQPG4fE8tbF6olOekEQ7j4ovkyUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182628; c=relaxed/simple;
	bh=ReJ5uhQRcBg/1XL59l+RmpDPJh/BYKyOS8QEpIqsA7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b8CjuDJaAVHkGt8q7APqZR3BdhAAEF31mYIV/LCCDm4ehZmR4/98PE8bI3cas06cfuJuRn5U8Y70xEEaiCnU3yjEbsJALcanwveDaOWwiM/yNa2krRAJtyak2X5YOaO81uPwJNeTwXJwkYGbJXJb2PzRKTyzbgDm9e7zooYr6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vipj3Th0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C04C4CEC3;
	Thu, 17 Oct 2024 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729182626;
	bh=ReJ5uhQRcBg/1XL59l+RmpDPJh/BYKyOS8QEpIqsA7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vipj3Th0pCqGVCEiHcQf5AabDrH4AI6EPjqq3Fk/BRFd5qhrXSnedIxqrFZQSIAxb
	 QljU3VEBzxxSqSe7+3YGTITwmz42hcOUAFUzpsQfzM9ncLTzUuPcPN66cvl2ouE74h
	 uSCxsdxSnMYvodA+mQSOSDFrPk1UiyZJ7RmF1TWv8FVhhe6C+4sGxcEC8XttwDmRya
	 7zkDdCfAH9ZjHExb7Bzh0bNkbsLpS4mpsuFz4i0apri5fw9TlXJWA9nSik1QkmYa8q
	 4rvUIXlSIB4ebxuQpON7uarHX16LDD4MZqzA9TkhBqSP7iYxe0m+dlUqQzwHcTDBp6
	 zej/6d4JJRtcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8C3809A8A;
	Thu, 17 Oct 2024 16:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] RISC-V: ACPI: fix early_ioremap to early_memremap
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172918263201.2528145.6233563101425140097.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 16:30:32 +0000
References: <20241014130141.86426-1-cuiyunhui@bytedance.com>
In-Reply-To: <20241014130141.86426-1-cuiyunhui@bytedance.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: linux-riscv@lists.infradead.org, punit.agrawal@bytedance.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 sunilvl@ventanamicro.com, alexghiti@rivosinc.com, conor.dooley@microchip.com,
 rafael.j.wysocki@intel.com, haibo1.xu@intel.com,
 jeeheng.sia@starfivetech.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 14 Oct 2024 21:01:41 +0800 you wrote:
> When SVPBMT is enabled, __acpi_map_table() will directly access the
> data in DDR through the IO attribute, rather than through hardware
> cache consistency, resulting in incorrect data in the obtained ACPI
> table.
> 
> The log: ACPI: [ACPI:0x18] Invalid zero length.
> 
> [...]

Here is the summary with links:
  - [v2] RISC-V: ACPI: fix early_ioremap to early_memremap
    https://git.kernel.org/riscv/c/0dcf8269ecee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




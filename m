Return-Path: <linux-kernel+bounces-288379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBC953976
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA88286ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347C3605BA;
	Thu, 15 Aug 2024 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9uQsyue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA357CBC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744239; cv=none; b=UnZ7Devc3UAQiL46Z2kYjyr8Z16wbA6zvEaXZBskL1XkcMqD3lMpAaAe3l2xDywdmK2Ue4xSnCEXnOg7U72LFhqwpBKGFzkl7zjyT53umRCM0c2+3sKM3PCMr/AZZ9rNMfoCXeh0CznZjGBg0UW/Zth7RrXZtdBr1AudpxyoQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744239; c=relaxed/simple;
	bh=C0K0y8xjMzXiqfZeiuATtXG7MMvO3HdT273gPOXVus8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fJ41sgsmsf6uvyIBtcl6XoJ9qqkaCKi15oN4w5vGDqIgZls0Kd5s2bZUGsAVwfGFfDhwry3l+he2V6HMB660yviSIaZ9dvuhPZT0P5wrxxVPyiB8aah1C1skERFRPd0lKKDKeAliYotAAmJDf/WWfl9kfe0sMpBhb0IV9pN337Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9uQsyue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABEBC4AF12;
	Thu, 15 Aug 2024 17:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723744238;
	bh=C0K0y8xjMzXiqfZeiuATtXG7MMvO3HdT273gPOXVus8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B9uQsyue+w8drvkYVNc+kk1QuuZQyvILUbUUx8hXvuJibsLuzys36fEfp0kbdmPzE
	 1ayPB/2gwauoydS1ZHIDKNMEXUeyWYLd0tOq4z/WiElszOWrXasWGNZpNT5Bi6BOSM
	 XyF/qqw4o/Uv7TFxvslG7BSbk1yfzibQa2ZP5cdyLzKI6fK6Rf8uKox0mIQfwiYy2t
	 cNzcYlQFtKTp75bpnDkzus3rWVK/ooVqLBiSGt5M3Iq3XURYpKTDFM6xl2guw8Gcv5
	 UlEk3+MkeG9xPaN4Z6YkIYYJ+68K8KC+5Ao+hK7F1iMUf6uJcC6QeYmmd/bt/0Sb6n
	 PrTaPGmcEY/9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35CE8382327A;
	Thu, 15 Aug 2024 17:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes v2] riscv: Fix out-of-bounds when accessing Andes per
 hart vendor extension array
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172374423800.2967007.6789620641826605863.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 17:50:38 +0000
References: <20240814192619.276794-1-alexghiti@rivosinc.com>
In-Reply-To: <20240814192619.276794-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, charlie@rivosinc.com,
 andy.chiu@sifive.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 14 Aug 2024 21:26:19 +0200 you wrote:
> The out-of-bounds access is reported by UBSAN:
> 
> [    0.000000] UBSAN: array-index-out-of-bounds in ../arch/riscv/kernel/vendor_extensions.c:41:66
> [    0.000000] index -1 is out of range for type 'riscv_isavendorinfo [32]'
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc2ubuntu-defconfig #2
> [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> [    0.000000] Call Trace:
> [    0.000000] [<ffffffff94e078ba>] dump_backtrace+0x32/0x40
> [    0.000000] [<ffffffff95c83c1a>] show_stack+0x38/0x44
> [    0.000000] [<ffffffff95c94614>] dump_stack_lvl+0x70/0x9c
> [    0.000000] [<ffffffff95c94658>] dump_stack+0x18/0x20
> [    0.000000] [<ffffffff95c8bbb2>] ubsan_epilogue+0x10/0x46
> [    0.000000] [<ffffffff95485a82>] __ubsan_handle_out_of_bounds+0x94/0x9c
> [    0.000000] [<ffffffff94e09442>] __riscv_isa_vendor_extension_available+0x90/0x92
> [    0.000000] [<ffffffff94e043b6>] riscv_cpufeature_patch_func+0xc4/0x148
> [    0.000000] [<ffffffff94e035f8>] _apply_alternatives+0x42/0x50
> [    0.000000] [<ffffffff95e04196>] apply_boot_alternatives+0x3c/0x100
> [    0.000000] [<ffffffff95e05b52>] setup_arch+0x85a/0x8bc
> [    0.000000] [<ffffffff95e00ca0>] start_kernel+0xa4/0xfb6
> 
> [...]

Here is the summary with links:
  - [-fixes,v2] riscv: Fix out-of-bounds when accessing Andes per hart vendor extension array
    https://git.kernel.org/riscv/c/b3f10d9b81e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-286578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAED951CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1852C2866AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF41B3F21;
	Wed, 14 Aug 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfV9y9qZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DF71B3F0B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644635; cv=none; b=WaUsopN98Gf5TyqkoYZ0S9DlYSn3Y5VrLNfcohoQOmEWXYucA9Tei/iIoAjUEi2hb/5x9t+Y0F3Q1EiFymHB4B18xwntlOa5vBOHmPcOzMQERX4nEuSJe16NwFqLvJPPL5xtMA3yDp2vyCdRj9g+AzOwzf30vq9Fg/vHo1NUwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644635; c=relaxed/simple;
	bh=K3AQ07cuCgUyJCPRakco3p9i1a9jiXa67Ur23zs1j0c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jfis4rnFamdYgXkDosnaYsexBLe7TK7AeQxVpcyLb4teTocDiGdgGVlUsH0kLmLV1XSIYN2Jpf0yVq0l/llJvA6bOMlVLQs4qMoP0ueVz82yunjUuMYNqCnMakUghhqdTFSl/GpEiYr+t4hVkwVV5I40sWM4csSA+H/p15OXIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfV9y9qZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8546AC4AF09;
	Wed, 14 Aug 2024 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723644634;
	bh=K3AQ07cuCgUyJCPRakco3p9i1a9jiXa67Ur23zs1j0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NfV9y9qZfixgg3kwogSL9+LtAmZLeIaEZVKYrhxJMEUTY7DpDoMB7263I2Dw+ZDtL
	 vqHd8kDetJhkkykJoeAH2VMmK/2o3UeUdB/C8lgV4cwRCGQNBR+YoZ9u1AqYUYDj3g
	 DC07bNb/D5exBk2saq2ylhNbmhVJObqjdsJercZPNcgsQYc3xUmWcPNcMYrtbF6jiF
	 mZPhAEGb6B7WLU6AI6dKKxKCIO91OXsLQRBUda0zhArpoHMKzSmqL5H1SO3fSVPRo/
	 3gHQ4M2AR8BNLpR+eqcuwVEYuUOPKkiZ5MGyzvV4UQDC3sLQBGAzT8zMW1aL87FWbh
	 v/TOg3jOo5Wpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB08A38232A8;
	Wed, 14 Aug 2024 14:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] riscv/kexec_file: Fix relocation type R_RISCV_ADD16 and
 R_RISCV_SUB16 unknown
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172364463350.2278280.14691701821976528565.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 14:10:33 +0000
References: <20240711083236.2859632-1-sunying@isrc.iscas.ac.cn>
In-Reply-To: <20240711083236.2859632-1-sunying@isrc.iscas.ac.cn>
To: None <sunying@isrc.iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, ebiederm@xmission.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 zhuhengbo@iscas.ac.cn, petr@tesarici.cz

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 11 Jul 2024 08:32:36 +0000 you wrote:
> From: Ying Sun <sunying@isrc.iscas.ac.cn>
> 
> Runs on the kernel with CONFIG_RISCV_ALTERNATIVE enabled:
>   kexec -sl vmlinux
> 
> Error:
>   kexec_image: Unknown rela relocation: 34
>   kexec_image: Error loading purgatory ret=-8
> and
>   kexec_image: Unknown rela relocation: 38
>   kexec_image: Error loading purgatory ret=-8
> 
> [...]

Here is the summary with links:
  - [v1] riscv/kexec_file: Fix relocation type R_RISCV_ADD16 and R_RISCV_SUB16 unknown
    https://git.kernel.org/riscv/c/2d1f51d8a4b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




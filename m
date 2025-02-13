Return-Path: <linux-kernel+bounces-513713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D982EA34DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5C03AB7D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2510F24A042;
	Thu, 13 Feb 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drEF+5Gq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400A245B14
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471411; cv=none; b=IY3kffVAZ6zMGO/c0YI783Sw1atwjuahGxtg+ZXejWbAZoax95S5pO/44BkL+mzOVHHMUqy/Ag86VhWC/Q6uEDUTrroYPe0KIuq3BTsImczTBi4997NqL0czzNFH1VHLpJYoiO9arqXin40JmxcB7YkG0FUAAGuT1c/drtFJyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471411; c=relaxed/simple;
	bh=/I8XkFmjwOBQTCuYuYfxvzqCS/2fPW2XvfbBm4xgaYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CU6ho+tuPZyTKsyY25w3VCpKO43yRkF2ZGGdm5XGfcIuRK49jI7IHT9Pb+/R60bkexDwHxjZEwSg1Fau78GmEUN+VfITX5EMbliCMiR9dpIYR3pKGmU1U21mkFy0b1TKSaoAhxMQxmv8NOlhBwSazrg2yZRX1wX55P4SUZb2dPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drEF+5Gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F30FC4CED1;
	Thu, 13 Feb 2025 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739471411;
	bh=/I8XkFmjwOBQTCuYuYfxvzqCS/2fPW2XvfbBm4xgaYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=drEF+5Gqd9C3Gj+IA8Y4eE/tnDMTw4O2y0XCMkVSrtkyIQWzbYIjIVchJ+3TZ8Jwq
	 /nuvz3EaI7GE/IYgRzKEc98AeJQVLF1+epcm43D5PUMyjgfze9eDBwZ5mcfmAA87XJ
	 5jvJ1mOixLiMU4RPXU+FDiLrvzvvzXSKCxaivxaVXAqlhknssOFen9b1M2EVfsCJHF
	 oiE6u4XOaNyhYl9olEgiFoqcA04pNxz6RmSQPfXErFM6dSA4In+O0OTmSMfC7AkshY
	 JYvIbu7y9JA7YeMz4nSJ4TJlp2SqbWpwhsbQlKT1lsuMRJWS0miz0bH0pW/7kt+u6l
	 oUGctlkF754Fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE580380CEEF;
	Thu, 13 Feb 2025 18:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] riscv: signal: fix the size of signal frame
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173947144024.1330575.6054499758611770955.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 18:30:40 +0000
References: <20241220083926.19453-1-yongxuan.wang@sifive.com>
In-Reply-To: <20241220083926.19453-1-yongxuan.wang@sifive.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 greentime.hu@sifive.com, vincent.chen@sifive.com, AndybnAC@gmail.com,
 andybnac@gmail.com, zong.li@sifive.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 20 Dec 2024 16:39:22 +0800 you wrote:
> This series addresses two issues about the RISC-V signal frame size
> calculation. PATCH1 removes the unnecessary header preservation for the
> END header. PATCH2 reorders the apply_boot_alternatives() and
> init_rt_signal_env() to get the correct signal_minsigstksz.
> 
> Yong-Xuan Wang (2):
>   riscv: signal: fix signal frame size
>   riscv: signal: fix signal_minsigstksz
> 
> [...]

Here is the summary with links:
  - [v2,1/2] riscv: signal: fix signal frame size
    https://git.kernel.org/riscv/c/0eeb13956757
  - [v2,2/2] riscv: signal: fix signal_minsigstksz
    https://git.kernel.org/riscv/c/5338770fc74b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




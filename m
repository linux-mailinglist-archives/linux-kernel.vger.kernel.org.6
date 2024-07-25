Return-Path: <linux-kernel+bounces-262239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A80A993C2DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5138E1F22129
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85C019DF4A;
	Thu, 25 Jul 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7sBpavN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4E19B3EC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913639; cv=none; b=MfSJA5SHpVRuBqxEgI9RhP2bCSk8jv5Pn3WQ3FAUw0U1ZQKKc8G8i3G9t04176gFJxyRCO9xYrRhPa5Cf3ORpsrqUlo04vnLDaGRYPpupsgXxmD9tLZFioPcYOlce24XOjVLjXiv7VrO+K97jcg6uH+N+SqabC/Dyf+eT8617Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913639; c=relaxed/simple;
	bh=pv1EbBB+Diu8zt1u9Ud8mj6yeTOIaZMPy0uWO7Z+kM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IRYz5dp/g2ySdGc1WQb2+kaH5iGw9kdrWEywLrkbpTyTGRb4P+SUjyE/UMyl/xN1Otg3htaziyPD7D0lfZsfYAUH1hEIUoKk9FB6Es4VH6o4UsUaZmjPfaUiigpQCkECP8Rl4WBH+EtDZ0azveVLfLuVHDVLzNM1kULmvbpN7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7sBpavN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C346C4AF19;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721913639;
	bh=pv1EbBB+Diu8zt1u9Ud8mj6yeTOIaZMPy0uWO7Z+kM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N7sBpavN9QprHaBwp7OcgJA6SimgOaKnMGDjQoG/M3iXdc83uJMz0+lt69EayLkYo
	 V3uLsHtVGp41mCiafbQbtwuBrxIjqxXRf6wV6tznTJ/9FshdecAi/+TbechdKoop1E
	 piabRVX83H/s0z5ZQieqc6FEZRadq6xJ5dUmaX/GnKmRmQqY0E/O3p4V3YCpSJs6Qu
	 x9JcZWSf9jc5OCwbVP8B6Qhte1xPPsychUqZWhVtQO0n7knVa9tS5o/fdHFWWk2vZI
	 vhLrs+FNIIgzVTO+CkAJ93AYhd4+OdWj9UJYlvzEl78k80IlwdCONfUWjhCw7H6GDJ
	 aDyb5+/HnpmFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7063CC4333D;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: Improve exception and system call latency
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172191363945.6240.15239605352830042623.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 13:20:39 +0000
References: <20240607061335.2197383-1-cyrilbur@tenstorrent.com>
In-Reply-To: <20240607061335.2197383-1-cyrilbur@tenstorrent.com>
To: Cyril Bur <cyrilbur@tenstorrent.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 antonb@tenstorrent.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  6 Jun 2024 23:13:35 -0700 you wrote:
> From: Anton Blanchard <antonb@tenstorrent.com>
> 
> Many CPUs implement return address branch prediction as a stack. The
> RISCV architecture refers to this as a return address stack (RAS). If
> this gets corrupted then the CPU will mispredict at least one but
> potentally many function returns.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: Improve exception and system call latency
    https://git.kernel.org/riscv/c/9eb7421003d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




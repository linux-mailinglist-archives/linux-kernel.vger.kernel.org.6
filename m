Return-Path: <linux-kernel+bounces-331723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA9397B078
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3441F221CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8364518859D;
	Tue, 17 Sep 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMXxXbh5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27CE187FE0
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578050; cv=none; b=sqnVFJtvMkAzMBxYTdCE7ZTaMer/UvfrAKz77KB1nnlQHuKAy3hJQbOtdEVjQJYWW9FFxojn7yplGEGnKSfs7dnMafIFDbPoOvX3zE1UfTaEGRq/4fGBwottu5lAHVLOjdpO7+bo8pw38EEBXr3g7dgtWA+rGevjLzsdrtzTMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578050; c=relaxed/simple;
	bh=1YBVwpwShseYqofpoveS9WJvw66aL8eM1rri7KCuq9k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NyEAnsC2cRHZ6DI++Adm67ypmrEZG4Ta7foCSNYQPN71Pc7VGb4rz1Ak8a6K+AgTi3N4PX9lEA1q2ItO0Vs+Agflw8efw+JmEGuO1UObzVLQV8boP3cnhYsaBmffR8Tj/x+8aj5i5A2NT+ppQNVXAnupXgiysPnsvVZm7cRrQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMXxXbh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856D6C4CECE;
	Tue, 17 Sep 2024 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726578049;
	bh=1YBVwpwShseYqofpoveS9WJvw66aL8eM1rri7KCuq9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qMXxXbh5uQTJkNLKeL6UxW+qv5g/NUF8AndGUG4PKxRnVWZhRBZpqjYLAu0UZXh86
	 u+ewsKlufWBoECOvPptovFCU784ng4ZmPPM5L47AnWPlsnOmXNxL5xR0C1Q9YAsn33
	 XJ2xUQpFpR56PzX2tQHq/uCuy9nDdJJo08QsIj7+CGzX5QFFEMmhJC4+3nehIUDLM9
	 2hziyodgBsBeHfLFbkhK+YogK50hNrBmWTckX2w0toDjxzx7c9+O+dBCF88P6ccg1Y
	 6G4XlqSBPUVhb2APb5T1vI6zC7oDHhS2wSs6IescwAANPf7IZf49lvjRn5WBz/yIFn
	 05nx7VfD1amPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712F03809A80;
	Tue, 17 Sep 2024 13:00:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: cacheinfo: Add back init_cache_level() function
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172657805102.126252.12300366991345937077.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 13:00:51 +0000
References: <20240707003515.5058-1-spersvold@gmail.com>
In-Reply-To: <20240707003515.5058-1-spersvold@gmail.com>
To: Steffen Persvold <spersvold@gmail.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun,  7 Jul 2024 02:35:15 +0200 you wrote:
> commit 5944ce092b97 (arch_topology: Build cacheinfo from primary CPU)
> removed the init_cache_level() function from arch/riscv/kernel/cacheinfo.c
> and relies on the init_cpu_topology() function in drivers/base/arch_topology.c
> to call fetch_cache_info() which in turn calls init_of_cache_level() to
> populate the cache hierarchy information. However, init_cpu_topology() is only
> called from smpboot.c:smp_prepare_cpus() and thus only available when
> CONFIG_SMP is defined.
> 
> [...]

Here is the summary with links:
  - riscv: cacheinfo: Add back init_cache_level() function
    https://git.kernel.org/riscv/c/1845d381f280

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




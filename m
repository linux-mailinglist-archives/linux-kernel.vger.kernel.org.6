Return-Path: <linux-kernel+bounces-407864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A1A9C75FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B40228B277
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70DB20F5DD;
	Wed, 13 Nov 2024 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ggfx9paO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED620EA37
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510768; cv=none; b=WMG5rcE5+1LhhAeHKGsndBzGtGlUSAq9JkpCg2zOrHTOojKl8bsfg54y5lWOSQqSVYANjC758KGbbqMw1EvQya4JoK1SjLxWWIV//nudom1N9IK89pyr4zveZuasNimtwJNZ6bvq/baGfdUtSgp7azhdEkUnNj56Ub1/B3/T2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510768; c=relaxed/simple;
	bh=4547KjisiSzSsjrc9K9ehuBqFLkQAd8IxQnZbpsV0Gk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AAltDPIRzmlm2hAB8nxVug8NIEXEZGCwTegzArkHGV810/AM4Zna5dDvM3aN+VE6hPeGRYnGNfblDyIqVF5aYwhNW/q42I9VPpe+dr4wLOs/eHs9P2+LBFN1k6gfzHP0Me4muZfom9G4t2iXUVFT2HBF7Vu5YU2tKZgkVi7YGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ggfx9paO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEEDC4CEC3;
	Wed, 13 Nov 2024 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731510767;
	bh=4547KjisiSzSsjrc9K9ehuBqFLkQAd8IxQnZbpsV0Gk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ggfx9paO+4bEx7zmSlVE0vDRqio1zCqzgORBfpOkCAqrrMiuCQgnVu8ycPjZccgHk
	 NPXx7GgqQTSyvky00FVlfvHsWk4uxy2N5YaSythvwGEPT8J2AUe8Nh+vyX72tC3JCl
	 npCVzxG6OByH8+/X44+oO72MsXf2HQheSQ60QbwPXlp7jv8QvTNM1dVs32D/BH6VQG
	 za73EsK30mye+UXVZpnwZbAQ2mqCjX6W7SOo/FZqdGA/cHZLT7RAAbYCtpsDC7BT9a
	 RswdJoppNMpbF4SzVr9Vo9JDbKak3MCPGR1V9bBqyAclw3/YHj4L0xMP6F3rRAqmNL
	 7sn+JqPHGxtkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7118C3809A80;
	Wed, 13 Nov 2024 15:12:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH for-next v2] riscv: Fix default misaligned access trap
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173151077824.1250875.1331896085573525028.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 15:12:58 +0000
References: <20241108-fix_handle_misaligned_load-v2-1-91d547ce64db@rivosinc.com>
In-Reply-To: <20241108-fix_handle_misaligned_load-v2-1-91d547ce64db@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, Mr.Bossman075@gmail.com,
 palmer@rivosinc.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 08 Nov 2024 15:47:36 -0800 you wrote:
> Commit d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses
> supported") removed the default handlers for handle_misaligned_load()
> and handle_misaligned_store(). When the kernel is compiled without
> RISCV_SCALAR_MISALIGNED, these handlers are never defined, causing
> compilation errors.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses supported")
> 
> [...]

Here is the summary with links:
  - [for-next,v2] riscv: Fix default misaligned access trap
    https://git.kernel.org/riscv/c/0eb512779d64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




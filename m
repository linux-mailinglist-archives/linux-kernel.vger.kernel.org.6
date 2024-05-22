Return-Path: <linux-kernel+bounces-186331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD358CC2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B610B21004
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1964C140399;
	Wed, 22 May 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IchHSFJ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CB13DBBD
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387033; cv=none; b=gut3mGapqX8kzX+OrbjYmyTvlPBUqTRhkxt3t10bzO8NYs8v/1Fy6v4dUAVnJ+TMT9l6/nrFCjdxFjPoYNsAbErCVdD1av1h9st8952s+G1LHhMIGZukwkdkDyIh8CrLajHOJ14qKoU2kvlCn6XOAvbC7ZJZt44S8fl81/NOiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387033; c=relaxed/simple;
	bh=G5jx41m2NJEBfmuU84pfaSn8qvt+7itfBV6dI/8zugY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jQIjudWklAp0GWzflfYEGJ/m3ERnG+edXE8dgi3PutFD51Z9Pc0PilE9OCCj8UCJcHmkqT9ykxS+Tuwm5hZzoj41kT/bvvw9JtFqLRbVd89orpp7Wg4AFgVWmSXZCGeJ6hL//mDIgiARCJ0ZD0DJDRDEsf2YlSd8xIcUKOjx09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IchHSFJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6C34C32782;
	Wed, 22 May 2024 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716387031;
	bh=G5jx41m2NJEBfmuU84pfaSn8qvt+7itfBV6dI/8zugY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IchHSFJ+AGvac+0x1wL3SbSrGlohoHDA81RiyXeID/x8iwP0KzsAUJAugxhW+5RyB
	 51O7B9quDgqApbQA+NiL+sHfuU7LAeSvy0y5BhhJMs8mmwvphBkblwd8r3CbioNLDn
	 NBFntAu0njMOCMzkpUjV9qYmHvfdQYaO/EDaw8+4rwjKhqADqf/lGaby4G0ZvowCBn
	 xEf1mEozzm2JfG8RqPJ+rHU23jZFYoKEBkPb/vl7xOoV2SciK4Jd6AwTuQ9jRACDaQ
	 ade/MpjSaq4Qiq1ziCNoa88LB6tzDZ8YKNc9vMT6g1/xu3o9WkkBVxqIpCs9WultNW
	 TSojxbXras6BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFE89C43619;
	Wed, 22 May 2024 14:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: do not select MODULE_SECTIONS by default
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171638703171.12705.15078741837244671625.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 14:10:31 +0000
References: <20240511015725.1162-1-dqfext@gmail.com>
In-Reply-To: <20240511015725.1162-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 qingfang.deng@siflower.com.cn

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 11 May 2024 09:57:25 +0800 you wrote:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> 
> Since commit aad15bc85c18 ("riscv: Change code model of module to
> medany to improve data accessing"), kernel modules have not been built
> with -fPIC, so they wouldn't have R_RISCV_GOT_HI20 or R_RISCV_CALL_PLT
> relocations, and handling of those relocations is unnecessary.
> 
> [...]

Here is the summary with links:
  - riscv: do not select MODULE_SECTIONS by default
    https://git.kernel.org/riscv/c/2ae376aa0cd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




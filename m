Return-Path: <linux-kernel+bounces-271638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD0B9450F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC15028A4C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15451BC9E7;
	Thu,  1 Aug 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyEHzMtg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345721BBBDD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530438; cv=none; b=MlvpNsOJB/mVr2UtPmGEqneBQrUCbxbvtaPc02SeJ86yCyWBwZwzqxPT5kFkC6I6tEFrfuy+hZ0h1fpC5/IvDOfLfqdXdgf+vuuwHU/12fqw0stkY73HFT3hHB+gXJNLtaHwEFM7RmR7estYrcKrHcqLt066LmBwSaHKuSvww1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530438; c=relaxed/simple;
	bh=d+0w/utyCeOUAJB0faml6J6Fo1KVfysprXdgsrmI0gY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aPUyOS2UqlRokn8Ky+aizafe41ge2eTe+H8c65i5fmbk7G2hQBOQGQCUMqjeJWBd3vDhpYn/5NA1QJLzP05UG+80tuAWcM4xteS/AkBZHDYLFppbU5vd09eVmLuKuZs2/xOR7czjK4IdmQvLajmEFlg0cKXLlytuGjzAmIJpE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyEHzMtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4129C4AF0E;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722530437;
	bh=d+0w/utyCeOUAJB0faml6J6Fo1KVfysprXdgsrmI0gY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iyEHzMtgm0NvIQ74RjpgOupB/46iT959lYS7ymDJRAYBuWh3U4AxFqUVRzL6CpWwI
	 iSUEdMCg1WFvGhPZmEpqtkP3RMvjPn+N4SXNtK+Qay3HdPzUQN/u3cTEF8vLFyfw4h
	 bQeFDPUkBw+hVaOBiWOozXjZsGSuYNA41lGtD9eV2OS/gK9g7K/fo7mfQP38lMJVww
	 XdaGbStyJbzXCf4KiMg/5Zwc1IcX4yYd6DjzzU2grDC9KHPa4e+PQe9oz6zHJF7iNQ
	 APvyGlX1XUpiRbNb83lgaw//eb4/kxMXMNsL6WGePpPyZ4H4xB2R0uIGnjC4r/H2TR
	 NER1moyfX0gjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A91B8E8876D;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] riscv/mm: Add handling for VM_FAULT_SIGSEGV in
 mm_fault_error()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172253043768.13740.17412211332901181883.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 16:40:37 +0000
References: <20240731084547.85380-1-qiaozhe@iscas.ac.cn>
In-Reply-To: <20240731084547.85380-1-qiaozhe@iscas.ac.cn>
To: Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
 surenb@google.com, akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
 willy@infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 31 Jul 2024 16:45:47 +0800 you wrote:
> Handle VM_FAULT_SIGSEGV in the page fault path so that we correctly
> kill the process and we don't BUG() the kernel.
> 
> Fixes: 07037db5d479 ("RISC-V: Paging and MMU")
> Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [V2] riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fault_error()
    https://git.kernel.org/riscv/c/0c710050c47d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




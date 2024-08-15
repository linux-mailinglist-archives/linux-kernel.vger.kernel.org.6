Return-Path: <linux-kernel+bounces-288380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD0E953977
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D2C287185
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B071747;
	Thu, 15 Aug 2024 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EunRdICV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207FD56B81
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744240; cv=none; b=cLFg99wnyI3iHLLSeoUoq3UT/lohKDV5+yQc/JeZYhWL6qqtmJw6rE88ArssAVpKupXlahOXH6Cuht9ucPEoUdzSAizQ/jZ/rxb8Lg6harP1W4n9S9xtea5DOA1hfh4Yv1+byIuHivFmibu9dHAq2L7GzhDsQOicWEAID0G1RMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744240; c=relaxed/simple;
	bh=M7g4AOWgcoM+Mxwn7Ms0klZO17PB9AXv4lAQo5UV8+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gSefqFO1OjtsPEO5ngFUGXtp3Iq8HO1XRuHovT7S7ovTDocWtyaAeXFAu6z2vP2Mjr61MrSyKO6FUAip4OqOnPsoForM+bxtAjTxCTVDKgkJvAw6aEcZZLGAi+Yv2BXH5ULu2VVzDraf52g2G+d0ZyPpIJAdUOFUXJhTaWJeFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EunRdICV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6460C4AF10;
	Thu, 15 Aug 2024 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723744239;
	bh=M7g4AOWgcoM+Mxwn7Ms0klZO17PB9AXv4lAQo5UV8+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EunRdICVSRyrNtKdY5GCdUi/0YRYT2C2KEXBfkK6aEQ1SF192EU8AGh1VbhCky+O6
	 9oiuNzRmy/Blz/zvE1DxT3+3Ufgp0TfP4YvKk7eqvM/znCy7Zr8s9fsZMn+lrahw5A
	 omNDl3P9ZbfLmqXKp+3YTCAy/e2qDxOkS4tzB2LaryIN2/YRe2yzDAbSItfSwVi0oq
	 /jfYIi5yINeXb8UcXjVzS29ykxi/5VC7gaeY9zVMNZ9CjiYOM336zHusNuxql7yJp6
	 hZfl4P2ZPefEDsFUoDXP7VatgNiLl1EwIKs64eBEE7InAYHz1xBwksGFvdmEjJZw6y
	 rEE+wBy+1WVjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5C65E382327A;
	Thu, 15 Aug 2024 17:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] RISC-V: ACPI: NUMA: initialize all values of
 acpi_early_node_map to NUMA_NO_NODE
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172374423926.2967007.4687839335755873720.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 17:50:39 +0000
References: <0d362a8ae50558b95685da4c821b2ae9e8cf78be.1722828421.git.haibo1.xu@intel.com>
In-Reply-To: <0d362a8ae50558b95685da4c821b2ae9e8cf78be.1722828421.git.haibo1.xu@intel.com>
To: Xu@codeaurora.org, Haibo1 <haibo1.xu@intel.com>
Cc: linux-riscv@lists.infradead.org, ajones@ventanamicro.com,
 sunilvl@ventanamicro.com, xiaobo55x@gmail.com, catalin.marinas@arm.com,
 will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, Jonathan.Cameron@huawei.com, lpieralisi@kernel.org,
 gshan@redhat.com, james.morse@arm.com, guohanjun@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  5 Aug 2024 11:30:23 +0800 you wrote:
> Currently, only acpi_early_node_map[0] was initialized to NUMA_NO_NODE.
> To ensure all the values were properly initialized, switch to initialize
> all of them to NUMA_NO_NODE.
> 
> Fixes: eabd9db64ea8 ("ACPI: RISCV: Add NUMA support based on SRAT and SLIT")
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/2] RISC-V: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE
    https://git.kernel.org/riscv/c/a445699879f9
  - [v2,2/2] arm64: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE
    https://git.kernel.org/riscv/c/b8c09eb34465

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




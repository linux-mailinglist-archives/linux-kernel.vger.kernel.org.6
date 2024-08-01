Return-Path: <linux-kernel+bounces-271634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE09450FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F74B2348D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B6D1BC092;
	Thu,  1 Aug 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEZ07OEe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF531B3722
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530437; cv=none; b=E8eEGmMqT00eQFTj+L+XIndgAOb/jYyZF2BIzM7Q3pkAxIb7RMoa62ABR2IHXZhxlJrP5+x8zeBR4ONQJbG3kglU6q9FEJXEYskC4eIfjMHGFrfShAws0ZehLkf2vLUC5+bS+FxeJE+cRtV8nP7XhpUOVLLWF9Q6TduFIEy7VBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530437; c=relaxed/simple;
	bh=5dcaZj0wsgnhyNk2Cch87qZnEd9A+HrOMapM6+gaEb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AU9wf/UdBj0LZaAMPsVgdIQitZ+aSs16Hg1etmIwB6QLRcJFnoXvm1pg8m3MBeHmSP4jA0Row/Y7/aWGSltnUmtQAsY6Iks9R2McRdxdTryb64s3Y2FxpRVwfJQ8nASaYgqBf2GqKEExEXv0bo6mFT48hWibduWm8+7LuQ16u70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEZ07OEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBE9DC4AF0D;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722530437;
	bh=5dcaZj0wsgnhyNk2Cch87qZnEd9A+HrOMapM6+gaEb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JEZ07OEejp6dhGn/s46zA9WRN24vkEkaB1Qs34BpdB0QDavtMCebv+o56qQIXuELi
	 oeyog5DZRxJQDJFxkg/pIMmqEL41kG4qCt+ZJRz5ucibSgVsxifn9rHE8/EsnyUxi1
	 1jObVWsd/uHtPBEG4T+Rht/lDlcPZJsHaxVtk2Md/K34aZm6ef0iE7C5B75KDueLRj
	 QX/f/JlQg2Bp5+Qmldasi37SguY17t1DZT4hhvbBgQBRsk9vl5ESXhfNriwBtznK/9
	 L26cbXeiVNiDL8mbj7g33wKtr11hw/dmZBaNmnz56hTe/7XsXqNNUIkNudyy6TTVVI
	 S8BsHrW+AexAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D267E8877C;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix linear mapping checks for non-contiguous memory
 regions
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172253043763.13740.6343182077669512580.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 16:40:37 +0000
References: <20240622114217.2158495-1-stuart.menefy@codasip.com>
In-Reply-To: <20240622114217.2158495-1-stuart.menefy@codasip.com>
To: Stuart Menefy <stuart.menefy@codasip.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 david.mckay@codasip.com, palmerdabbelt@google.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 22 Jun 2024 12:42:16 +0100 you wrote:
> The RISC-V kernel already has checks to ensure that memory which would
> lie outside of the linear mapping is not used. However those checks
> use memory_limit, which is used to implement the mem= kernel command
> line option (to limit the total amount of memory, not its address
> range). When memory is made up of two or more non-contiguous memory
> banks this check is incorrect.
> 
> [...]

Here is the summary with links:
  - riscv: Fix linear mapping checks for non-contiguous memory regions
    https://git.kernel.org/riscv/c/3f4b9eeadb17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




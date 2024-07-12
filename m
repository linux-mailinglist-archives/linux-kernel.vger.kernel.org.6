Return-Path: <linux-kernel+bounces-250522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3657692F8D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673A01C2149A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39CE158A3E;
	Fri, 12 Jul 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HprjVqNK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6410F7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779633; cv=none; b=gfw2CDSAKYkTGv6gTMHcE/UNt3YiPpWcSWIMa0QwEcYrTKGna0utZ8PGExVJaTWmrB7uV/fjJEEcnoCRoiuOYBoRCF/+dg8/hlbL0/uZLR3dqDN5lEAmxcvGT4B2I9CsGagTv/TFa2vU/4lw+NN5Ka5St3mM2vW0RNTQ+B/j1lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779633; c=relaxed/simple;
	bh=saXSXc7EtV5Q2Yrc557rIZq81TgZK3+FXyLIFKgsj6M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HgXVNqvtGnPGgSGEcrCva0uD3XaLcEX32szcGu+kVC/J2zj+SVCjW+qORqBQCVBUgDe3+4oT+GV54a1ypAA0TppnpzARnimXdO1ar2nxRPwXkokmzCBXRDxrrV4ehOoAOSaySZKvRT862+NMIF9MFuk53Fgu+ArE6LpzfPJj0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HprjVqNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 844FBC4AF07;
	Fri, 12 Jul 2024 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720779632;
	bh=saXSXc7EtV5Q2Yrc557rIZq81TgZK3+FXyLIFKgsj6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HprjVqNKWKBnZEqhy9YZNpR8SxioY9YsM0R/jhRIH+Y2VBO4L3qw4NIRbj4rIh/DV
	 i0nWF6kaTkK1AU4pLuiwo8Ad3XiaKG/9qKBIVFOoV08s0pFhEezrE6jcqm4et/jC1J
	 N3yIidI0F5ncopxbLfcZqMiOtoVkfdXeFvPEhoKVaSpw5/JvJvo/5HgSp0BkMryUyO
	 swlFycGc4fVcuTeQX9LDrOqO0f/bB6vuLwsiFOp6qti3Wr2Epk8WKWEdOMuAA12agF
	 MGmimgGkwfaZiOq5eOsbk/ZE8pDDH3kpd8KiBYvuRGu7TMfamDS79z1j2u0CI7HppG
	 Tdxa7gzffkF/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78381C433E9;
	Fri, 12 Jul 2024 10:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] riscv: Optimize crc32 with Zbc extension
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172077963248.4770.592373890802161820.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 10:20:32 +0000
References: <20240621054707.1847548-1-xiao.w.wang@intel.com>
In-Reply-To: <20240621054707.1847548-1-xiao.w.wang@intel.com>
To: Wang@codeaurora.org, Xiao W <xiao.w.wang@intel.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, charlie@rivosinc.com,
 andy.chiu@sifive.com, conor.dooley@microchip.com, greentime.hu@sifive.com,
 ajones@ventanamicro.com, heiko@sntech.de, david.laight@aculab.com,
 haicheng.li@intel.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 21 Jun 2024 13:47:07 +0800 you wrote:
> As suggested by the B-ext spec, the Zbc (carry-less multiplication)
> instructions can be used to accelerate CRC calculations. Currently, the
> crc32 is the most widely used crc function inside kernel, so this patch
> focuses on the optimization of just the crc32 APIs.
> 
> Compared with the current table-lookup based optimization, Zbc based
> optimization can also achieve large stride during CRC calculation loop,
> meantime, it avoids the memory access latency of the table-lookup based
> implementation and it reduces memory footprint.
> 
> [...]

Here is the summary with links:
  - [v5] riscv: Optimize crc32 with Zbc extension
    https://git.kernel.org/riscv/c/a43fe27d6503

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




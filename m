Return-Path: <linux-kernel+bounces-186850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075388CC9EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C1AB21E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10A114F12D;
	Wed, 22 May 2024 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ6yeDJp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB114D29C
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421908; cv=none; b=ufkVBH/xH6EfaoK8GIZCk1Yzn9pMjXF0gtBYUzC8/LjOYYGA3DkSzfcH0azdCGPhl7JOR5blxEecTNvnLQkamDKkazFCWOh5mEgpv+kp1JIwT850mzUzqKp7fz+UPcNajxeblYNFx78RPivOvKgXZO8KEFm0FxcgGV9zca91In8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421908; c=relaxed/simple;
	bh=Nty+d0O2k+tcTQfotqrEHDSwCA3ilUGE7inQCe2W3o8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UrJImT7N9eZ/OMN3qtftOBmgRZiStfPzY06v3VcanRxDbapfn5foFfNLSEpwzw9h4t4pNUCBI8mVUlqrt1f9beNenKoBKtcxc5dp7iwKqU20Vk87MKosTlvg+GKpV0y3xiOGaiIi2Ey9jz2k2WKuPDUGxJvwhh2a6OTIevyj+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ6yeDJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7C00C4AF0C;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716421907;
	bh=Nty+d0O2k+tcTQfotqrEHDSwCA3ilUGE7inQCe2W3o8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eJ6yeDJpb7x/wkFNd67nxJKK7wx+jMvay4iawRRiXNsVYNj970j+MzX2xuGFszMqW
	 1O0K4M9HvcWxvoSaHBSt+ojD8yVfNKiNim163ETs9khkxu45zF7R3AuHD+CDdvrf+h
	 NeXBi2k9LKvuxIyS9E7ie/ALv2xe5Ch/1aNaVCcUAIA+BLe3bSlggJDmDJ3VnSRE52
	 e3Kr37DsFP3a51mEEY3nvzQXTW/2LKZUizTBPNOlIghfpdPLrjcsNV4poUmxN+rwmL
	 W/aWZd4FdHnoTrr5FUF/P93yy9WvcRbksmc3D+2DpXIcNRP8v5KULbee2tn+qav5kr
	 /2Jse6KsKlVgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B99FEC43618;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: uaccess: Relax the threshold for fast path
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642190775.9409.16917538511707082083.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:51:47 +0000
References: <20240313091929.4029960-1-xiao.w.wang@intel.com>
In-Reply-To: <20240313091929.4029960-1-xiao.w.wang@intel.com>
To: Xiao Wang <xiao.w.wang@intel.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, jerry.shih@sifive.com,
 nick.knight@sifive.com, ajones@ventanamicro.com, bjorn@rivosinc.com,
 andy.chiu@sifive.com, viro@zeniv.linux.org.uk, cleger@rivosinc.com,
 alexghiti@rivosinc.com, haicheng.li@intel.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 13 Mar 2024 17:19:29 +0800 you wrote:
> The bytes copy for unaligned head would cover at most SZREG-1 bytes, so
> it's better to set the threshold as >= (SZREG-1 + word_copy stride size)
> which equals to 9*SZREG-1.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/lib/uaccess.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - riscv: uaccess: Relax the threshold for fast path
    https://git.kernel.org/riscv/c/e8c7995ea148

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




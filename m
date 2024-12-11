Return-Path: <linux-kernel+bounces-442278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AB19EDA24
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE7A283055
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B84120B81D;
	Wed, 11 Dec 2024 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvaMCh3E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908020B206
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956384; cv=none; b=unmsnLQMo8wPjoV0iqmbvdMJG1c9Ncsc3vGISi/8ib9TuE+4Nvgp2WFXk7fNPRArMVseo/rEs57etQxe/pVyQOiHdjVtFvedPnv/kQeb7XRMOVPqMFsozRA9jXEV/miZ00lR09uOmTW+PpR4RpQbnDNFATLuktWqmiRj9EEVu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956384; c=relaxed/simple;
	bh=dfkE6O/egkW2YpK2IvJJiv33ml4HlWyuyxOZmVAxw9c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XyEw2zS8wPAXhGkpZ5GyHF4HiF52VZ9Tt4SiDBAzo/2DkC/R/VE84zTH1Zyh1icssl58aw3MNwHsOVneL0txHEQRjt4/2QQ7gi503h9rj8UBGqw/Qla3qSDIGy2aPfbPd2IqXscoRcSP3FpaiJ4S+s5nPpMNmUwZp+Lenm6csI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvaMCh3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B139C4CED2;
	Wed, 11 Dec 2024 22:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956384;
	bh=dfkE6O/egkW2YpK2IvJJiv33ml4HlWyuyxOZmVAxw9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZvaMCh3EMlbzjJV5gz6GKVrjYMFfRsCEB0itM/x4pbq1+of24OYlFqoE5I0JX04Y8
	 W0WxYmXjG+uttUOWn1z8tvw9Wm/4xBI/gF+nIi+hS3jL01gSRT7CaP2RflsUkMOr1V
	 pOj61xt1kvg9nWPVgUq1Ej4SlLJonIisLTBdxm750YWAmRzm2onP7af9scPO30Jeak
	 iNvIihIP4CoD7N29Vqx89SWkRaPFvnkSXPDfRpYh212GYyEfkuaBYFF6rNte+nft8q
	 11wKmGfUABzhnUIzm3vDt6oYIEYNyGg2X4uIkYrjjawlifbrdRROY72L+y2a1joTB/
	 rTyJykfYjrFHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB0380A965;
	Wed, 11 Dec 2024 22:33:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Fix wrong usage of __pa() on a fixmap address
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395640024.1729195.13342843889585643305.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:20 +0000
References: <20241209074508.53037-1-alexghiti@rivosinc.com>
In-Reply-To: <20241209074508.53037-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, usamaarif642@gmail.com,
 robh@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  9 Dec 2024 08:45:08 +0100 you wrote:
> riscv uses fixmap addresses to map the dtb so we can't use __pa() which
> is reserved for linear mapping addresses.
> 
> Fixes: b2473a359763 ("of/fdt: add dt_phys arg to early_init_dt_scan and early_init_dt_verify")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [-fixes] riscv: Fix wrong usage of __pa() on a fixmap address
    https://git.kernel.org/riscv/c/c796e1872012

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




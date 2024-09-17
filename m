Return-Path: <linux-kernel+bounces-331725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F3D97B07C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25ED28A5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F04171E7C;
	Tue, 17 Sep 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDBXtYUK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126E4189506
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578053; cv=none; b=B9W9JecDGB3coeZkvmWJnTyMNMIz3zXA/Sn/tYEBfT/mryD+2WwkT2NkdbRsAoP/FEMEFVmJhFS9pUuIkyTZK80t/UoW8pmoMkS9UdpFI++jaq10jhUWik8fx+0FxUi8mJVsYZ7AXmF8mk8EXmpyGG80c6IIR3x9THsoPwraHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578053; c=relaxed/simple;
	bh=vXbeplZ1G+0wcjdO+vuH1yzCOpOfz/gAnMMvX2K1kVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rJa9W69TZG3SGWmyv+pbBezWrvCI5OGX9cu7Qn+gPZYSLpG7rH1D+IRMC3g5YvCnneeSB4uDigPCYjfMATAgmg1D0Q82m4Tspbxhv1kJ8d6KGEwRTHOA023kVd6Od3XLJphvGG2hO7iQ74KCrmnefqsZ/Kng98rz4u8TOSj6V5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDBXtYUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84666C4CECD;
	Tue, 17 Sep 2024 13:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726578052;
	bh=vXbeplZ1G+0wcjdO+vuH1yzCOpOfz/gAnMMvX2K1kVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jDBXtYUKDn6g8wSi+jxcozb/3cjhSUlghGet4AO8qeQauW/h73U58CHDG+TJma6Aw
	 0PJetWr09JZhIuWAKsOtn8sHNOJ8rhbAp2sQfzJ+uqX1GFMZ0Z8pj8sW6GAffns1MB
	 AQ4JG+ra6oFPzR+HpSDXSyoQMYwKd2ItzJVm333Eafx2Bzpvd4Ght88aoByYogqoES
	 dctkPDU1ZWpFeUNRVbXYpt8CeUHhHl0usRnTfJAEoxelX+ahJRlAvUrfnCu5XNkOcs
	 DsfbTbWhlWZ4BEK2zc6H+0Xlzjp156F6n5A5xgzqLg01T2UxTCbs6vCisAakigUeCF
	 bPsH/x/V/X7Wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2A3809A80;
	Tue, 17 Sep 2024 13:00:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: avoid Imbalance in RAS
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172657805400.126252.7167871737849732377.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 13:00:54 +0000
References: <20240720170659.1522-1-jszhang@kernel.org>
In-Reply-To: <20240720170659.1522-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 cyrilbur@tenstorrent.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 21 Jul 2024 01:06:59 +0800 you wrote:
> Inspired by[1], modify the code to remove the code of modifying ra to
> avoid imbalance RAS (return address stack) which may lead to incorret
> predictions on return.
> 
> Link: https://lore.kernel.org/linux-riscv/20240607061335.2197383-1-cyrilbur@tenstorrent.com/ [1]
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Cyril Bur <cyrilbur@tenstorrent.com>
> 
> [...]

Here is the summary with links:
  - [v2] riscv: avoid Imbalance in RAS
    https://git.kernel.org/riscv/c/8f1534e74403

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-513710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043E8A34DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886ED3A198E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E424503A;
	Thu, 13 Feb 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/9jAXLy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEBF245021
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471407; cv=none; b=HPIeN8gSQJ308Ngx0EenvS6tgFdoErCFxgJYFvYNlDn4zyaSBrpmfbPef62XQIqc5I48oqF5vC/Sx0977EwHS4R81PBM2WXQ8RN625SW5gu3t77ApJlyBn4ymY/i3dbhKsJME5ccNprgJ8ZTnBvfjiyjWwkPLAEY+faNo0p5vU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471407; c=relaxed/simple;
	bh=Dc2ONtrEad7VUfPnbx8Z1lbE94xlzKmO3OKnmanOGUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZMvUJK2xpIALB4KkYFxvMlfq8CP6ud6xOIIa9bQn5bKmGs6ui443xV8uOU0QHEuHiLaRbcZH6/Z0E1lbBt8UDUSq3sPeiiIGDrsq5DLgk8lTvWd3ZGJt+vhIS6dgR4Vka0g5LL+kvcG9GNR9tTUDlfkHYxnasJxh48lrlV+iHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/9jAXLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415BEC4CED1;
	Thu, 13 Feb 2025 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739471407;
	bh=Dc2ONtrEad7VUfPnbx8Z1lbE94xlzKmO3OKnmanOGUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t/9jAXLyFju5/kd+yyT6UK3Gntxc+xl5wCzAhIIG1mNUWx/bw0wa9kAFk5VBvN9JH
	 MDniw5yXH2LqItHhyPJUiB2mN+HM2GG1jOjDZjJJSgywX5mehQ5/Dqy1w36agKVFxA
	 AzjL3KApDmcag1P+SV7nFDICwrnU0trGvfjJ1FliRXnTrLH2zSi6MSVpAEiPa5QJxZ
	 WyPy01SbZrkO397hZVZsh6I6Ol0ljH7/M07z+cFjdJeNmO/pwf76LoGFep5eHfh52T
	 rG7DSgo5TmPEGipx2uPykkJSdUrArdS1dwoReVgl2sCd7fNP0NqjBU1JrLVxUGXvIH
	 7kiKQtGu3FxZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE666380CEEF;
	Thu, 13 Feb 2025 18:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: cpufeature: use bitmap_equal() instead of memcmp()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173947143640.1330575.1576531241025844653.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 18:30:36 +0000
References: <20250210155615.1545738-1-cleger@rivosinc.com>
In-Reply-To: <20250210155615.1545738-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, linux-kernel@vger.kernel.org, conor@kernel.org,
 alexghiti@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 10 Feb 2025 16:56:14 +0100 you wrote:
> Comparison of bitmaps should be done using bitmap_equal(), not memcmp(),
> use the former one to compare isa bitmaps.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - riscv: cpufeature: use bitmap_equal() instead of memcmp()
    https://git.kernel.org/riscv/c/1508ead3d229

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




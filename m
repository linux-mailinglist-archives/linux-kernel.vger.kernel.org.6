Return-Path: <linux-kernel+bounces-186847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6300F8CC9ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00E48B22841
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D3314F12C;
	Wed, 22 May 2024 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY3Cpmni"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE4014D28B
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421908; cv=none; b=FZURcyvmbs05/dH3oP8ah8lPL+DmXeWtYfhAvARSm+aUBjwXEUvr65tGFR3omubgik7DxT4R+45r/LdwXqo65YAomcUCXgFaGXs3CLADSMYoN5C+Mefzd2liBo1t5XkIEbA645wmTWmpdTyoSlux/iK1uQa1VKXJEP1CYL2OGZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421908; c=relaxed/simple;
	bh=gqLUb9QwFmSI9zsPRr9h3j96reicOIQtoFbQZ+xpT4c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nKFTMy51koiUjArj3e4/r4cnu4X6nMGUrXdNzVw3FRNNTsUmh1RI4FpXy8x66SkzkKbyvlAr1TVHkai66DlvACe6KdM8z/SFt4x9pvSKYLWX/1TCAuh9sP55WE/X8cetYZVkDo3C3VEqA8KklnBLRkFJmjcm4mEYK0i+y72Fr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY3Cpmni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7C3EC4AF12;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716421907;
	bh=gqLUb9QwFmSI9zsPRr9h3j96reicOIQtoFbQZ+xpT4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kY3CpmniW4Xo04BbXZBNVtdDiX3zJFaVbuN7sRGtSwXGiPwZ/iO0HAQ+wqA307T2M
	 sf8ing+ScWnGv/es/7MrZWsgs7DOPB8gOEFRzVW60YtPXR60VdNg8zYV+K9nOzCSer
	 atj6e+cp87MEQP8vbJDBleLys/l0ItejflIL2t4R7NfcR/pOLZSDnlZcYbUpulHWTM
	 faLgH3UnsWWbS/eyh0vGTpgFrv7CrmaXNXlh8KRQQlKJWOdbKc+eV01S2BnOQWgmZl
	 q8iVdBpj7cLrOq3JT2X9R0g3RHE0A8BfzH5NZE0Yp3wb/24SPZIBGK873LwcVotaGK
	 P3KNTxnPeYEHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCE91C43638;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Use bool value in set_cpu_online()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642190790.9409.1797871952115228181.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:51:47 +0000
References: <20240318065404.123668-1-ke.zhao@shingroup.cn>
In-Reply-To: <20240318065404.123668-1-ke.zhao@shingroup.cn>
To: Zhao Ke <ke.zhao@shingroup.cn>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, dawei.li@shingroup.cn,
 shenghui.qu@shingroup.cn

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 18 Mar 2024 14:54:04 +0800 you wrote:
> The declaration of set_cpu_online() takes a bool value. So replace
> int here to make it consistent with the declaration.
> 
> Signed-off-by: Zhao Ke <ke.zhao@shingroup.cn>
> ---
>  arch/riscv/kernel/smpboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Use bool value in set_cpu_online()
    https://git.kernel.org/riscv/c/07f23286451d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




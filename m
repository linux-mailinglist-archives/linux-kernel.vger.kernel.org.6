Return-Path: <linux-kernel+bounces-186849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ED28CC9EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB124B221F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CB914F12A;
	Wed, 22 May 2024 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbmiGK1u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66314D29B
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421908; cv=none; b=b4jeCniVNvXt+f1fTh2LrEYkmt6KzTtz4IS80KaM4rh8jPK7tE/ccGUTgPMeOlj2kTzNEmpDvDur5NzqgopgbyfOJEMVw+3nY3THyNAUaspAbn0LlWcGmfyYBuiIdxFauKx+5Sok1vfILJZRuKDd369f2rmRBSeUkyQeLz30q5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421908; c=relaxed/simple;
	bh=n9A8B2bi1boYYZUvXlGtFezy2ShJanph4rjH8GXQdoA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=afowRudNxMPFBtn2rTq+QzY3r2CRoo8BWRU44VOjHKILfRqyRPEUpVKsvxNvy2M4qJE0pixevjvGeKXNSgZmxaopJepQqTI6y+x7zTAuE+eg8kO+FzMIzsyyRoPgdfssn9AKh6NxELkaCx5OaNYoVGr6HxzlWxtbi14ixbcAQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbmiGK1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD314C4AF10;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716421907;
	bh=n9A8B2bi1boYYZUvXlGtFezy2ShJanph4rjH8GXQdoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rbmiGK1u/ss/abz9OJF4XgUBvyZvlMriaHA12q4Ru1tBpxNiObC7nvN+jkcz5MlkI
	 lLACip46Q71mta/ConRPspZkpppHTyAGCHWZQ/1lDYmdmpEaDp9bAX0LzgAN1HyLHc
	 iMocukrXukSwUa0u6ruWOgEvWT6pzrT48ucfSoS99kqjmm22fbjcKlsehGmS5kaaEg
	 fFNlQ6Ynj+IX+9GCo2/Cdlas7cn2dpIZU+xh+/wC/kGw9Ety/V9rsMoNTEXHsXAVLp
	 6F6OkoR2Vbth821mLFGpoJtbYOxw/kVnBUWOKWpy7dCIxyZOjWtl6EZKZEmt3iT8Fx
	 wH5C5iiFc4mNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1A5FC43619;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: uaccess: Allow the last potential unrolled copy
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642190785.9409.1593588970269968258.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:51:47 +0000
References: <20240313103334.4036554-1-xiao.w.wang@intel.com>
In-Reply-To: <20240313103334.4036554-1-xiao.w.wang@intel.com>
To: Xiao Wang <xiao.w.wang@intel.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, jerry.shih@sifive.com,
 nick.knight@sifive.com, ajones@ventanamicro.com, bjorn@rivosinc.com,
 andy.chiu@sifive.com, viro@zeniv.linux.org.uk, cleger@rivosinc.com,
 alexghiti@rivosinc.com, haicheng.li@intel.com, akira.tsukamoto@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 13 Mar 2024 18:33:34 +0800 you wrote:
> When the dst buffer pointer points to the last accessible aligned addr, we
> could still run another iteration of unrolled copy.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/lib/uaccess.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - riscv: uaccess: Allow the last potential unrolled copy
    https://git.kernel.org/riscv/c/74362d66a416

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-513715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EDFA34DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C515C188F84C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F924A078;
	Thu, 13 Feb 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raI6eUC3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2370B245033
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471414; cv=none; b=BKRAjK3A+6BWs8aFlMaXwSxyqUgEuRqpC/FkKffAbrzN5Iw6bwUHXHet3gjUh7si1weIQ+d1e6GsPv0VH2/eyMpaqFM+DtkjXTMiBTyVDo2G8sWq++GrdsTR4Us0spc4+6pGwp82YCAJtC5SVxjZ42I0CwXFD2FFSmON+FkxHAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471414; c=relaxed/simple;
	bh=LbJsYBJf8L7DxxyGxGKNRl8qtKpCXI3bcWDOVFwM90o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V32tzRrLFJxtcHsoeC+OfDAwCWghLx7VTOKR8UChGFMO1XcfVPgk3spW4R4ysVVRs2nCFZNT+AlPp9IF/qNMTEyC4H910nTxDXx8SxV4ZN9CUmyOH61bLGFtAjdP7676md6fEVsIYQFdnrehoZqOVOAroe86z4LQA9gRjxDRiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raI6eUC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF95C4CED1;
	Thu, 13 Feb 2025 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739471414;
	bh=LbJsYBJf8L7DxxyGxGKNRl8qtKpCXI3bcWDOVFwM90o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=raI6eUC3hk1EOIYdriSkOYSsyVIHfIQU54wKk+5d/JOH1+XbNKiMwLYlgrkR1e8af
	 1vE3W0RP7KG4Sc3ynWEVQWmblFK82eTURqrYOBbt0IWq6toebsqwR6ezVSyfcQrOLK
	 vX/gHHAOFUkh9vIO67CLL+foZlpXRfero1qvFGmBQsFhqTaeyWu9knpaIuCAxFdkeD
	 GD4TgSJ2J5Hkr0QhiU8aJ91HvrSxyy1H2TpZj32ZBAcslDALng3tK5D3daYSCxmTtU
	 jPkERF2mps28ThQKIslys4xgLfT8ZwnP7Je2WH4bsORza2NioETZ1BiFMuPqYw2j9o
	 97x+HfYaaZdfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C94380CEEF;
	Thu, 13 Feb 2025 18:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv/atomic: Do proper sign extension also for unsigned in
 arch_cmpxchg
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173947144300.1330575.4364486946556377842.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 18:30:43 +0000
References: <mvmed0k4prh.fsf@suse.de>
In-Reply-To: <mvmed0k4prh.fsf@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 30 Jan 2025 10:25:38 +0100 you wrote:
> Sign extend also an unsigned compare value to match what lr.w is doing.
> Otherwise try_cmpxchg may spuriously return true when used on a u32 value
> that has the sign bit set, as it happens often in inode_set_ctime_current.
> 
> Do this in three conversion steps.  The first conversion to long is needed
> to avoid a -Wpointer-to-int-cast warning when arch_cmpxchg is used with a
> pointer type.  Then convert to int and back to long to always sign extend
> the 32-bit value to 64-bit.
> 
> [...]

Here is the summary with links:
  - riscv/atomic: Do proper sign extension also for unsigned in arch_cmpxchg
    https://git.kernel.org/riscv/c/431a3bbd3249

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




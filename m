Return-Path: <linux-kernel+bounces-271640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F5F9450FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868E2289759
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E763C1BE233;
	Thu,  1 Aug 2024 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGIHvkW9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDC1BC066
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530438; cv=none; b=gkbGiH7xyCmkEgjx7upswe+0eGXxXNv2dXivTvfsqqKuZYzc2kWlIZuJx/iArwmloqHbYoZtFKd33BVoZr2kJuI7oYhC1pzeFz52bmtfvia34DBdqtEwJJTl2e21T/6n96ILjOz7odD1aYeWnrlAwBwCnVmG8vmO+Pvl50P/rrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530438; c=relaxed/simple;
	bh=Qf7CsUZ7Mp3HUtb2ngmsj4kwcF27UTC845pBKzaaids=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QnJOmxAEIVEhVmxNCFlWscznibVv+V1H5CnIsNqo0QaNRxBN4K0nSkfafhCFpdL6JQTzUhK3FAirWW7tdTDvJDWRau3DwcSwUYqevxrUXqK3KpSm/rhqV20quDcamzZ6DO34Yeg/rKIYrQN8HrMN8U5WEt07hD9xdsD90PGJgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGIHvkW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3824C32786;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722530438;
	bh=Qf7CsUZ7Mp3HUtb2ngmsj4kwcF27UTC845pBKzaaids=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VGIHvkW9pm4tSmx6J5sp7tQHJlJVPsD1h3vPy5N/Nja9Va9NQZbPXUbS/SmN3oQ1/
	 52v+14H02XzrEEK3jYk84UGohxTLTG3wZVdee4cd3KREyJh4iEM2LAy5PpH4PewKTg
	 m3iCvKTkpTN5mYmnuwhGpsX0S3hG1BT5ob9sYm20wNJ+DQW6AMsPUf+GRCFHpdMBmr
	 sUOFJrsjDROJQQMeOHkmtoyufG2H9+eGptiT8QNH+GyURI2SCZvvem+o0GjbPrg6yu
	 wU2Ik0fnfzpv/qp+aFxUPFWq/6Nvz/hGlh0lJnc4nfYjkMIGBbPGxqW23o8i7m2B02
	 UsJDIGQ9gn49Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7E05E8877A;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] RISC-V: Enable the IPI before workqueue_online_cpu()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172253043788.13740.11553891732223082482.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 16:40:37 +0000
References: <20240717031714.1946036-1-nick.hu@sifive.com>
In-Reply-To: <20240717031714.1946036-1-nick.hu@sifive.com>
To: Nick Hu <nick.hu@sifive.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@linutronix.de,
 peterz@infradead.org, anup@brainfault.org, samuel.holland@sifive.com,
 tj@kernel.org, alexghiti@rivosinc.com, linux-kernel@vger.kernel.org,
 greentime.hu@sifive.com, zong.li@sifive.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 17 Jul 2024 11:17:14 +0800 you wrote:
> Sometimes the hotplug cpu stalls at the arch_cpu_idle() for a while after
> workqueue_online_cpu(). When cpu stalls at the idle loop, the reschedule
> IPI is pending. However the enable bit is not enabled yet so the cpu stalls
> at WFI until watchdog timeout. Therefore enable the IPI before the
> workqueue_online_cpu() to fix the issue.
> 
> Fixes: 63c5484e7495 ("workqueue: Add multiple affinity scopes and interface to select them")
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> 
> [...]

Here is the summary with links:
  - [v2] RISC-V: Enable the IPI before workqueue_online_cpu()
    https://git.kernel.org/riscv/c/3908ba2e0b24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




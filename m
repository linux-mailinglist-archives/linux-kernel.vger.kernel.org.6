Return-Path: <linux-kernel+bounces-364900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E95A99DAC4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D11282292
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99341CAAC;
	Tue, 15 Oct 2024 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdgaCHxl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA85208D7;
	Tue, 15 Oct 2024 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952825; cv=none; b=i2dIgNl+aUWqij9NGCNLLoqQddlmiJxCZ13difcI8kqgWeEAm5vuAXKMPWgdh8ol3mpNIsZjuIxibIfMKjJHi52kzP2bs1LUKzndKKCHviCveBkrjiUc1iK3zuSOfgmTjFq7e22DWDTiV/fXglgQcSyqq3GgGZcG32om8GhvbZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952825; c=relaxed/simple;
	bh=Y3WHEJhJTnVp827nFuDhpgW9lFFF44RLvEnecnnrrSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EtY5WWqo2ojQfZG7fWveeEHG7vbMwFgKk9a111W4+/Dtybz/u3tZzDm2nhuyiV5pDpPERU8NPav03tgULpbvaXmHU8xY73DGJCVVcUjVx+0Xz6/osfNIpkcrQPXQMiQ6S0nB6c/zxMKVZPAV4jXGH7D6n/m5I2/do4u9SEU9pj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdgaCHxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C04C4CEC3;
	Tue, 15 Oct 2024 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728952824;
	bh=Y3WHEJhJTnVp827nFuDhpgW9lFFF44RLvEnecnnrrSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CdgaCHxloVXDaPpj1QckRoSudrblNAtqwp0z6vupX0lZWGaU3fFymIOOJ/4IkUsTs
	 saxNX9zMApcvXCF4tLanoDjHY4pRK4iy2jF37SPbKB+M7upgNWBETQkQZ/g5TAa8lD
	 e6XPhXHn+8bArFx86FZ8IV9Ed5y8GoHEbJaGjG34DMc3/0ZayHuw85wDkrl2q5KIO6
	 6Ih18AiLyI/tVPbNPX8P0Ljqf3x3XiQuH/rss5v5taZiCEck36CF/Y8VnHeDgiMbE+
	 bGYZOrB+iyt71k9hGItCVN1aEkVZAgt80pXgUSpdTEccrWVy7lc3i6mU9TD+Hj7Dw+
	 HNh17MilDe/wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE643822E4C;
	Tue, 15 Oct 2024 00:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 RESEND 0/2] posix-clock: Fix missing timespec64 check for
 PTP clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172895282976.680495.6568156161893701300.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 00:40:29 +0000
References: <20241009072302.1754567-1-ruanjinjie@huawei.com>
In-Reply-To: <20241009072302.1754567-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, richardcochran@gmail.com,
 johnstul@us.ibm.com, UNGLinuxDriver@microchip.com, jstultz@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Oct 2024 15:23:00 +0800 you wrote:
> Check timespec64 in pc_clock_settime() for PTP clock as
> the man manual of clock_settime() said.
> 
> Changes in v5 resend:
> - Add Acked-by.
> - Also Cc John Stultz.
> 
> [...]

Here is the summary with links:
  - [v5,RESEND,1/2] posix-clock: Fix missing timespec64 check in pc_clock_settime()
    https://git.kernel.org/netdev/net/c/d8794ac20a29
  - [v5,RESEND,2/2] net: lan743x: Remove duplicate check
    https://git.kernel.org/netdev/net/c/ea531dc66e27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




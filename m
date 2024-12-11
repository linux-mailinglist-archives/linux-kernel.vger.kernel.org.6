Return-Path: <linux-kernel+bounces-442246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDFD9ED9BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B2E1881FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05171E9B3E;
	Wed, 11 Dec 2024 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTGqiXy5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB4172767
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956332; cv=none; b=Na6jEx7i9G5T+l3zgcQmzH9y0AmBD2xsBregPDH2BZc4gDb96Bdjey0A43v+xpT1KSwjPRNpN28yroD9Fz3jEHeyIFEA6Qm4djL9nR/Jeyr0lpklhUQNNQU12a1PfxcDFkKCLsxE/YO0efj2hVNsLmhnZwm0yTioLzKsJJFDnEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956332; c=relaxed/simple;
	bh=YitCwK6c+33A6aC+Ygx3OE8d+hQaCuKW3MFcVWF5360=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sDJ4oOU8M7Xhjn41ASMwT6SQHmsCgo7G6yFLG++Bu33niSwITWVRWNzuUhBQOfyvb95B0DOpO6+eHhYHK83xyHJyO/ex64dIC285YTJE6HpOYCPBOc889EDUigIHtr8XMQ6mwKmC2+aQxElaM2KSgVjJ1Ic+ow3tMJxACV+I9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTGqiXy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4454C4CED2;
	Wed, 11 Dec 2024 22:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956331;
	bh=YitCwK6c+33A6aC+Ygx3OE8d+hQaCuKW3MFcVWF5360=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uTGqiXy5bmDgJRGblbXGYidOuhp/B6l9GzJ5CwQc4h89NX0dFGFGNGyNrA8ShzB6y
	 6RT8dcqVEw1SsssusH27Ml7A/KryBQEuPfbJznOp52WKzE3alcSxFUgeDHI8F+rLT6
	 wOkne/dlATfk7333bXBjysUA4stsIyDnFqEBWD43Zf99ZlO9R+UFvENwVkvjZ5wODH
	 ieN7Jx5cicu9C5le0ZhyMjXourWjhhtmOTo0SNsx0j0kXX13WP5DXXcwfH/S00gJ/Z
	 YA7d3n3kTWyNNmmwcDdmI+4a6g2nIBHa42LyNOefUddswo6iSqQ/jsEWK6u2acokTI
	 BPXSJf66CMZlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFD5380A965;
	Wed, 11 Dec 2024 22:32:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] irqchip/sifive-plic: Make use of __assign_bit() API
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395634775.1729195.14916770545645743784.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:27 +0000
References: <20240902130824.2878644-1-lihongbo22@huawei.com>
In-Reply-To: <20240902130824.2878644-1-lihongbo22@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-riscv@lists.infradead.org, tglx@linutronix.de,
 paul.walmsley@sifive.com, samuel.holland@sifive.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Thomas Gleixner <tglx@linutronix.de>:

On Mon, 2 Sep 2024 21:08:24 +0800 you wrote:
> We have for some time the __assign_bit() API to replace
> open coded
>     if (foo)
>         __set_bit(n, bar);
>     else
>         __clear_bit(n, bar);
> 
> [...]

Here is the summary with links:
  - [-next] irqchip/sifive-plic: Make use of __assign_bit() API
    https://git.kernel.org/riscv/c/40d7af5375a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




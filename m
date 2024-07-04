Return-Path: <linux-kernel+bounces-241086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F709276EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F0B1C22077
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14B81AED54;
	Thu,  4 Jul 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo2jZkvc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949E1AD9DE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098657; cv=none; b=MOSwK8SnFMZVaPeiIaa+JfbEewgPSRTQEwy3oefIULdzp177KicjDGUbIbOhaEyIJX7Q2RUKaY2aZDfFrX/ZTaiwuyGZPKf9S68i2/qcblJK6ldSkh5M9Z9SSn0il+7gvOPxoA24rpgR2SWdsYFq5ax7yg3h5GbZg7KrXh4OBIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098657; c=relaxed/simple;
	bh=d1R6VyIbkJ6U7w801EO8l21bk3qkW3imoEOlfi6mJ0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GQXAWzKzy9KE1dNCyvhRYqQXQcA79vBgR/qWuPbgHRai/QCHGXYdzit+LXHLdcRwmQcSCczRHZuV3eoMzi69ABcJs1KOfzlYnK1yCGtAacSejItg+YdPborDkM/auKp5e5immdZHGBVQQoFSjLDowmPC4V0OaeTsw9ZidupcJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo2jZkvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB4A9C4AF0C;
	Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720098656;
	bh=d1R6VyIbkJ6U7w801EO8l21bk3qkW3imoEOlfi6mJ0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fo2jZkvcZSDt1fGr5ZrtsubKDg0lm7xDjMC9jQnY4iYDYlIxVv8JLu59v3NRhkhb3
	 +31IvMoMqRPLlLD5TnKhcbpCo+WEl+FmkFY3ULZtIzz0lmwEu8T+L/OkXcGagr4DYd
	 CsoqzJteqGJOKYigMc5UDq+YNWx+UgHY9sVD08nqjFvsweG2GUZ4gRb5AGXYlvkorr
	 g254OZ7RieYGkdAlQPCGpbG61KIRqBnBqZuq/bicQ9M4WMOnl//qrOUT1t9sCRdq08
	 KHsOzteSG9RJ7k1Uhhha9F5VoIwT2QOUpQQ+mj2gwc9CdFhS3nzsXh5VWho1I3KNVl
	 y1rXL7FyCDNZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9FA3C43331;
	Thu,  4 Jul 2024 13:10:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 -fixes] riscv: kexec: Avoid deadlock in kexec crash path
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172009865675.17306.18375440466203340384.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 13:10:56 +0000
References: <20240626023316.539971-1-songshuaishuai@tinylab.org>
In-Reply-To: <20240626023316.539971-1-songshuaishuai@tinylab.org>
To: Song Shuai <songshuaishuai@tinylab.org>
Cc: linux-riscv@lists.infradead.org, takakura@valinux.co.jp, alex@ghiti.fr,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 bhe@redhat.com, akpm@linux-foundation.org, guoren@kernel.org,
 xianting.tian@linux.alibaba.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 26 Jun 2024 10:33:16 +0800 you wrote:
> If the kexec crash code is called in the interrupt context, the
> machine_kexec_mask_interrupts() function will trigger a deadlock while
> trying to acquire the irqdesc spinlock and then deactivate irqchip in
> irq_set_irqchip_state() function.
> 
> Unlike arm64, riscv only requires irq_eoi handler to complete EOI and
> keeping irq_set_irqchip_state() will only leave this possible deadlock
> without any use. So we simply remove it.
> 
> [...]

Here is the summary with links:
  - [V2,-fixes] riscv: kexec: Avoid deadlock in kexec crash path
    https://git.kernel.org/riscv/c/c562ba719df5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




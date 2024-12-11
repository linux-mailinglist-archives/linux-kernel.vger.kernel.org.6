Return-Path: <linux-kernel+bounces-442270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE39EDA10
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321EA1638AC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4597420626B;
	Wed, 11 Dec 2024 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOONck9Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD121F2C53;
	Wed, 11 Dec 2024 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956370; cv=none; b=SMOUDJAoTuuHrDRvXZtiITfc2nqgTAu8m9/i1UsBFITrL1JaXMRTbkr9AB3T3egFHTQHcSPByMqhdXvAXF7H1DV2acPbLQ/H8qZ4NbhLvjXfpsjg1IEdvR47xo4ZPj10f1Nu3otiNbdF3vOhrlZ7NCDD+qN5t+p2tSwkn7mR004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956370; c=relaxed/simple;
	bh=HsV2hgf0fbYGgHmLxzKHUU+rPda90YFsJKEFrTRZGjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nKBVoQvoC5p3eeby4Qo8gg/D4wYk2kmACIH10fywT+OFfuPu+LeC1tGnBGh2G//OHwkKNpj9NWiMvcofR4jUhTHbkcQPKbQ1rgElVJBvtOdkew17bpej2ULNHRF/pN6D2l4fup2dra8Ofs6TzlTnnAllGEZSHVNZdfjsuCmeQYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOONck9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF38C4CEDD;
	Wed, 11 Dec 2024 22:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956370;
	bh=HsV2hgf0fbYGgHmLxzKHUU+rPda90YFsJKEFrTRZGjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vOONck9QSCmGFAHL/+qROtp77YjI5J4I/SNx0ir3wUFq4T7bxTbb2voI8ut/Ww9hs
	 umsbLAHyc22326U3EC8FWHJ3RCF4ulGvVPT8unOrZjZcpbnYzq8lhQ8KZU/C75OtUl
	 TO35ohplFrGjkcnKUJpkMytFDmtP45NC6yfOPGcqz1mXjqA+0VDaJ219FdT3oRfhjQ
	 +iTuIQURyuJN/K99Xa7QwlpMG5dyEGecunWyNHIBydjo4JIfHZWyknpdRE7t11ztmj
	 /DFlKfV5HP6jQUF0INgFoLP6GW3gvNPKM3C4afp9/wcwEriIMhkxgMsNY64t5aAjCO
	 +zJCDNgxMnL1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710F2380A965;
	Wed, 11 Dec 2024 22:33:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] firmware: Switch back to struct platform_driver::remove()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395638610.1729195.7835904976463124425.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:06 +0000
References: <36974feb6035201d53384557259ec72fe311053b.1731397962.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <36974feb6035201d53384557259ec72fe311053b.1731397962.git.u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, sudeep.holla@arm.com,
 cristian.marussi@arm.com, tzungbi@kernel.org, briannorris@chromium.org,
 jwerner@chromium.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, conor.dooley@microchip.com,
 daire.mcnamara@microchip.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, somlo@cmu.edu, mst@redhat.com,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 dinguyen@kernel.org, michal.simek@amd.com, gregkh@linuxfoundation.org,
 wahrenst@gmx.net, laurent.pinchart@ideasonboard.com,
 jay.buddhabhatti@amd.com, ronak.jain@amd.com, radhey.shyam.pandey@amd.com,
 praveen.teja.kundanala@amd.com, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev, imx@lists.linux.dev,
 linux-mediatek@lists.infradead.org, qemu-devel@nongnu.org,
 linux-rpi-kernel@lists.infradead.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Tue, 12 Nov 2024 09:35:20 +0100 you wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/firmware to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> [...]

Here is the summary with links:
  - firmware: Switch back to struct platform_driver::remove()
    https://git.kernel.org/riscv/c/5770e9f237b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




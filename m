Return-Path: <linux-kernel+bounces-285072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D0C9508DA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E79EB24A87
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FD21A2C34;
	Tue, 13 Aug 2024 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q00kgZGs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7C1A2C09;
	Tue, 13 Aug 2024 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562382; cv=none; b=IRXka7wrvokECBe+ZQeqO+qTBjQxnkoFgwfAmrUAeJBgavECDYJ3ceKefDXUAn+libPKSnb+FJxklX+ZXF+dd5Xo4HYW8DNl9WTUcOSOOmi6VpijxrXzOtCQVi6/E84Bz6yUXbDGWi0Iqwlcl9wpzNcGPfaFDeimKod0n1FUo0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562382; c=relaxed/simple;
	bh=rsziEHP/+mLvNBlOON3UZ6Yo3R/yAwQ9GkBwk8w8g5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B4NaHywp69Utgl9nwsM36BVNJtiGoOrXLDJqrQjeC++2CARGmP6R/MOr5hYw0WF3sHrLTLFXQR0mq3pZH2lJfkeuSSQikyN6c7YIwZku4yh0Rt776m40RBXKM/ePOxwNOVkrtJZPiW/CqaFlLZRuUf/CGYvYMDEF+jXqp1MvFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q00kgZGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE917C4AF0B;
	Tue, 13 Aug 2024 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723562380;
	bh=rsziEHP/+mLvNBlOON3UZ6Yo3R/yAwQ9GkBwk8w8g5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q00kgZGsYj1y49e049T5MON3QZYB+/8iHm5YTS91WCfUPee3QTbjwW084sff0BMjh
	 Rkjai0s/iXiwYdag9p22P3EpXE/WHPNEPnm55ebFnys54yi5/4RPQXoejp5kfHIFqC
	 VBfMSuUT66Ne6wO5p3aGrMKp2quIxTvDUfn7ddmqPkRwyrJbt+ccwGowqK6tfaC88X
	 A/MtN9JDFHzNi2FLFDh3fK7CbafpITHEPHz/+Qn7UU7XDFcI6LjTE0nWYw+4J2Nv6H
	 88goqr9I+pM/kTYDGJ7/zNWHieaPfrDNPbQ78G3rgHrFIyXNoc3EO08RtLjuX1RqX6
	 a74niExdX3mKQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com, 
 Basavaraj.Hiregoudar@amd.com, venkataprasad.potturu@amd.com, 
 Syed.SabaKareem@amd.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, sound-open-firmware@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240813080850.3107409-1-Vijendar.Mukunda@amd.com>
References: <20240813080850.3107409-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: add legacy driver support for ACP7.1
 based platforms
Message-Id: <172356237845.72636.13426868316582938253.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 16:19:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 13 Aug 2024 13:38:50 +0530, Vijendar Mukunda wrote:
> Add acp pci driver and machine driver changes for ACP7.1 based platforms
> for legacy stack.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: add legacy driver support for ACP7.1 based platforms
      commit: c6f3abbbdc99930f831d5c76dac32ddbd9b88fa1

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark



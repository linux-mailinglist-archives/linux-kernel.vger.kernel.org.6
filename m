Return-Path: <linux-kernel+bounces-372161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E979A452B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B7728331C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5B22040B9;
	Fri, 18 Oct 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWbgSpO4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5741B204082;
	Fri, 18 Oct 2024 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273419; cv=none; b=WJCcIkD8U/sn85cmDgxBgXpE1PlRyLjCo3HLngTjVN5qivLn/YnjNx4YEbg3uPnWg/ZlTSI5AMYwhu1n7nXwYS0tLoz7YOuyRtBcG8XOEV5Ch19Twxmnb/djUi4cXUoMyIEF99q8tZhrE4kklmgAoOOX+impRTewC5pFkMCv+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273419; c=relaxed/simple;
	bh=3nfDO35UF/KZrf+NksVV0gTfDFwAeOtt32taPoRnlIc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IK0a36ctw2O0+L/upsb/2Czo5CIYlL11htdhSgUrd1ftjkhx6VpGC43NgWu2HoFGMkd3tJOuc/pJnn4ehRS+R3Cu8KBvHunZJgGm4wCL7SX22cujxwpCTA57NaxkukuWdD2VtlBPNvum8XVv3n79Hbp6BVnb0tSeUY3dCgymva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWbgSpO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6E3C4CEC5;
	Fri, 18 Oct 2024 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273419;
	bh=3nfDO35UF/KZrf+NksVV0gTfDFwAeOtt32taPoRnlIc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PWbgSpO4HNCI1yeN0i8TFL2gN+OWULu6RWkIVvLnXdp1x4/UxTr5ag4ue/uG3f6r+
	 SXw+dFFg1n1vxOdtgAQWzVjFYQLWN/qOOi8QX+n2TtisZi7yn7J6lHVVzIrwlynfzj
	 MoKcwlGmia9C77ny0gmoRwq4+cltrT2fH/Mf+9IpQRuzpBZATwd8a/joWp7o2isgd6
	 w0ejq5TU1SatvXWhyuVbTzNQohJa/eXSs5LEu+VSPyVu5jXzhFntF7VGn8zdD0X+9k
	 AFk1ejBM+Ej0HhG24Qie0v1Hq6oTXtO/m9N7Ri9bvp/YqSzd4uJgnkKc+jxnwsEDAd
	 TrrrGxALOQSrw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Binbin Zhou <zhoubinbin@loongson.cn>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, tangbin <tangbin@cmss.chinamobile.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241015150958.2294155-1-arnd@kernel.org>
References: <20241015150958.2294155-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: loongson: make loongson-i2s.o a separate module
Message-Id: <172927341718.163659.957408611564091244.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 18:43:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 15 Oct 2024 15:09:54 +0000, Arnd Bergmann wrote:
> An object file should not be linked into multiple modules and/or
> vmlinux:
> 
> scripts/Makefile.build:221: /home/arnd/arm-soc/sound/soc/loongson/Makefile: loongson_i2s.o is added to multiple modules: snd-soc-loongson-i2s-pci snd-soc-loongson-i2s-plat
> 
> Change this one to make it a library module with two exported symbols
> that will work in any configuration.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: loongson: make loongson-i2s.o a separate module
      commit: 43916d9288460bd76d47128898fdf5972dfdb87f

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



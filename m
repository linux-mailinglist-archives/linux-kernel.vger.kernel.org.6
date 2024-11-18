Return-Path: <linux-kernel+bounces-413258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9B9D1654
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09AD8B250FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FEB1BD9FE;
	Mon, 18 Nov 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2XTscyC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFB1A00F8;
	Mon, 18 Nov 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948970; cv=none; b=n1oubT3TaNSjPc9M4Evu6yxjLKJ+QOz+jBnBQV3hy5q76sq68QaSHLvW8rRQ2gL6LtpTkWJlFx7JTV00Nex4VWBJn55tKr9jhrcJkGl8Yi3IkGmeelsLByYsAYgD0zLgu3TXHt2FyDYPUrul15SOpUUjXuju1pGQPAjwruXPZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948970; c=relaxed/simple;
	bh=/0Pkzh2eJ9T0ocM+1U2ygIK45IBE3fmm+j4EMF+QzAA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZN0yT24+u+n/N8kipNCuF/ZTtMj9MgWs+orUy6L+0J07VjVU+CUw4fy0AG2W12RIaUYTD9Jmq9xH77n71PD9/2vu9wPB5pRNLpgg2k+i+sMJkiVGVs7xUQW8bWsjNzmBk5urxqiIdNUEJr6wi25QjnlAJ618lJf/3Pf9sZS+TbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2XTscyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7DDC4CECC;
	Mon, 18 Nov 2024 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731948970;
	bh=/0Pkzh2eJ9T0ocM+1U2ygIK45IBE3fmm+j4EMF+QzAA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=S2XTscyCwxFISPZnLeIfrr3AKwzy8gO6CrfzAhPYq5/fF0AVIZrKQODmFdkxQ0tgt
	 /+whQ7e2Ap4c1WLNOfBzcJXlurZw2fUuwU3Z1Q3Rk0MY9RchyfpNpD2Srr004T4dQb
	 FywxLPGgVAOHBeFtnojlBFZPOChxu1Ap+ZpgWUndC21QKYLXIGkPYypFuJn7QquvdM
	 QxoDCvo2oFt31oKE3t6Ltdc3QLPke6pyULKWEfHfzVTV3fCmqpMEmvg3DbsLvuGu7U
	 QrzyQsRlMyhEAjnx1eJifl0wSbzosrbJ68Hts1ajIgMvGsoKsdzhPUQJLvf5Zs7kTk
	 HRt9kosaT5bBw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "end.to.start" <end.to.start@mail.ru>, Jiawei Wang <me@jwang.link>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alex Far <anf1980@gmail.com>
In-Reply-To: <ZzjrZY3sImcqTtGx@RedmiG>
References: <ZzjrZY3sImcqTtGx@RedmiG>
Subject: Re: [PATCH] ASoC: amd: yc: fix internal mic on Redmi G 2022
Message-Id: <173194896823.56205.158411490065653084.b4-ty@kernel.org>
Date: Mon, 18 Nov 2024 16:56:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Sat, 16 Nov 2024 21:58:45 +0300, Alex Far wrote:
> This laptop model requires an additional detection quirk to enable the
> internal microphone
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: fix internal mic on Redmi G 2022
      commit: 67a0463d339059eeeead9cd015afa594659cfdaf

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



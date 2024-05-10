Return-Path: <linux-kernel+bounces-175312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0508C1DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B0C1F21BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5321D15E81C;
	Fri, 10 May 2024 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdNs4fcZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3D224DE;
	Fri, 10 May 2024 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322128; cv=none; b=qMZAkhDd1QDGVYQ9qLlSXkU6bfJ9353adrpaP70SJ1+Rf7RExupDP8mMS5ngXfZSE0kecLmRRhfpxGXzhc6uHIwKRvkKN39n0kTim4um/Jvds6+Xeq6Do1/IpqYouv8a5FEmnCh7IRQlZT4Yx8SHgX3K4nzl7OdpZLK2E6GSLQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322128; c=relaxed/simple;
	bh=T9jRIkRpc7yRgY2Mi79GUCF2sA7gPb2fWldAOAEDO/E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BdbIe/ovmW/sxI/svuppD/8uPt6uHKRrH+I/i5mM4alFaltgk3T+rN2YIgSe3F9NfdwnNNqPLKRg6QlUlrF/vzARVjXQmfvaN4GMQTmBpHHmATQw75ircKTUeb0pcw5FY/WucFYNS8Dbn3+jhd7d0Jf7DLMB7aj86pG3OU+gd64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdNs4fcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464C2C113CC;
	Fri, 10 May 2024 06:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715322128;
	bh=T9jRIkRpc7yRgY2Mi79GUCF2sA7gPb2fWldAOAEDO/E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KdNs4fcZdoKnBhQbc27T8hwMl6ahthARRP72sHArwK+IaXVrcuUSnsR0QMVpHlS02
	 ofHYXAFj3fImM0nt1Z0L5esAnNO+Bi4CgQCkFAb1Dox3AJtQHUjmXipHvRjLPmcG53
	 OSND6iGiKvjPNNwBK/b1lPFPfn/IjqUF59+qNkkoyo5+u6j4ogw61iIuAhPaBYVIUB
	 kKB9r7h8eDEmDNlrRHua+FC8QZ0SQsCgs494A7axCiVFXtrR3gRBunG8kB3uvKwie5
	 Ni03D4wiEs020UF0hXl2hCSwrpNvNZHhH1FkDkbJdNCOvV7C0hvsc586RTEAP2i7Gp
	 /isBY25dzuVlw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jiaxin Yu <jiaxin.yu@mediatek.com>, Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240509-8192-tdm-v1-1-530b54645763@chromium.org>
References: <20240509-8192-tdm-v1-1-530b54645763@chromium.org>
Subject: Re: [PATCH] ASoC: mediatek: mt8192: fix register configuration for
 tdm
Message-Id: <171532212481.2044808.8204957750366408255.b4-ty@kernel.org>
Date: Fri, 10 May 2024 07:22:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 09 May 2024 07:31:29 +0000, Hsin-Te Yuan wrote:
> For DSP_A, data is a BCK cycle behind LRCK trigger edge. For DSP_B, this
> delay doesn't exist. Fix the delay configuration to match the standard.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8192: fix register configuration for tdm
      commit: a85ed162f0efcfdd664954414a05d1d560cc95dc

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



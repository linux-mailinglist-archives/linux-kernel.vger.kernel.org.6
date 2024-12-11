Return-Path: <linux-kernel+bounces-442047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEEA9ED753
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3CA16401B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E5A2210E7;
	Wed, 11 Dec 2024 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spLWDjpJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F61FF1D7;
	Wed, 11 Dec 2024 20:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949498; cv=none; b=FHMNNPDH2oSlU6C6HS6FhXjDhYK/uV9FBhZmsoeYoq6I11ryJjgPjFB6uOCFJGHJTgSpG2KlTVSc2INMNQytt0RuJKUxHvCxtAefzrsfupriVHXhyAgsP/SSzfhPFoGaRU3/5IeULH+jggb7D+fZX0CPUzHAVrkWpm7umjYl1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949498; c=relaxed/simple;
	bh=FFmrdvB9EJxDvU8tTW53+f895EE8lOXsugMfu3vWp+w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sb80pYwkXSoz5Nc90spX35QkdAVuq4cMk9CSDpqxx+dDcLSxT/2IjysvO/ICADxyvwH4rrMaWKxgCUdD8JrTRbpuATn6IYyBhhqEeQtVdcrLDTfW5HkIIS7CTR550ltSgSjFVK+EJYX7wKRhhaAcVsg1gfEzeGFZIprW6nbmQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spLWDjpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBF6C4CED3;
	Wed, 11 Dec 2024 20:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733949498;
	bh=FFmrdvB9EJxDvU8tTW53+f895EE8lOXsugMfu3vWp+w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=spLWDjpJlNrU/BmoMXf0RYzaTzwoYxknIt0kD5IW9MJLPohbOcO11mL1JokYUvMpS
	 ayc9hAOvSS5CEXzEo4yVvhMpVNAeMx0j6Oj4k8q7oCjWbva6W6rzCWeWlnr/IjRdll
	 9Sa2lNZkIldYuLNaENy51U20WTUpjaSAiBLFHjkI1a1OHNFjHKHpV3JR2oSe/rtQXE
	 2Bu+50KvqtGMoi1a6wAl9RhOURpDAmSxgVc7SPaBzD6xepuAmTjMw8ZvSxrakoUOM8
	 Rya+MTiXeIoX3pAIcznme84jINAwyWaOS6HQA9bNzHQSvXHLaAWAr5bfFKIKnl9frW
	 qHxztYKGapUmg==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Stephen Gordon <gordoste@iinet.net.au>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241210033648.4872-1-gordoste@iinet.net.au>
References: <20241210033648.4872-1-gordoste@iinet.net.au>
Subject: Re: [PATCH v3] ASoC: audio-graph-card: Call of_node_put() on
 correct node
Message-Id: <173394949685.1491700.15447611446325984218.b4-ty@kernel.org>
Date: Wed, 11 Dec 2024 20:38:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 10 Dec 2024 14:36:47 +1100, Stephen Gordon wrote:
> A small obvious fix.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: audio-graph-card: Call of_node_put() on correct node
      commit: 687630aa582acf674120c87350beb01d836c837c

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



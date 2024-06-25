Return-Path: <linux-kernel+bounces-228737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C054916643
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 219B1B2470F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B694B14B075;
	Tue, 25 Jun 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7LB9nl9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072C3149C7F;
	Tue, 25 Jun 2024 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315232; cv=none; b=Zw1Glx/6J99N5tXVc/s3Rgxu/ekW+vj/+D8yhFle8CDFJek2WpVNwyUfnasMHOXj+vZiuSRGi2qWQgX7GKY6HJrhFkPtXhHl/1uqp0JZ++X3XM/d399qE1nfQzP7YejUNfYzNG75x2E+J4upX9Nao8+KpeCJK6rMYfKzXqvHMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315232; c=relaxed/simple;
	bh=NqJdMjPT9r805HO+jweg1g1ihBCkWTI4j4kjDfQkDEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fZnsFbZG3BmwT4gbRMXOJSpKfEnL+94KxjYFE0NepKrXCpeB/L70Y8o/VqQIbN2cL024bV4cv5EMZgwPVORE3JL7npGtv4yn5ADYiptxm5f4cyerK+T3AQ2JEVK8vObp2p3d5oWhCitEHvDadIxyKbaMOT8mLmmFNGpFF2Drcq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7LB9nl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E1AC32781;
	Tue, 25 Jun 2024 11:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719315231;
	bh=NqJdMjPT9r805HO+jweg1g1ihBCkWTI4j4kjDfQkDEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k7LB9nl9SPm9p8yq0UhgCUR7+bcQ2vC25wnADZiANHdw/FVB5qEUdBC8IbJbQCOT1
	 BLEEZKSC49WA0vTxYItoAqXfj2sqUj8nNQS4Boy4O2+gTssCZs5zttp/JKX0E/m1Qf
	 Vhxh5oOW9C36dE3IXhfV/XxJoiYN2b7ssTX7cJUmQJV64C56HXcGXIEkhhBhpKFaka
	 8kun7jFHzecU7wm6KpbiXDIIQ3GKEqdzIHqFg1iejFNdYe13loKLOfqac1dyiOFvs6
	 fo3ZvMXOvaiC/6UhhfYyPrmWMAfrDuPMbcJ0o0SnzfDvBo//IccR6rR5fC0pt+U8/7
	 NHtse6bPnwYuw==
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 angelogioacchino.delregno@collabora.com
In-Reply-To: <20240613020725.27874-1-jiaxin.yu@mediatek.com>
References: <20240613020725.27874-1-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v2] ASoC: mediatek: mt6358: Add "Dmic Mode Switch"
 kcontrol for switch DMIC mode.
Message-Id: <171931523011.64144.683590179914133512.b4-ty@kernel.org>
Date: Tue, 25 Jun 2024 12:33:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 13 Jun 2024 10:07:25 +0800, Jiaxin Yu wrote:
> There are two hardware connection methods for DMICs on the MT6358. In cases
> where more than two DMICs are used, we need to time-multiplex these DMICs.
> Therefore, we need to dynamically switch the modes of these DMICs based on
> the actual usage scenarios.
> 
>             ---- DMIC1
> AU_VIN0 ---
>             ---- DMIC2
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt6358: Add "Dmic Mode Switch" kcontrol for switch DMIC mode.
      commit: 4ae814dabcdae3e434820c64396e15ccb33cc0ce

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



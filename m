Return-Path: <linux-kernel+bounces-362435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA2199B4FA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CE72837D2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 12:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383CB18953A;
	Sat, 12 Oct 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+BaNJh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D0186E40;
	Sat, 12 Oct 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728737447; cv=none; b=WOltprNf6vpfZZlo8Jhym7YkCA7wZzqq8DkMTkv7I2cnW9kdjGVRJOdoEThRnMyAZPi45JjDkTTr3os0fIMtdk1LI3q9Qyp/rtaBgP9LLKQWfXmbSpD6qOkE2DI/Pj42MC1b0ac+5XeMGgO4y5BYyRIon5FzgGQ5+TfJ50L/rzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728737447; c=relaxed/simple;
	bh=2cWdrSgd9OIc2/RKdZ68s7lQknFnL0g54oGXJ+t/Su0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i0Om9uHPzWMT3ewzlSK4NfCalzhKppw/BWHk5JwrlvFpVUuZSF9UXw+Qz5xy+XyOs4j9BkathzN0IyUp97gUytGwvmPZ9S3E68PPP+yjwoRo6XaKhoXaQbm9n47kQke7RgttrvxciYApjMJJIe7Ajql4qQ+EM2EQuWAaqtAw2mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+BaNJh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349D1C4CECD;
	Sat, 12 Oct 2024 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728737447;
	bh=2cWdrSgd9OIc2/RKdZ68s7lQknFnL0g54oGXJ+t/Su0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n+BaNJh9XrIb2YbsTi6XD8D4VXT7fMxN7LLyeb1jm9N9b0/7RNBvmjUKpR6JB8hJs
	 QM/bJ6NwP7vuY2B4KFo+XtL0Fw2ECd6+FhfMsX/T38DSk00/NFy1XHIJnVJ4VpkLFK
	 Bw/CV7zYdl6gE5dOMOtaaaDL4kG3gHrk7kvCtPtvUgWfuM5gntf/VwK35TxDqtVgL6
	 UHC8le3t3DQ/0RdLOLzGjgsmkKzbpL6cd/7ev91JHscQ3qECtLXXGPxfwvBrDKefpq
	 Rxqyois6/wixb/xA0JJRt2WmwaQlAMhFxLJ6EIgysOGtuKVwjik/qcFg6NMzGv9Hqd
	 KEaHKy0rRrCiQ==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, vkoul@kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, pierre-louis.bossart@linux.dev, 
 bard.liao@intel.com, peter.ujfalusi@linux.intel.com
In-Reply-To: <20241007121241.30914-1-yung-chuan.liao@linux.intel.com>
References: <20241007121241.30914-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC/SoundWire: Simply interrupt enabling for
 Intel
Message-Id: <172873744520.3950734.5770397473019892080.b4-ty@kernel.org>
Date: Sat, 12 Oct 2024 13:50:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 07 Oct 2024 20:12:39 +0800, Bard Liao wrote:
> It is more logical to couple interrupt enabling/disabling with
> power-up/down sequences.
> 
> The change is mainly on ASoC tree. Can we go via ASoC tree with Vinod's
> Acked-by tag?
> 
> Pierre-Louis Bossart (2):
>   ASoC: SOF: Intel: hda-mlink: expose unlocked interrupt enable routine
>   ASoC/SoundWire: Intel: lnl: enable interrupts after first
>     power-up/before last power-down
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: Intel: hda-mlink: expose unlocked interrupt enable routine
      commit: eac79786c7397925149a1bfc4bb704777cd42a99
[2/2] ASoC/SoundWire: Intel: lnl: enable interrupts after first power-up/before last power-down
      commit: e0941775e6bdcf45e6e20b7ff3bb87dbb7d92fbb

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



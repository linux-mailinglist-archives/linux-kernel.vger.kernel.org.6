Return-Path: <linux-kernel+bounces-305367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60297962DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111111F24764
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6931A7040;
	Wed, 28 Aug 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQvMKyIG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786D1A4F30;
	Wed, 28 Aug 2024 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862616; cv=none; b=M7saH82JKi/AqCXW1YXY0E2l9cfdqqA1tcSGJflqVthd8uA85xhXYd/Tko+tQpo5c3QdM1OdOlpaaYLzjEKN2HkcJlVqnAqViSTZ9nGdMcFz+C5ua/DJaHnKcWHmU393OTvcVzf0iQN+wJsGiaM59/2mnr4O2PjZR0KHV8T+hPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862616; c=relaxed/simple;
	bh=5F3C6jF0AnBUgJMEeWCmhxNDzCwvlo6w+fCq+6Ew9GI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aHVYDJxpX/M0TNs0zi/L+E+tpiFf81zvmqrVkgLPXUofmliJZ6S36Anif0KdIyN42mp6Kf/UMZl+Mk9vf9IB9lQPfu4ZEMUOgqkdlImkKSMTswl9bWoq8Gr35loBB+rKf39YtXyNykOMTBpYsllqZeUkMC5haCK/RZVf53AKEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQvMKyIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3175C4FEEA;
	Wed, 28 Aug 2024 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724862615;
	bh=5F3C6jF0AnBUgJMEeWCmhxNDzCwvlo6w+fCq+6Ew9GI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UQvMKyIGffRMdVxgh7wMmGs0SJDH8TvnnBXL6cJPsUkV9Gf73aBjnd2+F3HKVF8ex
	 luK1hBF/7RoX/OMf41yO6nC5FQ8yFivOBYdp1tVz/nouuAf/1k7gbKFUqMeASmrwsi
	 l64SO+v+Evks4k/OZZkeP6LdMupjHB2EoXDl1HDS3qL8rOQDDpcS7nC1aSaI2IZSSI
	 ZGETAmcEetyyhlAuaGolviToxOGIbWgin0KWetb3rBMTKtazjShutNwVc90xKOepxo
	 h9KFL6rObh6sLlElMmH9Lu3TEoJsO1nJt+EuzZy60mAqtVYGR1PZzR2q8xh+R0SvZu
	 1qon1valVCqDQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240821100221.99699-1-rf@opensource.cirrus.com>
References: <20240821100221.99699-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs-amp-lib: Ignore empty UEFI calibration
 entries
Message-Id: <172486261439.92851.16165742413120082116.b4-ty@kernel.org>
Date: Wed, 28 Aug 2024 17:30:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 21 Aug 2024 11:02:21 +0100, Richard Fitzgerald wrote:
> If the timestamp of a calibration entry is 0 it is an unused entry and
> must be ignored.
> 
> Some end-products reserve EFI space for calibration entries by shipping
> with a zero-filled EFI file. When searching the file for calibration
> data the driver must skip the empty entries. The timestamp of a valid
> entry is always non-zero.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs-amp-lib: Ignore empty UEFI calibration entries
      commit: bb4485562f5907708f1c218b5d70dce04165d1e1

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



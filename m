Return-Path: <linux-kernel+bounces-404200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E2B9C40C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF7B1F22710
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6830719F40A;
	Mon, 11 Nov 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLEVcRXS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483F15A85A;
	Mon, 11 Nov 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334889; cv=none; b=VANBleY8wIB5plwxb9z2XHkxtd/RGdltCwoiMX6Mk2uTUQrXtneqSd7DC1brzRbjGc+JNJURMqN4XQ5F8zFWt+/hzV4flKy8gIJy21MflgOeh/aJlTCZzGk4HJO7reA/52C1OHwVBA+3Kpz1n2yiGxQiuGKKkzjOcC2R20KS5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334889; c=relaxed/simple;
	bh=SdtIFHXj9IJA/ws+x0OpsqKUWPnJeMa6F/7OWvkYcqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XCRSxxfOkfoXhdgg+G4qZa2mn1e421OVBF9G5UjJd8+NU9F8oxTamIM0OAYs4ZOzJ8tElsJQN9Sf+iflQPSZlr+Bo2x/+EaGsIMrwmD3Rah8yEo4+OpqlpeoWTQcnEUvso3jMQKPyx+c6Im07q8Wih8gquxDHkFfhT+Tf83gsls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLEVcRXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1853C4CECF;
	Mon, 11 Nov 2024 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731334889;
	bh=SdtIFHXj9IJA/ws+x0OpsqKUWPnJeMa6F/7OWvkYcqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZLEVcRXSQWYwARoAcvAgKmvEzKBcSUiGiFBPfvqiv8SBOOoMuWJAcrRhqmmeyI52a
	 G6yWwKFnYFWlTmJ7TC5MsJhlNtCnrUQFmxCKd9/TZ9mt2XZoe46wS4bzfWJ5qrdGwO
	 2Ice89Ox3lSskFe9V7tWgBgcGfqbQ3L9dXBm/RNXzJk7pNEENXUR/QNawTaf1YzwJR
	 KfwiLsHiITI7hWML+q0zchPb94o3kL44w83XTFJZfyna6n6LQEslqstRchQvNBMdL+
	 wmglk90QLUS0Rdypgb29l3a0L64c0P5RgpHft8redEz6AFNCFFhHdPMclNPyDlUGqi
	 ocyhDrSmDWqtw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, John Watts <contact@jookia.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241108-graph_dt_fix-v1-1-173e2f9603d6@jookia.org>
References: <20241108-graph_dt_fix-v1-1-173e2f9603d6@jookia.org>
Subject: Re: [PATCH] ASoC: audio-graph-card2: Purge absent supplies for
 device tree nodes
Message-Id: <173133488765.303054.8837828611900926496.b4-ty@kernel.org>
Date: Mon, 11 Nov 2024 14:21:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Fri, 08 Nov 2024 12:37:15 +1100, John Watts wrote:
> The audio graph card doesn't mark its subnodes such as multi {}, dpcm {}
> and c2c {} as not requiring any suppliers. This causes a hang as Linux
> waits for these phantom suppliers to show up on boot.
> Make it clear these nodes have no suppliers.
> 
> Example error message:
> [   15.208558] platform 2034000.i2s: deferred probe pending: platform: wait for supplier /sound/multi
> [   15.208584] platform sound: deferred probe pending: asoc-audio-graph-card2: parse error
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: audio-graph-card2: Purge absent supplies for device tree nodes
      commit: f8da001ae7af0abd9f6250c02c01a1121074ca60

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



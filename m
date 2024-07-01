Return-Path: <linux-kernel+bounces-236611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E0191E4D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D12281A41
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B440E16D4DE;
	Mon,  1 Jul 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwoLHCTK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E781EB2A;
	Mon,  1 Jul 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850101; cv=none; b=jnOKWK4aRZP3VphLcH4SXqaOw7s6mhCi92rAKkyF0Ba/FRbXwYzbpGxIc9QM4mHnLRDDT1GHkiQGjKwglXEnF/JwXRQqlzCIn9KymgBaMNcY2F/uWpIYiQP0RZ/P/nbpbpIA4jAmBeFvqZuZhBE2yJMnzRo530zxYTWWZJdpE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850101; c=relaxed/simple;
	bh=xo/lQLEgp4T9tOodEdYdrv/WFpbI3LH5AIIdorooP/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qsp0RaBV2zdzlk/R1pDIAGZWhT1103gNQhuCL5aXvU+RFtoFSh4neOTozGLBwHQxjxusPV31iw83BOu5a7+XY1Orivx1MtXJKtyIy/3XkWnIHCSqqpUwJe1DhLNZIe0B81HJMMfWY9yZSypZCYD+N5vOXtEi9d0USXdFW019s8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwoLHCTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2B2C116B1;
	Mon,  1 Jul 2024 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719850100;
	bh=xo/lQLEgp4T9tOodEdYdrv/WFpbI3LH5AIIdorooP/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cwoLHCTKrl1c3Bo7IVHu2E2rOLxdFCDLCz/fiqC1Hr0UDY4sSn6KYiUb68E2mjhVt
	 rF0RhoL/ILqR+JCyKuh0rWrXGmnANCeJ9ZstoFhfmA7toz8lqXpTG0i1W4JEXVTBtF
	 Wvi2Lsl6H4nyTLFvo70y0rmPeo3wnQkEp8dfQor1iB+YOAiTJaWmjKf5E8FP5nTkUR
	 ksfg3lq/t3pJymPH/n+qclsoWakdXXRuy3AUjwkXbSSWBBYkZbavN29UcrVJ8W2DA3
	 5RliJ7TXYPLUg4zoyKunLW+/pjhkg0LjCotqsC28eGr0UJo5fEuVTuOftAif5o6iko
	 fAf8ebBmYoSOQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
In-Reply-To: <20240627141432.93056-1-rf@opensource.cirrus.com>
References: <20240627141432.93056-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/4] firmware: cs_dsp: Add check to prevent overrunning
 the firmware file
Message-Id: <171985009864.89113.4517197771955831374.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 17:08:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 27 Jun 2024 15:14:28 +0100, Richard Fitzgerald wrote:
> This series fixes various missing length checks when processing
> variable-length data from the firmware file. These could have
> caused overrunning the end of firmware file buffer, or wild
> pointer accesses.
> 
> Richard Fitzgerald (4):
>   firmware: cs_dsp: Fix overflow checking of wmfw header
>   firmware: cs_dsp: Return error if block header overflows file
>   firmware: cs_dsp: Validate payload length before processing block
>   firmware: cs_dsp: Prevent buffer overrun when processing V2 alg
>     headers
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] firmware: cs_dsp: Fix overflow checking of wmfw header
      commit: 3019b86bce16fbb5bc1964f3544d0ce7d0137278
[2/4] firmware: cs_dsp: Return error if block header overflows file
      commit: 959fe01e85b7241e3ec305d657febbe82da16a02
[3/4] firmware: cs_dsp: Validate payload length before processing block
      commit: 6598afa9320b6ab13041616950ca5f8f938c0cf1
[4/4] firmware: cs_dsp: Prevent buffer overrun when processing V2 alg headers
      commit: 2163aff6bebbb752edf73f79700f5e2095f3559e

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



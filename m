Return-Path: <linux-kernel+bounces-407628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F049C7037
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7391F27B00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7ED1FF035;
	Wed, 13 Nov 2024 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoIzCjGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42597200BA8;
	Wed, 13 Nov 2024 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503003; cv=none; b=TOcpmxIccFPU1nVob/VMgh9drjNGz+3X5i/IWxi2nCM9PiOfZiPiix6OBLZ21Zr+aySUqQOISldML41a8mPiMzBTEIZTc1jpnB5w5dki6Yw3dSe0vHiYGMXGvwKNn0GGGy1LGXMK/gH7T+IyTkvIMxgh66XiB9mWRQbsyZ5UWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503003; c=relaxed/simple;
	bh=B2gIiMDTDDtPxAL49WyLVmRwYDtXU+qaJiqgsk+iadI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UFkw89yBLy0SE/zW71J8KLD3ena7DHPdEelmxlGcoLWgTbThuShEatSfTFfFUilPS2ZKYE0lexEH6VKHLnFCM3DV0GkFtmb80MY4Ei69KbEqGpxc+ZZdUCOwtvHRpAgzZdWHOaFdEYrvo57F9DcwCEBdX9nlOhP6fPbA8pSj+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoIzCjGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F5BC4CECF;
	Wed, 13 Nov 2024 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731503002;
	bh=B2gIiMDTDDtPxAL49WyLVmRwYDtXU+qaJiqgsk+iadI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CoIzCjGbvW7Txsx3ipinssU26QIR7QVdxIfLZtpEyczj4JUkqbAEIdrLDBsMoqClL
	 bP/4ffiIDvuX97buP3YL021rpOevy3+bLjuC+IiV/5+EG7OAne4vNSznOuUjgn6knt
	 08maFYMa7hHFffs0Vxgib59IQzao+1HztQKaStUMyuE330QfuC/lq3jOzDe5uDMyB6
	 0J36PFQz4QyxNw8RnpkZT8jMjDG/GHOHaHXStR5SP41YNd7ymYHuArUq/LQD6/CV2Z
	 uWTtDB2k3fX2ij8u/rezJH8XQlpUE++KXljRs7qw1JRBXfbmXNb1ozIemx8EH5R9yV
	 Yea6x6p68kVOA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, John Watts <contact@jookia.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241112-alsa_test_rates-v1-1-95cf529db871@jookia.org>
References: <20241112-alsa_test_rates-v1-1-95cf529db871@jookia.org>
Subject: Re: [PATCH] ASoC: test-component: Support continuous rates for
 test component
Message-Id: <173150300027.429793.6079129175956247934.b4-ty@kernel.org>
Date: Wed, 13 Nov 2024 13:03:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Tue, 12 Nov 2024 21:34:00 +1100, John Watts wrote:
> There's no reason to limit the supported rates of the test component
> to specific ones as if it's a real piece of hardware. Set the rates to
> continuous to aid in testing different rates.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: test-component: Support continuous rates for test component
      commit: c853e96308c58f9a06fcf393bcfe0eabdb72ca9c

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



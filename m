Return-Path: <linux-kernel+bounces-558564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939E1A5E7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12EB93ACFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1C91F12EB;
	Wed, 12 Mar 2025 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIMRqIvL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F261F03E4;
	Wed, 12 Mar 2025 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820038; cv=none; b=reKBA34ho+FRh7ACnzEVKYqOOCBcSj7ZIA4DV6fmTy7C6/dSpYCgV5J8viJS8Hsa8ZM9tpEzc+E/PtowyCuUVQApt0eMW82pbgDFLK4v2+ZMHY2coEwMRL3CW+z+IxZZhvewVQA3vEjZT5Fbaho5BdZVCekeHOERvTNlQECUE1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820038; c=relaxed/simple;
	bh=/CafB9CjLNnG+rUtDUJvwj69pDk3YEJSnvrK28dm2XU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jyoyjXlsi8wG/UyDTLoFGCSI198YDDgp1czX30YHzOfchrLamrwJL5jyVk2/9s34MxKGg2wS3JBF6xy4WuqKWXmfXlDN+mSIcgTrYFZ5Td2dephVnqVmJdk3xqfPrBVkD0zNtd1P2hE47W9PM63VeC+ixZjNVg/8B9st1EzaFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIMRqIvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05BEC4CEDD;
	Wed, 12 Mar 2025 22:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741820037;
	bh=/CafB9CjLNnG+rUtDUJvwj69pDk3YEJSnvrK28dm2XU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iIMRqIvLfnPjZLQe0figVe5wHAJC9578kv13FIlhxXaD/wUUj2S6BR9ksGJGqWxM+
	 8Cj7/Lw7lFCI2lZJl10LidF3gp1g9QAQmp/+iYMnHjtNej3bXaN3DMshSVYqcIwqvi
	 2SW1Ym9e6sfjIEb9oN8nlHKI7KvlkNWnjYFeelxVGi10+TQRp7GPac1EGH7qagXJuw
	 2GqoXO5sFwSBlpm56dI24xISrsRNXWcVe9IyE6WkjjiUPS94eCb8CkDhAxt+IARJuQ
	 kckSJGYrXgUgy6oz1FZg9ssLZqHtyDRKPmttfvDlWI5QzO7P/uJp68WAmn3qFc9IbZ
	 tNw/pyMCasFVQ==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250305172738.3437513-1-arnd@kernel.org>
References: <20250305172738.3437513-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l43: convert to SYSTEM_SLEEP_PM_OPS
Message-Id: <174182003460.191802.16024952656577662294.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 22:53:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 05 Mar 2025 18:27:32 +0100, Arnd Bergmann wrote:
> The custom suspend function causes a build warning when CONFIG_PM_SLEEP
> is disabled:
> 
> sound/soc/codecs/cs42l43.c:2405:12: error: unused function 'cs42l43_codec_runtime_force_suspend' [-Werror,-Wunused-function]
> 
> Change SET_SYSTEM_SLEEP_PM_OPS() to the newer SYSTEM_SLEEP_PM_OPS(),
> to avoid this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l43: convert to SYSTEM_SLEEP_PM_OPS
      commit: 2c2eadd07e747059ccd65e68cd1d1b23ca96b072

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



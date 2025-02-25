Return-Path: <linux-kernel+bounces-531482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9281A4410D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0FB7AC188
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6391C8600;
	Tue, 25 Feb 2025 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvqjUDqo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AFC269819;
	Tue, 25 Feb 2025 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490726; cv=none; b=ArRTpYrYosGLFw7Cv7gqBN0/cg5fjIqWjgoQhZeWvpKlPm4Chzh3YgLN90ZU8hicgNcVZOMbmT2S+1uOOMGhxqKsupx+Ancie2dIjXJYZq1d2sgMHGA/QEtX6SsDOttaN44wVUBVX9JCcWw7TXqiCkAb8ST1Y3csps6pEDBzgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490726; c=relaxed/simple;
	bh=UPwGdf4XoJMItFYS8KBqZHuoRc5P6DTbta0DBll+khg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fY5nZ6zFZJOom/9ymFo4RStAe674Cewpu5k8So2hGwQwKQKE+iCqvvE2TexSmcDQmyV9GdtWboPcN66n9lG2n9UNr1jTY8LOTt8I8/tDH9RAQzJ+PgCWMrjAB3YZSM6lcxsV2bMiwnXMM7NbBmf1AYfxt4HN6L44CqadNM6DkRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvqjUDqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D842EC4CEE8;
	Tue, 25 Feb 2025 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740490726;
	bh=UPwGdf4XoJMItFYS8KBqZHuoRc5P6DTbta0DBll+khg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TvqjUDqoZnLZ1CKRTfEe/kAlPzaswhfI8+hgOVkWa8Xa34befAncEym4ln5rtOQeu
	 vT1iJkR2JB9gSKmUlcHQ5U7zCNw4mYSWRJ/EhyEUl7vUaBV3pPyzIFCP+BKmf9hPGK
	 w0REPfP1XHFCQmXnUBJfsD9vzKKHFVLwpD4fwUnS5/Y46NWKI4SqV9dA8Af+1yW7+v
	 K9fY7qhKo/CgaRThzEqyV/5ieqwX8DcFs+rchEfPCeDYfx9x7cu3QKlMWq/j7Rl8HO
	 oBRvJEi2nH4Wv1gnbp3F3Q3rKllMQne78ZV8pPPIkFexrkRgV2ZOJrYnqFNWWLHEEC
	 G3u1iDccY0jCw==
From: Mark Brown <broonie@kernel.org>
To: Cheng-Yi Chiang <cychiang@chromium.org>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Benson Leung <bleung@chromium.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: chrome-platform@lists.linux.dev, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250220120100.1530-2-thorsten.blum@linux.dev>
References: <20250220120100.1530-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] ASoC: cros_ec_codec: Use str_enable_disable() helper
 in wov_enable_put()
Message-Id: <174049072359.42497.10441700607973248883.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 13:38:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 20 Feb 2025 13:01:01 +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enable_disable() helper
> function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cros_ec_codec: Use str_enable_disable() helper in wov_enable_put()
      commit: 10efa807929084a8a1c38655942a3bf83bce587a

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



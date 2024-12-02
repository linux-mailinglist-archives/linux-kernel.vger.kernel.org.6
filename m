Return-Path: <linux-kernel+bounces-428131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C879E0CDB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500D5B3DE99
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DCC1DC734;
	Mon,  2 Dec 2024 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpQWIfe0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06D1DC197;
	Mon,  2 Dec 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162304; cv=none; b=B4rmQbNGq+ore+5emfv3PpMdtuLaWp1d5qQkYqibuU535nTvMggsiwyX06BkZCcslsmJdcVZglQCgoTIbinKOLLD29LrkValemPT+/y2njaALz74+/TwamRQzUwG2t4U+BExBGgqdCa/H/QnCMg/172ToTO3vvud/O7kO3AEoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162304; c=relaxed/simple;
	bh=RmCnNjhUcPfj4ZV7oqO8MNtJx7x0NboJ5/JOdBfbFVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z7scOZIsiqlE3CkooCmDWL5kFWXzX6Z35jB/3Xd//i9bOGR6Zd9volI1KVsdnWOeCmoZu/259GEMA3aqT4EKkieR9BPAe6/a3ZGnXH1O0QUsnD/6lvGqT/UaSGwCCNqD725NA0BqiE7cZSeJPVqci3Ho7zmPg71tcbtT3teFvlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpQWIfe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156DBC4CED1;
	Mon,  2 Dec 2024 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733162304;
	bh=RmCnNjhUcPfj4ZV7oqO8MNtJx7x0NboJ5/JOdBfbFVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UpQWIfe0QTWKVzbmsHY8AvwXql88P2Uo1M7HBqZjVBV3/oGu6U4ZDflItE396DMVk
	 tHR62hLdfEvCfdSSLl5COy639nYpCxcjAph2rqtvqFC0ZzCxtL7VccaSeFZsTD/Guf
	 EkhW2E9yv8C1OjWmibIpd0VHi6J+yqNjYxQGztQdQ4oiV9k+bDcDqNOW1KzjHerhXf
	 vIxjD1j6kQphHn8fqqEiwJmHX3Ln8c8iZShprFNOK9YZWHCrHSZT/9I2RApjZWngEB
	 azt/+2/HXBqeng28g9WBKGL1r86FA82ahT9EEqJBoBVpcI3dUrlyRan6kxvcDCELNB
	 8SHJ853O14eKw==
From: Mark Brown <broonie@kernel.org>
To: Nicolas Belin <nbelin@baylibre.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241031102725.2447711-1-andriy.shevchenko@linux.intel.com>
References: <20241031102725.2447711-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoc: mediatek: mt8365: Don't use "proxy"
 headers
Message-Id: <173316230181.189181.7179970847637835365.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 17:58:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 31 Oct 2024 12:27:25 +0200, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: mediatek: mt8365: Don't use "proxy" headers
      commit: 509544d1b6dbffe7bc1849593ff217f965ec0419

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



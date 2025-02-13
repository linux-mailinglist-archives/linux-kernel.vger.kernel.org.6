Return-Path: <linux-kernel+bounces-513584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D384A34C02
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FDA169897
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6E228A2D6;
	Thu, 13 Feb 2025 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfynJet7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9687723A9B2;
	Thu, 13 Feb 2025 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467970; cv=none; b=rWdJYvb4UOyp0wjBSg7y6C+4YtEyugm/TaAtQINkufsKeDhDH4MjiRE4T/tUhqfNzEm0Btq9LCc4kFlkx9YQtNYECR8w4baCd5ol2KLdDXWfH0stXhMLI1B/LcBwH5sVyAf1xGFN9wk/Ze8BrWmmqjVBa9JYUusaALnuXKrpdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467970; c=relaxed/simple;
	bh=9qGEjUoG7OOHAIhBiFZz2L2hoTWT8k1nUFGC6bGDpBg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dsKAqcSP+6W3qr/7MoG2VQL2NL/vSOjNQsgrXn63gJh/qp3mas5jzDiduH/rwsSDN+DwYIGxdjxUSNrxlvPzB7Hq1etLR/nqzyo7IPeuFBLX/uHi40yPuSI7C1Fa9R51kA5hk3ScYmR0ZMvDMP/iCg0yKpWTLcLMiGKRMWAjR9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfynJet7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BAFC4CED1;
	Thu, 13 Feb 2025 17:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739467970;
	bh=9qGEjUoG7OOHAIhBiFZz2L2hoTWT8k1nUFGC6bGDpBg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GfynJet7FeUh4MQ2xP0MyM6o5kNumY5A+s+moMXrmjeWj5L46aIX4FR0c7C4t5Bv/
	 x7+9XSzB1etJfdPnJP3fxX8fGOcJVMCZ8+rvPyINVnGaYfOGrPHHorjtNfDa+9iuvQ
	 c4UNFR/JBiDeqe7xz2aGMJkq8EMSqpSpGZ72aHNH2P9koDzSG9ocod54BZXek/9vDZ
	 BNBu5fc3Ykg4LW8T2HQ8s3N6r1aWzsNr5V4BgU4qM5pzQgRiRmXXYJZENnfDuE/7zX
	 eQejspwEASgIyxjO9fXtRqA/AP0DViLChSq+h7EdBOKYZ+E7A1x9N/xn6ENVpwQwmm
	 iXRX8+AhD0Tag==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250212091227.1217-3-thorsten.blum@linux.dev>
References: <20250212091227.1217-3-thorsten.blum@linux.dev>
Subject: Re: [PATCH] ASoC: Intel: avs: Use str_on_off() in
 avs_dsp_core_power()
Message-Id: <173946796758.293721.1718038110681784020.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 17:32:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 12 Feb 2025 10:12:26 +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_on_off() helper function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: avs: Use str_on_off() in avs_dsp_core_power()
      commit: 994719ed6d81a6f4677875ab6730254c0bc484ea

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



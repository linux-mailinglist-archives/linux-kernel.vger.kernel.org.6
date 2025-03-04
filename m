Return-Path: <linux-kernel+bounces-545050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D7EA4E8E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AE58A3AC9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86062D1F6F;
	Tue,  4 Mar 2025 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcQRSi/5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCF827CB03;
	Tue,  4 Mar 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107245; cv=none; b=OAgj9quDzBfjrn95lYXrBko5P7GNp04vR7y3u50T+t8vNNAYCosZ8b/E3yGflMoEGcQVsU5ol1Vd1+rxjX6teMi6AEkpK5b2pbVidPTCBASdU16Nk0cd+QvNqrp2oCh9shAc4mI1t8RVyhslIUDVurKgeaJGXLXKstmpvZEi6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107245; c=relaxed/simple;
	bh=Lej59AaBCEz7PNnIkzWDSoOgxw7n9+icQLm2vFLvwgA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cTYeVmX3h5KNZBObkZtixgEEsjfqq10e07mR99xTY84ykPuFpA5/QY84IVFNBx/kL8bOGuaUK5jK+bMumqOZ3VwycGbnLM0NBFPCI0qbN/VhuujQdP2t/njQbhafbzUBNP70RBO+nea3dYMmugCENfFgJ1jn0cqVrs3ZUiBPeGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcQRSi/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B8BC113D0;
	Tue,  4 Mar 2025 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741107244;
	bh=Lej59AaBCEz7PNnIkzWDSoOgxw7n9+icQLm2vFLvwgA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IcQRSi/5XwYsl/XPfbSZB1Elaq7jm5BX9RgwYIZ3eDWNr6tMrih0lOZNY3Xrn2mxJ
	 LwJhmqBMRmHCVnUiDGiF9zqFDEzntPOIowsxvzIDRqDqVcGMu3/aKX6s3JVvCDrfQ1
	 kf40xSc+8TvobMZUVRsQWKc5Sg5R9t9ugeGger7/B+S2eZsIVorvoBP2Yd++090dze
	 HZNA1DvB7corXDnP1cDU2qI1L3kJYaWKxyKR1jHqvLcElWcLjKlbj6Efi8NOvPJ1gy
	 W0fRad7HRPMaLPGCYSS8TeH5MXb0NOH3JgciK9hH53Va2yhMPfIeFIMRmcyLvNoE6Y
	 CU4Cvy8OaiD7w==
From: Mark Brown <broonie@kernel.org>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304140504.139245-1-mstrozek@opensource.cirrus.com>
References: <20250304140504.139245-1-mstrozek@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l43: Add jack delay debounce after suspend
Message-Id: <174110724302.110430.11241715777395150116.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 16:54:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 04 Mar 2025 14:05:04 +0000, Maciej Strozek wrote:
> Hardware reports jack absent after reset/suspension regardless of jack
> state, so introduce an additional delay only in suspension case to allow
> proper detection to take place after a short delay.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l43: Add jack delay debounce after suspend
      commit: 164b7dd4546b57c08b373e9e3cf315ff98cb032d

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



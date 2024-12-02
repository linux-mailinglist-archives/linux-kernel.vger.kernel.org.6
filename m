Return-Path: <linux-kernel+bounces-427609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9D69E036E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6477165359
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43BD1FF7A2;
	Mon,  2 Dec 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjSexpOZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA71FC0E5;
	Mon,  2 Dec 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733146224; cv=none; b=eWbq/mj1ndUe+jtFIisEVCLdOBH53uLkRT4I5HvbIE74lO8YsXRteGpv0xQQthX2rS/5vx7BW4veq4RtJy48FDuiStmVhyjGKHEaNZC2ItFDaqqkhSvGXp8aC2SYFmITf3x/haPQUT9Y9/nYTZhE+r44uW+3Ny1faxtppNe4/G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733146224; c=relaxed/simple;
	bh=H1LUXNWRosTJkWP3diqezDJ6tU1GRDyrtF9wY1v026I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EZVZ8SujaszO8lTgHqQFL+VwOmx4h2/BlsP/NXFtAsNEpfoiZoBzyXC2tJBNmpV/ijjCTQC+PipPbruM7KYDbFPzFtk08XZzrU8xrCrqqVhFlwEt9u96uVOyymHlNbCkn6IRgRqVCcR2oH9jphTHsQFpk/plEtGE9aSgIbJ09es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjSexpOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB14BC4CED1;
	Mon,  2 Dec 2024 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733146223;
	bh=H1LUXNWRosTJkWP3diqezDJ6tU1GRDyrtF9wY1v026I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VjSexpOZzDEQA9coL4TLuOlB7IkGVBJYBGfWZDl2LLZdr1QMn/brioIujOXTzmy0L
	 22fGMCAO/x6aB4t7ik2rqUBT8RqayGR22SEvIQh0BpB07jhNWsWy6qMFabcLfyfgCK
	 uU7qNgf9sR/9f3YpsNEAB+VvX0TfmMbWF3rustoscPtXEmVJZYFRrEo/d++IIShR81
	 JnonoMni+24YmKi959BweGyVGte61CtV3d4wwJWKC33a5pqgbOv4S4fIqlJvEDkClU
	 +6e/tQ5cPaMQ0EaMPWx6rK/OYAiHHTvx2KWz8H5aZMWsHv//Py4Cz9yFmSRvkLXLJh
	 KXxtXy23A1NHA==
From: Mark Brown <broonie@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, 
 Marek Maslanka <mmaslanka@google.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 =?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
In-Reply-To: <20241128155926.1774625-1-mmaslanka@google.com>
References: <20241128155926.1774625-1-mmaslanka@google.com>
Subject: Re: [PATCH v3] ASoC: Intel: avs: da7219: Remove suspend_pre() and
 resume_post()
Message-Id: <173314621946.54037.15998444871365504630.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 13:30:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 28 Nov 2024 15:59:20 +0000, Marek Maslanka wrote:
> The presence of a plugged jack is not detected after resuming the device
> if the jack was plugged before the device was suspended. This problem is
>  caused by calling the
>  sound/soc/codecs/da7219-aad.c:da7219_aad_jack_det() function on resume,
>  which forces the jack insertion state to be unplugged.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: avs: da7219: Remove suspend_pre() and resume_post()
      commit: 04c319e05d0b08cc789db7abccce0fcb13dbab16

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



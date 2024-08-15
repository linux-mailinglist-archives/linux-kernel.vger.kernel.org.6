Return-Path: <linux-kernel+bounces-288030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B251A95314D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61818289FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB66A1A00E2;
	Thu, 15 Aug 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfpdB1Cb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF9319AA53;
	Thu, 15 Aug 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729948; cv=none; b=RXZ7ZApPJu+zFcewvoxfQxKZ/mzugEMq4dXGz3uE/OTRsmr0kjaplGgfm5kUrJIt6ATvQlJ/mqpJ9z76r6apKFX4d7sv1Z4356oXJKREqq3pZnFD92uGczQ0/aIN295poT9cb7DdlCJk5fu5H7+cHGopzv5+5rmUklI8V/CuqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729948; c=relaxed/simple;
	bh=XuBfDATDcvAiZT5CdLIKzlIJ8W1fzMosWfJyMuCN/pI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NFdnx9SfOcf2+02uj+2m2A1E5XNYFNwKikrdBQ2WOsz9IpuuJA+kpo/IUVfYdGfGIQzYZvld3gV2wvw5CLVQYSPCGYGj/vcr4HtkvW+QVFpQDw8+rmVa1zQvoJfMNPUjuW5WDa0fxW2R1t/WZN9Q5QNubWhl98ePxoJ5nJWzzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfpdB1Cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EEFC4AF0C;
	Thu, 15 Aug 2024 13:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723729947;
	bh=XuBfDATDcvAiZT5CdLIKzlIJ8W1fzMosWfJyMuCN/pI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZfpdB1Cbz1GsLjrkkdZ2F/nRymjc9Q6cRXrso00Y5VwxvnPM3Bqu6B6wan7OcdTXX
	 rVCogQGcY6OMGqbYalK9A2lFQ5cb4xMRKjljFOcuu8P5rcIAYYhCk5PpvvAwGoD6Y0
	 7T1qq8LKF53Mb0ju+nQcWeV+OxiZIgnNxUkmsFg0BrIiDYkVUibf7Zrn5JwXX4V/uF
	 4VCHsyo5+18tDGESHTXgwNU/6F3u5o+dSi3Fo8xVr7PQ/RhWnDpomYYUg3Dz2A/M8A
	 fgR4PUBsPHHURaA4rRDv/DoVIHdYA3bAxY6kx7TrjPyJb/Q9iUR6/EugfUidTXsNYX
	 IlNtycBWIVODg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "yr.yang" <yr.yang@mediatek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com
In-Reply-To: <20240801084326.1472-1-yr.yang@mediatek.com>
References: <20240801084326.1472-1-yr.yang@mediatek.com>
Subject: Re: [PATCH v2] ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register
 as volatile
Message-Id: <172372994551.42484.5241249306313134145.b4-ty@kernel.org>
Date: Thu, 15 Aug 2024 14:52:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 01 Aug 2024 16:43:26 +0800, yr.yang wrote:
> Add AFE Control Register 0 to the volatile_register.
> AFE_DAC_CON0 can be modified by both the SOF and ALSA drivers.
> If this register is read and written in cache mode, the cached value
> might not reflect the actual value when the register is modified by
> another driver. It can cause playback or capture failures. Therefore,
> it is necessary to add AFE_DAC_CON0 to the list of volatile registers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register as volatile
      commit: ff9f065318e17a1a97981d9e535fcfc6ce5d5614

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



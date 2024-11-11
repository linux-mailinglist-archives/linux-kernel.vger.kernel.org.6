Return-Path: <linux-kernel+bounces-404363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3489C42E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4094E2820E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212A31A2C29;
	Mon, 11 Nov 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc4FGU5I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C79B1A256E;
	Mon, 11 Nov 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343432; cv=none; b=rm7JWJcDVpYVOwCbvvjl8qUVF5U0Vw3hKcr2xAYjjCYWZ+2469vizf40BTcgX+O2AetnGmBwtUtDiIH3H/8XkdWg8NqkujI62THI8/CfUsoMoULxXiFcKbzPvHjBrsZPi8NtTZPASm1af8h18jFR79L+wJwvnCa+JyTe30+jJ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343432; c=relaxed/simple;
	bh=nG6iTzLFLjsLDmo/ST31XIcMDE99NoMA5MCsudLilOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BWR6+ztclFGd0BU5tY9QqT6QZ20IAdrsqrHLB4BgoiQ14bOvlDc6ejyB+r+K1qbfyN5DmC+ywWGdB1L9otI7UVio/7TMInZcTSKP183uqCRtvG6jRVgHdx+/K0hdXyA/wP5WxQDWoWJbYsJjNLdlL2kqbcXArjAF40Ya7JHe3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc4FGU5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D385C4CED4;
	Mon, 11 Nov 2024 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731343432;
	bh=nG6iTzLFLjsLDmo/ST31XIcMDE99NoMA5MCsudLilOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Nc4FGU5IL/zyOcxlmD9PnplkFpxcMylo57MEO5Ck3ZuPDx/G0RI0Yzc0EXJ7J6N2O
	 bjDzbJTcnZnEPmFmPIL5/ecFoOPwKbJXdbyBsI9e+jgi+6evBkXo6NBeTo+5KOyfT3
	 DBBXTw2/fopDpwj9FlpHfJrxFwgTWgt3Xy0wpqAPKaX9n8QrLXnzuxw/5t6wKg2mug
	 eQP5+ty6ejGfyOPLeRUgI7UBVbXIC0FyY7rd52GOFuJ04h17SoNnoHvMbmWRm1vhOu
	 ryCaKPtg4OB2rPnTBaqbKla9wg5Ww0TJj/sEaLJ9mIHnhUHFmMuONzpFP0wU22CHRM
	 +xu1ZIJPxPKWA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com, 
 pierre-louis.bossart@linux.dev, 
 Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, sound-open-firmware@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241107063609.11627-1-surajsonawane0215@gmail.com>
References: <20241107063609.11627-1-surajsonawane0215@gmail.com>
Subject: Re: [PATCH v3] ASoc: SOF: ipc4-pcm: fix uninit-value in
 sof_ipc4_pcm_dai_link_fixup_rate
Message-Id: <173134342880.341130.18079450114790118970.b4-ty@kernel.org>
Date: Mon, 11 Nov 2024 16:43:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Thu, 07 Nov 2024 12:06:09 +0530, Suraj Sonawane wrote:
> Fix an issue detected by the Smatch tool:
> 
> sound/soc/sof/ipc4-pcm.c: sof_ipc4_pcm_dai_link_fixup_rate()
> error: uninitialized symbol 'be_rate'.
> 
> The warning highlights a case where `be_rate` could remain uninitialized
> if `num_input_formats` is zero, which would cause undefined behavior
> when setting `rate->min` and `rate->max` based on `be_rate`.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: SOF: ipc4-pcm: fix uninit-value in sof_ipc4_pcm_dai_link_fixup_rate
      commit: 9a59718a5340aa0240a442115eb499de2ed18ee4

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



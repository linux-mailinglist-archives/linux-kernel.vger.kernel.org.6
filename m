Return-Path: <linux-kernel+bounces-215604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4109094D3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD0A284B52
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6A18735E;
	Fri, 14 Jun 2024 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib6YR8D2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABB19D8AF;
	Fri, 14 Jun 2024 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718408622; cv=none; b=mo8S7ap/UBaI8DOLfPxubyCSGosbP0dgil7uGYUkQMurfKXf54Q5Ei50QJm9+21gMPwiHtGbqcXqXCTOouoFgLIZcz9sHPtK3hNn4zUVRt3u2gnPrS93Zp06k0OYCAu+Y0w8QWASL6si658uJJMqXmsK02yBnPoFM9ECtzFg7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718408622; c=relaxed/simple;
	bh=NUdjis44A+P8r9hqKdMvkCt7Jj4IXY5URCzPLgFWQaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f2lljSdeC/1JpFqDQGnbQG4uHFGh5U3Z0MxvWXPqMnOlvxosZC5ftNhiNByWb2kbswh8hASe2VYZYU84evUxBXdEQVvcDMIhoRbRXG9+0kpx1KxrSGuLikmFqUuObOuSEUikHNrvNcyXMeNLlMswi+ra1VO8T82EQmxZ97/n9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib6YR8D2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C877C3277B;
	Fri, 14 Jun 2024 23:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718408621;
	bh=NUdjis44A+P8r9hqKdMvkCt7Jj4IXY5URCzPLgFWQaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ib6YR8D2txQiOT/1hRIvvDZQ4hkUJFGvlV3KKqIQaHAvtz8nm0BrTvpSBeGizAi+m
	 WIdeZ1Y7IwOGA6iCN2xDI5OnhqGe3SJ6atAfU0Lepvf41WEqDQG4U0kQgXYuScpMj+
	 yd2nF7kjKdcWsokxaijDY/9/TBvqYh5W7lvqPma6Bd4U2iyrUZqFv3+2kjvm+HfK2L
	 D+AXpycj2Xr+o5He2j5HIdeOVlkSWtNj72S4T3Pfk/Htd+/XP/lCzmNMw2SO2RZXgW
	 oXECI3/UbArOGz0Ynr6XLoO74xYoXgPUfQXlOq35h751xqvrYWh8EFQNKE8oNMu/Y4
	 lMJG+hB5LdvuA==
From: Mark Brown <broonie@kernel.org>
To: Banajit Goswami <bgoswami@quicinc.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: dmitry.baryshkov@linaro.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240613-q6apm-fixes-v1-1-d88953675ab3@linaro.org>
References: <20240613-q6apm-fixes-v1-1-d88953675ab3@linaro.org>
Subject: Re: [PATCH] ASoC: q6apm-lpass-dai: close graph on prepare errors
Message-Id: <171840862015.307440.8711592846059609297.b4-ty@kernel.org>
Date: Sat, 15 Jun 2024 00:43:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-0bd45

On Thu, 13 Jun 2024 13:13:05 +0100, Srinivas Kandagatla wrote:
> There is an issue around with error handling and graph management with
> the exising code, none of the error paths close the graph, which result in
> leaving the loaded graph in dsp, however the driver thinks otherwise.
> 
> This can have a nasty side effect specially when we try to load the same
> graph to dsp, dsp returns error which leaves the board with no sound and
> requires restart.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6apm-lpass-dai: close graph on prepare errors
      commit: be1fae62cf253a5b67526cee9fbc07689b97c125

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



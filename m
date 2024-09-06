Return-Path: <linux-kernel+bounces-319264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1998E96F9D1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F66283748
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35B054648;
	Fri,  6 Sep 2024 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UF+ACxCp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF362233B;
	Fri,  6 Sep 2024 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643071; cv=none; b=fB9aw00HnwWV+zWlD5J7JiMLvKeY6PeFWylV7hIgfLyHJsK5yzKfXRP6HZtRBcnP/5sOklbaqSbeqRF/JGu7cwUKT67chPPRDrXrmuNbCnGRkiocAsF7M9a5Ye9JOhvqRvIS8maYRcg9sQgDpTmI96Wibgv2YPd7RSsIavBATwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643071; c=relaxed/simple;
	bh=kWsF+/BUUgOC3v4X1mMJMZI/wMX1wZO9dj6uEviAxYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e92SK/6ljS8VI2W8uMOk5KNRRPtUCcPF/+B0gCZ9m4/KNQELTPLpoATvD6KMCmXzfbtWRYml4Up4jbu1B4vYjV7L6FRy4sWfY91m0Vi322m2A3vs3apNsi1yeEroAeYKShD5XvzVDVhxuyGypr2OBkC7cvLTPrYcBvQW1b70Kkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UF+ACxCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED5EC4CEC7;
	Fri,  6 Sep 2024 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725643070;
	bh=kWsF+/BUUgOC3v4X1mMJMZI/wMX1wZO9dj6uEviAxYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UF+ACxCpnUJzfIueroGIafGBPWzsUWtNZSRkmLuwNAwngsq46EJvBARmrEYTwSFtd
	 k1eEwQehSMmlv+MAfdpDNlhNkvt9sIHv0ZkF2c4K4Uvq2A5Ft2QECBWGajhC9Ms64w
	 GFGZ+FgO7LeCHZaY/211T+aD6wm0H6htJX0E9A/AtRmyTFyGaN+5KYtCm9M8Y2pFvm
	 /9IHXQp7dM9I6UlQN+W+LcZUnWDuNVwSrdqMcomaXWqkKGv+h6SG6/mquNd0nDsouw
	 jkk0X67/Ds2RNFWAsa7+3xWml4Vl/p66QxlHHraNnKZVIJHaXV2Q+wj4Dr9NdBjnwb
	 ZTVWWVTptu7BA==
From: Mark Brown <broonie@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ying zuxin <yingzuxin@vivo.com>
Cc: opensource.kernel@vivo.com, yang.yang@vivo.com, 
 ying zuxin <11154159@vivo.com>
In-Reply-To: <20240906084841.19248-1-yingzuxin@vivo.com>
References: <20240906084841.19248-1-yingzuxin@vivo.com>
Subject: Re: [PATCH] ASoC: codecs: Use devm_clk_get_enabled() helpers
Message-Id: <172564306815.1104804.1522611474091349812.b4-ty@kernel.org>
Date: Fri, 06 Sep 2024 18:17:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 06 Sep 2024 16:48:31 +0800, ying zuxin wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Use devm_clk_get_enabled() helpers
      commit: 241c044e743f9c55886828763c99b51b0392c21d

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



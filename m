Return-Path: <linux-kernel+bounces-570494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E1EA6B146
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A24C8A35B2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2A6224251;
	Thu, 20 Mar 2025 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moz9M5eq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA915574E;
	Thu, 20 Mar 2025 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742511291; cv=none; b=IcyB7CsKLMdy8/7YcGZnMm1f5GbYjVM5zNk6r/RZu+Ifw1uM8BeYM1XEOvtZ1EOCViMMCWsapr4Ry+ClYJ+5kXrNtO6KpAfEdqFLQD0yTbMygAiHW8fAF6wlHbwn2TucWCz+4wvFQvpq+Y/UHcSpOrukyl9sXg2xe0tFmknWFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742511291; c=relaxed/simple;
	bh=nZPLQ3D+uW+IN0lKkOGwBecX1CKPNktsCOLGMTU1uys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kBjNxI0DIUoVfUb+QW1JB8J2vDQqVrtOZaMLlMeGhnqffnlukSd/pqovyb4BH/KS+G8krImLgn/TUaXwgyRISf5n5eSgpK2tfnYCOqtC4N7qsgGPf1kI+20xxXJuKp2gCIiYSN0Eg47EBni5iim3w01KGn0yKCirXeP/mPH9GRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moz9M5eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6FAC4CEEC;
	Thu, 20 Mar 2025 22:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742511290;
	bh=nZPLQ3D+uW+IN0lKkOGwBecX1CKPNktsCOLGMTU1uys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=moz9M5eqGvtHwYSNUow+2yVsDJyG/hiOjsC9y3M4VqmHk4NAhe6dQSuejPIUYSAvY
	 xSaFVmqHjgKt8XylZ1OKLexMGAHguQqo4UaVYIgrGqQRzqQp+lU185cGmDAjBG04r5
	 DNPM9canzRvHmeTPl20Io6QZcq6Ds47b0YCp5oXa2Jt1WEtayA/2BdboKrh1bRYsuz
	 KwrHBun9AgpnoFG3YQXc0AqaeC6vQU1rNspK1r7V91uKfhzrZIe0dcoIFU5hLf5T7p
	 TLbfp+K1BvAo7W26TuFXrwaVWFFBz8V5g39wahTyBgMQ3Qz/k3k/BWoRGzJbG+124Q
	 65T5X7xuOQcJg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com, 
 kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.dev, 
 perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, 
 christophe.jaillet@wanadoo.fr, gregkh@linuxfoundation.org, 
 peterz@infradead.org, krzk@kernel.org, lee.lockhey@gmail.com, 
 u.kleine-koenig@baylibre.com, cujomalainey@chromium.org, jakiela@google.com, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, kernel@collabora.com
In-Reply-To: <20250320115300.137410-1-angelogioacchino.delregno@collabora.com>
References: <20250320115300.137410-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: SOF: mediatek: Commonize duplicated functions
Message-Id: <174251128562.367646.10336285275014385543.b4-ty@kernel.org>
Date: Thu, 20 Mar 2025 22:54:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 20 Mar 2025 12:53:00 +0100, AngeloGioacchino Del Regno wrote:
> In order to reduce duplication, move the ADSP mailbox callbacks
> handle_reply(), handle_request(), and other common SOF callbacks
> send_msg(), get_bar_index(), pcm_hw_params() and pcm_pointer()
> to the mtk-adsp-common.c file.
> 
> This cleanup brings no functional differences.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: Commonize duplicated functions
      commit: 24489150c5d9afea54c6909ba05c4dbdd8846dc0

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



Return-Path: <linux-kernel+bounces-232326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3296691A6D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D124F1F22259
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE4178CC5;
	Thu, 27 Jun 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOJvLtm1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB0178373;
	Thu, 27 Jun 2024 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492480; cv=none; b=s2y88AAZTAGvGmoNRXl17zPMrUQY627fPzrVspRvbZyz2CH3IQo4UUZJZ0Nr/6PUm68+B/DOQjuvKTJWq4Z2CGCO4tycB+tbSAsLFnPBOmjuw4G6EYf1B2rinEDPAEKf47yoL/Na0SVTszNzjcyHZkELtl8qHmqTHMeuikZdS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492480; c=relaxed/simple;
	bh=ZSLfv18TPLtxO7NM7kuw1m/QWZeg3i2KDlFZOp8uhPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ay9TfSo/mQXSX7B10VOg/0gdOggtiU7Nul591OhSw6eqAQhUhXVd/uoWpmiM4g6SsM3STDAVZc82V4DQZnq11z1+G0JI+zZc3xYxemtOZWhQRwFNo20QwLzPqyNwXaNK+Td0HK1uRfxT3jlJlfQSiMiCIOtRSrDIBZ416y2HIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOJvLtm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B8DC32786;
	Thu, 27 Jun 2024 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719492480;
	bh=ZSLfv18TPLtxO7NM7kuw1m/QWZeg3i2KDlFZOp8uhPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BOJvLtm1GkcoTRy+WOzgbU7r/Oe/0Xz7nvroqA5qLxEgzWByDvUGsa2qMpVrcTPKK
	 7FK8JrKCosMIWiE2y+Gx/KXbnJ/C/eRqb9Av98AV62xyizopNUlqjhyr5O13KawpmR
	 bB32IO/nGX5uE6L2lXNZYCVQxgW8cEK1WrjhlMyyZYVbnvkn2KXA+W7WTSq6wGWN8j
	 DiDAUYqYoTGkHbVaUkp3qDTb+P+rceX5VEb+A6+ge4u1HtIlyqPA1wGgXge1E26CZg
	 HrWi3t6jKAiTIQmHzXwO2RDTsHg9/jRC/d3tMtysaH2P7NMFCrxIZ6NKIJhYmkWIpt
	 AXhkM9FnO25QQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: viorel.suman@nxp.com
In-Reply-To: <1718174452-17596-1-git-send-email-shengjiu.wang@nxp.com>
References: <1718174452-17596-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/3] ASoC: imx-audmix: Split capture device to be a new
 device
Message-Id: <171949247673.260548.13585472243049698949.b4-ty@kernel.org>
Date: Thu, 27 Jun 2024 13:47:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 12 Jun 2024 14:40:49 +0800, Shengjiu Wang wrote:
> The transmitter and receiver part of the SAI interface need to be
> configured with different master/slave mode, especially to work
> with the audiomix module.
> 
> The SAI1 TX is in master mode, but SAI1 RX is in slave mode.
> So add another two DAIs for TX and RX separately in fsl_sai driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: fsl_sai: Add separate DAI for transmitter and receiver
      commit: 15c958390460f964ec707ae6c5d1843638ebfe69
[2/3] ASoC: fsl_audmix: Split playback and capture stream to different DAI
      commit: 6232a7eb1afc842d0daf1c0314e1eda65731783f
[3/3] ASoC: imx-audmix: Split capture device for audmix
      commit: 05d996e113481fdd9ac40ccf5cadabd1e73f2404

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



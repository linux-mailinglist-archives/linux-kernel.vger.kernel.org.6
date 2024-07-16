Return-Path: <linux-kernel+bounces-253815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D89932766
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D15B5B214C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC019AD6F;
	Tue, 16 Jul 2024 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpEoyfmf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262C199EB0;
	Tue, 16 Jul 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136373; cv=none; b=Wh6O9BXN/bSbfDvLIQ73eQ5GLfBzrD0xvJEMdZCppmS8oL/erypPXmu4fMA++US8O+JiIWR0xV8m4z4IdtrObLEGvOUkCMZFj0XDE11hZ5Axfu+XLxFGk4MZR0ZC1oIR267pATnIVLQyTrigrFg0dkO4McoWAZkw1bZcD+FmW/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136373; c=relaxed/simple;
	bh=ySkT21vTP+vCnq+3+S2X02mLqGY2uPTYv5xqJDOVO6Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WRnhmi1JOxtPIHRwF1Pb/5dgKkBMPVy8Qj6bGBpDgSqcdU/nSrLYbpQdW/7dnQ36Y5ze3sjh5U2OyJNHafDU8FU3cWHt11FLRxLyqMZNcs7nMsLxH92rcPRhROUGWe6qScex8u0Erjpj6RoxiKejhC+/bjT71mbEv5nirJ3kF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpEoyfmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EAEC116B1;
	Tue, 16 Jul 2024 13:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721136373;
	bh=ySkT21vTP+vCnq+3+S2X02mLqGY2uPTYv5xqJDOVO6Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RpEoyfmfePptBKszIjFxtC+23upd2iE6aL9KNHcD633vhJAq2RoP3RLciZbJmnbsV
	 ocy+zeaf+ai1zrR46Iigs520DCEywpoLcCzAXJ8UprTpth5QeowefaSYwmqnFnZEKw
	 fh4oJm+eWYS15/+6wDsmaMhp39pstc/a6nOwX/95S6ZuC+0VDD74Uh448jCQ6ALoY7
	 EVEpmXz6AU0nidnHZkZWPxk0J1piDGc4f7z48hdTr85PvYuyf7HT/Gd9rpR9KplYUU
	 quEO3WxLIrDigqHnKNPfqELomdmi0uRIlhPJ78Izt3jVDQrEUESl+2njjMoqfrTKKw
	 8dZUtg3s+pD6w==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, 
 "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
Cc: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 daniel.baluta@gmail.com, kernel@pengutronix.de, iuliana.prodan@nxp.com, 
 shengjiu.wang@nxp.com, laurentiu.mihalcea@nxp.com, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <20240715151653.114751-1-daniel.baluta@oss.nxp.com>
References: <20240715151653.114751-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH] ASoC: SOF: imx8m: Fix DSP control regmap retrieval
Message-Id: <172113637026.45643.5951000884693436336.b4-ty@kernel.org>
Date: Tue, 16 Jul 2024 14:26:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 15 Jul 2024 18:16:53 +0300, Daniel Baluta (OSS) wrote:
> According to Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> fsl,dsp-ctrl is a phandle to syscon block so we need to use correct
> function to retrieve it.
> 
> Currently there is no SOF DSP DTS merged into mainline so there is no
> need to support the old way of retrieving the dsp control node.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx8m: Fix DSP control regmap retrieval
      commit: 2634f745eac25a33f032df32cf98fca8538a534a

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



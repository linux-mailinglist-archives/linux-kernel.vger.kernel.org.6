Return-Path: <linux-kernel+bounces-285021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A9095083A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71665B22E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD11A01C9;
	Tue, 13 Aug 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1iQzcJY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8B18B499;
	Tue, 13 Aug 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560783; cv=none; b=JO+M3ZJIlpQ1l8Q9JU6+TKKeJNpMxQH0Hwe53xqO3JkmWBk76zwlkOmcMpZg5qhPH+Yl8W22qOlpWLerFe2ZwLdfcD/vf32uLeS90c9oZkD1cRfaUFo4O1P5Gu1AxiNv9IZIuEpBkKcWF/Bi2ZBWZA+QK7/aD+zT03D/k34pIXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560783; c=relaxed/simple;
	bh=/cDaT9MMZ7PXAGsvzduJNxiq9wgQt4bUH8UgICoMreY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eNd90LrJ6l0w8aVBpsAeGxSTLvisaw3KvYn6ytbwlwCMI7rWyDCl91WD7Rl1YlYf7n1gxeJF4hFKx4Dw+5BS4F+NZE8L30iTtZItkwPbw63QK85n0FAPT/qClIMfRnadTQF2xrO+3/LDidamjK9AMg5frNNxkdr5mLzFRcUffDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1iQzcJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4F5C4AF11;
	Tue, 13 Aug 2024 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723560783;
	bh=/cDaT9MMZ7PXAGsvzduJNxiq9wgQt4bUH8UgICoMreY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p1iQzcJYssZzZcK91NoTPOY5o0F0yzRU9O4/B1TcXOkx9PlrxWGIPAFAMdjRFlHAs
	 RTHqCr1REzfRgMPUgElmvU50Hycmv5I5iX7+JMJy2K0ybLQFv0uzYE08d5PUdqcayv
	 TMTcHltSBt6Y+/MH4KxKwLQD+ahYlsseo0sCM63IrxIYSHYzGMRgyOGoRiQOurA6ey
	 wtoHI3lt1Uz/TbcO/uBCjPywPuorpcY3LqZP6exZqMIkKDefrSZYOO3xXo/lTo8OQ1
	 a/ifJyopkUzV2UDWlUUDMrA8gvwmUaKaTMW3r6S/oZ5riGoSNq8fIa/7BFxBaqWgXG
	 lmIGuv44dqdcg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com, 
 Basavaraj.Hiregoudar@amd.com, venkataprasad.potturu@amd.com, 
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, 
 yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, perex@perex.cz, tiwai@suse.com, 
 cristian.ciocaltea@collabora.com, Markus.Elfring@web.de, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240813105944.3126903-1-Vijendar.Mukunda@amd.com>
References: <20240813105944.3126903-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH V2 1/2] ASoC: SOF: amd: move iram-dram fence register
 programming sequence
Message-Id: <172356077984.62411.5834566001022810605.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 15:52:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 13 Aug 2024 16:29:43 +0530, Vijendar Mukunda wrote:
> The existing code modifies IRAM and DRAM size after sha dma start for
> vangogh platform. The problem with this sequence is that it might cause
> sha dma failure when firmware code binary size is greater than the default
> IRAM size. To fix this issue, Move the iram-dram fence register sequence
> prior to sha dma start.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: amd: move iram-dram fence register programming sequence
      commit: c56ba3e44784527fd6efe5eb7a4fa6c9f6969a58
[2/2] ASoC: SOF: amd: Fix for incorrect acp error register offsets
      commit: 897e91e995b338002b00454fd0018af26a098148

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



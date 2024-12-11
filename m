Return-Path: <linux-kernel+bounces-442046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3356F9ED754
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA9518818D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C412210E5;
	Wed, 11 Dec 2024 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tD6AQSah"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45B209695;
	Wed, 11 Dec 2024 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949498; cv=none; b=Ev2F1Ohud8Ty4rtd6mrpVCG6AM7AOMWytF8oHQ10HKKanNuqblZw69aOlqXM2QQ+It/zfx0RQkV4UGnVh7raXChb7tRmYEd0GJ0mekbZn3p6vTUhMrrOltmVrLjmBv7soonLnSfDIvbN2Zt/T4/5kyxleU02MTrMfDC695QizJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949498; c=relaxed/simple;
	bh=U3TTKecYbJu8CPW6jwuij629ZrlvUeHH8MPaClL5ufw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ApC4HExWhgvUm+9hJzMtesleKnNCvRHD5wzuRE8AiMHLkkIK037MQXTT0xtMUWcw2gbl+ksmRx4Cs0oYHMhZ2RgAFvgkBTqTb5JrQU2f6HWPfHBgrzylDx+8kmDYaSVNc8SqmHTf//6nw2fhqc5zy5u1zcwOcHxsN9FKbkQVDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tD6AQSah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEA1C4CED2;
	Wed, 11 Dec 2024 20:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733949496;
	bh=U3TTKecYbJu8CPW6jwuij629ZrlvUeHH8MPaClL5ufw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=tD6AQSahKTAfHW2XREukl+XNlyNF8qI5xqQqpGNqOYXXGC/cJdWVYv/Br/Ki2NMn1
	 racW/EbjfBW9t6GjU3NSU3xvdBN94u0TUGRTH16C8S9h6sdVWSJBBSzpFDFQ2X+pMi
	 8Cg0OM3CS4j8TMCWZXJ70AebZMAQ+IinSC9v9rnrPmu6ji0HwehjIlXKE105p1ucHb
	 6Kz3mj4CYL3scDkLndUV0rTkBOITiHASKk87R7znB0qdeqquhFJPi/2P827Hmi46y+
	 7EkbOULSIG1RYG28FQZleMAMsgOVf/+RceVRC383az3FMaZrX+76S7flIEMy+5Mc07
	 6IVfmeLUKuo9A==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20241126053254.3657344-1-shengjiu.wang@nxp.com>
References: <20241126053254.3657344-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 0/2] ASoC: fsl: change IFACE_PCM to IFACE_MIXER
Message-Id: <173394949437.1491700.15212046480843342137.b4-ty@kernel.org>
Date: Wed, 11 Dec 2024 20:38:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 26 Nov 2024 13:32:52 +0800, Shengjiu Wang wrote:
> As the snd_soc_card_get_kcontrol() is updated to use
> snd_ctl_find_id_mixer() in
> commit 897cc72b0837 ("ASoC: soc-card: Use
> snd_ctl_find_id_mixer() instead of open-coding")
> which make the iface fix to be IFACE_MIXER.
> 
> if driver need to use snd_soc_card_get_kcontrol()
> the id.type need to be IFACE_MIXER.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_xcvr: change IFACE_PCM to IFACE_MIXER
      commit: 7c17f7780a48b5ed36b6d13a06004fac993e75af
[2/2] ASoC: fsl_spdif: change IFACE_PCM to IFACE_MIXER
      commit: bb76e82bfe57fdd1fe595cb0ccd33159df49ed09

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



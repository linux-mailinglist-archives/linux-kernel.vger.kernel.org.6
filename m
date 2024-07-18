Return-Path: <linux-kernel+bounces-256526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFC3934FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAFB1C210C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40E1442F0;
	Thu, 18 Jul 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDiKjJLy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A52A8FE;
	Thu, 18 Jul 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315612; cv=none; b=dbjgey6e4NeV7fSeWqLKxw6BIeL5qvuLqs9oFjCAm8+v/0J4nWZ4YXqzM3uUxOgvAzzwYY2dtcmU3XfmspC0HNNTfuaFA7k/2XQydj2YD0D7AMqDeSzcY23P6N5L0fAha8IOv3DX7i+8sK1NxSJnEPpyvhBrjofUUbe/0qMYQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315612; c=relaxed/simple;
	bh=oWv1oGl/GTLJXgxvgrl4uvx3M8z/wDMz5cxH6HjEBFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W3u92pwGz1dIhssp11VxifSiOjIFkJQFCNVbLsWvnKjUEvF/0znMX8dD2NXU1wrJfRKjVuRk+WKt+fDTNIkcPzWdJYd0rEA8/Mnv+Ui2wZEHkMjpNKp1BwSjhxcFeo/hdS4EK1hAfTWty3nu097TlHRysavh+3qz0+AGF6jHWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDiKjJLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37863C4AF0D;
	Thu, 18 Jul 2024 15:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721315611;
	bh=oWv1oGl/GTLJXgxvgrl4uvx3M8z/wDMz5cxH6HjEBFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VDiKjJLyay2P55bNcVqZKBQqtjm75AqLk52Qd/EoDF6sAQo9nFkLDj/YmgUqNiw/S
	 EspfbUPrA4X9B9aAU/eIAB46e7gCmT/+C09q56+moPSvJoNZWXgkzy6opPeqD54oYX
	 yqNQm1l04zKjovLvbrPtAzw9+Yt3hEGQM8P3+0rXBY9WIxauCKarERyP6hWFMI26k3
	 IJBcmMHZZ2SLG8MQBmqWrEhewue8kUknQh9YAWvlRjVB7whZdhCAamzP96++pqZrhv
	 avFnhB9WMm9RS2900Fq6ngikRr/S4/qLshaiv2mUvi1nmw7ozXD5SFVt0fJACH07JB
	 DZHftEJEzpkWQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240718062004.581685-1-venkataprasad.potturu@amd.com>
References: <20240718062004.581685-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: sof: amd: fix for firmware reload failure in
 Vangogh platform
Message-Id: <172131560794.82656.13194361470516878188.b4-ty@kernel.org>
Date: Thu, 18 Jul 2024 16:13:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 18 Jul 2024 11:50:02 +0530, Venkata Prasad Potturu wrote:
> Setting ACP ACLK as clock source when ACP enters D0 state causing
> firmware load failure, as per design clock source should be internal
> clock.
> 
> Remove acp_clkmux_sel field so that ACP will use internal clock
> source when ACP enters into D0 state.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sof: amd: fix for firmware reload failure in Vangogh platform
      commit: f2038c12e8133bf4c6bd4d1127a23310d55d9e21

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



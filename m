Return-Path: <linux-kernel+bounces-372465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19809A48E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D57A1F23F52
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1721618E36C;
	Fri, 18 Oct 2024 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlnL/VDN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5CE18CBEC;
	Fri, 18 Oct 2024 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287041; cv=none; b=b710Z+S3EpPHH1yCk4C8RvcLGCsfP/LT5/m4yzye7yZKQqU8BOzAm5K2ro/yltyF2EDqIO40NghiK/NJgxLO5Vtkt6nEBxNHXqIPh5yoFlxysmdQmRZQcKRgxMeFNytbrSHaAWe44juwGcsDsbbnkjROMo94JMvpmy3iD6qroyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287041; c=relaxed/simple;
	bh=fRDd/xAaQiNIntNWabElOUsWdfWNnSZkxRew2pucmek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PC/H65I6v/FZgAaciim+CPP3oG57J51nO8MYxUiYrMPYOxl70vuRn39rffm4X/EP2A9TM6zxeNSf4bHFagvX6kP6B166R7gzbdzgIlDLJLMUBnRgJX2mJ+4FrluSfZ6QZx/qkyL/xkSRbt8YoXYOGd6GPuXGOo1FNW/DUsmqJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlnL/VDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCFDC4CEC3;
	Fri, 18 Oct 2024 21:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729287040;
	bh=fRDd/xAaQiNIntNWabElOUsWdfWNnSZkxRew2pucmek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mlnL/VDN/D6y/xdsDKcstQiEG8ivZ8AfVl4YldfeAhRN/L5Z8O9JUbS5/ma1P2Jtk
	 au7uwYzJlt9BKqpr6DCeiJ56WRm67ed88+IlIcVO6J1ytRdIKOOGkMmw3oRPn4MrzI
	 VlCy52pOPvRqc4v88XrH3d8DFnPtSTOWLTNI3M5XgJd6+4U+im0owOdJ0A1gQ7ob+Z
	 DQPFbSZTHOu5B5CY+fdNZl0GVpCJ6s2Qw0hCrp1Fl2PAcQUEv8N8py6rH6pO1Dtma9
	 MfyZpbXyPZtAjbSwUsKwObiRO5UkmoX6c4M6Wq//pQkAeEghjaAgIJ/fxQTgBThnum
	 Yb5AtNw37q41w==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, vkoul@kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, pierre-louis.bossart@linux.dev, 
 bard.liao@intel.com, ranjani.sridharan@linux.intel.com
In-Reply-To: <20241016032910.14601-1-yung-chuan.liao@linux.intel.com>
References: <20241016032910.14601-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC/SoundWire: clean up link DMA during stop for
 IPC4
Message-Id: <172928703885.212383.18274357800270627734.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 22:30:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 16 Oct 2024 11:29:06 +0800, Bard Liao wrote:
> Clean up the link DMA for playback during stop for IPC4 is required to
> reset the DMA read/write pointers when the stream is prepared and
> restarted after a call to snd_pcm_drain()/snd_pcm_drop().
> 
> The change is mainly on ASoC. We may go via ASoC tree with Vinod's
> Acked-by tag
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: ipc4-topology: Do not set ALH node_id for aggregated DAIs
      commit: 9822b4c90d77e3c6555fb21c459c4a61c6a8619f
[2/4] ASoC: SOF: Intel: hda: Handle prepare without close for non-HDA DAI's
      commit: 6e38a7e098d32d128b00b42a536151de9ea1340b
[3/4] soundwire: intel_ace2x: Send PDI stream number during prepare
      commit: c78f1e15e46ac82607eed593b22992fd08644d96
[4/4] ASoC: SOF: Intel: hda: Always clean up link DMA during stop
      commit: ab5593793e9088abcddce30ba8e376e31b7285fd

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



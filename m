Return-Path: <linux-kernel+bounces-332590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C379F97BB86
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1E71F23118
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79659291E;
	Wed, 18 Sep 2024 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPXWnrZU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32D17C98C;
	Wed, 18 Sep 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658461; cv=none; b=g7sWBIWuWwwM99A7Z8A3IyIe/swCPO871n6MeZxfUoFmwGsfr2BlBWP+Q5reLiRma2pqmb11MYmcM311MzGGIzMQ3ZHfr+c3vylf0oSi+mQAHFzWH+VtP/irYTpEV1RZ9AVnpoOLrNDnm8nUmBJc1kL4oICHcabsgJuRtoJMHII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658461; c=relaxed/simple;
	bh=Yj8yguq6fHMKpfy6cIyL/hq3Tishf6iAF3akjLIRzAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I5QGbSpbcpuNLnFKaYyDL4raN3rFMQMsVm+kJPiuFVrmOHwDpDRFP7FHSbQu8Thti4d6xgG/o+JudN86/sQk5to4RVm045mVJgiXjG9DwSmLVp15qRJ29ZSuDPTBM74guDnS7NtFSBDaRVf4LKQx8R4L8y94nTwCKSd4fH9NfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPXWnrZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAE1C4CEC3;
	Wed, 18 Sep 2024 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726658461;
	bh=Yj8yguq6fHMKpfy6cIyL/hq3Tishf6iAF3akjLIRzAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RPXWnrZUdCoH7kRrmZTLDcNq69Us/SfDSGuGYdpss6MCaDCz+FWMbG4pYdnV40pIU
	 kvMFA6NlCbwqGgkAjZDX93glz69CIYYmuU4MIhh+x1RHDmpL6x5bkWEwqwD6wY9NeT
	 LsFu/HPjU+knmG6EaaFb8WPnlt4na4hlUNe1ssPZ6hA8W0zN403g3vQb7t7uVoHwXs
	 6Q3T9pLxzn6qpM40Va23Q+hjdM1D2CaMeYRAuSlLccvvKkeoVfln24NcbitzBvn7/O
	 3AzKWoI/BSP/nvMEzUDbf1dddoi37NfgqxMEjxg/wns9yEggEMhKndxo5fhvjdAXJc
	 DJaqZK2lLbNLg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240916061318.3147988-1-Vijendar.Mukunda@amd.com>
References: <20240916061318.3147988-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: don't set card long_name
Message-Id: <172665845809.1795214.7985418215228293070.b4-ty@kernel.org>
Date: Wed, 18 Sep 2024 13:20:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 16 Sep 2024 11:43:18 +0530, Vijendar Mukunda wrote:
> UCM can load a board-specific file based on the card long_name. Remove
> the constant "AMD Soundwire SOF" long_name so that the ASoC core can
> set the long_name based on DMI information.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: don't set card long_name
      commit: 8451a3c7879d8883fd3fbd9dd7cbe7ecc31e89ce

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



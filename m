Return-Path: <linux-kernel+bounces-372467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6439A48EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A53D1F25C48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B139F191493;
	Fri, 18 Oct 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXJ1kJu6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681E18D640;
	Fri, 18 Oct 2024 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287047; cv=none; b=GOg6Fv3FSM43btVCMyaa+/GJ/6ymj+DPsVBZ6/KGNlbluK8uMkkj0i4EeESes7cUYHhW4oNtZbm9sKHMGGjUGbXFidNUy1C3hLdLlbGY6sHUIgPZIksfPpW8PyenUPI9CTOKjO3yd3SrT8NY06QnpGNbIPQDyLyUaN5q7WO1SeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287047; c=relaxed/simple;
	bh=q6yelh/uOWVywDnkiEhm9rhs3QgNDHyY/K5DwGpxNFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LpPjSXNTsvfsKmdsdNogtazT/7XU7WSUbE+fxYAwMPerZs41sPmk8fe9KSs5Mr5FbQdty0AGc4gyTOwC1bQP8hJQPs5u6mI3B6HGKPwyvkl3QlUmk1q+EjkBtJgAniR9A2bTj8o0fSDEgQVMNFL/v8cDLdrc/SoJXLSjNyDyvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXJ1kJu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D83C4CEC5;
	Fri, 18 Oct 2024 21:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729287045;
	bh=q6yelh/uOWVywDnkiEhm9rhs3QgNDHyY/K5DwGpxNFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kXJ1kJu6hcr/Vy0iid+LjYDMFgiux3nLQvRKynZew8KgLADkLIMsjyO0usmQ0xqMJ
	 KbMLsesmdW18iJkjieohQS//H9xWFfSZMZjsqh5j8b5TDm73i9Pt6VEF0TTbiTxpkt
	 u2lNFLFVWBLeN2BEyL15DgyUs7yJpTpsg8a99/CR9cijHif1awEsmuhGLqpaqsS4la
	 MTSET349BPxZPvpv4MgsQ/lIh8ePz4wN4bkHio9/7DKLeK8eVFtD1mhIXfBh3zHiQe
	 Cz4hiLiEIOnG+YOHNaAgnHkcB/LcE8MkklOe2Pna8OCZjbUO8RyUUekPgbcqxaHhvT
	 dOE5h14xLOV3Q==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, vkoul@kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, pierre-louis.bossart@linux.dev, 
 bard.liao@intel.com
In-Reply-To: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
References: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 00/11] ASoC/soundwire: add initial support for SDCA
Message-Id: <172928704383.212383.14774577964808301941.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 22:30:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 16 Oct 2024 18:23:22 +0800, Bard Liao wrote:
> We need to get rt712 version by reading SDCA version and functions.
> This patch series adds initial support for SDCA and add a helper to tell
> if the codec is RT712_VB.
> 
> This series may go via the ASoC tree with Vinod's Acked-by tag.
> 
> Bard Liao (1):
>   soundwire: sdw_intel: include linux/acpi.h
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/11] soundwire: sdw_intel: include linux/acpi.h
        commit: f35533a0e60946ee3fb8adccf8a36024c6f1fe40
[02/11] ASoC/soundwire: remove sdw_slave_extended_id
        commit: 4b224ff80d6609811ec6ab5406a16c92825cfb1a
[03/11] ASoC: SDCA: add initial module
        commit: 3a513da1ae33972e59efeef7908061f1f24af480
[04/11] soundwire: slave: lookup SDCA version and functions
        commit: 0c673d2862534955241f339d7331f384b5ea44af
[05/11] ASoC: SDCA: add quirk function for RT712_VB match
        commit: fdb220399177177917dce52063b326a191a35a02
[06/11] ASoC: rt712-sdca: detect the SMART_MIC function during the probe stage
        commit: 9aa6df9cb82e8fd44132c481afc76eb7a7dbc398
[07/11] ASoC: soc-acpi: introduce new 'machine check' callback
        commit: dcf4694f200a67784e053eb5d1d70a191761ff4f
[08/11] ASoC: sdw_utils: add SmartMic DAI for RT712 VB
        commit: 9489db97f6f0d78c26eef8e7fc9c1371cef97b82
[09/11] ASoC: sdw_utils: add SmartMic DAI for RT713 VB
        commit: 7d6f2d5254b1786c8b3bd64c6295b14e1607965d
[10/11] ASoC: Intel: soc-acpi: add is_device_rt712_vb() helper
        commit: 5703ab86ff7bf079aa1ddf7a65b9727d0249383a
[11/11] ASoC: SOF: Intel: hda: use machine_check() for SoundWire
        commit: e92edcf8023d425c7abcf1d7abb5dcac53d106f5

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



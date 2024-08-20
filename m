Return-Path: <linux-kernel+bounces-294301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E9958BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1742820B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A70A196D9E;
	Tue, 20 Aug 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEHVLSqu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28F1917CC;
	Tue, 20 Aug 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169806; cv=none; b=H9r9NAJcOnGXR1X3JgRqXU6xXpHSTqR1W2W2GFzy2paDJLNn6fERM5O430I5YQwAl/sY5DeaF9uu3g5UjrfwK4ODyAyaLnLbWJCHakdayFAEHaY5SD+MQSCRk0mc8aIy8tyBtVIRjv1pAS3G3dOGEvx8aCd2BMCZtCqFSn9XsfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169806; c=relaxed/simple;
	bh=FM/6slYqkUzhEFqy4cFsVFigikMsa3+XDaqNAp6RoJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y39Xkq2VwogqyO+9BbL20GxuOpS2omqJmr/+YXxh27rqivSwY/i6xMR/W5p66b8oIJtIvNTJkBXft7A7a9c/au+TyXIrmgoVhRWuYWjKiayYkCmGrAI2rcO2uVKo6+ubTbnMaR1fa32uo6Q4Bc9dJQqckQNkGbRxbaBDyamkqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEHVLSqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B025EC4AF0B;
	Tue, 20 Aug 2024 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724169806;
	bh=FM/6slYqkUzhEFqy4cFsVFigikMsa3+XDaqNAp6RoJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TEHVLSquwf9Ig5CgXWKGLxZ+TqKYi5Qtp/qj9KwEgmJ2v3G1DbuDsjRF+WrHSGCD8
	 W5TjO73j3fHSmsgSI02xCD/zgg9U47996m+hCuFFLagBGpz/GY6rjLFq4aVmtuZIhK
	 Es4JwxSriOx+6kjnYI6X6kVMcDlpFsGIQRX1+ngU53SM7YUXpPm/0X5lHKMKpATl1C
	 FUnqIFjg1R5b1UmnHeo9S0eDk/OJDgesjitp6PVd1o1ZeO8bqaqpZ2Sec2Be4hQfGv
	 bzJKHYwQpLK+cPdjBRNcKm9AKGDMRNzXKk4WJJl/m7m6Kl/fsyR7HMPjIMtqsMlVqv
	 g8eFm0ctdbMVw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, cristian.ciocaltea@collabora.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240819061329.1025189-1-Vijendar.Mukunda@amd.com>
References: <20240819061329.1025189-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: replace desc->rev check with acp pci
 revision id
Message-Id: <172416980343.391665.2003933347335223810.b4-ty@kernel.org>
Date: Tue, 20 Aug 2024 17:03:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 19 Aug 2024 11:43:29 +0530, Vijendar Mukunda wrote:
> Replace acp descriptor structure member 'rev' check with acp pci revision
> id.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: replace desc->rev check with acp pci revision id
      commit: 1004f34d4f4a59aa5508c3b96069759efa738544

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



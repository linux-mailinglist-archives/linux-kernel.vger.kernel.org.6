Return-Path: <linux-kernel+bounces-328591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7509978641
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0F91F2430B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2048811EB;
	Fri, 13 Sep 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odY/Np3c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D333374FF;
	Fri, 13 Sep 2024 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246490; cv=none; b=BB4N5d2tEaeZjijS7hPwcEWGpdsC+7TOMHuRzXmZWEVgdI/kwcfHhqweizksrB37LkPopFv5D/1pf5nkidrmGWsCJfj+vzlYaMHVLxy4Wht5KsRf/aCXs/COtNIBRrRPZY8FssH7b/MIrOMncDE9jiFkykTHvtvDHVep7KH794E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246490; c=relaxed/simple;
	bh=2KDVnb1mVoYZypPCGHyU3wETUgQJZHVz0zgPgKiRHYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WuscWtLihNz1xAkLtF/NRV6+H8QQlv/hYTo60Y+ZzUFUvXwwBUutVyZGS0Jp1vbV2/MNK9V8Itgn0UuCpXbXYb7wdAEJQ3ehmv26AVSrj90xSs+EgARr+1W+Pad9BySZxMIP2jftN0jXDvDV8CCndDw5c7PQSXeqrguHEOYWjY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odY/Np3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7245C4CEC0;
	Fri, 13 Sep 2024 16:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726246489;
	bh=2KDVnb1mVoYZypPCGHyU3wETUgQJZHVz0zgPgKiRHYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=odY/Np3c3Gzd5x2Q4jugOAU9hIffgYQcI2j9IIqzDC8hh6KoiETUl68HWd79j6pTd
	 jf+XSs8AMJl7JCqaVsBC4AuibrZegs4eh6O+YO7LttAEBJtuk8siM7PcJwfOqav3kP
	 Vw6Jtn2R39G6rg0vr6KY2XAIJ9rTtprH1uZ4BuKsBxCTLhZdeVz4ujmh6Gs4Xhgbmx
	 bNsT04YbJFCKajSiVNpIJtqL46m28JNiEgoQ6NFBORi8Wydiqcl+atlcFCzMsbB3D+
	 4V+Gss6CVxBhiYNYiLdvsZs/1ORfbCEiLguYNw8qa8Tzjo2cM3syClFO2GKpjS1dyG
	 gpEsAtXK4UqaQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, kai.vehmanen@linux.intel.com, 
 ckeepax@opensource.cirrus.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240913090631.1834543-1-Vijendar.Mukunda@amd.com>
References: <20240913090631.1834543-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/5] AMD SoundWire machine driver code refactor
Message-Id: <172624648667.60960.3648714524641692495.b4-ty@kernel.org>
Date: Fri, 13 Sep 2024 17:54:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 13 Sep 2024 14:36:26 +0530, Vijendar Mukunda wrote:
> This patch series moves common Soundwire endpoint parsing and dai
> creation logic to common placeholder from Intel generic SoundWire
> machine driver code to make it generic. AMD SoundWire machine driver
> code is refactored to use these functions for SoundWire endpoint
> parsing and dai creation logic.
> 
> Link: https://github.com/thesofproject/linux/pull/5171
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: intel: sof_sdw: rename soundwire endpoint and dailink structures
      commit: f5c05fd7e9d20a3a8f3401b467fec2d24f49ea5a
[2/5] ASoC: intel: sof_sdw: rename soundwire parsing helper functions
      commit: 23f020bd607b7aec5f301699227ed196430fbc40
[3/5] ASoC: sdw_util/intel: move soundwire endpoint and dai link structures
      commit: 7860df5b29945cfab40dd667f576af31401d7c43
[4/5] ASoC: sdw_utils/intel: move soundwire endpoint parsing helper functions
      commit: 13b24f84782d6c0373f62eb645353883d94d1dcd
[5/5] ASoC: amd: acp: refactor SoundWire machine driver code
      commit: 6d8348ddc56ed43ba39d1e8adda13299201f32ed

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



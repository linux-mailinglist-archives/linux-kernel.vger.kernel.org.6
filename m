Return-Path: <linux-kernel+bounces-285020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A81950838
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA231C21200
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6C1A00EE;
	Tue, 13 Aug 2024 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivc/z1rC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E818B499;
	Tue, 13 Aug 2024 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560780; cv=none; b=YER77G9L8jIfz0HcshDneRTNHU/pbq5BIEbVTdCEW9GsbmT7U6T2L7V7YDqJIM46NFevc6K0pQyCIXUfgK0MgUQWXXFojahM8NkButcrYonFaTEihbXsRODwow2wWfxBv6NWru12vydBuXyf0YxRGAY51qPLzngdb9faZooNo6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560780; c=relaxed/simple;
	bh=7GeuAkDztQNplE6PjsDW4V6w3YAvYYPSKCwdxojbmZg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=feFjkydhL2/gHBXlCFCx6Gz4ajqewyXIf1LR7krLg4sSKc0IBC54EAPxKBHlFom2XU1k/cVVJugCGEFudzRSHCzlOWoClvJMbIvzABtJusPv1Tcg63bV6zZNTDpmCp3g083Av2i28IedvSvnwtOwd78MHVV8PHEzPLxr/pkxyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivc/z1rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57597C4AF09;
	Tue, 13 Aug 2024 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723560779;
	bh=7GeuAkDztQNplE6PjsDW4V6w3YAvYYPSKCwdxojbmZg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ivc/z1rCksasX0MTqTWoh5kIzd6Rw2+9rIY7cyl0EOmrJVJWhP+QTmqR/f8FvbKhZ
	 1qBJ+MoB6TcvzV1s1kJcdL/gCn/4LmEgLRDvaDWR3jHh6EACQL/QoMVMwtNXA71Ij+
	 SR1QIPdcZwqBgqSfcqCyMoIXsdCR5Ts85fWkS8w40DZxCUGdfxqANaXpCjga52+uMy
	 z+aggXNt8KN5IStsClmk7wMVQLOR1JE+lrbKB97GGXEqIMawwDUzXx5HAVJsoZ5g/y
	 w9l2SQfFGuFkbhy9fhCaazsOCdVmK+kxfZHhG1pfnb6YvGH8JxT8jaEwIey2HKaPTZ
	 RXnAIm/o1conw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com, 
 Basavaraj.Hiregoudar@amd.com, venkataprasad.potturu@amd.com, 
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, 
 yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, perex@perex.cz, tiwai@suse.com, 
 cristian.ciocaltea@collabora.com, sound-open-firmware@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kai.vehmanen@linux.intel.com, Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <20240812110514.2683056-1-Vijendar.Mukunda@amd.com>
References: <20240812110514.2683056-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: amd: move iram-dram fence register
 programming sequence
Message-Id: <172356077609.62411.17348863586201066528.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 15:52:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 12 Aug 2024 16:35:09 +0530, Vijendar Mukunda wrote:
> As per design, ACP iram-dram fence register sequence should be initiated
> before triggering SHA dma. This ensures that IRAM size will programmed
> correctly before initiaing SHA dma.
> 
> 

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



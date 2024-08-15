Return-Path: <linux-kernel+bounces-288455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86BD953A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E1A281CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472C27D40D;
	Thu, 15 Aug 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYqmUYQd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E83770ED;
	Thu, 15 Aug 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747225; cv=none; b=O+Sa3pMWgzClnj6YQ/ZoACgo5+P86ecSUOTOTkWVOSV+abNbHl8Dl3U2wX1CBAcpoWQk+kTX2ZwFWc59mALC1tst5y9DVoSZy0c8sur7zrPQhIT8eAMj3s7BO0W9oPY0sKAnu7Q1h2+dEiSydbkZ2flqdr1JqtRjB2nBYpK30kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747225; c=relaxed/simple;
	bh=D1ePwj4HA3MeqLcBwpMTSoEjH2UlYSWEiVdqjcDWGCA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oRSXdfsXn1jHQ+LbrnUelL//40miD1nXsaj5C+K78CZhFBffgbiLBfRrYunViWHLpSYgB9gFzZY4sU7YF07vbbcbTXaTUD+UKgdO8bVJKI98+MZ1wJIoLc6fp3n9sPLeO83ydiaiufSNodjUG+mPIGarsFA4ptW/GlCpcoLmqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYqmUYQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11825C4AF09;
	Thu, 15 Aug 2024 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723747225;
	bh=D1ePwj4HA3MeqLcBwpMTSoEjH2UlYSWEiVdqjcDWGCA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RYqmUYQdMMsMpgMi3OfmmzuyeXDSMlBKTGdsqsoeGBoCp+7/YeuHWFXOxdo3YXJ54
	 9jwCjpUJRq8Si2hu6EYqAWZy7LWphLrNeHgu3CLmcAexDwJHu9k3DmtIZXfnIiNUdO
	 pHdNj50j342lSjwizToJ8OauFM7iGq5UfucPr8Ob+Hsa1DSj9LqghVIWGpbHWY3QL+
	 jqnDf/bXufrSApA5juA0bqM1GFabfIaLurlKiL9D/Sweb0WLIBB+PcJ6I3D9oRMTzD
	 4BIX1B0Ic6YgDWCxM+Rvzxt2270+Wi8rE3RMDcLQIctAwx6GfCOoXlSh/4R6pBDTjX
	 88szodBzG3q/w==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Yuntao Liu <liuyuntao12@huawei.com>
Cc: AjitKumar.Pandey@amd.com, Syed.SabaKareem@amd.com, 
 alpernebiyasak@gmail.com, posteuca@mutex.one, tiwai@suse.com, 
 perex@perex.cz, lgirdwood@gmail.com
In-Reply-To: <20240815084923.756476-1-liuyuntao12@huawei.com>
References: <20240815084923.756476-1-liuyuntao12@huawei.com>
Subject: Re: [PATCH] ASoC: amd: acp: fix module autoloading
Message-Id: <172374722278.94796.16026585204554130425.b4-ty@kernel.org>
Date: Thu, 15 Aug 2024 19:40:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 15 Aug 2024 08:49:23 +0000, Yuntao Liu wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from platform_device_id table.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: fix module autoloading
      commit: 164199615ae230ace4519141285f06766d6d8036

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



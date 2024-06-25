Return-Path: <linux-kernel+bounces-228738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49729916644
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC311C208D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB5C14E2D0;
	Tue, 25 Jun 2024 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEp6bcX6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CDE14C5A9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315238; cv=none; b=MvpDl5d8J9rkwlVTTsiBJ1fef2cfO7SiDl6juZfoz+4Nm0fdtWiyPt08ohYj4vpprR7UfTE7CvCZBk9aA+XLI5hfK6oom6fkiQHqNcdXvz0gD+FE/jpBOwI5Ljl84vhM59VomjRMtyoRqURTTn/73u/nRH6w3TSYePuwr08xFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315238; c=relaxed/simple;
	bh=8hGDqALa72DGfTvkkhudJJF0q5sZIpRhO2CA+FW1mns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aC2a78Sjzf+opKEakGRDmlmD8Vey8DxBAX6xt9Xq1hmBbbb0Ggegdj7NqA9HNvbcV6wYdmLofQTnGXxPSTgP3U0uksiPRF6hB3+nZq+Z6tD/w9050tiacARA6MrBu8lImbb3zu1ri4ug4XZlQ6RcVQQ31JuuGOKNYHylZ0pW4Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEp6bcX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418A2C32781;
	Tue, 25 Jun 2024 11:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719315237;
	bh=8hGDqALa72DGfTvkkhudJJF0q5sZIpRhO2CA+FW1mns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AEp6bcX6PnlRu8gb8oZBfRc72mvhqpdoL2f8YzjfrqwAoT0jw9qcct/gKhCZC4ZhZ
	 sMj1G8gk2kLGERhyYTBOyUnMnh/B4M5Sp+FD4M8YTaP8YJBDsZdOsOUr9i0msrlg6j
	 QXj0zKRN81oBhepi1lKrcuuQki5DvARxHEWrhlMIICguL3pgkyFHCq07Nw6HJWt8Nn
	 KjeG2kc29LgX7bx8TBV53h+crl/sWjvjothoTE6nb7TuiM/A4iY7Aiq4AYsCwsTioi
	 ANncir6psWysfoln2gr6FJ8AZJ5qMLX58jhmD6cGkNGbDrZtqZqeS1jN+GLYz8SBVi
	 SGTBj6P2N8w4A==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz, 
 pierre-louis.bossart@linux.intel.com, 13916275206@139.com, 
 zhourui@huaqin.com, alsa-devel@alsa-project.org, i-salazar@ti.com, 
 linux-kernel@vger.kernel.org, j-chadha@ti.com, liam.r.girdwood@intel.com, 
 jaden-yue@ti.com, yung-chuan.liao@linux.intel.com, dipa@ti.com, 
 yuhsuan@google.com, henry.lo@ti.com, tiwai@suse.de, baojun.xu@ti.com, 
 soyer@irl.hu, Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com, 
 cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com, 
 savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com, jesse-ji@ti.com, 
 darren.ye@mediatek.com
In-Reply-To: <20240621132309.564-1-shenghao-ding@ti.com>
References: <20240621132309.564-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoc: tas2781: Add name_prefix as the prefix name
 of firmwares and kcontrol to support corresponding TAS2563/TAS2781s
Message-Id: <171931523198.64144.6255900977380836517.b4-ty@kernel.org>
Date: Tue, 25 Jun 2024 12:33:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 21 Jun 2024 21:23:07 +0800, Shenghao Ding wrote:
> Add name_prefix as the prefix name of firmwares and
> kcontrol to support corresponding TAS2563/TAS2781s.
> name_prefix is not mandatory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2781: Add name_prefix as the prefix name of firmwares and kcontrol to support corresponding TAS2563/TAS2781s
      commit: 00dd4d86ed908e70d912a96ad91d1248ff055b62

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



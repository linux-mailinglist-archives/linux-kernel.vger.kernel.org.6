Return-Path: <linux-kernel+bounces-272981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81883946305
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37F91C212E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEB116BE1A;
	Fri,  2 Aug 2024 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJirmEhS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F52166F3F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622876; cv=none; b=QvIn3Z3NL72PRgnOHOZ3ukAZRzV6vmi/wUGF0iEiCxa1eVcCv9CykIgLKlkIUtKbwMKJbneVgSebre6ZWbVclotsYwl9zi9YAdkI5RSbkcQ59OjtsyNv9P1P+bOpq1W8QCBFiXWRwEU+p5Cd/89PJ6LdLwCU1BDmgVbj5OMjNyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622876; c=relaxed/simple;
	bh=CawFQq0JzNWd9rAAFylss7w6aAw+SMvSoc1d7h2tRyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PoY4EFv0MZg4wedZxPNvXz/h/pvInEd79agTicgWU04eyHGpm+5PBtHvCoKjS/pnWUoA+xGaUNpQGswpH5sBsnS+LAPJSPx+vUVU5Y8Owohy841zjdKFWzskxXyjMAXKIMO8Z0o/TQAbY5SPetQONjJsrgEf/dtnHTiTpRbwKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJirmEhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16925C32782;
	Fri,  2 Aug 2024 18:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622875;
	bh=CawFQq0JzNWd9rAAFylss7w6aAw+SMvSoc1d7h2tRyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cJirmEhSuJ0jCCnvoF/y3V3uaJwxr/+Ki/NYvGI5gH+ftaBcaQAy28OCxrrL658OR
	 0gxG8uim/Qq6btGYQlhRd/d8Nc8yqpUdEC/nvn4fxN05FNrOz9FhiTIPFgE9hx6cUu
	 lC7URGwoR/DonRwZZh/loyb3mLZK1hLY9tXpI/hBaWVPFgG1DyLvQ8q8wBbuFbhjw7
	 yxcRAscleI07hyNAGC1Vq6BmClil0goz+tTBEMGJoHPQldsXZ574pIUFjtcllyexPT
	 lxtAacIEy45T111cuUqEYCYbCWmkjjAJyOV0q8/uqLFugeUYq3VoheL5D1jxYbNW8t
	 4y6M81Qb0ZuZQ==
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
 darren.ye@mediatek.com, antheas.dk@gmail.com, 
 Jerry2.Huang@lcfuturecenter.com
In-Reply-To: <20240802072055.1462-1-shenghao-ding@ti.com>
References: <20240802072055.1462-1-shenghao-ding@ti.com>
Subject: Re: [RESEND PATCH v2] ASoc: tas2781: Fix a compiling warning
 reported by robot kernel test due to adding tas2563_dvc_table
Message-Id: <172262286781.83468.4726261083691249080.b4-ty@kernel.org>
Date: Fri, 02 Aug 2024 19:21:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 02 Aug 2024 15:20:52 +0800, Shenghao Ding wrote:
> Move tas2563_dvc_table into a separate Header file, as only tas2781
> codec driver use this table, and hda side codec driver won't use it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2781: Fix a compiling warning reported by robot kernel test due to adding tas2563_dvc_table
      commit: 92b796845a4a8789c2d9434c6a77baa88a99121e

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



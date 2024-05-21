Return-Path: <linux-kernel+bounces-185114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 574BC8CB0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5A9281839
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E8142E7C;
	Tue, 21 May 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkTyRx2w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCB142E81
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302713; cv=none; b=DOwqrHZU9LqrNFeU3MHXFlRSEu9p+XtDd02MOVAUUjiqLKX6FW/wfGgupHQ5mt1CzwjbFQgKGvANChJNkb2/Y78Vj8fV0PhWApnHyLMVFuAfdWZvzeRFu6eND+1wrnXC4W/5bVS6uMFVzcSwgZuy9nV4CAVaZGW8lqdCquh3mjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302713; c=relaxed/simple;
	bh=4DcvWiiHMokzPWaXAObygjBZsmZTeXy9YYkbru4eb+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GoMNhkVGnM+kFSlwpq6hiNCBaQh0UiZMZKc8LXp+9elPrJHu4fAzu81GlW3GERWMlK3WHx4/msJD6EAhYaJ/UqYK4dSeHXMRBnY03F0skXXp1dp3E8oLOHS+/xY7TqC6KNYHtFCUqW2WFfyukf3kMtBLQVVvZUDz+we7J4ZQeOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkTyRx2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012EDC2BD11;
	Tue, 21 May 2024 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716302712;
	bh=4DcvWiiHMokzPWaXAObygjBZsmZTeXy9YYkbru4eb+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WkTyRx2wIT0j3Z34xfG96pAdQ6GRglag861QCawrIjSfQfv3Kjw9PgbyGdMxt4OKS
	 OTsTmJaVNRnj6L/2Ic4St8BHlJWPaStdU3nkyMv+53Zl07JSvekPa2fccDWr5L2RL3
	 peOs+G7TH3fLcDoW9EQ31LRkPVXReH2u+72/nNFWrscrBxXs553khx36oh1bg1uTKB
	 z1/DqzwESq1C2Df4SIQ9c3QYGHuLvs0mcGmZNCG9OfQMmaSRbh+DYhxL6CcTrbnVSD
	 PwTDMEn32YYMJ4nP90ppJVZvJVuepH/FynL8190c3Swk1dEzqK8qd2MZFgqP6dPfBt
	 dl36q8HDBuL0g==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jneanne@baylibre.com, eblanc@baylibre.com, 
 linux-kernel@vger.kernel.org, Neha Malcom Francis <n-francis@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com, j-keerthy@ti.com
In-Reply-To: <20240521094758.2190331-1-n-francis@ti.com>
References: <20240521094758.2190331-1-n-francis@ti.com>
Subject: Re: [PATCH] drivers: regulator: tps6594-regulator: Correct
 multi-phase configuration
Message-Id: <171630271072.58585.18250109896090255820.b4-ty@kernel.org>
Date: Tue, 21 May 2024 15:45:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-621fa

On Tue, 21 May 2024 15:17:58 +0530, Neha Malcom Francis wrote:
> According to the TPS6594 PMIC Manual (linked) 8.3.2.1.4 Multi-Phase BUCK
> Regulator Configurations section, the PMIC ignores all the other bucks'
> except the primary buck's regulator registers. This is BUCK1 for
> configurations BUCK12, BUCK123 and BUCK1234 while it is BUCK3 for
> BUCK34. Correct the registers mapped for these configurations
> accordingly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] drivers: regulator: tps6594-regulator: Correct multi-phase configuration
      commit: 74b38cd77d3eb63c6d0ad9cf2ae59812ae54d3ee

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



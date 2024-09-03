Return-Path: <linux-kernel+bounces-313933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3668E96AC86
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82ADAB2196B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FED91D5CDB;
	Tue,  3 Sep 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH0ohxE1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF7192B68;
	Tue,  3 Sep 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403833; cv=none; b=ITqCb3Q0Ts9pcG3gqGBx6zXHOS8XwSIREr4q6LVNoES8dQPSUDHxzLNzbN5WuAGY1abenfJ3QzS7J4dTG/o6C4nYCBJYsGUf9lrQsm/A/gnfJdTT91hh90cRj6xgR1fmNADsSn3ACSPMMEpw6V3rXbt+gOpoTwPQPlkYJbK6EFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403833; c=relaxed/simple;
	bh=/PwOf1ix35LtXpWe66PVTiKhMIdPspb3Xf1HdLILmwY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uHM1HwL0t05Dd641iEkXyl+knEvIOFp0mN3cAYkFo70x9cp8Y86T5AHndEJNRulYYH5JaTM2WRF4xlpjeZvUekZt16QDDA06WqMaXnVTI7+oGhYrLgPygZvXlhOINRjqAKZTENyLnklAR1XlVpPHucxXIlWsNX2K6zAnVaxOwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH0ohxE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB84C4CEC4;
	Tue,  3 Sep 2024 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725403833;
	bh=/PwOf1ix35LtXpWe66PVTiKhMIdPspb3Xf1HdLILmwY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UH0ohxE1zuZ3SoQeABy/unwJLGSIorFzM/Jf9qHcvXYc6W9n5gvnZs3ihl/Mr0Wu6
	 qTEb/Rawcbi8DjSaL/1CframWJEkZ2gRQfRvoFy6g6Tgp1fBthcPpfT0kS4RySX7hU
	 BgaY5WGWNG/c+zDcmDWPGWIVQQYu9LMl11+ICJmnzm1nyIsnuvCuGn/L6CGGI78hmT
	 92BFR/OnZZL6Rjya5DxZY9Vbn5Scu/6geJPCCXDb435IQ1cBHpyz8CYJiQGSOaYssO
	 2c/lJJq9sPyx4jLAR3w39MPMZDWjHhSCBsFipArBZKpPiC+fAU1yEyZ2fIqTkcyUlL
	 NGoBrOsKgN/nQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 tangbin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240903090620.6276-1-tangbin@cmss.chinamobile.com>
References: <20240903090620.6276-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: loongson: fix error release
Message-Id: <172540383156.163502.13746231189597948905.b4-ty@kernel.org>
Date: Tue, 03 Sep 2024 23:50:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 03 Sep 2024 17:06:20 +0800, tangbin wrote:
> In function loongson_card_parse_of(), when get device_node
> 'codec' failed, the function of_node_put(codec) should not
> be invoked, thus fix error release.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: loongson: fix error release
      commit: 97688a9c5b1fd2b826c682cdfa36d411a5c99828

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



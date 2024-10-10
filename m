Return-Path: <linux-kernel+bounces-358847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E315998494
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDF4282B26
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EED1C244F;
	Thu, 10 Oct 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9hYjoi4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECDC1C2439;
	Thu, 10 Oct 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558844; cv=none; b=DKnyiSTvBWxXVefKfaRzQpiPL0w7PtkTvpYuMIjOiH+tSK26inU9HWGV/J1zjIPt1DeR+hjI4fGvanPmfqNj8oFY/lym11kduUNfpsMS6CjxaXfcOKUA6hxWYHYPh+hJlRtxNjH6bQP46PMhqVDfZfJYF4DVZ41QN4WLZT6Fq4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558844; c=relaxed/simple;
	bh=Ddg6EIHl2NK2TWwpLSpCiLRnzSOXb2j+tOrgi4H3kNQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RxArb8MFsB6qPCfVregSKI1B9XveM/bt19tJfZxsana+N5eWvY4qrq+tWmRr8HZdaDjNsmlBi+3uN9EoKKy2/Xs42C0YmeEl7LBEnSj8ga0H9aw6TwWXRhKXadciCInuI245aCqjR2kp3t0NCsDn6KViRX/561mcw9Hl4OcAjpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9hYjoi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9622FC4CEC5;
	Thu, 10 Oct 2024 11:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728558844;
	bh=Ddg6EIHl2NK2TWwpLSpCiLRnzSOXb2j+tOrgi4H3kNQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e9hYjoi4esKau57f1oEKp9lqpR/lez0vbpaW5d+ZF5sd/1SkhZ/OBiEIdThHIh1UW
	 YQWtB09DSlenWQZMf072e5F5Gya5EvCrnIbmBvJdCbDK53P0Jx3EV+GQuFqjHiw4y+
	 7Z9VaDwVDG6i1wawlzDnZXAbzH8nB0M9UKDjScueA+z43Su+ArEaqtk53N81YjSE7M
	 N29UNeWJfuWEnTU6DtKL+/re4TVEG0ixIi7Wxx9EK1MRIU/oKvN1ZebGVs6wNSYDBV
	 ZaL7ocx+BbF9/4GZTyI28Cf5ygEuMBcv7UKeZJfipn1RbYQB45C7dVccEbBPP+q1x5
	 3yDpCOS17BzYQ==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: tiwai@suse.com, wangweidong.a@awinic.com, 
 andriy.shevchenko@linux.intel.com, heiko@sntech.de, 
 kuninori.morimoto.gx@renesas.com, nathan@kernel.org, 
 u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, lgirdwood@gmail.com
In-Reply-To: <20241008025923.10606-1-zhujun2@cmss.chinamobile.com>
References: <20241008025923.10606-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH] sound:aw88399:Correct error handling in
 aw_dev_get_dsp_status function
Message-Id: <172855884130.3258793.11914506844337433857.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 12:14:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 07 Oct 2024 19:59:23 -0700, Zhu Jun wrote:
> Added proper error handling for register value check that
> return -EPERM when register value does not meet expected condition
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound:aw88399:Correct error handling in aw_dev_get_dsp_status function
      commit: 53189ae7aa1eeabd937c7a4d1f41e40513597d2c

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



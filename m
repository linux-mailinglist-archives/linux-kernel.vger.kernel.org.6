Return-Path: <linux-kernel+bounces-297627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDE195BB97
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8391F2175F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ACA1CDA26;
	Thu, 22 Aug 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egYjdcXN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9501CDA19;
	Thu, 22 Aug 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343444; cv=none; b=FvFJOdBO5t4E1pUTX0zAdv6/CgpkmbrJglZwk18Fh7UPxCsLxu3M8dvDjnX82rm3frFbeY1T4ZsIWK1/MccHpeSqzuFxeCRSoDFnpfjMFtf4IpJp9QVOnP+GLcW5ed49czLJDVIa4CcwnKLN7SIwYqWfueMXq8FAGC9TKDb0LpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343444; c=relaxed/simple;
	bh=fpHmEMDUJlobT6BnM8Q7a9kfIIAHfyAJxCshLGZLMLw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dVWCmhaTxfgGRAQ8qZzFiKFgvQUOmEHKETsfa9nUTpr0iYZ1Kt0Lf5vVMGDxtJi+6nNWz1tnaZRBj+GjwssxBJ3TIkcfI7/ilQ2BoYp9YJYHoinpBu0LXLCozBc9DMa2UIrj+/+cQ4oreexPWH6QIh+yZJiCNvmnAuIn0TezGmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egYjdcXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF35C4AF0C;
	Thu, 22 Aug 2024 16:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724343444;
	bh=fpHmEMDUJlobT6BnM8Q7a9kfIIAHfyAJxCshLGZLMLw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=egYjdcXN/Y74/t8OqAxD+lWEiuJQEvq3UarlKicw2k2CVB2JRAg/bwbEjxmAEHrDc
	 X8ohIORWJNVu+CGTmJeevhQcC4K2PGy0Y69TAaXYEnSG188ltUZaypH2rQXU8vFF2r
	 SDxqfdnReq9jL5SJcOCAAjniMPxu1aPq5TQDG1/B2wwo1s5AEAQVkosCnTgCYi9RAA
	 uQs5CPHzH6wtp3Xa5M+6WTmaVgm7niUypliPgK4yuUAvpVvAGYlpBw1giDxk/4faI9
	 b097XROc/aCdXdCObE9zobOjUUZ/sqEuXe1YFtr0oSLn8LfpWMa1+zq6sg2xq9LIZn
	 V/BwUzlIlCw+Q==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Wu Bo <bo.wu@vivo.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Xingyu Wu <xingyu.wu@starfivetech.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <20240822095249.1642713-1-bo.wu@vivo.com>
References: <20240822095249.1642713-1-bo.wu@vivo.com>
Subject: Re: [PATCH] ASoC: dwc: change to use devm_clk_get_enabled()
 helpers
Message-Id: <172434344101.724373.7008343292226699330.b4-ty@kernel.org>
Date: Thu, 22 Aug 2024 17:17:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 22 Aug 2024 03:52:49 -0600, Wu Bo wrote:
> Make the code cleaner and avoid call clk_disable_unprepare()
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dwc: change to use devm_clk_get_enabled() helpers
      commit: 23618f5b630a1dde8c465150ddb2fd308b686b08

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



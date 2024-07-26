Return-Path: <linux-kernel+bounces-263595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C756593D813
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCFF1F2363F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5D17C236;
	Fri, 26 Jul 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxg7YK7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A42D611
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017686; cv=none; b=Fw5lXc49iQfeuMaKO/HZ+920qLFWUIcBolyUsz8QdoB66WnXac7qlevJXQFq1NcgtppxV+51S+O92PWptHeJXWtF89u7tKSHpJgSQYIzdAMvH8kW0ymlOCLX7rzXr91MqYmTVCGTyoNtTEoSvhc+Wz9ymBGGKvntg0cbuVyfaUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017686; c=relaxed/simple;
	bh=fXbrlGhMSm+MxbrzFbGyM5lDz8shybjYiKyqW7PfKcg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E1hckCVhMLSlveOOGPRizp2QLiMBl2zvejxOQe7dX5hAThOAFSdq6NvxgjQhpURg6OKNuP3AY8rcAU9Qeun8zBroJ5u2MDVzvFEOlm920hRcRJsO5zP94WQ61SPeTPlFRSdL4dIIZI+r4uet/0C84tKRVod+8v3H/pdgwS/l7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxg7YK7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5874C32782;
	Fri, 26 Jul 2024 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722017686;
	bh=fXbrlGhMSm+MxbrzFbGyM5lDz8shybjYiKyqW7PfKcg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Wxg7YK7iZv/1oD68uFODQ8mxN4U52WYBEpTV/4L6C/4GzF9MNX/qHZ9dhnkaT/Clz
	 QASq6chz8vuiaOtDpEAlmd5B6aRM7qK4KGDNrz+IwSFlQO54GhdOQR1OZzv5RW2yCA
	 PqGp7Gj5XMjZBELbNnUUkyaOQ5aKhVFFEz3mvjGsqAVMnodw7B3BPpDLxmuVvLAHkG
	 vJtHObnvWqaU/OgHpd59xHdbnVqjEfNTBIXygOiAA/d8FHpkYYFFSAwKCSXmGkoF9g
	 ZVlJ6+OKKUYKHMeumGcoRr8POVRWAh8xI2+qzg+ZDPubUbCzWW0SSdhOdupMBB1Ifx
	 B0F8DlbAi3W3Q==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
In-Reply-To: <20240726-regulator-restrict-rzg2l-v1-1-640e508896e2@kernel.org>
References: <20240726-regulator-restrict-rzg2l-v1-1-640e508896e2@kernel.org>
Subject: Re: [PATCH] regulator: Further restrict RZG2L USB VBCTRL regulator
 dependencies
Message-Id: <172201768463.94264.240372570015709112.b4-ty@kernel.org>
Date: Fri, 26 Jul 2024 19:14:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 26 Jul 2024 14:49:41 +0100, Mark Brown wrote:
> Since the regulator can't be used without the USB controller also
> tighten the dependency to match, as well as the default.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Further restrict RZG2L USB VBCTRL regulator dependencies
      commit: e975d955c07cbc2cd6a83a5d8235d8373441fdb9

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



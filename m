Return-Path: <linux-kernel+bounces-382082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CCA9B08DD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDFB283E06
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B2D166F33;
	Fri, 25 Oct 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRpYTP+a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B715E5CA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871335; cv=none; b=QkFXD85atkGddNejko6zGK11dcnrBEoljGuXZ3y0SURz09YK6SIY+jK9HTOvfau1p5fuKMaNVrXIAL90r+F3dKmXzrTZ9uHsxZtn0V7TV2mG5TTmIPFHDa4BTHBbwg8avnJyMzNVZrQm/Xn6hPl5KaSJS/CQ7t9lGp3cxcV3KTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871335; c=relaxed/simple;
	bh=NHcWrPVB2LjuUcSEWiU64nd/OISxQwwIxCrbQWi/YEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EYF95UMkBvOoY27KfK3hO5qIRKxxJZR6rckOXITHdsXfGV6voazEtAlE2bnvnhLzx6FOsk8wYEzQTi4ypextV+E8+TAp/geAFk7rDL4SmrPY3Ke5c4YxwR4+ynACnIF64QRtrhN3DCjzythlziHywQASOWfkMk8zGs0Qz+kdRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRpYTP+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC860C4CEC3;
	Fri, 25 Oct 2024 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729871334;
	bh=NHcWrPVB2LjuUcSEWiU64nd/OISxQwwIxCrbQWi/YEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vRpYTP+anjLOFNYt4fno4GonP+spFnVCjNjnpe8SXsZCxx0sAf2rvkblW5sGJvCOM
	 3vVVgyYdf92sQQS2ZF1N53knzBOCRLFO2QHEn8GlkoQ4Gy+7Hc/ZhlAXcfTGUpjotX
	 kGIA7B939Tv6s0go6rts5GUWk2fLO5CcQTJBScz9Z8hru1/bmA57GPbhe452ATfxq/
	 pOqhyMkT+mnZuZhvl6+FOCJELtAs1ccvSqYf6133/ZmCNG80FQN1Gt69SHesba7nlf
	 hRd9pAk2QSQRiyRr1KCcHdFoV1eqonI8D5oTbqHJV41GE0vNJCUFRxoLqoQU6gf4SH
	 Jb1NZ9RTz9HbQ==
From: Mark Brown <broonie@kernel.org>
To: cy_huang@richtek.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <00d691cfcc0eae9ce80a37b62e99851e8fdcffe2.1729829243.git.cy_huang@richtek.com>
References: <00d691cfcc0eae9ce80a37b62e99851e8fdcffe2.1729829243.git.cy_huang@richtek.com>
Subject: Re: [PATCH] regulator: rtq2208: Fix uninitialized use of
 regulator_config
Message-Id: <172987133352.67892.5725433691534758485.b4-ty@kernel.org>
Date: Fri, 25 Oct 2024 16:48:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 25 Oct 2024 13:59:18 +0800, cy_huang@richtek.com wrote:
> Fix rtq2208 driver uninitialized use to cause kernel error.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rtq2208: Fix uninitialized use of regulator_config
      commit: 2feb023110843acce790e9089e72e9a9503d9fa5

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



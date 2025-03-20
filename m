Return-Path: <linux-kernel+bounces-570185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667A9A6AD3A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDE3464DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1872227EBE;
	Thu, 20 Mar 2025 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVClTaj1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F828227E9B;
	Thu, 20 Mar 2025 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496348; cv=none; b=aBOmMtJLwdq14IcBgTNrUKaloZYMdCIklUIBFTjskc0Q9TWR66Ufj6PTvUmAMbrCEdpklG7ie5HXxe9TWmi3uAdvRGvjyB1fBJfE10YqqQsw4hECGIcFcu9sDLfRCrtQUmWEnBTwCYes2+asdsC0uKZKfNyGHr8e/+5EZVbXOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496348; c=relaxed/simple;
	bh=ZoHdoe5EKPucw7bkbS5YLIg4iMAhvkDsJwWntTI17Aw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BRETtNDf7+gilfVgwBipqTNCpRfFGSX3qh5WbKIh3jNZHiUgXgub/pMMmndgHUUBeaLftMVV20Aw2Zo7Of54m8ygyULJmAegdaad1eVIaExmAHbLUZrmlO6fxrL2gqY50QDbsAiDjZqG25LcmTMonGR/wCCIPWEVi+JiQGIRgtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVClTaj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F34C4CEE7;
	Thu, 20 Mar 2025 18:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742496347;
	bh=ZoHdoe5EKPucw7bkbS5YLIg4iMAhvkDsJwWntTI17Aw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dVClTaj1BrMjMDi0Fz5uuOdoS5icFCdTxXKSAmj4FyrEiJ/QkTBqlePC3plU8ikm2
	 qJhlGwnFw1hcihOMhfOVBZpFCysJGilrd2vml8RkvoLFhyYAfmKXwa32JRC9Z4Nsep
	 RKSqbMIHMHS7RoyyONBrZAaglzUmsE/Q+scZmoA4gRuZOrOx28B1sEO2PG2A8BuVzU
	 cXNZporCXVDIQJLcYdsIg3CHQmoTTusE+hrwJVO5p/JIMdaonr3oekrgvKHkmK8dz8
	 thZCMscwvXnnsI4gpLSRhLJMV5tlft6ESY9lFSmL/TQ8UIljJTfEKJy3VVRvsa9sWo
	 BGKPh+mtH8Ong==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20250319175123.3835849-1-ckeepax@opensource.cirrus.com>
References: <20250319175123.3835849-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/3] Tidy up ASoC control get and put handlers
Message-Id: <174249634647.174081.3060239685612080268.b4-ty@kernel.org>
Date: Thu, 20 Mar 2025 18:45:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 19 Mar 2025 17:51:20 +0000, Charles Keepax wrote:
> There is a lot of duplicated and occasionally slightly incorrect code
> around the ASoC control get and put handlers. This series add some kunit
> tests and then refactors the code to get all the tests passing and
> reduce some of the duplication. The focus here is on the volsw handlers,
> future work could still be done on some of the others but these were the
> ones that most required attention.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: ops: Factor out common code from get callbacks
      commit: 1e3cd64a29baa874b89180ac0744178ecb00f3cd
[2/3] ASoC: ops: Remove some unnecessary local variables
      commit: 94dfe71f0a4eb0d7df542560c22961dedf45141d
[3/3] ASoC: ops: Apply platform_max after deciding control type
      commit: 502a668fad12b6ca10bcbb615d62e61d3b669c99

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



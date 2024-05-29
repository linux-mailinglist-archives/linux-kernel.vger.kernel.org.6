Return-Path: <linux-kernel+bounces-194013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C538D3560
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A671F2608F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31FE17F375;
	Wed, 29 May 2024 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms4/gzHM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007217B432;
	Wed, 29 May 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981682; cv=none; b=jk6Yi8XEJ25lgodqCF6I5ZQeVecIjzkWhcJ9mGbWXUWAugo7Pk9euxaZw21PA2rtiCYzE7NwaAe4d3lNlWDqrvBeae2JBU+otOf/AC8ntdcmDhoLeqhQL8jvfQ1cauzItcsn2hkBixP6keax2RfUqB2vvddlzjlGEN448fCw9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981682; c=relaxed/simple;
	bh=MRWCI0ip6MvTxBSaQ8UZZpNFmVRFMlh49DopolhbX30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XtpidPjBc01RP/lVYn9cRXsTwnq9nRP6fZN7YqsNgXGhtoxjb7qnlsdu5Xtu2AwwoQnCQfds9wHD5s7ADXZx6WbfZH6dkJTc8SO8OrSOd2Iz1n4k9fEg7w9BYhb7uAfr2NaRnWJgNfjROVmuHzBUayi2GqqIs/hLzDOn45cVCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms4/gzHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0ADC32789;
	Wed, 29 May 2024 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716981681;
	bh=MRWCI0ip6MvTxBSaQ8UZZpNFmVRFMlh49DopolhbX30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ms4/gzHMjeqDy1SLNFdpCILEr6F3nuEjZxJJ+aV6j6KApxHgfYEfdx7NfQLguqSzK
	 vDv3sPSzrIILSmHCuLtcK6T00ga6+THVO9B7WEp71r0y1LC53II2eFC+UKAg4A6/9c
	 JQ1Ch2nvTtDuub5Zli3758+rK4Z7GhQ/cfJFB0PpOGtPTJRpjtHWDMNB0e2vizwp5I
	 Ydr2Pr0ufGVpk7xCxVqAk3OYAmqGw5qgwE0fzj0ETCFVzkGV/vZllbGLwWCDranKuK
	 6UPsEECiqHLNnmDFM+x3QTe5+T8nb/pzBhJ71TuMY+78fleVMcybLO0TrW0Q0Cw2/y
	 MKQyLs8QQRvqg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Alina Yu <alina_yu@richtek.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 cy_huang@richtek.com
In-Reply-To: <cover.1716870419.git.alina_yu@richtek.com>
References: <cover.1716870419.git.alina_yu@richtek.com>
Subject: Re: (subset) [RESEND 0/4] Fix issue when using
 devm_of_regulator_put_matches and add compatiblity for both fixed and
 adjustable LDO VOUT
Message-Id: <171698167961.48637.2854482112702924988.b4-ty@kernel.org>
Date: Wed, 29 May 2024 12:21:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-2ee9f

On Tue, 28 May 2024 14:01:12 +0800, Alina Yu wrote:
> There are two types of LDO VOUT: fixed voltage mode and adjustable voltage mode.
> 
> As the fixed voltage for the LDO is outside the range of the adjustable voltage mode,
> the constraints for this scenario are not suitable to represent both modes.
> Therefore, A property is added to specify the fixed LDO VOUT.
> 
> In this version, a software bug has been fixed.
> rtq2208_ldo_match is no longer a local variable.
> It prevents invalid memory access when devm_of_regulator_put_matches is called.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/4] regulator: rtq2208: Fix invalid memory access when devm_of_regulator_put_matches is called
      commit: 72b6a2d6506843375c7b91197f49ef38ca0c6d0f

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



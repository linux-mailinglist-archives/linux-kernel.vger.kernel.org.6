Return-Path: <linux-kernel+bounces-241698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01181927E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 22:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5891F245BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E5576050;
	Thu,  4 Jul 2024 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6IzO+3u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BC414AA9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123212; cv=none; b=Zjd4odWJ+49XTRIIQlzuPQU3M8OkLAfmyCvC6Vf9voOIn8f/6RJWBxXSP8KG5m3ySvWIrVP08SUtVuUlA3ZGku/j/wFRlqAVgGUT3k52mTdYpGUArJcO8IlD/xcigonO7zi2R2zOZmo1C65AZI3NlVNSs/rvdZkz92A3qSPbwPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123212; c=relaxed/simple;
	bh=Csc5MsbsEyLuNfkh2wCe32CpcbgQ5UEZ2i7ZZ9LoNq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J5wd77kIdAoJVeKF5hXH+QYfv+QJ4ndbIxZjZiwKGw8W6gjrUfpWWkYq+WwrXHi7MlpJqAitK8sT2uGwXAl080awfgomi8TWJli7l1sa/nT1cMcOGi95QoI6S+hCVVcPqagdkinCvJNX5JsDhdyaiTPNpEGRtdm6v7183wlARX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6IzO+3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF421C3277B;
	Thu,  4 Jul 2024 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720123211;
	bh=Csc5MsbsEyLuNfkh2wCe32CpcbgQ5UEZ2i7ZZ9LoNq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H6IzO+3ujVDZgZLJm+QWcHXmEUUN5OV/540PccnYKmNEIRbx7kdmB/PfkTE2ZWaqJ
	 P+1ZT3WDvq0rBDiacMdWi4MIc+a6MHMEz5MnwDa+L8+9LaWTMixV4pobN5B8oHIaD3
	 QfUdMk77aY5i2VmYQ+lgX+L3bypgu/43fvMU83pRJ7yNldYB3htlY8iMlSCPwUXuOm
	 Nu+mOnQPdg2Aqfh4VXEb0n37nDVtNSHAKZ6iGcHTPwDSkMNUKpCt8f2zp6qVQ6Xa9x
	 w4xbe6eUeGlNhxRhdcIgDQfQQBL8vxVEbmNSRVqZ4VRVQSx0ptLf+43EsDHwD2+DhX
	 Vs4efGzAAIGOg==
From: Mark Brown <broonie@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240704-regulator-const-regmap-v1-0-bce0ddef63ea@gmail.com>
References: <20240704-regulator-const-regmap-v1-0-bce0ddef63ea@gmail.com>
Subject: Re: [PATCH 0/2] regulator: Constify read-only regmap_config struct
Message-Id: <172012321044.121848.14079522267513199767.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 21:00:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 04 Jul 2024 20:13:06 +0200, Javier Carrasco wrote:
> This series adds the const modifier to the remaining regmap_config
> structs in the regulator subsystem that are effectively used as const
> (i.e., only read after their declaration), but kept ad writtable data.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: da9121: Constify struct regmap_config
      commit: 05db2e27b92302a43f996561dbb58ecabc3cc85d
[2/2] regulator: max77857: Constify struct regmap_config
      commit: 32d1171014a74c788218e0a8a5fd6fef65fb10ba

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



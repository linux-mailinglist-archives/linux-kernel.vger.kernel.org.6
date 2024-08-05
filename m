Return-Path: <linux-kernel+bounces-275065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F80294803E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813C41C22A86
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A9E2C684;
	Mon,  5 Aug 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0UYHWl0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D115D5BE;
	Mon,  5 Aug 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878781; cv=none; b=Ku27lK5+K9g6UO0+7Ub1PpFOxJ9YFuyraQA2c0Sy9LM9F+T2UQH+VLLXsqt9AcGcprB5evUA1I36Q1QL5TS7OLX9/q2pIanHIpCJPqei2PqT1nyrB9Saa+i6UAifl6PTBY4UO12zmBrk6Ury/1B/GbX1xA0RUwMCRraEOdoUr3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878781; c=relaxed/simple;
	bh=bOd564Wxxulsuy/lIm4hsAotpsnUz/4g74nRgkbzHrA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p9LrS2KjfiRCSlRJoXPDJgotk+i87xEF5qshn4PZ+HhpvzlS/TWe90ssHvTr+E8pGqrZ1WKTkGVKWxErCsmyJzarkATWl2KYpld8n81vI6DbofZekhpKQniUZXWZZVrig853dYoWidMRIoMt+ahC9CLBe3I/G1MMKH4zYF68I8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0UYHWl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B67C32782;
	Mon,  5 Aug 2024 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722878781;
	bh=bOd564Wxxulsuy/lIm4hsAotpsnUz/4g74nRgkbzHrA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=l0UYHWl0NsXw9cqo2Sbj1JXzi+2sFaCl9LCEE3loIRM8h21VMYZS99eI2w8OFtt3B
	 EXndj92tKLWhvkpVPJK2KEkoi0CkcfK8pDMO+p9EyLvKjlYQ9keueJG//SxH9A/6Zs
	 T592SF4Tvcn0E+EMmul56B9+2DqOJvxSYQwCsRou0i+dGPJoyUeH0eC/2PoHuOQPxa
	 MU2B2HIONcIZAK8hQfPkhDCPNf8NxuxjfAk1sGcaUWE6PyZhLZMvYe+53wAnb2YWva
	 BwTpItJV24hDfts2eD0i6xz73rh8KMU536P7xbz++n1/1dzPZ/XaGjwQZbOCpX+rop
	 BZ+F2clpyI77A==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240805114222.15722-1-rf@opensource.cirrus.com>
References: <20240805114222.15722-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs-amp-lib: Fix NULL pointer crash if
 efi.get_variable is NULL
Message-Id: <172287878052.48428.16665134497957791363.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 18:26:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 05 Aug 2024 12:42:22 +0100, Richard Fitzgerald wrote:
> Call efi_rt_services_supported() to check that efi.get_variable exists
> before calling it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs-amp-lib: Fix NULL pointer crash if efi.get_variable is NULL
      commit: dc268085e499666b9f4f0fcb4c5a94e1c0b193b3

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



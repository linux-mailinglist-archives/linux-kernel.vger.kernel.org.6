Return-Path: <linux-kernel+bounces-409554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1909C8E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F5A28A00D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32319A2B0;
	Thu, 14 Nov 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVNQnGG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C019D09F;
	Thu, 14 Nov 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598565; cv=none; b=G55SfOHuYtqACerGQx5BChub+aZxkxEFQPFQxCGbp34UR+1EknOZ9qwsAyUKgVoRIMN0bXLyNbl3qIp3p3T4qv22fqIIEYiLr9czN3GPBpYtLrI0L9+wYm0CHaTBxWgh/PjFH72jv81pO4bmaKXbJFToeDy4xqXkCRBqMCU6oEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598565; c=relaxed/simple;
	bh=c+QtyugjOQ3i5dvHqnYIoLWX152YPjrTGXRzntFQuQw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s/w4KE6t2a4yQpQQqayCYmeKF5PkvQusMNvmSCrPDFPOigZo3/CThiWF65PPdvfhWz7aNKp70PqNXSOAbhF0qZx67KUNXT8Py69xVvFhQTS9fOKnu0wTBVFEYl8YOyySJiCeYH05MbdUFfIrc+UKTpgnoTNuetsyJwFirI/nCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVNQnGG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C9FC4CECD;
	Thu, 14 Nov 2024 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731598565;
	bh=c+QtyugjOQ3i5dvHqnYIoLWX152YPjrTGXRzntFQuQw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OVNQnGG4/atn0pvBVfywdQNfSoFZUzXEKhLrySyKPqBzmyY+ARm8iuYuhVfpeHUJW
	 WEWVQbIbc7Rw5XZDGykgKrnPsOig8GBILoHY/LjsZJqNCGFa/tk51XrMN5Qo+VXaj9
	 xkRrooSUGTm+F4UM0ZO/5XEDirB7nL/x3rK103a9hvMMQtUvyMimqDMdmrI3/ZZGsV
	 8hWKe6HvmOjIPYeoeFwrVsQGpqrXdgOImj9KbL5VEavs8w2DS0enqg0VYgrfie6iTD
	 FcyXwstDXwBg4RoGkXvWVqNt9n2k3ogeQ7nyuks/SjkDhhazwDMf4U4flygTy8F8Ng
	 arcklwJFfExew==
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241114102851.2497942-1-olivier.moysan@foss.st.com>
References: <20241114102851.2497942-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH] ASoC: stm32: dfsdm: change rate upper limits
Message-Id: <173159856240.505512.17591660886281127681.b4-ty@kernel.org>
Date: Thu, 14 Nov 2024 15:36:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Thu, 14 Nov 2024 11:28:51 +0100, Olivier Moysan wrote:
> Increase rate upper limit to 192kHz to reflect the rate range actually
> supported by the STM32 DFSDM peripheral.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm32: dfsdm: change rate upper limits
      commit: ba888450828befb0607219f34c03aa8645625447

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



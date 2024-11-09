Return-Path: <linux-kernel+bounces-402613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D109C29AE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC95C284F2C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C5E13A888;
	Sat,  9 Nov 2024 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMAAu6Bw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815C13B780;
	Sat,  9 Nov 2024 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731122042; cv=none; b=uvXXOuZohC18nydBMUGhy3Zam0Ja0dX35TuPiV+0RewsdRDWh5xN48DezNZs0aO3udnmGIiRkoJCPcn22qHBTJHmM4f0anB6Msi/6A/g+2cLDHT3DORzQlyQ1TMA8XYSybxN4aJ8VwENnoEdqKqP3HaU/iGJZfoXXPZ5uLkxxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731122042; c=relaxed/simple;
	bh=+fO1Ep+DCuJGkt1paLe1xt9jDCApzKVVE3M9ZNlZNOU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p/asaqk/xULb+iOFR6USrv364vpW9U7nxC449YbjipiwIbhuc6iCK7bn1z0Wp4uffXQl0aB5HDuQXdeTuaCLKESKqmNqzuPZTtJnF3SS2HSxnskem+INdFgRACEr12qrEln2IgvNRVpLHuCiCDpqbsXH7DpH7Pmz4kyTHbMWUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMAAu6Bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1D5C4CED2;
	Sat,  9 Nov 2024 03:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731122041;
	bh=+fO1Ep+DCuJGkt1paLe1xt9jDCApzKVVE3M9ZNlZNOU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oMAAu6Bw/sJeCPto/7oDxFXHp9Az63CqCb/czvofrz0f9l6/UBKFJYlABrDYC0cLM
	 Ibn7/Y49pOk7Ly03Qd3dGUIPuiCMC7Fl9JfDz8/mz/lV6LGL8e0ThZpIygFEDh+0+6
	 eB8zjX4WbztkB78yKPMf78QLPv5rJddJGLd1gBht0VmiPUh9vZlQyaGkmmp/+P7SGt
	 JR+hKwZUpPY1LLW08y0Is/tQsDAhnPKtw8yQEMCXVb7au4VzuDjCPc06hAtHoEdcRG
	 XJiCpV+6jlzvEVEmxMO6t8DSsXOA5wqQ/DS+S4sJtVAv/w7Mn8wpQHl85IeCF5mpDR
	 zDoMQlOw9fyow==
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241107155143.1340523-1-olivier.moysan@foss.st.com>
References: <20241107155143.1340523-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH 0/2] ASoC: stm32: sai: add stm32mp25 support
Message-Id: <173112203864.168194.12196332639413190423.b4-ty@kernel.org>
Date: Sat, 09 Nov 2024 03:13:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 07 Nov 2024 16:51:40 +0100, Olivier Moysan wrote:
> Update STM32 SAI driver and binding to support STM32MP25 SoCs.
> 
> Olivier Moysan (2):
>   ASoC: dt-bindings: add stm32mp25 support for sai
>   ASoC: stm32: sai: add stm32mp25 support
> 
>  .../bindings/sound/st,stm32-sai.yaml          |  26 +++-
>  sound/soc/stm/stm32_sai.c                     |  58 +++++--
>  sound/soc/stm/stm32_sai.h                     |   6 +
>  sound/soc/stm/stm32_sai_sub.c                 | 144 +++++++++++++++++-
>  4 files changed, 216 insertions(+), 18 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: add stm32mp25 support for sai
      commit: 8509bb1f11a1fed710271631c2e06fd66452f510
[2/2] ASoC: stm32: sai: add stm32mp25 support
      commit: b3ea5bec7519027a8e0d6c5c3a313e2ab11e6b2c

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



Return-Path: <linux-kernel+bounces-241292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597EC92796F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7AB1C20CBD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22151B142E;
	Thu,  4 Jul 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSh6sHGm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF251B1410;
	Thu,  4 Jul 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105321; cv=none; b=S17IMvxf83M/zcKqIVzJgoSWeKmpvAPRXp+nwn1Ss9jnj5rGRdiQG46br8SOeAx29cWaj9IpEfOiLrX761t/cPBgUiUNgcgMxmdpoiP68gHfNOISblgrSdBp5nITRGIgQzzaML4MO6lJM21LSbcpbSLlF1at6jUMNLVM/qi3cJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105321; c=relaxed/simple;
	bh=Kb6Bg3h/wyL/yJijCF3T8Ygmjctgt3DijUcQ0c+p20E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YXLvblAF5XyvjMqv9XAl8bzXkvLeMEZqYEYXQxC58a1W5zG0WgGwbGng0b5r6eztmdEReFCo/t8p5ojSYoC9Jn0Elpq8kWJBlm/CH5fpUS9do8rI/1mxXKtryDklbf+g6LgIbycT774KUF629pYJbpNWRnivVb2NS1NH/HQwEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSh6sHGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DC9C4AF12;
	Thu,  4 Jul 2024 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720105320;
	bh=Kb6Bg3h/wyL/yJijCF3T8Ygmjctgt3DijUcQ0c+p20E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hSh6sHGmu76Q8A4/5Wx4hKaveyEAmppSlgyT9aP4gTWQnURYA/IldGnCT+JPCO0ny
	 C+ZEjNV1zdMdQrlAfJsL8sNwbvjBqSUV7VUY3TUZ4RUY8iS2kO0eDmqGEO7gcxV4yW
	 UQWCT0pbpP1JzCiaVU/h/A5Vw8dazyUxEKNuH8Zoa+pQo+FzCVlACxiVLcY173CofK
	 x8qtGdfpD3RHtqnio8zvikASnd2oVS9CDNREUY3KWZGvxpAPA8JjsNVVSDEA3rhxYJ
	 aUm1de+d7+DetYP9BWx5B3dxECPZgHdOg2mpG1uZ0tvmIMd/wZdzKSJXVX6l7Vlark
	 0HQLiGScpRdog==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Aleksandr Mishin <amishin@t-argos.ru>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20240703191007.8524-1-amishin@t-argos.ru>
References: <20240703191007.8524-1-amishin@t-argos.ru>
Subject: Re: [PATCH v2] ASoC: amd: Adjust error handling in case of absent
 codec device
Message-Id: <172010531874.64240.1946699241818022514.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 16:01:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 03 Jul 2024 22:10:07 +0300, Aleksandr Mishin wrote:
> acpi_get_first_physical_node() can return NULL in several cases (no such
> device, ACPI table error, reference count drop to 0, etc).
> Existing check just emit error message, but doesn't perform return.
> Then this NULL pointer is passed to devm_acpi_dev_add_driver_gpios()
> where it is dereferenced.
> 
> Adjust this error handling by adding error code return.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Adjust error handling in case of absent codec device
      commit: 5080808c3339de2220c602ab7c7fa23dc6c1a5a3

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



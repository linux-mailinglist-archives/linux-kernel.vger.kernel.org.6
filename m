Return-Path: <linux-kernel+bounces-231424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C47919890
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486E01C21B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1B192B8B;
	Wed, 26 Jun 2024 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKM1xyfB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C54192B7B;
	Wed, 26 Jun 2024 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431570; cv=none; b=LSS+7MzuZYmtU/9SaqRx1ukZ10ULliDBtOxoKdb4uHcUid+KUgf8SxXAUJOMBxztjvA4hMjmgsEAgJNfWWoWAFPQD4KGrvvsM2szm2XmTff6wxIEzTKgMM/sIYNH3MWvP8G25ySBRUR2NZ1Zu5564oqLbIAaFE/WfYki6uEL1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431570; c=relaxed/simple;
	bh=lzU+cik77CuctsT3z+aF1e9wxYmZGia/8jYGIDA2mE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=alqXtOXb8tsK8qTmxU5wo0JmspIiZ49QOhhIv/EvmagbRPyM+eCC2ofR9C2gvdYGeR6KJdWE3eqdzrx8uYcrARRaJtFWvFgIlxnu8LNrGHc9me4v8+WO3YcrBMy+2E/I/DRr/JBa+isvDO1umn7YZpi0gN15koRSZVKtuY1uALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKM1xyfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C30C4AF0A;
	Wed, 26 Jun 2024 19:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719431570;
	bh=lzU+cik77CuctsT3z+aF1e9wxYmZGia/8jYGIDA2mE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kKM1xyfBbSsNz2NF3csL/onKLZNJlgxmBOv8MFxtKYjRpqLXbVXZA9aXL+ZYO5Snp
	 YfKrVeYU+dRM3SLaAJg85cYNf3vTuffq9P6G7pEC2wxzSG+lVDrSY7IFBer88MDmtT
	 a7fsZM+wWpPAwR1edxi3VW+X2yTJVOZ4apfle98KUmFsLNGnUCLx9ueSLXqc+y3C/h
	 CnxbT8O6VDz7+zL9fiCrhXBvnNsxUVDOAsFuZJh42Ogx+IMl7w4r44xdB12hjaN3yS
	 uu7tEbLRTnQliSGTP21HnIdGSRsdpw9FgX8hV7ZsqBO4MvIWaigWvtqrYhrx+6G8S2
	 tX/6eELbmgsdw==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Aleksandr Mishin <amishin@t-argos.ru>
Cc: Banajit Goswami <bgoswami@quicinc.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, 
 Venkata Prasad Potturu <quic_potturu@quicinc.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20240605104953.12072-1-amishin@t-argos.ru>
References: <20240605104953.12072-1-amishin@t-argos.ru>
Subject: Re: [PATCH] ASoC: qcom: Adjust issues in case of DT error in
 asoc_qcom_lpass_cpu_platform_probe()
Message-Id: <171943156785.1690751.333640951846227902.b4-ty@kernel.org>
Date: Wed, 26 Jun 2024 20:52:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 05 Jun 2024 13:49:53 +0300, Aleksandr Mishin wrote:
> If IORESOURCE_MEM "lpass-rxtx-cdc-dma-lpm" or "lpass-va-cdc-dma-lpm"
> resources is not provided in Device Tree due to any error,
> platform_get_resource_byname() will return NULL which is later
> dereferenced. According to sound/qcom,lpass-cpu.yaml, these resources
> are provided, but DT can be broken due to any error. In such cases driver
> must be able to protect itself, since the DT is external data for the
> driver.
> Adjust this issues by adding NULL return check.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Adjust issues in case of DT error in asoc_qcom_lpass_cpu_platform_probe()
      commit: f9f7f29f64454bb20896c7d918c3abc3a1aa487b

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



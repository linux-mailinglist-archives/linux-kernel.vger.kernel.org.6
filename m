Return-Path: <linux-kernel+bounces-447555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4A49F3424
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC2F7A2B20
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BC51465A1;
	Mon, 16 Dec 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCQMQdk1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA466145FFF;
	Mon, 16 Dec 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361947; cv=none; b=DWZuAZHyIZ/QdTdXBaUVHX7gr4uwTarkaUTVXVyILiBCc/W8couE55HVCWvCmml+Zm5p4cKaQLRGVMKyfGgJEBS6kaV0exsOkK4botI3XnK0eNw1fP93JfqITfcbtkJljQylb/5NuVM6m6WL03IDKqAv5XAx9A/ttoapX0EeR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361947; c=relaxed/simple;
	bh=q7zy400uagPLKS9PRJpxOSiIFghsPRdYPTkFfB41EDk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iNSf1KjNIzk0HWPA25XT8NzteJzebrhe3hzjrGyXjN9wwvBshTe0579DW6KDzh0kkJPJs3nAXcbxOcFEMA0LGDjvx6rmQKONG2aYmypfbs8juEag+kUnBKR8Wp1SLbghCeRN0u7r+IIvUXyfvi9y4oXNzol6CWVY521oSW3rn0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCQMQdk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0932C4CED0;
	Mon, 16 Dec 2024 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734361947;
	bh=q7zy400uagPLKS9PRJpxOSiIFghsPRdYPTkFfB41EDk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uCQMQdk1SPY1D9l+ivTDmzVk0cAnPmuGO7jH2V2OTCwKCb54sQijkTdGLRzFm89uI
	 F3MMjBPqydYJrrGzDF6yl+Y51xq0fXbTGQRY7DFnKNvISE6hP2BeMZh3sRiGEUkcgV
	 vvs1jhFx8fk8TirQ4PUdTlJ3Glp3KFvK8WzxNS2zJIUVH6zrV7mMtp7aiIaYjWrp9G
	 Q3o/vY5CuhFot7eRryD/i4xizC4LfElzT7rY1QuE/Mt0G3wZcGQUNyPhHawjMNm34y
	 jwjzHCMN1N6kXMuW/Mp7yMyimuFzlfP0wT4J0EnnpbLS+7vBTn80oBvLiVtnbSvOWO
	 3DuCrQ8AUO+sQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, mario.limonciello@amd.com, 
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 syed.sabakareem@amd.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20241213061147.1060451-1-venkataprasad.potturu@amd.com>
References: <20241213061147.1060451-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: amd: ps: Fix for enabling DMIC on acp63 platform
 via _DSD entry
Message-Id: <173436194432.77772.11451411947563731348.b4-ty@kernel.org>
Date: Mon, 16 Dec 2024 15:12:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 13 Dec 2024 11:41:46 +0530, Venkata Prasad Potturu wrote:
> Add condition check to register ACP PDM sound card by reading
> _WOV acpi entry.
> 
> Fixes: 0386d765f27a ("ASoC: amd: ps: refactor acp device configuration read logic")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: ps: Fix for enabling DMIC on acp63 platform via _DSD entry
      commit: 88438444fdddd0244c8b2697713adcca3e71599e

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



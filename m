Return-Path: <linux-kernel+bounces-445348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA79F9F14E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F2B1652FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185351E048B;
	Fri, 13 Dec 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVclJOVO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C21E8854;
	Fri, 13 Dec 2024 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114419; cv=none; b=QKpdjh6Lxa/1S5IACZUZgmRoOgUWC0v4UeW+7eMSEMEhtKKd5VyWqbxLFVCJc8wDEi+9PSmrGbrWw278bx+2UUnwnpruX0dD5tvwy3DFq2vJuo03KtJFylmSCusvqXomGuDEuNWq2qB/K5dybdBwGD8gUI6qazkFTSuXfCGZLxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114419; c=relaxed/simple;
	bh=IgsRLbyjKbDnKZEGJ3MxQziXE1RmxfMqUEJ4Xfp0AXw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=otp9zgDpZNwTtD5yyFs/Q21IYc2o7f3rBNV7rCyDFKH8Z/9YNVYlmcHz4hWRrEvPaK/8BRgr3u+7jT0MJPcwckQCyYkQXjJhGk2bN8tnQQa0DxolP8NoQuSXIRFrXFN0V1tzn+08HXciY1bU/nxhN0YGpSXf3Sxt0zIJRCNH7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVclJOVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A467AC4CED6;
	Fri, 13 Dec 2024 18:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734114419;
	bh=IgsRLbyjKbDnKZEGJ3MxQziXE1RmxfMqUEJ4Xfp0AXw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=tVclJOVOf2RkdXGpgF+xzGmOWG3D4dwbR02GAwQcZ/q1ERmrWY9QQJyCXlLkfGgYy
	 lP2TMn0VqqiW/lzwrzJgJdgiBywyqJMRgEGM8iJVyiQ/TSfxxjpx2jXcZGiUhiVGdA
	 4T0ynGJk2xDc6xXQGo7jbq1yehcx/oxnnDjbZZLuh/wZ1J/G6D53jdeMpe5ytrzSVk
	 WOWrmSIXWACfDurEwngeQ6fL/dlU/lPQt+nQSqQoDj2PAVenLVcsuyQ2Skn7XUhhSG
	 Q+XW4vkSLM968vts7NDMOpAcBWyAfrfAP1Afw34HRwJqpOT9O3kOwMTgyxaLgi3Ptc
	 6w7X4Mbx2SfwA==
From: Mark Brown <broonie@kernel.org>
To: vkoul@kernel.org, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, 
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com, 
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20241212074509.3445859-1-shengjiu.wang@nxp.com>
References: <20241212074509.3445859-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v7 0/6] ASoC: fsl: add memory to memory function for
 ASRC
Message-Id: <173411441641.280424.4148595189607458156.b4-ty@kernel.org>
Date: Fri, 13 Dec 2024 18:26:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 12 Dec 2024 15:45:03 +0800, Shengjiu Wang wrote:
> This function is base on the accelerator implementation
> for compress API:
> 04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")
> 
> Audio signal processing also has the requirement for memory to
> memory similar as Video.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ALSA: compress: Add output rate and output format support
      commit: f4425e3ab2f796d442a44f31262eade9b6427ff7
[2/6] ASoC: fsl_asrc: define functions for memory to memory usage
      commit: 8ea7d04a4e9e30876c9d8184b4b8e4cab33e0372
[3/6] ASoC: fsl_easrc: define functions for memory to memory usage
      commit: 27147695aaf7ccb0edc3f21454b5405c9037b4ba
[4/6] ASoC: fsl_asrc_m2m: Add memory to memory function
      commit: 24a01710f6271ec32b629d714e6a64a69665128b
[5/6] ASoC: fsl_asrc: register m2m platform device
      commit: 286d658477a43284f7be2539b059ecc90ba109c2
[6/6] ASoC: fsl_easrc: register m2m platform device
      commit: b62eaff0650dc6dc2a4bf0f50714f2357a23fc71

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



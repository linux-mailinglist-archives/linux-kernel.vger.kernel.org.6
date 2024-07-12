Return-Path: <linux-kernel+bounces-251016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C92A492FFD0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89191281C13
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545D8176AA1;
	Fri, 12 Jul 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNr+gtQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2F16426;
	Fri, 12 Jul 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805466; cv=none; b=kxHjESUrnlsbU1MDOkPWbFeCRgqx1wvgvQ/DmXdPOmcMu+edWiAcnT/gHs5LYlqhbbfe5/IpnME68nE05ceRUZUU62ZEN+feebsH2iwdg78EawTRgsL2T0ZPIK3fPWvzlrSKKKQye7QL/VQ59k7Xs7s8z4H+vuSd1ykCZ4+9lVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805466; c=relaxed/simple;
	bh=dqPsG8yV77VmgXtagFaXS9kgxrHBND7ubnScKMYPFxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ChWQ9GutvYMODfNi8JjdQPwp9/cIeJrNEv12/8UZwm7kc/zeeA/pnTmvm07gLpk4R9mQnzEeUb+qC5ng32MQfQtI+7Dswb1kJXHSSLZVmkmAc+cVh4gtnGTS6e7XjtBERURXz1CJR631Zs7gCJWZn0utmwiyVCKLc+rJMqD9eJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNr+gtQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34765C32782;
	Fri, 12 Jul 2024 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720805466;
	bh=dqPsG8yV77VmgXtagFaXS9kgxrHBND7ubnScKMYPFxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iNr+gtQSpa6wenDI7MGr80XWWPrClvWHRd8kV5+APIsco5vUwDyJbLrLVluoYRtf5
	 +Qmey+VL/IdkrJkH3JQfxASBilLEiPW2uCRDe9yHsjtnhxL5BSRt980uN1tDcgAvpz
	 MQd0d5V9bQ1ClMLog81PyUIFyH1layLPdTaO+Yq1WstoPCC9deM/go/Lv0AeO6z6P7
	 hl5CtrqcoAIuMpH4BeJOpjj29jvTVACa6KU7QF7uCbIIxLa3JMCvu2M1LwoOvVrjFS
	 +a0Sq8O18OrToV0oiwWvUk9y76YW2z0Ta5I13DPZztUT4C/dx3ysTNgk8z5oKfQNee
	 u0Yr+GqNHzeWw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Prasad Kumpatla <quic_pkumpatl@quicinc.com>, 
 Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 quic_rohkumar@quicinc.com
In-Reply-To: <20240704081723.3394153-1-quic_mohs@quicinc.com>
References: <20240704081723.3394153-1-quic_mohs@quicinc.com>
Subject: Re: [PATCH v2 0/3] Fix the unbalanced pm_runtime_enable in
 wcd937x-sdw soundwire slave
Message-Id: <172080546390.557655.15542741446735034080.b4-ty@kernel.org>
Date: Fri, 12 Jul 2024 18:31:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 04 Jul 2024 13:47:20 +0530, Mohammad Rafi Shaik wrote:
> This patch set change will fix the unbalanced pm_runtime_enable in wcd937x-sdw soundwire slave.
> 
> And removed the string compare with widget name in MIC BIAS settings, instead
> of string compare use the MIC BIAS id's as value.
> 
> Removed separate handling for vdd-buck regulator supply which is not
> required. The vdd-buck regulator supply enabled using bulk enable.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: codecs: wcd937x-sdw: Fix Unbalanced pm_runtime_enable
      commit: 0ffc5a40ad21996c1c4b1d8a636c9051ea41a76e
[2/3] ASoC: codecs: wcd937x: Remove the string compare in MIC BIAS widget settings
      commit: a5f727f423101efd60a27bccd7680df429cef38a
[3/3] ASoC: codecs: wcd937x: Remove separate handling for vdd-buck supply
      commit: 216d04139a6d0ecaea9432178225b29d367da886

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



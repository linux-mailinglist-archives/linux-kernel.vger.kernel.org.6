Return-Path: <linux-kernel+bounces-570186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887E6A6AD3B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E2F884EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3609226520;
	Thu, 20 Mar 2025 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elKX58B6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19622839A;
	Thu, 20 Mar 2025 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496351; cv=none; b=ZBCcvF5ZiMZ9GCuH0tkQ1zYiAsPLZ/buVJvcLoODxnIx6FJDeQPoyAvdkh+QMcpPOH6/1rSqRjJuVOQXJ9h+mXVg2t9OcI3c3baDHlcqR6Ns+JHpVPD/sy68sQc0xb723wZto9UdUSc+mR5Y8IDG9gJXuBSsDBhIWnqE7hmCAXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496351; c=relaxed/simple;
	bh=9GgqdaYLKd7dmzLN4hNOYA1FFmBech8VPXpJw8W5XXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YeLXBeyadPNK2yHwoi4p9k8G4YFaIDjfu7hG8mjJfO7ECxMvvvAbWw8flDHdiG7K89nGl8YQyjBF/R4P92780LfjzZgy0kVbfQk3MLTiZEyYxVHIuVKZADTnxXU4Zso+W6XVbY74F+iApv0Yxd96qrDZQdsrK1iytupPEo8Dx1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elKX58B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36370C4CEEC;
	Thu, 20 Mar 2025 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742496350;
	bh=9GgqdaYLKd7dmzLN4hNOYA1FFmBech8VPXpJw8W5XXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=elKX58B6TYNLG5yRXK6frhwOhw+PbUVW47rpa+Uw0/X/McE81x2xa7zqWyLK+uRye
	 3w/SAmqk77qKQaRNs+ny6SawrO6GafiHBaNBZecnsWJuT5495VNkEAkcafE68k1esj
	 kQblPueB7Im9Oc1jUFS6B61DMEhQjqr/CS31OjydqAxTa+GlDKCOSMf8xE5c7SIITG
	 6atnbqq3Ps2KfnzFyZCprcGWecR8lqi7eRYS/Spj+zPz09SpoS4FBhVOSXloPdE2hB
	 fLZVDTSql2Tvpk7DsJkMDQJnuiYZg/zZmi8ttE4SE58pKVlxA6S+tKRbCD2OsPZdGn
	 6LSK9yd1zWepQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 patches@opensource.cirrus.com, Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319142059.46692-1-francesco@dolcini.it>
References: <20250319142059.46692-1-francesco@dolcini.it>
Subject: Re: [PATCH v4 0/5] ASoC: wm8904: Add DMIC and DRC support
Message-Id: <174249634796.174081.9833862895994881364.b4-ty@kernel.org>
Date: Thu, 20 Mar 2025 18:45:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 19 Mar 2025 15:20:54 +0100, Francesco Dolcini wrote:
> This patch series adds DMIC and DRC support to the WM8904 driver, a new
> of_ helper is added to simplify the driver code.
> 
> DRC functionality is added in the same patch series to provide the
> necessary dynamic range control to make DMIC support useful.
> 
> The WM8904 supports digital microphones on two of its inputs:
> IN1L/DMICDAT1 and IN1R/DMICDAT2. These two inputs can either be
> connected to an ADC or to the DMIC system. There is an ADC for each
> line, and only one DMIC block. This DMIC block is either connected to
> DMICDAT1 or to DMICDAT2. One DMIC data line supports two digital
> microphones via time multiplexing.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] of: Add of_property_read_u16_index
      commit: fd9582998b9a82ef53a34756de8a1fb86abac972
[2/5] ASoC: wm8904: Don't touch GPIO configs set to 0xFFFF
      commit: 2aa853248b6b6c76b9dd82353e45a4283f9c53ec
[3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC and EQ support
      commit: bd552e937fc80faa70007f7a4cbbf7edd5a6629a
[4/5] ASoC: wm8904: get platform data from DT
      commit: afe66ef965317381fd2894c2eba144b38b791910
[5/5] ASoC: wm8904: add DMIC support
      commit: b6612c8fc3a2c279196050ecc13c77a7863d83eb

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



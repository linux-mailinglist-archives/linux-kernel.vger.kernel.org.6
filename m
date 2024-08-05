Return-Path: <linux-kernel+bounces-275244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6885494824C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247F228269B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D699116BE3A;
	Mon,  5 Aug 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlJbbOPp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BCC16BE11;
	Mon,  5 Aug 2024 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722886034; cv=none; b=V2xcgwPGwK0tw46oIbhodzvMaFgZDF2tg+l0r84CRLhERO28z8FZQRHQftgmUZ7QLXd2AE2GjP6o40N09PmvEZmrQ/DGxIjUFpo4hNhAUWwzJmI2ccFM9hqMHPMyeN2talXTdvFBy0J/eZSSV12MMVgZaOEyD86qbVGxjwTqFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722886034; c=relaxed/simple;
	bh=VcNN8LeWKp8uJ3akmxby7FUq+CiabFmtH2wRcusXAtY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IgF/g92puT28sxX6LQhjFvYYoKuozUsU20NvZEX1+aXFEmyI/CAlXvLAPEun+kvAbwbOC/o8q1NMFBiwj/AQCvglZFzOpXW2phfXRM0jSyENfLPLJWO2P27ZvCVWS/WAmdUdSMXuGKykiEqnnEEmf60T5jEGvYnXsV+yARrDKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlJbbOPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35650C4AF11;
	Mon,  5 Aug 2024 19:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722886033;
	bh=VcNN8LeWKp8uJ3akmxby7FUq+CiabFmtH2wRcusXAtY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GlJbbOPpOGkhoS+nyVtSBmnLafoW1pzdgKfXGD+Dz0xINeHGpjHoxSEUfUC2JsEdc
	 9KCSkAq1TNSKHwEER54L0KAi9l65Sc0Cb4eJMclJx4uojAGt+vquklNJlFwQQqVOEJ
	 KHKVmR64UYrzgRZl3yocDD6ZhbKO1rFkKrMVNP7kvDgWaT3tl0O9cifh2zaDSjKE7f
	 XpERk/aTQIFH9B9UuXiuyUrtsgmh9LfpYc7MEODJklm7LAjg/FVHuxQ5Mob7HymiUt
	 JtydAj06DgCselEtLSzKyqXczFaST2Fw8xsjMGrhFKAzrqwrzmqU0UojQUisxN2B66
	 IOkvjG51wWGHA==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240805140839.26042-1-rf@opensource.cirrus.com>
References: <20240805140839.26042-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Handle OTP read latency over SoundWire
Message-Id: <172288603184.71820.8835151203364100477.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 20:27:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 05 Aug 2024 15:08:39 +0100, Richard Fitzgerald wrote:
> Use the late-read buffer in the CS35L56 SoundWire interface to
> read OTP memory.
> 
> The OTP memory has a longer access latency than chip registers
> and cannot guarantee to return the data value in the SoundWire
> control response if the bus clock is >4.8 MHz. The Cirrus
> SoundWire peripheral IP exposes the bridge-to-bus read buffer
> and status bits. For a read from OTP the bridge status bits are
> polled to wait for the OTP data to be loaded into the read buffer
> and the data is then read from there.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Handle OTP read latency over SoundWire
      commit: e42066df07c0fcedebb32ed56f8bc39b4bf86337

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



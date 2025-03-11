Return-Path: <linux-kernel+bounces-556197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5649A5C251
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B83116F963
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A20221F1F;
	Tue, 11 Mar 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxkKueGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09761C1F22;
	Tue, 11 Mar 2025 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699116; cv=none; b=bn2O6HoH4f6hkaizkG01MQItilXdht/v4f5EUXzY+PrsLrGpB7CP2aL/tAcO/UjPtZgb7C+e1VUdw+Gp9RpR1kcw4HvOhmB9pm2y8pwGdSIcLoy5i4SDJbFgH8J8mk8XVw3NcIPERjhmhPJvcwZj6Bga4QkrCQgIEKlXGI14LKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699116; c=relaxed/simple;
	bh=rtzEfGwsVr5IEohTqKChStg4Lk/Zbrodm9Xa6UeL49w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QdCUFWQzT8wHe6VvWX4oiO1g15IX1vgBfS9dSUe1i2dMmtCnuc+Fv4kUNJjGBYUhlgb64NhuGzV7PIK8To8Hq9QBZC2QjZRNch0m5oeZJshCzXBxpYQTyfOv4G2lgG/3xCQ6HOIbmxs47ndw49y5hHxnefo0QVGFAFFU5+l5TCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxkKueGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C72C4CEED;
	Tue, 11 Mar 2025 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741699116;
	bh=rtzEfGwsVr5IEohTqKChStg4Lk/Zbrodm9Xa6UeL49w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nxkKueGgdEC+tFwEi7A4jdAYp8O/FfqC2sfL4AD49QgZgSpS51GXE74JBsIQNM8wg
	 t2LqtqXLKS82KDyng2Oo7sAHBkUaNbOVH8aS1XwZeMu6mmAWEVluDY8U6pPVSGUg7v
	 wIElqKAJoTzgln5crrX4zSDO8sAc2juQpofNCITm9kuC+B+TP/HkOfHfY+Zb1esLjX
	 J7L239wMMEvPNXL3NlBUNQX7mANFVk3HdF65sM/5ojQ4DxtuBgGr8VIJyO6Cjrp10s
	 0hvRzI2aMHn/LF9u03kYr1Z8LbvymPRxI06IJ2lQow4suEa8vTH3iSuMZP/WLryWPs
	 KazUmN4Y7FAQg==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Lucas Tanure <tanureal@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20250304115643.2748-1-v.shevtsov@mt-integration.ru>
References: <20250304115643.2748-1-v.shevtsov@mt-integration.ru>
Subject: Re: [PATCH] ASoC: cs35l41: check the return value from spi_setup()
Message-Id: <174169911354.27942.6320813345687980941.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 13:18:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 04 Mar 2025 16:56:37 +0500, Vitaliy Shevtsov wrote:
> Currently the return value from spi_setup() is not checked for a failure.
> It is unlikely it will ever fail in this particular case but it is still
> better to add this check for the sake of completeness and correctness. This
> is cheap since it is performed once when the device is being probed.
> 
> Handle spi_setup() return value.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l41: check the return value from spi_setup()
      commit: ad5a0970f86d82e39ebd06d45a1f7aa48a1316f8

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



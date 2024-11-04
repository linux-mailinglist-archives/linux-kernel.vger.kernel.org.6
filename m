Return-Path: <linux-kernel+bounces-395012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4FB9BB71B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8FF1C21FA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648DE13B58C;
	Mon,  4 Nov 2024 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUdAyh74"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF613B29B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729212; cv=none; b=sZWqQ0OiRRqvILdFVFC3IoJVuV0wpIOyJCih0RMSbMoehsh/vn1FOgDMjas+dITQ4ES5HnPHZeYThysnDaZ2g8M35O2gv8OXYJFN1ZcrRcHK3FOpkk+UAUbmu60aklQHUK33qACXjIpToAX8vSuqq+LrS7ySIdYKhvqxwgby89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729212; c=relaxed/simple;
	bh=w9ObZxa/UU2kAEex0iae7ZbNOjcPWAbRIhO5NeNfrN4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q7CfCZEUXCORL37EI8hcq0/awzoYAe0OrAV193DvvjRIzaWThdW/wuBWtk7HT1OHi2Olw33geziPjJsLq91JT5Rv043QtAVQ5TZihlXvd4X9jtWoXnCHrP7VQjJqJ6p1y49qSwbdUfSx3Wy+RchC2DgNGNwVyLjJO+FQ+TOXR0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUdAyh74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718DBC4CECE;
	Mon,  4 Nov 2024 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730729212;
	bh=w9ObZxa/UU2kAEex0iae7ZbNOjcPWAbRIhO5NeNfrN4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lUdAyh74qs6d0rpFI85MWbyaQG3HFP3qDyaGjbYnU3ERCqoSt+xaklrQ8hNpKWwS3
	 lLuvOkhb/Rkr50RhQ+Q+wfESPpRLKL7yY2MAxj/MJnT+lSSUb9E7kj29bk86zLJ6oy
	 NTdbG8U0fnEIJEmuppdp43PqAK2ZCA+e5mGtNZ99u1akMD/eL44ZhKFzBu672H6tU7
	 HZMTZ/We0zza6iWl04mBoTpplLajsNtCLrmFGHKmJJcOr0lDK4Z+guuBOa7XNvAada
	 UXlPbJ/d4nsW6NjXXGcrf3UUJd7ewnb6XNQvRkyQXMQcRWrglrlZg+Olzfm6NrwBJS
	 r+7SKH8Yj5UZA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
In-Reply-To: <20241017-rk809-dcdc3-v1-1-e3c3de92f39c@gmail.com>
References: <20241017-rk809-dcdc3-v1-1-e3c3de92f39c@gmail.com>
Subject: Re: [PATCH] regulator: rk808: Add apply_bit for BUCK3 on RK809
Message-Id: <173072921119.32252.6219604204402845231.b4-ty@kernel.org>
Date: Mon, 04 Nov 2024 14:06:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 17 Oct 2024 21:37:28 +0300, Mikhail Rudenko wrote:
> Currently, RK809's BUCK3 regulator is modelled in the driver as a
> configurable regulator with 0.5-2.4V voltage range. But the voltage
> setting is not actually applied, because when bit 6 of
> PMIC_POWER_CONFIG register is set to 0 (default), BUCK3 output voltage
> is determined by the external feedback resistor. Fix this, by setting
> bit 6 when voltage selection is set. Existing users which do not
> specify voltage constraints in their device trees will not be affected
> by this change, since no voltage setting is applied in those cases,
> and bit 6 is not enabled.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rk808: Add apply_bit for BUCK3 on RK809
      commit: 5e53e4a66bc7430dd2d11c18a86410e3a38d2940

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



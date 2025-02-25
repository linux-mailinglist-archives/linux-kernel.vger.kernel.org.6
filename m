Return-Path: <linux-kernel+bounces-531985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F56A44759
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA1C177AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A4C1925B8;
	Tue, 25 Feb 2025 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REucVwfi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F57186287;
	Tue, 25 Feb 2025 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503095; cv=none; b=aLK3YkYoST+hR+KHRcJ/O4U/+N/qCbJRt0JnAfFRqI+3X8pcBAcIRgefWzBYlP7IYvjB+SXdqMo+zMNy65bicNx75kCC8NhLhMRxhM82lEeaAmKMPfMkc+peBoZkOx/P6VidOFi4Z3MZdTuG7AVZpS7/ToYVKgaLJwAJEHrNZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503095; c=relaxed/simple;
	bh=PYIKWFAhLrenPko0j94P9t8Yakf9ynY0f2VJEpzxp/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MO5Xvfn4p+UpYNgagsna63kJuc6/Z0pojLfbEdCryq3YF/a0I3PEKEQDuXP3jasobdnkpE8etQ0d9FnfC9EXHv0KKIbJ+Yu6pdvRKUGWJzIZrMOuijjydWW/F7TDJtDlzY7GuURJ4hkRh1U3PZ79W6h35ftilpQeLxBGB/P/GjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REucVwfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0D3C4CEE8;
	Tue, 25 Feb 2025 17:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740503095;
	bh=PYIKWFAhLrenPko0j94P9t8Yakf9ynY0f2VJEpzxp/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=REucVwfiOZjRmnlHLVkj94SmAs1xeGeu87b24dfU1Baim3dMetLwdvkmpVz9auq3I
	 S5ZDhROTtf4Qf94GBpd4XKK3FpuulYMcwF5bvqjC9n5BJ2Q5fJ1PTubm0GrI9OZhRz
	 Cg3wJff6E1kuabPZPBKwOwCYJOZBfJeZADXVpQuZTo2pWXDXfyljgyQCxCrp/e059A
	 QAv5r24qGJzbdPnPfpZmA4LHEoJiT0hMhETV34sITkGBj7k1GYUVPkcrtxe0ZEAsmi
	 IYXZ19CqBc+FWOaZp0Cvft0IspJBuKXw6k/2zDSRAT7yJJIGda9wFZAOZQVSu8//FG
	 FbXl0vMSohSwQ==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20250225131843.113752-1-rf@opensource.cirrus.com>
References: <20250225131843.113752-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] ALSA: cs35l56: Fix for races when soft-resetting
 on SPI
Message-Id: <174050309387.106105.14789849081879688731.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 17:04:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 25 Feb 2025 13:18:41 +0000, Richard Fitzgerald wrote:
> These two patches fix a race condition between driver and amp when issuing
> a soft-reset over SPI. The main problem with the race is that the driver
> could read the amp status as fully booted, when in fact the amp is about
> to reset or is in the process of resetting.
> 
> This is mainly contained within the ASoC driver code but a small change is
> needed to the HDA driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] firmware: cs_dsp: Remove async regmap writes
      commit: fe08b7d5085a9774abc30c26d5aebc5b9cdd6091
[2/2] ASoC: cs35l56: Prevent races when soft-resetting using SPI control
      commit: 769c1b79295c38d60fde4c0a8f5f31e01360c54f

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



Return-Path: <linux-kernel+bounces-184110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A26158CA2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1C0B220BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583651384B4;
	Mon, 20 May 2024 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKFXoRYU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E5137C58
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233223; cv=none; b=UxHP9WBUunPs7yCG7E4pz5qfV8n28EYDPBVAOcQLQUd15sm60F9JySEBxhTd5F5wUN2s1NeBVd5My3UYDtAPryRbM7TVaYKV9QTdTQY1dPGavaaylwM86AHdJd8gtdc0NkLHERoEJYP3ChTe89SSs/ScTUxNSDVCEzWnKcaid00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233223; c=relaxed/simple;
	bh=lIC7HB0swIWVdimTjG+bzLOFs5vA+ZcNp4GFhv6O2ss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hFB3swZxIgD7bdNnMHgyn33OrLyKCWjN2t2nUfbWBnuviNV5Bnd1OHgCjX30c2wg4WD2d128tiAW/WL8++ZB8BsqDJcBYWNkq8R8lOzYEYqcfn6kymJYeCD4+w70qhnre70DNg4lFSPm5GC1I+CaJUQjRka3sX8TmyaBZGAEDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKFXoRYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A018AC2BD10;
	Mon, 20 May 2024 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716233223;
	bh=lIC7HB0swIWVdimTjG+bzLOFs5vA+ZcNp4GFhv6O2ss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uKFXoRYU7uRmLdcEGZK7vJwRRGE7eUjD8yu+aR2xrY2aLnq02mES2IoZKT+WXVMFP
	 J1DjYVZrDFSHtK4NVhoKd1pZ4YCqyHqw6h1AlgOkrG0mYWc+v+7MW4YvoKs5z2ZBC7
	 do4nt5kChBPcE3/CUV3hBaONcstkHa+fPaE1iclH3mcBMPll2pjxxDq0SdpdJxwp7s
	 QTtBh6omdYiAaeifTEL/fIVBdKlKzSAjqeRS2YseQFxLdqgH+MHPfs37aTqbkuV6AN
	 9eIZcFnsErvG+Uykv4HFGxUd+FtWr4LUJNQPJ4LkgyWRXho1GYJuo45uXz+NbM9iKf
	 OlDVjtniSR8NQ==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, i-salazar@ti.com, 
 pierre-louis.bossart@linux.intel.com, 13916275206@139.com, 
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 liam.r.girdwood@intel.com, kevin-lu@ti.com, tiwai@suse.de, baojun.xu@ti.com, 
 soyer@irl.hu, Baojun.Xu@fpt.com
In-Reply-To: <20240518033515.866-1-shenghao-ding@ti.com>
References: <20240518033515.866-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2552: Add TX path for capturing AUDIO-OUT
 data
Message-Id: <171623322016.94469.11401583139822139429.b4-ty@kernel.org>
Date: Mon, 20 May 2024 20:27:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-621fa

On Sat, 18 May 2024 11:35:15 +0800, Shenghao Ding wrote:
> TAS2552 is a Smartamp with I/V sense data, add TX path
> to support capturing I/V data.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2552: Add TX path for capturing AUDIO-OUT data
      commit: 7078ac4fd179a68d0bab448004fcd357e7a45f8d

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



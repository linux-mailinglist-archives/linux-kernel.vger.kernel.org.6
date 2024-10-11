Return-Path: <linux-kernel+bounces-361210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B1799A515
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1483287C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429A218D8E;
	Fri, 11 Oct 2024 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odJokxhC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4711CF291;
	Fri, 11 Oct 2024 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653476; cv=none; b=YMXT9AUqErYBEM09qymrtdk6ixwc7qqTVi5pmayI7FgzIMxiVTgDxmwTPhPVBdsEd9nXesH1ed29De1DLd/c9SB0FwjCt6NH/zHcv0HIvSw2oDrB+i3A4A7AKG8TT8cLk2Wm/KvnuSCmkO5cLIRj5kNcIYkC2yMgv03zLpq/p94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653476; c=relaxed/simple;
	bh=Pa1bnUZ2CsvnT/l+Tzbsrx1EiuynpO91L6NglyA8Kcg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n5Kdxaxs7AWxT6j9ICdMB5Ao80s1Rc3V39/KRZ5VNQNJp5pBSqAwnbu+xz9347rVc8m/MK88N6R13fGOXy5QYMbMcVVClR7NNKM4e3q2TbGFB+Kf4XXUWt+UMriH73ycwdDGzJQX6s4xc2JZFg3icG/v1/ue4sJz39VLQJi9+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odJokxhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF59BC4CEC3;
	Fri, 11 Oct 2024 13:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728653476;
	bh=Pa1bnUZ2CsvnT/l+Tzbsrx1EiuynpO91L6NglyA8Kcg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=odJokxhC9afN+z10xjOTfvmRifnYMyRUqAtM0cEQTOObnLV5JamAgtizPzE7J2LQm
	 akUf3ZvNQxGtRhcPvQC+M42zcdESCVacnPWuMVkprDMlndKSGVpvuJkrrR0cZDhsZF
	 vY7yU40EAp/wzwckwApectD1Xz9HHfDVlZ7Y1hqOmBOCKUHOjl5CGUmkQhY2HoTzqI
	 ZbfhojOQQvZPq7zy3jEMdFUCD/HNkd2BuL+uXxBHzvdd8QSf8ANx/eUkvbWUfXefyn
	 3NxvlgYqXaFbsAGhJvDml7MACVDcze3PvUSYjIELqfVexY5rIYErjh+qfXT8lknfB6
	 kdeoMHE8eputg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Ryan Lee <ryans.lee@analog.com>, 
 linux-sound@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010182032.776280-1-colin.i.king@gmail.com>
References: <20241010182032.776280-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: max98388: Fix missing increment of
 variable slot_found
Message-Id: <172865347434.3898502.5695068809742521783.b4-ty@kernel.org>
Date: Fri, 11 Oct 2024 14:31:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 10 Oct 2024 19:20:32 +0100, Colin Ian King wrote:
> The variable slot_found is being initialized to zero and inside
> a for-loop is being checked if it's reached MAX_NUM_CH, however,
> this is currently impossible since slot_found is never changed.
> In a previous loop a similar coding pattern is used and slot_found
> is being incremented. It appears the increment of slot_found is
> missing from the loop, so fix the code by adding in the increment.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98388: Fix missing increment of variable slot_found
      commit: ca2803fadfd239abf155ef4a563b22a9507ee4b2

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



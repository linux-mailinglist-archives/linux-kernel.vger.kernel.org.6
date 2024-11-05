Return-Path: <linux-kernel+bounces-397017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580279BD5A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0265DB23574
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D52C1EBA0B;
	Tue,  5 Nov 2024 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK9kEHfI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE31EB9E9;
	Tue,  5 Nov 2024 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833644; cv=none; b=jujn2BZO/3hUqwGPiQnugBAeApq75jp1/gHqk7az4rpSlK+4zmmVfeVTMXD4TjAwy5QYnQJmaXvBYWwHo4XxOMgb2QuynnKT1a3h2WVA7Iqhdxh9g9S/ZrDpGyjl7XKPcQWV3xfQxEk4E61aWbdWUO4uEVfIaXQ2vMZSppDxhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833644; c=relaxed/simple;
	bh=QF2vNEmdwPntZbzjFEQGu4tKLc04rU44LayLYk5Hh0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OulMV2rJlBeIMrM3kreCWiL2MMtPlGJyu12WRs4zr7qASmTOUz39pmK9rqCYW0b/e5ys1nkrgfpIbE7pe6XVHyQ2sex1URRiGsFzHX7PD+7eAV/nsLjWPoZRGx363CJ2GhvGMO+kjdWIxlf9+nxq7NpY/kSnss3IHqSCY921rls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK9kEHfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEEAC4CECF;
	Tue,  5 Nov 2024 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730833644;
	bh=QF2vNEmdwPntZbzjFEQGu4tKLc04rU44LayLYk5Hh0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UK9kEHfI8fR1r2EiCFiDvVPMKwJPDS0FXyyU58ghuS3i9Vz2ncfOYd/EJSS6wSeIk
	 jtVThxLEiZgX2ow64dOLN441gIUAjpk/iakWfoD+C72q/kZ8zPB5Z5OpNgC+MFaYd4
	 ZZB7tStRQ4bWVOkOaO3GXS7vJOXYNZL40VlmPsYpLwb6IUoXvvoZHiaLg1bYoHaJ0v
	 +0zncU8H/I8yP+ws6jFuk7uJOhzKVoIcf6jv9uXs+gYmi5Tq8RVOj9m6CT237ME5ZN
	 hzdAdv0BnGETatlbC/Rod2dIxhr9ShNVGrWyco5TGyjMSnsMpUO33TaZeAxos6igSv
	 Y8rBzr7L3CAyg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, Mario.Limonciello@amd.com, 
 Richard.Gong@amd.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@intel.com>
In-Reply-To: <20241101020802.1103181-1-Vijendar.Mukunda@amd.com>
References: <20241101020802.1103181-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/2] Soundwire dai link init logic refactor
Message-Id: <173083364104.105724.13341920313310122179.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 19:07:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 01 Nov 2024 07:38:00 +0530, Vijendar Mukunda wrote:
> This patch series refactors the SoundWire dai link init logic for Intel
> and AMD generic SoundWire machine driver and also updates the stream_name
> in dai_links structure.
> 
> Link: https://github.com/thesofproject/linux/pull/5218
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: sdw_utils/intel/amd: refactor dai link init logic
      commit: 485df22866559e2f821a9754d51a9755ce56e7aa
[2/2] ASoC: sdw_utils: Update stream_name in dai_links structure
      commit: d280cf5fbfe3cdd373c98e858834ff87b6ea64de

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



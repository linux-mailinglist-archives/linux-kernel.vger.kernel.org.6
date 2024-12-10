Return-Path: <linux-kernel+bounces-439631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5494A9EB205
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A662846F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53C91AA1C6;
	Tue, 10 Dec 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt6Lu3/d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C71A42C4;
	Tue, 10 Dec 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837759; cv=none; b=dqfLqTW1dn95Um4ZtPAX59OyVUaAi9hm329UJo5F9wmuasllH/BQpm83MHDRKbY6K8HTk2tGszvta0F0dyKmNSOjTVR6SNqAYOLhhLxN8wtYD3AThGgMsyIM0G1hM7De0KbRYhU7GR9AfPNSVFhc+EfL+AA9pdCEMBRNWAKycl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837759; c=relaxed/simple;
	bh=b2I0+eKk4iK9OnVnulSzlYA0NLcSmfUjvE0er6c4iww=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OODo/nCYLBdVeY1qEUb5wiVxNX7hRiSirbgGy4Tk6ze6mET2fWWVc1dGWxg8q1K9k2RYrqeSwlth2N5fDJ7fM4TWHzT3Zzcs2VmkN8hY3cTDLDk1DDPO+xeuaBwO1sArjjlPkBwaYmXxyBxdHWVFPO/G1kix730g4IAhbs/j4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt6Lu3/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD34EC4CED6;
	Tue, 10 Dec 2024 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733837758;
	bh=b2I0+eKk4iK9OnVnulSzlYA0NLcSmfUjvE0er6c4iww=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=nt6Lu3/dIXv//XgupGVTniobw37MR1F2itWDNVH8bY13QPrlj9SUF0qTMBS/3GRav
	 WBV+isYER+30vTCC4Gtt3lRAFjlpJROLjV0ZCtaFY1SS+PK/pAN9oLC7eUnJwEhP+W
	 iLBvCFRpArPQzIWjymSS1xunV3pXjD3VeWbOg7PBzALqbJIg2nB7tyyF4y2+PPGsO4
	 MOxcO3EmsqRAqEjiwbDH78Gwk6CGDUULRaKZptjFQPipQZRwcXHnRrMMjFBPynWe86
	 lhMJKb2q0h6G8WtoZJAwERUnHRTGRnxqhDToi8DmsgSbg8fyOCerbcgmZKaZdky/yk
	 3Jzazp9hkDi4g==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20241126115440.3929061-1-chancel.liu@nxp.com>
References: <20241126115440.3929061-1-chancel.liu@nxp.com>
Subject: Re: [PATCH 0/4] Add function to constrain rates
Message-Id: <173383775650.46965.9428255940556546352.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:35:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 26 Nov 2024 20:54:36 +0900, Chancel Liu wrote:
> Platforms like i.MX93/91 only have one audio PLL. Some sample rates are
> not supported. If the PLL source is used for 8kHz series rates, then
> 11kHz series rates can't be supported. Add common function to constrain
> rates according to different clock sources.
> 
> In ASoC drivers switch to this new function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: fsl_utils: Add function to constrain rates
      commit: 820bcaeb1ff5705ba907563e554f17d0deecc3fa
[2/4] ASoC: fsl_micfil: Switch to common sample rate constraint function
      commit: daf7a173fc7c4b652f3fe69d3b5aa520976a7d63
[3/4] ASoC: fsl_xcvr: Add sample rate constraint
      commit: b622b677d255b41cbfce20b66535723933a6b640
[4/4] ASoC: fsl_sai: Add sample rate constraint
      commit: 4edc98598be43634f87af5d3876ebec6c274d2cb

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



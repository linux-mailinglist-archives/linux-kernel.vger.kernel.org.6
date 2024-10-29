Return-Path: <linux-kernel+bounces-387517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018829B5239
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941EB285AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A86F205E14;
	Tue, 29 Oct 2024 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot4zauSq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1000205145;
	Tue, 29 Oct 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228195; cv=none; b=oRmHeSuDw8ZHPsZ1y3o6PUFOwyWNiKFUouXBBYvj/77APtNzySADetizZIYKkUDJvrvMdxhuFHYeT/84IS29qNPBYOdqsR6l+n6AY9q3eYnt7jSeAweunkaeBk7TekXTfHiXcMx1nNpNh85FYSMfoJoT2sBy9CdkTMAxmZASMLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228195; c=relaxed/simple;
	bh=/rtuWnuL8pahA40R0aliah1SeTGZ8RbwOdKVG/eWXaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BeFmZhYTD5CJD889aoYGdEne0spIGZCGdl1kBO0KAWOjr2FdLtcBVGBLsHZ+8TnkQZEcMC2sdBWLKXh+B5sgo6nhiOW8Px0UdZuUqhRcs62vcfJcDUsz39gkXM5JQy16PELjVM/Cs5iuLAARGPWf23QDaPziOSH5dPZXDGQhD7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot4zauSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF31C4CEE5;
	Tue, 29 Oct 2024 18:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730228195;
	bh=/rtuWnuL8pahA40R0aliah1SeTGZ8RbwOdKVG/eWXaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ot4zauSqoowGZ6Z6GqIbnC+/dlHtOsEqM4B5aWsRQWiNY4mtZ6+6vD++v9e5UaXu9
	 qRW/5uWv3D1qWjdXbyDIYmiK0TjsY6Ec+A+d3Pa7a5GpsUI0874mWTbFOpt0J6SDGq
	 8+gHn8WHZ4NrkMjRTocbw4Mxmc8JZ8n6PziF2prHWJRSs9oZiI5SyczsiiUrxiROzz
	 kOzUMH3mTwLv5i9KiveIY1/m7gvXYEpFC+N163GUfLLCbNLZLQF1IoUMOuin0L2gSZ
	 OWIHbgGH36jQ10KcHJXQ6kALEfY6mSTNB2Syq0sL0Dh5TGkXliMJ9VOmvOpFe6NOXL
	 DgpJogen64r2Q==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neal Gompa <neal@gompa.dev>, 
 James Calligeros <jcalligeros99@gmail.com>, 
 Hector Martin <marcan@marcan.st>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, asahi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029092404.3874040-1-arnd@kernel.org>
References: <20241029092404.3874040-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l84: remove incorrect of_match_ptr()
Message-Id: <173022819225.134081.15074858579109548629.b4-ty@kernel.org>
Date: Tue, 29 Oct 2024 18:56:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 29 Oct 2024 09:23:55 +0000, Arnd Bergmann wrote:
> The use of of_match_ptr() is incorrect here and just causes
> a warning:
> 
> sound/soc/codecs/cs42l84.c:1084:34: error: unused variable 'cs42l84_of_match' [-Werror,-Wunused-const-variable]
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l84: remove incorrect of_match_ptr()
      commit: 0d4f74febc9d92d88099aff01f121b7f5f942c8f

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



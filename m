Return-Path: <linux-kernel+bounces-429679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29E9E1FD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA89F1686EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5581F4725;
	Tue,  3 Dec 2024 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTSADOOh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87841E4A9;
	Tue,  3 Dec 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236919; cv=none; b=SuG+r88yqxF4df0kXbsUGdN8ieN4qyrzhDW+5854Dn6+dDEN7EywVUfzcGj77zxjblLIhPlS5RCt6fSqZ+JEgSWm1Dzcx9ypvL+s6UD0uEqmYCdqOeYG8NMiF82vup7kZZsQ3dxWQtF0pb7xWSm2jM4QFjUEc8nQ8VMO4CuJVs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236919; c=relaxed/simple;
	bh=3s2rLqVFzkG/7hsZLgSm+vZhQcwjwFq4j/0oY+CmA0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V+94lrKxhg9FhDx6xr2c+wO/D0E2vfMCYqZj/eJZE2hToKBNtO9EHQWCc57dpppd1ZPtBgZs0IK36r8yKdCgTssw4wIdstizf+NQohtWL4emBUmWTu5Scaekjc6csYI7TZRdFoasyb2X8QhUy6zHVyammhK1Yt4zS/6gFWYAYN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTSADOOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A97BC4CECF;
	Tue,  3 Dec 2024 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733236918;
	bh=3s2rLqVFzkG/7hsZLgSm+vZhQcwjwFq4j/0oY+CmA0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dTSADOOhLCmWUTN5/YFlhk5W6YBLSUq8FWrJ2+kOvr6Ij6EcEyEkd92CkOpKJrJqZ
	 15V5Wv53fySH1hW7Qm0lst6kxxrPDs9fp4e3D/TETsi8iAH9WdV9HGVcB21pyCMwpa
	 bFOy1/zfosWmXXCi1M0tdLbfrzDSiX2pgbdT2cW1kRMlmXF3qMpCi1nzT6GA4vIdSO
	 URgxKgfJhxLOuc1uEU0PzL3BSxFthai0PN6fegUzqhxe7FCcAS0HfjyiflMFyAmwxL
	 DTGQDNDpO57ybDsXOZaPA6nIaKGLaevgAr8ZurFcGUjQyFWsvh+caEhuYIeMD4/tNA
	 a0x5hK+8Gw54w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Kiseok Jo <kiseok.jo@irondevice.com>, Binbin Zhou <zhoubinbin@loongson.cn>, 
 Tang Bin <tangbin@cmss.chinamobile.com>, 
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
 Yang Li <yang.lee@linux.alibaba.com>, 
 Igor Prusov <ivprusov@salutedevices.com>, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, asahi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202113641.1003836-2-u.kleine-koenig@baylibre.com>
References: <20241202113641.1003836-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] ASoC: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-Id: <173323691528.75840.3593450234330035704.b4-ty@kernel.org>
Date: Tue, 03 Dec 2024 14:41:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 02 Dec 2024 12:36:41 +0100, Uwe Kleine-König wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
> 
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      commit: 8359ea9c119570fb5971379655661f77a3aafb1d

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



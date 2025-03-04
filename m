Return-Path: <linux-kernel+bounces-544153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD5A4DDFE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F43B2BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56B2202C32;
	Tue,  4 Mar 2025 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9sEC6s2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5FA1F63E1;
	Tue,  4 Mar 2025 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091622; cv=none; b=D14ona6vL4+r23k77ROGD7AqdGxBzogCbaJxac+I48hQSmdRkgBrbkVLAg+r7le7TowTr+EB5WikF2A8ESgOPxoPmfaUJCWjnViKBhkdGfJ9vAYHlQX7J7g3jxQrAFrmZmdUjbBlATmY1vf0+2+RVPRKQHZ07g4nL6yqu+sUVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091622; c=relaxed/simple;
	bh=dqZtGwJUtXDmZoMfVHnN7AcR4HjJLjiW+lGh8hxZgPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PLOj/fZYpLlx8NMBtrZTWGv8bwCmrTMFuP82wUa7He7+3TteeFguvqUK36EUkkHCtHOmUIXbcUDViKkI3dlkaU0Pxle9KK1AmifZkm6trFXZziZiA1qZYvjCUCqwE8fu6WVWhKsQP0otZNhEe9n+L/XZMFxLuVyQlVhtx08ZhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9sEC6s2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3845FC4CEE7;
	Tue,  4 Mar 2025 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741091621;
	bh=dqZtGwJUtXDmZoMfVHnN7AcR4HjJLjiW+lGh8hxZgPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e9sEC6s2WExXlMgenn1JeA31Ur0QDQVfiTXL+Flkg2OyNlnf5u9pUh2ANP/IVVVxN
	 jOhNcnHmLO+rXLPUr7EtwO7OxkQdE+K9GLWtalKa9MuG4qSBzWisefhbJWCej87GSR
	 6cNgK/dXT8q2eIadA2VIAVSORMRV6NeWKAdeq6CPzY9O9Vopmvt2m0FBjkaofDYtGO
	 NEfTz4afJE6UqH1RqCi0o1Ps2989x9T1d44/la80iBgsL0Qimu/Ct/guv/mbtkQrUn
	 7mUQakTdpQ5D6/AgAysnbXFckiCQ6JOXZeKtWEBl4wHPeCoa9UWwtzqNOhUpCD7d9n
	 v42cQlhNTEGhw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250223202547.1795-2-thorsten.blum@linux.dev>
References: <20250223202547.1795-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] ASoC: SOF: Intel: hda-dai: Remove unnecessary bool
 conversion
Message-Id: <174109161795.25452.18341311547791859737.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 12:33:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sun, 23 Feb 2025 21:25:45 +0100, Thorsten Blum wrote:
> Remove the unnecessary bool conversion and simplify the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda-dai: Remove unnecessary bool conversion
      commit: feb849404a8b677aa6760d1539acf597e4574337

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



Return-Path: <linux-kernel+bounces-285069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F099508D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EAFB223EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A6F1A2561;
	Tue, 13 Aug 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urTqw7Fx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9A1A0B13;
	Tue, 13 Aug 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562374; cv=none; b=hx7RAyjEDfYJ39Vv2DwUxNNpnO88OhH5pHrf5k5QMymM2f7DLw0yoUteGsfvZgVyvW9boajfAkTX/4l7aihNIV+IFyJ5zuWt3quHBgX+mAzBNbvqJ6mmrB+5bLMxcCQ6TAcfEawAlw5XEeCERVeupT+tXv0NImJ+Nb0tb9GJmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562374; c=relaxed/simple;
	bh=IjWYqvVozMU5xDb4PvFiGRW9tuYNkqmyRRFkJ2XA9nE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V3UMU83zDbvSycEndxpU1MC3NY7BC/9+kkLyF1o4X9QB28FDceiKbwjjhZY8ntLmONMcQwkvOENRSoqIGAlbTFe2ECqYUaQByb/NxoXvpHCuLQ8eX1fe1YVu4o1+VhX8L05avnUMliokiy9VwyOoK0P9RGio/zqPdB3TBHoUio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urTqw7Fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2F6C4AF19;
	Tue, 13 Aug 2024 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723562373;
	bh=IjWYqvVozMU5xDb4PvFiGRW9tuYNkqmyRRFkJ2XA9nE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=urTqw7Fx3BrW36RwafkTtFLwboqOd8JmA+uleBl5yfSLbyapeVyeqXh9yHQobaZ1f
	 tK9BQBwCk21H0M4rC4il842m/GbJo3ayEpSE+U5Wku7PwTYfNNlWvQCYhlWr5ZcoLM
	 gyluLp7NjnuVtc/yRlCrGVxOqJ17O78NRxWXhBszyD61XwRZkOEwzrpGvaFKObERUB
	 1j16KIWTr9y4o8FOYbLdDLeylZfWMPbzrLqU+2K3ka5tIqA+pjcjg8WN4RRQv3TCab
	 tNagbceOOkFmHfAyJzFfaDr9Gw57W5A24FuTsnscYLcw8LRQ30A+/twSYmn1pqkIn3
	 yYkc0xcIMfAbA==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org
In-Reply-To: <5b906a0cc9b7be15d0d6310069f54254a75ea767.1722951770.git.christophe.jaillet@wanadoo.fr>
References: <5b906a0cc9b7be15d0d6310069f54254a75ea767.1722951770.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: cs43130: Constify struct reg_sequence and
 reg_sequences
Message-Id: <172356237111.72636.8665526019609243174.b4-ty@kernel.org>
Date: Tue, 13 Aug 2024 16:19:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 06 Aug 2024 15:43:00 +0200, Christophe JAILLET wrote:
> 'struct reg_sequence' and 'struct reg_sequences' are not modified in this
> drivers.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   54409	   7881	     64	  62354	   f392	sound/soc/codecs/cs43130.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs43130: Constify struct reg_sequence and reg_sequences
      commit: 86297bb30ae094e14a3a6c62b870a2f301a180a2

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



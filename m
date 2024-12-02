Return-Path: <linux-kernel+bounces-427610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC819E0370
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F542824CC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE25201273;
	Mon,  2 Dec 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA1MMO97"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3421FF61D;
	Mon,  2 Dec 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733146229; cv=none; b=CnfIZpI4i16NerNKJWMfjg1ZfavefiKeG2Q7ujrlIKZU+lc9v8RKJsYHW/tEKeSsIT7J3x7VFlByuwvGa6eGhBxxi4rPSkqxfcNoAIZbOVt40GUmefv7rkqFvtSIyeNMWvpVFP0Xt2PkorYZMCe8s3BIkG8CHQYYPyPo1kS7n7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733146229; c=relaxed/simple;
	bh=S0mkapFbGnsfajKZm8QKkmSAc2boXpDst+yWh+urgno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V90ZjKc2Mfn+iRaedwTKZHvPyYZu//XgL5FR63vmrJRjSew3IPfz61vUJGu527up2RyyAvtlv3kZNPOI7Be6bCXyxaVWsBZhU8b6Fj1Csf2bk7WSjxzCNphqSetY1TH34Hotju8TxpyXv6Dz69LR8odXxq/xy4FBxjLO6jwIaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA1MMO97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CF9C4CED2;
	Mon,  2 Dec 2024 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733146227;
	bh=S0mkapFbGnsfajKZm8QKkmSAc2boXpDst+yWh+urgno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DA1MMO97ZAW0TqB2X765/8qDDZyXL+7zSRTijCgc9gGli1V3IPoDY32ItaSi38hI7
	 Gkx9FNvX+Tw6QOHwYOhwTJijT1svCZnle1MyHt7wUfTvYtkUE+JQqbEPQSlE3kTBjZ
	 CylXbVWznRurYEaWs2I9bTYvuAw/mXXGF4yougyIb+pt9dAAEwwt8ysnLPhDLdWmYX
	 HDipFhf3dHNNvAJBCBnIM4OBeWy1YLeH7R5ahN6BzpLZD6WBHMIzOslhyqAyZoBGcT
	 RXZERaIAsPMhVocohn0yQuksRfeLClE3rqAxxa6LBX8OwJcMDrWeHztm+sgeEb+/B8
	 6bAdaRt0J6rJQ==
From: Mark Brown <broonie@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, 
 Marek Maslanka <mmaslanka@google.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 =?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
In-Reply-To: <20241128205215.2435485-1-mmaslanka@google.com>
References: <20241128205215.2435485-1-mmaslanka@google.com>
Subject: Re: [PATCH v4] ASoC: Intel: avs: da7219: Remove suspend_pre() and
 resume_post()
Message-Id: <173314622395.54037.14685523533292835181.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 13:30:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 28 Nov 2024 20:52:09 +0000, Marek Maslanka wrote:
> The presence of a plugged jack is not detected after resuming the device
> if the jack was plugged before the device was suspended. This problem is
> caused by calling the
> sound/soc/codecs/da7219-aad.c:da7219_aad_jack_det() function on resume,
> which forces the jack insertion state to be unplugged.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: avs: da7219: Remove suspend_pre() and resume_post()
      commit: 04c319e05d0b08cc789db7abccce0fcb13dbab16

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



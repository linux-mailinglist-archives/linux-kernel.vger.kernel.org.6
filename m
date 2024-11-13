Return-Path: <linux-kernel+bounces-408078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A295D9C7A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589231F2364C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A52022E4;
	Wed, 13 Nov 2024 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bk1gxFPx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF41F80BB;
	Wed, 13 Nov 2024 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520018; cv=none; b=hL2exVHq18jmBvQWUMVpOsAF4ZE5BnmqYzezvFUyDbDjULEwSWyPCnnmlPQOrROAF8F/0yg4Av0VgdNEY6QGBrP2fTHvvtw+HSoc1X0bkNbVlEZZUmGrKw1d3WmEPHdYSdzJ/7rWhRxQTYnZxFeVjY/koJrSKm41FpfFQiSBO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520018; c=relaxed/simple;
	bh=GN6ez5LH3n8oJxYDA0R33vrMUcLN60aHuBywIGOnQZs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QIavnH4VN5sKntI+hLdmWh8QyRkvRr5qm9+XcVaWjkG5b57etLPtykZLM5Ajbzx4uamWZiNpog4z7+PmWBSZJ6lcxwIngTvwn5cfC6kBtLY2TZZH/YXMnHGZJG7u1yvZrj6xiRqVsICQJF+AykD0ppDSnbpgkgL1uFUiV4J+9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bk1gxFPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257ABC4CEC3;
	Wed, 13 Nov 2024 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731520018;
	bh=GN6ez5LH3n8oJxYDA0R33vrMUcLN60aHuBywIGOnQZs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bk1gxFPxFmBMQ5Rf8WDeA0dNAYFb4scwvILCLhhe/VxblxI1xlLAV85KZGyCRA56e
	 sUpiUDdYOuYZKfoK0T+OqOKPY0r0UlXvF+AEpOLWegMq8tMdLcYifhUwJOeFdVwAwH
	 mMQaZuT3fH3UacWmXVlRLCeTs8y3v5t+eXxio0YC1g46MRDldBm6JAVUE9sTc0V0m4
	 1wFkWOVG7rD85w032FqQidDj4Vny0UGVHG2b0dwB3aaSQGFztfRFjgP7I9T6pn7NZ3
	 FcjUqcZ4IE6Mlta9bxXI5Msp8jXONQPI2M3jRUm8N36M8bRXMDnKWokXljDBoMsxyB
	 YFCTHTDtpHezQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241112-asoc-max9768-event-v1-1-ba5d50599787@kernel.org>
References: <20241112-asoc-max9768-event-v1-1-ba5d50599787@kernel.org>
Subject: Re: [PATCH] ASoC: max9768: Fix event generation for playback mute
Message-Id: <173152001663.471845.5810139737220775643.b4-ty@kernel.org>
Date: Wed, 13 Nov 2024 17:46:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Tue, 12 Nov 2024 13:09:50 +0000, Mark Brown wrote:
> The max9768 has a custom control for playback mute which unconditionally
> returns 0 from the put() operation, rather than returning 1 on change to
> ensure notifications are generated to userspace. Check to see if the value
> has changed and return appropriately.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max9768: Fix event generation for playback mute
      commit: 2ae6da569e34e1d26c5275442d17ffd75fd343b3

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



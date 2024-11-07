Return-Path: <linux-kernel+bounces-400199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845BF9C0A38
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49577284092
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFA8215C41;
	Thu,  7 Nov 2024 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0FdVTFC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C9521501D;
	Thu,  7 Nov 2024 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993742; cv=none; b=GYqtRNDl13/lnST6najmvqq1W9tfTk0Eo3y/lNjKHe9mi87ZTD1+8y8zOrllkRHQkMfDy54VAsSc4zVKOqjSyW9Q7fCZ2L07/SfGNdwyv6z0E8liLdwKQz14RXKDSTho2fN/nSdgmGEWg4yiQqaGCvsgZl0GgsIEcpluHitcKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993742; c=relaxed/simple;
	bh=GyWaCebIJB2MBOnYngkj3Xcn9uP7TVQyYFsiEtrBw/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LHgsc0wXeOagReMRZQG0a29bhtn7Jnf5q6FYMt84vstarfMDlxsZ75o3O+7WAEEBw8OwBMUskpDBBhid72cq2inYg2B2iK/y3anzHJaSybWa9XXhXhuNbM8wh2u0Hxgecos7RtqMO3UEv+/Vjghq7LNKyf6OFUn7ewcQ4LS0Hi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0FdVTFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73EDC4CECC;
	Thu,  7 Nov 2024 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730993741;
	bh=GyWaCebIJB2MBOnYngkj3Xcn9uP7TVQyYFsiEtrBw/s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O0FdVTFC5osat40Kl8QsKEksm5KYhlIo5NrZMfDOCPV+33J80/w0sk1jN8WQLjdm2
	 2JEHzlQrUeXXnPuBQDTkIGdu+U8oPmjVOb6CtFO22CGrF1ZC7iF6DOcbf1kU/EG3kz
	 ezSLxJFz3mcmYwP4tN8TcR4Xdy6Ve+8aAWY6ydQv31RiO2sD+J7piuXZMWbm+sJ3Ao
	 fKXx09KCWPvrKc9YUbuAT5EEqi8cmZmXK21YH9J5bFyaj/ITJ00HNsSKXOaY9EQqM9
	 YA1chybHueuY1SurPPDGmfPFR1jdyo953Hf+8tDAFvR4S/ZV7pAIs+RjXF2xw2IcOX
	 Wr7u5As/3eo5Q==
From: Mark Brown <broonie@kernel.org>
To: olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241106014654.206860-1-luoyifan@cmss.chinamobile.com>
References: <20241106014654.206860-1-luoyifan@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: stm: Prevent potential division by zero in
 stm32_sai_mclk_round_rate()
Message-Id: <173099373941.145735.10149404268306602537.b4-ty@kernel.org>
Date: Thu, 07 Nov 2024 15:35:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 06 Nov 2024 09:46:54 +0800, Luo Yifan wrote:
> This patch checks if div is less than or equal to zero (div <= 0). If
> div is zero or negative, the function returns -EINVAL, ensuring the
> division operation (*prate / div) is safe to perform.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
      commit: 63c1c87993e0e5bb11bced3d8224446a2bc62338
[1/1] ASoC: stm: Prevent potential division by zero in stm32_sai_get_clk_div()
      commit: 23569c8b314925bdb70dd1a7b63cfe6100868315

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



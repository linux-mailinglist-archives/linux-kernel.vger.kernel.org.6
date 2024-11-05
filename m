Return-Path: <linux-kernel+bounces-396811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B41A9BD28C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA50E1C217B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA8C1DB366;
	Tue,  5 Nov 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCHoQ3ve"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484917C7CE;
	Tue,  5 Nov 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824696; cv=none; b=MV9cFkXqD1Krb9csmldS1+6pc/UvRkYrPmWXA70Eguklk6Uc1fUU3CttR82sKeKx7/HFOSHDksYcW4VwZzz2X15wRwsb5WAaucB6WnXrH2b5lyaiY58Bd4ApnqY5e5cgFl6hck82FAV853p5fS1LXCkmY/tUEtsy6Qhe0vPj/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824696; c=relaxed/simple;
	bh=WCZhPeJ0cbeNMsYfbhHV+9cWVHtfghsiRz8NqGMWiek=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BYkATVTkzR4sVgzpXWW6bgJzf8alpJlLYXbCN/To6XKzBf+wmTxKQc+/UGvqcQ2KUMQcG/iz09h1pWVuJkaQbL6CZzvUGdRF2GDMGRCXoSiZHbSMZPi/wCUb+IZj00twMkerOCdW2F3c7KaoYsUkpdCSR/TgGDP89d482VAJ2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCHoQ3ve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C536C4CED4;
	Tue,  5 Nov 2024 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824695;
	bh=WCZhPeJ0cbeNMsYfbhHV+9cWVHtfghsiRz8NqGMWiek=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=fCHoQ3veyBOvbg2BXm/m/h8tBo8XlVx9QfEr7MaIADUFBbPVxB4zxtkTOI4mHyTCh
	 FqxwZFsaXZluemS3x0qkOYjBxCmbxakhfAU9D9QMwTbGaOnAP3LO4/uYEEOMuo04PH
	 WJrRxZnbG3hpVglb/WZjEaTleIk40KDioE3kFcj08Fquq0QUbFbRXP3cVAvC00PTLB
	 wVu4SzjTbfiNVsRAb3T4FHRqByBcNTTcCHJQClNDKZC1jHnM6umZDC4K2aUDwuLm0p
	 1xYvSWg73rYlbOz40DCKu5NrNg0g5aExS2V9kNu4qEoiC8oq9byePwV5RquO37zM3o
	 HIqUWhfGd3WpA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20241025062935.1071408-1-shengjiu.wang@nxp.com>
References: <20241025062935.1071408-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_mqs: Support accessing registers by scmi
 interface
Message-Id: <173082469323.77847.1613545045732850065.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 16:38:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 25 Oct 2024 14:29:35 +0800, Shengjiu Wang wrote:
> On i.MX95, the MQS module in Always-on (AON) domain only can
> be accessed by System Controller Management Interface (SCMI)
> MISC Protocol. So define a specific regmap_config for the case.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_mqs: Support accessing registers by scmi interface
      commit: 101c9023594ac937b11739aab149a0c14ab901b6

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



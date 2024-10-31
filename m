Return-Path: <linux-kernel+bounces-390896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9069B7FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084E21F22005
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC181BC061;
	Thu, 31 Oct 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbLyd1YD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77711386C9;
	Thu, 31 Oct 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391437; cv=none; b=ZLal8sQOaihI/GxAjU5UFW3IGyj7zQ1pk+5nBsJDVJnDOtYfm3R8DrqLmCOYoX8KkWYTTTsQp6/HN+wVIQAgQZizefnDlv4WwjPCZWzS5IIS6DujBR+owfqdKP2ja6w+XIw643l+STEe6mfbpkQbmqXLa12sdrQozw5HQ1zXRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391437; c=relaxed/simple;
	bh=BLJfnW3jiq/AIhgD6ZXfzXiMxza1mbbVkuda13/ao7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f6km46ckGpvWPWZOzmCcUfnBb9IXF7Wp6o2sICUJc72a4pUJ4+yUUYSBecAOcEep6JaNTRW1mMUBySihVrAKtu3mV+1GbpeCJif3SUNTmPSEVJZbVAsm1N6FbxDqvgHS5JBeSZqT04qKCLsb1L2C8HCXucv40VBhJAV9xSn6SM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbLyd1YD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BBFC4FDF1;
	Thu, 31 Oct 2024 16:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730391437;
	bh=BLJfnW3jiq/AIhgD6ZXfzXiMxza1mbbVkuda13/ao7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gbLyd1YD0w48TBG+uhYfCpKtjyRfrUgbUK500tUUQCxzUMxppMVt2du4MQ5XM245j
	 hCIraMnOE5h9CIALh2KCBGmvNzncRKP8CLgZ0cgtBaDS0C5erAglfr46hfF0BWOrbt
	 tdCjogKE7KE5IAKFLRwxJpEdQM5rHSsT7YNd/7Eqc52sWeIqONje54LySGbc1nwh+v
	 jY/zlK5oP2VbiTcKNd6RAvP7WLX/DyJpyzJ9CszNYkFtUCmEpb8ubHh8B25K6O3UzN
	 9deJCDvvlkvuM0IwD0lgNDDP4gDgzZZUoKsAO2P8nzbS567WZ7Kc+8/V0bICXaJXK6
	 JtFI9s75csjQQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, broonie@kernel.org, 
 Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20241014095202.828194-1-ckeepax@opensource.cirrus.com>
References: <20241014095202.828194-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH] mfd: cs42l43: Disable IRQs during suspend
Message-Id: <173039143588.1800953.3015027062724816237.b4-ty@kernel.org>
Date: Thu, 31 Oct 2024 16:17:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 14 Oct 2024 10:52:02 +0100, Charles Keepax wrote:
> The ASoC CODEC driver masks the IRQs whilst entering and exiting
> system suspend to avoid issues where the IRQ handler can run but PM
> runtime is disabled. However, as the IRQs could also be used from
> other parts of the driver, it would be better to move this handling to
> the MFD level.
> 
> Remove the handling from the ASoC driver and move it to the MFD
> driver. Whilst moving also ensure the IRQs are all masked at the device
> level before powering down the device, as per hardware recommendations.
> 
> [...]

Applied, thanks!

[1/1] mfd: cs42l43: Disable IRQs during suspend
      commit: 2bb0106db90f86c3c513c26bb42ef0798ae8164d

--
Lee Jones [李琼斯]



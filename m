Return-Path: <linux-kernel+bounces-376344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E26A9AB00A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE281F215A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419419F10A;
	Tue, 22 Oct 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYMnGAZN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B62B19D06A;
	Tue, 22 Oct 2024 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605012; cv=none; b=TnCDa0M08WeOPwE5fjd6uYlmUsMMpLh50TqhFf7WMZZo5EzxWZ4h6QwlLDkVZUKgK2d58StFtqHOq+ernTGMrCT5rmQoEXCQevZM/2C9QTEJqMnVFr39BNWOljhwRGaPkZB0Tyyndie4qVhnoDcq+j4QHLbkfV16/+M6GqQ2NEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605012; c=relaxed/simple;
	bh=WrfoQ0CcVnhI+DiLyo+NUznIagx+ZJo5tZXbePv565I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=teDhcwqaQ3jGqJYWPxQTemv+my7yHLz/SzId18YWV4NYsEQDzXXKnYxb0yNEck+WpNfjWmv+/Ig0nha0YUUEuKO27lVHnYFtKdi/R9ILgicpkY1UQ4FBzzKFTrPSA6JD58VaODDLLmNMqBEcx6E2nE3m0RF69UXeYrqxJPsSlaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYMnGAZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB0FC4CEC7;
	Tue, 22 Oct 2024 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729605011;
	bh=WrfoQ0CcVnhI+DiLyo+NUznIagx+ZJo5tZXbePv565I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JYMnGAZNX6IebZEAju7HITMfMDOrw0X391qVeotVMelYwNgzpCasz9NVQbCNxo25o
	 b+dFlV6z393kaE7+L/cmwu509km7H/MomwghqVcVNRAuliC/VwysUtwrnxQvlUBAfH
	 /MghiEbjxC8LRyitCGwvBs/DoABU4L6UlKJYVA4fmBfKHLH16urwSirxilZqbNzolJ
	 DuCHmXIg2pnyd6s5xvPdcel48BMVIvHw0mWwgcrXXRnhv5laHiLgYSqplYSwRDLuVt
	 i7SIlsKSVBXLf7r6XMjmyeWszntQJOu1ulW0cMaoYNnp9unNn10cvLeK+Ht/hoh3Pd
	 q5BvvxveLrC/w==
From: Robert Foss <rfoss@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241015073004.4066457-1-arnd@kernel.org>
References: <20241015073004.4066457-1-arnd@kernel.org>
Subject: Re: [PATCH 1/2] drm/imx: parallel-display: add legacy bridge
 Kconfig dependency
Message-Id: <172960500762.1579658.15507711463714527962.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 15:50:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 15 Oct 2024 07:29:57 +0000, Arnd Bergmann wrote:
> The driver now uses the legacy bridge helper code but can be configured
> to get built without it:
> 
> ERROR: modpost: "devm_imx_drm_legacy_bridge" [drivers/gpu/drm/imx/ipuv3/parallel-display.ko] undefined!
> 
> Add the required dependency, same as in the ldb driver.
> 
> [...]

Applied, thanks!

[1/2] drm/imx: parallel-display: add legacy bridge Kconfig dependency
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/ef214002e6b3
[2/2] drm/imx: legacy-bridge: add MODULE_DESCRIPTION
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/df606be44c16



Rob




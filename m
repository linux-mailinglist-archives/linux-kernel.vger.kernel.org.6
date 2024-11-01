Return-Path: <linux-kernel+bounces-392271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE09B91B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EF3282861
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522241A4B69;
	Fri,  1 Nov 2024 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRVHzdQZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA11A3AB1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466952; cv=none; b=odjVet5MBcO8jmHF0i2jKKuFwXkgB4MEkbFTmelkE6MZ6sa1XSEyFzW2jpHCkHozfh1kU03jjD1x2GzgpMKu8qIvkWRyBN6kVVun/NwVFgWOrWD2ns53izCfCD/eJ78WiGceyd6o1CXaxSLIpCJ2YFmOdVVEmp7I0QsSOBto3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466952; c=relaxed/simple;
	bh=CbliUjxHWzid1HaEjMD52FwgfpHebZBaQqZhjnsFu+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sJd70ECLB9wlXIvxeQ1vjnnFBRC0Dm1Mh/vFfdDW7zkLMT2KUqrA8XUFOtARI/CuB2p7fI7LCrMFirUMFao5q5F+fDsOkqdE3Kf9odg4G7qB13rW51qpbTxdXPotSX5O26CgKibI5kW144eTdR9/xOtIHhLQsxG5+HKDo6tB8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRVHzdQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1751CC4CECE;
	Fri,  1 Nov 2024 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730466952;
	bh=CbliUjxHWzid1HaEjMD52FwgfpHebZBaQqZhjnsFu+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XRVHzdQZOWVsUswjczYlgJ+hGF0sDVSCrZk8lyv3lQgwMvnUPYs4OHd9JAQT6RvdT
	 CdE/9UuYRqhuEC4TyGp5WOlJqP9xSWu/TZHHhl44fl7VlMpxmVL4MqE9tsCylM+DXt
	 pPjKzNXsP0VvS1PHWj1PkCKybDxxcsolkM3JcCiafRnn5fyRSwYexIoISCIBDNHgf5
	 vwQwd/wzKozgQDDD7ZJD3OGUNzuPgHN9MLJM2Gmv8RYQCpnZejdCvBVS+fWNFZiDDJ
	 J1TjCvT1zcIU/F2hQMzVrhzhXkM3I61dFVxEZMwDSqhHLufTwnH+veEdp+JaMLSf5B
	 DH7vcUDSXcSxw==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
 kernel@collabora.com, linux-kernel@vger.kernel.org
In-Reply-To: <20241031-regmap-maple-lockdep-fix-v2-1-06a3710f3623@collabora.com>
References: <20241031-regmap-maple-lockdep-fix-v2-1-06a3710f3623@collabora.com>
Subject: Re: [PATCH RFC v2] regmap: maple: Provide lockdep (sub)class for
 maple tree's internal lock
Message-Id: <173046695082.38539.16119866726852880979.b4-ty@kernel.org>
Date: Fri, 01 Nov 2024 13:15:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 31 Oct 2024 18:37:04 +0200, Cristian Ciocaltea wrote:
> In some cases when using the maple tree register cache, the lockdep
> validator might complain about invalid deadlocks:
> 
> [7.131886]  Possible interrupt unsafe locking scenario:
> 
> [7.131890]        CPU0                    CPU1
> [7.131893]        ----                    ----
> [7.131896]   lock(&mt->ma_lock);
> [7.131904]                                local_irq_disable();
> [7.131907]                                lock(rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock);
> [7.131916]                                lock(&mt->ma_lock);
> [7.131925]   <Interrupt>
> [7.131928]     lock(rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock);
> [7.131936]
>                 *** DEADLOCK ***
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: maple: Provide lockdep (sub)class for maple tree's internal lock
      commit: 1ed9b927e7dd8b8cff13052efe212a8ff72ec51d

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



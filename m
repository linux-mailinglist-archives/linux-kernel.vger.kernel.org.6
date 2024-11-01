Return-Path: <linux-kernel+bounces-392270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C2A9B91B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3800D1C233DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743B1A2574;
	Fri,  1 Nov 2024 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/YitEh/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4619BBC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466951; cv=none; b=J39WPDj7sY5J3aNuD7JwVHxNB99Do0ocaRFcNiBoIxGJafFVuypOG89/ELKILiJv/efHbHhwuz3Ikq7lHhNJMHKtA5vYWnHqK8NuodPCfcortieVWt0Ad3o1Ipk22f1RkgWZJwxLxagY17lwKOVAOUz5pv4ZTg6U92OWPsfFAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466951; c=relaxed/simple;
	bh=GxFCQoPT6SBfv+qJ1/AwwrFy3aW8c94SJ4DDxVc0Kk4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d8ZncR9mjb4dJHFMXJzYAfupYpcMt6STbNABMbkbdgWqUou8PxpKGzTdTM01XSkBVpGQkBkwRQ0WLrigxBi94MLAZCA4owcQQqRNqk2/RwT2dncT0SzV9xkSe/0byESS1Kb/YHzCT9av5XOpH3KCTieqBdtgEqHqcrgtP2dhJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/YitEh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395F2C4CECD;
	Fri,  1 Nov 2024 13:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730466950;
	bh=GxFCQoPT6SBfv+qJ1/AwwrFy3aW8c94SJ4DDxVc0Kk4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O/YitEh/mRTQcygIAXXOmx4qrwLCkrgTZ4sOp2wnjUwl9VWjC3Tt2oMXhGMMBYgdH
	 KXnOdK31eykQtVrIkZrRC7XmUR+jVM7jx0WcN27IWw9Zw/mTca4g26v28PDpXLM/jP
	 DhenGrx6DtTbWlq2naJEEPFqQp+ztqma6ZvIfkAfYok3KUt7iLphxGypd6HyF9EG2o
	 XtLJu/2qAadPSQ72CRshpdzuXSKzcTJRaYSgR0Dm2v2PR0MA38GJJLOy/+lYfZYSSf
	 FmaMlYmWqQWaOwAupAO9zj7dfHXPfwRp6p2HoxAJ/7r3CKXVC/rL1krCXL/55ibfev
	 9mPlU98IXDuwQ==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
 kernel@collabora.com, linux-kernel@vger.kernel.org
In-Reply-To: <20241029-regmap-maple-lockdep-fix-v1-1-7589e57390bd@collabora.com>
References: <20241029-regmap-maple-lockdep-fix-v1-1-7589e57390bd@collabora.com>
Subject: Re: [PATCH RFC] regmap: maple: Provide lockdep (sub)class for
 maple tree's internal lock
Message-Id: <173046694894.38539.7909211961224919690.b4-ty@kernel.org>
Date: Fri, 01 Nov 2024 13:15:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 29 Oct 2024 23:50:12 +0200, Cristian Ciocaltea wrote:
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



Return-Path: <linux-kernel+bounces-211985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBD09059AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB0E28523C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136FC184109;
	Wed, 12 Jun 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALitZ5fV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576291836CE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212193; cv=none; b=Og/0mi7w53LLS/7uDLjsn8K92GnpXIFKWoAMeOTo4G5soF3uITvoqGTdR5tGTm9R7V5LnXoKFKogxFs+Bcxr7xfTm0GdIf7gi2U9UmnoKUxybU5575opKZvabHeKnO/FCW82E2+QaCGux7SPTjVDEgLbz8wQJ9vwAPaYjpXCyk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212193; c=relaxed/simple;
	bh=Qjb4PcQO/USKFK8Vace4JKabxLlwRQRzJetYbjp9Vm0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KRIAKPwq6+vKut1l4iUZkIvX30FY2EIco8Ah8sx0y5l5J5mn6d/qTxnHi0y9+fL/SUH9o5KDcc/DOH0AUlUVt/be5rUQEMSatXLYxdCJyaRF9wUF5DqkuF7lgiYKXbQC3UXiWURcOdnG1FJ5By+AzeXzrp6eG9wR7z+1mkv0tjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALitZ5fV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D296C116B1;
	Wed, 12 Jun 2024 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718212192;
	bh=Qjb4PcQO/USKFK8Vace4JKabxLlwRQRzJetYbjp9Vm0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ALitZ5fVkZmxyoh4Ba15dHodb+xt3ibwNAZZ4wLKNa+M1eowPv+ds40FGT8giI/hj
	 3vYu9qavcqoZTsl2GPdG6yDsv91oqtR/uloo1R7G6FWidbb3o3OBbWWyoaeqEEbyJ7
	 FDaXQl9qWOJ2VFrw7gkmfmz7mwQMAYFAnI1R2V7hbqS6N5VPW04J7qERnwka6rIWg7
	 W0lw2SinkwMR5GZeRijhWmzHv0ZJhhp2G1q49nyEnJDkLHCTI2Wbwauz2Sw1HNXrDB
	 0HK50re5GNCtB3WWIQ519d14m4RdNIdhFOXKSpnoLOlruyyocS5kbas8gGjSkq2BhR
	 FuKbns/T6zl/g==
From: Mark Brown <broonie@kernel.org>
To: Kalle Niemi <kaleposti@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <ZmmJXtuVJU6RgQAH@latitude5580>
References: <ZmmJXtuVJU6RgQAH@latitude5580>
Subject: Re: [PATCH] regulator: bd71815: fix ramp values
Message-Id: <171821219113.232568.16310408431096376740.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 18:09:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Wed, 12 Jun 2024 14:42:34 +0300, Kalle Niemi wrote:
> Ramp values are inverted. This caused wrong values written to register
> when ramp values were defined in device tree.
> 
> Invert values in table to fix this.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd71815: fix ramp values
      commit: 4cac29b846f38d5f0654cdfff5c5bfc37305081c

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



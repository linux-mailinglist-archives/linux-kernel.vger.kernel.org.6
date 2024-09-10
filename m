Return-Path: <linux-kernel+bounces-323499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 099F6973DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C256C2883E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897F51A2C35;
	Tue, 10 Sep 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Blr4FFNt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A601A2C17;
	Tue, 10 Sep 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987750; cv=none; b=UdySgwKTzYAfHujF0nWIXnKhI1XlJY5IhInYsu43dJnekw1cOOUNDJwVwNN+Q0Y+C8T7vjNiu4jJUbJ7Wx4yRjfHdFWI1LP0Qh+2veAMcEZFVb/68zYulzS6HlnQOjQzk5orNs2PskS1FpXENfHdTxehhpbGIByO3OPhwrlMTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987750; c=relaxed/simple;
	bh=Ib2q5qUG48L1BNSRxOnDDPW+2Vgx/MGp5K+eSLG3Pkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lEjGgmOAzRCUtgpn3uLMRlHOXbNOvQqtted7qLAaMxGpncgxUJmc+wCbjG5EuMNAzDIwZVRaLjopdcc8GU4Ogdds05T6euYkaq3aOdGU26ygs5XJlhzH7oqOanqM+L88NeuZbUmq9aK0JZrFfvaGM2ZDRweK0tCALb2aWq9juq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Blr4FFNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19086C4CECE;
	Tue, 10 Sep 2024 17:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725987749;
	bh=Ib2q5qUG48L1BNSRxOnDDPW+2Vgx/MGp5K+eSLG3Pkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Blr4FFNty+BoTO3KTccXhfuyScYT6ZEZUieLBw/9So1Mqp7wHSYKVMFztMB4bfrKD
	 +RtJbO2ZoiBJcMTVthYnK42DZUvC9eTnF4IYi6NtoIvLjGkgbFR8xs7NlVSgMv3f9J
	 IGBt4C5Pv9ho7rZaHXp6xBe5aZubr+vwDhpVA4ftl4mE/aoUIMMnHYG0GVs5N17+Rj
	 qfFlBjnPHYmB72pajWqRFGjD8cR+r8f/hutFMhraaWhuD6F9CfP9wujg/oebirYvT+
	 Xqwd4gGrMyx0jXla5kzk4NrP++NO6uBva2JuzVckpAbNG+lGWYroix25vFmRaLrcBO
	 S556As4QQrX8g==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240910021104.3400-1-tangbin@cmss.chinamobile.com>
References: <20240910021104.3400-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: loongson: Add the correct judgement return
Message-Id: <172598774783.662466.1907446633578434541.b4-ty@kernel.org>
Date: Tue, 10 Sep 2024 18:02:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 10 Sep 2024 10:11:04 +0800, Tang Bin wrote:
> Use the function dev_err_probe can simplify code, but
> the error return should not be deleted, that is
> unreasonable, thus fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: loongson: Add the correct judgement return
      commit: 5e6f78cb5f53c52a11090657e917d2d7202aea23

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



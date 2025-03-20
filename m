Return-Path: <linux-kernel+bounces-570184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0559AA6AD39
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634BC4620F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D050227B8E;
	Thu, 20 Mar 2025 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zhi6SgYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2C1953A1;
	Thu, 20 Mar 2025 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496346; cv=none; b=YVkRa5joo1Nn0/P8cZkjXP2NKQfxTQnOXPJ8gropa+Ge/6E3vcLAzyIiIrfgQrXyluwWvBoUIC/fY3iu6Y5HxerPfi3J5hrAf4oGsOWpmYh18FjJ/MwzQbppvqWZ/17fuRlrQopKw6j6TK9+J66/ZqiVTQGbKriXP512w7RS8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496346; c=relaxed/simple;
	bh=kel6322F+AUa9Me7ttmY+GLSmbz3EpYQrShn5jV2tKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NHoitX8LUDf0viUbMO8M0N+nWDut+gC3/0+bOYupmOs+GESjbvkG/JmM7YPMXPVrZUFE1PwNxsaJP5c1an0JLd2xVhjhXSQ/H/9w8nr+8LtpEnyyRcrOcqa4LBgjvOPipKIuqukdaL5F2dKZRf1aGms9wLO75NPldVWwM7F/PEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zhi6SgYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9637C4CEDD;
	Thu, 20 Mar 2025 18:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742496346;
	bh=kel6322F+AUa9Me7ttmY+GLSmbz3EpYQrShn5jV2tKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zhi6SgYfbtniCP/Frj078ffSV4stXbKymxYdNx4rWXwjrXZXZx3hV4GxBWYVX3Gni
	 IGOwYabxTOLynCjyIe8bHg2UNYC0GY2Xdm2UhJROLKuUD4OtxD7HdwggeJhdYrjkLK
	 ++k/jUHvZ0Hdw6YXZCDvZ5Q4zfwy61vmvburUWW7NIMJilCo5HOk0SUv8yK1M2mphi
	 DW6OPN48Gl+PipcFN6jPsXZ7xq9jSiwnS5mhd0niGPV/KKMUJbq2OT04/LFlnr9b3c
	 btRmG42pwzRwUOZ0zopGNd1KfqpmGARur96k8jxfe4nSEuUWGThWJv7TJmVt4FREvs
	 j5A1FY7Onvjrw==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, shenghao-ding@ti.com, kevin-lu@ti.com, 
 baojun.xu@ti.com, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
References: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 00/15] Tidy up ASoC control get and put handlers
Message-Id: <174249634456.174081.3401907524253548023.b4-ty@kernel.org>
Date: Thu, 20 Mar 2025 18:45:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 18 Mar 2025 17:14:44 +0000, Charles Keepax wrote:
> There is a lot of duplicated and occasionally slightly incorrect code
> around the ASoC control get and put handlers. This series add some kunit
> tests and then refactors the code to get all the tests passing and
> reduce some of the duplication. The focus here is on the volsw handlers,
> future work could still be done on some of the others but these were the
> ones that most required attention.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/15] ASoC: ops-test: Add some basic kunit tests for soc-ops
        commit: 7a24b876ad8cdd56457e881d384a038922b508c3
[02/15] ASoC: ops: Minor formatting fixups
        commit: 534bfb330b2612199b2afaafc769ccb42bebb204
[03/15] ASoC: ops: Update comments for xr_sx control helpers
        commit: 7f978180673b4f3b68fcc66fc1f1d74a1fc5a93a
[04/15] ASoC: ops: Update mask generation to use GENMASK
        commit: c6002c1177cafb4462b6c188d2a62eb67f15165f
[05/15] ASoC: ops: Factor out helper to check valid control values
        commit: eeb76cb1fa0dcccf33091b04ba150076dfbeb6fd
[06/15] ASoC: ops: Replace snd_soc_read_signed() with new helper
        commit: 1522aacd0114069b7f01f047b9e5b159399af295
[07/15] ASoC: ops: Add control to register value helper
        commit: ed336066202c02f0b0e47d0cf08fd8f40a42351f
[08/15] ASoC: ops: Remove snd_soc_info_volsw_range()
        commit: 894a37c9de4b8a447ffa609d552e91ccb447c0a9
[09/15] ASoC: ops: Remove snd_soc_get_volsw_range()
        commit: fd7442561cfe9516b37cdb1d229dc1f811dc86cc
[10/15] ASoC: ops: Remove snd_soc_put_volsw_range()
        commit: 7d5df968f95cee274740d5fa42e0798ffb59bd38
[11/15] ASoC: ops: Factor out common code from info callbacks
        commit: 9dfcafe2037acc14265cead8d8a937a8bc4e01d8
[12/15] ASoC: ops: Factor out common code from put callbacks
        commit: 318e8794e05ca1879441a602e78c74f9d7e18309
[13/15] ASoC: ops: Factor out common code from get callbacks
        commit: 1e3cd64a29baa874b89180ac0744178ecb00f3cd
[14/15] ASoC: ops: Remove some unnecessary local variables
        commit: 94dfe71f0a4eb0d7df542560c22961dedf45141d
[15/15] ASoC: ops: Apply platform_max after deciding control type
        commit: 502a668fad12b6ca10bcbb615d62e61d3b669c99

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



Return-Path: <linux-kernel+bounces-397018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096DD9BD5AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25D8284486
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB9A1EF928;
	Tue,  5 Nov 2024 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeL6BOTg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF511EBFF1;
	Tue,  5 Nov 2024 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833652; cv=none; b=A+FYBMfUYjy9QK5Ic68ObVFqXyLqr/1C/Ho2UtLsSLmGPBEUDdWqtG0wbIAxKoMQDIMTnapycJwBggn2Sr5mlWPk2kMDbTN68RaHg0hMTK3wYxq8MsyZgi/3KBljDHegeQhWVCygTmeHP1XOTYOBOHRZTVsksgJ59ExA6o670oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833652; c=relaxed/simple;
	bh=MuK3FRfq7+1ACIOgRDoEQ6BJwiADcCz5WCKT6QfCaw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hBsbi8rnEIKnlw6YFiph/jqCONib3Mt1sM+1DktnErewWDPp/3USoGpeswoVVzV6XFsf3NA6b8qKF4d8AOt48ppro6OTLGzgZHWS+ReTA5DGoxXUxaP/xnGC+7+WNxv6oauYJoI91DRzuEhP4ri7ygVAOkZCHtE8nO4Bw9A80xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeL6BOTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2B7C4CECF;
	Tue,  5 Nov 2024 19:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730833652;
	bh=MuK3FRfq7+1ACIOgRDoEQ6BJwiADcCz5WCKT6QfCaw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BeL6BOTgK/2+/i3Lz/fBWvc6nu4MRRuxl4BKWlsfW4mT0cpIf89Wo8NFC7mCp4bUs
	 KoAS6Aec3xgeparovH6sXe87MB9GtWbWESwfmT5vbrxljYk0IqaH3T1V9MsEp9nG+R
	 B/oIZP+2ovIc53EBYsAStI4TbaSjUbGXRccyYq7nBLsklUPEWXXUrL0/Jb8zGEd2Fl
	 j/xock0QVY1Vb+cPp/JCQUw4iKQZXfYjsxTzf5aR+af7NUnHJMb1LU09yJYEdmWn0p
	 ijaXowYPXXR4jEzEgBn/FtlkqftprYwdH0Ca11R1K8CxjTUmOiG7/z/e1ilJUiEJws
	 8dVFSYxoKeyyg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, 
 pierre-louis.bossart@linux.dev, neil.armstrong@linaro.org, 
 rf@opensource.cirrus.com, arnd@arndb.de, luca.ceresoli@bootlin.com, 
 quic_pkumpatl@quicinc.com, herve.codina@bootlin.com, masahiroy@kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
Cc: yijiangtao@awinic.com
In-Reply-To: <20241024090324.131731-1-wangweidong.a@awinic.com>
References: <20241024090324.131731-1-wangweidong.a@awinic.com>
Subject: Re: [PATCH V2 0/2] ASoC: codecs: Add aw88081 amplifier driver
Message-Id: <173083364838.105724.16960222397895533638.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 19:07:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 24 Oct 2024 17:03:22 +0800, wangweidong.a@awinic.com wrote:
> Add the awinic,aw88081 property to support the aw88081 chip.
> 
> The driver is for amplifiers aw88081 of Awinic Technology
> Corporation. The awinic AW88081 is an I2S/TDM input,
> high efficiency digital Smart K audio amplifier
> 
> v1 -> v2: Modify the order of properties under the compatible node
>             in the awinic,aw88395.yaml file
>           Modify the commit message of the awinic,aw88395.yaml file
>           Move "struct aw88081" into .c files
>           Changing the order of header files
>           Using return 0 as a function return value
>           Modifying strscpy usage
>           Delete useless variable assignments
>           Modify dev_err_probe usage
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: Add schema for "awinic,aw88081"
      commit: 1d534bfb2b2ecec4e67a1667c67169f7a22e46f5
[2/2] ASoC: codecs: Add aw88081 amplifier driver
      commit: aaa73822bbf1912fb50ad21eb770258f7a84c6f7

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



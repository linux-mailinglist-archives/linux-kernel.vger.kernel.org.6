Return-Path: <linux-kernel+bounces-566554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 435BAA67971
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A38173665
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18B3212B2D;
	Tue, 18 Mar 2025 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvEZAX+C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E42212B00;
	Tue, 18 Mar 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315340; cv=none; b=EKtdBOp0Je6i1a8j8efnTKkA79T1NCPUFeAfJVvSz0Fwyl0k4jttak5IPPNdSICVIC5r+n0OUcXTpYEVw5HGdRpUF2GAdwGaH5dukYsgDdF2ov6sNIOnL1K1wZrhBgD6vIzx7lAgbwNnRKYRstB2XK8B7TzIh/4xqycx1H3/BI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315340; c=relaxed/simple;
	bh=wnl2NwzFRfWI9B+0pXiBWEfiup8Fd+EnVJVjNERrLPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I8zO+vFP/J7rVda1RsvYGVvPvwR2yakQlcm7MMhfVSlIkaj1Q7QGcaukUGK/9fYx99SktIDH+nZVpVFNMvaKqoeYt4uBTv6KGKmtXS81EYaFghedcbs9mBvXXmFrmu3ZyPKtuPofTICONlLNNt2lBJz/PUXFEcDbdSY+1oTtJag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvEZAX+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A678FC4CEDD;
	Tue, 18 Mar 2025 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742315339;
	bh=wnl2NwzFRfWI9B+0pXiBWEfiup8Fd+EnVJVjNERrLPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JvEZAX+CzNQVXbb5F/D/HSjHtJFxHToev4pQQqzooHr/+bRi5Q7KsmwbB7+xkEbkC
	 HG8dwijBT3EZAiYujC/+JMTeNaslHIV4hO4eD/xgvGgZBIXmTrqcQYyOboBaqnHIWu
	 zi17KYqbPTBtla9KofDmVmY5COnZjVKLQ3cbAvLRTxaMvCIH5dmPFs39DhlPP1WXrf
	 2GABIoiXzHqAQIK3GL63tUKgTqGFlEsn/9GXTyNoii7SSB1uUrIyMd6CCiMt9nMRzb
	 IncEiyopLTHRUmApo/O42wxOOOtCA455nEFEJO5/dY7miOqPSb3CPRCDpFDu9GjIvm
	 +sKTRiTjDzNMg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, jack.yu@realtek.com, 
 rf@opensource.cirrus.com, neil.armstrong@linaro.org, 
 ivprusov@salutedevices.com, luca.ceresoli@bootlin.com, 
 zhoubinbin@loongson.cn, quic_pkumpatl@quicinc.com, herve.codina@bootlin.com, 
 masahiroy@kernel.org, nuno.sa@analog.com, yesanishhere@gmail.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
Cc: yijiangtao@awinic.com
In-Reply-To: <20250312120100.9730-1-wangweidong.a@awinic.com>
References: <20250312120100.9730-1-wangweidong.a@awinic.com>
Subject: Re: [PATCH V3 0/2] ASoC: codecs: Add aw88166 amplifier driver
Message-Id: <174231533542.179247.14373898557017165095.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 16:28:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 12 Mar 2025 20:00:58 +0800, wangweidong.a@awinic.com wrote:
> Add the awinic,aw88166 property to support the aw88166 chip.
> 
> The driver is for amplifiers aw88166 of Awinic Technology
> Corporation. The AW88166 is a high efficiency digital
> Smart K audio amplifier
> 
> v2 -> v3: Modified warnings compiled with clang19.1.7,
>            removes printing of uninitialized values
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: Add schema for "awinic,aw88166"
      commit: 399f9bd01644c827be8bfca1236ec9b4c211ccbe
[2/2] ASoC: codecs: Add aw88166 amplifier driver
      commit: 88f200955977c211be053afebe3264debb9680f8

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



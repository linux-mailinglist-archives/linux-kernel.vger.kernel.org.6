Return-Path: <linux-kernel+bounces-321684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D41971E00
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8081F23246
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597ED3B791;
	Mon,  9 Sep 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG/iZst+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B619BB7;
	Mon,  9 Sep 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895543; cv=none; b=fHIv2wPQK2VRVk7XxZhWfTx1TWpgdHEcnModnRLGj1xxTuY2DFq1d0v0nB3VYdVjFRJLZwYlM+SdHyFdy1XZtXHb5EdCL0JrVlJWv5BbjtSOCzJFeXvAiy6dRayqLY9XaSnl8gi6N4VIOtUDvtJ9syTAXU8Ld8Z1oGqbleT5218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895543; c=relaxed/simple;
	bh=jMxN4Fl6ZnMlSt04M3dr89+fByKAO4mVkUVIINe02Sw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JKPkodGdqdM7dhQ9gihmD+t6mK5C+tJ0jv2gWY2Bu3l9zOOUGf7/7TrLNuLwECLPyaZ07VDLVoMgnvVUbAY3fpLy2r4QffPENzVKZfTGPQh0rf6o4ErgMA3NOCkkwRyPsxSSxiXmyU6sT/v3xsSG9hKbc2vcYHd01/q6acXlGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dG/iZst+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174E5C4CEC5;
	Mon,  9 Sep 2024 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725895543;
	bh=jMxN4Fl6ZnMlSt04M3dr89+fByKAO4mVkUVIINe02Sw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dG/iZst+guFHDwsPDx9GzQ4zc5dp2bB5lilnL+IkKuJByQK6ucKvjofURcbWxV5L1
	 jWu3TzAWUFxVRjFXJr1WzWz5Ltsl1eQDQlBlSt2cv3w7gdE+6HPkOwQSZw9m0Gwafs
	 A6qsTRbrDXKYDogcp/92ajdxjUNoKnEC6lK7dSzuIoMhlJVOUu/9Z+IUmo4/DcDXAr
	 a2C1MsqGhTbg97vJSEF+RPNtWZmI09Glb+feeVUQzoF3Hq9S9BHcGE7dtmnk98vyGG
	 MeAtmcrRgIePHVSMUaqijbkL5X5J67l5SJOgbGZtu2fmoETmRH+K5tmmqd+vawo5fP
	 qeqZUp38IM8vw==
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>, 
 John Watts <contact@jookia.org>, Ryan Walklin <ryan@testtoast.com>, 
 Philippe Simons <simons.philippe@gmail.com>
In-Reply-To: <20240816001824.6028-1-andre.przywara@arm.com>
References: <20240816001824.6028-1-andre.przywara@arm.com>
Subject: Re: [PATCH v3 0/3] regulator: Add AXP717 boost support
Message-Id: <172589553731.1703361.17276333493990928207.b4-ty@kernel.org>
Date: Mon, 09 Sep 2024 16:25:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 16 Aug 2024 01:18:21 +0100, Andre Przywara wrote:
> This is remainder of the AXP717 fix series, containing support for the
> boost regulator. This is meant to increase the battery voltage to the 5
> volts required to provide the USB VBUS power.
> It's the usual trinity of DT bindings patch (1/3), the MFD part
> describing the PMIC registers (2/3) and the final patch to model the
> regulator (3/3).
> Compared to v2, this drops the merged patches, and just retains the
> boost related parts. It also changes the internal name of the register
> to AXP717_MODULE_EN_CONTROL_2, since there is another control register
> we will need later for battery support.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] dt-bindings: mfd: x-powers,axp152: add boost regulator
      commit: b4c21faf69b8eec1016c776be4777f39f194e3b0
[2/3] mfd: axp20x: AXP717: Add support for boost regulator
      commit: bb2ac59f8205165fce5aee9135bd1e2ea9b1a74b
[3/3] regulator: axp20x: AXP717: Add boost regulator
      commit: 22dfe2ea1d63f15d8b9661e7690ac0a03159db6a

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



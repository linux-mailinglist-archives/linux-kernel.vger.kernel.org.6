Return-Path: <linux-kernel+bounces-553455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B040DA589ED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 02:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F11188D35C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3C14AD29;
	Mon, 10 Mar 2025 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3tSpHwX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBEAD2FB;
	Mon, 10 Mar 2025 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741569963; cv=none; b=sJjF41wfjAyuCJUvTXRadMsxWpTB218yZc8jYIGR151kQjjh2Pft1fL1rybBlzGxsh+mso4nR+VLCLkT4GYcoSLZZWwegTv8+OMpR96TM/8JkESMESTSbeXRXHbqTxpmb7KkI/Wi6UOcj/8OxPLqnBVjw42ywF2Aa5iuiQB3noo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741569963; c=relaxed/simple;
	bh=36ur/TO+eY3YKyPZxa0+OH3HDlC3TkS7yx23bLR7sN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BiJzNGnxWYPQrtM3PrN4gzPcEe2OnX+k1cdTottlp2Y6NB5bJzcWYnXh41DZTvu2ucHRJFzAr8/nQ5JRQb6wyMj8ZEXmpDx5G1fZFf2asn1NALn1GmVhaeI/N0gj/o3ldhqJM8Jh30xO7jelR9V1a0aBVRS4mp3WvZiCMznYnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3tSpHwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADB2C4CEE3;
	Mon, 10 Mar 2025 01:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741569963;
	bh=36ur/TO+eY3YKyPZxa0+OH3HDlC3TkS7yx23bLR7sN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L3tSpHwXnL9KqBxNpaUpUBfvDAPME1WADm6xgHV4GEeMv78dEntkYhZpnad8m2Qqg
	 nCaD51YfXUv79mERky9Qv25AwoTU4NdqSqeUNayCZrEMM/0OrqvmOeIK9W2oe06WEN
	 vc7U4IP07uNm3V3JdQ1YGdaUxSf4Qp2Yl5vObjZrtblcnLk+ED38ExqNfM/T8LQ1cc
	 DhU9g/ociajE/ZXXW0BZDgznTcnfJQIE0E1lFlBiZUBwQBplUVXXermwVb+rqz5izG
	 6ee6d71ZNMp6JYPHeokSB2vUUnKJuuomglwUbR0Wzj5rKp+h0yXpgvHRAFj6xe2A32
	 f6tS3S0yarH9g==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250306171840.593443-1-olivier.moysan@foss.st.com>
References: <20250306171840.593443-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH 0/2] ASoC: dmic: add regulator support
Message-Id: <174156995858.2353078.9754192448816004480.b4-ty@kernel.org>
Date: Mon, 10 Mar 2025 01:25:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Thu, 06 Mar 2025 18:18:38 +0100, Olivier Moysan wrote:
> Digital microphones may be supplied by a regulator. Add regulator
> support in dmic codec, to allow power management of the regulator
> through the ASoC DAPM widgets.
> 
> Olivier Moysan (2):
>   ASoC: dt-bindings: add regulator support to dmic codec
>   ASoC: dmic: add regulator support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: add regulator support to dmic codec
      commit: a8fed0bddf8fa239fc71dc5c035d2e078c597369
[2/2] ASoC: dmic: add regulator support
      commit: 1ec3f1dc215d4b3d3679ecdc4a549d4e82b3a609

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



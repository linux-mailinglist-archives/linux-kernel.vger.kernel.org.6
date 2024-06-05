Return-Path: <linux-kernel+bounces-203310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08A28FD93A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7F32865BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0443615FA8F;
	Wed,  5 Jun 2024 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym/0kS/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414821607B5;
	Wed,  5 Jun 2024 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623498; cv=none; b=SzTRdD7zeDm4HjVVpCLN9I7sMi9vscv46ALfNLQgY2XUJ7wdzJ9IDMx94CdlW39fHObMJhddXcjkcCkreo01d6olELvhqvI/OZFNr8idUIKEROk5LoKPkAXIZc1Jx7CKu3CYSRUZWyqGZwPYaVaRdjxiaEZT7528CZPx1nwYdIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623498; c=relaxed/simple;
	bh=rBGGoS167kQ+sG4t9OWK0GLv2EHAn8ZIL2hNB3Zfo8g=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bIXS65VB8UhMAt93r5e4JK7Oy2aTlXYoWqiNgFYbB8Xybt9o86+77VoiU5fdcAcoONvC9+MOLwrFXE8RFqvhwkKXa/U3/VtxWUKN2W9JGxSYUdohvHnOBRSPyedStDEuelySNRlo9FDmTzX5+HhHZc3MNGI5pt+t2cvzDafjCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym/0kS/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910FCC2BD11;
	Wed,  5 Jun 2024 21:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623497;
	bh=rBGGoS167kQ+sG4t9OWK0GLv2EHAn8ZIL2hNB3Zfo8g=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Ym/0kS/gmUDwepf+MPu7TmGfL+gfk1cslEIHcCOPxGquusgYywBZeceI8N0cq+2Mr
	 Bp2OHxBEB0DfManTr/xmqxg+O3RMUIbnx+x8dVcJwOjoZygT+DDG2n3KCyALbAmhzm
	 ECvYk7vKumMzGAa6HRCkJvcMN2f4flILzH5nmdub+Z1EHtYPoEQgcsMcAoDmDiS0YO
	 DWsdEDaWrQR3TpMB9zQg20t/ixv3pCEb2TeEMkFdRZBF44U2r0jnZzbMHkZ6BdhA/8
	 cgmNQdD7BF+VQuvfovsFQQMA5CvmJgrWhwJZo2yO5aAfNoIavc49GaMF5XIXMxTWZa
	 KD5bpxppYKR7A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240523124808.42923-1-krzysztof.kozlowski@linaro.org>
References: <20240523124808.42923-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wcd938x: Drop no-op ADC2_BCS Disable
 Switch
Message-Id: <171762349632.565712.2646435326229785795.b4-ty@kernel.org>
Date: Wed, 05 Jun 2024 22:38:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 23 May 2024 14:48:08 +0200, Krzysztof Kozlowski wrote:
> The "ADC2_BCS Disable Switch" control does basically nothing: sets field
> in driver's private data structure which is never read again to
> configure hardware.  Drop the control as it has no effect.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: Drop no-op ADC2_BCS Disable Switch
      commit: d8e5fa784867c4cd400afecc43aec57c51c10dc7

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



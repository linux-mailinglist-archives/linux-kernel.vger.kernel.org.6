Return-Path: <linux-kernel+bounces-409553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5869C8FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96287B38F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCE319B3E2;
	Thu, 14 Nov 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDHpDHl4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049819995B;
	Thu, 14 Nov 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598562; cv=none; b=FJjTu4xq5s7ai1VQrj22pN+eLffJOXNWZXH2T3Gy9g7+9wolcKwpm4ehjFea+Ods2fpI8z6ETFWJylpIKYd0ygwywAzaurgl4iK5n05F6Q0ExPX0iBQoiVUqetvRrTUxBRGNd4vnPkDAiV3NfvUi5io+jeHn0Fz0wftjb9NVyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598562; c=relaxed/simple;
	bh=rl828hm4qtTphXo1J5TgvuQCvwyvHSgptG9spLTDiAo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cfzyNE2TIScBCcd+jTpJkjKabJSzCWL1d+xYXdnCO157k9rQbhEJ5eBy5VjpJUSCSCdkXqhVyQ3nXcBjNJMf/cZoi1q0lctfTs0tEXzlVeF6D6aeWhrq50pWylzB2eZKhAg1/Jfv4tRK85T1lHqA8v7edZmTJV1ZfWRW+w5Nn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDHpDHl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424F9C4CED6;
	Thu, 14 Nov 2024 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731598562;
	bh=rl828hm4qtTphXo1J5TgvuQCvwyvHSgptG9spLTDiAo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CDHpDHl4Owvnccl7T4oODjqPSC10ZDDWJLvjdOn+zg0vqYpfl47ENw/poHtTWguMv
	 gvxXQkeLdpmgYneyP1gJvR2KeOtrHJBtVZU7Dk7fXkiGcDq1cfIzOcZVCfaQ4euRbN
	 7W459wAPRiOhsg6XCvT5EPUcYi/uAul250nTKTY8KZCabsQCPtT75h97JZeTAtU4qo
	 CMUm/IfQ9lP961LtKBxLh4QxAy8F+4B3bXKY3bB2yo1Be4wCU+mva4eAAnd2jPznKC
	 /AdwldVh9ax+5NvES9PjZxDabTA0bDLspecNqGd2hSOyAgTxCH7bf69kJ4ZCvNhcDm
	 hPU1pRWPp5IzQ==
From: Mark Brown <broonie@kernel.org>
To: Kiseok Jo <kiseok.jo@irondevice.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Tang Bin <tangbin@cmss.chinamobile.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241113175734.2443315-1-arnd@kernel.org>
References: <20241113175734.2443315-1-arnd@kernel.org>
Subject: Re: [PATCH] [v2] ASoC: sma1307: fix uninitialized variable refence
Message-Id: <173159855986.505512.7552118028382530741.b4-ty@kernel.org>
Date: Thu, 14 Nov 2024 15:35:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Wed, 13 Nov 2024 18:57:13 +0100, Arnd Bergmann wrote:
> When firmware loading is disabled, gcc warns that the local
> 'fw' variable fails to get initialized:
> 
> sound/soc/codecs/sma1307.c: In function 'sma1307_setting_loaded.isra':
> sound/soc/codecs/sma1307.c:1717:12: error: 'fw' is used uninitialized [-Werror=uninitialized]
>  1717 |         if (!fw) {
>       |            ^
> sound/soc/codecs/sma1307.c:1712:32: note: 'fw' was declared here
>  1712 |         const struct firmware *fw;
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sma1307: fix uninitialized variable refence
      commit: c48a4497356f701f94f1951626637ae240af909e

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



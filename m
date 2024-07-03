Return-Path: <linux-kernel+bounces-239587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AC99262D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACADFB24FD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD2917B436;
	Wed,  3 Jul 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0mzXWFe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA117967E;
	Wed,  3 Jul 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015630; cv=none; b=YEf77RO7x5+NqMyx6BIS/Wzmj9EkxuPl0/GPciW0wnou6w6LHtb9CEv8m0i5LQADC73tqK6liwxXsadE6xiMB93VVzKbtq199PRTaFR1Z0/TpvyQtmupVNviXMD30yllZ88P60tqVf+NmiHdIJyvhtDfdAT8Lotmf7RfTlj2McQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015630; c=relaxed/simple;
	bh=LpyaKz7iM69QFjuo9B3ujEy0kh0tLtON5z3kj0cQ0Fk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qE3OcSU1oPz1eWFvthReTrpDnEn1mgpgzO0vE7Ofki5PhTNQREILQdgKyzblXob2HsrQlQTxW1I2eylTu9rgx68i2qzJ9y1tT6GP44TdOPSZGOcKvuXrSCxHprwuZrpenKMAYb+G+rc0HihRNwrt4xA+BEElPzlVrRMbt4j3idg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0mzXWFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E18AC3277B;
	Wed,  3 Jul 2024 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720015630;
	bh=LpyaKz7iM69QFjuo9B3ujEy0kh0tLtON5z3kj0cQ0Fk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S0mzXWFeOVgNNtkj0OYoyRs12o/fkZuDj7ElXpdi6jeOQNxlK3V/hsJ6fQLHOhItV
	 DBs85EzLBAd0yHPMhbN02fXjNVO4SmPeVZDOTstCrK+R0O8rSLSeDuL91pU3PswIR3
	 uICAFCfEoz26T/AmMOnFd0h0VDaklAwEAjcu2ZFpLRv89Kl6dcV616TTHr01bf0c7F
	 nMCKtzgWb04iMNFOaJ+5p3UbE5djG/YlBU1zyvogdVL8PXVjwRxA0vEQTCC7ZIu/iR
	 WpgXnNfG3RoNk12GqmZmrK6w6nnpkc7ZeowbRDF2Um1ql9gldKHfKpzNsyF9FVHCVB
	 MZT/n5Zvq42SA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240702215349.839350-1-robh@kernel.org>
References: <20240702215349.839350-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: PCM6240: Use of_property_read_reg()
Message-Id: <172001562874.37877.13638252331095584419.b4-ty@kernel.org>
Date: Wed, 03 Jul 2024 15:07:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 02 Jul 2024 15:53:49 -0600, Rob Herring (Arm) wrote:
> Replace the open-coded parsing of "reg" with of_property_read_reg().
> The #ifdef is also easily replaced with IS_ENABLED().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: PCM6240: Use of_property_read_reg()
      commit: 4aad1d9471108a5023e224422b2522323521174c

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



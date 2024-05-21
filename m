Return-Path: <linux-kernel+bounces-185113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9458CB0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47FCB258AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF12143722;
	Tue, 21 May 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnk7g0ab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348FF142E60;
	Tue, 21 May 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302706; cv=none; b=iduZzzGWa4So+MF+Fq5RJ0MNzIL3uR51XHkLpEJBEUXtkibO1aGfA1uc/idv5LphZE/Kps5h6BBFyUYD2tDoiozHgXTORpdEQaDkirhwSOdTKEWrMY4DkkCCEbCE7xRKbS8MdPH27J13/H0xj4BFRio8Ki72wpFRgI2pAjaOeOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302706; c=relaxed/simple;
	bh=tNZZ7UbqGFi99eQF7zZneciQh6sIOV77HiXIpo+ovP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S5USpyO+jYFtKgH0xs6hdOvY5U9vbVtNw7IVbLbdzU0iu7Bfebk9mk5QKhvBwO8W0dzdY/mDuCGHrE2/jHDF+O8mCMaeuc1x/q84QjmGOT9ZIewTMVQIxvcYMqfAj0oXSltlHtAAYHU+rfnwwy2cxaljmPNoIqbi9KXd2CwjE24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnk7g0ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE386C32786;
	Tue, 21 May 2024 14:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716302705;
	bh=tNZZ7UbqGFi99eQF7zZneciQh6sIOV77HiXIpo+ovP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gnk7g0abzwCR7AADNUdIueOb9ERBfsgKWSi8Feu47T7UxVxXWRVAaqQ2oVZ2R+Kj6
	 caude00KUsLhOgZzjkgssfQRrdL7G71XxZpV5NApfb4+cY5zItiJxeHosXcOf5oV5c
	 /kvVoxJXRJ3jdnH6EMrsIVfEfdsqeM0Z0K/BfaFLweLPbb9/2xFZ3UCtSDTL7Jn+7q
	 ksYmdgiPG6+DRdp73WUOGuYXYXyxzJhR8su7p37JxnOGAYS+O6CWf7w+mW/qka3eQf
	 ILHRaRYBg6QQSWdp7S9N9Lxks8nMFWbliGBVbLdlhUxDEzFe25Fvygd16ZopMSBkJA
	 O5ZkWAxEG0vxg==
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240520222705.1742367-1-robh@kernel.org>
References: <20240520222705.1742367-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: stm32: Ensure compatible pattern
 matches whole string
Message-Id: <171630270256.58467.9560399752329823941.b4-ty@kernel.org>
Date: Tue, 21 May 2024 15:45:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-621fa

On Mon, 20 May 2024 17:27:05 -0500, Rob Herring (Arm) wrote:
> The compatible pattern "st,stm32-sai-sub-[ab]" is missing starting and
> ending anchors, so any prefix and/or suffix would still be valid.
> 
> This also fixes a warning on the example:
> 
> Documentation/devicetree/bindings/sound/st,stm32-sai.example.dtb: /example-0/sai@4400b000/audio-controller@4400b004: failed to match any schema with compatible: ['st,stm32-sai-sub-a']
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: stm32: Ensure compatible pattern matches whole string
      commit: 737ce4fb96206f999ddea7530145fc0e8abd5d31

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



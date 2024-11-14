Return-Path: <linux-kernel+bounces-409709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806099C9057
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4635E282BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486CF18452C;
	Thu, 14 Nov 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txv3kyeP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A318C930;
	Thu, 14 Nov 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603491; cv=none; b=CSKup4VSuGQDMh/P2aZ7g/BZZpLNVHlhY2qeTox+gdtMc+4NQvb1qh5E/fEmKfc/ki9b9ett8smGc7LKqif/dEFLWm0UCqb2wcLn5UlCgExNllQ+1WzpbL2qHUQ54aXH3cv75VowJqq8ryrUcq0yW3UBLarqx2oLlElFbLczkxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603491; c=relaxed/simple;
	bh=1NYyfhvpaHaoMxKldegCUmIUdIQjsXmFWCzEU3/3wjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZzvGVIV64MNNW444YmNZPElFoQPV7ynBAfVV5fZTkcuJo2zurlFjb9Ncw7dw1RiXVEa3clkEdyeEWuv+iZfQgG/r41LGftIGk/GzdTGy8rB9lebIRU639wPJH6+Bnk2vr938nsRfey2xOhi9pQKTvKUUByT997g3kh3N961aKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txv3kyeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BD8C4CED0;
	Thu, 14 Nov 2024 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731603491;
	bh=1NYyfhvpaHaoMxKldegCUmIUdIQjsXmFWCzEU3/3wjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Txv3kyePwuqcJtw5NY64raF6B9OwQI8iVh0PNbb+oJ0JU2vE4KZaX0Ihnr4sx2Jzq
	 V2ApIeHtIW4oIQs8/udP7l1uZnR4q66FeTOB6xAy5HeFsbjE75KnoBvEmHhf5cdJkG
	 9B18OBRKuqpUdzjTC5/lgqMB5KtIPN+3YiAMxlDPqkZXlCZodBbsPibMGqhroPSRpv
	 ovS3qlDR3elMMusvMcvGv+rlRMdKIfLXxLu/GrGbS+upKlfRf98TGAOZEgj/xRl1zd
	 GUYl4XDOw3E6ogbhWOJbPxYCPVM/Xqo2Tie7D4K1EIbpA6zFeQpaWDwco2c0tZqnWF
	 JdG5Q3Z6MxZ3g==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <aleandre.belloni@bootlin.com>, 
 "Hendrik v. Raven" <h.v.raven@merzmedtech.de>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20241114-simple-mux-idle-state-v2-0-a30cb37d2be2@merzmedtech.de>
References: <20241114-simple-mux-idle-state-v2-0-a30cb37d2be2@merzmedtech.de>
Subject: Re: [PATCH v2 0/2] ASoc: simple-mux: Allow to specify an
 idle-state
Message-Id: <173160348868.529304.8793310575318436684.b4-ty@kernel.org>
Date: Thu, 14 Nov 2024 16:58:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Thu, 14 Nov 2024 12:01:24 +0100, Hendrik v. Raven wrote:
> This series adds support for the idle-state property from the mux
> framework to the simple-mux audio variant. It allows to specify the state
> of the mux when it is not in use.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoc: simple-mux: add idle-state support
      commit: 2b974284aa073d6e2936f9032e8ad7b99480b5b8
[2/2] ASoC: dt-bindings: simple-mux: add idle-state property
      commit: 3b7e11a0116c30848d44429650ad80f9cc3bd963

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



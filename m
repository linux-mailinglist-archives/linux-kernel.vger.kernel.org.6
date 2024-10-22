Return-Path: <linux-kernel+bounces-376178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2DD9AA130
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101291C21E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDB219ADB0;
	Tue, 22 Oct 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJqLi2U6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C3713D516;
	Tue, 22 Oct 2024 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596758; cv=none; b=EYODqMv2ESi0fOWsgp3tQxez27uLgix379GfI9vpvS/QJvgWWAAWd4oUTDIUSz401oJYkCNKqeXRFJP74TkivozaVLN3D6+5j5v/ESebxVDkiRPAkej472lazp5SMqFDSCvGD1ERz4mm/aI9qOTeb2LU57CnDMUHEd7AyB9QNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596758; c=relaxed/simple;
	bh=FkkqCU683ZRtRpELveQpY8sLAoh27fcWoRv5y49TUes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AR0o9PegQANbJhnb5wmPaDCNUPczW/pb1SLFN26IV5LE8wZ9s8oFiyfI7T3LUmefLzBICIou+TurO4KhIxqqX7naHbiuW2wp6uI2XodyPCgyH2b6zbDRVcHkp0fjYLGLjT0vpfvbzs+QoAhqEmnZzmttdYubicnpwmhRdzBtkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJqLi2U6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA53C4CECD;
	Tue, 22 Oct 2024 11:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729596757;
	bh=FkkqCU683ZRtRpELveQpY8sLAoh27fcWoRv5y49TUes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UJqLi2U64hbi0dfDN0Fg6E/tcaB56hed+Y7KknxbWI0Z0WGugybx9AgL1QW5lD+aN
	 hBl/WzVwjCvLOiw/O8S3PoTTwGinZ3CHq0SWS7K+r8OJszvuBA9AQzKZPqNuRaYJV4
	 jzlibvrIlIQRAlhjjuQZ/f0NiGz/4LEIQrDWj7UN1bcZOwdciBLrPQ1PPzRYAH2hr8
	 52mdJTjEuVPvmWJC0wKr4rswcWsXC0/NhlFFg85n4coznaPS7hUzsef8yEp7jPMdG5
	 4xWNT31iiWVvGttVvVyBLU+g8LHv78iqPunPWvdqQ7EQ1EzDXCeTCecXgsC3iScFi1
	 0jQxTLS0M6hLg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241021130308.3616451-1-ryan.roberts@arm.com>
References: <20241021130308.3616451-1-ryan.roberts@arm.com>
Subject: Re: [PATCH v2] ASoC: soc-utils: Remove PAGE_SIZE compile-time
 constant assumption
Message-Id: <172959675624.19329.17579000137371454684.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 12:32:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 21 Oct 2024 14:03:07 +0100, Ryan Roberts wrote:
> In pursuit of the goal of supporting boot-time page size selection,
> remove use of PAGE_SIZE from the dummy_dma_hardware struct definition,
> since the value is not known at compile-time for this config.
> 
> Given the previous parameters were "essentially random", let's just
> hardcode them as 4K and 4K*2 to sidestep the need to boot-time patch the
> structure with the selected PAGE_SIZE.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-utils: Remove PAGE_SIZE compile-time constant assumption
      commit: 5337ff41d37d4171868bb7b34dade68e269743f0

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



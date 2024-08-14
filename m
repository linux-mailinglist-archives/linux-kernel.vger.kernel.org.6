Return-Path: <linux-kernel+bounces-286403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF82951A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD35B22E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC241B0104;
	Wed, 14 Aug 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5sVfw0V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E202613D51D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637142; cv=none; b=s4tS/I4Nmp6s65UGJP31h1rQA62yf9ykNMErWD9/Z3YdTdqr3ysYfoBJ6oowhoc/qho8wobNG8GT9SXvVnTN75CU0AD8mj0SWccHwdJyhZwBs1ylde4PqfNhnyxrBYjT4+pN/pDUxYzLmSfcV0OrvzAYXCZJoJpLBL+GJU31i5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637142; c=relaxed/simple;
	bh=WxTNAAxQLSa41CJ6bcrlb/Iub0Hf/kYnE92w53kFwNo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rnahOKjFkvgbTYgW6HGrnlmmZhGfu6goA05SwCHlKiD0SiaV/4b+1m5r2zVMpN5zGUIdCC7FUP4kqMqdLVHPx5z7s7kf1/9YP3M5SVZPZnV4jSk4Va6JrRHnVT9BM2+gOK9UL5lLwZDjGWNjSxaYGqiA0cikNzqHXcwXSJP+IeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5sVfw0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB59DC4AF0E;
	Wed, 14 Aug 2024 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723637141;
	bh=WxTNAAxQLSa41CJ6bcrlb/Iub0Hf/kYnE92w53kFwNo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M5sVfw0Vc5DXAqs/ewimfv5/UfZfvW20oBVakcKApO64SqFOFinM5c+bgwzgPsquU
	 QSd8QEl6G19VYM4n0oIcNHaNqmTCqE0kY8A+q8RWxeUqHTHyy9S3ORFwTIBW/V3mUt
	 sf86JqkWk0dZp7K6LPsX0o4rG2NIfLK0m4sf0P5X9FHsiz0iyf9SrAxNjfIQsrWKHV
	 Eust0camuszntR7FsQIU+Gz2xYOqR5OxLvgTbRC2kMtn3dGcGUS9MrvPr6BP2urQfz
	 a/F+chJX7uvIwzYMmhmpU5tzA6Ptv/muVAXe7kOYhezBbhXe2H5/ojQEJFhlmfvE5A
	 +9eZKTwJEtF0w==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1723120028.git.mazziesaccount@gmail.com>
References: <cover.1723120028.git.mazziesaccount@gmail.com>
Subject: Re: (subset) [PATCH v2 0/3] regmap IRQ support for devices with
 multiple IRQs
Message-Id: <172363714049.179665.4439425185273780377.b4-ty@kernel.org>
Date: Wed, 14 Aug 2024 13:05:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 08 Aug 2024 15:32:51 +0300, Matti Vaittinen wrote:
> Devices can provide multiple interrupt lines. One reason for this is that
> a device has multiple subfunctions, each providing its own interrupt line.
> Another reason is that a device can be designed to be used (also) on a
> system where some of the interrupts can be routed to another processor.
> 
> A line often further acts as a demultiplex for specific interrupts
> and has it's respective set of interrupt (status, mask, ack, ...)
> registers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[3/3] regmap: Allow setting IRQ domain name suffix
      commit: dde286ee57704226b500cb9eb59547fec07aad3d

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



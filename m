Return-Path: <linux-kernel+bounces-244748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD65392A8E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1121C21517
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF721494A9;
	Mon,  8 Jul 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd5HyoRZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7C79FD;
	Mon,  8 Jul 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462803; cv=none; b=iBMw8woUzblh3nzM+9nBSAldZprlI5O1arCMnODR+LUbJhP6gWGtBJJru8EoyaWFNJoRlq1id3Fp2qhD2hlEvFGgMbpvA7VNiBlH41POjXY3q81UoJYqQort4Aw37Ixm1qtvw9PGUUj6fy40NvQ/hlWq6W9ShIbREe9UVefbWxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462803; c=relaxed/simple;
	bh=QOFBs3lyd5kSuHcIUTuqmRKn5lA/nl/6CEtMFJTqhtc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q3sGLy0e0QQw9rwK2qUVJuHgA9FQZ8LU8hzAIKmbtlvg4kyR+/+Y5S4JtJnsyyL3ffSjyNW3cHG2xf1TJ3CLCelb2AjEPCdoClIM1EAmTKDDFzwFhUdNeQjgYHgJqKGi5dUd10C8a+YG/YbihXPl/2WLbFNJyRYn3+/oKoIvFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd5HyoRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7267FC116B1;
	Mon,  8 Jul 2024 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720462802;
	bh=QOFBs3lyd5kSuHcIUTuqmRKn5lA/nl/6CEtMFJTqhtc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nd5HyoRZ+1/kD1ldDYLBg+Olhz35hv8qT9ebD+RTFRANdyUkbH9VMmaUzOHWaJWs6
	 n4WD7AksMoznOpTSs5aov6yh2bPVYMFkfabXXNsZ8drFPI1v7n6SO59UpuEM1BN4EL
	 DeSTOcORPfPfSI+BWEcJTClSxyAoyMHQiUFlMqXZdZ/wQ9ouVBKYKQm33zC3hZ48D6
	 gV49G4gP0SBQ2EiVM1E7V+mrJ7avvJ82oDRJT1SRxRHIqcumXg1JGNRE1ByUvkIFGe
	 e7zANNhZ89mL3Jd790X3aF6GC9Z4UCRwZdz+nvoZxWjZlhbZd+JF8PI66ftHN9Oigb
	 Z15bp8bt8DwWw==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
In-Reply-To: <20240708144855.385332-1-rf@opensource.cirrus.com>
References: <20240708144855.385332-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: Use strnlen() on name fields in V1
 wmfw files
Message-Id: <172046280115.106387.10683882240697864309.b4-ty@kernel.org>
Date: Mon, 08 Jul 2024 19:20:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 08 Jul 2024 15:48:55 +0100, Richard Fitzgerald wrote:
> Use strnlen() instead of strlen() on the algorithm and coefficient name
> string arrays in V1 wmfw files.
> 
> In V1 wmfw files the name is a NUL-terminated string in a fixed-size
> array. cs_dsp should protect against overrunning the array if the NUL
> terminator is missing.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Use strnlen() on name fields in V1 wmfw files
      commit: 680e126ec0400f6daecf0510c5bb97a55779ff03

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



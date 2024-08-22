Return-Path: <linux-kernel+bounces-298037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C795C0FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B041C21595
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1173D1D1F5B;
	Thu, 22 Aug 2024 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZRajJM3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5F17555;
	Thu, 22 Aug 2024 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366666; cv=none; b=PZLNBPNTel55dTjtPZ1ok9IoQ7BV+ZGWZ5sCiS75/XAAXu+AcgNyuurqbi0KdxZk2yafPzZmsBmSQoUoAip/n6Q4BkVzWqgpY2NCFIOnu+3foySySpzwu/I68dZyoHRy2FB54sIEENXOA4NDblffwtsONeZrjhH9pehqdrcCLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366666; c=relaxed/simple;
	bh=qa68NCmkGViVQZim0NLO8ZUey6vjmJ8rAOT2oA0jDYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sSZ8pIsMr4QpOpwa9EbujDtX44rCoHRSakTt/dg0CnpTX7Uof5/0ElyHl5EOllH7HeFWfNk8NEBtZ7c8D9EBv+KCg4MMImhL9OMwHIOL35lHuTw2GkAXqIrPdBp5AM5a5J+fWYKiEoabrpeRHrQWBdy3lL8xF7kTXyV4pR3bEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZRajJM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F36C4AF0E;
	Thu, 22 Aug 2024 22:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724366665;
	bh=qa68NCmkGViVQZim0NLO8ZUey6vjmJ8rAOT2oA0jDYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eZRajJM3B3VkfPK13ilyc7XvcvbuN6EgrGSY5cOyanz/KV8NN5phpR3SO2oAp47f7
	 bWJ00HqZnWOaXzYmw/bpm61b8D+3rwR68WHrw//sROjs5hUfs43IS3sHCc8cKx2lg0
	 HUwvD0r6SS1nVpOWypwu22SYxhdfAR06MOfVlH+cMZ84mvakqNwv3Cpjrfimb23+YK
	 PGP61N1+SjBOueofIy/uGnTvtlfcS9snh53TUzdEp76zZo8A64o830uvXCabWDBxsN
	 QL4mhJ1bRdERAuSaaPlGGKjet+9ff/NuW/29A3wTmf8siACELzEdCF5omD9GfRWQtQ
	 EZOgMpkVxNjGQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240822133544.304421-1-rf@opensource.cirrus.com>
References: <20240822133544.304421-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: cs-amp-lib: Ignore empty UEFI calibration
 entries
Message-Id: <172436666378.825985.17736194460900053230.b4-ty@kernel.org>
Date: Thu, 22 Aug 2024 23:44:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 22 Aug 2024 14:35:44 +0100, Richard Fitzgerald wrote:
> If the timestamp of a calibration entry is 0 it is an unused entry and
> must be ignored.
> 
> Some end-products reserve EFI space for calibration entries by shipping
> with a zero-filled EFI file. When searching the file for calibration
> data the driver must skip the empty entries. The timestamp of a valid
> entry is always non-zero.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs-amp-lib: Ignore empty UEFI calibration entries
      commit: bb4485562f5907708f1c218b5d70dce04165d1e1

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



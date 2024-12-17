Return-Path: <linux-kernel+bounces-449522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 526549F503D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FEBB7A3D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B331F8EF4;
	Tue, 17 Dec 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Csa9hTKl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0F1F8AF2;
	Tue, 17 Dec 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450526; cv=none; b=b6UDF213ueaYeqgsC1i0lhc6bL1upRjh5ppRK5hKRgGV3pRRCghwrLXB9DpeNVZTm+tEtfayQtX/4LMaXobDujalE2+7Uf+97lRiyNw+EgvLjS1PtHfoCMoVa32JejDh5KLlehOJmWfB9gIRV8R3DC7i7WIvnC5NPVcfONRbqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450526; c=relaxed/simple;
	bh=7xJmLw+Vj4ly3aARU3VJt1odm9sSfWrmUuxq/oCcacM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=geLTWX23PPwg/PndyU/hWHNedZiIFBROiuuZVx8JnEfAjolXkNAzJdOMRrWGP8A5dBM+p4ModxIV4eXhcaroyt3NQzNLB6bAu91pAPFE3TtKYmtg407Zn64iWS1Tzn2OY780TsNsTWJI4HDEfBet9OdzznBEHNzH5r0hRS1mjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Csa9hTKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C2AC4CED6;
	Tue, 17 Dec 2024 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734450526;
	bh=7xJmLw+Vj4ly3aARU3VJt1odm9sSfWrmUuxq/oCcacM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Csa9hTKlKl6by9/Bw/uFDFxZREtW3Y+33wC6UExdUqIBK3V6dGT7pYHTwvTxQA0MI
	 QcmVf/z7MuP8rz6aKq9DzOpBuctQJIih8Ynd6dAbs6VmMt8T+ux/tmyXE1QXig6SeX
	 ISjlXe5lsur4Rm5rbw8iehbh08RKSaXCLYEg5Zt/ko9z8djVOrws5+64sdoAabwu7w
	 XDDJtWg/xPAIZOLZtTprMNO3mAFUdTfbsCK3Yy4MDkMC3DZu2QdlD/kRY+UjvO0Bzh
	 4W2UzZIZ3sKoQ9QzMRMfCXLwmv5SGnN9qv3olko6vJC2yLCCVLux/X9BD2gU5mKOY5
	 XTzUyRnVISV4A==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20241217105624.139479-1-rf@opensource.cirrus.com>
References: <20241217105624.139479-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: Fix endianness conversion in
 cs_dsp_mock_wmfw.c
Message-Id: <173445052480.96598.8225820624988774038.b4-ty@kernel.org>
Date: Tue, 17 Dec 2024 15:48:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 17 Dec 2024 10:56:24 +0000, Richard Fitzgerald wrote:
> In cs_dsp_mock_wmfw_add_coeff_desc() the value stored in longstring->len
> needs a cpu_to_le16() conversion.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Fix endianness conversion in cs_dsp_mock_wmfw.c
      commit: 644115e86023fccdaecb1318133ed14418b76f49

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



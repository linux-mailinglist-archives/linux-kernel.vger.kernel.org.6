Return-Path: <linux-kernel+bounces-417177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2E9D4FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F3DB230C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320F2AD00;
	Thu, 21 Nov 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4o7vp2D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2055C29;
	Thu, 21 Nov 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203608; cv=none; b=kwpuGqreGIHBtyNdwaXjiT6i4hJf50InGqLxFwy35FhUqk/MHixYcfqkViDexu5QspiooyD8KwtPFoklqMWnuOZWlFR9REWrVgeGzXrpjss1AkOseuh/aIzSkiwjHW8hm9Ldb2HVm6UZMWlTmdYbqYJswEP+jRH+btmbwFmUdwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203608; c=relaxed/simple;
	bh=h3VYfm3GVeYrwnQgHfIrSN3t/2El/UATUrMr5+FZtU8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ca6wcBDHEdScQPVSbVPkA4t0FbWHC5taMXDcQ3h3SUUJjKKVaJogvpfr+2HsCXU3+tCUolWoMaxfvmLNO4qdGU+QOaaKeSwO8UZAmWL9etPPzLPsw2bxMOQcaLGan7MbY4xWZI5I3vV4N+6JEbr4eCXpZpXuUOo7aPoA4ktcnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4o7vp2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D10C4CECC;
	Thu, 21 Nov 2024 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732203607;
	bh=h3VYfm3GVeYrwnQgHfIrSN3t/2El/UATUrMr5+FZtU8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=j4o7vp2D/1M7m7HuXwmpOSbtA+NXdI5Ifci7zLRCUP+OorAhtL0S+sp0sQDscaoaH
	 XXMtQztv/H+eAHE6fmZunkBxA4is68O0AAyvw78FNXBUX43tTsff5hgyJ37jhHadXG
	 teMCb5yKDjqmHIaslPDAjspfmc3pbxHXMFVV19tWL+dtF1JM7NmbHa5PrprEbG7nEP
	 ce9rZPRerlZ/4RjsamoJk5YMprdIKC3l/e6ix+np/Gn/tPe2/gsOeHSOVAH+ThwubE
	 P1qIMq1g0XyRT+cpXu+HvvAgE61NP0MhvmRKsJDGX1GNvy2YIph58eubK9xhD18e8s
	 Hx4fuQT5PzTMQ==
From: Mark Brown <broonie@kernel.org>
To: povik+lin@cutebit.org, liujing <liujing@cmss.chinamobile.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 asahi@lists.linux.dev, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241113015758.5441-1-liujing@cmss.chinamobile.com>
References: <20241113015758.5441-1-liujing@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: apple: Fix the wrong format specifier
Message-Id: <173220360587.62732.8833494204401808488.b4-ty@kernel.org>
Date: Thu, 21 Nov 2024 15:40:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 13 Nov 2024 09:57:58 +0800, liujing wrote:
> In the mca_fe_hw_params(), the variable tdm_slot_width is of
> type unsigned int, so the output should be %u
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: apple: Fix the wrong format specifier
      commit: f32c3f01c21cdd6a354988006aaca5e3dfe478f9

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



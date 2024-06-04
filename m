Return-Path: <linux-kernel+bounces-201296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A29F8FBCA6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE4B1F226EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D6514B075;
	Tue,  4 Jun 2024 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd7GoKC9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1E14AD36
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529731; cv=none; b=r/DivTZrQJGmRNcnoB9fCa+EtlmlxAc0ebBdFC6vEx0MoX0oE6oVDLyZ3jMR9l1PqF2LBX2cZv7nBao4sUmsVHvcD8FTiDTMnGZ0O0Gr7918yMfruAzvaA0njotModqvXefT57mBOUuk7hapt4dTKzbra4LQeGrh/lYFBeRrNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529731; c=relaxed/simple;
	bh=sCJUcLic2Kx1mgskgnUTLXw7tLAwNeCtpKMRzKgUaEQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jhvHhqAo87t2vkl3bXltsYN93wMeZTEoIw71SWxIaesSAlKDjBnifSSOZJgG7nWo4rizuQ18IBWCEuszGlj5LCv0bBAqjoq87yWTLaNTnvcRJjchNjTZeYbwlReeU/3JzrZ8eYWzIK6NoKD3rvH6T6+OtlVBxnRfQ4zDahPXdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd7GoKC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898D7C2BBFC;
	Tue,  4 Jun 2024 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717529730;
	bh=sCJUcLic2Kx1mgskgnUTLXw7tLAwNeCtpKMRzKgUaEQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gd7GoKC9aoExtAiB0XwC+95a/PBMDxshRDfknVsdF+h6mWfI4Mm2dOwmooHPPf2JV
	 UcxPJxAVX2Bgxr+Cz2diAtfFeXvG9FgFsdM+3d/54ZyuM9WAz+Abvc1SEUUc78KnaC
	 IuESIBxilV78EayUMGXvHaJb5uUH1FOG/SPifP6XcXwGSqo65wcYeFub3JkPQjap8s
	 TE9CCPO66TJQCbfjuD/gp/Wg3EGCHqNgTVJxpN32nKkYMEdCkOwcXEKRoY/9HYhUzY
	 01D5+PJa04qa1q7UGAIFaocmh2aAJd0GOQISlKojmsMM2herQCHrTZq2fpYfW5pApT
	 FtplFCQBjbpKQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Thomas Richard <thomas.richard@bootlin.com>
Cc: m.nirmaladevi@ltts.com, bhargav.r@ltts.com, lee@kernel.org, 
 linux-kernel@vger.kernel.org, gregory.clement@bootlin.com, 
 thomas.petazzoni@bootlin.com, u-kumar1@ti.com
In-Reply-To: <20240603170100.2394402-1-thomas.richard@bootlin.com>
References: <20240603170100.2394402-1-thomas.richard@bootlin.com>
Subject: Re: [PATCH] regulator: tps6594-regulator: Fix the number of irqs
 for TPS65224 and TPS6594
Message-Id: <171752972825.277656.2076276752460770735.b4-ty@kernel.org>
Date: Tue, 04 Jun 2024 20:35:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 03 Jun 2024 19:01:00 +0200, Thomas Richard wrote:
> The number of irqs is computed to allocate the right amount of memory for
> the irq data. An array of struct tps6594_regulator_irq_data is allocated
> one time for all the irqs. Each irq uses one cell of the array.
> 
> If the computed number of irqs is not correct, not allocated memory could
> be used.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps6594-regulator: Fix the number of irqs for TPS65224 and TPS6594
      commit: 8141b6da1763b9db009e5dcf873869bb31bcef45

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



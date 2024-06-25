Return-Path: <linux-kernel+bounces-228740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77D3916647
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B1E1C223CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7893D149DF4;
	Tue, 25 Jun 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz/bqknJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5714B96D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315249; cv=none; b=aIOWPNJVS77PEA3loudFlLQxW2n1F1BcnKAlFx9qij8s8yYc8cGOeNYF3/imK6Q8oAZOppAYPYsvctFxb0dV8CkohdeQATfWvvKMllfUw3PcT10EnG89TV/zIBSGbQP5WD+5Zb3vFcZI/mdlRpf0KACbeTZkvdLOaVD0YRHnskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315249; c=relaxed/simple;
	bh=476fFSSkHcV1Nidn93ERYD/fKP8Ds8ppHiNFPO7X/ZM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TOGLWHAtVijnAlnjfI/Heq4gkDTYOR/RM4D1oFS4fWKdZQZCHRnpBTuNUWuRKgnKv0ed1ImyiVgO+Dgw0FrrQllCrkpfzAhtusf7DQbh8rNE2CHyNgudBsp/WQggktsaq70CXC7UhFuglt1qzK103dt5Rkbwm9dSPezZpd10UlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz/bqknJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE50C32789;
	Tue, 25 Jun 2024 11:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719315249;
	bh=476fFSSkHcV1Nidn93ERYD/fKP8Ds8ppHiNFPO7X/ZM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Pz/bqknJ/2D1Xcf+3QQLErowkalR3433wZLUDLkWAMnGHpRL9kJ49bU+ipQpuUWdA
	 ApJ/Au1RzSzTcWzg+MBE7n3tgY3kTz+bm8fLRtY1PyrYVdBgEi8UebjNADJ/qM2pxd
	 uCnTw9rmY/1aw6dmfYwol6BxIWmKRnzZgccOGBB1FZAfE4jZXsj3RDC5TXYe2TFlJN
	 aaVLucVhJ/25XKCwVViHBTi3HjXPbFwd+vtD8OVBd9io7CFj2yrCyENgMGuaa8sakT
	 RMqxFLRFQm6E+im42NRdVnuTSqlT82Q0Kb4Sp38nXbmtWwPFaapI/o/H0juG5X3UIM
	 qrwi9sEqcyqoA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
 Robert Marko <robimarko@gmail.com>
In-Reply-To: <20240623140947.1252376-1-robimarko@gmail.com>
References: <20240623140947.1252376-1-robimarko@gmail.com>
Subject: Re: [PATCH] regulator: userspace-consumer: quiet device deferral
Message-Id: <171931524836.64387.7654955890138539082.b4-ty@kernel.org>
Date: Tue, 25 Jun 2024 12:34:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Sun, 23 Jun 2024 16:09:35 +0200, Robert Marko wrote:
> Trying to use userspace-consumer when the required supplies have not yet
> been probed will throw an error message on deferral:
> reg-userspace-consumer output-led-power: Failed to get supplies: -517
> 
> So, lets simply use dev_err_probe() instead of dev_err() to not print
> errors in case when driver probe is being deferred.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: userspace-consumer: quiet device deferral
      commit: 61a98ffc2081ac1e9070150932d9eb91d3935cf8

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



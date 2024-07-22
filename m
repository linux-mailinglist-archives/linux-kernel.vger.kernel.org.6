Return-Path: <linux-kernel+bounces-259317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46916939407
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF75281F63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE56171075;
	Mon, 22 Jul 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZX7dIjw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228BC16EBFE;
	Mon, 22 Jul 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721675546; cv=none; b=Zhz2NnM1fJJiJv12UJuYySkQA0Y3WRt7hIxpMalWnZrhJC1YIlmnN+Q/Ot0r4laZAUx7vDM5kNA4SN6E1GaIyB3uhDbZ8/m2gbli2bNO9L1sOL5CcKtIR7L9j2XqZNNsJXqoWFcS+A4ZkBhgxNfqs6xmTdTd4cANONvav1MvqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721675546; c=relaxed/simple;
	bh=08Ix2ICoI12/cLhY4GIhbhpOUaxPusqc257F2p4YRgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R7X6UoR2XSugwHe+uhVl5sT9Z1EY/Z8dd+l/boFjmjGesXKxfvYlELJfJK9La4rK55/SoiiGT6Mbdpnwyvz3t5tnsheCrOLk5HhyRE8T/EajGb4rGyLDayrV2f3tKT59NdRb69vlc0CWYA2/9sPvdoadmc94IY8L5DvARJ0jV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZX7dIjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A204DC4AF0B;
	Mon, 22 Jul 2024 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721675546;
	bh=08Ix2ICoI12/cLhY4GIhbhpOUaxPusqc257F2p4YRgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IZX7dIjwMPLhTMKg000zPem6udIF24kPaDuiDggQk3CWEcji8KaVHC3rsAK+5x+aL
	 12eckH04vW7DW02IiuZnuxQjCsAWS0EsuBOX3ExIA/+RDep67EIuAr0CTuAokRKxY4
	 t8u7uYyrTzMdKMyzaXIQUJae1gw9K02phDM1i1pal3dRvdAoTo5GC1dYh/x6+cWrMR
	 XrCi0EjU0zISuMaN5O5izRLhr6PccUY+SF4oTRrSKIDJBi98/Z/t9eE00FPNOnc4W0
	 U3Y0afjAATl06kBHC3A/9yNVugX6TYYpqUvcexza1yz6kB5c+wmI9LmNJb5BGXtI0u
	 TzhjArwt7inpg==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <18a29b68-cc85-4139-b7c7-2514e8409a42@stanley.mountain>
References: <18a29b68-cc85-4139-b7c7-2514e8409a42@stanley.mountain>
Subject: Re: [PATCH] ASoc: TAS2781: Fix tasdev_load_calibrated_data()
Message-Id: <172167554332.83479.1180608727450798301.b4-ty@kernel.org>
Date: Mon, 22 Jul 2024 20:12:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 19 Jul 2024 18:53:48 -0500, Dan Carpenter wrote:
> This function has a reversed if statement so it's either a no-op or it
> leads to a NULL dereference.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: TAS2781: Fix tasdev_load_calibrated_data()
      commit: 92c78222168e9035a9bfb8841c2e56ce23e51f73

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



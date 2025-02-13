Return-Path: <linux-kernel+bounces-513013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F84A3408A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A6A16A87B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A6F23A98C;
	Thu, 13 Feb 2025 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYT9iz0N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96C720B80D;
	Thu, 13 Feb 2025 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454110; cv=none; b=b1KbKW6h4jj1JBX3SC6Zgq32K0XRvi3jqd75nu9zqavAv8Ug+N2dmKeY8bKbU9pG88WypmUTmlKEZWi7Fnz0Ie8x94tAPJWW18bUlm/QnInQl6TqoQnYLjt2gX+5QZO1u4ZwFboDwMmCOw0ACXjpXmzhHYDYo/WaL7k4L8/VJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454110; c=relaxed/simple;
	bh=imDG3gI4Tn0Lpp/po3awdM1bNVdqzmKlF13bpxX6/Uw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UoHZdYSKQWDEOLjiEaAXN4+ujvLjBozjRwwgySGrCWfNRus/3hW6SjGu8g256ow335pHyoVgE99imeK2xGrzTlfkNrf8ENWxRmcnf3XRgSIjwF63F69khCKD1Znl/WmFKL80119PMXNPHLpaiZvRSYLHC9vdnma8XYlwuWzkrhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYT9iz0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE968C4CED1;
	Thu, 13 Feb 2025 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739454109;
	bh=imDG3gI4Tn0Lpp/po3awdM1bNVdqzmKlF13bpxX6/Uw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fYT9iz0Np9RBwoxj0zZnYhM5MxAGZeLT1r9aA3ncUp1qQpOkggCXf8oyWIUfGMhGf
	 07w9OtySQNt0UBR7Mxlg86BBHgWdR1Vs/yN2yIStcgWa8TOEKSCZEEZ3bhLLTNWcqN
	 eUUG3XLRVSOmFRLqiiJRCXy1r/mRBKANWvbjJ8172MKz2p6fI/PsCcqCPxEiWspGGV
	 1KlK8l5EAeQDMMJ9WM5qlRNcHXPIcVsXP11/u8bHU2x4d/6J+4fTNmXteukAkLvgF/
	 q1Uxft+eyN4ueSDaIIma/eR+/Fff7QPa6Rc6EAB3W2rJPKbSf3phFumJxBLvJ5WOT5
	 NfrUCeEMpPZbQ==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: imx@lists.linux.dev, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250211225018.2642-1-laurentiumihalcea111@gmail.com>
References: <20250211225018.2642-1-laurentiumihalcea111@gmail.com>
Subject: Re: [PATCH] ASoC: SOF: imx-common: set sdev->pdata->hw_pdata after
 common is alloc'd
Message-Id: <173945410762.135699.10442254060928769655.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 13:41:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 11 Feb 2025 17:50:18 -0500, Laurentiu Mihalcea wrote:
> 'imx_unregister_action' uses 'sdev->pdata->hw_pdata' to fetch the pointer
> to the common data structure. As such, if 'sdev->pdata->hw_pdata' is not
> set before adding 'imx_unregister_action' to the devres list, we risk
> derefrencing a NULL pointer if any of the calls between
> 'devm_add_action_or_reset' and 'sdev->pdata->hw_pdata = common' fails.
> 
> Set 'sdev->pdata->hw_pdata' to point to 'common' as soon as 'common' is
> allocated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx-common: set sdev->pdata->hw_pdata after common is alloc'd
      commit: f22ba3561daa792dd138ed543e0bf48efe0b999c

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



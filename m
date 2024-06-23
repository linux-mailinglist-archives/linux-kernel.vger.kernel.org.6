Return-Path: <linux-kernel+bounces-226064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6709139B2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 12:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEE81C20922
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC74376E5;
	Sun, 23 Jun 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2S7qlu3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE35C12F382;
	Sun, 23 Jun 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719139842; cv=none; b=Io8aDaCpy6i5E9hPyk4C+5CG4LYLB5v26nLEw1WIoIQlSB8b7jGp3661pSBHb9/ljluU1QpIpOcEjHJVHQkmL/88Mbl+P4EoapYrJJBHluPDQ7bib5Vzy0sTXC5+pB1VB6v+L1VKrq7WTd0kme9gPX587rBbmSabdWvZOEZ/ir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719139842; c=relaxed/simple;
	bh=grPOM/66C5Tp9I6T/5h0ot+1gowEnfIrnQhgoqZJR5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FReRRzQBHjH2nO79yhVIWUDxNSmel0g7mwN8p/JSQNWvU+5H6ho5Mhmt1NRD09XHeqG5CkUx+aU5rfl3rJmq9mdQRCyAiRqVW4/N/M155CFwwHaHipLZvxnkIugNPmaoGDksSD7YU5Dv4a+sojb5OHe066MhgLoydyzQGo5ek/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2S7qlu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BE6C32782;
	Sun, 23 Jun 2024 10:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719139841;
	bh=grPOM/66C5Tp9I6T/5h0ot+1gowEnfIrnQhgoqZJR5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p2S7qlu3JCIJ8mqEmvlorFhX/y2waM/XGh1LFTg9gJmmzesDOjxMYmW4zt6t6264H
	 evkOBYkljxOCiRs6SFJZJ+1tA0q+ZYSRxSgWIE0bX2u7j3DjPabfFGs9Gps+VYBPby
	 rBGTS/kgWSCEce3ViLJSWc7RYLyDD2LOYCjvXhEfqoH+ZhRN3VROy1sD/FKrn94ghW
	 h8G3PEJzxpnpLzzVuGBN0bu/f184pJ1ucVR/ipymZy2JntW5oO2jxFx3f9Nf0s/DAk
	 1V7K6GWNPP0Re/FY/DyvFXI0T2iD/Z2T1TXO/dnsZHxsVSPHemAnMfqL1rqrRsBopO
	 gT8DkCo5w8puQ==
From: Mark Brown <broonie@kernel.org>
To: Markus.Elfring@web.de, perex@perex.cz, tiwai@suse.com, 
 Hao Ge <hao.ge@linux.dev>
Cc: shenghao-ding@ti.com, colin.i.king@gmail.com, gehao618@163.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hao Ge <gehao@kylinos.cn>
In-Reply-To: <20240617020954.17252-1-hao.ge@linux.dev>
References: <82283abf-10b1-4095-a93f-112ba8aca483@web.de>
 <20240617020954.17252-1-hao.ge@linux.dev>
Subject: Re: [PATCH v2] ASoc: PCM6240: Return directly after a failed
 devm_kzalloc() in pcmdevice_i2c_probe()
Message-Id: <171913983921.13532.13655190308269903686.b4-ty@kernel.org>
Date: Sun, 23 Jun 2024 11:50:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 17 Jun 2024 10:09:54 +0800, Hao Ge wrote:
> The value “-ENOMEM” was assigned to the local variable “ret”
> in one if branch after a devm_kzalloc() call failed at the beginning.
> This error code will trigger then a pcmdevice_remove() call with a passed
> null pointer so that an undesirable dereference will be performed.
> Thus return the appropriate error code directly.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: PCM6240: Return directly after a failed devm_kzalloc() in pcmdevice_i2c_probe()
      commit: 3722873d49a1788d5420894d4f6f63e35f5c1f13

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



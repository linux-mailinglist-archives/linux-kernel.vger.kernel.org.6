Return-Path: <linux-kernel+bounces-266192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD3B93FC32
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0052836EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F7C183098;
	Mon, 29 Jul 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqTKBPlh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990A17CA1A;
	Mon, 29 Jul 2024 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273437; cv=none; b=rqUVspJBYFRf91/oqmD78cF7EtmzeNBAQD0erbprl6Tq2irWsA0YRYKwZRBEXEfJ5oIKIBvMrVvKYHHYj+6CRNXonYSYm81CFf1tFD5Jag0p2fkq2/1UATSspAUAXhQ6CoVQTm6N2FhrCz13FEP0or29QJoswKxnLZYpma9Lt2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273437; c=relaxed/simple;
	bh=7xDGXC/XNZ2t3fcsCAVbIoBM3ZgG2zfflMxd9N1oaFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mQd09ajkBnLB8hv8pO7npFmkaM3Tu1zxJ6tj8bxhetRwSeM3mQGgNE/IkZdbzV9fdvtt9F2N8eI34mQp6t/UFDnI/1OvdQNZcpZGYoOr7TWFckvVKuKMQnbRfJf8fc8bN3pZ8yeqysdRSZfPJQvjsdJPCLtu3SYnEc8POz5roo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqTKBPlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830D7C4AF0A;
	Mon, 29 Jul 2024 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722273437;
	bh=7xDGXC/XNZ2t3fcsCAVbIoBM3ZgG2zfflMxd9N1oaFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hqTKBPlh0aJB4aqVi2pavqZ3Ec8lhU1VgkKJdNTbwJpornn3H1e5Pgj/8h0VdTUKO
	 WFJeOoTeco0eU7GC0MVF9CaXmngUIgR1HlWNQMNeCd5pYHmJtZNgzZsX7lt0jNcudw
	 vdXuS6l6SqxNCU9BFie9h92H2Y4B8E/3ot6g9EKXZ0WdfGVWiaLjYA/3rKbOi+Sj3c
	 cSKnjtVquntHDNEsvrHDcNXQu2FIXw55aeFDRfhJI/xAk9GrHdAonNZPAdRVetKJyL
	 0qyI/+nha8eVgS9GLghpwc/E/X2bBtJRCFHqGM/2qyMtA0qoaynv8YniBMSPX8CZkz
	 D9cxFwSGyIA1A==
From: Mark Brown <broonie@kernel.org>
To: oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, derek.fang@realtek.com, Ma Ke <make24@iscas.ac.cn>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240717115436.3449492-1-make24@iscas.ac.cn>
References: <20240717115436.3449492-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: rt5682s: Return devm_of_clk_add_hw_provider to
 transfer the error
Message-Id: <172227343526.109775.10900399135589562597.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 18:17:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 17 Jul 2024 19:54:36 +0800, Ma Ke wrote:
> Return devm_of_clk_add_hw_provider() in order to transfer the error, if it
> fails due to resource allocation failure or device tree clock provider
> registration failure.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682s: Return devm_of_clk_add_hw_provider to transfer the error
      commit: 3ff810b9bebe5578a245cfa97c252ab602e703f1

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



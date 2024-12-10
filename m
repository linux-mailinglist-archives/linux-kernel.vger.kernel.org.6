Return-Path: <linux-kernel+bounces-439795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6069EB3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C35F284A75
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F9F1BEF91;
	Tue, 10 Dec 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM79R337"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2C1BE852;
	Tue, 10 Dec 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842283; cv=none; b=BE8LPq062PxX6sbFnwPhSnXmKqaqT4LStvnOz/iSqB5uhebb5Dy4AN54FB3lD111qMM/1hxKboluFHiz5+v6htre/eNjTnEcXMJD5ULd8Bx0ecV3XC3FN3F1DMV2ebgR6E5nSSA8C7A5Dcow0NObWGsSHRu3kizhotpMvLXUwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842283; c=relaxed/simple;
	bh=gYQlxCqKHPTw3FrYOrWx20hIFWFQk8Jr1cEKF3mclck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lOy+spOLWVglOWDwi67cKFxixSDLHJGFacUSQwTM9LKP9UyyKAxJF3y/LpYELbemS9lCeQRVrac5tPRmcoe+gxMsAAa2lcYmYWue1Sx8qjGXdAyaTakvmOA3m/pA04plPIuqTQvZ0G27P/IXscMgjVtkrc1MDqQwCXIewOp298w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM79R337; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CD4C4CED6;
	Tue, 10 Dec 2024 14:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842283;
	bh=gYQlxCqKHPTw3FrYOrWx20hIFWFQk8Jr1cEKF3mclck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LM79R337ru4lvTPF1crjCJQ0unHk+p0evDxY8duGQUrvrbT6X+wWqhF60lqyr+lPe
	 +NvnrbZagjOlARYRX6p3OWKyCxOC90FkXw+c1HOwrNR0W1PRt7l8t182o4UscJh/QP
	 0sh2Zu3oFpK/uagLS8ItqMe5kKY8hlSSqFwV4EiCq5SOkcQVm2hbq8VmQ4lFryxqgB
	 7/RTuW3hAzX0vZxYQY1ckO72gV0hr0/MiDR77iArtaJZ3uebz0DIy6FG19c7nEGH7i
	 Dc06DG3X+algGDiNCfCUroGf9xkDdVr2ss89foOJyTK60XQZT6Rwn9+9aTIlFLfXUz
	 QB5KwyktD0fnQ==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Stephen Gordon <gordoste@iinet.net.au>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241207122257.165096-1-gordoste@iinet.net.au>
References: <20241207122257.165096-1-gordoste@iinet.net.au>
Subject: Re: [PATCH v2] ASoC: audio-graph-card: Call of_node_put() on
 correct node
Message-Id: <173384228159.64342.9992436674669504121.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 14:51:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Sat, 07 Dec 2024 23:22:56 +1100, Stephen Gordon wrote:
> V2: Adjust commit message
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: audio-graph-card: Call of_node_put() on correct node
      commit: 687630aa582acf674120c87350beb01d836c837c

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



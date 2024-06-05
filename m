Return-Path: <linux-kernel+bounces-203231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B08FD819
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CD32820D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEDA4965B;
	Wed,  5 Jun 2024 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IotqZlJh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4CF15F418;
	Wed,  5 Jun 2024 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621535; cv=none; b=Zlzmb4WrUlSR0W+9mcqAG9CnlDOGypVR+oGzsvIAyyYgiHvNqwBgny0qgknFCRSisx6bdluswsXmZauxOLGlkiqUCHDCuIYmwJ67Y82pU8dw3JYKriDGx7lYrRVZ6n9X+knndy8HIZF1LvtGaJ2yRbqxrdC/2nszqBi8KsI4hrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621535; c=relaxed/simple;
	bh=HX2FOEXY8UflXmGqEAtTtfooLXB6TYloRO4ddELc9EI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WEZ8+6ELgb5PPlCu2kZ5iEXT45MVcrTgM3lns4Xv71XMtKi7rQ7jIgCWG4znBHs837rs3UKHqYxJlueMEY4xzO7bOevY9KCrFLLhdrGCWPYM/PtVz6WsnRVhyXsBG4zltXdqFsMFCPJtAX61O9VK7DKC1jGaYAM9r6Pl9hg6Bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IotqZlJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBFFC32782;
	Wed,  5 Jun 2024 21:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717621535;
	bh=HX2FOEXY8UflXmGqEAtTtfooLXB6TYloRO4ddELc9EI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IotqZlJhbhOy1/VcjrFfU9iEv72PAg2bPladFlnP4BoBgvaeqES5SgqaWt9HzHWOt
	 YUhdH8CWnoLBKRmYu3e7DuPDqeV2dDE90kKVFFx1mOr+170mvT9FqXR8xEVCApXYZD
	 ZEalX9aDgV+/oqNlQbCO0YxeLbDF/hTQp/elWc5Wiyx35JgTuVjedn6Z2pq+V7h2oq
	 KqiKecpswSFCXCeJ5Kc6Mmrp6vNoBzlR2IE3VPQGAM8EQjML3Fe4OffEaRzemgqD+L
	 ttguZbJ0oGhJWZuwiGEDCdbWjzfMQwVM8FPoEFIYddoMH1WQK6YVyNVuwGJqKyknw7
	 5NMtjUWVCWxrQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240531-da7219-v1-1-ac3343f3ae6a@chromium.org>
References: <20240531-da7219-v1-1-ac3343f3ae6a@chromium.org>
Subject: Re: [PATCH RFT] ASoC: mediatek: mt8183-da7219-max98357: Fix
 kcontrol name collision
Message-Id: <171762153256.557520.12011428649748199502.b4-ty@kernel.org>
Date: Wed, 05 Jun 2024 22:05:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 31 May 2024 08:37:54 +0000, Hsin-Te Yuan wrote:
> Since "Headphone Switch" kcontrol name has already been used by da7219,
> rename the control name from "Headphone" to "Headphones" to prevent the
> colision. Also, this change makes kcontrol name align with the one in
> mt8186-mt6366-da7219-max98357.c.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8183-da7219-max98357: Fix kcontrol name collision
      commit: 97d8613679eb53bd0c07d0fbd3d8471e46ba46c1

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



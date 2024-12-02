Return-Path: <linux-kernel+bounces-428132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D829E0B37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2A0AB3ECB7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED401DE3A5;
	Mon,  2 Dec 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWGhRa/A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E561DE2BC;
	Mon,  2 Dec 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162307; cv=none; b=r7SsBKwvsJ/RmnOkN+RyQ2QeByWDF6azJceyszqhXYKUIm64dQ4eBu7v5xXW9gfZ6oNsTgLNdpDnTlxk8+k2yUsvA8k+HDK09zAY1kYadX7GO4H/DMh6cN2cqMeiKfp0s20MXRR7lUG76wKQAJoILDjqCCdKXhBiSHr5zYQRTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162307; c=relaxed/simple;
	bh=XJ3XxTSNZkfF19O/ZvNhYW0wKLfXMcF4WWxY1EwSDFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dUnoDQYWBwH5RRtJDxmRs4jMS7W8qZdyGBSNrHFaxjzTHwqXqVs21R6mNUR4uq39iSjtv16+4ks8JAlq0d3C7GWekqJrSc0Vf5b77GQSdZGhIb5g1dEaZ9fbZXA+5WS5ipFXojsg2d8p6g5EZVspZZWnVgl0O6Bmdp3bt0LD0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWGhRa/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920B5C4CED6;
	Mon,  2 Dec 2024 17:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733162306;
	bh=XJ3XxTSNZkfF19O/ZvNhYW0wKLfXMcF4WWxY1EwSDFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iWGhRa/AoUmERI8dddfKx7Q231RsV7SLE7yM8gmY7/X7Ah3fWhw6jxjPp3wLoE9wz
	 ssLPxgzrMnP3nCngQhPvtAp0ReLEaPQmkOodq9TCGco9jX7kRdDB+bhN4BfUBW4c+C
	 5kuf3gq1C7jpDU1rmV1qfx9M/8YJaJ95wEtIIgLbFA3wDQBjx9ec6MXMwHJubLABu1
	 DnnpjifO4JM6A0ClVe6bdgPr7+FzRvEVziTeaK1oMjUba/sMuK5VvwLAWOuaWc8qmX
	 C+/Dn1Q+0wkkcqN710zRK1Aa/FII7IP3Dt2ZlONoiKv5xOPt7ZUarEO3MdE5rgoASZ
	 zT8T6X6WVxutA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20241025080026.2393-1-tangbin@cmss.chinamobile.com>
References: <20241025080026.2393-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8192-afe-pcm: Simplify probe() with
 local dev variable
Message-Id: <173316230432.189181.14465686239974996213.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 17:58:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 25 Oct 2024 16:00:26 +0800, Tang Bin wrote:
> Simplify the function mt8192_afe_pcm_dev_probe() by
> using local 'dev' instead of '&pdev->dev'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8192-afe-pcm: Simplify probe() with local dev variable
      commit: 01981565c764c554cc96e2d30a71c42975171416

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



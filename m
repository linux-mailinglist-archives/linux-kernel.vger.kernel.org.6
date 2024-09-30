Return-Path: <linux-kernel+bounces-344863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C48B98AF0C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA9C1F239F3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192B11AC898;
	Mon, 30 Sep 2024 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx9+ijmC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E231A2636;
	Mon, 30 Sep 2024 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731602; cv=none; b=Cspkv2SEg4GnFlwVBqE5SFfwfFwyAH5VqsykReBQ8VSKeCjKTDn0PCc3VPsWgz7mI96OECIBMHsu8X032E24+yUIbLZ5pfC92XEjBzEChFwC/jx4sU+C7XPepsPzRsHxPNgvosGZKww27pir0t8vzy44B+7TvgDNBbU2TBDb2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731602; c=relaxed/simple;
	bh=NkRqiuMzhon0316LV3Kd2sU6eM23gxXjReXGVuES79I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sWAmW2IgXnEOKBlTPJwaK5vd5tbsHPCo1lsc7vM4u9Ij8WN4d1LFUxSJIzDRxUxYBS4W0qNjcHt7MXPHky9o8Kr6r6X6zRIx707YpjbDZoIasqJmSy3EIDLvhwFgJ3J3VRb3yYZwRjF7cnNz2RpBSs70tZbf+2tpe+C7u8uqtn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx9+ijmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B21C4CEC7;
	Mon, 30 Sep 2024 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731602;
	bh=NkRqiuMzhon0316LV3Kd2sU6eM23gxXjReXGVuES79I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qx9+ijmCV0QWEi1Y3/I0BppzWyFZVGTnGK/kuxt4amCNYMWAAhex2Ojp/1Ipd9w6j
	 Zu1EdY6/lt9gWstfSbToWwF/U0xEqJL5FQNpw9tIQ1btd/ffNA1LphbiwBMaykzNQc
	 5W+JJWj9I/6Jt4IkmgZG2zLhZDJJ+Y8t9B/VyxzY8ied3nAfZqBqQO+k6Ej2I6Nl7Q
	 JZS08jHRK9gfNiigzZrtzKjMgApPH3zvwQwmArLAm+qnO6TjSNS2i9UzYTbDwFFXo1
	 n7DoD4qEZXHUktUmxCMz9EewyNE7yBHCrYyI4CeCzjQULmZxZuRg143ACLMmJdP4aM
	 1hs7qx0qdQn+g==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240924-asoc-imx-maple-v1-1-8b993901f71e@kernel.org>
References: <20240924-asoc-imx-maple-v1-1-8b993901f71e@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Use maple tree register cache
Message-Id: <172773160047.2197048.13783696550298838000.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:26:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 24 Sep 2024 15:58:42 +0200, Mark Brown wrote:
> Several of the NXP drivers use regmaps with a rbtree register cache. Since
> the maple tree cache is uisng a generally more modern data structure which
> makes implementation choices more suitable for modern systems let's convert
> these drivers to it. This should have no practical impact.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: Use maple tree register cache
      commit: bbeffdda5f26a56072cb8cf741f4c52bc2174838

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



Return-Path: <linux-kernel+bounces-396817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE99BD29A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DA91F2319E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76A61D9A60;
	Tue,  5 Nov 2024 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLwZYMYU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352991D9A4B;
	Tue,  5 Nov 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824711; cv=none; b=o3m2a/VJpTni59GY4G22xZfmYzi47ck8ujbp99DFyYD8H+tPYPSL2H3Y/6V228Qd5B/mW9TWjqttkI9TmtNx+Lz705MR+vfeHMRM+CXZoU60tNq/CBX2j8dFhvnnK0BCuVodmUeS/d2tSNf4I6M1vAVtk/RCiCAJlrJkUNT4OJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824711; c=relaxed/simple;
	bh=X3QevZg0rzrXDfQFtVrzDiR/bMaGBDN1CpqsOH1Ja48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EUDlFB7UD+RM6uqom20gkW3M9rXAQOsCoREqMHc3lILubQmfRLH7yqj03GyGS1Urf77NaZgHJnhIwhHcGD/nqo1gCyDTfvRuaaatVpHe79yda2JCIGjt+y4EpUZwkS93tg/cye8wh8sR7sK+Xyn2vGf4lYvBFXmdIUvnNHWPRlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLwZYMYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED5DC4CED2;
	Tue,  5 Nov 2024 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824710;
	bh=X3QevZg0rzrXDfQFtVrzDiR/bMaGBDN1CpqsOH1Ja48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aLwZYMYUdbc96SDQl4CZJP7laKG276AROeHoNAb/mbq0JLX8pGH2ErNkqqR3CVg8N
	 wzFnZjVoe4to+XZpY9sJNCkq2NuZWXe7RB+L/RIxQawDz4LpKAaTkQ0Snkp/RocZ92
	 V/JonNjeP1FzhAKY/9P7HCpDQh/8+WkvyZ35K1zzJmsMNtdNDlcPuf0LP39CUwV+Bu
	 vb09gWYSP1T8UGfcjd3qkimmpy3Nfm8anUXei95OTdaq+ceTA+2hAypAq1K2R+2Z90
	 E6USeKTASzsIsUwBQ1cB6RpFrTf+W4JEKSFJS07aA0pLz6ygCAEBzhLvmJHUNIMawB
	 POu5V5s8j3nkg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20241028-esai_fix-v1-0-3c1432a5613c@nxp.com>
References: <20241028-esai_fix-v1-0-3c1432a5613c@nxp.com>
Subject: Re: (subset) [PATCH 0/2] ASoC: fsl-esai: allow fsl,imx8qm-esai
 fallback to fsl,imx6ull-esai
Message-Id: <173082470778.77847.10489834906356614772.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 16:38:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 28 Oct 2024 15:49:30 -0400, Frank Li wrote:
> Update binding doc to allow fsl,imx8qm-esai fallback to fsl,imx6ull-esai.
> Update dts add fsl,imx6ull-esai fallback.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: fsl-esai: allow fsl,imx8qm-esai fallback to fsl,imx6ull-esai
      commit: adf7ea48ce05a6c5c44f0f9d3f81e83e5cb70c3e

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



Return-Path: <linux-kernel+bounces-346446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC1298C4D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9347B24620
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE5E1CC173;
	Tue,  1 Oct 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rflcr7Z/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330831CBE91;
	Tue,  1 Oct 2024 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805189; cv=none; b=iLcMBjmKBlkiddFNhx++lxh8HZZhfqZnqScjavxbON2DVZEthckT4IocEDhTANvUCY78MYE5s2JO4LA2+yP1QL5139dwSss9b5Qazej9Up9rbmjCVw5Fx94pFdkGZfF1Sm91majS6nPFx1821uMOfP7OjIW7lN9uxbKejiufYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805189; c=relaxed/simple;
	bh=V234jebYcblKJHaW08SlVHYoHv/9EbT1j3IuhFaCA6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oGEDoV/wCi2eMgV56H1rxHM5iUDN5/7mUKh4DrypEqbtNYlyFMsLRvtRRa71c/PNhZ3/c5Hcjv3WXmBdru0wJ5oi832pw+tbWZ8lzq+kbAWbsUtriSEASjd06Xq2yMC1pKRbq+h1W4LQ1NdSKt2rNWWPdRMX7Ovcnvq4xhOOkUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rflcr7Z/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE149C4CEC6;
	Tue,  1 Oct 2024 17:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727805188;
	bh=V234jebYcblKJHaW08SlVHYoHv/9EbT1j3IuhFaCA6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rflcr7Z/6fGAXVpxP4bcU1glKPbGggbNHSOZfP0soZhN1YPEIf7AIAvBR7dWeRVSE
	 3+Aiv6g3fJmCL0WVU6D17Zw6pdNhZ5D1KQw/f7aRFGI5DW22HYu64I9oXQVxvI7aRf
	 QarMvEEv0UHGxyVM+eBuMRrTx6TWf3ufHPJUzfwxgdJbnUMiSD508Iv6dYtSlJxzvX
	 5sR1HeW3SC4WFPJ4WkMwA+u6o3aAm+Iz+QKXRE5cI9zhy3ECrL2N/ZxDSo+HbX3Bog
	 1qufKeosWZVE/r/pFj00KrFDn0YeJkxHAv2UQbRS9ROy3Qlmv7X2gt3erZPbptFuG7
	 kiQFV/otleXZw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240918061540.685579-1-Vijendar.Mukunda@amd.com>
References: <20240918061540.685579-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/8] ASoC: amd: acp: refactor acp version
 differentiation logic
Message-Id: <172780518563.2298697.14487896281426250267.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 18:53:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 18 Sep 2024 11:45:32 +0530, Vijendar Mukunda wrote:
> Currently different logics being used in the code for acp version
> differentiation. This patch series refactors the code to use acp pci
> revision id for handling acp version specific code.
> 
> Vijendar Mukunda (8):
>   ASoC: amd: acp: simplify platform conditional checks code
>   ASoC: amd: acp: use acp_rev for platform specific conditional checks
>   ASoC: amd: acp: use acp pci revision id for platform differntiation
>   ASoC: amd: acp: store acp pci rev id in platform driver private
>     structure
>   ASoC: amd: acp: pass acp pci revision id as platform data
>   ASoC: amd: acp: remove unused variable from acp_card_drvdata structure
>   ASoC: amd: acp: replace adata->platform conditional check
>   ASoC: amd: acp: remove unused variable from acp platform driver
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: amd: acp: simplify platform conditional checks code
      commit: 839a8b18dbd2e2345a261169fb68d950a1071862
[2/8] ASoC: amd: acp: use acp_rev for platform specific conditional checks
      commit: fca471b5d094dabd65f6d8777096e9ed1df1bef7
[3/8] ASoC: amd: acp: use acp pci revision id for platform differntiation
      commit: 5dbf8a19fe5d5a4c764ba88d171b06704354296a
[4/8] ASoC: amd: acp: store acp pci rev id in platform driver private structure
      commit: 40412a298c77eaa4a22a1aa7030bcc0b2e02c618
[5/8] ASoC: amd: acp: pass acp pci revision id as platform data
      commit: 0eae2c96b49d85b31ab635b9dc6f09b09d3c54de
[6/8] ASoC: amd: acp: remove unused variable from acp_card_drvdata structure
      commit: 2e609185e174a9ffd462ab125085ddfcbe9e2f4d
[7/8] ASoC: amd: acp: replace adata->platform conditional check
      commit: b33d93990e3774a24575517c6fcc2167036672d1
[8/8] ASoC: amd: acp: remove unused variable from acp platform driver
      commit: 9864c8af89eb14a2e5334f8e24bb82086182e894

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



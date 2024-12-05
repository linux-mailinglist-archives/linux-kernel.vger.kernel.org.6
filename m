Return-Path: <linux-kernel+bounces-433618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81E89E5AAE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D03164034
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019771DC18F;
	Thu,  5 Dec 2024 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df8V0ztk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E231B59A;
	Thu,  5 Dec 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414725; cv=none; b=G1VPNvUOIRI485g2LEPF0MxIj9hDavhjHyG0cN2Iehl+k0pD/2NwhovBEKxRaL7VkA1kdm1nJSg+4rg1k3Ozqzrb0KAAxBZLNugi3oQZyNiQhhRLjVTKUDyesT7w6UblmD3Q6XBImXfDnIHkKrx/yFluHaZuUAy9tpUVT1iXUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414725; c=relaxed/simple;
	bh=EFE2AZL6QW6AXMyxjHx2rd1oTU99m7QnJG1VGZzGKKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XM2QFAnp8QLWYM2KRfDTCYSaYm5TyjKUaZFhjFjf5ZgEd3Fmd2tOKyL9PN7TErJjCBMwoSEoBuu6qjhfNR6oDqKYC2OIG+HFujpx8a6aanuGxtknBZuCzu2JsSWqX7YJHD55WA/1BEx3y1YovP7vkXbdsGr+qMGycrh3XRWMeMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df8V0ztk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CE7C4CEDC;
	Thu,  5 Dec 2024 16:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733414724;
	bh=EFE2AZL6QW6AXMyxjHx2rd1oTU99m7QnJG1VGZzGKKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=df8V0ztkwUKYdcjL//LhZEfRE54JUuQr2rUvlNDiSEM9JqaQNsNbzMaxwUjx0VpAI
	 T2rr5J1htHk/GHAgb/mzA5AqWOdK8G9JrLb8hqHpuEa+E2ytLP2FFqbbwxk23I175h
	 etYsU/UY2xOfXWVd7cxLnbKLmsIElcHEgL/Wruf/XORf+Z3a6zsop5b01pgJ3s1y5i
	 8jEZs0JcGud02E/zZFa+du47l5AUKBq/uRHttEfjBam17S80XY30bPKZ3nWkDNvJdn
	 SMSsPEHeCQ0S8tsRwMe+igY2VNPSU7bcBUZibbaWZiwgpIUzENrDeFNQV43596wgsR
	 Qbm2bJE3+Rurg==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Trevor Wu <trevor.wu@mediatek.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org, 
 Aary Patil <aary.patil@mediatek.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>, 
 parkeryang <Parker.Yang@mediatek.com>
In-Reply-To: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
References: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
Subject: Re: (subset) [PATCH 0/5] Enable audio output for Genio 700 EVK
 board
Message-Id: <173341472111.145991.1986411780939561969.b4-ty@kernel.org>
Date: Thu, 05 Dec 2024 16:05:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 05 Dec 2024 09:13:53 -0300, Nícolas F. R. A. Prado wrote:
> This series enables audio output support for the Genio 700 EVK board.
> Patches 1-4 do the required binding and DT changes, and patch 5
> describes the audio DT nodes to get audio output working on the two
> audio jacks, Earphone and Speaker, present on the board.
> 
> The standalone fix in [1] is required in addition to this series in
> order to get the sound card probing.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add compatible for mt8390 evk
      commit: 8e22ea5fb8498c52fcc20bbe2070c3aef1a3dff2
[4/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: Allow DL_SRC/UL_SRC dai-links
      commit: 5a56323a54b7febcfe82cc5eda840a176647b7cd

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



Return-Path: <linux-kernel+bounces-279077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE8394B8B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B66F1F22BB6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6618953D;
	Thu,  8 Aug 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QumPQrG/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E997C62A02;
	Thu,  8 Aug 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104766; cv=none; b=SsihIENnYpXBfzGzYyCCrHBaZnUuuFYR1llp/saLh/nFrQJvJe4mIZINPfiTkNk6/rJfypEGo8dLXpVJjPQQjwtt0Me16WufoLfK5/mlRylpKXk1GB18eocAgRt+H/8PairellT59UtXirEhh3T5RpyurykglsM5h9B3OSPPlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104766; c=relaxed/simple;
	bh=wyGx+hEJcKcB48IvGGd6h0VDj2+CYo9kV3ak2QyISOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CW4E6K2n6XnUyr0nsZbQjSq6A0PCma/41Wzm+yBQ9EtWOS91RTFR+Ch7eSu/WsMF+3SErgmHo5+1PBFUe9UnxgoUT9AZE2SBQ2VyLS0iYmGFYSNRNLzeupk0z/TjxUqCCcuGT+BDEn7VZ1gVCBz0BssZk3cd/DmadgaNO5LNIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QumPQrG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E3EC32782;
	Thu,  8 Aug 2024 08:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723104765;
	bh=wyGx+hEJcKcB48IvGGd6h0VDj2+CYo9kV3ak2QyISOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QumPQrG/t3EEm3FPj5QkNQ3XdBdRoSCuWoeukdPa7MtrfgKS0xC9vBxYqtoRF5MpK
	 bnDB4+HjL3FXULyiDAHksc2g6dpe1s33Yc+8v5n/5KFSoBjvHWB1fljWDNQIR+LEJy
	 c5FAUrdWrv7YxsBFBW/O8T3CH091Fvo5a7WpvRiXIZUeQmPso4+HJOkIeQnlvy29AF
	 aXgdfxvF16aRnC2rRYRi2K+S4ISXhClzcxCPEzacBwtEZFG/m/4IgwZ/bu0mScg3VJ
	 0evxRAWBAJNechfp3g2G9Sl3ttiuDrSBFBb2iGvvRWTx9xlsmQwt+vBXk0946jWU2a
	 vlLxLDaj+F+7w==
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, 
 Jason-ch Chen <Jason-ch.Chen@mediatek.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Chen-Yu Tsai <wenst@chromium.org>
In-Reply-To: <20240807091738.18387-1-macpaul.lin@mediatek.com>
References: <20240807091738.18387-1-macpaul.lin@mediatek.com>
Subject: Re: [PATCH v2] dt-bindings: regulator: mediatek,mt6397-regulator:
 convert to YAML
Message-Id: <172310475886.457595.9495452307181786798.b4-ty@kernel.org>
Date: Thu, 08 Aug 2024 09:12:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 07 Aug 2024 17:17:38 +0800, Macpaul Lin wrote:
> Convert the MediaTek MT6397 regulator bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: mediatek,mt6397-regulator: convert to YAML
      commit: 1b4ec561b47d806eb0752a73837c2248bf622c06

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



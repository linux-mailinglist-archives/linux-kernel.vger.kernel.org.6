Return-Path: <linux-kernel+bounces-227065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8659147D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2271E1C21ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E413774D;
	Mon, 24 Jun 2024 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mb0qeF7X"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299412F24;
	Mon, 24 Jun 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226316; cv=none; b=qWCQ7poq+y8DoP4xGAkmB1hOMHmC6rk/5+wBjgP2wdoqXcvmABrrMFKOF9ErpDIMgB1/+wCKyc7d3Mh/3IyAB2sYFP4l7j86029kMAvxw8Gx352WfYUAmEyovSRWAU7AB+8FpUx2EjWqmKVYhWIf4oBfoxJOgsokXtOw57xCAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226316; c=relaxed/simple;
	bh=zECgMKM9yykTAXEDbgcRVzxyKGAZ3Ejp9Ilu/XnL06Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bLFRDLLB5eTuTAD6Kunl96gtSbN0Vr70iGCgxGq4IKCwnZIsZTp7uvNrmXvG84TmrNpDv8YH4BzYBv7V8jI3sE8KQiNGFF60ITWJFJZi5UwnnFhJRIe0qHZPzoROkgIKRa9IXVm5/nLuiT/I61HLafZ0xdN+fr3iwxwtE72x++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mb0qeF7X; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719226313;
	bh=zECgMKM9yykTAXEDbgcRVzxyKGAZ3Ejp9Ilu/XnL06Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Mb0qeF7XFYa8RwDEaUB8FWTMJ5TbhRK3XhkatDPTh3raAj+ayHZTQ8GfuWE16zErP
	 LHDCvWGqTiLFMlcLJMNk0z/zGn7swRQ5gWTK4y66/PE6xnPl7UZ0w2U/NIkXW3b35i
	 Qsbe/igmKuCG152SXAp1HgCrqivpg1AfuCeUK3X/Eh1J2VwLl5nYWyzAfUU2bFMuQh
	 95ZRcbnZUZ/vE4pYpZCTmtbmYU9lRyJorOHFG6hj/CmPwxrpefTkpiMILgQqpCO/jk
	 lLvhgihXYx4hoLM1HadeTXbBhJ2uSy/M5I6E5/c05qNNF4XvWOjA2MzPUG6+2cgLX5
	 OsRJgCTtC+pww==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A6DE437804C6;
	Mon, 24 Jun 2024 10:51:52 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240620094746.2404753-1-wenst@chromium.org>
References: <20240620094746.2404753-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH 0/3] arm64: dts: mediatek: Add MT8186 Voltorb
 Chromebooks
Message-Id: <171922631260.124275.13611191482374063756.b4-ty@collabora.com>
Date: Mon, 24 Jun 2024 12:51:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 20 Jun 2024 17:47:35 +0800, Chen-Yu Tsai wrote:
> This series adds support for the MT8186 Voltorb Chromebooks. This is yet
> another product based on the Corsola reference design. This particular
> version features a higher end spec-ed SoC, necessitating a beefier
> regulator for the big core cluster.
> 
> Patch 1 adds an entry for a new regulator IC. How this differs from
> the previous iteration is not totally clear.
> 
> [...]

Applied to v6.10-next/dts64, thanks!

[2/3] dt-bindings: arm: mediatek: Add MT8186 Voltorb Chromebooks
      commit: 52225f8c1347328168f113cc2c089bf81e6714d6
[3/3] arm64: dts: mediatek: Add MT8186 Voltorb Chromebooks
      commit: e612fe2dfd7833ae06e7418eba39d7fbddb36799

Cheers,
Angelo




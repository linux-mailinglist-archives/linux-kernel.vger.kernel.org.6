Return-Path: <linux-kernel+bounces-347234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C81D98CFC9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5144A28CD85
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27965198E6C;
	Wed,  2 Oct 2024 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E/YMZX2x"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292C197A67;
	Wed,  2 Oct 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727860089; cv=none; b=je5lDtjDvLGz6CUvPGrQ8oz87M0iyJr99zhCmwhpr98zmUCANEDjVshPcx2bNgVPmDJIwOmlePYxGGtexWQaUzHmqonQ09OAtOjbhXdOujsdyCWEN7kHXpj7yJrrnvlA9LM6cMHBXNpNgmfkQWZIlZL2jSjRVCufVXxtSe9lnDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727860089; c=relaxed/simple;
	bh=Xtda8GgdmpzB/6piVb67QcbqKu9enLjmiJSRfaL4WgE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TBEDN4VWQZzksh7855joFLmIxiV/PDrYRR+hDgYSDGP83LqmofeBNzDTiMdvKmWRxYzGHX8OPSgeNwF9+SzjrU5FhQ06hE1eWLwJKkm/EKJa2228RsPZq7yfx7XrNnp2qlsO6q7FMT5QsOMmCUteTKcyp5WM1JiukHNveOt57Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E/YMZX2x; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727860086;
	bh=Xtda8GgdmpzB/6piVb67QcbqKu9enLjmiJSRfaL4WgE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E/YMZX2xXUFZOGClSYWCrQeBKYJH5iA1V5TKBUPVfMiTSX/RSn9r2zZFdOqopzOIB
	 d/TmRttPlHx4KkojpmDKtl8iMax2n955FPyEw5cVDgNr/xV6jizXnFY561kWWWjj5K
	 Xs7mzP1SBkNDo0BK/QXawTzgFt0x7qxxVu+qUITEDMIDcrylcDAn7cI0Q8b4m3KTNP
	 Je1C9m+puoRlziweE0ZKx1UWz5/F76xn04zgrEx9AOqnv+S+u3OimO5AQ+/N0QqGvJ
	 gVmn3dCG0DtF4V0gowxpeqnVaJjn8v9aJig2Dkjwma9RETssKeFtnOfPIOAJMRDdcY
	 ob2L6bL4+11Lg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A84D917E10D2;
	Wed,  2 Oct 2024 11:08:05 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Pablo Sun <pablo.sun@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20241002022138.29241-1-pablo.sun@mediatek.com>
References: <20241002022138.29241-1-pablo.sun@mediatek.com>
Subject: Re: (subset) [PATCH v3 0/6] Enable Mali GPU on MediaTek Genio 700
 EVK
Message-Id: <172786008562.33539.7007504716451192939.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:08:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 02 Oct 2024 10:21:32 +0800, Pablo Sun wrote:
> This series is based on linux-next, tag: next-20240927
> 
> Enables the GPU on mt8390-genio-700-evk.dts.
> The panfrost driver probed with dmesg:
> 
> panfrost 13000000.gpu: clock rate = 390000000
> panfrost 13000000.gpu: mali-g57 id 0x9093 major 0x0 minor 0x0 status 0x0
> panfrost 13000000.gpu: features: 00000000,000019f7,
>   issues: 00000003,80000400
> panfrost 13000000.gpu: Features: L2:0x08130206 Shader:0x00000000
>   Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
> panfrost 13000000.gpu: shader_present=0x10005 l2_present=0x1
> [drm] Initialized panfrost 1.2.0 for 13000000.gpu on minor 0
> 
> [...]

Applied to v6.12-next/soc, thanks!

[5/6] soc: mediatek: mediatek-regulator-coupler: Support mt8188
      https://git.kernel.org/mediatek/c/32ab0090

Cheers,
Angelo




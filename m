Return-Path: <linux-kernel+bounces-347259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B694698D037
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C0A5B256E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B229A1CC15F;
	Wed,  2 Oct 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m3baZz16"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782419412F;
	Wed,  2 Oct 2024 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861610; cv=none; b=mhKMQ1fnLeLKbTkx3ZjZ3pH43OayVGxrR9CRyNZTClHdlkf314lnsdQ07JIuCGLGOJRpAREAsuXYXBdv4B/erSQF0gKXtwJ0A7WwT5Az4NYKRKikLyueEZpQ9zs2ascJwBJG2jJ3eJlOgdQ6cwb3jJmJWnX1BhiB6iu9itWgQgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861610; c=relaxed/simple;
	bh=9UNSrYUYZixLR+dbvzU2+reeNrx287LANg9DBYW9CTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L5zUu4ww13iO1olYoldrwsBhwENanelY+lBB1ii5+MYorT1WCHG8Zss9NPhhPwvgS/+93RaGyEPtcBNbBVS90j892e3g1kPveJhWayWGW0+ptrs3f6Wmqxef5sGBJZOeGsn+qsWzLHIfYcUaJSSGzAkAOlC9Sr1pEGhfmT+I8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m3baZz16; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727861606;
	bh=9UNSrYUYZixLR+dbvzU2+reeNrx287LANg9DBYW9CTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m3baZz16WDi3Y13FNPwGjJhvKPpDwJM9tehDnjzEm/mLzd/fL9KKuhuR3GcuWCHEG
	 V1LJUON8Rt/gXA+CA/+g1AjU4Z96fLkXmxCcKjoGwv1wO2kClm6Dv2PHZS1VhMo+Z5
	 4l38PAkjCRJZF2yAkGWsFR4m4jWD+Te3Mmpl6+0BjnAgc+QDp16FbHMPGcOcuB285Y
	 DSoQrybIqd6CWmqwfoxvflZF2yDsHfyI9QOTWriyt+CZd2VO00hcJQxOODetBpjsrZ
	 LtnbyWgkrm5FsyHxDxfQGj7PAYHUmsLtvPUJdpqBUMK4YkouenSaaYUBbP4COvGB1m
	 Gw190fwBJchYQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3C6AB17E11F6;
	Wed,  2 Oct 2024 11:33:26 +0200 (CEST)
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
Message-Id: <172786160619.39477.3697338680534899940.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:33:26 +0200
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

Applied to v6.12-next/dts64, thanks!

[1/6] arm64: dts: mediatek: mt8188: Fix wrong clock provider in MFG1 power domain
      https://git.kernel.org/mediatek/c/4007651c
[6/6] arm64: dts: mediatek: mt8390-genio-700-evk: Enable Mali GPU
      https://git.kernel.org/mediatek/c/0158b773

Cheers,
Angelo




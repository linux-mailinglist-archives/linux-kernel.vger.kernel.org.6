Return-Path: <linux-kernel+bounces-355131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152EF9947C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9EFB26EA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277931DE89A;
	Tue,  8 Oct 2024 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oPopWbj/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934AE1D799E;
	Tue,  8 Oct 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388346; cv=none; b=WIESQUy67eKdZJrQ34KsX5dmvPNYwOPKLPzeMLUDD4PgTJQVgyIEyc8Gx5jikEY4vmg0pSWbelWSDNuW7r68IdW8oe3LSQZ2b1xBUC5CMaAziRzuDEA76evKo/ADUcjYdt5UY47TU8Lkog2zLdW4E779iAfx2mZjLXJlFKRgc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388346; c=relaxed/simple;
	bh=yoZPUcstHvfFyrc/Sujr2G0j7hScF0BV7LuYHeSOp6A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lG0uysPGt+kuSZ7Dd7ICIiGpV20IDtNwLvETJeKI7UrLo3w59eCvGBWe5QOhFQRX8r0zzr8OqJg97eEUUoo3D9yH3kvJWMZfoolCKCLAPSKKf0B9wYYqZAxFRiNyDfsOFUGf0obqevzY0zQZHfzap1iz2otDcj2+9Po622xW3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oPopWbj/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728388342;
	bh=yoZPUcstHvfFyrc/Sujr2G0j7hScF0BV7LuYHeSOp6A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oPopWbj/MEK+6doEOmxxm5ZH2UaKXZQ7ffhrBoy/ujN1GBoyCmxpLmwKQesvSuanT
	 vMLQYyOM05bREuDMBJdpq58OaWtHXHdUt87rtTjA5lOpda+qm/g+8WhLFtzcBHpkvg
	 ECxwU4GB0mWAQv0VGcoRdAJaXgjwL4ZQVyg4h30DPeQwrJbvRHsPtk4BCkoX8xjouC
	 OLECTWKKuNOrEaIkvqAuiD3dPLnR/nAon1mqAbuK9oSLnfTWiuOvpXy6xZABE4qvsg
	 /Lm1OOOfe1ehIdgjVKmitwD+prMe/O4yo5+UovYFCUmkmbjsPdKDZpOkFos4a/8W9y
	 yMd2CkiQhybgw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4126417E13A2;
	Tue,  8 Oct 2024 13:52:22 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Fei Shao <fshao@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20241004081218.55962-1-fshao@chromium.org>
References: <20241004081218.55962-1-fshao@chromium.org>
Subject: Re: [PATCH v3 0/9] Add platform supports to MediaTek MT8188 SoC
 (part 2)
Message-Id: <172838834220.62767.15083532214738517740.b4-ty@collabora.com>
Date: Tue, 08 Oct 2024 13:52:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 04 Oct 2024 16:11:52 +0800, Fei Shao wrote:
> This series is based on top of my previous "Add platform supports to
> MediaTek MT8188 SoC" v3 series[*].
> 
> There's nothing to change or address in that series at the point of
> writing, so I decided not to resend it and start this new "part 2"
> series instead.
> (if I need to update both series next time I might consider merging them
> into one)
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[1/9] arm64: dts: mediatek: mt8188: Assign GCE aliases
      https://git.kernel.org/mediatek/c/3192a83f
[2/9] arm64: dts: mediatek: mt8188: Add PCIe nodes
      https://git.kernel.org/mediatek/c/ad5c0159
[3/9] arm64: dts: mediatek: mt8188: Add MIPI DSI nodes
      https://git.kernel.org/mediatek/c/08a838d6
[4/9] arm64: dts: mediatek: mt8188: Add video decoder and encoder nodes
      https://git.kernel.org/mediatek/c/b04407fb
[5/9] arm64: dts: mediatek: mt8188: Add JPEG decoder and encoder nodes
      https://git.kernel.org/mediatek/c/9e85e3cc
[6/9] arm64: dts: mediatek: mt8188: Add display nodes for vdosys0
      https://git.kernel.org/mediatek/c/26170e14
[7/9] arm64: dts: mediatek: mt8188: Add display nodes for vdosys1
      https://git.kernel.org/mediatek/c/0a3bd16e
[8/9] arm64: dts: mediatek: mt8188: Add DP-INTF nodes
      https://git.kernel.org/mediatek/c/5a206e43
[9/9] arm64: dts: mediatek: mt8188: Add eDP and DP TX nodes
      https://git.kernel.org/mediatek/c/8f8d13c8

Cheers,
Angelo




Return-Path: <linux-kernel+bounces-347265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E697498D046
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BD8289221
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898E51E1A2C;
	Wed,  2 Oct 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p922LMMS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E751B1E130B;
	Wed,  2 Oct 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861615; cv=none; b=JpuhcOzuq/gLJccpCuidAaJQRqSrcB00+EmcZWe1nBggaAyOy/xt6WGiviFa3pZUxIHMmbldWhC1fgNL1M9MfIXJVePQS9YbIJ0efpw3Ga9whrkkZBa0HMQI6Xpj5K/nwXVAJCUvjCIIAVLjYK4VVX6XOw4rfqYFszq1bl5Ak+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861615; c=relaxed/simple;
	bh=aEZ3V0e96llw0qLEbix5vImUGc2T9SakySfi4kktqIw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NWGf56OJhJM8FY30FHYQpoSqMxJ2cNP/p7lvUYg0yLthqx3vd0gKnJsqOxcuRdYmXdcNyl43FyIuJWDcYwPRovI8hijfv+qIPSwdZVsQGPRzjgdErS2zCZYq2p4BAcCva+z5cKDI2ovuvxxVA5oZBzmpxs01VAhK4edHGY+3ohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p922LMMS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727861612;
	bh=aEZ3V0e96llw0qLEbix5vImUGc2T9SakySfi4kktqIw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p922LMMSqLkHVljF+Ecm6Wyqj53PprrTan/GuHAnocAa0td6pPXoXZlJJIbXKd9O2
	 CmGPaXvOMBG1gxZpsTVMC67Y2vbLvQUou3fZweCVWY/uhprnRdqixMUJHoQUX1ft6D
	 L3mO8ubA4ZbZrYuwBko9oUEZR9CIJtKqGtqn0rIjHdoiYF5x2L4EQOpOD96gH+eHAX
	 li4O+9aCtLeOKdKFwNjO2r6hbP3ccMYIhmuGyU92uOdvFB46GrpMIS5KPRtGgrURkk
	 UyJ9z0E008SHk2egkElJ3XurYW6hMJOFJ3lEDyn6YEHNjeOCtnaJ/7qXqTIx6iLhf0
	 EOD0frFlh1fEQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AD9C717E1250;
	Wed,  2 Oct 2024 11:33:31 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>, 
 Pin-yen Lin <treapking@chromium.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Fabien Parent <fparent@baylibre.com>, 
 Jitao shi <jitao.shi@mediatek.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240912144430.3161717-1-treapking@chromium.org>
References: <20240912144430.3161717-1-treapking@chromium.org>
Subject: Re: (subset) [PATCH 0/2] Fix dtcheck warnings for mediatek,dpi
 binding
Message-Id: <172786161165.39477.4684212034089747258.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:33:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 12 Sep 2024 22:43:57 +0800, Pin-yen Lin wrote:
> This series fixes two binding schema errors in mediatek,dpi binding.
> The first patch adds the power-domain property to the binding, and the
> second patch adds the port node as it's required by the binding.
> 
> 
> Pin-yen Lin (2):
>   dt-bindings: display: mediatek: dpi: Add power-domains to the bindings
>   arm64: dts: mt8183: Add port node to dpi node
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[2/2] arm64: dts: mt8183: Add port node to dpi node
      https://git.kernel.org/mediatek/c/ec1a37b3

Cheers,
Angelo




Return-Path: <linux-kernel+bounces-347262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF9F98D03F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650DB288B86
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C131E130F;
	Wed,  2 Oct 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Jwme9FEo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63801E00BE;
	Wed,  2 Oct 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861613; cv=none; b=lrgIhrpF8zA6ui3Cgev/zL5MJ2MA3O+tCKx1hNB318/M4YpK70hMyDpgnG/WBflFYdAarYM0nEvtJfcUZlKiELWG/LDQFoAarjxAdNAJB9BZb8ZUFAzciU7l4Lc5rDeT9oNzydX+w5dexkvAPoAvCqaVO/t/ZPZMKDc0jBDOVF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861613; c=relaxed/simple;
	bh=DAtGJqVbakzDbiZtYokHvZtNYlKTAu4abCJItS1QG/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gDAQctCBk/4/M7qCqXO0CNRg8WJHZmOXGqKlQ7LlOb3DcRO7J9o8AbNdJRVj1jQdTLRj0o2jAj6amwSi4xnysH7N8Y7TolBr583zhz6ZN5lJCsIX+Nx111hDdNKFVZmay0uzELdHeR9iW0YZrQ2YrZAlAW3tEiBnGz6j4Zk/O+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Jwme9FEo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727861609;
	bh=DAtGJqVbakzDbiZtYokHvZtNYlKTAu4abCJItS1QG/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Jwme9FEorp2j+aphusEqIxwEq+4BI9kQ4vdExhP+wRvtdlekayQn/3rt3kmvu9K3Z
	 0Mv3NTJTEV9+qgRVQWr/AfRdwQK0PK/TlgJNY0XzA/LIlO2F3Ots9YjsoXuWe7yw0t
	 4OOA+PN9nnHkNz7w+PjFAKPOH5X3lqzZrax23ZezA9DtFd8xHZQYE07jPIkXBY9TLc
	 4sviLfjrMnruYvsSc7+Ohn6PRgzXI222NirnqEI1u3jFguowTRjcFNOL37i8jcwawt
	 h4QQJsIo+bhkZ6kA6hFiAVXJCUuwJlQTOmtqFs3DiuxuI5oX9GBPsiWJi98kB4X+rI
	 XVX4jDh8SsDUw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4EF6F17E121B;
	Wed,  2 Oct 2024 11:33:29 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Pi-Hsun Shih <pihsun@chromium.org>, 
 linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>, 
 Fabien Parent <fparent@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jitao Shi <jitao.shi@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Pin-yen Lin <treapking@chromium.org>, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240916162956.267340-1-alpernebiyasak@gmail.com>
References: <20240916162956.267340-1-alpernebiyasak@gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-kukui: Disable DPI
 display interface
Message-Id: <172786160926.39477.6425761248165017242.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:33:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 16 Sep 2024 19:29:32 +0300, Alper Nebi Yasak wrote:
> Commit 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183") adds
> a device-tree node for the DPI display interface that feeds the external
> display pipeline, to enable HDMI support on the Pumpkin board.
> 
> However, the external display is not fully described on Chrome devices,
> blocked by further work on DP / USB-C muxing graph bindings. This
> incomplete description currently breaks internal display at least on the
> Cozmo board. The same issue was found and fixed on MT8186 devices with
> commit 3079fb09ddac ("arm64: dts: mediatek: mt8186-corsola: Disable DPI
> display interface"), but the MT8183 change wasn't merged until then.
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8183-kukui: Disable DPI display interface
      https://git.kernel.org/mediatek/c/377548f0

Cheers,
Angelo




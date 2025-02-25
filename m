Return-Path: <linux-kernel+bounces-530827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC3A438FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2802A7AB91A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF81B267F6D;
	Tue, 25 Feb 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eyAPlUtC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9051D266196
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474323; cv=none; b=ciVsfuBoEuXOV/NXAncBWuVnvD38lBt/PWljjky00FaRu5LFF597NEJ+XpuvKl6nKOqK4z0R4iijUgeHi2kcfEx67e1vQh5qACLG6DYrNkwtfK13U+01aPcLcN/lZgWQ8iH/kJAOejkaM+Xba45rprGnn6Y6JLIe9ReKBeCcbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474323; c=relaxed/simple;
	bh=fhAvNwf3S/C3P4S0nP2ZiO1M1JWrZ+3nKs2jQvYh0EQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iJ7Lc3A1R2g1HoIpKhUquqid7NxNf4nwlzCNkKuQMG2U4Qkcb0t2yqrzq/U4dYAzXe0dFKELBvP8zo34zMUfiE+uNoLexViXdvBdWj808ObQm/al0OkmUfkLQGQxUQs+fjfU04xBOE23Y7gCIWy92Hri4wHUB2q+GMtMQH+DYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eyAPlUtC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740474319;
	bh=fhAvNwf3S/C3P4S0nP2ZiO1M1JWrZ+3nKs2jQvYh0EQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eyAPlUtCpHNl0RMIgAneO5Y+Jth+DkR1empGojPRixoK/bjWcItLCwv4Y7KT3XtYx
	 RvNIjzh79Gnfgyj8TwZCT6fBNcWin3+3aEIsq1Ea53aeomgA6t4Af61ApJdoWxsEha
	 VaOc0xpSIv6E0W1zbcV4/k+H4sjXwQgX92OEAns7O7L/OBOHkeX3Et7uaFrRKxGWTn
	 IOx8tXxxN+h/9hKHGewICb0I8c/W81ZwMfJiQYDJPdxHMitb9uiVFuvFmUUEggFGRn
	 mLl7P+p0skSOtQgW5EIYMKsTUOZazgS9P45heSwpi0v4n5+c5fgr5+Tin9YbNu5UzQ
	 zbyqHA65ZH9GA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E561517E0B63;
	Tue, 25 Feb 2025 10:05:18 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: shawn.sung@mediatek.com, fparent@baylibre.com, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, pablo.sun@mediatek.com, 
 kernel@collabora.com
In-Reply-To: <20250212100012.33001-1-angelogioacchino.delregno@collabora.com>
References: <20250212100012.33001-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 0/8] MediaTek mmsys/mutex fixes and improvements
Message-Id: <174047431886.20024.8850797193074768931.b4-ty@collabora.com>
Date: Tue, 25 Feb 2025 10:05:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 12 Feb 2025 11:00:04 +0100, AngeloGioacchino Del Regno wrote:
> This series adds the missing DPI1 SOF/EOF to the MT8188 mutex tables,
> required to support output through DPI1->HDMI Transmitter, and also
> adds a few fixes and improvements to the mtk-mmsys driver and tables
> for all SoCs.
> For MT8188, in MMSYS, this adds the DSC path for the display
> controller, and fixes the current DPI1 one to actually do something
> meaningful... and speaking of mmsys....
> 
> [...]

Applied to v6.14-next/soc, thanks!

[1/8] soc: mediatek: mtk-mutex: Add DPI1 SOF/EOF to MT8188 mutex tables
      commit: ecb051fd99dcda50a9b93fa6e9399094b37488f0
[2/8] soc: mediatek: mtk-mmsys: Fix MT8188 VDO1 DPI1 output selection
      commit: 643ec3e1e2d070fba8f94dedc702211f501889da
[3/8] soc: mediatek: mtk-mmsys: Add compile time check for mmsys routes
      commit: 650de00b6b9c5690c6c3e8474d431f59a6f89b0b
[4/8] soc: mediatek: mt8188-mmsys: Migrate to MMSYS_ROUTE() macro
      commit: ba7877ba5353f0a2e8f15151e8053647eed5ad5c
[5/8] soc: mediatek: mt8167-mmsys: Fix missing regval in all entries
      commit: d0202d007a27ecea8c609f55d8757d75b521ea5b
[6/8] soc: mediatek: mt8365-mmsys: Fix routing table masks and values
      commit: 773140aa314218ba92ee4d69956f2813f593216e
[7/8] soc: mediatek: mmsys: Migrate all tables to MMSYS_ROUTE() macro
      commit: f9435e9c1a0c579db4edeb32f8fb317fb721c659
[8/8] soc: mediatek: mt8188-mmsys: Add support for DSC on VDO0
      commit: 89ef9bb1ece1a70bb79715be48a5afece39cae44

Cheers,
Angelo




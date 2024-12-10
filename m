Return-Path: <linux-kernel+bounces-439090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAFE9EAAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0DE283383
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A60231CAF;
	Tue, 10 Dec 2024 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kllvcoB4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EBC2309B8;
	Tue, 10 Dec 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819307; cv=none; b=VjTVRZfnD/UoEHyPoUrLqawUoi84wBSbsKcK1/He5z7ErW4jDQ/Z/kmi9mpP7f0h9buTymAogZJidFJqBJBbrcTDftN7n5hIBH9zfZbm7dW4N/d3prj+cnMeBfyuXV5urZsb2C1shDat2q9IwPysXTy3kgE0FFdjzQhZCfTZtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819307; c=relaxed/simple;
	bh=HRLZCOLXzZDLz3g8rQ8lNljlgFguHhxc0j2pbJ/KQvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bd0D0pu0gTmxBhS7sx2pUrTi6vrD9vquiyOqPjNGMYU/j+hgRKXU35zMLzLsvUNov8VtUPejFCYjw1/bIJbeq/wBO5lTWVgj872r/FvMvskq0huFkQxSSmIzgMy3WMprMoqpl7JwSyiLs7SUVQUeqntE+EtiSHOBftUEbgcI1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kllvcoB4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733819304;
	bh=HRLZCOLXzZDLz3g8rQ8lNljlgFguHhxc0j2pbJ/KQvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kllvcoB4HA+uUXNH0OGc6bR9zZNvt8hneDdEAMCoHhKh5TfNgorEbbKEtIxvma8cw
	 ppDdSpcYynaPGzy99PiwbHu/enDy/I0EgTuyMefbsSREEEbcz9nN0hMO0NT/nkW0Zt
	 KZ8EsGlFWFx5kKHrrL/0t6rTmw0o67mEKVKStoIVhoIMI4Wl276ZC/llWbWrLDP32c
	 REWGyF2eF3fNKOCDCKII+UBdjwSZqrR4rE5Mu6W6R/y6IOTA8adccNcwHHnb8BB1zM
	 RmelxwDSGtD97eYbon4uCoZEteE0gotZljy4rR58o9AG06kYiGWptSfSl7VM6EPtNT
	 SKHWTuEE1H02A==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C1A4117E1543;
	Tue, 10 Dec 2024 09:28:23 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Val Packett <val@packett.cool>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20241204190524.21862-1-val@packett.cool>
References: <20241204190524.21862-1-val@packett.cool>
Subject: Re: (subset) [PATCH 0/5] MT8516/MT8167 dtsi fixes
Message-Id: <173381930371.18469.6086866397447453685.b4-ty@collabora.com>
Date: Tue, 10 Dec 2024 09:28:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 04 Dec 2024 16:05:03 -0300, Val Packett wrote:
> I've been working on mainline bringup on an MT8167 tablet I found at a
> junkyard sale (lenovo,tb7304f) for postmarketOS :3
> 
> This first series consists of basic device tree fixes for the MT8516
> dtsi that the MT8167 one inherits from.
> 
> The changes that follow add support for the MT6392 PMIC, and that's
> mostly been implemented by Fabien Parent back in 2020 and not merged:
> 
> [...]

Applied to v6.13-next/dts64, thanks!

[1/5] arm64: dts: mediatek: mt8516: fix GICv2 range
      commit: e3ee31e4409f051c021a30122f3c470f093a7386
[2/5] arm64: dts: mediatek: mt8516: fix wdt irq type
      commit: 03a80442030e7147391738fb6cbe5fa0b3b91bb1
[3/5] arm64: dts: mediatek: mt8516: add i2c clock-div property
      commit: eb72341fd92b7af510d236e5a8554d855ed38d3c
[4/5] arm64: dts: mediatek: mt8516: reserve 192 KiB for TF-A
      commit: 2561c7d5d497b988deccc36fe5eac7fd50b937f8

Cheers,
Angelo




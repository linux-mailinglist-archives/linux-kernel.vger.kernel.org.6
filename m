Return-Path: <linux-kernel+bounces-530813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7542AA438D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6835B7AE755
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B8026770E;
	Tue, 25 Feb 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QF3FdlHD"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF32256C91;
	Tue, 25 Feb 2025 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474158; cv=none; b=I8Dx19mFcyncWjorXM3Bumw3McIqowUJ2AO4tnuHql/QQp1EUo4GcK/E9RtG+djI1AqPwGz9iHidx5zI3Eh5ffCglS/YEhfRhFqHSPuO5XOdxbYB5C5S2YbWowTmUUU0Hy8Gzoi08l40dAJnCLFRE8ZggS4jddMAEEMYo0/q+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474158; c=relaxed/simple;
	bh=N8EaBkB/oPq7vbJ2oYiO1rXY0iEuTlwI6ZV3Cw7DVEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MTWQP1PgV5UY6YrQCKT+4TlThsQU5ULxLartjFEmHwIS/km4OdMbB7VjfRiOSRjxJZgiGIVY+7o62IS3VHieKJRNrqKgoX4iKRov3DOLpvLaYMVnUIqpqn4T+qUGg6skTPkDV27FlVmnXRqBePXnkXgSK8NOVohgPbmENtiwNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QF3FdlHD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740474153;
	bh=N8EaBkB/oPq7vbJ2oYiO1rXY0iEuTlwI6ZV3Cw7DVEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QF3FdlHDy94YWVjPk/9NE/OltIQBeouYkO2vfUTC5NKlTWXRsS2fpVAlOW1aIeD8t
	 jXD19h7+uauWWYnNm7S5DbAH77kgKfg8fMSz/2aeh3cey2MHkgNV3YEH5KvyiOZWxN
	 wQnXbAZPTZFDtnICeAE/dUQuUgsAmov6ReQOWLFclwQhcov8pOEMysz0r+4CZiUC5X
	 iLrUZLYswO6MJA4OIz2pYM28NEGEONkpCiCyBGjn4ikaPeKFHmk7j5CVQ8rYg1A4BJ
	 zXqnby+lUGwX1gf16AMSB4UnoSsEfrmdZsQISJkWXifKzPoyd3k7yVpIc6uoLaAONb
	 o/hGgNj5tI4uQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4297D17E0CFA;
	Tue, 25 Feb 2025 10:02:32 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Chris-qj chen <chris-qj.chen@mediatek.com>
In-Reply-To: <20250220142230.2530583-1-macpaul.lin@mediatek.com>
References: <20250220142230.2530583-1-macpaul.lin@mediatek.com>
Subject: Re: [PATCH] dt-bindings: usb: mtu3: Add ports property
Message-Id: <174047415218.19243.9815306970624641790.b4-ty@collabora.com>
Date: Tue, 25 Feb 2025 10:02:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 20 Feb 2025 22:22:30 +0800, Macpaul Lin wrote:
> Define the ports property in the mediatek,mtu3 device tree binding schema.
> Include definitions for port@0 and port@1, specifying their roles as
> High Speed (HS) and Super Speed (SS) data buses, respectively.
> 
> 

Applied to v6.14-next/dts64, thanks!

[1/1] dt-bindings: usb: mtu3: Add ports property
      commit: 3aeff53c57c86981f9920e4d5ae7d00b7d62a671

Cheers,
Angelo




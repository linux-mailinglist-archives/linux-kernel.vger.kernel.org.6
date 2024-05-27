Return-Path: <linux-kernel+bounces-190355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441A18CFD38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C881C220D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945E13AD11;
	Mon, 27 May 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KmZI87EK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672B13A24D;
	Mon, 27 May 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802755; cv=none; b=KOOKORupJrrOQwVaaxK47uRnPYTLwIX7SHp9ff9FP9hR/F8CXmiStvlen4l8hupnAGVdJSNA8dj9kUXrgLhjiwGQgq+bLrZe1gwEL+7g9iGOv02xLpxMoZ6h8U2jk5Wte14r4a/g4J6RykOOwPjafiNrrC56MiGwKj8QKm62gkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802755; c=relaxed/simple;
	bh=phWrTw+karsjUzSg7kcqChr4IdJshL4HbQ9zmQkn4Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPYIoOJaR2h59azfvs7W7fY0rS/hECsNt9z0BEUUSYcMfY2zDoii22LGx0gMvF+IG93+TpI+ZWtmNNT24GLBrT5j6ml1AdiaZVa+1kl/fORe/C1hFs2FmaFEccRBLoMVOlrepAHR66t3wt7G7Dsa9TiMBdN8SCCwy5vHomiakSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KmZI87EK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716802751;
	bh=phWrTw+karsjUzSg7kcqChr4IdJshL4HbQ9zmQkn4Qk=;
	h=From:To:Cc:Subject:Date:From;
	b=KmZI87EKdwsteVx5VwSdvILvBracIrFrCTLUXucUpWp5B8zeZOvElhuJ4qjMyXNbo
	 J0pozHh2KKNF93/orrsz9CapK9KRxsbKChlvWuD7rBsgvKkxTpNGwT3MSkQXLYLXWT
	 PIxb0hewTe6muqjZwQt5nULsisMGzK7LVqLKaF5dVVWaYHMLcf4+OLYk4UpArg9Ai0
	 TT2lB9gpFNWJ2gZF1LjFHuZOSkmqv8kHVuesPKJuHffEcwNY54h8snfcJa/IRrIORl
	 QjGBXNK9UO6yv3lZbag/0m37jiB8Ty4r0vJWFf7687uUxy70YloAXauKJASQ3/72+7
	 iI0j7MeYigTug==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B90B53782065;
	Mon, 27 May 2024 09:39:10 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	mandyjh.liu@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	jpanis@baylibre.com
Subject: [PATCH 0/5] Support for MT8188 power domains, gpu, gce, vdo
Date: Mon, 27 May 2024 11:39:03 +0200
Message-ID: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds power domains, basic VDOSYS nodes and GCE Mailboxes
to finally be able to add the GPU node, which is needed to get the
thermal nodes complete, unblocking that series.

Please note that the IMG_VCORE power domains were omitted, as those
need some more (driver side) love to actually work... and adding them
right now would most likely break basic boot.

For the GPU, this series depends on [1].

Cheers!

[1]: https://lore.kernel.org/lkml/20240527092513.91385-1-angelogioacchino.delregno@collabora.com

AngeloGioacchino Del Regno (5):
  dt-bindings: mfd: mediatek,mt8195-scpsys: Add support for MT8188
  arm64: dts: mediatek: mt8188: Add Global Command Engine mailboxes
  arm64: dts: mediatek: mt8188: Add VDOSYS0/1 support for multimedia
  arm64: dts: mediatek: mt8188: Add support for SoC power domains
  arm64: dts: mediatek: mt8188: Add support for Mali GPU on Panfrost

 .../bindings/mfd/mediatek,mt8195-scpsys.yaml  |   1 +
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 480 ++++++++++++++++++
 2 files changed, 481 insertions(+)

-- 
2.45.1



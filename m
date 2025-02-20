Return-Path: <linux-kernel+bounces-523486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F247A3D77A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FF319C106B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9581F150B;
	Thu, 20 Feb 2025 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RVTbQNmY"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDDB1EFF9B;
	Thu, 20 Feb 2025 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048947; cv=none; b=DRLY2d/MNFRTqlzsRY1a+q6BAYgHeneiYYf63HtyxPut2ZhFnC2NbgRKOzBG5A9PhwSh6+1YB00IC7NHoldx6dwt5KNAwabkqB7Wpa1j1jtl/kLkzQzJoSw3+C9FSxbYmdSbdKgEjbwuT98+gDE5VEWoEVPvdJf/zzCxctxD/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048947; c=relaxed/simple;
	bh=Fe1NU5MSplDv5eB2zljQeoAX6aX1MK7BwDK75afdqts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJ9rq5NsS4QzRvUJw1b2RXzWdkO9ycE4rKorwNpHVuBN1J0e9E7Zo3HSAaFiykBdiCOnxnDKMWhIMklFVBV7iGlKaYW6eBC19gXjYpLScZX2OWvU0H1cVW7eqI1wGhgu5vcpL1IvXwNqV2vGxoGsRe+pqMD4/D6YBpl5JoRyNlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RVTbQNmY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740048943;
	bh=Fe1NU5MSplDv5eB2zljQeoAX6aX1MK7BwDK75afdqts=;
	h=From:To:Cc:Subject:Date:From;
	b=RVTbQNmYR35edytVQKzTBRi1sUJrKyaEktH+KwNhGZ+AK4KZlu6hY+BQbxbGivrzm
	 xvw6OpD9jjSBlvANTwspWE1cOEKRkyV+1JLwjhVUAzC/kqQ2OtVjgkYHjdxaQDOvVC
	 3THwTjqaIWerXQmtWVf4B0h6ozPF8zIF+zR/4scZ4Om6STX9DCo6a00Gw7woAk4GdG
	 G2oSe+9Z/e+VAIkZ1gZLZuAhdQnGomYI6gZ6PAkel12n2ld2DCz9kyiHoOrTib9utD
	 b9wyGz0zAF2FMwgxijai0uZUCIXac5lRQfzyxejMnpLGQmvTlG/G6qYoBfHKZ6EAIc
	 NguSqriMxKbDw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A7D0517E0CD1;
	Thu, 20 Feb 2025 11:55:42 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com
Cc: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v3 0/3] MediaTek MT8188 MTU3 USB and Genio 510/700 TypeC
Date: Thu, 20 Feb 2025 11:55:11 +0100
Message-ID: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds MTU3 nodes to the MT8188 base devicetree, fixes the
Geralt Chromebooks to use it, and adds support for all of the USB
ports, including TypeC Power Delivery, Alternate Modes, etc, found
on the MediaTek Genio 510 and Genio 700 Evaluation Kits.

This also adds the missing SuperSpeed port to the mtk-xhci binding.

AngeloGioacchino Del Regno (3):
  dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP
  arm64: dts: mediatek: mt8188: Add MTU3 nodes and correctly describe
    USB
  arm64: dts: mediatek: mt8390-genio-700: Add USB, TypeC Controller, MUX

 .../bindings/usb/mediatek,mtk-xhci.yaml       |   4 +
 .../boot/dts/mediatek/mt8188-geralt.dtsi      |  18 +++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 121 +++++++++-----
 .../dts/mediatek/mt8390-genio-common.dtsi     | 151 +++++++++++++++++-
 4 files changed, 251 insertions(+), 43 deletions(-)

-- 
2.48.1



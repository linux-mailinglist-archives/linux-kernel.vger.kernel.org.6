Return-Path: <linux-kernel+bounces-521477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD20BA3BDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227A23A9403
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B80B1DFE25;
	Wed, 19 Feb 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QWRGYqJf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC58286281;
	Wed, 19 Feb 2025 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967733; cv=none; b=EJPJIE0ElR5X9+n4iYfGRXXeRCmbxZDI+EyEeEzSiN7S+DHDfw640PgTmhfSbmvHvXj93pUSXv+rt8QuhsD/ndO9z0qP1MqE2/I91mefwRM/lB5xU2ZV/CKHyh6qGJfLEByOnYVHwCgl6syK/rRhk1Pw5SwaWXKh1oaGqqINBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967733; c=relaxed/simple;
	bh=dsR7BYjCUHAZyYafXNUKYoN2pBJeDtkoQ5YTosh0TXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjYOEnzmhsMT2fuN+AlyYUEuwI6e8lYJk9MPFOAwFKpp2zI/5hkQtH5BxxOSo3O4N6R6Ct3fVEeNR9GKuJVE/pMBupbwyJ+nMPKwGEJNTafYU/GQ+zHE/eGTF4pi+Mnw/N36r7SUf5d4/pCI6qGyI7n79RqeiSMmdUM/3K3UtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QWRGYqJf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739967730;
	bh=dsR7BYjCUHAZyYafXNUKYoN2pBJeDtkoQ5YTosh0TXo=;
	h=From:To:Cc:Subject:Date:From;
	b=QWRGYqJfkpEbakw2Aphxh3VSQMTFOeHSvHeJAFeK81ZE9x0/Z3BrXEx0NIxJ++ZLJ
	 Aq1FF5TUEGASJ/qgskPgrmAr7xhQha4X6/8AhyUdMX/3MVEf6OEXWxkz4GuDdnlhGn
	 NoP6mM+nrQKrUtBtjM15vciLj+y4PqKJoC2gIQQN6TeK8bVt1iGNYTALedSvO6SWZr
	 UI5/Mm2Ec0zekOvHHB0RkDJUDVW/DGSivWVEjHBBiBQIHEL3uUR/dl+JyUKfjtCfn5
	 dQ5uqMFaqzOq+TEePEQZlEQGghLwWpWcIuW/3U+7+UZ3Dm3lci9Ax96WY99fJL6RNL
	 16qAMgv+jJQIQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7609F17E0FE5;
	Wed, 19 Feb 2025 13:22:09 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: heikki.krogerus@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	andre.draszik@linaro.org,
	angelogioacchino.delregno@collabora.com,
	linux@roeck-us.net,
	shufan_lee@richtek.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v2 0/2] MediaTek MT8188 MTU3 USB and Genio 510/700 TypeC
Date: Wed, 19 Feb 2025 13:22:04 +0100
Message-ID: <20250219122206.46695-1-angelogioacchino.delregno@collabora.com>
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


AngeloGioacchino Del Regno (2):
  arm64: dts: mediatek: mt8188: Add MTU3 nodes and correctly describe
    USB
  arm64: dts: mediatek: mt8390-genio: Add USB, TypeC Controller, MUX

 .../boot/dts/mediatek/mt8188-geralt.dtsi      |  18 ++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 121 +++++++++-----
 .../dts/mediatek/mt8390-genio-common.dtsi     | 155 +++++++++++++++++-
 3 files changed, 251 insertions(+), 43 deletions(-)

-- 
2.48.1



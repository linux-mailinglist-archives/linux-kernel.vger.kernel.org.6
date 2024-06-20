Return-Path: <linux-kernel+bounces-222424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133D791014E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E7A281523
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2601A8C2E;
	Thu, 20 Jun 2024 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MCcOWFSZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81EA628;
	Thu, 20 Jun 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878720; cv=none; b=RC+wrQ0shvoViVBz+99n+6s8JMzT2iH2Hu0OxjXXy6n4Y5J/rBtiDYT94hNm+miswhg6aMKybAKQePkLmS2pVxf+rY0e9faQ7GuzW0QFK+glICxDulf6g0oyhVIC1pPZvmmtNuLMAmzD/Nl7ky2twNerax1ih61jXwXSBU8PoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878720; c=relaxed/simple;
	bh=Zg0YfAACgdrWSFtjmdDAqVwctljVdRiqv1hto8U66Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgLzJKsbVmJfp8YuuASnGsNit64XIRtm8qAfH/t1H7Wb7JogOqMZag98DziDKhxfMQprsI6etjSDvMjI3Ph8qzbhYZaJ2dbOMmOdMnakMSQ8jHmmntwuEXzw1iFmT1y79zRhZHKN7qknroOpMG3/8Nz/QtWieK+7vKDm+RwKc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MCcOWFSZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718878717;
	bh=Zg0YfAACgdrWSFtjmdDAqVwctljVdRiqv1hto8U66Js=;
	h=From:To:Cc:Subject:Date:From;
	b=MCcOWFSZtRC/nGssgzuL9+vtEsZO205TCcH/IizeBSI+6a1flCdLrrt5Aq/rAgSDU
	 amAovpdN8LKEmOOosc+1DCkiPxRli4OCmks7JHdrU73bgHaBwnF0Fmvw4yG3oaBqNc
	 vQtOJ+il1GezkNkqAUwfi6laIHgHDEYieeEzOXIcC1k0BJ55tsnIMYTWpFIXTIxVdK
	 nI4Bqh4Z94JqnA9Gq9RC+qZewhia7IgsES7vmgntUYLHR0/EGsB/kTJS5bNlTS+PhP
	 BpBJRcgNTufTF33f0zX10rVHsYlllXUsCqOxYPPVAuQQ0nsCWP3uNcxMFNCQcK4zPK
	 +1LchlOq/szMg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 793E33780698;
	Thu, 20 Jun 2024 10:18:36 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH] arm64: dts: mediatek: Makefile: Generate symbols for DTBO support
Date: Thu, 20 Jun 2024 12:18:30 +0200
Message-ID: <20240620101830.1097548-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DTC_FLAGS '-@' for mt7986a-bananapi-bpi-r3 and -mini to
instruct the devicetree compiler to enable generation of symbols.

This allows proper support for Device Tree Overlay(s) for those
boards; future boards that need DTBO support are expected to add
their own DTC_FLAGS_{dtb-name}.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 56d551da917e..5dbb695d053f 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -84,3 +84,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-kontron-3-5-sbc-i1200.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
+
+# Device tree overlays support
+DTC_FLAGS_mt7986a-bananapi-bpi-r3 := -@
+DTC_FLAGS_mt7986a-bananapi-bpi-r3-mini := -@
-- 
2.45.2



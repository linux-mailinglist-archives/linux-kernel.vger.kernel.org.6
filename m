Return-Path: <linux-kernel+bounces-510867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2279FA32301
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F2A16274D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656DA208961;
	Wed, 12 Feb 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mNP2xFoN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B01FC11A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354423; cv=none; b=tHzAUJQbiqnNgVGbxEC8FoBjeMmVrCEQ3CUf65UsWpnYNVvVQwVFtJcZbwUbCBLSZPag4tcyBQs0sRuWqgNZbncBiHaGC2QHUR1RYtVUNy5/IhO1oUAMS+ie4ccBqDsJmJPjkthOCdfUKgUsTit2a4Fk82gADJDRO4tP+AeSvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354423; c=relaxed/simple;
	bh=4OBZG7uX/8CsjJnTc/XKtHc+h4pbWEM3iLpBrSk7XGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeRJHrzsexmfkCW/NulirgNIAOOGnMn+HKEmKufrbBJK7GJGbXPVSeW7WlvBOoQo+CTjp0cJMBz/NeXGuI+LD70PGIionj5Rt9N8U0WiEFMkdDL0HvbArqXEfYPi0/ouyXCwbh4lIz8pB2aMLvimrR5jbxYTZ06ddnO/07hvsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mNP2xFoN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739354420;
	bh=4OBZG7uX/8CsjJnTc/XKtHc+h4pbWEM3iLpBrSk7XGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNP2xFoNXIDZ7NNXdzVu7NRA4380M6RigKXK+u401dsLvBr+ubh0hYGfQqMGB3jBW
	 cGsndad8GZZ43KSuv05hI/rIl1TEs7ZqfCy81jLQ9G8w+IbfMPGdOzUZWVT7qYbO3o
	 TH1Cr3Rf0Qt7vVtIiFpzb85NSHDx6IdcxL2k+W0Cb4iydppLdZN2lmkjYpIQvJsRrA
	 79dPOXNi3496vj6M/NyPRqtTkypqVwn8YjsBJlLZWljnzlaCwnq+uKZquteTzpQV38
	 wE+D6EtbCF0uvBNwYbAHuLf6UhJ/JC+c1sPLszRkNByTclR0yQ/bHChyl5mct0tXXd
	 A4Nwbq2ons27g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A648717E154E;
	Wed, 12 Feb 2025 11:00:19 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	shawn.sung@mediatek.com,
	fparent@baylibre.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	pablo.sun@mediatek.com,
	kernel@collabora.com
Subject: [PATCH v1 3/8] soc: mediatek: mtk-mmsys: Add compile time check for mmsys routes
Date: Wed, 12 Feb 2025 11:00:07 +0100
Message-ID: <20250212100012.33001-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212100012.33001-1-angelogioacchino.delregno@collabora.com>
References: <20250212100012.33001-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every MediaTek SoC with multimedia capabilities has an array of
structure mtk_mmsys_routes that defines a multimedia connection
between hardware components.

This connection is activated by writing a (masked) value in each
specific register, and the association between from->to path and
value to write is expressed as an entry in that array.

Failing to set the right path does not give any meaningful error
and makes things to simply not work as the data will either not
be retrieved from the right input port, or will be written to
the wrong output port (or both): since a misconfiguration may
effectively still be a possibly correct configuration at the HW
level, this may be only giving side effects in terms of simply
getting no functionality but, again, no errors.

In order to reduce room for mistakes in declarations of the
mmsys routes, add a macro that compile-time checks that the
provided value does at least fit in the register mask.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mmsys.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
index d370192737ca..d5f6fbdc6f72 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -80,6 +80,20 @@
 
 #define MMSYS_RST_NR(bank, bit) (((bank) * 32) + (bit))
 
+/*
+ * This macro adds a compile time check to make sure that the in/out
+ * selection bit(s) fit in the register mask, similar to bitfield
+ * macros, but this does not transform the value.
+ */
+#define MMSYS_ROUTE(from, to, reg_addr, reg_mask, selection)		\
+	{ DDP_COMPONENT_##from, DDP_COMPONENT_##to, reg_addr, reg_mask,	\
+	  (__BUILD_BUG_ON_ZERO_MSG((reg_mask) == 0, "Invalid mask") +	\
+	   __BUILD_BUG_ON_ZERO_MSG(~(reg_mask) & (selection),		\
+				   #selection " does not fit in "	\
+				   #reg_mask) +				\
+	   (selection))							\
+	}
+
 struct mtk_mmsys_routes {
 	u32 from_comp;
 	u32 to_comp;
-- 
2.48.1



Return-Path: <linux-kernel+bounces-190358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB5C8CFD3F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB348282985
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2C013C81B;
	Mon, 27 May 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qe8BeP9Z"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82913AD3E;
	Mon, 27 May 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802758; cv=none; b=gh4SjMjMQK/ImdGx/eQ9LLR4O8ocdpoOWZcXB3AxPop/ugRu4g167PtAECiCHEgTowdssGs259dYCyvbUC2pm970ViG2iZaduxf0+y2djw0vlBrqlNHIA0dj0qy4jPUN2y253ENL/INdISOaJZsNOPjahXmkIJcgFqMWSJPwvxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802758; c=relaxed/simple;
	bh=OiPBAFsu0z+fLHyKUPGOZVRQqVDS03RDPW95gydTYUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svbUmmU/QmGRwDcggNcO9b6qC8P4GZh/0XkzNySu+4BxIbOhzVSnrQBP/j+ZuLUK/hD4BROSQxMsFVeIXK2j801Hl/G7oNHOeiCvkJRc4xYtR/oNs5W645YnSQjLg9aKX4FF/BDkn7gatvZEkw6MXpaorJS5gfrJuUAabq1TNDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qe8BeP9Z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716802755;
	bh=OiPBAFsu0z+fLHyKUPGOZVRQqVDS03RDPW95gydTYUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qe8BeP9Z5JJLAQoxQykrmznc8aBQZesyg1HM/YgTqwUcst8/PhQ7I7odtQoXtMsj4
	 qDxi8Nk8jM+DkkrXIkbWRhKq1S9d2JhoeKidroGU9mEn956Y72uEEx7R8HaOYCEBaq
	 oyShpxJ4xtqV4mmoCpA7Ougqcr4c23yXOYQANU52B/uTr+doxsLyAmvBvbu6nPgnA7
	 Ikc6qrv+uTQtBrCmFqze+iWJgxxXWC9Ne1fq08hd49+tldwGJo1d9LVE8qwD565Zcd
	 Lyf5zhkBgCurLFWodNdus1+7UOVU1Mc9oiXIcCR+C3F9ZvmqhaDjWmEPCX6fV5zQAI
	 23fc0X3ySr5Ig==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 29CCA378212E;
	Mon, 27 May 2024 09:39:14 +0000 (UTC)
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
Subject: [PATCH 3/5] arm64: dts: mediatek: mt8188: Add VDOSYS0/1 support for multimedia
Date: Mon, 27 May 2024 11:39:06 +0200
Message-ID: <20240527093908.97574-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
References: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the two VDOSYS blocks in MT8188, later on used for
various Multimedia related IP, including display and video codecs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 06fa3b862c31..84f2809eae7a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -969,5 +969,22 @@ vencsys: clock-controller@1a000000 {
 			reg = <0 0x1a000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		vdosys0: syscon@1c01d000 {
+			compatible = "mediatek,mt8188-vdosys0", "syscon";
+			reg = <0 0x1c01d000 0 0x1000>;
+			#clock-cells = <1>;
+			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c01XXXX 0xd000 0x1000>;
+		};
+
+		vdosys1: syscon@1c100000 {
+			compatible = "mediatek,mt8188-vdosys1", "syscon";
+			reg = <0 0x1c100000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			mboxes = <&gce0 1 CMDQ_THR_PRIO_4>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0 0x1000>;
+		};
 	};
 };
-- 
2.45.1



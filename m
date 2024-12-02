Return-Path: <linux-kernel+bounces-427503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34449E022B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC1D169B46
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB03220127C;
	Mon,  2 Dec 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="HGN9OKkq"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A31FF5F7;
	Mon,  2 Dec 2024 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142379; cv=none; b=dOYgr5YT2FuGIOkxNUrWXE6VgWXs6Cm36wf5OGeSbiDQnpSDEAV7hQmf12UQjTDBZ9IA4PkRNyZUo5CN8EyFpCkFeyxSu1HlfsxyP4TrgBSAasiSmlh7QKHAWcrfry+l+wuWWItFk4pAszeKXQVzOTxw/Xzx90xUUu81wJdBqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142379; c=relaxed/simple;
	bh=ceRNp10MFyCq9mQX22uiOcqupE+k+0+DQzA3QUDjNJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2ZgRuA0f2p3B6gTpORuG53QaYgMfe21lWe7LQO1wIwD3/Kz21WNP5fLphQWuf6CTqQ00KGZyw6SB4WAUCFKRQzBdQWE4P1JwtR2z3RbqD91dGWxxR4s1GCJBjodKtFBcvqoRjiAnFGhSgovQgkpAKgA8A89ZiiElZVhPQGfWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=HGN9OKkq; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout4.routing.net (Postfix) with ESMTP id 65890100942;
	Mon,  2 Dec 2024 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0EXR8idz0jZrwTu0ZraBXOMpYUYvi61Qv1pOwi0q8Gg=;
	b=HGN9OKkq8JcXImEOs12P13y6OgcjkFsko0M1iTj+P6S4LgrTTzkSE5wZVhGODvNAKVXdOR
	D/HRrkc9iq45tvyTLCwsJmBUoiXBf4ueeXUE4XcpBNVv1OicHwvLPOgT9BZVHDsNDjrevw
	E9K5C7jwavloYxl2bsA3q02Xe1K0SB0=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id CF8D0360188;
	Mon,  2 Dec 2024 12:26:13 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 07/18] arm64: dts: mediatek: mt7988: add reserved memory
Date: Mon,  2 Dec 2024 13:25:48 +0100
Message-ID: <20241202122602.30734-8-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202122602.30734-1-linux@fw-web.de>
References: <20241202122602.30734-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: d44b10d0-8dcf-40cb-8484-051ea16b9861

From: Frank Wunderlich <frank-w@public-files.de>

Add memory range handled by ATF to not be touched by linux kernel.
ATF is SoC specific and not board-specific so add it to mt7988.dtsi.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 09dcb39ad098..1cf801486e61 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -63,6 +63,18 @@ psci {
 		method = "smc";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 320 KiB reserved for ARM Trusted Firmware (BL31 and BL32) */
+		secmon_reserved: secmon@43000000 {
+			reg = <0 0x43000000 0 0x50000>;
+			no-map;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		ranges;
-- 
2.43.0



Return-Path: <linux-kernel+bounces-525365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A609DA3EF10
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B4B7A33FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A226201249;
	Fri, 21 Feb 2025 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DaeFTekZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDB433BE;
	Fri, 21 Feb 2025 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127838; cv=none; b=pbJegqE+0Oc9/dDdFwbLfyb6IkHiBoDX0KvisOlD/HlSKcGY4RGWJHSgkMrG7s6fz+gXmPBgVJmApY16Z6G6hmUAZXqF5Agz8kSz7nTfCtRRbcmFWZjTQ2a0Sm0I8CdsVZIcP7gAXNjQgypZe6MPWZXgHE8d9dOuTKULWRDbot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127838; c=relaxed/simple;
	bh=kAmfHxvkLgWR7k83UqfnKWY4sjAmD73vzTZvLCcH7uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a15wxvaj4P4nynQfVj30/FTC+yUSYnzLy+8tF7gQBYYvIe77CSeYnOG87Q86/BYGHRSvSbePRN/e3cY9ctUrEm55LlqUIr7Kj8jtGZ9eOgGS/kmHEIAuxVk6H09A+s3JxNIFAQVy5xxkOjovT/eNpimURnrRAwmkKDx168pqQtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DaeFTekZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740127834;
	bh=kAmfHxvkLgWR7k83UqfnKWY4sjAmD73vzTZvLCcH7uk=;
	h=From:Date:Subject:To:Cc:From;
	b=DaeFTekZoGfEbfMsEmBjPUJb9hcbPpHtowUG65h3wbXAiKimBIoQO03IT7OhsNFG2
	 pJzxCvCbnhl4dy7/EGUi9KYz4Y0UrQMMkdeobuyc4UUEFE0iS1Yv4/fw3EYr2BOrOp
	 tTlfdkGcaSvhJzj7AO8IS6B+9lphoU1spy2jfjha4sMwTWOPLLxZWZrXKiXYuc2iqR
	 W/JRn8uMRdyMAMINLdBA9CAO9tpaSjezK0T9hYXlybfBtgdZpG3evA91oxIoAhyCEH
	 WO7CcsaaX3s9FKn1gI/fKNHtjtRQwmtd5pIOBk3egeZbAnf9YOSKIJBbJQVjvINAiu
	 lyBrcMTBNaVUg==
Received: from yukiji.home (lfbn-tou-1-1147-231.w90-76.abo.wanadoo.fr [90.76.208.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 95D6817E09C0;
	Fri, 21 Feb 2025 09:50:33 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 21 Feb 2025 09:49:52 +0100
Subject: [PATCH] arm64: dts: mediatek: mt8390-genio-common: Fix duplicated
 regulator name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-fix-mtk8390-genio-common-dup-regulator-name-v1-1-92f7b9f7a414@collabora.com>
X-B4-Tracking: v=1; b=H4sIAC8+uGcC/zWNQQ6CMBREr0L+2p/UqkG4imFRYMAfbYttMSSEu
 9tAXL5J5r2VIoIgUl2sFPCVKN5lOJ8K6p7GjWDpM5NW+qa0VjzIwja97pdK8QgnnjtvrXfczxM
 HjPPbJB/YGQs2qr0OKFEqVJSNU0C+77VHc3DAZ87RdIzUmohdKKkuHJbE/zA12/YDjFHiva4AA
 AA=
X-Change-ID: 20250220-fix-mtk8390-genio-common-dup-regulator-name-a0b4fe7e70e9
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740127833; l=1267;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=kAmfHxvkLgWR7k83UqfnKWY4sjAmD73vzTZvLCcH7uk=;
 b=wzn19VohCl90bGUdg4UQ1oIyYlM5PwUBAb5LDiLwlAbpmH9TnJvIQOtiV3Ton8dFgAR/58mNV
 253Axf747UuCgLwhypEmgukFtH9uxklEZOBVvTHsv/7lf08qVan9/6R
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

usb_p2_vbus regulator has the same regulator-name property value as
sdio_fixed_3v3, so change it to avoid this.

Fixes: a4fd1943bf9b ("arm64: dts: mediatek: mt8390-genio-700-evk: update regulator names")
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index a37cf102a6e928440cc88e7e8fe0225fc28ec962..e828864433a6f4195944ff67bb7bb4808d1fd262 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -213,7 +213,7 @@ usb_p1_vbus: regulator-8 {
 	/* used by ssusb2 */
 	usb_p2_vbus: regulator-9 {
 		compatible = "regulator-fixed";
-		regulator-name = "wifi_3v3";
+		regulator-name = "vbus_p2";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;

---
base-commit: 964b0ceed00032fa0fa841fd61e5f315880a2d36
change-id: 20250220-fix-mtk8390-genio-common-dup-regulator-name-a0b4fe7e70e9

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>



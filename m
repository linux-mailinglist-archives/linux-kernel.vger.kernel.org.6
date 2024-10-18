Return-Path: <linux-kernel+bounces-371240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D179A3865
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358F7285CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D196C18CBF5;
	Fri, 18 Oct 2024 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j0ke+elu"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A6186616
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239688; cv=none; b=OJ7QbghNTK+uPeesmD2Sv/JR0SCbmazkH5D0ipz32tZz6mQP4+HPFY4RLVu+mZSRwATRJ+C+AVFMclg1uDU6p4sGw3DJOdQj1p72GMvxFsoI89eDtnrrSaq9or971b2rX4+H3kHzzC9kva4vKW3DMLStG0uTimjZrTGnl29squw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239688; c=relaxed/simple;
	bh=+b1cMWRvd2/m165u4jRfl6bdFWmMjC5X8GKJ0se5ktk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMlQBZwrkKxk9ibdm7MZnXW/sY6pyMTVIwSkDZH2GLFgG7hTvr4tS3R44+iZBGXl+ejPVaTyC6V2P66OXb2LD/G+/LENsB/AVYPRnX3jgBkk+2OPBGOwor/xwZIhwWN9uxA48KdB+WQEy7OhsSGvXvfE23weXGGyaqxiu2N83OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j0ke+elu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cbb1cf324so15466445ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729239685; x=1729844485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2sw2cnvD53O5L8zKGOZV5sbNVDe/+IEjxX86rJilqAk=;
        b=j0ke+elu0OGjMHJZKJ1aG2SpcsTrrfMvjw6NL7rEsL1w1LkjZjpPbqxilX2wbkIpk9
         cmJKA0AIrz09fbFyrINYIbETOVEzdm4uYtrS+lOYqoUXC3NEcN4lRUWyH0DnMMg9KXDl
         /xuSsUT4W/LfHHR8PKU5j5UxPqRvbgKUDdLNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239685; x=1729844485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sw2cnvD53O5L8zKGOZV5sbNVDe/+IEjxX86rJilqAk=;
        b=NgAY3FrgmM4cMWvVKZKCSVCDe9li2rzKy3VTiRlo/50gckX5RvAm1TKcq7A050pOnu
         s7qiB07+ITXwk/UGMTdGVWD20pdE2O6Oj64lurKiHOlhrivCJv0uw/l2KPt0BZwqEh6r
         IEJluo6Q2gVjSqWjitwMEVAkbxGeoP8bMk3N9ZhmWiwGazL7URVkWyQmOudsCffQz0bN
         j4bkt+A3WXvLkd/UQ39HpYyVoE541OESIugXrncXi5vwXnsz2sN8OElmodjIcH82eMIz
         VdzH3nUlgL394xJf8PS+3P+XpFTlXcYa0Et42hEP2WHf2SDpV3BHg9J5Sjf0+T22jw1V
         S3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0fXqZFgRo51J0G7SLRHcmvYCzZrN06QfBgNgOgzUKubfiPDyDrNIhkRR+KWri1JnRI6RmpJywMzPEdXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoncd2F3WAW4lDYHD1wmOAU8zwdk3aBJrQOrJ2x4/myADgdwco
	3aMAqLcUwgqAKok4Buv0Ao3dPzgJ2gRREX4LOPvjNK/B0TmKxBCZT4/44lWmow==
X-Google-Smtp-Source: AGHT+IFOJPmAyaUnxkdtc6GJUuyr1a/qUKidE/urORfJ7bfMi/Vu+97DNhgccSxR9H9P6CXOMHrp/w==
X-Received: by 2002:a17:90b:814:b0:2e2:a96c:f00d with SMTP id 98e67ed59e1d1-2e56185d15bmr1863982a91.21.1729239684929;
        Fri, 18 Oct 2024 01:21:24 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:5e77:354e:2385:7baa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55da79303sm1315149a91.52.2024.10.18.01.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:21:24 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: dts: mediatek: mt8186-corsola-voltorb: Merge speaker codec nodes
Date: Fri, 18 Oct 2024 16:21:11 +0800
Message-ID: <20241018082113.1297268-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Voltorb device uses a speaker codec different from the original
Corsola device. When the Voltorb device tree was first added, the new
codec was added as a separate node when it should have just replaced the
existing one.

Merge the two nodes. The only differences are the compatible string and
the GPIO line property name. This keeps the device node path for the
speaker codec the same across the MT8186 Chromebook line. Also rename
the related labels and node names from having rt1019p to speaker codec.

Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This is technically not a fix, but having the same device tree structure
in stable kernels would be more consistent for consumers of the device
tree. Hence the request for a stable backport.

Changes since v1:
- Dropped Fixes tag, since this is technically a cleanup, not a fix
- Rename existing rt1019p related node names and labels to the generic
  "speaker codec" name
---
 .../dts/mediatek/mt8186-corsola-voltorb.dtsi  | 21 +++++--------------
 .../boot/dts/mediatek/mt8186-corsola.dtsi     |  8 +++----
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
index 52ec58128d56..b495a241b443 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
@@ -10,12 +10,6 @@
 
 / {
 	chassis-type = "laptop";
-
-	max98360a: max98360a {
-		compatible = "maxim,max98360a";
-		sdmode-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
-		#sound-dai-cells = <0>;
-	};
 };
 
 &cpu6 {
@@ -59,19 +53,14 @@ &cluster1_opp_15 {
 	opp-hz = /bits/ 64 <2200000000>;
 };
 
-&rt1019p{
-	status = "disabled";
-};
-
 &sound {
 	compatible = "mediatek,mt8186-mt6366-rt5682s-max98360-sound";
-	status = "okay";
+};
 
-	spk-hdmi-playback-dai-link {
-		codec {
-			sound-dai = <&it6505dptx>, <&max98360a>;
-		};
-	};
+&speaker_codec {
+	compatible = "maxim,max98360a";
+	sdmode-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
+	/delete-property/ sdb-gpios;
 };
 
 &spmi {
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index c7580ac1e2d4..cf288fe7a238 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -259,15 +259,15 @@ spk-hdmi-playback-dai-link {
 			mediatek,clk-provider = "cpu";
 			/* RT1019P and IT6505 connected to the same I2S line */
 			codec {
-				sound-dai = <&it6505dptx>, <&rt1019p>;
+				sound-dai = <&it6505dptx>, <&speaker_codec>;
 			};
 		};
 	};
 
-	rt1019p: speaker-codec {
+	speaker_codec: speaker-codec {
 		compatible = "realtek,rt1019p";
 		pinctrl-names = "default";
-		pinctrl-0 = <&rt1019p_pins_default>;
+		pinctrl-0 = <&speaker_codec_pins_default>;
 		#sound-dai-cells = <0>;
 		sdb-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
 	};
@@ -1195,7 +1195,7 @@ pins {
 		};
 	};
 
-	rt1019p_pins_default: rt1019p-default-pins {
+	speaker_codec_pins_default: speaker-codec-default-pins {
 		pins-sdb {
 			pinmux = <PINMUX_GPIO150__FUNC_GPIO150>;
 			output-low;
-- 
2.47.0.rc1.288.g06298d1525-goog



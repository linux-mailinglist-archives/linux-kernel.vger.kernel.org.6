Return-Path: <linux-kernel+bounces-345795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF13398BB38
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18AF282FFD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491DB1C5793;
	Tue,  1 Oct 2024 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M5idW44C"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578EC1C4639
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782302; cv=none; b=UyM74UBeB/qq6yjFcmaKQ00/EjH7oqFlJ+lkOTQu5GKfv109Q6f79SKNyBX+epVTZtMRbnzyVGE2LH4Ry9e8ZW8/gHlxUWl2gIAQP84iINkYOsoy9XRUOFob9NCjKFn1yma767+AqCD0HARATr9UXguGwGdr41ATXBsfrOI7xmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782302; c=relaxed/simple;
	bh=fwOtCEimEWkzwxYD6G3lmyiuERxgKaPU7Rm8N391xIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RH/o5+ofsCG6ViPg2Id6bwXnIUCUy/k1ZsRWHVBLO0Nx/n5zd7DGa5PVuaN/aN7Z1tw/aPuxZ8yLRc1gcizGyM9KDzUqPBOddCi5bJzEuMUPUxeybtRTJNO43TQ0+xOkBAetNTWizTbMuA8g2Ct3g7B3TWeQYCbI+plCmIV4oXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M5idW44C; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-719b17b2da1so3887535b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727782301; x=1728387101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHVpAqtBhTjk/tW32shjLNYqZYBHOi3xkZZdLwrHsZc=;
        b=M5idW44CYepRULenbleAONsG822vcvCEo+D5PgE8ODCdogj3mfdLI5hP6LfBosZPBR
         eV2dQIACY2+q1z4cKEnT1XwhtJWGjH5PS38ojTdf4aos9ayq/Yky4Nieh9kIEtT4oAo+
         S522XYMmxekheApursMPUIZHkhvALPYP4gK5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782301; x=1728387101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHVpAqtBhTjk/tW32shjLNYqZYBHOi3xkZZdLwrHsZc=;
        b=YyYUIRwYN7hgyUP/hryqoxDOAPoo/T5DZ2fiKF/638QXzgHVA4SyGkyUxMVeY3Xixb
         9nx+KRKu+FUS+vIoDZOjABicdYuy9ZSPKa+wJpYWfgnXnCY04YMK2JvtyhU37ND2fR2G
         umwchxn/pzsN1w+V0edSMYLPnl/Kxjgp8ngJ2vOupL+96Ur/7FnFD8dtuOBaYTeOkXLY
         7Q06ZlXTSVnD/Wy5L11NeVw7sgpgoNpLNQ2Qs0+WQZIBVaW+x0OA2rxfa7wKbZ2fBfNW
         yMUZ4k3FpXq7HsRocKTNREU10VHwxANMD/wlI+r+trsHInmFTAtRLAftH8ldM1EvTkug
         5DCA==
X-Forwarded-Encrypted: i=1; AJvYcCUm0Nq5oSmGZNuRtTywWjVrFIo/zr7Lqoy9mRC1fCRU1h1Wu+RrLsRGvixyqLDxb5hbY9YMWMmyMsBADys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVIT+lFmv160lpA8ypQ6DHlJJOtQ7iMgXUvO+xkGn8nUtD5R9
	deKBjda1et9BKoYO6iHyblKwgVN6Hk5Qw4rMsdV4+urshoBIVjeOI1zbz5pm8XdmUsN/zjt6950
	=
X-Google-Smtp-Source: AGHT+IFZ3oUWJS1Sa53CgoaQveyvKTUyDvv6ZPmGhi3kZ/l698r7fpVxnLWRxa7awXLoABaq4SwyfA==
X-Received: by 2002:a05:6a20:1d98:b0:1cf:22d4:3832 with SMTP id adf61e73a8af0-1d4fa64c5admr19196260637.5.1727782300706;
        Tue, 01 Oct 2024 04:31:40 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:e044:f156:126b:d5c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b63d9sm7810646b3a.52.2024.10.01.04.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:31:40 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 8/8] arm64: dts: mediatek: mt8188: Move SPI NOR *-cells properties
Date: Tue,  1 Oct 2024 19:27:26 +0800
Message-ID: <20241001113052.3124869-9-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001113052.3124869-1-fshao@chromium.org>
References: <20241001113052.3124869-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the #address-cells and #size-cells properties from the board dts
to SoC dtsi to be reused by other boards and avoid duplicated lines.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v2:
New patch.

 arch/arm64/boot/dts/mediatek/mt8188-evb.dts | 2 --
 arch/arm64/boot/dts/mediatek/mt8188.dtsi    | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188-evb.dts b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
index 68a82b49f7a3..f89835ac36f3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8188-evb.dts
@@ -140,8 +140,6 @@ &mt6359_vrf12_ldo_reg {
 &nor_flash {
 	pinctrl-names = "default";
 	pinctrl-0 = <&nor_pins_default>;
-	#address-cells = <1>;
-	#size-cells = <0>;
 	status = "okay";
 
 	flash@0 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index ca50ed20fca0..e2c6ed816507 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1618,6 +1618,8 @@ nor_flash: spi@1132c000 {
 			clock-names = "spi", "sf", "axi";
 			assigned-clocks = <&topckgen CLK_TOP_SPINOR>;
 			interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.46.1.824.gd892dcdcdd-goog



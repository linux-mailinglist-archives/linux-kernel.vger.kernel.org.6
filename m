Return-Path: <linux-kernel+bounces-325155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE7F9755A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C05288354
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57AD1A3052;
	Wed, 11 Sep 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Robf0AoI"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E01AAE2E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065328; cv=none; b=MxnrNWO2xDrzr9c0ORlgwRStUmepFsPTIMLi34TQQysUAXQrZ74hI9fRzKezM14c0PBjdo1w0sTPM5Ze56sDLb9fUGw44jvFNY95meq/C4ZRgley9Q2dQPzzw6Ggly6zDCzs0dn8N90y3UfJoOLQkFIMv3AOAXTPjbKU7vvDb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065328; c=relaxed/simple;
	bh=dn3E1OSWDZj5O8mccoBkEq8mmQ/0O63omvmxxrC2FR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYD0627ThhuEghFF6HlKKZjb5oPM/ma55L6/+FayoU4KAYR/gE42UoMXUnSf3foTiX2TSGMOW340Akpz1qVNC6zXnty9QAZHeGWA+TarMUE4Qvho+ByrjB47+9dId1rpg9I8LEVg6QGlRnnzedvwIgcl/XqZ0ayagUrLpIVPf+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Robf0AoI; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e0402a98caso874214b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726065326; x=1726670126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNJmlJuaspo2SJylGvarXYbq/qh4LXZFb+SB568Vu00=;
        b=Robf0AoIXTl6jJ/QFqCHIeG/rKoYFI9rNgQYpbXBwIgIagFH9Q0uSImhc+fCXMBiaH
         wfX3qoqr+Ot0XPb//doLwNarS7fVYUtVxnukdzuCVIw4p/lldnbZlYotZSxS3+bEjGT/
         e7GldmoguuoiDawsxeZnD7hG9zrcV+CvTYK7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726065326; x=1726670126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNJmlJuaspo2SJylGvarXYbq/qh4LXZFb+SB568Vu00=;
        b=ZguZMOdaHOdOIUy6JbyTTRJ9T/dxBAF8HwQ6PJ9M7zM1z3+pRRS7B/lVC8U/8Kyu7p
         nCAIUZvSc94rsURqzbetM2sH0c5Mfy/9KbUkDIXkaNoZHEf98ktyQ16TjDO+FXvtlrFj
         rDRoK5aLM1Zrr3E4rqChE7QfaGkKjhlu0acDRCVssdp+J1NUMTmmk9V4QJdJBKemCIHL
         BSmnjOGnsQP6iIMCApskiWyUus36WFJKljv4UChujubMDebzPjmCUO3uNodUVRMgWgkk
         RwFg4rFqrYn3xaEHbnVpUkmowpzfamuj3F60e/dlTK5Xa2h+qNtxljAxb25k0q+iqYq0
         WvqA==
X-Forwarded-Encrypted: i=1; AJvYcCVzgPFzy1JsykdINoZ03jOdjBl0ZOQbz1eZzveqeDko9a/ndIV0t8lPbUtO1Vk6ABIhsxTmrBB2pN8KU2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHDcBz9+ex6VV7hgWSNZFoN1RLpvwu47hfqyH2J1MPv3nBhOl
	LStYDLS07tyaJZajjjF7wl3eEaYS46SQOIXcOwM3/O+jovS8x2PHUcNhlj1gfg==
X-Google-Smtp-Source: AGHT+IGME0UPIJahehavGen0dgvEatXYyewutMBmDSKHZzczItT4r7tLJ/JhZQ5wOmVfzQENAr9Cgw==
X-Received: by 2002:a05:6870:e416:b0:261:1b66:5ab1 with SMTP id 586e51a60fabf-27c1b5811dcmr2051517fac.21.1726065325607;
        Wed, 11 Sep 2024 07:35:25 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:102f:d738:6069:fd4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5901sm46620a12.24.2024.09.11.07.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:35:24 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 6/8] arm64: dts: mediatek: mt8188: Add SPMI support for PMIC control
Date: Wed, 11 Sep 2024 22:33:59 +0800
Message-ID: <20240911143429.850071-7-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911143429.850071-1-fshao@chromium.org>
References: <20240911143429.850071-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SPMI node for PMIC control on MT8188 SoC.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v3:
- Remove leading zeros in spmi reg size

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 61530f8c5599..a826ca4d10e3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1306,6 +1306,18 @@ pwrap: pwrap@10024000 {
 			clock-names = "spi", "wrap";
 		};
 
+		spmi: spmi@10027000 {
+			compatible = "mediatek,mt8188-spmi", "mediatek,mt8195-spmi";
+			reg = <0 0x10027000 0 0xe00>, <0 0x10029000 0 0x100>;
+			reg-names = "pmif", "spmimst";
+			assigned-clocks = <&topckgen CLK_TOP_SPMI_M_MST>;
+			assigned-clock-parents = <&topckgen CLK_TOP_ULPOSC1_D10>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_PMIC_AP>,
+				 <&infracfg_ao CLK_INFRA_AO_PMIC_TMR>,
+				 <&topckgen CLK_TOP_SPMI_M_MST>;
+			clock-names = "pmif_sys_ck", "pmif_tmr_ck", "spmimst_clk_mux";
+		};
+
 		infra_iommu: iommu@10315000 {
 			compatible = "mediatek,mt8188-iommu-infra";
 			reg = <0 0x10315000 0 0x1000>;
-- 
2.46.0.598.g6f2099f65c-goog



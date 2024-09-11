Return-Path: <linux-kernel+bounces-324731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B369797503B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51513B2438C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A820019C556;
	Wed, 11 Sep 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hhFsnYww"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D428187FEE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051942; cv=none; b=MBc/DD5jMi3Ad0WqgpVp95e0ro11439wWTxqaSqFE0QnePZmLL27mpqxKfCMsX8qsJpGq1XCrDgpSFjTPlRd/YM2xQe7FxB6tcEH0URF7DnmajCobCs6tBmcouStJPs1UWBFUIoamI2/7rHDakC1XOOeHK/rWEtSUwnVYLJ0Ei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051942; c=relaxed/simple;
	bh=KcJWLcKYuSgI36pSaOyN401+9/udRKSn12pXVUl24K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uToKfavmyBfnwCXiwqC8ysPYUofUXnYXfGUvc/98N+XdfQC1MF9fDTwobDdTSOXNTY1mqYydrKKZDwhIPjz9xdlQ182kbXb+JyDa/kTcmqnROVx2RxnOGZZNLtOuPfZa0qAtQGDivv70N/8iNBeIzG74/PuZv0gR5HekYGCYRZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hhFsnYww; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so1499598a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726051939; x=1726656739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HQV01fo8Eazmoun9faxS0xRrGLPbJrswKSNOP5sQk0=;
        b=hhFsnYwwGyr0rcUCPcDu7okifnlAB19SPyKQIbQFXweK348k+uuc/TKGo+ux9UQfB7
         RfEH3+jzXxX1VL34UWeBstCRRg12wv8AgMxz18yRN+ny4RSZVWxVedC/NoPW4eEreq6t
         ahhoCNo31/HLu/qoEzLiPdTru+a9diDVrLofk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051939; x=1726656739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HQV01fo8Eazmoun9faxS0xRrGLPbJrswKSNOP5sQk0=;
        b=MQYhaVrNGk4zdS0BwTHUkTLF0YNi2BuUyULWigmVsu7CSltxycwGN0UbO9HXEm+6dk
         opCgpyv6t9fouAxl/gU77vrOigDCM9O+fFs273uEzOSUcLSxei3Os00nQ2wRjz5o3Z2h
         JTknUT8/97vbw6FHfFg/BL3ZBwqv4S+SkWuXUsIC42msDzP6+8rhEt1P7cq9J6XHSCwh
         FsGIQi+jmjq8pKLqjAuH5ffC+DVOIU+N4sb2apoiT/4Uzw08iJa1QLevYwCLYWioF4K1
         zOJBp5qXYyVIxT+TgeAVcgHndF9rp1dn/xyKhHFc4t8MA5Kz09IkzVjaQ4oj2QnU5pZ2
         Ja3w==
X-Forwarded-Encrypted: i=1; AJvYcCX1MBavn+cYb2YBinGZxpIT1E+3FfsfRrP76Pe8GqXqvqeom7uYNTSLVt1+8kz1nsAe29tVMLzYRobF+LE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2H3QMUTWioBVuZWixH4yltJI99mpRT58CdrcwdV9nj856uPYm
	V4Mi4v3bmqjTqZ9N6G7I+OqMaJpJpd5DoxSbmUK+vvQKR86VsoXmNRqD2xWsTA==
X-Google-Smtp-Source: AGHT+IGpIHc7bP/F9Qr9SpWnaJJbLZcEiPMmrVxSgqEtW06qM8RmvMPVCseAMDYizvq7I6rvYfbmIQ==
X-Received: by 2002:a05:6a20:c703:b0:1cf:2357:df1a with SMTP id adf61e73a8af0-1cf62c8d808mr4373257637.10.1726051938654;
        Wed, 11 Sep 2024 03:52:18 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:102f:d738:6069:fd4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8242b3d13sm7147352a12.52.2024.09.11.03.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:52:18 -0700 (PDT)
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
Subject: [PATCH v2 6/8] arm64: dts: mediatek: mt8188: Add SPMI support for PMIC control
Date: Wed, 11 Sep 2024 18:51:11 +0800
Message-ID: <20240911105131.4094027-7-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911105131.4094027-1-fshao@chromium.org>
References: <20240911105131.4094027-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SPMI node for PMIC control on MT8188 SoC.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 61530f8c5599..32e5b7108f6a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1306,6 +1306,18 @@ pwrap: pwrap@10024000 {
 			clock-names = "spi", "wrap";
 		};
 
+		spmi: spmi@10027000 {
+			compatible = "mediatek,mt8188-spmi", "mediatek,mt8195-spmi";
+			reg = <0 0x10027000 0 0x000e00>, <0 0x10029000 0 0x000100>;
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



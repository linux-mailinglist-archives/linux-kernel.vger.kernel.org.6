Return-Path: <linux-kernel+bounces-345794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E003098BB35
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8C91F231A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE181C1AB0;
	Tue,  1 Oct 2024 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bvYea0iX"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCEC1C461D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782300; cv=none; b=cBTAhsp2wvbKdQJcJbGOYcvP+avLiygM8frkaqXG4LjprJ7VsiA+vgqPq1WqifSFCOdnDi+3aYBBgjOIaz/xV2lioBTgEq2KSUIlIIamFyVSLOs4RWeAZEKfeT5yo9SEB039qjnNMukKfP9OC6Z90N0fDvzgLyoXtxR4t7KWvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782300; c=relaxed/simple;
	bh=ncaWv5MvjPC1QpMqdPg7gTy452mZzJoZ6cXt6xZrLQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EADDueBXEVauB0rE5bgfPLSUdGobnd8CGoLa4ntBw++RL5qjpfghERzKYY8zIhYgLhI+osNpTD+QEhFpp+fszdiwpoBpDR85umZJMCplQLx4ZcmyGIzuM0K1gBLODEgczUJhlp1goMhi5GEX0sFeD9RRg+C/5E8Xw9Y/DAQi8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bvYea0iX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71788bfe60eso3991234b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727782298; x=1728387098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8fXwFowiSq282GBggx76buGJQF3HVDXJm077wJTisA=;
        b=bvYea0iXS/pJMcGl63fBHVlSO/hv8A1EjyJshG/WdeNRFpr3n0F9/4HYb9Srwb1aDW
         9258fHLl0GirO1/o4JxJNf6pS1P749Jd2U3X0TNWtvxjpcCtQEahA9rVzJuH4kKEvgm0
         gBFRvA2TT58W8LMd25iSZxAqwt59lyqwZcMrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782298; x=1728387098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8fXwFowiSq282GBggx76buGJQF3HVDXJm077wJTisA=;
        b=e0NO3L48fb+iJzQ6+gFIPGR85E/ZEJ2ME94iOX/gSKXRP5b3Z2K67skGjQYzhHCllK
         RNEYPrKyKItmzV2mIWdvJu7tPi+Q6r4x3nKwS7n2e+fg4yUsl3iJrAxlZsQmA1Hg+zXl
         NrBcOLbHD2QZR9sOiLxQncgcYkmmRX1noVUvjE/a78s58IeIPzn5RGQRgc/S/8zL/++Z
         Y+TSrVXvuathAyA9Os+DtCjEPuMnsAqrb7TeUfm5QAadIS9zFzj7tJ9CrDbDJO4za9u1
         WmbIZC0c8Jnjt+hMFobK3ElYvl7EoN9DiOG1n+YkSDDnfNTNSbcUZ7ZbLqsBHS3hbm8t
         asFw==
X-Forwarded-Encrypted: i=1; AJvYcCWd+MovNnmTKG4rc+uVSaouiJTfLXxQ1bRDhBlDYtoXwpU18M3qrv3hK9aymC2qikXUbGtTjEKVyITxthk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1HxjkSc7XwMJP8iFMm83gaILVs+Uxt1Zrb8RrZC8mfnlUzuqE
	MPnRcY6BNuHHKzQfH7eb9W6PRyVPn+s1ABfJ5PRdMBdlE7Nxh38GNHZKpa6FMA==
X-Google-Smtp-Source: AGHT+IH09z3QCZ1p0pTjFjuPslZ4C1g3IxE08k1hiNGnKInQp2WoOjwX15K0+Vnyd5cLS3+99kg5ug==
X-Received: by 2002:a05:6a00:17a9:b0:70d:2fb5:f996 with SMTP id d2e1a72fcca58-71b25f451e7mr23221279b3a.11.1727782298034;
        Tue, 01 Oct 2024 04:31:38 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:e044:f156:126b:d5c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b63d9sm7810646b3a.52.2024.10.01.04.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:31:37 -0700 (PDT)
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
Subject: [PATCH v2 7/8] arm64: dts: mediatek: mt8188: Move vdec1 power domain under vdec0
Date: Tue,  1 Oct 2024 19:27:25 +0800
Message-ID: <20241001113052.3124869-8-fshao@chromium.org>
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

The MT8188 video decoder pipeline has two hardware IP blocks: LAT and
Core, which are powered by vdec0 and vdec1 power domains, respectively.

The hardware design includes a dependency between the vdec0 and vdec1
power domains to ensure that Core is powered down before LAT. Without
correctly describing this dependency in DT, the system will fail to
suspend.

As a comparable reference, MT8192 also uses the LAT + Core decoding
pipeline, and it has the correct power domain dependency defined in DT.

Update vdec1 as a sub-domain of vdec0 in MT8188 DT to reflect the
hardware design. Also, use more specific clock names for both power
domains.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v2:
Revise commit message.

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 790315c1bdb3..ca50ed20fca0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1062,20 +1062,22 @@ power-domain@MT8188_POWER_DOMAIN_VPPSYS1 {
 							#power-domain-cells = <0>;
 						};
 
-						power-domain@MT8188_POWER_DOMAIN_VDEC1 {
-							reg = <MT8188_POWER_DOMAIN_VDEC1>;
-							clocks = <&vdecsys CLK_VDEC2_LARB1>;
-							clock-names = "ss-vdec";
-							mediatek,infracfg = <&infracfg_ao>;
-							#power-domain-cells = <0>;
-						};
-
 						power-domain@MT8188_POWER_DOMAIN_VDEC0 {
 							reg = <MT8188_POWER_DOMAIN_VDEC0>;
 							clocks = <&vdecsys_soc CLK_VDEC1_SOC_LARB1>;
-							clock-names = "ss-vdec";
+							clock-names = "ss-vdec1-soc-l1";
 							mediatek,infracfg = <&infracfg_ao>;
-							#power-domain-cells = <0>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#power-domain-cells = <1>;
+
+							power-domain@MT8188_POWER_DOMAIN_VDEC1 {
+								reg = <MT8188_POWER_DOMAIN_VDEC1>;
+								clocks = <&vdecsys CLK_VDEC2_LARB1>;
+								clock-names = "ss-vdec2-l1";
+								mediatek,infracfg = <&infracfg_ao>;
+								#power-domain-cells = <0>;
+							};
 						};
 
 						cam_vcore: power-domain@MT8188_POWER_DOMAIN_CAM_VCORE {
-- 
2.46.1.824.gd892dcdcdd-goog



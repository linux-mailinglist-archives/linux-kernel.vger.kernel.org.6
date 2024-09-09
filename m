Return-Path: <linux-kernel+bounces-321258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF0597167F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6359B23E99
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D91BA279;
	Mon,  9 Sep 2024 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B+ftJDjZ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526781BA278
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880698; cv=none; b=RR5pV5hYJUHhgO1FYyfNiklR5Jcl4l9fsnb2M9q4wbtZqv1dG+i7vl/8rxZ48emnt3PqbtJfLbQZLkzH1A4T5WBtjlF7etWOHbgTTfCufKzmlvTvEiihzcx0kZhBea/r+0VTWWnNWLGNUpNWkzXOYXtLhHb6ZbWZquQpU2E2sEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880698; c=relaxed/simple;
	bh=jbOwDaqgbnkt1pKGITvcZBnuGOzSlLDXtXaL39hqhZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfBOEMEROd7HoQwPcNRGTLnvv5FOFqgbKIM1ALQxugEXnPackgIZzOFBhMvunaEDAULPZnGCvPTU57YVlwjI2PKAs8eVIasG2MfgF5xcOe9sf/VuIASx6XKHYTtW6ibtueMQMDnpe9YIPyKxk6qgFAeoJ7CvkaN6xKt1MJlY4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B+ftJDjZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-205722ba00cso35107285ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725880696; x=1726485496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckgyamt9fIAy8TE1Yk1YBjU42OpcFXF6RxP0WQ2W6QI=;
        b=B+ftJDjZPxpSJLo+CsZ5xFffmBNCNIXlUF1Cs180JPxYcBjhlr7gXT4H3g9f3JpnqZ
         WtSlxiuIpkd4mFWIQEc+i/2vPVhPQ3dzYcTDKeDUvdNe5ViYf9NpKlLMlAwJDpxOlOUU
         hwCQo4iIudqsIUIQHBs77Hyv3D0qS8pwDb79I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725880696; x=1726485496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckgyamt9fIAy8TE1Yk1YBjU42OpcFXF6RxP0WQ2W6QI=;
        b=iaCx6U3dXWvMQTv42et4GEb8Jj3SCAJZPzt6BV7sdzncnQ+gZr3cATWTDn2OngZSCZ
         9UMN8PvPJB82xxSMLPXy3yMQfre+GFwrgTxEk/05ShtwhGXrvqUtgoZMWCDmuNZMWvhv
         TrILGRZRFeup8s679ETgqtqfglpEqKFrIfGsu1EiPciSQNAbFh71lQ9OrYaOiHOO+vQS
         EF+Sgrm7W1hYP6SpWDsXuDD8amuLUjwQEq5gRXZvbLWSUghEn+cQocqfsxWfWkPBt/XX
         Zp0/tphfeN1x092WYYYyr93ItG0raiQmRzRVUI6jeilaNcgyDER3rb20dBLrtFC2ldF9
         KmQw==
X-Forwarded-Encrypted: i=1; AJvYcCWl4/I2AqFFoFZ+8JGsn+hZ/Rln9TsmvLUG2vjMen7fzpuidOVukaatHVLApGkaazkDskUsiwG94/fZNmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3HtryICEh6S75a43g/sW+gdV7rMAX9wDqhIWMKpZs2cNpcR2s
	eqNzTz75DapsbyuqhpEisVbkXG3m2gKHQhqEqGLgMg0rNw3RoKIdEQly8EKU9drs8QANyNxcLGs
	=
X-Google-Smtp-Source: AGHT+IFRpkGOOqIZHwaCAgwZfgwkno7RZN67aHUXn/a4/ib3Hspbmk92vpL01CBwnX4m3qWy82ITrg==
X-Received: by 2002:a17:902:ea12:b0:207:1826:2f0d with SMTP id d9443c01a7336-20718262f70mr43516725ad.59.1725880696573;
        Mon, 09 Sep 2024 04:18:16 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:6647:6d5f:dd48:8f5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1dc55sm32039745ad.186.2024.09.09.04.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:18:16 -0700 (PDT)
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
Subject: [PATCH 11/13] arm64: dts: mediatek: mt8188: Add SPMI support for PMIC control
Date: Mon,  9 Sep 2024 19:14:24 +0800
Message-ID: <20240909111535.528624-12-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240909111535.528624-1-fshao@chromium.org>
References: <20240909111535.528624-1-fshao@chromium.org>
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

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 4593bc1fb5b7..08f13ccefcfc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1311,6 +1311,18 @@ pwrap: pwrap@10024000 {
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
2.46.0.469.g59c65b2a67-goog



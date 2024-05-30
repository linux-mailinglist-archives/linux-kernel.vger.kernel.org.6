Return-Path: <linux-kernel+bounces-195074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 539098D4742
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838A21C22885
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC681761AE;
	Thu, 30 May 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I64wiQ3U"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86E7176195
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058143; cv=none; b=HkomrTsHjCx550pZBCIm7a4hIx2qYbXNrfNBrhtIevJijcPx7HLnQQItM/kf7vUEcDg/Xkd2BYIA0HyYJwmtIFIskXttTj43fEP33uYuVW+ES29PQ5m9oFixS2OoSIzkF91plDYfRuuQs5qtBwyODK/lKG/z9biw3FJbnedC8MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058143; c=relaxed/simple;
	bh=3sS+9gSsossoY+rGrRHB96KNj3HXC+IUQnbd1IFwUWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWv4ycFV7vIMCUtG3cO/CA2j+c0sEb7Kqvxl2F6J1JD2/5Dq7M43ADIhdhFs/iPVtcZxuVjd26+DS8kxmWJ0ESdoyEZQzBbjdkiVfyAfFGT90jIGRyR2jfCm2h6K9wxfik4H3QYQQVBjbzPuCCrou+byPMOINUYVqNIAytCve7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I64wiQ3U; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-702323ea6b2so332725b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717058141; x=1717662941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3dPYP7w2xcwwD4ezxBwzChfzLxfVatZgNqWhWYFewg=;
        b=I64wiQ3Ub+DvAtsc0QmifTY54MOf3Tm8Q8CG4wE3gJARTBLhbTMb0MU65Rg52+OHDB
         BkrqLi07nIiPIDvle4VjDFDyrhhmGb7PoUJXZueHZyQngQh280nL1dG1svOKqKjC9K5/
         qIyPxBruLj61waIabnYZlKTUG3PELMCspqlus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717058141; x=1717662941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3dPYP7w2xcwwD4ezxBwzChfzLxfVatZgNqWhWYFewg=;
        b=gqbPdpuTPwRE3f+hq3Zyr8SukUuxsujNUCjvOpYG7Wz9+NKUwepVe+sqRzlclZHa5Y
         +j0pb8VgxOSw4CuMKQ1r+64DEr6zKPOnCBs5rKhek3pbssPUTeS8IfhSeiSY4BfgxDc8
         HIptxcf2dCqhFHMhmbPHKWpdk4swd+PNXLd7eFFvUobZqnrTgfBzWGbOlYfIkXKtmijD
         LOJaQXPUEk7dCkmnfD6noIZocpUTp18DBOSZEFX2xBmb0/8UYxxRrtGev6avwKQwu1Sy
         7qV7Fa6P6Mq0XIpqym50oqILqD+7wai3p6Z6Xf5pHkPzT+/reQXUgQZeG6SimjoxU2o9
         /EsA==
X-Forwarded-Encrypted: i=1; AJvYcCVbrLB9hzxyOvWi7nUVpDhdHBj36xpQHBfiOB46BlH3Rp2XplF9/C8tN+sG6tvAzWOctXCmLEHG5zd1NJsob4enntOvrt+8j2XvNmBP
X-Gm-Message-State: AOJu0YyTqmaazlEfkMy7/l53KxkeoA7GR3UnvdE3jVxSA2UKZ+a+t8UR
	gnf7c0qKuMCoZNFFXDZ6YreK6LBwSAVD34uMrpHMP2b7/pnXUFSiriIiDGJDLg==
X-Google-Smtp-Source: AGHT+IFl9n7DktKEcpEJ4WGQz7AcjFouxFiRzMPk6dDKBcDqPpXqbxbt5Utw0hXKMF4XUXofIeg46w==
X-Received: by 2002:a05:6a21:99a3:b0:1b1:ec17:e59c with SMTP id adf61e73a8af0-1b264618a95mr1679425637.61.1717058141165;
        Thu, 30 May 2024 01:35:41 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:65f0:63a9:90bb:50b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f617390fe7sm10950635ad.146.2024.05.30.01.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:35:40 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: mediatek: mt8173: Add GPU device nodes
Date: Thu, 30 May 2024 16:35:05 +0800
Message-ID: <20240530083513.4135052-7-wenst@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240530083513.4135052-1-wenst@chromium.org>
References: <20240530083513.4135052-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is part
of the Series6XT, another variation of the Rogue family of GPUs.

On top of the GPU is a glue layer that handles some clock and power
signals.

Add device nodes for both.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 136b28f80cc2..3d7b9cc20a16 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -993,6 +993,30 @@ u2port1: usb-phy@11291000 {
 			};
 		};
 
+		gpu: gpu@13000000 {
+			compatible = "mediatek,mt8173-gpu", "img,powervr-6xt";
+			reg = <0 0x13000000 0 0x10000>;
+			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&mfgtop CLK_MFG_G3D>,
+				 <&mfgtop CLK_MFG_MEM>,
+				 <&mfgtop CLK_MFG_AXI>;
+			clock-names = "core", "mem", "sys";
+			power-domains = <&mfgtop>;
+		};
+
+		mfgtop: clock-controller@13fff000 {
+			compatible = "mediatek,mt8173-mfgtop";
+			reg = <0 0x13fff000 0 0x1000>;
+			clocks = <&topckgen CLK_TOP_AXI_MFG_IN_SEL>,
+				 <&topckgen CLK_TOP_MEM_MFG_IN_SEL>,
+				 <&topckgen CLK_TOP_MFG_SEL>,
+				 <&clk26m>;
+			clock-names = "sys", "mem", "core", "clk26m";
+			power-domains = <&spm MT8173_POWER_DOMAIN_MFG>;
+			#clock-cells = <1>;
+			#power-domain-cells = <0>;
+		};
+
 		mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8173-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
-- 
2.45.1.288.g0e0cd299f1-goog



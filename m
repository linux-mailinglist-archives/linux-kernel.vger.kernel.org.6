Return-Path: <linux-kernel+bounces-368865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 190C79A15D4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35B11F23383
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035B81D2B13;
	Wed, 16 Oct 2024 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bCuRDeju"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D71D279F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729118000; cv=none; b=Iwz9NqZQiNGS138xQ8E9f24pJpSSD95QIR7Z080qHhfqBSJOUO0gyjJ/8hz4gtAzmRXqWUNEwhRhDxGv876BwywZ6QT73fLaz+mpqNFXv4koMq2IaG41y7Yp5ckAnQP2C3zQAb5nDwJhpO5fttPuHOR560h0v4liAoNEgIPfLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729118000; c=relaxed/simple;
	bh=cLG4XkYYJQpRf4RufsTgHDLiu0qatuItEKjSjDpDctI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PkYacbmU6AYWaGY6MIWkKNM6jDKG6PTEzpnKBCmF+dmo8imKbBZHmc4NLg/S1OGjBkmGCfSsQBPqaVLf58DEFjRfqbwtvkEqv0rhl7ODplg/a8jKstw0bBk8VQcT/YXST+lAiLbSxip+RDyGXujePsy+qxx0j+ufs8eXX/ClDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bCuRDeju; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c7edf2872so11597945ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729117998; x=1729722798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0Sh3029V3MK51x11tytW0IURI4Fv8hVCwwtjTn58GU=;
        b=bCuRDejuvh4LNc7X2LKScpj9EdmgXVk+DrYCREYaB0D+9j4TUk5f/L357JS8uSR0Mj
         bEmaQXigP/6VYMgziOoQrtgOMa1JgUt1MLcz/Z25UNRVOmNpMpVzPzuOQmFX/nu1/P3G
         ej8oso+MBBRzUim6BMo6o+CzPqlD8uNYGf1Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729117998; x=1729722798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0Sh3029V3MK51x11tytW0IURI4Fv8hVCwwtjTn58GU=;
        b=w+dXEJb9cJFodb18U62GdR1+aol+pnNmoYe1Z2PCAd/ot6coADH7nmmiqfk5mTlr9E
         d/2+eCZSgjswXqPTRkmMw6UqDQniIgmZZnH54bViWAFEq8GRXa5p4Q11MUgHxPM3Y3LS
         19DOMzOf6mvn7bOhdooTUevxZBr36YO5lpB1JSfGpzADPGKjT6kbc+oRrarNXSYQ+9xm
         ubfYNJju4LVIQsJIxz8uE7rSbrqu2g9rbFf4JWs5CCfkhCsDov7e/9bb0Yc5nOp45mOz
         l/SLGgSeHu+dLZEKjQEOSJonrCFRfaz0R8aKXrxZ3mlvEoHHBA1qdYofSg8zqvrmFmQA
         cUTw==
X-Forwarded-Encrypted: i=1; AJvYcCUotFQT1HdIbcTMDkcZ8tiJ1+5CfOoDv7CrF3nkPmnWawQGY40XVZhsswcn6RG25GgVBwkCaSkx1AAEzQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JftfkRWf9c73iPBbK5EPU86RINFOXRPckmzhH6OsyTEWF9aH
	QyL+sFtbjXFTYWYWd3vzXlpZ66SfS1DrTIEszHxtxf038uoGZMk3gWlbL4spbw==
X-Google-Smtp-Source: AGHT+IG0tsd413azSd2z2aQQ6JvNbIUWii6V7rLAFfiINNm/TURRGSMl6gwvfVgmDrvrJ5OSs6C+nw==
X-Received: by 2002:a17:903:181:b0:20c:ceaf:e65f with SMTP id d9443c01a7336-20d4797b143mr15638175ad.25.1729117998315;
        Wed, 16 Oct 2024 15:33:18 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:aab3:ae1c:d5a8:7fba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805b040sm33441645ad.252.2024.10.16.15.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 15:33:18 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jitao Shi <jitao.shi@mediatek.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] arm64: dts: mt8183: Add port node to mt8183.dtsi
Date: Thu, 17 Oct 2024 06:32:52 +0800
Message-ID: <20241016223312.3430051-1-treapking@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the port node to fix the binding schema check. Also update
mt8183-kukui to reference the new port node.

Fixes: 88ec840270e6 ("arm64: dts: mt8183: Add dsi node")
Fixes: 27eaf34df364 ("arm64: dts: mt8183: config dsi node")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 10 +++-------
 arch/arm64/boot/dts/mediatek/mt8183.dtsi       |  4 ++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 07ae3c8e897b..b7b3d8fbf1e0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -280,14 +280,10 @@ panel_in: endpoint {
 			};
 		};
 	};
+};
 
-	ports {
-		port {
-			dsi_out: endpoint {
-				remote-endpoint = <&panel_in>;
-			};
-		};
-	};
+&dsi_out {
+	remote-endpoint = <&panel_in>;
 };
 
 &dpi0 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 1afeeb1155f5..e4899cd6fef1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1834,6 +1834,10 @@ dsi0: dsi@14014000 {
 			resets = <&mmsys MT8183_MMSYS_SW0_RST_B_DISP_DSI0>;
 			phys = <&mipi_tx0>;
 			phy-names = "dphy";
+
+			port {
+				dsi_out: endpoint { };
+			};
 		};
 
 		dpi0: dpi@14015000 {
-- 
2.47.0.rc1.288.g06298d1525-goog



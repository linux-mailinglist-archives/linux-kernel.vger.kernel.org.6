Return-Path: <linux-kernel+bounces-326740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9F976C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE561F247AA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1B51B9B24;
	Thu, 12 Sep 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGKOrdfV"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC21B9843
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152283; cv=none; b=TlKZNhQfINWrFqspZWJwV/2sXx3Y3tUi7xh1HaMReXtNuc1KcWlrWTk8ASQMuw+mfgNkug3B2zx+J7iSotPYcOuNvMlSCBd2lfkxieww3jNwbgP+9Lmmm/+0WNrx5akyiAc4WZnun4hgeocz3kzb3GN2xOG/IazVes4gGwca87w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152283; c=relaxed/simple;
	bh=o0CFMv3zUMlbHLsYeUBPcNq1Mj+k/sjWZCmQYc7SHrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+etntX4yqDFIX9bmCpienFFQ6fS/8gdPZL9yg2CDphES5t5UTS4dJu4JyVAtFm4+Wg3pOUg1F7Wg/pFjiBOG9HxOaOpUYk7ehl/RBk6DA3Zp1vRR6BCxwEl5fXgs9DRG27Ggy6H80jpDnKSzXDkgWMQuvCPDP38iSnro5+8rCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fGKOrdfV; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-27b7a1480bdso497246fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726152281; x=1726757081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBobOyxG7h8nS1KWtk3g4MWOyKZOXk2z2jSGYhG4DTs=;
        b=fGKOrdfVQfrBZZRdimB/4bKTYSrlC3xUDA6GDYucIH8aBcqQzK7GoJyQwVMUoY4/Ye
         2Rthk4Ep2GO8AMNbNI3n+i2OO+9wxJHAQvlbinz6BqqBpTuhiFA4+Di+j5n55wFdwWJX
         TYXmsIOr37p9UcqoP/+TvrZqkyAw6XPnaTeCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152281; x=1726757081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBobOyxG7h8nS1KWtk3g4MWOyKZOXk2z2jSGYhG4DTs=;
        b=K41TztdCTxnyGB8IsSF0IpR5W0XG8rV9XrzWmG+dK88mOsjhtJi5bTVQTCOi7m+qJn
         EX24aSWNGaY5kJ1Nur8StMBtlg4i+zfIFW5ho6daeNKffNCIC1yjzpoWlZ8j3FoDTWcB
         CahNppdLKPqrzgwAlwX1sYtjrjxnRA8fRhaBU+i6Sd7dtiUdwJo+oVi5jRQUmp5Dx/Iz
         pX9FkPULA8gWeaC36i8GDiyVJ2alz/AZfbS7PvSl/RKdFDH8PXFG40aotXsiv+9yYWzv
         Q2dZ5mMyidTtalRBQUFJV1lv2k97pYNYcz0VVhyQaPLMvWcT3xvaTLC6aNOxDj32admz
         R4Eg==
X-Gm-Message-State: AOJu0YxHqdT1dBmO8QkeKVABVPIHIPuoVTXWG5k3EfHProcVOY2005hc
	3hH7k/fQD+3plt+RrxClbPlhy5bxtd4rL6tvw82BK9uXqjgu3uADlG/HKi/rlQ==
X-Google-Smtp-Source: AGHT+IHO/WoJUXlOGm3jql0fNBGLuC2NTWOQUgJ/i3VELhySJR9ptX7aA3pjDFcXYgWO/HiMD6f3fw==
X-Received: by 2002:a05:6871:2b27:b0:277:c21c:8619 with SMTP id 586e51a60fabf-27c3f0e0e6fmr1795567fac.8.1726152280812;
        Thu, 12 Sep 2024 07:44:40 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:8638:897f:b6cd:8c44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fdee186sm1826269a12.85.2024.09.12.07.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:44:40 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>,
	Fabien Parent <fparent@baylibre.com>,
	Jitao shi <jitao.shi@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: display: mediatek: dpi: Add power-domains to the bindings
Date: Thu, 12 Sep 2024 22:43:58 +0800
Message-ID: <20240912144430.3161717-2-treapking@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240912144430.3161717-1-treapking@chromium.org>
References: <20240912144430.3161717-1-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The power-domains property is used by most DT nodes using mediatek,dpi
bindings. Add this to the bindings to fix the schema check error.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 .../bindings/display/mediatek/mediatek,dpi.yaml           | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 5ca7679d5427..7e0bb88f5856 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -42,6 +42,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  power-domains:
+    description:
+      A phandle and PM domain specifier as defined by bindings
+      of the power controller specified by phandle. See
+      Documentation/devicetree/bindings/power/power-domain.yaml for details.
+
   clocks:
     items:
       - description: Pixel Clock
@@ -82,11 +88,13 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/power/mt8173-power.h>
 
     dpi0: dpi@1401d000 {
         compatible = "mediatek,mt8173-dpi";
         reg = <0x1401d000 0x1000>;
         interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
+        power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
         clocks = <&mmsys CLK_MM_DPI_PIXEL>,
              <&mmsys CLK_MM_DPI_ENGINE>,
              <&apmixedsys CLK_APMIXED_TVDPLL>;
-- 
2.46.0.662.g92d0881bb0-goog



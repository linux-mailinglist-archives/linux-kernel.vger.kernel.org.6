Return-Path: <linux-kernel+bounces-534449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F97A46720
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0250B4223A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D36A22371E;
	Wed, 26 Feb 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brKLuFOk"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6770222584;
	Wed, 26 Feb 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588401; cv=none; b=h4Q9UL1XKcMy9RD9jbrOhiyFZqezxCkKmU7HXPHAuq4aO6AvFf86FJJeZL5GSOCBjPLaHXFOZj2VQABzCub7rS3qbufVgIz51OdeJI6OH8lMb3GZuy7NPFpZqkg8LFA2cSSawq/ROrj5rxvLaRfnGvypqo7/xdPS49272xZN8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588401; c=relaxed/simple;
	bh=ORjAe6MoxwYydOUBgswDC+POQ7kq3EukhUnkAloJl6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NlsME71/pNB/0lWIZydCQHyAeRVRA83DND1cOXppvSomKJ6QTVMD/cu4kU0vmWUyYNihVPHKlhzKjIBWF04y5gd3gxVlKjhD9tiMN7UGBNxrldIxYP0M6jB+LEnoZ0+A0XDcJ/xZjqU1nn0tsbSKVLgKjVJzKFwNGtNUNDho9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brKLuFOk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4397dff185fso221475e9.2;
        Wed, 26 Feb 2025 08:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740588398; x=1741193198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1rqUZmbeIGtXPgCTodsmKk6y+OMHLTQEiTCHhSgzVo=;
        b=brKLuFOkomFr9PR1LLHUQjCz4qS8ImD/OTtfWMtKsuCTok0qNY7wyWfAa5lGpThucR
         +TKbxcal3swZSOQLF64qtGoAdWw+JAVHh+pY8Eh2KWrA31bVU+3wIL5aSS1WL7iNHbPG
         fEF5H8arktEVGio8RVQQLlyPqtiqGUX078GWEYlNHEJ3V1bHK1GfSec4SWMwl6qY6ZF9
         WOIsGpWSxXBj/yIqKnQys3GKeBNdmV3M30L7ma8sX+jaPycBwORJm64GWuq3trg9qt8e
         OARo6NNddG2k6LkOMUwBbEzAc70X2LxhkDIoLNN5bNqq7erpDUgY16EDqHEsL5tHPMT4
         ZDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588398; x=1741193198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1rqUZmbeIGtXPgCTodsmKk6y+OMHLTQEiTCHhSgzVo=;
        b=uXwUdqt80fZBysOu1F4hfAyE+ZgjYDld++Og+GfPsIteiQWyb21ABNcedBK+2kRmS3
         MJsDYNmC8jlDmPBThuE/BfJNzcRVYLC0q+PepXIrWIn2dazt/DMneuN7vgxvftH1/ds3
         tMjU1n4f+Z908ZSddmrJ2pYaYeTLIXI1CzgHIO6mk87/NAxitXr9WHfSv/Gons2AMW8u
         nYuL9Rvb6DxonqQf1N+vIYO6zQKKfWfgzQj/yE6vQDAG5zU4X75QliTvMwmWG41kY13F
         A0Ah+se//k4vvhQe/5eMyIyQtqPPjwSBtQjmtTIwWq/2cQt9BOQX7WIvncdi+JGpy5Wn
         I/pA==
X-Forwarded-Encrypted: i=1; AJvYcCV/lTD5GDx+H74xOve4bGTwKJ3EVx27sAZuKoe7rIfXlFkMM09ujwDmg7GcPr9pFrh49iDYsC6mkE7BiYEJ@vger.kernel.org, AJvYcCWeLFJzTHmWxcwvpnmCBROEUkFyW0NpEzbhpwlYImJHIgfloRRJO+1eJ620EAuI5kZQeRyopaH4kK4r@vger.kernel.org, AJvYcCX3HsqDptS7X5h9k+rFd23E8TPFO4Wz7c3c/He+SURjRxcDn/bHazEAWKjLOMvPLVqLJB8fi3waafP7@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwouj5VRCe5qAnQ11gjXEEzLSy2+oMAstomzem1OsiLQD7Pdp
	u80ba0FtLCuoSpgPWN0gWjM7TCYaN9hqehQJvVeXM/PRMQxG6QUYIMCiRQQR
X-Gm-Gg: ASbGnctSAyZusGqWqpdge5F1ygIdThLkdYbJG0mh3DTwxxeeS3VjkyyCfhyo5zqgADD
	CZk+IC5vAaqx1fDEqunU+A+iSsUMKE0sP+v5TYyxhaiGaa1Q8Ol6QQi2O830sl/hA1ktLGEOkgj
	3T94C3yIMDh3vcpJ8XEUhgL4qY9DpsP/ehbTCbPd+hvLRGbwuanhnVw7Wl10xr+sO2Fssb3ZezS
	0/YfNf6Xu5qtDYK2aKQrl+qolOnKaTqfopUCxytajJJFVEzv33uYdkLrbq4dhVwf0mRxPZIUSOR
	75IlxqLl/BhuuF17CwBjfTu1hUesqWWGx3ChpTGIcr5OOBNfKIYlPuqhStl0m77v
X-Google-Smtp-Source: AGHT+IGNO74QcjfvqSxSeJoVAhbgQPoU9My5GWhE+D/oKsm5H8jpS40BGbgcOjeGiCnhRrebp+SqTQ==
X-Received: by 2002:a05:600c:5114:b0:439:8c6d:7ad9 with SMTP id 5b1f17b1804b1-43ab903f62emr35202715e9.31.1740588397807;
        Wed, 26 Feb 2025 08:46:37 -0800 (PST)
Received: from playground.localdomain ([188.25.208.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7165sm6200215f8f.73.2025.02.26.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:46:37 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Adam Ford <aford173@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: clock: imx8mp: add axi clock
Date: Wed, 26 Feb 2025 11:45:10 -0500
Message-Id: <20250226164513.33822-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
References: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Some components of AUDIOMIX (i.e: DSP, OCRAM_A) are clocked by
AUDIO_AXI_CLK_ROOT. Since the AUDIOMIX block control manages the clock
gates for those components, include their root clock in the list of clocks
consumed by the IP.

Fixes: 95a0aa7bb10e ("dt-bindings: clock: imx8mp: Add audiomix block control")
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 .../devicetree/bindings/clock/imx8mp-audiomix.yaml     | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
index 6588a17a7d9a..0272c9527037 100644
--- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
@@ -24,8 +24,8 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 7
-    maxItems: 7
+    minItems: 8
+    maxItems: 8
 
   clock-names:
     items:
@@ -36,6 +36,7 @@ properties:
       - const: sai5
       - const: sai6
       - const: sai7
+      - const: axi
 
   '#clock-cells':
     const: 1
@@ -72,10 +73,11 @@ examples:
                  <&clk IMX8MP_CLK_SAI3>,
                  <&clk IMX8MP_CLK_SAI5>,
                  <&clk IMX8MP_CLK_SAI6>,
-                 <&clk IMX8MP_CLK_SAI7>;
+                 <&clk IMX8MP_CLK_SAI7>,
+                 <&clk IMX8MP_CLK_AUDIO_AXI_ROOT>;
         clock-names = "ahb",
                       "sai1", "sai2", "sai3",
-                      "sai5", "sai6", "sai7";
+                      "sai5", "sai6", "sai7", "axi";
         power-domains = <&pgc_audio>;
     };
 
-- 
2.34.1



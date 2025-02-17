Return-Path: <linux-kernel+bounces-518120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4127A38A34
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF231712AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EC0227580;
	Mon, 17 Feb 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ3MrQA8"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47223226894;
	Mon, 17 Feb 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811648; cv=none; b=AjjW3PiQnjf2/cnnUDmaK+LfEny6vA637AiIWgb1TLGvp2Smqud1z2UVkr3uiUfk2mAyiIG+jCjcFzWgwhPeQ4+uQKOTLbbzx+Pd3H3FkS6eEB+FUVBGgEuuOXuFeNzU1y5uqx/6OtCMa0YdgE1LSbzt4S5VIB89EWKT9y6j15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811648; c=relaxed/simple;
	bh=yDSPeTXboEdRS8x7d2A8N+8BHRSpjjkkT3cyeJcrnlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FiX8igBPF51A92zKMZULXx0JFPxxJJnsgTlHdV+DSxq/0apvgKQuOnGfqksdFUkE5YSA4YJWbkQCTUXespovqf3LzrJ0fJdt+LA0IZYNoR9j08HI7252JYU6kQcdy8Lrs6vp016Rr/pdtkRJXI/SInRm8MKA0s/frC8Z4x1+C0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ3MrQA8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb97e15bcbso221880366b.0;
        Mon, 17 Feb 2025 09:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739811645; x=1740416445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrtKLikUl3VDuLA5KThNUpjO2Vam386mSG/zowIweFg=;
        b=NQ3MrQA80Q22ogH12ZFoAVEjJvjLoLvAWVDwAPEOmrNKxNdL23ryLKy/pb7Ors1Wsa
         4id5TSau5vpBaeHI5WOHbMQrgt4gwYZo+T55K9QXWDBrdJuHVM2S5L9UJYwTSOenC8JE
         cNPTyurICo3frBKX/lLsQzhIF8dUVmnTpMzTMoOp8OjVOSclXzN/0S1Pe2RzYzmwelBq
         Nn68Ek38isPShQwhsVW8By8zTwNuasP+yvyAZvttIQOCkrWI2hFqlhvo5q7AdCmp0iA2
         zkrHf+EJqo72UjB7ydx78f9blz9x/0wBSPdi8j7xmJnStns01NdcLWGBrAVk+orXE7uS
         +DDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811645; x=1740416445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrtKLikUl3VDuLA5KThNUpjO2Vam386mSG/zowIweFg=;
        b=YPyBL5xgj0od0s7a/zG8SqoqNAjuW/CL9JFBG6M7PVjPD0zhOeGtp6rbWMy1RIRWL3
         tl/yWgE2cobzJ4JOKRaM4vgJFz0DT7UBroDBvmhuzDjBUYl8nnXtG8ZJ3+rdS6DS9dIk
         ehRtFBl8dk1uXvVgeuzn/GdX3A/lfKxQIQv/0HnqTOjdVT5k8NIF3YOUmD+4dprlInt9
         NFgn0N/looIj3stlNtR+VkbexFEWWXVPinBIiNVWsETP6rUVbbKgB6iBKI2eGZk8HYr9
         Mvz4zLfN1F+ZAMsRQyfHD4dlMgVf2wIUEA6YzmwpcjzXt5narCZ83NwqyDX5hoKF9P3G
         oEKw==
X-Forwarded-Encrypted: i=1; AJvYcCUTLDuZA3lw/krkw77ZrnQGjFsEi26a4SAhYYmrT7bv5YZkooOQ8nPpfy1cy3YpMYuZLABoS0Mu5inL@vger.kernel.org, AJvYcCVt/olOgL5UZ1Ovxq9Vsn2wIe9NiFFCS6/Vt/c5+rYrCtkaaUZLlnRvx70NSLgMyqBdBAjmq1htijV/@vger.kernel.org, AJvYcCWD9X0MAmEl6tjiTpf3Qi7DPCgHvLGVnlKbi6oFLxByWQX29U/6QSp7e1L4kg97feqs7Bu7eOCrnMcNVZ/a@vger.kernel.org
X-Gm-Message-State: AOJu0YzInhG0BGtyISS+Y/yXgR851Yi8NF04S3DK74b9N+WF6+6qeDqz
	zGmB4MohhXB9AzpPschfAYP2MQHeVpzRc2Lb/Fpu3Fs7Jy9pSIqHmzWA6JoO
X-Gm-Gg: ASbGncvh4KgX8X7haxStN5WWkzfEJy1BiwmCi/g4ZSA5NMp+k29CPngWGpaemQTWhuN
	yXMvRO+2orfV0VIcuhxZpwLZIDWYneFV8uN9fdzk9PToSIKiuIuJBVXDnyZ1InR68sOTewNyDXK
	K1qjNyQKOXYbtKdUDP19aI0jk9J210uzEtlQFIlNC572R6swFmQwwnrhVNM8CWmWmt7h+Yg5oGC
	eKcPel+oY36xUHklHY8Mt3yT1ljSowTsMa1hr9n1FInqFUDOYAt+Ckw1xugEsS6mQNCuYujRnp+
	maM06TSkR3X/CbhkQ7c3AGfvh+EtOLjVBM8OfDjZ7y+pnLxv5qEqQQ==
X-Google-Smtp-Source: AGHT+IEy3WVBYS5bkjMmOdhylnIW18miMxAnn6ezvqexWBHLNRb3AIqDu2C8ZCsKXA+RyQX3qUnCaQ==
X-Received: by 2002:a17:906:379a:b0:abb:aef3:6052 with SMTP id a640c23a62f3a-abbaef36608mr148178766b.55.1739811645248;
        Mon, 17 Feb 2025 09:00:45 -0800 (PST)
Received: from playground.localdomain ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376aa2sm920570766b.103.2025.02.17.09.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:00:44 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: clock: imx8mp: add axi clock
Date: Mon, 17 Feb 2025 11:57:15 -0500
Message-Id: <20250217165718.74619-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
References: <20250217165718.74619-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The AUDIOMIX clock provider takes an additional clock: AUDIO_AXI_CLK_ROOT.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
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



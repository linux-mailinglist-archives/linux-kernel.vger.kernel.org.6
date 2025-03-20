Return-Path: <linux-kernel+bounces-569649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A25A6A597
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C2B177835
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E33F21CA18;
	Thu, 20 Mar 2025 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJwQIkHg"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AE21C9F4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471805; cv=none; b=O/vuCFsbzqqMo/3CEbbpjcG0Hemv0+tuycjgnHng1B411RnPin4yr3fgf2OOlcV+Qe1HxK2IFzzC///WQKqScUylenMOhCSOKNy//XqV9GbXzyWHXEMZvUyAU1MSFlbxJjcdWe7vrhihUZ0vmBjYkU2iAVXWj+mMBZxftEqJ+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471805; c=relaxed/simple;
	bh=Aon4CSRLZAp00bOLv5cqnz1HdCAHQzSH1gGdjQ1+p2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YopogWRj7i5sBfCCMuUp3Y4zYqz3uuogvMqQ9rBHK3IOKgpVPLBfzbVKVKUEfR0AXrA0ePFtojP/JdX+QrSmluvi1ym6wkAW0nwPb79i2GxMbcBBg1SRJbkCwett+bi8yCvw6eY2WwTh+YUdtCGEibkLyx3urM+W+EJLwlikYR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SJwQIkHg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so5559775e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742471802; x=1743076602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTBcwD7zMY77Gd6SVP9wN85Z8q1nB61DYTk+PAfaKwU=;
        b=SJwQIkHgEM7R1WTrjxpobSyb1vdk6Rz0QmdMccVtxj/JyReA8AwE217gHf/RAxD0kf
         yeqNsFxw/EvLoQ8/QZdgJozzsPBFfQcs11YRe/bfbPnPhJVG/cjxX8iM3CRgkJDsDJro
         7GVfCMkvz/OwuH6r7LCyr7Hc6+3SbAbUIy3jvL/LgeTZzO3ANr9SOWQ75GXsdKzSUxi0
         kuxM4uzz4iZW+nWICN+EsyLdexxtOIqTFZttRfrR3p9lSNapHqk/EAiIXEZ8+M8EJFUv
         JfrQAV+ntcUyLWVW5c6m2avoCH46AeC1eE/RW6f0CB/ncTOJ+NPhinuobkizybiYVFo4
         iXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471802; x=1743076602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTBcwD7zMY77Gd6SVP9wN85Z8q1nB61DYTk+PAfaKwU=;
        b=oCTSNtoBGEAdwfASF9BjBmBlFf8mrOGvWTQvOr+0gJ/O1zyGfjd1GXLcNrd6DKRrGT
         SChZHUf2B9Pp7HovOfVUY1CmYOG2PLLm54zYaMcHvOGzTiGL0BV9SpnStIBxbiQ1w4jY
         cjc3ZJsFia6SN50cD0IdWAyXCvPHCf5Y9AJzDWhHzuYdFz0qoqr+zOLg7U09h5rhMwgv
         p2PZ4bTYBIhX1nFYrdcWKrprLkNt+EK7kYMEFheR4IrOyOAOAL1A7Cs6dlsYTt8PJAQg
         SzCPa9j7t58Nq+IWZbIjAlZRlIpw9mp+A6wYorYGGMIrbAWli3Cx4DFdDbYP6CGJvN/j
         o3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVkYyJD/4GLTIZL4KnU4J1H7aJZ2qx5VpfvP/rgKoqfa/AIVnuIQpiN2W8X4gx8RpQZ1xG3uCqm49TNE4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRraaHl7TVzIcY6S4v5WM4fS0fnioifz63rTHBUONvzn1B5uy
	EoX1oTlOw+6FLG67c6Gs71spYYyFVBziy+GH2eTPj9L91ShGye34b4ffexiwBFo=
X-Gm-Gg: ASbGncse9UfFH6EVkVQChKjnaH6Mxob6DBVRTjp1mU3P1uYatdlFgFs84i3z1UXWiVp
	Mnh2wjolS+i/nDm+Of/E9TaWXYeMoEwcy1UwZ1twv3JUXq5vTa2zfV9nlrrdrHFFAqIdxpONQpE
	sT2o3rXaOQ2W4a2PixZohyqtMuesYre+Mxi32pZMHK1t07yR/JM35XGb4A0+4EFXNBw8rtDloYE
	EdbUayIPhIZqGx319kueBRhU57R3Atsqm2UDN6+jhyFMhkIyiRxIPoT+b4pxkkaqVK0IYCEJlYn
	dU0XfMVMa53Fv7+O3jNku1QZTcUpj9V7rJ0hTwgJu99h23/Y6aiu6X4LxNQ8EJlJMc3uhg==
X-Google-Smtp-Source: AGHT+IELSu1Fy0iTPGOQqguY/3CHrp5HN+wulAbklczgtP+/n5Gl76d1bxZyG2Z7RhRwAdDyddobKg==
X-Received: by 2002:a05:600c:1546:b0:43c:fb5b:84d8 with SMTP id 5b1f17b1804b1-43d49549405mr24419195e9.16.1742471801801;
        Thu, 20 Mar 2025 04:56:41 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888117csm23257857f8f.44.2025.03.20.04.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:56:40 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: peda@axentia.se,
	broonie@kernel.org,
	andersson@kernel.org,
	krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	paulha@opensource.cirrus.com,
	lgirdwood@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/5] dt-bindings: mux: add optional regulator binding to gpio mux
Date: Thu, 20 Mar 2025 11:56:29 +0000
Message-Id: <20250320115633.4248-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320115633.4248-1-srinivas.kandagatla@linaro.org>
References: <20250320115633.4248-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On some platforms to minimise pop and click during switching between
CTIA and OMTP headset an additional HiFi Mux Switch is used. Most common
case is that this switch is switched on by default, but on some
platforms this needs a regulator enable. One such platform is Lenovo
T14s.

This patch adds required bindings in gpio-mux to add such optional regulator.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/mux/gpio-mux.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.yaml b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
index b597c1f2c577..ef7e33ec85d4 100644
--- a/Documentation/devicetree/bindings/mux/gpio-mux.yaml
+++ b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
@@ -25,6 +25,10 @@ properties:
     description:
       List of gpios used to control the multiplexer, least significant bit first.
 
+  mux-supply:
+    description:
+      Regulator to power on the multiplexer.
+
   '#mux-control-cells':
     enum: [ 0, 1 ]
 
-- 
2.39.5



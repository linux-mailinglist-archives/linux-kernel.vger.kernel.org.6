Return-Path: <linux-kernel+bounces-384647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAE49B2CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27568B21980
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A9B1D5164;
	Mon, 28 Oct 2024 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T0Fd6yjB"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C181D0E38
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111175; cv=none; b=hNj8R4x+4H+7KV+rKYHu6HYhL/Vc2KAtAaFfeM0VyK1Zx5HFan1aBA44J7cmOwxk9drEGGwHYLhgpK96jCqoRh45JF7+nGMun8yk9cOsXCcrcOjJEuPDxdCFO+Y8wwCiTHbVct95RFeT0Fq57750/mi1ERKYEeoRH10ULK+XQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111175; c=relaxed/simple;
	bh=R93VMLohkk+JmS520PXpYqfQBg15NGWIzpjAwA+J2Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDGQiUjfImUG4TDbA41bMuKnhbzHESiPrOgvXqLDww247ca3QPAl69UhwuY81B0XJMQ8eqkTCbV0CcK+nZBmoQz5CcaiObSCiSFy7p7VoBDXxlOH8mre3nn1432yONQxcxrUJ81VArbt1JQNuWtP2pg/NzW2EyX4dGPSU3TF3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=T0Fd6yjB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso4087374e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730111171; x=1730715971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYexXqsopB/TorltyWtW3DQvmZVEoLO13n0GfiFkuag=;
        b=T0Fd6yjBYEgaZb3zDq1s5h/LV2LLRVDrIggdpQqSuJBtWs+/Ecd395woqs512paGqG
         xm54xRsDTAko01E/OdqIbwHLAboe3l44XDazR8QlAtOSMvkls9yVHhC/3pG+3fI5qhIp
         AHZTdlgJs1LqETco2MRl6O/kgWaD/WHHW7f5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111171; x=1730715971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYexXqsopB/TorltyWtW3DQvmZVEoLO13n0GfiFkuag=;
        b=Yv1u963woagsyu+xETeGyGv+iI9WRMMrX+VgdIx2gtNzQRx7IdC1AbN2tgCyEh1hTJ
         y2vkCLaJe+X+Z5Gv8On1UY1NWMN4OJv9n3NFkmvemGByDbrI+nzq9CNpR5H3a+COrSls
         Y5Nu/Htq1JBg3zfMD0fxM3xGpslIGLk30x8JfClu6JUdNo5eR0DBjAT629d2YBwqTaaj
         wllKV5e45BImk1lPtOfQvC47JxIQn82Q6/el37kpnhypA/S9YeYKu7n56+lgag+46tog
         hFUsIaRkfo5kvb9+LU6cJ6zCm7Wy99nv24cHrIcfrBplx1AKJ3VEpNKzs4JjA4HowgKv
         dBVQ==
X-Gm-Message-State: AOJu0Yw1dA5TvgHPSYf1gWmnfvwSJNCro9818z7ziaIrunbJqWbpBsmv
	MvpC3SON7C7diF71CLNYrS9Rtffo+KVHl2vxgnofGimxn8ZdbBUNFD4L9dYVCfDNUB8X+9RO+zj
	yK90=
X-Google-Smtp-Source: AGHT+IFPiWSMUJsvLDsFUQKEPXeJtOq9dyzWbF9cm4SlPeUZQ8cIi4gauJvX3gywzP7yEJIBk1InHA==
X-Received: by 2002:ac2:4c46:0:b0:535:82eb:21d1 with SMTP id 2adb3069b0e04-53b34a3516cmr2517575e87.57.1730111171159;
        Mon, 28 Oct 2024 03:26:11 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f297b04sm363613966b.134.2024.10.28.03.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:26:10 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 01/10] dt-bindings: soc: imx-blk-ctrl: add 'fsl,power-domains-boot-on' property
Date: Mon, 28 Oct 2024 11:25:24 +0100
Message-ID: <20241028102559.1451383-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
References: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This property lists the state of the power domains, indicating whether
they have been left on or off by the bootloader/firmware.
This information becomes relevant, for example, in the case of supporting
the simple framebuffer.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
index eeec9965b091..00aa0b8d8ea9 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
@@ -56,6 +56,15 @@ properties:
       - const: csi-aclk
       - const: csi-pclk
 
+  fsl,power-domains-boot-on:
+    description: |
+      Provide the on/off (1/0) status of the power domains. It allows
+      specifying whether one or more power domains have already been
+      initialized and left powered on by the bootloader.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    maxItems: 5
+
 required:
   - compatible
   - reg
-- 
2.43.0



Return-Path: <linux-kernel+bounces-534468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76308A4676F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A527717CFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32742248AE;
	Wed, 26 Feb 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeAwsRp3"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB9223710
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588868; cv=none; b=FMpg0m0mcuY+JJFlKczNOL0aWgvUjkMckeiCoGyd5IhinAo3I+2bN7r2v/j35AubyAc1xH4XxcIx/n8WP8RC1aAcmMeq64qP1WUPuWOeAlpzIr+KcIDhqshT1dJtiDVrp9pX7s/QLjWMO43P6ruBb6uDCfHnn67GWDj3V9Nj8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588868; c=relaxed/simple;
	bh=pvVFF8LcYlrlCMpxO/aHUSZAY8oWsFTdA7hLOwF7t3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AIh/R8wFlil+AMN/nPwHIoQvHAyTUxq7cNiL8QOYIqjATkePurzuVHIIGkRXkFcNj7ChS1Ui5wBC+SXkbcnVgxfDSDHYBUt43YAs7vxPzdC1b0kgwVuiFsvXBah9f/IVQqjmwgG9zFLPfN0p9vuy/jpEBWWX2rALEMbs3F+Yr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeAwsRp3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so426255e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740588865; x=1741193665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtGcm5ZWKNh3uJM/zqclGCkk9N3iqiYtET6+2Cl2Q+U=;
        b=UeAwsRp3jtdZKVkfFGWcPkRC0ThF9++mweBBVhTMsxtEciaxlCtx1AFNlDek6jGfvu
         0kGsyqUBEY+ryDBpvORMIv8ps90Fb+o8x8pGg0pOVNsg9QsNsGcvp0bJgK0nHm05oC+q
         ivyKfUUHviJ9b+JHyl5OfYN1bPYJoGH+rDXWqYUoabxeZc9fD4HB4JkzSfd/uL6cJuTB
         TCL0Dg6ofF4D5falZI+SzsSQI3BfmrmLrQbrkmQHy9S+UH2f4BSYPqB+AapGIb1Z9Jdh
         2DwwcZ3/tt8KogZZtOpZLuWhUcUiynP7T/AVB4LmHReY79LkDCsgunDXk76QMvdhV9Pa
         rTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588865; x=1741193665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtGcm5ZWKNh3uJM/zqclGCkk9N3iqiYtET6+2Cl2Q+U=;
        b=V7pxow74X22miImFzJaA5pc+WKwDq9P9VExZKuegZReDdbtm97N4xyO+VbAqTu2jcN
         S349XtBzr47M8FjVoxZnbZAK/ZQcq8rCUWHw//GpW2pjZdi76CLMHtJEIobMTJnvbvLs
         oWA74cOjMdUmaORaHEzMoTA3kctbxrDXoBQ562jPfteWo2EHnMg1ow7dLIwvI9gXJUjj
         HM93i+eBuBL0xVSJU6kLWZ1RHUchzXcp4nJHQVWKNjLcPk9SH9z4reE/5ZIsV0hhNERR
         MT7WTkzue6iHUR1EcAiRtjYHfkjPVUpRpTtEXV/T7c86MgQHQ7jJP6D0TYSLao44LcjR
         hujg==
X-Forwarded-Encrypted: i=1; AJvYcCUwN3c1DDVv78WEKxiqJvBN7CjYKZdbw5WJoKsdonfpqh+MU+vxZmr5/Ea3BFlq28e6Kk9L/YpoKgueKKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcluDdCLOmF3SyOZ+KUpnZ27Gn+fTFfEFfPfEukMekgBsouQqI
	34+IRgG6HG/8/pQSBZRAG59VwyIdnP3i5fABMrt+mq8H28ggNvNA
X-Gm-Gg: ASbGncspF7Gi64befMAKWDnMvgZy5yMgY9fsIFMTTmf5XATapTiAzX6aFc1xbZeD8JK
	QPvAm2EtZfjhlqJ2Wm4dmqZrrBALqKEupj0VSWlZ89oN/6gPZwguSBFVH8wXSfHVcSBQTzyXVS3
	zbF/NRdDH1Z1j13FWK2Blh5xd6EfRqJJOAl4eFJ3oJ1e7zjeP2CCBkxWna5up/4nbls5e09bEGt
	cDG2XzRPNc+ItPdnm5o1khp560NT9q9LPOuqGDfTB8horTeq4TGXTQELlEIGgkBXkClNsI/wd5z
	XwLBz4C3pYci0kxqpX72OQABMpB30eJnFLVGW5OtTCOO5MPuyG2UW8zSylFhMAhR
X-Google-Smtp-Source: AGHT+IEr7k3hpbUucx2jKL4FfCjfgt288+HwWr+usBZ9kHZQ7fGw05QKWSeEYQ0zCCodSQZ6AYFIxA==
X-Received: by 2002:a05:600c:458d:b0:439:99e6:2ab with SMTP id 5b1f17b1804b1-439aebcfd58mr175600195e9.28.1740588864704;
        Wed, 26 Feb 2025 08:54:24 -0800 (PST)
Received: from playground.localdomain ([188.25.208.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba587163sm27672515e9.36.2025.02.26.08.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:54:24 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] dt-bindings: dsp: fsl,dsp: document 'access-controllers' property
Date: Wed, 26 Feb 2025 11:53:11 -0500
Message-Id: <20250226165314.34205-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
References: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Some DSP instances may have their access to certain peripherals
conditioned by a bus access controller such as the one from the
AIPSTZ bridge.

Add the optional 'access-controllers' property, which may be used
in such cases.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
index ab93ffd3d2e5..869df7fcece0 100644
--- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -82,6 +82,9 @@ properties:
     description:
       Phandle to syscon block which provide access for processor enablement
 
+  access-controllers:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.34.1



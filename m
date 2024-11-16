Return-Path: <linux-kernel+bounces-411738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39519CFF09
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F5B1F23220
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50031B6539;
	Sat, 16 Nov 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="konFY003"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A21AF0B5;
	Sat, 16 Nov 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762638; cv=none; b=iAX2sfTbYa9YWd2DnxaipiSgWNIByi9hQcCJspmf2zJXg0iLJPCcvZqwNTdmK1RCfncNrxn0R/7E5IQBtCqAbZVFSLZSPPw1DMztCnncHO0/Gb6z6QW7KRF2AGQICP8gsvvl6pB1XP/R5OABzXG12y2zxp59UotajuOJRpTMphI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762638; c=relaxed/simple;
	bh=5+JBZWvrLPOz6LfTr8VfctvLwC/Yy9XRaHMeGAbL6IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RZO0Q5Yq+tDj+5XSthiBAvYEEhwv3rKxz13ZtQyCDPf6joU/78PJZkV/7xx7isXdBlQCDIbEcdlEYCdEpn17q9l/2EAzlT5OhoniALI9tMyLC83jRMOzyX69S3KoiZp/IJUZp2SIIcOb3HLIwSofNdowr+XZqa5gJaUchHkXcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=konFY003; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315855ec58so2972475e9.2;
        Sat, 16 Nov 2024 05:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762635; x=1732367435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqQodJhTXgKzsrGtW7EUbvDnu/oSGoJ9T/OEaMeLSic=;
        b=konFY003CuB+eAWzLIk7uOYZU0oyFaDqCreT5nNnb7q9nfxpAShnxBxdx3PBSD0bqM
         ySsZkRn4YkvgDHXun4KsAluehMTIGambomuVY612ogRYM3M3exlfopY8K+pxuCA7ArpG
         jtXH4+jzl3t/UDjr0gGppOfIoHx2ndsO1YaUwWQ37a2t7JVT6Cxpub7Kmu71rDXlysfH
         ZMSt+8Y2CHOm2cDYqNnOt5Li3x45KHmPWZBzP/Pm2CaoH42xs2tnVSD+MMdwNZSeCpDu
         vA6O7vkHRDJW79DhjiuiW4x0V7tzFmEiMdX272HBunU4ebr72z/fEsaW/blhbByiPBQp
         3NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762635; x=1732367435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqQodJhTXgKzsrGtW7EUbvDnu/oSGoJ9T/OEaMeLSic=;
        b=Gbq8tOalxpuQiFlyFakIatv5hvUic+uoVs0vJoPeb10+wgJ9CSE7BjkueJdcE+rWD3
         YcNZ3so7j1QrmSNQOgdFornCNGLIjrk+aK0eNhPVJFBDQqF9elMcLj8iHNunCvAmNEGV
         uR5N07pdHQ1yKmZB28zj3byg1t7TZnoVJlWwxZfKTrCP3jZ+p+NijBp88AOI/gpFWxIE
         1FLUBbRqoMCOnPchOv72ZeiKIOv0VL5mVEgC05W4SvTQFkeP3i5bzrU/qh3ExvEv9l3q
         cy6Nfbrl6800iCrQOCWGKiFiSBlgwgNGxlZDfVs/IkrqVDTVYObw+GgMDSstLsDYLwp4
         iUYg==
X-Forwarded-Encrypted: i=1; AJvYcCU4iqEjgR37ZO3vb14YPgX+QvfiUFqLEJtT2fpNMuWiDNmlShjXLxU5VL2KXTPmRK0ZIZIIhFqWaJfdq8GO@vger.kernel.org, AJvYcCW+MXZKTxevvI6JwaY20BzdRmibV84JiJ3shjT3fJz7LUR0QhPaQlVwV1fhfWTozK9g42iJ9FZwnOQ8@vger.kernel.org
X-Gm-Message-State: AOJu0YyAgqf1ARl5jxIldjps8lnp9aWYNuhaTRBOrHFQ+8Gd8jJIjPqi
	THCbDYL6X9Ltk/xw+SxWe9FKsN4rRXUz7KrmER5a7KM+3T4rLeGw
X-Google-Smtp-Source: AGHT+IGjswmH6e38+GLAay8wKkKmPhEHLWeETuvrpckWKSYCetWrm+gYAdX+qtJtvHkw8ub3JlNa2A==
X-Received: by 2002:a05:600c:3c9a:b0:432:dc5a:b301 with SMTP id 5b1f17b1804b1-432df79af95mr23546065e9.8.1731762634899;
        Sat, 16 Nov 2024 05:10:34 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ba80sm92424375e9.29.2024.11.16.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:10:34 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org
Cc: marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 06/11] dt-bindings: altera: add binding for Mercury+ SA2
Date: Sat, 16 Nov 2024 13:10:20 +0000
Message-Id: <20241116131025.114542-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241116131025.114542-1-l.rubusch@gmail.com>
References: <20241116131025.114542-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the device-tree binding for the Enclustra Mercury+ SA2 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 87a22d2a4..31af6859d 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -61,6 +61,16 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Mercury+ SA2 boards
+        items:
+          - enum:
+              - enclustra,mercury-sa2-pe1
+              - enclustra,mercury-sa2-pe3
+              - enclustra,mercury-sa2-st1
+          - const: enclustra,mercury-sa2
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
+
       - description: Stratix 10 boards
         items:
           - enum:
-- 
2.39.2



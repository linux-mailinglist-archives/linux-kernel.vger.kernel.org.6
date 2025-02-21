Return-Path: <linux-kernel+bounces-525242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C442A3ECDE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA233B936A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9C11FECC7;
	Fri, 21 Feb 2025 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNH8PU4T"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640421FDA9E;
	Fri, 21 Feb 2025 06:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119739; cv=none; b=rLMf1spqpImSVg6+vJFPC3FDJVz7GfGrYzYAVmT3Wvz0bxrDnaXTDfQQgRHz+QYffjWCF2JId82V0iU6OQEe7Wv02KvCm2O+VRD0DdlfqO7pMofY2KxeJgWWjNekUusHKZPch8ufctMu0t1HOu1rTPYri83+R9NfzF1nP7Jrv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119739; c=relaxed/simple;
	bh=nEBR/ZhMQZciESdwCVA5pOAm06SUbrX6YQTiEaxmjWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwJR+rncIWrjk1B0xFXa1gm39FYrBcIZIjZhdiEMR9oQ3LyGp+XQnIBDKhljkr9yYEyqTV45QdsjKgIid7Je8U54XzlKq5cBAjcsy9SuVPBil6czsTQDiEl1rwNmeWfURRnkUqYp3UEplMmOa/4lr3WvPWn0K0Fpu5XNMnboBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNH8PU4T; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c2a87378so29075335ad.1;
        Thu, 20 Feb 2025 22:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740119738; x=1740724538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwO/SkbYtwZTs4AM8sYV7gCvk2UZJpUu9dv4BdAdEOY=;
        b=CNH8PU4TEkqPFYrgIuek19C19Sl5KsFznqq4IDGtvNVdoOqUlLLbnbTRALQiO4OvZm
         v/vzMFd5vuoWz83u4uCpfSQ3aldA38xUC+0llvUvBohpnfM35LUvPqL1MS8MpgQVLYT1
         rtQrF91JSAMalobxNDj3XpkJ3bF+6NES1Tjz0vHdFDV1VILGNDpQftoyvm3tBKaZWPFb
         O8sISrYqawvtI+aEDFWs7ROz3zSCk2mHCNhHwYCWsoprSyrZmucoEn4Ysd5YUoI0s4+3
         oJcbdUkhtAFMAWMc8+G+OcbkOJapnW8/34IeQsCZa//0NRiS17GpaYX4+jtOXx+dnVrN
         C+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740119738; x=1740724538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwO/SkbYtwZTs4AM8sYV7gCvk2UZJpUu9dv4BdAdEOY=;
        b=dJb39wvw6iHqxe416GwUU5rSBSRrdA2PXBO4pnVrztSbYHQtIiB/lH8i1E7VV9I094
         gGDmX/wskz7LZEvu0yLRckGhFhhml9j42d3/vky3BLqTYxGw5nJGnHmJUs+ORBFgYlub
         BKPN+N/OB66PQ5LjQt35SzUTYUJU1343OLqZx6ZcmK4Bw99QRol//ARGLPg7UX9pR+0u
         AW8VS30iqBxjtjgmtSOrwtddylDyoCmMr9p2IB+hZuU0ZrVmH74E/EDDEwv0+ud5QwRL
         tDoSWael7yvGlgPWL258is0bgQlwRkw743qlnTdA17ma74dbggSCgAdnMIFW1b6vK9Jx
         g6PA==
X-Forwarded-Encrypted: i=1; AJvYcCXgyezG6inmkybU13oaOA9r9nwgV80xc36+W9cb5zango9WVTxtPBFTyzlUK4adkwcYBgyY/bDGF7GM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Mc5U878SrL7OlN2VoXlI2V5pwVrRdzlpY/ra15OpDDRHt1Tu
	YF3ANy/2XEK7Duwr3mg9QCytCo0s23Nhyuup1+Z2//MK5Pq0RBHV
X-Gm-Gg: ASbGncsgJE3Z2IlfSd39WdHroSgbgNeMHbfRiwZ/JwED4hq5NYsS9bXgJZYhGo5z2Za
	X3r2Ec0KO4kkFQTkzTpdynnPysdr4FX2g1SHUq1QNpGMhiVJRFjR34DgJDJ9RYhpZ9CXB0wBpeV
	KxmxplZHr4JyZBCaomU9FP9PSX0c2kHzIUS0oIMKyVq7vHrHDFWch2v9vM6tm59Kq5QAjH6H2Jl
	ONtFOn5fHw+/+PKy6tnde4bhgjZaujmcxhahmXo39uboSQQbnxFaZ7bjpgiyZgIYMPpGbsMDS4j
	VkJsqWu9WAVJGjjPaAppCTq7KuUC7SZyC0Il
X-Google-Smtp-Source: AGHT+IF1irUoX48lK4y0HS1OgtbhNS+wWRgPDk7H704bIktSj2/k9kSPBlJNGGRV0ZdISZdA+3mOZg==
X-Received: by 2002:a05:6a20:c998:b0:1ee:d8c8:4b82 with SMTP id adf61e73a8af0-1eef5558f37mr3519911637.31.1740119737763;
        Thu, 20 Feb 2025 22:35:37 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5dc68sm13777275a12.9.2025.02.20.22.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:35:37 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v3 1/4] dt-bindings: i3c: silvaco: Add npcm845 compatible string
Date: Fri, 21 Feb 2025 14:35:25 +0800
Message-Id: <20250221063528.1810007-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221063528.1810007-1-yschu@nuvoton.com>
References: <20250221063528.1810007-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
Need to add a new compatible string to distinguish between different
hardware versions.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index c56ff77677f1..4fbdcdac0aee 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: silvaco,i3c-master-v1
+    enum:
+      - nuvoton,npcm845-i3c
+      - silvaco,i3c-master-v1
 
   reg:
     maxItems: 1
-- 
2.34.1



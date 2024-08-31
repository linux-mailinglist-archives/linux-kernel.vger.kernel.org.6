Return-Path: <linux-kernel+bounces-309712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD79966F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D30F1F238C8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7DC8528F;
	Sat, 31 Aug 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGyA7+vf"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79371537BF;
	Sat, 31 Aug 2024 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725083832; cv=none; b=bUYRNiCLha7o6dXFt+2DfnDyKyub/fbEYxhBeuHAVQ7XFXw7RH2BmzYzGtZ+gFR3g/4lH1f7SeAUW0tt8H+OJOu6tJYRjtar+n2mSbs1eiD+O7+VOEtE3kjmJKs68YtozMpBPmBXJXxHEq44ZNOpuh3vNB6zOm4e7/C8wfgj0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725083832; c=relaxed/simple;
	bh=5tgSRq5lvBi6wvc1wgAZq4DW7ZKyyVnTtG108xrA/dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJQqx1if6h8plKSPUxtBjGFNXkR40pyJ4MwU6tVkswaZ8VnOEJ3Kue4tk+Dgou1uGEuLwmACv9jEteKfA+uBNjCbMh3tQS5Agy3NA2aC+PX8sTjzXpkaU2q8Gs2TZANFWXUREnxfU4h+tk5KlVevjE/2WOyX9moHE5ybehPwNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGyA7+vf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202146e93f6so25179215ad.3;
        Fri, 30 Aug 2024 22:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725083830; x=1725688630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UZMOJ9tZhYVHk/YEPl6bWyPievm93YsDD+e3s9SDgs=;
        b=EGyA7+vfCsFJGPKEey3doF6ya+mM61CD/ECUZPt+uP0YtgOLPaNSwR5Y+Oxd05duNA
         Uo8pBUsH5QBoA6ZcuVwyHHGqBprJ/Nl14OHQVyvPG2z+Y1eLChAx0JipZsfmkOyPFDxk
         EKRAbknGchX7yYLgXkEHf86kz6U+DLHer++6e14luZ2vv5t+zgjmONDqDsNJEocfVy4u
         pfzXguYlzXHUXuDEJBzeICN5Sc3/tJZnw+74ikCi507khJVcCV6vyMY5cSCKLiKGmM6d
         JW/voZBTq1EEK0jnRGxT2DHezqa64I/1JCh3wvChRLJkbhFhmyILOLSG7sU2vo9FV0Ej
         mZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725083830; x=1725688630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UZMOJ9tZhYVHk/YEPl6bWyPievm93YsDD+e3s9SDgs=;
        b=w0aRJfrvhCQFL9ptZNW006YLe7pe0OKV/tc9r+zTPFmrL/RoYC7Z5PrXHaOLPlgpNt
         nZISxUTG5zxeaCbsM74vFRKcrdqPHMqT+UhCmFqPwgnM8KIIw1RlOZR5npr7r3Gu1cTu
         RR6y9+FrzMoQc7ZjAR4IlptR3NHa/0CWCuGtfJPEz3iX78H5Xa8BPUS4slzPr2gZOlgR
         86xApwU/C+jk4Yw+lc1ch7mtPX58P0H2tN5BYvzs75sOO6/5FrLrHcTSzCKcPlirz/YP
         60SjYS1++Kn8oiLsSSjlyKEgLBw+/Q4LqGKHvjDTdBLfDWu/W8HOEJWglo9JcpJemJwj
         HKrg==
X-Forwarded-Encrypted: i=1; AJvYcCUMAu9uk0JJsFRp7oZprUkQo7KqSkZqfpNHFWtj9EMVq41cGveWcFQTxnNO3vo2E7L+nbUazuot8OiW@vger.kernel.org, AJvYcCVBpz5xslyyn4UaF7C4NLcY6G71q/Qiz4QQAg/gIDzt/RQdXTiU+KI9HMTEBdEXZY52pSaNiNiT14bqqmM9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0OP9elNXvxlSjw2ObL0RtwDeX+0OPbnta4XfDIi7b9Np+dRsz
	HfWNZP5giuSh86Zecf0VXzZfp8bcs3jX4JRTxnLrA/YCrF3FK/IV
X-Google-Smtp-Source: AGHT+IGgyopLwUfSPL49E8730EhvLqPDRmGJc0WWS5mZWfB25NqZV3DvqNch7iHLN016VoFzOLtscA==
X-Received: by 2002:a17:903:41c7:b0:205:3832:ecc4 with SMTP id d9443c01a7336-2053832f198mr30229735ad.28.1725083829837;
        Fri, 30 Aug 2024 22:57:09 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2053aa8cb4asm12027045ad.271.2024.08.30.22.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 22:57:09 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	konrad.dybcio@somainline.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: apple,aic: Document A7-A11 compatibles
Date: Sat, 31 Aug 2024 13:48:16 +0800
Message-ID: <20240831055605.3542-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240831055605.3542-1-towinchenmi@gmail.com>
References: <20240831055605.3542-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document and describe the compatibles for Apple A7-A11 SoCs.

There are three feature levels:
- apple,aic: No fast IPI, for A7-A10
- apple,t8015-aic: fast IPI, global only, for A11
- apple,t8103-aic: fast IPI with local and global support, for M1

Each feature level is an extension of the previous, for example, M1 will
also work with the A7 feature level.

All of A7-M1 gets its own SoC-specific compatible, and the "apple,aic"
compatible as a fallback.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../bindings/interrupt-controller/apple,aic.yaml   | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index 698588e9aa86..4be9b596a790 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -31,13 +31,25 @@ description: |
   This device also represents the FIQ interrupt sources on platforms using AIC,
   which do not go through a discrete interrupt controller.
 
+  IPIs may be performed via MMIO registers on all variants of AIC. Starting
+  from A11, system registers may also be used for "fast" IPIs. Starting from
+  M1, even faster IPIs within the same cluster may be achieved by writing to
+  a "local" fast IPI register as opposed to using the "global" fast IPI
+  register.
+
 allOf:
   - $ref: /schemas/interrupt-controller.yaml#
 
 properties:
   compatible:
     items:
-      - const: apple,t8103-aic
+      - enum:
+          - apple,s5l8960x-aic
+          - apple,t7000-aic
+          - apple,s8000-aic
+          - apple,t8010-aic
+          - apple,t8015-aic
+          - apple,t8103-aic
       - const: apple,aic
 
   interrupt-controller: true
-- 
2.46.0



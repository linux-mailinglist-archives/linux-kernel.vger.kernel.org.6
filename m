Return-Path: <linux-kernel+bounces-393717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E66D9BA45D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6879281CEF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 07:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B485115B10C;
	Sun,  3 Nov 2024 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLcjcv/m"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89BD158A00;
	Sun,  3 Nov 2024 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730619225; cv=none; b=Cc8uohMmSsS8K35QbJqvMV/m4vRmxEi3wm5o7AD7ARmGl/qw8qSpy8QPcsDpkRP1mEYZxmio6C4Et27B5sfe8M9UvchTLGQzgCVOszPedzW7Ikz2S6TTX++47TbFAnJaApSH6x9Yrd/tq+dNnglvZG4PII6yetbWyQiZg2ocF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730619225; c=relaxed/simple;
	bh=XEarR1V/wSScu1ltyWhNi5l0HHJogogwRXsmiHTLBfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GN08GuGbNK0LgaMfXXaENGYDSEvoetCz3XGoC3iSVQnlSw2Hrzb564mJFtyQuxcxhcFep7tyW6G+2+MQ01c260s/x60xkgaX9iNEzdLbIwDAwOQ00ib/4Rrps6IqlkTBrLsO0aELq2ZQQyMK96HjFC1/YXuLo98QB4+affSIC6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLcjcv/m; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so2850116b3a.3;
        Sun, 03 Nov 2024 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730619223; x=1731224023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7y+F0NAVhdE2hhGdAP0Oqd3utvxnAK6BbO2jtHkbzc=;
        b=GLcjcv/mPwJNO2URgXsoo8aVAo491zSLfjp15ZChzAU/n04S1b4QfkkUbJsy62hVE0
         4gR7DdqB0fZRMZkDsmXK6pESzDseoZMpj1hW7IYGpbTsGszljknF1HgtVF9Gx3E+5rvp
         9PIg7toqAzqkjEWr2uk6Y8x5484mb2A/3duOFTE02aI4xeDB67cq3E+QoLFTrYUtPKSF
         mJ5+CFbNdgMvxpoAVsJ6zSHFiS18r9X0pcJy7g45WNoMF0lTxseumedV+7ceXtkZza+x
         eKfcHJtxB/O/QVyCzyirrEB319ljSnm2NqiMLqOuMQxjrcyh8VJ5sV6pEilLmiPwYIy3
         h8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730619223; x=1731224023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7y+F0NAVhdE2hhGdAP0Oqd3utvxnAK6BbO2jtHkbzc=;
        b=KHZubV+h61JknlQsf7ZL/wSLYyjSmVTZD5k4OfgpU/dLMu/klI9vksN2hxxQrZdbvT
         +dEZbvr0wVb7Jag4p47oeKxn/0Ok18+tnc4YCFTOSW+WXuRNJ0YjnY9gv2QZBaSbux0+
         nf28SExQLCJZqjAr33QNF33ILmS3Yitvki2f8StcBL4FTVuQ8JO2VGndE0AmlDCRlUr4
         DWI/9CRTrxWkR8MsS0MIou7NFagiUuW4N9PUhay12PVC6cmo1rLBIvX2PTgn4Vvw/K6k
         JnWa4ZrpcGdqUHRIf3oLqKydvbzLHm0mOPokuLwVUyGO0cT1uGWQimPosFuPT2NaeOO+
         SEiw==
X-Forwarded-Encrypted: i=1; AJvYcCWl1208phQwarA3jebSWznrQIrPHH+Cy9kccJMeFBySiX0KOZBppB1IWwfeEgq81q9xXaON3Px4eZ5l@vger.kernel.org, AJvYcCX94+yVSf4+4p95OVdYvG9tuoDLFTvPkYkCCZkbFmyWsOnoxwk9j+3O0O+uJ+kW8PxjjNP/kM7RuWZxGPt8@vger.kernel.org
X-Gm-Message-State: AOJu0YxUDwon+JUpRX4GST9KV9Mzkwqk534CmLYXoTFNKH1neyXIMPjr
	zhpbxnd6zpsvzqi5GlxKvgg8oXn5LXELjo6Y4ZfEdMOeqcyUgtLn
X-Google-Smtp-Source: AGHT+IE6qDUt9+yFC13+4w0ALhboEGJDjMA6yvBceFpgkq25mvQ/surgMUyOnPPCDOEl/rb4VKy2Hw==
X-Received: by 2002:a17:90b:4c0b:b0:2db:2939:d9c0 with SMTP id 98e67ed59e1d1-2e93c15bf3emr17260428a91.2.1730619223097;
        Sun, 03 Nov 2024 00:33:43 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e93da983f9sm5353443a91.5.2024.11.03.00.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 00:33:42 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH asahi-soc/dt v3 01/10] dt-bindings: arm: apple: apple,pmgr: Add A7-A11 compatibles
Date: Sun,  3 Nov 2024 15:31:12 +0800
Message-ID: <20241103073319.30672-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103073319.30672-1-towinchenmi@gmail.com>
References: <20241103073319.30672-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocks found on Apple A7-A11 SoCs are compatible with the existing
driver so add their per-SoC compatibles.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index 673277a7a224..5001f4d5a0dc 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -22,6 +22,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-pmgr
+          - apple,t7000-pmgr
+          - apple,s8000-pmgr
+          - apple,t8010-pmgr
+          - apple,t8015-pmgr
           - apple,t8103-pmgr
           - apple,t8112-pmgr
           - apple,t6000-pmgr
-- 
2.47.0



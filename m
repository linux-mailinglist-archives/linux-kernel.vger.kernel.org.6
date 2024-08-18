Return-Path: <linux-kernel+bounces-291149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B132955DF4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2FC1C208A5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547C1154439;
	Sun, 18 Aug 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pKk1X/sw"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55454149C7A
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002133; cv=none; b=BejrVaPZpBjmnN5V3NgR79NCcdFrr1tDu7R1Mzhyqil8XSPFhSOLI203DybUs6qEmVFy7GzNuWjOo73SfwZj8sb2opNZznwzKZlgYMJN7UXb1TYw34ZtBUJKzUflTZVZTy125mQZ8dEVGUELYAdGF27XqOxDOPtxqvz1mKKzyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002133; c=relaxed/simple;
	bh=EcLybmfw+0g9pG7qN2rZISIWYbjARPz79yYF0pURgRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UcFPxZVL3UjDQP8XWWzl6nJODMVcIql8Rleou3ejAuVzfPdj/EWkTtTmddrkmEmTiCJ+GYdy/1+vuti7fRFawtJ/Mo8mYQbojy8mErcoA9FUTk1VctBrcQRgfRiUWtNZJBHCiuT06vB9Fqn6ahXKAZ337gJicgvF3ULjj7+ZtyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pKk1X/sw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-371a9bea8d4so646346f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002129; x=1724606929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNx0581gmw5KmVnKNMArHkHEaJIxEm4/jRsnasy6Iao=;
        b=pKk1X/swdl2oN+2bNpUL5GH7qs4Ir4Cgl7LUFUkNE/562P1P/ui1Jib+Q88VxAIgb9
         /jSdiQSVxOeddjSASj4ktt1tDxLEzXdVzHhCGLdLO5I6vCXF+HtYyuzBJFabrWfpHaaK
         6P+eSRT5tdh3Ly4sBzReo0jdKyhaEGmkZ4jekegK0KF+5UT6fWW2yQeVaITVAuww6pl3
         Z65Ywt3UbN98sQ9CFk6tXyg01er/bw5utj0jY0/7GiMTo+tKbN5XCMLxfkHhFrdl6xni
         tl99lm2DNlB3uzROAwPOZJMyFDLrhbL0xX11zd2ASHCsCqVLUFPXRBOaSdCqVvhd/OJx
         1ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002129; x=1724606929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNx0581gmw5KmVnKNMArHkHEaJIxEm4/jRsnasy6Iao=;
        b=T/mERbQZUUPXmhEjAgtXVZqdNPqzYnPhI5YZbUK3dRQvwPtwxpmg/Hs5J62kRIgZGN
         sy3M13ClvawNRS4GaxdEUuJ83XYQDjmIG6oGBj0lmQpP9h36Ajl44fRhGp6PfShcVY60
         NzoVKjt0OzGJNEoLVd0adM6VVvZ7tjTdxbB0ztlYwzGVOyV4DGs8R2qh4HmWAza8sk9t
         BGWZ5jk+GG540tcQpYJj6LCMbDMgcCOHC/a1kblYAsRRgaUhlQqT+0aeokuiwBGZ+uJj
         bA4fxdnVj6nhmODJqYziq/UFd0sfWUQSCoN0FfmlCtB2Q/oODGEmaTtTYu5501+9L9Ea
         pphw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Nohs/h+Oa2E7998PhEdxg64FanIzNfq6dbvY6TLU+oAkq1FvORm8jBf1GE8HRyiCbkbtpQ+h5yez9FmB9toCDjBoXMAHy9l2Mue+
X-Gm-Message-State: AOJu0Yxx6ATenaCvZV7f7utXKlmZTNuuh524/oYDcIAHMLO2Z+tSz+SB
	hz/ImlIQxOYC6pZCRqPEPvq9BZCMaYEpwWJNmfdvjr6Ipj5dUiPdCMDA0CGbOrs=
X-Google-Smtp-Source: AGHT+IHhIVY0bWR2O7mz+r0RXXbWCwIx/u27MbcgBTwXx1CRg5LFhEFV+GL/Fw9bSLQnd+XYkgRWkw==
X-Received: by 2002:adf:f285:0:b0:371:888d:7aaa with SMTP id ffacd0b85a97d-371946b1ae9mr5217302f8f.49.1724002128655;
        Sun, 18 Aug 2024 10:28:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a31csm8518541f8f.17.2024.08.18.10.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:28:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: PCI: hisilicon,kirin-pcie: add top-level constraints
Date: Sun, 18 Aug 2024 19:28:41 +0200
Message-ID: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties with variable number of items per each device are expected to
have widest constraints in top-level "properties:" block and further
customized (narrowed) in "if:then:".  Add missing top-level constraints
for clock-names and reset-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/hisilicon,kirin-pcie.yaml          | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
index c9f04999c9cf..e863519f3161 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -37,7 +37,8 @@ properties:
     minItems: 3
     maxItems: 4
 
-  clocks: true
+  clocks:
+    maxItems: 5
 
   clock-names:
     items:
-- 
2.43.0



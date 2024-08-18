Return-Path: <linux-kernel+bounces-291151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A54CA955DF9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CF21C20AF2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A15514AD3F;
	Sun, 18 Aug 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbjPWgKC"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAD1494BB
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002135; cv=none; b=AOiqocwFjxAQt7aRouveY0L1yQUBxlE3KUWRJngGl8l5BQoMohtph/jzfPy5u58tdyLMbt1Va3FI5S8EqR1KJsrMrTAbGgnwzH9cFqzSrnhCdMpcKQKPekt2hff1eQgAAYwohDneQH2Hzodae23dlEBm7remoKCj+bc2eiG/VRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002135; c=relaxed/simple;
	bh=PfGTzwpVRGa/duIB1SHjIP9e0pglFAYCv6F1CEvYO9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mp2ap9lCSGYw73HmXgU/D4eMsojqJdEdLNC3yjCzMp6mLHy5YhypzbEL3PpflGRZDvVfESylKZ6k7ASnnU9hdXFDNtHrdtFRMSOl4zlwpFHfjvzMZ/d9KHSdNwoGNW7mErSCXV0F5D6aqnOgm7EACQ9eesjqSuk3Wo+Tdx0RpXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KbjPWgKC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso27299865e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002132; x=1724606932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BWMc4qRFUaUXttIzQ63qUjdk7KJyVPGCsohK/pyxYs=;
        b=KbjPWgKCUFwk8hM2zlAjlY6VlicqzT+2Xj734Gi4gsjqO07YDy2nZdrSFXkNkpIgfX
         No78J5scM4c22qa/evtsevDyfvz4jSJRxNtFX08njnxwz6+qCzo0hpXwsVkb+noHBoml
         fuEJvUEYDIQ1Bm3r/iUwO/qD4v00iX2QtveTp9ClJkheJ6ZflOPurFKFtKxNO8aYV/Pm
         +3WxYktkRGOY8ruPFXN3gCeDyrVdW/YHsKOiXz5SnKvW47c+1zBtA4PSg0n+rejQF5is
         lwPCSQUXiJ6xvk2yMgRTlr840v5NbAh2ZBkIDx8fm8A+oI0R6V2Ai0X8OKWYQ+IsHa/L
         CzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002132; x=1724606932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BWMc4qRFUaUXttIzQ63qUjdk7KJyVPGCsohK/pyxYs=;
        b=M+lfjLYouheiV3xIfUcSJtINGYY8UEMva6Hj1RZPQoBv24/JVpgemvnwwwPgLukhJr
         HvNDpwmuhV7xryFhWIYtnPY7IEDnHB0Mlt7wRmc4dThwyn/609xwZURwYL17x83hypPi
         X2MPP0bTMmJkkV3uvzQ58Ww++wgkj0Vx2Pb2WpPzbt7Hf6fk9QrkBS+V+ZJ+85u45S/P
         6xk1UsqQfpO60gZvTjHibzcbNq+4vPDnqw13KvsTbpKNT6w3WJki5jYXxUwnw6gy2LH0
         1pidIYnStaS0x1jIVjDkeJ5DKr/NLyFVuMI9fr1ZhSO9TZoQB6UnQy4TE3voVzm7gQCw
         Putg==
X-Forwarded-Encrypted: i=1; AJvYcCV5oRoHBYPXWPfLi1sEHWvh5j3Qm1JHATtnUgw3OI3yIm3YmfOXZCljsb3WqQlmhZSzHQiyu+k2olAabZ1RSVZll7IKk6FY8vZa/7Ke
X-Gm-Message-State: AOJu0Yy0h1IrRkK+ynihsAO34EVW7QC4Mislp38o0NRgqTlwPRgGkpdW
	ddi/IryJyZ8t7UPSOk04ExTuTkgWB84GqwTyZ1OWW0MizaC9ElYediADEDp5nJc=
X-Google-Smtp-Source: AGHT+IG7xhCbtpRMZFSXkVzfqnY16kl4EuN/5EeqoMflBvn6N+CjkKnH17T5hiI1Vz8GRi/mg+he+A==
X-Received: by 2002:adf:fad1:0:b0:36b:a3f1:eb with SMTP id ffacd0b85a97d-371946bfa9amr4703230f8f.53.1724002132091;
        Sun, 18 Aug 2024 10:28:52 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a31csm8518541f8f.17.2024.08.18.10.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:28:51 -0700 (PDT)
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
Subject: [PATCH 3/3] dt-bindings: PCI: socionext,uniphier-pcie-ep: add top-level constraints
Date: Sun, 18 Aug 2024 19:28:43 +0200
Message-ID: <20240818172843.121787-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>
References: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>
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
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml          | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
index f0d8e486a07d..93f3d0f4bb94 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
@@ -38,13 +38,17 @@ properties:
     minItems: 1
     maxItems: 2
 
-  clock-names: true
+  clock-names:
+    minItems: 1
+    maxItems: 2
 
   resets:
     minItems: 1
     maxItems: 2
 
-  reset-names: true
+  reset-names:
+    minItems: 1
+    maxItems: 2
 
   num-ib-windows:
     const: 16
-- 
2.43.0



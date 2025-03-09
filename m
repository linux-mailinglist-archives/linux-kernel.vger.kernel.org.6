Return-Path: <linux-kernel+bounces-553139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1622A58469
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDB41890497
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426E1DE8B8;
	Sun,  9 Mar 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYG1g61R"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF301E521A;
	Sun,  9 Mar 2025 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527051; cv=none; b=X2svrtxle75JiNkJsFRU6X84vEGaO1x1bbbzWJIve8SV+t8CS+C5BAuk53yKipCYrS49V/rx23ZY32oV9d44JlVEXqCIh8RE0BHhCR+vCHFaWD2puF6NYQBBp0bm2U+lEB0hjtA7lmqK31P17Y+taKReUyKIgeNPxoKwW73AuNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527051; c=relaxed/simple;
	bh=+PJI4+Kyd347ETzgLInQ5mg+S7qWNmwJbj/lCsAkVdI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5fZHFM20UcvLHxZtQqjIEb6KhRVoP061kt4ki9L87bqWnzm5qaUNKLKLKw8cmvaU9mBBl8KjI67ieJYnYPDABR1iMp7UlyELjKWdvPBE2M3fnxRiZNS4IA8qhqCdFRmKR+RguL9SoYXZn9Av14DqaEyIo8ScXuvtjAsGIx/XtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYG1g61R; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43948021a45so28847015e9.1;
        Sun, 09 Mar 2025 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527048; x=1742131848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbSAM91ADrJHfalqGDD88Hb16SIvmOajhEqLWyeYm6g=;
        b=SYG1g61R4abYHpixSRBGGSGzPTGInAkBAksF+bhuhNAtvKXwKMhE8oMyGGqFLHNRfr
         xdT5Pwbkz6SnfPNoxPokPBZOnnCS2fE9Dp1HiPDAiXCF16GD5RVrsazVro26cU4K3T5H
         BtaUKx35GuU2Cl5r/AnPXJ4A0dq3MWECvYm8dDbmaJjyk5AW4F8Wgav0IAYwc686y5iA
         s8vCIKQNF6Au4tihHoTLD+VXX/ooohRqeF8KWJ7igdUuDojATJU40V4nDoCvWbpmzcuf
         lsSgoW8+cjOa8n8ejKn95tGiePcE3UFR2K2SHH7AChsyIebgm6B9SYsTXSAjgP1Fpiiz
         tCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527048; x=1742131848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbSAM91ADrJHfalqGDD88Hb16SIvmOajhEqLWyeYm6g=;
        b=TFKmEdod9d/IfhtogRcZ1Bc7AFtpRjN6nBGRxBTQZqcOXJZugZDOLcvZzsZS5iCSV3
         830c9LTmbfhk7jhUv05rBsqrmrcdHKTV2Je7V8URMMLENByTLIjrITb1MHWhe2KjiR+O
         AJNefOcw3KiyRBgEDseOzWgbrx52NsjX+5hBmv4I1pmfZ5M8ZzsFE76qJPaOLcpZ8kFl
         NfR6pZAzI/4J0Vhj2sNNqMpXOPme519W5/oDKi+15X5G5Ex83mybJykOlj1pjZBa42RC
         LoK/j8w8+CmFDZHwQ5a4usGekNLa5Dt6OnZkrIWHrGE592+DJAML9GEEmQyoLqD1EfB2
         BkgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7WStxknV1pfhuM4RV5a+ag+clP/blz1O5pRnwekbgAwndknOWKMVb2TeYlvTfIRq2CsLw6A+En5GJ@vger.kernel.org, AJvYcCX7P8ncUb116oiCsQP6Fr3LERnZMRR813s4fcQwLw96tTd7H9f5dHEX9KMKaaFqPBujIhQd6WigKNXb@vger.kernel.org, AJvYcCXGBtun5Ti+/AYw3pqyXFglZ+jeOnkGk+L6NdOpG4seeiqsTimqXtsE0hzG86AFUS5TgfqMGJfqjij/@vger.kernel.org, AJvYcCXPctNkSYfFMNvXPcFR8k4pogQSGoa8rVDvcio1HE7AXskfolXmtCXwVWz+mDiQVq4DhT5UUvoRCuhqVvnz@vger.kernel.org
X-Gm-Message-State: AOJu0YzypA9gXTpFY9lSFl2VkPhznmO/G8AgIYhI3QDo9N4XfMmYlsX6
	xD6SmKbIoWReZ99tDWt682UotWsqTx8+mGCVTj3uvzkQXKDOvMQ9T+nJ4Q==
X-Gm-Gg: ASbGncukgK4GWSS/9HN1y/kgCDKm+RbfgP2xPeEdjAQlNJzN6ziWU0D0iljLR5YBuSB
	W1AghdrmROhOUBdM44vVSFBMTQTFlv4CrVlw3qInTB28iurHyXd9kZ4oh6r2hS/4sOlvGkOwn3P
	OjF/rtXQCeDNnRiKkGiFiCpnEVLIM7fGcdl2Udilrc9J4kQZtReIFvH7bSdpJHQyVRGFrCR6182
	r1UTuKqRgQxO0v3KZJAc9pk36cAizFnGh+t6oige/zw76FypiLyZzvCgS5kowbuodVvl/tveCYn
	5mBSd1UalIiUXmcW3utyLLa5UiRoBEAJlFlQsuS+RmNY/+eUtddRm0DYL5wmsR8bJ0xC/FPfQkr
	6uygJ9t8RHYhplg==
X-Google-Smtp-Source: AGHT+IFjxljLxw+g6msj/2zStIgexQhH3tclnIAh4+AmOpan6twS1irZOwFGMlz3N6mJw4r5TT41Og==
X-Received: by 2002:a5d:59af:0:b0:390:f745:bbfb with SMTP id ffacd0b85a97d-39132d7d4e1mr6797683f8f.26.1741527047554;
        Sun, 09 Mar 2025 06:30:47 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH 06/13] dt-bindings: clock: airoha: make reg optional for Airoha EN7581
Date: Sun,  9 Mar 2025 14:29:37 +0100
Message-ID: <20250309132959.19045-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132959.19045-1-ansuelsmth@gmail.com>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Airoha EN7581 clock-controller registers are placed in the SCU
(System Controller Unit). Now that additional pheriperals are supported
for the SCU, a dedicated SCU node is created and the clock-controller is
moved as a child of such node hence the register property is taken from
the parent node.

To support this, make the reg property optional and provide an
additional example for this case.

Driver supports both old and new implementation by checking the presence
of the reg property and parsing the register accordingly.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/clock/airoha,en7523-scu.yaml           | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
index fe2c5c1baf43..84e6c3d43868 100644
--- a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
+++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
@@ -51,7 +51,6 @@ properties:
 
 required:
   - compatible
-  - reg
   - '#clock-cells'
 
 allOf:
@@ -66,6 +65,9 @@ allOf:
 
         '#reset-cells': false
 
+      required:
+        - reg
+
   - if:
       properties:
         compatible:
@@ -99,3 +101,12 @@ examples:
               #reset-cells = <1>;
       };
     };
+
+  # Example with clock-controller in SCU MFD
+  - |
+    clock-controller {
+      compatible = "airoha,en7581-scu";
+
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.48.1



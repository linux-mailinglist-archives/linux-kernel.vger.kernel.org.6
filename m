Return-Path: <linux-kernel+bounces-254705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C4E933698
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A715B235C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F99125AC;
	Wed, 17 Jul 2024 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AGLklqya"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C828710A1C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196219; cv=none; b=c1+yfWUrwxVTnJsaFnfcgKMd1Br9CEO8by9bR4IddXVxUi/+p/HI+XfegPvoLSa2o5BoZxLg/oCK+i/LZTfZPviUKp6N307pcljQNXWsPJJxi1JAZYQ+xaijRKdGjiBwLf/PXd+X+DDZF+BmFe3Zafl6XnE+er7epYecxuntTNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196219; c=relaxed/simple;
	bh=ASIZxkswmDtZ+ZGB+DAdAIDL+TY12awedCwg0AK29lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNnQ/CpX3NRSjSJ2Dv6CG3pGIlJt9KuMtMsoZCyxO1GRlPyRe2neQHu0z8IX3JpXzMhFWKRildTrQWk/OLbogbZHftBd1j36y1tM1KkkybZXAOgDT5uo+g+Z65qtXenFFXKWFJ5g6+8QpvxTTjGUPEkjZKNj3c7w5iz5kVjjglc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AGLklqya; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-426526d30aaso45300535e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721196216; x=1721801016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArkPBFGt6K1MFhrYQ24ruK4j4xzpePBZL9fawM1R2H4=;
        b=AGLklqyaVbodhgMwRwXc2aa/0ZC0UDJoHkQqHptxZmpMCxa6MSe+IJ/XY1E/P3t2gd
         6lGjJKtpTNpfqnf2ugbnD5UDAb+kBBjfevLuJlIXf/rIuwxMhSzSXKlTr8dQohv4lt80
         dj6A78nDVcXRUCwot+v2UmClJkw6ZLOyD7MF9/jfaynQqi4FmpVY6CcUyCZWtAo/ZqgI
         zKVNl4uPEFcBvYZCKDY61t3LZl/2E4XaYg7mfCkPExhIJLH9X1ewraDwy4+yRC8K4qTk
         dv+CZ1D3MrudHD8a31jCXw7hIY+Xqr0Vu8731D/gaHJcDoFFVML3iQ9/Gs/wqTN8hG7n
         yKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721196216; x=1721801016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArkPBFGt6K1MFhrYQ24ruK4j4xzpePBZL9fawM1R2H4=;
        b=Fo0U66bOBgxsbY/YD8GGu+KjbuY2Nqrz6d/ImFJbn4tJbhxOEEZATmnnmndWrdxCS2
         z0IUGvotIk4f0v2LJcSaH4xcU3IrHvJsY2EYH116NQLCXkP4W8PT2PDdeFLoTT9k6kAH
         TnZkcphX2TeVfzI7jJpHwcJBus585QnF7GdQGXXzclTZsxTXD8m8zPvRC/KCmNlGGSLi
         4BYOcXSI8T+hX2H8tqsEIOLjKLVxh5514Gb46UuZtrnHJfyZw8l7liGZmoxN7yHcERs7
         Pf3nytj15Wer+VrbG8vjCO7PgrPg1d8vjyLUCHthtWZz5S76EN679Y4xaTkxQCQ+8jGh
         qS4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4ZtLuZ6C6Pso+Nv/mrffMomOV3XwGwjuaneHMFCRBlZcpbfqjV8lpOvXzxGBQ0UfW8aaiOMhaHhOXBMmmN8cUtxgPVeBn8SUhOJYt
X-Gm-Message-State: AOJu0YwGdqJOoloEkuxxSHNzdDvoQ3mGBeF3Am+zOssImC5YsxYJH1hT
	ZubI0iiTBcChZ/U1nkCK1MzkKFg/1b5dxzuDw5H501KwgPylE2BxcTDgFZXm3/Q=
X-Google-Smtp-Source: AGHT+IEGysgZPMM4acl6H0WMyDhumNTRPZzYYEvhuxVrBFVR//wZJdXVjhzyWhOID+qrmJtwitm53g==
X-Received: by 2002:a05:600c:4e94:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-427c2ce4a57mr4782015e9.17.1721196215982;
        Tue, 16 Jul 2024 23:03:35 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e8387fsm154887365e9.20.2024.07.16.23.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:03:35 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Matt Evans <mev@rivosinc.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 2/4] dt-bindings: riscv: Add Svvptc ISA extension description
Date: Wed, 17 Jul 2024 08:01:23 +0200
Message-Id: <20240717060125.139416-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717060125.139416-1-alexghiti@rivosinc.com>
References: <20240717060125.139416-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Svvptc ISA extension which was ratified recently.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..b52375bea512 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -171,6 +171,13 @@ properties:
             memory types as ratified in the 20191213 version of the privileged
             ISA specification.
 
+        - const: svvptc
+          description:
+            The standard Svvptc supervisor-level extension for
+            address-translation cache behaviour with respect to invalid entries
+            as ratified at commit 4a69197e5617 ("Update to ratified state") of
+            riscv-svvptc.
+
         - const: zacas
           description: |
             The Zacas extension for Atomic Compare-and-Swap (CAS) instructions
-- 
2.39.2



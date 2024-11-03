Return-Path: <linux-kernel+bounces-393838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E769BA611
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F91F2174C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958617DFE4;
	Sun,  3 Nov 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z6yqiISf"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C491BE6C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730645764; cv=none; b=eWtPL5D0l5xJsze2tEMCeoe+ivXXtt+uZflU6inRTVpqKUlYdWxue+Uugjo8/FIxPkF+u1FhLqey/ay2ZPhdM6Q0hx9ZO7BdeGeaGvYG/0Bw/SA+LcfASyhUfx0AFvYIFDODUGnzEJ2psvK4c3a8FFthhV+DBrOIBNjxtoC6RH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730645764; c=relaxed/simple;
	bh=DRgDwMt2Jlwx1evaYgD0rUR9lyNA/XwrvCTgk+IBusk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6Iu31RhdRJcOPOE9ugp8f18psPk0ncNWJa0NS2e+AUI/VC8wA4x37Lojcm3Kt7EIymIPBi0bA/uS6Y+kPuYl7ue1CvnQTmJqTAt3DRK+I5QA1uKwrBw6y6h7QdZtkvbqLFvu1d9vCIQ7MMq0dof9sNn+2Tvfqa9q6O0TUGSvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z6yqiISf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso29185815e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 06:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730645761; x=1731250561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lAswjGp3xf0DHvJRryPePimKYUd7lF/oN62wU2lB88=;
        b=z6yqiISfjOngRuB2+EacocBQYut+r7Ta6UjRUXgl+SQuyJWkOyhfMgJNYvBGNGsm2a
         Ydm7xAv7hq9KP5x1+eeye/B1TRVY2N3Q3u4RlxEI2htd7v2MHlq3nDNvJx9CEaeW/POS
         Iram1YERIiAdzJXmdzxuC3ZltRhD1kgO6ftfe6G49bK8pVKsy6tomu5pwkthRAlFBvln
         2AYtyGBp+9061PIfcLhBtMuNSjH4JArlV/YecWC+PqxFrMrXqLlM2MiaNSlTW+GAnbaM
         jzT0GJFbXPn5ZmAoOcZ9hh1hRwnIQpeYauP+dAAfqRisAdtVqoo0U8pCGQhjLdYIjWaT
         /u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730645761; x=1731250561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lAswjGp3xf0DHvJRryPePimKYUd7lF/oN62wU2lB88=;
        b=huN6EnyrCWZJbQtyPQZ9MZJYGZZG8y4G/7M3EGbAEaHBbCdqscv20ISORIEkIsxRX4
         s5rkPIZe+FwKBO3FatumGNwsSc5VvgEhg8fIOws0dPWell2W8B1mr+Vsj9yzqgJejVoW
         A6Wm8A1fiSRx5MTDn/UAkzGn7MN54XgfFp71ZPeOAaRK2BbIBfmQ6FB3IUV2qt6KOhws
         tRfhr+zEKPX1xgy1I1fMstpOEmb4oSlzBlRGuyz2H7u2ReLbU71V57fVruRIjqo4ehcY
         pARsXngN8gGbmJqVYhaUcDhDFvQO++I9xwM6G+fFcADzuEoOseZ4Dkk8ljn/O4pCMTKH
         oPOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1mIc1eAeZYlO7JSNTiR7aTQWOWYXTZx7c0KssVFiaP+hqWFTwSHm3E+drs5RieWxo0XL/p/Aidb6jxRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3puYe7AaA0Q4c7iSyiA5bsj9uEelhyYIske3LOzM/mbtEfO6
	qjNbMt0ZqZPNsbpgcJ++k1Huy62XtTgzpmcVO6a09JWffBNzQCcTqOukxZ26g/8=
X-Google-Smtp-Source: AGHT+IFXcE4yQOkwclhHZgMus+XU93hkWLBdlkgkjwLbfRe2UgNWPomwyzpyojRGnPIQGSxet5Zozw==
X-Received: by 2002:a05:600c:3b04:b0:431:6083:cd38 with SMTP id 5b1f17b1804b1-43283242a52mr72748635e9.6.1730645760870;
        Sun, 03 Nov 2024 06:56:00 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116ad6fsm10730912f8f.98.2024.11.03.06.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 06:56:00 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v6 04/13] dt-bindings: riscv: Add Zabha ISA extension description
Date: Sun,  3 Nov 2024 15:51:44 +0100
Message-Id: <20241103145153.105097-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241103145153.105097-1-alexghiti@rivosinc.com>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Zabha ISA extension which was ratified in April
2024.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 2cf2026cff57..db062107823b 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -178,6 +178,12 @@ properties:
             as ratified at commit 4a69197e5617 ("Update to ratified state") of
             riscv-svvptc.
 
+        - const: zabha
+          description: |
+            The Zabha extension for Byte and Halfword Atomic Memory Operations
+            as ratified at commit 49f49c842ff9 ("Update to Rafified state") of
+            riscv-zabha.
+
         - const: zacas
           description: |
             The Zacas extension for Atomic Compare-and-Swap (CAS) instructions
-- 
2.39.2



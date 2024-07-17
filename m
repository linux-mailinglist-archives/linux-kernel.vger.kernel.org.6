Return-Path: <linux-kernel+bounces-255533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 493619341DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096CF283BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1F91849C2;
	Wed, 17 Jul 2024 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="v/imoO4n"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49EF1836D6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239665; cv=none; b=dBfptJMJVkSd0mqQqd9zujnSWrj61tkY70Yh56ANmSVyf8zaAMFggbO4X2Hbv0P9RzVJD6UR4m4APUestJcrnH1Yaw78E7p56Xef3Y9+lZK/O7OiJZe2XePJwi3IIxBgqLFupcTX3pAQQEO3GhofxlJi3lW2s047ig6v76iDzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239665; c=relaxed/simple;
	bh=3hW/UtUp11LtwLQnUU2vlcRxK6mCiikL1CZIfS9wmwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOx7nDz8e2njQlN06KgkJ3uyozIArUzk6jg5DwpSl+wNbF5L0kJArQyCx8PETX8Bm2dq8nQYP5dCp88vhAC/D1sHBUoiaO7B+ur1+6oGa39gwr6k3b0mUrar3H+BFavTfbMGXm0sdPCcsjx1VFmMWFgBIRi1q+6gGEdRWznrzjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=v/imoO4n; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b04cb28acso884706b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721239662; x=1721844462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tFii3hPMYAW5WvkVv/NJHIyP/B7kBKP4c/1sTtNnLg=;
        b=v/imoO4nDz8jG1X/ufR9i9wm/GiGcbmYHr/aTApPLYMDK89YoyzpggLm8/t0gRvi20
         jR5SvJMrifb+QISMtTmIAQqfEc51tL9XSaPNe/1vt0STeWBjmuCI7geHv04eOfjq3nb9
         bzCOQXBtReYTpZyfpugXSqOmfIpXlISg1w6m3FUQY0YDymUSeNrQzVu9tDBPjnVIhN77
         ZaHO8N4d5UA43PO15rLjAGfyF9c/NDxwk1qfvorRn3e4IwFWsDg8F9s4gLg8yA6GOk/I
         1YvVi4SVt0pjplpiFfYQDxQ69FrRaUjGwa6GrSwm/EfH9CY7QDM/6TAZElcaglKFAoXl
         JLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721239662; x=1721844462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tFii3hPMYAW5WvkVv/NJHIyP/B7kBKP4c/1sTtNnLg=;
        b=Nwa0hSMxtAVqTWoVe0LCsrgXmCX37QraKKR81q8v4aF0l6+/eilKSXkOBJju85RzsE
         Wmdc3SKK3Haf3TgF3BTaJW1ZJrxRdF78yx0ZoDckC1SmOUNQFzqm13Vb2dmTcgyn6KC8
         VX8vB0nT6yySbzbE4hCX9nwZbaS1HQjZnQPq5c+tJ3+LbadxsDnnnHRClppcocAz8YeU
         6XtiJVD14KR2JyewZArhFZigkpE9PsAN1w2Ua8eKnRhi7/2cf31GHgnbyMLvvbRizmb8
         X61F6BpzlWEUPfu1JUJHeIbKsIFn/RM3wdc34uC7FlEYFt0Aum4lCi8wpc66130JPjFM
         2Xaw==
X-Forwarded-Encrypted: i=1; AJvYcCWU2zbznCfrm/NyGUlK1QqsJBdjkvah4bDaFQ/5av+2ynui188EVE0mB0dFc7rQLl5aEob7AMhZPqcj4Lm9B6eEpMWsgm2Wm+1h6xTt
X-Gm-Message-State: AOJu0YwpsCNBTz6t6J0OPoHJdSW1Hym1cQn5EGiAh1pmn2YanahCbeHr
	if9CmK0p4r43DNG0fKWzl15Gwl9A+H1C8LXzlln5cgSA+vkC/S2nStTlejz176Y=
X-Google-Smtp-Source: AGHT+IGkm7y8DzyVw6YqO18fnbVUrmjLNXdtGQCu/ytr0h3ai80Sb6oKvYQECtXt6ZL5w+lxnqy/1w==
X-Received: by 2002:a05:6a00:1944:b0:708:41c4:8849 with SMTP id d2e1a72fcca58-70ceeb7e7cfmr679984b3a.9.1721239661951;
        Wed, 17 Jul 2024 11:07:41 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c969sm8432332b3a.35.2024.07.17.11.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:07:41 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 2/7] dt-bindings: riscv: Add Zicclsm ISA extension description.
Date: Wed, 17 Jul 2024 14:07:22 -0400
Message-ID: <20240717180727.4180475-3-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717180727.4180475-1-jesse@rivosinc.com>
References: <20240717180727.4180475-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for Zicclsm ISA extension.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
V1 -> V2:
 - New patch
V2 -> V3:
 - No changes
V3 -> V4:
 - No changes
V4 -> V5:
 - No changes
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index cfed80ad5540..9f6aae1f5b65 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -317,6 +317,13 @@ properties:
             The standard Zicboz extension for cache-block zeroing as ratified
             in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+        - const: zicclsm
+          description:
+            The standard Zicclsm extension for misaligned support for all regular
+            load and store instructions (including scalar and vector) but not AMOs
+            or other specialized forms of memory access. Defined in the
+            RISC-V RVA Profiles Specification.
+
         - const: zicntr
           description:
             The standard Zicntr extension for base counters and timers, as
-- 
2.45.2



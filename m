Return-Path: <linux-kernel+bounces-277122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E7E949CE3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56871F245C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171DB757F2;
	Wed,  7 Aug 2024 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DlXn04nX"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2D763EE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722990719; cv=none; b=Ett3vzCce/RwEWnKeZcVh7MGfflkkN22iElzQrg0CpcGizGpsOa77D/vtVIQhQQ7rmAASdqWqm1ffoc+YCsQj5XgIIWmlfeeSwLfnDiD+pMJS0oH3HEMVHbLKSZaNVdCRrv5D9zmQW1XF6sENKvPUrRC5RDh+ghEJEVMg1q9rWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722990719; c=relaxed/simple;
	bh=/SkqORRprGraSlNdCA3N7P9uibYmHsQsfL3EwVWnJvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i3BFWvIES8FaaTNFD4+KMLU0han4URlH5NT0cj+hglA8pH9HfYlcwXSz8zwiMmXF8pjsJIkqhD54pwlF9u+W297QzmsvjZo8owwv6rPbXz+av0ELm5/VL5bYChSM3tOe/TmjUX5wHLFpr0lXDp92rTIirC3BzX4UOhfYAv0fETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DlXn04nX; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db14cc9066so764470b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722990717; x=1723595517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QC5zCLZI62pAjh3MZXl2DmzWweDYeenNtUhW+BVEweY=;
        b=DlXn04nXTJekVqRpwSIxNoQIGqEfhWnTh/eMWYD0aU4Gl2zc33AkIORxrxX1hcYr3/
         qnF62To0Sfh1L3ag86M/x5uMYD+iPPO7dnCkNuMX+5/ePZQFbZcNrl5xbEQM7tWoMSCF
         0iYgWxq4HRcpS6lT1IhXSgmlQMmvVsf9STLn/Y5Dm9FV71LN9KUPOZ6VrL3kq0RVa9v8
         Qd6VqXgw5jOg/jGG7GBIpdmVSVQh5QUrYwhDU+sfKo6btwCFgUjG52toppdQKF+z81mq
         VaxHzyOLTQl8xogN03bHJxSTSoFZT0P4k3E7V1o7KZR5BCMQK9jPDRurP4bGZmyNGE7K
         3E+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722990717; x=1723595517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC5zCLZI62pAjh3MZXl2DmzWweDYeenNtUhW+BVEweY=;
        b=CpR7Lbhx0GAPwRaDz3n7IARu0BhBZK5+xmUfX3R1ghx3LeF1Amj8UFJkJy5+X7RjT9
         AbM50AMhnwMyk/9u6C617UPRJ7aVgpCoJBMITFvhUlqlXEl1ycgjTU1ZPDpLKoKqZ9b6
         wB+niYKGb3kqBEnlLfl/s2urrqLbc8VQYr3ZGVNhDHpRRHjQkQAh8N0lz2GX6l9rvKuw
         dkXX2q/LyqlJfiEgNCsRR0pv6alggz7FSoJyLZckj0aQD5tBVfXV34TMXaYyL+JNQueF
         EBeJ2/Yq/de4WTgmFw4SzTd/PWAIxHuC/QZaoXXjZ3G1ETomqvMzMqmDw7sxu7vWIVjm
         GX0A==
X-Forwarded-Encrypted: i=1; AJvYcCUH7FXPBmAtXlMXLwkg9kcTgwO7qJ/2HZ8lsfws9ELVVLTOp72EnIFR0fmnXhl7VmHTSTmQj0FumuNxy7dmPOCqYVyG+HVkXpGKC0jg
X-Gm-Message-State: AOJu0YwizYAzF360pXE1p4uMBjOdBV/+mTUGoOFyYEF46rJrNYBAf/zV
	VRuUyo1zkL5/rbvs7cEt+ccOyO9Rf2Id+4kMBNXe0pMmqA+NAkEJG/gQ1WZTdUc=
X-Google-Smtp-Source: AGHT+IEomO2rWS8N04dkJc59Kgkws+mWDwLUt7ddjCqe47b0HovPqN/7PDFgjz5yTN0u2e47G0ibbQ==
X-Received: by 2002:a05:6808:d48:b0:3da:e246:36f9 with SMTP id 5614622812f47-3db558310d3mr21688532b6e.31.1722990716821;
        Tue, 06 Aug 2024 17:31:56 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5aasm7476174a12.6.2024.08.06.17.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 17:31:56 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 06 Aug 2024 17:31:42 -0700
Subject: [PATCH v9 06/13] RISC-V: define the elements of the VCSR vector
 CSR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-xtheadvector-v9-6-62a56d2da5d0@rivosinc.com>
References: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
In-Reply-To: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722990701; l=930;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=DIdTxrF0tPCTSVf2TD2d8xS0VDMxpxf73XTxU8DNXFU=;
 b=tCigg/1A4l8IsEtr1/y9NTwTRU5XH+2Tl9Svmx0pkqdzZuPXykgTqvIzRfkbgnNWcTMSLRxxz
 q60DgQzkkPUAT9JnB8p+nZJ8SdgxaBb3cQ8syWdxfgoAzaldKwS912B
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Heiko Stuebner <heiko@sntech.de>

The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].

Define constants for those to access the elements in a readable way.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 25966995da04..3eeb07d73065 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -300,6 +300,10 @@
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
 
+#define VCSR_VXRM_MASK			3
+#define VCSR_VXRM_SHIFT			1
+#define VCSR_VXSAT_MASK			1
+
 /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_SISELECT		0x150
 #define CSR_SIREG		0x151

-- 
2.45.0



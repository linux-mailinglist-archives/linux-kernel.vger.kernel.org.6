Return-Path: <linux-kernel+bounces-305966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B5E963738
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56BC4B23D44
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5E1B813;
	Thu, 29 Aug 2024 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TASeHDFL"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D3DF53
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893317; cv=none; b=tNXjjkzpJj4oKHxE877cJgbR9sF7GhQqUpJwG/y+/VEWRHy6hBb2I773d40tNVurlaNj8UV33wBMR70fbbR2PwwzCvYMOwb++2SOlWCz5ePOncrJSAnRAauiky+d9hVR0FJroqYjdgGOF3bk1VlbDc8B9LtRiKP8tgQFMK9GXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893317; c=relaxed/simple;
	bh=aNo8TVxZAR2bze3M4iKFYApRyORSbSq2cezAP/8XpqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggdiVjNIoeDMhExD7xKjFPRZ0tN1saIDzkBPNtMiHbimo5Q+sEeXhVLXTJmrrrTQABDiSddkFLG4Ou9JZAgXYD0aBhO/pI6aMrBcVH47MTO5zR0+f0cHTB8LunHWyaSRQ5IPBwQo7irFxr9K5nw+0t9aliHa28mfxSChGp2VIWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TASeHDFL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7141e20e31cso108697b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724893315; x=1725498115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHFcN3ChX0djp1RepjgsjW/fBWZ8xhYPoH7rbGZfY6g=;
        b=TASeHDFLIkt2PiSKQ3H3ImBJy8KHJw6ZDwYZIk1xuW/sVg448XVtDiXq1DTdk7hfk6
         Bf+lJ3O62Aa49c4Zs6CNaCg/To8psc8c+rh288cqZzayNmeNM17p21PvU+L4T9j5nhu+
         hWC0pbsAprWK/JIhjsQm+DFG8zJYW+JNGzweUNQ9NN5YLTo1pWDLH0cxCMVITZZeWfsr
         mJ7JRGIFdXgprPdWTDw/LNGdr1PEDBpTRzmLyxxxCEOL8AKtXD8ut9yrh1v4R6wU2wtc
         ZYI52DkRzzJBWsXMUDBrLx2Sf5Hj/SL2S8UZELR21LIO/phxWdaKfb1nR+LFvTc7i69/
         ZP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724893315; x=1725498115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHFcN3ChX0djp1RepjgsjW/fBWZ8xhYPoH7rbGZfY6g=;
        b=Ou03Q1D8PEmFmyreYGfl7S/+g1ADzD81erh4NJR5Ie3Wd9ySBj7cyTnkLjckhn5ywZ
         IkGkni8R2gKRcvJwugNbY0P0bcPcvynMH9THz2KbFri8lZzZMc0znW22PP9wQnWkE856
         YtxTJJMRUBKeXJVp4iEHuo1CMQjn8LDXKGeEOtlQgsW5liYZDqTdHYFKn2faCxrS/1+l
         e58jBBpDtWObeNN8++d20I9IDo61RHwn4YvvAnKUr+QMihaYpsCEUd7/d8zhuY782fK7
         vjEmzW+zkRXNvy71NTw1Rc6/v9Si83YmA5t5Mw33fu4Z9mMV3BEsP8cj9ESKD4dph3ff
         DTeg==
X-Forwarded-Encrypted: i=1; AJvYcCUafw43Da0V7/EH35zeOYMptzWKKtL/Rc4ITarQo8GvkGNMTBwYbkgkzEvuJwo8sHq1XYRbKBozv+WD8Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzfqmzarMjq0At4cLr2YmtNqoZDR0mtbjDYpWLE5ShfEtDJXbd
	VYqau43ZKFaFDdemF/gsUXivWCor9RoDMBPcp+kOMtsCsWF5j6Z33XqpfrtQw+s=
X-Google-Smtp-Source: AGHT+IF8CbBSlekEoVPXOLT8SjVqvpI1Vr212Z+9HPZCWCL06zOdU0IItmLQYG4ajt+f+ix6KHKJ7w==
X-Received: by 2002:a05:6a20:d8b:b0:1c6:b45a:df51 with SMTP id adf61e73a8af0-1cce1022303mr974109637.30.1724893315562;
        Wed, 28 Aug 2024 18:01:55 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a4dsm89670b3a.17.2024.08.28.18.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:01:55 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 01/10] dt-bindings: riscv: Add pointer masking ISA extensions
Date: Wed, 28 Aug 2024 18:01:23 -0700
Message-ID: <20240829010151.2813377-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240829010151.2813377-1-samuel.holland@sifive.com>
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V Pointer Masking specification defines three extensions:
Smmpm, Smnpm, and Ssnpm. Document the behavior of these extensions as
following the current draft of the specification, which is frozen at
version 1.0.0-rc2.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v3)

Changes in v3:
 - Note in the commit message that the ISA extension spec is frozen

Changes in v2:
 - Update pointer masking specification version reference

 .../devicetree/bindings/riscv/extensions.yaml  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a06dbc6b4928..a6d685791221 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -128,6 +128,18 @@ properties:
             changes to interrupts as frozen at commit ccbddab ("Merge pull
             request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
 
+        - const: smmpm
+          description: |
+            The standard Smmpm extension for M-mode pointer masking as defined
+            at commit 654a5c4a7725 ("Update PDF and version number.") of
+            riscv-j-extension.
+
+        - const: smnpm
+          description: |
+            The standard Smnpm extension for next-mode pointer masking as defined
+            at commit 654a5c4a7725 ("Update PDF and version number.") of
+            riscv-j-extension.
+
         - const: smstateen
           description: |
             The standard Smstateen extension for controlling access to CSRs
@@ -147,6 +159,12 @@ properties:
             and mode-based filtering as ratified at commit 01d1df0 ("Add ability
             to manually trigger workflow. (#2)") of riscv-count-overflow.
 
+        - const: ssnpm
+          description: |
+            The standard Ssnpm extension for next-mode pointer masking as defined
+            at commit 654a5c4a7725 ("Update PDF and version number.") of
+            riscv-j-extension.
+
         - const: sstc
           description: |
             The standard Sstc supervisor-level extension for time compare as
-- 
2.45.1



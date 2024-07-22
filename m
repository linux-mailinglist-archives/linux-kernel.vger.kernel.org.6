Return-Path: <linux-kernel+bounces-259419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734689395C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9731EB21703
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E537F46542;
	Mon, 22 Jul 2024 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="olQnCKl3"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE3446A2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685495; cv=none; b=PY47sAH4h6Mmt77EdbWs4+nfQ5OOYI9ZW+hTFr10JqcYO3GZh8X+XJZCKQqjYpmQi/3/Kt0nNtC7OY4CqomWRNcx+mMbiUb3dKx6YejRIahwK5V+xdJnd6yVwZ+9v5w1dumyYLWU+AMV9slCjwv2y8UV9m6kE3eyUMJVqvyNLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685495; c=relaxed/simple;
	bh=ZzH0VgSdYutk/uKY2omj651o9v+E5HP1BijtgXJzAp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AI6+1lGJFLyC1t63vcqUBBx2/SWdTop08vN3BTOU/l9DaRtgNEH1rSFZTZ1yh52w+I5wv+E2uXGay0c2UaEpuwFC954ufQaYenOuEAmLvWZCvfYphrz+o7WbbldVL2k7az20y8U4onXJ43QA5vSDsrlVA8AcxN2ZUhMNUHCP2YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=olQnCKl3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd66cddd4dso1156485ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721685493; x=1722290293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWtR9ZjYZiSKNZtqnpkUxp+qNZzbKrCzo+6HVfyCbsc=;
        b=olQnCKl3AieIkZcrRuaABkl9o11ZO1iHeP5giFbSwwHDnVm6kVT/pkyOZtUGProuMm
         j2IDkre07igoU1eC2BNPKuZcPN0oJP3a8b8Hy4H/3cwan26/JLHde3vrkOWZga8UpNsC
         QN0ePW6aFXJv4QW4p9ZLZp3zGupa+G2dRbrHOmTTrilH+p1SedD6GOJ4dAiiRsB1v1Ur
         EnWkW8nlnGNQvt9eG+Ac6if6d0Bhw9XQo8xIGbiqxCzB5yp6ydrlYbdKfSsXkSmXqLEn
         Qd6/rV8tfcEs08bP9LncfQ+NTJFrVYfzfjrUgcYhsV/I8VMshQXoERn24nSu+AXLjWXM
         mQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685493; x=1722290293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWtR9ZjYZiSKNZtqnpkUxp+qNZzbKrCzo+6HVfyCbsc=;
        b=vScMrHfb0TZT6PjpZXG0OOLU5zMWFxEpi+DzIDoPUZb7ceMosD5jOWbYGFTIuBFHIU
         o9lfWd0dEVvL29nX5z3gE9SHCQ4Knu1+B4ixymfqS7A2VDVGhb7cdKhQOV3YqkcjDiIU
         XKR/w1JjYL+20Rtuf51JEnsR66FZLlfsVHL1DEK3gMD/oe0rrUQP6bF57rjxqr4mjDyz
         JZD8mvcomdnWaw96PaQezoROpldmxfIOQqkuth35LCLMhLbB3F9Z6gdhl+BpfA8Af8b4
         AVxVPSVGGiXJyESJnsx7eTN2V6MpmS3ejTFrEekTjv6KoCmrFWi3gkQ1UPg+NzMip3g3
         N6mw==
X-Forwarded-Encrypted: i=1; AJvYcCXnna4NhFT1GEsKC/bBdUvrGj9mHRwI2bpXkwttXlw3JIQJeS1JL75CYBpPw2wV2apf3ber4CoMDXxbV2X+O+SoFPLwsSg9UP8AyPyy
X-Gm-Message-State: AOJu0Yy9leZWljPqAvBuei21bIEG0X9kC4JIJR/9tnu4UBYRkNZAqBJ4
	TtJu53m1kRMlp2yF8Jt3mQDuCU+nJTrp0aho4i3Wu6+zaOk2BMdRlQk3ogVF41Q=
X-Google-Smtp-Source: AGHT+IHTkfkTbO9687i4Pn2+RihIVEo5h0oCdzVOneV1P9azYW/tvjOn1QPbNPDGhVqGXxDgJEBHuw==
X-Received: by 2002:a17:903:41cc:b0:1fb:7c7f:6447 with SMTP id d9443c01a7336-1fdb5f6b353mr10313025ad.25.1721685493071;
        Mon, 22 Jul 2024 14:58:13 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f44f0d4sm59997775ad.219.2024.07.22.14.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:58:12 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 22 Jul 2024 14:58:05 -0700
Subject: [PATCH v6 01/13] dt-bindings: riscv: Add xtheadvector ISA
 extension description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-xtheadvector-v6-1-c9af0130fa00@rivosinc.com>
References: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
In-Reply-To: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721685488; l=1788;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=ZzH0VgSdYutk/uKY2omj651o9v+E5HP1BijtgXJzAp0=;
 b=nZEeYwaJqqmvsjfP3STCkMzgTO0YV5QHpTcK9EbgMZdRapnAEgagfXnzOhMbcFXpInDpLxRU4
 H+rbxMq8H8mA7REaKmytn+kSbxVFuc5Ssov3TqrIQwafO799xnPzEis
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The xtheadvector ISA extension is described on the T-Head extension spec
Github page [1] at commit 95358cb2cca9.

Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc [1]

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a06dbc6b4928..1a3d01aedde6 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -556,6 +556,10 @@ properties:
             latency, as ratified in commit 56ed795 ("Update
             riscv-crypto-spec-vector.adoc") of riscv-crypto.
 
+        # vendor extensions, each extension sorted alphanumerically under the
+        # vendor they belong to. Vendors are sorted alphanumerically as well.
+
+        # Andes
         - const: xandespmu
           description:
             The Andes Technology performance monitor extension for counter overflow
@@ -563,6 +567,12 @@ properties:
             Registers in the AX45MP datasheet.
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
+        # T-HEAD
+        - const: xtheadvector
+          description:
+            The T-HEAD specific 0.7.1 vector implementation as written in
+            https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
+
     allOf:
       # Zcb depends on Zca
       - if:

-- 
2.44.0



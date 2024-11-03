Return-Path: <linux-kernel+bounces-393728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D4D9BA482
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDF6B21107
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 07:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA01F16087B;
	Sun,  3 Nov 2024 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbnUIPyl"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0EF15853D;
	Sun,  3 Nov 2024 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730620239; cv=none; b=Q6uWE8GMRX+QQ54U0EtbOZLMg5h+4w5bD5VSaRdzEP0JS7VCoz7Zm1/a/ROwWSQMOeepFQTzdxncGBo1vQpqwheY1qumWg1tGl5Gz7mKAXi+90o4KrUxHKJfUyJc1ClweFYo1q/1NlCEJyrUOrgBwXHf4nZAnMBjvPGQ2sMnASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730620239; c=relaxed/simple;
	bh=TebZqSPKVqyKP7bCiCs3wWrC0grssWV2aeOt4sHyoRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDPWptgeRxhwGXoqMtu8nEHkLMtNpZ9fLtXyQejAFlU5wpNbouh/vyBCbNp7dOouxZJYUXiNc9oqTP9lkef37G1GeX7WW0ho79CpftmZ8G2DiUmGN4f/Hfe5nAyAlrykFpwX5iJ4Zy5XJ+YLaYJssTBvvk4U7hBK0S7LanyX/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbnUIPyl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71ec997ad06so2682288b3a.3;
        Sun, 03 Nov 2024 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730620237; x=1731225037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHcOCAQRVF6wDwCpz/Ofc5RAAihYPSYxf02RxaoduNk=;
        b=FbnUIPylsa6ckTIcW6ZAuJxsrdo2sNTjuQOtegGWLeXzNR6wHWAVdfSpd9HwlM7fC1
         BRJ7j+tedkK9hYw+KsnUo72eoWgnlgL9LPuGjb/lutVIK08lDbXQayoBpxFgduILldey
         iSnd/W+l+G+52EWsycXqmfmPcafdSjen58ArEaXWr0BuFVoliUtBBWonWbVtyz6G5qcg
         eHMFwfXJRWa9BV0tIcW3HEQTzaSKJlCosQI2BVVHIFYE8q9D4b1/Qo75WgPzRBUhCCZ5
         nOWRMzauwvx4PVbh9Q3arspa8y1OMnDSVZmRL+qoLS4DrEcJxAkwze+7k5N2jpTOvsLJ
         5c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730620237; x=1731225037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHcOCAQRVF6wDwCpz/Ofc5RAAihYPSYxf02RxaoduNk=;
        b=Pw9ffNMnOGLOKCxLe3aqwJvZJlyWs51xmD7p3PM3ltpF+3Ewr3lCruDKMYxGEK8zHW
         xdReXKTOJg98+pRD27iWBYYEVSVnJXZVS/GrduPeS0tvtRfoYHXrmp7/tdvSDR0avRKc
         T23oZp1xN+q1rWBKJMAdGEHN4Oiy9+SKD0s0PJ5uqKyD7To26YjMWs36Jdxfy+MZ+Hx3
         zU9YPK8h7OnDPChy5DKyM1xQATon9vLPWHgxE59b6vDCtxEYTNSjPT9CozMRez1KmAXh
         iQ6RHAKy1ihqSqyFSVquKFndA5M0grBrAWA2Ru5q0ZHg8KWikcgWI8Qm3QGp+r2ikNwx
         Re1A==
X-Forwarded-Encrypted: i=1; AJvYcCWUjFn9C+BglusgvKH3FFxD+cZrB4cAOgOZ2w/SUkRS0anKjSDRqkjtkBGge2RDEag3ZPUBsZKQ1opx@vger.kernel.org, AJvYcCWpSej/dzSQPG3Nk+Pt38jEoQDS56QRJMA1uT9Pt/I8UuKspRfw4DFFGYiaSf53SXBenHlAjjp/fwB+fgNe@vger.kernel.org
X-Gm-Message-State: AOJu0YxCFfMgNNmZeQxM5gbyM5/fzRW2jTmXc/Q36L7ACiuxRgRLJ9QO
	POouO+acDyFH0W6gX0Mjx37yxd9vqZfRdEvvRqxPRS85caMCTkOK
X-Google-Smtp-Source: AGHT+IG7/wFicHX9OEUYDqktOUiK/uVF+gBMW79yuPguvpjtQ5yao4SckDLDe3KLDsePTQwcfpW9kg==
X-Received: by 2002:a05:6a20:734c:b0:1db:d756:6136 with SMTP id adf61e73a8af0-1dbd7566139mr99827637.3.1730620236993;
        Sun, 03 Nov 2024 00:50:36 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc20f64asm5409704b3a.96.2024.11.03.00.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 00:50:36 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andybnac@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: riscv: add bfloat16 ISA extension description
Date: Sun,  3 Nov 2024 15:49:55 +0800
Message-ID: <20241103074959.1135240-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103074959.1135240-1-inochiama@gmail.com>
References: <20241103074959.1135240-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the BFloat16 precision Floating-Point ISA extension,
(Zfbfmin, Zvfbfmin, Zvfbfwma). which was ratified in commit 4dc23d62
("Added Chapter title to BF16") of the riscv-isa-manual.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 2cf2026cff57..99d8b70fa321 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -277,6 +277,12 @@ properties:
             instructions, as ratified in commit 056b6ff ("Zfa is ratified") of
             riscv-isa-manual.
 
+        - const: zfbfmin
+          description:
+            The standard Zfbfmin extension which provides minimal support for
+            16-bit half-precision brain floating-point instructions, as ratified
+            in commit 4dc23d62 ("Added Chapter title to BF16") of riscv-isa-manual.
+
         - const: zfh
           description:
             The standard Zfh extension for 16-bit half-precision binary
@@ -467,6 +473,18 @@ properties:
             in commit 6f702a2 ("Vector extensions are now ratified") of
             riscv-v-spec.
 
+        - const: zvfbfmin
+          description:
+            The standard Zvfbfmin extension for minimal support for vectored
+            16-bit half-precision brain floating-point instructions, as ratified
+            in commit 4dc23d62 ("Added Chapter title to BF16") of riscv-isa-manual.
+
+        - const: zvfbfwma
+          description:
+            The standard Zvfbfwma extension for vectored half-precision brain
+            floating-point widening multiply-accumulate instructions, as ratified
+            in commit 4dc23d62 ("Added Chapter title to BF16") of riscv-isa-manual.
+
         - const: zvfh
           description:
             The standard Zvfh extension for vectored half-precision
@@ -605,6 +623,33 @@ properties:
         then:
           contains:
             const: zca
+      # Zfbfmin depends on F
+      - if:
+          contains:
+            const: zfbfmin
+        then:
+          contains:
+            const: f
+      # Zvfbfmin depends on V or Zve32f
+      - if:
+          contains:
+            const: zvfbfmin
+        then:
+          oneOf:
+            - contains:
+                const: v
+            - contains:
+                const: zve32f
+      # Zvfbfwma depends on Zfbfmin and Zvfbfmin
+      - if:
+          contains:
+            const: zvfbfwma
+        then:
+          allOf:
+            - contains:
+                const: zfbfmin
+            - contains:
+                const: zvfbfmin
 
 allOf:
   # Zcf extension does not exist on rv64
-- 
2.47.0



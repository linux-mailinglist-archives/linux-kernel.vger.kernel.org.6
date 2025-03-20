Return-Path: <linux-kernel+bounces-569528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7219EA6A434
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C25D3BFC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EA5224AF2;
	Thu, 20 Mar 2025 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="sgealLsZ"
Received: from naesa04.arrow.com (naesa04.arrow.com [216.150.161.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291242080D9;
	Thu, 20 Mar 2025 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468101; cv=none; b=f209xR0eDMwLg8ycg8KtsAJ+0fh3pYOUghgeAS2iVRTT+KKriPlRYtiVZo0fcthN0ZoIEb4eC1pnKD8YRBsnU6YHybAQMaCS0tw03SOfnfs8c5hHZZPUpkpoEhriq5bjNiF7pYNmKaXo1qs4cekDC1v2kbCWmqVBhy7197ESRWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468101; c=relaxed/simple;
	bh=H3wnlGqXSSS/oiZRRPE2KJNofPHwThcoVMkEwdUNQ7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iv7jR2mlFnTQ9TVmY4vAZNHIh+ffi6uJb6Bm3IPBGPDHl/icHpBO07W5B/jI70Omx6OVPy5onT42BUc16Mlz69JGUnfIjtRGyt+XwNitUWkhL9YI/njmMRKPwN1QGL20C835xzJX1mNW0QnzTG4Q+X3glYY2JUy8iTUxqAE29xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=sgealLsZ; arc=none smtp.client-ip=216.150.161.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=2708; q=dns/txt;
  s=NAESA-Selector1; t=1742468099; x=1774004099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H3wnlGqXSSS/oiZRRPE2KJNofPHwThcoVMkEwdUNQ7I=;
  b=sgealLsZ0kzhVyd4DTkeiERkjmZ/JLSA/4PxowSsJMHSYu+irXWKOCyh
   IGlMW/Ij/e65ZknKrL2+p+jRaiMT2rpEvR0LfNXYDpGIMpdQd0DzVJm9T
   idw1FF3tRLjEv2rhM6lO8iHGFJyhJcO1AvCNPRAOZ+XNwpIQP91ZK9Kxa
   7j/qbOnWgMqR3r/0JnOxdlKGF7GzTOtMv7jxuiVKFPuO0JP3fq2l0f+wy
   pz56xb+IOGXn6XVMED2w4Nr2AY4Qyt9LRBsNNRiA4O7nHhaVHn1anZA8Y
   xE61Kk72+5e1Id4dc6QRooK8jEjH5VYYT8fBHZ9O97w2mQHVbQIK41Qkn
   w==;
X-CSE-ConnectionGUID: JOlNPfBESO+lmtvRbbIzyA==
X-CSE-MsgGUID: m3A5hBjFRaCAlw9BfkjPpw==
X-IronPort-AV: E=Sophos;i="6.14,261,1736838000"; 
   d="scan'208";a="80263111"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa04out.arrow.com with ESMTP; 20 Mar 2025 04:54:57 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 20 Mar 2025 16:24:49 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl,
	Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] dt-bindings: cache: sifive,ccache0: Add ESWIN EIC7700 SoC compatibility
Date: Thu, 20 Mar 2025 16:24:44 +0530
Message-Id: <20250320105449.2094192-6-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
References: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Mar 2025 10:54:49.0944 (UTC) FILETIME=[80946D80:01DB9986]

From: Pritesh Patel <pritesh.patel@einfochips.com>

This cache controller is also used on the ESWIN EIC7700 SoC.
However, it have 256KB private L2 Cache and shared L3 Cache of 4MB.
So add dedicated compatible string for it.

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 .../bindings/cache/sifive,ccache0.yaml        | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
index 7e8cebe21584..579bacb66f34 100644
--- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
+++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
@@ -39,6 +39,7 @@ properties:
           - const: cache
       - items:
           - enum:
+              - eswin,eic7700-l3-cache
               - starfive,jh7100-ccache
               - starfive,jh7110-ccache
           - const: sifive,ccache0
@@ -55,10 +56,10 @@ properties:
     enum: [2, 3]
 
   cache-sets:
-    enum: [1024, 2048]
+    enum: [1024, 2048, 4096]
 
   cache-size:
-    const: 2097152
+    enum: [2097152, 4194304]
 
   cache-unified: true
 
@@ -89,6 +90,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - eswin,eic7700-l3-cache
               - sifive,fu740-c000-ccache
               - starfive,jh7100-ccache
               - starfive,jh7110-ccache
@@ -108,6 +110,22 @@ allOf:
             Must contain entries for DirError, DataError and DataFail signals.
           maxItems: 3
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: eswin,eic7700-l3-cache
+
+    then:
+      properties:
+        cache-size:
+          const: 4194304
+
+    else:
+      properties:
+        cache-size:
+          const: 2097152
+
   - if:
       properties:
         compatible:
@@ -122,11 +140,31 @@ allOf:
         cache-sets:
           const: 2048
 
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mpfs-ccache
+              - sifive,fu540-c000-ccache
+
+    then:
       properties:
         cache-sets:
           const: 1024
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - eswin,eic7700-l3-cache
+
+    then:
+      properties:
+        cache-sets:
+          const: 4096
+
   - if:
       properties:
         compatible:
-- 
2.25.1



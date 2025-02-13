Return-Path: <linux-kernel+bounces-512176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B78E4A33525
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84597A312E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7A81553BC;
	Thu, 13 Feb 2025 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcstMuAr"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE91494C3;
	Thu, 13 Feb 2025 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412557; cv=none; b=ZnJXGvRXnIJc2kvKILFtRsIj+1Ih9e3Pug+0NfT/VFYUP4GyA5N8ZIxgWrejSU9/4nzXtOPKpgGzwCQHnVNyOWGdhpksrPDG1rOCI8TVjY0ZctPuftqH+qDQgw9XL7bORp79+VjDiFlFnEwTyjFypfc8kZGfbOPGLaHWPvplf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412557; c=relaxed/simple;
	bh=3qPF0chiHK722rfk75RnUIuKB10cPDIrLgoIBvfCQgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPtoafTzVtbnqtGdnJB7MK0UytGUGmUWXNgcdOlONmdd4iiT8QbtHwhpu3LuAn9+NR6jqzvtNEvtO7KsiMWOtHWmEk7Au5G8TN8Bi7Ufjuefqrp2zYYPg5Caq1bK+yTtOMyOdrD4Fd2SPLM+dEh+47vhGm4SRQEJg0aAQoC1Cn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcstMuAr; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c07b65efeeso15159585a.2;
        Wed, 12 Feb 2025 18:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739412555; x=1740017355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMzBCZUxKjxBjINW4Q8NZwZbLLoL9o1dpVjVjazylMA=;
        b=BcstMuAr7CK9NSxXF9fN8HL7fyMe+H0XFe3eNOXHBORw5M7f2fIIuGoyiM9uBs89A6
         39Id96Fy7R2WtiIGEOcDCfdHyLEl3xc4gjUdmxzHvWD60ZyXAkXW4liEE1XzlQgYIRbi
         kwgLtAf6jizSzJC0EW6LkBcqnO5uOMDTWkiFR0YmJiKuBNjTdVT1vuYP5apC/bphxkMB
         foapozV9FxBxE1h1I0OKVY1fK16OqkHzqhkDltPHjk9JCQoFzRxLBxA0Bg2TAgiZfy9y
         Hy2wUz/Nifa/Vb8gYBMCaAGe4yPqetKymyWk2eLOR5L9Ujk6XX3S11K3irv0CxvA9e7W
         cjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412555; x=1740017355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMzBCZUxKjxBjINW4Q8NZwZbLLoL9o1dpVjVjazylMA=;
        b=UI/610YO5SyPInvLhicmvfeCwAdseiYY9ntKrdVcg9go3OLrPkw0eKhhSQwKXYqtl7
         HGenCWeeOFv/iP/8sByhxleLi+BHcCkYaLPwUvfi6OoDDRaTvRc1VhZhYp4rUR9Tw+pr
         eErbsB9USwOT0tDQXCl4g/DCfqwCD4ilxb7yiAitpfvI5HemBHetFz5FSfsgaSnXPpsN
         88iAF+lvJi3ZAbpiJR4OTjz6af5xMSgVDrAR+AekvJ4gptVRFeG4OT+zYn9/DROeF7xy
         poMEQ92oleUXY2tqb3uChfUxh7LXPR/c1HqomJA+qMJpp1Q7DkOxbihIHs6MwcZBhDRG
         /g2g==
X-Forwarded-Encrypted: i=1; AJvYcCXGxcR+eKH4b3V3QM9ImhdJq1uN/XMpalzPxnFfli2buCO3JhmckdOtzcb7sDBRo6g9ZGsQTt5+v4z2DEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8MtE3fOXaEdIysUglgBGCksOnxFOYxMfIUepYviaJCyxVqLSy
	chKsjCEqHX1mUGKQQxzjoRk4m5915lZbzUah2ngeSFEQMu6HtC4x
X-Gm-Gg: ASbGnctoV5ed4OjKR8FT2sQ40XTLph+t94BFKN0Z369enz5/fyDLZuKoC0ab4mn5Rt9
	69/XnKZJWRupxThxptGZoP28sfEsfVZSo2an6pyTSowoZa3wt6fbuJE+fyxny3yJzCAvmkZhKlU
	xPlYYI5YABESl95opwBljZ/+pvyKjL3iBiWh049VBb4TrWcpUGZRlKM0Y9czmHmrI3NqfOL/O5r
	/3uRnvZiJZXn3jSbU+KafiPiOr/WJ8oMa5D5bQREWG5r7qHq/9lLkJfTUgVn0Td+Cg=
X-Google-Smtp-Source: AGHT+IFzSpeYmkmhYNfuU0USr4lEMhOa2fMmDdTe/rH8ObQkGxuUEDVUfTkUCRajwBoAp/WW8kS3Xw==
X-Received: by 2002:a05:620a:2a06:b0:7c0:7c49:a435 with SMTP id af79cd13be357-7c07c49a614mr89674885a.52.1739412554676;
        Wed, 12 Feb 2025 18:09:14 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c07c86e4e0sm20092685a.91.2025.02.12.18.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:09:13 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 1/4] dt-bindings: reset: add generic bit reset controller
Date: Thu, 13 Feb 2025 10:08:54 +0800
Message-ID: <20250213020900.745551-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213020900.745551-1-inochiama@gmail.com>
References: <20250213020900.745551-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SoCs from Aspeed, Allwinner, Sophgo and Synopsys have
a simple reset controller by toggling bit. It is a hard time
for each device to add its own compatible to the driver.
Since this device share a common design, it is possible to
add a common device to reduce these unnecessary change.

Add common binding for these kind generic reset controller.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/reset/reset-simple.yaml          | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/reset-simple.yaml

diff --git a/Documentation/devicetree/bindings/reset/reset-simple.yaml b/Documentation/devicetree/bindings/reset/reset-simple.yaml
new file mode 100644
index 000000000000..77584e23e8e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/reset-simple.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/reset-simple.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic BIT Reset Controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+description:
+  Some reset controller devices uses a simple method to perform
+  assert/deassert by toggling bit. Some SoCs from Aspeed, Allwinner,
+  Sophgo and Synopsys have this kind of reset controller instances.
+
+properties:
+  compatible:
+    enum:
+      - reset-simple-high
+      - reset-simple-low
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    reset-controller@1000000 {
+        compatible = "reset-simple-high";
+        reg = <0x1000000 0x1000>;
+        #reset-cells = <1>;
+    };
-- 
2.48.1



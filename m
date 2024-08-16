Return-Path: <linux-kernel+bounces-289680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E495491F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EB82839B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58F156F34;
	Fri, 16 Aug 2024 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hnhVzKov"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E312D1EA
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812602; cv=none; b=MMlU2Wm5Is0/fiaLO5Vi1c34Axby/okG704OKIfwgVYj7GLnTBBfXjsRBm5U5NtxzTlal372CjS8m3q2kQPLiqNmBD3gYezzh27Nvw2p2iMeeDoFLLYDgcBqg3BvE54N8jy556zWU5EUm6Yb+xJW1jxBuQWx/DbXQ3riERlaadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812602; c=relaxed/simple;
	bh=K37drQFBcQe/KPuccp1cUx2OgiWzM+wcBntWujhb3wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cv5mkEFG3+zz7XEqV4muGc3oGmBp1KkOOcmyumlYkvNhSfiG4TqWHjjGrZg2TJpKsedF4ef9K0uraZDznt/CSdd2h1DXh82B6J+sfXKWCbi0drLBhC8U9FOFl7dTF8+HUB5VLVwEVbx1LwRhPp1ISo535172l6MsjJQHqZ4a+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hnhVzKov; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37198a6da58so311595f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723812599; x=1724417399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ke0AjxBAncE489wmYzkh+nSMUTPo+pIzRMAmnYnwJNQ=;
        b=hnhVzKovzynDoQAun++O/2psFXoxwrfmAL6FguXikmJuDNYs3SQ9zWNdJcJrKlR1DR
         sctpHAV4oWUVezB+H+qUsieJ3NuUbTcnl/Aq+11aYks95YMgQ4U2xA5i0OtjgONG6D2r
         C00jzf3q4d0kVc4AIxX+fUP1j51qkshg5prgMOvzyLMOt3qOsOfq2baQA8vguhwBoxFW
         pGBuh9L6WKiZ4Cx0Iufjn//tAFzjeWgzufatyFg07Nm4ckgGfj+gENjcn3tE82YUgu5E
         ZkRPL8yFQvjCOb/2xM9cCXdV6K6pe9ck1VhlS/9F3T5kXDuoZDo1i7NgAXDaIfMQq4nJ
         uF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723812599; x=1724417399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ke0AjxBAncE489wmYzkh+nSMUTPo+pIzRMAmnYnwJNQ=;
        b=cm0GanNDSgyXq5Gx6OWnO6UIOi2ZDq4nDA99m1eOxZ8infj6yBiCKAHwR7Jq9RLNSl
         Ouvdo3g3JMkJH+gmuuIzBwoifatcC7Ue+2LfpsLoZmuy8S/9pDx6rExUiU6e2KKKZ/qB
         ucmXKWWav/UjJk6I4+4uL0Trt99uMLqGfubjbfK6NWgOMFyXszw8g9BI2IHJ+Kq/8SJo
         uOhpz4STPrAcivrheHRRk5nGM1bRGcInrMboTXlypXeZOVsPZOqh/gEASmxezTI8Ge1V
         PusKa0HhqT3x/Dlc0XQYuLoyZ3oaVHdv4ACMxF/omOhBP9H6+QbrqYaRlr0NfZLkVGKv
         bfnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWau02RB6JU0OIgzm6qQp03pyfhYuIUc7gnY3spgpmnbH8mzH/44DOu6LPGrm5NqVyi59kyc+/NgIKKBE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8gfw8tsNYPSUGsZfwm/87gniw+IWo2da4IZeojbQz1Xg1eQM
	utlAQKl1XCwnFsdcazLNuFap3DIhINvyJeIUTOLXusPtY3jlluzdJh2Dzi0YUwA=
X-Google-Smtp-Source: AGHT+IGM4LtUkED1FVNx+BEXnUbZCpfDI0OMEbuSoUR17hoiKqSTIP6vlmoZg/GiQAQSJ3CnFpyexA==
X-Received: by 2002:adf:e907:0:b0:371:8e24:1191 with SMTP id ffacd0b85a97d-371946a4455mr2184543f8f.53.1723812598913;
        Fri, 16 Aug 2024 05:49:58 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aa393sm3570531f8f.90.2024.08.16.05.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:49:58 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org
Cc: maz@kernel.org,
	mark.rutland@arm.com,
	robh@kernel.org,
	saravanak@google.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2] of/irq: Support #msi-cells=<0> in of_msi_get_domain
Date: Fri, 16 Aug 2024 14:49:58 +0200
Message-ID: <20240816124957.130017-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An 'msi-parent' property with a single entry and no accompanying
'#msi-cells' property is considered the legacy definition as opposed
to its definition after being expanded with commit 126b16e2ad98
("Docs: dt: add generic MSI bindings"). However, the legacy
definition is completely compatible with the current definition and,
since of_phandle_iterator_next() tolerates missing and present-but-
zero *cells properties since commit e42ee61017f5 ("of: Let
of_for_each_phandle fallback to non-negative cell_count"), there's no
need anymore to special case the legacy definition in
of_msi_get_domain().

Indeed, special casing has turned out to be harmful, because, as of
commit 7c025238b47a ("dt-bindings: irqchip: Describe the IMX MU block
as a MSI controller"), MSI controller DT bindings have started
specifying '#msi-cells' as a required property (even when the value
must be zero) as an effort to make the bindings more explicit. But,
since the special casing of 'msi-parent' only uses the existence of
'#msi-cells' for its heuristic, and not whether or not it's also
nonzero, the legacy path is not taken. Furthermore, the path to
support the new, broader definition isn't taken either since that
path has been restricted to the platform-msi bus.

But, neither the definition of 'msi-parent' nor the definition of
'#msi-cells' is platform-msi-specific (the platform-msi bus was just
the first bus that needed '#msi-cells'), so remove both the special
casing and the restriction. The code removal also requires changing
to of_parse_phandle_with_optional_args() in order to ensure the
legacy (but compatible) use of 'msi-parent' remains supported. This
not only simplifies the code but also resolves an issue with PCI
devices finding their MSI controllers on riscv, as the riscv,imsics
binding requires '#msi-cells=<0>'.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
v2:
 - switch to of_parse_phandle_with_optional_args() to ensure the
   absence of #msi-cells means count=0

 drivers/of/irq.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index c94203ce65bb..690df4b71ab9 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -709,8 +709,7 @@ struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
  * @np: device node for @dev
  * @token: bus type for this domain
  *
- * Parse the msi-parent property (both the simple and the complex
- * versions), and returns the corresponding MSI domain.
+ * Parse the msi-parent property and returns the corresponding MSI domain.
  *
  * Returns: the MSI domain for this device (or NULL on failure).
  */
@@ -718,33 +717,19 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
 				     struct device_node *np,
 				     enum irq_domain_bus_token token)
 {
-	struct device_node *msi_np;
+	struct of_phandle_args args;
 	struct irq_domain *d;
+	int index = 0;
 
-	/* Check for a single msi-parent property */
-	msi_np = of_parse_phandle(np, "msi-parent", 0);
-	if (msi_np && !of_property_read_bool(msi_np, "#msi-cells")) {
-		d = irq_find_matching_host(msi_np, token);
-		if (!d)
-			of_node_put(msi_np);
-		return d;
-	}
-
-	if (token == DOMAIN_BUS_PLATFORM_MSI) {
-		/* Check for the complex msi-parent version */
-		struct of_phandle_args args;
-		int index = 0;
+	while (!of_parse_phandle_with_optional_args(np, "msi-parent",
+						    "#msi-cells",
+						    index, &args)) {
+		d = irq_find_matching_host(args.np, token);
+		if (d)
+			return d;
 
-		while (!of_parse_phandle_with_args(np, "msi-parent",
-						   "#msi-cells",
-						   index, &args)) {
-			d = irq_find_matching_host(args.np, token);
-			if (d)
-				return d;
-
-			of_node_put(args.np);
-			index++;
-		}
+		of_node_put(args.np);
+		index++;
 	}
 
 	return NULL;
-- 
2.45.2



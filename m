Return-Path: <linux-kernel+bounces-289442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F16B5954645
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BC2BB20F03
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66516F0E1;
	Fri, 16 Aug 2024 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oWxzGh7Q"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7C12D773
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802126; cv=none; b=aQpT/FRFoUUGVWmAuS+CuIMVMGM6l8K3yuRB479FwxUTLzyitaFG/wrAi0WWWh8J07xvS5obB6dyGLGxSDvk8OmizPc/zJxvZFR1iDArNT2c06N+JK8T0GWJ0CK1eC/Ql6rT92ikv0IvMgtcIQycowDMynw+e7K0Ldh8Hs++1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802126; c=relaxed/simple;
	bh=CC1JIfHvIBAl36w46sBXVBsGIZ5We62PJWHtJs+O8t8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tMbPUBEk8X9UCvKbh3tcOW9Ph0NJn1whzuNK/SZ6atMECypNkf2WDlGG712ekuceaosPxT/KyAmOHBhjzQVUzOEjmdQLZGr/GSDhFhxTQrw/K6lKf3i430ycDIqdnTIU3AaOuBGCHbrx0KOOLoNTkwQ+85rbx8QNStWn0zr0wXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oWxzGh7Q; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bec7ee6f44so1163693a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723802123; x=1724406923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RoIvLUfwtlErHQHB2ji6smKiDqBoIASWBt1x369LS4I=;
        b=oWxzGh7Q2J+AKFn64fUlu68dzqhqHS92gaHzGbt3+ih2SU4eRqAL5cYzGJbf29CvlK
         /NedYSeFCxIbT/alrOzwP50VDrpFOFESRMWzUDDyfcnjEras1QPeIBLYU6jMVkE8hL2T
         QQv6Nf9bx5XhCjr42EseRc5l8uzfere65XwZ+MH/SFrNNZJduUXbCn9lTMo+glIERa+E
         zbXh60IbjHk5E6oWPuJH6OKyG+rCaCjZfjHk/5CMy/NkxBd5q/dyA8FSs5px4GyddJLX
         4A5PTKzJ1rgrVUnJTRYnmxKIHp7vJc+phEFE6+bPCvW752LAG36BJEnxjSD6EFRe8Dq7
         3GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723802123; x=1724406923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoIvLUfwtlErHQHB2ji6smKiDqBoIASWBt1x369LS4I=;
        b=sGPpQqHEyNreqEYeQ73ytVGJjzjVdl9nPdJTYYk4FXeux/AKV0QhAmmRAi2nNLMkYq
         KsAx24B9srFqaeE1TsQUYgLPknR2JKRNsyMv2o3jkHkPIWq6u5UXT1+Ish7FCdgofdxf
         cGhEETYXIF0iN9wu4vO6wBet3AMFx08ZXubsT7exYDjJe+0vLjE65RcGvtJcF2qumdDR
         5zAk64u7k+ravA2pPOB6Dr/h3daoCcW8YVBiQLZCGQX1GLs4EuXUkpcKp3OSUefUsdDZ
         Luk/aw7OdAr1IbxWXULvBMRFu+NovZczSotLmWBqw1WGUIQRp2g3/tUu48BLgBScLCns
         qrxA==
X-Forwarded-Encrypted: i=1; AJvYcCWTtK06zZ20y78saEwRcXYZXLuEcDVAflgGIo23c61tT4dX73x67zF8ONg1z/+qEc5VY7Ei7HTJUlIzzVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxduJDyKeOsxwGS14H3DPb2K9GKajmkzskhnkjVukkwl1MhdBRl
	Q934yRjnt82oEQXGceyugRTcBRnN/uRHue9crZskwkHHw6VgYGZND75i4AAN228=
X-Google-Smtp-Source: AGHT+IEWEn1buqzvrPyI+YLyXqKvY0yYQVZ2BQACp/XQgrDhUOxKmz7wrTINSfs3M48T6a9DY2iabw==
X-Received: by 2002:a17:907:2d10:b0:a7a:a3f7:389f with SMTP id a640c23a62f3a-a8392a49534mr149316266b.66.1723802122185;
        Fri, 16 Aug 2024 02:55:22 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935807sm228603466b.134.2024.08.16.02.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 02:55:21 -0700 (PDT)
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
Subject: [PATCH] of/irq: Support #msi-cells=<0> in of_msi_get_domain
Date: Fri, 16 Aug 2024 11:55:21 +0200
Message-ID: <20240816095520.96348-2-ajones@ventanamicro.com>
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
casing and the restriction. This not only simplifies the code but
also resolves an issue with PCI devices finding their MSI controllers
on riscv, as the riscv,imsics binding requires '#msi-cells=<0>'.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/of/irq.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index c94203ce65bb..026b52c8ee63 100644
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
+	while (!of_parse_phandle_with_args(np, "msi-parent",
+					   "#msi-cells",
+					   index, &args)) {
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


